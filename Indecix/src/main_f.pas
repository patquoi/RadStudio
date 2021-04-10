unit main_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Base;

const
   NbCouleurs                               = 10;
   NbColDes                                 = 6;

type
   TDigit                                   = (dUnite, dDizaine, dCentaine);
   TCouleur                                 = (cNoir=0,cBleu=1,cMagenta=2,cOrange=3,cRouge=4,cJaune=5,cVert=6,cPourpre=7,cBlanc=8,cGris=9);
   TEtatBouton                              = (ebIndefini=0, ebOK=1, ebStop=2);

const
   Couleur   : array [TCouleur] of TColor   = ($000000, $ef5024, $7939c2, $0080ff, $0000ff, $60ffff, $008900, $b44b97, $ffffff, $404040);
   stNomCl   : array [TCouleur] of String   = ('Noir',  'Bleu','Magenta','Orange', 'Rouge', 'Jaune', 'Vert','Pourpre', 'Blanc', 'Gris');
   stDigit   : array [TDigit] of String     = ('U','D','C');
   stIdJr    : array [TIdJoueur] of String  = ('', 'G', 'D');
   stLabel                                  = 'Label';
   stPaintBox                               = 'PaintBox';
   stSfxCpt  : array [TCompteur] of string  = ('DRAJ', 'DC', 'DNJ');
   NbLgnDes  : array [TCompteur] of Integer = (     3,    2,     2);
   EtatDeCpt : array [TCompteur] of TEtatDe = (edEnAttente, edCapture, edNonJoue);
   // Messages
   stMsgTourJr                              = 'C''est � %s de jouer !'#13'Appuyez sur STOP'#13'pour arr�ter le d�...';
   stMsgAtteJr                              = '';
   stMsgPlceDe                              = 'Placez votre d� sur'#13'l''une des cases de votre couleur...';
   stMsgChxInc                              = 'Choix incorrect !'#13'Choisissez une case color�e !';
   stMsgResCpt                              = 'Vous avez captur�'#13'%d d�%s dont'#13'%d adverse%s'#13'rapportant %d point%s.';
   stMsgZeroPt                              = 'Vous n''obtenez aucun point.';
   stMsgPlcImp                              = 'Impossible de placer votre d� !'#13'Votre adversaire gagne un point.';
   stMsgAGagne                              = 'Partie termin�e'#13'Vous avez gagn� !';
   stMsgAPerdu                              = 'Partie termin�e'#13'Vous avez perdu !';
   stMsgEgalite                             = 'Partie termin�e'#13'Vous �tes � �galit� !';
   stPluriel : array [Boolean] of string    = ('','s');
type
  TFormMain = class(TForm)
    ImageCollection: TImageCollection;
    VirtualImageListChf: TVirtualImageList;
    VirtualImageListFnd: TVirtualImageList;
    VirtualImageListDes: TVirtualImageList;
    VirtualImageListFde: TVirtualImageList;
    VirtualImageListBtn: TVirtualImageList;
    VirtualImageListTjr: TVirtualImageList;
    VirtualImageListTDe: TVirtualImageList;
    StatusBar: TStatusBar;
    TimerDe: TTimer;
    MainMenu: TMainMenu;
    MenuItemPartieNouvelle: TMenuItem;
    MenuItemPartie: TMenuItem;
    MenuItemInfo: TMenuItem;
    MenuItemJoueurs: TMenuItem;
    PaintBoxGrille: TPaintBox;
    PaintBox1DRAJ: TPaintBox;
    PaintBox1DC: TPaintBox;
    PaintBox1DNJ: TPaintBox;
    PaintBox2DRAJ: TPaintBox;
    PaintBox2DC: TPaintBox;
    PaintBox2DNJ: TPaintBox;
    PaintBoxAction: TPaintBox;
    PaintBoxDe: TPaintBox;
    PaintBox1ScoreC: TPaintBox;
    PaintBox1ScoreD: TPaintBox;
    PaintBox2ScoreC: TPaintBox;
    PaintBox2ScoreD: TPaintBox;
    PaintBox1Msg: TPaintBox;
    PaintBox2Msg: TPaintBox;
    PaintBoxTour: TPaintBox;
    Label1DRAJ: TLabel;
    Label2DRAJ: TLabel;
    Label1DC: TLabel;
    Label2DC: TLabel;
    Label1DNJ: TLabel;
    Label2DNJ: TLabel;
    PaintBox1ScoreU: TPaintBox;
    PaintBox2ScoreU: TPaintBox;
    VirtualImageListStr: TVirtualImageList;
    PaintBox1StarA: TPaintBox;
    PaintBox1StarB: TPaintBox;
    PaintBox2StarA: TPaintBox;
    PaintBox2StarB: TPaintBox;
    procedure PaintBoxScorePaint(Sender: TObject);
    procedure PaintBoxDePaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxGrillePaint(Sender: TObject);
    procedure TimerDeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBoxActionPaint(Sender: TObject);
    procedure PaintBoxActionClick(Sender: TObject);
    procedure MenuItemJoueursClick(Sender: TObject);
    procedure PaintBoxMsgPaint(Sender: TObject);
    procedure PaintBoxDesPaint(Sender: TObject);
    procedure MenuItemPartieNouvelleClick(Sender: TObject);
    procedure PaintBoxGrilleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxTourPaint(Sender: TObject);
    procedure PaintBoxStarPaint(Sender: TObject);
  private
    stMsg : Array [TIdJoueur] of String;
    xPose, yPose : Integer; // Coordonn�es du choix de la case du d�
    procedure ChangeEtatBouton(NvEtatBouton : TEtatBouton);
    function DonneEtatBouton : TEtatBouton;
  public
    procedure ColoreTexteJoueurs;
    procedure AfficheMessage(Id : TIdJoueur; stNvMsg : String; EtatBouton : TEtatBouton = ebIndefini);
    procedure AfficheCompteur(c : TCompteur; Id : TIdJoueur = jIndefini); // Si Id = jIndefini, on affiche les deux compteurs
    procedure AfficheCompteurs(Id : TIdJoueur = jIndefini); // Si Id = jIndefini, on affiche tous les compteurs
    procedure AfficheScore(Id : TIdJoueur = jIndefini); // Si Id = jIndefini, on affiche tous les scores
    procedure AfficheTour;
    function AfficheCasesJouables : Integer;
    procedure AfficheGrille;
    procedure AfficheStars;
    property EtatBouton : TEtatBouton read DonneEtatBouton write ChangeEtatBouton;
    procedure LanceDe;
    procedure ActionDe(NumDe : TNumDe; Etat: TEtatDe);
    procedure FinDePartie;
  end;

var
  FormMain: TFormMain;
  CoulJr  : array [TIdJoueur] of TCouleur;

implementation

{$R *.dfm}

uses System.Math, joueurs_f;

procedure TFormMain.FormCreate(Sender: TObject);
begin
 CoulJr[jGauche] := cBleu;
 CoulJr[jDroite] := cRouge;
 ColoreTexteJoueurs
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
TimerDe.Enabled := False;
end;

procedure TFormMain.MenuItemJoueursClick(Sender: TObject);
begin
try
  FormJoueurs := TFormJoueurs.Create(Self);
  FormJoueurs.ShowModal;
finally
  FormJoueurs.Release
end;
end;

procedure TFormMain.MenuItemPartieNouvelleClick(Sender: TObject);
begin
p.Nouvelle;
Refresh;
AfficheTour; // Affiche les messages et le tour
LanceDe;
end;

procedure TFormMain.PaintBoxMsgPaint(Sender: TObject);
var pb     : TPaintBox;
    i, n,
    y0, h,
    x, y   : Integer;
    j      : TIdJoueur;
    Reste,
    Ligne  : String;

  function ProchaineLigne : String;
  var PosCR : Integer;
  begin
  PosCR := Pos(''+#13+'', Reste);
  if PosCR > 0 then
    begin
    Result := Copy(Reste, 1, PosCR-1);
    Reste := Copy(Reste, PosCR+1, Length(Reste)-PosCR)
    end
  else
    begin
    Result := Reste;
    Reste := '';
    end
  end{function ProchaineLigne};

begin
pb := Sender as TPaintBox;
j  := TIdJoueur(pb.Tag);
with pb.Canvas do
  begin
  Brush.Color := pb.Color;
  FillRect(TRect.Create(0, 0, pb.Width-1, pb.Height-1));
  end;
Reste := stMsg[j];
n := 0;
repeat
    Inc(n);
    ProchaineLigne;
until Length(Reste)=0;
Reste := stMsg[j];
h := pb.Canvas.TextHeight(Reste);
y0 := (pb.Height - n*h) div 2;
for i:=0 to n-1 do
  begin
  Ligne:=ProchaineLigne;
  x := (pb.Width - pb.Canvas.TextWidth(Ligne)) div 2;
  y := y0 + i*h;
  pb.Canvas.TextOut(x, y, Ligne);
  end;
end;

procedure TFormMain.PaintBoxDesPaint(Sender: TObject);
var pb    : TPaintBox;
    bm    : TBitmap;
    nd,td,
    x, y,
    tCrt  : Integer;
    jCrt  : TIdJoueur;
    cCrt  : TCompteur;
    dCrt  : TNumDe;
    stSfx : String;
begin
if p = Nil then Exit; // On ne fait rien si p n'est pas d�fini.
pb := Sender as TPaintBox;
jCrt := TIdJoueur(StrToInt(Copy(pb.Name,9,1)));
stSfx := Copy(pb.Name,10,4);
for cCrt := Low(TCompteur) to High(TCompteur) do
  if stSfxCpt[cCrt] = stSfx then
    break;
nd := 0; // On compte les d�s affich�s
td := Min(pb.Width div NbColDes, pb.Height div NbLgnDes[cCrt]); // Taille d'un d�
for tCrt := 0 to p.TrCrt do
  for dCrt := Succ(Low(TNumDe)) to High(TNumDe) do
    if p.De[dCrt].Tour = tCrt then // On affiche les d� par ordre de tour de jeu
      if (p.De[dCrt].Etat = EtatDeCpt[cCrt]) and
         (((cCrt = cDC) and (p.De[dCrt].Vq = jCrt)) or           // D�s captur�s = vainqueur courant uniquement
          ((cCrt = cDRAJ) and (p.De[dCrt].Jr = jCrt)) or         // D�s restant � jouer = joueur courant uniquement
          ((cCrt = cDNJ)  and (p.De[dCrt].Jr = Adv[jCrt]))) then // D�s non jou�s = joueur adverse uniquement
        begin
        x := td*(nd mod NbColDes);
        y := td*(nd div NbColDes);
        bm := TBitmap.Create;
        VirtualImageListFnd.GetBitmap(Ord(cNoir), bm);
        VirtualImageListFde.GetBitmap(Ord(CoulJr[p.De[dCrt].Jr]), bm);
        VirtualImageListDes.GetBitmap(Ord(p.De[dCrt].Face)-1, bm);
        pb.Canvas.StretchDraw(TRect.Create(x, y, x+td-1, y+td-1), bm);
        FreeAndNil(bm);
        Inc(nd);
        end;
end;

procedure TFormMain.PaintBoxStarPaint(Sender: TObject);
var Id   : TIdJoueur;
    bm   : TBitmap;
    pb   : TPaintBox;
    Rect : TRect;
begin
pb := Sender as TPaintBox;
Id := TIdJoueur(StrToInt(Copy(pb.Name,9,1)));
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
pb.Canvas.Brush.Color:=Couleur[cGris];
pb.Canvas.FillRect(Rect);
bm := TBitmap.Create;
VirtualImageListFnd.GetBitmap(Ord(cNoir), bm);
VirtualImageListStr.GetBitmap(Ord(CoulJr[Id]), bm);
pb.Canvas.StretchDraw(Rect, bm);
FreeAndNil(bm);
FreeAndNil(Rect);
end;

procedure TFormMain.PaintBoxActionClick(Sender: TObject);
var pb        : TPaintBox;
    Etat      : TEtatBouton;
begin
pb := Sender as TPaintBox;
Etat := TEtatBouton(pb.Tag);
case Etat of
  ebIndefini: Exit;
  ebOK:       if p.PhCrt = phResultatPose then
                begin
                if p.JoueurSuivant then
                  begin
                  AfficheTour;
                  LanceDe;
                  end
                else
                  FinDePartie
                end;
  ebStop:     begin
              TimerDe.Enabled := False;
              if AfficheCasesJouables = 0 then // Impossible de jouer
                ActionDe(p.DeCrt, edNonJoue)
              else // On peut poser le d�
                begin
                EtatBouton := ebIndefini;
                AfficheMessage(p.JrCrt, stMsgPlceDe);
                p.PhaseSuivante;
                end;
              end;
end{case Etat of};
end;

procedure TFormMain.PaintBoxActionPaint(Sender: TObject);
var bm   : TBitmap;
    pb   : TPaintBox;
    Rect : TRect;
begin
pb := Sender as TPaintBox;
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
pb.Canvas.Brush.Color:=Couleur[cGris];
pb.Canvas.FillRect(Rect);
bm := TBitmap.Create;
VirtualImageListFnd.GetBitmap(Ord(cNoir), bm);
if pb.Tag > 0 then
  VirtualImageListBtn.GetBitmap(pb.Tag-1, bm);
pb.Canvas.StretchDraw(Rect, bm);
FreeAndNil(bm);
FreeAndNil(Rect);
end;

procedure TFormMain.PaintBoxDePaint(Sender: TObject);
var bm   : TBitmap;
    pb   : TPaintBox;
    Rect : TRect;
begin
pb := Sender as TPaintBox;
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
pb.Canvas.Brush.Color:=Couleur[cGris];
pb.Canvas.FillRect(Rect);
bm := TBitmap.Create;
if p.JrCrt > jIndefini then
  VirtualImageListTde.GetBitmap(Ord(CoulJr[p.JrCrt]), bm);
if p.DeCrt > ndIndefini then
  VirtualImageListDes.GetBitmap(Ord(p.De[p.DeCrt].Face)-1, bm);
pb.Canvas.StretchDraw(Rect, bm);
FreeAndNil(bm);
FreeAndNil(Rect);
end;

procedure TFormMain.PaintBoxGrilleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var xCrt,
    yCrt : Integer;
    pb   : TPaintBox;
    tc   : Integer;
begin
if p = Nil then Exit;
if p.PhCrt <> phPoseDe then Exit;

pb := (Sender as TPaintBox);
tc := Min(pb.Width div TailleGrille, pb.Height div TailleGrille);
if Button = mbLeft then
  begin
  xCrt := X div tc;
  yCrt := Y div tc;
  if p.Jouable[xCrt, yCrt] then
    begin
    xPose := xCrt;
    yPose := yCrt;
    ActionDe(p.DeCrt, edPose);
    end
  else
    AfficheMessage(p.JrCrt, stMsgChxInc);
  end;
end;

procedure TFormMain.PaintBoxGrillePaint(Sender: TObject);
var bm   : TBitmap;
    pb   : TPaintBox;
    Rect : TRect;
    x, y : TCoordonnee;
    tc,
    tw,th: Integer;
    nd   : TNumDe;
    stSc : String;
begin
if p = Nil then Exit;
pb := (Sender as TPaintBox);
tc := Min(pb.Width div TailleGrille, pb.Height div TailleGrille);
for x := Low(TCoordonnee) to High(TCoordonnee) do
  for y:= Low(TCoordonnee) to High(TCoordonnee) do
    begin
    nd := p.Gr[x, y];
    Rect := TRect.Create(tc*Ord(x)+2, tc*Ord(y)+2, tc*Ord(x)+tc-2, tc*Ord(y)+tc-2);
    pb.Canvas.Brush.Color := Couleur[cGris];
    pb.Canvas.FillRect(Rect);
    bm := TBitmap.Create;
    if nd > ndIndefini then
      begin
      VirtualImageListFnd.GetBitmap(Ord(cGris), bm);
      VirtualImageListFDe.GetBitmap(Ord(CoulJr[p.De[nd].Jr]), bm);
      VirtualImageListDes.GetBitmap(Ord(p.De[nd].Face)-1, bm);
      pb.Canvas.StretchDraw(Rect, bm);
      end
    else
      if p.Jouable[x, y] then
        begin
        VirtualImageListFnd.GetBitmap(Ord(cGris), bm);
        VirtualImageListFDe.GetBitmap(Ord(CoulJr[p.JrCrt]), bm);
        pb.Canvas.StretchDraw(Rect, bm);
        if p.Scores[x, y]>0 then
          begin
          stSc := IntToStr(p.Scores[x, y]);
          with pb.Canvas do
            begin
            tw := TextWidth(stSc);
            th := TextHeight(stSc);
            Brush.Color := Couleur[CoulJr[p.JrCrt]];
            if CoulJr[p.JrCrt] = cJaune then
              Font.Color := clBlack
            else
              Font.Color := clWhite;
            TextOut(tc*Ord(x) + (tc-tw) div 2,
                    tc*Ord(y) + (tc-th) div 2, stSc);
            end;
          end;
        end;
    FreeAndNil(bm);
    end;
end;

procedure TFormMain.PaintBoxScorePaint(Sender: TObject);
var bm   : TBitmap;
    pb   : TPaintBox;
    Rect : TRect;
    Chf  : Integer;
begin
if p = Nil then Exit;
pb := Sender as TPaintBox;
case pb.Tag of
  0: Chf := p.Score(jGauche) div 100;
  1: Chf := (p.Score(jGauche) div 10) mod 10;
  2: Chf := p.Score(jGauche) mod 10;
  3: Chf := p.Score(jDroite) div 100;
  4: Chf := (p.Score(jDroite) div 10) mod 10;
  5: Chf := p.Score(jDroite) mod 10;
else
  Chf := 0;
end;
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
pb.Canvas.Brush.Color:=Couleur[cGris];
pb.Canvas.FillRect(Rect);
bm := TBitmap.Create;
VirtualImageListFnd.GetBitmap(Ord(cNoir), bm);
VirtualImageListChf.GetBitmap(NbCouleurs*Chf+Ord(CoulJr[TIdJoueur(1 + pb.Tag div 3)]), bm);
pb.Canvas.StretchDraw(Rect, bm);
FreeAndNil(bm);
end;

procedure TFormMain.PaintBoxTourPaint(Sender: TObject);
var pb   : TPaintBox;
    Rect : TRect;
    stTr : String;
begin
if p = Nil then Exit;
pb := Sender as TPaintBox;
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
stTr := Format('%d/%d', [p.TrCrt, NbTotalDes]);
with pb.Canvas do
  TextOut((Rect.Width - TextWidth(stTr)) div 2, (Rect.Height - TextHeight(stTr)) div 2, stTr);
end;

procedure TFormMain.TimerDeTimer(Sender: TObject);
begin
if p = Nil then Exit;
if p.DeCrt > ndIndefini then
  p.De[p.DeCrt].Face := TFaceDe(1+Random(6));
PaintBoxDe.Refresh
end;

procedure TFormMain.ColoreTexteJoueurs;
var j : TIdJoueur;
begin
for j := Succ(Low(TIdJoueur)) to High(TIdJoueur) do
  begin
  (FindComponent(stLabel+IntToStr(Ord(j))+stSfxCpt[cDRAJ]) as TLabel).Font.Color := Couleur[CoulJr[j]];
  (FindComponent(stLabel+IntToStr(Ord(j))+stSfxCpt[cDC]) as TLabel).Font.Color := Couleur[CoulJr[j]];
  (FindComponent(stLabel+IntToStr(Ord(j))+stSfxCpt[cDNJ]) as TLabel).Font.Color := Couleur[CoulJr[j]];
  (FindComponent(stPaintBox+IntToStr(Ord(j))+'Msg') as TPaintBox).Font.Color := Couleur[CoulJr[j]];
  end;
end;

(******************)
(* Actions de d�s *)
(******************)

procedure TFormMain.LanceDe;
begin
if p = Nil then Exit;
ActionDe(p.DeCrt, edLance);
end;

procedure TFormMain.ActionDe(NumDe : TNumDe; Etat: TEtatDe);
var ld  : TListeDes;
    nj,
    na,
    np  : Integer;
    plj,
    pla,
    plp : String;

begin
if p = Nil then Exit;
case Etat of
  edLance:     begin
               EtatBouton := ebStop;
               AfficheCompteur(cDRAJ, p.JrCrt);
               TimerDe.Enabled := True;
               end;
  edPose:      with p do
                 begin
                 PoseDe(NumDe, xPose, yPose);
                 ld := Nil;
                 if CaptureDes(NumDe, xPose, YPose, ld, True) then
                   begin
                   AfficheScore(JrCrt);
                   AfficheCompteur(cDC, JrCrt);
                   nj := ld.Des(p, jIndefini);
                   na := ld.Des(p, Adv[jrCrt]);
                   np := ld.Score(p, jIndefini);
                   plj := stPluriel[nj>1];
                   pla := stPluriel[na>1];
                   plp := stPluriel[np>1];
                   AfficheMessage(JrCrt, Format(stMsgResCpt, [nj, plj, na, pla, np, plp]), ebOK);
                   FreeAndNil(ld);
                   end
                 else
                   AfficheMessage(JrCrt, stMsgZeroPt, ebOK);
                 AfficheGrille;
                 p.PhaseSuivante; // Tour suivant
                 end;
  edNonJoue:   with p do
                 begin
                 PasseDe(NumDe);
                 AfficheMessage(JrCrt, stMsgPlcImp, ebOK);
                 AfficheCompteur(cDNJ, Adv[p.JrCrt]);
                 AfficheScore(Adv[p.JrCrt]);
                 p.PhaseSuivante; // On saute le placement
                 p.PhaseSuivante; // Tour suivant
                 end;
end{case of};
end;

(**************************)
(* Affichages par Refresh *)
(**************************)

procedure TFormMain.AfficheMessage(Id : TIdJoueur; stNvMsg : String; EtatBouton : TEtatBouton = ebIndefini);
var j,jd,jf : TIdJoueur;
begin
if Id = jIndefini then
  begin
  jd :=Succ(Low(TIdJoueur));
  jf :=High(TIdJoueur);
  end
else
  begin
  jd := Id;
  jf := Id;
  end;
for j:= jd to jf do
  begin
  stMsg[j] := stNvMsg;
  (FindComponent(stPaintBox+IntToStr(Ord(j))+'Msg') as TPaintBox).Refresh;
  end;
// On affiche le bouton
Self.EtatBouton := EtatBouton
end;

procedure TFormMain.AfficheCompteur(c : TCompteur; Id : TIdJoueur = jIndefini);
var j,jd,jf   : TIdJoueur;
    sc, nb    : Integer;
begin
if p = Nil then Exit;
if Id = jIndefini then
  begin
  jd :=Succ(Low(TIdJoueur));
  jf :=High(TIdJoueur);
  end
else
  begin
  jd := Id;
  jf := Id;
  end;
for j := jd to jf do
  begin
  // 1. Affichage des d�s
  (FindComponent(stPaintBox+IntToStr(Ord(j))+stSfxCpt[c]) as TPaintBox).Refresh;
  // 2. Affichage des scores entre parenth�ses apr�s les titres
  with FindComponent(stLabel+IntToStr(Ord(j))+stSfxCpt[c]) as TLabel do
    begin
    nb := p.Compte(j, c);
    sc := p.Score(j, c);
    if sc = 0 then
      Caption := Copy(Caption, 1, Pos('(', Caption)) + Format('%d)', [nb])
    else
      Caption := Copy(Caption, 1, Pos('(', Caption)) + Format('%d, %d pt%s)', [nb, sc, stPluriel[sc>1]]);
    end;
  end;
end;

procedure TFormMain.AfficheCompteurs(Id : TIdJoueur = jIndefini);
var c : TCompteur;
begin
for c := Low(TCompteur) to High(TCompteur) do
  AfficheCompteur(c, Id);
end;

procedure TFormMain.AfficheScore(Id : TIdJoueur = jIndefini);
var d       : TDigit;
    j,jd,jf : TIdJoueur;
begin
if Id = jIndefini then
  begin
  jd :=Succ(Low(TIdJoueur));
  jf :=High(TIdJoueur);
  end
else
  begin
  jd := Id;
  jf := Id;
  end;
for j:= jd to jf do
  for d := Low(TDigit) to High(TDigit) do
    (FindComponent(stPaintBox+IntToStr(Ord(j))+'Score'+stDigit[d]) as TPaintBox).Refresh;
end;

procedure TFormMain.AfficheTour;
begin
AfficheMessage(p.JrCrt, Format(stMsgTourJr, [stNomCl[CoulJr[p.JrCrt]]]));
AfficheMessage(Adv[p.JrCrt], stMsgAtteJr);
PaintBoxTour.Refresh;
end;

function TFormMain.AfficheCasesJouables : Integer;
begin
Result := 0;
if p = Nil then Exit;
Result := p.MarqueCasesJouables;
PaintBoxGrille.Refresh;
end;

procedure TFormMain.AfficheGrille;
begin
PaintBoxGrille.Refresh
end;

procedure TFormMain.AfficheStars;
var Id : TIdJoueur;
    ab : Char;
begin
for Id := Succ(Low(TIdJoueur)) to High(TIdJoueur) do
  for ab := 'A' to 'B' do
    (FindComponent(stPaintBox+IntToStr(Ord(Id))+'Star'+ab) as TPaintBox).Refresh;
end;

(* Autres m�thodes *)
procedure TFormMain.ChangeEtatBouton(NvEtatBouton : TEtatBouton);
begin
with PaintBoxAction do
  begin
  Tag := Ord(NvEtatBouton);
  Refresh
  end;
end;

function TFormMain.DonneEtatBouton : TEtatBouton;
begin
Result := TEtatBouton(PaintBoxAction);
end;

procedure TFormMain.FinDePartie;
var sg, sd : Integer;
begin
EtatBouton := ebIndefini;
sg := p.Score(jGauche);
sd := p.Score(jDroite);
if sg > sd then
  begin
  AfficheMessage(jGauche, stMsgAGagne);
  AfficheMessage(jDroite, stMsgAPerdu);
  end;
if sg < sd then
  begin
  AfficheMessage(jDroite, stMsgAGagne);
  AfficheMessage(jGauche, stMsgAPerdu);
  end;
if sg = sd then
  begin
  AfficheMessage(jDroite, stMsgEgalite);
  AfficheMessage(jGauche, stMsgEgalite);
  end;
end;

end.
