unit plateau_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ComCtrls, Vcl.Grids,
  base, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.Menus,
  Vcl.ExtCtrls;

type
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
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
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
  private
    FMessage   : String;
    procedure LitParametres;
    procedure EcritParametres;
    procedure DefinitMessage(stNvMessage : String); // Exécuté en affectant la property stMesssage
    procedure DessineMessage; // Exécuté en affectant la property stMesssage
    function RectCase(x : TCoordonnee; y : TCoordonnee) : TRect;
  public // Les procédures Dessine... ci-dessous sont utilisées automatiquement par FormPaint
    TailleCase : Integer;
    procedure DessineCase(ProprioId : TJoueurId; x : TCoordonnee; y : TCoordonnee; DirPoss : TDirPoss);
    procedure DessineScore(Id : TJoueurId; Pos, Score : Integer; JrCrt, Automate, Elimine : Boolean);
    procedure DessineJackpot(Score, DrnSc : Integer; DrnJr : TJoueurId);
    procedure DessineLanceDes(Id : TJoueurId; De : array of TDe);
    procedure DessineBilan(Tour : Integer);
    procedure DessineEvenement(TypeEvt : TTypeEvt; Proprio1, Proprio2 : TJoueurId);
    procedure DessineCompteurEvt(Couleur : TCouleur);
    property stMessage : String read FMessage write DefinitMessage;
  end;

var
  FormPlateau: TFormPlateau;

implementation
{$R *.dfm}

uses
  IniFiles, System.Types, System.Math, System.StrUtils, apropos_f, evtdes_f,
  nvpartie_f;

const
  stNomFichierIni  : String = 'Paradice.ini';
  stSectionOptions : String = 'Options';
  stEntreePolice   : String = 'Police';
  stEntreeVitesse  : String = 'Vitesse';

// -------------------
// Evénements de fiche
// -------------------

procedure TFormPlateau.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var dw, dh : Integer;
begin
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
  Refresh;
  StatusBar.SimpleText:=Format('Taille d''une case : %d', [TailleCase]);
  end;
end;

procedure TFormPlateau.FormCreate(Sender: TObject);
begin
LitParametres;
end;

procedure TFormPlateau.FormDestroy(Sender: TObject);
begin
EcritParametres;
end;

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
end;

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
                Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jJackpot;
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
             VendEvenement;
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
end;

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
DesOK := False; // Lancé de dés
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
          try
            Partie.DessineBilan;
          except
            DessineBilan(0);
          end;
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
end;

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
begin
if Application.MessageBox('Êtes-vous sûr(e) de vouloir abandonner la partie ?', 'Confirmation d''abandon', MB_ICONEXCLAMATION + MB_YESNO) = IDYES then
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
    with FormPlateau do
      begin
      Canvas.Brush.Color:=clBlack;
      // On efface la zone de score
      Canvas.FillRect(TRect.Create( 7*(TailleCase + 1) + 1, 1*(TailleCase + 1) + 1,
                                   12*(TailleCase + 1) - 1, 4*(TailleCase + 1) - 1));
      // On efface la zone de bilan
      Canvas.FillRect(TRect.Create(1*(TailleCase+1) + 1, 1*(TailleCase+1) + 1,
                                   6*(TailleCase+1) - 1, 6*(TailleCase+1) - 1));
      Partie.Demarre; // L'instance Partie a été créée : on démarre le jeu
      end
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
end;

procedure TFormPlateau.TimerClignotementTimer(Sender: TObject);
begin
TimerClignotement.Tag := 1 - TimerClignotement.Tag;
with Partie do
  DessineCase(Jr[JrCrt].Pion.x, Jr[JrCrt].Pion.y);
end;

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
end;

procedure TFormPlateau.TimerParcoursTimer(Sender: TObject);
begin
TimerParcours.Tag := 0;
Refresh;
TimerParcours.Enabled:=False;
end;

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
end;

// -----------------------
// méthodes personnalisées
// -----------------------

procedure TFormPlateau.LitParametres;
var IniFile : TIniFile;
    i       : Integer;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni);
try
  Font.Name := IniFile.ReadString(stSectionOptions, stEntreePolice, 'Impact');
  TimerPion.Interval := IniFile.ReadInteger(stSectionOptions, stEntreeVitesse, MenuItemVitesseMoyenne.Tag);
  TimerAutomate.Interval := 5 * TimerPion.Interval;
  TimerClignotement.Interval := TimerAutomate.Interval div 2;
  // On rafraîchit le menu des options (vitesse)
  for i:= 0 to MenuItemVitesse.Count - 1 do
    with MenuItemVitesse.Items[i] do
      Checked := (Tag = TimerPion.Interval)
finally
  FreeAndNil(IniFile);
end{try}
end;

procedure TFormPlateau.EcritParametres;
var IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni);
try
  IniFile.WriteString(stSectionOptions, stEntreePolice, Font.Name);
  IniFile.WriteInteger(stSectionOptions, stEntreeVitesse, TimerPion.Interval);
finally
  FreeAndNil(IniFile);
end{try}
end;

procedure TFormPlateau.DefinitMessage(stNvMessage : String); // Exécuté en affectant la property stMesssage
begin
FMessage := stNvMessage;
DessineMessage;
end;

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
Canvas.FillRect(TRect.Create(x0Min + 1,              y0Min + 1,
                             x0Min + LargeurMax - 1, y0Min + HauteurMax - 1));

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
    Chf, ne   : Integer;
    u         : Boolean;
    bmEvt     : TBitmap;
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
    // 2. On compte les événements  
    if Couleur = cBlanc then
      ne := NbEvenements(jIndefini) // cBlanc = événements encore libres => proprio = jIndefini => cNoir
    else
      ne := NbEvenements(TJoueurId(Couleur)); 
except
  ne := 0;
end;

// 3. On affiche le compteur
for u := False to True do // Unité (true) ou dizaine (false)
  begin
  Chf := IfThen(u, ne mod 10, ne div 10);
  bmEvt := TBitmap.Create;
  VirtualImageListFonds.GetBitmap(Ord(cNoir), bmEvt);
  VirtualImageListChiffres.GetBitmap(Chf*NbMaxCouleurs+Ord(Couleur), bmEvt);
  xc := x + dx div 4 + ((Ord(Couleur)-1) div 2)*(dx div 4 + TailleEvt div 2) + Ord(u)*(TailleEvt div 4);
  yc := y - dy div 8 + ((Ord(Couleur)-1) mod 2)*(dy div 4 + TailleEvt div 2);
  Canvas.StretchDraw(TRect.Create(xc,                   yc, 
                                  xc + TailleEvt div 4, yc + TailleEvt div 2), bmEvt);
  FreeAndNil(bmEvt);
  end
end;

end.
