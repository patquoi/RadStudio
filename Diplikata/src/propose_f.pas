unit propose_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls, System.Actions, base;
//---------------------------------------------------------------------------
type
  TFormPropositionPose = class(TForm)
    ActionList: TActionList;
    ActionA: TAction;
    ActionAn: TAction;
    ActionB: TAction;
    ActionCh: TAction;
    ActionD: TAction;
    ActionE: TAction;
    ActionEn: TAction;
    ActionF: TAction;
    ActionG: TAction;
    ActionH: TAction;
    ActionI: TAction;
    ActionJ: TAction;
    ActionK: TAction;
    ActionL: TAction;
    ActionM: TAction;
    ActionN: TAction;
    ActionO: TAction;
    ActionP: TAction;
    ActionOn: TAction;
    ActionOu: TAction;
    ActionR: TAction;
    ActionS: TAction;
    ActionT: TAction;
    ActionUi: TAction;
    ActionV: TAction;
    ActionW: TAction;
    ActionNg: TAction;
    ActionY: TAction;
    ActionZ: TAction;
    ActionJoker: TAction;
    ActionEffacer: TAction;
    ActionFin: TAction;
    PopupMenu: TPopupMenu;
    MenuItemA: TMenuItem;
    MenuItemB: TMenuItem;
    MenuItemC: TMenuItem;
    MenuItemD: TMenuItem;
    MenuItemE: TMenuItem;
    MenuItemF: TMenuItem;
    MenuItemG: TMenuItem;
    MenuItemH: TMenuItem;
    MenuItemI: TMenuItem;
    MenuItemJ: TMenuItem;
    MenuItemK: TMenuItem;
    MenuItemL: TMenuItem;
    MenuItemM: TMenuItem;
    MenuItemN: TMenuItem;
    MenuItemO: TMenuItem;
    MenuItemP: TMenuItem;
    MenuItemR: TMenuItem;
    MenuItemS: TMenuItem;
    MenuItemT: TMenuItem;
    MenuItemU: TMenuItem;
    MenuItemV: TMenuItem;
    MenuItemW: TMenuItem;
    MenuItemY: TMenuItem;
    MenuItemZ: TMenuItem;
    MenuItemJoker: TMenuItem;
    MenuItemEffacer: TMenuItem;
    TimerPlacementAuto: TTimer;
    StatusBar: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    LabelPose: TLabel;
    LabelReliquat: TLabel;
    ButtonProposerCoupJoueur: TButton;
    ButtonA: TButton;
    ButtonAn: TButton;
    ButtonB: TButton;
    ButtonCh: TButton;
    ButtonD: TButton;
    ButtonE: TButton;
    ButtonEn: TButton;
    ButtonF: TButton;
    ButtonG: TButton;
    ButtonH: TButton;
    ButtonI: TButton;
    ButtonJ: TButton;
    ButtonK: TButton;
    ButtonL: TButton;
    ButtonM: TButton;
    ButtonN: TButton;
    ButtonO: TButton;
    ButtonP: TButton;
    ButtonOn: TButton;
    ButtonOu: TButton;
    ButtonR: TButton;
    ButtonS: TButton;
    ButtonT: TButton;
    ButtonUi: TButton;
    ButtonV: TButton;
    ButtonW: TButton;
    ButtonNg: TButton;
    ButtonY: TButton;
    ButtonZ: TButton;
    ButtonJoker: TButton;
    ButtonEffacer: TButton;
    RadioGroupDirection: TRadioGroup;
    LabelColonne: TLabel;
    LabelLigne: TLabel;
    ComboBoxColonne: TComboBox;
    ComboBoxLigne: TComboBox;
    ButtonPlacer: TButton;
    ButtonAnnuler: TButton;
    ButtonFin: TButton;
    procedure ActionLettreExecute(Sender: TObject);
    procedure ActionEffacerExecute(Sender: TObject);
    procedure ActionFinExecute(Sender: TObject);
    procedure TimerPlacementAutoTimer(Sender: TObject);
    procedure ButtonPlacerClick(Sender: TObject);
    procedure ButtonPlacerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioGroupDirectionClick(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ButtonProposerCoupJoueurClick(Sender: TObject);
  private
    PlacementAutoOK : Boolean; // v1.6.9 : Permet de fermer la boîte modale automatiquement dès que Placer est actif
    Solution : TSolution;
    procedure DesactiveBoutons;
    procedure ActivePhase2;
    procedure RafraichitBoutonPlacer;
    procedure RafraichitBoutons;
    function PropositionOk : Boolean;
    procedure Trace;
    procedure RecopieChevalet; // v1.5.2
    procedure ChargeTirage; // v1.5.2
  public
    Chevalet : TChevalet;
    d : TDirection;
    X, Y : TCoordonnee;
    Debut, Fin : TOrdreJetonChevalet;
    ScoreProposition : Integer;
    // v1.5.2 : Proposition du joueur (x,y,d)...
    ChoixColonne, ChoixLigne : Integer;
    ChoixDirection : TDirection;
    function PropositionPose(var Solution : TSolution; var ScoreProposition : Integer; // v1.7.4 : plus de paramètres X, Y, d, Debut, Fin
                             const ChoixColonne, ChoixLigne : Integer; const ChoixDirection : TDirection) : Boolean; // v1.5.2 : ajout des 3 const Choix[...] pour l'affichage de la proposition joueur
  end;
//---------------------------------------------------------------------------
var
  FormPropositionPose: TFormPropositionPose;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses main_f, tirage_f, definition_f, langue;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const stPrefixeAction ='Action'; // vKA
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ActionEffacerExecute(Sender: TObject);
var DrnCar : Char;    // vKA
    l      : Integer; // vKA
    DblLtr : Boolean;
begin
l:=Length(LabelPose.Caption); // vKA
if l=0 then Exit; // vKA
DrnCar:=LabelPose.Caption[l];
DblLtr:=(DrnCar>='a') and (DrnCar<='z');  // vKA
LabelReliquat.Caption:=Copy(LabelPose.Caption,
                            l-Ord(DblLtr),  // On prend deux lettres si la dernière est une minuscule (double lettre)
                            1+Ord(DblLtr))+ // On prend deux lettres si la dernière est une minuscule (double lettre)
                       LabelReliquat.Caption;
LabelPose.Caption:=copy(LabelPose.Caption, 1, l-1-Ord(DblLtr));
Dec(Fin);
RafraichitBoutons;
Trace
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ActionFinExecute(Sender: TObject);
begin
// On décrémente Fin car il reflète le prochain jeton à poser (initialisé à 1 quand la pose est vide)
Dec(Fin);
DesactiveBoutons;
ActivePhase2;
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ActionLettreExecute(Sender: TObject);
var PosLettre,
    i,
    iChevalet : Integer;
    stAction, // vKA
    stLettre  : String;
    JtnPerm   : TNumeroJetonSac;

begin // Lettre+Joker
stAction:=(Sender as TAction).Name;
// 0. On identifie la lettre (' ' pour joker)
if stAction='ActionJoker' then
  stLettre:=' '
else
  stLettre:=Copy(stAction,7,2); // vKA
// 1. On ajoute le jeton à la pose
LabelPose.Caption:=LabelPose.Caption+stLettre;
// 2. On retire le jeton du reliquat
PosLettre:=AnsiPos(stLettre, LabelReliquat.Caption); // vKA. AnsiPos au lieu de Pos
LabelReliquat.Caption:=Copy(LabelReliquat.Caption, 1, PosLettre-1)+
                       Copy(LabelReliquat.Caption,
                            PosLettre+Length(stLettre),
                            Length(LabelReliquat.Caption)-PosLettre);
// 3. On permute dans le chevalet et on incrémente la taille de la pose
iChevalet:=0;
i:=Fin;
Repeat
 if stAffichageJeton[TypeJeton[Chevalet[i]]]=stLettre then // vKA AffichageJeton au lieu de stLettreJeton
  iChevalet:=i;
 Inc(i);
Until (iChevalet>0) or (i=High(TOrdreJetonChevalet));
JtnPerm:=Chevalet[Fin];
Chevalet[Fin]:=Chevalet[iChevalet];
Chevalet[iChevalet]:=JtnPerm;
Inc(Fin);
RafraichitBoutons;
Trace
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ButtonPlacerClick(Sender: TObject);
begin
p.LettreJokerPropositionAvecUnSeulJetonPlace:=tjJoker; // v2.5.2
X:=TCoordonnee(ComboBoxColonne.ItemIndex);
Y:=TCoordonnee(ComboBoxLigne.ItemIndex);
d:=TDirection(RadioGroupDirection.ItemIndex+1);
if PropositionOk then
  begin
  PlacementAutoOK:=True; // v1.6.9 : Autorise à fermer la boîte modale (TimerPlacementAuto)
  ModalResult:=mrOk;
  end
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ButtonPlacerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // v 1.6
if (Shift = [ssShift, ssCtrl]) and (Key=68) then // Raccourci Maj+Ctrl+D > Definition de mot
  FormMain.ActionActionsRechercherDefinitionMotExecute(FormMain.ActionActionsRechercherDefinitionMot)
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ButtonProposerCoupJoueurClick(Sender: TObject);
var i : Integer;
begin
// 1. Chevalet
RecopieChevalet;
ChargeTirage;
// 2. On prend les jetons à placer
for i:=FormTirage.ChoixDebut to FormTirage.ChoixFin do
  if FormTirage.Chevalet[i]>0 then
    if TypeJeton[FormTirage.Chevalet[i]]=tjJoker then
      ActionLettreExecute(ActionJoker)
    else
      ActionLettreExecute(FindComponent(stPrefixeAction+stAffichageJeton[TypeJeton[FormTirage.Chevalet[i]]]) as TAction);
Dec(Fin);
DesactiveBoutons;
// 3. Direction
if ChoixDirection>dIndefinie then
  RadioGroupDirection.ItemIndex:=Ord(ChoixDirection)-1;
// 4. Coordonnées
ComboBoxColonne.ItemIndex:=ChoixColonne;
ComboBoxLigne.ItemIndex:=ChoixLigne;
ButtonPlacer.Enabled:=(ComboBoxColonne.ItemIndex>-1) and
                      (ComboBoxLigne.ItemIndex>-1) and
                      (RadioGroupDirection.ItemIndex>-1) and
                      (Length(LabelPose.Caption)>0);
if FormMain.PlacementPropositionAuto and ButtonPlacer.Enabled then // v1.6.9
  ButtonPlacerClick(self);
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ComboBoxChange(Sender: TObject);
begin
RafraichitBoutonPlacer
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.FormCreate(Sender: TObject);
begin
X:=0;
Y:=0;
d:=dIndefinie;
Debut:=1;
Fin:=1;
Solution:=Nil;
PlacementAutoOK:=False; // v1.6.9
GenereFichierFRIni(self); //v1.8 gestion multilingue
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.FormDestroy(Sender: TObject);
begin
FormMain.PlacementPropositionAuto:=False; // v1.6.9
PlacementAutoOK:=False; // v1.6.9
FreeAndNil(Solution)
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : accès l'aide en ligne (F1)
  with FormMain do
    ActionInfosAideExecute(ActionInfosAide)
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.FormKeyPress(Sender: TObject; var Key: Char);
begin
case Key of
  '@':if ButtonAn.Enabled then ActionLettreExecute(ActionAn); // vKA : @ => An
  '&':if ButtonEn.Enabled then ActionLettreExecute(ActionEn); // vKA : & => En
  '$':if ButtonNg.Enabled then ActionLettreExecute(ActionNg); // vKA : $ => Ng
  '°':if ButtonOn.Enabled then ActionLettreExecute(ActionOn); // vKA : ° => On
  'ù':if ButtonOu.Enabled then ActionLettreExecute(ActionOu); // vKA : ù => Ou
  end{case of}
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.FormShow(Sender: TObject);
begin
ChargeTirage; // v1.5.2
p.LettreJokerPropositionAvecUnSeulJetonPlace:=tjJoker; // v1.4.10
RafraichitBoutons;
Trace;
if FormMain.PlacementPropositionAuto and ButtonProposerCoupJoueur.Enabled then // v1.6.9
  ButtonProposerCoupJoueurClick(self);
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.RadioGroupDirectionClick(Sender: TObject);
begin
RafraichitBoutonPlacer
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.TimerPlacementAutoTimer(Sender: TObject);
begin // v1.6.9
if PlacementAutoOK then
  ModalResult:=mrOk;
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.RecopieChevalet; // v1.5.2
var i, j : Integer;
begin // v1.5.2
// On recopie les jetons du chevalet serrés à gauche
j:=Low(TOrdreJetonChevalet);
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
 if FormTirage.Chevalet[i]>0 then
  begin
  FormPropositionPose.Chevalet[j]:=FormTirage.Chevalet[i];
  Inc(j);
  end;
for i:=j to High(TOrdreJetonChevalet) do
 FormPropositionPose.Chevalet[i]:=0;
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ChargeTirage; // v1.5.2
var i : Integer;
begin
// On charge le tirage avec les jetons du chevalet
LabelPose.Caption:='';
LabelReliquat.Caption:='';
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
 if Chevalet[i]>0 then
  LabelReliquat.Caption:=LabelReliquat.Caption+stAffichageJeton[TypeJeton[Chevalet[i]]]; // vKA
end;
//---------------------------------------------------------------------------
function TFormPropositionPose.PropositionPose(var Solution : TSolution; var ScoreProposition : Integer; // v1.7.4 : plus de paramètres X, Y, d, Debut, Fin
                                              const ChoixColonne, ChoixLigne : Integer; const ChoixDirection : TDirection) : Boolean; // v1.5.2 : ajout des 3 const Choix[...] pour l'affichage de la proposition joueur
begin
Result:=False; // v1.4.3 : évite l'avertissement
ScoreProposition:=0;
FormPropositionPose:=TFormPropositionPose.Create(Application);
FormPropositionPose.RecopieChevalet; // v1.5.2 (factorisation)
FormPropositionPose.ChoixColonne:=ChoixColonne; // v1.5.2
FormPropositionPose.ChoixLigne:=ChoixLigne; // v1.5.2
FormPropositionPose.ChoixDirection:=ChoixDirection; // v1.5.2
try
 Result:=(FormPropositionPose.ShowModal<>mrCancel);
 if Result then
   ScoreProposition:=FormPropositionPose.ScoreProposition;
finally
  if Result then
   Solution:=TSolution.Clone(FormPropositionPose.Solution);
  FormPropositionPose.Release;
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.DesactiveBoutons;
var c                 : Integer; // vKA : Integer au lieu de Char
    stNomAction       : String;
begin
ActionFin.Enabled:=False;
ActionEffacer.Enabled:=False;
ActionJoker.Enabled:=False;
for c:=Ord(tjA) to Ord(tjZ) do // vKA : on parcourt TTypeJeton et non 'A' à 'Z'
 begin
 stNomAction:=stPrefixeAction+stAffichageJeton[TTypeJeton(c)]; // vKA : on parcourt TTypeJeton et non 'A' à 'Z' et on affiche les lettres
 (FindComponent(stNomAction) as TAction).Enabled:=False;
 end;
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.ActivePhase2;
begin
RadioGroupDirection.Enabled:=True;
LabelColonne.Enabled:=True;
LabelLigne.Enabled:=True;
ComboBoxColonne.Enabled:=True;
ComboBoxLigne.Enabled:=True;
RadioGroupDirection.SetFocus
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.RafraichitBoutonPlacer;
begin
ButtonPlacer.Enabled:=(RadioGroupDirection.ItemIndex>-1) and
                      (ComboBoxColonne.ItemIndex>-1) and
                      (ComboBoxLigne.ItemIndex>-1);
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.RafraichitBoutons;
var i           : Integer;
    stNomAction : String;
begin
ButtonProposerCoupJoueur.Enabled:=(Length(LabelPose.Caption)=0); // v1.5.2
// On désactive tous les boutons...
DesactiveBoutons;
ActionEffacer.Enabled:=Length(LabelPose.Caption)>0;
ActionFin.Enabled:=Length(LabelPose.Caption)>0; // v1.5.2 : erreur : "Caption" au lieu de "Name"
// ...Puis on ne réactive que les boutons des lettres restantes du tirage
for i:=1 to Length(LabelReliquat.Caption) do
 begin
 if LabelReliquat.Caption[i]=stLettreJeton[tjJoker] then
  ActionJoker.Enabled:=True
 else
  begin
  if (LabelReliquat.Caption[i]>='A') and (LabelReliquat.Caption[i]<='Z') then // vKA : On exclut les lettres en minuscules traitées ci-dessous
    begin
    if (Length(LabelReliquat.Caption)>i) and (LabelReliquat.Caption[i+1]>='a') and (LabelReliquat.Caption[i+1]<='z') then // vKA : On traite les doubles lettres ici
      stNomAction:=stPrefixeAction+LabelReliquat.Caption[i]+LabelReliquat.Caption[i+1]
    else
      stNomAction:=stPrefixeAction+LabelReliquat.Caption[i];
    (FindComponent(stNomAction) as TAction).Enabled:=True
    end{if a~z}
  end{if A~Z}
 end{for};
end;
//---------------------------------------------------------------------------
function TFormPropositionPose.PropositionOk : Boolean;
var stPrmMotPrincipal : String; // v1.5.3
begin
Result:=False; // Pessimiste
if (p.Tour=1) and (Fin<NbLettresMinMot) then
  begin
  FormMain.AfficheMessage(Format('Vous devez placer au moins %d lettres sur le plateau de jeu au premier tour.', [NbLettresMinMot]),
                          stPlacementImpossible, MB_ICONEXCLAMATION);
  Exit
  end;
if p.EstJouable(X, Y,
                d,
                Chevalet,
                Debut, Fin) then
  if p.MotsFormesValables(X, Y,
                          d,
                          Chevalet,
                          Debut, Fin, tpPose) then // v1.4 : tpPose
    with FormMain do
      begin
      FreeAndNil(Solution);
      if Fin=Debut then // v1.5.3 : Cas de la pose d'un seul jeton : on choisit la direction du mot formé
        begin
        stPrmMotPrincipal:=p.stMotPrincipal;
        p.MotsFormesValables(X, Y, Dir90[d], Chevalet, Debut, Fin, tpPose);
        if (Length(stPrmMotPrincipal)<Length(p.stMotPrincipal)) or
           ((Length(stPrmMotPrincipal)=Length(p.stMotPrincipal)) and (stPrmMotPrincipal>p.stMotPrincipal)) then
          d:=Dir90[d]
        end;
      if FormDefinitionMot<>nil then // v1.6 : propose le mot pour la recherche de définition (Maj+Ctrl+D)
        FormDefinitionMot.EditMot.Text:=stLettresDoubles(AnsiLowerCase(p.stMotPrincipal)); // vKA : Affichage des lettres doubles : ajout de stLettresDoubles(...) et utilisation d'AnsiLowerCase au lieu de LowerCase pour les lettres accentuées
      Solution:=TSolution.Cree(p.stMotPrincipal, X, Y, d, Chevalet, Debut, Fin, p.NumeroJoker, p.LettreJoker); // p.* affectés dans p.MotsFormesValables (cf. v1.4)
      ScoreProposition:=p.ScorePose(X, Y, d, Chevalet, Debut, Fin);
      PoseProposition(X, Y, d, Chevalet, Debut, Fin);
      if not FormMain.PlacementPropositionAuto then // v1.6.9
        AfficheMessage(Format('Votre proposition rapporte %d points.',
                              [ScoreProposition]),
                       'Proposition', MB_ICONINFORMATION);
      RetireProposition(X, Y, d);
      Result:=True
      end{with}
  else
    with FormMain do
      AfficheMessage(p.stMessage, stPlacementImpossible, MB_ICONEXCLAMATION)
else
  with FormMain do
    AfficheMessage(p.stMessage,
                   stPlacementImpossible,
                   MB_ICONEXCLAMATION);
end;
//---------------------------------------------------------------------------
procedure TFormPropositionPose.Trace;
var i : Integer;
begin
StatusBar.SimpleText:='Chevalet : '; //IntToStr(Fin)+':';
For i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
 StatusBar.SimpleText:=StatusBar.SimpleText+p.stLettre(Chevalet[i]);
end;
//---------------------------------------------------------------------------
end.
