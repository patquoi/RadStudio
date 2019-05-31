unit Base;

interface

const
  //  COORDONNEES
  xyIndefini		  = -1;
  xCentre			    = 5;
  yCentre			    = 4;
  xMin				    = 0;
  xMax				    = 10;
  yMin				    = 0;
  yMax				    = 8;
  // limites Tireur+Ballon pour les rebonds
  xTBMin			    = 1;
  xTBMax			    = 9;
  yTBMin			    = 0;
  yTBMax			    = 8;
  // Filets = limite zone de défense
  yFiletMin		    = 3;
  yFiletMax		    = 5;

  // Paramètres de jeu (pour l'instant fixés)
  PionsParJoueur  = 6;
  TourMiTemps		  = 50;
  TourFinPartie	  = 100;


type
  TCamp           = (cNeutre, cGauche, cDroite); // Ord(tpJrGauche|Droite)=Ord(jGauche|Droite)=Ord(cGauche|Droite)
  TJoueur         = (jGauche=1, jDroite=2); // Ord(tpJrGauche|Droite)=Ord(jGauche|Droite)=Ord(cGauche|Droite)
  TColonne        = xyIndefini..xMax;
  TLigne          = xyIndefini..yMax;
  TTypePion       = (tpCaseVide=-1, tpBallon, tpJrGauche, tpJrDroite); // Ord(tpJrGauche|Droite)=Ord(jGauche|Droite)=Ord(cGauche|Droite)
  TNumPion        = 0..PionsParJoueur; // 0 = indéfini, 1 = 1er pion
  TEtatPion       = (epInactif, epAEteDeplace, epATire);
  TZone           = (zButGauche=-3, zDefenseGauche=-2, zLibreGauche=-1, zCentraleNeutre=0, zLibreDroite=1, zDefenseDroite=2, zButDroite=3);
  TCouleurTerrain = (ctGris=-1, ctBleu, ctRouge, ctVert); // Gris pour zone neutre
  TCouleurPion    = (cpIndefinie=-1, cpBleu, cpCiel, cpJaune, cpMauve, cpOrange, cpPourpre, cpRouge, cpVert);
  TDirection      = (dIndefinie, dNord, dNordEst, dEst, dSudEst, dSud, dSudOuest, dOuest, dNordOuest);
  TPhase          = (phAttente, phPoseJoueurs, phDeplacement1, phDeplacement2, phTir, phTestTir);
  TDeplPossible   = (dpPossible, dpHorsPortee, dpDirIncorrecte, dpZoneInterdite, dpTrajetOccupe); // type de la fonction TJeu.DeplacementPossible
  TTirPossible    = (tpPossible, tpTrajetTBOccupe, tpTrajetBNOccupe, tpMemeCaseTB, tpCaseOccupee);

const
  // Coordonnées : Poteaux de but
  xBut				    : array [TCamp] of Double = (0.0, 9.5, 0.5);
  yButMin			    = 2.5;
  yButMax			    = 5.5;

  Zone            : array [TColonne, TLigne] of TZone = ((zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre),
                                                         (zCentraleNeutre,zDefenseGauche, zDefenseGauche, zDefenseGauche, zButGauche,     zButGauche,     zButGauche,     zDefenseGauche, zDefenseGauche, zDefenseGauche),
                                                         (zCentraleNeutre,zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche),
                                                         (zCentraleNeutre,zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche),
                                                         (zCentraleNeutre,zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche),
                                                         (zCentraleNeutre,zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche,   zLibreGauche),
                                                         (zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre,zCentraleNeutre),
                                                         (zCentraleNeutre,zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite),
                                                         (zCentraleNeutre,zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite),
                                                         (zCentraleNeutre,zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite),
                                                         (zCentraleNeutre,zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite,   zLibreDroite),
                                                         (zCentraleNeutre,zDefenseDroite, zDefenseDroite, zDefenseDroite, zButDroite,     zButDroite,     zButDroite,     zDefenseDroite, zDefenseDroite, zDefenseDroite));
  ZoneImgIdx      : array [TZone] of Integer          = (0, 12, 24, 40, 24, 12, 0);
  dx				      : array [TDirection] of integer     = (0, 0, 1, 1, 1, 0, -1, -1, -1);
  dy				      : array [TDirection] of Integer     = (0, -1, -1, 0, 1, 1, 1, 0, -1);

type
  TPion = class
    x           : TColonne;
    y           : TLigne;
    Etat        : TEtatPion;
    procedure Initialise(const j : TJoueur; const n : TNumPion);
    constructor Cree(const j : TJoueur; const n : TNumPion);
    constructor Clone(const Pion : TPion);
    procedure Place(const x : TColonne; const y : Tligne);
    procedure Deplace(const x : TColonne; const y : Tligne);
    procedure Tire(const x : TColonne; const y : Tligne);
  private
    Joueur      : TJoueur;
    Numero      : TNumPion;
    destructor Detruit;
  public
  end{class TPion};

  TJeu = class
    TourCrt : Integer;
    CampCrt : TCamp;
    Places  : Integer; // de 0 à PionsParJoueur*2
    xBallon : TColonne;
    yBallon : TLigne;
    But     : Boolean;
    c       : array [TColonne, TLigne] of TTypePion;
    n       : array [TColonne, TLigne] of TNumPion; // 0 = pas de pion joueur; 1..PionsParJoueur = numéro du pion
    p       : array [TJoueur, TNumPion] of TPion; // /!\ TNumPion = 1..PionsParJoueur : p[j,0]=Nil
    xDepl   : array [TJoueur] of TColonne;
    yDepl   : array [TJoueur] of TLigne;
    Buts    : array [TJoueur] of Integer;
    Phase   : array [TJoueur] of TPhase;
    // Statistiques
    Occupation : Integer;
    DistBln : array [TJoueur] of Double;
    DistPjr : array [TJoueur] of Double;
    procedure Initialise;
    constructor Cree;
    constructor Clone(const Jeu : TJeu);
    procedure Tire(const xTireur : TColonne; const yTireur : TLigne; const xNvBallon : TColonne; const yNvBallon : TLigne);
    function TirPossible(const x : TColonne; const y : TLigne) : TTirPossible;
    function PeutTirer : Boolean; // Indique si CampCrt peut tirer dans la situation actuelle
    function DeplacementPossible(const x : TColonne; const y : TLigne) : TDeplPossible; // 0 = possible ; >0 = impossible avec motif
    procedure DeplaceJoueurVers(const x : TColonne; const y : TLigne);
  private
    destructor Detruit;
  public
  end{class TJeu};

var
  // Paramètres de jeu (couleurs)
  CouleurTerrain  : array [TCamp] of TCouleurTerrain;
  CouleurPion     : array [TJoueur] of TCouleurPion;

function CoordonneesValides(const x : TColonne; const y : TLigne) : Boolean;

implementation

uses Math;

// procédures & fonctions globales (outils)
function CoordonneesValides(const x : TColonne; const y : TLigne) : Boolean;
begin
Result:=(x>xyIndefini) and (y>xyIndefini)
end;

// ============
// Classe TPion
// ============
procedure TPion.Initialise(const j : TJoueur; const n : TNumPion);
begin
Joueur:=j;
Numero:=n;
x:=Low(TColonne);
y:=Low(TLigne);
Etat:=epInactif;
end;

procedure TPion.Place(const x : TColonne; const y : Tligne);
begin // /!\ Placement et non déplacement (phase engagement)
self.x:=x;
self.y:=y;
end;

procedure TPion.Deplace(const x : TColonne; const y : Tligne);
begin // /!\ Déplacement et non Placement (phase déplacement)
self.x:=x;
self.y:=y;
Etat:=epAEteDeplace;
end;

procedure TPion.Tire(const x : TColonne; const y : Tligne);
begin
self.x:=x;
self.y:=y;
Etat:=epATire;
end;

constructor TPion.Cree(const j : TJoueur; const n : TNumPion);
begin
Initialise(j, n);
end;

constructor TPion.Clone(const Pion : TPion);
begin
Joueur:=Pion.Joueur;
Numero:=Pion.Numero;
x:=Pion.x;
y:=Pion.y;
Etat:=Pion.Etat;
end;

destructor TPion.Detruit;
begin
end;

// ===========
// Classe TJeu
// ===========

procedure TJeu.Initialise;
var i : TColonne;
    j : TLigne;
    k : TJoueur;
    l : TNumPion;
begin
TourCrt:=0;
CampCrt:=cNeutre;
Places:=0;
xBallon:=xyIndefini;
yBallon:=xyIndefini;
But:=False;
Occupation:=0; // Statistiques
for k:=Low(TJoueur) to High(TJoueur) do
  begin
  xDepl[k]:=xyIndefini;
  yDepl[k]:=xyIndefini;
  Buts[k]:=0;
  Phase[k]:=phAttente;
  DistBln[k]:=0.0; // Statistiques
  DistPjr[k]:=0.0; // Statistiques
  for l:=Low(TNumPion) to High(TNumPion) do // Pions
    p[k, l].Initialise(k, l); // Inutile à la création mais pas pour un appel explicite à Initialise
  end;

// Cases
for i:=Low(TColonne) to High(TColonne) do
  for j:=Low(TLigne) to High(TLigne) do
    begin
    if (i=TLigne(yMax div 2)) and (j=TColonne(xMax div 2)) then
      c[i, j]:=tpBallon
    else
      c[i, j]:=tpCaseVide;
    n[i, j]:=0;
    end;
end;

constructor TJeu.Cree;
var k : TJoueur;
    l : TNumPion;
begin
for k:=Low(TJoueur) to High(Tjoueur) do
  for l:=Low(TNumPion)+1 to High(TNumPion) do
    p[k, l]:=TPion.Cree(k, l);
Initialise;
end;

constructor TJeu.Clone(const Jeu : TJeu);
var i : TColonne;
    j : TLigne;
    k : TJoueur;
    l : TNumPion;
begin
TourCrt:=Jeu.TourCrt;
CampCrt:=Jeu.CampCrt;
Places:=Jeu.Places;
xBallon:=Jeu.xBallon;
yBallon:=Jeu.yBallon;
But:=Jeu.But;
Occupation:=Jeu.Occupation;
for k:=Low(TJoueur) to High(TJoueur) do
  begin
  xDepl[k]:=Jeu.xDepl[k];
  yDepl[k]:=Jeu.yDepl[k];
  Buts[k]:=Jeu.Buts[k];
  Phase[k]:=Jeu.Phase[k];
  DistBln[k]:=Jeu.DistBln[k];
  DistPjr[k]:=Jeu.DistPjr[k];
  for l:=Low(TNumPion) to High(TNumPion) do // Pions
    p[k, l]:=TPion.Clone(p[k, l]);
  end;

// Cases
for i:=Low(TColonne) to High(TColonne) do
  for j:=Low(TLigne) to High(TLigne) do
    begin
    c[i, j]:=Jeu.c[i, j];
    n[i, j]:=Jeu.n[i, j];
    end;
end;

destructor TJeu.Detruit;
var k : TJoueur;
    l : TNumPion;
begin
for k:=Low(TJoueur) to High(Tjoueur) do
  for l:=Low(TNumPion)+1 to High(TNumPion) do
    p[k, l].Free;
end;

procedure TJeu.Tire(const xTireur : TColonne; const yTireur : TLigne; const xNvBallon : TColonne; const yNvBallon : TLigne);
var Distance : Double;
begin
	// Distance parcourue. Même en cas de but, on prend la distance tireur-ballon pour le ballon (prend ça dans la gueule).
	Distance:=Sqrt((xBallon-xTireur)*(xBallon-xTireur)+(yBallon-yTireur)*(yBallon-yTireur));
	DistPjr[TJoueur(CampCrt)]:=DistPjr[TJoueur(CampCrt)]+Distance;
	DistBln[TJoueur(CampCrt)]:=DistBln[TJoueur(CampCrt)]+Distance;
	// afficheDistance(campCrt);

	// On bouge les éléments
	c[xTireur, yTireur]:=tpCaseVide;
	// afficheCase(xTireur, yTireur);
	if not But then
    begin
		c[xNvBallon, yNvBallon]:=tpBallon;
		// afficheCase(xNvBallon, yNvBallon);
    end;
	c[xBallon, yBallon]:=TTypePion(CampCrt);
  p[TJoueur(CampCrt), n[xTireur, yTireur]].Tire(xBallon, yBallon);
  n[xBallon, yBallon]:=n[xTireur, yTireur]; n[xTireur, yTireur]:=0;
	// afficheCase(xBallon, yBallon);
	if not But then
    begin
		xBallon:=xNvBallon;
		yBallon:=yNvBallon;
    end
	else
    begin
		xBallon:=xyIndefini;
		yBallon:=xyIndefini;
    end;
	if But then
    begin
		// if not TempsSuspendu then suspendChrono(new Date().getTime());
		if CampCrt=cGauche then // Si gauche marque : +10. Si droite marque : +0.
			Inc(Occupation, xMax);
		// AfficheBut();
    end
  else
		Inc(Occupation, xBallon)
	// afficheOccupation();
end;

function TJeu.TirPossible(const x : TColonne; const y : TLigne) : TTirPossible; // Le Pion tireur (x,y) peut-il tirer ? 0 = possible ; >0 = impossible avec motif (1=trajet Tireur-Ballon occupé, 2=trajet Ballon-NvCase occupé)
var d, sens,
    i, j, k,
    dxTB, dyTB,
    dxx, dyy,
    xx, yy,
    xNB, yNB    : Integer;
    yBut        : Double;
    PasBon,
    ButPossible,
    ButMarque,
    Rebond      : Boolean;
    dir         : TDirection;
    tp          : TTirPossible;
begin // /!\ Pré-requis : (x,y) est un pion tireur valide (non déplacé) et à portée (<3 cases) et le tir potentiel n'est pas en arrière
// if (modeTestTir == 1) resultatTestTir = rttKO; // v1.1 : mode test tir pessimiste
Result:=tpPossible; // Optimiste par défaut !
dxTB:=xBallon-x;
dyTB:=yBallon-y;
PasBon:=False;
ButPossible:=True; // Optimiste
if (dxTB=0) or (dyTB=0) or (Abs(dxTB)=Abs(dyTB)) then
	begin	// Tir Cardinal : on regarde s'il n'y a pas de pion sur le trajet tireur>Ballon et Ballon>NvCase...
  d:=0;	dir:=dIndefinie;
	if x=xBallon then // Vertical
    begin
    if yBallon>y then
      dir:=dSud
		else
      dir:=dNord;
    d:=Abs(yBallon-y);
    end
  else
    begin
    if y=yBallon then // Horizontal
			begin
      if xBallon>x then
				dir:=dEst
			else
				dir:=dOuest;
			d:=Abs(xBallon-x);
      end
		else // Diagonale
      begin
      sens:=(1+(xBallon-x) div Abs(xBallon-x)) div 2+
             1+(yBallon-y) div Abs(yBallon-y);
			case sens of
				0: dir:=dNordOuest;
				1: dir:=dNordEst;
				2: dir:=dSudOuest;
				3: dir:=dSudEst;
      end{case of sens};
			d:=Abs(xBallon-x);
		  end;
		// Vérification du trajet Tireur-Ballon
		for k:=1 to d-1 do
			if c[x+k*dx[dir],
           y+k*dy[dir]]<>tpCaseVide then
				begin
        Result:=tpTrajetTBOccupe;
        end;Exit;
        end;

		// Vérification du trajet Ballon-NvCase
		tp:=tpPossible; // Optimiste
		dxx:=dxTB;
		dyy:=dyTB;
		xx:=xBallon;
		yy:=yBallon;
		Rebond:=false;
		j:=IfThen(dxTB<>0,Abs(dxTB),Abs(dyTB));
		for i:=1 to j-1 do
      begin // Rebond avant éventuel but... alors ne plus contrôler
			if (xx+Sign(dxx)>xTBMax) or (xx+Sign(dxx)<xTBMin) then
        begin
        dxx:=-dxx;
        Rebond:=True;
        end;
			if (yy+Sign(dyy)>yTBMax) or (yy+Sign(dyy)<yTBMin) then
				dyy:=-dyy;
			Inc(xx, Sign(dxx));
			Inc(yy, Sign(dyy));
			if (c[xx,yy]>tpCaseVide) and // Case occupée et
			   ((xx<>x) or (yy<>y)) then // la case finale n'est pas la case tireur (permutation autorisée)
        begin
				tp:=tpTrajetBNOccupe;
				PasBon:=true; // Sous réserve qu'il n'y ait pas but
        end;
			if not Rebond then ButPossible:=not PasBon;
		  end;
		if PasBon and not ButPossible then
      begin
			Result:=tp; // Pas de rebond avant case occupée => pas bon !
      Exit
      end
	  end;
	// Tir non Cardinal : uniquement case finale du ballon doit être vide
  ButMarque:=False;
	xNB:=2*xBallon-x;
	yNB:=2*yBallon-y;
	if xNB<xTBMin then xNB:=2-xNB;
	if xNB>xTBMax then xNB:=2*xTBMax-xNB;
	if yNB<yTBMin then yNB:=-yNB;
	if yNB>yTBMax then yNB:=2*yTBMax-yNB;
	if x<>xBallon then // But impossible si ballon et tireur sur même colonne
		begin // On cherche yBut pour savoir si ça passe strictement entre les poteaux

		// xBallon-x   yBallon-y
		// --------- = ---------
		//   xBut-x      yBut-y

		yBut:=y+((xBut[CampCrt]-x)*(yBallon-y))/(xBallon-x);
		if (yBut>yButMin) and (yBut<yButMax) and // Entre les lignes de poteaux ET…
   		 ((CampCrt=cGauche) and (2*xBallon-x>xBut[CampCrt]) or // Le ballon aurait passé la colonne de but (droite)
			  (CampCrt=cDroite) and (2*xBallon-x<xBut[CampCrt])) then // Le ballon aurait passé la colonne de but (gauche)
			ButMarque:=True
	  end;
	if not ButMarque then
    begin
		if PasBon then
      begin
			Result:=tp; // Finalement, pas de but possible => pas bon !
      Exit
      end;
		if (xNB=xBallon) and (yNB=yBallon) then
      begin
			Result:=tpMemeCaseTB; // Ballon et tireur arrivent sur la même case
      Exit
      end;
		if (c[xNB, yNB]>tpCaseVide) and
		    ((xNB<>x) or (yNB<>y)) then
      begin
			Result:=tpCaseOccupee;
      Exit
      end
    end;
  (*
	if (testSeul==undefined) { // Si l'on ne teste pas le tir pour savoir si l'on peut tirer ALORS
	    if (modeTestTir != 1) { // on effectue l'action et on notifie s'il y a but (variable globale). v1.1 : SAUF si le joueur courant n'est pas en mode test tir
			but=butMarque; localStorage.but = butMarque;
			tire(x, y, xNB, yNB); // Tir possible
	    } else { // v1.1 : Sinon on affiche le tir (tireur et ballon déplacés)
	 		if (butMarque) {
	 			resultatTestTir = rttBut;
	 			xTestTireur = x;
	 			yTestTireur = y;
	 			xTestBallon = xBallon;
	 			yTestBallon = yBallon;
	 			afficheCase(xBallon, yBallon);
	 		} else {
	 			resultatTestTir = rttOK;
	 			xTestTireur = xBallon;
	 			yTestTireur = yBallon;
	 			xTestBallon = xNB;
	 			yTestBallon = yNB;
	 			afficheCase(xBallon, yBallon);
	 			afficheCase(xNB, yNB);
	 		}
			setTimeout( function () {
							defaitTestTir();
						}, dureeMsgErr);
	    }
	*)
end;

function TJeu.PeutTirer : Boolean; // Indique si CampCrt peut tirer dans la situation actuelle
var xDepl : TColonne;
    yDepl : TLigne;
    x : TColonne;
    y : TLigne;
begin
Result:=False; // Pessimiste par défaut !
xDepl:=self.xDepl[TJoueur(CampCrt)];
yDepl:=self.yDepl[TJoueur(CampCrt)];
for x:=xMin to xMax do
	for y:=yMin to yMax do
		if ((c[x,y]=TTypePion(CampCrt)) and // Pion tireur
				((x<>xDepl) or (y<>yDepl)) and // Pion non déplacé
				((Abs(xBallon-x)<=3) and (Abs(yBallon-y)<=3)) and // À portée du ballon
				(((CampCrt<>cGauche) or (xBallon>=x)) and  // Tir latéral ou devant (gauche)
				 ((CampCrt<>cDroite) or (xBallon<=x))) and // Tir latéral ou devant (droit)
				(TirPossible(x, y)=tpPossible)) then // Tir possible
			begin
      Result:=True;
      Exit
      end
end;

function TJeu.DeplacementPossible(const x : TColonne; const y : TLigne) : TDeplPossible; // Peut-on déplacer le pion joueur (xDepl, yDepl)=>(x,y) ? 0 = possible ; >0 = impossible avec motif
var xDepl : TColonne;
    yDepl : TLigne;
    d, k  : Integer;
    dir   : TDirection;
    sens  : Integer;
begin // /!\ Pré-requis : case cible vide [c[x][y]=tpCaseVide] et xDepl, yDepl définies [CoordonneesValides(xDepl, yDepl)]
xDepl:=self.xDepl[TJoueur(CampCrt)];
yDepl:=self.yDepl[TJoueur(CampCrt)];
Result:=dpPossible; // Déplacement possible par défaut (optimiste !)
// Hors de portée (>3 cases)
if (Abs(x-xDepl)>3) or
   (Abs(y-yDepl)>3) then
  begin
	Result:=dpHorsPortee;
  Exit;
  end;
// Direction non autorisée (hor./vert./diag.)
if (x<>xDepl) and (y<>yDepl) and
   ((Abs(x-xDepl)/Abs(y-yDepl))<>1) then
  begin
  Result:=dpDirIncorrecte;
  Exit;
  end;
// Zone interdite
if ((x=xMin) or (x=xMax)) and // Zone de défense ET
   ((y>=yFiletMin) or (y<=yFiletMax)) then // filets --> interdit
  begin
  Result:=dpZoneInterdite;
  Exit;
  end;
if ((((x=xMin) and (campCrt=cDroite)) or // [défense joueur gauche ou
		 ((x=xMax) and (campCrt=cGauche))) and // défense joueur droite] ET
	  ((y<=yFiletMin) or (y>=yFiletMax))) then // hors filets --> interdit
  begin
  Result:=dpZoneInterdite;
  Exit;
  end;
d:=0; dir:=dIndefinie;
if x=xDepl then // Vertical
  begin
  if (y>yDepl) then
    dir:=dSud
  else
    dir:=dNord;
	d:=Abs(y-yDepl);
  end
else
  if y=yDepl then // Horizontal
    begin
		if x>xDepl then
			dir:=dEst
		else
			dir:=dOuest;
		d:=Abs(x-xDepl);
    end
  else // Diagonale
		begin
    sens:=(1+(x-xDepl) div Abs(x-xDepl)) div 2 +
           1+(y-yDepl) div Abs(y-yDepl);
		case sens of
			0: dir:=dNordOuest;
			1: dir:=dNordEst;
			2: dir:=dSudOuest;
      3: dir:=dSudEst;
		end{case of Sens};
		d:=Abs(x-xDepl);
	  end;
	// Vérification du trajet
	for k:=1 to d-1 do
		if (c[xDepl+k*dx[dir],
          yDepl+k*dy[dir]]<>tpCaseVide) then
      begin
			Result:=dpTrajetOccupe;
      Exit
      end;
end;

procedure TJeu.DeplaceJoueurVers(const x : TColonne; const y : TLigne); // Déplace le pion joueur (xDepl,yDepl)=>(x,y)
var xDepl : TColonne;
    yDepl : TLigne;
begin // Pré-requis : DeplacementPossible(x,y)
xDepl:=self.xDepl[TJoueur(CampCrt)];
yDepl:=self.yDepl[TJoueur(CampCrt)];
c[xDepl, yDepl]:=tpCaseVide;
p[TJoueur(CampCrt), n[xDepl, yDepl]].Deplace(x, y);
n[x, y]:=n[xDepl, yDepl]; n[xDepl, yDepl]:=0;
// afficheCase(xDepl, yDepl);
//distPjr[campCrt]+=Math.sqrt((xDepl-x)*(xDepl-x)+(yDepl-y)*(yDepl-y)); localStorage.setItem('distPjr'+campCrt, distPjr[campCrt]);
//afficheDistance(campCrt);
c[x, y]:=TTypePion(campCrt);
self.xDepl[TJoueur(CampCrt)]:=x;
self.yDepl[TJoueur(CampCrt)]:=y;
// afficheCase(x, y);
// changePhase(phTir);
end;

initialization

// Couleurs par défaut
CouleurTerrain[cNeutre]:=ctGris;
CouleurTerrain[cGauche]:=ctBleu;
CouleurTerrain[cDroite]:=ctRouge;
CouleurPion[jGauche]:=cpBleu;
CouleurPion[jDroite]:=cpRouge;
end.
