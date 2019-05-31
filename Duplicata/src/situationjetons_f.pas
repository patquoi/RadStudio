unit situationjetons_f; // v1.2
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;
//---------------------------------------------------------------------------
type
  TSituationJeton = (sjIndefinie, sjSac, sjChevalet, sjPlateau);
  TFormSituationJetons = class(TForm) // Fiche à créer
    GroupBoxOrdreTirageJetons: TGroupBox;
    RichEditOrdreTirageJetons: TRichEdit;
    GroupBoxLegende: TGroupBox;
    LabelLegende1: TLabel;
    LabelLegende2: TLabel;
    LabelLegende3: TLabel;
    GroupBoxSituationParType: TGroupBox;
    LabelA: TLabel;
    LabelB: TLabel;
    LabelC: TLabel;
    LabelD: TLabel;
    LabelE: TLabel;
    LabelF: TLabel;
    LabelG: TLabel;
    LabelH: TLabel;
    LabelI: TLabel;
    LabelJ: TLabel;
    LabelK: TLabel;
    LabelL: TLabel;
    LabelM: TLabel;
    LabelN: TLabel;
    LabelO: TLabel;
    LabelP: TLabel;
    LabelQ: TLabel;
    LabelR: TLabel;
    LabelS: TLabel;
    LabelT: TLabel;
    LabelU: TLabel;
    LabelV: TLabel;
    LabelW: TLabel;
    LabelX: TLabel;
    LabelY: TLabel;
    LabelZ: TLabel;
    Label_: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    LabelSacA: TLabel;
    LabelSacB: TLabel;
    LabelSacC: TLabel;
    LabelSacD: TLabel;
    LabelSacE: TLabel;
    LabelSacF: TLabel;
    LabelSacG: TLabel;
    LabelSacH: TLabel;
    LabelSacI: TLabel;
    LabelSacJ: TLabel;
    LabelSacK: TLabel;
    LabelSacL: TLabel;
    LabelSacM: TLabel;
    LabelSacN: TLabel;
    LabelSacO: TLabel;
    LabelSacP: TLabel;
    LabelSacQ: TLabel;
    LabelSacR: TLabel;
    LabelSacS: TLabel;
    LabelSacT: TLabel;
    LabelSacU: TLabel;
    LabelSacV: TLabel;
    LabelSacW: TLabel;
    LabelSacX: TLabel;
    LabelSacY: TLabel;
    LabelSacZ: TLabel;
    LabelSac_: TLabel;
    LabelChvA: TLabel;
    LabelChvB: TLabel;
    LabelChvC: TLabel;
    LabelChvD: TLabel;
    LabelChvE: TLabel;
    LabelChvF: TLabel;
    LabelChvG: TLabel;
    LabelChvH: TLabel;
    LabelChvI: TLabel;
    LabelChvJ: TLabel;
    LabelChvK: TLabel;
    LabelChvL: TLabel;
    LabelChvM: TLabel;
    LabelChvN: TLabel;
    LabelChvO: TLabel;
    LabelChvP: TLabel;
    LabelChvQ: TLabel;
    LabelChvR: TLabel;
    LabelChvS: TLabel;
    LabelChvT: TLabel;
    LabelChvU: TLabel;
    LabelChvV: TLabel;
    LabelChvW: TLabel;
    LabelChvX: TLabel;
    LabelChvY: TLabel;
    LabelChvZ: TLabel;
    LabelChv_: TLabel;
    LabelPltA: TLabel;
    LabelPltB: TLabel;
    LabelPltC: TLabel;
    LabelPltD: TLabel;
    LabelPltE: TLabel;
    LabelPltF: TLabel;
    LabelPltG: TLabel;
    LabelPltH: TLabel;
    LabelPltI: TLabel;
    LabelPltJ: TLabel;
    LabelPltK: TLabel;
    LabelPltL: TLabel;
    LabelPltM: TLabel;
    LabelPltN: TLabel;
    LabelPltO: TLabel;
    LabelPltP: TLabel;
    LabelPltQ: TLabel;
    LabelPltR: TLabel;
    LabelPltS: TLabel;
    LabelPltT: TLabel;
    LabelPltU: TLabel;
    LabelPltV: TLabel;
    LabelPltW: TLabel;
    LabelPltX: TLabel;
    LabelPltY: TLabel;
    LabelPltZ: TLabel;
    LabelPlt_: TLabel;
    LabelConsonnes: TLabel;
    LabelTitre1: TLabel;
    LabelTitre2: TLabel;
    LabelTitre3: TLabel;
    PopupMenu: TPopupMenu;
    MenuItemFermer: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuItemFermerClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    TimerEnabled : Boolean; // v1.5
  public
  end;
//---------------------------------------------------------------------------
var
  FormSituationJetons: TFormSituationJetons;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses base, main_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const CouleurSituation : array [TSituationJeton] of TColor = (clWhite, clGreen, $000080FF, clRed);
const PrefixeLabel     : array [TSituationJeton] of String = ('Label', 'LabelSac', 'LabelChv', 'LabelPlt');
//---------------------------------------------------------------------------
procedure TFormSituationJetons.FormShow(Sender: TObject);
const stFormatDecompteJetons = '%s %d';
var i, j, k, v, o, r             : Integer; // v1.5 : on compte les jetons (Verts/Oranges/Rouges)
    MelangeEnCoursAvantAffichage : Boolean; // v1.5 : on stoppe le mélange de jetons le cas échéant (hors partie)
  function stContenu(const NumeroJeton : TOrdreJetonSac) : String;
  begin // On suppose que NumeroJeton>0
  if TypeJeton[NumeroJeton]=tjJoker then
    Result:='_'
  else
    Result:=p.stLettre(NumeroJeton)
  end;
begin
with FormMAin do
  if ReflexionEnCours then
    begin
    TimerEnabled:=TimerReflexion.Enabled;
    if TimerEnabled then
      EmpecheTempsImparti:=True // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
    end
  else
    TimerEnabled:=False;
MelangeEnCoursAvantAffichage:=FormMain.MelangeEnCours; // v1.5
FormMain.MelangeEnCours:=False;
// v1.5 : on compte les jetons (Verts/Oranges/Rouges)
v:=0; o:=0;
with RichEditOrdreTirageJetons do
  begin
  // 0. On affiche l'ordre de tirage des jetons
  Text:='';
  for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
    Text:=Text+stContenu(p.s[i]);
  // 1. On peint les jetons du plateau en rouge
  for i:=Low(TCoordonnee) to High(TCoordonnee) do
    for j:=Low(TCoordonnee) to High(TCoordonnee) do
      if p.c[i,j]>0 then
        begin
        for k:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
          if p.s[k]=p.c[i,j] then
            begin
            SelStart:=k-1;
            with Self.FindComponent(PrefixeLabel[sjPlateau]+stContenu(p.c[i,j])) as TLabel do
              Caption:=IntToStr(StrToInt(Caption)+1);
            (Self.FindComponent(PrefixeLabel[sjIndefinie]+stContenu(p.c[i,j])) as TLabel).Color:=CouleurSituation[sjPlateau];
            Break
            end;
        SelLength:=1;
        SelAttributes.Color:=CouleurSituation[sjPlateau]
        end;
  // 2. On peint les jetons du chevalet en orange
  for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
    if p.t[i]>0 then
      begin
      for j:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
        if p.s[j]=p.t[i] then
          begin
          Inc(o); // v1.5 : on compte les jetons (Verts/Oranges/Rouges)
          SelStart:=j-1;
          with Self.FindComponent(PrefixeLabel[sjChevalet]+stContenu(p.t[i])) as TLabel do
            Caption:=IntToStr(StrToInt(Caption)+1);
          (Self.FindComponent(PrefixeLabel[sjIndefinie]+stContenu(p.t[i])) as TLabel).Color:=CouleurSituation[sjChevalet];
          end;
      SelLength:=1;
      SelAttributes.Color:=CouleurSituation[sjChevalet]
      end;
  // 4. On peint les jetons du sac en vert
  for i:=p.ProchainJetonATirer to High(TOrdreJetonSac) do
    begin
    Inc(v); // v1.5 : on compte les jetons (Verts/Oranges/Rouges)
    with Self.FindComponent(PrefixeLabel[sjSac]+stContenu(p.s[i])) as TLabel do
      Caption:=IntToStr(StrToInt(Caption)+1);
    (Self.FindComponent(PrefixeLabel[sjIndefinie]+stContenu(p.s[i])) as TLabel).Color:=CouleurSituation[sjSac]
    end;
  SelStart:=p.ProchainJetonATirer-1;
  SelLength:=High(TOrdreJetonSac);
  SelAttributes.Color:=CouleurSituation[sjSac];
  // 5. On retire la sélection
  SelStart:=0;
  SelLength:=0;
  // v1.5 : on compte les jetons (Verts/Oranges/Rouges)
  r:=NbJetonsSac-o-v;
  LabelLegende1.Caption:=Format(stFormatDecompteJetons, [LabelLegende1.Caption, v]);
  LabelLegende2.Caption:=Format(stFormatDecompteJetons, [LabelLegende2.Caption, o]);
  LabelLegende3.Caption:=Format(stFormatDecompteJetons, [LabelLegende3.Caption, r]);
  end{with};
if MelangeEnCoursAvantAffichage then
  FormMain.MelangeEnCours:=True // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormSituationJetons.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key=#27) or (Key=#13) then ModalResult:=mrOk;
end;
//---------------------------------------------------------------------------
procedure TFormSituationJetons.FormHide(Sender: TObject);
begin
with FormMain do
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5 : On reprend la détection de temps imparti écoulé
end;
//---------------------------------------------------------------------------
procedure TFormSituationJetons.MenuItemFermerClick(Sender: TObject);
begin
ModalResult:=mrOk // v1.5.1 : Comportement d'interrupteur avec le raccourci Ctrl+I
end;
//---------------------------------------------------------------------------
procedure TFormSituationJetons.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : accès l'aide en ligne (F1)
  with FormMain do
    ActionInfosAideExecute(ActionInfosAide)
end;

end.
