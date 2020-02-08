unit listemots_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;
//---------------------------------------------------------------------------
type
  TFormListeMots = class(TForm)
    Label1: TLabel;
    ComboBoxNbLettresMin: TComboBox;
    ComboBoxNbLettresMax: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    LabelResume: TLabel;
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    RadioGroupAn: TRadioGroup;
    RadioGroupEn: TRadioGroup;
    RadioGroupOn: TRadioGroup;
    RadioGroupF: TRadioGroup;
    RadioGroupV: TRadioGroup;
    RadioGroupH: TRadioGroup;
    RadioGroupNg: TRadioGroup;
    RadioGroupOun: TRadioGroup; // v1.8KA : ajout du jeton "Oun"
    RadioGroupUi: TRadioGroup;
    Bevel2: TBevel;
    RadioButton2: TRadioButton;
    RadioGroup4: TRadioGroup;
    RadioGroup10: TRadioGroup;
    Bevel3: TBevel;
    ButtonReinitialiser: TButton;
    ButtonGenerer: TButton;
    ButtonAnnuler: TButton;
    GroupBoxRq: TGroupBox;
    Label4: TLabel;
    procedure RadioButtonClick(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
    procedure ButtonReinitialiserClick(Sender: TObject);
    procedure ButtonGenererClick(Sender: TObject);
    procedure ComboBoxNbLettresMinChange(Sender: TObject);
  private
    procedure ActiveBouton;
    procedure AfficheResume;
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
var
  FormListeMots: TFormListeMots;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.StrUtils, Winapi.ShellApi, base, patience_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
type
  TLettreChere   = (lchIndefinie, lchAn, lchEn, lchF, lchH, lchNg, lchOn, lchOun, lchUi, lchV); // v1.8KA : Ajout du nouveau jeton "Oun"
  TValeurChere   = (vchIndefinie, vch4Pts, vch10Pts);
  TTypeRecherche = (trLettre, trValeur);
//---------------------------------------------------------------------------
const
  ValeurChere    : array [TLettreChere] of TValeurChere = (vchIndefinie, vch4Pts, vch4Pts, vch4Pts, vch10Pts, vch10Pts, vch4Pts, vch10Pts, vch10Pts, vch4Pts); // v1.8KA : Ajout du nouveau jeton "Oun"
  // vKA : Ci-dessous on n'inclut pas les lettres chères doubles (Ng et Ui) traitées à la main 
  LettreChere    : array ['A'..'Z'] of TLettreChere = (lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchF, lchIndefinie,
                                                       lchH, lchIndefinie,
                                                       lchIndefinie, lchIndefinie,
                                                       lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchV, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie);
// vKA : Seules les doubles lettres Ch et Ou ne sont pas lettres chères
//---------------------------------------------------------------------------
procedure TFormListeMots.ButtonReinitialiserClick(Sender: TObject);
begin
RadioGroupAn.ItemIndex:=0;
RadioGroupEn.ItemIndex:=0;
RadioGroupF.ItemIndex:=0;
RadioGroupH.ItemIndex:=0;
RadioGroupNg.ItemIndex:=0;
RadioGroupOn.ItemIndex:=0;
RadioGroupOun.ItemIndex:=0; // v1.8KA : Ajout du nouveau jeton "Oun"
RadioGroupUi.ItemIndex:=0;
RadioGroupV.ItemIndex:=0;
RadioGroup4.ItemIndex:=0;
RadioGroup10.ItemIndex:=0;
RadioGroupAn.Enabled:=False;
RadioGroupEn.Enabled:=False;
RadioGroupF.Enabled:=False;
RadioGroupH.Enabled:=False;
RadioGroupNg.Enabled:=False;
RadioGroupOn.Enabled:=False;
RadioGroupOun.Enabled:=False; // v1.8KA : Ajout du nouveau jeton "Oun"
RadioGroupUi.Enabled:=False;
RadioGroupV.Enabled:=False;
RadioGroup4.Enabled:=False;
RadioGroup10.Enabled:=False;
RadioButton1.Checked:=False;
RadioButton2.Checked:=False
end;
//---------------------------------------------------------------------------
procedure TFormListeMots.ButtonGenererClick(Sender: TObject);
var i, j,
    nl, nm,
    nlMin, nlMax,
    iDico,
    Pourcentage,
    NblATraiter : Integer;
    NbTrv       : array [0..NbLettresMaxMot] of Integer;
    MotTrv      : Boolean;
    lch         : TLettreChere;
    vch         : TValeurChere;
    TypeRech    : TTypeRecherche;
    RechLch,    // Nombre de lettres chères à trouver
    NTrvLch     : array [TLettreChere] of Integer; // Nombre de lettres chères trouvées (par mot)
    RechVch,    // Nombre de valeurs chères à trouver
    NTrvVCh     : array [TValeurChere] of Integer; // Nombre de valeurs chères trouvées (par mot)
    stNomFichier,
    stMot       : String;
    f           : TextFile;
begin
stNomFichier:=stRepLocalAppData+'listemots.txt'; // v1.7.4 : ExtractFilePath(Application.ExeName) remplacé par stRepLocalAppData
AssignFile(f, stNomFichier);
try
  Rewrite(f);
  FormPatience:=TFormPatience.Create(Self);
  with FormPatience do
    begin
    Panel.Caption:='Recherche en cours. Veuillez patienter SVP...';
    Gauge.MinValue:=0;
    Gauge.MaxValue:=100;
    Gauge.Progress:=0;
    iDico:=0;
    NblATraiter:=NbLettresDico;
    // On déduit le nombre de lettres des mots hors taille
    for i:=NbLettresMinMot to StrToInt(ComboBoxNbLettresMin.Text)-1 do
      Dec(NblATraiter, nbl[i]);
    for i:=StrToInt(ComboBoxNbLettresMax.Text)+1 to NbLettresMaxMot do
      Dec(NblATraiter, nbl[i]);
    Show;
    Repaint
    end;
  if ComboBoxNbLettresMin.Text=ComboBoxNbLettresMax.Text then
    WriteLn(f, 'Liste de mots de ', ComboBoxNbLettresMin.Text, ' jetons comportant '+LabelResume.Caption)
  else
    WriteLn(f, 'Liste de mots de ', ComboBoxNbLettresMin.Text, ' à ', ComboBoxNbLettresMax.Text,' jetons comportant '+LabelResume.Caption);
  TypeRech:=TTypeRecherche(Ord(RadioButton1.Checked)+2*Ord(RadioButton2.Checked)-1);
  for i:=0 to NbLettresMaxMot do
    NbTrv[i]:=0;
  nlMin:=StrToInt(ComboBoxNbLettresMin.Text);
  nlMax:=StrToInt(ComboBoxNbLettresMax.Text);
  RechLch[lchAn]:=RadioGroupAn.ItemIndex;
  RechLch[lchEn]:=RadioGroupEn.ItemIndex;
  RechLch[lchF]:=RadioGroupF.ItemIndex;
  RechLch[lchH]:=RadioGroupH.ItemIndex;
  RechLch[lchNg]:=RadioGroupNg.ItemIndex;
  RechLch[lchOn]:=RadioGroupOn.ItemIndex;
  RechLch[lchOun]:=RadioGroupOun.ItemIndex; // v1.8KA : Ajout du nouveau jeton "Oun"
  RechLch[lchUi]:=RadioGroupUi.ItemIndex;
  RechLch[lchV]:=RadioGroupV.ItemIndex;
  RechVch[vch4pts]:=RadioGroup4.ItemIndex;
  RechVch[vch10pts]:=RadioGroup10.ItemIndex;
  for nl:= nlMin to nlMax do
    begin
    nm:=(nbl[nl] div nl)-1;
    for i:=0 to nm do
      begin
      for j:=Ord(Low(TLettreChere)) to Ord(High(TLettreChere)) do
        NTrvLch[TLettreChere(j)]:=0;
      for j:=Ord(Low(TValeurChere)) to Ord(High(TValeurChere)) do
        NTrvVch[TValeurChere(j)]:=0;
      stMot:=p.Dico.stMotDico(nl, i);
      Inc(iDico, nl);
      for j:=1 to Length(stMot) do
        begin
        if (stMot[j]>='A') and (stMot[j]<='Z') then // vKA : on exclut les lettres doubles (traitées dans le else à la main)
          lch:=LettreChere[stMot[j]]
        else{lettre double} // début vKA
          case stMot[j] of
          'Â': lch:=lchAn;
          'Ê': lch:=lchEn;
          'Ñ': lch:=lchNg;
          'Ô': lch:=lchOn;
          'Ü': lch:=lchOun; // v1.8KA : Ajout du nouveau jeton "Oun"
          'Î': lch:=lchUi;
          else lch:=lchIndefinie
          end; // fin vKA
        case TypeRech of
          trLettre: begin
                    Inc(NTrvLch[lch]);
                    if (lch>lchIndefinie) and
                       (NTrvLch[lch]>RechLch[lch]) then Break;
                    end;
          trValeur: begin
                    vch:=ValeurChere[lch];
                    Inc(NTrvVch[vch]);
                    if (vch>vchIndefinie) and
                       (NTrvVch[vch]>RechVch[vch]) then Break;
                    end
          end{case of};
        end{for j};
      MotTrv:=True; // Optimiste
      case TypeRech of
        trLettre: for j:=Ord(Low(TLettreChere))+1 to Ord(High(TLettreChere)) do
                    if NTrvLch[TLettreChere(j)]<>RechLch[TLettreChere(j)] then
                      begin
                      MotTrv:=False;
                      Break
                      end;
        trValeur: for j:=Ord(Low(TValeurChere))+1 to Ord(High(TValeurChere)) do
                    if NTrvVch[TValeurChere(j)]<>RechVch[TValeurChere(j)] then
                      begin
                      MotTrv:=False;
                      Break
                      end;
        end{case of};
      if MotTrv then
        begin
        if NbTrv[nl]=0 then
          begin
          WriteLn(f);
          WriteLn(f, 'Mots de ', nl, ' jetons');
          end;
        Inc(NbTrv[0]);
        Inc(NbTrv[nl]);
        Write(f, stLettresDoubles(stMot), ' ') // vKA : Affichage des doubles lettres
        end{if MotTrv};
      with FormPatience do
        begin
        Pourcentage:=(100*iDico) div NblATraiter;
        if Gauge.Progress<>Pourcentage then
          begin
          Gauge.Progress:=Pourcentage;
          Repaint
          end{if Gauge}
        end{with FormPatience}
      end{for i};
    if NbTrv[nl]>0 then
      begin
      WriteLn(f);
      WriteLn(f, NbTrv[nl], ' mot', IfThen(NbTrv[nl]>1, 's', ''), ' de ', nl, ' jetons trouvé', IfThen(NbTrv[nl]>1, 's', ''), '.');
      end
    end{for nl};
  WriteLn(f);
  WriteLn(f, 'Nombre total de mots trouvés : ', NbTrv[0]);
finally
  FormPatience.Release;
  CloseFile(f);
  ShellExecute(0,
               'Open',
               pChar(ExtractFileName(stNomFichier)),
               Nil,
               pChar(ExtractFilePath(stNomFichier)),
               SW_SHOWNORMAL)
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormListeMots.ComboBoxNbLettresMinChange(Sender: TObject);
var i, NbLettres : Integer;
begin
NbLettres:=StrToInt(ComboBoxNbLettresMax.Text);
ComboBoxNbLettresMax.ItemIndex:=-1;
with ComboBoxNbLettresMax.Items do
  begin
  Clear;
  for i:=StrToInt(ComboBoxNbLettresMin.Text) to NbLettresMaxMot do
    Add(IntToStr(i));
  end;
if NbLettres<StrToInt(ComboBoxNbLettresMin.Text) then
  ComboBoxNbLettresMax.ItemIndex:=0
else
  with ComboBoxNbLettresMax.Items do
    for i:=0 to Count-1 do
      if IntToStr(NbLettres)=Strings[i] then
        ComboBoxNbLettresMax.ItemIndex:=i
end;
//---------------------------------------------------------------------------
procedure TFormListeMots.RadioButtonClick(Sender: TObject);
var RadioButton : TRadioButton;
begin
RadioButton:=Sender as TRadioButton;
case RadioButton.Tag of
  1: begin
     RadioGroup4.ItemIndex:=0;
     RadioGroup10.ItemIndex:=0
     end;
  2: begin
     RadioGroupAn.ItemIndex:=0;
     RadioGroupEn.ItemIndex:=0;
     RadioGroupOn.ItemIndex:=0;
     RadioGroupF.ItemIndex:=0;
     RadioGroupV.ItemIndex:=0;
     //--------------------
     RadioGroupH.ItemIndex:=0;
     RadioGroupNg.ItemIndex:=0;
     RadioGroupOun.ItemIndex:=0; // v1.8KA : Ajout du nouveau jeton "Oun"
     RadioGroupUi.ItemIndex:=0
     end
  end;
RadioGroupAn.Enabled:=(RadioButton.Tag=1);
RadioGroupEn.Enabled:=(RadioButton.Tag=1);
RadioGroupOn.Enabled:=(RadioButton.Tag=1);
RadioGroupF.Enabled:=(RadioButton.Tag=1);
RadioGroupV.Enabled:=(RadioButton.Tag=1);
RadioGroupH.Enabled:=(RadioButton.Tag=1);
RadioGroupNg.Enabled:=(RadioButton.Tag=1);
RadioGroupOun.Enabled:=(RadioButton.Tag=1); // v1.8KA : Ajout du nouveau jeton "Oun"
RadioGroupUi.Enabled:=(RadioButton.Tag=1);
RadioGroup4.Enabled:=(RadioButton.Tag=2);
RadioGroup10.Enabled:=(RadioButton.Tag=2);
ActiveBouton
end;
//---------------------------------------------------------------------------
procedure TFormListeMots.RadioGroupClick(Sender: TObject);
begin
AfficheResume;
ActiveBouton;
end;
//---------------------------------------------------------------------------
procedure TFormListeMots.ActiveBouton;
begin
ButtonGenerer.Enabled:=(RadioGroup4.ItemIndex+
                        RadioGroup10.ItemIndex+
                        //--------------------
                        RadioGroupAn.ItemIndex+
                        RadioGroupEn.ItemIndex+
                        RadioGroupOn.ItemIndex+
                        RadioGroupF.ItemIndex+
                        RadioGroupV.ItemIndex+
                        //--------------------
                        RadioGroupH.ItemIndex+
                        RadioGroupNg.ItemIndex+
                        RadioGroupOun.ItemIndex+ // v1.8KA : Ajout du nouveau jeton "Oun"
                        RadioGroupUi.ItemIndex > 0);

end;
//---------------------------------------------------------------------------
procedure TFormListeMots.AfficheResume;
begin
LabelResume.Caption:='';
if RadioGroupAn.ItemIndex>0 then
  LabelResume.Caption:=IntToStr(RadioGroupAn.ItemIndex)+' An';
if RadioGroupEn.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupEn.ItemIndex)+' En';
if RadioGroupOn.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupOn.ItemIndex)+' On';
if RadioGroupF.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupF.ItemIndex)+' F';
if RadioGroupV.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupV.ItemIndex)+' V';
if RadioGroupH.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupH.ItemIndex)+' H';
if RadioGroupNg.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupNg.ItemIndex)+' Ng';
if RadioGroupOun.ItemIndex>0 then // v1.8KA : Ajout du nouveau jeton "Oun"
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupOun.ItemIndex)+' Oun';
if RadioGroupUi.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupUi.ItemIndex)+' Ui';

// vKA : d'une manière générale dans cette unité, on remplace "lettre" par "jeton" à cause des doubles lettres...

if RadioGroup4.ItemIndex>0 then
  LabelResume.Caption:=IntToStr(RadioGroup4.ItemIndex)+Format(' jeton%s à 4 pts', [IfThen(RadioGroup4.ItemIndex>1,'s','')]);
if RadioGroup10.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' et ')+IntToStr(RadioGroup10.ItemIndex)+Format(' jeton%s à 10 pts', [IfThen(RadioGroup10.ItemIndex>1,'s','')]);

if LabelResume.Caption<>'' then
  LabelResume.Caption:=LabelResume.Caption+'.';
end;
//---------------------------------------------------------------------------
end.
