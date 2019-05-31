unit main_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ExtCtrls, Base, Vcl.ComCtrls;
//---------------------------------------------------------------------------
type
//---------------------------------------------------------------------------
  // v1.5 : Notification des actions sur la barre de statut des messages. CAC = Case à cocher (Actif/Inactif)
  TActionANotifier=( aanAucune,
                     aanPartieNouvelle,
                     aanPartieDemonstrationCAC, // En fait pas CAC mais gère l'interruption de la démo (Inactif)
                     aanPartieOuvrir,
                     aanPartieEnregistrer,
                     aanOptionsJournalRechercheSolutionsCAC,
                     aanOptionsGenererAutoFeuilleDeMatchCAC,
                     aanOptionsGenererAfficherSolutionsCAC,
                     aanOptionsTempsLimiteCAC,
                     aanOptionsProposititionsInvalidesCAC,
                     aanOptionsEnregistrerParametres,
                     aanOptionsEnregistrerParametresEnQuittantCAC, // v1.6.5
                     aanOptionsRetablirParametres,
                     aanOptionsAppliquerParametres,
                     aanOptionsViderListePartiesJoueesCAC, // En fait pas CAC mais gère la confirmation (Inactif si Non)
                     aanOptionsEnregistrerPartieAutoCAC, // v1.5
                     aanOptionsPlacerPropositionAutoCAC, // v1.6.9
                     aanOptionsReinitialiserRecordsCAC, // v1.5. En fait pas CAC mais gère la confirmation (Inactif si Non)
                     aanOptionsTypePartieBlitz, // v1.5.6
                     aanOptionsTypePartieSemiRapide, // v1.5.6
                     aanOptionsTypePartieNormale, // v1.5.6
                     aanOptionsTypePartieStandard, // v1.5.6
                     aanOptionsTypePartieJoker, // v1.5.6
                     aanActionPasserSonTourCAC, // En fait pas CAC mais gère la confirmation (Inactif si Non)
                     aanActionChangerTirageCAC, // En fait pas CAC mais gère la confirmation (Inactif si Non)
                     aanAffichageTirageCAC,
                     aanAffichageFeuilleDeMatchCAC,
                     aanAffichageGrapheEvolutionCAC,
                     aanAffichageNouveauxRecordsCAC, // v1.5
                     aanAffichageFdMDetaillee,
                     aanAffichagePartiesJoueesCAC, // En fait pas CAC mais option d'affichage (Génération+Affichage) ou non (Génération seule) de la liste
                     aanAffichageRecordsCAC, // v1.5 : En fait pas CAC mais option d'affichage (Génération+Affichage) ou non (Génération seule) de la liste
                     aanAffichageDefi1M15LCAC, // v1.5.3 : En fait pas CAC mais option d'affichage (Génération+Affichage) ou non (Génération seule) de la liste
                     aanAffichageRapportsFormatCAC); // En fait pas CAC mais bouton radio (Inactif pour Note sur 20)
//---------------------------------------------------------------------------
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ImageListActions: TImageList;
    ActionActionsChangerTirage: TAction;
    ActionActionsPasserSonTour: TAction;
    ActionActionsProposerTirage: TAction;
    ActionActionsListerMotsLettresCheres: TAction;
    ActionActionsRechercherMots: TAction;
    ActionActionsRechercherDefinitionMot: TAction;
    ActionAffichageFeuilleMatch: TAction;
    ActionAffichageTirage: TAction;
    ActionAffichageGrapheEvolution: TAction;
    ActionAffichageFeuilleMatchDetaillee: TAction;
    ActionAffichageRapportsPourcentage: TAction;
    ActionAffichageRapportsNoteSur20: TAction;
    ActionAffichageSituationJetons: TAction;
    ActionAffichagePartiesJouees: TAction;
    ActionAffichageRecords: TAction;
    ActionAffichageNouveauxRecords: TAction;
    ActionAffichageListeDefisReleves1M15L: TAction;
    ActionInfosAPropos: TAction;
    ActionInfosAide: TAction;
    ActionInfosInternes: TAction;
    ActionOptionsListeToutesSolutions: TAction;
    ActionOptionsJournalRecherche: TAction;
    ActionOptionsTempsLimite: TAction;
    ActionOptionsSanctions: TAction;
    ActionOptionsEnregistrer: TAction;
    ActionOptionsEnregistrerEnQuittant: TAction;
    ActionOptionsReinitialiser: TAction;
    ActionOptionsGenererAutoFDM: TAction;
    ActionOptionsViderListePartiesJouees: TAction;
    ActionOptionsEnregistrerPartieAuto: TAction;
    ActionOptionsPlacerPropositionAuto: TAction;
    ActionOptionsReinitialiserRecords: TAction;
    ActionOptionsAppliquer: TAction;
    ActionOptionsQualitePose: TAction;
    ActionOptionsTypePartieBlitz: TAction;
    ActionOptionsTypePartieSemiRapide: TAction;
    ActionOptionsTypePartieNormale: TAction;
    ActionOptionsTypePartieStandard: TAction;
    ActionOptionsTypePartieJoker: TAction;
    ActionPartieNouvelle: TAction;
    ActionPartieOuvrir: TAction;
    ActionPartieEnregistrerSous: TAction;
    ActionPartieEnregistrer: TAction;
    ActionPartieQuitter: TAction;
    ActionPartieDemonstration: TAction;
    ActionPlacementHorizontal: TAction;
    ActionPlacementVertical: TAction;
    ActionTestPlacementHorizontal: TAction;
    ActionTestPlacementVertical: TAction;
    MenuItemPartie: TMenuItem;
    MenuItemOptions: TMenuItem;
    MenuItemActions: TMenuItem;
    MenuItemAffichage: TMenuItem;
    MenuItemInfos: TMenuItem;
    MenuItemPartieNouvelle: TMenuItem;
    MenuItemPartieDemonstration: TMenuItem;
    MenuItemSeparateur5: TMenuItem;
    MenuItemPartieOuvrir: TMenuItem;
    MenuItemPartieEnregistrer: TMenuItem;
    MenuItemPartieEnregistrerSous: TMenuItem;
    MenuItemSeparateur6: TMenuItem;
    MenuItemPartieQuitter: TMenuItem;
    MenuItemOptionsJournalRecherche: TMenuItem;
    MenuItemOptionsGenererAutoFDM: TMenuItem;
    MenuItemOptionsListeToutesSolutions: TMenuItem;
    MenuItemOptionsEnregistrerPartieAuto: TMenuItem;
    MenuItemOptionsQualitePose: TMenuItem;
    MenuItemSeparateur3: TMenuItem;
    MenuItemOptionsTypePartie: TMenuItem;
    MenuItemOptionsTypePartieBlitz: TMenuItem;
    MenuItemOptionsTypePartieSemiRapide: TMenuItem;
    MenuItemOptionsTypePartieNormale: TMenuItem;
    MenuItemSeparateur7: TMenuItem;
    MenuItemOptionsTypePartieStandard: TMenuItem;
    MenuItemOptionsTypePartieJoker: TMenuItem;
    MenuItemOptionsTempsLimite: TMenuItem;
    MenuItemOptionsSanctions: TMenuItem;
    MenuItemSeparateur4: TMenuItem;
    MenuItemOptionsEnregistrer: TMenuItem;
    MenuItemOptionsAppliquer: TMenuItem;
    MenuItemOptionsReinitialiser: TMenuItem;
    MenuItemOptionsEnregistrerEnQuittant: TMenuItem;
    MenuItemSeparateur9: TMenuItem;
    MenuItemOptionsViderListePartiesJouees: TMenuItem;
    MenuItemOptionsReinitialiserRecords: TMenuItem;
    MenuItemActionsPasserSonTour: TMenuItem;
    MenuItemActionsChangerTirage: TMenuItem;
    MenuItemActionsProposerTirage: TMenuItem;
    MenuItemSeparateur8: TMenuItem;
    MenuItemActionsRechercherMots: TMenuItem;
    MenuItemActionsListerMotsLettresCheres: TMenuItem;
    MenuItemActionsRechercherDefinitionMot: TMenuItem;
    MenuItemAffichageTirage: TMenuItem;
    MenuItemAffichageFeuilleMatch: TMenuItem;
    MenuItemAffichageGrapheEvolution: TMenuItem;
    MenuItemAffichageSituationJetons: TMenuItem;
    MenuItemAffichageNouveauxRecords: TMenuItem;
    MenuITemSeparateur1: TMenuItem;
    MenuItemAffichageFeuilleMatchDetaillee: TMenuItem;
    MenuItemAffichageRecords: TMenuItem;
    MenuItemAffichagePartiesJouees: TMenuItem;
    MenuItemAffichageListeDefisReleves: TMenuItem;
    MenuItemAffichageListeDefisReleves1M15L: TMenuItem;
    MenuITemSeparateur2: TMenuItem;
    MenuItemAffichageRapportsPourcentage: TMenuItem;
    MenuItemAffichageRapportsNoteSur20: TMenuItem;
    MenuItemInfosAide: TMenuItem;
    MenuItemInfosAPropos: TMenuItem;
    MenuItemInfosInternes: TMenuItem;
    PopupMenuPlacement: TPopupMenu;
    MenuItemPlacementGaucheDroite: TMenuItem;
    MenuITemPlacementHautBas: TMenuItem;
    PopupMenuTestPlacement: TPopupMenu;
    MenuItemTestPlacementHorizontal: TMenuItem;
    MenuItemTestPlacementVertical: TMenuItem;
    TimerMelangeur: TTimer;
    TimerDicoOK: TTimer;
    TimerReflexion: TTimer;
    TimerDemonstration: TTimer;
    TimerAPropos: TTimer;
    TimerClignotement: TTimer;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusBar: TStatusBar;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure TimerMelangeurTimer(Sender: TObject);
    procedure TimerDicoOKTimer(Sender: TObject);
    procedure TimerReflexionTimer(Sender: TObject);
    procedure TimerDemonstrationTimer(Sender: TObject);
    procedure TimerAProposTimer(Sender: TObject);
    procedure TimerClignotementTimer(Sender: TObject);
    procedure OpenDialogShow(Sender: TObject);
    procedure SaveDialogShow(Sender: TObject);
    procedure ActionActionsChangerTirageExecute(Sender: TObject);
    procedure ActionActionsPasserSonTourExecute(Sender: TObject);
    procedure ActionActionsProposerTirageExecute(Sender: TObject);
    procedure ActionActionsRechercherMotsExecute(Sender: TObject);
    procedure ActionActionsListerMotsLettresCheresExecute(Sender: TObject);
    procedure ActionActionsRechercherDefinitionMotExecute(Sender: TObject);
    procedure ActionAffichageFeuilleMatchExecute(Sender: TObject);
    procedure ActionAffichageTirageExecute(Sender: TObject);
    procedure ActionAffichageGrapheEvolutionExecute(Sender: TObject);
    procedure ActionAffichageFeuilleMatchDetailleeExecute(Sender: TObject);
    procedure ActionOptionsRapportsExecute(Sender: TObject);
    procedure ActionAffichageSituationJetonsExecute(Sender: TObject);
    procedure ActionAffichagePartiesJoueesExecute(Sender: TObject);
    procedure ActionAffichageRecordsExecute(Sender: TObject);
    procedure ActionAffichageListeDefisReleves1M15LExecute(Sender: TObject);
    procedure ActionInfosAProposExecute(Sender: TObject);
    procedure ActionInfosAideExecute(Sender: TObject);
    procedure ActionInfosInternesExecute(Sender: TObject);
    procedure ActionOptionsListeToutesSolutionsExecute(Sender: TObject);
    procedure ActionOptionsJournalRechercheExecute(Sender: TObject);
    procedure ActionOptionsEnregistrerExecute(Sender: TObject);
    procedure ActionOptionsReinitialiserExecute(Sender: TObject);
    procedure ActionOptionsViderListePartiesJoueesExecute(Sender: TObject);
    procedure ActionOptionsReinitialiserRecordsExecute(Sender: TObject);
    procedure ActionOptionsAppliquerExecute(Sender: TObject);
    procedure ActionOptionsQualitePoseExecute(Sender: TObject);
    procedure ActionOptionsTypePartieDureeExecute(Sender: TObject);
    procedure ActionOptionsTypePartieTirageExecute(Sender: TObject);
    procedure ActionPartieNouvelleExecute(Sender: TObject);
    procedure ActionPartieOuvrirExecute(Sender: TObject);
    procedure ActionPartieEnregistrerSousExecute(Sender: TObject);
    procedure ActionPartieEnregistrerExecute(Sender: TObject);
    procedure ActionPartieQuitterExecute(Sender: TObject);
    procedure ActionPartieDemonstrationExecute(Sender: TObject);
    procedure ActionPlacementExecute(Sender: TObject);
    procedure ActionTestPlacementHorizontalExecute(Sender: TObject);
    procedure ActionTestPlacementVerticalExecute(Sender: TObject);
    procedure ActionVideExecute(Sender: TObject);
  private
    TaillePlateau,
    TaillePolice,
    TailleCase,
    ChoixColonne,
    ChoixLigne,
    Choix1Colonne, // v1.4.1 (clavier)
    Choix1Ligne,   // v1.4.1 (clavier)
    xPopup,
    yPopup                  : Integer;
    ChoixDirection          : TDirection;
    RafraichissementEnCours,
    MelangeJetonsEnCours, // Permet d'éviter les événements en boucle lors du redimensionnement
    DestructionEnCours      : Boolean;
    stFNomFichierPartie,
    stVersion,
    stSousVersion           : String; // v1.5
    FChoixPoseClavierEnCours, // v1.4.1
    FMelangeEnCours, // v1.1
    FPartieModifiee,
    FReflexionEnCours       : Boolean;
    FTypePartie             : TTypePartie; // v1.5.6
    FTempsReflexion         : TTempsReflexion; // v1.5.6
    TopChrono, FinChrono    : TDateTime;
    function ModeDemonstration : Boolean;
    procedure ChangeStatutMelange(const NvStatutMelange : Boolean); // v1.1
    procedure ChangeModeDemonstration(const NvModeDemonstration : Boolean);
    procedure ChangeStatutPartie(const NvStatutPartie : Boolean);
    procedure ChangeNomFichierPartie(const stNvNomFichierPartie : String);
    procedure ChangeStatutReflexionEnCours(const NvStatutReflexionEnCours : Boolean);
    procedure AfficheTitre;
    procedure AfficheCoordonnees(const X, Y : Integer; const MontreCase : Boolean);
    procedure DessineCase(const X, Y : TCoordonnee; const MontreCase : Boolean);
    procedure DessinePlacement(const X, Y : TCoordonnee; const d : TDirection);
    procedure OuvrePartie(const stNomFichier : String);
    procedure DetermineVersion;
  //procedure EnregistreExtension; // v1.6.4
    procedure DefinitDimensionsParDefaut(var FormMainClientWidth, FormMainClientHeight : Integer);
    procedure ChargeOptions; // v1.3.2
    procedure EnregistreOptions;  // v1.3.2
    procedure ReinitialiseOptions;  // v1.3.2
    function TesteMelangeEnCours : Boolean;  // v1.3.4 : Evite d'enregistrer une partie terminée...
    procedure EnregistrePartie; // v1.4.9
    procedure GenereListePartiesJouees(const Affichage : Boolean); // v1.4.9
    procedure NotifieAction(Action : TActionANotifier; Activee : Boolean); // v1.5 : Notification des actions sur la barre de statut
    procedure ChangeTypePartie(const TypePartie : TTypePartie); // 1.5.6
    procedure ChangeTempsReflexion(const TempsReflexion : TTempsReflexion); // v1.5.6
  public
    EmpecheTempsImparti,     // v1.5 : Permet d'empêcher que le message Temps imparti apparaisse mais permet de rafraîchir le temps écoulé et ainsi effacer les pb de rafraîchissement de la zone Temps ("Partie" apparaissait après un AfficheMessage)
    PlacementPropositionAuto, // v1.6.9
    TestPlacementEnCours : Boolean; // v1.5.2. Uniquement pour la saisie des coordonnées de la case cible au clavier (#[1~15][A~O])
    procedure GenereListeRecords(const Affichage : Boolean); // v1.5
    property ChoixPoseClavierEnCours : Boolean read FChoixPoseClavierEnCours; // v1.4.1
    property MelangeEnCours : Boolean read FMelangeEnCours write ChangeStatutMelange; // v1.1
    property stNomFichierPartie : String read stFNomFichierPartie write ChangeNomFichierPartie;
    property PartieModifiee : Boolean read FPartieModifiee write ChangeStatutPartie;
    property ReflexionEnCours : Boolean read FReflexionEnCours write ChangeStatutReflexionEnCours;
    property DemoEnCours : Boolean read ModeDemonstration write ChangeModeDemonstration;
    property TypePartie : TTypePartie read FTypePartie write ChangeTypePartie; // v1.5.6
    property TempsReflexion : TTempsReflexion read FTempsReflexion write ChangeTempsReflexion; // v1.5.6
    function AfficheMessage(const stMessage, stTitre : String; Options : Integer) : Integer;
    procedure DessineCoordonnees; // v1.3.9
    procedure DessinePlateau;
    procedure PoseProposition(const X, Y : TCoordonnee; const d : TDirection; const Chevalet : TChevalet; const Debut, Fin : TOrdreJetonChevalet);
    procedure RetireProposition(const X, Y : TCoordonnee; const d : TDirection);
  end;
//---------------------------------------------------------------------------
var
  FormMain: TFormMain;
  stTitrePlateau                : String = 'Word  Killer'; // v1.1 (const -> var) Pour changer l'initiale selon s'il y a mélange ou non
//---------------------------------------------------------------------------
const
  CouleurBonus                  : array [TBonus] of TColor = ( clSilver,   clBlue, clLime, clMaroon, $000080FF, clFuchsia);
  CouleurFondJeton              : array [Boolean] of TColor = ($C0FFFF, $60FFFF);
  CouleurEncreJeton             : array [ValeurJetonMin..ValeurJetonMax] of TColor = (clBlack, clBlack, clBlack, clBlack, clBlack, clBlack, clBlack, clBlack, clPurple, clBlack, clMaroon); // v1.6
  CouleurEncreJoker             : TColor = $B0AAAA;
  CouleurChoixCase              : TColor = clWhite;
  CouleurEncreSubstitutJoker    : TColor = clGreen;
  CouleurEncreSubstitutJokerFdM : TColor = clLime;
  CouleurEncreRecordTypePartie  : array [TTypePartie] of TColor = (clBlack, clBlack, clGreen); // v1.5.7

  // Pour FormParamPoseAuto (v1.5.5)
  stSectionParametres           : string = 'Paramètres';
  stEntreeOptionTQP             : string = 'TQP';// Type de Qualité de la Pose (v1.5.5)
  stEntreeOptionPQP             : string = 'PQP';// Proportion de la Qualité de la Pose (v1.5.5)
  stEntreeOptionTR              : string = 'TR'; // Temps de réflexion (v1.5.6)
  stEntreeOptionTP              : string = 'TP'; // Type Partie (v1.5.6)
  // Pour FormDefinitions (v1.6)
  stEntreeActionsSD             : string = 'SD'; // Source des définitions de mots (v1.6)

  stResolutionMinimale          = 'Le mode d''affichage 800x600 est au minimum conseillé.';
  stResolution                  = 'Résolution';
  stPlacementImpossible         = 'Placement impossible'; // v1.4 : publique car utilisée par FormPropositionPose
  stConfirmation                = 'Confirmation'; // v1.5 (factorisation)
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.Math, System.StrUtils, System.IniFiles, System.UITypes, Winapi.ShellApi,
  cststr, tirage_f, listemots_f, saisietirage_f, definition_f, rechdico_f, fdmatch_f,
  statspartie_f, situationjetons_f, propos_f, prmpose_f, solutions_f, propose_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
type
  TInfoBarreStatut          = (ibsMessage, ibsTemps, ibsCoordonnees);
//---------------------------------------------------------------------------
const
  HauteurLargeurCoordonnees     = 32; // v1.3.9
  TailleMinPlateauDefaut        = 392; // v1.4 : taille plateau minimum par défaut (1024x768). En dessous, on réduit le chevalet
  TailleMinPlateau              = 212; // v1.3.9
  // v1.4.8 : '(Cumul=%d%s)' retiré. v1.5 : ligne raccourcie. v1.5.5 : ajout score§Top et rang déplacé
  // v1.6 : temps de calcul : ajout de " en %.2f s (%.1f sol/s)"
  // v1.6 : la note cumulée a été supprimée. La phrase a été revue (note avant le rang).
  stFrmSolutionsProposition     = '%d solutions en %.2f s (%.0f sol/s). Votre coup de %d pts sur un top de %d (soit %.1f%s) est classé %d%s.';
  stFormatTitre                 = '%s%s%s';
  stFormatDuree                 = '%2d:%2d'; // v1.4.9
  stPartieTerminee              = 'Partie terminée.';
  stEtatSaisiePrmCase           : array [Boolean] of String = ('Saisie des coordonnées de la case cible interrompue...',
                                                           'Saisie des coordonnées de la case cible (1~15 puis A~O)...');
  stFormatTitreFichierPartie    : array [0..1] of String = ('', ' - %s');
  stIndicateurPartieModifiee    : array [0..1] of String = ('', '*');
  MontreCase                    : Boolean    = True;  // Pour AfficheCoordonnees & DessineCase
  NeMontrePasCase               : Boolean    = False; // Pour AfficheCoordonnees & DessineCase
  // v1.3.2
  stEntreeOptionJRS             : string = 'JRS';// Journal de Recherche des Solutions
  stEntreeOptionTL              : string = 'TL'; // Temps Limité
  stEntreeOptionPIS             : string = 'PIS';// Propositions Invalides Santionnées
  stEntreeOptionGAF             : string = 'GZF';// Générer automatiquement la FDM (v1.3.5)
  stEntreeOptionLTS             : string = 'LTS';// Lister Toutes les solutions (v1.3.6)
  stEntreeOptionEPA             : string = 'EPA';// Enregistrer Partie Auto (v1.5)
  stEntreeOptionPPA             : string = 'PPA'; // Placer Proposition Auto (v1.6.9)
  stEntreeOptionEEQ             : string = 'EEQ';// Enregistrer les paramètres En Quittant (v1.6.5)
  stEntreeAffichageNR           : string = 'NR'; // Nouveaux records (v1.5)
  stEntreeAffichageFR           : string = 'FR'; // Format rapports (% ou /20)
  stEntreeDimensionsLP          : string = 'LP'; // Largeur plateau
  stEntreeDimensionsHP          : string = 'HP'; // Hauteur plateau
  stEntreeDimensionsLT          : string = 'LT'; // Largeur Tirage
  stEntreeDimensionsHT          : string = 'HT'; // Hauteur Tirage
  stEntreePartiesNbParties      : string = 'NP'; // v1.4.9 : Nombre de parties
  stEntreePartiesNom            : string = 'N';  // v1.4.9 : Nom de partie (nom du fichier, vide si non enregistrée
  stEntreePartiesNbCoups        : string = 'NC'; // v1.4.9 : Nombre de coups joués
  stEntreePartiesReliquat       : string = 'R';  // v1.4.9 : Reliquat
  stEntreePartiesScore          : string = 'S';  // v1.4.9 : Score
  stEntreePartiesJoue           : string = 'J';  // v1.4.9 : Score (joué)
  stEntreePartiesTop            : string = 'T';  // v1.4.9 : Score (top)
  stEntreePartiesTemps          : string = 'TR'; // v1.4.9 : Temps de réflexion
  stEntreePartiesRgMoyen        : string = 'RM'; // v1.4.9 : Rang moyen
  stEntreePartiesNbSolMoyen     : string = 'NSM';// v1.4.9 : Nb moyen de solutions
  stEntreePartiesNbSolBonus     : string = 'NSB';   // v1.5: Nb solutions avec bonus 50
  stEntreePartiesNbSolSEMT      : string = 'NSSEMT';// v1.5: Nb solutions >= 50% Top (pour le calcul du Niveau de difficulté)
  stEntreePartiesNivDiffPondere : string = 'NDP';  // v1.5.1: Indique Oui ou Non si le niveau de difficulté a été pondéré
  stEntreePartiesDateHeure      : string = 'DH';   // v1.5: Date/Heure
  stEntreePartiesTypePartie     : string = 'TP';   // v1.5.6: Type Partie. Ord(TTypePartie)
  stEntreePartiesTpsCalcSol     : string = 'TCS';  // v1.6: Temps de calcul des solutions (Cumul)
  stSectionAffichage            : string = 'Affichage';
  stSectionDimensions           : string = 'Dimensions';
  stSectionParties              : string = 'Parties'; // v1.4.9

  // v1.5 :
  Actif                         : Boolean    = True; // v1.5 : pour stMsgNotificationAction
  Inactif                       : Boolean    = False; // v1.5 : pour stMsgNotificationAction
  stMsgNotificationAction       : array [TActionANotifier, Boolean] of string
                                = (('',''),//aanAucune,
                                   ('','Nouvelle partie commencée'),//aanPartieNouvelle,
                                   ('Démonstration INTERROMPUE.','Démonstration en cours... Appuyer sur %s pour interrompre.'),//aanPartieDemonstrationCAC,
                                   ('','Partie CHARGÉE.'),//aanPartieOuvrir,
                                   ('','Partie ENREGISTRÉE.'),//aanPartieEnregistrer,
                                   ('La journalisation de la recherche des solutions est ARRÊTÉE.','La journalisation de la recherche des solutions est DÉMARRÉE.'),//aanOptionsJournalRechercheSolutionsCAC,
                                   ('La feuille de match détaillée N''EST PLUS générée automatiquement.','La feuille de match détaillée EST générée automatiquement.'),//aanOptionsGenererAutoFeuilleDeMatchCAC,
                                   ('La liste des solutions N''EST PLUS générée et affichée à chaque tour.','La liste des solutions EST générée et affichée à chaque tour.'),//aanOptionsGenererAfficherSolutionsCAC,
                                   ('Le temps de réflexion N''EST PLUS limité.','Le temps de réflexion EST limité.'),//aanOptionsTempsLimiteCAC,
                                   ('Les propositions invalides NE SONT PLUS sanctionnées.','Les propositions invalides SONT sanctionnées.'),//aanOptionsProposititionsInvalidesCAC,
                                   ('','Les paramètres actuels ont été ENREGISTRÉS.'),//aanOptionsEnregistrerParametres,
                                   ('Les paramètres NE SONT PAS AUTOMATIQUEMENT ENREGISTRÉS en quittant.', 'Les paramètres SONT AUTOMATIQUEMENT ENREGISTRÉS en quittant.'),//aanOptionsEnregistrerParametresEnQuittantCAC // v1.6.5
                                   ('','Les paramètres par défaut ont été RÉTABLIS (NON enregistrés).'),//aanOptionsRetablirParametres,
                                   ('','Les derniers paramètres enregistrés ont été RÉTABLIS.'),//aanOptionsAppliquerParametres,
                                   ('La liste des parties jouées N''A PAS été réinitialisée.','La liste des parties jouées a été RÉINITIALISÉE.'),//aanOptionsViderListePartiesJoueesCAC,
                                   ('La partie N''EST PLUS automatiquement enregistrée après chaque coup.','La partie EST automatiquement ENREGISTRÉE après chaque coup.'),//aanOptionsEnregistrerPartieAutoCAC
                                   ('La meilleure solution est placée automatiquement.', 'La proposition est placée automatiquement.'),//aanOptionsPlacerPropositionAutoCAC // v1.6.9
                                   ('Les records N''ONT PAS été RÉINITIALISÉS.','Les records ont tous été RÉINITIALISÉS.'),//aanOptionsReinitialiserRecordsCAC,
                                   ('','La durée d''une partie a été fixée à 1 minute (partie Blitz).'), //aanOptionsTypePartieBlitz, // v1.5.6
                                   ('','La durée d''une partie a été fixée à 2 minutes (partie semi-rapide).'), //aanOptionsTypePartieSemiRapide, // v1.5.6
                                   ('','La durée d''une partie a été fixée à 3 minutes (partie normale).'),//aanOptionsTypePartieNormale, // v1.5.6
                                   ('','Le type de partie "standard" est ACTIVÉ.'), //aanOptionsTypePartieStandard, // v1.5.6
                                   ('','Le type de partie "joker" est ACTIVÉ.'), //aanOptionsTypePartieJoker, // v1.5.6
                                   ('Vous N''avez PAS passé votre tour.','Vous avez PASSÉ votre tour.'),//aanActionPasserSonTourCAC,
                                   ('Vous N''avez PAS PU changer le tirage.','Vous avez CHANGÉ le tirage.'),//aanActionChangerTirageCAC,
                                   ('Le chevalet a été MASQUÉ.','Le chevalet a été AFFICHÉ.'),//aanAffichageTirageCAC,
                                   ('La feuille de match a été MASQUÉE.','La feuille de match a été AFFICHÉE.'),//aanAffichageFeuilleDeMatchCAC,
                                   ('Le graphe d''évolution a été MASQUÉ.','Le graphe d''évolution a été AFFICHÉ.'),//aanAffichageGrapheEvolutionCAC,
                                   ('Les nouveaux records N''apparaîtront PLUS en temps réel.', 'Les nouveaux records APPARAÎTRONT en temps réel.'),//aanAffichageNouveauxRecordsCAC,
                                   ('','La feuille de match détaillée a été AFFICHÉE.'),//aanAffichageFdMDetaillee,
                                   ('La liste des parties jouées a été MISE À JOUR.','La liste des parties jouées a été MISE À JOUR et AFFICHÉE.'),//aanAffichagePartiesJouees,
                                   ('La liste des records a été MISE À JOUR.','La liste des records a été MISE À JOUR et AFFICHÉE.'),//aanAffichagePartiesJouees,
                                   ('La liste des défis n°1 a été MISE À JOUR.','La liste des défis n°1 a été MISE À JOUR et AFFICHÉE.'),//aanAffichageDefis1M15LCAC,
                                   ('Les rapports sont sous forme de POURCENTAGES.','Les rapports sont sous forme de NOTES SUR 20.'));//aanAffichageRapportsFormatCAC);
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsChangerTirageExecute(Sender: TObject);
begin
if not ReflexionEnCours then Exit;
if AfficheMessage('Êtes-vous sûr(e) de bien vouloir changer tout le tirage ?', // v1.5
                  stConfirmation,
                  MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDNO then Exit;
if p.ProchainJetonATirer>NbJetonsSac-NbMaxJetonsTirage+1 then
  begin
  AfficheMessage(Format('Vous ne pouvez pas changer le tirage s''il reste moins de %d jetons dans le sac.',
                        [NbMaxJetonsTirage]),
                 'Changement impossible', MB_ICONHAND);
  NotifieAction(aanActionChangerTirageCAC, Inactif); // v1.5
  Exit
  end;
if FormTirage<>nil then
  begin
  FormTirage.ChangeTirage;
  NotifieAction(aanActionChangerTirageCAC, Actif) // v1.5
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsListerMotsLettresCheresExecute(
  Sender: TObject);
begin // v1.6
FormListeMots:=TFormListeMots.Create(Self);
with FormListeMots do
  try
    ShowModal;
  finally
    Release
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsPasserSonTourExecute(Sender: TObject);
begin
if not DemoEnCours and
   not ReflexionEnCours then Exit;
if DemoEnCours or
   (AfficheMessage('Êtes-vous sûr(e) de vouloir passer votre tour ?',
                   stConfirmation, // v1.5 (factorisation)
                   MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=IDYES) then
  begin
  if DemoEnCours then // v1.5
    NotifieAction(aanPartieDemonstrationCAC, Actif)
  else
    NotifieAction(aanActionPasserSonTourCAC, Actif);
  ActionPlacementExecute(Sender)
  end
else
  NotifieAction(aanActionPasserSonTourCAC, Inactif); // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsProposerTirageExecute(Sender: TObject);
begin
if not ReflexionEnCours then Exit;
with FormSaisieTirage do
  if ShowModal=mrOk then
    begin
    p.TirageOKVerifieSiNecessaire(FormTirage.Chevalet); // v1.5.6. Rq : Chevalet est transmis pour rien car il est chargé dans ChargeTirage
    FormTirage.ChargeTirage;
    end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsRechercherDefinitionMotExecute(
  Sender: TObject);
begin // v1.6
FormDefinitionMot.ShowModal
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionActionsRechercherMotsExecute(Sender: TObject);
begin
FormRechercheMots.ShowModal
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageFeuilleMatchDetailleeExecute(
  Sender: TObject);
var stNomFichierFdMD : String;
begin
if stNomFichierPartie='' then
  if ActionOptionsGenererAutoFDM.Tag=0 then // v1.3.5
    stNomFichierFdMD:=stRepLocalAppData+'WordKillers.wkp' // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  else
    begin
    ActionOptionsGenererAutoFDM.Tag:=0;
    Exit // On ne génère pas automatiquement de feuille de match si un nom de partie n'est pas défini.
    end
else
  stNomFichierFdMD:=stNomFichierPartie;
p.GenereFeuilleMatchDetaillee(Copy(stNomFichierFdMD,
                                   1,
                                   Length(stNomFichierFdMD)-
                                   Length(ExtractFileExt(stNomFichierFdMD)))+'.html',
                                   ActionOptionsGenererAutoFDM.Tag=0); // v1.3.5 (Pas d'affichage si génération auto)
if ActionOptionsGenererAutoFDM.Tag=0 then // v1.5
  NotifieAction(aanAffichageFdMDetaillee, Actif)
else
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:='La feuille de match détaillée a été MISE À JOUR.';
ActionOptionsGenererAutoFDM.Tag:=0
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageFeuilleMatchExecute(Sender: TObject);
begin
with FormFeuilleMatch do
  if (Sender as TAction).Checked then
    Show
  else
    Hide;
NotifieAction(aanAffichageFeuilleDeMatchCAC, FormFeuilleMatch.Visible) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageGrapheEvolutionExecute(Sender: TObject);
begin
with FormStatsPartie do
  if (Sender as TAction).Checked then
    Show
  else
    Hide;
NotifieAction(aanAffichageGrapheEvolutionCAC, FormStatsPartie.Visible) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageListeDefisReleves1M15LExecute(
  Sender: TObject);
begin // v1.5.3
d15l.GenereListeDefis(stRepLocalAppData+ // stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
                      stNomFichierDefi1M15L,
                      Affiche);
NotifieAction(aanAffichageDefi1M15LCAC, Affiche)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichagePartiesJoueesExecute(Sender: TObject);
begin // v1.4.9
GenereListePartiesJouees(Affiche)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsRapportsExecute(Sender: TObject);
begin
FormatRapport:=TFormatRapport((Sender as TAction).Tag);
NotifieAction(aanAffichageRapportsFormatCAC, Boolean(Ord(FormatRapport))) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageRecordsExecute(Sender: TObject);
begin // v1.5
GenereListeRecords(Affiche)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageSituationJetonsExecute(Sender: TObject);
begin // v1.2
FormSituationJetons:=TFormSituationJetons.Create(Self);
with FormSituationJetons do
  try
    ShowModal
  finally
    Release
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionAffichageTirageExecute(Sender: TObject);
begin
with FormTirage do
  if (Sender as TAction).Checked then
    Show
  else
    Hide;
NotifieAction(aanAffichageTirageCAC, FormTirage.Visible) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionInfosAideExecute(Sender: TObject);
begin
OuvreFichierHTML(ExtractFilePath(Application.ExeName)+'html/index.html'); // v1.4.6
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionInfosAProposExecute(Sender: TObject);
begin
FormAPropos:=TFormAPropos.Create(self);
with FormAPropos do
 try
   LabelVersion.Caption:=stVersion;
   LabelVersionOmbre.Caption:=stVersion; // v1.6
   LabelSousVersion.Caption:=stSousVersion;
   ShowModal;
 finally
   Release;
 end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionInfosInternesExecute(Sender: TObject);
// v1.5.6 : ajout du temps de réflexion (Partie/Word Killers)
// v1.8.4 : affichage 32/64 bits dans les informations internes après la version de Word Killers
const stFrmInfoPartie = 'Partie'#13#13' · Nom : %s.'#13' · Numéro : %s.'#13' · Version du format de fichier de partie : %3X.'#13' · Type de partie : %s.'#13' · Temps de réflexion : %s.'#13#13+
                        'Word Killers'#13#13' · Version : %s (%d bits)'#13' · Prochain n° de partie : %d.'#13' · Version courante du format de fichier de partie : %X.'#13' · Type de partie : %s.'#13' · Temps de réflexion : %s.';
begin // v1.5.3
if p<>nil then // v1.5.6
  AfficheMessage(Format(stFrmInfoPartie,
                        [IfThen(p.stNomPartie='','N/A',p.stNomPartie),
                         IfThen(p.NumeroPartie=0,'N/A',IntToStr(p.NumeroPartie)),
                         p.VersionFichier,
                         stTypePartie[p.TypePartie], // v1.5.6
                         stTempsReflexion[p.TempsReflexion], // v1.5.6
                         stVersion+stSousVersion,
// v1.8.4 : affichage 32/64 bits dans les informations internes après la version de Word Killers
{$IFDEF WIN32}
                         32,
{$ENDIF}
{$IFDEF WIN64}
                         64,
{$ENDIF}
                         p.ProchainNumeroPartie(LectureSeule),
                         VersionFichierCrt,
                         stTypePartie[TypePartie], // v1.5.6
                         stTempsReflexion[TempsReflexion] // v1.5.6
                        ]), 'Informations internes',
                      MB_ICONINFORMATION+MB_OK)
else
  AfficheMessage(Format(stFrmInfoPartie,
                        ['N/A',
                         'N/A',
                         'N/A',
                         stVersion+stSousVersion,
                         'N/A',
                      VersionFichierCrt]), 'Informations internes',
                      MB_ICONINFORMATION+MB_OK)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsAppliquerExecute(Sender: TObject);
begin // v1.5.3
ChargeOptions;
with FormTirage do
  if Visible then begin Hide; Show end;
with FormFeuilleMatch do
  if Visible then begin Hide; Show end;
NotifieAction(aanOptionsAppliquerParametres, Actif)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsEnregistrerExecute(Sender: TObject);
begin // v1.3.2
EnregistreOptions
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsJournalRechercheExecute(Sender: TObject);
begin
stNomFichierJournal:=stRepLocalAppData+'wordkillers.log'; // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
Journalisation:=ActionOptionsJournalRecherche.Checked;
if Journalisation then
  begin
  AssignFile(Journal, stNomFichierJournal);
  Rewrite(Journal);
  JournalOuvert:=True; // v1.5 : Empêche le Try CloseFile(Journal)
  NotifieAction(aanOptionsJournalRechercheSolutionsCAC, Actif) // v1.5
  end
else
  try
    if not JournalOuvert then Exit; // v1.5 : Empêche le Try CloseFile(Journal)
    CloseFile(Journal);
    JournalOuvert:=False; // v1.5 : Empêche le Try CloseFile(Journal)
    NotifieAction(aanOptionsJournalRechercheSolutionsCAC, Inactif); // v1.5
    ShellExecute(0,
                 'Open',
                 pChar(ExtractFileName(stNomFichierJournal)), // v1.4
                 Nil,
                 pChar(ExtractFilePath(stNomFichierJournal)), // v1.4
                 SW_SHOWNORMAL)
  except
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsListeToutesSolutionsExecute(Sender: TObject);
begin // v1.3.6
StockageSolutions:=ActionOptionsListeToutesSolutions.Checked;
NotifieAction(aanOptionsGenererAfficherSolutionsCAC, StockageSolutions) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsQualitePoseExecute(Sender: TObject);
begin
FormParamPose.ShowModal
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsReinitialiserExecute(Sender: TObject);
begin // v1.3.2
ReinitialiseOptions
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsReinitialiserRecordsExecute(Sender: TObject);
var IniFile : TIniFile;
begin // v1.4.9
if AfficheMessage('Êtes-vous sûr(e) de vouloir réinitialiser tous les records ?',
                  stConfirmation, // v1.5 (factorisation)
                  MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES then
  try
    IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
    IniFile.EraseSection(stSectionRecords);
    r.Charge; // v1.6.1
    NotifieAction(aanOptionsReinitialiserRecordsCAC, Actif); // v1.5
  finally
    FreeAndNil(IniFile);
  end{try}
else
  NotifieAction(aanOptionsReinitialiserRecordsCAC, Inactif) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsTypePartieDureeExecute(Sender: TObject);
var ActionTypePartie : TAction;
    NvTypePartie     : TTempsReflexion;
begin
if not MelangeEnCours then
  AfficheMessage('Le temps de réflexion de la partie en cours n''est pas modifié.'#13#13'Le nouveau choix sera appliqué lors de la prochaine partie.', 'Temps de réflexion', MB_ICONEXCLAMATION);
ActionTypePartie:=Sender as TAction;
NvTypePartie:=TTempsReflexion(ActionTypePartie.Tag);
ChangeTempsReflexion(NvTypePartie);
NotifieAction(TActionANotifier(Ord(aanOptionsTypePartieBlitz)+Ord(NvTypePartie)-1), ActionTypePartie.Checked)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsTypePartieTirageExecute(Sender: TObject);
var ActionTypePartie : TAction;
    NvTypePartie     : TTypePartie;
begin
if not MelangeEnCours then
  AfficheMessage('Le type de la partie en cours n''est pas modifié.'#13#13'Le nouveau type de partie sera appliqué lors de la prochaine partie.', 'Type de partie', MB_ICONEXCLAMATION);
ActionTypePartie:=Sender as TAction;
NvTypePartie:=TTypePartie(ActionTypePartie.Tag);
ChangeTypePartie(NvTypePartie);
NotifieAction(TActionANotifier(Ord(aanOptionsTypePartieStandard)+Ord(NvTypePartie)-1), ActionTypePartie.Checked)
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionOptionsViderListePartiesJoueesExecute(
  Sender: TObject);
var IniFile : TIniFile;
begin // v1.4.9
if AfficheMessage('Êtes-vous sûr(e) de vouloir vider la liste des parties jouées ?',
                  stConfirmation, // v1.5 (factorisation)
                  MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES then
  try
    IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
    IniFile.EraseSection(stSectionParties);
    NotifieAction(aanOptionsViderListePartiesJoueesCAC, Actif); // v1.5
  finally
    FreeAndNil(IniFile);
  end{try}
else
  NotifieAction(aanOptionsViderListePartiesJoueesCAC, Inactif) // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieDemonstrationExecute(Sender: TObject);
begin
DemoEnCours:=not DemoEnCours;
if not DemoEnCours then
  NotifieAction(aanPartieDemonstrationCAC, Inactif); // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieEnregistrerExecute(Sender: TObject);
var FdMAffichee,            // v1.5
    TimerEnabled : Boolean; // v1.5
begin
if TesteMelangeEnCours then Exit; // v1.3.4 : Evite d'enregistrer une partie terminée...
if ReflexionEnCours then // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
  begin
  TimerEnabled:=TimerReflexion.Enabled;
  if TimerEnabled then
    EmpecheTempsImparti:=True
  end
else
  TimerEnabled:=False;
if (stNomFichierPartie='') then
  if SaveDialog.Execute then
    stNomFichierPartie:=SaveDialog.FileName
  else
    begin
    if ReflexionEnCours and TimerEnabled then
      EmpecheTempsImparti:=False; // v1.5
    Exit
    end;
try
  with FormTirage do
    p.Sauve(stNomFichierPartie,
            Chevalet,
            ChoixDebut, ChoixFin,
            xPopup,     yPopup);
  if r.AssocieNomPartie then // v1.5 : On a un nom de partie : on l'associe tout de suite à ses records !
    GenereListeRecords(NAffichePas); // Si un record modifié, on regénère la liste des records.
  with FormFeuilleMatch do // v1.5 : au lieu de with FormFeuilleMatch.RichEdit.Lines
    begin
    FdMAffichee:=Visible; // v1.5
    if FdMAffichee then Visible:=False; // v1.5
    try // v1.5
      InverseCouleurTexte; // v1.5. FdM : blanc sur fond noir. Fichier RTF : noir sur fond blanc
      RichEdit.Lines.SaveToFile(Copy(stNomFichierPartie,
                                1,
                                Length(stNomFichierPartie)-
                                Length(ExtractFileExt(stNomFichierPartie)))+'.rtf');
      InverseCouleurTexte; // v1.5. FdM : blanc sur fond noir. Fichier RTF : noir sur fond blanc
    finally // v1.5
      if FdMAffichee then Visible:=True; // v1.5
    end // v1.5
    end;
finally
  PartieModifiee:=False;
  NotifieAction(aanPartieEnregistrer, Actif); // v1.5
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieEnregistrerSousExecute(Sender: TObject);
var TimerEnabled : Boolean; // v1.5
begin
if TesteMelangeEnCours then Exit; // v1.3.4 : Evite d'enregistrer une partie terminée...
if ReflexionEnCours then // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
  begin
  TimerEnabled:=TimerReflexion.Enabled;
  if TimerEnabled then
    EmpecheTempsImparti:=True
  end
else
  TimerEnabled:=False;
if SaveDialog.Execute then
  begin
  stNomFichierPartie:=SaveDialog.FileName;
  ActionPartieEnregistrerExecute(Sender);
  end;
if ReflexionEnCours and TimerEnabled then
  EmpecheTempsImparti:=False // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieNouvelleExecute(Sender: TObject);
begin
if PartieModifiee and not MelangeEnCours then // v1.3.4 : Pas de confirmation si fin de partie (MelangeEnCours)
  begin
  if AfficheMessage('Une partie est en cours, êtes-vous sûr(e) de vouloir abandonner et en commencer une nouvelle ?',
                    stConfirmation, // v1.5 (factorisation)
                    MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDNO then
    Exit
  end;
if (stNomFichierPartie<>'') or (p.Tour>1) then
  begin
  MelangeEnCours:=True; // v1.1
  AfficheMessage('Veuillez attendre un instant avant de commencer une nouvelle partie, le temps que les jetons soient mélangés...'#13#10#13#10+
                 'Appuyez sur [OK] lorsque vous souhaitez commencer.',
                 'Mélange des jetons', MB_ICONINFORMATION);
  MelangeEnCours:=False // v1.1
  end{if PartieModifiee}
else
  MelangeEnCours:=False; // v1.1
p.TypePartie:=TypePartie; // v1.5.6
p.TempsReflexion:=TempsReflexion; // v1.5.6
PartieModifiee:=False;
stNomFichierPartie:='';
StatusBar.Panels.Items[Ord(ibsMessage)].Text:='';
p.CommencePartie;
DessinePlateau;
with FormTirage do
  ChargeTirage;
with FormFeuilleMatch do
  begin
  if Visible then Hide;
  InitialisePartie;
  Show
  end{with};
NotifieAction(aanPartieNouvelle, Actif); // v1.5, à la place de StatusBar.Panels.Items[Ord(ibsMessage)].Text:='Nouvelle partie commencée.';
if DemoEnCours then
  TimerDemonstration.Enabled:=True
else
  ReflexionEnCours:=True
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieOuvrirExecute(Sender: TObject);
var TimerEnabled : Boolean; // v1.5
begin
if ReflexionEnCours then // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
  begin
  TimerEnabled:=TimerReflexion.Enabled;
  if TimerEnabled then
    EmpecheTempsImparti:=True
  end
else
  TimerEnabled:=False;
if PartieModifiee and not MelangeEnCours and // v1.3.4 : Pas de confirmation si fin de partie (MelangeEnCours)
   (AfficheMessage('Une partie est en cours, êtes-vous sûr(e) de vouloir abandonner et ouvrir une partie sauvegardée ?',
                   stConfirmation, // v1.5 (factorisation)
                   MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDNO) then
  begin
  if ReflexionEnCours and TimerEnabled then EmpecheTempsImparti:=False; // v1.5
  Exit
  end;
if OpenDialog.Execute then // v1.1 : mélange désactivé dans OuvrePartie
  OuvrePartie(OpenDialog.FileName)
else
  if ReflexionEnCours and TimerEnabled then EmpecheTempsImparti:=False // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPartieQuitterExecute(Sender: TObject);
begin
Close
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionPlacementExecute(Sender: TObject);
const stResultat          = 'Résultat'; // v1.4.9
      stTirageInsuffisant = 'Tirage insuffisant ou plus de jetons. Partie terminée.'#13#13'Voulez-vous sauvegarder la fin de partie ?'; // v1.5 : On propose de sauvegarder la partie terminée
      stAucuneSolution    = 'Aucune solution trouvée. Partie terminée.'#13#13'Voulez-vous sauvegarder la fin de partie ?'; // v1.4.9
      stFrmInfoPose       = 'avec %s en %s';
var i, j, // v1.4.4
    NbJetonsAPlacer,
    ScoreProposition,
    ScorePose            : Integer; // v1.4
    stStatistiquePrpSol  : String;
    slSolutions          : TStringList;
    Prc (*, CumulPrc*)   : Double; // CumulPrc supprimé de l'affichage
    stPrmProposition     : String;
    ChoixFait,           // v1.4
    TestPlacement        : Boolean; // v1.5.2
    d                    : TDirection; // v1.4
    X, Y                 : TCoordonnee; // v1.4
    Debut, Fin           : TOrdreJetonChevalet; // v1.4
    Solution             : TSolution; // v1.4

  procedure Sanctionne;
  begin
  if not DemoEnCours then // v1.6.3
    ReflexionEnCours:=False; // On arrête le chrono car on sait qu'à partir d'ici c'est joué
  ScoreProposition:=0;
  p.stProposition[p.Tour]:=''
  end;

begin
// v1.5.2 : inclut le test de placement (Tag>2 de PopuMenuTestPlacement)
ChoixDirection:=TDirection(1+((Sender as TAction).Tag-1) mod 2); // Le tag des actions donne la direction. 0=Passer son tour
TestPlacement:=((Sender as TAction).Tag>2); // v1.5.2
if ReflexionEnCours and
  (ChoixDirection>dIndefinie) then
  begin
  NbJetonsAPlacer:=p.NbJetonsAPlacer(FormTirage.Chevalet,
                                     FormTirage.ChoixDebut, FormTirage.ChoixFin);
  case NbJetonsAPlacer of // v1.5 pour le cas NbJetonsAPlacer=1
  0:begin
    AfficheMessage('Vous devez sélectionner les lettres à placer AVANT de choisir la case. Pour ce faire...'#13#13+
                   'À la souris :'#13+
                   ' - Regroupez ensemble tous les jetons à placer ;'#13+
                   ' - Cliquez avec le bouton droit de la souris sur le premier jeton à placer, puis'#13+
                   ' - En maintenant enfoncé le bouton droit, déplacez le pointeur jusqu''au dernier jeton à placer, et enfin'#13+
                   ' - Relâchez le bouton : les lettres sélectionnées apparaissent en rouge.'#13#13+
                   'Au clavier :'#13+
                   ' - Regroupez ensemble tous les jetons à placer (en utilisant les chiffres, les touches fléchées et les touches Début et Fin) ;'#13+
                   ' - Appuyez sur la touche « * » ;'#13+
                   ' - Tapez le chiffre correspondant à la position du premier jeton à placer (1 pour le premier, 2 pour le deuxième, etc.) ;'#13+
                   ' - Tapez le chiffre correspondant à la position du dernier jeton à placer : les lettres sélectionnées apparaissent en rouge.'#13#13+
                   'Appuyez sur la touche F1 pour plus d''informations sur la sélection des jetons à poser.',
                   stPlacementImpossible, MB_ICONEXCLAMATION);
    Exit // Pas de sanction... C'est un oubli !
    end;
  1:begin // v1.5 : on teste le cas où le choix de la direction n'est pas celle d'un mot
    if p.JetonIsoleDirectionChoix(ChoixColonne, ChoixLigne, ChoixDirection) then
      ChoixDirection:=TDirection(3-Ord(ChoixDirection));
    end;
  else // v1.5 (case of)
    if (p.Tour=1) and (NbJetonsAPlacer<NbLettresMinMot) then
      begin
      AfficheMessage(Format('Vous devez placer au moins %d lettres sur le plateau de jeu au premier tour.', [NbLettresMinMot]),
                     stPlacementImpossible, MB_ICONEXCLAMATION);
      Exit // Pas de sanction (et encore c'est gentil...)
      end
  end{case of}; // v1.5 (case of)

  // v1.4.4 : Réinitialisé car si proposition avec joker invalide non sanctionnée, la prochaine proposition ne demande pas de lettre pour le joker !
  p.LettreJokerPropositionAvecUnSeulJetonPlace:=tjJoker;

  if p.EstJouable(ChoixColonne, ChoixLigne,
                  ChoixDirection,
                  FormTirage.Chevalet,
                  FormTirage.ChoixDebut, FormTirage.ChoixFin) then
    begin
    if TestPlacement then
      begin
      ScoreProposition:=p.ScorePose(ChoixColonne, ChoixLigne,
                                    ChoixDirection,
                                    FormTirage.Chevalet,
                                    FormTirage.ChoixDebut, FormTirage.ChoixFin);
      PoseProposition(ChoixColonne, ChoixLigne,
                      ChoixDirection,
                      FormTirage.Chevalet,
                      FormTirage.ChoixDebut, FormTirage.ChoixFin);
      AfficheMessage(Format('Cette proposition rapporterait %d points (mot[s] non validé[s]).',
                            [ScoreProposition]),
                     'Proposition', MB_ICONINFORMATION);
      RetireProposition(ChoixColonne, ChoixLigne, ChoixDirection);
      Exit
      end;
    if p.MotsFormesValables(ChoixColonne, ChoixLigne,
                            ChoixDirection,
                            FormTirage.Chevalet,
                            FormTirage.ChoixDebut, FormTirage.ChoixFin, tpProposition) then // v1.4 : tpProposition
      begin
      ReflexionEnCours:=False; // On arrête le chrono car on sait qu'à partir d'ici c'est accepté
      ScoreProposition:=p.ScorePose(ChoixColonne, ChoixLigne,
                                    ChoixDirection,
                                    FormTirage.Chevalet,
                                    FormTirage.ChoixDebut, FormTirage.ChoixFin);
      PoseProposition(ChoixColonne, ChoixLigne,
                      ChoixDirection,
                      FormTirage.Chevalet,
                      FormTirage.ChoixDebut, FormTirage.ChoixFin);
      AfficheMessage(Format('Votre proposition rapporte %d points.',
                            [ScoreProposition]),
                     'Proposition', MB_ICONINFORMATION);
      // v1.5 : Records
      if not p.TiragePropose[p.Tour] then // v1.5.3 : pas de record si tirage proposé
        r.TesteRecord(srProposition, nvrTour, trMax, ntrTailleMot, p.Tour, p.TailleMaxMotForme, 'avec le mot '+p.stMotTailleMax);
      // v1.5.1 : déplacé après les appels à FormFeuilleMatch.AjouteLigne pour bénéficier du complément d'info en couleur !
      // r.TesteRecord(srProposition, nvrTour, trMax, ntrScore, p.Tour, ScoreProposition, ''); // v1.5
      RetireProposition(ChoixColonne, ChoixLigne, ChoixDirection)
      end{if MotsFormesValables}
    else
      begin
      AfficheMessage(p.stMessage, stPlacementImpossible, MB_ICONEXCLAMATION);
      if ActionOptionsSanctions.Checked then Sanctionne else Exit
      end
    end{if p.EstJouable}
  else
    begin
    AfficheMessage(p.stMessage,
                   stPlacementImpossible,
                   MB_ICONEXCLAMATION);
    if ActionOptionsSanctions.Checked then Sanctionne else Exit
    end
  end{if ChoixDirection}
else
  Sanctionne; // Volontaire ou temps écoulé
// À partir de là, on a une proposition ou le joueur a passé son tour...
p.Score[p.Tour]:=ScoreProposition;
slSolutions:=TStringList.Create;
slSolutions.Sorted:=True;
Solution:=Nil; // v1.4
try
  p.Cherche(slSolutions);
  // un opérateur jouant le rôle de IfThen manque cruellement dans Delphi !!!
  if p.ScoreTop[p.Tour]=0 then Prc:=0 else Prc:=(MaxFormatRapport[FormatRapport]*p.Score[p.Tour])/p.ScoreTop[p.Tour];
  // if p.CumulTop[p.Tour]=0 then CumulPrc:=0 else CumulPrc:=(MaxFormatRapport[FormatRapport]*p.Cumul[p.Tour])/p.CumulTop[p.Tour]; // v1.6
  // Test record Score Top déplacé après FormFeuilleMatch.AjouteLigne
  // if not DemoEnCours then r.TesteRecord(srTop, nvrTour, trMax, ntrScore, p.Tour, p.ScoreTop[p.Tour], ''); // v1.5
  stStatistiquePrpSol:=Format(stFrmSolutionsProposition,
                              [p.NbSol[p.Tour],
                               p.TpsCalculSol[p.Tour], p.NbSol[p.Tour]/p.TpsCalculSol[p.Tour], // v1.6 : temps de calcul
                               p.Score[p.Tour], p.ScoreTop[p.Tour],
                               Prc, stFormatRapport[FormatRapport], // v1.6, déplacé ici et cumul supprimé
                               p.PosPrp[p.Tour],
                               stSuffixeRang[Ord(p.PosPrp[p.Tour]>1)](*, // v1.5.5
                               Prc, stFormatRapport[FormatRapport](*, // v1.6
                               CumulPrc, stFormatRapport[FormatRapport]*) (*, // v1.4.8
                               p.CumulPosPrp[p.Tour] div p.Tour,
                               stSuffixeRang[Ord((p.CumulPosPrp[p.Tour] div p.Tour)>1)]*)]);
  FormSolutions.StatusBar.SimpleText:=stStatistiquePrpSol;
  ChoixFait:=False; // v1.4
  while not ChoixFait do
    case FormSolutions.ChoisitSolution(slSolutions) of // v1.4
      tpMeilleure:begin // On enregistre les données de la solution retenue (ce n'est plus forcément la meilleure depuis la version 1.5.5)
                  // v1.4 : cas solution unique sortie pour pouvoir sortir si annulation demandée
                  ChoixFait:=True;
                  p.ScorePartie[p.Tour]:=p.ScoreSolPose; // v1.5.5 : p.ScoreSolPose à la place de p.ScoreTop[p.Tour]
                  p.CumulPartie[p.Tour]:=p.ScorePartie[p.Tour]+IfThen(p.Tour>Low(TTour), p.CumulPartie[Pred(p.Tour)], 0); // v1.4
                  p.EnregistreSolution(FormSolutions.ListBox.Items.Objects[FormSolutions.ListBox.ItemIndex] as TSolution);
                  with FormSolutions.ListBox.Items.Objects[FormSolutions.ListBox.ItemIndex] as TSolution do
                    begin
                    // Cas de la proposition à un jeton posé
                    if p.PropositionAvecUnSeulJetonPlace then
                      begin // On choisit la direction qui donne le mot principal le plus long
                      stPrmProposition:=p.stProposition[p.Tour];
                      if not p.MotsFormesValables(ChoixColonne, ChoixLigne,
                                                  Dir90[ChoixDirection],
                                                  FormTirage.Chevalet,
                                                  FormTirage.ChoixDebut, FormTirage.ChoixFin, tpPose) then // v1.4.3 : tpPose
                        begin // v1.6.6 : Si mot(s) non valable(s) alors pas de proposition ni score car sanction prise !
                        ScoreProposition:=0;
                        p.stMotPrincipal:='';
                        p.stProposition[p.Tour]:=''
                        end;
                      // v1.6 : stMotPrincipal à la place de stProposition[p.Tour] dans tout le test ci-dessous (1/3)
                      if (Length(stPrmProposition)<Length(p.stMotPrincipal)) or
                         ((Length(stPrmProposition)=Length(p.stMotPrincipal)) and (stPrmProposition>p.stMotPrincipal)) then
                        begin
                        // v1.6 : on affecte le mot principal réel et la bonne direction ici (2/3)
                        p.stProposition[p.Tour]:=p.stMotPrincipal;
                        ChoixDirection:=Dir90[ChoixDirection];
                        end;
                      // v1.6 : on n'exécute qu'une fois AjouteLigne (plus de cas Dir90[ChoixDirection] à la place de ChoixDirection)
                      FormFeuilleMatch.AjouteLigne(p.stProposition[p.Tour], ChoixColonne, ChoixLigne, ChoixDirection, FormTirage.Chevalet, FormTirage.ChoixDebut, FormTirage.ChoixFin,
                                                   stMot,                   x,            y,          d,              Chevalet,            Debut,                 Fin)
                      end{if PropositionAvecUnSeulJeton}
                    else
                      FormFeuilleMatch.AjouteLigne(p.stProposition[p.Tour], ChoixColonne, ChoixLigne, ChoixDirection, FormTirage.Chevalet, FormTirage.ChoixDebut, FormTirage.ChoixFin,
                                                   stMot,                   x,            y,          d,              Chevalet,            Debut,                 Fin);
                    // Tests de records...
                    if not p.TiragePropose[p.Tour] then // v1.5.3 : pas de record si tirage proposé
                      begin
                      r.TesteRecord(srProposition, nvrTour, trMax, ntrScore, // v1.5.1 : déplacé pour avoir la pose en couleur dans le complément d'info !
                                    p.Tour, p.Score[p.Tour],
                                    Format(stFrmInfoPose, [p.stHTMLPoseStyleEtCouleurAppliques(p.Tour, csHumain),
                                                           p.stCoordonnees(ChoixColonne, ChoixLigne, ChoixDirection)]));
                      if not DemoEnCours then
                        begin
                        // v1.5 : Record ntrTailleMot : p.TailleMaxMotForme et p.stMotTailleMax calculé dans p.ScorePose exécuté dans FormFeuilleMatch.AjouteLigne
                        r.TesteRecord(srTop, nvrTour, trMax, ntrTailleMot, p.Tour, p.TailleMaxMotForme, 'avec le mot '+p.stMotTailleMax);
                        r.TesteRecord(srTop, nvrTour, trMax, ntrScore, // v1.5.1 : déplacé pour avoir la pose en couleur dans le complément d'info !
                                      p.Tour, p.ScoreTop[p.Tour],
                                      Format(stFrmInfoPose, [p.stHTMLPoseStyleEtCouleurAppliques(p.Tour, csMachine),
                                                             p.stCoordonnees(x, y, d)]));
                        end
                      end;
                    if StockageSolutions then GenereListeSolutionsTriees; // v1.3.6
                    ChargeChevalet(FormTirage.Chevalet);
                    // On affecte les lettres de jokers utilisés dans la solution retenue
                    ChargeLettresJoker(p.LettreJoker);
                    p.JoueTour(x, y, d, FormTirage.Chevalet, Debut, Fin);
                    with FormStatsPartie do
                      if Visible then Repaint;
                    DessinePlacement(x, y, d);
                    PartieModifiee:=True;
                    if ActionOptionsGenererAutoFDM.Checked then // v1.3.5
                      begin
                      ActionOptionsGenererAutoFDM.Tag:=1; // Empêche l'affichage de la FDM
                      ActionAffichageFeuilleMatchDetailleeExecute(ActionAffichageFeuilleMatchDetaillee);
                      end;
                    with FormTirage do
                      if not ChargeTirage then
                        begin
                        StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stPartieTerminee;
                         // v1.4.9 : Plus de jetons ajouté dans le texte + Constantes
                         // v1.5 : on propose d'enregistrer la fin de partie
                        if AfficheMessage(stTirageInsuffisant, stResultat, MB_ICONQUESTION+MB_YESNO)=IDYES then
                          ActionPartieEnregistrerExecute(ActionPartieEnregistrer);
                        EnregistrePartie; // v1.4.9
                        p.ProchainJetonATirer:=Low(TOrdreJetonSac);
                        MelangeEnCours:=True; // v1.1
                        if DemoEnCours then
                          begin
                          TimerDemonstration.Tag:=0;
                          DemoEnCours:=False
                          end;
                        Exit
                        end{if not Acceptable}
                    end{with FormSolutions.ListBox.Items.Objects...}
                  end{tpMeilleure:};
      tpAucune:   begin
                  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stPartieTerminee;
                  // v1.4.9 (constantes)
                  // v1.5 : on propose d'enregistrer la fin de partie
                  if AfficheMessage(stAucuneSolution, stResultat, MB_ICONQUESTION+MB_YESNO)=IDYES then
                    ActionPartieEnregistrerExecute(ActionPartieEnregistrer);
                  EnregistrePartie; // v1.4.9
                  p.ProchainJetonATirer:=Low(TOrdreJetonSac);
                  MelangeEnCours:=True; //v1.1
                  if DemoEnCours then
                    begin
                    TimerDemonstration.Tag:=0;
                    DemoEnCours:=False
                    end;
                  Exit
                  end;
      tpManuelle: begin // v1.4
                  FreeAndNil(Solution);
                  if FormPropositionPose.PropositionPose(Solution, ScorePose, // v1.8.2 : plus de paramètres X, Y, d, Debut, Fin
                                                        ChoixColonne, ChoixLigne, ChoixDirection) then // v1.5.2 : ajout des 3 const Choix[...] pour l'affichage de la proposition joueur
                    begin
                    ChoixFait:=True;
                    p.ScorePartie[p.Tour]:=ScorePose;
                    p.CumulPartie[p.Tour]:=p.ScorePartie[p.Tour]+IfThen(p.Tour>Low(TTour), p.CumulPartie[Pred(p.Tour)], 0);
                    p.EnregistreSolution(Solution);
                    with Solution do
                      begin
                      // Cas de la proposition à un jeton posé
                      if p.PropositionAvecUnSeulJetonPlace then
                        begin // On choisit la direction qui donne le mot principal le plus long
                        stPrmProposition:=p.stProposition[p.Tour];
                        if not p.MotsFormesValables(ChoixColonne, ChoixLigne,
                                                    Dir90[ChoixDirection],
                                                    FormTirage.Chevalet,
                                                    FormTirage.ChoixDebut, FormTirage.ChoixFin, tpPose) then // v1.4 : tpPose
                          begin // v1.6.6 : Si mot(s) non valable(s) alors pas de proposition ni score car sanction prise !
                          ScoreProposition:=0;
                          p.stMotPrincipal:='';
                          p.stProposition[p.Tour]:=''
                          end;
                        // v1.6 : stMotPrincipal à la place de stProposition[p.Tour] dans tout le test ci-dessous (1/3)
                        if (Length(stPrmProposition)<Length(p.stMotPrincipal)) or
                           ((Length(stPrmProposition)=Length(p.stMotPrincipal)) and (stPrmProposition>p.stMotPrincipal)) then
                          begin
                          // v1.6 : on affecte le mot principal réel et la bonne direction ici (2/3)
                          p.stProposition[p.Tour]:=p.stMotPrincipal;
                          ChoixDirection:=Dir90[ChoixDirection];
                          end;
                        // v1.6 : on n'exécute qu'une fois AjouteLigne (plus de cas Dir90[ChoixDirection] à la place de ChoixDirection)
                        FormFeuilleMatch.AjouteLigne(p.stProposition[p.Tour], ChoixColonne, ChoixLigne, ChoixDirection, FormTirage.Chevalet, FormTirage.ChoixDebut, FormTirage.ChoixFin,
                                                     stMot,                   x,            y,          d,              Chevalet,            Debut,                 Fin)
                        end{if PropositionAvecUnSeulJeton}
                      else
                        FormFeuilleMatch.AjouteLigne(p.stProposition[p.Tour], ChoixColonne, ChoixLigne, ChoixDirection, FormTirage.Chevalet, FormTirage.ChoixDebut, FormTirage.ChoixFin,
                                                     stMot,                   x,            y,          d,              Chevalet,            Debut,                 Fin);
                      // Tests de records...
                      if not p.TiragePropose[p.Tour] then // v1.5.3 : pas de record si tirage proposé
                        begin
                        r.TesteRecord(srProposition, nvrTour, trMax, ntrScore, // v1.5.1 : déplacé pour avoir la pose en couleur dans le complément d'info !
                                      p.Tour, p.Score[p.Tour],
                                      Format(stFrmInfoPose, [p.stHTMLPoseStyleEtCouleurAppliques(p.Tour, csHumain),
                                                             p.stCoordonnees(ChoixColonne, ChoixLigne, ChoixDirection)]));
                        // v1.5.1 : if faut quand même enregistrer le score top car ne dépend pas du choix de la pose. Par contre, pas d'info sur la pose si ce n'est pas le top !
                        if not DemoEnCours then
                          begin
                          if p.ScorePartie[p.Tour]=p.ScoreTop[p.Tour] then
                            begin
                            r.TesteRecord(srTop, nvrTour, trMax, ntrTailleMot, // v1.5.1 : Record de taille de mot ajouté également ici
                                          p.Tour, p.TailleMaxMotForme, 'avec le mot '+p.stMotTailleMax);
                            r.TesteRecord(srTop, nvrTour, trMax, ntrScore,
                                          p.Tour, p.ScoreTop[p.Tour],
                                          Format(stFrmInfoPose, [p.stHTMLPoseStyleEtCouleurAppliques(p.Tour, csMachine),
                                                                 p.stCoordonnees(x, y, d)]))
                            end
                          else
                            r.TesteRecord(srTop, nvrTour, trMax, ntrScore, // v1.5.1 : if faut quand même enregistrer le score top car ne dépend pas du choix de la pose. Par contre, pas d'info sur la pose !
                                          p.Tour, p.ScoreTop[p.Tour], 'pas de top posé')
                          end
                        end;
                      if StockageSolutions then GenereListeSolutionsTriees; // v1.3.6
                      ChargeChevalet(FormTirage.Chevalet);
                      // On affecte les lettres de jokers utilisés dans la solution retenue
                      ChargeLettresJoker(p.LettreJoker);
                      p.JoueTour(x, y, d, FormTirage.Chevalet, Debut, Fin);
                      with FormStatsPartie do
                        if Visible then Repaint;
                      DessinePlacement(x, y, d);
                      PartieModifiee:=True;
                      if Length(p.stSolution[p.tour-1])=NbLettresMaxMot then // v1.5.3
                        if d15l.TesteDefi then
                          NotifieAction(aanAffichageDefi1M15LCAC, NAffichePas);
                      if ActionOptionsGenererAutoFDM.Checked then // v1.3.5
                        begin
                        ActionOptionsGenererAutoFDM.Tag:=1; // Empêche l'affichage de la FDM
                        ActionAffichageFeuilleMatchDetailleeExecute(ActionAffichageFeuilleMatchDetaillee);
                        end;
                      with FormTirage do
                        if not ChargeTirage then
                          begin
                          StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stPartieTerminee;
                          // v1.4.9 (constantes)
                          // v1.5 : on propose d'enregistrer la fin de partie
                          if AfficheMessage(stTirageInsuffisant, stResultat, MB_ICONQUESTION+MB_YESNO)=IDYES then
                            ActionPartieEnregistrerExecute(ActionPartieEnregistrer);
                          EnregistrePartie; // v1.4.9
                          p.ProchainJetonATirer:=Low(TOrdreJetonSac);
                          MelangeEnCours:=True; // v1.1
                          if DemoEnCours then
                            begin
                            TimerDemonstration.Tag:=0;
                            DemoEnCours:=False
                            end;
                          Exit
                          end{if not Acceptable}
                      end{with}
                    end{if PropositionPose}
                  else
                    ChoixFait:=False
                  end;
    end{case of};
finally
  FormSolutions.ListBox.Clear;
  slSolutions.Destroy;
  FreeAndNil(Solution); // v1.4
  // v1.4.4 : On réinitialise tous les indicateurs de proposition car il peut y avoir des résidus (comme coin inférieur droit)
  for i:=Low(TCoordonnee) to High(TCoordonnee) do
    for j:=Low(TCoordonnee) to High(TCoordonnee) do
      if p.Proposition[i, j] then
        begin
        p.Proposition[i, j]:=False;
        DessineCase(i, j, NeMontrePasCase)
        end
end{try};
if p.NbJetonsAJouer=0 then
  begin
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stPartieTerminee;
  // v1.5 : La fin de partie ne devrait pas se produire ici mais on ne sait jamais : ajout...
  // - de la demande de sauvegarde
  // - de l'enregistrement de la partie terminée
  if AfficheMessage(stTirageInsuffisant, stResultat, MB_ICONQUESTION+MB_YESNO)=IDYES then
    ActionPartieEnregistrerExecute(ActionPartieEnregistrer);
  EnregistrePartie;
  p.ProchainJetonATirer:=Low(TOrdreJetonSac);
  MelangeEnCours:=True; // v1.1
  Exit
  end;
if DemoEnCours then
  TimerDemonstration.Enabled:=True
else
  begin
  if ActionOptionsEnregistrerPartieAuto.Checked and
     (stNomFichierPartie<>'') then // v1.5 (nouvelle option)
    ActionPartieEnregistrerExecute(ActionPartieEnregistrer);
  ReflexionEnCours:=True;
  end;
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionTestPlacementHorizontalExecute(Sender: TObject);
begin
//
end;
//---------------------------------------------------------------------------
procedure TFormMain.ActionTestPlacementVerticalExecute(Sender: TObject);
begin
//
end;
procedure TFormMain.ActionVideExecute(Sender: TObject);
var Action : TAction; // v1.5
begin // Evénements des cases à cocher sans code
// v1.5 : Notifications sur la barre de statut
Action:=(Sender as TAction);
if Action=ActionOptionsGenererAutoFDM then
  NotifieAction(aanOptionsGenererAutoFeuilleDeMatchCAC, Action.Checked);
if Action=ActionOptionsSanctions then
  NotifieAction(aanOptionsProposititionsInvalidesCAC, Action.Checked);
if Action=ActionOptionsTempsLimite then
  NotifieAction(aanOptionsTempsLimiteCAC, Action.Checked);
if Action=ActionOptionsEnregistrerPartieAuto then
  NotifieAction(aanOptionsEnregistrerPartieAutoCAC, Action.Checked);
if Action=ActionOptionsPlacerPropositionAuto then // v1.6.9
  NotifieAction(aanOptionsPlacerPropositionAutoCAC, Action.Checked);
if Action=ActionOptionsEnregistrerEnQuittant then // v1.6.5
  NotifieAction(aanOptionsEnregistrerParametresEnQuittantCAC, Action.Checked);
if Action=ActionAffichageNouveauxRecords then // v1.5
  begin
  if r<>nil then r.AfficheNouveauxRecords:=Action.Checked;
  NotifieAction(aanAffichageNouveauxRecordsCAC, Action.Checked);
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var DiffLargeur, DiffHauteur : Integer;
begin
DiffLargeur:=Width-ClientWidth;
DiffHauteur:=Height-ClientHeight;
if (NewWidth-DiffLargeur<TailleMinPlateau+HauteurLargeurCoordonnees) or     // 1.3.9
   (NewHeight-DiffHauteur<TailleMinPlateau+HauteurLargeurCoordonnees+StatusBar.Height) then // 1.3.9 : +StatusBar.Height !
  Resize:=False;
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin // v1.6.5
if ActionOptionsEnregistrerEnQuittant.Checked then
  EnregistreOptions;
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:=not PartieModifiee or MelangeEnCours or // v1.3.4 : Pas de confirmation si fin de partie (MelangeEnCours)
          (AfficheMessage('Une partie est en cours, êtes-vous sûr(e) de vouloir abandonner ?',
                          stConfirmation, // v1.5 (factorisation)
                          MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES)
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormCreate(Sender: TObject);
begin
StatusBar.Panels.Items[Ord(ibsMessage)].Text:=''; // v1.3.5
ChargeOptions; // v1.3.2
DetermineVersion;
// EnregistreExtension; // v1.6.4 -> Fait dans l'installation de Word Killers (mode unique) permettant une compatibilité avec Windows Vista/Seven
stNomFichierPartie:='';
PartieModifiee:=False;
RafraichissementEnCours:=False;
MelangeJetonsEnCours:=False;
DestructionEnCours:=False;
FChoixPoseClavierEnCours:=False; // v1.4.1
Choix1Colonne:=-1; // v1.4.1
Choix1Ligne:=-1;   // v1.4.1
p:=TPartie.Cree;
d15l:=TDefi15Lettres.Cree; // v1.5.3. Créé après p car a besoin du dico !
DoubleBuffered:=True; // Evite le scintillement
ReflexionEnCours:=False;
TopChrono:=0;
FinChrono:=0;
xPopup:=-1;
yPopup:=-1;
MelangeEnCours:=True; // v1.1
EmpecheTempsImparti:=False; // v1.5
TestPlacementEnCours:=False; // v1.5.2
PlacementPropositionAuto:=False; // v1.6.9
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormDestroy(Sender: TObject);
begin
MelangeEnCours:=False; // v1.1
DestructionEnCours:=True;
p.Detruit
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormKeyPress(Sender: TObject; var Key: Char);
var X, Y : Integer;
begin  // v1.4.1

if ReflexionEnCours and
   ((Key='+') or
    (Key='#')) then // v1.5.2 ('#' et déplacé en tête car interrupteur non fonctionnel)
  begin
  FChoixPoseClavierEnCours:=ChoixPoseClavierEnCours xor True;
  TestPlacementEnCours:=((Key='#') and ChoixPoseClavierEnCours); // v1.5.2
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stEtatSaisiePrmCase[ChoixPoseClavierEnCours];
  Choix1Colonne:=-1;
  Choix1Ligne:=-1;
  Exit
  end;

if ReflexionEnCours and ChoixPoseClavierEnCours then
  begin
  if (UpperCase(Key)>='A') and (UpperCase(Key)<='O') then
    begin
    if (Choix1Colonne>-1) then
      begin
      FChoixPoseClavierEnCours:=False;
      StatusBar.Panels.Items[Ord(ibsMessage)].Text:='';
      Choix1Ligne:=Ord(UpperCase(Key)[1])-Ord('A');
      // On a les deux coordonnées : On affiche le menu de choix de la direction
      X:=TailleCase*(Choix1Colonne)+HauteurLargeurCoordonnees div 2;
      Y:=TailleCase*(Choix1Ligne+1)+HauteurLargeurCoordonnees div 2;
      if TestPlacementEnCours then // v1.5.2
        begin
        TestPlacementEnCours:=False;
        FormMouseDown(Self, mbRight, [ssRight], X, Y)
        end
      else
        FormMouseDown(Self, mbLeft, [ssLeft], X, Y)
      end
    else
      begin
      FChoixPoseClavierEnCours:=False;
      TestPlacementEnCours:=False; // v1.5.2
      AfficheMessage('Saisissez d''abord la colonne (entre 1 et 15) avant la ligne entre (A et O).', 'Choix de la première case du placement', MB_ICONEXCLAMATION);
      StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stEtatSaisiePrmCase[False];
      end
    end;
  if (Key>='0') and (Key<='9') then
    if (Choix1Colonne=1) and (Key>='1') and (Key<='5') then
      Choix1Colonne:=10+Ord(Key)-Ord('0')
    else
      Choix1Colonne:=Ord(Key)-Ord('0');
  Exit
  end;

if ((Key>='0') and (Key<='7')) or (Key='*') then
  if (FormTirage<>nil) and FormTirage.Visible then
    with FormTirage do
      begin
      SetFocus;
      FormKeyPress(Self, Key)
      end
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Point : TPoint;
begin
if not ReflexionEnCours then Exit;
Point.X:=X; Point.Y:=Y;
Point:=ClientToScreen(Point);
AfficheCoordonnees(X,Y, MontreCase);
if Button=mbLeft then
  PopupMenuPlacement.Popup(Point.X, Point.Y);
if Button=mbRight then // v1.5.2
  PopupMenuTestPlacement.Popup(Point.X, Point.Y);
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
AfficheCoordonnees(X,Y, NeMontrePasCase);
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormPaint(Sender: TObject);
begin
DessinePlateau
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormResize(Sender: TObject);
var
i            : TTypeJeton;
TaillePlateau,
TaillePolice,
TailleLettre : Integer;
TailleOk     : Boolean;
begin
TaillePlateau:=0; // v1.4.3 : Evite l'avertissement à cause du try
if not Visible or
   RafraichissementEnCours then Exit; // Redimensionnement en cours
RafraichissementEnCours:=True;
try
  // On calcule la taille du plateau
  TaillePlateau:=Max(TailleMinPlateau,
                     Min(ClientHeight-StatusBar.Height,
                         ClientWidth))-HauteurLargeurCoordonnees; // v1.3.9
  TaillePlateau:=2+NbCasesCote*((TaillePlateau-2) div NbCasesCote);
  ClientWidth:=TaillePlateau+HauteurLargeurCoordonnees; // v1.3.9
  ClientHeight:=TaillePlateau+HauteurLargeurCoordonnees+StatusBar.Height; // v1.3.9
  with StatusBar.Panels do
   Items[Ord(ibsMessage)].Width:=ClientWidth-Items[Ord(ibsTemps)].Width
                                            -Items[Ord(ibsCoordonnees)].Width; // A cause du SizeGrid
  // On détermine la taille de la police de telle sorte que toutes les lettres entre dans une case
  with Font do
    begin
    Charset:=ANSI_CHARSET;
    Name:='Arial';
    Style:=[];
    end;
  TailleCase:=TaillePlateau div NbCasesCote;
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

  // On rafraichit enfin le plateau avec les tailles définies
  if Self.TaillePlateau<>TaillePlateau then
    begin
    Self.TaillePlateau:=TaillePlateau;
    DessinePlateau;
    end;

  // v1.8.3 : on repositionne Tirage (et feuille de match)
  if (FormTirage<>nil) and FormTirage.Visible then
    FormTirage.FormShow(self);
finally
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=Format('Taille %dx%d', [TaillePlateau, TaillePlateau]);
  RafraichissementEnCours:=False;
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.FormShow(Sender: TObject);
begin
FormResize(Sender)
end;
//---------------------------------------------------------------------------
procedure TFormMain.OpenDialogShow(Sender: TObject);
begin
OpenDialog.InitialDir:=stRepLocalAppData; // stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
end;
//---------------------------------------------------------------------------
procedure TFormMain.SaveDialogShow(Sender: TObject);
begin
SaveDialog.InitialDir:=stRepLocalAppData // stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
end;
//---------------------------------------------------------------------------
procedure TFormMain.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
if Panel.ID = 1 then
  with StatusBar.Canvas do
    begin
    Font.Color:=IfThen(Panel.Text[1]='-',
                       clRed,
                       IfThen(Panel.Text[1]='+',
                              clGreen,
                              clBlack));
    TextOut(Rect.Left+(Rect.Right-Rect.Left-TextWidth(Panel.Text)) div 2,
            Rect.Top+(Rect.Bottom-Rect.Top-TextHeight(Panel.Text)) div 2,
            Panel.Text);
    end;
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerAProposTimer(Sender: TObject);
begin
TimerAPropos.Enabled:=False;
ActionInfosAProposExecute(ActionInfosAPropos)
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerClignotementTimer(Sender: TObject);
begin // v1.5
with TimerClignotement do
  begin
  Tag:=1-Tag;
  if CoordonneesValides(xPopup, yPopup) then
    DessineCase(xPopup, yPopup, Boolean(Tag));
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerDemonstrationTimer(Sender: TObject);
begin
TimerDemonstration.Enabled:=False;
if TimerDemonstration.Tag=0 then // Phase de démarrage
  begin
  TimerDemonstration.Tag:=1;
  ActionPartieNouvelleExecute(ActionPartieNouvelle)
  end
else
  begin
  NotifieAction(aanPartieDemonstrationCAC, Actif); // v1.5
  ActionActionsPasserSonTourExecute(ActionActionsPasserSonTour)
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerDicoOKTimer(Sender: TObject);
begin
if (p<>nil) and (p.Dico<>nil) then
  begin
  TimerDicoOk.Enabled:=False;
  if not p.Dico.ChargementDicoOk then
    Close
  else
    if (ParamCount>0) and (ParamStr(1)<>'!') then // Si dico OK alors on charge la partie demandée en ligne de commande le cas échéant. vWK : '!' permet de passer outre la non validité d'un mot
      if FileExists(ParamStr(1)) then
        OuvrePartie(ParamStr(1))
      else
        AfficheMessage('Le fichier demandé est introuvable !', 'Impossible d''ouvrir la partie', MB_ICONHAND);
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerMelangeurTimer(Sender: TObject);
var a, b, c : Integer;
begin
// On mélange les jetons : on prend 2 jetons et on les permute
if not MelangeEnCours // v1.1 - mélange non autorisé explicitement
   or MelangeJetonsEnCours or // Ici, il s'agit de la permutation en cours
   DestructionEnCours or
   (p=nil) then Exit; // Permutation de jeton en cours ou partie pas créée, les prochains jetons attendent
MelangeJetonsEnCours:=True;
try
  Repeat
    a:=1+Random(NbJetonsSac);
    b:=1+Random(NbJetonsSac);
  Until a<>b;
  c:=p.s[a];
  p.s[a]:=p.s[b];
  p.s[b]:=c;
finally
  MelangeJetonsEnCours:=False;
end{try};
end;
//---------------------------------------------------------------------------
procedure TFormMain.TimerReflexionTimer(Sender: TObject);
const stSigne  : array [0..1] of String = ('-','+');
var stTemps    : String;
    Maintenant : TDateTime;
    SecondesRestantes : Integer;
begin
Maintenant:=Now;
SecondesRestantes:=Round(60*Ord(p.TempsReflexion)-24*3600*Frac(Maintenant-TopChrono)); // v1.5.6 : Ord(p.TempsReflexion) à la place de MinutesReflexion
stTemps:=Format('%s%d:%2d', [stSigne[Ord(SecondesRestantes>0)],
                             Abs(SecondesRestantes) div 60,
                             Abs(SecondesRestantes) mod 60]);
if stTemps[4]=' ' then stTemps[4]:='0';
with StatusBar.Panels.Items[Ord(ibsTemps)] do
 if Text<>stTemps then
   begin
   Text:=stTemps;
   StatusBar.Repaint;
   end;
if not EmpecheTempsImparti and // v1.5 : permet de rafraîchir le temps écoulé malgré l'empêchement d'interrompre la réflexion.
   ActionOptionsTempsLimite.Checked and
   (SecondesRestantes<=0) then
 begin
 ReflexionEnCours:=False;
 AfficheMessage('Le temps de réflexion est écoulé et vous n''avez rien proposé !', 'Temps imparti écoulé', MB_ICONEXCLAMATION);
 ActionPlacementExecute(ActionActionsPasserSonTour)
 end
end;
//---------------------------------------------------------------------------
// Procédures et fonctions publiques et privée
//---------------------------------------------------------------------------
procedure TFormMain.DessineCase(const X, Y : TCoordonnee; const MontreCase : Boolean);
var x1, y1,
    x2, y2,
    Valeur,
    LargeurTexte, // v1.5
    LargeurScore : Integer; // v1.5
    Score        : String;
    Mode         : TBrushStyle;

  procedure MontreBonusVoisins; // v1.4.4
  var s : array[1..3] of TPoint;
  begin
  with Canvas do
    begin
    if (y>0) and (BonusCase[x,y-1]>bAucun) then
      begin
      Brush.Color:=CouleurBonus[BonusCase[x,y-1]];
      Pen.Color:=Brush.Color;
      s[1].x:=x1+3*(x2-x1) div 7;
      s[2].x:=x1+4*(x2-x1) div 7;
      s[3].x:=x1+1*(x2-x1) div 2;
      s[1].y:=1+y1;
      s[2].y:=s[1].y;
      s[3].y:=1+y1+(y2-y1) div 7;
      Polygon(s);
      end;
    if (y<NbCasesCote-1) and (BonusCase[x,y+1]>bAucun) then
      begin
      Brush.Color:=CouleurBonus[BonusCase[x,y+1]];
      Pen.Color:=Brush.Color;
      s[1].x:=x1+3*(x2-x1) div 7;
      s[2].x:=x1+4*(x2-x1) div 7;
      s[3].x:=x1+1*(x2-x1) div 2;
      s[1].y:=y2-2;
      s[2].y:=s[1].y;
      s[3].y:=y2-2-(y2-y1) div 7;
      Polygon(s);
      end;
    if (x>0) and (BonusCase[x-1,y]>bAucun) then
      begin
      Brush.Color:=CouleurBonus[BonusCase[x-1,y]];
      Pen.Color:=Brush.Color;
      s[1].y:=y1+3*(y2-y1) div 7;
      s[2].y:=y1+4*(y2-y1) div 7;
      s[3].y:=y1+1*(y2-y1) div 2;
      s[1].x:=1+x1;
      s[2].x:=s[1].x;
      s[3].x:=1+x1+(x2-x1) div 7;
      Polygon(s);
      end;
    if (x<NbCasesCote-1) and (BonusCase[x+1,y]>bAucun) then
      begin
      Brush.Color:=CouleurBonus[BonusCase[x+1,y]];
      Pen.Color:=Brush.Color;
      s[1].y:=y1+3*(y2-y1) div 7;
      s[2].y:=y1+4*(y2-y1) div 7;
      s[3].y:=y1+1*(y2-y1) div 2;
      s[1].x:=x2-2;
      s[2].x:=s[1].x;
      s[3].x:=x2-2-(x2-x1) div 7;
      Polygon(s);
      end
    end{with Canvas}
  end;

begin
if MontreCase then
  begin
  if CoordonneesValides(xPopup, yPopup) then
    DessineCase(xPopup, yPopup, NeMontrePasCase); // On efface la mise en évidence précédente
  xPopup:=X;
  yPopup:=Y
  end;
with Canvas do
  begin // /!\ ATTENTION LE DESSIN DES JETONS EST DUPLIQUÉ DANS FormTirage.DessineTirage /!\
  x1:=1+TailleCase*x+HauteurLargeurCoordonnees div 2; // 1.3.9
  y1:=1+TailleCase*y+HauteurLargeurCoordonnees div 2; // 1.3.9
  x2:=x1+TailleCase;
  y2:=y1+TailleCase;
  Pen.Color:=Self.Color;
  if (p=Nil) or (p.c[x, y]=0) then
   begin
   Brush.Color:=CouleurBonus[BonusCase[x,y]];
   if MontreCase then
     Pen.Color:=TColor(TimerClignotement.Tag*CouleurChoixCase+(1-TimerClignotement.Tag)*Self.Color)
   else
     Pen.Color:=Self.Color;
   RoundRect(x1, y1, x2, y2,
             TailleCase div 5,
             TailleCase div 5);
   MontreBonusVoisins; // v1.4.4
   Pen.Color:=Self.Color
   end
  else
   begin
   Valeur:=ValeurJeton[TypeJeton[p.c[x,y]]];
   if TypeJeton[p.c[x,y]]<>tjJoker then
     Font.Color:=IfThen(p.SubstitutJoker[p.c[x,y]], // v1.5.6
                        CouleurEncreSubstitutJoker,
                        CouleurEncreJeton[Valeur]) // v1.6
   else
     Font.Color:=CouleurEncreJoker;
   Brush.Color:=CouleurFondJeton[p.Proposition[X, Y]];
   if MontreCase then
     Pen.Color:=TColor(TimerClignotement.Tag*CouleurChoixCase+(1-TimerClignotement.Tag)*Self.Color)
   else
     Pen.Color:=Self.Color;
   RoundRect(x1, y1, x2, y2,
             TailleCase div 5,
             TailleCase div 5);
   Pen.Color:=Self.Color;
   Mode:=Brush.Style;
   Brush.Style:=bsclear;
   Font.Size:=TaillePolice div 3;
   // v1.5 : l'affichage de la lettre a été déplacé après l'affichage du score pour utiliser la largeur du score
   LargeurScore:=0; // v1.5
   if Valeur>0 then
     begin
     if Valeur>9 then // v1.3.6 : On place mieux l'indice 10 (vers la droite)...
       begin
       Score:=IntToStr(ValeurJeton[TypeJeton[p.c[x,y]]] div 10)+' ';
       TextOut(x1+TailleCase-TextWidth(Score)-3 // v1.5.6 (Ord) ci-dessous
                 -Ord((TaillePolice>35) and (TaillePolice<39))
                 -Ord((TaillePolice>41) and (TaillePolice<45))
                 -Ord(TaillePolice>47)
                 -Ord((TaillePolice>50) and (TaillePolice<54)),
               y1+TailleCase-TextHeight(Score)-2,
               Score);
       LargeurScore:=TextWidth(Score); // v1.5
       Score:=' '+IntToStr(ValeurJeton[TypeJeton[p.c[x,y]]] mod 10);
       TextOut(x1+TailleCase-TextWidth(Score)-3
                 -Ord(TaillePolice>29)
                 -Ord(TaillePolice>44)
                 -Ord(TaillePolice>77)
                 +TextWidth(' ') div 2, // v1.5.6 (Ord)
               y1+TailleCase-TextHeight(Score)-2,
               Score);
       // StatusBar.Panels.Items[Ord(ibsMessage)].Text:=IntToStr(TaillePolice) // Pour test
       end
     else
       begin
       Score:=IntToStr(ValeurJeton[TypeJeton[p.c[x,y]]]);
       TextOut(x1+TailleCase-TextWidth(Score)-3
                 -Ord(TaillePolice>44)
                 -Ord(TaillePolice>47), // v1.5.6 (Ord)
               y1+TailleCase-TextHeight(Score)-2,
               Score);
       LargeurScore:=TextWidth(Score); // v1.5
       end{if Valeur};
     end;
   // v1.5 : on décale légèrement les lettres à gauche en fonction du score affiché sur le jeton
   Font.Size:=TaillePolice;
   LargeurTexte:=TextWidth(p.stLettre(x,y)); // v1.5
   if p.stLettre(x,y)='W' then LargeurScore:=LargeurScore div 3; // v1.5
   TextOut(x1+(TailleCase-LargeurTexte-LargeurScore) div 2, // v1.5 : Décalage à gauche si valeur
           y1,
           p.stLettre(x,y));
   Brush.Style:=Mode;
   end{if p.c else}
 end{with}
end;
//---------------------------------------------------------------------------
procedure TFormMain.DessinePlateau;
var i, j : Integer;
begin
with Canvas do
 begin
 with Font do
   begin
   Charset:=ANSI_CHARSET;
   Color:=CouleurEncreJeton[0];
   Name:='Arial';
   Style:=[];
   end;
 // On met d'abord un fond noir
 Brush.Color:=Color;
 FillRect(Rect(0, 0, ClientWidth, ClientWidth));
 DessineCoordonnees; // v1.8.3 : on dessine d'abord les coordonnées pour éviter le débordement sur les cases
// On ne dessine que les cases, les séparations étant de la couleur du fond
 for i:=Low(TCoordonnee) to High(TCoordonnee) do
   for j:=Low(TCoordonnee) to High(TCoordonnee) do
     DessineCase(i, j, (xPopup=i) and (yPopup=j));
  end{with};
end;
//---------------------------------------------------------------------------
procedure TFormMain.DessineCoordonnees; // v1.3.9
var i          : Integer;
    stAbscisse,
    stOrdonnee : String;
begin
with Canvas do
 begin
 Font.Color:=clWhite;
 Font.Size:=8;
 Brush.Color:=clBlack;
 for i:=Low(TCoordonnee) to High(TCoordonnee) do
  begin
  stAbscisse:=IntToStr(i+1);
  stOrdonnee:=' ';
  stOrdonnee[1]:=Chr(Ord('A')+i);
  // Abscisse haut
  TextOut(TailleCase*i+TailleCase div 2
         +HauteurLargeurCoordonnees div 2
         -TextWidth(stAbscisse) div 2,
          HauteurLargeurCoordonnees div 4
         -TextHeight(stAbscisse) div 2+1,
          stAbscisse);

  // Abscisse bas
  TextOut(TailleCase*i+TailleCase div 2
         +HauteurLargeurCoordonnees div 2
         -TextWidth(stAbscisse) div 2,
          TaillePlateau+3*HauteurLargeurCoordonnees div 4
         -TextHeight(stAbscisse) div 2-1,
          stAbscisse);
  // Ordonnée gauche
  TextOut(HauteurLargeurCoordonnees div 4
         -TextWidth(stOrdonnee) div 2,
          TailleCase*i+TailleCase div 2
         +HauteurLargeurCoordonnees div 2
         -TextHeight(stOrdonnee) div 2,
          stOrdonnee);

  // Ordonnée droite
  TextOut(TaillePlateau+3*HauteurLargeurCoordonnees div 4
         -TextWidth(stOrdonnee) div 2,
          TailleCase*i+TailleCase div 2
         +HauteurLargeurCoordonnees div 2
         -TextHeight(stOrdonnee) div 2,
          stOrdonnee);
  end
 end
end;
//---------------------------------------------------------------------------
function TFormMain.AfficheMessage(const stMessage, stTitre : String; Options : Integer) : Integer;
var TimerEnabled : Boolean;
begin
if ReflexionEnCours then
  begin
  TimerEnabled:=TimerReflexion.Enabled;
  if TimerEnabled then
    EmpecheTempsImparti:=True // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
  end
else
  TimerEnabled:=False; // v1.1 : Inutile mais bon, c'est pour l'avertissement
Result:=Application.MessageBox(pChar(stMessage), pChar(stTitre), Options);
if ReflexionEnCours and TimerEnabled then
  EmpecheTempsImparti:=False // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormMain.AfficheCoordonnees(const X, Y : Integer; const MontreCase : Boolean);
var Colonne, Ligne : Integer;
begin
Colonne:=1+(X-2-HauteurLargeurCoordonnees div 2) div TailleCase; // v1.3.9
if Colonne=0 then Colonne:=1;
if Colonne>NbCasesCote then Colonne:=NbCasesCote;
Ligne:=1+(Y-2-HauteurLargeurCoordonnees div 2) div TailleCase; // 1.3.9
if Ligne=0 then Ligne:=1;
if Ligne>NbCasesCote then Ligne:=NbCasesCote;
if MontreCase then
  DessineCase(Colonne-1, Ligne-1, MontreCase); // Affecte xPopup et yPopup
StatusBar.Panels.Items[Ord(ibsCoordonnees)].Text:=p.stCoordonnees(Colonne-1, Ligne-1);
// On enregistre la case sélectionnée
ChoixColonne:=Colonne-1;
ChoixLigne:=Ligne-1;
end;
//---------------------------------------------------------------------------
procedure TFormMain.DessinePlacement(const X, Y : TCoordonnee; const d : TDirection);
var i : Integer;
begin
for i:=0 to p.DistanceCaseDrnJetonPlace do
  DessineCase(X+i*dx[d], Y+i*dy[d], NeMontrePasCase)
end;
//---------------------------------------------------------------------------
procedure TFormMain.PoseProposition(const X, Y : TCoordonnee; const d : TDirection; const Chevalet : TChevalet; const Debut, Fin : TOrdreJetonChevalet);
begin
p.PlaceJetons(X, Y, d, Chevalet, Debut, Fin, Proposition);
DessinePlacement(X, Y, d);
end;
//---------------------------------------------------------------------------
procedure TFormMain.RetireProposition(const X, Y : TCoordonnee; const d : TDirection);
var i : Integer;
begin
for i:=0 to p.DistanceCaseDrnJetonPlace do
  if p.Proposition[X+i*dx[d], Y+i*dy[d]] then
    begin
    p.c[X+i*dx[d], Y+i*dy[d]]:=0;
    p.Proposition[X+i*dx[d], Y+i*dy[d]]:=False;
    DessineCase(X+i*dx[d],Y+i*dy[d], NeMontrePasCase)
    end;
end;
//---------------------------------------------------------------------------
function TFormMain.ModeDemonstration : Boolean;
begin
Result:=ActionPartieDemonstration.Checked
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeStatutMelange(const NvStatutMelange : Boolean);
begin  // v1.1
if NvStatutMelange then
  begin
  Caption:='W'+Copy(Caption, 2, Length(Caption)-1);
  stTitrePlateau[1]:='W'
  end
else
  begin
  Caption:='w'+Copy(Caption, 2, Length(Caption)-1);
  stTitrePlateau[1]:='w'
  end;
if FMelangeEnCours=NvStatutMelange then Exit; // Inutile
if NvStatutMelange then
  p.ChargeOrdreSac;
if not NvStatutMelange then
 TimerMelangeur.Enabled:=False;
FMelangeEnCours:=NvStatutMelange;
if not NvStatutMelange then
  p.SauveOrdreSac;
if NvStatutMelange then
 TimerMelangeur.Enabled:=True;
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeModeDemonstration(const NvModeDemonstration : Boolean);
begin
ActionPartieDemonstration.Checked:=NvModeDemonstration;
TimerDemonstration.Enabled:=NvModeDemonstration;
if p<>nil then // v1.5
  p.DemoEnCours:=NvModeDemonstration

end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeStatutPartie(const NvStatutPartie : Boolean);
begin
FPartieModifiee:=NvStatutPartie;
AfficheTitre // La property en écriture sert spécialement à rafraîchir le statut de la partie
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeNomFichierPartie(const stNvNomFichierPartie : String);
begin
stFNomFichierPartie:=stNvNomFichierPartie;
// v1.5 pour avoir un accès au nom de la partie depuis l'unité base (records)
if p<>nil then
  if stNvNomFichierPartie<>'' then
    begin
    p.stNomPartie:=ExtractFileName(stNvNomFichierPartie);
    p.stNomPartie:=Copy(p.stNomPartie, 1, Length(p.stNomPartie)-Length(ExtractFileExt(p.stNomPartie)))
    end
  else
    p.stNomPartie:='';
AfficheTitre // La property en écriture sert spécialement à rafraîchir le titre avec/sans le nom de fichier
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeStatutReflexionEnCours(const NvStatutReflexionEnCours : Boolean);
begin
FReflexionEnCours:=NvStatutReflexionEnCours;
if FReflexionEnCours then
  begin
  TopChrono:=Now;
  TimerReflexion.Enabled:=True
  end
else
  begin
  TimerReflexion.Enabled:=False;
  if TopChrono>0 then
    begin
    FinChrono:=Now;
    p.Temps[p.Tour]:=FinChrono-TopChrono;
    if ActionOptionsTempsLimite.Checked and
       (p.Temps[p.Tour]>Ord(p.TempsReflexion)/24/60) then // v1.5.6 : Ord(p.TempsReflexion) à la place de MinutesReflexion
      p.Temps[p.Tour]:=Ord(p.TempsReflexion)/24/60;       // v1.5.6 : Ord(p.TempsReflexion) à la place de MinutesReflexion
    p.CumulTemps[p.Tour]:=p.Temps[p.Tour]+IfThen(p.Tour>Low(TTour), p.CumulTemps[Pred(p.Tour)], 0.0)
    end
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.AfficheTitre;
begin
Caption:=Format(stFormatTitre, [stTitrePlateau,
                                Format(stFormatTitreFichierPartie[Ord(Length(stNomFichierPartie)>0)],
                                       [ExtractFileName(stNomFichierPartie)]),
                                stIndicateurPartieModifiee[Ord(PartieModifiee)]]);
end;
//---------------------------------------------------------------------------
procedure TFormMain.OuvrePartie(const stNomFichier : String);
var i            : Integer;
    FdMAffichee,
    ChargementOk : Boolean; // v1.5
    Chevalet     : TChevalet;
    Debut, Fin   : TNumeroJetonChevalet;
    stMessage    : String;
begin
// v1.5.1 : initialisations ci-dessous sorties du bloc try
ChargementOk:=True; // v1.5.1 : Optimiste
MelangeEnCours:=False; // v1.1
stNomFichierPartie:=stNomFichier;
try
  if not p.Charge(stNomFichierPartie, // v1.5 : cas d'erreur : différence de version
           Chevalet, Debut, Fin, xPopup, yPopup, stMessage) then
    begin
    ChargementOk:=False; // v1.5.1 : pour éviter les message du bloc finally
    AfficheMessage(stMessage, 'Impossible d''ouvrir la partie sauvegardée', MB_ICONSTOP);
    NotifieAction(aanPartieOuvrir, Inactif); // v1.5
    Repaint;
    Exit;
    end;
  DessinePlateau;
  FormTirage.ChargeChevalet(Chevalet, Debut, Fin);
  if not p.TirageOKVerifieSiNecessaire(Chevalet) then// v1.5.6. Il fallait attendre que le plateau et le chevalet se charge...
    begin // On a corrigé : on rafraîchit Plateau et Tirage
    DessinePlateau;
    FormTirage.ChargeChevalet(Chevalet, Debut, Fin);
    end;
  with FormFeuilleMatch do // v1.5 : au lieu de FormFeuilleMatch.RichEdit.Lines
    begin
    FdMAffichee:=Visible; // v1.5
    if FdMAffichee then Visible:=False; // v1.5
    CalculeLargeurMax; // v1.6.5
    try
      RichEdit.Lines.Clear;
      RichEdit.Lines.LoadFromFile(Copy(stNomFichierPartie,
                                       1,
                                       Length(stNomFichierPartie)-
                                       Length(ExtractFileExt(stNomFichierPartie)))+'.rtf');
      FormFeuilleMatch.InverseCouleurTexte; // v1.5. FdM : blanc sur fond noir. Fichier RTF : noir sur fond blanc
      // v1.6.5 : Cumuls sur la ligne de statut
      StatusBar.SimpleText:=Format(stFormatLigneStatut, [p.Cumul[p.Tour-1], p.CumulPartie[p.Tour-1], p.CumulTop[p.Tour-1]]);
    finally // v1.5
      if FdMAffichee then Visible:=True; // v1.5
    end // v1.5
    end;
  NotifieAction(aanPartieOuvrir, Actif); // v1.5
finally
  Repaint;
  with FormFeuilleMatch.RichEdit.Lines do
    if Count=0 then
      begin
      Add(stEntete[0]);
      Add(stEntete[1]);
      if p<>nil then
        for i:=1 to p.Tour-1 do
          Add('');
      StatusBar.SimpleText:='' // v1.6.5
      end;
  PartieModifiee:=False;
  with FormTirage do
    begin
    if Visible then Hide;
    Show;
    end;
  with FormFeuilleMatch do
    begin
    if Visible then Hide;
    AjusteHauteur;
    Show;
    end;
  if FormTirage.NbJetons=0 then
    begin
    if ChargementOk then // v1.5.1
      begin
      StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stPartieTerminee;
      AfficheMessage('Il n''y a plus de jetons. Partie terminée.', 'Fin de partie', MB_ICONINFORMATION);
      end;
    p.ProchainJetonATirer:=Low(TOrdreJetonSac);
    MelangeEnCours:=True; // v1.1
    end
  else
    ReflexionEnCours:=True
end{try}
end;
//---------------------------------------------------------------------------
function TFormMain.TesteMelangeEnCours : Boolean; // v1.3.4 : Evite d'enregistrer une partie terminée...
begin
if MelangeEnCours then
  begin
  Application.MessageBox('Aucune partie n''est en cours ou la partie est terminée.', 'Enregistrement impossible', MB_ICONEXCLAMATION);
  Result:=True;
  end
else
  Result:=False
end;
//---------------------------------------------------------------------------
procedure TFormMain.DetermineVersion;
var
  VerInfoSize, VerValueSize, ParametreInutilise: DWord;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), ParametreInutilise);
if VerInfoSize <> 0 then
  begin
  {On alloue de la mémoire pour un pointeur sur les info de version : }
  GetMem(VerInfo, VerInfoSize);
  {On récupère ces informations : }
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  {On traite les informations ainsi récupérées : }
  with VerValue^ do
    begin
    stVersion:=Format('%d.%d.%d',
                      [dwFileVersionMS shr 16,
                       dwFileVersionMS and $FFFF,
                       dwFileVersionLS shr 16]);
    stSousVersion:=Format('.%d', [dwFileVersionLS and $FFFF]); // v1.5
    end;
  FreeMem(VerInfo, VerInfoSize);
  end
else
  raise EAccessViolation.Create('Erreur inattendue : aucune information de version incluse.');
end;
//-----------------------------------------------------------------------------
(* // v1.6.4
procedure TFormMain.EnregistreExtension;
var   Reg : TRegistry;
const   stExtensionWkp = '.wkp';
        stVide      = '';
        stWordKillers = 'WordKillers';

begin
// On contrôle la base de registre sur le lien avec les fichiers de simulation
Reg:=TRegistry.Create;
with Reg do
  try // v1.3
    try
      RootKey:=HKEY_CLASSES_ROOT;
      OpenKey(stExtensionWkp, True); // v1.5.1 : Plus de if not KeyExists(stExtensionWkp)
      WriteString(stVide, stWordKillers);
      CloseKey();
      OpenKey(stWordKillers, True);
      WriteString(stVide, 'Partie de Word Killers');
      OpenKey('DefaultIcon', True);
      WriteString(stVide, ParamStr(0)+',0');
      OpenKey('\'+stWordKillers+'\shell', True);
      OpenKey('open', True);
      OpenKey('command', True);
      WriteString(stVide, ParamStr(0)+' "%1"');
      CloseKey();
      CloseKey();
      CloseKey();
      CloseKey();
      CloseKey();
    finally
      Destroy
    end{try}
  except
    on E:Exception do
      ShowMessage(E.Message)
  end{try²}
end; *)
//---------------------------------------------------------------------------
procedure TFormMain.DefinitDimensionsParDefaut(var FormMainClientWidth, FormMainClientHeight : Integer);
begin
// v1.4
if (Screen.Width<800) or
   (Screen.Height<600) then
  begin
  FormMain.AfficheMessage(stResolutionMinimale, stResolution, MB_ICONEXCLAMATION);
  Application.Terminate
  end;
// On détermine les dimensions idéales du plateau...
if FormFeuilleMatch=nil then // v1.6.5 : Largeur FDM suivant version. Si feuille de match n'existe pas, on prend la version étroite (par défaut)
  FormMainClientWidth:=Screen.Width-LargeurClientFdMMin-Width+ClientWidth
else
  FormMainClientWidth:=Screen.Width-LargeurClientFdMMin-Width+ClientWidth;
FormMainClientHeight:=FormMainClientWidth+StatusBar.Height;
// On ne descend pas en dessous d'une certaine taille min idéale...
if FormMainClientWidth<TailleMinPlateauDefaut+HauteurLargeurCoordonnees then
  begin
  FormMainClientWidth:=TailleMinPlateauDefaut+HauteurLargeurCoordonnees;
  FormMainClientHeight:=TailleMinPlateauDefaut+HauteurLargeurCoordonnees+StatusBar.Height;
  end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChargeOptions;  // v1.3.2
var IniFile              : TIniFile;
    FormMainClientWidth,
    FormMainClientHeight : Integer;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    ActionOptionsJournalRecherche.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionJRS, False);
    ActionOptionsJournalRechercheExecute(ActionOptionsJournalRecherche); // v1.3.6 (oubli)
    ChangeTypePartie(TTypePartie(IniFile.ReadInteger(stSectionParametres, stEntreeOptionTP, Ord(tpStandard)))); // v1.5.6
    ChangeTempsReflexion(TTempsReflexion(IniFile.ReadInteger(stSectionParametres, stEntreeOptionTR, Ord(trNormal)))); // v1.5.6
    ActionOptionsTempsLimite.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionTL, True);
    ActionOptionsSanctions.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionPIS, True);
    ActionOptionsGenererAutoFDM.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionGAF, True); // v1.3.5
    ActionOptionsListeToutesSolutions.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionLTS, False); // v1.3.6
    ActionOptionsListeToutesSolutionsExecute(ActionOptionsListeToutesSolutions); // v1.3.6
    ActionOptionsEnregistrerPartieAuto.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionEPA, True); // v1.5
    ActionOptionsPlacerPropositionAuto.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionPPA, False); // v1.6.9
    ActionOptionsEnregistrerEnQuittant.Checked:=IniFile.ReadBool(stSectionParametres, stEntreeOptionEEQ, True); // v1.6.5
    if FormDefinitionMot<>nil then // v1.6
      FormDefinitionMot.ComboBoxSource.ItemIndex:=ReadInteger(stSectionParametres, stEntreeActionsSD, 0);
    ActionAffichageNouveauxRecords.Checked:=IniFile.ReadBool(stSectionAffichage, stEntreeAffichageNR, True); // v1.5
    if r<>nil then r.AfficheNouveauxRecords:=ActionAffichageNouveauxRecords.Checked; // v1.5
    if IniFile.ReadBool(stSectionAffichage, stEntreeAffichageFR, False) then
      begin
      ActionAffichageRapportsNoteSur20.Checked:=True;
      ActionOptionsRapportsExecute(ActionAffichageRapportsNoteSur20) // v1.3.3
      end
    else
      begin
      ActionAffichageRapportsPourcentage.Checked:=True;
      ActionOptionsRapportsExecute(ActionAffichageRapportsPourcentage) // v1.3.3
      end;

    if FormParamPose<>nil then FormParamPose.LitParametres;

    DefinitDimensionsParDefaut(FormMainClientWidth, FormMainClientHeight);

    RafraichissementEnCours:=true;
    FormMain.ClientHeight:=ReadInteger(stSectionDimensions, stEntreeDimensionsHP, FormMainClientHeight);
    RafraichissementEnCours:=false;
    FormMain.ClientWidth:=ReadInteger(stSectionDimensions, stEntreeDimensionsLP, FormMainClientWidth);

    end{with};
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.EnregistreOptions;  // v1.3.2
var IniFile : TIniFile;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    WriteBool(stSectionParametres, stEntreeOptionJRS,    ActionOptionsJournalRecherche.Checked);
    WriteBool(stSectionParametres, stEntreeOptionTL,     ActionOptionsTempsLimite.Checked);
    WriteBool(stSectionParametres, stEntreeOptionPIS,    ActionOptionsSanctions.Checked);
    WriteBool(stSectionParametres, stEntreeOptionGAF,    ActionOptionsGenererAutoFDM.Checked); // v1.3.5
    WriteBool(stSectionParametres, stEntreeOptionLTS,    ActionOptionsListeToutesSolutions.Checked); // v1.3.6
    WriteBool(stSectionParametres, stEntreeOptionEPA,    ActionOptionsEnregistrerPartieAuto.Checked); // v1.5
    WriteBool(stSectionParametres, stEntreeOptionPPA,    ActionOptionsPlacerPropositionAuto.Checked); // v1.6.9
    WriteBool(stSectionParametres, stEntreeOptionEEQ,    ActionOptionsEnregistrerEnQuittant.Checked); // v1.6.5
    WriteInteger(stSectionParametres, stEntreeOptionTP,  Ord(TypePartie)); // v1.5.6
    WriteInteger(stSectionParametres, stEntreeOptionTR,  Ord(TempsReflexion)); // v1.5.6
    if FormParamPose<>nil then // v1.6
      with FormParamPose do  // v1.5.5
        begin
        WriteInteger(stSectionParametres, stEntreeOptionTQP, RadioGroupTypeQualitePose.ItemIndex);
        WriteInteger(stSectionParametres, stEntreeOptionPQP, TrackBar.Position);
        end;
    if FormDefinitionMot<>nil then // v1.6
      WriteInteger(stSectionParametres, stEntreeActionsSD, FormDefinitionMot.ComboBoxSource.ItemIndex);
    WriteBool(stSectionAffichage,  stEntreeAffichageNR, ActionAffichageNouveauxRecords.Checked); // v1.5
    WriteBool(stSectionAffichage,  stEntreeAffichageFR, ActionAffichageRapportsNoteSur20.Checked);
    WriteInteger(stSectionDimensions, stEntreeDimensionsLP, FormMain.ClientWidth);
    WriteInteger(stSectionDimensions, stEntreeDimensionsHP, FormMain.ClientHeight);
    WriteInteger(stSectionDimensions, stEntreeDimensionsLT, FormTirage.ClientWidth);
    WriteInteger(stSectionDimensions, stEntreeDimensionsHT, FormTirage.ClientHeight);
    NotifieAction(aanOptionsEnregistrerParametres, Actif); // v1.5
    end{with};
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.ReinitialiseOptions;  // v1.3.2
var IniFile                : TIniFile;
    FormMainClientWidth,
    FormMainClientHeight,
    FormTirageClientWidth,
    FormTirageClientHeight : Integer;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    ActionOptionsJournalRecherche.Checked:=False;
    ActionOptionsTempsLimite.Checked:=True;
    ActionOptionsSanctions.Checked:=True;
    ActionOptionsGenererAutoFDM.Checked:=True; // v1.3.5
    ActionOptionsListeToutesSolutions.Checked:=False; // v1.3.6
    ActionOptionsListeToutesSolutionsExecute(ActionOptionsListeToutesSolutions);
    ActionOptionsEnregistrerPartieAuto.Checked:=True; // v1.5
    ActionOptionsPlacerPropositionAuto.Checked:=False; // v1.6.9
    ActionOptionsEnregistrerEnQuittant.Checked:=True; // v1.6.5
    ChangeTypePartie(tpStandard); // v1.5.6
    ChangeTempsReflexion(trNormal); // v1.5.6
    if FormDefinitionMot<>nil then // v1.6
      FormDefinitionMot.ComboBoxSource.ItemIndex:=0;
    ActionAffichageRapportsPourcentage.Checked:=True;
    ActionAffichageNouveauxRecords.Checked:=True; // v1.5
    if r<>nil then r.AfficheNouveauxRecords:=True; // v1.5
    ActionOptionsRapportsExecute(ActionAffichageRapportsPourcentage); // v1.3.3

    DefinitDimensionsParDefaut(FormMainClientWidth, FormMainClientHeight);

    RafraichissementEnCours:=True;
    ClientHeight:=FormMainClientHeight;
    RafraichissementEnCours:=False;
    ClientWidth:=FormMainClientWidth;

    if FormParamPose<>nil then // v1.6
      with FormParamPose do // v1.5.5
        begin
        TypeQualitePose:=tqpTops;
        QualitePose:=High(TQualitePose);
        end;

    if FormTirage<>nil then
      with FormTirage do
        begin
        DefinitDimensionsParDefaut; // v1.8.2 : plus de paramètres FormTirageCLient
        ClientWidth:=FormTirageClientWidth;
        ClientHeight:=formTirageClientHeight;
        Top:=FormMain.Top;
        Left:=FormMain.Left+FormMain.Width;
        end;

    if FormFeuilleMatch<>nil then
      with FormFeuilleMatch do // v1.5.3
        if Visible then begin Hide; Show; end;

    NotifieAction(aanOptionsRetablirParametres, Actif); // v1.5
    end{with};
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.EnregistrePartie; // v1.4.9
const
    stFrmSolutionsSurTours = '%d solutions sur %d tours';
    stFrmScoreMoyenParTour = 'soit %.1f pts par tour';
    stFrmTempsEnTours = '%.2f sec. sur %d tours';
    stFrmNbSolSurTemps = '%d solutions en %.2f sec.';
var i,
    NivDiff,
    NbBonusPrp,
    NbBonusTop,
    ScoreBonusPrp,
    ScoreBonusTop,
    NbTopsTrv     : Integer; // v1.5
    IniFile       : TIniFile;
    ExisteDeja,
    TiragePropose : Boolean; // v1.5.3
    stLibAlt,// v1.5
    stUrlBmp,// v1.5
    stLibelle,//v1.5
    stNom, st     : string;
begin
if DemoEnCours then Exit;
ExisteDeja:=False;
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    stNom:=copy(ExtractFileName(stNomFichierPartie),1,length(ExtractFileName(stNomFichierPartie))-length(ExtractFileExt(stNomFichierPartie)));
    // Tester avant si stNom existe déjà
    i:=1;
    Repeat
     st:=IniFile.ReadString(stSectionParties, stEntreePartiesNom+IntToStr(i), '');
     if st<>'' then
       ExisteDeja:=(stNom=st);
     Inc(i);
    Until ExisteDeja or (st='');
    if not ExisteDeja then
      begin
      i:=IniFile.ReadInteger(stSectionParties, stEntreePartiesNbParties, 0);
      Inc(i);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesNbParties, i);
      IniFile.WriteString(stSectionParties,  stEntreePartiesNom+IntToStr(i), stNom);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesNbCoups+IntToStr(i), p.Tour-1);
      IniFile.WriteString(stSectionParties,  stEntreePartiesReliquat+IntToStr(i), p.stTirage[p.Tour]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesScore+IntToStr(i), p.Cumul[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesJoue+IntToStr(i), p.CumulPartie[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesTop+IntToStr(i), p.CumulTop[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesTemps+IntToStr(i), Round(24*3600*p.CumulTemps[p.Tour-1]));
      IniFile.WriteInteger(stSectionParties, stEntreePartiesRgMoyen+IntToStr(i), p.CumulPosPrp[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesNbSolMoyen+IntToStr(i), p.CumulNbSol[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesNbSolBonus+IntToStr(i), p.CumulNbSolBonus50[p.Tour-1]);
      IniFile.WriteInteger(stSectionParties, stEntreePartiesNbSolSEMT+IntToStr(i), Round(1000.0*p.CumulNbSolSEMoitieTop[p.Tour-1])); // v1.5.1 : Calcul pondéré par ScoreTop. Rationnel multiplié par 1000 pour garder de la précision
      IniFile.WriteBool(stSectionParties,    stEntreePartiesNivDiffPondere+IntToStr(i), p.VersionFichier>=$150); // v1.5.1 : indicateur de pondération du niveau de difficulté moyen par ScoreTop
      IniFile.WriteString(stSectionParties,  stEntreePartiesDateHeure+IntToStr(i), stDateHeureCourante); // v1.5
      IniFile.WriteInteger(stSectionParties, stEntreePartiesTypePartie+IntToStr(i), Ord(p.TypePartie)); // v1.5.6
      if (p.VersionFichier>=$160) and (p.CumulTpsCalculSol[p.Tour-1]>0) then // v1.6 : Records liés au temps de calcul des solutions
        IniFile.WriteInteger(stSectionParties, stEntreePartiesTpsCalcSol+IntToStr(i), Round(100*p.CumulTpsCalculSol[p.Tour-1])); // v1.6
      // v1.5.3 : On teste ici si un tirage a été proposé. Dans ce cas, aucun record de partie n'est enregistré
      TiragePropose:=False;
      for i:=Low(TTour) to p.Tour-1 do
        if p.TiragePropose[i] then TiragePropose:=True;
      if not TiragePropose then // v1.5.3
        with r do // v1.5 : on teste les records de parties ici
          begin
          // Score (prp & top)
          // v1.5.1 : Ajout info complémentaire pour les records de score de partie ci-dessous (Proposition & top) : score moyen par tour
          TesteRecord(srProposition, nvrPartie, trMax, ntrScore, 0, p.Cumul[p.Tour-1], Format(stFrmScoreMoyenParTour, [(1.0*p.Cumul[p.Tour-1])/(p.Tour-1)]));
          TesteRecord(srTop,         nvrPartie, trMax, ntrScore, 0, p.CumulTop[p.Tour-1], Format(stFrmScoreMoyenParTour, [(1.0*p.CumulTop[p.Tour-1])/(p.Tour-1)]));
          // Nb Bonus (prp & top)
          NbBonusPrp:=0; NbBonusTop:=0;
          ScoreBonusPrp:=0; ScoreBonusTop:=0;
          for i:=Low(TTour) to p.Tour-1 do
            begin
            if p.BonusScrabblePrp[i] then
              begin
              Inc(NbBonusPrp);
              Inc(ScoreBonusPrp, p.Score[i]);
              end;
            if p.BonusScrabbleSol[i] then
              begin
              Inc(NbBonusTop);
              Inc(ScoreBonusTop, p.ScoreTop[i]);
              end
            end;
          TesteRecord(srProposition, nvrPartie, trMax, ntrNbBonus, 0, NbBonusPrp, Format('sur %d, avec %d pts sur %d', [NbBonusTop, ScoreBonusPrp, ScoreBonusTop]));
          TesteRecord(srTop,         nvrPartie, trMax, ntrNbBonus, 0, NbBonusTop, Format('avec %d pts', [ScoreBonusTop]));
          // Niv.de diff. (Min & Max)
          NivDiff:=CalculeNiveauDifficulte(p.CumulNbSolSEMoitieTop[p.Tour-1],
                                           p.CumulTop[p.Tour-1], // v1.5.1 : Niveau de difficulté moyen pondéré par ScoreTop
                                           stLibAlt, stUrlBmp);
          stLibelle:=Copy(stLibAlt, 4+Pos('/10', stLibAlt), Length(stLibAlt));
          TesteRecord(srGenerale, nvrPartie, trMax, ntrNivDiff, 0, NivDiff, stLibelle);
          TesteRecord(srGenerale, nvrPartie, trMin, ntrNivDiff, 0, NivDiff, stLibelle);
          // NbSol/Rang (Proposition)
          if p.CumulPosPrp[p.Tour-1]>0 then // Précaution
            TesteRecord(srProposition, nvrPartie, trMax, ntrNbSolSurRg, 0,
                        Round(((100*p.CumulNbSol[p.Tour-1]) div (p.Tour-1))/(p.CumulPosPrp[p.Tour-1] div (p.Tour-1))),
                        Format('%d%s sur %d', [p.CumulPosPrp[p.Tour-1] div (p.Tour-1),
                                               stSuffixeRang[Ord(p.CumulPosPrp[p.Tour-1] div (p.Tour-1)>1)],
                                               p.CumulNbSol[p.Tour-1] div (p.Tour-1)]));
          // Nb de solutions
          TesteRecord(srGenerale,    nvrPartie, trMax, ntrNbSolutions, 0,
                      Round((100.0*p.CumulNbSol[p.Tour-1])/(p.Tour-1)),
                      Format(stFrmSolutionsSurTours, [p.CumulNbSol[p.Tour-1], p.Tour-1]));
          TesteRecord(srGenerale,    nvrPartie, trMin, ntrNbSolutions, 0,
                      Round((100.0*p.CumulNbSol[p.Tour-1])/(p.Tour-1)),
                      Format(stFrmSolutionsSurTours, [p.CumulNbSol[p.Tour-1], p.Tour-1]));
          // Rapport Score/Top
          TesteRecord(srProposition, nvrPartie, trMax, ntrRptScoreTop, 0,
                      Round((10000.0*p.Cumul[p.Tour-1])/p.CumulTop[p.Tour-1]),
                      Format('%d pts sur un top de %d', [p.Cumul[p.Tour-1], p.CumulTop[p.Tour-1]]));
          // NbSolBonus50
          TesteRecord(srGenerale,    nvrPartie, trMax, ntrNbSolBonus, 0,
                      Round((100.0*p.CumulNbSolBonus50[p.Tour-1])/(p.Tour-1)),
                      Format('%d bonus sur %d tours', [p.CumulNbSolBonus50[p.Tour-1], p.Tour-1])); // v1.5.1 : ajout de l'info complémentaire
          // NbTopsTrv
          NbTopsTrv:=0;
          for i:=1 to p.Tour-1 do
            if p.Score[i]=p.ScoreTop[i] then Inc(NbTopsTrv);
          TesteRecord(srProposition, nvrPartie, trMax, ntrNbTopsTrv, 0,
                      Round((10000.0*NbTopsTrv)/(p.Tour-1)),
                      Format('soit %d top[s] sur %d tours', [NbTopsTrv, p.Tour-1]));
          // v1.6 : Records liés au temps de calcul des solutions
          if (p.VersionFichier>=$160) and (p.CumulTpsCalculSol[p.Tour-1]>0) then
            begin
            TesteRecord(srGenerale, nvrPartie, trMin, ntrTpsCalcSol, 0, Round((100.0*p.CumulTpsCalculSol[p.Tour-1])/(p.Tour-1)), Format(stFrmTempsEnTours, [p.CumulTpsCalculSol[p.Tour-1], p.Tour-1]));
            TesteRecord(srGenerale, nvrPartie, trMax, ntrTpsCalcSol, 0, Round((100.0*p.CumulTpsCalculSol[p.Tour-1])/(p.Tour-1)), Format(stFrmTempsEnTours, [p.CumulTpsCalculSol[p.Tour-1], p.Tour-1]));
            TesteRecord(srGenerale, nvrPartie, trMin, ntrNbSolParSec, 0, Round(p.CumulNbSol[p.Tour-1]/p.CumulTpsCalculSol[p.Tour-1]), Format(stFrmNbSolSurTemps, [p.CumulNbSol[p.Tour-1], p.CumulTpsCalculSol[p.Tour-1]]));
            TesteRecord(srGenerale, nvrPartie, trMax, ntrNbSolParSec, 0, Round(p.CumulNbSol[p.Tour-1]/p.CumulTpsCalculSol[p.Tour-1]), Format(stFrmNbSolSurTemps, [p.CumulNbSol[p.Tour-1], p.CumulTpsCalculSol[p.Tour-1]]));
            end

          end{with r}
        {if not TiragePropose}
      end{if}
    end{with};
finally
  FreeAndNil(IniFile);
  if not ExisteDeja then
    GenereListePartiesJouees(NAffichePas)
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.GenereListePartiesJouees(const Affichage : Boolean); // v1.4.9
var i, n,
    NbCoups,
    Propose,
    Joue, Top,
    Rang, Nbsol,
    NbSolBonus,       // v1.5
    Duree               : Integer;
    CumulCoups,
    CumulPropose,
    CumulJoue,
    CumulTop,
    CumulDuree,
    CumulRang,
    CumulNbSol,
    CumulNbSolPrec,
    CumulTopDiff,     // v1.5.1 : pour exclure les parties créées avec une version < v1.5
    CumulNbSolBonus,
    CumulNbSolTpsCalcSol, // v1.6
    NbToursPartiesAvB50, // v1.5 : pour exclure les parties créées avec une version < v1.5
    NbPartiesTpsCalcSol,
    NbParties           : array [TTypePartie] of Integer; // v1.5.6 : NbParties + total par type de partie
    CumulTpsCalcSol,    // v1.6
    CumulNbSolSEMT      // v1.5
                        : array [TTypePartie] of Double;  // v1.5.6 : Il y a un total par type de partie
    NbSolParSec,        // v1.6
    TpsCalculSol,       // v1.6
    NbSolSEMT           : Double;  // v1.5.1 : Integer => Double car pondéré par ScoreTop
    NivDiffPondere      : Boolean; // v1.5.1 : indique si le niveau de difficulté moyen a été pondéré ou non par ScoreTop
    TypePartie          : TTypePartie; // v1.5.6 : on fait un total par type de partie (normale, "Joker", ...)
    IniFile             : TIniFile;
    f                   : TextFile;
    stNom,
    stReliquat,
    stNomFichier,
    stDuree,
    stRapport,                     // v1.5 : Utilisation du format de rapport paramétré (% ou /20)
    stNbSolAvBonus,                // v1.5
    stLibAltDiff,                  // v1.5
    stUrlBmp,                      // v1.5
    stDateHeure,                   // v1.5
    stTpsCalcSol,                  // v1.6
    stNbSolParSec       : string;  // v1.6
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    for TypePartie:=tpStandard to High(TTypePartie) do // v1.5.6 : cumuls par type de partie
      begin
      CumulCoups[TypePartie]:=0; CumulPropose[TypePartie]:=0; CumulJoue[TypePartie]:=0;
      CumulTop[TypePartie]:=0; CumulDuree[TypePartie]:=0; CumulRang[TypePartie]:=0; CumulNbSol[TypePartie]:=0;
      CumulTopDiff[TypePartie]:=0; CumulNbSolSEMT[TypePartie]:=0.0; // v1.5
      CumulNbSolBonus[TypePartie]:=0; NbToursPartiesAvB50[TypePartie]:=0; // v1.5
      NbParties[TypePartie]:=0; // v1.5.6
      // v1.6 : Tps de calcul des solutions
      NbPartiesTpsCalcSol[TypePartie]:=0;
      CumulTpsCalcSol[TypePartie]:=0;
      CumulNbSolTpsCalcSol[TypePartie]:=0;
      end;
    n:=IniFile.ReadInteger(stSectionParties, stEntreePartiesNbParties, 0);
    stNomFichier:=stRepLocalAppData+'Parties.html'; // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
    AssignFile(f, stNomFichier);
    Rewrite(f);
    Write(f, stFrmHTMLLdPJEnT); // v1.5 : chgt de nom de constante isolée dans une unité séparée
    for i:=1 to n do
      begin
      stNom:=IniFile.ReadString(stSectionParties, stEntreePartiesNom+IntToStr(i), '');
      if stNom='' then stNom:=stHTMLItaliqueSansNom; // v1.5
      NbCoups:=IniFile.ReadInteger(stSectionParties, stEntreePartiesNbCoups+IntToStr(i), 0);
      stReliquat:=IniFile.ReadString(stSectionParties, stEntreePartiesReliquat+IntToStr(i), '');
      if stReliquat='' then stReliquat:=stHTMLEspaceInsecable; // v1.5
      Propose:=IniFile.ReadInteger(stSectionParties, stEntreePartiesScore+IntToStr(i), 0);
      Joue:=IniFile.ReadInteger(stSectionParties, stEntreePartiesJoue+IntToStr(i), 0);
      Top:=IniFile.ReadInteger(stSectionParties, stEntreePartiesTop+IntToStr(i), 0);
      Duree:=IniFile.ReadInteger(stSectionParties, stEntreePartiesTemps+IntToStr(i), 0);
      stDuree:=Format(stFormatDuree, [Duree div 60, Duree mod 60]);
      stDuree:=StringReplace(stDuree, ' ', '0', [rfReplaceAll]);
      Rang:=Round((1.0*IniFile.ReadInteger(stSectionParties, stEntreePartiesRgMoyen+IntToStr(i), 0))/NbCoups);
      NbSol:=Round((1.0*IniFile.ReadInteger(stSectionParties, stEntreePartiesNbSolMoyen+IntToStr(i), 0))/NbCoups);

      // v1.5 : NbSolBonus
      NbSolBonus:=IniFile.ReadInteger(stSectionParties, stEntreePartiesNbSolBonus+IntToStr(i), 0);
      if NbSolBonus=0 then
        stNbSolAvBonus:=stHTMLEspaceInsecable
      else
        stNbSolAvBonus:=Format('%.1f', [(1.0*NbSolBonus)/NbCoups]);

      stDateHeure:=IniFile.ReadString(stSectionParties, stEntreePartiesDateHeure+IntToStr(i), ''); // v1.5
      if stDateHeure='' then stDateHeure:=stHTMLEspaceInsecable; // v1.5

      // v1.5 : calcul du niveau de difficulté de la partie (parties générées avec version >=1.5)
      // v1.5.1 : NivDiffPondere à vrai si niveau de difficulté pondéré par ScoreTop (>=v1.5.1)
      NivDiffPondere:=IniFile.ReadBool(stSectionParties, stEntreePartiesNivDiffPondere+IntToStr(i), False);
      if NivDiffPondere then
        begin
        // v1.5.1 : Nouveau calcul du Niveau de difficulté moyen : PONDERE par ScoreTop
        NbSolSEMT:=(1.0*IniFile.ReadInteger(stSectionParties, stEntreePartiesNbSolSEMT+IntToStr(i), 0))/1000.0;
        CalculeNiveauDifficulte(NbSolSEMT, Top, stLibAltDiff, stUrlBmp)
        end
      else
        begin
        // v1.5.1 : Ancien calcul du Niveau de difficulté moyen : NON pondéré par ScoreTop
        NbSolSEMT:=1.0*IniFile.ReadInteger(stSectionParties, stEntreePartiesNbSolSEMT+IntToStr(i), 0)/NbCoups;
        CalculeNiveauDifficulte(NbSolSEMT, NbSol, stLibAltDiff, stUrlBmp);
        end;
      TypePartie:=TTypePartie(IniFile.ReadInteger(stSectionParties, stEntreePartiesTypePartie+IntToStr(i), Ord(tpStandard))); // v1.5.6
      Inc(NbParties[TypePartie]); // v1.5.6

      // v1.6 : Temps de calcul & nombre de solutions par seconde
      TpsCalculSol:=IniFile.ReadInteger(stSectionParties, stEntreePartiesTpsCalcSol+IntToStr(i), 0)/NbCoups/100.0;
      if TpsCalculSol=0 then
        NbSolParSec:=0
      else
        NbSolParSec:=Round(NbSol/TpsCalculSol);
      if TpsCalculSol=0 then
        begin
        stTpsCalcSol:=stHTMLEspaceInsecable;
        stNbSolParSec:=stHTMLEspaceInsecable;
        end
      else
        begin
        stTpsCalcSol:=Format(stFrmTpsCalcSol, [TpsCalculSol]);
        stNbSolParSec:=Format(stFrmNbSolParSec, [1.0*NbSolParSec]) // Format %f donc on forme un double au lieu d'un entier
        end;
      // v1.5 : pour les deux lignes ci-dessous, utilisation du format de rapport paramétré (% ou /20)
      stRapport:=Format('%.1f%s', [(1.0*MaxFormatRapport[FormatRapport]*Propose)/Top, stFormatRapport[FormatRapport]]);
      // v1.5 : (ci-dessous) chgt de nom de constante isolée dans une unité séparée

      Write(f, Format(stFrmHTMLLdPJLgn, [i,
                                         Format(stFrmHTMLTypePartie[TypePartie], [stNom]), // v1.5.6 : on colorie les types de partie non standard
                                         stDateHeure, // v1.5
                                         NbCoups, stReliquat, stDuree, Propose,
                                         stCodeCouleurHTMLRapport((1.0*Propose)/Top, False), // v1.6.3 : False (argument pour masquer)
                                         stRapport, Joue, Top, Rang, NbSol,
                                         IfThen(NivDiffPondere or (NbSolSEMT=0), '','*'), // Indique un niveau de difficulté non pondéré par le score top (partie v1.5)
                                         stNbSolAvBonus, // v1.5
                                         stUrlBmp, stLibAltDiff, // v1.5 (voir ci-après rq Write de la ligne Moyenne)
                                         stTpsCalcSol, stNbSolParSec])); // v1.6 : Temps de calcul & nombre de solutions par seconde
      // v1.5.6 ci-dessous : [TypePartie]
      Inc(CumulCoups[TypePartie], NbCoups);
      Inc(CumulPropose[TypePartie], Propose);
      Inc(CumulJoue[TypePartie], Joue);
      Inc(CumulTop[TypePartie], Top);
      Inc(CumulDuree[TypePartie], Duree);
      CumulNbSolPrec[TypePartie]:=CumulNbSol[TypePartie];
      Inc(CumulNbSol[TypePartie], NbSol);
      if NbSolSEMT>0 then
        begin
        CumulNbSolSEMT[TypePartie]:=CumulNbSolSEMT[TypePartie]+NbSolSEMT; // v1.5.6 : Calcul erroné : ...+NbSolSEMT à la place de ...+(NbSolSEMT*Top)/NbSol
        Inc(CumulTopDiff[TypePartie], Top);
        end;
      Inc(CumulNbSolBonus[TypePartie], NbSolBonus);  // v1.5
      if NbSolBonus>0 then Inc(NbToursPartiesAvB50[TypePartie], NbCoups); // v1.5 : pour exclure les parties créées avec une version < v1.5
      if NbParties[TypePartie]>1 then // v1.5 : Débordement d'entier : utilisation des entiers 64 bits
        CumulRang[TypePartie]:=((Int64(Rang)*Int64(CumulNbSol[TypePartie])) div NbSol +
                                (Int64(Pred(NbParties[TypePartie]))*Int64(CumulRang[TypePartie])*Int64(CumulNbSol[TypePartie])) div CumulNbSolPrec[TypePartie]) div NbParties[TypePartie]
      else
        CumulRang[TypePartie]:=Rang;
      if TpsCalculSol>0 then // v1.6
        begin
        CumulTpsCalcSol[TypePartie]:=CumulTpsCalcSol[TypePartie]+TpsCalculSol;
        Inc(CumulNbSolTpsCalcSol[TypePartie], NbSol);
        Inc(NbPartiesTpsCalcSol[TypePartie])
        end
      end{for}
    end{with};

    if n>1 then // v1.5.6 : moyenne par type de partie : n est remplacé par NbParties[TypePartie]
      for TypePartie:=tpStandard to High(TTypePartie) do // v1.5.6
        if NbParties[TypePartie]>0 then // v1.5.6
          begin
          // v1.5 : NbSolBonus
          if NbToursPartiesAvB50[TypePartie]=0 then
            stNbSolAvBonus:=stHTMLEspaceInsecable
          else
            stNbSolAvBonus:=Format('%.1f', [(1.0*CumulNbSolBonus[TypePartie])/NbToursPartiesAvB50[TypePartie]]);

          stDuree:=Format(stFormatDuree, [Round((1.0*CumulDuree[TypePartie])/NbParties[TypePartie]) div 60, Round((1.0*CumulDuree[TypePartie])/NbParties[TypePartie]) mod 60]);
          stDuree:=StringReplace(stDuree, ' ', '0', [rfReplaceAll]);
          // v1.5 : Utilisation du format de rapport paramétré (% ou /20)
          stRapport:=Format('%.1f%s', [(1.0*MaxFormatRapport[FormatRapport]*CumulPropose[TypePartie])/CumulTop[TypePartie], stFormatRapport[FormatRapport]]);

          // v1.5 : calcul du niveau de difficulté de la partie (parties générées avec version >=1.5)
          CalculeNiveauDifficulte(CumulNbSolSEMT[TypePartie], CumulTopDiff[TypePartie], stLibAltDiff, stUrlBmp); // v1.5.1 : calcul pondéré avec ScoreTop

          // v1.6 : Temps de calcul & nombre de solutions par seconde
          if CumulTpsCalcSol[TypePartie]=0 then
            begin
            stTpsCalcSol:=stHTMLEspaceInsecable;
            stNbSolParSec:=stHTMLEspaceInsecable;
            end
          else
            begin
            stTpsCalcSol:=Format(stFrmTpsCalcSol, [CumulTpsCalcSol[TypePartie]/NbPartiesTpsCalcSol[TypePartie]]);
            stNbSolParSec:=Format(stFrmNbSolParSec, [CumulNbSolTpsCalcSol[TypePartie]/CumulTpsCalcSol[TypePartie]])
            end;

          Write(f, Format(stFrmHTMLLdPJMoy, // v1.5 : chgt de nom de constante isolée dans une unité séparée
                          [Format(stFrmHTMLTypePartie[TypePartie], [stTypePartie[TypePartie]]), // v1.5.6
                           Round((1.0*CumulCoups[TypePartie])/NbParties[TypePartie]),
                           stDuree,
                           Round((1.0*CumulPropose[TypePartie])/NbParties[TypePartie]),
                           stCodeCouleurHTMLRapport((1.0*CumulPropose[TypePartie])/CumulTop[TypePartie], False), // v1.5 : code couleur pour les rapports. v1.6.3 : False (argument pour masquer)
                           stRapport, // v1.5 : au lieu de (100.0*CumulPropose)/CumulTop,
                           Round((1.0*CumulJoue[TypePartie])/NbParties[TypePartie]), Round((1.0*CumulTop[TypePartie])/NbParties[TypePartie]),
                           Trunc(CumulRang[TypePartie]/NbParties[TypePartie]), Trunc(CumulNbSol[TypePartie]/NbParties[TypePartie]),
                           stNbSolAvBonus, // v1.5
                           stUrlBmp, stLibAltDiff, // v1.5
                           stTpsCalcSol, stNbSolParSec]))
          end;

    // v1.5 : chgt de nom de constante isolée dans une unité séparée
    Write(f, Format(stFrmHTMLLdPJPdP1+stFrmHTMLLdPJPdP2+stFrmHTMLLdPJPdP3, // v1.6.2 : il manquait P3
                    [stURLBitmapNiveauDifficulte(dtIndefinie), stAltDiffTirage[dtIndefinie],
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
    NotifieAction(aanAffichagePartiesJoueesCAC, Affichage); // v1.5
finally
  FreeAndNil(IniFile);
  CloseFile(f);
  if Affichage then
    OuvreFichierHTML(stNomFichier);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormMain.GenereListeRecords(const Affichage : Boolean); // v1.5
var IniFile         : TIniFile;
    f               : TextFile;
    i               : Integer;
    stNomFichier    : String;
function stHTMLCelluleRecord(const r : TRecord) : string;
  const stFrmHTMLParenthesesBR = '(%s)<br>';
        stHTMLBreakReturn      = '<br>';
  begin
  if r.RecordPossible then
    if r.AucunRecord then
      Result:=stHTMLRecordAucun
    else
      if r.Tour=0 then
        Result:=Format(stFrmHTMLLdRCell, [r.stHTMLValeur(cirPageHTML),
                                          IfThen((r.stLibelle='') or
                                                 (r.Nature=ntrNivDiff),
                                                 '',
                                                 Format(stFrmHTMLParenthesesBR,
                                                        [r.stLibelle])),
                                          IfThen(r.stNomPartie='',
                                                 '',
                                                 r.stNomPartie+stHTMLBreakReturn),
                                          '',
                                          r.stDateHeure])
      else
        Result:=Format(stFrmHTMLLdRCell, [r.stHTMLValeur(cirPageHTML),
                                          IfThen((r.stLibelle='') or
                                                 (r.Nature=ntrNivDiff),
                                                 '',
                                                 Format(stFrmHTMLParenthesesBR,
                                                        [r.stLibelle])),
                                          IfThen(r.stNomPartie='',
                                                 '',
                                                 r.stNomPartie+'&nbsp;: '),
                                          Format('Tour %d<br>', [r.Tour]),
                                          r.stDateHeure])
  else
    Result:=stHTMLRecordNonAttribue;
  // v1.5.7 : On met la couleur suivant le type de partie
  Result:=Format(stFrmHTMLLdRTexte, [Format(stFrmHTMLTypePartie[r.TypePartie], [Result])])
  end;
function stHTMLLigneNatureRecord(const n : TNatureRecord) : string;
  begin
  case n of
    ntrNivDiff,
    ntrNbSolutions,
    // v1.6 : les deux natures de recourds ci-dessous
    ntrTpsCalcSol,
    ntrNbSolParSec: Result:=Format(stFrmHTMLLdR2LMin, [stNatureRecord[n], // v1.5.7 : ajout de tpStandard/tpJoker ci-dessous
                                                       stHTMLCelluleRecord(r.MeilleurRecord(srGenerale,    nvrTour,   trMin, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMin, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMin, n, tpJoker])+
                                                       stHTMLCelluleRecord(r.MeilleurRecord(srProposition, nvrTour,   trMin, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMin, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMin, n, tpJoker])+
                                                       stHTMLCelluleRecord(r.MeilleurRecord(srTop,         nvrTour,   trMin, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMin, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMin, n, tpJoker])])+
                            Format(stFrmHTMLLdR2LMax, [stHTMLCelluleRecord(r.MeilleurRecord(srGenerale,    nvrTour,   trMax, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMax, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMax, n, tpJoker])+
                                                       stHTMLCelluleRecord(r.MeilleurRecord(srProposition, nvrTour,   trMax, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMax, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMax, n, tpJoker])+
                                                       stHTMLCelluleRecord(r.MeilleurRecord(srTop,         nvrTour,   trMax, n))+ // v1.5.8 : on prend le meilleur tout type de partie confondu
                                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMax, n, tpStandard])+
                                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMax, n, tpJoker])])
  else
    Result:=Format(stFrmHTMLLdR1LMax, [stNatureRecord[n], // v1.5.7 : ajout de tpStandard/tpJoker ci-dessous
                                       stHTMLCelluleRecord(r.MeilleurRecord(srGenerale,    nvrTour,   trMax, n))+
                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMax, n, tpStandard])+
                                       stHTMLCelluleRecord(r.r[srGenerale,     nvrPartie, trMax, n, tpJoker])+
                                       stHTMLCelluleRecord(r.MeilleurRecord(srProposition, nvrTour,   trMax, n))+
                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMax, n, tpStandard])+
                                       stHTMLCelluleRecord(r.r[srProposition,  nvrPartie, trMax, n, tpJoker])+
                                       stHTMLCelluleRecord(r.MeilleurRecord(srTop,         nvrTour,   trMax, n))+
                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMax, n, tpStandard])+
                                       stHTMLCelluleRecord(r.r[srTop,          nvrPartie, trMax, n, tpJoker])]);
  end{case of}
  end;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    stNomFichier:=stRepLocalAppData+'Records.html'; // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
    AssignFile(f, stNomFichier);
    Rewrite(f);
    Write(f, stFrmHTMLLdREnT);
    for i:=Ord(Low(TNatureRecord)) to Ord(High(TNatureRecord)) do
      Write(f, stHTMLLigneNatureRecord(TNatureRecord(i)));
    Write(f, Format(stFrmHTMLLdRPdP1+stFrmHTMLLdRPdP2+stFrmHTMLLdRPdP3,
                    [stURLBitmapNiveauDifficulte(dtIndefinie), stAltDiffTirage[dtIndefinie],
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
    NotifieAction(aanAffichageRecordsCAC, Affichage); // v1.5
    end;
finally
  FreeAndNil(IniFile);
  CloseFile(f);
  if Affichage then
    OuvreFichierHTML(stNomFichier);
end
end;
//---------------------------------------------------------------------------
procedure TFormMain.NotifieAction(Action : TActionANotifier; Activee : Boolean);
begin // v1.5 : Notification des actions sur la barre de statut
if (Action=aanPartieDemonstrationCAC) and (Activee=True) then
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=Format(stMsgNotificationAction[Action, Activee],
                                                       [ShortCutToText(ActionPartieDemonstration.ShortCut)])
else
  StatusBar.Panels.Items[Ord(ibsMessage)].Text:=stMsgNotificationAction[Action, Activee]
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeTypePartie(const TypePartie : TTypePartie); // v1.5.6
begin
FTypePartie:=TypePartie;
case TypePartie of
 tpStandard: ActionOptionsTypePartieStandard.Checked:=True;
 tpJoker:    ActionOptionsTypePartieJoker.Checked:=True;
end
end;
//---------------------------------------------------------------------------
procedure TFormMain.ChangeTempsReflexion(const TempsReflexion : TTempsReflexion); // v1.5.6
begin
FTempsReflexion:=TempsReflexion;
case TempsReflexion of
 trNormal:     ActionOptionsTypePartieNormale.Checked:=True;
 trSemiRapide: ActionOptionsTypePartieSemiRapide.Checked:=True;
 trBlitz:      ActionOptionsTypePartieBlitz.Checked:=True;
end
end;
//---------------------------------------------------------------------------

end.
