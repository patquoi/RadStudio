unit saisietirage_f;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;
//----------------------------------------------------------------------------
type
  TFormSaisieTirage = class(TForm)
    LabelReliquat: TLabel;
    LabelNouveauTirage: TLabel;
    Button0: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    ButtonOK: TButton;
    LabelInformation: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonJetonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private // Matériel : p.ProchainJetonATirer et p.PremierJetonTire
    TiragePropose, // v1.5.3
    TimerEnabled : Boolean; // v1.5
    procedure RafraichitAccesBoutons;
    procedure AfficheTirage;
    procedure TesteJokerDernierJeton(const LabelTirage : TLabel);
  public
    { Déclarations publiques }
  end;
//----------------------------------------------------------------------------
var
  FormSaisieTirage: TFormSaisieTirage;
//----------------------------------------------------------------------------
implementation
//----------------------------------------------------------------------------
uses base, main_f;
//----------------------------------------------------------------------------
{$R *.dfm}
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.ButtonJetonClick(Sender: TObject);
var TypeJetonDmd : TTypeJeton;
    JetonTmp : TOrdreJetonSac;
    i : Integer;
    iTirage : TNumeroJetonTirage;
begin
TiragePropose:=True; // v1.5.3
TypeJetonDmd:=TTypeJeton((Sender as TButton).Tag);
for i:=p.ProchainJetonATirer to High(TOrdreJetonSac) do
  if TypeJeton[p.s[i]]=TypeJetonDmd then
    begin // On permute
    JetonTmp:=p.s[p.ProchainJetonATirer];
    p.s[p.ProchainJetonATirer]:=p.s[i];
    p.s[i]:=JetonTmp;
    iTirage:=Length(LabelReliquat.Caption)+Length(LabelNouveauTirage.Caption)+1;
    p.t[iTirage]:=p.s[p.ProchainJetonATirer];
    LabelNouveauTirage.Caption:=LabelNouveauTirage.Caption+p.stLettre(p.s[p.ProchainJetonATirer]);
    TesteJokerDernierJeton(LabelNouveauTirage);
    Inc(p.ProchainJetonATirer);
    RafraichitAccesBoutons;
    Exit;
    end;
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=(ModalResult=mrOk)
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormCreate(Sender: TObject);
begin
TiragePropose:=False; // v1.5.3
TimerEnabled:=False // v1.5
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormHide(Sender: TObject);
begin
with FormMain do
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5 : On reprend la détection de temps imparti écoulé
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : accès l'aide en ligne (F1)
  with FormMain do
    ActionInfosAideExecute(ActionInfosAide)
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormKeyPress(Sender: TObject; var Key: Char);
var Taille : Integer;
begin
if Key=#8 then
  begin
  Taille:=Length(LabelNouveauTirage.Caption);
  if Taille>0 then
    begin
    Dec(p.ProchainJetonATirer);
    LabelNouveauTirage.Caption:=Copy(LabelNouveauTirage.Caption, 1, Taille-1);
    RafraichitAccesBoutons
    end
  end
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.FormShow(Sender: TObject);
begin
TiragePropose:=False; // v1.5.3
with FormMain do
  if ReflexionEnCours then
    begin
    TimerEnabled:=TimerReflexion.Enabled;
    if TimerEnabled then
      EmpecheTempsImparti:=True // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
    end
  else
    TimerEnabled:=False;
AfficheTirage;
RafraichitAccesBoutons
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.ButtonOKClick(Sender: TObject);
var i : Integer;
begin
// On en profite pour affecter une seule fois stTirage (à cause des vides et des jokers)
p.stTirage[p.Tour]:=stTirageVide;
if TiragePropose then
  p.TiragePropose[p.Tour]:=True; // v1.5.3
if p.TypePartie=tpJoker then // v1.5.6
  p.AjouteJokerAuTirage;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if TypeJeton[p.t[i]]>tjIndefini then
    p.stTirage[p.Tour, i]:=p.stLettre(p.t[i])[1];
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.TesteJokerDernierJeton(const LabelTirage : TLabel);
var Taille : Integer;
begin
Taille:=Length(LabelTirage.Caption);
if LabelTirage.Caption[Taille]=' ' then
  LabelTirage.Caption:=Copy(LabelTirage.Caption, 1, Taille-1)+'?'
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.RafraichitAccesBoutons;
var i : Integer;
  function SaisieTerminee : Boolean;
  begin
  Result:=(Length(LabelReliquat.Caption)+
           Length(LabelNouveauTirage.Caption)=NbMaxJetonsTirage) or // Tirage à 7 jetons
          (p.ProchainJetonATirer>High(TOrdreJetonSac)) // Sac vide
  end;
begin
// 1. On grise tout
for i:=0 to NbLettresAlphabet do
  (FindComponent('Button'+IntToStr(i)) as TButton).Enabled:=False;
if SaisieTerminee then
  begin
  ButtonOk.Enabled:=True;
  Exit
  end;
// 2. On active dès que l'on trouve un jeton dans le sac...
for i:=p.ProchainJetonATirer to High(TOrdreJetonSac) do
  (FindComponent('Button'+IntToStr(Ord(TypeJeton[p.s[i]])-1)) as TButton).Enabled:=True;
// On active le bouton OK si on arrive à 7 jetons dans le tirage ou que le sac est vide.
ButtonOk.Enabled:=SaisieTerminee
end;
//----------------------------------------------------------------------------
procedure TFormSaisieTirage.AfficheTirage;
var i : Integer;
begin
LabelReliquat.Caption:='';
LabelNouveauTirage.Caption:='';
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if i<p.PremierJetonTire then
    begin
    LabelReliquat.Caption:=LabelReliquat.Caption+
                           stLettreJeton[TypeJeton[p.t[i]]];
    TesteJokerDernierJeton(LabelReliquat)
    end
  else
    begin
    LabelNouveauTirage.Caption:=LabelNouveauTirage.Caption+
                                stLettreJeton[TypeJeton[p.t[i]]];
    TesteJokerDernierJeton(LabelNouveauTirage)
    end
end;
//----------------------------------------------------------------------------
end.
