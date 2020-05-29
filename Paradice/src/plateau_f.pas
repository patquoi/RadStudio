unit plateau_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ComCtrls, Vcl.Grids,
  base, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.Menus,
  Vcl.ExtCtrls;

const
  NbMaxRegles    = 3;

type

  TTypeAffichage = (taBilanTour=0, taEvolution=1, taStatsEvts=2, taStatsDes=3); // Indique l'affichage en haut à gauche (Bilan Tour par défaut)
  TFormatStats   = (fsPourcent=0, fsScore=1); // Indique le format des statistiques de dés et d'événements

  TNumRegle      = 1..NbMaxRegles;
  TOptionRegle   = (orEvtJckptAcht=1, orEvtJckptVnte=2, orEvtJckptLiqd=4); // Attention à bien définir des puissances de 2 pour pouvoir stocker TOptionsRegle ci-dessous
  TOptionsRegle  = set of TOptionRegle;

  TFormPlateau = class(TForm)
    ImageCollection: TImageCollection;
    VirtualImageListCases: TVirtualImageList;
    MainMenu: TMainMenu;
    MenuItemPartie: TMenuItem;
    MenuItemOptions: TMenuItem;
    MenuITemInformations: TMenuItem;
    StatusBar: TStatusBar;
    MenuItemAPropos: TMenuItem;
    MenuItemVoir: TMenuItem;
    MenuItemEvenements: TMenuItem;
    VirtualImageListDirPoss: TVirtualImageList;
    VirtualImageListFonds: TVirtualImageList;
    VirtualImageListDes: TVirtualImageList;
    VirtualImageListJackpot: TVirtualImageList;
    VirtualImageListFondsDe: TVirtualImageList;
    VirtualImageListChiffres: TVirtualImageList;
    VirtualImageListSignes: TVirtualImageList;
    VirtualImageListJoueurs: TVirtualImageList;
    VirtualImageListPions: TVirtualImageList;
    MenuItemPolice: TMenuItem;
    FontDialog: TFontDialog;
    MenuItemPartieNouvelle: TMenuItem;
    VirtualImageListTypes: TVirtualImageList;
    MenuItemParcours: TMenuItem;
    MenuItemParcours1: TMenuItem;
    MenuItemParcours2: TMenuItem;
    MenuItemParcours3: TMenuItem;
    MenuItemParcours4: TMenuItem;
    MenuItemParcours5: TMenuItem;
    MenuItemParcours6: TMenuItem;
    TimerParcours: TTimer;
    TimerDes: TTimer;
    TimerPion: TTimer;
    MenuItemVitesse: TMenuItem;
    MenuItemVitesseRapide: TMenuItem;
    MenuItemVitesseMoyenne: TMenuItem;
    MenuItemVitesseLente: TMenuItem;
    VirtualImageListDemiFonds: TVirtualImageList;
    TimerAutomate: TTimer;
    MenuItemSeparator1: TMenuItem;
    MenuItemPartiePause: TMenuItem;
    MenuItemPartieReprise: TMenuItem;
    MenuItemPartieAbandon: TMenuItem;
    TimerClignotement: TTimer;
    MenuItemEvolution: TMenuItem;
    MenuITemSeparator3: TMenuItem;
    MenuITemBilanTour: TMenuItem;
    MenuItemStatsEvts: TMenuItem;
    MenuItemStatsDes: TMenuItem;
    MenuItemFormatStats: TMenuItem;
    MenuItemFormatStatsPourcents: TMenuItem;
    MenuItemFormatStatsScore: TMenuItem;
    TimerLancement: TTimer;
    MenuItemSeparator2: TMenuItem;
    MenuItemRegle: TMenuItem;
    MenuItemRegleEvtJackpot: TMenuItem;
    MenuItemRegleEvtJackpotAchat: TMenuItem;
    MenuItemRegleEvtJackpotVente: TMenuItem;
    MenuItemRegleEvtJackpotLiquidation: TMenuItem;
    MenuItemPartieDemo: TMenuItem;
    Aide1: TMenuItem;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure MenuItemAProposClick(Sender: TObject);
    procedure MenuItemEvenementsClick(Sender: TObject);
    procedure MenuItemPoliceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItemPartieNouvelleClick(Sender: TObject);
    procedure MenuItemParcoursClick(Sender: TObject);
    procedure TimerParcoursTimer(Sender: TObject);
    procedure TimerDesTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerPionTimer(Sender: TObject);
    procedure MenuItemVitesseClick(Sender: TObject);
    procedure TimerAutomateTimer(Sender: TObject);
    procedure MenuItemPartiePauseClick(Sender: TObject);
    procedure MenuItemPartieRepriseClick(Sender: TObject);
    procedure MenuItemPartieAbandonClick(Sender: TObject);
    procedure TimerClignotementTimer(Sender: TObject);
    procedure MenuItemTypeAffichageClick(Sender: TObject);
    procedure MenuItemFormatStatsClick(Sender: TObject);
    procedure TimerLancementTimer(Sender: TObject);
    procedure MenuItemRegleClick(Sender: TObject);
    procedure MenuItemPartieDemoClick(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FMessage : String;
    DrnHauteur,
    DrnLargeur,
    DrnTaille : Integer; // Sauvegarde la taille de la fenêtre en cas de diminution (minimize)
    procedure DemarrePartie;
    procedure LitParametres;
    procedure EcritParametres;
    procedure DefinitMessage(stNvMessage : String); // Exécuté en affectant la property stMesssage
    procedure DessineMessage; // Exécuté en affectant la property stMesssage
    function RectCase(x : TCoordonnee; y : TCoordonnee) : TRect;
  public // Les procédures Dessine... ci-dessous sont utilisées automatiquement par FormPaint
    TailleCase    : Integer;
    TypeAffichage : TTypeAffichage;
    FormatStats   : TFormatStats;
    OptionsRegle  : TOptionsRegle;
    procedure ChangeAccesRegle(MenuItem : TMenuItem; Activer : Boolean);
    function DonneOptionsRegle : Integer;
    procedure DessineCase(ProprioId : TJoueurId; x : TCoordonnee; y : TCoordonnee; DirPoss : TDirPoss);
    procedure DessineScore(Id : TJoueurId; Pos, Score : Integer; JrCrt, Automate, Elimine : Boolean);
    procedure DessineJackpot(Score, DrnSc : Integer; DrnJr : TJoueurId);
    procedure DessineLanceDes(Id : TJoueurId; De : array of TDe);
    procedure DessineBilan(Tour : Integer);
    procedure DessineEvolution;
    procedure DessineStatsEvts;
    procedure DessineStatsDes;
    procedure DessineSelonTypeAffichage; // Appelle DessineBilan ou DessineEvolution selon TypeAffichage
    procedure DessineEvenement(TypeEvt : TTypeEvt; Proprio1, Proprio2 : TJoueurId);
    procedure DessineCompteurEvt(Couleur : TCouleur);
    property stMessage : String read FMessage write DefinitMessage;
  end;

var
  FormPlateau: TFormPlateau;

implementation
{$R *.dfm}

uses
  IniFiles, System.Types, System.Math, System.StrUtils, ShellApi, apropos_f, evtdes_f,
  nvpartie_f;

const
  stNomFichierIni    : String = 'Paradice.ini';
  stSectionOptions   : String = 'Options';
  stSectionAffichage : String = 'Affichage';
  stEntreePolice     : String = 'Police';
  stEntreeVitesse    : String = 'Vitesse';
  stEntreeFormat     : String = 'Format';
  stEntreeStats      : String = 'Stats';
  stEntreeRegle      : String = 'Règle';
  stEntreeHauteur    : String = 'Hauteur';
  stEntreeLargeur    : String = 'Largeur';
  stEntreeTaille     : String = 'Taille';
  NumRegle           : array [1..NbMaxRegles] of TOptionRegle = (orEvtJckptAcht, orEvtJckptVnte, orEvtJckptLiqd);

  // MessageBox
  stConfirmation     : String = 'Confirmation';
  stConfEVSDV        : String = '%sEtes-vous sûr(e) de vouloir %s ?';

// -------------------
// Evénements de fiche
// -------------------

procedure TFormPlateau.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
var dw, dh : Integer;
begin
if WindowState = wsMinimized then Exit;
if (NewHeight = DrnHauteur) and (NewWidth = DrnLargeur) then Exit;

dw:=Width-ClientWidth;
dh:=Height-ClientHeight+StatusBar.Height;
Resize:=True;
if (NewHeight<>Height) and (NewWidth=Width) then
  NewWidth:=NewHeight
else
  if (NewWidth<>Width) and (NewHeight=Height) then
    NewHeight:=NewWidth
  else
    if (NewHeight<Height) and (NewWidth<Width) then
      if NewHeight>NewWidth then
        NewWidth:=NewHeight
      else
        NewHeight:=NewWidth
    else
      if (NewHeight>Height) and (NewWidth>Width) then
        if NewHeight<NewWidth then
          NewWidth:=NewHeight
        else
          NewHeight:=NewWidth
      else
        Resize:=False;
if Resize then
  begin
  TailleCase:=(NewWidth-dw-(NbCasesDeCote+1)) div NbCasesDeCote;
  NewWidth:=NbCasesDeCote*TailleCase+dw+(NbCasesDeCote+1);
  NewHeight:=NewWidth-dw+dh;
  // Sauvegarde des dernières dimensions OK
  DrnLargeur := NewWidth;
  DrnHauteur := NewHeight;
  DrnTaille := TailleCase;
  end
else
  begin
  // Restauration des derniers dimensions OK;
  NewWidth := DrnLargeur;
  NewHeight := DrnHauteur;
  TailleCase := DrnTaille;
  Resize := True;
  end;
Refresh;
StatusBar.SimpleText:=Format('Taille d''une case : %d', [TailleCase]);
end;

procedure TFormPlateau.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin // v1.0.1 : ajout confirmation si partie en cours
try
  if Partie.Etat <> epInactif then
    Canclose := (Application.MessageBox(pWideChar(Format(stConfEVSDV, ['Une partie est en cours. ', 'quitter'])), pWideChar(stConfirmation), MB_ICONEXCLAMATION + MB_YESNO) = IDYES);
except
  Canclose := True;
end;
end{procedure TFormPlateau.FormCloseQuery};

procedure TFormPlateau.FormCreate(Sender: TObject);
begin
DrnHauteur := Height;
DrnLargeur := Width;
LitParametres;
end{procedure TFormPlateau.FormCreate};

procedure TFormPlateau.FormDestroy(Sender: TObject);
begin
EcritParametres;
end{procedure TFormPlateau.FormDestroy};

procedure TFormPlateau.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var d : base.TDirection;
begin

try
  with Partie do
    if (Etat = epPause) or       // évite d'interagir si le jeu est en pause
       (Jr[JrCrt].Automate) then // évite de court-circuiter le jeu d'un automate
      Exit;
except
end;

case Key of
  37..40: try
            with Partie do
              if Phase = phtChxDirPion then
                begin
                for d := Succ(Low(base.TDirection)) to High(base.TDirection) do
                  if Key = ToucheDir[d] then break;
                if (Ord(DirPossJr[JrCrt, Jr[JrCrt].Pion.x, Jr[JrCrt].Pion.y]) and Ord(DirPossDir[d])) = Ord(DirPossDir[d]) then
                  begin
                  TimerClignotement.Enabled := False;
                  Jr[JrCrt].Pion.Dir := d;
                  Phase := phtDepltPion;
                  end;
                end;
          except
          end{try};
end{case of};
end{procedure TFormPlateau.FormKeyDown};

procedure TFormPlateau.FormKeyPress(Sender: TObject; var Key: Char);
var x, y : TCoordonnee;
    tc : TTypeCase;
    te : TTypeEvt;
begin

try
  with Partie do
    if (Etat = epPause) or       // évite d'interagir si le jeu est en pause
       (Jr[JrCrt].Automate) then // évite de court-circuiter le jeu d'un automate
      Exit;
except
end;

case Key of
  #32: try
         with Partie do
           if Phase = phtLanceDes then // On arrête les dés et on déplace le pion
             begin
             TimerDes.Enabled := False;
             TimerClignotement.Enabled := False;
             Jr[JrCrt].Pion.CAP := Ord(De[PrmDe]) + Ord(De[DrnDe]); // Nb cases à parcourir = total des dés
             Phase := phtDepltPion;
             PhaseSvt := phtIndefinie;
             end;
       except
       end{try};
  #13: try
         with Partie do
           if (Phase = phtActionDes) and
              (PhaseSvt <> phtAchatEvt) then // Pas d'achat en cours (O/N obligatoire)
             begin
             Phase := PhaseSvt;
             PhaseSvt := phtIndefinie;
             end;
       except
       end{try};

// Achat d'événement
  'o',
  'O',
  'n',
  'N': try
         with Partie do
           begin
           x := Jr[JrCrt].Pion.x;
           y := Jr[JrCrt].Pion.y;
           tc := TypeCase[x, y];
           if (Phase = phtActionDes) and
              (PhaseSvt = phtAchatEvt) and
              (TypeEvtCase[tc]>teIndefini) then
              begin
              te := TypeEvtCase[tc];
              if (Key = 'O') or (Key = 'o') then
                begin // Le joueur courant acquiert l'événement, il paie le prix
                Paie(PrixEvt[Nbj], jIndefini, JrCrt);
                Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := JrCrt;
                end
              else // Le jackpot hérite l'événement
                if orEvtJckptAcht in OptionsRegle then // Si option "Evt Jackpot Achat" est activée
                  Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jJackpot
                else
                  Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jIndefini;
              DessineCase(x, y);
              DessineEvenement(te);
              DessineCompteurEvt(TCouleur(Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id), AvecBlanc);
              DessineCompteurEvt(cPourpre, SansBlanc);
              PhaseSvt := phtIndefinie;
              Phase := phtJoueurSvt;
              end;
           end;
       except
       end{try};

// Vente d'événement
  'f',
  'F': try
         with Partie do
           if Phase = phtVenteEvt then
             Phase := PhaseSvt; // On revient à l'action précédente
       except
       end{try};
  's',
  'S': try
         with Partie do
           if Phase = phtVenteEvt then
             begin
             EvtAVendreSvt;
             VenteEvenements; // Pour rafraîchir le message
             end;
       except
       end{try};
  'v',
  'V': try
         with Partie do
           if Phase = phtVenteEvt then
             begin
             VendEvenement(VenteUnitaire);
             if NbEvenements(JrCrt)>0 then
               begin
               EvtAVendreSvt;
               VenteEvenements; // Pour rafraîchir le message
               end
             else // Il n'y a plus rien à vendre, on sort automatiquement
               Phase := PhaseSvt; // On revient à l'action précédente
             end;
       except
       end{try};
end{case of};
end{procedure TFormPlateau.FormKeyPress};

procedure TFormPlateau.FormPaint(Sender: TObject);
var x, y  : TCoordonnee;
    j     : TJoueurId;
    te    : TTypeEvt;
    c     : TCouleur;
    JptOK,
    DesOK,
    PtsOK,
    MsgOK,
    BlnOK,
    EvtOK : Boolean;
begin
// On ne rafraîchit qu'une fois les parties multicases hors parcours
JptOK := False; // Jackpot
DesOK := False; // Lancer de dés
PtsOK := False; // Score des joueurs
MsgOK := False; // Message
BlnOK := False; // Bilan du tour
EvtOK := False; // Situation des evt

for x := Canvas.ClipRect.Left div (TailleCase+1) to Canvas.ClipRect.Right div (TailleCase+1) do
  for y := Canvas.ClipRect.Top div (TailleCase+1) to Canvas.ClipRect.Bottom div (TailleCase+1) do
    if TypeCase[x, y] > tcIndefini then
      begin
      try
        Partie.DessineCase(x, y)
      except
        DessineCase(jIndefini, x, y, dpAucune);
      end{try}
      end
    else // Affichage Infos : Scores, Jackpot et dés (une seule fois par appel à FormPaint)
      if (TJoueurId(TimerParcours.Tag) = jIndefini) then // Mode Parcours d'un joueur (Ctrl+1-6) : on n'affiche que les cases (dirposs et pion)
        begin
        if not PtsOK and // Affichage des scores
           (x>=7) and (x<=11) and
           (y>=1) and (y<= 3) then
          begin
          try // Partie doit être défini
            Partie.DessineScores;
          except
            for j := Succ(Low(TJoueurId)) to Pred(High(TJoueurId)) do
              DessineScore(j, Ord(j), 0, False, False, False);
          end{try};
          PtsOK:=true;
          end;
        if not JptOK and // Affichage du jackpot
           (x>=9) and (x<=11) and
           (y>=9) and (y<=11) then
          begin
          try // Partie doit être défini
            Partie.DessineJackpot;
          except
            DessineJackpot(0, 0, jIndefini);
          end{try};
          JptOK:=true;
          end;
        if not DesOK and // Affichage des dés
           (x>=9) and (x<=11) and
           (y>=6) and (y<=6) then
          begin
          try
            Partie.DessineLanceDes;
          except
            DessineLanceDes(jIndefini, [dIndefini, dIndefini]);
          end{try};
          DesOK:=true;
          end;
        if not MsgOK and // Affichage du message
           (x>=5) and (x<=7) and
           (y>=7) and (y<=11) then
          begin
          DessineMessage;
          MsgOK:=true;
          end;
        if not BlnOK and // Affichage du bilan
           (x>=1) and (x<=5) and
           (y>=1) and (y<=5) then
          begin
          DessineSelonTypeAffichage;
          BlnOK := true;
          end;
        if not EvtOK and // Affichage des evts then
           (x>=1) and (x<=3) and
           (y>=7) and (y<=11) then
          begin
          try
            Partie.DessineEvenements;
          except
            for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
              DessineEvenement(te, jIndefini, jIndefini);
            for c := Succ(Low(TCouleur)) to Pred(High(TCouleur)) do
              DessineCompteurEvt(c);  
          end;
          end;
        end;
end{procedure TFormPlateau.FormPaint};

procedure TFormPlateau.MenuItemAProposClick(Sender: TObject);
begin
FormAPropos:=TFormAPropos.Create(self);
with FormAPropos do
  try
    ShowModal;
  finally
    Release
  end;
end;

procedure TFormPlateau.MenuItemPartieDemoClick(Sender: TObject);
begin
try
  try
    FreeAndNil(Partie)
  except
  end;
finally
  Partie := TPartie.Create(High(TNbJoueurs), [False, True, True, True, True, True, True]);
  DemarrePartie;
end;
end;

procedure TFormPlateau.MenuItemEvenementsClick(Sender: TObject);
begin
FormEvtDes:=TFormEvtDes.Create(self);
with FormEvtDes do
  try
    ShowModal;
  finally
    Release;
  end;
end;

procedure TFormPlateau.MenuItemRegleClick(Sender: TObject);
var OptionRegle : TOptionRegle;
begin
OptionRegle := TOptionRegle((Sender as TMenuItem).Tag);
if not (OptionRegle in OptionsRegle) then
  Include(OptionsRegle, OptionRegle);
end;

procedure TFormPlateau.MenuItemFormatStatsClick(Sender: TObject);
begin
// 1. On efface la zone
with Canvas do
  begin
  Brush.Color:=clBlack;
  FillRect(TRect.Create(1*(TailleCase+1)-1, 1*(TailleCase+1),
                        6*(TailleCase+1), 6*(TailleCase+1)+1));
  end;
// 2. On affecte la propriété
FormatStats := TFormatStats((Sender as TMenuItem).Tag);
// 3. On rafraîchit la zone
DessineSelonTypeAffichage;
end;

procedure TFormPlateau.MenuItemParcoursClick(Sender: TObject);
begin
with TimerParcours do
  begin
  if Enabled then Enabled:=False;
  Tag := (Sender as TMenuITem).Tag;
  Enabled := True;
  end;
Refresh;
end;

procedure TFormPlateau.MenuItemPartieAbandonClick(Sender: TObject);
begin // v1.0.1 : mise en commun des messages de confirmation
if Application.MessageBox(pWideChar(Format(stConfEVSDV, ['', 'abandonner la partie'])), pWideChar(stConfirmation), MB_ICONEXCLAMATION + MB_YESNO) = IDYES then
  try
    try
      FreeAndNil(Partie);
    except
    end;
  finally
    Partie := TPartie.Create(High(TNbJoueurs), [False, False, False, False, False, False, False]);
    Refresh;
    StatusBar.SimpleText := 'Partie abandonnée.';
  end;
end;

procedure TFormPlateau.MenuItemPartieNouvelleClick(Sender: TObject);
begin
FormNvPartie := TFormNvPartie.Create(self);
try
  if FormNvPartie.ShowModal = mrOK then
    DemarrePartie;
finally
  FormNvPartie.Release
end;
end;

procedure TFormPlateau.MenuItemPartiePauseClick(Sender: TObject);
begin
try
  with Partie do
    Etat := epPause;
except
end;
end;

procedure TFormPlateau.MenuItemPartieRepriseClick(Sender: TObject);
begin
try
  Partie.Etat := epEnCours;
except
end;
end;

procedure TFormPlateau.MenuItemPoliceClick(Sender: TObject);
begin
FontDialog.Font.Name := Self.Font.Name;
if FontDialog.Execute then
  Self.Font.Name := FontDialog.Font.Name;
end;

procedure TFormPlateau.MenuItemTypeAffichageClick(Sender: TObject);
begin
// 1. On efface la zone
with Canvas do
  begin
  Brush.Color:=clBlack;
  FillRect(TRect.Create(1*(TailleCase+1)-1, 1*(TailleCase+1),
                        6*(TailleCase+1), 6*(TailleCase+1)+1));
  end;
// 2. On affecte la propriété
TypeAffichage := TTypeAffichage((Sender as TMenuItem).Tag);
// 3. On rafraîchit la zone
DessineSelonTypeAffichage;
end;

procedure TFormPlateau.MenuItemVitesseClick(Sender: TObject);
begin
TimerPion.Interval := (Sender as TMenuItem).Tag;
TimerAutomate.Interval := 5 * TimerPion.Interval;
TimerClignotement.Interval := TimerAutomate.Interval div 2;
end;

procedure TFormPlateau.TimerAutomateTimer(Sender: TObject);
begin
try
  with Partie do
    begin
    if Etat = epPause then
      begin
      TimerAutomate.Enabled := False;
      Reprise := rjAutomate;
      Exit;
      end
    else
      if Reprise = rjAutomate then
        Reprise := rjIndefinie;
    if (Phase = phtActionDes) or (Phase = phtVenteEvt) then
      begin
      TimerAutomate.Enabled := False;
      Phase := PhaseSvt;
      end;
    end;
except
end{try};
end{procedure TFormPlateau.TimerAutomateTimer};

procedure TFormPlateau.TimerClignotementTimer(Sender: TObject);
begin
TimerClignotement.Tag := 1 - TimerClignotement.Tag;
with Partie do
  DessineCase(Jr[JrCrt].Pion.x, Jr[JrCrt].Pion.y);
end{procedure TFormPlateau.TimerClignotementTimer};

procedure TFormPlateau.TimerDesTimer(Sender: TObject);
var d : TNumDe;
begin
try
  with Partie do
    begin
    if Etat = epPause then
      begin
      TimerAutomate.Enabled := False;
      Reprise := rjDes;
      Exit;
      end
    else
      if Reprise = rjDes then
        Reprise := rjIndefinie;
    if not Jr[JrCrt].Automate or (TimerDes.Tag > 0) then
      begin // On change les dés
      for d := Low(TNumDe) to High(TNumDe) do
        De[d] := TDe(1 + Random(Ord(High(TDe))));
      DessineLanceDes;
      if TimerDes.Tag > 0 then
        TimerDes.Tag := TimerDes.Tag - 1;
      end
    else // On arrête les dés pour l'automate et on déplace le pion
      begin
      TimerDes.Enabled := False;
      Jr[JrCrt].Pion.CAP := Ord(De[PrmDe]) + Ord(De[DrnDe]); // Nb cases à parcourir = total des dés
      Phase := phtDepltPion;
      end
    end;
except
end{try};
end{procedure TFormPlateau.TimerDesTimer};

procedure TFormPlateau.TimerLancementTimer(Sender: TObject);
begin
TimerLancement.Enabled := False;
FormAPropos:=TFormAPropos.Create(self);
with FormAPropos do
  try
    TimerLancement.Enabled := True;
    ShowModal;
  finally
    Release
  end;
end{procedure TFormPlateau.TimerLancementTimer};

procedure TFormPlateau.TimerParcoursTimer(Sender: TObject);
begin
TimerParcours.Tag := 0;
Refresh;
TimerParcours.Enabled:=False;
end{procedure TFormPlateau.TimerParcoursTimer};

procedure TFormPlateau.TimerPionTimer(Sender: TObject);
begin
try
  with Partie do
    begin
    if Etat = epPause then
      begin
      TimerAutomate.Enabled := False;
      Reprise := rjPion;
      Exit;
      end
    else
      if Reprise = rjPion then
        Reprise := rjIndefinie;
    if Jr[JrCrt].Pion.CAP>0 then // Si le pion n'est pas encore arrivé
      begin
      if Jr[JrCrt].Pion.Dir > dIndefinie then // 1. On a déjà une direction...
        AvancePion
      else // Sinon on doit la déterminer...
        begin
        if (NbDirPoss[DirPossJr[JrCrt, Jr[JrCrt].Pion.x, Jr[JrCrt].Pion.y]]=1) or // 2. Si une seule direction possible OU
           Jr[JrCrt].Automate then // Automate ALORS
          begin  // 2&. On peut choisir la direction et continuer
          ChoisitDirection;
          AvancePion;
          end
        else // SINON 2b. On demande de choisir en appuyant sur la touche fléchée correspondant à la direction
          begin
          TimerPion.Enabled := False;
          Phase := phtChxDirPion;
          end
        end
      end
    else
      begin
      TimerPion.Enabled := False;
      Phase := phtActionDes;
      end
    end;
except
end{try};
end{procedure TFormPlateau.TimerPionTimer};

// -----------------------
// méthodes personnalisées
// -----------------------

procedure TFormPlateau.DemarrePartie;
begin
with FormPlateau do
  begin
  Canvas.Brush.Color:=clBlack;
  // On efface la zone de score
  Canvas.FillRect(TRect.Create( 7*(TailleCase + 1), 1*(TailleCase + 1),
                               12*(TailleCase + 1), 4*(TailleCase + 1)));
  // On efface la zone de bilan
  Canvas.FillRect(TRect.Create(1*(TailleCase+1)-1, 1*(TailleCase+1),
                               6*(TailleCase+1), 6*(TailleCase+1)+1));
  // On efface la zone des événements
  Canvas.FillRect(TRect.Create(1*(TailleCase + 1),  7*(TailleCase + 1),
                               4*(TailleCase + 1), 12*(TailleCase + 1)));
  with Partie do
    begin
    DessineEvenements; // On redessine une seule fois tous les événements
    Demarre; // L'instance Partie a été créée : on démarre le jeu
    end;
  end
end{procedure TFormPlateau.DemarrePartie};

procedure TFormPlateau.LitParametres;
var IniFile     : TIniFile;
    ta          : TTypeAffichage;
    fs          : TFormatStats;
    i, eor      : Integer;
    nr          : TNumRegle;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni);
try
  // 1. Police (Impact par défaut)
  Font.Name := IniFile.ReadString(stSectionOptions, stEntreePolice, 'Impact');

  // 2. Vitesse (Moyenne par défaut)
  TimerPion.Interval := IniFile.ReadInteger(stSectionOptions, stEntreeVitesse, MenuItemVitesseMoyenne.Tag);
  TimerAutomate.Interval := 5 * TimerPion.Interval;
  TimerClignotement.Interval := TimerAutomate.Interval div 2;

  // 3. Règle du jeu (élément orEvtJckptAcht activé uniquement)
  OptionsRegle := []; // Défini dans les événements OnClick des rubriques de menu
  eor := IniFile.ReadInteger(stSectionOptions, stEntreeRegle, Ord(orEvtJckptAcht));
  for nr := Low(TNumRegle) to High(TNumRegle) do
    begin
    if (Ord(NumRegle[nr]) and eor) = Ord(NumRegle[nr]) then
      case NumRegle[nr] of
        orEvtJckptAcht: begin
                        MenuItemRegleEvtJackpotAchat.Checked := True;
                        MenuItemRegleClick(MenuItemRegleEvtJackpotAchat);
                        end;
        orEvtJckptVnte: begin
                        MenuItemRegleEvtJackpotVente.Checked := True;
                        MenuItemRegleClick(MenuItemRegleEvtJackpotVente);
                        end;
        orEvtJckptLiqd: begin
                        MenuItemRegleEvtJackpotLiquidation.Checked := True;
                        MenuItemRegleClick(MenuItemRegleEvtJackpotLiquidation);
                        end;
      end;
    end;

  // 4. Type d'affichage en haut à gauche du plateau (Bilan Tour par défaut)
  ta := TTypeAffichage(IniFile.ReadInteger(stSectionAffichage, stEntreeStats, Ord(taBilanTour))); // Bilan tour par défaut
  // On rafraîchit le menu des options
  case ta of // On affecte TypeAffichage depuis l'événement du menu
    taBilanTour: begin
                 MenuItemBilanTour.Checked := True;
                 MenuItemTypeAffichageClick(MenuItemBilanTour);
                 end;
    taEvolution: begin
                 MenuItemEvolution.Checked := True;
                 MenuItemTypeAffichageClick(MenuItemEvolution);
                 end;
    taStatsEvts: begin
                 MenuItemStatsEvts.Checked := True;
                 MenuItemTypeAffichageClick(MenuItemStatsEvts);
                 end;
    taStatsDes:  begin
                 MenuItemStatsDes.Checked := True;
                 MenuItemTypeAffichageClick(MenuItemStatsDes);
                 end;
  end{case of};

  // 5. Type d'affichage en haut à gauche du plateau (Bilan Tour par défaut)
  fs := TFormatStats(IniFile.ReadInteger(stSectionOptions, stEntreeFormat, Ord(fsPourcent))); // Format % par défaut
  // On rafraîchit le menu des options
  case fs of
    fsPourcent: begin
                MenuItemFormatStatsPourcents.Checked := True;
                MenuItemFormatStatsClick(MenuItemFormatStatsPourcents);
                end;
    fsScore:    begin
                MenuItemFormatStatsScore.Checked := True;
                MenuItemFormatStatsClick(MenuItemFormatStatsScore);
                end;
  end{case of};

  // 6. Dimensions de la fenêtre
  Width := IniFile.ReadInteger(stSectionAffichage, stEntreeLargeur, Width);
  Height := IniFile.ReadInteger(stSectionAffichage, stEntreeHauteur, Height);
  TailleCase := IniFile.ReadInteger(stSectionAffichage, stEntreeTaille, TailleCase);

  // On rafraîchit le menu des options (vitesse)
  for i:= 0 to MenuItemVitesse.Count - 1 do
    with MenuItemVitesse.Items[i] do
      Checked := (Tag = TimerPion.Interval)
finally
  FreeAndNil(IniFile);
end{try}
end{procedure TFormPlateau.LitParametres};

procedure TFormPlateau.EcritParametres;
var IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni);
try
  // 1. Options
  IniFile.WriteString(stSectionOptions, stEntreePolice, Font.Name);
  IniFile.WriteInteger(stSectionOptions, stEntreeVitesse, TimerPion.Interval);
  IniFile.WriteInteger(stSectionOptions, stEntreeRegle, DonneOptionsRegle);
  // 2. Affichage
  IniFile.WriteInteger(stSectionAffichage, stEntreeStats, Ord(TypeAffichage));
  IniFile.WriteInteger(stSectionAffichage, stEntreeFormat, Ord(FormatStats));
  IniFile.WriteInteger(stSectionAffichage, stEntreeLargeur, DrnLargeur);
  IniFile.WriteInteger(stSectionAffichage, stEntreeHauteur, DrnHauteur);
  IniFile.WriteInteger(stSectionAffichage, stEntreeTaille, DrnTaille);

finally
  FreeAndNil(IniFile);
end{try}
end{procedure TFormPlateau.EcritParametres};

procedure TFormPlateau.Aide1Click(Sender: TObject);
begin
ShellExecute(0, 'Open', pChar(ExtractFilePath(Application.ExeName)+'\html\index.html'), '', '', SW_SHOWNORMAL);
end;

procedure TFormPlateau.ChangeAccesRegle(MenuItem : TMenuItem; Activer : Boolean);
var i : Integer;
begin
if (MenuItem.Count > 0) then
  for i := 0 to MenuItem.Count - 1 do
    ChangeAccesRegle(MenuItem.Items[i], Activer)
else
  MenuItem.Enabled := Activer;
end{procedure TFormPlateau.ChangeAccesRegle};

function TFormPlateau.DonneOptionsRegle : Integer;
var OptionRegle : TOptionRegle;
begin
Result := 0;
for OptionRegle := Low(TOptionRegle) to High(TOptionRegle) do
  Inc(Result, Ord(OptionRegle) * Ord(OptionRegle in OptionsRegle));
end;

procedure TFormPlateau.DefinitMessage(stNvMessage : String); // Exécuté en affectant la property stMesssage
begin
FMessage := stNvMessage;
DessineMessage;
end{TFormPlateau.DefinitMessage};

procedure TFormPlateau.DessineMessage; // Exécuté en affectant la property stMesssage
const stVide = '';
      stCR = #13;
      stCL = '#';
var HauteurMsg,
    LargeurMsg,
    x0Msg, y0Msg,
    HauteurMax,
    LargeurMax,
    x0Min, y0Min,
    Taille,
    l, g,
    tth, th, tw,
    x, y         : Integer;
    stMsgBrut,
    stTexte      : String;
    stLigne,
    stLgnBrute,
    stGrpColore  : TStringDynArray;

// Le texte filtré sans les indicateurs de couleur permet de calculer la taille idéale de la police
procedure FiltreMessage; // Retire les balises
var a : TApplCoul;
    c : TCouleur;
begin
stMsgBrut := stMessage;
for a := Low(TApplCoul) to High(TApplCoul) do
  for c := Low(TCouleur) to High(TCouleur) do
    stMsgBrut := ReplaceStr(stMsgBrut, stCL+stClMsg[a, c], stVide);
end{procedure FiltreMessage};

// Détermine la taille idéale pour une ligne de message
procedure CalculeTaillePolice(Ligne : Integer);
var tw : Integer;
begin
if stLgnBrute[Ligne]<>'' then
  begin
  if Taille = 0 then // Si jamais testée, on part de 1 et on incrémente
    begin
    Canvas.Font.Size := 1;
    tw:=Canvas.TextWidth(stLgnBrute[Ligne]);
    while (tw < LargeurMsg) do
      begin
      Canvas.Font.Size := Canvas.Font.Size + 1;
      tw:=Canvas.TextWidth(stLgnBrute[Ligne]);
      end;
    Taille := Canvas.Font.Size - 1; // On décrémente car Canvas.Font.Size dépasse Largeur
    end
  else // Sinon on part de Taille et on décrémente
    begin
    Canvas.Font.Size := Taille;
    tw:=Canvas.TextWidth(stLgnBrute[Ligne]);
    while (tw > LargeurMsg) do
      begin
      Canvas.Font.Size := Canvas.Font.Size - 1;
      tw:=Canvas.TextWidth(stLgnBrute[Ligne]);
      end
    end;
    Taille := Canvas.Font.Size;
  end
end{function TaillePolice};

function TexteAEnrichir(stTexte : String) : String;
var a         : TApplCoul;
    c         : TCouleur;
    stTxtBrut : String;
    bmCase    : TBitmap;
begin
stTxtBrut := stTexte.Substring(1, stTexte.Length-1);
if stTxtBrut.Length>0 then
  begin
  th := Canvas.TextHeight(stTxtBrut);
  tw := Canvas.TextWidth(stTxtBrut);
  end;
if stTexte[1]<='z' then
  begin // 1. Couleur à appliquer
  for a := Low(TApplCoul) to High(TApplCoul) do
    for c := Low(TCouleur) to High(TCouleur) do
      if stTexte[1] = stClMsg[a, c] then
        if a = acTexte then
          Canvas.Font.Color := Couleur[c]
        else
          begin
          Canvas.Brush.Color := Couleur[c];
          if (stTxtBrut.Length>0) and (c<>cNoir) then
            Canvas.FillRect(TRect.create(x, y, x+tw, y+th));
          end;
  end
else
  begin // 2. Case à afficher
  bmCase := TBitmap.Create;
  VirtualImageListCases.GetBitmap(Ord(stTexte[1]) - Ord('z') - 1, bmCase);
  Canvas.StretchDraw(TRect.Create(x, y, x+th-1, y+th-1), bmCase);
  FreeAndNil(bmCase);
  Inc(x, th); // La case est de même dimension que la hauteur des caractères de la police
  end;
Result := stTxtBrut;
end{function TexteAEnrichir};

begin{procedure TFormPlateau.DessineMessage}

// 1. Dimensions de l'espace
LargeurMax := 3*(TailleCase+1);
HauteurMax := 5*(TailleCase+1);
x0Min := 5*(TailleCase+1);
y0Min := 7*(TailleCase+1);

LargeurMsg := Trunc(2.8125*(TailleCase+1)); // On retire 1/32 de marge de part et d'autre soit une largeur de 3*(15/16)*(TailleCase+1)
HauteurMsg := HauteurMax;
x0Msg := x0Min + Trunc(0.09375*(TailleCase+1)); // On ajoute 1/32 de marge à gauche soit 3*(1/32)*(TailleCase+1)
y0Msg := y0Min;

// 2. On efface la zone
Canvas.Brush.Color:=clBlack;
Canvas.FillRect(TRect.Create(x0Min,              y0Min,
                             x0Min + LargeurMax, y0Min + HauteurMax));

if stMessage = '' then Exit;

// 2. Extraction du message brut pour calcul de l'espace et de la taille de la police
FiltreMessage;
stLigne := SplitString(stMessage, stCR);
stLgnBrute := SplitString(stMsgBrut, stCR);

Canvas.Font.Color := clWhite; // blanc par défaut

// 3a. On calcule la taille idéale de la police...
Taille:=0;
for l:= 0 to Length(stLgnBrute)-1 do
  CalculeTaillePolice(l);
Canvas.Font.Size:=Taille;

// 3b. Puis la hauteur totale pour centrer le texte
tth := 0;
for l:=0 to Length(stLgnBrute)-1 do
  Inc(tth, Canvas.TextHeight(stLgnBrute[l]));
Inc(y0Msg, (HauteurMsg - tth) div 2);

x := x0Msg; y := y0Msg;

// 4. Affichage du texte
for l := 0 to Length(stLigne)-1 do
  begin
  th := Canvas.TextHeight(stLgnBrute[l]);
  stGrpColore := SplitString(stLigne[l], stCL);
  Inc(x, (LargeurMsg - Canvas.TextWidth(stLgnBrute[l])) div 2);
  for g := 0 to Length(stGrpColore)-1 do
    if stGrpColore[g].Length>0 then
      begin
      if g = 0 then
        stTexte := stGrpColore[g]
      else
        stTexte := TexteAEnrichir(stGrpColore[g]);
      if stTexte.Length>0 then
        begin
        Canvas.TextOut(x, y, stTexte);
        Inc(x, Canvas.TextWidth(stTexte));
        end
      end;
  Inc(y, th);
  x := x0Msg;
  end;
end{procedure TFormPlateau.DessineMessage};

function TFormPlateau.RectCase(x : TCoordonnee; y : TCoordonnee) : TRect;
begin
Result:=TRect.Create((x+0)*(TailleCase+1)+1, (y+0)*(TailleCase+1)+1,
                     (x+1)*(TailleCase+1)-1, (y+1)*(TailleCase+1)-1);
end{function TFormPlateau.RectCase};

procedure TFormPlateau.DessineCase(ProprioId : TJoueurId; x : TCoordonnee; y : TCoordonnee; DirPoss : TDirPoss);
var bmCase   : TBitMap;
    j        : TJoueurId;
    NbjCase,
    xj, yj   : TCoordonnee;
    dp       : TDirPoss;
begin
if (TypeCase[x, y]>tcIndefini) then
  begin

  bmCase:=TBitMap.Create;

  // 0a. Détermination si affichage du parcours d'un joueur demandé OU du choix d'une direction à prendre (joueur humain)
  dp := dpAucune; j := jIndefini;
  if (TJoueurId(TimerParcours.Tag) > jIndefini) then // Mode affichage du parcours d'un joueur (Ctrl+1-6) : Ne passe pas par l'argument DirPoss car le plateau est rafraîchi !
    begin
    j := TJoueurId(TimerParcours.Tag);
    dp := DirPossJr[j, x, y];
    end;
  if DirPoss > dpAucune then
    begin
    j := Partie.JrCrt;
    dp := DirPoss;
    end;
  if dp > dpAucune then
    begin
    VirtualImageListFonds.GetBitmap(Ord(cNoir), bmCase);
    if (TJoueurId(TimerParcours.Tag) > jIndefini) and
       (Partie.Jr[j].Pion.x = x) and (Partie.Jr[j].Pion.y = y) then
      VirtualImageListJoueurs.GetBitmap(Ord(j)-1, bmCase) // 0b. Mode affichage du parcours (Ctrl+1-6) : Affichage du pion sur toute la case le cas échéant
    else // OU 0b. Affichage des directions possibles
      if (DirPoss = dpAucune) or (Partie.Jr[j].Pion.x <> x) or (Partie.Jr[j].Pion.y <> y) or not TimerClignotement.Enabled or (TimerClignotement.Tag <> 0) then // Condition de clignotement
        VirtualImageListDirPoss.GetBitmap((NbMaxCouleurs - 2) * (NumBmDp[dp] - 1) + Ord(j), bmCase); // Couleur du jackpot + Gris en moins soit 6 (joueurs) + 2 (N&B)
    end
  else
    begin
    // 1. Case avec fond joueur le cas échéant (ProprioId)
    if (TypeCase[x, y]=tcDepart) then // Fond noir pour la case départ
      VirtualImageListFonds.GetBitmap(Ord(cNoir), bmCase)
    else
      if ProprioId>jIndefini then
        VirtualImageListFonds.GetBitmap(Ord(ProprioId), bmCase);
    VirtualImageListCases.GetBitmap(Ord(TypeCase[x, y])-1, bmCase);

    // 2. Pion le cas échéant (partie en cours)

    with Partie do
      if JrCrt > jIndefini then
        begin
        xj := Jr[JrCrt].Pion.x;
        yj := Jr[JrCrt].Pion.y;
        end
      else
        begin // Hors case arbitrairement
        xj := 1;
        yj := 1;
        end;

    if (xj <> x) or (yj <> y) or not TimerClignotement.Enabled or (TimerClignotement.Tag <> 0) then // Condition de clignotement pion joueur courant
      begin
      NbjCase:=0;
      // 2a. On compte les joueurs sur la case
      for j := Succ(Low(TJoueurId)) to TJoueurId(Partie.Nbj) do
        if not Partie.Jr[j].Elimine and (Partie.Jr[j].Pion.x = x) and (Partie.Jr[j].Pion.y = y) then
          Inc(NbjCase);
      // 2b. On ajoute soit le pion (plusieurs joueurs sur la case), soit le joueur (1 seul joueur sur la case)
      for j := Succ(Low(TJoueurId)) to TJoueurId(Partie.Nbj) do
        if not Partie.Jr[j].Elimine and (Partie.Jr[j].Pion.x = x) and (Partie.Jr[j].Pion.y = y) then
          if NbjCase>1 then
            VirtualImageListPions.GetBitmap(Ord(j)-1, bmCase) // On affiche le pion sur 1/6 de la case
          else
            VirtualImageListJoueurs.GetBitmap(Ord(j)-1, bmCase); // On affiche le pion sur toute la case
      end
    end;
  // 3. On dessine
  Canvas.StretchDraw(RectCase(x,y), bmCase);

  FreeAndNil(bmCase);

  end;
end{procedure TFormPlateau.DessineCase};

procedure TFormPlateau.DessineScore(Id : TJoueurId; Pos, Score : Integer; JrCrt, Automate, Elimine : Boolean);
const x = 7;
      y = 1;
var Chf     : Integer;
    c       : TNumChfScr;
    bmScr   : TBitmap;
begin
if Elimine then
  Score := 0;
// 1. Position dans le classement + Joueur courant
bmScr := TBitmap.Create;
VirtualImageListFonds.GetBitmap(IfThen(JrCrt,Ord(Id),Ord(cNoir)), bmScr); // Fond noir ou couleur si joueur courant ou gris si éliminé
VirtualImageListChiffres.GetBitmap(Pos * NbMaxCouleurs + IfThen(Elimine, Ord(cGris), IfThen(JrCrt,Ord(cNoir),Ord(Id))), bmScr); // Position en noir si joueur courant sinon couleur du joueur ou gris si éliminé
Canvas.StretchDraw(TRect.Create(Round((x+0.0)*(TailleCase+1))+1, Round((y+0.5*(Ord(Id)-1)+0.0)*(TailleCase+1))+1,
                                Round((x+0.5)*(TailleCase+1))-1, Round((y+0.5*(Ord(Id)-1)+0.5)*(TailleCase+1))-1),
                   bmScr);
FreeAndNil(bmScr);

// 2. Affichage du symbole (fruit)
bmScr := TBitmap.Create;
VirtualImageListFonds.GetBitmap(Ord(cNoir), bmScr); // Fond noir
VirtualImageListJoueurs.GetBitmap(Ord(Id)-1, bmScr); // Symbole du joueur
Canvas.StretchDraw(TRect.Create(Round((x+0.5)*(TailleCase+1))+1, Round((y+0.5*(Ord(Id)-1)+0.0)*(TailleCase+1))+1,
                                Round((x+1.0)*(TailleCase+1))-1, Round((y+0.5*(Ord(Id)-1)+0.5)*(TailleCase+1))-1),
                   bmScr);
FreeAndNil(bmScr);

// 3. Affichage du score
for c := Low(TNumChfScr) to High(TNumChfScr) do
  begin
  bmScr:=TBitmap.Create;
  Chf:=(Score div Puiss10[High(TNumChfScr)-c]) mod 10;
  VirtualImageListFonds.GetBitmap(IfThen(JrCrt,Ord(Id),Ord(cNoir)), bmScr); // Fond noir ou couleur si joueur courant  ou gris si éliminé
  VirtualImageListChiffres.GetBitmap(Chf * NbMaxCouleurs + IfThen(Elimine, Ord(cGris), IfThen(JrCrt,Ord(cNoir),Ord(Id))), bmScr); // Position en noir si joueur courant sinon couleur du joueur ou gris si éliminé
  Canvas.StretchDraw(TRect.Create(Round((x+1.25+0.5*c+0.0)*(TailleCase+1)), Round((y+0.5*(Ord(Id)-1)+0.0)*(TailleCase+1))+1,
                                  Round((x+1.25+0.5*c+0.5)*(TailleCase+1)), Round((y+0.5*(Ord(Id)-1)+0.5)*(TailleCase+1))-1),
                     bmScr);
  FreeAndNil(bmScr);
  end;

 // 4. Affichage du type de joueur (humain/automate)
bmScr := TBitmap.Create;
VirtualImageListFonds.GetBitmap(IfThen(Elimine, Ord(cGris), Ord(Id)), bmScr);
VirtualImageListTypes.GetBitmap(Ord(Automate), bmScr);
Canvas.StretchDraw(TRect.Create(Round((x+4.5)*(TailleCase+1))+1, Round((y+0.5*(Ord(Id)-1)+0.0)*(TailleCase+1))+1,
                                Round((x+5.0)*(TailleCase+1))-1, Round((y+0.5*(Ord(Id)-1)+0.5)*(TailleCase+1))-1),
                   bmScr);
FreeAndNil(bmScr);
end{procedure TFormPlateau.DessineScore};

procedure TFormPlateau.DessineJackpot(Score, DrnSc : Integer; DrnJr : TJoueurId);
const xc = 9; yc = 10;
      xd = 9; xf = 11;
      yd = 9; yf = 9;
var Chf   : Integer;
    c     : TNumChfScr;
    bmJpt : TBitmap;
begin
// 1. Affichage JACKPOT (en haut)
bmJpt := TBitmap.Create;
VirtualImageListJackpot.GetBitmap(0, bmJpt); // Fond noir
VirtualImageListJackpot.GetBitmap(1, bmJpt); // Jackpot
Canvas.StretchDraw(TRect.Create(Round((xd+0)*(TailleCase+1))+1, Round((yd+0)*(TailleCase+1))+1,
                                Round((xf+1)*(TailleCase+1))-1, Round((yf+1)*(TailleCase+1))-1),
                   bmJpt);
FreeAndNil(bmJpt);

// 2. Affichage du score du jackpot en cours
for c := Low(TNumChfScr) to High(TNumChfScr) do
  begin
  bmJpt:=TBitmap.Create;
  Chf:=(Score div Puiss10[High(TNumChfScr)-c]) mod 10;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmJpt);
  VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+Ord(cPourpre), bmJpt);
  Canvas.StretchDraw(TRect.Create(Round((xc+0.5*c+0.0)*(TailleCase+1)), Round((yc+0)*(TailleCase+1))+1,
                                  Round((xc+0.5*c+0.5)*(TailleCase+1)), Round((yc+1)*(TailleCase+1))-1),
                     bmJpt);
  FreeAndNil(bmJpt);
  end;

// 3. Affichage du dernier jackpot remporté avec la couleur du joueur l'ayant remporté
if DrnJr > jIndefini then
  for c := Low(TNumChfScr) to High(TNumChfScr) do
    begin
    bmJpt:=TBitmap.Create;
    Chf:=(DrnSc div Puiss10[High(TNumChfScr)-c]) mod 10;
    VirtualImageListFonds.GetBitmap(Ord(cNoir), bmJpt);
    VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+Ord(DrnJr), bmJpt);
    Canvas.StretchDraw(TRect.Create(Round((xc+0.5*c+0.0)*(TailleCase+1)), Round((yc+1)*(TailleCase+1))+1,
                                    Round((xc+0.5*c+0.5)*(TailleCase+1)), Round((yc+2)*(TailleCase+1))-1),
                       bmJpt);
    FreeAndNil(bmJpt);
    end;
end{procedure TFormPlateau.DessineJackpot};

procedure TFormPlateau.DessineLanceDes(Id : TJoueurId; De : array of TDe);
const xd : array [TNumDe] of Double = (9.5,10.5);
      yd : array [TNumDe] of Double = (6.0, 6.0);
var d      : TNumDe;
    bmDe   : array [TNumDe] of TBitmap;
begin
for d := Low(TNumDe) to High(TNumDe) do
  begin
  // 1. Fond du joueur courant
  bmDe[d]:=TBitmap.Create;
  VirtualImageListFonds.GetBitmap(0, bmDe[d]);
  VirtualImageListFondsDe.GetBitmap(Ord(Id), bmDe[d]);
  if De[d]>dIndefini then // Dé si défini
    begin
    VirtualImageListDes.GetBitmap(ord(De[d])-1, bmDe[d]);
    Canvas.StretchDraw(TRect.Create(Round((xd[d]+0)*(TailleCase+1))+1, Round((yd[d]+0)*(TailleCase+1))+1,
                                    Round((xd[d]+1)*(TailleCase+1))-1, Round((yd[d]+1)*(TailleCase+1))-1),
                       bmDe[d]);
    end;
  FreeAndNil(bmDe[d]);
  end;
end{procedure TFormPlateau.DessineLanceDes};

procedure TFormPlateau.DessineBilan(Tour : Integer);
const  stTour : String = 'Tour ';
var Largeur,
    Hauteur,
    tw, th,
    x, y,
    x0, y0,
    k, Chf,
    Marge,
    si, sj,
    pei,pej : Integer;
    Elimine : Boolean;
    sc      : TSensCpta;
    c       : TNumChfScr;
    Pos     : array [TJoueurId] of Integer;
    i, j    : TJoueurId;
    bmBln   : TBitmap;

procedure CalculeTaillePolice;
begin
Canvas.Font.Size := 1;
th:=Canvas.TextHeight(stTour);
while th<=TailleCase do
  begin
  Canvas.Font.Size := Canvas.Font.Size + 1;
  th:=Canvas.TextHeight(stTour);
  end;
Canvas.Font.Size := Canvas.Font.Size - 1;
end{function TaillePolice};

begin
Largeur := 5*(TailleCase+1);
Hauteur := 5*(TailleCase+1);
x0 := 1*(TailleCase+1);
y0 := 1*(TailleCase+1);
CalculeTaillePolice;

// 1. Information Tour
with Canvas do
  begin
  // 1a. On affiche "Tour"
  tw := TextWidth(stTour) + Round(1.5*(TailleCase+1)); // Tour + 3 chiffres (3*3/4)
  Marge := (Largeur - tw) div 2;
  x := x0 + Marge;
  y := y0 + Marge div 4;
  Font.Color := clWhite;
  TextOut(x, y, stTour);
  Inc(x, TextWidth(stTour));
  // 1b. On affiche le numéro du tour (3 chiffres)
  tw := Round(0.50*(TailleCase+1));
  th := Round(1.00*(TailleCase+1));
  for k := 0 to 2 do
    begin
    Chf := (Tour div Puiss10[2-k]) mod 10;
    bmBln := TBitmap.Create;
    VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
    VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+Ord(cBlanc), bmBln);
    StretchDraw(TRect.Create(x, y, x+tw-1, y+th-1), bmBln);
    Inc(x, tw);
    FreeAndNil(bmBln);
    end;
  end;

// 2. On calcule les positions
with Partie do
  for i := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
    begin
    Pos[i]:=0;
    si := ScoreTour(i, Tour);
    pei := Jr[i].PosElm;
    for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
      begin
      sj := ScoreTour(j, Tour);
      pej := Jr[j].PosElm;
      if (pej<pei) or                            // Positions d'éliminés
         ((pej=pei) and (si<sj)) or              // Scores
         ((pej=pei) and (si=sj) and (j<=i)) then // Tours de jeu
        Inc(Pos[i]);
      end;
    end;

// 3. On affiche le score de chaque joueur
Inc(y, Marge div 4 + th);
for j := Succ(Low(TJoueurId)) to TJoueurId(Partie.Nbj) do
  begin
  Elimine := Partie.Jr[j].Elimine;
  // 3a. on affiche la position dans la couleur du joueur
  x := x0;
  bmBln := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
  VirtualImageListChiffres.GetBitmap(Pos[j]*NbMaxCouleurs+IfThen(Elimine, Ord(cGris), Ord(j)), bmBln);
  Canvas.StretchDraw(TRect.Create(Round(x+0.000*(TailleCase+1))+1, Round(y+0.0*(TailleCase+1))+1,
                                  Round(x+0.375*(TailleCase+1))-1, Round(y+0.5*(TailleCase+1))-1), bmBln);
  FreeAndNil(bmBln);
  // 3b. on affiche le symbole du joueur
  bmBln := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
  VirtualImageListJoueurs.GetBitmap(Ord(j)-1, bmBln);
  Canvas.StretchDraw(TRect.Create(Round(x+0.375*(TailleCase+1))+1, Round(y+0.0*(TailleCase+1))+1,
                                  Round(x+0.875*(TailleCase+1))-1, Round(y+0.5*(TailleCase+1))-1), bmBln);
  FreeAndNil(bmBln);

  sj := IfThen(Elimine, 0, Partie.ScoreTour(j, Tour));

  // 3c. on affiche le signe du score (+/-)
  bmBln := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
  VirtualImageListSignes.GetBitmap(Ord(sj>=0)*NbMaxCouleurs+IfThen(Elimine, Ord(cGris), Ord(j)), bmBln);
  Canvas.StretchDraw(TRect.Create(Round(x+0.875*(TailleCase+1))+1, Round(y+0.0*(TailleCase+1))+1,
                                  Round(x+1.250*(TailleCase+1))-1, Round(y+0.5*(TailleCase+1))-1), bmBln);
  FreeAndNil(bmBln);

  // 3d. on affiche le score du tour
  for c := Low(TNumChfScr) to High(TNumChfScr) do
    begin
    Chf := (abs(sj) div Puiss10[Ord(High(TNumChfScr)-c)]) mod 10;
    bmBln := TBitmap.Create;
    VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
    VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+IfThen(Elimine, Ord(cGris), Ord(j)), bmBln);
    Canvas.StretchDraw(TRect.Create(Round(x+(1.250+0.375*c)*(TailleCase+1))+1, Round(y+0.0*(TailleCase+1))+1,
                                    Round(x+(1.625+0.375*c)*(TailleCase+1))-1, Round(y+0.5*(TailleCase+1))-1), bmBln);
    FreeAndNil(bmBln);
    end;

  // 3e. on affiche le crédit et le débit en dessous
  for sc := scCredit downto scDebit do
    begin
    // Signe + (crédit) ou - (débit)
    bmBln := TBitmap.Create;
    VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln); // Fond = couleur joueur
    VirtualImageListSignes.GetBitmap(Ord(sc)*NbMaxCouleurs+IfThen(Elimine, Ord(cGris), IfThen(sc=scDebit, Ord(cRouge), Ord(cVert))), bmBln); // Texte = Rouge (D) ou Vert (C)
    Canvas.StretchDraw(TRect.Create(Round(x+3.5*(TailleCase+1))+1, Round(y+(0.00+0.25*(1-Ord(sc)))*(TailleCase+1))+1,
                                    Round(x+3.7*(TailleCase+1))-1, Round(y+(0.25+0.25*(1-Ord(sc)))*(TailleCase+1))-1), bmBln);
    FreeAndNil(bmBln);

    sj := IfThen(Elimine, 0, IfThen(sc=scDebit, Partie.DebitTour(j, Tour), Partie.CreditTour(j, Tour)));
    for c := Low(TNumChfScr) to High(TNumChfScr) do
      begin
      Chf := (sj div Puiss10[Ord(High(TNumChfScr)-c)]) mod 10;
      bmBln := TBitmap.Create;
      VirtualImageListFonds.GetBitmap(Ord(cNoir), bmBln);
      VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+IfThen(Elimine, Ord(cGris), IfThen(sc=scDebit, Ord(cRouge), Ord(cVert))), bmBln);
      Canvas.StretchDraw(TRect.Create(Round(x+(3.7+0.2*c)*(TailleCase+1))+1, Round(y+(0.00+0.25*(1-Ord(sc)))*(TailleCase+1))+1,
                                      Round(x+(3.9+0.2*c)*(TailleCase+1))-1, Round(y+(0.25+0.25*(1-Ord(sc)))*(TailleCase+1))-1), bmBln);
      FreeAndNil(bmBln);
      end;
    end;
  Inc(y, Round(0.5*(TailleCase+1)));
  end;
end{procedure TFormPlateau.DessineBilan};

procedure TFormPlateau.DessineEvolution;
const
    PtScore : Integer = 10000;
    PtTour  : Integer = 1;

var Taille,
    ScoreMax,
    TourMax,
    x, y,
    x0, y0,
    t, s   : Integer;
    dx, dy : Double;
    j      : TJoueurId;
begin
if Partie.TrCrt = 0 then Exit;

// 0. On efface la zone
Canvas.Brush.Color:=clBlack;
Canvas.FillRect(TRect.Create(1*(TailleCase+1)-1, 1*(TailleCase+1),
                             6*(TailleCase+1), 6*(TailleCase+1)+1));

Taille := 5*(TailleCase+1);
x0 := 1*(TailleCase+1);
y0 := 1*(TailleCase+1);

// 1. Calcul des dimensions en abscisses (tours)
TourMax := Partie.TrCrt;
dx := (Taille-1)/TourMax;

// 2. Calcul des dimensions en ordonnées (scores)
ScoreMax := 0;
for t := 0 to TourMax do
  for j := Succ(Low(TJoueurId)) to (High(TJoueurId)) do
    if (j <= TJoueurId(Partie.Nbj)) or (j = jJackpot) then
      ScoreMax := max(Partie.Score(j, t), ScoreMax);
dy := (Taille-1)/ScoreMax;

// 4. Affichage des graphes par joueurs
with Canvas do
  begin
  Brush.Color := clWhite;
  // 3. Affichage du quadrillage par point (10 tours, 100000 pts)
  for t := 0 to TourMax div PtTour do
    for s := 0 to ScoreMax div PtScore do
      begin
      x := x0 + Round(dx*t*PtTour);
      y := y0 + Taille - Round(dy*s*PtScore);
      if (t mod 10)*(s mod 10) = 0 then
        FillRect(TRect.Create(x-1, y-1, x+1, y+1))
      else
        Pixels[x, y] := clWhite;
      end;
  Pen.Style := psSolid;
  Pen.Width := 1;
  for j := Succ(Low(TJoueurId)) to High(TJoueurId) do
    if (j <= TJoueurId(Partie.Nbj)) or (j = jJackpot) then
      begin
      Pen.Color := Couleur[TCouleur(j)];
      for t := 0 to TourMax do
        if t = 0 then
          MoveTo(x0 + Round(dx*t), y0 + Taille - Round(dy*Partie.Score(j, t)))
        else
          LineTo(x0 + Round(dx*t), y0 + Taille - Round(dy*Partie.Score(j, t)));
      end
  end
end{procedure TFormPlateau.DessineEvolution};

procedure TFormPlateau.DessineStatsEvts;
const Colonnes : Integer = 4;
      Lignes   : Integer = 7;
      stStats    : array [TFormatStats] of String = ('Stats en %','Stats en score');
      stValMax   : array [TFormatStats] of String = ('100.0','888888');
      stFrmStats : array [TFormatStats] of String = ('00.0','000000');
var x,y,x0,y0,
    xSE,ySE,
    Hauteur,
    Largeur,
    Taille,
    sc1, sc2,
    r, v, b  : Integer;
    dx,dy : Double;
    e,e1,e2  : TTypeEvt;
    Proprio1,
    Proprio2 : TJoueurId;
    se       : array [TFormatStats] of Double;
    stValSE  : array [TFormatStats] of String;
    Pos      : array [TTypeEvt] of Integer;
    bmEvt    : TBitmap;

procedure DetermineTaillePolice(stTexte : String; LargeurMax : Integer);
begin
with Canvas do
  begin
  Font.Size := 1;
  while (TextWidth(stTexte) < LargeurMax) and
        (TextHeight(stTexte) < Hauteur) do
    Font.Size := Font.Size + 1;
  Font.Size := Font.Size - 1;
  end;
end{procedure DetermineTaillePolice};

begin
Taille := 5*(TailleCase+1);
x0 := 1*(TailleCase+1);
y0 := 1*(TailleCase+1);
Largeur := Taille div (Colonnes + 2);
Hauteur := Taille div (Lignes + 3);
dx := (Taille - Largeur * Colonnes) / (Colonnes + 1);
dy := (Taille - Hauteur * Lignes) / (Lignes + 1);
Pos[teIndefini] := 0;

// 1. Calcul des positions
for e1 := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  begin
  Pos[e1] := 1;
  sc1 := Partie.ScEvt[e1];
  for e2 := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
    begin
    sc2 := Partie.ScEvt[e2];
    if (sc1 < sc2) or
       ((sc1 = sc2) and (Ord(e2) < Ord(e1))) then
      Inc(Pos[e1]);
    end;
  end;

// 2. Affichage de l'unité (en haut à gauche)
DetermineTaillePolice(stStats[FormatStats], Round(3*dx + 2*Largeur));
with Canvas do
  begin
  Font.Color := clWhite;
  TextOut(x0 + Round((3*dx + 2*Largeur - TextWidth(stStats[FormatStats]))/2),
          y0 + Round((  dx +   Hauteur - TextHeight(stStats[FormatStats]))/2), stStats[FormatStats]);
  end;

// 3. Affichage des événements
DetermineTaillePolice(stValMax[FormatStats], Round(Largeur + dx - Hauteur));
for e := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  begin
  x := x0 + Round(dx + ((Pos[e] + 1) mod Colonnes) * (Largeur + dx));
  y := y0 + Round(dy + ((Pos[e] + 1) div Colonnes) * (Hauteur + dy));
  Proprio1 := Partie.Evt[e].CaseEvt[ncePrm].Id;
  Proprio2 := Partie.Evt[e].CaseEvt[nceDrn].Id;

  // 2a. Affichage de l'événement avec les propriétaires en fond
  bmEvt := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(Proprio1)+8*Ord(Proprio1=jIndefini), bmEvt);
  VirtualImageListDemiFonds.GetBitmap(Ord(Proprio2)+8*Ord(Proprio2=jIndefini), bmEvt);
  VirtualImageListCases.GetBitmap(Ord(TypeCaseEvt[e])-1, bmEvt);
  Canvas.StretchDraw(TRect.Create(x, y, x + Hauteur - 1, y + Hauteur - 1), bmEvt);
  FreeAndNil(bmEvt);

  // 2b. Calcul de la couleur de la statistique
  with Partie do
   begin
    if Partie.ScEvt[teIndefini] > 0 then
      begin
      se[fsPourcent] := (100.0 * Partie.ScEvt[e]) / Partie.ScEvt[teIndefini];
      se[fsScore]    := 1.0 * Partie.ScEvt[e];
      end
    else
      begin
      se[fsPourcent] := 0.0;
      se[fsPourcent] := 0.0;
      end;
    r := 0; v := 0; b := 0;
    case Trunc(se[fsPourcent]/25) of
      0: begin
         b := Round((255*(25-se[fsPourcent]))/25);
         v := Round((255*se[fsPourcent])/25);
         end;
      1: begin
         v := Round((255*(50-se[fsPourcent]))/25);
         r := Round((255*(se[fsPourcent]-25))/25);
         end;
      2: begin
         v := Round((255*(se[fsPourcent]-50))/25);
         r := 255;
         end;
      3: begin
         b := Round((255*(se[fsPourcent]-75))/25);
         v := 255;
         r := 255;
         end;
      4: begin
         b := 255;
         v := 255;
         r := 255;
         end;
    end{case of};
    stValSE[FormatStats] := FormatFloat(stFrmStats[FormatStats], se[FormatStats]);
   end;
  with Canvas do
    begin
    // 2c. Effacement la zone d'écriture
    Brush.Color := clBlack;
    FillRect(TRect.Create(x + Hauteur,                 y,
                          x + Round(Largeur + dx) - 1, y + Round(Hauteur + dy) - 1));
    // 2d. Affichage de la statistique (score ou pourcent)
    Font.Color := TColor(r + 256*v + 65536*b);
    xSE := x + Hauteur + Round((Largeur - dx/2 - TextWidth(stValSE[FormatStats]))/2);
    ySE := y +           Round((Hauteur -        TextHeight(stValSE[FormatStats]))/2);
    TextOut(xSE, ySE, stValSE[FormatStats]);
    end
  end;
end{procedure TFormPlateau.DessineStatsEvts};

procedure TFormPlateau.DessineStatsDes;
const stFormat   : array [TFormatStats] of String = ('%','Score');
      stValMax   : array [TFormatStats] of String = ('100.0','888888');
      stFrmStats : array [TFormatStats] of String = ('00.0','000000');
var x, y,
    xSD,ySD,
    x0,y0,
    Taille,
    tc,dc,
    r,v,b   : Integer;
    sd      : Array [TFormatStats] of Double;
    d,d1,d2 : TDe;
    stValSD : String;
    bmDe    : TBitmap;

procedure DetermineTaillePolice(stTexte : String);
begin
with Canvas do
  begin
  Font.Size := 1;
  while (TextWidth(stTexte) < tc) and
        (TextHeight(stTexte) < tc) do
    Font.Size := Font.Size + 1;
  Font.Size := Font.Size - 1;
  end;
end{procedure DetermineTaillePolice};

begin
Taille := 5*(TailleCase+1);
x0 := 1*(TailleCase+1);
y0 := 1*(TailleCase+1);
tc := Taille div (Ord(High(TDe))+3);
dc := Round((Taille - tc * (Ord(High(TDe))+1)) div (Ord(High(TDe))+2));

for d1 := Low(TDe) to High(TDe) do
  for d2 := Low(TDe) to High(TDe) do
    begin
    if d1 = dIndefini then
      d := d2
    else
      if d2 = dIndefini then
        d := d1
      else
        d := dIndefini;
    x := x0 + dc + Ord(d1)*(dc + tc);
    y := y0 + dc + Ord(d2)*(dc + tc);
    if (d > dIndefini) then
      begin
      bmDe := TBitmap.Create;
      VirtualImageListFonds.GetBitmap(Ord(cBlanc), bmDe); // Fond blanc pour les dés
      VirtualImageListDes.GetBitmap(Ord(d)-1, bmDe);
      Canvas.StretchDraw(TRect.Create(x, y,
                                      x + tc - 1, y + tc - 1), bmDe);
      FreeAndNil(bmDe);
      end
    else
      if Ord(d1)+Ord(d2) = 0 then
        with Canvas do
          begin
          DetermineTaillePolice(stFormat[FormatStats]);
          Font.Color := clWhite;
          xSD := x + (tc - TextWidth(stFormat[FormatStats])) div 2;
          ySD := y + (tc - TextHeight(stFormat[FormatStats])) div 2;
          TextOut(xSD, ySD, stFormat[FormatStats]);
          DetermineTaillePolice(stValMax[FormatStats]);
          end
      else
        if Partie.ScEvt[teIndefini] > 0 then
          begin
          // On efface uniquement la zone de chiffres qui bouge
          with Canvas do
            begin
            Brush.Color:=clBlack;
            FillRect(TRect.Create(x, y,
                                  x + tc - 1, y + tc - 1));
            end;
          with Partie do
           begin
            sd[fsPourcent] := (100.0 * ScDes[d1, d2]) / ScEvt[teIndefini];
            sd[fsScore]    := 1.0 * ScDes[d1, d2];
            r := 0; v := 0; b := 0;
            case Trunc(sd[fsPourcent]/25) of
              0: begin
                 b := Round((255*(25-sd[fsPourcent]))/25);
                 v := Round((255*sd[fsPourcent])/25);
                 end;
              1: begin
                 v := Round((255*(50-sd[fsPourcent]))/25);
                 r := Round((255*(sd[fsPourcent]-25))/25);
                 end;
              2: begin
                 v := Round((255*(sd[fsPourcent]-50))/25);
                 r := 255;
                 end;
              3: begin
                 b := Round((255*(sd[fsPourcent]-75))/25);
                 v := 255;
                 r := 255;
                 end;
              4: begin
                 b := 255;
                 v := 255;
                 r := 255;
                 end;
            end{case of};
            stValSD := FormatFloat(stFrmStats[FormatStats], sd[FormatStats]);
           end;
          with Canvas do
            begin
            Font.Color := TColor(r + 256*v + 65536*b);
            xSD := x + (tc - TextWidth(stValSD)) div 2;
            ySD := y + (tc - TextHeight(stValSD)) div 2;
            TextOut(xSD, ySD, stValSD);
            end
          end
    end
end{procedure TFormPlateau.DessineStatsDes};

procedure TFormPlateau.DessineSelonTypeAffichage;
begin
case TypeAffichage of
  taEvolution: try
                 DessineEvolution;
               except
               end;
  taBilanTour: try
                 Partie.DessineBilan;
               except
                 DessineBilan(0);
               end;
  taStatsEvts: try
                 DessineStatsEvts
               except
               end;
  taStatsDes:  try
                 DessineStatsDes
               except
               end;
end{case of};
end{procedure TFormPlateau.DessineSelonTypeAffichage};

procedure TFormPlateau.DessineEvenement(TypeEvt : TTypeEvt; Proprio1, Proprio2 : TJoueurId);
var Largeur,
    Hauteur,
    TailleEvt,
    dx, dy,
    x0, y0,
    x, y      : Integer;
    bmEvt     : TBitmap;
begin
Largeur := 3*(TailleCase+1);
Hauteur := 5*(TailleCase+1);
TailleEvt := Hauteur div 10;
x0 := 1*(TailleCase+1);
y0 := 7*(TailleCase+1);
dx := (Largeur - 4*TailleEvt) div 5;
dy := (Hauteur - 7*TailleEvt) div 8;
x := x0 + dx + (dx + TailleEvt) * xTypeEvt[TypeEvt];
y := y0 + dy + (dy + TailleEvt) * yTypeEvt[TypeEvt];
bmEvt := TBitmap.Create;
VirtualImageListFonds.GetBitmap(Ord(Proprio1)+8*Ord(Proprio1=jIndefini), bmEvt);
VirtualImageListDemiFonds.GetBitmap(Ord(Proprio2)+8*Ord(Proprio2=jIndefini), bmEvt);
VirtualImageListCases.GetBitmap(Ord(TypeCaseEvt[TypeEvt])-1, bmEvt);
Canvas.StretchDraw(TRect.Create(x, y, x+TailleEvt-1, y+TailleEvt-1), bmEvt);
FreeAndNil(bmEvt);
end{procedure TFormPlateau.DessineEvenement};

procedure TFormPlateau.DessineCompteurEvt(Couleur : TCouleur);
var Largeur,
    Hauteur,
    TailleEvt,
    dx, dy,
    x0, y0,
    x, y,
    xc, yc,
    Chf, ne  : Integer;
    u, JrElm : Boolean;
    bmEvt    : TBitmap;
begin
// 1. On reprend le calcul pour l'affichage des événement affichés juste au dessus
Largeur := 3*(TailleCase+1);
Hauteur := 5*(TailleCase+1);
TailleEvt := Hauteur div 10;
x0 := 1*(TailleCase+1);
y0 := 7*(TailleCase+1);
dx := (Largeur - 4*TailleEvt) div 5;
dy := (Hauteur - 7*TailleEvt) div 8;
// On part juste apèrs le dernier événement avec 4 compteurs par emplacement d'événement
x := x0 + dx + (dx + TailleEvt) * (1 + xTypeEvt[teImpair]);
y := y0 + dy + (dy + TailleEvt) * (0 + yTypeEvt[teImpair]);

try
  with Partie do
    begin
    // 2. On compte les événements
    if Couleur = cBlanc then
      ne := NbEvenements(jIndefini) // cBlanc = événements encore libres => proprio = jIndefini => cNoir
    else
      ne := NbEvenements(TJoueurId(Couleur));
    JrElm := (Couleur > cNoir) and (Ord(Couleur) <= Nbj) and Jr[TJoueurId(Couleur)].Elimine;
    end;
except
  ne := 0;
  JrElm := False;
end;

// 3. On affiche le compteur
for u := False to True do // Unité (true) ou dizaine (false)
  begin
  Chf := IfThen(u, ne mod 10, ne div 10);
  bmEvt := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmEvt);
  VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+IfThen(JrElm,Ord(cGris),Ord(Couleur)), bmEvt);
  xc := x + dx div 4 + ((Ord(Couleur)-1) div 2)*(dx div 4 + TailleEvt div 2) + Ord(u)*(TailleEvt div 4);
  yc := y - dy div 8 + ((Ord(Couleur)-1) mod 2)*(dy div 4 + TailleEvt div 2);
  Canvas.StretchDraw(TRect.Create(xc,                   yc, 
                                  xc + TailleEvt div 4, yc + TailleEvt div 2), bmEvt);
  FreeAndNil(bmEvt);
  end
end{procedure TFormPlateau.DessineCompteurEvt};

end.
