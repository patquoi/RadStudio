unit base;

interface

uses
  System.Classes, Vcl.Graphics;

const
  PrmDe        = 0;
  DrnDe        = 1;

  NbMinJoueurs = 2;
  NbMaxJoueurs = 6;

type
  TNbJoueurs = NbMinJoueurs..NbMaxJoueurs;
  TNumChfScr = 0..5; // Les scores vont de 0 à 999999

  TEtatPartie= (epInactif=0, epEnCours, epPause); // permet de mettre à jour le menu Partie
  TRepriseJeu= (rjIndefinie=0, rjPion, rjDes, rjAutomate); // Indique quel Timer est utilisé pour la pause/reprise du jeu

  TDe        = (dIndefini=0, dUn, dDeux, dTrois, dQuatre, dCinq, dSix);
  TNumDe     = PrmDe..DrnDe;

  TSymbole   = (sMoins, sPlus);

  TFamEvt    = (feIndefinie=0, feResultat, feNombreDes, feParite, feSomme, feProduit, feEcart, feRapport);
  TTypeEvt   = (teIndefini=0,  teSomme,    teProduit,  teEcart,     teRapport,
                               teNbDes1,   teNbDes2,   teNbDes3,    teNbDes4,  teNbDes5, teNbDes6,
                               tePair,     teImpair,
                               teSomme5,   teSomme6,   teSomme7,    teSomme8,  teSomme9,
                               teProduit4, teProduit6, teProduit12,
                               teEcart0,   teEcart1,   teEcart2,    teEcart3,
                               teRapport2, teRapport3);
  TTypeCase  = (tcIndefini=0,
                tcDepart,
                tcSomme,    tcProduit,     tcEcart,     tcRapport,
                tcDe1,      tcDe2,         tcDe3,       tcDe4,      tcDe5,    tcDe6,
                tcPair,     tcImpair,
                tcSomme5,   tcSomme6,      tcSomme7,    tcSomme8,   tcSomme9,
                tcProduit4, tcProduit6,    tcProduit12,
                tcEcart0,   tcEcart1,      tcEcart2,    tcEcart3,
                tcRapport2, tcRapport3,
                tcEchelleN, tcEchelleE,    tcEchelleS,  tcEchelleO,
                tcRelance,  tcBisRepet, tcTirelire,  tcJackpot);

  TNumCaseEvt = (ncePrm=0, nceDrn);
  TNumEchelle = (neNPrm=0, neNDrn, neEPrm, neEDrn, neSPrm, neSDrn, neOPrm, neODrn);

  TDefGain    = (dgIndefinie=0, dgFixe, dgVariable);
  TSensCpta   = (scDebit=0, scCredit);

  TCoordonnee = 0..12;
  TDirection  = (dIndefinie=0, dNord, dEst, dSud, dOuest);
  TNbDirPoss  = 0..4;
  TDirPoss    = (dpAucune=0, dpN, dpE, dpNE, dpS, dpNS, dpSE, dpTsO, dpO, dpNO, dpEO, dpTsS, dpSO, dpTsE, dpTsN, dpToutes); // Les dirposs de plus de 2 directions ne sont pas présentes sur le parcours (sauf départ).

  TJoueurId   = (jIndefini=0, jMyrtille, jFramboise, jOrange, jFraise, jCitron, jKiwi, jJackpot);  // Jackpot c'est pour les achats d'événements
  TCouleur    = (cNoir=0,         cCiel,   cMagenta, cOrange,  cRouge, cJaune,  cVert, cPourpre, cBlanc, cGris);
  TApplCoul   = (acTexte=0, acFond); // Pour l'affiche des messages

  TPhaseTour  = (phtIndefinie=0, phtLanceDes, phtChxDirPion, phtDepltPion, phtActionDes, phtVenteEvt, phtAchatEvt, phtJoueurSvt);

  TCaseEvt = class
  private // constantes définies à la création et à usage interne
    TypeEvt  : TTypeEvt;
    NumCase  : TNumCaseEvt;
  public
    x, y     : TCoordonnee;
    Id       : TJoueurId;
    constructor Create(TypeEvt : TTypeEvt; NumCase : TNumCaseEvt; x, y : TCoordonnee); overload;
    destructor Destroy; override;
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream) : Boolean;
    function Charge(fs : TFileStream) : Boolean;
  end{class TCaseEvt};

  TEvenement = class
    CaseEvt : array [TNumCaseEvt] of TCaseEvt;
  private // constantes définies à la création et à usage interne
    TypeEvt : TTypeEvt;
  public
    constructor Create(TypeEvt : TTypeEvt); overload; // Pour appels fonctions hors partie
    constructor Create(TypeEvt : TTypeEvt; x, y : TCoordonnee); overload;
    procedure Ajoute(x, y : TCoordonnee);
    destructor Destroy; override;
    // Pour affichage définition des événements hors partie
    function ResultatDes(De : array of TDe) : Integer;
    function DonneGain(De : array of TDe) : Integer;
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream) : Boolean;
    function Charge(fs : TFileStream) : Boolean;
  end{class TEvenement};

  TScore = class
  private
    Id : TJoueurId;
    Debit,
    Credit : array of array of Integer;
  public
    constructor Create(Id : TJoueurId; ScoreDepart : Integer);
    destructor Destroy; override;
    procedure Initialise(Tour : Integer);
    procedure Debite(Tour, Score : Integer; Crediteur : TJoueurId);
    function DebitTour(Tour : Integer) : Integer; overload;
    function CumulDebit(Tour : Integer) : Integer; overload;
    procedure Credite(Tour, Score : Integer; Debiteur : TJoueurId);
    function CreditTour(Tour : Integer) : Integer; overload;
    function CumulCredit(Tour : Integer) : Integer; overload;
    function ScoreTour(Tour : Integer) : Integer;
    function CumulScore(Tour : Integer) : Integer;
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream; Tour : Integer) : Boolean;
    function Charge(fs : TFileStream; Tour : Integer) : Boolean;
  end{class TScore};

  TJackpot = class
    Score : TScore;
    DrnSc : Integer; // Dernier jackpot emporté
    DrnJr : TJoueurId; // Dernier joueur ayant remporté le jackpot
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure Credite(Tour, Credit : Integer; Debiteur : TJoueurId);
    procedure Debite(Tour, Debit : Integer; Crediteur : TJoueurId);
    function CumulScore(Tour : Integer) : Integer;
    function DebitTour(Tour : Integer) : Integer;
    function CreditTour(Tour : Integer) : Integer;
    function CumulCredit(Tour : Integer) : Integer; // v1.1.3 pour stats joueurs
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream; Tour : Integer) : Boolean;
    function Charge(fs : TFileStream; Tour : Integer) : Boolean;
  end{class TJackpot};

  TPion = class
    x, y : TCoordonnee;
    Dir  : TDirection;
    CAP  : Integer; // Cases (restant) À Parcourir. Vaut zéro dès que le pion arrive à destination
  private
    Id : TJoueurId;
  public
    constructor Create(Id : TJoueurId);
    destructor Destroy; override;
    procedure ChoisitDirection;
    procedure AvancePion;
    procedure DeplacePion(x, y : TCoordonnee);
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream) : Boolean;
    function Charge(fs : TFileStream) : Boolean;
  end{class TPion};

  TJoueur = class
    Automate,
    Elimine  : Boolean;
    PosElm   : Integer;
    Pion     : TPion;
    Score    : TScore;
  private
    Id : TJoueurId;
  public
    constructor Create(Id : TJoueurId; Automate : Boolean);
    destructor Destroy; override;
    procedure ChoisitDirection;
    procedure AvancePion;
    procedure DeplacePion(x, y : TCoordonnee);
    procedure Credite(Tour, Credit : Integer; Debiteur : TJoueurId);
    procedure Debite(Tour, Debit : Integer; Crediteur : TJoueurId);
    function CumulScore(Tour : Integer) : Integer;
    function ScoreTour(Tour : Integer) : Integer;
    function DebitTour(Tour : Integer) : Integer;
    function CreditTour(Tour : Integer) : Integer;
    function CumulCredit(Tour : Integer) : Integer; // v1.1.3 pour stats joueurs
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream; Tour : Integer) : Boolean;
    function Charge(fs : TFileStream; Tour : Integer) : Boolean;
  end{class TJoueur};

  TPartie = class // Eléments variables d'une partie
    Nbj    : TNbJoueurs;
    TrCrt  : Integer;
    JrCrt  : TJoueurId;
    Jckpt  : TJackpot;
    De     : array [TNumDe] of TDe;
    Jr     : array [TJoueurId] of TJoueur;
    Evt    : array [TTypeEvt] of TEvenement;
    // Stats
    ScDes  : array [TDe, TDe] of Integer;
    ScEvt  : array [TTypeEvt] of Integer;
  private
    FEtat  : TEtatPartie;
    FPhase : TPhaseTour;
    PosElm : Integer; // Utilisé pour définir TJoueur.PosElm
    function APayerEvenementsDes : Integer;
    procedure PaieEvenementDes;
    procedure ActionCasePion;
    procedure ChangeEtat(NvEtat : TEtatPartie);
    procedure ChangePhase(NvPhase : TPhaseTour);
    procedure Elimine(Id : TJoueurId);
  public
    Reprise        : TRepriseJeu; // Défini si Etat à epPause
    PhaseSvt       : TPhaseTour; // Utilisée lors de Phase phtActionDes ou phtVenteEvt
    EvtAVendre     : TTypeEvt; // Utilisé lors de la phase phtVenteEvt
    property Etat  : TEtatPartie read FEtat write ChangeEtat;
    property Phase : TPhaseTour read FPhase write ChangePhase;
    constructor Create(Nbj : TNbJoueurs; Automate : array of Boolean); overload;
    destructor Destroy; override;
    // Dessins
    procedure DessineCase(x, y : TCoordonnee);
    procedure DessineScores;
    procedure DessineJackpot;
    procedure DessineLanceDes;
    procedure DessineBilan;
    procedure DessineEvolution;
    procedure DessineStatsEvts;
    procedure DessineStatsDes;
    procedure DessineStatsJrs; // v1.1.3
    procedure DessineSelonTypeAffichage; // Appelle DessineBilan ou DessineEvolution selon TypeAffichage
    procedure DessineEvenement(TypeEvt : TTypeEvt);
    procedure DessineCompteurEvt(Couleur : TCouleur; PlusBlanc : Boolean);
    procedure DessineEvenements;
    // Phases
    procedure ChoisitDirection;
    procedure AvancePion;
    procedure DeplacePion(x, y : TCoordonnee);
    function NbJoueursRestants : Integer;
    procedure JoueurSuivant;
    procedure InitialiseTour;
    procedure TourSuivant;
    procedure Demarre;
    // Vente
    procedure EvtAVendreSvt;
    procedure VendEvenement(EstLiquidation : Boolean);
    function NbEvenements(Id : TJoueurId) : Integer;
    procedure VenteEvenements;
    procedure LiquideEvenements;
    // Divers
    procedure Paie(Score : Integer; Crediteur, Debiteur : TJoueurId);
    procedure Credite(Id : TJoueurId; Score : Integer);
    function Score(Id : TJoueurId) : Integer; overload;
    function Score(Id : TJoueurId; Tour : Integer) : Integer; overload;
    function ScoreTour(Id : TJoueurId; Tour : Integer) : Integer;
    function DebitTour(Id : TJoueurId; Tour : Integer) : Integer;
    function CreditTour(Id : TJoueurId; Tour : Integer) : Integer;
    // v1.1 partie enregistrée
    function Sauve(fs : TFileStream) : Boolean;
    function Charge(fs : TFileStream) : Boolean;
  end{class TPartie};

const

  // Constantes générales

  NbCasesDeCote  : Integer = 13;
  NbMaxCouleurs  : Integer = 10; // Couleurs joueurs + Pourpre + Noir + Blanc + Gris

  ScoreDepart    : Integer     = 100000;

  xDepart        : TCoordonnee = 7;
  yDepart        : TCoordonnee = 5;

  Puiss10 : array [TNumChfScr] of Integer         = (1, 10, 100, 1000, 10000, 100000);

  stEtat : array [TEtatPartie] of String = ('Partie inactive.', 'Partie reprise.', 'Partie interrompue.'); // Message affiché dans la barre de statut. v1.1.1 : Partie inactive+reprise.

  // Joueurs et couleurs
                                                     // Noir,    Ciel, Magenta,  Orange,   Rouge,   Jaune,    Vert, Pourpre,   Blanc  Gris,
  Couleur : array [TCouleur] of TColor            = ($000000, $ef5024, $7939c2, $0080ff, $0000ff, $60ffff, $008900, $b44b97, $ffffff, $404040);
  stClMsg : array [TApplCoul, TCouleur] of String = (('N',     'C',     'M',     'O',     'R',     'J',     'V',     'P',     'B',    'G'),
                                                     ('n',     'c',     'm',     'o',     'r',     'j',     'v',     'p',     'b',    'G'));

  stNomJoueur : array [TJoueurId] of String       = ('', 'Myrtille', 'Framboise', 'Orange', 'Fraise', 'Citron', 'Kiwi', 'Jackpot');

  // Paramètre de TPartie.DessineCompteurEvt
  AvecBlanc     : Boolean = True;
  SansBlanc     : Boolean = False;
  // Paramètre de TPartie.VendEvenement
  Liquidation   : Boolean = True;
  VenteUnitaire : Boolean = False;

  //  Evénements et cases

  FamilleEvt : array [TTypeEvt] of TFamEvt = (feIndefinie, feResultat,  feResultat,  feResultat,  feResultat,
                                                           feNombreDes, feNombreDes, feNombreDes, feNombreDes, feNombreDes, feNombreDes,
                                                           feParite,    feParite,
                                                           feSomme,     feSomme,     feSomme,     feSomme,     feSomme,
                                                           feProduit,   feProduit,   feProduit,
                                                           feEcart,     feEcart,     feEcart,     feEcart,
                                                           feRapport,   feRapport);
  DefGain : array [TTypeEvt] of TDefGain =  (dgIndefinie, dgVariable, dgVariable, dgVariable, dgVariable,
                                                          dgVariable, dgVariable, dgVariable, dgVariable, dgVariable, dgVariable,
                                                          dgVariable, dgVariable,
                                                          dgFixe,     dgFixe,     dgFixe,     dgFixe,     dgFixe,
                                                          dgFixe,     dgFixe,     dgFixe,
                                                          dgFixe,     dgFixe,     dgFixe,     dgFixe,
                                                          dgFixe,     dgFixe);

  stNomFam : array [TFamEvt] of String = ('', 'Résultat', 'Nombre', 'Parité', 'Sommes', 'Produits', 'Ecarts', 'Rapports');
  stNomFamille : array [TFamEvt] of String = ('', 'Résultat des dés', 'Nombre de dés', 'Parité des dés', 'Sommes de dés', 'Produits de dés', 'Ecarts de dés', 'Rapports de dés');
  stNomEvt : array [TTypeEvt] of String = ('', 'Somme', 'Produit', 'Ecart', 'Rapport',
                                               'Dés 1', 'Dés 2', 'Dés 3', 'Dés 4', 'Dés 5', 'Dés 6',
                                               'Dés pairs', 'Dés impairs',
                                               'Somme = 5', 'Somme = 6', 'Somme = 7', 'Somme = 8', 'Somme = 9',
                                               'Produit = 4', 'Produit = 6', 'Produit = 12',
                                               'Ecart = 0', 'Ecart = 1', 'Ecart = 2', 'Ecart = 3',
                                               'Rapport = 2', 'Rapport = 3');
  stNomEvenement : array [TTypeEvt] of String = ('', 'Somme des dés', 'Produit des dés', 'Ecart des dés', 'Rapport des dés',
                                                     'Nombre de 1', 'Nombre de 2', 'Nombre de 3', 'Nombre de 4', 'Nombre de 5', 'Nombre de 6',
                                                     'Nombre de dés pairs', 'Nombre de dés impairs',
                                                     'Somme des dés = 5', 'Somme des dés = 6', 'Somme des dés = 7', 'Somme des dés = 8', 'Somme des dés = 9',
                                                     'Produit des dés = 4', 'Produit des dés = 6', 'Produit des dés = 12',
                                                     'Ecart des dés = 0', 'Ecart des dés = 1', 'Ecart des dés = 2', 'Ecart des dés = 3',
                                                     'Rapport des dés = 2', 'Rapport des dés = 3');
  stDefGain : array [TDefGain] of String = ('', 'Fixe',           'Variable');
  stFrmGain : array [TDefGain] of String = ('', 'Si %s alors %d', '%s × %d');
  RsltEvt : array [TTypeEvt] of Integer = (0, 0, 0, 0, 0,
                                              0, 0, 0, 0, 0, 0,
                                              0, 0,
                                              5, 6, 7, 8, 9,
                                              4, 6,12,
                                              0, 1, 2, 3,
                                              2, 3);

  xTypeEvt  : array [TTypeEvt] of Integer = (0,    0,    1,    2,    3,
                                                   0,    1,    2,    0,    1,    2,
                                                   0,    1,
                                                   3,    3,    3,    3,    3,
                                                   0,    1,    2,
                                                   0,    1,    0,    1,
                                                   2,    2);

  yTypeEvt  : array [TTypeEvt] of Integer = (0,    0,    0,    0,    0,
                                                   1,    1,    1,    2,    2,    2,
                                                   6,    6,
                                                   1,    2,    3,    4,    5,
                                                   5,    5,    5,
                                                   3,    3,    4,    4,
                                                   3,    4);

  TauxGain  : array [TTypeEvt] of Integer = (0,   70,   40,  252,  294,
                                                1470, 1470, 1470, 1470, 1470, 1470,
                                                 490,  490,
                                                4410, 3528, 2940, 3528, 4410,
                                                5880, 4410, 4410,
                                                2940, 1764, 2205, 2940,
                                                2940, 4410);

  PrixEvt : array [TNbJoueurs] of Integer = (2500, 3750, 5000, 6250, 7500);

  TypeCaseEvt : array [TTypeEvt] of TTypeCase = (tcIndefini, tcSomme,    tcProduit,  tcEcart,     tcRapport,
                                                             tcDe1,      tcDe2,      tcDe3,       tcDe4,     tcDe5, tcDe6,
                                                             tcPair,     tcImpair,
                                                             tcSomme5,   tcSomme6,   tcSomme7,    tcSomme8, tcSomme9,
                                                             tcProduit4, tcProduit6, tcProduit12,
                                                             tcEcart0,   tcEcart1,   tcEcart2,    tcEcart3,
                                                             tcRapport2, tcRapport3);
  TypeEvtCase : array [TTypeCase] of TTypeEvt = (teIndefini,
                                                 teIndefini,
                                                 teSomme,    teProduit,  teEcart,     teRapport,
                                                 teNbDes1,   teNbDes2,   teNbDes3,    teNbDes4,  teNbDes5, teNbDes6,
                                                 tePair,     teImpair,
                                                 teSomme5,   teSomme6,   teSomme7,    teSomme8,  teSomme9,
                                                 teProduit4, teProduit6, teProduit12,
                                                 teEcart0,   teEcart1,   teEcart2,    teEcart3,
                                                 teRapport2, teRapport3,
                                                 teIndefini, teIndefini, teIndefini,  teIndefini,
                                                 teIndefini, teIndefini, teIndefini,  teIndefini);

  stNomCase : array [TTypeCase] of String = ( '',
                                              'Départ',
                                              'Somme',     'Produit',      'Ecart',      'Rapport',
                                              'Dé 1',      'Dé 2',         'Dé 3',       'Dé 4',    'Dé 5',   'Dé 6',
                                              'Pair',      'Impair',
                                              'Somme=5',   'Somme=6',      'Somme=7',    'Somme=8', 'Somme=9',
                                              'Produit=4', 'Produit=6',    'Produit=12',
                                              'Ecart=0',   'Ecart=1',      'Ecart=2',    'Ecart=3',
                                              'Rapport=2', 'Rapport=3',
                                              'Echelle N', 'Echelle E',    'Echelle S',  'Echelle O',
                                              'Relance',   'Bis repetita', 'Tirelire',   'Jackpot');

  TypeCase : array [TCoordonnee, TCoordonnee] of TTypeCase = ((tcJackpot,  tcSomme8,   tcEcart1,   tcBisRepet, tcDe2,      tcProduit6, tcEchelleO, tcEcart3,   tcSomme9,   tcRelance,  tcDe5,      tcSomme7,   tcJackpot),
                                                              (tcProduit4, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcRapport,  tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcProduit12),
                                                              (tcEcart0,   tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcTirelire, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcBisRepet),
                                                              (tcRelance,  tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcDe3,      tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcSomme5),
                                                              (tcSomme6,   tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcEchelleN, tcProduit4, tcPair,     tcDe2,      tcTirelire, tcImpair,   tcDe4),
                                                              (tcRapport3, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcRapport3, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcEcart2),
                                                              (tcEchelleN, tcSomme,    tcTirelire, tcDe1,      tcSomme9,   tcProduit,  tcEchelleS, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcRelance),
                                                              (tcEcart2,   tcIndefini, tcIndefini, tcIndefini, tcEcart,    tcDepart,   tcSomme,    tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcIndefini, tcSomme8),
                                                              (tcDe6,      tcIndefini, tcIndefini, tcIndefini, tcImpair,   tcRapport,  tcEchelleE, tcEcart1,   tcEchelleO, tcDe6,      tcTirelire, tcEcart,    tcEchelleS),
                                                              (tcBisRepet, tcIndefini, tcIndefini, tcIndefini, tcDe5,      tcIndefini, tcIndefini, tcIndefini, tcDe4,      tcIndefini, tcIndefini, tcIndefini, tcProduit6),
                                                              (tcDe3,      tcIndefini, tcIndefini, tcIndefini, tcTirelire, tcIndefini, tcIndefini, tcIndefini, tcTirelire, tcIndefini, tcIndefini, tcIndefini, tcBisRepet),
                                                              (tcSomme7,   tcIndefini, tcIndefini, tcIndefini, tcProduit,  tcIndefini, tcIndefini, tcIndefini, tcPair,     tcIndefini, tcIndefini, tcIndefini, tcRapport2),
                                                              (tcJackpot,  tcEcart0,   tcRelance,  tcSomme6,   tcEchelleE, tcRapport2, tcBisRepet, tcProduit12, tcDe1,     tcSomme5, tcRelance,    tcEcart3,   tcJackpot));

                                                //neNPrm, neNDrn, neEPrm, neEDrn, neSPrm, neSDrn, neOPrm, neODrn
  SautEch : array [TNumEchelle] of TNumEchelle = (neNDrn, neNPrm, neEDrn, neEPrm, neSDrn, neSPrm, neODrn, neOPrm);
  xEchelle: array [TNumEchelle] of TCoordonnee = (     4,      6,      8,     12,      6,      8,      0,      8);
  yEchelle: array [TNumEchelle] of TCoordonnee = (     6,      0,      6,      4,      6,     12,      6,      8);

  NbCases : array [TTypeCase] of Integer = (88, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 5, 5, 6, 4);
  NumCase : array [TCoordonnee, TCoordonnee] of Integer = ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), // Les cases inutilisées sont quand même comptées (5x5+3x3x5+2x3x3=25+45+18=88)
                                                           (0, 0, 1, 2, 3, 4, 0, 5, 6, 7, 8, 9, 0),
                                                           (0,10,11,12,13,14, 0,15,16,17,18,19, 1),
                                                           (1,20,21,22,23,24, 0,25,26,27,28,29, 0),
                                                           (0,30,31,32,33,34, 0, 1, 0, 1, 1, 0, 0),
                                                           (0,35,36,37,38,39, 1,40,41,42,43,44, 0),
                                                           (1, 0, 2, 0, 1, 0, 0,45,46,47,48,49, 2),
                                                           (1,50,51,52, 0, 0, 1,53,54,55,56,57, 1),
                                                           (0,58,59,60, 1, 1, 0, 1, 1, 1, 3, 1, 1),
                                                           (2,61,62,63, 1,64,65,66, 1,67,68,69, 1),
                                                           (1,70,71,72, 4,73,74,75, 5,76,77,78, 3),
                                                           (1,79,80,81, 1,82,83,84, 1,85,86,87, 0),
                                                           (2, 1, 3, 1, 1, 1, 4, 1, 1, 1, 4, 1, 3));

  // Directions

  dx : array [TDirection] of Integer          = (0, 0, 1, 0, -1);
  dy : array [TDirection] of Integer          = (0, -1, 0, 1, 0);
  NbDirPoss  : array [TDirPoss] of TNbDirPoss = (0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4); // Les dirposs de plus de 2 directions ne sont pas présentes sur le parcours (sauf départ).
  DirDirPoss : array [TDirPoss] of TDirection = (dIndefinie, dNord, dEst, dIndefinie, dSud, dIndefinie, dIndefinie, dIndefinie, dOuest, dIndefinie, dIndefinie, dIndefinie, dIndefinie, dIndefinie, dIndefinie, dIndefinie);
  DirPossDir : array [TDirection] of TDirPoss = (dpAucune, dpN, dpE, dpS, dpO);
  ToucheDir : array [TDirection] of Word      = (0, 38, 39, 40, 37);

  DirPossJr : array [TJoueurId, TCoordonnee, TCoordonnee] of TDirPoss = (((dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune)),
                                                                         ((dpS,     dpS,     dpS,     dpS,     dpS,     dpS,     dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN), // Joueur 1
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpSE,    dpS,     dpS,     dpS,     dpS,     dpS     ,dpEO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpEO,    dpN,     dpN,     dpN,     dpNS,    dpS,     dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpN,     dpNS,    dpS,     dpE,     dpN,     dpN,     dpN,     dpN),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpO,     dpN,     dpN,     dpN,     dpNS,    dpS,     dpS,     dpS,     dpO)),
                                                                         ((dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpNS,    dpS,     dpS,     dpS,     dpS,     dpS,     dpE), // Joueur 2
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpN,     dpN,     dpN,     dpN,     dpN     ,dpN),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpS,     dpS,     dpEO,    dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpEO,    dpN,     dpNS,    dpS,     dpS,     dpS,     dpS,     dpS,     dpEO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpNO,    dpN,     dpN,     dpN,     dpN)),
                                                                         ((dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpNE,    dpN,     dpN,     dpN,     dpN,     dpN,     dpN), // Joueur 3
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpS,     dpS,     dpS,     dpS,     dpS,     dpS     ,dpEO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpN,     dpN,     dpN,     dpNS,    dpS,     dpEO,    dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpN,     dpNS,    dpS,     dpE,     dpN,     dpN,     dpN,     dpN),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpO,     dpN,     dpN,     dpN,     dpNS,    dpS,     dpS,     dpS,     dpO)),
                                                                         ((dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN), // Joueur 4
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpN,     dpN,     dpN,     dpN,     dpN     ,dpNO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpS,     dpS,     dpEO,    dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpEO,    dpN,     dpNS,    dpS,     dpS,     dpS,     dpS,     dpS,     dpEO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpNO,    dpN,     dpN,     dpN,     dpN)),
                                                                         ((dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN), // Joueur 5
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpSO,    dpS,     dpS,     dpS,     dpS,     dpS     ,dpEO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpS,     dpS,     dpEO,    dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpN,     dpNS,    dpS,     dpE,     dpN,     dpN,     dpN,     dpN),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpO,     dpN,     dpN,     dpN,     dpNO,    dpN,     dpN,     dpN,     dpNS,    dpS,     dpS,     dpS,     dpO)),
                                                                         ((dpE,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN), // Joueur 6
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpSO,    dpS,     dpS,     dpS,     dpS,     dpS     ,dpEO),
                                                                          (dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpS,     dpS,     dpS,     dpS,     dpS,     dpS,     dpEO,    dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpO,     dpToutes,dpE,     dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpEO,    dpN,     dpN,     dpN,     dpNS,    dpS,     dpS,     dpS,     dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpAucune,dpAucune,dpAucune,dpE,     dpAucune,dpAucune,dpAucune,dpO,     dpAucune,dpAucune,dpAucune,dpE),
                                                                          (dpO,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpN,     dpNO,    dpN,     dpN,     dpN,     dpN)),
                                                                         ((dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune),
                                                                          (dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune,dpAucune)));

  NumBmDp : array [TDirPoss] of Integer = (0, 1, 2, 3, 4, 5, 6, 0, 7, 8, 9, 0, 10, 0, 0, 11); // Pas d'image si plus de 2 directions possibles (sauf départ toutes directions)

  // v1.1 partie enregistrée
  stMsgErrScoreDebitCredit = 'Score.Debit/Credit';

var
  stRepLocalAppData : String;
  Partie            : TPartie;

implementation

uses
  System.Types, System.SysUtils, System.Math, Winapi.Windows, plateau_f;

// ============================================================================
// méthodes globales
// ============================================================================

function Enrichit(stTexte : String; CouleurFond, CouleurTexte : TCouleur) : String; overload;
begin // Par défaut : fond noir et texte blanc
case Ord(CouleurFond<>cNoir)+2*Ord(CouleurTexte<>cBlanc) of
  0: // Pas de changement de couleur, on retransmet le texte tel quel
     Result := stTexte;
  1: // On ne change que le fond
     Result := Format('#%s%s#%s', [stClMsg[acFond, CouleurFond], stTexte, stClMsg[acFond, cNoir]]);
  2: // On ne change que le texte
     Result := Format('#%s%s#%s', [stClMsg[acTexte, CouleurTexte], stTexte, stClMsg[acTexte, cBlanc]]);
  3: // On change tout !
     Result := Format('#%s#%s%s#%s#%s', [stClMsg[acFond, CouleurFond], stClMsg[acTexte, CouleurTexte], stTexte, stClMsg[acTexte, cBlanc], stClMsg[acFond, cNoir]]);
end{case of};
end;

function Enrichit(TypeCase : TTypeCase) : String; overload;
begin
Result := Format('#%s', [Char(Ord('z')+Ord(TypeCase))]);
end;

procedure InitialiseRepLocalAppData;
const stVarLocalAppData  = 'LOCALAPPDATA';
      stVarUserProfile   = 'USERPROFILE';
      stRepLocAppDataPrdc = '\Patquoi.fr\Paradice';
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

// ============================================================================
// Méthodes de classes
// ============================================================================

// ----------------
// Classe TCaseEvt
// ----------------

constructor TCaseEvt.Create(TypeEvt : TTypeEvt; NumCase : TNumCaseEvt; x, y : TCoordonnee);
begin
self.TypeEvt := TypeEvt;
self.NumCase := NumCase;
self.x := x;
self.y := y;
self.Id := jIndefini;
end;

destructor TCaseEvt.Destroy;
begin
inherited Destroy;
end;

// v1.1 partie enregistrée

function TCaseEvt.Sauve(fs : TFileStream) : Boolean;
begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(TypeEvt, sizeof(TypeEvt));
    WriteBuffer(NumCase, sizeof(NumCase));
    // public
    WriteBuffer(x, sizeof(x));
    WriteBuffer(y, sizeof(y));
    WriteBuffer(Id, sizeof(Id));
    // protected
    end;
except
  Result:=False;
end{try}
end{function Sauve};

function TCaseEvt.Charge(fs : TFileStream) : Boolean;
begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(TypeEvt, sizeof(TypeEvt));
    ReadBuffer(NumCase, sizeof(NumCase));
    // public
    ReadBuffer(x, sizeof(x));
    ReadBuffer(y, sizeof(y));
    ReadBuffer(Id, sizeof(Id));
    // protected
    end;
except
  Result:=False;
end{try}
end{function Charge};

// -----------------
// Classe TEvenement
// -----------------

constructor TEvenement.Create(TypeEvt : TTypeEvt; x, y : TCoordonnee);
begin
self.TypeEvt:=TypeEvt;
if TypeEvt > teIndefini then
  CaseEvt[ncePrm]:=TCaseEvt.Create(TypeEvt, ncePrm, x, y);
end;

constructor TEvenement.Create(TypeEvt : TTypeEvt);
begin
self.TypeEvt:=TypeEvt;
end;

destructor TEvenement.Destroy;
var ce : TNumCaseEvt;
begin
for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
  FreeAndNil(CaseEvt[ce]);
inherited Destroy;
end;

procedure TEvenement.Ajoute(x, y : TCoordonnee);
begin
CaseEvt[nceDrn]:=TCaseEvt.Create(TypeEvt, nceDrn, x, y);
end;

function TEvenement.ResultatDes(De : array of TDe) : Integer;
begin
case TypeEvt of

  teSomme,
  teSomme5,
  teSomme6,
  teSomme7,
  teSomme8,
  teSomme9:    Result:=Ord(De[PrmDe])+Ord(De[DrnDe]);

  teProduit,
  teProduit4,
  teProduit6,
  teProduit12: Result:=Ord(De[PrmDe])*Ord(De[DrnDe]);

  teEcart,
  teEcart0,
  teEcart1,
  teEcart2,
  teEcart3:    Result:=Max(Ord(De[PrmDe]), Ord(De[DrnDe]))-Min(Ord(De[PrmDe]), Ord(De[DrnDe]));

  teRapport,
  teRapport2,
  teRapport3:  if Max(Ord(De[PrmDe]), Ord(De[DrnDe])) mod Min(Ord(De[PrmDe]), Ord(De[DrnDe])) = 0 then // Dés divisibles
                 Result:=Max(Ord(De[PrmDe]), Ord(De[DrnDe])) div Min(Ord(De[PrmDe]), Ord(De[DrnDe]))
               else
                 Result:=0;

  tePair:      Result:=Ord(Ord(De[PrmDe]) mod 2=0)+Ord(Ord(De[DrnDe]) mod 2=0);
  teImpair:    Result:=Ord(Ord(De[PrmDe]) mod 2=1)+Ord(Ord(De[DrnDe]) mod 2=1);

  teNbDes1,
  teNbDes2,
  teNbDes3,
  teNbDes4,
  teNbDes5,
  teNbDes6:    Result:=Ord(Ord(De[PrmDe])=1+Ord(TypeEvt)-Ord(teNbDes1))+
                       Ord(Ord(De[DrnDe])=1+Ord(TypeEvt)-Ord(teNbDes1));
else
  Result:=0;
end{case of};
end{function TEvenement.ResultatDes};

function TEvenement.DonneGain(De : array of TDe) : Integer;
begin
case DefGain[TypeEvt] of
  dgVariable: Result:=ResultatDes(De)*TauxGain[TypeEvt];
  dgFixe:     if ResultatDes(De)=RsltEvt[TypeEvt] then
                Result:=TauxGain[TypeEvt]
              else
                Result:=0
else
  Result:=0;
end{case of};
end{function TEvenement.DonneGain};

// v1.1 partie enregistrée

function TEvenement.Sauve(fs : TFileStream) : Boolean;
const stFrmMsgErr = 'Partie.Evt[%d].CaseEvt[%d].Sauve';
var ce : TNumCaseEvt;
begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(TypeEvt, sizeof(TypeEvt));
    for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
      if not CaseEvt[ce].Sauve(fs) then raise EWriteError.CreateFmt(stFrmMsgErr, [Ord(TypeEvt), Ord(ce)]);
    // public
    // protected
    end;
except
  Result:=False;
end{try}
end{function TEvenement.Sauve};

function TEvenement.Charge(fs : TFileStream) : Boolean;
const stFrmMsgErr = 'Partie.Evt[%d].CaseEvt[%d].Charge';
var ce : TNumCaseEvt;
begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(TypeEvt, sizeof(TypeEvt));
    for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
      if not CaseEvt[ce].Charge(fs) then raise EReadError.CreateFmt(stFrmMsgErr, [Ord(TypeEvt), Ord(ce)]);
    // public
    // protected
    end;
except
  Result:=False;
end{try}
end{function TEvenement.Charge};

// -------------
// Classe TScore
// -------------

constructor TScore.Create(Id : TJoueurId; ScoreDepart : Integer);
begin
self.Id := Id;
Initialise(0);
Credite(0, ScoreDepart, jIndefini);
end;

destructor TScore.Destroy;
begin
inherited Destroy;
end;

procedure TScore.Initialise(Tour : Integer);
var j : TJoueurId;
begin
SetLength(Debit, Tour+1);
SetLength(Credit, Tour+1);
SetLength(Debit[Tour], Ord(High(TJoueurId))-Ord(Low(TJoueurId))+1);
SetLength(Credit[Tour], Ord(High(TJoueurId))-Ord(Low(TJoueurId))+1);
for j := Low(TJoueurId) to High(TJoueurId) do
  begin
  Credit[Tour, Ord(j)] := 0;
  Debit[Tour, Ord(j)] := 0;
  end;
end;

procedure TScore.Debite(Tour, Score : Integer; Crediteur : TJoueurId);
begin
Inc(Debit[Tour, Ord(Crediteur)], Score);
end;

function TScore.DebitTour(Tour : Integer) : Integer;
var j : TJoueurId;
begin
Result := 0;
for j := Low(TJoueurId) to High(TJoueurId) do
  Inc(Result, Debit[Tour, Ord(j)]);
end;

function TScore.CumulDebit(Tour : Integer) : Integer;
var t : Integer;
begin
Result := 0;
for t := 0 to Tour do
  Inc(Result, DebitTour(t));
end;

procedure TScore.Credite(Tour, Score : Integer; Debiteur : TJoueurId);
begin
Inc(Credit[Tour, Ord(Debiteur)], Score);
end;

function TScore.CreditTour(Tour : Integer) : Integer;
var j : TJoueurId;
begin
Result := 0;
for j := Low(TJoueurId) to High(TJoueurId) do
  Inc(Result, Credit[Tour, Ord(j)]);
end;

function TScore.CumulCredit(Tour : Integer) : Integer;
var t : Integer;
begin
Result := 0;
for t := 0 to Tour do
  Inc(Result, CreditTour(t));
end;

function TScore.ScoreTour(Tour : Integer) : Integer;
begin
Result := 0;
Inc(Result, CreditTour(Tour));
Dec(Result, DebitTour(Tour));
end;

function TScore.CumulScore(Tour : Integer) : Integer;
var t : Integer;
begin
Result := 0;
for t := 0 to Tour do
  Inc(Result, ScoreTour(t));
end;

// v1.1 partie enregistrée

function TScore.Sauve(fs : TFileStream; Tour : Integer) : Boolean;

function SauveDebitCredit : Boolean;
var t : Integer;
    j : TJoueurId;
begin
Result := True;
try
  for t := 0 to Tour do
    for j := Low(TJoueurId) to High(TJoueurId) do
      with fs do
        begin
        WriteBuffer(Credit[t, Ord(j)], sizeof(Credit[t, Ord(j)]));
        WriteBuffer(Debit[t, Ord(j)], sizeof(Debit[t, Ord(j)]));
        end;
except
  Result := False;
end;
end{function SauveDebitCredit};

begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(Id, sizeof(Id));
    if not SauveDebitCredit then raise EWriteError.Create(stMsgErrScoreDebitCredit);
    // public
    // protected
    end;
except
  Result:=False;
end{try}
end{function Sauve};

function TScore.Charge(fs : TFileStream; Tour : Integer) : Boolean;

function ChargeDebitCredit : Boolean;
var t : Integer;
    j : TJoueurId;
begin
Result := True;
try
  SetLength(Debit, Tour+1);
  SetLength(Credit, Tour+1);
  for t := 0 to Tour do
    begin
    SetLength(Debit[t], Ord(High(TJoueurId))-Ord(Low(TJoueurId))+1);
    SetLength(Credit[t], Ord(High(TJoueurId))-Ord(Low(TJoueurId))+1);
    for j := Low(TJoueurId) to High(TJoueurId) do
      with fs do
        begin
        ReadBuffer(Credit[t, Ord(j)], sizeof(Credit[t, Ord(j)]));
        ReadBuffer(Debit[t, Ord(j)], sizeof(Debit[t, Ord(j)]));
      end;
    end;
except
  Result := False;
end;
end{function ChargeDebitCredit};

begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(Id, sizeof(Id));
    if not ChargeDebitCredit then raise EReadError.Create(stMsgErrScoreDebitCredit);
    // public
    // protected
    end;
except
  Result:=False;
end{try}
end{function Charge};

// ---------------
// Classe TJackpot
// ---------------

constructor TJackpot.Create;
begin
self.DrnSc := 0;
self.DrnJr := jIndefini;
self.Score := TScore.Create(jJackpot, 0);
end;

destructor TJackpot.Destroy;
begin
FreeAndNil(Score);
inherited Destroy;
end;

procedure TJackpot.Credite(Tour, Credit : Integer; Debiteur : TJoueurId);
begin
Score.Credite(Tour, Credit, Debiteur);
end;

procedure TJackpot.Debite(Tour, Debit : Integer; Crediteur : TJoueurId);
var ds : Integer;
begin
ds := CumulScore(Tour);
if ds > 0 then
  begin
  DrnSc := ds;
  DrnJr := Crediteur;
  end;
Score.Debite(Tour, Debit, Crediteur);
end;

function TJackpot.CumulScore(Tour : Integer) : Integer;
begin
Result := Score.CumulScore(Tour);
end;

function TJackpot.DebitTour(Tour : Integer) : Integer;
begin
Result := Score.DebitTour(Tour);
end;

function TJackpot.CreditTour(Tour : Integer) : Integer;
begin
Result := Score.CreditTour(Tour);
end;

function TJackpot.CumulCredit(Tour : Integer) : Integer; // v1.1.3 pour stats joueurs
begin
Result := Score.CumulCredit(Tour);
end;

// v1.1 partie enregistrée

function TJackpot.Sauve(fs : TFileStream; Tour : Integer) : Boolean;
const stFrmMsgErr = 'Partie.Jckpt.%s.Sauve';
begin
Result:=True;
try
  with fs do
    begin
    // private
    // public
    // protected
    if not Score.Sauve(fs, Tour) then raise EWriteError.CreateFmt(stFrmMsgErr, ['Score']);
    WriteBuffer(DrnSc, sizeof(DrnSc));
    WriteBuffer(DrnJr, sizeof(DrnJr));
    end;
except
  Result:=False;
end{try}
end{function TJackpot.Sauve};

function TJackpot.Charge(fs : TFileStream; Tour : Integer) : Boolean;
const stFrmMsgErr = 'Partie.Jckpt.%s.Charge';
begin
Result:=True;
try
  with fs do
    begin
    // private
    // public
    // protected
    if not Score.Charge(fs, Tour) then raise EReadError.CreateFmt(stFrmMsgErr, ['Score']);
    ReadBuffer(DrnSc, sizeof(DrnSc));
    ReadBuffer(DrnJr, sizeof(DrnJr));
    end;
except
  Result:=False;
end{try}
end{function TJackpot.Charge};

// ------------
// Classe TPion
// ------------

constructor TPion.Create(Id : TJoueurId);
begin
self.Id := Id;
self.x := xDepart;
self.y := yDepart;
self.Dir := dIndefinie;
end;

destructor TPion.Destroy;
begin
inherited Destroy;
end;

procedure TPion.ChoisitDirection;
var d       : TDirection;
    dp      : TDirPoss;
    k,
    Chx,
    nd      : Integer;
begin // S'il n'y a qu'une seule direction possible, le choix est vite fait !
dp := DirPossJr[Id, x, y];
nd := NbDirPoss[dp];
Chx := 1 + Random(nd);
k := 0;
for d := Succ(Low(TDirection)) to High(TDirection) do
  if (Ord(DirPossDir[d]) and Ord(dp)) = Ord(DirPossDir[d]) then
    begin
    Inc(k);
    if Chx = k then
      begin
      self.Dir := d;
      break;
      end;
    end;
end;

procedure TPion.AvancePion;
begin
self.x := TCoordonnee(Ord(self.x) + dx[self.Dir]);
self.y := TCoordonnee(Ord(self.y) + dy[self.Dir]);
Dec(CAP);
Dir := dIndefinie; // Oblige à déterminer la direction à la prochaine case
end;

procedure TPion.DeplacePion(x, y : TCoordonnee);
begin
self.x := x;
self.y := y;
CAP := 0;
Dir := dIndefinie; // Oblige à déterminer la direction à la prochaine case
end;

// v1.1 partie enregistrée

function TPion.Sauve(fs : TFileStream) : Boolean;
begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(Id, sizeof(Id));
    // public
    // protected
    WriteBuffer(x, sizeof(x));
    WriteBuffer(y, sizeof(y));
    WriteBuffer(Dir, sizeof(Dir));
    WriteBuffer(CAP, sizeof(CAP));
    end;
except
  Result:=False;
end{try}
end{function TPion.Sauve};

function TPion.Charge(fs : TFileStream) : Boolean;
begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(Id, sizeof(Id));
    // public
    // protected
    ReadBuffer(x, sizeof(x));
    ReadBuffer(y, sizeof(y));
    ReadBuffer(Dir, sizeof(Dir));
    ReadBuffer(CAP, sizeof(CAP));
    end;
except
  Result:=False;
end{try}
end{function TPion.Charge};

// --------------
// Classe TJoueur
// --------------

constructor TJoueur.Create(Id : TJoueurId; Automate : Boolean);
begin
self.Id := Id;
self.Automate := Automate;
self.Elimine := False;
self.PosElm := 0;
if Id > jIndefini then
  begin
  self.Pion := TPion.Create(Id);
  self.Score := TScore.Create(Id, ScoreDepart);
  end
else
  begin
  self.Pion := nil;
  self.Score := nil;
  end;
end;

destructor TJoueur.Destroy;
begin
FreeAndNil(Pion);
FreeAndNil(Score);
inherited Destroy;
end;

procedure TJoueur.ChoisitDirection;
begin
Pion.ChoisitDirection
end;

procedure TJoueur.AvancePion;
begin
Pion.AvancePion;
end;

procedure TJoueur.DeplacePion(x, y : TCoordonnee);
begin
Pion.DeplacePion(x, y);
end;

procedure TJoueur.Credite(Tour, Credit : Integer; Debiteur : TJoueurId);
begin
Score.Credite(Tour, Credit, Debiteur);
end;

procedure TJoueur.Debite(Tour, Debit : Integer; Crediteur : TJoueurId);
begin
Score.Debite(Tour, Debit, Crediteur);
end;

function TJoueur.CumulScore(Tour : Integer) : Integer;
begin
Result := Score.CumulScore(Tour);
end;

function TJoueur.ScoreTour(Tour : Integer) : Integer;
begin
Result := Score.ScoreTour(Tour);
end;


function TJoueur.DebitTour(Tour : Integer) : Integer;
begin
Result := Score.DebitTour(Tour);
end;

function TJoueur.CreditTour(Tour : Integer) : Integer;
begin
Result := Score.CreditTour(Tour);
end;

function TJoueur.CumulCredit(Tour : Integer) : Integer; // v1.1.3 pour stats joueurs
begin
Result := Score.CumulCredit(Tour);
end;


// v1.1 partie enregistrée

function TJoueur.Sauve(fs : TFileStream; Tour : Integer) : Boolean;
const stFrmMsgErr = 'Partie.Jr[%d].%s.Sauve';
begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(Id, sizeof(Id));
    // public
    // protected
    WriteBuffer(Automate, sizeof(Automate)); // v1.1.2 : Oubli
    WriteBuffer(Elimine, sizeof(Elimine));
    WriteBuffer(PosElm, sizeof(PosElm));
    if not Pion.Sauve(fs) then raise EWriteError.CreateFmt(stFrmMsgErr, [Ord(Id), 'Pion']);;
    if not Score.Sauve(fs, Tour) then raise EWriteError.CreateFmt(stFrmMsgErr, [Ord(Id), 'Score']);;
    end;
except
  Result:=False;
end{try}
end{function TJoueur.Sauve};

function TJoueur.Charge(fs : TFileStream; Tour : Integer) : Boolean;
const stFrmMsgErr = 'Partie.Jr[%d].%s.Charge';
begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(Id, sizeof(Id));
    // public
    // protected
    ReadBuffer(Automate, sizeof(Automate)); // v1.1.2 : Oubli
    ReadBuffer(Elimine, sizeof(Elimine));
    ReadBuffer(PosElm, sizeof(PosElm));
    if not Pion.Charge(fs) then raise EReadError.CreateFmt(stFrmMsgErr, [Ord(Id), 'Pion']);
    if not Score.Charge(fs, Tour) then raise EReadError.CreateFmt(stFrmMsgErr, [Ord(Id), 'Score']);
    end;
except
  Result:=False;
end{try}
end{function TJoueur.Charge};

// --------------
// Classe TPartie
// --------------

constructor TPartie.Create(Nbj : TNbJoueurs; Automate : array of Boolean);
var d     : TNumDe;
    j     : TJoueurId;
    e     : TTypeEvt;
    x, y  : TCoordonnee;
    d1, d2: TDe;
begin
self.TrCrt:=0;
self.JrCrt:=jIndefini;
self.Nbj := Nbj;
self.Etat := epInactif;
self.Phase := phtIndefinie;
self.PosElm := Nbj;
self.EvtAVendre := teIndefini;
// Jackpot
self.Jckpt := TJackpot.Create;
// Des
for d := Low(TNumDe) to High(TNumDe) do
  De[d]:=dIndefini;
// Joueurs (on alloue que les joueurs actifs, pas de propriété Actif)
for j:=Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  Jr[j]:=TJoueur.Create(j, Automate[Ord(j)]);
// Evénements
for x := Low(TCoordonnee) to High(TCoordonnee) do
  for y := Low(TCoordonnee) to High(TCoordonnee) do
    begin
    e:=TypeEvtCase[TypeCase[x, y]];
    if e > teIndefini then
      begin // C'est un événement que l'on crée au passage
      if NumCase[x, y]=0 then
        Evt[e]:=TEvenement.Create(e, x, y) // Première case de l'événement : on crée l'instance
      else
        Evt[e].Ajoute(x, y); // Deuxième case de l'événement : on complète l'instance créée
      end;
    end;
// Stats
for d1 := Low(TDe) to High(TDe) do
  for d2 := Low(TDe) to High(TDe) do
    ScDes[d1, d2] := 0;
for e := Low(TTYpeEvt) to High(TTypeEvt) do
  ScEvt[e] := 0;    
end;

destructor TPartie.Destroy;
var j : TJoueurId;
    e : TTypeEvt;
begin
// Jackpot
FreeAndNil(Jckpt);
// Joueurs
for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  FreeAndNil(Jr[j]);
  // Evénements
for e := Low(TTypeEvt) to High(TTypeEvt) do
  FreeAndNil(Evt[e]);
inherited Destroy;
end;

function TPartie.APayerEvenementsDes : Integer;
var tc        : TTypeCase;
    x, y      : TCoordonnee;
    te        : TTypeEvt;
    ce        : TNumCaseEvt;
    Crediteur : TJoueurId;
begin
Result := 0;
x := Jr[JrCrt].Pion.x;
y := Jr[JrCrt].Pion.y;
tc := TypeCase[x, y];
for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
    begin
    Crediteur := Evt[te].CaseEvt[ce].Id;
    if (Crediteur > jIndefini) and (Crediteur <> jrCrt) then
      begin
      if tc = tcTirelire then
        Inc(Result, Evt[te].DonneGain(De))
      else
        Inc(Result, Evt[te].DonneGain(De));
      end
    end;
end;

procedure TPartie.PaieEvenementDes;
var tc        : TTypeCase;
    x, y      : TCoordonnee;
    te        : TTypeEvt;
    ce        : TNumCaseEvt;
    Crediteur : TJoueurId;
    Gain      : Integer;
begin
EvtAVendre := teIndefini; // La vente est terminée
x := Jr[JrCrt].Pion.x;
y := Jr[JrCrt].Pion.y;
tc := TypeCase[x, y];
for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
    begin
    Crediteur := Evt[te].CaseEvt[ce].Id;
    if (Crediteur > jIndefini) and (Crediteur <> jrCrt) then
      begin
      Gain := Evt[te].DonneGain(De);
      if tc = tcTirelire then
        Paie(Gain, jJackpot, JrCrt)
      else
        Paie(Gain, Crediteur, JrCrt);
      // Stats
      Inc(scDes[De[PrmDe], De[DrnDe]], Gain);
      Inc(scDes[De[DrnDe], De[PrmDe]], Gain);
      Inc(ScEvt[te], Gain);
      Inc(scEvt[teIndefini], Gain); // Total gains pour calculer le pourcentage
      end
    end;
DessineScores; // score par joueur
DessineSelonTypeAffichage;
end;

function TPartie.NbEvenements(Id: TJoueurId) : Integer;
var te        : TTypeEvt;
    ce        : TNumCaseEvt;
begin
Result := 0;
for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  for ce := Low(TNumCaseEvt) to High(TNumCaseEvt) do
    if Evt[te].CaseEvt[ce].Id = Id then
      Inc(Result);
end;

procedure TPartie.ActionCasePion;
var tc      : TTypeCase;
    te      : TTypeEvt;
    x, y    : TCoordonnee;
    ne      : TNumEchelle;
    PrpId   : TJoueurId;
    Jackpot : Integer;
    stMsg   : String;
begin
PhaseSvt := phtIndefinie;
x := Jr[JrCrt].Pion.x;
y := Jr[JrCrt].Pion.y;
tc := TypeCase[x, y];
te := TypeEvtCase[tc];
stMsg := Enrichit(stNomJoueur[JrCrt]+',', cNoir, TCouleur(JrCrt))+#13'votre pion est'#13'sur '+Enrichit(tc)+'.'#13' '#13;
if te>teIndefini then
  begin
  PrpId := Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id;
  if (PrpId = jIndefini) or (PrpId = jJackpot) then
    begin
    if Evt[te].CaseEvt[TNumCaseEvt(1-NumCase[x, y])].Id = JrCrt then
      begin
      stMsg := stMsg + 'Vous avez déjà'#13'acquis cet événement,'#13'La deuxième'#13'est donc gratuite !';
      Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := JrCrt;
      DessineCase(x, y);
      DessineEvenement(te);
      DessineCompteurEvt(TCouleur(JrCrt), AvecBlanc);
      DessineCompteurEvt(cPourpre, SansBlanc);
      PhaseSvt := phtJoueurSvt;
      end
    else
      if Jr[JrCrt].Automate then
        begin // Achat automatique s'il a assez pour acheter
        if Jr[JrCrt].CumulScore(TrCrt) >= PrixEvt[Nbj] then
          begin // Le joueur courant acquiert l'événement, il paie le prix
          stMsg := stMsg + 'Vous achetez'#13'cet événement'#13'pour '+IntToStr(PrixEvt[Nbj])+'.';
          Paie(PrixEvt[Nbj], jIndefini, JrCrt);
          DessineScores;
          Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := JrCrt;
          end
        else // sinon
          begin // Le jackpot hérite de l'événement (si option "Evt Jackpot Achat" activée)
          stMsg := stMsg + 'Vous n''achetez pas'#13'cet événement.';
          if orEvtJckptAcht in FormPlateau.OptionsRegle then
            Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jJackpot;
          end;
        DessineCase(x, y);
        DessineEvenement(te);
        DessineCompteurEvt(TCouleur(Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id), AvecBlanc);
        DessineCompteurEvt(cPourpre, SansBlanc);
        PhaseSvt := phtJoueurSvt;
        end
      else
        if Score(JrCrt) >= PrixEvt[Nbj] then // A FAIRE : proposer de vendre
          begin
          stMsg := stMsg + 'Voulez-vous'#13'acheter pour'#13+IntToStr(PrixEvt[Nbj])+' ?';
          PhaseSvt := phtAchatEvt;
          end
        else
          begin // Pas assez pour acheter -> Jackpot (si option "Evt Jackpot Achat" activée)
          if orEvtJckptAcht in FormPlateau.OptionsRegle then
            Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jJackpot;
          DessineCase(x, y);
          DessineEvenement(te);
          DessineCompteurEvt(cPourpre, AvecBlanc);
          PhaseSvt := phtJoueurSvt;
          end;
    end
  else
    PhaseSvt := phtJoueurSvt;
  end
else
  case tc of
    tcEchelleN..
    tcEchelleO:  begin
                 stMsg := stMsg + 'Le pion a'#13'été déplacé'#13'sur l''autre case';
                 ne := SautEch[TNumEchelle(2*(Ord(tc)-Ord(tcEchelleN))+NumCase[x, y])];
                 DeplacePion(xEchelle[ne], yEchelle[ne]);
                 PhaseSvt := phtJoueurSvt;
                 end;

    tcRelance:   begin // Le message de relancer les dés va être affiché lors de la phase
                 stMsg := stMsg + 'Vous allez'#13'relancer'#13'les dés.';
                 PhaseSvt := phtLanceDes;
                 end;

    tcBisRepet:  begin
                 stMsg := stMsg + 'Le pion va être'#13'à nouveau déplacé.';
                 Jr[JrCrt].Pion.CAP := Ord(De[PrmDe]) + Ord(De[DrnDe]);
                 PhaseSvt := phtDepltPion;
                 end;

    tcTirelire:  begin // L'action a déjà été faite dans PaieEvenementDes
                 stMsg := stMsg + 'Le jackpot a'#13'été augmenté.';
                 PhaseSvt := phtJoueurSvt;
                 end;
    tcJackpot:   begin
                 Jackpot := Jckpt.CumulScore(TrCrt);
                 if Jackpot > 0 then
                   begin
                   stMsg := stMsg + 'Vous empochez'#13'le jackpot'#13'soit '+IntToStr(Jackpot)+' !';
                   Paie(Jackpot, JrCrt, jJackpot);
                   end
                 else
                   stMsg := stMsg + 'Malheureusement'#13'le Jackpot est vide !';
                 PhaseSvt := phtJoueurSvt;
                 end;
  end{case of};
if Jr[JrCrt].Automate then
  with FormPlateau do
    begin
    stMessage := stMsg;
    TimerAutomate.Enabled := True // On attend avant de passer à la phase suivante le temps de voir le message
    end
else
  with FormPlateau do
    if PhaseSvt = phtAchatEvt then
      stMessage := stMsg + #13' '#13'Appuyez sur '+Enrichit('O', cBlanc, cNoir)+' ou '+Enrichit('N', cBlanc, cNoir)+'.'
    else
      stMessage := stMsg + #13' '#13'Appuyez sur '+Enrichit('ENTRÉE', cBlanc, cNoir)+'.';
end;

procedure TPartie.EvtAVendreSvt;
begin
if NbEvenements(JrCrt) = 0 then
  begin
  EvtAVendre := teIndefini;
  Exit
  end
else
  if EvtAVendre = teIndefini then
    EvtAVendre := Succ(Low(TTypeEvt));
  repeat
    if EvtAVendre < High(TTypeEvt) then
      EvtAVendre := Succ(EvtAVendre)
    else
      EvtAVendre := Succ(Low(TTypeEvt));
  until (Evt[EvtAVendre].CaseEvt[ncePrm].Id = JrCrt) or
        (Evt[EvtAVendre].CaseEvt[nceDrn].Id = JrCrt);
end;

procedure TPartie.VendEvenement(EstLiquidation : Boolean);
var ce : TCaseEvt;
begin
ce := Evt[EvtAVendre].CaseEvt[ncePrm];
if ce.Id = JrCrt then
  begin
  if (    EstLiquidation and (orEvtJckptLiqd in FormPlateau.OptionsRegle)) or
     (not EstLiquidation and (orEvtJckptVnte in FormPlateau.OptionsRegle)) then
    ce.Id := jJackpot // Si règle "Evt Jackpot Vente/Liquidation" activée
  else
    ce.Id := jIndefini;
  Credite(JrCrt, PrixEvt[Nbj]);
  DessineCase(ce.x, ce.y);
  DessineEvenement(EvtAVendre);
  DessineCompteurEvt(TCouleur(JrCrt), SansBlanc);
  DessineCompteurEvt(cPourpre, SansBlanc);
  end
else
  begin
  ce := Evt[EvtAVendre].CaseEvt[nceDrn];
  if ce.Id = JrCrt then
    begin
    if (    EstLiquidation and (orEvtJckptLiqd in FormPlateau.OptionsRegle)) or
       (not EstLiquidation and (orEvtJckptVnte in FormPlateau.OptionsRegle)) then
      ce.Id := jJackpot // Si règle "Evt Jackpot Vente/Liquidation" activée
    else
      ce.Id := jJackpot;
    Credite(JrCrt, PrixEvt[Nbj]);
    DessineCase(ce.x, ce.y);
    DessineEvenement(EvtAVendre);
    DessineCompteurEvt(TCouleur(JrCrt), SansBlanc);
    DessineCompteurEvt(cPourpre, SansBlanc);
    end;
  end;

end;

procedure TPartie.VenteEvenements;
var ap, sc : Integer;
    stMsg  : String;
begin
if EvtAVendre = teIndefini then
  EvtAVendreSvt;
with FormPlateau do
  begin
  sc := Score(JrCrt);
  ap := APayerEvenementsDes;
  if sc - ap < 0 then
    stMsg := Enrichit(stNomJoueur[JrCrt]+',', cNoir, TCouleur(JrCrt))+#13'vous devez payer '+IntToStr(ap)+#13'il manque '+IntToStr(ap - sc)+'.'+#13+' '+#13;
  if Jr[JrCrt].Automate then
    begin
    stMessage := stMsg + Enrichit(stNomJoueur[JrCrt]+' vend', cNoir, TCouleur(JrCrt))+#13+Enrichit(TypeCaseEvt[EvtAVendre])+'.';
    VendEvenement(VenteUnitaire);
    TimerAutomate.Enabled := True // On attend avant de passer à la phase suivante le temps de voir le message
    end
  else
    stMessage := stMsg + 'Evénement à vendre'#13+Enrichit(TypeCaseEvt[EvtAVendre])+#13' '#13+Enrichit('V', cBlanc, cNoir)+'endre, '+Enrichit('S', cBlanc, cNoir)+'uite ou '+Enrichit('F', cBlanc, cNoir)+'in.';
  end;
end{procedure TPartie.VenteEvenements};

procedure TPartie.LiquideEvenements;
begin
while NbEvenements(JrCrt)>0 do
  begin
  EvtAVendreSvt;
  VendEvenement(Liquidation);
  end;
end;

procedure TPartie.ChangeEtat(NvEtat : TEtatPartie);
begin
try
  try
    with FormPlateau do
      begin
      MenuItemPartieNouvelle.Enabled := (NvEtat = epInactif);
      MenuItemPartieDemo.Enabled := (NvEtat = epInactif);
      MenuItemPartieReprise.Enabled := (NvEtat = epPause);
      MenuItemPartiePause.Enabled := (NvEtat = epEnCours);
      MenuItemPartieAbandon.Enabled := (NvEtat = epPause);

      //v1.1 parties enregistrées
      MenuItemPartieEnregistrer.Enabled := (NvEtat = epPause);
      MenuItemPartieEnregistrerSous.Enabled := (NvEtat = epPause);
      MenuItemPartieOuvrir.Enabled := (NvEtat = epInactif);

      ChangeAccesRegle(MenuItemRegle, NvEtat = epInactif); // Interdit de changer les options de règle du jeu pendant une partie
      if not ChargementEnCours then
        begin
        case NvEtat of
          epInactif: begin
                     self.Reprise := rjIndefinie;
                     TimerClignotement.Enabled := False;
                     stNomPartie := ''; // v1.1 : on remet à zéro de nom de la partie (défini au moment d'enregistrer)
                     end;
          epEnCours: case Reprise of
                       rjPion:     TimerPion.Enabled := true;
                       rjDes:      TimerDes.Enabled := true;
                       rjAutomate: TimerAutomate.Enabled := true;
                     end;
          epPause:   self.Reprise := rjIndefinie;
        end{case of};
        if (FEtat <> epInactif) or (NvEtat <> epEnCours) then
          StatusBar.SimpleText := stEtat[NvEtat];
        end;
      end;
  except
  end;
finally
  self.FEtat := NvEtat;
end;
end;

procedure TPartie.ChangePhase(NvPhase : TPhaseTour);
var stMsg : String;
    nc, ne,
    ap, sc  : Integer;
    x, y    : TCoordonnee;
    te      : TTypeEvt; // v1.1.1
    PrpId   : TJoueurId; // v1.1.1
begin
case NvPhase of
  phtLanceDes:    with FormPlateau do
                    begin
                    if PhaseSvt = phtLanceDes then // On relance les dés pour le même joueur
                      stMsg := Enrichit(stNomJoueur[JrCrt]+','#13'relancez les dés.', cNoir, TCouleur(JrCrt))
                    else
                      stMsg := Enrichit('C''est à '+stNomJoueur[JrCrt]+#13'de jouer.', cNoir, TCouleur(JrCrt));
                    if Jr[JrCrt].Automate then
                      TimerDes.Tag := 5 + Random(11) // Nombre de changements des dés de 5 à 15
                    else
                      stMsg := stMsg + #13' '#13'Appuyez sur '+Enrichit('ESPACE', cBlanc, cNoir)+#13'pour arrêter les dés.';
                    stMessage :=  stMsg;
                    FPhase := NvPhase;
                    TimerDes.Enabled := True;
                    end;
  phtDepltPion:   with FormPlateau do
                    begin
                    stMessage := Enrichit(stNomJoueur[JrCrt]+',', cNoir, TCouleur(JrCrt))+#13'votre pion'#13'est en cours'#13'de déplacement...';
                    FPhase := NvPhase;
                    TimerPion.Enabled := True;
                    end;
  phtChxDirPion:  with FormPlateau do
                    begin
                    x := Jr[JrCrt].Pion.x;
                    y := Jr[JrCrt].Pion.y;
                    nc := Jr[JrCrt].Pion.CAP;
                    DessineCase(JrCrt, x, y, DirPossJr[JrCrt, x, y]); // On affiche les directions possibles
                    TimerClignotement.Enabled := True; // On signale où se trouve le pion
                    FPhase := NvPhase;
                    stMessage := Enrichit(stNomJoueur[JrCrt]+',', cNoir, TCouleur(JrCrt))+#13'il reste '+IntToStr(nc)+' case(s)'#13'à parcourir'#13'mais vous devez'#13'choisir une direction.'#13' '#13'Utilisez les '#13'touches fléchées.';
                    end;
  phtActionDes:   with FormPlateau do
                    begin
                    FPhase := NvPhase;
                    x := Jr[JrCrt].Pion.x;
                    y := Jr[JrCrt].Pion.y;
                    if TypeCase[x, y] <> tcBisRepet then // On ne compte pas deux fois le paiement des événements de dés
                      begin
                      ap := APayerEvenementsDes;
                      sc := Score(JrCrt);
                      if sc >= ap then
                        begin
                        EvtAVendre := teIndefini;
                        PaieEvenementDes // Le joueur courant paie les événements de dés acquis par les autres joueurs
                        end
                      else // Pas assez pour payer
                        if sc + PrixEvt[Nbj] * NbEvenements(JrCrt) < ap then
                          begin
                         // v1.1.1 si pion sur événement libre et règle 1 activée -> Jackpot
                          te := TypeEvtCase[TypeCase[x, y]];
                          if te>teIndefini then
                            begin
                            PrpId := Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id;
                            if PrpId = jIndefini then
                              if orEvtJckptAcht in FormPlateau.OptionsRegle then
                                begin
                                Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id := jJackpot;
                                self.DessineCase(x, y);
                                self.DessineEvenement(te);
                                self.DessineCompteurEvt(cPourpre, AvecBlanc);
                                end
                            end;
                          LiquideEvenements; // Tous les événements du joueur passent au Jackpot (si règle 3 activée)
                          PaieEvenementDes; // On paie quand même les créanciers mais on passe le joueur en statut Eliminé
                          Elimine(JrCrt); // Permet de définir Elimine mais aussi PosElm
                          self.DessineCase(x, y);
                          stMsg := Enrichit(stNomJoueur[JrCrt]+',', cNoir, TCouleur(JrCrt))+#13'vous ne pouvez pas'#13'payer '+IntToStr(ap)+#13'même en vendant'#13'tous vos'#13'événements.'#13' '#13'Vous êtes ÉLIMINÉ(E) !';
                          if not Jr[JrCrt].Automate then
                            stMessage := stMsg + #13' '#13'Appuyez sur '+Enrichit('ENTRÉE', cBlanc, cNoir)+'.'
                          else
                            stMessage := stMsg;
                          DessineScores;
                          DessineSelonTypeAffichage;
                          DessineEvenements;
                          PhaseSvt := phtJoueurSvt;
                          if Jr[JrCrt].Automate then
                            TimerAutomate.Enabled := True;
                          Exit;
                          end
                        else // Liquidation d'événements
                         begin
                         if Jr[JrCrt].Automate then
                           begin // Pour les automates on vend n'importe quel événement
                           ne := 1 + Random(NbEvenements(JrCrt));
                           repeat
                             EvtAVendreSvt;
                             Dec(ne);
                           until ne = 0;
                           PhaseSvt := nvPhase;
                           end;
                         // On retient la phase courante (PhaseSvt) pour y revenir dès que l'on quitte l'opération de vente
                         PhaseSvt := nvPhase;
                         Phase := phtVenteEvt;
                         Exit;
                         end;
                      end;
                    ActionCasePion;   // Action correspondant à la case
                    end;
  phtVenteEvt:    with FormPlateau do
                    begin
                    FPhase := NvPhase;
                    VenteEvenements;
                    end;
  phtAchatEvt:    with FormPlateau do
                    FPhase := NvPhase;
  phtJoueurSvt:   JoueurSuivant;
end{case of};
end{procedure TPartie.ChangePhase};

procedure TPartie.Elimine(Id: TJoueurId);
begin
jr[JrCrt].Elimine := True;
jr[JrCrt].PosElm := PosElm;
Dec(PosElm);
end;

procedure TPartie.DessineCase(x, y : TCoordonnee);
var j  : TJoueurId;
    te : TTypeEvt;
    dp : TDirPoss;
begin
if TypeCase[x, y] > tcIndefini then
  begin
  j:=jIndefini;
  dp := dpAucune;
  if (Phase = phtChxDirPion) and
     (x = Jr[JrCrt].Pion.x) and
     (y = Jr[JrCrt].Pion.y) then
    dp := DirPossJr[JrCrt, x, y]
  else
    begin
    te := TypeEvtCase[TypeCase[x, y]];
    if te>teIndefini then // La case est un événement
      j:=Evt[te].CaseEvt[TNumCaseEvt(NumCase[x, y])].Id; // On récupère le JoueurId
    end;
  FormPlateau.DessineCase(j, x, y, dp);
  end;
end;

procedure TPartie.DessineScores;
var i, j    : TJoueurId;
    si, sj,
    pei,pej : Integer;
    Pos     : array [TJoueurId] of Integer;
begin
for i := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  begin
  Pos[i]:=0;
  si := Score(i);
  pei := Jr[i].PosElm;
  for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
    begin
    sj := Score(j);
    pej := Jr[j].PosElm;
    if (pej<pei) or                            // Positions d'éliminés
       ((pej=pei) and (si<sj)) or              // Scores
       ((pej=pei) and (si=sj) and (j<=i)) then // Tours de jeu
      Inc(Pos[i]);
    end;
  end;
for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  FormPlateau.DessineScore(j, Pos[j], Score(j), j=JrCrt, Jr[j].Automate, Jr[j].Elimine);
end;

procedure TPartie.DessineJackpot;
begin
FormPlateau.DessineJackpot(Jckpt.CumulScore(TrCrt), Jckpt.DrnSc, Jckpt.DrnJr);
end;

procedure TPartie.DessineLanceDes;
begin
FormPlateau.DessineLanceDes(JrCrt, De);
end;

procedure TPartie.DessineBilan;
begin
FormPlateau.DessineBilan(TrCrt);
end;

procedure TPartie.DessineEvolution;
begin
FormPlateau.DessineEvolution;
end;

procedure TPartie.DessineStatsEvts;
begin
FormPlateau.DessineStatsEvts;
end;

procedure TPartie.DessineStatsDes;
begin
FormPlateau.DessineStatsDes;
end;

procedure TPartie.DessineStatsJrs; // v1.1.3 : Ajout stats par joueur
begin
FormPlateau.DessineStatsJrs;
end;

procedure TPartie.DessineSelonTypeAffichage;
begin
case FormPlateau.TypeAffichage of
  taBilanTour: DessineBilan;
  taEvolution: DessineEvolution;
  taStatsEvts: DessineStatsEvts;
  taStatsDes : DessineStatsDes;
  taStatsJrs : DessineStatsJrs; // v1.1.3 : Ajout stats par joueur
end{case of}
end;

procedure TPartie.DessineEvenement(TypeEvt : TTypeEvt);
begin
FormPlateau.DessineEvenement(TypeEvt, Evt[TypeEvt].CaseEvt[ncePrm].Id, Evt[TypeEvt].CaseEvt[nceDrn].Id);
end;

procedure TPartie.DessineCompteurEvt(Couleur : TCouleur; PlusBlanc : Boolean);
begin
FormPlateau.DessineCompteurEvt(Couleur);
if PlusBlanc then // événements libres
  FormPlateau.DessineCompteurEvt(cBlanc);
end;

procedure TPartie.DessineEvenements;
var te : TTypeEvt;
    c  : TCouleur;
begin
for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  DessineEvenement(te);
for c := Succ(Low(TCouleur)) to TCouleur(Nbj) do
  DessineCompteurEvt(c, SansBlanc); // ON affiche pas le compteur blanc (affiché après une fois)
DessineCompteurEvt(cPourpre, SansBlanc);
DessineCompteurEvt(cBlanc, SansBlanc);
end;

procedure TPartie.ChoisitDirection;
begin
Jr[JrCrt].ChoisitDirection;
end;

procedure TPartie.AvancePion;
var xPrc, yPrc : TCoordonnee;
begin
xPrc := Jr[JrCrt].Pion.x;
yPrc := Jr[JrCrt].Pion.y;
Jr[JrCrt].AvancePion;
DessineCase(xPrc, yPrc);
DessineCase(Jr[JrCrt].Pion.x, Jr[JrCrt].Pion.y);
end;

procedure TPartie.DeplacePion(x, y : TCoordonnee);
var xPrc, yPrc : TCoordonnee;
begin
xPrc := Jr[JrCrt].Pion.x;
yPrc := Jr[JrCrt].Pion.y;
Jr[JrCrt].Pion.x := x;
Jr[JrCrt].Pion.y := y;
Jr[JrCrt].DeplacePion(x, y);
DessineCase(xPrc, yPrc);
DessineCase(x, y);
end;

function TPartie.NbJoueursRestants : Integer;
var j : TJoueurId;
begin
Result := 0;
for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  if not Jr[j].Elimine then
    Inc(Result);
end;

procedure TPartie.JoueurSuivant;
var Pos   : array [TJoueurId] of Integer;
    i     : Integer;
    j     : TJoueurId;
    stMsg : String;
begin
if (NbJoueursRestants=1) then // FIN DE JEU
  begin
  // 1. On calcule le classement final
  for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
    if Jr[j].Elimine then
      Pos[j] := Jr[j].PosElm
    else
      Pos[j] := 1;
  for i := 1 to Nbj do
    for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
      if Pos[j] = i then
        stMsg := stMsg + #13+Enrichit(IntToStr(i)+'. '+stNomJoueur[j], cNoir, TCouleur(j));
  // 2. On affiche le classement
  FormPlateau.stMessage := 'Partie terminée'#13' '+stMsg;
  // 3. On arrête la partie
  Phase := phtIndefinie;
  Etat := epInactif; // permet d'afficher Nouvelle Partie
  Exit;
  end;
if (JrCrt < TJoueurId(Nbj)) then
  JrCrt := Succ(JrCrt) // Joueur Suivant
else // On a passé le dernier joueur, on met Jackpot
  if JrCrt = jJackpot then
    JrCrt := Succ(Low(TJoueurId)) // Premier joueur
  else
    begin // On a passé le dernier joueur
    JrCrt := jJackpot;
    TourSuivant; // Inclut JoueurSuivant (jJackPot -> jMyrtille)
    end;
if Jr[JrCrt].Elimine then
  JoueurSuivant
else
  begin
  DessineScores; // Pour l'affichage du joueur courant
  if not Jr[JrCrt].Automate then
    FormPlateau.TimerClignotement.Enabled := True; // On signale au joueur (humain) où est le pion
  Phase := phtLanceDes;
  end;
end;

procedure TPartie.InitialiseTour;
var j : TJoueurId;
begin
for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
  Jr[j].Score.Initialise(TrCrt);
Jckpt.Score.Initialise(TrCrt);
DessineSelonTypeAffichage;
end;

procedure TPartie.TourSuivant;
begin
Inc(TrCrt);
InitialiseTour;
JoueurSuivant;
end;

procedure TPartie.Demarre;
begin
Etat := epEnCours;
TourSuivant
end;

procedure TPartie.Paie(Score : Integer; Crediteur, Debiteur : TJoueurId);
begin
case Crediteur of
  jIndefini: begin end;
  jJackpot:  Jckpt.Credite(TrCrt, Score, Debiteur);
else
  Jr[Crediteur].Credite(TrCrt, Score, Debiteur);
end{case of};
case Debiteur of
  jIndefini: begin end;
  jJackpot:  Jckpt.Debite(TrCrt, Score, Crediteur);
else
  Jr[Debiteur].Debite(TrCrt, Score, Crediteur);
end{case of};
DessineScores; // Score par joueur
DessineSelonTypeAffichage;
if (Debiteur = jJackpot) or
   (Crediteur = jJackpot) then
  DessineJackpot;
end;

procedure TPartie.Credite(Id : TJoueurId; Score : Integer); // À utiliser si pas de débiteur (exemple vente d'evt)
begin
Jr[Id].Credite(TrCrt, Score, jIndefini);
end;

function TPartie.Score(Id : TJoueurId) : Integer;
begin
Result := Jr[Id].CumulScore(TrCrt);
end;

function TPartie.Score(Id : TJoueurId; Tour : Integer) : Integer;
begin
if Id = jJackpot then
  Result := Jckpt.CumulScore(Tour)
else
  Result := max(0, Jr[Id].CumulScore(Tour)); // On évite les scores négatifs
end;

function TPartie.ScoreTour(Id : TJoueurId; Tour : Integer) : Integer;
begin
Result := Jr[Id].ScoreTour(Tour);
end;

function TPartie.DebitTour(Id : TJoueurId; Tour : Integer) : Integer;
begin
Result := Jr[Id].DebitTour(Tour);
end;

function TPartie.CreditTour(Id : TJoueurId; Tour : Integer) : Integer;
begin
Result := Jr[Id].CreditTour(Tour);
end;

// v1.1 partie enregistrée

function TPartie.Sauve(fs : TFileStream) : Boolean;
const stFrmMsgErr = 'Partie.%s.Sauve';
var j  : TJoueurId;
    te : TTypeEvt;
begin
Result:=True;
try
  with fs do
    begin
    // private
    WriteBuffer(FEtat, sizeof(FEtat));
    WriteBuffer(FPhase, sizeof(FPhase));
    WriteBuffer(PosElm, sizeof(PosElm));
    // public
    WriteBuffer(Reprise, sizeof(Reprise));
    WriteBuffer(PhaseSvt, sizeof(PhaseSvt));
    WriteBuffer(EvtAVendre, sizeof(EvtAVendre));
    // protected
    WriteBuffer(TrCrt, sizeof(TrCrt));
    WriteBuffer(JrCrt, sizeof(TrCrt));
    if not Jckpt.Sauve(fs, TrCrt) then raise EWriteError.CreateFmt(stFrmMsgErr, ['Jckpt']);
    WriteBuffer(De, sizeof(De));
    for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
      if not Jr[j].Sauve(fs, TrCrt) then raise EWriteError.CreateFmt(stFrmMsgErr, ['Jr['+IntToStr(Ord(j))+']']);
    for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
      if not Evt[te].Sauve(fs) then raise EWriteError.CreateFmt(stFrmMsgErr, ['Evt['+IntToStr(Ord(te))+']']);
    WriteBuffer(scDes, sizeof(scDes));
    WriteBuffer(scEvt, sizeof(scEvt));
    end;
except
  Result:=False;
end{try}
end{function TPartie.Sauve};

function TPartie.Charge(fs : TFileStream) : Boolean;
const stFrmMsgErr = 'Partie.%s.Charge';
var j    : TJoueurId;
    te   : TTypeEvt;
    Etat : TEtatPartie;
begin
Result:=True;
try
  with fs do
    begin
    // private
    ReadBuffer(Etat, sizeof(Etat));
    self.Etat := Etat; // Rafraîchit les menus sans rien déclencher
    ReadBuffer(FPhase, sizeof(FPhase));
    ReadBuffer(PosElm, sizeof(PosElm));
    // public
    ReadBuffer(Reprise, sizeof(Reprise));
    ReadBuffer(PhaseSvt, sizeof(PhaseSvt));
    ReadBuffer(EvtAVendre, sizeof(EvtAVendre));
    // protected
    ReadBuffer(TrCrt, sizeof(TrCrt));
    ReadBuffer(JrCrt, sizeof(TrCrt));
    if not Jckpt.Charge(fs, TrCrt) then raise EReadError.CreateFmt(stFrmMsgErr, ['Jckpt']);
    ReadBuffer(De, sizeof(De));
    for j := Succ(Low(TJoueurId)) to TJoueurId(Nbj) do
      if not Jr[j].Charge(fs, TrCrt) then raise EReadError.CreateFmt(stFrmMsgErr, ['Jr['+IntToStr(Ord(j))+']']);
    for te := Succ(Low(TTypeEvt)) to High(TTypeEvt) do
      if not Evt[te].Charge(fs) then raise EReadError.CreateFmt(stFrmMsgErr, ['Evt['+IntToStr(Ord(te))+']']);
    ReadBuffer(scDes, sizeof(scDes));
    ReadBuffer(scEvt, sizeof(scEvt));
    end;
except
  Result:=False;
end{try}
end{function TPartie.Charge};

// ============================================================================
// Initialisation & finalisation
// ============================================================================

initialization
InitialiseRepLocalAppData;
Partie := TPartie.Create(High(TNbJoueurs), [False, False, False, False, False, False, False]);

finalization
FreeAndNil(Partie);

end.
