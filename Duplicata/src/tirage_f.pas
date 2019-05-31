unit tirage_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base;
//---------------------------------------------------------------------------
const CouleurSelection   = clRed;
      CouleurChoix1Jeton = clBlue; // v1.4.1
//---------------------------------------------------------------------------
type
  TEtapeSelectionPose = (espInactive, espActivee, espChoixDebutSelection); // v1.4.1
  TFormTirage = class(TForm)
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TaillePolice,
    TailleCase              : Integer;
    EtapeSelectionPose      : TEtapeSelectionPose; // v1.4.1
    RafraichissementEnCours : Boolean;
    ChoixJeton,
    Choix1Jeton             : TNumeroJetonChevalet; // v1.4.1
    FChoixDebut,
    FChoixFin               : TNumeroJetonChevalet;
    function CompteNbJetons : TNbJetonsTirage; // v1.4.9
  public
    Chevalet   : TChevalet;
    property ChoixDebut : TNumeroJetonChevalet read FChoixDebut;
    property ChoixFin   : TNumeroJetonChevalet read FChoixFin;
    property NbJetons   : TNbJetonsTirage read CompteNbJetons; // v1.4.9
    function ChargeTirage : Boolean;
    procedure DessineTirage;
    procedure ChargeChevalet(const Chevalet : TChevalet;
                             const Debut, Fin : TNumeroJetonChevalet);
    procedure ChangeTirage;
    procedure DefinitDimensionsParDefaut; // v1.8.2 : plus de paramètres FormTirageClient
    procedure ChargeOptions; // v1.3.2
  end;
//---------------------------------------------------------------------------
const TailleMinCase = 16;
//---------------------------------------------------------------------------
var
  FormTirage: TFormTirage;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses
  System.Math, System.Inifiles, main_f, fdmatch_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const
  stEntreeDimensionsLT      : string = 'LT'; // Largeur Tirage
  stEntreeDimensionsHT      : string = 'HT'; // Hauteur Tirage
  stSectionParametres       : string = 'Paramètres';
  stSectionAffichage        : string = 'Affichage';
  stSectionDimensions       : string = 'Dimensions';
//---------------------------------------------------------------------------
procedure TFormTirage.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var DiffLargeur, DiffHauteur : Integer;
begin
DiffLargeur:=Width-ClientWidth;
DiffHauteur:=Height-ClientHeight;
if (NewWidth-DiffLargeur<2+TailleMinCase*NbMaxPlacesChevalet) or
   (NewHeight-DiffHauteur<2+TailleMinCase) then
  Resize:=False;
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormResize(Sender: TObject);
var
i            : TTypeJeton;
TaillePolice,
TailleLettre : Integer;
TailleOk     : Boolean;
begin
if not Visible or
   RafraichissementEnCours then Exit; // Redimensionnement en cours
RafraichissementEnCours:=True;
try
  // On retaille le chevalet
  TailleCase:=Min(ClientHeight-2,(ClientWidth-2) div NbMaxPlacesChevalet);
  ClientWidth:=2+NbMaxPlacesChevalet*TailleCase;
  ClientHeight:=2+TailleCase;
  // On détermine la taille de la police de telle sorte que toutes les lettres entre dans une case
  with Font do
    begin
    Charset:=ANSI_CHARSET;
    Name:='Arial';
    Style:=[];
    end;
  TailleLettre:=TailleCase-2; // On retire les bords pour le contenu
  TaillePolice:=2;
  with Canvas do
    Repeat
      Font.Size:=TaillePolice;
      i:=Succ(Low(TTypeJeton));
      Repeat
       TailleOk:=(Max(TextWidth(stLettreJeton[i]),
                      TextHeight(stLettreJeton[i]))<=TailleLettre);
       i:=Succ(i);
      Until (i=High(TTypeJeton)) or not TailleOk;
    if TailleOk then
      begin
      Self.TaillePolice:=TaillePolice;
      Inc(TaillePolice);
      end;
    Until not TailleOk;

  // On rafraichit enfin le tirage avec les tailles définies
  Self.TailleCase:=TailleCase;
  DessineTirage;

  // v1.8.3 : on replace finalement complètement la feuille de match (position et taille)
  // FormFeuilleMatch.CalculeLargeurMax; // v1.8.2
  // v1.8.5 : il faut utiliser Hide/Show pour déclencher FormShow ET faire apparaître la fenêtre
  // FormFeuilleMatch.FormShow(self);
  with FormFeuilleMatch do
    begin
    if Visible then Hide; // Force à rafraîchir
    Show;
    end{with};
finally
  RafraichissementEnCours:=False;
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormHide(Sender: TObject);
begin
FormMain.ActionAffichageTirage.Checked:=False;
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var ChoixPrecedent : TOrdreJetonChevalet;
    NumeroJeton    : TNumeroJetonSac;
begin // v1.4.1
//Application.MessageBox(pChar(IntToStr(Key)), 'Key');
if Choix1Jeton=0 then Exit;
ChoixPrecedent:=Choix1Jeton;
case Key of // v1.8.2 : Contrôles à l'intérieur du case
  36: Choix1Jeton:=Low(TOrdreJetonChevalet); // Début
  37: if Choix1Jeton>Low(TOrdreJetonChevalet) then Dec(Choix1Jeton); // Flèche gauche
  39: if Choix1Jeton<High(TOrdreJetonChevalet) then Inc(Choix1Jeton); // Flèche droite
  35: Choix1Jeton:=High(TOrdreJetonChevalet); // Fin
else Exit;
end{case};
NumeroJeton:=Chevalet[ChoixPrecedent];
Chevalet[ChoixPrecedent]:=Chevalet[Choix1Jeton];
Chevalet[Choix1Jeton]:=NumeroJeton;
DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormKeyPress(Sender: TObject; var Key: Char);
var i              : Integer;
    ChoixPrecedent : TOrdreJetonChevalet;
    NumeroJeton    : TNumeroJetonSac;
begin // v1.4.1
// Cas du choix de placement : on envoie la saisie au plateau de jeu (touche '+' ou saisie en cours)
if FormMain.ReflexionEnCours and
   (FormMain.ChoixPoseClavierEnCours or (Key='+') or (Key='#')) then // v1.5.2 : ajout de '#' (test placement)
  begin
  FormMain.FormKeyPress(Self, Key);
  Exit
  end;

// Interrupteur de la pose jetons (en rouge) au clavier (On/Off)
if (Key='*') then
  begin
  if EtapeSelectionPose>espInactive then
    begin
    EtapeSelectionPose:=espInactive;
    FChoixDebut:=0;
    FChoixFin:=0;
    DessineTirage
    end
  else
    EtapeSelectionPose:=espActivee;
  Exit;
  end;
// Maintenant il nous reste les chiffres !
if (Key<'0') or (Key>IntToStr(NbMaxJetonsTirage)[1]) then Exit; // v1.5.9 : on remplace '7' par IntToStr(NbMaxJetonsTirage)
ChoixPrecedent:=Choix1Jeton;
Choix1Jeton:=0;
if Key>'0' then
  begin
  for i:=Low(TOrdreJetonChevalet) to Ord(Key)-Ord('0') do
    begin
    Inc(Choix1Jeton);
    while (Choix1Jeton<High(TOrdreJetonChevalet)) and (Chevalet[Choix1Jeton]=0)
      do Inc(Choix1Jeton);
    end;
  if Choix1Jeton>High(TOrdreJetonChevalet) then
    Choix1Jeton:=0
  else
    if ChoixPrecedent>0 then // On permute !
      begin
      NumeroJeton:=Chevalet[ChoixPrecedent];
      Chevalet[ChoixPrecedent]:=Chevalet[Choix1Jeton];
      Chevalet[Choix1Jeton]:=NumeroJeton;
      Choix1Jeton:=0; // Plus de jeton sélectionné après permutation
      end
  end;
// Cas de la sélection de la pose des jetons (en rouge)
case EtapeSelectionPose of
 espActivee:              if Choix1Jeton=0 then
                            begin
                            FChoixDebut:=0;
                            FChoixFin:=0;
                            EtapeSelectionPose:=espInactive
                            end
                          else
                            begin
                            FChoixDebut:=Choix1Jeton;
                            FChoixFin:=0;
                            Choix1Jeton:=0;
                            EtapeSelectionPose:=espChoixDebutSelection
                            end;
 espChoixDebutSelection:  if Choix1Jeton=0 then
                            begin
                            FChoixDebut:=0;
                            FChoixFin:=0;
                            EtapeSelectionPose:=espInactive
                            end
                          else
                            begin
                            FChoixFin:=Choix1Jeton;
                            Choix1Jeton:=0;
                            EtapeSelectionPose:=espInactive
                            end
end;
DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i, JetonDeplace : Integer;
begin
if 1+(X-2) div TailleCase > NbMaxPlacesChevalet then // v1.8.2
  ChoixJeton:=NbMaxPlacesChevalet
else // v1.8.8 : X peut être négatif !
  if 1+(X-2) div TailleCase < 1 then 
    ChoixJeton:=1
  else
    ChoixJeton:=1+(X-2) div TailleCase;
if ssDouble in Shift then
  begin
  if Button=mbLeft then // On déplace en tête
    begin
    JetonDeplace:=Chevalet[ChoixJeton];
    for i:=ChoixJeton downto Low(TOrdreJetonChevalet)+1 do
      Chevalet[i]:=Chevalet[i-1];
    Chevalet[Low(TOrdreJetonChevalet)]:=JetonDeplace;
    DessineTirage
    end;
  if Button=mbRight then // On déplace en queue
    begin
    // On annule la sélection (conflit)
    FChoixDebut:=0;
    FChoixFin:=0;
    JetonDeplace:=Chevalet[ChoixJeton];
    for i:=ChoixJeton to High(TOrdreJetonChevalet)-1 do
      Chevalet[i]:=Chevalet[i+1];
    Chevalet[High(TOrdreJetonChevalet)]:=JetonDeplace;
    DessineTirage
    end
  end
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i, JetonDeplace : Integer;
    ChoixCible : TNumeroJetonChevalet;
begin
if 1+(X-2) div TailleCase > NbMaxPlacesChevalet then // v1.8.2
  ChoixCible:=NbMaxPlacesChevalet
else // v1.8.7 : X peut être négatif !
  if 1+(X-2) div TailleCase < 1 then
    ChoixCible:=1
  else
    ChoixCible:=1+(X-2) div TailleCase;
if Button=mbLeft then // Déplacement
  begin
  if ChoixCible=ChoixJeton then Exit;
  JetonDeplace:=Chevalet[ChoixJeton];
  if ChoixCible<ChoixJeton then // On déplace en tête
    for i:=ChoixJeton downto ChoixCible+1 do
      Chevalet[i]:=Chevalet[i-1]
  else
    for i:=ChoixJeton to ChoixCible-1 do
      Chevalet[i]:=Chevalet[i+1];
  Chevalet[ChoixCible]:=JetonDeplace;
  end;
if Button=mbRight then // Sélection du placement
  begin
  FChoixDebut:=Min(ChoixJeton, ChoixCible);
  FChoixFin:=Max(ChoixJeton, ChoixCible);
  end;
DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormPaint(Sender: TObject);
begin
DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormShow(Sender: TObject);
begin
FormMain.ActionAffichageTirage.Checked:=True;
Top:=FormMain.Top;
Left:=FormMain.Left+FormMain.Width;
if Left+Width>Screen.Width then // v1.4 : On fait attention de ne pas déborder de l'écran
  DefinitDimensionsParDefaut; // v1.8.2 : plus de paramètres FormTirageClient
FormResize(Self);
DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.FormCreate(Sender: TObject);
var i : Integer;
begin
ChargeOptions;
DoubleBuffered:=True; // Evite le scintillement
RafraichissementEnCours:=False;
ChoixJeton:=0;
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  Chevalet[i]:=0;
FChoixDebut:=0;
FChoixFin:=0;
Choix1Jeton:=0; // v1.4.1
EtapeSelectionPose:=espInactive; // v1.4.1
end;
//---------------------------------------------------------------------------
procedure TFormTirage.DessineTirage;
var i, Valeur,
    x1, y1,
    x2, y2,
    LargeurTexte, // v1.5
    LargeurScore : Integer; // v1.5
    Mode         : TBrushStyle;
    ContenuJeton : TTypeJeton;
    Score        : String;
begin
with Canvas do
  begin
  // On met d'abord un fond noir
  Brush.Color:=Color;
  FillRect(Rect(0, 0, ClientWidth, ClientWidth));
  for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
    if Chevalet[i]>0 then
      begin // /!\ ATTENTION LE DESSION DES JETONS EST DUPLIQUÉ DANS FormMain.DessineCase /!\
      // Ensuite les jetons
      x1:=1+TailleCase*(i-1);
      y1:=1;
      x2:=x1+TailleCase;
      y2:=y1+TailleCase;

      ContenuJeton:=TypeJeton[Chevalet[i]]; // v1.6 : déplacé ici pour CouleurEncreJetonCher
      Valeur:=ValeurJeton[ContenuJeton]; // v1.6 : déplacé ici pour CouleurEncreJetonCher

      Pen.Color:=IfThen(i=Choix1Jeton, CouleurChoix1Jeton, // v1.4.1
                        IfThen((i>=FChoixDebut) and (i<=FChoixFin),
                               CouleurSelection,
                               CouleurEncreJeton[Valeur] // v1.6
                              )
                       ); // v1.4.1
      Brush.Color:=CouleurFondJeton[CoupJoue];
      RoundRect(x1, y1, x2, y2,
               TailleCase div 5,
               TailleCase div 5);
      Font.Color:=(* Pen.Color - v1.4.1 *)
                  IfThen((i>=FChoixDebut) and (i<=FChoixFin),
                         CouleurSelection,
                         IfThen(i=Choix1Jeton,
                                CouleurChoix1Jeton,
                                CouleurEncreJeton[Valeur] // v1.6
                               )
                        );
      Mode:=Brush.Style;
      Brush.Style:=bsclear;

      Font.Size:=TaillePolice div 3;
      // v1.5 : l'affichage de la lettre a été déplacé après l'affichage du score pour utiliser la largeur du score
      LargeurScore:=0; // v1.5
      if Valeur>0 then
       begin
       if Valeur>9 then // v1.5 : oubli de la correction v1.3.6 : On place mieux l'indice 10 (vers la droite)...
         begin
         Score:=IntToStr(ValeurJeton[ContenuJeton] div 10)+' ';
         TextOut(x1+TailleCase-TextWidth(Score)-3 // v1.5.6 (Ord) ci-dessous
                   -Ord((TaillePolice>35) and (TaillePolice<39))
                   -Ord((TaillePolice>41) and (TaillePolice<45))
                   -Ord(TaillePolice>47)
                   -Ord((TaillePolice>50) and (TaillePolice<54)),
                 y1+TailleCase-TextHeight(Score)-2,
                 Score);
         LargeurScore:=TextWidth(Score); // v1.5
         Score:=' '+IntToStr(ValeurJeton[ContenuJeton] mod 10);
         TextOut(x1+TailleCase-TextWidth(Score)-3
                   -Ord(TaillePolice>29)
                   -Ord(TaillePolice>44)
                   -Ord(TaillePolice>77)
                   +TextWidth(' ') div 2, // v1.5.6 (Ord)
                 y1+TailleCase-TextHeight(Score)-2,
                 Score);
         // FormMain.StatusBar.Panels.Items[0].Text:=IntToStr(TaillePolice) // Pour test
         end
       else
         begin
         Score:=IntToStr(ValeurJeton[ContenuJeton]);
         TextOut(x1+TailleCase-TextWidth(Score)-3
                   -Ord(TaillePolice>44)
                   -Ord(TaillePolice>47), // v1.5.6 (Ord) + TextWidth(' ') div 2 supprimé
                 y1+TailleCase-TextHeight(Score)-2,
                 Score);
         LargeurScore:=TextWidth(Score); // v1.5
         end;
       end{if Valeur};
      // v1.5 : on décale légèrement les lettres à gauche en fonction du score affiché sur le jeton
      Font.Size:=TaillePolice;
      LargeurTexte:=TextWidth(stLettreJeton[ContenuJeton]); // v1.5
      if stLettreJeton[ContenuJeton]='W' then LargeurScore:=LargeurScore div 3; // v1.5
      TextOut(x1+(TailleCase-LargeurTexte-LargeurScore) div 2, // v1.5 : Décalage
              y1, stLettreJeton[ContenuJeton]);
      Brush.Style:=Mode;
      end{if p.c else}
  end{with}
end;
//---------------------------------------------------------------------------
function TFormTirage.ChargeTirage : Boolean;
var i : Integer;
begin
// 1. On efface tout le chevalet
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  Chevalet[i]:=0;
FChoixDebut:=0;
FChoixFin:=0;
// 2. On charge à gauche le restant et à droite le nouveau tirage
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if (p.PremierJetonTire=0) or (i<p.PremierJetonTire) then
    Chevalet[i]:=p.t[i]
  else
    Chevalet[i+NbMaxPlacesChevalet-NbMaxJetonsTirage]:=p.t[i];
// 3. Affichage
if visible then
  DessineTirage
else
  Show;
// 4. Tirage acceptable ?
Result:=not p.TirageInchangeable; // v1.5 : à la place de (p.ProchainJetonATirer<=High(TOrdreJetonSac));
if Result then // Cas du reliquat testé à l'extérieur (fin de jeu)
  while not p.TirageAcceptable and
        not FormMain.DemoEnCours and
    (FormMain.AfficheMessage('Le tirage est insuffisant à ce stade de la partie.'#13#13'Souhaitez-vous changer tout le tirage ?',
                             'Changement du tirage',
                             MB_ICONQUESTION+MB_YESNO)=IDYES) do
    ChangeTirage
else
  Result:=p.TirageAcceptable;
  if not Result and // v1.4.9 : possibilité de continuer jusqu'au bout la partie
     (NbJetons>0) and
     not FormMain.DemoEnCours then
    Result:=(FormMain.AfficheMessage('Le tirage est insuffisant.'#13#13'Voulez-vous néanmoins continuer ?',
                                     'Tirage insuffisant',
                                     MB_ICONQUESTION+MB_YESNO)=IDYES)
end;
//---------------------------------------------------------------------------
procedure TFormTirage.DefinitDimensionsParDefaut; // v1.8.2 : plus de paramètres FormTirageClient
begin
if (Screen.Width<800) or
   (Screen.Height<600) then
  begin
  FormMain.AfficheMessage(stResolutionMinimale, stResolution, MB_ICONEXCLAMATION);
  Application.Terminate
  end;
Width:=Screen.Width-FormMain.Width;
if FormFeuilleMatch<>nil then
  FormFeuilleMatch.Height:=FormMain.Height-Height
end;
//---------------------------------------------------------------------------
procedure TFormTirage.ChargeOptions; // v1.3.2
var IniFile                : TIniFile;
    FormTirageClientWidth,
    FormTirageClientHeight : Integer;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    DefinitDimensionsParDefaut; // v1.8.2 : plus de paramètres FormTirageCLient
    RafraichissementEnCours:=True;
    ClientWidth:=ReadInteger(stSectionDimensions, stEntreeDimensionsLT, FormTirageClientWidth);
    RafraichissementEnCours:=False;
    ClientHeight:=ReadInteger(stSectionDimensions, stEntreeDimensionsHT, FormTirageClientHeight);
    end{with};
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormTirage.ChargeChevalet(const Chevalet : TChevalet;
                                     const Debut, Fin : TNumeroJetonChevalet);
var i : Integer;
begin
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  self.Chevalet[i]:=Chevalet[i];
FChoixDebut:=Debut;
FChoixFin:=Fin;
if Visible then DessineTirage
end;
//---------------------------------------------------------------------------
procedure TFormTirage.ChangeTirage;
begin
p.ChangeTirage(Chevalet);
p.TirageOKVerifieSiNecessaire(Chevalet); // v1.5.6
if not Visible then
  Show
else
  DessineTirage
end;
//---------------------------------------------------------------------------
function TFormTirage.CompteNbJetons : TNbJetonsTirage; // v1.4.9
var i : Integer;
begin
Result:=Low(TNbJetonsTirage);
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  Inc(Result, Ord(Chevalet[i]>0))
end;
//---------------------------------------------------------------------------
end.
