unit base;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
uses Winapi.Windows, System.Classes, System.IniFiles, Vcl.Graphics;
//----------------------------------------------------------------------------
const NbCasesCote         =  15;
      PositionRelativeMin = -14;
      PositionCaseDepart  =   0;
      PositionRelativeMax =  14;
      NbLettresAlphabet   =  29; // vKA
      NbJetonsSac         = 103; // vKA
      NbMaxJetonsTirage   =   7;
      NbMaxPlacesChevalet =  10;
      NbLettresMinMot     =   2;
      NbLettresMaxMot     = NbCasesCote;

      NbLettresDico       = 101875; // 101764; // 101418; // 101402; // 101396; // 101390; // 101383; // 101339; // 98553; // 98515; // 98504; // 98461; // 98413; // 98402; // vKA. Gwodiko

      BonusScrabble       = 50;
      NbMaxJokers         = 2;
      NbMaxChoixJokers    = 4; // v1.4.1 : S'il y a deux lettres réparties chacunes sur un joker et un jeton lettre alors il y a 4 possibilités.
   // MinutesReflexion    = 3; // v1.5.6. Obsolète. Utilisation de TPartie.TempsReflexion à la place
      NbNiveauxDifficulte = 10; // v1.5
      ValeurJetonMin      = 0; // v1.6
      ValeurJetonMax      = 10; // v1.6
      ModeAutomatique     = True;
      ModeManuel          = False;

      // v1.5 : changement de format : ajout du nombre de solutions >= 50% du top
      // v1.5.3 : changement de format : ajout de TiragePropose[TTour]
      // v1.6 : changement de format : ajout de TpsCalculSol[TTour] et CumulTpsCalculSol[TTour]
      // v1.6.5 : Pour la feuille de match plus étroite
      // v1.6.6 : Pas de changement dans la structure de fichier mais un chgt d'affichage de fdm. La version est changée pour éviter le mélange.
      // /!\ NE PAS OUBLIER d'ajouter la nouvelle version dans le test de TPartie.Charge !!!
      VersionFichierCrt   = $166;
      stNomFichierIni     = 'Diplikata.ini';
      stSectionSac        = 'Sac';
      stJoker             = '?';
      stSuffixeRang       : array [0..1] of String = ('er', 'ème');
      stFrmTpsCalcSol     = '%.2f'; // v1.6
      stFrmNbSolParSec    = '%.0f'; // v1.6
      stTopTrouve         : array [Boolean] of String = (' ','*'); // v1.6.3 : indicateur de Top trouvé
//----------------------------------------------------------------------------
type  TBonus = (bAucun,
                bLettreCompteDouble, bLettreCompteTriple,
                bMotCompteDouble, bMotCompteTriple);
      TCoordonnee = 0..NbCasesCote-1;
      TTypeJeton = (tjIndefini, // vKA
                    tjJoker, tjA, tjAn, tjB, tjCh, tjD, tjE, tjEn, tjF, tjG,
                    tjH,     tjI, tjJ, tjK, tjL, tjM, tjN, tjNg, tjO, tjOn,
                    tjOu,    tjP, tjR, tjS, tjT, tjUi, tjV, tjW, tjY, tjZ);
      TGenreLettre=(glIndefini, glConsonne, glVoyelle);
      TNumeroJetonSac           = 0..NbJetonsSac; // 0 = pas de jeton
      TOrdreJetonSac            = 1..NbJetonsSac; // Ordre de tirage des jetons dans le sac
      TNumeroJetonTirage        = 0..NbMaxJetonsTirage; // 0 = pas de jeton
      TOrdreJetonTirage         = 1..NbMaxJetonsTirage; // Ordre de tirage des jetons dans le jeu courant
      TNbJetonsTirage           = 0..NbMaxJetonsTirage; // v1.4.1. Utilisé pour ChoixJokerOuLettre
      TOrdreJetonChevalet       = 1..NbMaxPlacesChevalet; // Place des jetons sur le chevalet
      TNumeroJetonChevalet      = 0..NbMaxPlacesChevalet; // 0 = pas de jeton
      TChevalet                 = array [TOrdreJetonChevalet] of TNumeroJetonSac;
      TDirection                = (dIndefinie, dHorizontale, dVerticale);
      TTour                     = 1..NbJetonsSac;
      TNbLettres                = NbLettresMinMot..NbLettresMaxMot;
      TIndexDico                = 0..NbLettresDico-1;
      TNumeroJoker              = 0..NbMaxJokers; // 0 = Pas de joker
      TOrdreJoker               = 1..NbMaxJokers; // Correspond aussi à TNumeroSac pour les jokers
      TNbJokers                 = 0..NbMaxJokers; // v1.4.1. Utilisé pour ChoixJokerOuLettre
      TChoixLettreJoker         = (cljAucun, cljLettre, cljJoker, cljLettreEtJoker); // v1.4.1
      TActionChoixLettreJoker   = (acIgnorer, acChercher, acChercherSuivant, acResterDessus); // v1.4.1
      TPositionRelative         = PositionRelativeMin..PositionRelativeMax;
      TPositionMot              = 1..NbCasesCote;
      TJoker                    = array [TOrdreJoker] of TNumeroJoker;
      TLettreJoker              = array [TOrdreJoker] of TTypeJeton;
      TPlateau                  = array [TCoordonnee, TCoordonnee] of TNumeroJetonSac;
      TSac                      = array [TOrdreJetonSac] of TOrdreJetonSac;
      TTirage                   = array [TOrdreJetonTirage] of TNumeroJetonSac;
      TSubstitutJoker           = array [TOrdreJetonSac] of Boolean; // v1.5.6
      TFormatRapport            = (frPourcentage, frNoteSur20);
      TTypeProposition          = (tpRecherche, tpProposition, tpPose); // v1.4 : dernier argument de MotsFormesValables
      TLettreJetonPlace         = 'A'..'û'; // v1.4.3 // vKA : il faut ajouter les lettres accentuées des lettres doubles ('û' au lieu de 'z')
      TDifficulteTirage         = (dtIndefinie=-1,
                                   dt0Etoile=0,
                                   dtDemiEtoile=1,
                                   dt1Etoile=2,
                                   dt1EtoileEtDemie=3,
                                   dt2Etoiles=4,
                                   dt2EtoilesEtDemie=5,
                                   dt3Etoiles=6,
                                   dt3EtoilesEtDemie=7,
                                   dt4Etoiles=8,
                                   dt4EtoilesEtDemie=9,
                                   dt5Etoiles=10);
      TCibleStats  = (csHumain, csMachine); // v1.5.1 : déplacé de statspartie_f
      TTempsReflexion           = (trIndefini=0, trBlitz, trSemiRapide, trNormal); // v1.5.6
      TTypePartie               = (tpIndefini=0, tpStandard, tpJoker); // v1.5.6
      TLocalisationJeton        = (ljInconnue=0, ljPlateau, ljChevalet, ljSac); // v1.5.6
      TLangue                   = (lFrancais=0, lKreyol=1); // v1.8 multilingue
     //-----------------------------------------------------------------------
      TAnagrammes = class(TObject)
      public
        NbAnagrammes : Integer;
        iDico : array of Integer; // Index pour TDico.stMotDico
      end;
     //-----------------------------------------------------------------------
      TRecherche = class
      private
        ChargementDicoOk : Boolean;
      public
        Tirages : array [TNbLettres] of TStringList;
        constructor Cree;
        destructor  Detruit;
      end;
     //-----------------------------------------------------------------------
      TDico = class
      private
        Index : array [TNbLettres] of Integer;
        Dico  : array [TIndexDico] of Char;
      public
        Rech  : TRecherche;
        ChargementDicoOk : Boolean;
        constructor Cree;
        destructor  Detruit;
        function Existe(const stMot : String) : Boolean;
        function stMotDico(const TailleMot, IndexDico : Integer) : String;
        function IndexProchainMot(const IndexDebut : Integer; const stFiltre : String) : Integer;
      end{class TDico};
      //-----------------------------------------------------------------------
      TSolution = class(TObject)
      public
        stMot       : String;
        x,y         : TCoordonnee;
        d           : TDirection;
        Chevalet    : TChevalet;
        Debut, Fin  : TOrdreJetonChevalet;
        LettreJoker : TLettreJoker;
        constructor Cree(const stMot : String; const x, y : TCoordonnee; const d : TDirection; const Chevalet : TChevalet; const Debut, Fin: TOrdreJetonChevalet; const NumeroJoker : TJoker; const LettreJoker : TLettreJoker);
        constructor Clone(const solution : TSolution);
        destructor  Detruit;
        procedure ChargeChevalet(var Chevalet : TChevalet);
        procedure ChargeLettresJoker(var LettreJoker : TLettreJoker);
        procedure DechargeLettresJoker(var LettreJoker : TLettreJoker);
      end;
      //----------------------------------------------------------------------
      TPartie = class
      private
        LettreAEchanger, JokerAEchanger : TOrdreJetonSac; // v1.5.6 : Déclarées ici car modifiées dans AjouteJokerAuTirage mais utilisées pour mettre à jour Chevalet dans l'appel depuis ChangeTirage
        procedure InitialisePartie;
        function MotForme90Valable(const X, Y : TCoordonnee;
                                   const d : TDirection;
                                   const stLettrePosee : String;
                                   var stMot : String) : Boolean;
        function ScoreMot90(const X, Y : TCoordonnee;
                            const d : TDirection;
                            const LettrePosee : TNumeroJetonSac) : Integer;
        procedure RetireJetons(const Chevalet : TChevalet;
                               const Debut, Fin : TOrdreJetonChevalet);
        procedure CompleteTirage;
      public
        NumeroPartie        : Integer; // v1.5.3 : Public. v1.5 : Permet d'identifier une partie pour les records associés avant qu'un nom lui soit donné
        VersionFichier      : Integer; // v1.4 : Permet de rendre compatible des comportements de versions antérieures (exemple : format de la FdM RTF)
        Dico                : TDico;
        c                   : TPlateau; // Cases du plateau de jeu
        s                   : TSac;  // Contenu du sac
        t                   : TTirage; // Contenu du tirage
        SubstitutJoker      : TSubstitutJoker; // v1.5.6. Indique que le jeton était un joker et qu'il a été substitué par une lettre.
        TypePartie          : TTypePartie;         // v1.5.6
        TempsReflexion      : TTempsReflexion; // v1.5.6
        Proposition         : array [TCoordonnee, TCoordonnee] of Boolean; // Si Proposition alors True sinon False
        NumeroJoker         : TJoker;// v1.4 : Défini après un appel à MotsFormesValables
        LettreJoker         : TLettreJoker;
        Score, ScoreTop, ScorePartie, // v1.4 (Score Proposition, Score Top, Score Pose)
        Cumul, CumulTop, CumulPartie, // v1.4 (Cumul Proposition, Cumul Top, Cumul Pose)
        NbSolSupEgalMoitieTop, // v1.5 : pour calculer la difficulté du tirage
        NbSolBonus50,          // v1.5
        CumulNbSolBonus50,     // v1.5
        PosPrp, NbSol,
        CumulPosPrp,
        CumulNbSol,
        xPrp, yPrp,
        xSol, ySol            : array [TTour] of Integer;
        dPrp, dSol            : array [TTour] of TDirection;
        BonusScrabblePrp,
        BonusScrabbleSol,
        TiragePropose         : array [TTour] of Boolean; // v1.5.3 (TiragePropose) : empêche l'enregistrement des records si tirage proposé
        stTirage,
        stProposition,
        stSolution            : array [TTour] of String;
        Temps, CumulTemps,
        CumulNbSolSEMoitieTop,// v1.5 : pour calculer la difficulté du tirage. v1.5.1 : Pondéré par ScoreTop. Directement cumul de ScoreTop*NbSolSEMT/NbSol (Integer => Double)
        TpsCalculSol,         // v1.6
        CumulTpsCalculSol     : array [TTour] of Double; // v1.6
        TailleMaxMotForme,    // v1.5 : calculé dans ScorePose (pour records de taille max mot formé)
        ScoreSolPose,         // v1.5.5 : Score des solutions affichées dans FormSolutions et défini dans Cherche
        ScoreMax, NbMaxSol    : Integer; // pour l'affichage des stats
        Tour                  : TTour;
        ProchainJetonATirer   : Integer; // En fait TOrdreJetonSac mais doit pouvoir passer au delà pour détecter le sac vide !
        PremierJetonTire      : TNumeroJetonTirage;
        DistanceCaseDrnJetonPlace : Integer; // Permet le rafraichissement des cases du plateau après placement
        PropositionAvecUnSeulJetonPlace : Boolean; // Permet de repérer la pose d'un seul jeton afin de choisir la bonne direction (celle qui donne le mot principal le plus long)
        JokerPropositionAvecUnSeulJetonPlace : TNumeroJoker; // Si un seul jeton posé alors on retient le joker affecté (car effacé par la suite)
        LettreJokerPropositionAvecUnSeulJetonPlace : TTypeJeton; // Si un seul jeton posé alors on retient la lettre choisie (car effacée par la suite)
        DemoEnCours           : Boolean; // v1.5 : alimenté depuis l'unité main_f pour avoir accès au mode démo dans TPartie.Cherche
        stNomPartie,    // v1.5 : alimenté depuis l'unité main_f pour avoir accès au nom depuis l'unité base
        stMotTailleMax, // v1.5 : calculé dans ScorePose (pour records de taille max mot formé)
        stMotPrincipal, // v1.4 : Mot principal défini après un appel à MotsFormesValables
        stMessage             : String; // Rempli par les fonctions testant les mots et qui renvoient False
        function AjouteJokerAuTirage : Boolean; // v1.5.6
        function RemetJokersDansSac(var Chevalet : TChevalet; const Debut, Fin : TOrdreJetonChevalet) : Boolean; // v1.5.6. Renvoie True si au moins un joker a été remis dans le sac
        function TirageOKVerifieSiNecessaire(var Chevalet : TChevalet) : Boolean; // v1.5.6
        function ProchainNumeroPartie(const Incremente : Boolean) : Integer; // v1.5.3 : public + argument Incremente. v1.5 : Permet d'identifier une partie pour les records associés avant qu'un nom lui soit donné
        function TirageInchangeable : Boolean; // v1.5
        procedure ChargeOrdreSac; //v1.1 (private -> public)
        procedure SauveOrdreSac;  //v1.1 (private -> public)
        function stCoordonnees(const X, Y : TCoordonnee) : String; overload; // Sans direction
        function stCoordonnees(const X, Y : TCoordonnee; const d : TDirection) : String; overload; // Avec direction Lettre-Nombre=Horizontal & Nombre-Lettre=Vertical
        function stCoordonnees(const X, Y : TCoordonnee; const d : TDirection; const k : Integer) : String; overload; // v1.7.2 : Avec k position relative du premier jeton du mot pour afficher les coordonnées du premier jeton du mot en fonction des coordonnées du premier jeton posé.
        function ScorePose(const X, Y : TCoordonnee;
                           const d : TDirection;
                           const Chevalet : TChevalet;
                           const Debut, Fin : TOrdreJetonChevalet) : Integer;
        procedure JoueTour(const X, Y : TCoordonnee;
                           const d : TDirection;
                           var Chevalet : TChevalet; // v1.5.6 (const>var à cause de RemetJokersDansSac)
                           const Debut, Fin : TOrdreJetonChevalet);
        constructor Cree;
        destructor Detruit;
        procedure CommencePartie;
        function NbJetonsAJouer : TNumeroJetonTirage;
        function stLettre(const X, Y : TCoordonnee) : String; overload;
        function stLettreLD(const X, Y : TCoordonnee) : String; overload; // vKA : avec lettres doubles
        function stLettre(const NumeroJeton : TNumeroJetonSac) : String; overload; // N° de jeton du sac et non n° d'ordre dans le sac
        function stLettreLD(const NumeroJeton : TNumeroJetonSac) : String; overload; // vKA : avec lettres doubles
        function stLettreAJ(const NumeroJeton : TNumeroJetonSac) : String; // v1.4.3: Renvoie une minuscule s'il s'agit d'un joker.
        function GenreLettreJeton(const NumeroJeton : TOrdreJetonSac) : TGenreLettre;  // N° de jeton du sac et non n° d'ordre dans le sac
        function TirageAcceptable : Boolean;
        function NbJetonsPoses : Integer; // v1.5.3
        function NbJetonsAPlacer(const Chevalet : TChevalet;
                                 const Debut, Fin : TNumeroJetonChevalet) : Integer;
        function NbJokersAPlacer(const Chevalet : TChevalet; // v1.5 pour classement choix de solutions tops
                                 const Debut, Fin : TNumeroJetonChevalet) : Integer;
        function ValeurAPlacer(const Chevalet : TChevalet; // v1.5 pour classement choix de solutions tops
                               const Debut, Fin : TNumeroJetonChevalet) : Integer;
        function MotsFormesValables(const X, Y : TCoordonnee; // Test des mots formés
                                    const d : TDirection;
                                    const Chevalet : TChevalet;
                                    const Debut, Fin : TOrdreJetonChevalet;
                                    const TypeProposition : TTypeProposition) : Boolean; // v1.4 : TTypeProposition au lieu de Boolean
        function EstJouable(const X, Y : TCoordonnee; // Test du placement
                            const d : TDirection;
                            const Chevalet : TChevalet;
                            const Debut, Fin : TOrdreJetonChevalet) : Boolean;
        function JetonIsoleDirectionChoix(const X, Y : TCoordonnee; // v1.5
                                          const d : TDirection) : Boolean;
        // fonctions de stockage. Pas d'extension : .dip => Partie. .rtf => Feuille de match en format rtf.
        function Sauve(const stNomFichier : String; const Chevalet : TChevalet;
                       const Debut, Fin : TNumeroJetonChevalet;
                       const xPopup, yPopup : Integer) : Boolean;
        function Charge(const stNomFichier : String;   var Chevalet : TChevalet;
                          var Debut, Fin : TNumeroJetonChevalet;
                          var xPopup, yPopup : Integer;
                          var stMessage : String) : Boolean;
        function PartieEnCours : Boolean;
        function stSac : String;
        procedure PlaceJetons(const X, Y : TCoordonnee;
                              const d : TDirection;
                              const Chevalet : TChevalet;
                              const Debut, Fin : TOrdreJetonChevalet;
                              const EstProposition : Boolean);
        procedure ChangeTirage(var Chevalet : TChevalet); // Prend chaque jeton du chevalet et l'échange contre un du sac
        procedure Cherche(var slSolutions : TStringList);
        procedure EnregistreSolution(const Solution : TSolution);
        procedure EnregistreProposition(const x, y : TCoordonnee; const d : TDirection);
        function stHTMLPoseStyleEtCouleurAppliques(const Tour : TTour; const Cible : TCibleStats) : string; // v1.5.1 (factorisation+utilisation extérieure)
        procedure GenereFeuilleMatchDetaillee(const stNomFichier : String; const Affichage : Boolean); // v1.3.5 (Affichage)
      end{class};
      //----------------------------------------------------------------------
      TSourceRecord    = (srGenerale, srProposition, srTop); // v1.5
      TNiveauRecord    = (nvrTour, nvrPartie); // v1.5
      TTypeRecord      = (trMin, trMax); // v1.5
      TNatureRecord    = (ntrScore, // v1.5
                          ntrNbBonus,
                          ntrTailleMot,
                          ntrNivDiff,
                          ntrNbSolSurRg,
                          ntrNbSolutions,
                          ntrNbSolBonus,
                          ntrRptScoreTop,
                          ntrNbTopsTrv,
                          ntrTpsCalcSol,   // v1.6
                          ntrNbSolParSec); // v1.6
      TInfoRecord      = (irNumeroPartie, irNomPartie, irTour, irValeur, irLibelle, irDateHeure);
      TCibleInfoRecord = (cirFenetre, cirPageHTML); // v1.5 : pour fonction stHTMLValeur(TCibleInfoRecord)
      //----------------------------------------------------------------------
      TRecord = class // v1.5
      private
        function stEntreeRecord(const Info : TInfoRecord) : String;
      public
        Source      : TSourceRecord;
        Niveau      : TNiveauRecord;
        MinMax      : TTypeRecord;
        Nature      : TNatureRecord;
        TypePartie  : TTypePartie; // v1.5.7
        stNomPartie,
        stDateHeure : string;
        NumeroPartie,
        Tour,
        Valeur      : Integer;
        stLibelle   : String;
        constructor Cree(const Source : TSourceRecord; const Niveau : TNiveauRecord; const MinMax : TTypeRecord; const Nature : TNatureRecord; const TypePartie : TTypePartie); // v1.5.7 (TTypePartie)
        destructor Detruit;
        procedure Enregistre(const Tour, Valeur : Integer; const stLibelle : String; const Affiche : Boolean);
        function TesteRecord(const Tour, Valeur : Integer; const stLibelle : String; const Affiche : Boolean) : Boolean;
        procedure Charge(const IniFile : TIniFile);
        function RecordPossible : Boolean;
        function AucunRecord : Boolean;
        function stHTMLValeur(const Cible : TCibleInfoRecord) : String;
        function stLibelleSansCodeHTML : string; // v1.5.1
      end;
      //----------------------------------------------------------------------
      TRecords = class // v1.5
      private
      public
        AfficheNouveauxRecords : Boolean;
        r : array [TSourceRecord, TNiveauRecord, TTypeRecord, TNatureRecord, TTypePartie] of TRecord; // v1.5.7 (TTypePartie)
        constructor Cree;
        destructor Detruit;
        procedure Charge; // v1.6.1 : n'est plus private car utilisée par TFormMain.ActionOptionsReinitialiserRecordsExecute
        // Renvoie true si record battu
        function MeilleurRecord(const Source : TSourceRecord; const Niveau : TNiveauRecord; const MinMax : TTypeRecord; const Nature : TNatureRecord) : TRecord; // v1.5.8 : retourne le meilleur record tout type de partie confondu
        function TesteRecord(const Source : TSourceRecord; const Niveau : TNiveauRecord; const MinMax : TTypeRecord; const Nature : TNatureRecord; const Tour, Valeur : Integer; const stLibelle : String) : Boolean;
        function AssocieNomPartie : Boolean; // v1.5 : Utilisé pour associer le nom de la partie qui vient d'être enregistrée à ses records. Renvoie True si un record a été modifié (pour regénérer derrière la liste des records HTML.)
      end;
      //----------------------------------------------------------------------
      TDefi15Lettres = class // v1.5.3
      private
        slMot : TStringList; // Triée par score décroissant puis alpha. Syntaxe : "Mot=Valeur". Cf. ../bin/html/top15.txt
      public
        constructor Cree;
        destructor Detruit;
        function NumeroMot(const stMot : string) : Integer;
        function ValeurMot(const stMot : string) : Integer;
        procedure ChargeDefi(const iDefi : Integer; var stMot : String; var NbJetons, NbCoups, ScoreMot, CumulScore : Integer); overload; // v1.5.4
        function ChargeDefi(const stMotATester : String; var NbJetons, NbCoups, ScoreMot, CumulScore : Integer) : Integer; overload; // Renvoie le numéro d'entrée du défi dans le fichier Ini
        procedure EnregistreDefi(const stMot : String; const NumeroDefi, NbJetons, NbCoups, ScoreMot, CumulScore : Integer);
        function DefisEnregistres : Integer; // v1.5.4
        function TesteDefiRecord : String; // v1.5.4 : Renvoie le mot record (courant ou battu)
        function TesteDefi : Boolean; // v1.5.3 : Renvoie True si le défi est enregistré (nouveau ou battu)
        procedure GenereListeDefis(const stNomFichier : String; const Affichage : Boolean);
      end;
      //----------------------------------------------------------------------
const CoefBonusMot    : array [TBonus] of Integer = (1,1,1,2,3);
      CoefBonusLettre : array [TBonus] of Integer = (1,2,3,1,1);
      BonusCase : array [TCoordonnee, TCoordonnee] of TBonus =
        ((bMotCompteTriple   , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteTriple   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bMotCompteTriple   ),
         (bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             ),
         (bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             ),
         (bLettreCompteDouble, bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bLettreCompteDouble),
         (bAucun             , bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bAucun             ),
         (bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             ),
         (bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             ),
         (bMotCompteTriple   , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bMotCompteTriple   ),
         (bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             ),
         (bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             ),
         (bAucun             , bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bAucun             ),
         (bLettreCompteDouble, bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bLettreCompteDouble),
         (bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             , bAucun             ),
         (bAucun             , bMotCompteDouble   , bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bLettreCompteTriple, bAucun             , bAucun             , bAucun             , bMotCompteDouble   , bAucun             ),
         (bMotCompteTriple   , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bAucun             , bMotCompteTriple   , bAucun             , bAucun             , bAucun             , bLettreCompteDouble, bAucun             , bAucun             , bMotCompteTriple   ));

      // début vKA
      ValeurJeton   : array [TTypeJeton]   of Integer   = (0,0,1,4,3,3,2,1,4,4,3,10,1,2,3,1,2,1,10,1,4,3,3,3,1,1,10,4,2,2,2);
      stLettreJeton : array [TTypeJeton] of String      = (''#0'', // v1.4.5 : au lieu de '' permettant d'obtenir une chaîne à un seul caractère #0 et empêchant un message d'erreur.
                                                           ' ','A','Â','B','Ç','D','E','Ê','F','G',
                                                           'H','I','J','K','L','M','N','Ñ','O','Ô',
                                                           'Û','P','R','S','T','Î','V','W','Y','Z');
      EstDoubleLettre : array [TTypeJeton] of Boolean   = (false,
                                                           false,false, true,false, true,false,false,true,false,false,
                                                           false,false,false,false,false,false,false,true,false, true,
                                                            true,false,false,false,false, true,false,false,false,false);
      stAffichageJeton : array [TTypeJeton] of String   = (''#0'', // vKA : affichage réel sur les jetons (de 1 à 2 lettres)
                                                           ' ','A','An','B','Ch','D','E','En','F','G',
                                                           'H','I','J','K','L','M','N','Ng','O','On',
                                                           'Ou','P','R','S','T','Ui','V','W','Y','Z');

      // 7 Double lettres : Â=An, Ç=Ch, Ê=En, Ñ=Ng, Ô=On, Û=Ou, Î=Ui. vKA
      // fin vKA

      stTirageVide            = '       ';
      stHTMLEspaceInsecable   = '&nbsp;'; // v1.5
      // v1.5.7 : <td align="center">...</td> a été retiré pour les deux lignes suivantes
      stHTMLRecordNonAttribue = '<i>-</i>';    // v1.5
      stHTMLRecordAucun       = '<i>Aucun record</i>'; // v1.5
      TypeJeton : array [TNumeroJetonSac]    of TTypeJeton = (tjIndefini, tjJoker, tjJoker,  // vKA
                                                               tjA,  tjA,  tjA,  tjA,  tjA, tjA, tjA, tjA, tjA, tjAn, tjAn,  tjB, tjB, tjCh, tjCh,  tjD,  tjD,
                                                               tjD,  tjE,  tjE,  tjE,  tjE, tjE, tjE, tjE, tjE,  tjE,  tjE,  tjE, tjE,  tjE,  tjE, tjEn, tjEn,
                                                               tjF,  tjF,  tjG,  tjG,  tjH, tjI, tjI, tjI, tjI,  tjI,  tjJ,  tjJ, tjJ,  tjK,  tjK,  tjK,  tjK,
                                                               tjL,  tjL,  tjL,  tjL,  tjL, tjM, tjM, tjN, tjN,  tjN,  tjN, tjNg, tjO,  tjO,  tjO,  tjO,  tjO,
                                                              tjOn, tjOn, tjOu, tjOu, tjOu, tjP, tjP, tjR, tjR,  tjR,  tjR,  tjS, tjS,  tjS,  tjS,  tjT,  tjT,
                                                               tjT,  tjT,  tjT, tjUi,  tjV, tjV, tjW, tjW, tjW,  tjW,  tjY,  tjY, tjY,  tjZ,  tjZ,  tjZ);

      GenreJeton : array [TTypeJeton]      of TGenreLettre = (glIndefini, glIndefini, // vKA
                                                              glVoyelle,  glVoyelle,  glConsonne, glConsonne, glConsonne, glVoyelle,  glVoyelle,  glConsonne, glConsonne, glConsonne,
                                                              glVoyelle,  glConsonne, glConsonne, glConsonne, glConsonne, glConsonne, glConsonne, glVoyelle,  glVoyelle,  glVoyelle,
                                                              glConsonne, glConsonne, glConsonne, glConsonne, glVoyelle,  glVoyelle, glConsonne, glVoyelle,  glConsonne); // vKA : attention, le W est une voyelle !

      dx : array [TDirection]             of Integer       = ( 0, 1, 0);
      dy : array [TDirection]             of Integer       = ( 0, 0, 1);

      dxBabord  : array [TDirection]      of Integer       = ( 0, 0, 1);
      dyBabord  : array [TDirection]      of Integer       = ( 0,-1, 0);

      dxTribord : array [TDirection]      of Integer       = ( 0, 0,-1);
      dyTribord : array [TDirection]      of Integer       = ( 0, 1, 0);

      XCentre : TCoordonnee = High(TCoordonnee) div 2;
      YCentre : TCoordonnee = High(TCoordonnee) div 2;

      Dir90 : array [TDirection]          of TDirection    = (dIndefinie, dVerticale, dHorizontale);

      // Constantes pour le dictionnaire
      nbl : array [TNbLettres] of Integer            = (310,2589,8020,15540,18276,19159,14784,9594,6190,3641,2112,1092,448,120); // vKA : Référence du gwodiko

      stNomFichierDico                                = 'L23456789ABCDEF'; // ODS
      stNomFichierRech                                = 'R23456789ABCDEF'; // ODS
      stVersionDico                                   = 'Gwodiko'; // vKA (créé v1.5.3)
      stMsgMotNonValable                              : array [Boolean] of String = ('Le mot %s n''est pas valable selon le '+stVersionDico+'.', // v1.5.3 : ajout stVersionDico
                                                                                     'Les mots %s ne sont pas valables selon le '+stVersionDico+'.'); // v1.3.1, v1.6 : tableau.
      stDirection       : array[TDirection] of String = ('', 'Horizontalement',
                                                             'Verticalement');
      stFrmFichierIntrouvable =  'Le fichier %s est introuvable !';
      stErreurInattendue      = 'Erreur inattendue';

      // v1.5.5 : Déplacé ici pour utilisation dans sous procédure AjouteSolution (était dans GenereListeSolutionsTriees)
      PosPosition             = 11;
      TaillePosition          = 3;
      PosSolution             = 15;

      Proposition             : Boolean = True;
      CoupJoue                : Boolean = False;
      // v1.5 : les deux constantes ci-dessous rendues publics pour TFormMain.GenereListeRecords depuis l'unité nvrecord_f et la fonction TRecord.Enregistre depuis l'unité base
      Affiche                 : Boolean    = True;  // v1.4.9 : Pour GenereListePartiesJouees/GenereListeRecords (v1.5)
      NAffichePas             : Boolean    = False; // v1.4.9 : Pour GenereListePartiesJouees/GenereListeRecords (v1.5)
      AjouteUn                : Boolean = True;     // v1.5.3 : pour fonction ProchainNumeroPartie(const Incremente : Boolean) : Integer
      LectureSeule            : Boolean = False;    // v1.5.3 : pour fonction ProchainNumeroPartie(const Incremente : Boolean) : Integer
      MaxFormatRapport        : array [TFormatRapport] of Integer   = (100, 20);
      stFormatRapport         : array [TFormatRapport] of String    = ('%', '/20');
      ComplementScore         : Integer = 9999; // v1.3.6
      stAltDiffTirage         : array [TDifficulteTirage] of String = ('N/A', '0/10', '1/10', '2/10', '3/10', '4/10', '5/10', '6/10', '7/10', '8/10', '9/10', '10/10');
      // v1.5 : gestion des records
      stSectionRecords        = 'Records'; // v1.5. public car besoin pour réintialiser les records depuis FormMain.
      stSourceRecord          : array [TSourceRecord] of String = ('','Proposition','Top');
      stNiveauRecord          : array [TNiveauRecord] of String = ('tour', 'partie');
      stTypeRecord            : array [TTypeRecord] of String   = ('min', 'max');
      stNatureRecord          : array [TNatureRecord] of String = ('Score', // v1.5
                                                                   'Nb Bonus 50',
                                                                   'Taille de mot formé',
                                                                   'Niv.de diff.',
                                                                   'Rapport Nb Sol./Rang', // x100
                                                                   'Nb solutions',
                                                                   'Nb sol. avec bonus', // x100
                                                                   'Rapport Score/Top',
                                                                   'Nb tops trouvés',  // x100
                                                                   'Tps de calc. des sol.', // v1.6
                                                                   'Nb sol. trouvées / s.'); // v1.6
      stTempsReflexion        : array [TTempsReflexion] of String = ('N/A','Blitz (1'')', 'Semi-Rapide (2'')', 'Normal (3'')'); // v1.5.6
      stTypePartie            : array [TTypePartie] of String     = ('N/A','Standard', 'Joker'); // v1.5.6
      stFrmHTMLTypePartie     : array [TTypePartie] of string    = ('','%s','<FONT COLOR="#00FF00">%s</FONT>'); // v1.5.7 : indicateur coloré par type de parties             (v1.6)      (v1.6)
                                                                                  //Score, NbBonus, TailleMot, NivDiff, NbSolSurRg,   NbSol, NbSolBonus, RptScTop, NbTopsTrv, TpsCalcSol, NbSol/s
      EstSourceNatureRecord   : array [TSourceRecord, TNatureRecord] of boolean = ((False,  False,   False,     True,  False,         True,   True,      False,    False,     True,       True),  // Général
                                                                                   (True,   True,    True,      False, True,          False,  False,     True,     True,      False,      False), // Proposition
                                                                                   (True,   True,    True,      False, False,         False,  False,     False,    False,     False,      False));// Top
                                                                                  //Score, NbBonus, TailleMot, NivDiff, NbSolSurRg,   NbSol, RptScTop
      EstNiveauNatureRecord   : array [TNiveauRecord, TNatureRecord] of boolean = ((True,   False,   True,      True,  True,          True,   True,      False,    False,     True,       True),  // Tour
                                                                                   (True,   True,    False,     True,  True,          True,   True,      True,     True,      True,       True)); // Partie
                                                                                  //Score, NbBonus, TailleMot, NivDiff, NbSolSurRg,   NbSol, RptScTop
      EstTypeNatureRecord     : array [TTypeRecord, TNatureRecord]   of boolean = ((False,  False,   False,     True,  False,         True,   False,     False,    False,     True,       True),  // Min
                                                                                   (True,   True,    True,      True,  True,          True,   True,      True,     True,      True,       True ));// Max
      // EstTypePartie           : array [TNiveauRecord, TTypePartie]   of Boolean = ((False, True, False), (False, True, True)); // v1.5.7
      // v1.5.3 : Gestion du défi : Mot de 15 jetons donné posé le plus rapidement possible
      stNomFichierDefi1M15L                = 'Defis1M15L.html';
      stSectionDefiM15L                    = 'DefiM15L';
      stEntreeDefiM15LNbDefis              = 'ND';
      // Les entrées ci-dessous sont indexées
      stEntreeDefiM15LVersionDico          = 'VD';
      stEntreeDefiM15LMot                  = 'M';
      stEntreeDefiM15LNumeroMot            = 'NM';
      stEntreeDefiM15LValeurMot            = 'VM';
      stEntreeDefiM15LNbJetonsPosesHorsMot = 'NJPHM';
      stEntreeDefiM15LNbCoupsJouesHorsMot  = 'NCJHM';
      stEntreeDefiM15LScoreMot             = 'SM';
      stEntreeDefiM15LCumulScoreHorsMot    = 'CSHM';
      stEntreeDefiM15LDateHeure            = 'DH';
      stEntreeDefiM15LNomPartie            = 'NP';

//---------------------------------------------------------------------------
var p                   : TPartie;
    r                   : TRecords; // v1.5
    d15l                : TDefi15Lettres; // v1.5.3
    Journalisation,
    JournalOuvert       : Boolean; // v1.5 : Empêche le Try CloseFile(Journal)
    Journal             : TextFile;
    stRepLocalAppData, // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
    stNomFichierJournal : String; // v1.4
    FormatRapport       : TFormatRapport;
    StockageSolutions   : Boolean; // v1.3.6
    slSolutionsTriees   : TStringList; // v1.3.6
    NbEntreesDico       : Integer; // vKA
    LangueAffichage     : TLangue; // v1.8 multilingue
//---------------------------------------------------------------------------
function stURLCheminNomFichier(const stCheminFichier : String) : String; // v1.5 : pour récupérer l'url pour l'utiliser dans un fichier HTML
procedure OuvreFichierHTML(stCheminFichier : String); // v1.4.6
function CoordonneesValides(const Colonne, Ligne : Integer) : Boolean;
function stTirageTrie(const stTirage : String) : String;
procedure GenereListeSolutionsTriees;
function stCodeCouleurHTMLRapport(const Rapport : Double; const Invisible : Boolean) : String; // v1.5 : 0 <= Rapport <= 1. v1.6.3 : Invisible pour masquer l'affichage
function stURLBitmapNiveauDifficulte(const Difficulte : TDifficulteTirage) : string;
function CalculeNiveauDifficulte(const NbSolSEMT : Double; const NbSol : Integer; var stLibelleAlternatif, stURLBitmap : string) : Integer; // v1.5.1 : Int64 au lieu de Integer
function stDateHeureCourante : String; // v1.5
// v1.5.1 : fonction stHTMLStyleEtCouleurAppliques sortie de la procedure GenereFeuilleMatchDetaillee pour TesteRecord sur les scores max et fournir la solution en couleurs comme sur la Fdmd !
function stHTMLStyleEtCouleurAppliques(const stChaine, stHTMLCodeCouleur : String; const Style : TFontStyles) : String;
function NbJetons(stTirageDL : String) : Integer;// vKA : Remplace Length car il n'y a pas forcément une lettre par jeton !!!!
function stJetonsEnLettres(stJetons : String) : String; // vKA : Convertisseur de Tirage de jetons en lettres (Â=>An, Ê=>En, etc.)
function stLettresEnJetons(stLettres : String) : String; // vKA : Convertisseur de Tirage de lettres en jetons (An=>Â, En=>Ê, etc.)
function stControleLettresEnJetons(stLettres : String) : String; // vKA : Contrôle avant conversion
function stLettresDoubles(stLettres : String) : String; // vKA : transforme les lettres accentuées en lettres doubles en prenant en compte la casse (lettre de joker)
function stHTMLLettresDoubles(stLettres : String) : String; // vKA : transforme les lettres accentuées en lettres doubles en mettant en gris foncé les jokers qui sont en minuscule (version HTML)
function PositionRelativeDebutMot(const x, y : TCoordonnee; d : TDirection) : Integer; // v1.7.2 : on définit la position relative du premier jeton du mot posé ou non sur le plateau par rapport au premier jeton posé pour l'affichage du tableau des solutions
function TypeJetonLettre(const stLettre : String) : TTypeJeton; // v1.7.3 : transforme une lettre en TTYpeJeton, exemple : Â=>tjAn, Ç=>tjCh, etc.
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses
  SysUtils, Math, StdCtrls, Winapi.ShellApi, StrUtils,
  cststr, // v1.5 : constantes chaînes mises dans une unité séparée.
  patience_f, joker_f, fdmatch_f, nvrecord_f, prmpose_f; // v1.5.5 (prmpose_f)
//---------------------------------------------------------------------------
const stAutreChoix            = #13#13'Cliquez sur une autre case départ ou changez la sélection des jetons.';
      stFrmSolution           = '%s : %s en %s';
      stCoordonneesIndefinies = ' - ';
      stLibreOccupee          : array [0..1] of String = ('Occupée', 'Libre');
      AvecSautDeLigne         : Boolean = True;
      SansSautDeLigne         : Boolean = False;
      stCodeHTMLBonus         : array [TBonus] of String = ('#C0C0C0', '#00FFFF', '#4040FF', '#FFC0C0', '#FF0000'); // v1.3.6 : Déclaration déplacée ici pour utilisation commune avec Liste des Solutions. v1.3.10 : bleu foncé éclairci
      stCodeHTMLPoseJoker     ='#606060';  // vKA : pour ne pas confondre avec les doubles lettres, on ne met plus en minuscule les jokers posés mais on les met en gris foncé.
      stCodeHTMLSubstitutJoker='#00FF00';
      stFormatSolTriee        = '%4d-%1d-%2d;%3s;%s'; // v1.3.6 (Critères de tri : Score-NbJetonsPlacés-ScoreJetonsPlacés;Coordonnées;Proposition@)
      stSectionCompteur       = 'Compteur';         // v1.5. compteur de partie pour rattacher les records a posteriori (après enregistrement)
      stEntreeCompteur        = 'ProchainNumero';   // v1.5. compteur de partie pour rattacher les records a posteriori (après enregistrement)
      stEntreeSourceRecord    : array [TSourceRecord] of string  = ('Gen', 'Prp', 'Top'); // v1.5
      stEntreeNiveauRecord    : array [TNiveauRecord] of string  = ('Tour', 'Prt'); // v1.5
      stEntreeTypeRecord      : array [TTypeRecord]   of string  = ('Min', 'Max'); // v1.5
      stEntreeNatureRecord    : array [TNatureRecord] of string  = ('Score', 'NbBonus', 'TailleMot', 'NivDiff', 'NbSolSurRg', 'NbSol', 'NbSolBonus', 'RptScTop', 'NbTopsTrv', 'TpsCalcSol','NbSolParSec');
      stEntreeTypePartie      : array [TTypePartie]   of string  = ('', '', 'Joker'); // v1.5.7

      stEntreeInfoRecord      : array [TInfoRecord]   of string  = ('Num', 'Nom', 'Tour', 'Val','Lib', 'DtHr');
//---------------------------------------------------------------------------
function stURLCheminNomFichier(const stCheminFichier : String) : String; // v1.5 : pour récupérer l'url pour l'utiliser dans un fichier HTML
begin
Result:=Format('file:///%s', [stCheminFichier]);
Result:=StringReplace(Result, '\', '/', [rfReplaceAll]);
Result:=StringReplace(Result, ' ', '%20', [rfReplaceAll]);
end;
//---------------------------------------------------------------------------
procedure OuvreFichierHTML(stCheminFichier : String); // v1.4.6
begin
ShellExecute(0, 'Open', pChar(stURLCheminNomFichier(stCheminFichier)), '', '', SW_SHOWMAXIMIZED) // v1.5 : utilise la fonction ci-dessus
end;
//---------------------------------------------------------------------------
function stTirageTrie(const stTirage : String) : String;
var i, j : Integer;
    ResultI : Char;
begin
Result:=stTirage;
for i:=1 to Length(stTirage)-1 do
  for j:=i+1 to Length(stTirage) do
    if Result[i]>Result[j] then
      begin
      ResultI:=Result[i];
      Result[i]:=Result[j];
      Result[j]:=ResultI
      end
end;
//-------------------------------------------------------------------------
procedure Journalise(const SautDeLigne : Boolean; const stMsg : String);
begin
if Journalisation then
  if SautDeLigne then
    WriteLn(Journal, stMsg)
  else
    Write(Journal, stMsg)
end;
//---------------------------------------------------------------------------
function CoordonneesValides(const Colonne, Ligne : Integer) : Boolean;
begin
Result:=(Colonne>= Low(TCoordonnee))  and
        (Colonne<=High(TCoordonnee)) and
        (Ligne>= Low(TCoordonnee))  and
        (Ligne<=High(TCoordonnee));
end;
//---------------------------------------------------------------------------
function stSolutionTriee(const stMot : String; const x, y : Integer; const d : TDirection; const Chevalet : TChevalet; const Debut, Fin : Integer) : String; // v1.3.6
var i, ScoreJetonsPlaces : Integer;
    stCoordonnees : String;
begin
ScoreJetonsPlaces:=0;
for i:=Debut to Fin do
  if Chevalet[i]>0 then
    Inc(ScoreJetonsPlaces, ValeurJeton[TypeJeton[Chevalet[i]]]);
stCoordonnees:=p.stCoordonnees(x, y, d, PositionRelativeDebutMot(x, y, d)); // v1.7.2 : On ajoute la position relative du premier jeton du mot pour affichage dans tableau des solutions
Result:=Format(stFormatSolTriee,  [ComplementScore-p.ScorePose(x, y, d, Chevalet, Debut, Fin),
                                   Fin-Debut+1, ScoreJetonsPlaces, stCoordonnees, stMot]);
end;
//---------------------------------------------------------------------------
procedure GenereListeSolutionsTriees; // v1.3.6
const stFrmHTMLEnTete = '<?xml version="1.0" encoding="iso-8859-1"?>'#13+
                        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Solutions triées - Diplikata</title><meta content="Solutions triées Diplikata" name="description"><meta content="Solutions triées, Diplikata" name="keywords"></head>'#13+
                        '<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<h1>Solutions triées - Diplikata</h1>'#13;
      stFrmHTMLPdPage = '</tbody></table>'#13#13'</body></html>';
      stFrmHTMLETPlt  = '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><td>&nbsp;</td>';
      // v1.4.8 : Ajout du nombre de solutions distinctes affichées dans le tableau
      stFrmHTMLPdPPlt = '</tr>'#13'</tbody></table><BR>'#13#13'Tirage au tour n°%d&nbsp;: <B>%S</B>. Nombre de solutions distinctes : %d.<P><U>Remarque</U> : Les lettres en <FONT COLOR="'+stCodeHTMLPoseJoker+'">gris foncé</FONT> sont les jokers utilisés.<BR>'#13#13; // v1.4.1 (Rq)
      stFrmHTMLETSol  = '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td align="center" colspan="3"><I>Critères de tri</I></td><td align="center" colspan="3"><I>Solutions</I></td></tr>'#13+
                        '<tr><td><I>Score</I></td><td><I>Jeton(s)<BR>placé(s)</I></td><td><I>Valeur<BR>placée</I></td><td><I>Rang</I></td><td><I>Position(s)<BR>1er jeton du mot</I></td><td><I>Mot(s) posé(s)</I></td></tr>'#13;
      stFrmHTMLLigne  = '<tr>%s%s%s%s<td>%s</td><td><TT>%s</TT></td></tr>'#13;
      stFrmHTMLCritTri= '<td align="right" rowspan=%d>%s</td>';
      stFrmHTMLCritPts : array [Boolean] of String = ('<td align="right" rowspan=%d>%d&nbsp;pt</td>',
                                                      '<td align="right" rowspan=%d>%d&nbsp;pts</td>');
      stFrmHTMLCritJPs : array [Boolean] of String = ('<td rowspan=%d>%d&nbsp;jeton</td>',
                                                      '<td rowspan=%d>%d&nbsp;jetons</td>');
var   f                : TextFile;
      i, di,
      Agregats,
      LignesAgregees,
      LignesAgregeesAVenir,
      RSScore,
      RSNbJP,
      RSValeurJP,
      Score,
      NbJP,
      ValeurJP         : Integer;
      stNomFichierHTML,
      stLigne,
      stScore,
      stNbJP,
      stValeurJP,
      stPosition,
      stPositions,
      stSolution,
      stSolutions,
      stTemoinPos,
      stTemoinSol,
      stRSScore,
      stRSNbJP,
      stRSValeurJP,
      stRSPosition,
      stHTMLLigne      : String;
  //-----------------------------
  function AgregatPositionOuSolution(const di : Integer) : Integer;
  var st, stLigneCrt : String;
  begin
  Result:=1; // Optimiste
  stLigneCrt:=slSolutionsTriees[i+di];
  st:=Copy(stLigneCrt, PosPosition, TaillePosition);
  if st<>stTemoinPos then
    begin
    stTemoinPos:=st;
    st:=Copy(stLigneCrt, PosSolution, Length(stLigneCrt)-PosSolution+1);
    if st<>stTemoinSol then
      begin
      stTemoinSol:=st;
      Result:=0;
      end
    else
      stTemoinPos:=' ' // v1.3.7 (évite le cas de chevauchement Pos1Sol1/Pos2Sol1/Pos2Sol2)
    end
  else
    stTemoinSol:=' ' // v1.3.7 (évite le cas de chevauchement Pos1Sol1/Pos1Sol2/Pos2Sol2)
  end;
  //-----------------------------
  procedure CalculeRowSpanScore;
  begin
  RSScore:=1; Agregats:=0;
  stTemoinPos:=Copy(stLigne, PosPosition, TaillePosition);
  stTemoinSol:=Copy(stLigne, PosSolution, Length(stLigne)-PosSolution+1);
  while (i+RSScore<slSolutionsTriees.Count) and
        (Copy(slSolutionsTriees[i+RSScore], 1, 4)=stScore) do
    begin
    if Copy(slSolutionsTriees[i+RSScore],1,9)<>Copy(slSolutionsTriees[i+RSScore-1],1,9) then
      begin // Empêche et réinitialise le calcul des agrégats si changement de critère de tri
      stTemoinPos:='  ';
      stTemoinSol:='  ';
      end;
    Inc(Agregats, AgregatPositionOuSolution(RSScore));
    Inc(RSScore)
    end;
  Dec(RSSCore, Agregats);
  stRSScore:=Format(stFrmHTMLCritPts[Score>1], [RSScore, Score]);
  end;
  //-----------------------------
  procedure CalculeRowSpanNbPJ;
  begin
  RSNbJP:=1; Agregats:=0;
  stTemoinPos:=Copy(stLigne, PosPosition, TaillePosition);
  stTemoinSol:=Copy(stLigne, PosSolution, Length(stLigne)-PosSolution+1);
  while (i+RSNbJP<slSolutionsTriees.Count) and
        (Copy(slSolutionsTriees[i+RSNbJP], 1, 6)=stScore+'-'+stNbJP) do
    begin
    if Copy(slSolutionsTriees[i+RSNbJP],1,9)<>Copy(slSolutionsTriees[i+RSNbJP-1],1,9) then
      begin // Empêche et réinitialise le calcul des agrégats si changement de critère de tri
      stTemoinPos:='  ';
      stTemoinSol:='  ';
      end;
    Inc(Agregats, AgregatPositionOuSolution(RSNbJP));
    Inc(RSNbJP)
    end;
  Dec(RSNbJP, Agregats);
  stRSNbJP:=Format(stFrmHTMLCritJPs[NbJP>1], [RSNbJP, NbJP]);
  end;
  //-----------------------------
  procedure CalculeRowSpanValeurJP;
  begin
  RSValeurJP:=1; Agregats:=0;
  stTemoinPos:=Copy(stLigne, PosPosition, TaillePosition);
  stTemoinSol:=Copy(stLigne, PosSolution, Length(stLigne)-PosSolution+1);
  while (i+RSValeurJP<slSolutionsTriees.Count) and
        (Copy(slSolutionsTriees[i+RSValeurJP], 1, 9)=stScore+'-'+stNbJP+'-'+stValeurJP) do
    begin
    Inc(Agregats, AgregatPositionOuSolution(RSValeurJP));
    Inc(RSValeurJP);
    end;
  Dec(RSValeurJP, Agregats);
  stRSValeurJP:=Format(stFrmHTMLCritPts[ValeurJP>1], [RSValeurJP, ValeurJP]);
  stRSPosition:=Format(stFrmHTMLCritTri, [RSValeurJP, IntToStr(i+1)+'.']);
  end;
  //-----------------------------
  procedure EcritPlateauSolutionsTriees;
  var x, y     : Integer;
      stLettre,
      stTirage : String;
  begin
  Write(f, stFrmHTMLETPlt);
  // En-têtes de colonnes
  for x:=Low(TCoordonnee) to High(TCoordonnee) do
    Write(f, Format('<td align="center"><FONT COLOR="#7F7F7F"><I>%2.2d</I></FONT></td>', [x+1]));
  // Lignes
  for y:=Low(TCoordonnee) to High(TCoordonnee) do
    begin
    Write(f, '</tr>'#13'<tr><td><FONT COLOR="#7F7F7F"><I>'+Chr(65+y)+'</I></FONT></td>'); // vKa : Chr() au lieu de stLettreJeton à cause des doubles lettres
    for x:=Low(TCoordonnee) to High(TCoordonnee) do
      if p.c[x,y]>0 then
        begin
        stLettre:=p.stLettreLD(x, y); // vKA : stLettreLD au lieu de stLettre
        Write(f, Format('<td align="center"><FONT COLOR="%s"><B>%s</B></FONT></td>',
                        [IfThen(TypeJeton[p.c[x,y]]=tjJoker, // vKA : On met en gris foncé les jokers et plus en minuscule à cause des doubles lettres
                                stCodeHTMLPoseJoker,
                                stCodeHTMLBonus[BonusCase[x,y]]),
                                stLettre]))
        end
      else
        if BonusCase[x,y]<>bAucun then
          Write(f, Format('<td align="center"><FONT COLOR="%s">#</FONT></td>', [stCodeHTMLBonus[BonusCase[x,y]]]))
        else
          Write(f, Format('<td>&nbsp;</td>', [stCodeHTMLBonus[BonusCase[x,y]]]));
    end{for y};
  stTirage:=stLettresDoubles(Copy(AnsiReplaceStr(p.stTirage[p.Tour],' ','?'), 1, p.NbJetonsAJouer)); // v1.3.8 (Copy). vKA : utilisation de stLettresDoubles pour afficher les doubles lettres dans le tirage
  Write(f, Format(stFrmHTMLPdPPlt, [p.Tour, stTirage, slSolutionsTriees.Count])); // v1.4.8 : Ajout du nombre de solutions affichées !
  end;
//----------------
// DEBUT PRINCIPAL
//----------------
begin
// Initialisation des compteurs de RowSpan
RSScore:=0; RSNbJP:=0; RSValeurJP:=0;
LignesAgregeesAVenir:=0;
// Ouverture du fichier en écriture
stNomFichierHTML:=stRepLocalAppData+'Solutions.html'; // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))

(* // Trace
AssignFile(f, stRepLocalAppData+'\Trace.txt'); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
Rewrite(f);
for i:=0 to slSolutionsTriees.Count-1 do
  begin
  Write(f, Format('%4d', [ComplementScore-StrToInt(Copy(slSolutionsTriees[i], 1, 4))]));
  WriteLn(f, Copy(slSolutionsTriees[i],5,Length(slSolutionsTriees[i])-4))
  end;
CloseFile(f);
*)

AssignFile(f, stNomFichierHTML);
try
  Rewrite(f);
  Write(f, stFrmHTMLEnTete);

  // Récapitulatif tour de jeu
  EcritPlateauSolutionsTriees;

  Write(f, stFrmHTMLETSol);
  for i:=0 to slSolutionsTriees.Count-1 do
    begin

    // Infos ligne
    stLigne:=slSolutionsTriees[i];
    stScore:=Copy(stLigne, 1, 4);
    Score:=ComplementScore-StrToInt(Copy(stLigne, 1, 4));
    stNbJP:=Copy(stLigne, 6, 1);
    NbJP:=StrToInt(stNbJP);
    stValeurJP:=Copy(stLigne, 8, 2);
    ValeurJP:=StrToInt(stValeurJP);

    // Calcul des ROWSPAN de critères
    if LignesAgregeesAVenir=0 then
      begin
      if RSScore=0 then CalculeRowSpanScore else stRSScore:='';
      if RSNbJP=0 then CalculeRowSpanNbPJ else stRSNbJP:='';
      if RSValeurJP=0 then CalculeRowSpanValeurJP else begin stRSValeurJP:=''; stRSPosition:='' end;
      end;

    stSolution:=Copy(stLigne, PosSolution, Length(stLigne)-PosSolution+1);
    stPosition:=Copy(stLigne, PosPosition, TaillePosition);

    if LignesAgregeesAVenir=0 then
      begin
      LignesAgregees:=1;
      // Agrégats des Solutions d'une même position
      stSolutions:=stHTMLLettresDoubles(stSolution); // vKA : affichage des doubles lettres (ajout stHTMLLettresDoubles)
      di:=1;
      while (i+di<slSolutionsTriees.Count) and (di<=Agregats) and (stPosition=Copy(slSolutionsTriees[i+di], PosPosition, TaillePosition)) do
        begin
        stSolutions:=stSolutions+' '+stHTMLLettresDoubles(Copy(slSolutionsTriees[i+di], PosSolution, Length(slSolutionsTriees[i+di])-PosSolution+1)); // vKA : affichage des doubles lettres (ajout stHTMLLettresDoubles)
        Inc(di); Inc(LignesAgregees);
        end;
      // Agrégats des Positions d'une même solution
      stPositions:=stPosition;
      di:=1;
      while (i+di<slSolutionsTriees.Count) and (di<=Agregats) and (stSolution=Copy(slSolutionsTriees[i+di], PosSolution, Length(slSolutionsTriees[i+di])-PosSolution+1)) do
        begin
        stPositions:=stPositions+' '+Copy(slSolutionsTriees[i+di], PosPosition, TaillePosition);
        Inc(di); Inc(LignesAgregees)
        end;
      // Ecriture ligne tableau
      LignesAgregeesAVenir:=LignesAgregees;
      stHTMLLigne:=Format(stFrmHTMLLigne, [stRSScore, stRSNbJP, stRSValeurJP, stRSPosition, stPositions, stSolutions]);
      Write(f, stHTMLLigne);
      Dec(RSScore); Dec(RSNbJP); Dec(RSValeurJP)
      end{if LignesAgregeesAVenir=0};
    Dec(LignesAgregeesAVenir)
    end{for};
  Write(f, stFrmHTMLPdPage);
finally
  CloseFile(f);
  OuvreFichierHTML(stNomFichierHTML); // v1.4.6
  slSolutionsTriees.Clear
end{try};
end;
//---------------------------------------------------------------------------
function stCodeCouleurHTMLRapport(const Rapport : Double; const Invisible : Boolean) : String; // v1.5
var r, v : Integer;
begin // 0 <= Rapport <= 1
if Invisible then // v1.6.3 : On rend invisible (noir sur noir)
  begin
  Result:=Format('#%2X%2X%2X', [0, 0, 0]);
  Exit
  end;
if Rapport = 1 then // v1.6.3 : si top on affiche en cyan
  begin
  Result:=Format('#%2X%2X%2X', [0, 255, 255]);
  Exit
  end;
if Rapport>0.5 then
  r:=Round(0.5+255*2*(1.0-Rapport))-1
else
  r:=255;
if Rapport<0.5 then
  v:=Round(0.5+255*2*Rapport)-1
else
  v:=255;
if r<0 then r:=0;
if r>255 then r:=255;
if v<0 then v:=0;
if v>255 then v:=255;
Result:=Format('#%2X%2X%2X', [r, v, 0])
end;
//---------------------------------------------------------------------------
function stURLBitmapNiveauDifficulte(const Difficulte : TDifficulteTirage) : string;
begin
Result:=stURLCheminNomFichier(ExtractFilePath(ParamStr(0))+Format('html/%d.png', [Ord(Difficulte)])) // v1.7.4 : png au lieu de bmp
end;
//---------------------------------------------------------------------------
function CalculeNiveauDifficulte(const NbSolSEMT : Double; const NbSol : Integer; var stLibelleAlternatif, stURLBitmap : String) : Integer; // v1.5
var Difficulte : TDifficulteTirage;
    NoteSur10 : Double;
begin
if NbSolSEMT=0 then
  begin
  Difficulte:=dtIndefinie;
  stLibelleAlternatif:=stAltDiffTirage[Difficulte]+' (valeur indisponible)';
  Result:=0;
  end
else
  begin
  NoteSur10:=NbNiveauxDifficulte-
             (NbNiveauxDifficulte div 2)*
             Log10(Min(100.0,
                       1.0+(100.0*NbSolSEMT)/NbSol
                      )
                  );
  Result:=Round(100*NoteSur10); // Pour les records
  Difficulte:=TDifficulteTirage(Round(NoteSur10));
  stLibelleAlternatif:=Format('%.1f/10 (%.2f%% des sol. >= 50%% Top)', [NoteSur10, (100.0*NbSolSEMT)/NbSol])
  end;
stURLBitmap:=stURLCheminNomFichier(ExtractFilePath(ParamStr(0))+'html/'+IntToStr(Ord(Difficulte))+'.png') // v1.7.4 : png au lieu de bmp
end;
//---------------------------------------------------------------------------
function stDateHeureCourante : String; // v1.5
var dt : TDateTime;
    jr,ms,an,hr,mn,sc,ml : Word;
    st : String;
begin
dt:=Now;
DecodeDate(dt, an, ms, jr);
DecodeTime(dt, hr, mn, sc, ml);
st:=Format('%2d/%2d/%4d', [jr, ms, an]);
st:=StringReplace(st, ' ', '0', [rfReplaceAll]);
Result:=st;
st:=Format('%2d:%2d:%2d', [hr, mn, sc]);
st:=StringReplace(st, ' ', '0', [rfReplaceAll]);
Result:=Result+' '+st;
end;
//---------------------------------------------------------------------------
// v1.5.1 : stHTMLStyleEtCouleurAppliques sortie de la procedure GenereFeuilleMatchDetaillee pour TesteRecord sur les scores max et fournir la solution en couleurs comme sur la Fdmd !
function stHTMLStyleEtCouleurAppliques(const stChaine, stHTMLCodeCouleur : String; const Style : TFontStyles) : String;
var stHTMLDebut, stHTMLFin : String;
begin
if stHTMLCodeCouleur<>'' then
  begin
  stHTMLDebut:=Format('<FONT COLOR="%s">', [stHTMLCodeCouleur]);
  stHTMLFin:='</FONT>'
  end;
if fsUnderline in Style then
  begin
  stHTMLDebut:=stHTMLDebut+'<U>';
  stHTMLFin:='</U>'+stHTMLFin;
  end;
if fsBold in Style then
  begin
  stHTMLDebut:=stHTMLDebut+'<B>';
  stHTMLFin:='</B>'+stHTMLFin;
  end;
if fsItalic in Style then
  begin
  stHTMLDebut:=stHTMLDebut+'<I>';
  stHTMLFin:='</I>'+stHTMLFin;
  end;
Result:=stHTMLDebut+stChaine+stHTMLFin
end{function};
//---------------------------------------------------------------------------
function NbJetons(stTirageDL : String) : Integer;// vKA : Remplace Length car il n'y a pas forcément une lettre par jeton !!!!
var i, n : Integer;
begin
n:=0;
for i:=1 to Length(stTirageDL) do
  Inc(n, IfThen((stTirageDL[i]>='A') and (stTirageDL[i]<='Z'),1,IfThen((stTirageDL[i]='?') or (stTirageDL[i]=' '),1,0)));
Result:=n;
end{function};
//---------------------------------------------------------------------------
function stJetonsEnLettres(stJetons : String) : String; // KA : Convertisseur de Tirage de jetons en lettres (Â=>An, Ê=>En, etc.)
var i, j        : Integer;
    stLettres   : String;
    LettreJoker : Boolean; // v1.7.4 : indique lettre de joker pour mettre entre crochets
begin
stLettres:='';
// v1.7.4 : on met les lettres de jokers entre parenthèses (lettres en minucules dans stJetons)
for i:=1 to length(stJetons) do
  if stJetons[i]='?' then
    stLettres:=stLettres+stJetons[i]
  else
    for j:=1 to NbLettresAlphabet+1 do
      begin
      Dec(stJetons[i], 32);
      if stJetons[i] = stLettreJeton[TTypeJeton(j)] then // v1.7.4 : C'est une lettre de joker, on remet en majuscule
        LettreJoker:=True
      else
        begin
        Inc(stJetons[i], 32);
        LettreJoker:=False
        end;
      if stJetons[i] = stLettreJeton[TTypeJeton(j)] then
        begin
        if EstDoubleLettre[TTypeJeton(j)] then
          begin
          if LettreJoker then // v1.7.4
            stLettres:=stLettres+'('+stAffichageJeton[TTypeJeton(j)]+')'
          else
            stLettres:=stLettres+stAffichageJeton[TTypeJeton(j)]
          end
        else
          begin
          if LettreJoker then // v1.7.4
            stLettres:=stLettres+'('+stJetons[i]+')'
          else
            stLettres:=stLettres+stJetons[i];
          end;
        break
        end
      end;
Result:=stLettres;
end;
//---------------------------------------------------------------------------
function stLettresEnJetons(stLettres : String) : String; // KA : Convertisseur de Tirage de lettres en jetons (An=>Â, En=>Ê, etc.)
var i, j, l  : Integer;
var stJetons : String;
begin
stJetons:='';
l:=length(stLettres);
for i:=1 to l do
  if stLettres[i]='?' then
    stJetons:=stJetons+stJoker
  else
    for j:=2 to NbLettresAlphabet+1 do
      if Copy(stLettres,i,1+ // On compare deux lettres si la lettre qui suit est en minuscule (Jeton à double lettre)
                          Ord(((i<l) and
                               (stLettres[i+1]>='a') and
                               (stLettres[i+1]>='a'))))=stAffichageJeton[TTypeJeton(j)] then
        begin
        stJetons:=stJetons+stLettreJeton[TTypeJeton(j)];
        break
        end;
Result:=stJetons;
end;
//---------------------------------------------------------------------------
function stControleLettresEnJetons(stLettres : String) : String; // KA : Contrôle avant conversion
var i : Integer;
begin
for i:=1 to Length(stLettres) do
  if (stLettres[i]<'A') and (stLettres[i]>'Z') and ((stLettres[i]='Q') or (stLettres[i]='X')) and (stLettres[i]<>'?') and
      (stLettres[i]<>'g') and (stLettres[i]<>'h') and (stLettres[i]<>'i')  and (stLettres[i]<>'n') and (stLettres[i]<>'u') then
    begin
    Result:='Le caractère "'+stLettres[i]+'" est interdit !';
    break
    end
  else
    if (stLettres[i]='n') and ((i>1) and (stLettres[i-1]<>'A') and (stLettres[i-1]<>'E') and (stLettres[i-1]<>'O')) then
      begin
      Result:='Tout caractère "n" doit suivre un "A" (An), un "E" (En) ou un "O" (On).';
      break
      end
    else
      if (stLettres[i]='u') and (i>1) and (stLettres[i-1]<>'O') then
        begin
        Result:='Tout caractère "u" doit suivre un "O" (Ou).';
        break
        end
      else
        if (stLettres[i]='g') and (i>1) and (stLettres[i-1]<>'N') then
          begin
          Result:='Tout caractère "g" doit suivre un "N" (Ng).';
          break
          end
        else
          if (stLettres[i]='i') and (i>1) and (stLettres[i-1]<>'U') then
            begin
            Result:='Tout caractère "i" doit suivre un "U" (Ui).';
            break
            end
          else
            if (stLettres[i]='h') and (i>1) and (stLettres[i-1]<>'C') then
              begin
              Result:='Tout caractère "h" doit suivre un "C" (Ch).';
              break
              end
            else
              if (stLettres[i]='C') and (i<=Length(stLettres)) and (stLettres[i+1]<>'h') then
                begin
                Result:='Tout caractère "C" doit précéder un "h" (Ch).';
                break
                end
              else
                if (stLettres[i]='U') and (i<=Length(stLettres)) and (stLettres[i+1]<>'i') then
                  begin
                  Result:='Tout caractère "U" doit précéder un "i" (Ui).';
                  break
                  end
end;
//---------------------------------------------------------------------------
function stLettresDoubles(stLettres : String) : String; // vKA : transforme les lettres accentuées en lettres doubles en mettant entre parenthèses les lettres de joker
var i, l        : Integer;
    stLettresLD : String;
begin
stLettresLD:='';
l:=Length(stLettres);
for i:=1 to l do
  case stLettres[i] of
    'Â': stLettresLD:=stLettresLD+'An';
    'Ç': stLettresLD:=stLettresLD+'Ch';
    'Ê': stLettresLD:=stLettresLD+'En';
    'Ñ': stLettresLD:=stLettresLD+'Ng';
    'Ô': stLettresLD:=stLettresLD+'On';
    'Û': stLettresLD:=stLettresLD+'Ou';
    'Î': stLettresLD:=stLettresLD+'Ui';
    'a'..'z': stLettresLD:=stLettresLD+Format('(%s)', [UpperCase(stLettres[i])]);
    'â': stLettresLD:=stLettresLD+'(An)';
    'ç': stLettresLD:=stLettresLD+'(Ch)';
    'ê': stLettresLD:=stLettresLD+'(En)';
    'ñ': stLettresLD:=stLettresLD+'(Ng)';
    'ô': stLettresLD:=stLettresLD+'(On)';
    'û': stLettresLD:=stLettresLD+'(Ou)';
    'î': stLettresLD:=stLettresLD+'(Ui)';
    else stLettresLD:=stLettresLD+stLettres[i];
  end{case of};
Result:=stLettresLD
end{function};
//---------------------------------------------------------------------------
function stHTMLLettresDoubles(stLettres : String) : String; // vKA : transforme les lettres accentuées en lettres doubles en mettant en gris foncé les jokers qui sont en minuscule (version HTML)
const stHTMLJoker = '<FONT COLOR="%s">%s</FONT>';
var i, l        : Integer;
    stLHTMLLettresLD : String;
begin
stLHTMLLettresLD:='';
l:=Length(stLettres);
for i:=1 to l do
  case stLettres[i] of
    'Â': stLHTMLLettresLD:=stLHTMLLettresLD+'An';
    'Ç': stLHTMLLettresLD:=stLHTMLLettresLD+'Ch';
    'Ê': stLHTMLLettresLD:=stLHTMLLettresLD+'En';
    'Ñ': stLHTMLLettresLD:=stLHTMLLettresLD+'Ng';
    'Ô': stLHTMLLettresLD:=stLHTMLLettresLD+'On';
    'Û': stLHTMLLettresLD:=stLHTMLLettresLD+'Ou';
    'Î': stLHTMLLettresLD:=stLHTMLLettresLD+'Ui';
    'a'..'z': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, UpperCase(stLettres[i])]);
    'â': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'An']);
    'ç': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'Ch']);
    'ê': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'En']);
    'ñ': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'Ng']);
    'ô': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'On']);
    'û': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'Ou']);
    'î': stLHTMLLettresLD:=stLHTMLLettresLD+Format(stHTMLJoker, [stCodeHTMLPoseJoker, 'Ui']);
    else stLHTMLLettresLD:=stLHTMLLettresLD+stLettres[i];
  end{case of};
Result:=stLHTMLLettresLD
end{function};
//---------------------------------------------------------------------------
function PositionRelativeDebutMot(const x, y : TCoordonnee; d : TDirection) : Integer; // v1.7.2 : on définit la position relative du premier jeton du mot posé ou non sur le plateau par rapport au premier jeton posé pour l'affichage du tableau des solutions
var i : Integer;
begin
i:=0;
while CoordonneesValides(x-(i+1)*dx[d],y-(i+1)*dy[d]) and
      (p.c[x-(i+1)*dx[d]][y-(i+1)*dy[d]]>0) do
 Inc(i);
Result:=-i;
end{function};
//---------------------------------------------------------------------------
function TypeJetonLettre(const stLettre : String) : TTypeJeton; // v1.7.3 : transforme une lettre en TTYpeJeton, exemple : Â=>tjAn, Ç=>tjCh, etc.
var i : Integer;
begin
Result:=tjIndefini;
for i:=Ord(Low(TTypeJeton))+1 to Ord(High(TTypeJeton)) do
  if stLettre=stLettreJeton[TTypeJeton(i)] then
    begin
    Result:=TTypeJeton(i);
    break
    end
end;
//---------------------------------------------------------------------------
constructor TRecherche.Cree;
const
  stTirageVide : array [TNbLettres] of AnsiString = ('  ', // v1.7.4 : AnsiString au lieu de String pour correspondre à stTirage (vRX)
                                                     '   ',
                                                     '    ',
                                                     '     ',
                                                     '      ',
                                                     '       ',
                                                     '        ',
                                                     '         ',
                                                     '          ',
                                                     '           ',
                                                     '            ',
                                                     '             ',
                                                     '              ',
                                                     '               ');
var
  i, j, m : Integer;
  k, l, o : Word;
  n : AnsiChar;
  stTirage : AnsiString; // v1.7.4 : AnsiString au lieu de String (vRX)
  Anagrammes : TAnagrammes;
  F : File;
begin
ChargementDicoOk:=False;
if not FileExists(ExtractFilePath(ParamStr(0))+stNomFichierRech) then
  begin
  MessageBox(0, pChar(Format(stFrmFichierIntrouvable, [stNomFichierRech])), stErreurInattendue, MB_ICONHAND);
  Exit;
  end;
AssignFile(F, ExtractFilePath(ParamStr(0))+stNomFichierRech);
// FormChargementDico est créée et accessible
try
  with FormPatience do
    begin
    Panel.Caption:='Chargement du dictionnaire de recherche en cours. Veuillez patienter SVP...';
    Gauge.MaxValue:=High(TNbLettres);
    Gauge.MinValue:=Low(TNbLettres)-1;
    Gauge.Progress:=Gauge.MinValue;
    Panel.Repaint;
    end;
  Reset(F, 1);
  for i:=Low(TNbLettres) to High(TNbLettres) do
    begin
    stTirage:=stTirageVide[i];
    Tirages[i]:=TStringList.Create;
    Tirages[i].Sorted:=True;
    BlockRead(F, j, SizeOf(j));
    for k:=1 to j{NbTirages} do
      begin
      for l:=1 to i{NbLettres} do
        BlockRead(f, stTirage[l], SizeOf(stTirage[l]));
      BlockRead(F, n, SizeOf(n));
      Anagrammes:=TAnagrammes.Create;
      Anagrammes.NbAnagrammes:=0;
      SetLength(Anagrammes.iDico, Integer(n));
      for m:=0 to Integer(n){NbAnagrammes}-1 do
        begin
        BlockRead(F, o, SizeOf(o));
        Anagrammes.iDico[m]:=Integer(o);
        Inc(Anagrammes.NbAnagrammes);
        end;
      Tirages[i].AddObject(String(stTirage), Anagrammes); // v1.7.4 : String(stTirage) pour éviter l'avertissement
      end{for j};
    with FormPatience do
      begin
      Gauge.Progress:=i;
      Gauge.Repaint;
      Panel.Repaint;
      end
    end{for i};
    ChargementDicoOk:=True;
finally
  CloseFile(F);
end{try}
end;
//---------------------------------------------------------------------------
destructor TRecherche.Detruit;
var i, j : Integer;
begin
try
  for i:=Low(TNbLettres) to High(TNbLettres) do
    begin
    for j:=0 to Tirages[i].Count-1 do
      if Tirages[i].Objects[j]<>Nil then
        (Tirages[i].Objects[j] as TAnagrammes).Destroy;
    Tirages[i].Destroy;
    end
finally
end
end;
//---------------------------------------------------------------------------
constructor TDico.Cree; // vKA
var i : Integer;
    c : AnsiChar; // RX
    F : File of AnsiChar; // RX
begin
ChargementDicoOk:=False;
if not FileExists(ExtractFilePath(ParamStr(0))+stNomFichierDico) then
  begin
  MessageBox(0, pChar(Format(stFrmFichierIntrouvable, [stNomFichierDico])), stErreurInattendue, MB_ICONHAND);
  Exit
  end;
AssignFile(F, ExtractFilePath(ParamStr(0))+stNomFichierDico);
FormPatience:=TFormPatience.Create(Nil);
try
  with FormPatience do
    begin
    Panel.Caption:='Chargement de '+stVersionDico+' en cours. Veuillez patienter SVP...';
    Gauge.MaxValue:=NbLettresDico div 100;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  Reset(F);
  Index[Low(TNbLettres)]:=0;
  NbEntreesDico:=0;
  for i:=Low(TNbLettres)+1 to High(TNbLettres) do
    begin
    Index[i]:=Index[i-1]+nbl[i-1];
    Inc(NbEntreesDico, nbl[i-1] div (i-1))
    end;
  Inc(NbEntreesDico, nbl[15] div 15);
  for i:=0 to NbLettresDico-1 do
    begin
    Read(f, c);
    Dico[i]:=Char(c); // v1.7.4 : conversion AnsiChar > Char
    if i mod 100 = 0 then
    with FormPatience do
      begin
      Gauge.Progress:=i div 100;
      Gauge.Repaint;
      Panel.Repaint;
      end;
    end;
    ChargementDicoOk:=True;
    Rech:=TRecherche.Cree;
    ChargementDicoOk:=(Rech<>nil) and Rech.ChargementDicoOk;
finally
  CloseFile(F);
  FormPatience.Release;
end{try}
end;
//---------------------------------------------------------------------------
destructor TDico.Detruit;
begin
 if Rech<>nil then Rech.Detruit
end;
//---------------------------------------------------------------------------
function TDico.stMotDico(const TailleMot, IndexDico : Integer) : String;
var i : Integer;
begin
Result:='';
for i:=0 to TailleMot-1 do
  begin
  Result:=Result+' ';
  Result[i+1]:=Dico[Index[TailleMot]+IndexDico*TailleMot+i];
  end
end;
//---------------------------------------------------------------------------
function TDico.Existe(const stMot : String) : Boolean;
var Taille, Comp, iInf, iSup, iMil : Integer;
begin
Result:=True; // Optimiste
Taille:=Length(stMot);
if Taille<2 then Exit;
iInf:=0;
iSup:=nbl[Taille] div Taille-1;
iMil:=(iInf+iSup) div 2;
Comp:=AnsiCompareStr(stMotDico(Taille, iMil), stMot); // vKA : AnsiCompareStr au lieu de CompareStr
while (Comp<>0) and (iSup>iInf) do
  begin
  if (iSup-iInf=1) and (Comp<>0) then
    iInf:=iSup
  else
    if Comp<=0 then
      iInf:=iMil
    else
      iSup:=iMil;
  iMil:=(iInf+iSup) div 2;
  Comp:=AnsiCompareStr(stMotDico(Taille, iMil), stMot); // vKA : AnsiCompareStr au lieu de CompareStr
  end;
Result:=Comp=0;
end;
//---------------------------------------------------------------------------
function TDico.IndexProchainMot(const IndexDebut : Integer; const stFiltre : String) : Integer;
var i, j, Taille : Integer;
begin
Taille:=Length(stFiltre);
i:=IndexDebut+1; j:=0;
while (i<nbl[Taille] div Taille) and (j<=Taille) do
  begin
  j:=1;
  while (j<=Taille) and
        ((stFiltre[j]='?') or
         (Dico[Index[Taille]+i*Taille+j-1]=stFiltre[j])) do
    Inc(j);
  if (j<=Taille) then
    Inc(i);
  end{while};
if (j>Taille) then
  Result:=i
else
  Result:=-1 // Rien trouvé
end;
//---------------------------------------------------------------------------
function TPartie.TirageInchangeable : Boolean; // v1.5
begin
Result:=(ProchainJetonATirer>NbJetonsSac-NbMaxJetonsTirage+1);
end;
//---------------------------------------------------------------------------
procedure TPartie.ChargeOrdreSac;
var i : Integer;
    IniFile : TIniFile;
begin
for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
  s[i]:=i; // On met les jetons dans le sac dans l'ordre (une seule fois) mais ils seront mélangés par la suite
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
    s[i]:=IniFile.ReadInteger(stSectionSac, IntToStr(i), i)
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TPartie.SauveOrdreSac;
var i : Integer;
    IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
    IniFile.WriteInteger(stSectionSac, IntToStr(i), s[i])
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
function TPartie.stCoordonnees(const X, Y : TCoordonnee) : String;
var stLettre : String;
begin
stLettre:=' '; stLettre[1]:=Chr(Ord('A')+Y);
Result:=Format('%s%d', [stLettre, X+1]);
end;
//---------------------------------------------------------------------------
function TPartie.stCoordonnees(const X, Y : TCoordonnee; const d : TDirection) : String;
var stLettre : String;
begin
if d>dIndefinie then
  begin
  stLettre:=' '; stLettre[1]:=Chr(Ord('A')+Y);
  if d=dVerticale then
    Result:=Format('%d%s', [X+1, stLettre])
  else
    Result:=Format('%s%d', [stLettre, X+1])
  end
else
  Result:=stCoordonneesIndefinies
end;
//---------------------------------------------------------------------------
function TPartie.stCoordonnees(const X, Y : TCoordonnee; const d : TDirection; const k : Integer) : String; // v1.7.2 : Avec k position relative du premier jeton du mot pour afficher les coordonnées du premier jeton du mot en fonction des coordonnées du premier jeton posé.
var stLettre : String;
begin
if d>dIndefinie then
  begin
  stLettre:=' '; stLettre[1]:=Chr(Ord('A')+Y+k*dy[d]);
  if d=dVerticale then
    Result:=Format('%d%s', [X+k*dx[d]+1, stLettre])
  else
    Result:=Format('%s%d', [stLettre, X+k*dx[d]+1])
  end
else
  Result:=stCoordonneesIndefinies
end;
//---------------------------------------------------------------------------
procedure TPartie.JoueTour(const X, Y : TCoordonnee;
                           const d : TDirection;
                           var Chevalet : TChevalet; // v1.5.6 (const -> var à cause de l'appel de RemetJokersDansSac)
                           const Debut, Fin : TOrdreJetonChevalet);
begin
if TypePartie=tpJoker then RemetJokersDansSac(Chevalet, Debut, Fin); // v1.5.6
PlaceJetons(X, Y, d, Chevalet, Debut, Fin, CoupJoue);
RetireJetons(Chevalet, Debut, Fin);
Inc(Tour);
CompleteTirage;
end;
//---------------------------------------------------------------------------
procedure TPartie.RetireJetons(const Chevalet : TChevalet;
                               const Debut, Fin : TOrdreJetonChevalet);
var i, j : Integer;
    Jeton : TOrdreJetonSac;
begin
// 1. On retire les jetons placés
for i:=Debut to Fin do
  for j:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
    if Chevalet[i]=t[j] then
      t[j]:=0;
// 2. On serre à gauche ce qui reste
j:=0;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  begin
  if (t[i]>0) then
    begin
    if j<>0 then
      begin // On déplace un jeton vers la place vide la plus à gauche
      t[j]:=t[i];
      t[i]:=0;
      repeat
        Inc(j);
      until (j=High(TOrdreJetonTirage)) or
            (t[j]=0)
      end
    end
  else {t[i]=0}
    if (j=0) then
      j:=i
  end{for i};
// 3. On retire les lettres de jokers laissées sur le tirage
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if (TypeJeton[t[i]]=tjJoker) and (LettreJoker[t[i]]>tjJoker) then
    LettreJoker[t[i]]:=tjJoker;
// 4. On met en dernier de la liste des jetons sortis du sac (s[i],i<ProchainJetonATirer) les jetons du reliquat
i:=Low(TOrdreJetonTirage);
while t[i]>0 do // On passe tous les jetons du reliquats (en tête du tirage)
  begin // On est sur un jeton du reliquat
  if s[ProchainJetonATirer-i]<>t[i] then // Il n'est pas à la bonne place dans s
    begin
    j:=ProchainJetonATirer-i;
    while (j>=Low(TOrdreJetonSac)) and
          (s[j]<>t[i]) do
      Dec(j);
    if j>=Low(TOrdreJetonSac) then
      begin
      // On ramène le jeton du reliquat devant les derniers jetons non encore posés.
      // Les jetons situés derrière les jetons du reliquat sont les jetons posés.
      Jeton:=s[ProchainJetonATirer-i];
      s[ProchainJetonATirer-i]:=t[i];
      s[j]:=Jeton;
      end{if j}
    end{if s};
  Inc(i)
  end;
end;
//---------------------------------------------------------------------------
procedure TPartie.CompleteTirage;
var i : Integer;
begin
PremierJetonTire:=0;
stTirage[Tour]:=stTirageVide;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if t[i]=0 then
    begin // On prend des jetons du sac si...
    if ProchainJetonATirer<=High(TOrdreJetonSac) then
      begin // ...il y en a encore !
      t[i]:=s[ProchainJetonATirer];
      stTirage[Tour, i]:=stLettre(s[ProchainJetonATirer])[1];
      Inc(ProchainJetonATirer);
      if PremierJetonTire=0 then
        PremierJetonTire:=i;
      end
    else
      stTirage[Tour,i]:=' '
    end
  else
    stTirage[Tour,i]:=stLettre(t[i])[1];
if TypePartie=tpJoker then AjouteJokerAuTirage; // v1.5.6
end;
//---------------------------------------------------------------------------
function TPartie.AjouteJokerAuTirage : Boolean; // v1.5.6. Retourne False s'il ne reste plus de jokers dans le sac OU si un joker est déjà dans le tirage
var i,
    ProchainJetonJoker : Integer;
    // /!\ Variables déclarées en private dans la class TPartie : LettreAEchanger, JokerAEchanger : TOrdreJetonSac;
    JetonAChanger      : TOrdreJetonTirage;
    JokerDejaTire      : Boolean;
begin
// Pour les jetons de n° PremierJetonTire à High(TOrdreJetonTirage) si il n'y a pas de joker, on remplace au hasard une des lettres par un joker s'il en reste dans le sac.
// 1. Reste-t-il des jokers dans le sac ?
ProchainJetonJoker:=0; JokerDejaTire:=False;
for i:=ProchainJetonATirer to High(TOrdreJetonSac) do
  if TypeJeton[s[i]]=tjJoker then
    begin
    ProchainJetonJoker:=i;
    JokerAEchanger:=s[i]
    end;
// 2. Y a=t=il déjà un joker dans ce qui vient d'être tiré ?
if ProchainJetonJoker>0 then
  for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
    if TypeJeton[t[i]]=tjJoker then
      begin
      JokerDejaTire:=True;
      Break
      end;
Result:=(ProchainJetonJoker>0) and not JokerDejaTire;
if not Result then Exit;
// 3. On prend une lettre parmi les jetons venant d'être tirés (hors reliquat)
JetonAChanger:=PremierJetonTire+Random(High(TOrdreJetonTirage)+1-PremierJetonTire);
// 4. On change la lettre
LettreAEchanger:=t[JetonAChanger];
t[JetonAChanger]:=JokerAEchanger;
stTirage[Tour,JetonAChanger]:=stLettre(JokerAEchanger)[1];
for i:=ProchainJetonATirer-1 downto Low(TOrdreJetonSac) do
  if s[i]=LettreAEchanger then
    begin
    s[i]:=JokerAEchanger;
    Break;
    end;
// 5. On mais la lettre à la place du joker dans le sac
for i:=ProchainJetonATirer to High(TOrdreJetonSac) do
  if s[i]=JokerAEchanger then
    begin
    s[i]:=LettreAEchanger;
    Break;
    end
end;
//---------------------------------------------------------------------------
function TPartie.RemetJokersDansSac(var Chevalet : TChevalet; const Debut, Fin : TOrdreJetonChevalet) : Boolean; // v1.5.6. Renvoie True si au moins un joker a été remis dans le sac
var i, j, k : Integer;
    Joker, Lettre : TNumeroJetonSac;
begin
Result:=False; // Pessimiste
for i:=Debut to Fin do
  if (TypeJeton[Chevalet[i]]=tjJoker) and (LettreJoker[Chevalet[i]]>tjJoker) then
    for j:=ProchainJetonATirer to High(TOrdreJetonSac) do
      if LettreJoker[Chevalet[i]]=TypeJeton[s[j]] then // On a trouvé la lettre
        begin
        Result:=True;
        Joker:=Chevalet[i];
        LettreJoker[Joker]:=tjJoker;
        Lettre:=s[j];
        s[j]:=Joker;
        for k:=ProchainJetonATirer-1 downto Low(TNumeroJetonSac) do
          if s[k]=Joker then
            begin
            s[k]:=Lettre;
            Break;
            end;
        Chevalet[i]:=s[k];
        for k:=High(TOrdreJetonTirage) downto Low(TOrdreJetonTirage) do
          if t[k]=Joker then
            begin
            t[k]:=Lettre;
            Break;
            end;
        SubstitutJoker[Lettre]:=True; // Marqueur pour l'affichage sur le plateau de jeu
        Break
        end
end;
//---------------------------------------------------------------------------
function TPartie.TirageOKVerifieSiNecessaire(var Chevalet : TChevalet) : Boolean; // v1.5.6
var i, j, k, l         : Integer;
    TirageOk           : Boolean;
    Position           : TLocalisationJeton;
    lj                 : array [TOrdreJetonSac] of TLocalisationJeton;
const stTirageCorrompu = 'Tirage corrompu';
      stFrmMsg         = 'Le tirage a été corrompu au niveau du jeton n°%d (%s). Il va être corrigé.';
      stLocalisation   : array [TLocalisationJeton] of String = ('mystère','plateau de jeu','chevalet','sac');
      stFrmCorr        = 'Le tirage a été corrigé. La correction a été effectuée également au niveau du %s.';
begin
Result:=True; // Optimiste !
// 0. Initialisation
for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
  lj[i]:=ljInconnue;
// 1. Jetons du plateau en rouge
for i:=Low(TCoordonnee) to High(TCoordonnee) do
  for j:=Low(TCoordonnee) to High(TCoordonnee) do
    if c[i,j]>0 then
      for k:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
        if s[k]=c[i,j] then
          begin
          lj[k]:=ljPlateau;
          Break
          end;
// 2. Jetons du chevalet
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  if t[i]>0 then
    for j:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
      if s[j]=t[i] then
        begin
        lj[j]:=ljChevalet;
        Break
        end;
// 3. Jetons du sac
for i:=ProchainJetonATirer to High(TOrdreJetonSac) do
  lj[i]:=ljSac;
for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
  if lj[i]=ljInconnue then
    begin
    Result:=False;
    MessageBox(0, pChar(Format(stFrmMsg, [i, stLettre(s[i])])), stTirageCorrompu, MB_ICONEXCLAMATION);
    Break
    end;
if Result then Exit;
// On traite à partir d'ici, cas par cas
Position:=ljInconnue;
for i:=High(TOrdreJetonSac) downto Low(TOrdreJetonSac) do
  if lj[i]=ljInconnue then // Doublon : on cherche le jeton qui n'a pas d'occurrence dans le tirage
    begin
    for j:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
      begin
      TirageOk:=False; // Pessimiste
      for k:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
        if s[k]=j then
          begin
          TirageOk:=True;
          Break
          end;
      if not TirageOk then
        begin
        // Il faut rechercher si la lettre manquante est dans le sac...
        if i<ProchainJetonATirer then // ...puis sur le chevalet et enfin sur le plateau de jeu
          begin
          // Chevalet ?
          for k:=High(TOrdreJetonTirage) downto Low(TOrdreJetonTirage) do
            if t[k]=s[i] then
              begin
              t[k]:=j;
              Position:=ljChevalet;
              Break
              end;
          if (Position=ljChevalet) then // On corrige le contenu du chevalet si transmis en paramètre
            for k:=High(TOrdreJetonChevalet) downto Low(TOrdreJetonChevalet) do
              if Chevalet[k]=s[i] then
                begin
                Chevalet[k]:=j;
                Break
                end;
          if Position=ljInconnue then
            // Il ne reste plus que le plateau de jeu
            for k:=Low(TCoordonnee) to High(TCoordonnee) do
              for l:=Low(TCoordonnee) to High(TCoordonnee) do
                if c[k,l]=s[i] then
                  begin
                  c[k,l]:=j;
                  Position:=ljPlateau;
                  Break
                  end
          end
        else
          Position:=ljSac;
        s[i]:=j; // On corrige en dernier l'ordre du tirage dans le sac
        MessageBox(0, pChar(Format(stFrmCorr, [stLocalisation[Position]])), stTirageCorrompu, MB_ICONEXCLAMATION);
        Break
        end{if not TirageOk}
      end;
    Break
    end;
// On retraite jusqu'à ce qu'il n'y ait plus de problèmes
TirageOKVerifieSiNecessaire(Chevalet);
end;
//---------------------------------------------------------------------------
function TPartie.ProchainNumeroPartie(const Incremente : Boolean) : Integer; // v1.5.3 (const Incremente : Boolean)
var IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  Result:=IniFile.ReadInteger(stSectionCompteur, stEntreeCompteur, 1);
  if Incremente then // v1.5.3
    IniFile.WriteInteger(stSectionCompteur, stEntreeCompteur, Result+1);
finally
  FreeAndNil(IniFile)
end;
end;
//---------------------------------------------------------------------------
procedure TPartie.InitialisePartie;
var i, j : Integer;
begin
VersionFichier:=VersionFichierCrt; // v1.6.5 : Oubli !
for i:=Low(TCoordonnee) to High(TCoordonnee) do
  for j:=Low(TCoordonnee) to High(TCoordonnee) do
    begin
    Proposition[i, j]:=False;
    c[i, j]:=0;
    end;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  t[i]:=0;
ProchainJetonATirer:=Low(TOrdreJetonSac);
Tour:=Low(TTour);
PremierJetonTire:=Low(TOrdreJetonTirage);
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
  LettreJoker[i]:=tjJoker; // Deviendra une lettre par la suite (tjA à tjZ)
JokerPropositionAvecUnSeulJetonPlace:=0;
LettreJokerPropositionAvecUnSeulJetonPlace:=tjJoker;
ScoreSolPose:=0; // v1.5.5
ScoreMax:=0;
NbMaxSol:=0;
stNomPartie:=''; // v1.5
for i:=Low(TTour) to High(TTour) do
  begin
  Score[i]:=0;
  ScoreTop[i]:=0;
  ScorePartie[i]:=0; // v1.4
  Cumul[i]:=0;
  CumulTop[i]:=0;
  CumulPartie[i]:=0; // v1.4
  PosPrp[i]:=0;
  NbSol[i]:=0;
  CumulPosPrp[i]:=0;
  CumulNbSol[i]:=0;
  NbSolSupEgalMoitieTop[i]:=0; // v1.5
  CumulNbSolSEMoitieTop[i]:=0.0; // v1.5
  NbSolBonus50[i]:=0; // v1.5
  CumulNbSolBonus50[i]:=0; // v1.5
  xPrp[i]:=-1; yPrp[i]:=-1;
  xSol[i]:=-1; ySol[i]:=-1;
  dPrp[i]:=dIndefinie;
  dSol[i]:=dIndefinie;
  BonusScrabblePrp[i]:=False;
  BonusScrabbleSol[i]:=False;
  TiragePropose[i]:=False; // v1.5.3
  stProposition[i]:='';
  stSolution[i]:='';
  Temps[i]:=0.0;
  CumulTemps[i]:=0.0;
  TpsCalculSol[i]:=0.0; // v1.6
  CumulTpsCalculSol[i]:=0.0; // v1.6
  end;
for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do // v1.5.6
  SubstitutJoker[i]:=False;
end;
//---------------------------------------------------------------------------
constructor TPartie.Cree;
begin
DemoEnCours:=False; // v1.5
VersionFichier:=VersionFichierCrt; // v1.4 : Par défaut, sinon chargée.
Dico:=TDico.Cree;
TypePartie:=tpIndefini; // v1.5.6. Même si forcé dans ActionPartieNouvelleExecute
TempsReflexion:=trIndefini; // v1.5.6. Même si forcé dans ActionPartieNouvelleExecute
InitialisePartie;
// v1.1 : ChargeOrdreSac supprimé (géré à la demande par property)
end;
//---------------------------------------------------------------------------
destructor TPartie.Detruit;
begin
// v1.1 : SauveOrdreSac supprimé (géré à la demande par property)
Dico.Detruit;
end;
//---------------------------------------------------------------------------
procedure TPartie.CommencePartie;
begin
InitialisePartie;
NumeroPartie:=ProchainNumeroPartie(AjouteUn); // v1.5 : on attribue un numéro pour associer la partie à ses records une fois la partie enregistrée.
CompleteTirage
end;
//---------------------------------------------------------------------------
function TPartie.NbJetonsAJouer : TNumeroJetonTirage;
var i : Integer;
begin
Result:=0;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
  Result:=Result+Ord(t[i]>0)
end;
//---------------------------------------------------------------------------
function TPartie.MotForme90Valable(const X, Y : TCoordonnee;
                                   const d : TDirection;
                                   const stLettrePosee : String;
                                   var stMot : String) : Boolean;
var i, iAvant, iApres : Integer;
begin
Result:=True; // Optimiste
// On cherche le jeton placé le plus en arrière
iAvant:=0;
While CoordonneesValides(X+(iAvant-1)*dx[d], Y+(iAvant-1)*dy[d]) and
      (c[X+(iAvant-1)*dx[d], Y+(iAvant-1)*dy[d]]>0) do Dec(iAvant);
// On cherche le jeton placé le plus en avant
iApres:=0;
While CoordonneesValides(X+(iApres+1)*dx[d], Y+(iApres+1)*dy[d]) and
      (c[X+(iApres+1)*dx[d], Y+(iApres+1)*dy[d]]>0) do Inc(iApres);
stMot:='';
if 1+iApres-iAvant<2 then Exit; // Moins de deux lettres : OK.
for i:=iAvant to iApres do
  if i<>0 then
    stMot:=stMot+stLettre(X+i*dx[d], Y+i*dy[d])
  else
    stMot:=stMot+stLettrePosee;
Result:=Dico.Existe(stMot);
end;
//---------------------------------------------------------------------------
function TPartie.stLettre(const X, Y : TCoordonnee) : String;
begin
if TypeJeton[c[X,Y]]=tjJoker then
  Result:=stLettreJeton[LettreJoker[c[X,Y]]]
else
  Result:=stLettreJeton[TypeJeton[c[X,Y]]]
end;
//---------------------------------------------------------------------------
function TPartie.stLettreLD(const X, Y : TCoordonnee) : String; // vKA : avec lettres doubles
begin
if TypeJeton[c[X,Y]]=tjJoker then
  Result:=stAffichageJeton[LettreJoker[c[X,Y]]]
else
  Result:=stAffichageJeton[TypeJeton[c[X,Y]]]
end;
//---------------------------------------------------------------------------
function TPartie.stLettre(const NumeroJeton : TNumeroJetonSac) : String; // v1.4.1 : TNumeroJetonSac au lieu de TOrdreJetonSac
begin // Paramètre = N° de jeton physique et non n° d'ordre dans le sac
if TypeJeton[NumeroJeton]=tjJoker then
  Result:=stLettreJeton[LettreJoker[NumeroJeton]]
else
  Result:=stLettreJeton[TypeJeton[NumeroJeton]]
end;
//---------------------------------------------------------------------------
function TPartie.stLettreLD(const NumeroJeton : TNumeroJetonSac) : String; // vKA : avec lettres doubles
begin // Paramètre = N° de jeton physique et non n° d'ordre dans le sac
if TypeJeton[NumeroJeton]=tjJoker then
  Result:=stAffichageJeton[LettreJoker[NumeroJeton]]
else
  Result:=stAffichageJeton[TypeJeton[NumeroJeton]]
end;
//---------------------------------------------------------------------------
function TPartie.stLettreAJ(const NumeroJeton : TNumeroJetonSac) : String; // v1.4.3: Renvoie une minuscule s'il s'agit d'un joker.
begin // Paramètre = N° de jeton physique et non n° d'ordre dans le sac
if TypeJeton[NumeroJeton]=tjJoker then
  Result:=AnsiLowerCase(stLettreJeton[LettreJoker[NumeroJeton]]) // vKA : Utilisation de la version Ansi pour traiter les lettres accentuées (jetons à lettres doubles)
else
  Result:=stLettreJeton[TypeJeton[NumeroJeton]]
end;
//---------------------------------------------------------------------------
function TPartie.GenreLettreJeton(const NumeroJeton : TOrdreJetonSac) : TGenreLettre;
begin // Paramètre = N° de jeton physique et non n° d'ordre dans le sac
if TypeJeton[NumeroJeton]=tjJoker then
  Result:=GenreJeton[LettreJoker[NumeroJeton]]
else
  Result:=GenreJeton[TypeJeton[NumeroJeton]]
end;
//---------------------------------------------------------------------------
function TPartie.TirageAcceptable : Boolean;
var i : Integer;
    n : array [TGenreLettre] of Integer;
begin
for i:=Ord(Low(TGenreLettre)) to Ord(High(TGenreLettre)) do
  n[TGenreLettre(i)]:=0;
for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage)do
  if t[i]>0 then
    Inc(n[GenreLettreJeton(t[i])]);
if ProchainJetonATirer>High(TOrdreJetonSac) then // Reliquat
  Result:=(n[glIndefini]>0) or
          (Min(n[glConsonne],n[glVoyelle])>0)
else // Il reste des jetons dans le sac
  if Tour<16 then
    Result:=(n[glIndefini]+Min(n[glConsonne],n[glVoyelle])>=2)
  else
    Result:=(n[glIndefini]+Min(n[glConsonne],n[glVoyelle])>=1)
end;
//---------------------------------------------------------------------------
function TPartie.NbJetonsPoses : Integer; // v1.5.3
var i, j : Integer;
begin
Result:=0;
for i:=Low(TCoordonnee) to High(TCoordonnee) do
  for j:=Low(TCoordonnee) to High(TCoordonnee) do
    if c[i, j]>0 then
      Inc(Result)
end;
//---------------------------------------------------------------------------
function TPartie.NbJetonsAPlacer(const Chevalet : TChevalet;
                                 const Debut, Fin : TNumeroJetonChevalet) : Integer;
var i : Integer;
begin
Result:=0;
if (Debut<Low(TOrdreJetonChevalet)) or
   (Fin<Low(TOrdreJetonChevalet)) then Exit;
for i:=Debut to Fin do
  if Chevalet[i]>0 then Inc(Result);
end;
//---------------------------------------------------------------------------
function TPartie.NbJokersAPlacer(const Chevalet : TChevalet; // v1.5 pour classement choix de solutions tops
                                 const Debut, Fin : TNumeroJetonChevalet) : Integer;
var i : Integer;
begin
Result:=0;
if (Debut<Low(TOrdreJetonChevalet)) or
   (Fin<Low(TOrdreJetonChevalet)) then Exit;
for i:=Debut to Fin do
  if TypeJeton[Chevalet[i]]=tjJoker then Inc(Result);
end;
//---------------------------------------------------------------------------
function TPartie.ValeurAPlacer(const Chevalet : TChevalet; // v1.5 pour classement choix de solutions tops
                               const Debut, Fin : TNumeroJetonChevalet) : Integer;
var i : Integer;
begin
Result:=0;
if (Debut<Low(TOrdreJetonChevalet)) or
   (Fin<Low(TOrdreJetonChevalet)) then Exit;
for i:=Debut to Fin do
  Inc(Result, ValeurJeton[TypeJeton[Chevalet[i]]])
end;
//---------------------------------------------------------------------------
function TPartie.MotsFormesValables(const X, Y : TCoordonnee;
                                    const d : TDirection;
                                    const Chevalet : TChevalet;
                                    const Debut, Fin : TOrdreJetonChevalet;
                                    const TypeProposition : TTypeProposition) : Boolean; // v1.4 : TTypeProposition au lieu de Boolean
var NbJetonsPlaces,
    i, iSelection, iPlateau,
    TypeJoker,
    NbMotsNonValables, // v1.6
    Nbjokers : Integer; // v1.4
    stMot, stMot90 : String;
begin // Doit être exécuté avant PlaceJetons et que si EstJouable renvoie True
NbJokers:=0; // v1.4
NbMotsNonValables:=0; // v1.6
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do NumeroJoker[i]:=0; // v1.4
if TypeProposition<>tpRecherche then
  stMessage:='';
Result:=True; // Optimiste par défaut
// On cherche les jetons placés avant le premier placé
i:=0;
While CoordonneesValides(X+(i-1)*dx[d], Y+(i-1)*dy[d]) and
      (c[X+(i-1)*dx[d], Y+(i-1)*dy[d]]>0) do
  begin
  stMot:=stLettre(X+(i-1)*dx[d],
                  Y+(i-1)*dy[d])+
         stMot;
  Dec(i)
  end;
// On cherche les jetons posés + déjà présents au passage
iPlateau:=0; NbJetonsPlaces:=0;
for iSelection:=Debut to Fin do
  if Chevalet[iSelection]>0 then
    begin
    Inc(NbJetonsPlaces);
    while c[X+iPlateau*dx[d],
            Y+iPlateau*dy[d]]>0 do
      begin
      stMot:=stMot+stLettre(X+iPlateau*dx[d],
                            Y+iPlateau*dy[d]);
      Inc(iPlateau);
      end;
    if (TypeProposition<>tpRecherche) and
       (TypeJeton[Chevalet[iSelection]]=tjJoker) then
      if (LettreJokerPropositionAvecUnSeulJetonPlace>tjJoker) and
         (JokerPropositionAvecUnSeulJetonPlace>=Low(TOrdreJoker)) and // v1.4.3 : il manquait le égal !
         (JokerPropositionAvecUnSeulJetonPlace=Chevalet[iSelection]) then
        begin
        NumeroJoker[NbJokers]:=Chevalet[iSelection]; // v1.4
        Inc(NbJokers); // v1.4
        LettreJoker[Chevalet[iSelection]]:=LettreJokerPropositionAvecUnSeulJetonPlace;
        JokerPropositionAvecUnSeulJetonPlace:=0;
        LettreJokerPropositionAvecUnSeulJetonPlace:=tjJoker
        end
      else
        begin
        FormJoker.stMot:=stLettresDoubles(stMot)+stJoker; // vKA : affichage des lettres doubles : ajout de stLettresDoubles(...)
        TypeJoker:=FormJoker.ShowModal;
        if TypeJoker<Ord(Low(TTypeJeton)) then
          begin
          Result:=False;
          stMessage:='Joker non défini (annulé)';
          Exit;
          end
        else
          begin
          NumeroJoker[NbJokers]:=Chevalet[iSelection]; // v1.4
          Inc(NbJokers); // v1.4
          LettreJoker[Chevalet[iSelection]]:=TTypeJeton(TypeJoker);
          // On retient l'information dans le cas d'un seul jeton posé où il faudrait choisir la direction donnant le mot principal le plus long (jokers effacés)
          JokerPropositionAvecUnSeulJetonPlace:=Chevalet[iSelection];
          LettreJokerPropositionAvecUnSeulJetonPlace:=TTypeJeton(TypeJoker);
          end
        end{else if LettreJoker};
    // On contrôle les mots transversaux au passage
    if not MotForme90Valable(X+iPlateau*dx[d],
                             Y+iPlateau*dy[d],
                             Dir90[d],
                             stLettre(Chevalet[iSelection]),
                             stMot90) then
      begin
      Result:=False;
      if TypeProposition<>tpRecherche then
        begin
        stMessage:=stMessage+ // v1.6 : On place le texte après avoir défini la liste de mots non valables
                   IfThen(NbMotsNonValables=0, '', ', ')+
                   stLettresDoubles(stMot90); // vKA : affichage des doubles lettres : ajout de stLettresDoubles(...)
        Inc(NbMotsNonValables);
        end
      end;
    stMot:=stMot+stLettre(Chevalet[iSelection]);
    Inc(iPlateau);
    end{if};
// On cherche les jetons placés après le dernier placé
i:=0;
While CoordonneesValides(X+(iPlateau+i)*dx[d],
                         Y+(iPlateau+i)*dy[d]) and
      (c[X+(iPlateau+i)*dx[d], Y+(iPlateau+i)*dy[d]]>0) do
  begin
  stMot:=stMot+stLettre(X+(iPlateau+i)*dx[d],
                        Y+(iPlateau+i)*dy[d]);
  Inc(i)
  end;
//  - On regarde si le mot principal est valable
if not Dico.Existe(stMot) then
  begin
  Result:=False;
  if TypeProposition<>tpRecherche then
    begin // v1.6 : On place le texte après avoir défini la liste de mots non valables. Le mot pricipal est mis en tête
    stMessage:=stLettresDoubles(stMot)+IfThen(NbMotsNonValables=0, '', ', ')+stMessage; // vKA : affichage des doubles lettres : ajout de stLettresDoubles(...)
    Inc(NbMotsNonValables);
    end;
  end;
if NbMotsNonValables>0 then // v1.6 : on place le texte mot(s) non valide(s)
  stMessage:=Format(stMsgMotNonValable[NbMotsNonValables>1], [stMessage]);
stMotPrincipal:=stMot; // v1.4 : permet de retenir le mot principal pour créer une instance de TSolution depuis FormPorpositionPose
if TypeProposition=tpProposition then
  begin
  stProposition[Tour]:=stMot;
  PropositionAvecUnSeulJetonPlace:=(NbJetonsPlaces=1); // Permet de décider quelle direction retenir (proposition uniquement)
  end;
if not Result and
   (TypeProposition<>tpRecherche) then // Si pas bon, on annule le(s) joker(s) pour les humains
   begin
   iPlateau:=0;
   for iSelection:=Debut to Fin do
     if Chevalet[iSelection]>0 then
       begin
       while c[X+iPlateau*dx[d],
               Y+iPlateau*dy[d]]>0 do
        Inc(iPlateau);
       if TypeJeton[Chevalet[iSelection]]=tjJoker then
         LettreJoker[Chevalet[iSelection]]:=tjJoker;
       end{if Chevalet}
   end{if Result else}
end;
//---------------------------------------------------------------------------
function TPartie.EstJouable(const X, Y : TCoordonnee;
                            const d : TDirection;
                            const Chevalet : TChevalet;
                            const Debut, Fin : TOrdreJetonChevalet) : Boolean;
var iSelection, iPlateau : Integer;
    CaseCentrale,
    JetonContigu : Boolean;
begin
stMessage:='';
Result:=True; // Optimiste par défaut
CaseCentrale:=False;
JetonContigu:=False;
iPlateau:=0;
for iSelection:=Debut to Fin do
  if Chevalet[iSelection]>0 then
    begin
    while c[X+iPlateau*dx[d],
            Y+iPlateau*dy[d]]>0 do
      begin
      if (Tour>1) and not JetonContigu then
        JetonContigu:=True;
      Inc(iPlateau);
      end;
    Result:=CoordonneesValides(X+iPlateau*dx[d],
                               Y+iPlateau*dy[d]);
    if not Result then break; // Pas bon, on quitte
    if (Tour=1) and
       not CaseCentrale then
      CaseCentrale:=((X+iPlateau*dx[d]=XCentre) and
                     (Y+iPlateau*dy[d]=YCentre));
    if (Tour>1) and not JetonContigu then // On regarde si un jeton placé est situé de part ou d'autre (latéralement)
      JetonContigu:=(CoordonneesValides(X+iPlateau*dx[d]+dxBabord[d],
                                        Y+iPlateau*dy[d]+dyBabord[d]) and
                     (c[X+iPlateau*dx[d]+dxBabord[d],
                        Y+iPlateau*dy[d]+dyBabord[d]]>0)) or
                    (CoordonneesValides(X+iPlateau*dx[d]+dxTribord[d],
                                        Y+iPlateau*dy[d]+dyTribord[d]) and
                     (c[X+iPlateau*dx[d]+dxTribord[d],
                        Y+iPlateau*dy[d]+dyTribord[d]]>0));
    Inc(iPlateau);
    end{if};
if (Tour>1) and not JetonContigu then // On regarde si un jeton placé suit ou précède les jetons placés
  JetonContigu:=(CoordonneesValides(X-dx[d],
                                    Y-dy[d]) and
                 (c[X-dx[d], Y-dy[d]]>0)) or
                (CoordonneesValides(X+iPlateau*dx[d],
                                    Y+iPlateau*dy[d]) and
                 (c[X+iPlateau*dx[d],
                    Y+iPlateau*dy[d]]>0));
if not Result then
  stMessage:='Il n''y a pas assez de place sur le jeu à l''endroit et direction indiqués.'+stAutreChoix
else
  if (Tour=1) and not CaseCentrale then
    begin
    stMessage:='Au premier tour, vous devez placer au moins un jeton sur la case centrale.'+stAutreChoix;
    Result:=False;
    end{if Tour};
if Result and
   (Tour>1) and
   not JetonContigu then
  begin
  stMessage:='Les jetons posés ne sont contigus à aucun autre jeton déjà placé.'+stAutreChoix;
  Result:=False
  end
end;
//---------------------------------------------------------------------------
function TPartie.JetonIsoleDirectionChoix(const X, Y : TCoordonnee; // v1.5
                                          const d : TDirection) : Boolean;
begin
Result:=CoordonneesValides(X-dx[d], Y-dy[d]) and (c[X-dx[d], Y-dy[d]]=0) and
        CoordonneesValides(X+dx[d], Y+dy[d]) and (c[X+dx[d], Y+dy[d]]=0)
end;
//---------------------------------------------------------------------------
procedure TPartie.PlaceJetons(const X, Y : TCoordonnee;
                              const d : TDirection;
                              const Chevalet : TChevalet;
                              const Debut, Fin : TOrdreJetonChevalet;
                              const EstProposition : Boolean);
var iSelection, iPlateau : Integer;
begin
iPlateau:=0;
for iSelection:=Debut to Fin do
  begin
  if Chevalet[iSelection]>0 then
    begin
    while c[X+iPlateau*dx[d],
            Y+iPlateau*dy[d]]>0 do Inc(iPlateau);
    c[X+iPlateau*dx[d],
      Y+iPlateau*dy[d]]:=Chevalet[iSelection];
    Proposition[X+iPlateau*dx[d],
                Y+iPlateau*dy[d]]:=EstProposition;
    Inc(iPlateau);
    end{if}
  end{for};
DistanceCaseDrnJetonPlace:=iPlateau-1;
end;
//---------------------------------------------------------------------------
function TPartie.ScoreMot90(const X, Y : TCoordonnee;
                            const d : TDirection;
                            const LettrePosee : TNumeroJetonSac) : Integer;
var i, iAvant, iApres,
    TailleMot90 : Integer; // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
    stMot90 : String;      // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
begin
Result:=0;
TailleMot90:=0; // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
stMot90:='';    // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
// On cherche le jeton placé le plus en arrière
iAvant:=0;
While CoordonneesValides(X+(iAvant-1)*dx[d],
                         Y+(iAvant-1)*dy[d]) and
      (c[X+(iAvant-1)*dx[d],
         Y+(iAvant-1)*dy[d]]>0) do Dec(iAvant);
// On cherche le jeton placé le plus en avant
iApres:=0;
While CoordonneesValides(X+(iApres+1)*dx[d],
                         Y+(iApres+1)*dy[d]) and
      (c[X+(iApres+1)*dx[d],
         Y+(iApres+1)*dy[d]]>0) do Inc(iApres);
if 1+iApres-iAvant<2 then Exit; // Moins de deux lettres : OK.
for i:=iAvant to iApres do
  begin
  if i<>0 then
    begin
    Inc(Result, ValeurJeton[TypeJeton[c[X+i*dx[d], Y+i*dy[d]]]]);
    // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
    stMot90:=stMot90+stLettre(X+i*dx[d], Y+i*dy[d])
    end
  else
    begin
    Inc(Result, CoefBonusLettre[BonusCase[X, Y]]*
                ValeurJeton[TypeJeton[LettrePosee]]);
    // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
    stMot90:=stMot90+stLettre(LettrePosee);
    end;
  Inc(TailleMot90); // v1.5 : pour calcul TPartie.TailleMaxMotForme et TPartie.stMotTailleMax
  end;
if TailleMot90>TailleMaxMotForme then // v1.5
  begin
  TailleMaxMotForme:=TailleMot90;
  stMotTailleMax:=stMot90
  end;
Result:=Result*CoefBonusMot[BonusCase[X, Y]];
end;
//---------------------------------------------------------------------------
function TPartie.ScorePose(const X, Y : TCoordonnee;
                           const d : TDirection;
                           const Chevalet : TChevalet;
                           const Debut, Fin : TOrdreJetonChevalet) : Integer;
var ScoreMots90,
    ScoreMotPrincipal,
    NbLettresMotPrincipal,
    CoefMot,
    NbJetonsPlaces,
    i, iSelection, iPlateau : Integer;
    stMotPrincipal          : String; // v1.5 : pour calcul stMotTailleMax
begin // Doit être exécuté avant PlaceJetons et que si EstJouable renvoie True
ScoreMotPrincipal:=0;
NbLettresMotPrincipal:=0; // Permet de savoir si la direction prise correspond à un mot ou une seule lettre (ne comptant pas dans ce cas là)

// v1.5 : calculé pour records de taille max mot formé
TailleMaxMotForme:=0;
stMotTailleMax:='';
stMotPrincipal:='';

// On cherche les jetons placés avant le premier placé
i:=0;
While CoordonneesValides(X+(i-1)*dx[d],
                         Y+(i-1)*dy[d]) and
      (c[X+(i-1)*dx[d],
         Y+(i-1)*dy[d]]>0) do
  begin
  Inc(ScoreMotPrincipal, ValeurJeton[TypeJeton[c[X+(i-1)*dx[d],
                                                 Y+(i-1)*dy[d]]]]);
  Inc(NbLettresMotPrincipal);
  stMotPrincipal:=stLettre(X+(i-1)*dx[d], // v1.5 : On calcule le début de stMotPrincipal
                           Y+(i-1)*dy[d])+
                  stMotPrincipal;
  Dec(i)
  end;

// On cherche les jetons posés + déjà présents au passage
iPlateau:=0;
NbJetonsPlaces:=0;
CoefMot:=1;
ScoreMots90:=0;
for iSelection:=Debut to Fin do
  if Chevalet[iSelection]>0 then
    begin
    while c[X+iPlateau*dx[d],
            Y+iPlateau*dy[d]]>0 do
      begin
      Inc(ScoreMotPrincipal,
          ValeurJeton[TypeJeton[c[X+iPlateau*dx[d],
                                  Y+iPlateau*dy[d]]]]);
      Inc(NbLettresMotPrincipal);
      stMotPrincipal:=stMotPrincipal+ // v1.5 : On calcule le milieu de stMotPrincipal
                      stLettre(X+iPlateau*dx[d],
                               Y+iPlateau*dy[d]);
      Inc(iPlateau);
      end;
    // On contrôle les mots transversaux au passage
    Inc(ScoreMots90, ScoreMot90(X+iPlateau*dx[d],
                                Y+iPlateau*dy[d],
                                Dir90[d],
                                Chevalet[iSelection]));
    Inc(ScoreMotPrincipal,
        CoefBonusLettre[BonusCase[X+iPlateau*dx[d],
                                  Y+iPlateau*dy[d]]]*
        ValeurJeton[TypeJeton[Chevalet[iSelection]]]);
    CoefMot:=CoefMot*CoefBonusMot[BonusCase[X+iPlateau*dx[d],
                                            Y+iPlateau*dy[d]]];
    Inc(NbLettresMotPrincipal);
    stMotPrincipal:=stMotPrincipal+ // v1.5 : On calcule le milieu de stMotPrincipal
                    stLettre(Chevalet[iSelection]);
    Inc(iPlateau);
    Inc(NbJetonsPlaces)
    end{if};
//  - On cherche les jetons placés après le dernier placé
i:=0;
While CoordonneesValides(X+(iPlateau+i)*dx[d],
                         Y+(iPlateau+i)*dy[d]) and
      (c[X+(iPlateau+i)*dx[d], Y+(iPlateau+i)*dy[d]]>0) do
  begin
  Inc(ScoreMotPrincipal, ValeurJeton[TypeJeton[c[X+(iPlateau+i)*dx[d],
                                      Y+(iPlateau+i)*dy[d]]]]);
  Inc(NbLettresMotPrincipal);
  stMotPrincipal:=stMotPrincipal+ // v1.5 : On calcule la fin de stMotPrincipal
                  stLettre(X+(iPlateau+i)*dx[d],
                           Y+(iPlateau+i)*dy[d]);
  Inc(i)
  end{while};

// v1.5 : test du mot principal pour la taille max des mots formés
if NbLettresMotPrincipal>TailleMaxMotForme then
  begin
  TailleMaxMotForme:=NbLettresMotPrincipal;
  stMotTailleMax:=stMotPrincipal
  end;
stMotTailleMax:=StringReplace(stMotTailleMax, ' ', '?', [rfReplaceAll]);

Result:=Ord(NbLettresMotPrincipal>1)*ScoreMotPrincipal*CoefMot+
        ScoreMots90+
        Ord(NbJetonsPlaces=NbMaxJetonsTirage)*BonusScrabble;
end;
//---------------------------------------------------------------------------
// fonctions de stockage. extension .dip => Partie ; .rtf => Feuille de match en format rtf.
//---------------------------------------------------------------------------
function TPartie.Sauve(const stNomFichier : String;
                       const Chevalet : TChevalet;
                       const Debut, Fin : TNumeroJetonChevalet;
                       const xPopup, yPopup : Integer) : Boolean;
var i, j, k,
    AncCumNbSolSEMT : Integer; // v1.5.1 : variable de chargement de compatibilité
    F : File;
begin
AncCumNbSolSEMT:=0; // v1.5.1
AssignFile(f, stNomFichier);
try
  Rewrite(f, 1);
  // v1.5.3 : On monte la version 1.5 en 1.5.3 car on enregistre la donnée 1.5.3 TiragePropose[TTour]
  if VersionFichier=$150 then VersionFichier:=$153;
  BlockWrite(f, VersionFichier, SizeOf(VersionFichier));
  for i:=Low(TCoordonnee) to High(TCoordonnee) do
    for j:=Low(TCoordonnee) to High(TCoordonnee) do
      begin
      BlockWrite(f, c[i, j], SizeOf(c[i, j]));
      BlockWrite(f, Proposition[i, j], SizeOf(Proposition[i, j]));
      end;
  for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
    BlockWrite(f, s[i], SizeOf(s[i]));
  for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
    BlockWrite(f, t[i], SizeOf(t[i]));
  for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
    BlockWrite(f, LettreJoker[i], SizeOf(LettreJoker[i]));
  if VersionFichier>=$156 then // v1.5.6
    for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
      BlockWrite(f, SubstitutJoker[i], SizeOf(SubstitutJoker[i]));
  for i:=Low(TTour) to High(TTour) do
    begin
    BlockWrite(f, Score[i], SizeOf(Score[i]));
    BlockWrite(f, Cumul[i], SizeOf(Cumul[i]));
    BlockWrite(f, ScoreTop[i], SizeOf(ScoreTop[i]));
    BlockWrite(f, CumulTop[i], SizeOf(CumulTop[i]));
    if VersionFichier>=$140 then  // v1.4. On poursuit la version antérieure à la v1.4 à cause de la feuille de match RTF enregistrée séparément (version antérieure à 1.4)
      begin
      BlockWrite(f, ScorePartie[i], SizeOf(ScorePartie[i]));
      BlockWrite(f, CumulPartie[i], SizeOf(CumulPartie[i]));
      end;
    BlockWrite(f, PosPrp[i], SizeOf(PosPrp[i]));
    BlockWrite(f, NbSol[i], SizeOf(NbSol[i]));
    BlockWrite(f, CumulPosPrp[i], SizeOf(CumulPosPrp[i]));
    BlockWrite(f, CumulNbSol[i], SizeOf(CumulNbSol[i]));
    if VersionFichier>=$150 then // v1.5. Ces stats ne peuvent pas être recalculées après chargement (restent à zéro)
      begin
      BlockWrite(f, NbSolSupEgalMoitieTop[i], SizeOf(NbSolSupEgalMoitieTop[i])); // v1.5
      BlockWrite(f, AncCumNbSolSEMT, SizeOf(AncCumNbSolSEMT));                   // v1.5.1 : on enregistre rien au format entier 32 bits (valeur recalculée au chargement)
      BlockWrite(f, NbSolBonus50[i], SizeOf(NbSolBonus50[i]));                   // v1.5
      BlockWrite(f, CumulNbSolBonus50[i], SizeOf(CumulNbSolBonus50[i]));         // v1.5
      end;
    BlockWrite(f, xPrp[i], SizeOf(xPrp[i]));
    BlockWrite(f, yPrp[i], SizeOf(yPrp[i]));
    BlockWrite(f, dPrp[i], SizeOf(dPrp[i]));
    BlockWrite(f, xSol[i], SizeOf(xSol[i]));
    BlockWrite(f, ySol[i], SizeOf(ySol[i]));
    BlockWrite(f, dSol[i], SizeOf(dSol[i]));
    BlockWrite(f, BonusScrabblePrp[i], SizeOf(BonusScrabblePrp[i]));
    BlockWrite(f, BonusScrabbleSol[i], SizeOf(BonusScrabbleSol[i]));
    if VersionFichier>=$150 then // On enregistre que pour les versions >= v1.5
      BlockWrite(f, TiragePropose[i], SizeOf(TiragePropose[i])); //v1.5.3
    BlockWrite(f, Temps[i], SizeOf(Temps[i]));
    BlockWrite(f, CumulTemps[i], SizeOf(CumulTemps[i]));
    if VersionFichier>=$160 then // On enregistre que pour les versions >= v1.6
      begin
      BlockWrite(f, TpsCalculSol[i], SizeOf(TpsCalculSol[i]));
      BlockWrite(f, CumulTpsCalculSol[i], SizeOf(CumulTpsCalculSol[i]))
      end;
    k:=Length(stProposition[i]);
    BlockWrite(f, k, SizeOf(k));
    for j:=1 to k do
      BlockWrite(f, stProposition[i,j], SizeOf(stProposition[i,j]));
    k:=Length(stSolution[i]);
    BlockWrite(f, k, SizeOf(k));
    for j:=1 to k do
      BlockWrite(f, stSolution[i,j], SizeOf(stSolution[i,j]));
    k:=Length(stTirage[i]);
    BlockWrite(f, k, SizeOf(k));
    for j:=1 to k do
      BlockWrite(f, stTirage[i,j], SizeOf(stTirage[i,j]));
    end;
  if VersionFichier>=$156 then // v1.5.6
    begin
    BlockWrite(f, TypePartie, SizeOf(TypePartie));
    BlockWrite(f, TempsReflexion, SizeOf(TempsReflexion));
    end;
  BlockWrite(f, ScoreMax, SizeOf(ScoreMax));
  BlockWrite(f, NbMaxSol, SizeOf(NbMaxSol));
  BlockWrite(f, Tour, SizeOf(Tour));
  BlockWrite(f, ProchainJetonATirer, SizeOf(ProchainJetonATirer));
  BlockWrite(f, PremierJetonTire, SizeOf(PremierJetonTire));
  BlockWrite(f, DistanceCaseDrnJetonPlace, SizeOf(DistanceCaseDrnJetonPlace));
  BlockWrite(f, PropositionAvecUnSeulJetonPlace, SizeOf(PropositionAvecUnSeulJetonPlace));
  BlockWrite(f, JokerPropositionAvecUnSeulJetonPlace, SizeOf(JokerPropositionAvecUnSeulJetonPlace));
  BlockWrite(f, LettreJokerPropositionAvecUnSeulJetonPlace, SizeOf(LettreJokerPropositionAvecUnSeulJetonPlace));
  for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
    BlockWrite(f, Chevalet[i], SizeOf(Chevalet[i]));
  BlockWrite(f, Debut, SizeOf(Debut));
  BlockWrite(f, Fin, SizeOf(Fin));
  BlockWrite(f, xPopup, SizeOf(xPopup));
  BlockWrite(f, yPopup, SizeOf(yPopup));
  if VersionFichier>=$150 then // v1.5. N° absolu de partie pour les records. Pas de numéro pour les versions antérieure à la v1.5 (inutiles car nom de partie défini)
    BlockWrite(f, NumeroPartie, SizeOf(NumeroPartie));
  Result:=True;
finally
  CloseFile(f);
end{try}
end;
//---------------------------------------------------------------------------
function TPartie.Charge(const stNomFichier : String;
                         var Chevalet : TChevalet;
                         var Debut, Fin : TNumeroJetonChevalet;
                         var xPopup, yPopup : Integer;
                         var stMessage : String) : Boolean; // v1.5 : Message d'erreur
var i, j, k,
    AncCumNbSolSEMT : Integer; // v1.5.1 : variable de chargement de compatibilité
    l : String;
    F : File;
begin
Result:=False; // v1.5 : Pessimiste
l:=' ';
AssignFile(f, stNomFichier);
try
  Reset(f, 1);
  BlockRead(f, VersionFichier, SizeOf(VersionFichier));
  // ATTENTION : ajouter TOUTES les versions de fichiers ici
  if (VersionFichier<>$140) and
     (VersionFichier<>$150) and
     (VersionFichier<>$153) and
     (VersionFichier<>$156) and
     (VersionFichier<>$160) and
     (VersionFichier<>$163) and
     (VersionFichier<>$165) and
     (VersionFichier<>$166) then // v1.6.6
    begin
    // v1.5.1 : On ne prend plus les fichiers de version antérieure à la version 1.4
    // VersionFichier:=$100; // v1.4 : oubli de stocker $100 à l'origine
    stMessage:='Ce n''est pas un fichier de partie Diplikata ou le fichier a été généré avec une version de Diplikata antérieure à la version 1.4.';
    Exit
    end;
  if VersionFichier>VersionFichierCrt then // v1.5
    begin
    stMessage:='Cette partie a été enregistrée avec une version ultérieure à la version actuelle de Diplikata.';
    Exit
    end;
  for i:=Low(TCoordonnee) to High(TCoordonnee) do
    for j:=Low(TCoordonnee) to High(TCoordonnee) do
      begin
      BlockRead(f, c[i, j], SizeOf(c[i, j]));
      BlockRead(f, Proposition[i, j], SizeOf(Proposition[i, j]));
      // v1.4.4 : On ne peut pas avoir de proposition en enregistrement : on retire les résidus (comme la case du coin en bas à droite)
      Proposition[i, j]:=False;
      end;
  for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
    BlockRead(f, s[i], SizeOf(s[i]));
  for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
    BlockRead(f, t[i], SizeOf(t[i]));
  for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
    BlockRead(f, LettreJoker[i], SizeOf(LettreJoker[i]));
  if VersionFichier>=$156 then // v1.5.6
    for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
      BlockRead(f, SubstitutJoker[i], SizeOf(SubstitutJoker[i]))
  else
    for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
      SubstitutJoker[i]:=False;
  for i:=Low(TTour) to High(TTour) do
    begin
    BlockRead(f, Score[i], SizeOf(Score[i]));
    BlockRead(f, Cumul[i], SizeOf(Cumul[i]));
    BlockRead(f, ScoreTop[i], SizeOf(ScoreTop[i]));
    BlockRead(f, CumulTop[i], SizeOf(CumulTop[i]));
    if VersionFichier>=$140 then  // v1.4
      begin
      BlockRead(f, ScorePartie[i], SizeOf(ScorePartie[i]));
      BlockRead(f, CumulPartie[i], SizeOf(CumulPartie[i]));
      end
    else
      begin
      ScorePartie[i]:=ScoreTop[i];
      CumulPartie[i]:=CumulTop[i];
      end;
    BlockRead(f, PosPrp[i], SizeOf(PosPrp[i]));
    BlockRead(f, NbSol[i], SizeOf(NbSol[i]));
    BlockRead(f, CumulPosPrp[i], SizeOf(CumulPosPrp[i]));
    BlockRead(f, CumulNbSol[i], SizeOf(CumulNbSol[i]));
    if VersionFichier>=$150 then // v1.5
      begin
      BlockRead(f, NbSolSupEgalMoitieTop[i], SizeOf(NbSolSupEgalMoitieTop[i]));
      BlockRead(f, AncCumNbSolSEMT, SizeOf(AncCumNbSolSEMT)); // v1.5.1 : on charge pour la compatibilité mais on recalcule ci-après
      BlockRead(f, NbSolBonus50[i], SizeOf(NbSolBonus50[i]));
      BlockRead(f, CumulNbSolBonus50[i], SizeOf(CumulNbSolBonus50[i]));
      // v1.5.1 : on pondère le niveau de difficulté moyen par ScoreTop (non sauvegardé : recalculé)
      if NbSol[i]<>0 then
        CumulNbSolSEMoitieTop[i]:=(1.0*NbSolSupEgalMoitieTop[i]*ScoreTop[i])/NbSol[i]+
                                  IfThen(i>Low(TTour), CumulNbSolSEMoitieTop[Pred(i)], 0.0)
      else
        CumulNbSolSEMoitieTop[i]:=0
      end
    else
      begin
      NbSolSupEgalMoitieTop[i]:=0;
      CumulNbSolSEMoitieTop[i]:=0.0;
      NbSolBonus50[i]:=0;
      CumulNbSolBonus50[i]:=0;
      end;
    BlockRead(f, xPrp[i], SizeOf(xPrp[i]));
    BlockRead(f, yPrp[i], SizeOf(yPrp[i]));
    BlockRead(f, dPrp[i], SizeOf(dPrp[i]));
    BlockRead(f, xSol[i], SizeOf(xSol[i]));
    BlockRead(f, ySol[i], SizeOf(ySol[i]));
    BlockRead(f, dSol[i], SizeOf(dSol[i]));
    BlockRead(f, BonusScrabblePrp[i], SizeOf(BonusScrabblePrp[i]));
    BlockRead(f, BonusScrabbleSol[i], SizeOf(BonusScrabbleSol[i]));
    if VersionFichier>=$153 then // v1.5.3
      BlockRead(f, TiragePropose[i], SizeOf(TiragePropose[i]))
    else
      TiragePropose[i]:=False;
    BlockRead(f, Temps[i], SizeOf(Temps[i]));
    BlockRead(f, CumulTemps[i], SizeOf(CumulTemps[i]));
    if VersionFichier>=$160 then // v1.6
      begin
      BlockRead(f, TpsCalculSol[i], SizeOf(TpsCalculSol[i]));
      BlockRead(f, CumulTpsCalculSol[i], SizeOf(CumulTpsCalculSol[i]))
      end;
    stProposition[i]:='';
    BlockRead(f, k, SizeOf(k));
    for j:=1 to k do
      begin
      BlockRead(f, l[1], SizeOf(l[1]));
      stProposition[i]:=stProposition[i]+l
      end;
    stSolution[i]:='';
    BlockRead(f, k, SizeOf(k));
    for j:=1 to k do
      begin
      BlockRead(f, l[1], SizeOf(l[1]));
      stSolution[i]:=stSolution[i]+l
      end;
    stTirage[i]:='';
    BlockRead(f, k, SizeOf(k));
    for j:=1 to k do
      begin
      BlockRead(f, l[1], SizeOf(l[1]));
      stTirage[i]:=stTirage[i]+l
      end;
    // v1.4.7 : On recalcule CumulPosPrp au cas où le fichier a été généré avec une version antérieure à la version 1.4.7
    // Attention : le rang moyen est CumulPosPrp[i] div i
    if NbSol[i]>0 then
      if i>Low(TTour) then // v1.5 : Débordement d'entier : utilisation des entiers 64 bits
        CumulPosPrp[i]:=((Int64(PosPrp[i])*Int64(CumulNbSol[i])) div NbSol[i]+
                         (Int64(Pred(i))*Int64(CumulPosPrp[Pred(i)])*Int64(CumulNbSol[i])) div CumulNbSol[Pred(i)]) div i
      else
        CumulPosPrp[i]:=PosPrp[i];
      end;
  if VersionFichier>=$156 then // v1.5.6
    begin
    BlockRead(f, TypePartie, SizeOf(TypePartie));
    BlockRead(f, TempsReflexion, SizeOf(TempsReflexion));
    end
  else
    begin
    TypePartie:=tpStandard;
    TempsReflexion:=trNormal
    end;
  BlockRead(f, ScoreMax, SizeOf(ScoreMax));
  BlockRead(f, NbMaxSol, SizeOf(NbMaxSol));
  BlockRead(f, Tour, SizeOf(Tour));
  BlockRead(f, ProchainJetonATirer, SizeOf(ProchainJetonATirer));
  BlockRead(f, PremierJetonTire, SizeOf(PremierJetonTire));
  BlockRead(f, DistanceCaseDrnJetonPlace, SizeOf(DistanceCaseDrnJetonPlace));
  BlockRead(f, PropositionAvecUnSeulJetonPlace, SizeOf(PropositionAvecUnSeulJetonPlace));
  BlockRead(f, JokerPropositionAvecUnSeulJetonPlace, SizeOf(JokerPropositionAvecUnSeulJetonPlace));
  BlockRead(f, LettreJokerPropositionAvecUnSeulJetonPlace, SizeOf(LettreJokerPropositionAvecUnSeulJetonPlace));
  for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
    BlockRead(f, Chevalet[i], SizeOf(Chevalet[i]));
  BlockRead(f, Debut, SizeOf(Debut));
  BlockRead(f, Fin, SizeOf(Fin));
  BlockRead(f, xPopup, SizeOf(xPopup));
  BlockRead(f, yPopup, SizeOf(yPopup));
  if VersionFichier>=$150 then // v1.5. N° absolu de partie pour les records. Pas de numéro pour les versions antérieure à la v1.5 (inutiles car nom de partie défini)
    BlockRead(f, NumeroPartie, SizeOf(NumeroPartie))
  else // v1.5.3 : oubli !
    NumeroPartie:=0;
  Result:=True;
finally
  CloseFile(f);
end{try}
end;
//---------------------------------------------------------------------------
function TPartie.PartieEnCours : Boolean;
begin
Result:=(ProchainJetonATirer>Low(TOrdreJetonSac))
end;
//---------------------------------------------------------------------------
function TPartie.stSac : String;
var i : Integer;
begin
for i:=Low(TOrdreJetonSac) to High(TOrdreJetonSac) do
  if i=ProchainJetonATirer then
    Result:=Result+'['+stLettreJeton[TypeJeton[s[i]]]+']'
  else
    Result:=Result+stLettreJeton[TypeJeton[s[i]]]
end;
//---------------------------------------------------------------------------
procedure TPartie.Cherche(var slSolutions : TStringList); // slSolutions est supposée être déjà instanciée
var x, y,
    ii,
    iDrnSol1J,
    i1, i2, i3, i4, i5, i6, i7,
    NbJokers, // /!\ Défini dans Etape6 et utilisé dans Etape7
    NbJetonsAbsents,
    NbJetonsAPlacer,
    NbJetonsTirage,
    NbMinJetonsAPlacer,
    NbMaxJetonsAPlacer,
    ScoreQualitePose,    // v1.5.5
    ScoreCrt, DiffScore, // v1.5.5
    RangQualitePose,     // v1.5.5
    NivDiff               : Integer; // v1.5
    iJAP                  : array[TOrdreJetonTirage] of Integer;
    ScoreSupEgalMoitieTop : Boolean; // v1.5
    NumeroJoker           : TJoker;
    NumeroJokerTire       : array [TOrdreJoker] of Boolean;
    d                     : TDirection;
    TopChrono             : TDateTime; // v1.6
    stTirage,
    stSolution, // Pour détecter le doublon de solution à 1 jeton (Solution enregistrée)
    // v1.5 (3 strings ci-dessous) pour test de record NivDiff
    stLibAlt,
    stURLBmp,
    stLibelle             : String;
    stDrnMot1J,                                                  // v1.4.3 : Nouvelle façon de stocker les solutions à 1 jeton.
    stDrnSol1J            : array [TLettreJetonPlace] of String; // v1.4.3 : Nouvelle façon de stocker les solutions à 1 jeton.
  //-------------------------------------------------------------------------
  function Etape3Tour1 : Boolean; // Retourne faux si hors limite. Cas Tour=1
  begin
  Result:=((d=dVerticale) and (x=XCentre) and (y<=YCentre) and (y>=YCentre-NbJetonsTirage+1)) or
          ((d=dHorizontale) and (y=YCentre) and (x<=xCentre) and (x>=XCentre-NbJetonsTirage+1));
  if not Result then Exit;
  // On calcule le NbMin et le NbMaxJetonsAPlacer
  NbMaxJetonsAPlacer:=NbJetonsTirage;
  if x=XCentre then
    NbMinJetonsAPlacer:=Max(2,1+XCentre-x)
  else // cas y=YCentre
    NbMinJetonsAPlacer:=Max(2,1+YCentre-y)
  end{Etape3Tour1};
  //-------------------------------------------------------------------------
  function Etape3 : Boolean; // Retourne faux si hors limite. Cas Tour>1
  var NbJetonsPlaces : Integer;
    //-------------------------------------------------------------------------
    function ExisteCaseDevant : Boolean;
    begin
    Result:=CoordonneesValides(x+NbMinJetonsAPlacer*dx[d],
                               y+NbMinJetonsAPlacer*dy[d])
    end;
    //-------------------------------------------------------------------------
    function AucunJetonLateral : Boolean;
    begin // Pas de jeton...
    Result:=(not CoordonneesValides(x+(NbMinJetonsAPlacer-1)*dx[d]+dxBabord[d],
                                    y+(NbMinJetonsAPlacer-1)*dy[d]+dyBabord[d]) or
             (c[x+(NbMinJetonsAPlacer-1)*dx[d]+dxBabord[d],
                y+(NbMinJetonsAPlacer-1)*dy[d]+dyBabord[d]]=0)) and // Ni à babord...
            (not CoordonneesValides(x+(NbMinJetonsAPlacer-1)*dx[d]+dxTribord[d],
                                    y+(NbMinJetonsAPlacer-1)*dy[d]+dyTribord[d]) or
             (c[x+(NbMinJetonsAPlacer-1)*dx[d]+dxTribord[d],
                y+(NbMinJetonsAPlacer-1)*dy[d]+dyTribord[d]]=0)) // Ni à tribord.
    end;
    //-------------------------------------------------------------------------
    function CaseDevantVide : Boolean;
    begin
    Result:=(c[x+NbMinJetonsAPlacer*dx[d],
               y+NbMinJetonsAPlacer*dy[d]]=0)
    end;
    //-------------------------------------------------------------------------
  begin
  Result:=True;
  NbMinJetonsAPlacer:=1;
  if not CoordonneesValides(x-dx[d], y-dy[d]) or // Si pas de jeton
     (c[x-dx[d], y-dy[d]]=0) then                // juste derrière ALORS...
    begin // On cherche devant la case départ...
    while ExisteCaseDevant and
          CaseDevantVide and // il n'y a pas de jeton contigu de part et d'autre
          AucunJetonLateral do
      Inc(NbMinJetonsAPlacer); // Il faut continuer à trouver un jeton contigu...
    if (not ExisteCaseDevant and AucunJetonLateral) or // On a un mur devant ET on n'a aucun jeton latéral
       (NbMinJetonsAPlacer>NbJetonsTirage) then // OU ALORS, on a pas assez de jetons pour toucher un jeton placé ALORS...
      begin // On quitte (pas bon)
      Result:=False;
      Exit
      end{if²}
    end{if};
  NbMaxJetonsAPlacer:=NbMinJetonsAPlacer;
  NbJetonsPlaces:=0;
  while (NbMaxJetonsAPlacer<=NbJetonsTirage) and
        CoordonneesValides(x+(NbMaxJetonsAPlacer+NbJetonsPlaces)*dx[d],
                           y+(NbMaxJetonsAPlacer+NbJetonsPlaces)*dy[d]) do
    if c[x+(NbMaxJetonsAPlacer+NbJetonsPlaces)*dx[d],
         y+(NbMaxJetonsAPlacer+NbJetonsPlaces)*dy[d]]>0 then
      Inc(NbJetonsPlaces)
    else
      Inc(NbMaxJetonsAPlacer);
  NbMaxJetonsAPlacer:=Min(NbMaxJetonsAPlacer, NbJetonsTirage);
  end{function};
  //-------------------------------------------------------------------------
  procedure Etape7; // On a le tirage : on peut chercher les mots. Si trop de lettres, retourne False
  var i, j, k,
      NbJetonsPlacesPasses, // Sert à l'affectation de Chevalet[] !
      iTirageRecherche,
      NbJetonsPlaces,
      NbJetonsPlacesApres,
      Taille,
      ScoreSol : Integer;
      stTirageComplet,
      stTirageCompletTrie,
      stAnagramme,
      stAnagrammeAJ, // v1.4.1 : AJ=Avec Joker (en minuscule)
      stDrnMot : String; // v1.4.3
      iJetonPlace : array [TPositionRelative] of Integer; // Ordre dans le mot du jeton placé obligatoire
      stLettrePlacee : array [TPositionRelative] of Char; // Lettre placée dans le mot obligatoire
      Anagrammes : TAnagrammes;
      MotOk : Boolean;
      JetonChoisi : array[TOrdreJetonTirage] of Boolean;
      OrdreJetonChoisiPositionMot : array [TPositionMot] of TNumeroJetonTirage; // v1.4.1
      ChoixPossiblesPositionMot : array [TPositionMot] of TChoixLettreJoker; // v1.4.1
      ActionChoixLettreJoker : array [TPositionMot] of TActionChoixLettreJoker; // v1.4.1
      DrnPositionAPlacer : Integer; // v1.4.1
      Chevalet : TChevalet;
      PositionDebutMot : TPositionRelative;
    //-------------------------------------------------------------------------
    function ChoixJetonsAPlacer : Boolean; // v1.4.1. Retourne vrai s'il on a trouvé encore une possibilité de choisir et fait le choix (place les jetons sur le chevalet et choisit entre jokers et lettres)
      //-----------------------------------------------------------------------
      procedure AffecteJetonTiragePositionMot(PositionMot : TPositionMot; NbJetonsPlacesPasses : Integer); // v1.4.2 : NbJetonsPlacesPasses passé en paramètre
      var OrdreJeton : TOrdreJetonTirage;
      begin
      OrdreJeton:=OrdreJetonChoisiPositionMot[PositionMot];
      if TypeJeton[t[OrdreJeton]]=tjJoker then
        stAnagrammeAJ[PositionMot]:=AnsiLowerCase(stAnagramme)[PositionMot] // vKA : Utilisation de la version Ansi pour traiter les lettres accentuées (jetons à lettres doubles)
      else
        stAnagrammeAJ[PositionMot]:=AnsiUpperCase(stAnagramme)[PositionMot]; // vKA : Utilisation de la version Ansi pour traiter les lettres accentuées (jetons à lettres doubles)
      Chevalet[PositionMot-NbJetonsPlacesPasses]:=t[OrdreJeton];
      JetonChoisi[OrdreJeton]:=True;
      end;
      //-----------------------------------------------------------------------
      procedure RetireChoixJetonPossible(PositionMot : TPositionMot);
      var OrdreJeton : TOrdreJetonTirage;
      begin
      OrdreJeton:=OrdreJetonChoisiPositionMot[PositionMot];
      if TypeJeton[t[OrdreJeton]]=tjJoker then
        ChoixPossiblesPositionMot[PositionMot]:=TChoixLettreJoker(Ord(ChoixPossiblesPositionMot[PositionMot]) xor Ord(cljJoker))
      else
        ChoixPossiblesPositionMot[PositionMot]:=TChoixLettreJoker(Ord(ChoixPossiblesPositionMot[PositionMot]) xor Ord(cljLettre));
      end;
      //-----------------------------------------------------------------------
      function ChoixJetonPossible(OrdreJeton : TOrdreJetonTirage; PositionMot : TPositionMot) : Boolean;
      begin
      if TypeJeton[t[OrdreJeton]]=tjJoker then
        Result:=((Ord(ChoixPossiblesPositionMot[PositionMot]) and Ord(cljJoker))>0) // v1.4.2
      else
        Result:=((Ord(ChoixPossiblesPositionMot[PositionMot]) and Ord(cljLettre))>0); // v1.4.2
      end;
      //-----------------------------------------------------------------------
      function ChangeChoixLettreJoker(PositionMot : TPositionMot) : Boolean; // Retourne Faux si plus de choix
      var j, k,
          NbJetonsPlacesPasses : Integer; // v1.4.2 : Pour ne pas écraser celui de l'appelant (Etape7)
      begin
      Result:=True; // Optimiste
      ActionChoixLettreJoker[PositionMot]:=acChercherSuivant;
      JetonChoisi[OrdreJetonChoisiPositionMot[PositionMot]]:=False;

      for k:=PositionMot+1 to Taille do
        if ActionChoixLettreJoker[k]<>acIgnorer then
          begin
          ChoixPossiblesPositionMot[k]:=cljLettreEtJoker;
          ActionChoixLettreJoker[k]:=acChercher;
          JetonChoisi[OrdreJetonChoisiPositionMot[k]]:=False;
          OrdreJetonChoisiPositionMot[k]:=0
          end;

      NbJetonsPlacesPasses:=0; // v1.4.2
      for k:=Low(TPositionMot) to PositionMot-1 do // v1.4.2
        if ActionChoixLettreJoker[k]=acIgnorer then
          Inc(NbJetonsPlacesPasses);

      for k:=PositionMot to Taille do
        if ActionChoixLettreJoker[k]<>acIgnorer then
          begin
          if (ActionChoixLettreJoker[k]=acChercherSuivant) and
             (OrdreJetonChoisiPositionMot[k]>0) then
            RetireChoixJetonPossible(k); // On enregistre le dernier choix pour ne pas le choisir à nouveau
          for j:=1+OrdreJetonChoisiPositionMot[k] to High(TOrdreJetonTirage) do
            if not JetonChoisi[j] and
               (stAnagramme[k]=stLettre(t[j])[1]) and
               ChoixJetonPossible(j, k)  then
              begin
              OrdreJetonChoisiPositionMot[k]:=j;
              ActionChoixLettreJoker[k]:=acResterDessus;
              AffecteJetonTiragePositionMot(k, NbJetonsPlacesPasses); // v1.4.2 : NbJetonsPlacesPasses passé en paramètre
              Break;
              end;
          if ActionChoixLettreJoker[k]<>acResterDessus then
            if k=PositionMot then
              begin // On trouve plus de choix : on recherche sur la lettre précédente du mot (récursivement)
              repeat
                Dec(PositionMot);
              until (PositionMot<Low(TPositionMot)) or
                    (ActionChoixLettreJoker[PositionMot]<>acIgnorer);
              if PositionMot>=Low(TPositionMot) then
                Result:=ChangeChoixLettreJoker(PositionMot)
              else
                Result:=False;
              break;
              end
            else // Anomalie car on doit trouver le premier choix
              begin
              Result:=False;
              Break;
              end{else}
          end{if ActionChoix<>Ignorer}
        else
          Inc(NbJetonsPlacesPasses); // Sert à l'affectation de Chevalet[] !
      end;
      //-----------------------------------------------------------------------
      function ChercheChoix(PositionMot : TPositionMot) : Boolean; // Retourne Faux si plus de choix
      var OrdreJeton : TOrdreJetonTirage;
      begin
      Result:=False; // Pessimiste
      for OrdreJeton:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
        if not JetonChoisi[OrdreJeton] and
           (stAnagramme[PositionMot]=stLettre(t[OrdreJeton])[1]) and
           ChoixJetonPossible(OrdreJeton, PositionMot)  then
          begin
          OrdreJetonChoisiPositionMot[PositionMot]:=OrdreJeton;
          AffecteJetonTiragePositionMot(PositionMot, NbJetonsPlacesPasses); // v1.4.2 : NbJetonsPlacesPasses passé en paramètre
          ActionChoixLettreJoker[PositionMot]:=acResterDessus;
          Result:=True;
          Break;
          end;
      if not Result then // Pas trouvé de choix, on passe au choix suivant
        begin
        repeat
          Dec(PositionMot);
        until (PositionMot<Low(TPositionMot)) or
              (ActionChoixLettreJoker[PositionMot]<>acIgnorer);
        if PositionMot>Low(TPositionMot) then
          Result:=ChangeChoixLettreJoker(PositionMot)
        end
      end;
      //-----------------------------------------------------------------------
      function ChercheChoixSuivant(PositionMot : TPositionMot) : Boolean; // Retourne Faux si plus de choix
      var OrdreJeton : TOrdreJetonTirage;
      begin
      Result:=False; // Pessimiste
      if OrdreJetonChoisiPositionMot[PositionMot]>0 then // On enregistre le dernier choix pour ne pas le choisir à nouveau
        RetireChoixJetonPossible(PositionMot);
      for OrdreJeton:=1+OrdreJetonChoisiPositionMot[PositionMot] to High(TOrdreJetonTirage) do
        if not JetonChoisi[OrdreJeton] and
           (stAnagramme[PositionMot]=stLettre(t[OrdreJeton])[1]) and
           ChoixJetonPossible(OrdreJeton, PositionMot)  then
          begin
          OrdreJetonChoisiPositionMot[PositionMot]:=OrdreJeton;
          AffecteJetonTiragePositionMot(PositionMot, NbJetonsPlacesPasses); // v1.4.2 : NbJetonsPlacesPasses passé en paramètre
          ActionChoixLettreJoker[PositionMot]:=acResterDessus;
          Result:=True;
          Break;
          end;
      if not Result then // Pas trouvé de choix, on passe au choix suivant
        begin
        repeat
          Dec(PositionMot);
        until (PositionMot<Low(TPositionMot)) or
              (ActionChoixLettreJoker[PositionMot]<>acIgnorer);
        if PositionMot>Low(TPositionMot) then
          Result:=ChangeChoixLettreJoker(PositionMot)
        end
      end;
      //-----------------------------------------------------------------------
      function EstJetonAPlacer(PositionMot : TPositionMot) : Boolean;
      var i : Integer;
      begin
      i:=0;
      while (i<NbJetonsPlaces) and
            (PositionMot<>iJetonPlace[i+PositionDebutMot+1]-PositionDebutMot-1) do
        Inc(i);
      Result:=(i>=NbJetonsPlaces); // c'est un jeton à placer
      end;
      //-----------------------------------------------------------------------
    var i : Integer; // v1.4.1
    begin  // function ChoixJetonsAPlacer
    if (Nbjokers=0) and (DrnPositionAPlacer>0) then // Court-circuit si pas de jokers (deuxième appel de ChoixJetonAPlacer)
      begin
      Result:=False;
      Exit
      end;
    Result:=True; // Optimiste
    // 1. Initialisation
    for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
      Chevalet[i]:=0;
    for i:=Low(TOrdreJetonTirage) to High(TOrdreJetonTirage) do
      JetonChoisi[i]:=False;
    DrnPositionAPlacer:=1; // v1.4.1
    // 2. On met les jetons à placer dans l'ordre
    NbJetonsPlacesPasses:=0; // Sert à l'affectation de Chevalet[] !
    stAnagrammeAJ:=stAnagramme; // v1.4.1
    for i:=1 to Taille do
      begin
      if EstJetonAPlacer(i) then // c'est un jeton à placer
        begin
        if i>DrnPositionAPlacer then DrnPositionAPlacer:=i; // v1.4.1
        case ActionChoixLettreJoker[i] of
          acChercher:        if not ChercheChoix(i) then
                               begin
                               Result:=False;
                               Break;
                               end;
          acChercherSuivant: if not ChercheChoixSuivant(i) then
                               begin
                               Result:=False;
                               Break;
                               end;
          acResterDessus:    begin end; // Rien à faire
        end{case of};
        AffecteJetonTiragePositionMot(i, NbJetonsPlacesPasses); // v1.4.2 : NbJetonsPlacesPasses passé en paramètre
        end
      else
        begin
        ActionChoixLettreJoker[i]:=acIgnorer;
        Inc(NbJetonsPlacesPasses);
        end;
      end{for i};
    if Result then // Permet de chercher le choix suivant au prochain appel de ChoixJetonsAPlacer
      ActionChoixLettreJoker[DrnPositionAPlacer]:=acChercherSuivant
    end;
    //-------------------------------------------------------------------------
  begin  // procedure Etape7
  // On prend les lettres choisies à placer
  stTirageComplet:=stTirage[iJAP[1]];
  for i:=2 to NbJetonsAPlacer do
    stTirageComplet:=stTirageComplet+stTirage[iJAP[i]];
  Journalise(SansSautDeLigne, Format('      %s', [stLettresDoubles(stTirageComplet)])); // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)  
  // On y ajoute les lettres posées en avant...
  NbJetonsPlacesApres:=0;
  for i:=1 to NbJetonsAPlacer do
    while CoordonneesValides(x+(i+NbJetonsPlacesApres)*dx[d],
                             y+(i+NbJetonsPlacesApres)*dy[d]) and
          (c[x+(i+NbJetonsPlacesApres)*dx[d],
             y+(i+NbJetonsPlacesApres)*dy[d]]>0) do
      begin
      if NbJetonsPlacesApres=0 then Journalise(SansSautDeLigne, '<'); // v1.4.7 : On inverse < et > car prête à confusion.
      iJetonPlace[NbJetonsPlacesApres]:=1+i+NbJetonsPlacesApres;
      stLettrePlacee[NbJetonsPlacesApres]:=stLettre(c[x+(i+NbJetonsPlacesApres)*dx[d],
                                                      y+(i+NbJetonsPlacesApres)*dy[d]])[1];
      Journalise(SansSautDeLigne, Format('%s', [stLettresDoubles(stLettrePlacee[NbJetonsPlacesApres])]));  // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
      stTirageComplet:=stTirageComplet+stLettrePlacee[NbJetonsPlacesApres];
      Inc(NbJetonsPlacesApres)
      end;
  // On y ajoute les lettres posées en arrière...
  PositionDebutMot:=-1;
  while CoordonneesValides(x+PositionDebutMot*dx[d],
                           y+PositionDebutMot*dy[d]) and
          (c[x+PositionDebutMot*dx[d],
             y+PositionDebutMot*dy[d]]>0) do
    begin
    if PositionDebutMot=-1 then Journalise(SansSautDeLigne, '>'); // v1.4.7 : On inverse < et > car prête à confusion.
    iJetonPlace[PositionDebutMot]:=1+PositionDebutMot;
    stLettrePlacee[PositionDebutMot]:=stLettre(c[x+PositionDebutMot*dx[d],
                                                 y+PositionDebutMot*dy[d]])[1];
    Journalise(SansSautDeLigne, Format('%s', [stLettresDoubles(stLettrePlacee[PositionDebutMot])])); // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
    stTirageComplet:=stTirageComplet+stLettrePlacee[PositionDebutMot];
    Dec(PositionDebutMot)
    end;
  NbJetonsPlaces:=NbJetonsPlacesApres-PositionDebutMot-1;
  // On trie
  stTirageCompletTrie:=stTirageTrie(stTirageComplet);
  Journalise(AvecSautDeLigne, Format('=>%s', [stLettresDoubles(stTirageCompletTrie)])); // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
  // On cherche les anagrammes
  Taille:=Length(stTirageCompletTrie);
  if Taille>=Low(TNbLettres) then
    begin
    iTirageRecherche:=Dico.Rech.Tirages[Taille].IndexOf(stTirageCompletTrie);
    if iTirageRecherche>-1 then
      begin // On a trouvé des mots...
      Anagrammes:=(Dico.Rech.Tirages[Taille].Objects[iTirageRecherche] as TAnagrammes);
      for j:=0 to Anagrammes.NbAnagrammes-1 do
        begin
        stAnagramme:=Dico.stMotDico(Taille, Anagrammes.iDico[j]);
        Journalise(SansSautDeLigne, Format('        %s: ', [stLettresDoubles(stAnagramme)])); // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
        k:=0;
        while (k<NbJetonsPlaces) and
              (stAnagramme[iJetonPlace[k+PositionDebutMot+1]-PositionDebutMot-1]=stLettrePlacee[k+PositionDebutMot+1]) do
          Inc(k);
        MotOk:=(k=NbJetonsPlaces);
        if MotOk then
          begin
          Journalise(AvecSautDeLigne, 'OK');
          // On construit le chevalet dans l'ordre des jetons à placer

          // Initialisation des marqueurs de derniers jetons utilisés
          DrnPositionAPlacer:=0; // v1.4.1 : Pour Détecter le premier appel de ChoixJetonAPlacer et court-circuiter le deuxième appel de ChoixJetonsAPlacer si pas de jokers
          for i:=Low(TPositionMot) to High(TPositionMot) do
            begin
            OrdreJetonChoisiPositionMot[i]:=0;
            if i>Taille then
              begin
              ChoixPossiblesPositionMot[i]:=cljAucun;
              ActionChoixLettreJoker[i]:=acIgnorer;
              end
            else
              begin
              ChoixPossiblesPositionMot[i]:=cljLettreEtJoker;
              ActionChoixLettreJoker[i]:=acChercher;
              end
            end;

          While ChoixJetonsAPlacer do // v1.4.1 : le choix des jetons à placer a été déplacé dans la fonction ChoixJetonsAPlacer qui retourne s'il y a encore un choix possible (gestion des choix jokers/lettre)
            begin
            Journalise(SansSautDeLigne, '          '+stLettresDoubles(stAnagrammeAJ)); // v1.4.1. vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
            // 3. On teste les autres mots de la pose
            if MotsFormesValables(x, y, d, Chevalet, Low(TOrdreJetonChevalet), NbJetonsAPlacer, tpRecherche) then // v1.4 : tpRecherche
              begin
              ScoreSol:=ScorePose(x, y, d, Chevalet, Low(TOrdreJetonChevalet), NbJetonsAPlacer);
              // On teste si l'on a pas déjà pris en compte la solution (cas du même jeton posé sur la même case)
              if (NbJetonsAPlacer=1) then
                if d=dVerticale then // v1.4.3 : Nouvelle façon de tester les doublons de solutions à 1 jeton placé : on teste la solution verticale à la solution horizontale stockée
                  begin
                  stDrnMot:=stDrnMot1J[stLettreAJ(Chevalet[1])[1]]; // v1.4.3 : on va chercher le mot horizontal
                  if stDrnMot<>'' then // v1.4.3 : Nouvelle façon de tester les doublons de solutions à 1 jeton placé : on stocke le mot et la solution
                    if (Length(stAnagrammeAJ)>Length(stDrnMot)) or
                       ((Length(stAnagrammeAJ)=Length(stDrnMot)) and
                        (stAnagrammeAJ<stDrnMot)) then // v1.4.1 +AJ
                      begin
                      Journalise(SansSautDeLigne, ' => POSE VALIDE mais solution horizontale déjà prise en compte (on prend finalement CETTE solution).');
                      // 1. On supprime l'AUTRE solution le cas échéant
                      iDrnSol1J:=slSolutions.IndexOf(stDrnSol1J[stLettreAJ(Chevalet[1])[1]]);
                      if iDrnSol1J>-1 then
                        begin
                        // 1a. On détruit l'objet TSolution liée
                        (slSolutions.Objects[iDrnSol1J] as TSolution).Detruit;
                        // 1b. On détruit l'entrée de la solution dans la liste
                        slSolutions.Delete(iDrnSol1J);
                        // 1c. On décrémente les compteurs
                        Dec(NbSol[Tour]);
                        if Score[Tour]<ScoreSol then // Même score que le doublon (ouf)
                          Dec(PosPrp[Tour]);
                        end
                      // 2. Et on laisse prendre la solution courante
                      end
                    else
                      begin
                      Journalise(AvecSautDeLigne, ' => POSE VALIDE mais solution horizontale déjà prise en compte (on prend finalement L''AUTRE solution).');
                      Continue // On poursuit la recherche (on a déjà la solution enregistrée)
                      end
                  end{if dVerticale} // v1.4.3
                else // v1.4.3 : d=dVerticale
                  begin // v1.4.3 : Solution stockée en fonction du type de jeton posé (pour joker, on ne prend que le premier cas)
                  stDrnMot1J[stLettreAJ(Chevalet[1])[1]]:=stAnagrammeAJ; // v1.4.1 +AJ
                  stDrnSol1J[stLettreAJ(Chevalet[1])[1]]:=Format(stFrmSolution, // vKA. Affichage des lettres doubles : ajout de stLettresDoubles(...)
                                                                 [stLettresDoubles(stAnagrammeAJ), stDirection[d], stCoordonnees(x, y, d)]); // v1.4.1 +AJ
                  end;
              Journalise(AvecSautDeLigne, Format(' => POSE VALIDE rapportant %d points !', [ScoreSol]));
              // Statistiques Proposition/Solution
              Inc(NbSol[Tour]);
              // v1.5 : Condition "if StockageSolutions then" retirée car besoin de connaître le nombre de sol >= 50%top pour évaluer la difficulté du tirage affichée sur la feuille de match détaillée // v1.3.6
              slSolutionsTriees.AddObject(stSolutionTriee(stAnagrammeAJ, x, y, d, Chevalet, Low(TOrdreJetonChevalet), NbJetonsAPlacer), // v1.4.1 (stAnagrammeAJ)
                                          TSolution.Cree(stAnagramme, x, y, d, Chevalet, Low(TOrdreJetonChevalet), NbJetonsAPlacer, NumeroJoker, LettreJoker)); // v1.5.5 (Add+Object)
              if Score[Tour]<ScoreSol then
                Inc(PosPrp[Tour]);
              if ScoreSol>=ScoreTop[Tour] then
                begin
                stSolution:=Format(stFrmSolution, // vKA. Affichage des lettres doubles : ajout de stLettresDoubles(...)
                                   [stLettresDoubles(stAnagrammeAJ), stDirection[d], stCoordonnees(x, y, d)]); // v1.4.1 +AJ
                if ScoreTop[Tour]<ScoreSol then
                  begin
                  if FormParamPose.TypeQualitePose=tqpTops then // v1.5.5 : paramètre type qualité liste solutions choix pose
                    begin
                    ScoreSolPose:=ScoreSol; // v1.5.5
                    slSolutions.Clear
                    end;
                  ScoreTop[Tour]:=ScoreSol;
                  if ScoreTop[Tour]>ScoreMax then ScoreMax:=ScoreTop[Tour];
                  end;
                if (FormParamPose.TypeQualitePose=tqpTops) and // v1.5.5 : paramètre type qualité liste solutions choix pose
                   (slSolutions.IndexOf(stSolution)=-1) then
                  slSolutions.AddObject(stSolution,
                                        TSolution.Cree(stAnagramme, x, y, d, Chevalet, Low(TOrdreJetonChevalet), NbJetonsAPlacer, NumeroJoker, LettreJoker));
                end{if ScoreSol>=ScoreTop}
              end{if MotsFormesValables}
            else
              Journalise(AvecSautDeLigne, ' => Autres mots formés non valables.')
            end{while Choix}
          end{if MotOk}
        else
          Journalise(AvecSautDeLigne, '')
        end{for j}
      end{if iTirageRecherche} // v1.4.1
    end{if Taille}
  end{procedure Etape7};
  //-------------------------------------------------------------------------
  function Etape6 : Boolean; // On a la case, les jetons à placer alors on cherche les mots
  var i, i1, i2 : Integer; // vKA : i1, i2 à la place de Lettre1 et Lettre2
      // NbJokers : Integer; /!\ déclaré dans Cherche car utilisé par Etape7 pour déterminer le meilleur coup
      iJoker : array [TOrdreJoker] of TNumeroJetonTirage;
  begin // On a les jetons à placer (6)
  Result:=True; // Optimiste
  Journalise(SansSautDeLigne, '    ');
  NbJokers:=0;
  for i:=Low(TOrdreJoker) to Min(NbJetonsAPlacer, High(TOrdreJoker)) do // Si triés les jokers sont en tête du tirage trié
    begin
    if stTirage[iJAP[i]]=stLettreJeton[tjJoker] then
      begin
      Inc(NbJokers);
      iJoker[NbJokers]:=iJAP[i];
      Journalise(SansSautDeLigne, '*');
      end;
    Journalise(SansSautDeLigne, Format('%d,', [iJAP[i]]))
    end;
  for i:=High(TOrdreJoker)+1 to NbJetonsAPlacer do
    Journalise(SansSautDeLigne, Format('%d,', [iJAP[i]]));
  Journalise(AvecSautDeLigne, '');
  if NbJokers>0 then
    for i1:=Ord(tjA) to Ord(tjZ) do // vKA : on parcourt les 29 lettres (et non plus de 'A' à 'Z')
      begin
      stTirage[iJoker[1]]:=stLettreJeton[TTypeJeton(i1)][1]; // vKA : on parcourt les 29 lettres (et non plus de 'A' à 'Z')
      LettreJoker[NumeroJoker[1]]:=TTypeJeton(i1); // vKA : ordre (i1) au lieu du caractère (Lettre1)
      if NbJokers>1 then
        for i2:=Ord(tjA) to Ord(tjZ) do // vKA : on parcourt les 29 lettres (et non plus de 'A' à 'Z')
          begin
          stTirage[iJoker[2]]:=stLettreJeton[TTypeJeton(i2)][1]; // vKA : on parcourt les 29 lettres (et non plus de 'A' à 'Z')
          LettreJoker[NumeroJoker[2]]:=TTypeJeton(i2); // vKA : ordre (i2) au lieu du caractère (Lettre2)
          Etape7;
          end
      else
        Etape7;
      end{for i1}
  else
    Etape7;
  // On remet les jokers en place...
  for i:=1 to NbJokers do
    begin
    stTirage[iJoker[i]]:=stLettreJeton[tjJoker,1];
    LettreJoker[NumeroJoker[i]]:=tjJoker;
    end;
  end{procedure Etape6};
  //--------------------------------------------------------------------------
  procedure AjouteSolution(const stSol : String; const Sol : TSolution); // v1.5.5
  var stSolution : String;
  begin
  stSolution:=Format(stFrmSolution, [Copy(stLettresDoubles(stSol), PosSolution, Length(stSol)-PosSolution+1), // vKA. Affichage des lettres doubles : ajout de stLettresDoubles(...)
                                     stDirection[Sol.d], stCoordonnees(Sol.x, Sol.y, Sol.d)]);
  slSolutions.AddObject(stSolution, Sol)
  end;
begin
(*
Etapes de recherche des solutions
1. Case départ vide parmi toutes les vides (sauf premier tour)
2. Direction (horizontale ou verticale)
3. Détermination du nombre minimum et maximum de jetons plaçables
4. Choix du nombre de jeton à placer parmi le min et le max
5. Choix des jetons à placer
6. Choix des lettres pour le(s) joker(s)
7. Tri => Recherche anagrammes avec lettres posées si correspondances valables
8. Mots transverses valables
*)
TopChrono:=Now;
slSolutionsTriees.Clear; // v1.3.6
NbSol[Tour]:=0;
PosPrp[Tour]:=1;
stTirage:=stTirageTrie(Self.stTirage[Tour]);
// On élimine les places vides en fin de jeu pour ne pas les confondre avec des jokers
NbJetonsAbsents:=0;
ii:=High(TOrdreJetonTirage);
while t[ii]=0 do
  begin
  Inc(NbJetonsAbsents);
  Dec(ii)
  end;
stTirage:=Copy(stTirage, 1+NbJetonsAbsents, Length(stTirage)-NbJetonsAbsents);
// On repère les numéros des jokers
NbJetonsTirage:=Length(stTirage);
for ii:=Low(TOrdreJoker) to High(TOrdreJoker) do
  begin
  NumeroJokerTire[ii]:=False;
  NumeroJoker[ii]:=0
  end;
for ii:=1 to NbJetonsTirage do
  if TypeJeton[t[ii]]=tjJoker then
    NumeroJokerTire[t[ii]]:=True;
if NumeroJokerTire[1] then
  begin
  NumeroJoker[1]:=1;
  if NumeroJokerTire[2] then
    NumeroJoker[2]:=2
  end
else
  if NumeroJokerTire[2] then
    NumeroJoker[1]:=2;
// Début de la recherche
Journalise(AvecSautDeLigne, '--------------------------------------------------------------------------------');
Journalise(AvecSautDeLigne, Format('%s=>%s', [stLettresDoubles(Self.stTirage[Tour]), stLettresDoubles(stTirage)])); // vKA : affichage des lettres doubles (ajout de stLettresDoubles(...)
ScoreTop[Tour]:=0;
FormPatience:=TFormPatience.Create(Nil);
try
  with FormPatience do
    begin
    Panel.Caption:='Recherche des solutions en cours. Veuillez patienter SVP...';
    Gauge.MinValue:=0;
    Gauge.MaxValue:=NbLettresMaxMot*NbLettresMaxMot;
    Gauge.Progress:=0;
    Show
    end;
  for x:=Low(TCoordonnee) to High(TCoordonnee) do
    for y:=Low(TCoordonnee) to High(TCoordonnee) do
      begin
      Journalise(AvecSautDeLigne, Format('%s: %s',
                              [stCoordonnees(x, y),
                               stLibreOccupee[Ord(c[x, y]=0)]]));
      if c[x, y]=0 then // Aucun jeton en (x,y) (Etape 1)
        begin // v1.4.3 (ajout begin/end)
        for ii:=Ord(Low(TLettreJetonPlace)) to Ord(High(TLettreJetonPlace)) do // v1.4.3
          begin // On initialise les solutions à 1 jeton placé
          stDrnMot1J[TLettreJetonPlace(ii)]:='';
          stDrnSol1J[TLettreJetonPlace(ii)]:=''
          end;
        for d:=dHorizontale to dVerticale do // Direction (Etape 2)
          if ((Tour=1) and Etape3Tour1) or // Tour 1 spécial (pas de jetons contigus
             Etape3 then // Détermine nombre min & max de jetons à placer
            begin
            Journalise(AvecSautDeLigne, Format('  %s: Pose possible (%d~%d jetons)',
                                    [stDirection[d],
                                     NbMinJetonsAPlacer,
                                     NbMaxJetonsAPlacer]));
            for NbJetonsAPlacer:=NbMinJetonsAPlacer to NbMaxJetonsAPlacer do // NbJetonsAPlacer (Etape 4)
              begin
              for i1:=Low(TOrdreJetonTirage) to NbJetonsTirage-NbJetonsAPlacer+1 do // i1~i6 = Etape 5
                if (i1=Low(TOrdreJetonTirage)) or (stTirage[i1]<>stTirage[i1-1]) then
                  begin
                  iJAP[1]:=i1;
                  if NbJetonsAPlacer=1 then
                    Etape6
                  else
                    for i2:=i1+1 to NbJetonsTirage-NbJetonsAPlacer+2 do
                      if (i2=i1+1) or (stTirage[i2]<>stTirage[i2-1]) then
                        begin
                        iJAP[2]:=i2;
                        if NbJetonsAPlacer=2 then
                          Etape6
                        else
                          for i3:=i2+1 to NbJetonsTirage-NbJetonsAPlacer+3 do
                            if (i3=i2+1) or (stTirage[i3]<>stTirage[i3-1]) then
                              begin
                              iJAP[3]:=i3;
                              if NbJetonsAPlacer=3 then
                                Etape6
                              else
                                for i4:=i3+1 to NbJetonsTirage-NbJetonsAPlacer+4 do
                                  if (i4=i3+1) or (stTirage[i4]<>stTirage[i4-1]) then
                                    begin
                                    iJAP[4]:=i4;
                                    if NbJetonsAPlacer=4 then
                                      Etape6
                                    else
                                      for i5:=i4+1 to NbJetonsTirage-NbJetonsAPlacer+5 do
                                        if (i5=i4+1) or (stTirage[i5]<>stTirage[i5-1]) then
                                          begin
                                          iJAP[5]:=i5;
                                          if NbJetonsAPlacer=5 then
                                            Etape6
                                          else
                                            for i6:=i5+1 to NbJetonsTirage-NbJetonsAPlacer+6 do
                                              if (i6=i5+1) or (stTirage[i6]<>stTirage[i6-1]) then
                                                begin
                                                iJAP[6]:=i6;
                                                if NbJetonsAPlacer=6 then
                                                  Etape6
                                                else
                                                  for i7:=i6+1 to NbJetonsTirage-NbJetonsAPlacer+7 do
                                                    if (i7=i6+1) or (stTirage[i7]<>stTirage[i7-1]) then
                                                    begin
                                                    iJAP[7]:=i7;
                                                    Etape6
                                                    end
                                                end
                                          end
                                    end
                              end
                        end
                  end
              end
            end
        end; // v1.4.3 (ajout begin/end)
      with FormPatience do
        begin
        Gauge.Progress:=Gauge.Progress+1;
        Repaint
        end
      end;

  // v1.5.5 : On traite ici la liste des solution pour le choix de la pose (s'il ne s'agit pas de la liste des tops)
  case FormParamPose.TypeQualitePose of
    tqpRapportScoreTop: begin
                        ScoreQualitePose:=Round((FormParamPose.QualitePose*ScoreTop[Tour])/100.0);
                        DiffScore:=High(Integer);
                        for ii:=0 to slSolutionsTriees.Count-1 do
                          begin
                          ScoreCrt:=ComplementScore-StrToInt(Copy(slSolutionsTriees[ii], 1, 4));
                          if (ScoreCrt>=ScoreQualitePose) and (ScoreCrt-ScoreQualitePose<=DiffScore) then
                            begin
                            if (ScoreCrt-ScoreQualitePose<DiffScore) then
                              begin
                              DiffScore:=ScoreCrt-ScoreQualitePose;
                              ScoreSolPose:=ScoreCrt;
                              slSolutions.Clear
                              end;
                            AjouteSolution(slSolutionsTriees[ii],
                                           slSolutionsTriees.Objects[ii] as TSolution)
                            end
                          end
                        end;
    tqpRangSolution:    begin
                        RangQualitePose:=(slSolutionsTriees.Count*(100-FormParamPose.QualitePose)) div 100; // On prend la partie entière
                        ScoreSolPose:=ComplementScore-StrToInt(Copy(slSolutionsTriees[RangQualitePose], 1, 4));
                        AjouteSolution(slSolutionsTriees[RangQualitePose],
                                       slSolutionsTriees.Objects[RangQualitePose] as TSolution)
                        end
  end{case of};

  // v1.6 : Calcul du temps de recherche des solutions
  TpsCalculSol[Tour]:=3600*24*(Now-TopChrono);
  CumulTpsCalculSol[Tour]:=TpsCalculSol[Tour]+IfThen(Tour>Low(Tour), CumulTpsCalculSol[Pred(Tour)], 0);

  Cumul[Tour]:=Score[Tour]+IfThen(Tour>Low(TTour), Cumul[Pred(Tour)], 0);
  CumulTop[Tour]:=ScoreTop[Tour]+IfThen(Tour>Low(TTour), CumulTop[Pred(Tour)], 0);
  CumulNbSol[Tour]:=NbSol[Tour]+IfThen(Tour>Low(TTour), CumulNbSol[Pred(Tour)], 0);
  // v1.5.1 : on pondère le niveau de difficulté moyen par ScoreTop
  // v1.5 : on évalue le nombre de solutions >= 50% du Top pour évaluer la difficulté du tirage
  ii:=0;
  NbSolSupEgalMoitieTop[Tour]:=0;
  if (VersionFichier>=$150) and // On ne calcule pas si la version du fichier < v1.5 car ça fausse la moyenne du niveau de difficulté en cours de partie
     (slSolutionsTriees.Count>0) then
    Repeat
      ScoreSupEgalMoitieTop:=(ComplementScore-StrToInt(Copy(slSolutionsTriees[ii], 1, 4))>=(ScoreTop[Tour]+1) div 2);
      Inc(NbSolSupEgalMoitieTop[Tour], Ord(ScoreSupEgalMoitieTop));
      Inc(ii);
    Until (ii=slSolutionsTriees.Count) or not ScoreSupEgalMoitieTop;
  // v1.5.1 : on pondère le niveau de difficulté par ScoreTop
  if NbSol[Tour]<>0 then
    CumulNbSolSEMoitieTop[Tour]:=(1.0*NbSolSupEgalMoitieTop[Tour]*ScoreTop[Tour])/NbSol[Tour]+
                                 IfThen(Tour>Low(TTour), CumulNbSolSEMoitieTop[Pred(Tour)], 0);

  // v1.5 : on compte le nombre de bonus 50
  NbSolBonus50[Tour]:=0;
  if (VersionFichier>=$150) then // On ne calcule pas si la version du fichier < v1.5 car ça fausse la moyenne en cours de partie
    begin
    for ii:=0 to slSolutionsTriees.Count-1 do
      Inc(NbSolBonus50[Tour], Ord(Copy(slSolutionsTriees[ii], 6, 1)=IntToStr(NbMaxJetonsTirage))); // Bonus 50 si 7 jetons placés !
    // Au premier tour, on divise le nombre par deux à cause de la symétrie diagonale : NbSolBonus50(horizontalement)=NbSolBonus50(verticalement)
    if Tour=1 then NbSolBonus50[Tour]:=NbSolBonus50[Tour] div (2*NbMaxJetonsTirage) // Il y a 14 positions pour un mot de 7 lettres au premier tour !
    end;
  CumulNbSolBonus50[Tour]:=NbSolBonus50[Tour]+IfThen(Tour>Low(TTour), CumulNbSolBonus50[Pred(Tour)], 0);

  // v1.5 : Test de records
  if not p.DemoEnCours and
     not TiragePropose[Tour] then // v1.5.3 : pas de record si tirage proposé
    begin
    // Niveau de difficulté
    NivDiff:=CalculeNiveauDifficulte(NbSolSupEgalMoitieTop[Tour], NbSol[Tour], stLibAlt, stURLBmp);
    stLibelle:=Copy(stLibAlt, 4+Pos('/10', stLibAlt), Length(stLibAlt));
    r.TesteRecord(srGenerale, nvrTour, trMax, ntrNivDiff, Tour, NivDiff, stLibelle);
    r.TesteRecord(srGenerale, nvrTour, trMin, ntrNivDiff, Tour, NivDiff, stLibelle);
    // Nb Solutions
    r.TesteRecord(srGenerale, nvrTour, trMax, ntrNbSolutions, Tour, 100*NbSol[Tour], '');
    if Nbsol[Tour]>0 then // On exclue le cas où l'on ne peut pas placer de jetons
      r.TesteRecord(srGenerale, nvrTour, trMin, ntrNbSolutions, Tour, 100*NbSol[Tour], '');
    // NbSolutions avec bonus
    r.TesteRecord(srGenerale, nvrTour, trMax, ntrNbSolBonus, Tour, 100*NbSolBonus50[Tour], '');
    // Nbsol/Rang
    if (PosPrp[Tour]>0) and // Précaution contre la division par zéro
       (PosPrp[Tour]<NbSol[Tour]) then // On ne prend pas les tours passés ou les modes démo Rang=Nbsol+1
      r.TesteRecord(srProposition, nvrTour, trMax, ntrNbSolSurRg, Tour,
                    Round((100.0*NbSol[Tour])/PosPrp[Tour]),
                    Format('%d%s sur %d', [PosPrp[Tour],
                                           stSuffixeRang[Ord(PosPrp[Tour]>1)],
                                           NbSol[Tour]]));
    // v1.6 : Test des records liés au temps de calcul des solutions
    if TpsCalculSol[Tour]>0 then
      begin
      r.TesteRecord(srGenerale, nvrTour, trMin, ntrTpsCalcSol, Tour, Round(100*TpsCalculSol[Tour]), '');
      r.TesteRecord(srGenerale, nvrTour, trMax, ntrTpsCalcSol, Tour, Round(100*TpsCalculSol[Tour]), '');
      r.TesteRecord(srGenerale, nvrTour, trMin, ntrNbSolParSec, Tour, Round(NbSol[Tour]/TpsCalculSol[Tour]), '');
      r.TesteRecord(srGenerale, nvrTour, trMax, ntrNbSolParSec, Tour, Round(NbSol[Tour]/TpsCalculSol[Tour]), '');
      end
    end;

  // v1.4.7 : On pondère dans le calcul des rangs moyens par rapport au nombre de solutions
  //CumulPosPrp[Tour]:=PosPrp[Tour]+IfThen(Tour>Low(TTour), CumulPosPrp[Pred(Tour)], 0);
  if Tour>Low(TTour) then // v1.5 : Débordement d'entier : utilisation des entiers 64 bits
    if (NbSol[Tour]>0) and (CumulNbSol[Pred(Tour)]>0) then
      CumulPosPrp[Tour]:=  ((Int64(PosPrp[Tour])*Int64(CumulNbSol[Tour])) div NbSol[Tour]+
                            (Int64(Pred(Tour))*Int64(CumulPosPrp[Pred(Tour)])*Int64(CumulNbSol[Tour])) div CumulNbSol[Pred(Tour)]) div Tour
    else
      CumulPosPrp[Tour]:=CumulPosPrp[Pred(Tour)]
  else
    CumulPosPrp[Tour]:=PosPrp[Tour];
  if NbSol[Tour]>NbMaxSol then
    NbMaxSol:=NbSol[Tour];
finally
  FormPatience.Close;
  FormPatience.Release;
end
end;
//---------------------------------------------------------------------------
procedure TPartie.ChangeTirage(var Chevalet : TChevalet);
var i : Integer;
    JetonAPrendre : TChevalet;
  function JetonsPrisTousDifferents : Boolean;
  var ii : Integer;
  begin
  ii:=Low(TOrdreJetonChevalet);
  while (ii<=i-1) and
        (JetonAPrendre[i]<>JetonAPrendre[ii]) do
    Inc(ii);
  Result:=(ii=i);
  end{JetonPrisTousDifferents};
  procedure PermuteJetons; // Permute Chevalet[i]&t[?] avec s[JetonsAPrendre[i]]
  var ii : Integer;
      JetonIntermediaire : TOrdreJetonSac;
  begin
  JetonIntermediaire:=Chevalet[i];
  Chevalet[i]:=s[JetonAPrendre[i]];
  // On change dans s l'équivalant de Chevalet[i] ancien
  ii:=Low(TOrdreJetonSac);
  while s[ii]<>JetonIntermediaire do
    Inc(ii);
  s[ii]:=s[JetonAPrendre[i]];
  ii:=Low(TOrdreJetonTirage);
  // On change dans t l'équivalent de Chevalet[i] ancien
  while t[ii]<>JetonIntermediaire do
    Inc(ii);
  t[ii]:=s[JetonAPrendre[i]];
  stTirage[Tour,ii]:=stLettre(s[JetonAPrendre[i]])[1];
  // On change dans s JetonAPrendre[i]
  s[JetonAPrendre[i]]:=JetonIntermediaire;
  end;
begin //-----------DEBUT----------------
if ProchainJetonATirer>NbJetonsSac-NbMaxJetonsTirage+1 then Exit; // On ne change que s'il reste au moins 7 jetons
// On mélange les jetons : on prend 2 jetons (1 du chevalet et 1 du sac) et on les permute
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  begin
  JetonAPrendre[i]:=0;
  if Chevalet[i]>0 then
    begin
    Repeat
      JetonAPrendre[i]:=ProchainJetonATirer+
                         Random(NbJetonsSac+1-ProchainJetonATirer);
    Until JetonsPrisTousDifferents;
    PermuteJetons // Permute Chevalet[i]&t[?] avec s[JetonsAPrendre[i]]
    end
  end;
PremierJetonTire:=Low(TOrdreJetonTirage); // On a tout changé !
if TypePartie=tpJoker then // v1.5.6
  begin
  if AjouteJokerAuTirage then // On modifie Chevalet
    for i:=High(TOrdreJetonChevalet) downto Low(TOrdreJetonChevalet) do
      if Chevalet[i]=LettreAEchanger then
        begin
        Chevalet[i]:=JokerAEchanger;
        Break
        end
  end
end;
//---------------------------------------------------------------------------
procedure TPartie.EnregistreSolution(const Solution : TSolution);
begin
xSol[Tour]:=Solution.x;
ySol[Tour]:=Solution.y;
dSol[Tour]:=Solution.d;
stSolution[Tour]:=Solution.stMot
end;
//---------------------------------------------------------------------------
procedure TPartie.EnregistreProposition(const x, y : TCoordonnee; const d : TDirection);
begin
xPrp[Tour]:=x;
yPrp[Tour]:=y;
dPrp[Tour]:=d;
end;
//---------------------------------------------------------------------------
function TPartie.stHTMLPoseStyleEtCouleurAppliques(const Tour : TTour; // v1.5.1 (factorisation+utilisation extérieure)
                                                   const Cible : TCibleStats) : string;
var i              : Integer;
    Style          : TFontStyles;
    Bonus          : TBonus;
    PoseJoker, // vKA : Permet d'afficher en couleur et non plus en minuscule (réservé aux doubles lettres)
    SubstitutJoker : Boolean; // v1.5.6
    stLettre       : String;
begin
stLettre:=' ';
Result:='';
case Cible of
  csHumain: for i:=1 to Length(stProposition[Tour]) do
              if FormFeuilleMatch.FormatLettreMotPrincipal(Tour, csHumain,
                                                           i, stLettre[1],
                                                           Style, Bonus,
                                                           PoseJoker, // vKA : Permet d'afficher en couleur et non plus en minuscule (réservé aux doubles lettres)
                                                           SubstitutJoker) then // v1.5.6 : SubstitutJoker
                Result:=Result+stHTMLStyleEtCouleurAppliques(stLettresDoubles(stLettre), // vKA : On affiche les doubles lettres : stLettreDouble(stLettre) au lieu de stLettre
                                                             IfThen(SubstitutJoker, // v1.5.6 : SubstitutJoker
                                                                    stCodeHTMLSubstitutJoker,
                                                                    IfThen(PoseJoker, // vKA : Permet d'afficher en couleur et non plus en minuscule (réservé aux doubles lettres)
                                                                           stCodeHTMLPoseJoker,
                                                                           stCodeHTMLBonus[Bonus])),
                                                             Style)
              else
                Result:=stLettresDoubles(stProposition[Tour]); // v1.7.4 : oubli stLettresDoubles et Tour à la place de i !
  csMachine:for i:=1 to Length(stSolution[Tour]) do
              if FormFeuilleMatch.FormatLettreMotPrincipal(Tour, csMachine,
                                                           i, stLettre[1],
                                                           Style, Bonus,
                                                           PoseJoker, // vKA : Permet d'afficher en couleur et non plus en minuscule (réservé aux doubles lettres)
                                                           SubstitutJoker) then // v1.5.6 : SubstitutJoker
                Result:=Result+stHTMLStyleEtCouleurAppliques(stLettresDoubles(stLettre), // vKA : On affiche les doubles lettres : stLettreDouble(stLettre) au lieu de stLettre
                                                             IfThen(SubstitutJoker, // v1.5.6 : SubstitutJoker
                                                                    stCodeHTMLSubstitutJoker,
                                                                    IfThen(PoseJoker, // vKA : Permet d'afficher en couleur et non plus en minuscule (réservé aux doubles lettres)
                                                                           stCodeHTMLPoseJoker,
                                                                           stCodeHTMLBonus[Bonus])),
                                                             Style)
              else
                Result:=stLettresDoubles(stSolution[Tour])  // v1.7.4 : oubli stLettresDoubles et Tour à la place de i !
end{case of}
end;
//---------------------------------------------------------------------------
procedure TPartie.GenereFeuilleMatchDetaillee(const stNomFichier : String; const Affichage : Boolean); // v1.3.5 (Affichage)
const stFormatDuree   = '%d:%2d'; // v1.4.9
      stCodeHTMLTemps : array [0..1]   of String = ('#00FF00', '#FF0000');
var   i, j,
      Secondes            : Integer;
      f                   : TextFile;
      FdMAffichee         : Boolean; // v1.5
      PrcScore, PrcCumul  : Double; // v1.4.7 : Pour le calcul du rang moyen
      stHTMLPrp, stHTMLSol,
      stHTMLTirage,
      stScore,
      stScorePartie, // v1.4
      stScoreTop,
      stHTMLTps,
      stHTMLCumulTps,
      stHTMLTpsMoyen,
      stLettre,
      stLibAltDiffTir,
      stLibAltDiffPrt,
      stURLBmpTir,
      stURLBmpPrt,
      stTpsCalcSol, // v1.6
      stNbSolParSec, // v1.6
      stCumulTpsCalcSol, // v1.6
      stCumulNbSolParSec  : String; // v1.6
      Style               : TFontStyles;
begin
stLettre:=' ';
AssignFile(f, stNomFichier);
FdMAffichee:=FormFeuilleMatch.Visible; // v1.5
if FdMAffichee then FormFeuilleMatch.Visible:=False; // v1.5 : pour éviter le scintillement, on cache la feuille de match !
try
  Rewrite(f);
  Write(f, Format(stFrmHTMLFdmdEnT1+stFrmHTMLFdmdEnT2, [stFormatRapport[FormatRapport]])); // v1.5 : chgt de nom de constantes et découpage
  for i:=1 to Tour-1 do
    begin
    if ScoreTop[i]=0 then
      PrcScore:=0
    else
      PrcScore:=(MaxFormatRapport[FormatRapport]*Score[i])/ScoreTop[i];
    if CumulTop[i]=0 then
      PrcCumul:=0
    else
      PrcCumul:=(MaxFormatRapport[FormatRapport]*Cumul[i])/CumulTop[i];

    // Temps
    Secondes:=Round(24*3600*Temps[i]);
    if DemoEnCours then // v1.6.3
      stHTMLTps:='-'
    else
      begin
      stHTMLTps:=Format(stFormatDuree, [Secondes div 60, Secondes mod 60]); // v1.4.9 (stFormatDuree)
      if stHTMLTps[3]=' ' then stHTMLTps[3]:='0';
      stHTMLTps:=stHTMLStyleEtCouleurAppliques(stHTMLTps, stCodeHTMLTemps[Ord(stHTMLTps>IntToStr(Ord(TempsReflexion)))], []) // v1.5.6 : Ord(TempsReflexion) à la place de MinutesReflexion
      end;
    // Temps (cumul)
    Secondes:=Round(24*3600*CumulTemps[i]);
    if DemoEnCours then // v1.6.3
      stHTMLCumulTps:='-'
    else
      begin
      stHTMLCumulTps:=Format(stFormatDuree, [Secondes div 60, Secondes mod 60]); // v1.4.9 (stFormatDuree)
      if stHTMLCumulTps[Length(stHTMLCumulTps)-1]=' ' then stHTMLCumulTps[Length(stHTMLCumulTps)-1]:='0'
      end;
    // Temps moyen
    Secondes:=Round(24*3600*CumulTemps[i]/i);
    if DemoEnCours then // v1.6.3
      stHTMLTpsMoyen:='-'
    else
      begin
      stHTMLTpsMoyen:=Format(stFormatDuree, [Secondes div 60, Secondes mod 60]); // v1.4.9 (stFormatDuree)
      if stHTMLTpsMoyen[3]=' ' then stHTMLTpsMoyen[3]:='0';
      stHTMLTpsMoyen:=stHTMLStyleEtCouleurAppliques(stHTMLTpsMoyen, stCodeHTMLTemps[Ord(stHTMLTpsMoyen>IntToStr(Ord(TempsReflexion)))], []) // v1.5.6 : Ord(TempsReflexion) à la place de MinutesReflexion
      end;
    // Proposition (mot&score)
    if BonusScrabblePrp[i] then
      stScore:=stHTMLStyleEtCouleurAppliques(IntToStr(Score[i]), '', [fsUnderline])
    else
      stScore:=IntToStr(Score[i]);
    // v1.6.3 : indicateur de top (astérisque)
    stScore:=stTopTrouve[Score[i]=ScoreTop[i]]+stScore;

    if stProposition[i]='' then
      stHTMLPrp:='&nbsp'
    else
      stHTMLPrp:=stHTMLPoseStyleEtCouleurAppliques(i, csHumain); // v1.5.1 (factorisation)

    // Solution (mot&score)
    if BonusScrabbleSol[i] then // v1.4 : ScoreTop remplacé par ScorePartie
      stScorePartie:=stHTMLStyleEtCouleurAppliques(IntToStr(ScorePartie[i]), '', [fsUnderline])
    else
      stScorePartie:=IntToStr(ScorePartie[i]);
    if stSolution[i]='' then
      stHTMLSol:='&nbsp'
    else
      stHTMLSol:=stHTMLPoseStyleEtCouleurAppliques(i, csMachine); // v1.5.1 (factorisation)

    // Score Top (v1.4) déplacé de ci-dessus
    stScoreTop:=IntToStr(ScoreTop[i]);

    // Tirage
    stHTMLTirage:='';
    for j:=1 to Length(stTirage[i]) do
      if FormFeuilleMatch.FormatLettreTirage(i, j, stLettre[1], Style) then
        begin // v1.6.6 : les nouveaux jetons sont soulignés et non plus en italique (moins lisible)
        if Style=[fsItalic] then Style:=[fsUnderline];
        stHTMLTirage:=stHTMLTirage+stHTMLStyleEtCouleurAppliques(stLettresDoubles(stLettre), '', Style) // vKA : transforme les lettres accentuées en lettres doubles : stLettreDouble(stLettre) au lieu de stLettre
        end
      else
        stHTMLTirage:=stLettresDoubles(stTirage[i]); // v1.7.4 : Oubli stLettresDoubles ?

    // v1.5 : Niveau de Difficulté. Formule : NbNiveauxDifficulte-(NbNiveauxDifficulte/2)*log10(min(100,1+100*(NbSol>=50%)/NbSol)).
    CalculeNiveauDifficulte(NbSolSupEgalMoitieTop[i], NbSol[i], stLibAltDiffTir, stURLBmpTir);
    CalculeNiveauDifficulte(CumulNbSolSEMoitieTop[i],
                            CumulTop[i], // v1.5.1 : Niveau de difficulté moyen pondéré par ScoreTop
                            stLibAltDiffPrt, stURLBmpPrt);
    // v1.6
    if (VersionFichier<$160) or
       (TpsCalculSol[i]=0) then
      begin
      stTpsCalcSol:=stHTMLEspaceInsecable;
      stNbSolParSec:=stHTMLEspaceInsecable;
      end
    else
      begin
      stTpsCalcSol:=Format(stFrmTpsCalcSol, [TpsCalculSol[i]]);
      stNbSolParSec:=Format(stFrmNbSolParSec, [NbSol[i]/TpsCalculSol[i]])
      end;
    if (VersionFichier<$160) or
       (CumulTpsCalculSol[i]=0) then
      begin
      stCumulTpsCalcSol:=stHTMLEspaceInsecable;
      stCumulNbSolParSec:=stHTMLEspaceInsecable;
      end
    else
      begin
      stCumulTpsCalcSol:=Format(stFrmTpsCalcSol, [CumulTpsCalculSol[i]/i]);
      stCumulNbSolParSec:=Format(stFrmNbSolParSec, [CumulNbSol[i]/CumulTpsCalculSol[i]])
      end;
    Write(f, Format(stFrmHTMLFdmdLgn,
                    [i, stHTMLTirage,
                     stCoordonnees(xPrp[i], yPrp[i], dPrp[i]), stHTMLPrp,
                     stCoordonnees(xSol[i], ySol[i], dSol[i]), stHTMLSol,
                     stScore, stScorePartie, stScoreTop, // v1.4 : ScorePartie
                     Cumul[i], CumulPartie[i], CumulTop[i], // v1.4 : CumulPartie
                     stHTMLTps, stHTMLCumulTps,
                     PosPrp[i], stSuffixeRang[Ord(PosPrp[i]>1)], NbSol[i],
                     IfThen(NbSolBonus50[i]=0, stHTMLEspaceInsecable, IfThen(i=1,'*','')+IntToStr(NbSolBonus50[i])), // v1.5 : Nb bonus 50 + Astérisque du premier tour
                     stURLBmpTir, stLibAltDiffTir,
                     stTpsCalcSol, stNbSolParSec, // v1.6 : Tps calcul solutions
                     stHTMLTpsMoyen, // v1.5 : permutation Temps et Rang/Solutions - v1.4.8 (temps moyen regroupé avec les moyennes)
                     Max(1, CumulPosPrp[i] div i), // v1.6.4 : Empêche d'afficher zéro
                     stSuffixeRang[Ord(CumulPosPrp[i] div i>1)], CumulNbSol[i] div i, // v1.4.7
                     IfThen(CumulNbSolBonus50[i]=0, stHTMLEspaceInsecable, Format('%.1f', [(1.0*CumulNbSolBonus50[i])/i])), // v1.5 : Nb Bonus 50 (moyenne)
                     stURLBmpPrt, stLibAltDiffPrt,
                     stCumulTpsCalcSol, stCumulNbSolParSec, // v1.6 : Tps calcul solutions
                     stCodeCouleurHTMLRapport(PrcScore/MaxFormatRapport[FormatRapport], DemoEnCours), // v1.5 : code couleur du rouge au vert pour performance. v1.6.3 : on masque si démo en cours
                     PrcScore,
                     stCodeCouleurHTMLRapport(PrcCumul/MaxFormatRapport[FormatRapport], DemoEnCours), // v1.5 : code couleur du rouge au vert pour performance. v1.6.3 : on masque si démo en cours
                     PrcCumul]))
    end{for};
  Write(f, Format(stFrmHTMLFdmdPdP1+
                  stFrmHTMLFdmdPdP2+
                  stFrmHTMLFdmdPdP3 // v1.6
                                 , [stFormatRapport[FormatRapport],
                                    stFormatRapport[FormatRapport],
                                    stURLBitmapNiveauDifficulte(dtIndefinie), stAltDiffTirage[dtIndefinie],
                                    stURLBitmapNiveauDifficulte(dt0Etoile), stAltDiffTirage[dt0Etoile],
                                    stURLBitmapNiveauDifficulte(dtDemiEtoile), stAltDiffTirage[dtDemiEtoile],
                                    stURLBitmapNiveauDifficulte(dt1Etoile), stAltDiffTirage[dt1Etoile],
                                    stURLBitmapNiveauDifficulte(dt1EtoileEtDemie), stAltDiffTirage[dt1EtoileEtDemie],
                                    stURLBitmapNiveauDifficulte(dt2Etoiles), stAltDiffTirage[dt2Etoiles],
                                    stURLBitmapNiveauDifficulte(dt2EtoilesEtDemie), stAltDiffTirage[dt2EtoilesEtDemie],
                                    stURLBitmapNiveauDifficulte(dt3Etoiles), stAltDiffTirage[dt3Etoiles],
                                    stURLBitmapNiveauDifficulte(dt3EtoilesEtDemie), stAltDiffTirage[dt3EtoilesEtDemie],
                                    stURLBitmapNiveauDifficulte(dt4Etoiles), stAltDiffTirage[dt4Etoiles],
                                    stURLBitmapNiveauDifficulte(dt4EtoilesEtDemie), stAltDiffTirage[dt4EtoilesEtDemie],
                                    stURLBitmapNiveauDifficulte(dt5Etoiles), stAltDiffTirage[dt5Etoiles]]));
finally
  CloseFile(f);
  with FormFeuilleMatch do // v1.5
    begin
    RichEdit.SelStart:=0; // v1.5
    RichEdit.SelLength:=0; // v1.5
    if FdMAffichee then FormFeuilleMatch.Visible:=True; // v1.5 : pour éviter le scintillement, on a caché la feuille de match que l'on réaffiche le cas échéant.
    end;
  if Affichage then
   OuvreFichierHTML(stNomFichier); // v1.4.6
end{try};
end;
//---------------------------------------------------------------------------
constructor TSolution.Cree(const stMot : String; const x, y : TCoordonnee; const d : TDirection; const Chevalet : TChevalet; const Debut, Fin: TOrdreJetonChevalet; const NumeroJoker : TJoker; const LettreJoker : TLettreJoker);
var i : Integer;
begin
Self.stMot:=stMot;
Self.x:=x;
Self.y:=y;
Self.d:=d;
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  Self.Chevalet[i]:=Chevalet[i];
Self.Debut:=Debut;
Self.Fin:=Fin;
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
  Self.LettreJoker[i]:=tjJoker;
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
  if NumeroJoker[i]>0 then
    Self.LettreJoker[NumeroJoker[i]]:=LettreJoker[NumeroJoker[i]]
end;
//---------------------------------------------------------------------------
constructor TSolution.Clone(const Solution : TSolution);
var i: Integer;
begin
Self.stMot:=Solution.stMot;
Self.x:=Solution.x;
Self.y:=Solution.y;
Self.d:=Solution.d;
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  Self.Chevalet[i]:=Solution.Chevalet[i];
Self.Debut:=Solution.Debut;
Self.Fin:=Solution.Fin;
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
  Self.LettreJoker[i]:=Solution.LettreJoker[i]
end;
//---------------------------------------------------------------------------
destructor  TSolution.Detruit;
begin
end;
//---------------------------------------------------------------------------
procedure TSolution.ChargeChevalet(var Chevalet : TChevalet);
var i, j : Integer;
    Jeton : TNumeroJetonSac;
begin
// On met les jetons suivant l'ordre du chevalet de la solution retenue
for i:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
  for j:=Low(TOrdreJetonChevalet) to High(TOrdreJetonChevalet) do
    if (i<>j) and
       (Self.Chevalet[i]>0) and
       (Self.Chevalet[i]=Chevalet[j]) then
      begin
      Jeton:=Chevalet[i];
      Chevalet[i]:=Self.Chevalet[i];
      Chevalet[j]:=Jeton;
      end
end;
//---------------------------------------------------------------------------
procedure TSolution.ChargeLettresJoker(var LettreJoker : TLettreJoker);
var i : Integer;
begin
// On affecte les lettres de jokers utilisés dans la solution retenue
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
 if Self.LettreJoker[i]>tjJoker then
   LettreJoker[i]:=Self.LettreJoker[i];
end;
//---------------------------------------------------------------------------
procedure TSolution.DechargeLettresJoker(var LettreJoker : TLettreJoker);
var i : Integer;
begin
// On affecte les lettres de jokers utilisés dans la solution retenue
for i:=Low(TOrdreJoker) to High(TOrdreJoker) do
 if Self.LettreJoker[i]>tjJoker then
   LettreJoker[i]:=tjJoker;
end;
//---------------------------------------------------------------------------
constructor TRecord.Cree(const Source : TSourceRecord; // v1.5
                         const Niveau : TNiveauRecord;
                         const MinMax : TTypeRecord;
                         const Nature : TNatureRecord;
                         const TypePartie : TTypePartie); // v1.5.7
begin
Self.Source:=Source;
Self.Niveau:=Niveau;
Self.MinMax:=MinMax;
Self.Nature:=Nature;
Self.TypePartie:=TypePartie; // v1.5.7
Valeur:=IfThen(MinMax=trMin, High(Integer), 0);
NumeroPartie:=0;
stNomPartie:='';
stDateHeure:='';
Tour:=0;
stLibelle:='';
end;
//---------------------------------------------------------------------------
destructor TRecord.Detruit; // v1.5
begin
// RAF
end;
//---------------------------------------------------------------------------
procedure TRecord.Enregistre(const Tour : Integer; const Valeur : Integer; const stLibelle : String; const Affiche : Boolean);
var IniFile : TIniFile;
begin
Self.stDateHeure:=stDateHeureCourante;
Self.Tour:=Tour;
Self.Valeur:=Valeur;
Self.stLibelle:=stLibelle;
Self.stNomPartie:=p.stNomPartie;
Self.NumeroPartie:=p.NumeroPartie;
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  IniFile.WriteInteger(stSectionRecords, stEntreeRecord(irNumeroPartie), NumeroPartie);
  IniFile.WriteString(stSectionRecords, stEntreeRecord(irNomPartie), stNomPartie);
  if Niveau=nvrTour then
    IniFile.WriteInteger(stSectionRecords, stEntreeRecord(irTour), Tour);
  IniFile.WriteInteger(stSectionRecords, stEntreeRecord(irValeur), Valeur);
  IniFile.WriteString(stSectionRecords, stEntreeRecord(irLibelle), stLibelle);
  IniFile.WriteString(stSectionRecords, stEntreeRecord(irDateHeure), stDateHeure);
finally
  FreeAndNil(IniFile);
end{try};
if Affiche and
   ((Niveau=nvrPartie) or // v1.5.9 : On n'affiche pas si le record de niveau tour n'est pas le meilleur tout type de partie confondu
    (r.MeilleurRecord(Source, Niveau, MinMax, Nature).stDateHeure=stDateHeure)) then
  FormNvRecord.AfficheRecord(Self)
end;
//---------------------------------------------------------------------------
function TRecord.TesteRecord(const Tour, Valeur : Integer; const stLibelle : String; const Affiche : Boolean) : Boolean;
begin
Result:=False;
// if (Niveau=nvrPartie) and (p.TypePartie>tpStandard) then Exit; // v1.5.7 : records de types de partie non standard gérés maintenant séparément
case MinMax of
  trMin: if (Nature=ntrNivDiff) and (Valeur=0) then
           Result:=False
         else
           Result:=(Valeur<Self.Valeur);
  trMax: Result:=(Valeur>Self.Valeur);
end;

if Result then
  Enregistre(Tour, Valeur, stLibelle, Affiche);
end;
//---------------------------------------------------------------------------
procedure TRecord.Charge(const IniFile : TIniFile);
begin
with IniFile do
  begin
  NumeroPartie:=ReadInteger(stSectionRecords, stEntreeRecord(irNumeroPartie), 0);
  stNomPartie:=ReadString(stSectionRecords, stEntreeRecord(irNomPartie), '');
  Tour:=ReadInteger(stSectionRecords, stEntreeRecord(irTour), 0);
  Valeur:=ReadInteger(stSectionRecords, stEntreeRecord(irValeur), IfThen(MinMax=trMin, High(Integer), 0));
  stLibelle:=ReadString(stSectionRecords, stEntreeRecord(irLibelle), '');
  stDateHeure:=ReadString(stSectionRecords, stEntreeRecord(irDateHeure), '')
  end
end;
//---------------------------------------------------------------------------
function TRecord.RecordPossible : Boolean;
begin
Result:=EstSourceNatureRecord[Source, Nature] and
        EstNiveauNatureRecord[Niveau, Nature];
end;
//---------------------------------------------------------------------------
function TRecord.AucunRecord : Boolean;
begin
Result:=(Valeur=IfThen(MinMax=trMin, High(Integer), 0)) or
        ((stNomPartie='') and (NumeroPartie=0)) or // Si on a pas de numéro alors version < 1.5 donc il y a un nom de partie !
        (stDateHeure='')
end;
//---------------------------------------------------------------------------
function TRecord.stHTMLValeur(const Cible : TCibleInfoRecord) : String;
begin
case Nature of
  ntrScore:       Result:=Format('%d points', [Valeur]);
  ntrNbBonus:     Result:=Format('%d', [Valeur]);
  ntrTailleMot:   Result:=Format('%d jetons', [Valeur]); // vKA : à cause des doubles-lettres, le record se transforme en nombre de jetons au lieu de nombre de lettres !
  ntrNivDiff:     if Cible = cirPageHTML then
                    Result:=Format('%.2f/10</b>&nbsp;'+stHTMLImgNivDiff+'<br>%s<b>',
                                   [Valeur/100.0,
                                    stURLBitmapNiveauDifficulte(TDifficulteTirage(Round(Valeur/100.0))),
                                    stAltDiffTirage[TDifficulteTirage(Round(Valeur/100.0))],
                                    stLibelle])
                  else
                    Result:=Format('%.2f/10 %s', [Valeur/100.0, stLibelle]);
  ntrNbSolSurRg:  Result:=Format('%.2f', [Valeur/100.0]);
  ntrNbSolutions: if Niveau=nvrPartie then
                    Result:=Format('%d solutions', [Round(Valeur/100.0)]) // v1.6 : pas de chiffres après la virgules
                  else
                    if MinMax=trMax then
                      Result:=Format('%d solutions', [Valeur div 100])
                    else
                      Result:=Format('%d solution(s)', [Valeur div 100]);
  ntrNbSolBonus:  if Niveau=nvrPartie then
                    Result:=Format('%.2f bonus', [Valeur/100.0])
                  else
                    Result:=Format('%d bonus', [Valeur div 100]);
      // v1.5 : pour les deux lignes ci-dessous, utilisation du format de rapport paramétré (% ou /20)
  ntrRptScoreTop: Result:=Format('%.2f%s', [(1.0*MaxFormatRapport[FormatRapport]*Valeur)/10000.0, stFormatRapport[FormatRapport]]);
  ntrNbTopsTrv:   Result:=Format('%.2f %%', [Valeur/100.0]);
  ntrTpsCalcSol:  if MinMax=trMax then
                    Result:=Format('%.2f secondes', [Valeur/100.0]) // v1.6
                  else
                    Result:=Format('%.2f seconde(s)', [Valeur/100.0]); // v1.6
  ntrNbSolParSec: Result:=Format('%d solutions', [Valeur]); // v1.6
end;
end;
//---------------------------------------------------------------------------
function TRecord.stLibelleSansCodeHTML : string; // v1.5.1
var i : Integer;
    CodeHTMLEnCours : Boolean;
begin
Result:=''; CodeHTMLEnCours:=False;
for i:=1 to Length(stLibelle) do
  begin
  if not CodeHTMLEnCours then
    if stLibelle[i]='<' then
      CodeHTMLEnCours:=True
    else
      Result:=Result+stLibelle[i]
  else
    if stLibelle[i]='>' then
      CodeHTMLEnCours:=False
  end
end;
//---------------------------------------------------------------------------
procedure TRecords.Charge;
var s, nv, t, nt, tp : Integer;
    IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  for s:=Ord(Low(TSourceRecord)) to Ord(High(TSourceRecord)) do
    for nv:=Ord(Low(TNiveauRecord)) to Ord(High(TNiveauRecord)) do
      for t:=Ord(Low(TTypeRecord)) to Ord(High(TTypeRecord)) do
        for nt:=Ord(Low(TNatureRecord)) to Ord(High(TNatureRecord)) do
          for tp:=Ord(tpStandard) to Ord(High(TTypePartie)) do // v1.5.7 ici et ci-dessous (TTypePartie)
            if EstSourceNatureRecord[TSourceRecord(s), TNatureRecord(nt)] and
               EstNiveauNatureRecord[TNiveauRecord(nv), TNatureRecord(nt)] and
               EstTypeNatureRecord[TTypeRecord(t), TNatureRecord(nt)] then // v1.5.8 : EstTypePartie supprimé car les records sont enregistrés même pour Tour+Joker
              r[TSourceRecord(s), TNiveauRecord(nv), TTypeRecord(t), TNatureRecord(nt), TTypePartie(tp)].Charge(IniFile);
finally
  FreeAndNil(IniFile)
end
end;
//---------------------------------------------------------------------------
constructor TRecords.Cree; // v1.5
var s, nv, t, nt, tp : Integer;
begin
AfficheNouveauxRecords:=True;
for s:=Ord(Low(TSourceRecord)) to Ord(High(TSourceRecord)) do
  for nv:=Ord(Low(TNiveauRecord)) to Ord(High(TNiveauRecord)) do
    for t:=Ord(Low(TTypeRecord)) to Ord(High(TTypeRecord)) do
      for nt:=Ord(Low(TNatureRecord)) to Ord(High(TNatureRecord)) do
        for tp:=Ord(Low(TTypePartie)) to Ord(High(TTypePartie)) do // v1.5.7 ici et ci-dessous (TTypePartie)
          r[TSourceRecord(s), TNiveauRecord(nv), TTypeRecord(t), TNatureRecord(nt), TTypePartie(tp)]:=
            TRecord.Cree(TSourceRecord(s), TNiveauRecord(nv), TTypeRecord(t), TNatureRecord(nt), TTypePartie(tp));
Charge
end;
//---------------------------------------------------------------------------
destructor TRecords.Detruit; // v1.5
var s, nv, t, nt, tp : Integer;
begin
for s:=Ord(Low(TSourceRecord)) to Ord(High(TSourceRecord)) do
  for nv:=Ord(Low(TNiveauRecord)) to Ord(High(TNiveauRecord)) do
    for t:=Ord(Low(TTypeRecord)) to Ord(High(TTypeRecord)) do
      for nt:=Ord(Low(TNatureRecord)) to Ord(High(TNatureRecord)) do
        for tp:=Ord(Low(TTypePartie)) to Ord(High(TTypePartie)) do // v1.5.7 ici et ci-dessous (TTypePartie)
          r[TSourceRecord(s), TNiveauRecord(nv), TTypeRecord(t), TNatureRecord(nt), TTypePartie(tp)].Detruit
end;
//---------------------------------------------------------------------------
function TRecord.stEntreeRecord(const Info : TInfoRecord) : String;
begin
Result:=stEntreeSourceRecord[Source]+
        stEntreeNiveauRecord[Niveau]+
        stEntreeTypeRecord[MinMax]+
        stEntreeNatureRecord[Nature]+
        stEntreeTypePartie[TypePartie]+ // v1.5.7
        stEntreeInfoRecord[Info]
end;
//---------------------------------------------------------------------------
function TRecords.MeilleurRecord(const Source : TSourceRecord; const Niveau : TNiveauRecord; const MinMax : TTypeRecord; const Nature : TNatureRecord) : TRecord; // v1.5.8 : retourne le meilleur record tout type de partie confondu
var tp       : Integer;
    Meilleur : Boolean;
begin
Result:=r[Source, Niveau, MinMax, Nature, tpStandard];
for tp:=Ord(Succ(tpStandard)) to Ord(High(TTypePartie)) do
  with r[Source, Niveau, MinMax, Nature, TTypePartie(tp)] do
    begin // Même test que TRecord.TesteRecord
    Meilleur:=False; // Pessimiste
    case MinMax of
      trMin: if (Nature=ntrNivDiff) and (Valeur=0) then
               Meilleur:=False
             else
               Meilleur:=(Valeur<Result.Valeur);
      trMax: Meilleur:=(Valeur>Result.Valeur);
    end;
    if Meilleur then Result:=r[Source, Niveau, MinMax, Nature, TTypePartie(tp)]
    end
end;
//---------------------------------------------------------------------------
function TRecords.TesteRecord(const Source    : TSourceRecord;
                              const Niveau    : TNiveauRecord;
                              const MinMax    : TTypeRecord;
                              const Nature    : TNatureRecord;
                              const Tour,
                                    Valeur    : Integer;
                              const stLibelle : String) : Boolean;
begin
// v1.5.7 : ajout de p.TypePartie
Result:=r[Source, Niveau, MinMax, Nature, p.TypePartie].TesteRecord(Tour, Valeur, stLibelle, AfficheNouveauxRecords);
end;
//---------------------------------------------------------------------------
function TRecords.AssocieNomPartie : Boolean; // v1.5 : Utilisé pour associer le nom de la partie qui vient d'être enregistrée à ses records.
var s, nv, t, nt, tp : Integer;
begin // Renvoie True si un record a été modifié (pour regénérer derrière la liste des records HTML.)
Result:=False; // Pessimiste
if p.NumeroPartie>0 then // Les parties de version < 1.5 n'ont pas de numéro mais ont un nom de partie !
  for s:=Ord(Low(TSourceRecord)) to Ord(High(TSourceRecord)) do
    for nv:=Ord(Low(TNiveauRecord)) to Ord(High(TNiveauRecord)) do
      for t:=Ord(Low(TTypeRecord)) to Ord(High(TTypeRecord)) do
        for nt:=Ord(Low(TNatureRecord)) to Ord(High(TNatureRecord)) do
          for tp:=Ord(Low(TTypePartie)) to Ord(High(TTypePartie)) do // v1.5.7
          with r[TSourceRecord(s), TNiveauRecord(nv), TTypeRecord(t), TNatureRecord(nt), TTypePartie(tp)] do
            if (NumeroPartie=p.NumeroPartie) then // On a trouvé un record pour cette partie...
              begin
              Enregistre(Tour, Valeur, stLibelle, NAffichePas); // ...On réenregistre (sans afficher) !
              if Not Result then Result:=True
              end
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.NumeroMot(const stMot : string) : Integer;
begin
Result:=1+slMot.IndexOfName(stMot)
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.ValeurMot(const stMot : string) : Integer;
begin
Result:=StrToInt(slMot.Values[stMot])
end;
//---------------------------------------------------------------------------
constructor TDefi15Lettres.Cree; // v1.5.3
var slTemp      : TStringList;
    i, j, n,
    Score       : Integer;
    stMot       : String;

begin
// 1. On stocke et on trie les mots de 15 jetons avec leurs scores
slTemp:=TStringList.Create;
with slTemp do
  begin
  Sorted:=True;
  n:=(nbl[NbLettresMaxMot] div NbLettresMaxMot)-1;
  for i:=0 to n do
    begin
    stMot:=p.Dico.stMotDico(NbLettresMaxMot, i);
    Score:=0;
    for j:=1 to NbLettresMaxMot do
      Inc(Score, ValeurJeton[TypeJetonLettre(stMot[j])]); // v1.7.3 : conversion stLettre en TypeJeton avant via la nouvelle fonction TypeJetonLettre()...
    Add(Format('%d-%s (%d points)', [99-Score, stMot, Score]));
    end
  end;
// 2. On restocke les mots de 15 jetons où l'index est le n° de mot après tri
slMot:=TStringList.Create;
with slMot do
  begin
  CaseSensitive:=True;
  for i:=0 to slTemp.Count-1 do
    Add(Format('%s=%s', [Copy(slTemp[i], 4, NbLettresMaxMot),
                         Copy(slTemp[i], 21, 2)]))
  end;
FreeAndNil(slTemp)
end;
//---------------------------------------------------------------------------
destructor TDefi15Lettres.Detruit; // v1.5.3
begin
FreeAndNil(slMot)
end;
//---------------------------------------------------------------------------
procedure TDefi15Lettres.ChargeDefi(const iDefi : Integer; var stMot : String; var NbJetons, NbCoups, ScoreMot, CumulScore : Integer); // v1.5.4
var IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  with IniFile do
    begin
    stMot:=ReadString(stSectionDefiM15L, stEntreeDefiM15LMot+IntToStr(iDefi), '');
    NbJetons:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbJetonsPosesHorsMot+IntToStr(iDefi), 0);
    NbCoups:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbCoupsJouesHorsMot+IntToStr(iDefi), 0);
    ScoreMot:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LScoreMot+IntToStr(iDefi), 0);
    CumulScore:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LCumulScoreHorsMot+IntToStr(iDefi), 0)
    end
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.ChargeDefi(const stMotATester : String; var NbJetons, NbCoups, ScoreMot, CumulScore : Integer) : Integer;
var i, n    : Integer;
    IniFile : TIniFile;
begin
Result:=0;
NbJetons:=0;
NbCoups:=0;
ScoreMot:=0;
CumulScore:=0;
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  with IniFile do
    begin
    n:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbDefis, 0);
    for i:=1 to n do
      if stMotATester=ReadString(stSectionDefiM15L, stEntreeDefiM15LMot+IntToStr(i), '') then
        begin
        Result:=i;
        Break
        end;
    if Result>0 then
      begin
      NbJetons:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbJetonsPosesHorsMot+IntToStr(Result), 0);
      NbCoups:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbCoupsJouesHorsMot+IntToStr(Result), 0);
      ScoreMot:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LScoreMot+IntToStr(Result), 0);
      CumulScore:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LCumulScoreHorsMot+IntToStr(Result), 0)
      end
    end;
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TDefi15Lettres.EnregistreDefi(const stMot : String; const NumeroDefi, NbJetons, NbCoups, ScoreMot, CumulScore : Integer);
var n, m, v : Integer;
    IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
n:=NumeroDefi;
m:=NumeroMot(stMot);
v:=ValeurMot(stMot);
try
  with IniFile do
    begin
    if n=0 then
      begin
      n:=1+ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbDefis, 0);
      WriteInteger(stSectionDefiM15L, stEntreeDefiM15LNbDefis, n);
      end;
    WriteString(stSectionDefiM15L, stEntreeDefiM15LVersionDico+IntToStr(n), stVersionDico); // v1.7.3 Entrée "diko" en chaîne et non entier
    WriteString(stSectionDefiM15L, stEntreeDefiM15LMot+IntToStr(n), stMot);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LNumeroMot+IntToStr(n), m);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LValeurMot+IntToStr(n), v);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LNbJetonsPosesHorsMot+IntToStr(n), NbJetons);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LNbCoupsJouesHorsMot+IntToStr(n), NbCoups);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LScoreMot+IntToStr(n), ScoreMot);
    WriteInteger(stSectionDefiM15L, stEntreeDefiM15LCumulScoreHorsMot+IntToStr(n), CumulScore);
    if p.stNomPartie<>'' then // Permet d'utiliser la valeur par défaut de ReadString
      WriteString(stSectionDefiM15L, stEntreeDefiM15LNomPartie+IntToStr(n), p.stNomPartie);
    WriteString(stSectionDefiM15L, stEntreeDefiM15LDateHeure+IntToStr(n), stDateHeureCourante);
    end;
    MessageBox(0,
               pChar(Format(IfThen(NumeroDefi=0,
                                    'Nouveau défi (n°%d avec le mot %s à %d points) :'#13#13'en %d+15 jetons et %d+1 coups donnant %d points et un cumul de %d+%d=%d points.',
                                   'Défi amélioré (n°%d avec le mot %s à %d points) :'#13#13'en %d+15 jetons et %d+1 coups donnant %d points et un cumul de %d+%d=%d points.'),
                            [m, stMot, v, NbJetons, NbCoups, ScoreMot, CumulScore, ScoreMot, CumulScore+ScoreMot])),
               'Défi du mot de 15 jetons à former avec le moins de jetons possible', 0);
finally
  FreeAndNil(IniFile);
  GenereListeDefis(stRepLocalAppData+stNomFichierDefi1M15L, NAffichePas); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
end{try}
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.DefisEnregistres : Integer; // v1.5.4
var IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  Result:=IniFile.ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbDefis, 0);
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.TesteDefiRecord : String; // v1.5.4
const LeRecord   : Boolean = True;
      LeDefi     : Boolean = False;
var i, NbDefis   : Integer;
    NbJetons,
    NbCoups,
    ScoreMot,
    CumulScore   : array[Boolean] of Integer;
    stMotATester : String;
begin
NbJetons[LeRecord]:=0;
NbCoups[LeRecord]:=0;
ScoreMot[LeRecord]:=0;
CumulScore[LeRecord]:=0;
NbDefis:=DefisEnregistres;
for i:=1 to NbDefis do
  begin
  ChargeDefi(i, stMotATester, NbJetons[LeDefi], NbCoups[LeDefi], ScoreMot[LeDefi], CumulScore[LeDefi]);
  if (NbJetons[LeDefi]>NbJetons[LeRecord]) or
     ((NbJetons[LeDefi]=NbJetons[LeRecord]) and
      (NbCoups[LeDefi]>NbCoups[LeRecord])) or
     ((NbJetons[LeDefi]=NbJetons[LeRecord]) and
      (NbCoups[LeDefi]=NbCoups[LeRecord]) and
      (ScoreMot[LeDefi]<ScoreMot[LeRecord])) or
     ((NbJetons[LeDefi]=NbJetons[LeRecord]) and
      (NbCoups[LeDefi]=NbCoups[LeRecord]) and
      (ScoreMot[LeDefi]=ScoreMot[LeRecord]) and
      (CumulScore[LeDefi]<CumulScore[LeRecord])) then
    begin
    NbJetons[LeRecord]:=NbJetons[LeDefi];
    NbCoups[LeRecord]:=NbCoups[LeDefi];
    ScoreMot[LeRecord]:=ScoreMot[LeDefi];
    CumulScore[LeRecord]:=CumulScore[LeDefi];
    Result:=stMotATester
    end
  end
end;
//---------------------------------------------------------------------------
function TDefi15Lettres.TesteDefi : Boolean; // v1.5.3
var iDefi,
    NbJetons,
    NbCoups,
    ScoreMot,
    CumulScore,
    NbJetonsPoses : Integer;
    stMotATester : String;
begin
Result:=True; // Optimiste
// Attention : À partir d'ici, le tour a été incrémenté
stMotATester:=p.stSolution[p.Tour-1];
iDefi:=ChargeDefi(stMotATester, NbJetons, NbCoups, ScoreMot, CumulScore);
NbJetonsPoses:=p.NbJetonsPoses-NbLettresMaxMot;
if (iDefi=0) or
   (NbJetonsPoses<NbJetons) or
   ((NbJetonsPoses=NbJetons) and
    (p.Tour-2<NbCoups)) or
   ((NbJetonsPoses=NbJetons) and
    (p.Tour-2=NbCoups) and
    (p.ScorePartie[p.Tour-1]>ScoreMot)) or
   ((NbJetonsPoses=NbJetons) and
    (p.Tour-2=NbCoups) and
    (p.ScorePartie[p.Tour-1]=ScoreMot) and
    (p.CumulPartie[p.Tour-2]>CumulScore)) then
  EnregistreDefi(stMotATester, iDefi, NbJetonsPoses, p.Tour-2, p.ScorePartie[p.Tour-1], p.CumulPartie[p.Tour-2])
else
  Result:=False
end;
//---------------------------------------------------------------------------
procedure TDefi15Lettres.GenereListeDefis(const stNomFichier : String; const Affichage : Boolean);
const // v1.5.4
      Debut : Boolean = False;
      Fin   : Boolean = True;
      stHTMLGras : array [Boolean, Boolean] of String = (('','<b>'),('','</b>'));
var i, iDrn,
    j, k, n     : Integer;
    EstRecord   : Boolean; // v1.5.4
    f           : TextFile;
    IniFile     : TIniFile;
    stMotRecord : String;
begin
stMotRecord:=TesteDefiRecord; // v1.5.4
AssignFile(f, stNomFichier);
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  Rewrite(f);
  Write(f, stFrmHTMLD15lEnT);
  with IniFile do
    begin
    n:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbDefis, 0);
    iDrn:=0;
    repeat
      // On cherche le n° défi le plus petit
      i:=slMot.Count+1; // i = N° de défi à afficher
      for j:=1 to n do          // Défis relevés
        begin
        k:=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNumeroMot+IntToStr(j), 0);
        if (k<i) and (k>iDrn) then i:=k
        end;
      if i<slMot.Count then
        for j:=1 to n do  // Défis relevés
          if stVersionDico=ReadString(stSectionDefiM15L, stEntreeDefiM15LVersionDico+IntToStr(j), '') then // v1.7.3 Entrée "diko" en chaîne et non entier
            begin
            if (i=ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNumeroMot+IntToStr(j), 0)) and
               (slMot.Names[i-1]=ReadString(stSectionDefiM15L, stEntreeDefiM15LMot+IntToStr(j), '')) then
              begin
              EstRecord:=(slMot.Names[i-1]=stMotRecord); // v1.5.4
              Write(f, Format(stFrmHTMLD15LLgn, // v1.5.4 : Balises de Gras ci-dessous pour le mot le plus difficile à placer
                              [stHTMLGras[Debut, EstRecord], i, stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], slMot.Names[i-1], stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], StrToInt(slMot.ValueFromIndex[i-1]), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbJetonsPosesHorsMot+IntToStr(j), 0), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadInteger(stSectionDefiM15L, stEntreeDefiM15LNbCoupsJouesHorsMot+IntToStr(j), 0), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadInteger(stSectionDefiM15L, stEntreeDefiM15LScoreMot+IntToStr(j), 0), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadInteger(stSectionDefiM15L, stEntreeDefiM15LCumulScoreHorsMot+IntToStr(j), 0), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadString(stSectionDefiM15L, stEntreeDefiM15LDateHeure+IntToStr(j), '&nbsp;'), stHTMLGras[Fin, EstRecord],
                               stHTMLGras[Debut, EstRecord], ReadString(stSectionDefiM15L, stEntreeDefiM15LNomPartie+IntToStr(j), '&nbsp;'), stHTMLGras[Fin, EstRecord]]))
              end
            end;
      iDrn:=i;
    Until i>slMot.Count;
    end{with};
  Write(f, stFrmHTMLD15lPdp);
finally
  FreeAndNil(IniFile);
  CloseFile(f);
  if Affichage then
    OuvreFichierHTML(stNomFichier);
end{try}
end;
//---------------------------------------------------------------------------
procedure InitialiseRepLocalAppData; // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
const stVarLocalAppData  = 'LOCALAPPDATA';
      stRepLocAppDataDup = '\Patquoi.fr\Diplikata';
var n : DWord;
begin
n:=0;
n:=GetEnvironmentVariable(pChar(stVarLocalAppData), nil, n);
if n>0 then
  begin
  SetLength(stRepLocalAppData, n-1);
  if GetEnvironmentVariable(pChar(stVarLocalAppData), pChar(stRepLocalAppData), n)<>n-1 then
    stRepLocalAppData:=ExtractFilePath(ParamStr(0)) // Dossier de Diplikata.exe
  else
    begin
    stRepLocalAppData:=stRepLocalAppData+stRepLocAppDataDup;
    if not DirectoryExists(stRepLocalAppData) then
      if not ForceDirectories(stRepLocalAppData) then
        stRepLocalAppData:=ExtractFilePath(ParamStr(0)) // Dossier de Diplikata.exe
      else
        stRepLocalAppData:=stRepLocalAppData+'\'
    else
      stRepLocalAppData:=stRepLocalAppData+'\';
    end
  end
else
  stRepLocalAppData:=ExtractFilePath(ParamStr(0)); // Dossier de Diplikata.exe
end;
//---------------------------------------------------------------------------
initialization
  FileMode:=fmOpenRead; // v1.7.4 : les fichiers ouverts avec Reset sont en lecture seule.
  Journalisation:=False;
  JournalOuvert:=False; // v1.5 : Empêche le Try CloseFile(Journal)
  InitialiseRepLocalAppData; // v1.7.4 : stRepLocalAppData remplace ParamStr(0)
  stNomFichierJournal:=ExtractFilePath(ParamStr(0))+'Diplikata.log';
  StockageSolutions:=False; // v1.3.6
  slSolutionsTriees:=TStringList.Create; // v1.3.6
  slSolutionsTriees.Sorted:=True; // v1.3.6
  FormatRapport:=frPourcentage;
  r:=TRecords.Cree; // v1.5
  d15l:=Nil;
//---------------------------------------------------------------------------
finalization
  r.Detruit; // v1.5
  if Journalisation then
    begin
    if not JournalOuvert then Exit; // v1.5 : Empêche le Try CloseFile(Journal)
    CloseFile(Journal);
    JournalOuvert:=False; // v1.5 : Empêche le Try CloseFile(Journal)
    ShellExecute(0,
                 'Open',
                 pChar(ExtractFileName(stNomFichierJournal)),
                 Nil,
                 pChar(ExtractFilePath(stNomFichierJournal)), // v1.4 (plus de guillemets+stNomFichierJournal)
                 SW_SHOWNORMAL)
    end
//---------------------------------------------------------------------------
end.

