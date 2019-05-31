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
    RadioGroupJ: TRadioGroup;
    RadioGroupK: TRadioGroup;
    RadioGroupW: TRadioGroup;
    RadioGroupQ: TRadioGroup;
    RadioGroupZ: TRadioGroup;
    RadioGroupX: TRadioGroup;
    RadioGroupY: TRadioGroup;
    Bevel2: TBevel;
    RadioButton2: TRadioButton;
    RadioGroup8: TRadioGroup;
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
  TLettreChere   = (lchIndefinie, lchJ, lchK, lchQ, lchW, lchX, lchY, lchZ);
  TValeurChere   = (vchIndefinie, vch8Pts, vch10Pts);
  TTypeRecherche = (trLettre, trValeur);
//---------------------------------------------------------------------------
const
  ValeurChere    : array [TLettreChere] of TValeurChere = (vchIndefinie, vch8Pts, vch10Pts, vch8Pts, vch10Pts, vch10Pts, vch10Pts, vch10Pts);
  LettreChere    : array ['A'..'Z'] of TLettreChere = (lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchJ, lchK,
                                                       lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchQ,
                                                       lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie, lchIndefinie,
                                                       lchW, lchX, lchY, lchZ);
//---------------------------------------------------------------------------
procedure TFormListeMots.ButtonReinitialiserClick(Sender: TObject);
begin
RadioGroupJ.ItemIndex:=0;
RadioGroupK.ItemIndex:=0;
RadioGroupQ.ItemIndex:=0;
RadioGroupW.ItemIndex:=0;
RadioGroupX.ItemIndex:=0;
RadioGroupY.ItemIndex:=0;
RadioGroupZ.ItemIndex:=0;
RadioGroup8.ItemIndex:=0;
RadioGroup10.ItemIndex:=0;
RadioGroupJ.Enabled:=False;
RadioGroupK.Enabled:=False;
RadioGroupQ.Enabled:=False;
RadioGroupW.Enabled:=False;
RadioGroupX.Enabled:=False;
RadioGroupY.Enabled:=False;
RadioGroupZ.Enabled:=False;
RadioGroup8.Enabled:=False;
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
stNomFichier:=stRepLocalAppData+'listemots.txt'; // v1.8.7 : oubli de remplacer ExtractFilePath(Application.ExeName) par stRepLocalAppData
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
    WriteLn(f, 'Liste de mots de ', ComboBoxNbLettresMin.Text, ' lettres comportant '+LabelResume.Caption)
  else
    WriteLn(f, 'Liste de mots de ', ComboBoxNbLettresMin.Text, ' à ', ComboBoxNbLettresMax.Text,' lettres comportant '+LabelResume.Caption);
  TypeRech:=TTypeRecherche(Ord(RadioButton1.Checked)+2*Ord(RadioButton2.Checked)-1);
  for i:=0 to NbLettresMaxMot do
    NbTrv[i]:=0;
  nlMin:=StrToInt(ComboBoxNbLettresMin.Text);
  nlMax:=StrToInt(ComboBoxNbLettresMax.Text);
  RechLch[lchJ]:=RadioGroupJ.ItemIndex;
  RechLch[lchK]:=RadioGroupK.ItemIndex;
  RechLch[lchQ]:=RadioGroupQ.ItemIndex;
  RechLch[lchW]:=RadioGroupW.ItemIndex;
  RechLch[lchX]:=RadioGroupX.ItemIndex;
  RechLch[lchY]:=RadioGroupY.ItemIndex;
  RechLch[lchZ]:=RadioGroupZ.ItemIndex;
  RechVch[vch8pts]:=RadioGroup8.ItemIndex;
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
        lch:=LettreChere[stMot[j]];
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
          WriteLn(f, 'Mots de ', nl, ' lettres');
          end;
        Inc(NbTrv[0]);
        Inc(NbTrv[nl]);
        Write(f, stMot, ' ')
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
      WriteLn(f, NbTrv[nl], ' mot', IfThen(NbTrv[nl]>1, 's', ''), ' de ', nl, ' lettres trouvé', IfThen(NbTrv[nl]>1, 's', ''), '.');
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
     RadioGroup8.ItemIndex:=0;
     RadioGroup10.ItemIndex:=0
     end;
  2: begin
     RadioGroupJ.ItemIndex:=0;
     RadioGroupK.ItemIndex:=0;
     RadioGroupQ.ItemIndex:=0;
     RadioGroupW.ItemIndex:=0;
     RadioGroupX.ItemIndex:=0;
     RadioGroupY.ItemIndex:=0;
     RadioGroupZ.ItemIndex:=0
     end
  end;
RadioGroupJ.Enabled:=(RadioButton.Tag=1);
RadioGroupK.Enabled:=(RadioButton.Tag=1);
RadioGroupQ.Enabled:=(RadioButton.Tag=1);
RadioGroupW.Enabled:=(RadioButton.Tag=1);
RadioGroupX.Enabled:=(RadioButton.Tag=1);
RadioGroupY.Enabled:=(RadioButton.Tag=1);
RadioGroupZ.Enabled:=(RadioButton.Tag=1);
RadioGroup8.Enabled:=(RadioButton.Tag=2);
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
ButtonGenerer.Enabled:=(RadioGroup8.ItemIndex+
                        RadioGroup10.ItemIndex+
                        RadioGroupJ.ItemIndex+
                        RadioGroupK.ItemIndex+
                        RadioGroupQ.ItemIndex+
                        RadioGroupW.ItemIndex+
                        RadioGroupX.ItemIndex+
                        RadioGroupY.ItemIndex+
                        RadioGroupZ.ItemIndex > 0);

end;
//---------------------------------------------------------------------------
procedure TFormListeMots.AfficheResume;
begin
LabelResume.Caption:='';
if RadioGroupJ.ItemIndex>0 then
  LabelResume.Caption:=IntToStr(RadioGroupJ.ItemIndex)+' J';
if RadioGroupK.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupK.ItemIndex)+' K';
if RadioGroupQ.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupQ.ItemIndex)+' Q';
if RadioGroupW.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupW.ItemIndex)+' W';
if RadioGroupX.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupX.ItemIndex)+' X';
if RadioGroupY.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupY.ItemIndex)+' Y';
if RadioGroupZ.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' + ')+IntToStr(RadioGroupZ.ItemIndex)+' Z';

if RadioGroup8.ItemIndex>0 then
  LabelResume.Caption:=IntToStr(RadioGroup8.ItemIndex)+Format(' lettre%s à 8 pts', [IfThen(RadioGroup8.ItemIndex>1,'s','')]);
if RadioGroup10.ItemIndex>0 then
  LabelResume.Caption:=LabelResume.Caption+IfThen(LabelResume.Caption='', '', ' et ')+IntToStr(RadioGroup10.ItemIndex)+Format(' lettre%s à 10 pts', [IfThen(RadioGroup10.ItemIndex>1,'s','')]);

if LabelResume.Caption<>'' then
  LabelResume.Caption:=LabelResume.Caption+'.';
end;
//---------------------------------------------------------------------------
end.
