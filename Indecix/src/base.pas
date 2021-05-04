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
  TCompteur   = (cDRAJ, cDC, cDNJ, cSM, cSP); // Dés Restant À Jouer, Dés Capturés, Dés Non Joués, Suite Mixtes, Suites Propres
  TPhaseJeu   = (phIndefinie=0, phLanceDes=1, phPoseDe=2, phResultatPose=3);
  TTour       = 0..NbTotalDes;

  TDe = class
    Id : TNumDe;
    Jr, Vq : TIdJoueur; // Si Etat = edCapture alors Vq est le joueur l'ayant capturé (par défaut Vq=Jr) ; Si Etat = edNonJoue alors Vq = Adv[Jr]
    x, y : Integer; // si (0,0), dé non posé
    Etat : TEtatDe;
    Tour : TTour; // Tour de la dernière action
    FFace : TFaceDe;
    procedure Change(NvFace : TFaceDe);
  public
    procedure Initialise;
    constructor Create(NumDe : TNumDe);
    destructor Destroy; override;
    property Face : TFaceDe read FFace write Change;
  end{class TDe};

  TPartie = class;

  TDes = array [TNumDe] of TDe;

  TListeDes = class
    NumDe : TNumDe;
    Svt : TListeDes;
  public
    constructor Create(PrmNumDe : TNumDe);
    destructor Destroy; override;
    procedure AjouteDe(NvNumDe : TNumDe);
    function Des(d : TDes; Id : TIdJoueur) : Integer; // Si Id = jIndefini alors nombre total de dés sinon nombre de dés de Id
    function Score(d: TDes; JrCrt, Id : TIdJoueur) : Integer; // Score pour p.JrCrt : Si Id = jIndefini alors Score total sinon Score des dés de Id
  end{class TListeDes};

  TJoueur = class
    Id : TIdJoueur;
    Automate : Boolean;
  public
    constructor Create(IdJoueur : TIdJoueur);
    destructor Destroy; override;
  end{class TJoueur};

  TJoueurs     = array [TIdJoueur] of TJoueur;

  TSuiteDes = class
    x, y : Integer; // Case où a été "créée" la suite
    Tr : TTour; // Tour pendant lequel la suite a été créée
    Jr : TIdJoueur; // Joueur ayant posé le dé en (x, y)
    o : TOrientation; // Horizontal (ligne) ou vertical (colonne)
    Pos : TCoordonnee; // dans la grille (ligne ou colonne selon l'orientation)
    Propre : Boolean; // Vrai si tous les dés appartiennent à Self.Jr.
    procedure Initialise;
  public
    constructor Create(o : TOrientation; Pos : TCoordonnee);
    destructor Destroy; override;
    procedure Affecte(Jr : TIdJoueur; x, y : TCoordonnee; Propre : Boolean);
    function ExisteTjrs(Gr : TGrille) : Boolean; // Retourne Vrai si la suite est toujours présente
    function Score(Gr : TGrille; Des : TDes) : Integer; // Calcule le score en fonction du type de suite (x2 si propre) et du dé posé (à ne pas comptabiliser)
  end{class TSuiteDes};

  TSuitesDes = array [TOrientation, TCoordonnee] of TSuiteDes;

  TPartie = class
    Gr      : TGrille;
    Jouable : TMarquage;
    Scores  : TScore;
    Jr      : TJoueurs;
    Des     : TDes;
    TrCrt   : TTour;
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
    function CreeSuite(x, y : TCoordonnee) : Boolean; // Retourne Vrai si une suite est créée en posant le dé en (x,y)
    function SuiteCree(x, y : TCoordonnee) : Boolean; // Retourne Vrai si une suite vient d'être créée en posant un dé en (x,y) : alimente Suites
  end{class TPartie};

var
  stRepLocalAppData : String;
  p                 : TPartie;

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

procedure InitialiseRepLocalAppData;
const stVarLocalAppData  = 'LOCALAPPDATA';
      stVarUserProfile   = 'USERPROFILE';
      stRepLocAppDataPrdc = '\Patquoi.fr\Indecix';
var stExePath : String;
begin
stExePath := ExtractFilePath(ParamStr(0));
stRepLocalAppData := GetEnvironmentVariable(stVarLocalAppData);
if stRepLocalAppData = '' then
  begin
  stRepLocalAppData := GetEnvironmentVariable(stVarUserProfile);
  if stRepLocalAppData = '' then
    stRepLocalAppData := stExePath // Dossier de Paradice.exe
  else
    begin
	  stRepLocalAppData := stRepLocalAppData + '\Local Settings\Application Data' + stRepLocAppDataPrdc;
	  if not DirectoryExists(stRepLocalAppData) then
		  if not ForceDirectories(stRepLocalAppData) then
        stRepLocalAppData := stExePath // Dossier de Paradice.exe
      else
        stRepLocalAppData:=stRepLocalAppData+'\'
    else
      stRepLocalAppData:=stRepLocalAppData+'\';
    end;
  end
else
  begin
  stRepLocalAppData := stRepLocalAppData + stRepLocAppDataPrdc;
  if not DirectoryExists(stRepLocalAppData) then
    if not ForceDirectories(stRepLocalAppData) then
      stRepLocalAppData:=stExePath // Dossier de Paradice.exe
    else
      stRepLocalAppData:=stRepLocalAppData+'\'
  else
    stRepLocalAppData:=stRepLocalAppData+'\';
  end
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

function TListeDes.Des(d : TDes; Id : TIdJoueur) : Integer;
begin
Result := Ord((Id = jIndefini) or (Id = d[NumDe].Jr));
if Svt <> nil then
  Inc(Result, Svt.Des(d, Id));
end;

function TListeDes.Score(d : TDes; JrCrt, Id : TIdJoueur) : Integer;
begin
Result := Ord(d[NumDe].Face) * (1 + Ord(JrCrt <> d[NumDe].Jr));
if Svt <> Nil then
  Inc(Result, Svt.Score(d, JrCrt, Id));
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
Self.Propre := False;
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

procedure TSuiteDes.Affecte(Jr : TIdJoueur; x, y : TCoordonnee; Propre : Boolean);
begin
Self.Jr := Jr;
Self.x := x;
Self.y := y;
Self.Propre := Propre;
end;

function TSuiteDes.ExisteTjrs(Gr : TGrille) : Boolean;
var c : TCoordonnee;
begin
Result := False;
if Self.Jr = jIndefini then Exit; // Suite non créée
Result := True; // Optimiste
for c := Low(TCoordonnee) to High(TCoordonnee) do
  case o of
    oHorizontale: if Gr[c, y] = ndIndefini then
                    begin
                    Result := False;
                    Exit;
                    end;
    oVerticale:   if Gr[x, c] = ndIndefini then
                    begin
                    Result := False;
                    Exit;
                    end;
  end{case o of};
end;

function TSuiteDes.Score(Gr : TGrille; Des : TDes) : Integer;
var c : TCoordonnee;
begin
Result := 0;
if Self.Jr = jIndefini then Exit; // Suite non créée
for c := Low(TCoordonnee) to High(TCoordonnee) do
  case o of
    oHorizontale: if Gr[c, y] = ndIndefini then
                    begin
                    Result := 0; // La suite a été cassée
                    Exit;
                    end
                  else
                    if c <> x then // On ne compte pas le dé créateur de la suite (score entre 15 et 20)
                      Inc(Result, Ord(Des[Gr[c, y]].Face));
    oVerticale:   if Gr[x, c] = ndIndefini then
                    begin
                    Result := 0; // La suite a été cassée
                    Exit;
                    end
                  else
                    if c <> y then // On ne compte pas le dé créateur de la suite (score entre 15 et 20)
                      Inc(Result, Ord(Des[Gr[x, c]].Face));
  end{case o of};
if Propre then // Score x2
  Inc(Result, Result);
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
    Des[d] := TDe.Create(d)
  else
    Des[d] := Nil;
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
    Des[d].Free;
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
    Des[d].Initialise;
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
  Des[DeCrt].Etat := edLance;
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
with Des[NumDe] do
  begin
  Etat := NvEtat;
  Tour := TrCrt;
  end;
end;

procedure TPartie.PoseDe(NumDe : TNumDe; xPose, yPose : Integer);
begin
ChangeEtatDe(NumDe, edPose);
with Des[NumDe] do
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
with Des[NumDe] do
  begin
  Vq := Adv[JrCrt];
  Tour := TrCrt;
  end
end;

procedure TPartie.CaptureDe(NumDe : TNumDe);
begin
ChangeEtatDe(NumDe, edCapture);
Gr[Des[NumDe].x, Des[NumDe].y] := ndIndefini;
with Des[NumDe] do
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
f0 := Des[NumDe].Face;
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
    fb := Des[Borne].Face;
    KO := False;
    for kk := k+1 to -1 do
      begin
      ndkk := Gr[x+kk*dx[d], y+kk*dy[d]];
      if ((Des[ndkk].Face > fb) and
          (Des[ndkk].Face < f0)) or
         ((Des[ndkk].Face > f0) and
          (Des[ndkk].Face < fb)) then
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
    fb := Des[Borne].Face;
    KO := False;
    for kk := 1 to k-1 do
      begin
      ndkk := Gr[x+kk*dx[d], y+kk*dy[d]];
      if ((Des[ndkk].Face > fb) and
          (Des[ndkk].Face < f0)) or
         ((Des[ndkk].Face > f0) and
          (Des[ndkk].Face < fb)) then
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
  if (Gr[i, y] > ndIndefini) and (Des[Gr[i, y]].Face = Des[d].Face) then
    Exit; // Dé de même valeur sur la ligne y
  if (Gr[x, i] > ndIndefini) and (Des[Gr[x, i]].Face = Des[d].Face) then
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
        Scores[x, y] := ld.Score(Des, JrCrt, JrCrt);
        FreeAndNil(ld);
        end
      end;
end;

function TPartie.Compte(j : TIdJoueur; c : TCompteur) : Integer;
var nd : TNumDe;
    n  : Integer;
    o  : TOrientation;
    co : TCoordonnee;
begin
n := 0;
case c of
    cDRAJ: for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((Des[nd].Jr = j) and (Des[nd].Etat = edEnAttente)));
    cDC:   for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((Des[nd].Vq = j) and (Des[nd].Etat = edCapture)));
    cDNJ:  for nd := Succ(Low(TNumDe)) to High(TNumDe) do
             Inc(n, Ord((Des[nd].Jr = Adv[j]) and (Des[nd].Etat = edNonJoue)));
    cSM:   for o := Low(TOrientation) to High(TOrientation) do
             for co := Low(TCoordonnee) to High(TCoordonnee) do
               with Suites[o, co] do
                 if ExisteTjrs(Gr) then
                   Inc(n, Ord((Jr = j) and not Propre));
    cSP:   for o := Low(TOrientation) to High(TOrientation) do
             for co := Low(TCoordonnee) to High(TCoordonnee) do
               with Suites[o, co] do
                 if ExisteTjrs(Gr) then
                   Inc(n, Ord((Jr = j) and Propre));
  end;
Result := n;
end;

function TPartie.Score(j : TIdJoueur; c : TCompteur) : Integer;
var nd : TNumDe;
    s  : Integer;
    o  : TOrientation;
    co : TCoordonnee;
begin
s := 0;
case c of
    cDC:      for nd := Succ(Low(TNumDe)) to High(TNumDe) do
                Inc(s, Ord(Des[nd].Face)*(Ord((Des[nd].Vq = j) and (Des[nd].Etat = edCapture))*(1+Ord(Des[nd].Jr = Adv[j]))));
    cDNJ:     for nd := Succ(Low(TNumDe)) to High(TNumDe) do
                Inc(s, Ord((Des[nd].Jr = Adv[j]) and (Des[nd].Etat = edNonJoue)));
    cSM:      for o := Low(TOrientation) to High(TOrientation) do
                for co := Low(TCoordonnee) to High(TCoordonnee) do
                  if (Suites[o, co].Jr = j) and not Suites[o, co].Propre then
                    Inc(s, Suites[o, co].Score(Gr, Des));
    cSP:      for o := Low(TOrientation) to High(TOrientation) do
                for co := Low(TCoordonnee) to High(TCoordonnee) do
                  if (Suites[o, co].Jr = j) and Suites[o, co].Propre then
                    Inc(s, Suites[o, co].Score(Gr, Des));
  end;
Result := s;
end;

function TPartie.Score(j : TIdJoueur) : Integer;
begin
Result := Score(j, cDC) + Score(j, cDNJ) + Score(j, cSM) + Score(j, cSP);
end;

procedure TPartie.PhaseSuivante;
begin
if PhCrt < phResultatPose then
  PhCrt := Succ(PhCrt);
end;

function TPartie.CreateurSuite(x, y : TCoordonnee) : TIdJoueur;
var jh, jv : TIdJoueur;
begin
Result := jIndefini; // Pessimiste
jh := jIndefini;
jv := jIndefini;
if Suites[oVerticale, x].ExisteTjrs(Gr) then
  jv := Suites[oVerticale, x].Jr;
if Suites[oHorizontale, y].ExisteTjrs(Gr) then
  jh := Suites[oHorizontale, y].Jr;
if (jv = jIndefini) and (jh > jIndefini) then
  Result := jh;
if (jh = jIndefini) and (jv > jIndefini) then
  Result := jv;
if (jh > jIndefini) and (jv > jIndefini) then
  if Suites[oVerticale, x].Tr > Suites[oHorizontale, y].Tr then
    Result := jv
  else
    Result := jh;
end;

function TPartie.CreeSuite(x, y : TCoordonnee) : Boolean;
var c      : TCoordonnee;
    o      : TOrientation;
    OK     : array [TOrientation] of Boolean;
begin
for o := Low(TOrientation) to High(TOrientation) do
  begin
  OK[o] := True; // Optimiste !
  for c := Low(TCoordonnee) to High(TCoordonnee) do
    case o of
      oHorizontale: if (c <> x) and (Gr[c, y] = ndIndefini) then
                      begin
                      OK[o] := False;
                      break;
                      end;
      oVerticale:   if (c <> y) and (Gr[x, c] = ndIndefini) then
                      begin
                      OK[o] := False;
                      break;
                      end;
    end{case o of};
    if not OK[o] then
      Continue
  end;
Result := Ok[oHorizontale] or Ok[oVerticale]
end;

function TPartie.SuiteCree(x, y : TCoordonnee) : Boolean;
var c      : TCoordonnee;
    o      : TOrientation;
    Propre : Boolean;
    OK     : array [TOrientation] of Boolean;
begin
for o := Low(TOrientation) to High(TOrientation) do
  begin
  OK[o] := True; // Optimiste !
  Propre := True; // Pessimiste
  for c := Low(TCoordonnee) to High(TCoordonnee) do
    case o of
      oHorizontale: if Gr[c, y] = ndIndefini then
                      begin
                      OK[o] := False;
                      break;
                      end
                    else
                      if Propre and (Des[Gr[c, y]].Jr <> Des[Gr[x, y]].Jr) then
                        Propre := False;
      oVerticale:   if Gr[x, c] = ndIndefini then
                      begin
                      OK[o] := False;
                      break;
                      end
                    else
                      if Propre and (Des[Gr[x, c]].Jr <> Des[Gr[x, y]].Jr) then
                        Propre := False;
    end{case o of};
    if not OK[o] then
      Continue
    else // On enregistre la suite
      case o of
        oHorizontale: Suites[o, y].Affecte(Des[Gr[x, y]].Jr, x, y, Propre);
        oVerticale:   Suites[o, x].Affecte(Des[Gr[x, y]].Jr, x, y, Propre);
      end{case o of};
  end;
Result := Ok[oHorizontale] or Ok[oVerticale]
end;

initialization
InitialiseRepLocalAppData;
p := TPartie.Create;

finalization
FreeAndNil(p);

end.
