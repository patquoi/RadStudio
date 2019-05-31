unit main_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.Samples.Gauges, base;

type
  TFormMain = class(TForm)
    StatusBar: TStatusBar;
    PanelBas: TPanel;
    DrawGrid: TDrawGrid;
    ImageListJeu: TImageList;
    MainMenu: TMainMenu;
    MenuItemPartie: TMenuItem;
    MenuItemInfo: TMenuItem;
    MenuItemOptions: TMenuItem;
    MenuItemOptionsCouleurs: TMenuItem;
    ActionList: TActionList;
    ActionOptionsCouleurs: TAction;
    PanelOccupation: TPanel;
    PanelBas1Gauche: TPanel;
    PanelBas1: TPanel;
    GaugeOccupation: TGauge;
    PanelBas1Haut: TPanel;
    PanelDistanceJ: TPanel;
    PanelBas2Gauche: TPanel;
    PanelBas2: TPanel;
    GaugeDistanceJ: TGauge;
    PanelBas2Haut: TPanel;
    PanelDistanceB: TPanel;
    PanelBas3Gauche: TPanel;
    PanelBas3: TPanel;
    GaugeDistanceB: TGauge;
    PanelBas3Haut: TPanel;
    PanelHaut: TPanel;
    PanelHautGauche: TPanel;
    PanelScoreTour: TPanel;
    PanelHautTours: TPanel;
    GaugeTour: TGauge;
    PanelHautJGauche: TPanel;
    PanelHautJDroite: TPanel;
    PaintBoxJDroite: TPaintBox;
    PaintBoxJGauche: TPaintBox;
    ImageListScore: TImageList;
    ImageListPhase: TImageList;
    PanelTempsJGauche: TPanel;
    PanelTempsJDroite: TPanel;
    PanelTitreJGauche: TPanel;
    PanelTitreJDroite: TPanel;
    TimerImages: TTimer;
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure ActionOptionsCouleursExecute(Sender: TObject);
    procedure DrawGridClick(Sender: TObject);
    procedure AfficheScore(const Jeu : TJeu);
    procedure AffichePhase(const Jeu : TJeu);
    procedure AfficheOccupation(const Jeu : TJeu; const delta : Integer);
    procedure AfficheDistance(const Jeu : TJeu);
    procedure AfficheScoreEtPhase;
    procedure TimerImagesTimer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  CouleurJoueur   : array [TCouleurPion] of TColor    = (clNone, $00ff0107, $00fffc01, $0000ffff, $00fc01ff, $000184ff, $00ff0184, $000107ff, $0001ff01);

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses couleurs_f;

procedure TFormMain.ActionOptionsCouleursExecute(Sender: TObject);
begin
FormCouleurs.ShowModal
end;

procedure TFormMain.DrawGridClick(Sender: TObject);
begin
// On affiche les coordonnées de la case séelctionnée
with DrawGrid do
  StatusBar.Panels[1].Text:=Chr(Ord('@')+Col)+Chr(Ord('0')+Row);
end;

procedure TFormMain.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var stCoordonnee : String;
    Image : TImage;
begin
if (ACol*ARow=0) and (ACol+ARow>0) then // 1. Affichage coordonnées
  with DrawGrid.Canvas do
   begin
   if ACol=0 then
     stCoordonnee:=Chr(Ord('0')+ARow)
   else
     stCoordonnee:=Chr(Ord('@')+ACol);
   TextOut(Rect.Left+(Rect.Right-Rect.Left+1-TextWidth(stCoordonnee)) div 2,
           Rect.Top+(Rect.Bottom-Rect.Top+1-TextHeight(stCoordonnee)) div 2, stCoordonnee);
   end
else
 if ACol+ARow>0 then
  begin
  // 2. Terrain de jeu
  Image:=TImage.Create(Self);
  try
    with Image do
      begin
      Stretch:=True;
      Width:=DrawGrid.DefaultColWidth;
      Height:=DrawGrid.DefaultRowHeight;
      end;
    ImageListJeu.GetBitmap(ZoneImgIdx[Zone[ACol-1, ARow-1]]+ // Zone
                           4*Ord(CouleurTerrain[TCamp(Ord(ACol<6)+2*Ord(ACol>6))])+ // Couleur terrain
                           (ACol+ARow) mod 4, // version image
                           Image.Picture.Bitmap);
    DrawGrid.Canvas.StretchDraw(Rect, Image.Picture.Graphic);
  finally
    Image.Free
  end{try};
  end
end;

procedure TFormMain.FormResize(Sender: TObject);
const CharTest = 'W';
      Bords = 3; // compensation des bordures
      PropFixe = 0.75; // Proportion de la taille en moins des en-têtes par rapport à celle des cases
var CellWidth, CellHeight, CellSize,
    FixedWidth, FixedHeight,
    dWidth, dHeight,
    MaxWidth, MaxHeight                 : Integer;
begin // On recalcule la taille de FormMain une seule fois selon les tailles de cases courantes
if DrawGrid.Tag=1 then Exit; // Pour empêcher de retailler en boucle
// 1. Delta Form/DrawGrid
dWidth:=Width-DrawGrid.Width;
dHeight:=Height-DrawGrid.Height;
with DrawGrid do
  begin
  // 2a. On calcule la taille de la case en prenant le min entre hauteur et largeur obtenues comme taille de case (carrée)
  CellWidth:=Trunc((Width-ColCount-Bords)/(ColCount-PropFixe));
  CellHeight:=Trunc((Height-RowCount-Bords)/(RowCount-PropFixe));
  // 2b. Les en-têtes font la moitié de la taille des cases
  FixedWidth:=Width-(ColCount-1)*CellWidth-Bords;
  FixedHeight:=Height-(RowCount-1)*CellHeight-Bords;
  // 3. Calcul de la taille définitive de case (qui doit être carrée)
  if CellWidth<CellHeight then
    CellSize:=CellWidth
  else
    CellSize:=CellHeight;
  // 4. On retaille les cases de la DrawGrid
  DefaultColWidth:=CellSize;
  DefaultRowHeight:=CellSize;
  ColWidths[0]:=FixedWidth;
  RowHeights[0]:=FixedHeight;
  // 5. On reajuste la taille de la police des coordonnées
  MaxWidth:=Canvas.TextWidth(CharTest);
  MaxHeight:=Canvas.TextHeight(CharTest);
  while (MaxWidth<FixedWidth) and
        (MaxHeight<FixedHeight)  do
    begin
    Canvas.Font.Size:=Canvas.Font.Size+1;
    MaxWidth:=Canvas.TextWidth(CharTest);
    MaxHeight:=Canvas.TextHeight(CharTest);
    end;
  while (MaxWidth>=FixedWidth) or
        (MaxHeight>=FixedHeight)  do
    begin
    Canvas.Font.Size:=Canvas.Font.Size-1;
    MaxWidth:=Canvas.TextWidth(CharTest);
    MaxHeight:=Canvas.TextHeight(CharTest);
    end;
  Font.Size:=Canvas.Font.Size;
  // 6. On retaille la fiche
  DrawGrid.Tag:=1; // Pour empêcher de retailler en boucle
  self.Width:=dWidth+(ColCount-1)*CellSize+ColCount+Bords+FixedWidth;
  self.Height:=dHeight+(RowCount-1)*CellSize+RowCount+Bords+FixedHeight;
  DrawGrid.Tag:=0;
  end;
// 7. On retaille StatusBar.Panels[0]
StatusBar.Panels[0].Width:=StatusBar.Width-StatusBar.Panels[1].Width;
// 8. On retaille les panneaux d'affichage pour center par rapport au terrain
PanelHautGauche.Width:=FixedWidth;
PanelBas1Gauche.Width:=FixedWidth;
PanelBas2Gauche.Width:=FixedWidth;
PanelBas3Gauche.Width:=FixedWidth;
PanelHautJGauche.Width:=(PanelScoreTour.Width-PaintBoxJGauche.Width-PaintBoxJDroite.Width) div 2;
PanelHautJDroite.Width:=PanelHautJGauche.Width;
// 9. On rafraîchit les images (score & phase)
AfficheScoreEtPhase;
end;

procedure TFormMain.AfficheScore(const Jeu : TJeu);
var ImgJGauche,
    ImgJDroite    : TImage;
    RectJGauche,
    RectJDroite   : TRect;
begin
if Jeu<>nil then // On stocke l'info à afficher depuis l'événement OnTimer
  begin
  PaintBoxJGauche.Tag:=Jeu.Buts[jGauche];
  PaintBoxJDroite.Tag:=Jeu.Buts[jDroite];
  Exit
  end;
// On affiche les images
ImgJGauche:=TImage.Create(Self);
ImgJDroite:=TImage.Create(Self);
try
  with ImgJGauche do
    begin
    Transparent:=True;
    SetStretchBltMode(Canvas.Handle,HALFTONE);
    Stretch:=True;
    Width:=PaintBoxJGauche.Height div 2;
    Height:=PaintBoxJGauche.Height;
    end;
  ImageListScore.GetBitmap(PaintBoxJGauche.Tag+10*(1+Ord(CouleurPion[jGauche])), ImgJGauche.Picture.Bitmap);
  RectJGauche:=TRect.Create(0, 0, ImgJGauche.Width-1, ImgJGauche.Height-1);
  with PaintBoxJGauche.Canvas do
    begin
    Pen.Color:=Brush.Color;
    Rectangle(RectJGauche);
    StretchDraw(RectJGauche, ImgJGauche.Picture.Graphic);
    end;
  with ImgJDroite do
    begin
    Transparent:=True;
    SetStretchBltMode(Canvas.Handle,HALFTONE);
    Stretch:=True;
    Width:=PaintBoxJDroite.Height div 2;
    Height:=PaintBoxJDroite.Height;
    end;
  ImageListScore.GetBitmap(PaintBoxJDroite.Tag+10*(1+Ord(CouleurPion[jDroite])), ImgJDroite.Picture.Bitmap);
  RectJDroite:=TRect.Create(PaintBoxJDroite.Width-ImgJDroite.Width, 0, PaintBoxJDroite.Width-1, ImgJDroite.Height-1);
  with PaintBoxJDroite.Canvas do
    begin
    Pen.Color:=Brush.Color;
    Rectangle(RectJDroite);
    StretchDraw(RectJDroite, ImgJDroite.Picture.Graphic);
    end;
finally
  ImgJGauche.Free;
  ImgJDroite.Free;
end{try};
end;

procedure TFormMain.AffichePhase(const Jeu : TJeu);
const DeltaGauche   = 1;
      DeltaDroite   = 0;
      ImgIdxAtt     = 0;
      ImgIdxTir     = 1;
      ImgIdxTTir    = 2;
      ImgIdxDepl    = 3;
      ImgIdxPose    = 19;
var ImgJGauche,
    ImgJDroite    : TImage;
    RectJGauche,
    RectJDroite   : TRect;
begin
if Jeu<>nil then // On stocke l'info à afficher depuis l'événement OnTimer
  begin
  PanelHautJGauche.Tag:=Ord(Jeu.Phase[jGauche]);
  PanelHautJDroite.Tag:=Ord(Jeu.Phase[jDroite]);
  Exit
  end;
// On affiche les images
ImgJGauche:=TImage.Create(Self);
ImgJDroite:=TImage.Create(Self);
try
  with ImgJGauche do
    begin
    Transparent:=True;
    SetStretchBltMode(Canvas.Handle,HALFTONE);
    Stretch:=True;
    Width:=PaintBoxJGauche.Height;
    Height:=PaintBoxJGauche.Height;
    end;
  case TPhase(PanelHautJGauche.Tag) of
    phAttente:      ImageListPhase.GetBitmap(ImgIdxAtt, ImgJGauche.Picture.Bitmap); // Rien (on efface)
    phTir:          ImageListPhase.GetBitmap(ImgIdxTir, ImgJGauche.Picture.Bitmap); // Ballon
    phTestTir:      ImageListPhase.GetBitmap(ImgIdxTTir, ImgJGauche.Picture.Bitmap); // Ballon obscurci
    phDeplacement1..
    phDeplacement2: ImageListPhase.GetBitmap(ImgIdxDepl+DeltaGauche+2*Ord(CouleurPion[jGauche]), ImgJGauche.Picture.Bitmap); // Joueur
    phPoseJoueurs:  ImageListPhase.GetBitmap(ImgIdxPose+DeltaGauche+2*Ord(CouleurPion[jGauche]), ImgJGauche.Picture.Bitmap); // Joueur obscurci
  end;
  RectJGauche:=TRect.Create(PaintBoxJGauche.Width-ImgJGauche.Width, 0, PaintBoxJGauche.Width-1, ImgJGauche.Height-1);
  with PaintBoxJGauche.Canvas do
    begin
    Rectangle(RectJGauche);
    StretchDraw(RectJGauche, ImgJGauche.Picture.Graphic);
    end;
  with ImgJDroite do
    begin
    Transparent:=True;
    SetStretchBltMode(Canvas.Handle,HALFTONE);
    Stretch:=True;
    Width:=PaintBoxJDroite.Height;
    Height:=PaintBoxJDroite.Height;
    end;
  case TPhase(PanelHautJDroite.Tag) of
    phAttente:      ImageListPhase.GetBitmap(ImgIdxAtt, ImgJDroite.Picture.Bitmap); // Rien (on efface)
    phTir:          ImageListPhase.GetBitmap(ImgIdxTir, ImgJDroite.Picture.Bitmap); // Ballon
    phTestTir:      ImageListPhase.GetBitmap(ImgIdxTTir, ImgJDroite.Picture.Bitmap); // Ballon obscurci
    phDeplacement1..
    phDeplacement2: ImageListPhase.GetBitmap(ImgIdxDepl+DeltaDroite+2*Ord(CouleurPion[jDroite]), ImgJDroite.Picture.Bitmap); // Joueur
    phPoseJoueurs:  ImageListPhase.GetBitmap(ImgIdxPose+DeltaDroite+2*Ord(CouleurPion[jDroite]), ImgJDroite.Picture.Bitmap); // Joueur obscurci
  end;
  RectJDroite:=TRect.Create(0, 0, ImgJDroite.Width-1, ImgJDroite.Height-1);
  with PaintBoxJDroite.Canvas do
    begin
    Pen.Color:=Brush.Color;
    Rectangle(RectJDroite);
    StretchDraw(RectJDroite, ImgJDroite.Picture.Graphic);
    end;
finally
  ImgJGauche.Free;
  ImgJDroite.Free;
end{try};
end;

procedure TFormMain.AfficheOccupation(const Jeu : TJeu; const Delta : Integer);
var Tours : Integer;
begin // À ce moment de l'affichage, on a pas encore changé de camp...
	Tours:=1+2*Jeu.TourCrt;
	if Jeu.TourCrt<TourMiTemps then
		if Jeu.CampCrt=cDroite then
			Inc(Tours)
    else
		  if Jeu.CampCrt=cGauche then
  			Inc(Tours);
	Inc(Tours, delta); // Pour le chargement de partie car l'affichage de l'occupation est avant changement de camp
  GaugeOccupation.Progress:=Round(100.0*Jeu.Occupation/Tours);
end;

procedure TFormMain.AfficheDistance(const Jeu : TJeu);
begin
GaugeDistanceJ.Progress:=Round((1000.0*Jeu.DistPjr[jGauche])/(Jeu.DistPjr[jGauche]+Jeu.DistPjr[jDroite]));
end;

procedure TFormMain.TimerImagesTimer(Sender: TObject);
begin
TimerImages.Enabled:=False;
AfficheScore(nil);
AffichePhase(nil);
(* // Pour test
PaintBoxJGauche.Tag:=(1+PaintBoxJGauche.Tag) mod 10;
PaintBoxJDroite.Tag:=(1+PaintBoxJDroite.Tag) mod 10;
PanelHautJGauche.Tag:=(1+PanelHautJGauche.Tag) mod (Ord(High(TPhase))+1);
PanelHautJDroite.Tag:=(1+PanelHautJDroite.Tag) mod (Ord(High(TPhase))+1);
*)
end;

procedure TFormMain.AfficheScoreEtPhase;
begin
TimerImages.Enabled:=True;
end;

end.
