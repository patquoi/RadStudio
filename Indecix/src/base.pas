unit base;

interface

const
  TailleGrille    = 6;
  NbTotalDes      = 36;
  Capturer        = True;
  NePasCapturer   = False;

type
  TDirection  = (dIndefinie=0, dNord=1, dEst=2, dSud=3, dOuest=4);
  TIdJoueur   = (jIndefini=0, jGauche=1, jDroite=2);
  TOrientation = (oHorizontale=0, oVerticale=1);

const
  dx   : array[TDirection] of Integer   = (0, 0, 1, 0, -1);
  dy   : array[TDirection] of Integer   = (0, -1, 0, 1, 0);
  Adv  : array[TIdJoueur]  of TIdJoueur = (jIndefini, jDroite, jGauche);
  DirO : array[TOrientation] of TDirection = (dSud, dEst);

type
  TCoordonnee = 0..TailleGrille-1;
  TFaceDe     = (fdUn=1, fdDeux=2, fdTrois=3, fdQuatre=4, fdCinq=5, fdSix=6);
  TNumDe      = (ndIndefini=0, ndG01, ndD01, ndG02, ndD02, ndG03, ndD03, ndG04, ndD04, ndG05, ndD05, ndG06, ndD06,
                               ndG07, ndD07, ndG08, ndD08, ndG09, ndD09, ndG10, ndD10, ndG11, ndD11, ndG12, ndD12,
                               ndG13, ndD13, ndG14, ndD14, ndG15, ndD15, ndG16, ndD16, ndG17, ndD17, ndG18, ndD18);
  TGrille     = array [TCoordonnee, TCoordonnee] of TNumDe;
  TMarquage   = array [TCoordonnee, TCoordonnee] of Boolean;
  TScore      = array [TCoordonnee, TCoordonnee] of Integer;
  TEtatDe     = (edEnAttente, edLance, edPose, edNonJoue, edCapture);
  TCompteur   = (cDRAJ, cDC, cDNJ);

  TPhaseJeu   = (phIndefinie=0, phLanceDes=1, phPoseDe=2, phResultatPose=3);

  TDe = class
    Id : TNumDe;
    Jr, Vq : TIdJoueur; // Si Etat = edCapture alors Vq est le joueur l'ayant capturé (par défaut Vq=Jr) ; Si Etat = edNonJoue alors Vq = Adv[Jr]
    x, y : Integer; // si (0,0), dé non posé
    Etat : TEtatDe;
    Tour : Integer; // Tour de la dernière action
    FFace : TFaceDe;
    procedure Change(NvFace : TFaceDe);
  public
    procedure Initialise;
    constructor Create(NumDe : TNumDe);
    destructor Destroy; override;
    property Face : TFaceDe read FFace write Change;
  end{class TDe};

  TPartie = class;

  TListeDes = class
    NumDe : TNumDe;
    Svt : TListeDes;
  public
    constructor Create(PrmNumDe : TNumDe);
    destructor Destroy; override;
    procedure AjouteDe(NvNumDe : TNumDe);
    function Des(p : TPartie; Id : TIdJoueur) : Integer; // Si Id = jIndefini alors nombre total de dés sinon nombre de dés de Id
    function Score(p : TPartie; Id : TIdJoueur) : Integer; // Score pour p.JrCrt : Si Id = jIndefini alors Score total sinon Score des dés de Id
  end{class TListeDes};

  TJoueur = class
    Id : TIdJoueur;
    Automate : Boolean;
  public
    constructor Create(IdJoueur : TIdJoueur);
    destructor Destroy; override;
  end{class TJoueur};

  TJoueurs     = array [TIdJoueur] of TJoueur;
  TDes         = array [TNumDe] of TDe;

  TSuiteDes = class
    x, y : Integer; // Case où a été "créée" la suite
    Jr : TIdJoueur; // Joueur ayant posé le dé en (x, y)
    o : TOrientation; // Horizontal (ligne) ou vertical (colonne)
    Pos : TCoordonnee; // dans la grille (ligne ou colonne selon l'orientation)
    procedure Initialise;
  public
    constructor Create(o : TOrientation; Pos : TCoordonnee);
    destructor Destroy; override;
    procedure Affecte(Jr : TIdJoueur; x, y : TCoordonnee);
    function CreateurSiExiste(Gr : TGrille) : TIdJoueur; // Si la suite existe, renvoie son créateur, sinon jIndefini
    function PropreSiExiste(Gr: TGrille) : Boolean; // Retourne Vrai si tous les dés de la suite appartiennent au créateur (Score x2)
  end{class TSuiteDes};

  TSuitesDes = array [TOrientation, TCoordonnee] of TSuiteDes;

  TPartie = class
    Gr      : TGrille;
    Jouable : TMarquage;
    Scores  : TScore;
    Jr      : TJoueurs;
    De      : TDes;
    TrCrt   : Integer;
    JrCrt   : TIdJoueur;
    DeCrt   : TNumDe;
    PhCrt   : TPhaseJeu;
    Suites  : TSuitesDes;
    procedure InitialiseGrille;
    procedure InitialiseMarquage;
    function DeSuivant : Boolean; // Retourne Faux si plus de dés à jouer (fin de partie)
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initialise;
    function JoueurSuivant : Boolean; // Retourne Faux si fin de partie
    procedure Nouvelle;
    procedure ChangeEtatDe(NumDe : TNumDe; NvEtat : TEtatDe);
    procedure PoseDe(NumDe : TNumDe; xPose, yPose : Integer);
    procedure PasseDe(NumDe : TNumDe);
    procedure CaptureDe(NumDe : TNumDe);
    function CaptureDes(NumDe : TNumDe; x, y : TCoordonnee; var ListeDes : TListeDes; bCapturer : Boolean) : Boolean; // Retourne vrai si au moins un dé est capturé
    function EstJouable(d : TNumDe; x, y : TCoordonnee) : Boolean;
    function MarqueCasesJouables : Integer; // Retourne le nombre de cases jouables
    function Compte(j : TIdJoueur; c : TCompteur) : Integer;
    function Score(j : TIdJoueur; c : TCompteur) : Integer; overload;
    function Score(j : TIdJoueur) : Integer; overload;
    procedure PhaseSuivante;
    function CreateurSuite(x, y : TCoordonnee) : TIdJoueur;
    function SuiteCree(x, y : TCoordonnee) : Boolean; // Retourne Vrai si une suite vient d'être créée en posant un dé en (x,y)
  end{class TPartie};

var
  p : TPartie;

function CoordonneesValides(x, y : Integer) : Boolean;

implementation

uses
  System.SysUtils;


(* Fonctions générales *)

function CoordonneesValides(x, y : Integer) : Boolean;
begin
Result := (x >= Ord(Low(TCoordonnee))) and
          (x <= Ord(High(TCoordonnee))) and
          (y >= Ord(Low(TCoordonnee))) and
          (y <= Ord(High(TCoordonnee)));
end;

(* Class TDe *)

procedure TDe.Initialise;
begin
Self.Vq := Self.Jr;
Self.x := -1;
Self.y := -1;
Self.Etat := edEnAttente;
Self.Tour := 0;
Self.FFace := TFaceDe(1+((Ord(Self.Id)-1) div 2) mod 6); // Un dé a toujours une face !
end;

constructor TDe.Create(NumDe : TNumDe);
begin
Self.Id := NumDe;
Self.Jr := TIdJoueur(1 + (Ord(NumDe) - 1) mod 2);
Initialise;
end;

destructor TDe.Destroy;
begin
inherited Destroy;
end;

procedure TDe.Change(NvFace : TFaceDe);
begin
FFace := NvFace;
end;

(* Class TListeDes *)

constructor TListeDes.Create(PrmNumDe : TNumDe);
begin
Self.NumDe := PrmNumDe;
Svt := Nil;
end;

destructor TListeDes.Destroy;
begin
if Svt <> Nil then Svt.Free;
inherited Destroy;
end;

procedure TListeDes.AjouteDe(NvNumDe : TNumDe);
begin
if Svt <> Nil then
  Svt.AjouteDe(NvNumDe)
else
  Svt := TListeDes.Create(NvNumDe);
end;

function TListeDes.Des(p : TPartie; Id : TIdJoueur) : Integer;
begin
Result := Ord((Id = jIndefini) or (Id = p.De[NumDe].Jr));
if Svt <> nil then
  Inc(Result, Svt.Des(p, Id));
end;

function TListeDes.Score(p : TPartie; Id : TIdJoueur) : Integer;
begin
Result := Ord(p.De[NumDe].Face) * (1 + Ord(p.JrCrt <> p.De[NumDe].Jr));
if Svt <> Nil then
  Inc(Result, Svt.Score(p, Id));
end;

(* Class TJoueur *)

constructor TJoueur.Create(IdJoueur : TIdJoueur);
begin
Id := IdJoueur;
Automate := False;
end;

destructor TJoueur.Destroy;
begin
inherited Destroy;
end;

(* Class TSuiteDes *)

procedure TSuiteDes.Initialise;
begin
// Données du futur créateur de la suite
Self.x := -1; Self.y := -1;
Self.Jr := jIndefini;
end;

constructor TSuiteDes.Create(o : TOrientation; Pos : TCoordonnee);
begin
Self.o := o;
Self.Pos := Pos;
Initialise
end;

destructor TSuiteDes.Destroy;
begin
inherited Destroy;
end;

procedure TSuiteDes.Affecte(Jr : TIdJoueur; x, y : TCoordonnee);
begin
Self.Jr := Jr;
Self.x := x;
Self.y := y;
end;

function TSuiteDes.CreateurSiExiste(Gr : TGrille) : TIdJoueur;
var c : TCoordonnee;
begin
Result := Self.Jr;
If Result = jIndefini then Exit;
for c := Low(TCoordonnee) to High(TCoordonnee) do
  case o of
    oHorizontale: if Gr[c, y] = ndIndefini then
                    begin
                    Result := jIndefini;
                    break;
                    end;
    oVerticale:   if Gr[x, c] = ndIndefini then
                    begin
                    Result := jIndefini;
                    break;
                    end;
  end
end;

function TSuiteDes.PropreSiExiste(Gr: TGrille) : Boolean;
var c : TCoordonnee;
begin
Result := True; // Optimiste !
for c := Low(TCoordonnee) to High(TCoordonnee) do
  case o of
    oHorizontale: if (Gr[c, y] = ndIndefini) or
                     (TIdJoueur(1 + Ord(Gr[c, y]) mod 2) <> Self.Jr) then
                    begin
                    Result := False;
                    break;
                    end;
    oVerticale:   if (Gr[x, c] = ndIndefini) or
                     (TIdJoueur(1 + Ord(Gr[x, c]) mod 2) <> Self.Jr) then
                    begin
                    Result := False;
                    break;
                    end;
  end
end;

(* Class TPartie *)

procedure TPartie.InitialiseGrille;
var x, y : TCoordonnee;
begin
for x := Low(TCoordonnee) to High(TCoordonnee) do
  for y := Low(TCoordonnee) to High(TCoordonnee) do
    Gr[x, y] := ndIndefini;
end;

procedure TPartie.InitialiseMarquage;
var x, y : TCoordonnee;
begin
for x := Low(TCoordonnee) to High(TCoordonnee) do
  for y := Low(TCoordonnee) to High(TCoordonnee) do
    begin
    Jouable[x, y] := False;
    Scores[x, y] := 0;
    end;
end;

constructor TPartie.Create;
var j : TIdJoueur;
    d : TNumDe;
    o : TOrientation;
    c : TCoordonnee;
begin
InitialiseGrille;
for j := Low(TIdJoueur) to High(TIdJoueur) do
  if j > jIndefini then
    Jr[j] := TJoueur.Create(j)
  else
    Jr[j] := Nil;
for d := Low(TNumDe) to High(TNumDe) do
  if d > ndIndefini then
    De[d] := TDe.Create(d)
  else
    De[d] := Nil;
for o := Low(TOrientation) to High(TOrientation) do
  for c := Low(TCoordonnee) to High(TCoordonnee) do
    Suites[o, c] := TSuiteDes.Create(o, c);
JrCrt := jIndefini;
DeCrt := ndIndefini;
end;

destructor TPartie.Destroy;
var j : TIdJoueur;
    d : TNumDe;
    o : TOrientation;
    c : TCoordonnee;
begin
for j := Low(TIdJoueur) to High(TIdJoueur) do
  if j > jIndefini then
    Jr[j].Free;
for d := Low(TNumDe) to High(TNumDe) do
  if d > ndIndefini then
    De[d].Free;
for o := Low(TOrientation) to High(TOrientation) do
  for c := Low(TCoordonnee) to High(TCoordonnee) do
    Suites[o, c].Free;
inherited Destroy;
end;

procedure TPartie.Initialise;
var d : TNumDe;
begin
InitialiseGrille;
for d := Low(TNumDe) to High(TNumDe) do
  if d > ndIndefini then
    De[d].Initialise;
TrCrt := 0;
JrCrt := jIndefini;
DeCrt := ndIndefini;
PhCrt := phIndefinie;
end;

function TPartie.DeSuivant : Boolean;
begin
if DeCrt<High(TNumDe) then
  begin
  DeCrt := Succ(DeCrt);
  De[DeCrt].Etat := edLance;
  PhCrt := phLanceDes;
  Result := True;
  end
else
  Result := False;
end;

function TPartie.JoueurSuivant : Boolean;
begin
if DeSuivant then
  begin
  Inc(TrCrt);
  case JrCrt of
    jIndefini: JrCrt := jGauche;
    jGauche: JrCrt := jDroite;
    jDroite: JrCrt := jGauche;
  end;
  Result := True;
  end
else // Plus de dés à jouer : Fin de partie
  Result := False;
end;

procedure TPartie.Nouvelle;
begin
Initialise;
JoueurSuivant;
end;

procedure TPartie.ChangeEtatDe(NumDe : TNumDe; NvEtat : TEtatDe);
begin
with De[NumDe] do
  begin
  Etat := NvEtat;
  Tour := TrCrt;
  end;
end;

procedure TPartie.PoseDe(NumDe : TNumDe; xPose, yPose : Integer);
begin
ChangeEtatDe(NumDe, edPose);
with De[NumDe] do
  begin
  x := xPose;
  y := yPose;
  Tour := TrCrt;
  end;
Gr[xPose, yPose] := NumDe;
InitialiseMarquage;
phCrt := phPoseDe;
end;

procedure TPartie.PasseDe(NumDe : TNumDe);
begin
ChangeEtatDe(NumDe, edNonJoue);
with De[NumDe] do
  begin
  Vq := Adv[JrCrt];
  Tour := TrCrt;
  end
end;

procedure TPartie.CaptureDe(NumDe : TNumDe);
begin
ChangeEtatDe(NumDe, edCapture);
Gr[De[NumDe].x, De[NumDe].y] := ndIndefini;
with De[NumDe] do
  begin
  Vq := JrCrt;
  x := -1;
  y := -1;
  Tour := TrCrt;
  end;
end;

function TPartie.CaptureDes(NumDe : TNumDe; x, y : TCoordonnee; var ListeDes : TListeDes; bCapturer : Boolean) : Boolean;
var d     : TDirection;
    k, kk,
    kd,kf : Integer;
    f0,fb : TFaceDe; // f0 = Face du dé posé ; fb = Face de la borne
    ndac,
    ndkk,
    Borne : TNumDe;
    KO    : Boolean;
begin
Result := False;
f0 := De[NumDe].Face;
for d := dEst to dSud do
  begin

  // 1. Avant le dé posé
  kd := -1;
  while CoordonneesValides(x+kd*dx[d], y+kd*dy[d]) and
        (Gr[x+kd*dx[d], y+kd*dy[d]] > ndIndefini) do
    Dec(kd);
  Inc(kd);
  for k := kd to -2 do
    begin // Il faut qu'entre les deux dés NumDe et Borne, il n'y ait que des dés dont la face est comprise entre f0 et fb
    Borne := Gr[x+k*dx[d], y+k*dy[d]];
    fb := De[Borne].Face;
    KO := False;
    for kk := k+1 to -1 do
      begin
      ndkk := Gr[x+kk*dx[d], y+kk*dy[d]];
      if ((De[ndkk].Face > fb) and
          (De[ndkk].Face < f0)) or
         ((De[ndkk].Face > f0) and
          (De[ndkk].Face < fb)) then
        continue
      else
        begin
        KO := True;
        break;
        end;
      end;
    if KO then
      continue
    else // Tous les dés entre NumDe et Borne sont capturés
      begin
      for kk := k+1 to -1 do
        begin
        Result:=True;
        ndac := Gr[x+kk*dx[d], y+kk*dy[d]];
        if bCapturer then CaptureDe(ndac);
        if ListeDes = Nil then
          ListeDes := TListeDes.Create(ndac)
        else
          ListeDes.AjouteDe(ndac);
        end;
      break;
      end;
    end;

  // 2. Après le dé posé
  kf := 1;
  while CoordonneesValides(x+kf*dx[d], y+kf*dy[d]) and (Gr[x+kf*dx[d], y+kf*dy[d]] > ndIndefini) do
    Inc(kf);
  Dec(kf);
  for k := 2 to kf do
    begin // Il faut qu'entre les deux dés NumDe et Borne, il n'y ait que des dés dont la face est comprise entre f0 et fb
    Borne := Gr[x+k*dx[d], y+k*dy[d]];
    fb := De[Borne].Face;
    KO := False;
    for kk := 1 to k-1 do
      begin
      ndkk := Gr[x+kk*dx[d], y+kk*dy[d]];
      if ((De[ndkk].Face > fb) and
          (De[ndkk].Face < f0)) or
         ((De[ndkk].Face > f0) and
          (De[ndkk].Face < fb)) then
        continue
      else
        begin
        KO := True;
        break;
        end;
      end;
    if KO then
      continue
    else // Tous les dés entre NumDe et Borne sont capturés
      begin
      for kk := 1 to k-1 do
        begin
        Result := True;
        ndac := Gr[x+kk*dx[d], y+kk*dy[d]];
        if bCapturer then CaptureDe(ndac);
        if ListeDes = Nil then
          ListeDes := TListeDes.Create(ndac)
        else
          ListeDes.AjouteDe(ndac);
        end;
      break;
      end;
    end;
  end;

end;

function TPartie.EstJouable(d : TNumDe; x, y : TCoordonnee) : Boolean;
var i : TCoordonnee;
begin
Result := False; // Pessimiste !
if Gr[x, y] > ndIndefini then
  Exit; // Case cible occupée
for i := Low(TCoordonnee) to High(TCoordonnee) do
  begin
  if (Gr[i, y] > ndIndefini) and (De[Gr[i, y]].Face = De[d].Face) then
    Exit; // Dé de même valeur sur la ligne y
  if (Gr[x, i] > ndIndefini) and (De[Gr[x, i]].Face = De[d].Face) then
    Exit; // Dé de même valeur sur la colonne x
  end;
Result := True; // Tout est ok !
end;

function TPartie.MarqueCasesJouables : Integer;
var x, y : TCoordonnee;
    ld   : TListeDes;
begin
Result := 0;
for x := Low(TCoordonnee) to High(TCoordonnee) do
  for y := Low(TCoordonnee) to High(TCoordonnee) do
    if EstJouable(DeCrt, x, y) then
      begin
      Jouable[x, y] := True;
      Inc(Result);
      ld := Nil;
      if CaptureDes(p.DeCrt, x, y, ld, NePasCapturer) then
        begin
        Scores[x, y] := ld.Score(Self, p.JrCrt);
        FreeAndNil(ld);
        end
      end;
end;

function TPartie.Compte(j : TIdJoueur; c : TCompteur) : Integer;
var nd : TNumDe;
    n  : Integer;
begin
n := 0;
case c of
    cDRAJ: for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((De[nd].Jr = j) and (De[nd].Etat = edEnAttente)));
    cDC:   for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((De[nd].Vq = j) and (De[nd].Etat = edCapture)));
    cDNJ:  for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((De[nd].Jr = Adv[j]) and (De[nd].Etat = edNonJoue)));
  end;
Result := n;
end;

function TPartie.Score(j : TIdJoueur; c : TCompteur) : Integer;
var nd : TNumDe;
    s  : Integer;
begin
s := 0;
case c of
    cDC:   for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(s, Ord(De[nd].Face)*(Ord((De[nd].Vq = j) and (De[nd].Etat = edCapture))*(1+Ord(De[nd].Jr = Adv[j]))));
    cDNJ:  for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(s, Ord((De[nd].Jr = Adv[j]) and (De[nd].Etat = edNonJoue)));
  end;
Result := s;
end;

function TPartie.Score(j : TIdJoueur) : Integer;
begin
Result := Score(j, cDC) + Score(j, cDNJ);
end;

procedure TPartie.PhaseSuivante;
begin
if PhCrt < phResultatPose then
  PhCrt := Succ(PhCrt);
end;

function TPartie.CreateurSuite(x, y : TCoordonnee) : TIdJoueur;
var jv, jh : TIdJoueur;
begin
Result := jIndefini; // Pessimiste
jv := Suites[oVerticale, x].CreateurSiExiste(Self.Gr);
jh := Suites[oHorizontale, y].CreateurSiExiste(Self.Gr);
if (jv = jIndefini) and (jh > jIndefini) then
  Result := jh;
if (jh = jIndefini) and (jv > jIndefini) then
  Result := jv;
end;

function TPartie.SuiteCree(x, y : TCoordonnee) : Boolean;
var c : TCoordonnee;
    o : TOrientation;
begin
Result := True; // Optimiste !
for o := Low(TOrientation) to High(TOrientation) do
  for c := Low(TCoordonnee) to High(TCoordonnee) do
    case o of
      oHorizontale: if Gr[c, y] = ndIndefini then
                      begin
                      Result := False;
                      break;
                      end;
      oVerticale:   if Gr[x, c] = ndIndefini then
                      begin
                      Result := False;
                      break;
                      end;
    end
end;

initialization
p := TPartie.Create;

finalization
FreeAndNil(p);

end.
