(******************************************************************************
LE COMPTE POUR DE BON - Atelier de recherche de calculs de comptes à trouver

Copyright (C) 2005 Patrice FOUQUET

Ce programme est un logiciel libre ; vous pouvez le redistribuer et/ou le
modifier conformément aux dispositions de la Licence Publique Générale GNU,
telle que publiée par la Free Software Foundation ; version 2 de la licence,
ou encore toute version ultérieure.

Ce programme est distribué dans l'espoir qu'il sera utile,
mais SANS AUCUNE GARANTIE ; sans même la garantie implicite de COMMERCIALISATION
ou D'ADAPTATION A UN OBJET PARTICULIER. Pour plus de détail,
voir la Licence Publique Générale GNU.

Vous devez avoir reçu un exemplaire de la Licence Publique Générale GNU en même
temps que ce programme ; si ce n'est pas le cas,
écrivez à la Free Software Foundation Inc.,
675 Mass Ave, Cambridge, MA 02139, Etats-Unis.

Pour toutes informations:
mailto:lcpdb@patquoi.fr
http://patquoi.free.fr/#jm

-------------------------------------------------------------------------------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
******************************************************************************)
//-----------------------------------------------------------------------------
unit IA;
//-----------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------
Uses Classes, ComCtrls, Winapi.Windows;
//-----------------------------------------------------------------------------
const
//-----------------------------------------------------------------------------
  NbMaxPlaques               =  6; // Les 6 nombres donnés au départ
  NbMaxNombresGeneres        = 11; // Nombres donnés (6 max) + Résultats intermédiaires (5 max)
  NbMaxChoixOperandes        = 20; // Le plus de possibilités de choix = 4 opérandes parmi 6 = 20
  NbMaxChoixContrarietes     = 64; // Le plus de possibilités de choix = 6 indicateurs contraires = 2^6 = 64 possibilités
  NbChiffresMaxResultatMax   =  9; // Le résultat max peut avoir au maximum 9 chiffres
  NbOptimisationsCalcul      =  4; // Nombre d'optimisations de calcul paramétrables
  NbMaxLignesCalcul          =  5; // Nombre maximum de lignes de calcul
  ndIndefini                 = -1;
  ndTresFacile               =  0;
  ndTresDifficile            =  8;
  ndIntrouvable              =  9;
  stPluriel                  : Array[Boolean] of String = ('', 's'); // Gestion du pluriel pour enlever les parenthèses. v1.2
//-----------------------------------------------------------------------------
type
//-----------------------------------------------------------------------------
  TValeurPlaque              = 0..100; // Intervalle de valeurs des plaques (Utilisé uniquement dans tableau_f et pavenum_f)
  TIndexNombreGenere         = 0..NbMaxNombresGeneres-1; // Nombres utilisés ou non
  TIndexNombreUtilisable     = 0..NbMaxPlaques-1; // Nombres utilisables uniquement
  TNbNombresUtilisables      = 0..NbMaxPlaques;
  TNbOperandes               = 2..NbMaxPlaques;
  TIndexLigneCalcul          = 0..NbMaxLignesCalcul-1;
  TNbLignesCalcul            = 0..NbMaxLignesCalcul;
  TNumeroChoixOperandes      = 0..NbMaxChoixOperandes-1; // Maximum : 4 opérandes parmi 6 = 20 choix possibles
  TNbChoixOperandes          = 0..NbMaxChoixOperandes; // Maximum : 4 opérandes parmi 6 = 20 choix possibles
  TNbChoixContrarietes       = 0..NbMaxChoixContrarietes; // Maximum : 6 indicateurs contraires = 2^6 = 64 possibilités
  TNumeroChoixContrarietes   = 0..NbMaxChoixContrarietes-1; // Maximum : 6 indicateurs contraires = 2^6 = 64 possibilités
  TOperateur                 = (oPlus, oMultiplie);
  TValeur                    = Integer; // OPTIMISATION n°10 (au lieu de Int64)

  TSortie                    = (sAucune, sEcran, sFichier, sPartout);
  TSortieEcran               = (seAucun, seTypeListe, seTypeArbre, seTout);
  TSortieFichier             = (sfAucun, sfTypeEnonce, sfEnProfondeur, sfTout);
  TOptimisationCalcul        = ( ocPasDeMultiplicationDivisionPar1, // Paramétrable (Activé par défaut)
                                 ocPasDeResultatMemeTypeOperande, // Paramétrable (Activé par défaut)
                                 ocPasDeResultatEgalOperande, // Paramétrable (Activé par défaut)
                                 ocPasDOperandesContraires, // Paramétrable (Activé par défaut)
                                 ocResultatInutilise, // Toujours activé
                                 ocPasDeResultatEgalCompte); // Paramétrable (Activé par défaut). v1.2
  TOptimisationsCalcul       = set of TOptimisationCalcul;
  TNiveauDifficulte          = ndIndefini..ndIntrouvable;
//-----------------------------------------------------------------------------
  TSituation                 = class;
  TOperation                 = class;
//-----------------------------------------------------------------------------
// CLASSES
//-----------------------------------------------------------------------------
  TNombre = class
  private
    Situation : TSituation;
    FEstUtilise : Boolean; // True si Self est l'opérande d'un résultat parmi Situation.Nombre
    function CalculeSiResultat : Boolean;
  public
    Valeur    : TValeur;
    Operation : TOperation; // Opération dans laquelle il est le résultat
    property EstUtilise : Boolean read FEstUtilise; // Lecture seule
    property EstResultat : Boolean read CalculeSiResultat; // Lecture seule
    constructor Cree(Situation : TSituation; const Valeur : TValeur); overload; // Constructeur
    constructor Cree(Situation : TSituation; const Nombre : TNombre); overload; // Constructeur de copie/déréférencement suivant Nombre.EstUtilise
    constructor Cree(Operation : TOperation); overload; // Crée le résultat d'Operation comme nombre
    destructor Detruit;
    function Copie(Situation: TSituation) : TNombre; // Copie/Déréférence selon qu'il est utilisé ou non (OPTIMISATION n°11)
    procedure Utilise; // Passe EstUtilise à True
    function stApercuProfondeur : String;
    function stApercuEnonce : String;
  end{class TNombre};
//-----------------------------------------------------------------------------
  TOperation = class
  private
    Situation     : TSituation;
    FResultat     : TValeur;
    function DonneResultat : TValeur;
  public
    Operateur     : TOperateur;
    NbOperandes   : TNbNombresUtilisables; // Rq : Théoriquement c'est de type TNbOperandes mais pas en pure création où on part de zéro !
    IndexOperande : array [TIndexNombreUtilisable] of TIndexNombreGenere; // Index de l'opérande dans Situation (de TIndexNombreUtilisable dans TIndexNombreGenere)
    Contraire     : array [TIndexNombreUtilisable] of Boolean;
    property Resultat    : TValeur read DonneResultat;
    constructor Cree(Situation : TSituation; const Operateur : TOperateur); overload; // Constructeur
    constructor Cree(Situation : TSituation; const Operation : TOperation); overload; // Clôneur
    destructor Detruit;
    procedure CalculeResultat; // Calcule le résultat et le stocke dans FResultat.
    function OperandeAClasserAvant( const OperationSrc : TOperation; const IndexOperandeSrc : TIndexNombreGenere; const ContraireSrc : Boolean; const IndexOperationDst : TIndexNombreUtilisable; var ContenusIdentiques : Boolean) : Boolean;
    procedure AjouteOperande(const IndexOperande : TIndexNombreGenere; const Contraire, AvecTri : Boolean);
    procedure CopieNombresDans(Situation : TSituation); // Copie (clône) les nombres de Self dans Situation
    procedure MarqueOperandesUtilises; // Marque les propriétés EstUtilise des opérandes de Self
    function NbOperations : Integer; // Retourne le nombre de niveaux d'opérations sous-jacentes (0=opération avec uniquement des nombres donnés)
    function ResultatMax : TValeur; // Retourne le résultat le plus élevé trouvé dans les opérandes à tous les niveaux (nombres calculés uniquement)
    function stApercuProfondeur : String;
    function stApercuEnonce : String;
  end{class TOperation};
//-----------------------------------------------------------------------------
  TSituation = class
  private
    function CalculeNbMaxOperandes : TNbNombresUtilisables;
  public
    Nombre     : array {[max=TIndexNombreGenere]} of TNombre;
    property NbMaxOperandes : TNbNombresUtilisables read CalculeNbMaxOperandes;
    constructor Cree; overload;// Constructeur
    constructor Cree(const Operation : TOperation); overload;// Générateur : fabrique une nouvelle situation à partir de l'opération
    destructor Detruit;
    procedure AjouteNombre(const Valeur : TValeur); overload;
    procedure AjouteNombre(const Nombre : TNombre); overload;
    procedure AjouteResultat(Operation : TOperation); // Ici on transmet OperantionSrc, on ne le clône pas, il l'a déjà été dans TSituation.Cree(OperationSrc)
    procedure EcritApercuProfondeur;
    function EcritApercuEnonceSiInexistant(const Resultat : TValeur) : Boolean;
    function NbResultatsInutilises : TNbNombresUtilisables;
    function NbPlaquesUtilisees : TNbNombresUtilisables;
    function AjouteSolutionDansArbre(const TreeView : TTreeView; const stApercu : String) : TTreeNode;
    function EstOperationPossible( var Resultat : TValeur;
                                   const Operateur : TOperateur;
                                   const NumeroOperande : TIndexNombreGenere;
                                   const ContraireOperande : Boolean) : Boolean;
    procedure Cherche;
  end{class TSituation};
//-----------------------------------------------------------------------------
  TStatSolution = class
  public
    NbPlaques,
    NbLignesCalcul,
    ResultatIntermediaireMax,
    RangComplexite,
    RangChrono : Integer;
    Temps      : TDateTime;
    constructor Cree(const NbPlaques, NbLignesCalcul, ResultatIntermediaireMax : Integer; const Temps : TDateTime);
    destructor Detruit;
    function stApercu : String;
  end{class TInfoSolution};
//-----------------------------------------------------------------------------
var // Instances uniques : évite la duplication d'une information unique
//-----------------------------------------------------------------------------

  SortieProfondeur,
  SortieEnonce            : Text;
  stRepLocalAppData, // v1.3 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  stNomFichierProfondeur,
  stNomFichierEnonce,
  stConclusion, // Indique si compte est bon ou approché
  stNbSolutionsTempsEcoule : String; // Donne les infos de nombre de solutions et temps de calcul
  // OPTIMISATIONS PARAMETRABLES
  OptimisationsCalcul     : TOptimisationsCalcul;
  Sortie                  : TSortie;
  SortieEcran             : TSortieEcran;
  SortieFichier           : TSortieFichier;
  OrdreChrono,
  NbCalculsEnvisages      : Integer; // v1.2
  Compte,
  DistanceRecherche       : TValeur;
  TempsRecherche          : TDateTime;
  NiveauRecherche         : TNiveauDifficulte;
  ParametreVide           : Boolean; // Utilisé pour PositionOperateur(...)
//-----------------------------------------------------------------------------
const
  stToolButton         : string = 'ToolButton'; // Préfixe d'objet utilisés par les fiches  // v1.3 : ToolButton au lieu de SpeedButton
  stLabel               : string = 'Label';       // Préfixe d'objet utilisés par les fiches
  stOperateurEgal       : string = '=';
  stSuffixeOperation    : string = ' opération';
  stSuffixePlaque       : string = ' plaque';
  stLeCompteEstBon      : string = 'Le compte est bon. ';
  stLeCompteEstApproche : string = 'Le compte est approché (±%d) : %d ou %d. ';
  stAvertissementOptCalc: array [TOptimisationCalcul] of String = ( 'Multiplication/Division par 1. Opération ignorée.',
                                                                    'Opérande résultat d''une opération de même type trouvé : opérations regroupées.',
                                                                    'Opérande égal au résultat trouvé : opération ignorée.',
                                                                    'Deux opérandes inverses ou opposés trouvés. Opérandes ignorés.',
                                                                    'Résultat intermédiaire non utilisé. Opération ignorée.',
                                                                    'Résultat intermédiaire égal au compte. Suite ignorée.');
  EnModeEnonce          : Boolean                               = False;
  EnModeProfondeur      : Boolean                               = True;
  AjoutAvecTri          : Boolean = True;
  AjoutSansTri          : Boolean = False;
                             // [NbOperandes,NbMaxOperandes]
  NbChoixOperandes      : array [TNbOperandes,        //Sur un total de  2  3  4  5  6 nombres... On en prend :
                                 TNbOperandes] of TNbChoixOperandes = (( 1, 3, 6,10,15),       // 2
                                                                       ( 0, 1, 4,10,20),       // 3
                                                                       ( 0, 0, 1, 5,15),       // 4
                                                                       ( 0, 0, 0, 1, 6),       // 5
                                                                       ( 0, 0, 0, 0, 1));      // 6

  NbChoixContrarietes   : array [TNbNombresUtilisables] of TNbChoixContrarietes = (1,2,4,8,16,32,64);

  NumeroOperandeChoix   : array [TNbOperandes, // Nombre d'opérandes à choisir
                                 TNbOperandes, // Nombre d'opérandes sélectionnables
                                 TNumeroChoixOperandes, // N° de choix d'opérandes  1°Choix       2°Choix       3°Choix       4°Choix       5°Choix       6°Choix       7°Choix       8°Choix       9°Choix      10°Choix      11°Choix      12°Choix      13°Choix      14°Choix      15°Choix      16°Choix      17°Choix      18°Choix      19°Choix      20°Choix
                                 TIndexNombreUtilisable]{N°opérande} of TIndexNombreUtilisable =
                                                                              ((((0,1,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 2 (1 possibilité)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(1,2,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 3 (3 possibilités)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(2,3,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 4 (6 possibilités)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(0,4,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(1,4,0,0,0,0),(2,3,0,0,0,0),(2,4,0,0,0,0),(3,4,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 5 (10 possibilités)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(0,4,0,0,0,0),(0,5,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(1,4,0,0,0,0),(1,5,0,0,0,0),(2,3,0,0,0,0),(2,4,0,0,0,0),(2,5,0,0,0,0),(3,4,0,0,0,0),(3,5,0,0,0,0),(4,5,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 2 parmi 6 (15 possibilités)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 3 (1 possibilité)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,2,3,0,0,0),(1,2,3,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 4 (4 possibilités)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,1,4,0,0,0),(0,2,3,0,0,0),(0,2,4,0,0,0),(0,3,4,0,0,0),(1,2,3,0,0,0),(1,2,4,0,0,0),(1,3,4,0,0,0),(2,3,4,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 5 (10 possibilités)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,1,4,0,0,0),(0,1,5,0,0,0),(0,2,3,0,0,0),(0,2,4,0,0,0),(0,2,5,0,0,0),(0,3,4,0,0,0),(0,3,5,0,0,0),(0,4,5,0,0,0),(1,2,3,0,0,0),(1,2,4,0,0,0),(1,2,5,0,0,0),(1,3,4,0,0,0),(1,3,5,0,0,0),(1,4,5,0,0,0),(2,3,4,0,0,0),(2,3,5,0,0,0),(2,4,5,0,0,0),(3,4,5,0,0,0))), // 3 parmi 6 (20 possibilités)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 4 parmi 4 (1 possibilité)
                                                                                ((0,1,2,3,0,0),(0,1,2,4,0,0),(0,1,3,4,0,0),(0,2,3,4,0,0),(1,2,3,4,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 4 parmi 5 (5 possibilités)
                                                                                ((0,1,2,3,0,0),(0,1,2,4,0,0),(0,1,2,5,0,0),(0,1,3,4,0,0),(0,1,3,5,0,0),(0,1,4,5,0,0),(0,2,3,4,0,0),(0,2,3,5,0,0),(0,2,4,5,0,0),(0,3,4,5,0,0),(1,2,3,4,0,0),(1,2,3,5,0,0),(1,2,4,5,0,0),(1,3,4,5,0,0),(2,3,4,5,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 4 parmi 6 (15 possibilités)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,4,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 5 parmi 5 (1 possibilité)
                                                                                ((0,1,2,3,4,0),(0,1,2,3,5,0),(0,1,2,4,5,0),(0,1,3,4,5,0),(0,2,3,4,5,0),(1,2,3,4,5,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 5 parmi 6 (6 possibilités)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,4,5),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))));// 6 parmi 6 (1 possibilité)
//-----------------------------------------------------------------------------
// Déclarations de méthodes d'unités (exportables)
//-----------------------------------------------------------------------------
function stReduitEtOrdonneCalculSaisi(const stCalcul : String; var stAvertissements : String) : String;
procedure InitialiseSortie;
procedure FinaliseSortie(const Tps : TDateTime);
procedure InitialiseRepLocalAppData; // v1.3 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
uses
//-----------------------------------------------------------------------------

  System.Types, SysUtils, Forms, ShellApi, Math, StdCtrls, main_f, tableau_f;
//-----------------------------------------------------------------------------
type
//-----------------------------------------------------------------------------
  TSignesOperation        = array [TOperateur] of Char;
  TOperandesLigneCalcul   = array [TIndexNombreUtilisable] of TValeur;
  TMarquagesLigneCalcul   = array [TIndexNombreUtilisable] of Boolean;
  TOperateursLignesCalcul = array [TIndexLigneCalcul] of TOperateur;
  TResultatsLignesCalcul  = array [TIndexLigneCalcul] of TValeur;
  TMarquagesLignesCalcul  = array [TIndexLigneCalcul] of Boolean;
  TLignesCalcul           = array [TIndexLigneCalcul] of String;
  TRangsLignesCalcul      = array [TIndexLigneCalcul] of TNbLignesCalcul;
  TNbOperandesLignesCalcul= array [TIndexLigneCalcul] of TNbOperandes;
  TPositionsOperateurs    = array [0..1] of Integer;
//-----------------------------------------------------------------------------
const
//-----------------------------------------------------------------------------
  stOperateur             : TSignesOperation = ('+', '*');
  stOperateurContraire    : TSignesOperation = ('-', '/');
//-----------------------------------------------------------------------------
// METHODES D'UNITE
//-----------------------------------------------------------------------------
procedure AjouteOptimisation( const Optimisation : TOptimisationCalcul;
                              var Optimisations : TOptimisationsCalcul;
                              const stPrefixeAvertissement : String;
                              var stAvertissements : String);
begin
if not (Optimisation in Optimisations) then
  begin
  Optimisations:=Optimisations+[Optimisation];
  stAvertissements:=stAvertissements+#13#10+stPrefixeAvertissement+stAvertissementOptCalc[Optimisation];
  end;
end;
//-----------------------------------------------------------------------------
// Renvoie les optimisations effectuées le cas échéant.
// Si modification il y a : IdxDrnOperande, Operande[], Contraire[] et
//                          stAvertissements sont modifiés
//-----------------------------------------------------------------------------
function TesteOptimisationOperandes( const Operateur : TOperateur; // Opérateur de l'opération
                                     const Resultat : TValeur;
                                     const stPrefixeAvertissement : String;
                                     var   Operande  : TOperandesLigneCalcul; // Opérandes[0..IdxDrnOperande]
                                     var   Contraire : TMarquagesLigneCalcul;
                                     var   IdxDrnOperande : TIndexNombreUtilisable;
                                     var   stAvertissements : String) : TOptimisationsCalcul;
var i, j                  : Integer; // v1.2.1
    ASupprimer            : TMarquagesLigneCalcul;
begin
Result:=[]; // Pessimiste
// 1. D'abord les optimisations d'opérations inutiles
//  - ocPasDeResultatEgalOperande
if (ocPasDeResultatEgalOperande in OptimisationsCalcul) then // Exception : Cas Compte par 1 = Compte
  for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
    if (Operande[i]=Resultat) then
      begin
      AjouteOptimisation(ocPasDeResultatEgalOperande, Result, stPrefixeAvertissement, stAvertissements);
      Exit; // Ça ne sert à rien de continuer... La ligne va être supprimée
      end;

// 2. Cas des opérandes inutiles :
//  - ocPasDOperandesContraires
//  - ocPasDeMultiplicationDivisionPar1
// On initialise les marqueurs
for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
  ASupprimer[i]:=False;
for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
  begin
  if (ocPasDeMultiplicationDivisionPar1 in OptimisationsCalcul) and
     not ASupprimer[i] and // On ne traite pas un opérande déjà à supprimer
     (Operande[i]=1) and (Operateur=oMultiplie) then
    begin
    AjouteOptimisation(ocPasDeMultiplicationDivisionPar1, Result, stPrefixeAvertissement, stAvertissements);
    ASupprimer[i]:=True;
    end;
  if (ocPasDOperandesContraires in OptimisationsCalcul) and
     (IdxDrnOperande>1) then // Si 2 opérandes : autorisé (a-a=0 impossible à saisir mais a/a=1 possible et autorisé !)
    for j:=i+1 to IdxDrnOperande do
      if not ASupprimer[i] and not ASupprimer[j] and // On ne traite pas deux fois le même opérande
         (Operande[i]=Operande[j]) and
         (Contraire[i]=not Contraire[j]) then
        begin
        AjouteOptimisation(ocPasDOperandesContraires, Result, stPrefixeAvertissement, stAvertissements);
        ASupprimer[i]:=True;
        ASupprimer[j]:=True;
        end
  end;
// 3. On supprime les opérandes marquées comme telles
for i:=IdxDrnOperande downto Low(TIndexNombreUtilisable) do
  if ASupprimer[i] then
    begin
    Dec(IdxDrnOperande); // v1.2.3 : la décrémentation était dans la boucle or si les opérandes sont en queue, la boucle n'est pas parcourue !
    for j:=IdxDrnOperande-1 downto i do
      begin
      Operande[j]:=Operande[j+1];
      Contraire[j]:=Contraire[j+1];
      end
    end
end;
//-----------------------------------------------------------------------------
function PositionOperateur( const Operateur : TOperateur; // Indique le type d'opération
                            const stOperation : String; // Chaîne de l'opération
                            var Contraire : Boolean; // Indique si l'opérateur trouvé est contraire
                            var FinOperation : Boolean) : Integer; // Indique si '=' est l'opérateur trouvé
var PosOperateur   : TPositionsOperateurs;
begin
FinOperation:=False; // 1 seul cas de fin donc False par défaut
PosOperateur[0]:=Pos(stOperateur[Operateur], stOperation);
PosOperateur[1]:=Pos(stOperateurContraire[Operateur], stOperation);
if PosOperateur[0]+PosOperateur[1]=0 then
  begin // On atteint le dernier opérande. PosOperateur = Pos(stOperateurEgal);
  Result:=Pos(stOperateurEgal, stOperation);
  FinOperation:=True;
  end
else
  if PosOperateur[0]=0 then
    begin
    Result:=PosOperateur[1];
    Contraire:=True;
    end
  else
    if PosOperateur[1]=0 then
      begin
      Result:=PosOperateur[0];
      Contraire:=False;
      end
    else
      begin
      Result:=Min(PosOperateur[0], PosOperateur[1]);
      Contraire:=(Result=PosOperateur[1]);
      end;
end;
//-----------------------------------------------------------------------------
function stReduitEtOrdonneOperationSaisie( const stOperation : String;
                                           const stPrefixeAvertissement : String;
                                           var stAvertissements : String;
                                           var Operateur : TOperateur;
                                           var Resultat : TValeur;
                                           var NbOperandes : TNbOperandes) : String;
var
  stResteATraiter : String;
  Operande        : TOperandesLigneCalcul;
  Contraire       : TMarquagesLigneCalcul;
  IdxDrnOperande  : TIndexNombreUtilisable;
  PosOperateurs   : TPositionsOperateurs;
  PosOperateur    : Integer;
  DrnOperandeTrv,
  ContraireTemp   : Boolean;
  i, j            : Integer;
  OperandeTemp    : TValeur;
  Optimisations   : TOptimisationsCalcul;
begin
// 1. Initialisation
PosOperateur:=Pos(stOperateurEgal, stOperation); // On cherche où se trouve l'opérateur =
Resultat:=StrToInt(copy(stOperation, PosOperateur+1, Length(stOperation)-PosOperateur));// On extrait le résultat de l'opération
IdxDrnOperande:=0;
DrnOperandeTrv:=False;
// 2. On cherche l'opérateur (entre + et *)
PosOperateurs[Ord(oPlus)]:=Pos(stOperateur[oPlus], stOperation)+Pos(stOperateurContraire[oPlus], stOperation);
PosOperateurs[Ord(oMultiplie)]:=Pos(stOperateur[oMultiplie], stOperation)+Pos(stOperateurContraire[oMultiplie], stOperation);
if PosOperateurs[Ord(oPlus)]>0 then
  Operateur:=oPlus
else
  Operateur:=oMultiplie;

Result:=stOperation;

// 3. On localise le premier opérateur pour déterminer le premier opérande
PosOperateur:=PositionOperateur(Operateur, stOperation, Contraire[1], ParametreVide);

// 4. On détermine l'opérande et sa "contrariété" positive pour le premier
Operande[0]:=StrToInt(copy(stOperation, 1, PosOperateur-1));
stResteATraiter:=copy(stOperation, PosOperateur+1, Length(stOperation)-PosOperateur);
Contraire[0]:=False;

// 5. On détermine les autres opérandes (à présent on part de l'opérateur (le premier) jusqu'au dernier opérande)
Repeat
  Inc(IdxDrnOperande);
  PosOperateur:=PositionOperateur(Operateur, stResteATraiter, Contraire[IdxDrnOperande+1], DrnOperandeTrv);
  Operande[IdxDrnOperande]:=StrToInt(copy(stResteATraiter,1,PosOperateur-1));
  stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
Until DrnOperandeTrv;
// 5c. On teste les optimisations de calculs et on modifie le cas échéant Operande, Contraire et IdxDrnOperande
Optimisations:=TesteOptimisationOperandes( Operateur,
                                           Resultat,
                                           stPrefixeAvertissement,
                                           Operande,
                                           Contraire,
                                           IdxDrnOperande,
                                           stAvertissements);
if (ocPasDeResultatEgalOperande in Optimisations) or // Si opération inutile OU
   (IdxDrnOperande=0) then // Il ne reste plus qu'un opérande ALORS
  begin // On renvoie vide et on sort !
  Result:='';
  Exit;
  end;

// 6. On trie les opérandes par ordre de contrariété (Non-contraires puis contraires) et valeur (ordre décroissant)
for i:=0 to IdxDrnOperande-1 do
  for j:=i+1 to IdxDrnOperande do
    if (Contraire[i]>Contraire[j]) or
       ((Contraire[i]=Contraire[j]) and
        (((Operande[i]<Operande[j]) and not Contraire[i]) or
          (Operande[i]>Operande[j]) and Contraire[i])) then
      begin // On permute [i] et [j]
      OperandeTemp:=Operande[i]; ContraireTemp:=Contraire[i];
      Operande[i]:=Operande[j];
      Contraire[i]:=Contraire[j];
      Operande[j]:=OperandeTemp;
      Contraire[j]:=ContraireTemp;
      end;
// 7. On reforme l'opération en chaîne pour la transmettre
NbOperandes:=IdxDrnOperande;
Result:=IntToStr(Operande[0]);
for i:=1 to IdxDrnOperande do
  begin
  if Contraire[i] then
    Result:=Result+stOperateurContraire[Operateur]
  else
    Result:=Result+stOperateur[Operateur];
  Result:=Result+IntToStr(Operande[i])
  end;
Result:=Result+stOperateurEgal+IntToStr(Resultat);
end;
//-----------------------------------------------------------------------------
function stSignesChanges(const stCalcul : String; const ChangerSigne : Boolean; const Operateur : TOperateur) : String;
var i : Integer;
begin
Result:=stCalcul;
if ChangerSigne then
  for i:=1 to Length(stCalcul) do
    begin
    if stCalcul[i]=stOperateur[Operateur] then
      Result[i]:=stOperateurContraire[Operateur];
    if stCalcul[i]=stOperateurContraire[Operateur] then
      Result[i]:=stOperateur[Operateur];
    end
end;
//------------------------------------------------------------------------------
// FONCTION stReduitEtOrdonneCalculSaisi (avec sous-procédures et sous-fonctions
//------------------------------------------------------------------------------
function stReduitEtOrdonneCalculSaisi(const stCalcul : String; var stAvertissements : String) : String;
var stResteATraiter         : String;
    i, j                    : Integer; // v1.2.1
    PositionEspace          : Integer;
    stOperateurSuivant,
    stPartieLigneTraitee    : String;
    NbLignesCalcul          : TNbLignesCalcul;
    stLigneCalcul           : TLignesCalcul;
    NbOperandesLigneCalcul  : TNbOperandesLignesCalcul;
    OperateurLigneCalcul    : TOperateursLignesCalcul;
    ResultatLigneCalcul     : TResultatsLignesCalcul;
    LigneCalculUtilisee     : TMarquagesLignesCalcul;
    RangLigneMemeResultat   : TRangsLignesCalcul;
    Operande                : TValeur;
    PosOperateur            : Integer;
    FusionOperande,
    FusionLigne,
    ChangerSigne            : Boolean;
//------------------------------------------------------------------------------
// Procédures internes (Phase 3)
//------------------------------------------------------------------------------
function LignesCalculMemeResultatOrdonnees(const IndexLigneCalcul1, IndexLigneCalcul2 : TIndexLigneCalcul) : Boolean;
var PosOperateur             : TPositionsOperateurs;
    DrnOperandeTrv    : Boolean;
    Operande                 : array [0..1] of TValeur;
    stResteATraiter          : array [0..1] of String;
    Index                    : array [0..1] of TIndexLigneCalcul;
    i                        : Integer;
begin
// On suppose ici que les résultats ont même valeur. On souhaite connaître laquelle des deux lignes de calcul on va prendre.
Index[0]:=IndexLigneCalcul1; Index[1]:=IndexLigneCalcul2;
// 1. On compare d'abord l'ordre des résultats dans la ligne les utilisant (ordre décroissant)
if NbOperandesLigneCalcul[Index[0]]<>NbOperandesLigneCalcul[Index[1]] then
  begin
  Result:=(NbOperandesLigneCalcul[Index[0]]>NbOperandesLigneCalcul[Index[1]]);
  Exit;
  end;
// À partir d'ici les deux lignes de calcul ont le même nombre d'opérandes)
for i:=0 to 1 do
  stResteATraiter[i]:=stLigneCalcul[Index[i]];
repeat
  PosOperateur[0]:=PositionOperateur(OperateurLigneCalcul[Index[0]], stResteATraiter[0], ParametreVide, DrnOperandeTrv);
  PosOperateur[1]:=PositionOperateur(OperateurLigneCalcul[Index[1]], stResteATraiter[1], ParametreVide, DrnOperandeTrv);
  for i:=0 to 1 do
    begin
    Operande[i]:=StrToInt(copy(stResteATraiter[i], 1, PosOperateur[i]-1));
    stResteATraiter[i]:=copy(stResteATraiter[i], PosOperateur[i]+1, Length(stResteATraiter[i])); // v1.2.6 : Il manquait le principe de récurrence ce qui faisait une boucle infinie si les premiers opérandes étaient égaux...
    end;
  if Operande[0]<>Operande[1] then
    begin
    Result:=(Operande[0]>Operande[1]);
    Exit;
    end;
  // À partir d'ici les ièmes opérandes sont égaux, on continue...
until DrnOperandeTrv;
Result:=True; // DrnOperandeTrv est vrai alors les lignes sont identiques : on ne change rien !
end{procedure OrdonneLignesCalcul};
//------------------------------------------------------------------------------
function ConstruitCalculReduitEtOrdonne(const stCalcul : String; const IndexLigne : TIndexLigneCalcul) : String;
var IndexLigneSvt     : TIndexLigneCalcul;
    PosOperateur      : Integer;
    DrnOperandeTrv    : Boolean;
    Operande          : TValeur;
    stResteATraiter,
    stCalculOperandes : String;
    i                 : Integer; // v1.2.1
begin
// 1. cas trivial : Ligne de calcul vide : on renvoie la ligne transmise
if stLigneCalcul[IndexLigne]='' then
  begin
  Result:=stCalcul;
  Exit
  end;
// 2. On initialise les chaînes de traitement
stCalculOperandes:='';
stResteATraiter:=stLigneCalcul[IndexLigne];
// 3. On extrait les opérandes et on va chercher les éventuelles lignes qui
//    définissent les opérandes comme résultats intermédiaires
repeat
  PosOperateur:=PositionOperateur(OperateurLigneCalcul[IndexLigne], stResteATraiter, ParametreVide, DrnOperandeTrv);
  Operande:=StrToInt(copy(stResteATraiter, 1, PosOperateur-1));
  stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
  IndexLigneSvt:=High(TIndexLigneCalcul); // On calcul un minimum...
  for i:=0 to IndexLigne-1 do
    if (ResultatLigneCalcul[i]=Operande) and // On a trouvé une ligne dont le résultat est égal à l'opérande ET
       not LigneCalculUtilisee[i] and // ce résultat n'a pas encore été utilisé ET
       ((IndexLigneSvt=High(TIndexLigneCalcul)) or // SOIT on a pas encore trouvé de ligne concurrente
        (RangLigneMemeResultat[i]<RangLigneMemeResultat[IndexLigneSvt])) then // SOIT on en a une mais pas meilleure ALORS
      IndexLigneSvt:=i; // ON prend cette ligne
  if IndexLigneSvt<High(TIndexLigneCalcul) then
    begin
    LigneCalculUtilisee[IndexLigneSvt]:=True; // On a trouvé une ligne
    stCalculOperandes:=ConstruitCalculReduitEtOrdonne(stCalculOperandes, IndexLigneSvt);
    end;
until DrnOperandeTrv;
// 4. On reconstruit la ligne de calcul en intercalant les lignes de calcul des
//    opérandes entre la chaîne construite et la ligne des résultats en
//    faisant attention aux chaînes vides
if stCalcul<>'' then
  if stCalculOperandes<>'' then
    Result:=stCalcul+' '+stCalculOperandes+' '+stLigneCalcul[IndexLigne]
  else
    Result:=stCalcul+' '+stLigneCalcul[IndexLigne]
else
  if stCalculOperandes<>'' then
    Result:=stCalculOperandes+' '+stLigneCalcul[IndexLigne]
  else
    Result:=stLigneCalcul[IndexLigne];
end{procedure ConstruitCalculReduitEtOrdonne};
//------------------------------------------------------------------------------
// Début FONCTION stReduitEtOrdonneCalculSaisi
//------------------------------------------------------------------------------
begin
Result:='';
NbLignesCalcul:=0;
stAvertissements:='Calcul saisi : '+stCalcul;
stAvertissements:=stAvertissements+#13#10'Optimisation des lignes...';
// Phase 1 : réduit & ordonne chaque ligne indépendemment l'une de l'autre
//------------------------------------------------------------------------------
stResteATraiter:=stCalcul;
while stResteATraiter<>'' do
  begin
  PositionEspace:=Pos(' ', stResteATraiter);
  if PositionEspace=0 then
    PositionEspace:=Length(stResteATraiter)+1;
  stLigneCalcul[NbLignesCalcul]:=stReduitEtOrdonneOperationSaisie( copy(stResteATraiter, 1, PositionEspace-1),
                                                                   ' - Ligne "'+copy(stResteATraiter, 1, PositionEspace-1)+'" : ',
                                                                   stAvertissements,
                                                                   OperateurLigneCalcul[NbLignesCalcul],
                                                                   ResultatLigneCalcul[NbLignesCalcul],
                                                                   NbOperandesLigneCalcul[NbLignesCalcul]); // Initialisation Phase 2
  LigneCalculUtilisee[NbLignesCalcul]:=False; // Initialisation Phase 2
  Inc(NbLignesCalcul);
  stResteATraiter:=copy(stResteATraiter, PositionEspace+1, Length(stResteATraiter)-PositionEspace);
  end{while};
// Phase 2 : réduit & ordonne les lignes en groupant les opérations de même type
//------------------------------------------------------------------------------
stAvertissements:=stAvertissements+#13#10'Regroupement des opérations de même type...';
if NbLignesCalcul<2 then
  begin
  Result:=stLigneCalcul[0];
  stAvertissements:=stAvertissements+#13#10'Calcul optimisé (réduit et ordonné): '+Result;
  Exit; // On ne peut plus optimiser grand-chose : il ne reste qu'une ligne !
  end;
// 2a. On teste chaque ligne pour vérifier les fusions possibles
for i:=1 to NbLignesCalcul-1 do // Pour chaque ligne de calcul (sauf la première qui ne peut contenir de résultat intermédiaire)
  begin
  stResteATraiter:=copy(stLigneCalcul[i], 1, Pos(stOperateurEgal, stLigneCalcul[i])); // On vire le résultat de la ligne (on garde le signe '=')
  stPartieLigneTraitee:='';
  FusionLigne:=False;
  stOperateurSuivant:='';
  while stResteATraiter<>'' do
    begin
    // On localise le prochain opérateur
    PosOperateur:=PositionOperateur(OperateurLigneCalcul[i], stResteATraiter, ParametreVide, ParametreVide);
    Operande:=StrToInt(copy(stResteATraiter,1,PosOperateur-1));
    ChangerSigne:=(stOperateurSuivant=stOperateurContraire[OperateurLigneCalcul[i]]); // On teste si l'opérateur est contraire avant de récupérer le suivant
    stOperateurSuivant:=copy(stResteATraiter,PosOperateur,1);
    stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
    // On regarde si l'opérande n'est pas le résultat d'une ligne précédente
    FusionOperande:=False;
    for j:=0 to i-1 do
      if (stLigneCalcul[j]<>'') and // Ligne encore utile (pas fusionnée et pas vide)
         (Operande=ResultatLigneCalcul[j]) and // Opérande = Résultat
         not LigneCalculUtilisee[j] then // Résultat de la ligne non encore utilisé
        begin
        LigneCalculUtilisee[j]:=True; // L'opérande a été trouvé comme résultat ALORS on le marque sa ligne comme utilisée
        if (OperateurLigneCalcul[i]=OperateurLigneCalcul[j]) then // Mêmes type d'opération
          begin // ALORS on fusionne : on remplace l'opérande par la ligne de calcul
          stAvertissements:= stAvertissements+
                             Format(#13#10' - "%s" et "%s"', [stLigneCalcul[j], stLigneCalcul[i]]);
          stPartieLigneTraitee:= stPartieLigneTraitee+
                                 stSignesChanges( copy( stLigneCalcul[j],
                                                        1,
                                                        Pos(stOperateurEgal, stLigneCalcul[j])-1),
                                                  ChangerSigne,
                                                  OperateurLigneCalcul[i])+
                                 stOperateurSuivant;
          stLigneCalcul[j]:='';
          FusionOperande:=True;
          if not FusionLigne then FusionLigne:=True; // Indique qu'il faudra réduire et ordonner ensuite
          Break; // On a trouvé la ligne de calcul, on arrête la recherche après la fusion
          end
        end;
    if not FusionOperande then // L'opérande courante N'a PAS été remplacée par une ligne de calcul : on l'ajoute directement avec l'opérateur suivant
      stPartieLigneTraitee:=stPartieLigneTraitee+IntToStr(Operande)+stOperateurSuivant;
    end{while};
  // Si une fusion de ligne a été faite on réduit et ordonne la ligne de calcul à nouveau
  if FusionLigne then
    begin
    stLigneCalcul[i]:=stPartieLigneTraitee+IntToStr(ResultatLigneCalcul[i]);
    stLigneCalcul[i]:=stReduitEtOrdonneOperationSaisie( stLigneCalcul[i],
                                                        ' - Optimisation nouvelle ligne "'+stLigneCalcul[i]+'" : ',
                                                        stAvertissements,
                                                        OperateurLigneCalcul[i],
                                                        ResultatLigneCalcul[i],
                                                        NbOperandesLigneCalcul[i]);
    end;
  end{for};
// 2b. On supprime les lignes inutilisées (sauf la dernière) c'est-à-dire les lignes dont le résultat n'est pas utilisé.
stAvertissements:=stAvertissements+#13#10'Suppression des lignes dont le résultat n''est pas utilisé...';
for i:=0 to NbLignesCalcul-2 do
  if not LigneCalculUtilisee[i] and
     (stLigneCalcul[i]<>'') then
    begin
    stAvertissements:=stAvertissements+#13#10' - Ligne "'+stLigneCalcul[i]+'"';
    stLigneCalcul[i]:='';
    end;
// Phase 3: On trie les lignes de même résultat et on reconstitue le calcul 
//------------------------------------------------------------------------------
// 3a. On initialise les marqueurs
stAvertissements:=stAvertissements+#13#10'Tri des lignes et reconstitution du calcul finalisé...';
for i:=0 to NbLignesCalcul-1 do
  begin
  LigneCalculUtilisee[i]:=False; 
  RangLigneMemeResultat[i]:=0;
  end;
// 3b. On classe les lignes de même résultat (sauf la dernière ligne bien sûr)
for i:=0 to NbLignesCalcul-3 do
  for j:=i+1 to NbLignesCalcul-2 do
    if (ResultatLigneCalcul[i]=ResultatLigneCalcul[j]) then
      if LignesCalculMemeResultatOrdonnees(i, j) then
        Inc(RangLigneMemeResultat[j])
      else
        Inc(RangLigneMemeResultat[i]);
// Phase 3 : On ordonne les lignes par récurrence
Result:=ConstruitCalculReduitEtOrdonne('', NbLignesCalcul-1); // Appel Récursif
stAvertissements:=stAvertissements+#13#10'Calcul optimisé (réduit et ordonné): '+Result;
end;
//------------------------------------------------------------------------------
// Fin FONCTION stReduitEtOrdonneCalculSaisi
//------------------------------------------------------------------------------
function stVerifieNumeroOperandeChoix : string; // fonction de vérification à usage unique et donc plus utilisé mais laissé en guise d'exemple
var
    nmo,no : TNbOperandes;
    nco    : TNumeroChoixOperandes;
    ioc    : TIndexNombreUtilisable;
    x, xx  : Integer;
const Puiss6 : array [TIndexNombreUtilisable] of Integer = (46656,7776,1296,216,36,6);
begin
// Vérification de NumeroOperandeChoix
  for nmo:=Low(TNbOperandes) to High(TNbOperandes) do
    for no:=Low(TNbOperandes) to nmo do
      begin
      x:=0;
      for nco:=Low(TNumeroChoixOperandes) to NbChoixOperandes[no,nmo]-1 do
        begin
        xx:=0;
        for ioc:=Low(TIndexNombreUtilisable) to no-1 do
          begin
          if NumeroOperandeChoix[no,nmo,nco,ioc]>=nmo then
            Result:=Result+Format(#13#10'Index hors limite (%d/%d,%d) [%d!<%d].', [no,nmo,nco, NumeroOperandeChoix[no,nmo,nco,ioc],nmo]);
          Inc(xx, Puiss6[ioc] * NumeroOperandeChoix[no,nmo,nco,ioc]);
          end;
        if xx=0 then
          Result:=Result+Format(#13#10'Index d''opérandes indéfinis pour ce choix (%d/%d,%d).', [no,nmo,nco]);
        if xx<=x then
          Result:=Result+Format(#13#10'Distribution irrégulière (%d/%d,%d) [%d!>%d].', [no,nmo,nco, xx,x]);
        x:=xx;
        end;
      end;
end;
//-----------------------------------------------------------------------------
procedure InitialiseSortie;
var
 stNomFichier : String;
begin
with FormMain do
 stNomFichier:=Label1.Caption+'-'+Label2.Caption+'-'+Label3.Caption+'-'+Label4.Caption+'-'+Label5.Caption+'-'+Label6.Caption+','+Label7.Caption;
if (Ord(SortieFichier) and Ord(sfEnProfondeur))>0 then
  begin
  IA.stNomFichierProfondeur:=stRepLocalAppData+stNomFichier+';P.txt'; // v1.3 : stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
  Assign(IA.SortieProfondeur, IA.stNomFichierProfondeur);
  Rewrite(IA.SortieProfondeur);
  end;
if (Ord(SortieFichier) and Ord(sfTypeEnonce))>0 then
  begin
  IA.stNomFichierEnonce:=stRepLocalAppData+stNomFichier+';E.txt'; // v1.3 : stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
  Assign(IA.SortieEnonce, IA.stNomFichierEnonce);
  Rewrite(IA.SortieEnonce);
  end;
end;
//-----------------------------------------------------------------------------
procedure FinaliseSortie(const Tps : TDateTime);
var i, j, Compteur,
    Quantite, // v1.2
    PosParentheseGauche,
    PosParentheseDroite : Integer;
    stIntitule          : String;
    TreeNode            : TTreeNode;
begin
// On fixe le temp de recherche
IA.TempsRecherche:=Tps;
if IA.DistanceRecherche=0 then
  begin
  // On fixe le niveau du compte cherché
  with FormMain.TreeView do
    if (Items.Count>0) and
       (Items[0].getFirstChild<>nil) and
       (Items[0].getFirstChild.getFirstChild<>nil) then
      IA.NiveauRecherche:=Items[0].getFirstChild.ImageIndex+Items[0].getFirstChild.getFirstChild.ImageIndex-5;
  // On résume les infos du résultat
  IA.stConclusion:=IA.stLeCompteEstBon
  end
else
  begin
  // On fixe le niveau du compte cherché
  IA.NiveauRecherche:=ndIntrouvable;
  // On résume les infos du résultat
  IA.stConclusion:=Format(stLeCompteEstApproche, [IA.DistanceRecherche, IA.Compte-IA.DistanceRecherche, IA.Compte+IA.DistanceRecherche]);
  end;
FormTableau.ToolButtonDifficulte.ImageIndex:=IA.NiveauRecherche;  // v1.1
IA.stNbSolutionsTempsEcoule:= Format( '%d solution%s en ', [ FormMain.ListBox.Items.Count,
                                                             stPluriel[FormMain.ListBox.Items.Count>1]])+ // Gestion du pluriel pour enlever les parenthèses. v1.2
                              FormatDateTime('s''"''z', Tps)+ // v1.2
                              Format('. %d envisagées.', [IA.NbCalculsEnvisages]); // v1.2
FormMain.StatusBar.SimpleText:=IA.stConclusion+IA.stNbSolutionsTempsEcoule;
if (Ord(SortieFichier) and Ord(sfEnProfondeur))>0 then
  begin
  WriteLn(IA.SortieProfondeur, stNbSolutionsTempsEcoule);
  CloseFile(IA.SortieProfondeur);
  ShellExecute(0, 'Open', pChar(ExtractFileName(IA.stNomFichierProfondeur)), '', pChar(ExtractFilePath(IA.stNomFichierProfondeur)), 0);
  end;
if (Ord(SortieFichier) and Ord(sfTypeEnonce))>0 then
  begin
  WriteLn(IA.SortieEnonce, stNbSolutionsTempsEcoule);
  CloseFile(IA.SortieEnonce);
  ShellExecute(0, 'Open', pChar(ExtractFileName(IA.stNomFichierEnonce)), '', pChar(ExtractFilePath(IA.stNomFichierEnonce)), 0);
  end;
if (Ord(SortieEcran) and Ord(seTypeArbre))>0 then
  begin
  with FormMain.TreeView.Items.Item[0] do
    begin
    Text:=stNbSolutionsTempsEcoule;
    ImageIndex:=IndexImageDrapeau+Ord(IA.DistanceRecherche=0);
    SelectedIndex:=IndexImageDrapeau+Ord(IA.DistanceRecherche=0);
    end;
  // - On calcule les sous totaux dans l'arbre et
  // - On retire les compteurs indiqués par les images
  with FormMain.ListBox do
    for i:=0 to FormMain.ListBox.Items.Count-1 do
      begin
      TreeNode:=Items.Objects[i] as TTreeNode;
      for j:=1 to 3 do
        begin
        TreeNode:=TreeNode.Parent;
        if Pos(stSuffixeOperation, TreeNode.Text)+Pos(stSuffixePlaque, TreeNode.Text)>0 then
          TreeNode.Text:=Copy(TreeNode.Text, 3, Length(TreeNode.Text)-2);
        stIntitule:=TreeNode.Text;
        PosParentheseGauche:=Pos('(', stIntitule);
        PosParentheseDroite:=Pos(')', stIntitule);
        Compteur:=StrToInt(Copy(stIntitule, PosParentheseGauche+1, PosParentheseDroite-PosParentheseGauche-1));
        Inc(Compteur);
        TreeNode.Text:= Copy( stIntitule,
                              1,
                              PosParentheseGauche-1)+
                        Format('(%d)', [Compteur]); // On ajoute ensuite le pourcentage. v1.2
        end
      end{for};
  // On calcule le pourcentage que l'on affiche à la fin du libellé de chaque feuille de l'arbre. v1.2
  with FormMain.TreeView do // v1.2
    for i:=1 to Items.Count-1 do
      with Items[i] do
        if Parent<>nil then
          begin
          if HasChildren then Text:=TrimLeft(Text); // Retirer les espaces des noeuds de résultats intermédiaires max.
          if Pos('solution', Parent.Text)>0 then // Nombre de solutions
            Compteur:=FormMain.ListBox.Items.Count
          else
            begin
            stIntitule:=Items[i].Parent.Text;
            PosParentheseGauche:=Pos('(', stIntitule);
            if PosParentheseGauche>0 then
              if Pos('/', stIntitule)>0 then // On a déjà calculé le pourcentage pour le parent
                Compteur:=StrToInt(Copy(stIntitule, PosParentheseGauche+1, Pos('/', stIntitule)-PosParentheseGauche-1))
              else
                Compteur:=StrToInt(Copy(stIntitule, PosParentheseGauche+1, Length(stIntitule)-PosParentheseGauche-1))
            else
              Continue;
            end;
          stIntitule:=Text;
          PosParentheseGauche:=Pos('(', stIntitule);
          if PosParentheseGauche>0 then
            begin
            Quantite:=StrToInt(Copy(stIntitule, PosParentheseGauche+1, Length(stIntitule)-PosParentheseGauche-1));
            if Compteur>Quantite then // Evite d'afficher 100%. v1.2.1  
              Text:=copy(Text,1,Length(Text)-1)+Format('/%d - %.1f%%)', [Compteur, (100.0*Quantite)/Compteur]);
            end
          end
  end
end;
//-----------------------------------------------------------------------------
procedure InitialiseRepLocalAppData; // v1.3 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
const stVarLocalAppData  = 'LOCALAPPDATA';
      stVarUserProfile   = 'USERPROFILE'; // v1.3.2
      stRepLocAppDataLcpdb = '\Patquoi.fr\lcpdb';
var stExePath : String; // v1.3.2
begin // v1.3.2 procédure réécrite
stExePath := ExtractFilePath(ParamStr(0));
stRepLocalAppData := GetEnvironmentVariable(stVarLocalAppData);
if stRepLocalAppData = '' then
  begin
  stRepLocalAppData := GetEnvironmentVariable(stVarUserProfile);
  if stRepLocalAppData = '' then
    stRepLocalAppData := stExePath // Dossier de Paradice.exe
  else
    begin
	  stRepLocalAppData := stRepLocalAppData + '\Local Settings\Application Data' + stRepLocAppDataLcpdb;
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
  stRepLocalAppData := stRepLocalAppData + stRepLocAppDataLcpdb;
  if not DirectoryExists(stRepLocalAppData) then
    if not ForceDirectories(stRepLocalAppData) then
      stRepLocalAppData:=stExePath // Dossier de Paradice.exe
    else
      stRepLocalAppData:=stRepLocalAppData+'\'
  else
    stRepLocalAppData:=stRepLocalAppData+'\';
  end
end;

//-----------------------------------------------------------------------------
// METHODES DE CLASSES
//-----------------------------------------------------------------------------
// Méthodes de la classe TNombre
//-----------------------------------------------------------------------------
function TNombre.CalculeSiResultat : Boolean;
begin
Result:=(Operation<>Nil);
end;
//-----------------------------------------------------------------------------
constructor TNombre.Cree(Situation : TSituation; const Valeur : TValeur);
begin
Self.Situation   := Situation;
Self.Valeur      := Valeur;
Self.Operation   := Nil;
Self.FEstUtilise := False;
end;
//-----------------------------------------------------------------------------
constructor TNombre.Cree(Situation : TSituation; const Nombre : TNombre); // Constructeur de copie
begin
Self.Situation   := Situation;
Self.Valeur      := Nombre.Valeur;
Self.FEstUtilise := Nombre.EstUtilise;
if Nombre.EstResultat then
  Self.Operation := Nombre.Operation {TOperation.Cree(Self.Situation, Nombre.Operation)} // Déréférence au lieu de copier (OPTIMISATION n°12)
else
  Self.Operation := Nil;
end;
//-----------------------------------------------------------------------------
constructor TNombre.Cree(Operation : TOperation);
begin
Self.Situation   := Operation.Situation;
Self.Valeur      := Operation.Resultat;
Self.Operation   := Operation;
Self.FEstUtilise := False;
end;
//-----------------------------------------------------------------------------
destructor TNombre.Detruit;
begin
end;
//-----------------------------------------------------------------------------
function TNombre.Copie(Situation: TSituation) : TNombre; // Effectue une copie par allocation ou déréférencement suivant qu'il soit Utilisé ou non (OPTIMISATION n°11)
begin
if EstUtilise then
  Result:=Self
else
  Result:=TNombre.Cree(Situation, Self);
end;
//-----------------------------------------------------------------------------
procedure TNombre.Utilise;
begin
Self.FEstUtilise:=True;
end;
//-----------------------------------------------------------------------------
function TNombre.stApercuProfondeur : String;
begin
Result:=Operation.stApercuProfondeur
end;
//-----------------------------------------------------------------------------
function TNombre.stApercuEnonce : String;
begin
Result:=IntToStr(Valeur)
end;
//-----------------------------------------------------------------------------
// Méthodes de la classe TOperation
//-----------------------------------------------------------------------------
constructor TOperation.Cree(Situation : TSituation; const Operateur : TOperateur); // Constructeur
begin
Self.Situation := Situation;
Self.Operateur := Operateur;
FResultat:=0; // Résultat pas encore défini (0 par convention car résultat impossible)
NbOperandes:=0;
end;
//-----------------------------------------------------------------------------
constructor TOperation.Cree(Situation : TSituation; const Operation : TOperation); // Clôneur
var i : Integer; // v1.2.1
begin
Self.Situation := Situation;
Self.Operateur := Operation.Operateur;
Self.FResultat := Operation.Resultat; // On fait confiance à la propriété de l'opération fournie !
NbOperandes:=0;
for i:=Low(Operation.IndexOperande) to Operation.NbOperandes-1 do
  AjouteOperande(Operation.IndexOperande[i], Operation.Contraire[i], AjoutSansTri);
end;
//-----------------------------------------------------------------------------
destructor TOperation.Detruit;
begin
end;
//-----------------------------------------------------------------------------
// Calcule le résultat et le stocke dans FResultat. Renvoie Vrai si l'opération
// est possible (>0 et division entière)
//-----------------------------------------------------------------------------
procedure TOperation.CalculeResultat;
var i        : Integer; // v1.2.1
    Operande : TNombre;
begin
if Operateur=oPlus then FResultat:=0 else FResultat:=1;
for i:=Low(IndexOperande) to NbOperandes-1 do
  begin
  Operande := Situation.Nombre[IndexOperande[i]];
  case Operateur of
    oPlus:      if Contraire[i] then
                  Dec(FResultat, Operande.Valeur)
                else
                  Inc(FResultat, Operande.Valeur);
    oMultiplie: if Contraire[i] then
                  FResultat:=FResultat div Operande.Valeur
                else
                  FResultat:=FResultat * Operande.Valeur;
    end{case Operateur of};
  end{if};
end;
//-----------------------------------------------------------------------------
function TOperation.DonneResultat : TValeur;
begin
if FResultat=0 then CalculeResultat; // Si FResultat nul alors le résultat n'a jamais été calculé (par sécurité)
Result:=FResultat;
end;
//-----------------------------------------------------------------------------
// On veut comparer les nombres
//  - OperationSrc.Situation.Nombre[IndexOperandeSrc] de contrariété ContraireSrc à
//  - self.Situation.Nombre[self.IndexOperande[IndexOperationDst]] de
//    contrariété self.Contraire[IndexOperationDst]
// Renvoie True si le premier est à ajouter avant le deuxième. False sinon.
// ContenusIdentiques est modifié : True si les contenus sont identiques
// (indépendamment des ordres de création). False sinon.
//-----------------------------------------------------------------------------
function TOperation.OperandeAClasserAvant( const OperationSrc : TOperation;
                                           const IndexOperandeSrc : TIndexNombreGenere;
                                           const ContraireSrc : Boolean;
                                           const IndexOperationDst : TIndexNombreUtilisable;
                                           var ContenusIdentiques : Boolean) : Boolean;
var i                   : Integer; // v1.2.1
    OperandesIdentiques,
    OperandeAnterieur   : Boolean;
    NombreDst,
    NombreSrc           : TNombre;
begin
Result:=False; // Valeur par défaut dans le cas où les nombres sont strictement égaux en contenu (mais le premier arrivé est le mieux placé et n'est pas déplacé).
ContenusIdentiques:=False; // Cas le plus fréquent
// Ordre des Critères de comparaison :
// 1. Contrariété : Non Contraires d'abord ; Contraires ensuite
if ContraireSrc<>Self.Contraire[IndexOperationDst] then
  begin
  Result:=ContraireSrc<Self.Contraire[IndexOperationDst];
  Exit;
  end;
// Note : On peut maintenant utiliser UNIQUEMENT ContraireSrc car Self.Contraire[IndexOperationDst]=ContraireSrc !
NombreDst:=        Self.Situation.Nombre[Self.IndexOperande[IndexOperationDst]];
NombreSrc:=OperationSrc.Situation.Nombre[IndexOperandeSrc];
// 2. Valeur : Ordre décroissant si non contraire ; Ordre croissant si contraire
if NombreSrc.Valeur<>NombreDst.Valeur then
  begin
  Result:=((NombreSrc.Valeur>NombreDst.Valeur) and Not ContraireSrc) or
          ((NombreSrc.Valeur<NombreDst.Valeur) and ContraireSrc);
  Exit;
  end;
// 3. Type : Résultats d'abord ; Non Résultats ensuite
if NombreSrc.EstResultat<>NombreDst.EstResultat then
  begin
  Result:=NombreSrc.EstResultat>NombreDst.EstResultat;
  Exit;
  end;
// 4. Cas des nombres non résultats égaux : le premier arrivé est le mieux placé !
if not NombreSrc.EstResultat then
  begin
  ContenusIdentiques:=True; // On indique néanmoins qu'en contenu, ils sont égaux
  Exit;
  end;
// Note : On considère maintenant que l'on traite UNIQUEMENT des résultats
// 5. Nombre d'opérandes : Ordre décroissant (de surcroît des non résultats sont
//                         à la fin si l'on considère qu'ils n'ont qu'un opérande)
if NombreSrc.Operation.NbOperandes<>NombreDst.Operation.NbOperandes then
  begin
  Result:=NombreSrc.Operation.NbOperandes>NombreDst.Operation.NbOperandes;
  Exit;
  end;
// Note : À présent, le nombre d'opérandes est identique.
// 6. ENFIN, on compare récursivement chaque opérande dans l'ordre de leurs index respectifs.
// Si nombres strictement égaux (comme deux non résultats de même valeur et contrariété),
// On passe aux opérandes suivantes de même index et ainsi de suite
for i:=Low(NombreSrc.Operation.IndexOperande) to NombreSrc.Operation.NbOperandes-1 do
  begin
  OperandeAnterieur:=NombreDst.Operation.OperandeAClasserAvant( NombreSrc.Operation,
                                                                NombreSrc.Operation.IndexOperande[i],
                                                                NombreSrc.Operation.Contraire[i],
                                                                i,
                                                                OperandesIdentiques);
  if not OperandesIdentiques then
    begin
    Result:=OperandeAnterieur;
    Break;
    end;
  end;
end;
//-----------------------------------------------------------------------------
procedure TOperation.AjouteOperande(const IndexOperande : TIndexNombreGenere; const Contraire, AvecTri : Boolean);
// Ajoute IndexOperande dans Self.IndexOperande
var i : Integer; // v1.2.1
    NombresEgaux : Boolean; // Résultat de fonction inutilisé pour cet appel de fonction
begin
Inc(NbOperandes);
if AvecTri then
  begin
  if NbOperandes>1 then // On ne trie que s
    for i:=NbOperandes-2 downto Low(Self.IndexOperande) do
      if OperandeAClasserAvant(self, IndexOperande, Contraire, i, NombresEgaux) then
        begin // On décale les opérandes actuelles et on continue à chercher antérieurement
        Self.IndexOperande[i+1] := Self.IndexOperande[i];
        Self.Contraire[i+1]     := Self.Contraire[i];
        end
      else // On a trouvé l'endroit du nouvel opérande
        begin
        Self.IndexOperande[i+1] := IndexOperande;
        Self.Contraire[i+1]     := Contraire;
        Exit;
        end;
  // On a pas encore affecté : il s'agit alors de la première place !
  Self.IndexOperande[Low(Self.IndexOperande)] := IndexOperande;
  Self.Contraire[Low(Self.IndexOperande)]     := Contraire;
  end
else // Sans tri : on ajoute à la fin
  begin
  Self.IndexOperande[NbOperandes-1] := IndexOperande;
  Self.Contraire[NbOperandes-1]     := Contraire;
  end;
end;
//-----------------------------------------------------------------------------
procedure TOperation.CopieNombresDans(Situation : TSituation);
var i : TIndexNombreGenere; 
begin
for i:=Low(Self.Situation.Nombre) to High(Self.Situation.Nombre) do
  Situation.AjouteNombre(Self.Situation.Nombre[i]);
end;
//-----------------------------------------------------------------------------
procedure TOperation.MarqueOperandesUtilises;
// Marque les propriétés EstUtilise des opérandes de Self
var i : TIndexNombreUtilisable;
begin
for i:=Low(IndexOperande) to NbOperandes-1 do
  Situation.Nombre[IndexOperande[i]].Utilise;
end;
//-----------------------------------------------------------------------------
function TOperation.NbOperations : Integer;
var i : Integer;
begin
Result:=0;
for i:=Low(IndexOperande) to High(IndexOperande) do
  if Situation.Nombre[IndexOperande[i]].EstResultat then
    Inc(Result, 1+Situation.Nombre[IndexOperande[i]].Operation.NbOperations);
end;
//-----------------------------------------------------------------------------
function TOperation.ResultatMax : TValeur;
var i : Integer;
begin
Result:=0;
for i:=Low(IndexOperande) to High(IndexOperande) do
  if Situation.Nombre[IndexOperande[i]].EstResultat and
     (Result<Situation.Nombre[IndexOperande[i]].Valeur) then
    Result:=Max( Situation.Nombre[IndexOperande[i]].Valeur,
                 Situation.Nombre[IndexOperande[i]].Operation.ResultatMax);
end;
//-----------------------------------------------------------------------------
function TOperation.stApercuProfondeur : String;
var i : TIndexNombreUtilisable;
    stValeur : String;
begin
Result:='('+stOperateur[Operateur];
for i:=Low(IndexOperande) to NbOperandes-1 do
  begin
  if Situation.Nombre[IndexOperande[i]].EstResultat then
    stValeur:=Situation.Nombre[IndexOperande[i]].Operation.stApercuProfondeur
  else
    stValeur:=IntToStr(Situation.Nombre[IndexOperande[i]].Valeur);
  if Contraire[i] then
    case Operateur of
      oPlus:      Result:=Result+' -'+stValeur;
      oMultiplie: Result:=Result+' 1/'+stValeur;
    end
  else
    Result:=Result+' '+stValeur;
  end;
Result:=Result+')';
end;
//-----------------------------------------------------------------------------
function TOperation.stApercuEnonce : String;
var i : TIndexNombreUtilisable;
begin
Result:='';
// D'abord on écrit les opérations antérieures
for i:=Low(IndexOperande) to NbOperandes-1 do
  if Situation.Nombre[IndexOperande[i]].EstResultat then
    Result:=Result+Situation.Nombre[IndexOperande[i]].Operation.stApercuEnonce;
// Ensuite, on peut écrire l'opération courante.
Result:=Result+' ';
for i:=Low(IndexOperande) to NbOperandes-1 do
  begin
  if i>Low(IndexOperande) then
    if Contraire[i] then
      Result:=Result+stOperateurContraire[Operateur]
    else
      Result:=Result+stOperateur[Operateur];
  Result:=Result+Situation.Nombre[IndexOperande[i]].stApercuEnonce;
  end;
Result:=Result+stOperateurEgal+IntToStr(Resultat);
end;
//-----------------------------------------------------------------------------
// Méthodes de la classe TSituation
//-----------------------------------------------------------------------------
constructor TSituation.Cree;
begin
SetLength(Nombre, 0);
end;
//-----------------------------------------------------------------------------
constructor TSituation.Cree(const Operation : TOperation); // Clôneur : fabrique une nouvelle situation à partir d'une opération (et de sa situation)
var OperationDst : TOperation; // Clône d'Operation
begin
// 1. On clône d'abord Operation pour qu'elle soit à Self.
OperationDst := TOperation.Cree(Self, Operation);
// 2. On copie les nombres de Operation.Situation dans Situation (self)
Operation.CopieNombresDans(Self);
// 3. On marque les opérandes d'OperationDst comme utilisé
OperationDst.MarqueOperandesUtilises;
// 4. On ajoute le résultat comme nombre à Self
AjouteResultat(OperationDst);
end;
//-----------------------------------------------------------------------------
destructor TSituation.Detruit;
var i : TIndexNombreGenere;
begin
for i:=Low(Nombre) to High(Nombre) do
  if Nombre[i].Situation=Self then
    Nombre[i].Destroy;
SetLength(Nombre, 0);
end;
//-----------------------------------------------------------------------------
function TSituation.CalculeNbMaxOperandes : TNbNombresUtilisables;
var i : TIndexNombreGenere;
begin
Result:=0;
for i:=Low(Nombre) to High(Nombre) do
  if not Nombre[i].EstUtilise then Inc(Result);
end;
//-----------------------------------------------------------------------------
procedure TSituation.AjouteNombre(const Valeur : TValeur);
var i : TIndexNombreGenere;
begin
i:=Length(Nombre);
SetLength(Nombre, i+1);
Nombre[i]:=TNombre.Cree(Self, Valeur);
end;
//-----------------------------------------------------------------------------
procedure TSituation.AjouteNombre(const Nombre : TNombre); // Copie d'un nombre
var i : TIndexNombreGenere;
begin
i:=Length(Self.Nombre);
SetLength(Self.Nombre, i+1);
self.Nombre[i]:=Nombre.Copie(Self); {TNombre.Cree(Self, Nombre);} // OPTIMISATION n°11
end;
//-----------------------------------------------------------------------------
procedure TSituation.AjouteResultat(Operation : TOperation); // Ici on transmet Operation, on ne le clône pas, il l'a déjà été dans TSituation.Cree(Operation)
var i : TIndexNombreGenere;
begin
i:=Length(Nombre);
SetLength(Nombre, i+1);
Nombre[i]:=TNombre.Cree(Operation);
end;
//-----------------------------------------------------------------------------
procedure TSituation.EcritApercuProfondeur;
var i : TIndexNombreGenere;
    stApercu : String;
begin
stApercu:='';
for i:=Low(Nombre) to High(Nombre) do
  if Nombre[i].EstResultat and not Nombre[i].EstUtilise then
    begin
    stApercu:=Nombre[i].stApercuProfondeur;
    Break;
    end;
WriteLn(IA.SortieProfondeur, stApercu);
end;
//-----------------------------------------------------------------------------
function TSituation.EcritApercuEnonceSiInexistant(const Resultat : TValeur) : Boolean;
// Comme Précédent mais écrit uniquement si l'aperçu n'a pas déjà été écrit
// et renvoie alors True ; sinon, n'écrit rien et renvoie False.
var i : TIndexNombreGenere;
    stApercu : String;
    MeilleurResultat : Boolean;
begin
MeilleurResultat:=Abs(Resultat-IA.Compte)<IA.DistanceRecherche;
stApercu:='';
for i:=Low(Nombre) to High(Nombre) do
  if Nombre[i].EstResultat and not Nombre[i].EstUtilise then
    begin
    stApercu:=Nombre[i].Operation.stApercuEnonce;
    Break;
    end;
if MeilleurResultat or // Soit on a trouvé mieux...
   (FormMain.ListBox.Items.IndexOf(stApercu)<0) then // Soit on a pas trouvé mieux mais on a pas déjà trouvé cette solution
  begin
  if MeilleurResultat then // Si meilleur Résultat, on stocke la nouvelle distance et on vide les solutions
    begin
    IA.DistanceRecherche:=Abs(Resultat-IA.Compte);
    FormMain.EffaceSolutions;
    if Ord(SortieFichier)>0 then
      begin
      if (Ord(SortieFichier) and Ord(sfEnProfondeur))>0 then
        CloseFile(IA.SortieProfondeur);
      if (Ord(SortieFichier) and Ord(sfTypeEnonce))>0 then
        CloseFile(IA.SortieEnonce);
      end;
    if ((Ord(IA.Sortie) and Ord(sFichier))>0) then
      IA.InitialiseSortie;
    end;
  if (Ord(SortieEcran) and Ord(seTypeArbre))>0 then
   FormMain.ListBox.Items.AddObject(stApercu, AjouteSolutionDansArbre(FormMain.TreeView, stApercu))
  else
   FormMain.ListBox.Items.Add(stApercu);
  if (Ord(SortieFichier) and Ord(sfTypeEnonce))>0 then
    WriteLn(IA.SortieEnonce, stApercu);
  Result:=True;
  end
else
  Result:=False;
end;
//-----------------------------------------------------------------------------
function TSituation.NbResultatsInutilises : TNbNombresUtilisables;
var i :TIndexNombreGenere;
begin
Result:=0;
for i:=Low(Nombre) to High(Nombre) do
  Result:=Result+Ord(Nombre[i].EstResultat and not Nombre[i].EstUtilise);
end;
//-----------------------------------------------------------------------------
function TSituation.NbPlaquesUtilisees : TNbNombresUtilisables;
var i :TIndexNombreGenere;
begin
Result:=0;
for i:=Low(Nombre) to NbMaxPlaques-1 do
  Result:=Result+Ord(Nombre[i].EstUtilise);
end;
//-----------------------------------------------------------------------------
function TSituation.AjouteSolutionDansArbre(const TreeView : TTreeView; const stApercu : String) : TTreeNode;
var NbOperations : Integer;
    ResultatMax : TValeur;
begin
// Critère n°1 : NbPlaquesUtilisees
// Critère n°2 : NbOperations
// Critère n°3 : ResultatMax
NbOperations:=1+Nombre[High(Nombre)].Operation.NbOperations;
ResultatMax:=Nombre[High(Nombre)].Operation.ResultatMax;
Result:=FormMain.TreeView.Items.AddChildObject( FormMain.CreeNoeudSiInexistant( FormMain.CreeNoeudSiInexistant( FormMain.CreeNoeudSiInexistant( TreeView.Items[0],
                                                                                                                                                IntToStr(NbPlaquesUtilisees)+stSuffixePlaque,
                                                                                                                                                NbPlaquesUtilisees>1,
                                                                                                                                                NbPlaquesUtilisees+DiffIndexImageNbPlaques),
                                                                                                                IntToStr(NbOperations)+stSuffixeOperation,
                                                                                                                NbOperations>1,
                                                                                                                NbOperations+DiffIndexImageNbOperations),
                                                                                Format('%9d', [ResultatMax]),
                                                                                False,
                                                                                IndexImageResultatMax),
                                                stApercu,
                                                TStatSolution.Cree( NbPlaquesUtilisees,
                                                                    NbOperations,
                                                                    ResultatMax,
                                                                    Now-main_f.TopChrono));
Result.ImageIndex:=IndexImageSolution;
Result.SelectedIndex:=IndexImageSolution+1;
end;
//-----------------------------------------------------------------------------
function TSituation.EstOperationPossible( var Resultat : TValeur;
                                          const Operateur : TOperateur;
                                          const NumeroOperande : TIndexNombreGenere;
                                          const ContraireOperande : Boolean) : Boolean;
var Operande : TNombre;
begin
Result:=True; // Optimiste par défaut !
Operande := Nombre[NumeroOperande];
case Operateur of
  oPlus:      if ContraireOperande then
                begin
                if Resultat<=Operande.Valeur then
                  begin // OPTIMISATION n°1 : Pas de différence négative ou nulle
                  Result:=False;
                  Exit;
                  end;
                Dec(Resultat, Operande.Valeur)
                end
              else
                Inc(Resultat, Operande.Valeur);
  oMultiplie: begin
              if (ocPasDeMultiplicationDivisionPar1 in OptimisationsCalcul) and
                 (Operande.Valeur=1) then
                begin // OPTIMISATION n°3 : Pas de multiplication/division par 1
                Result:=False;
                Exit;
                end;
             if ContraireOperande then
                begin
                if Resultat mod Operande.Valeur <> 0 then
                  begin // OPTIMISATION n°2 : Pas de division non entière
                  Result:=False;
                  Exit;
                  end;
                Resultat:=Resultat div Operande.Valeur
                end
              else
                Resultat:=Resultat * Operande.Valeur;
              end;
  end{case Operateur of};
end;
//-----------------------------------------------------------------------------
procedure TSituation.Cherche;
var IndexNombre              : TIndexNombreGenere;
    IndexOperande,
    IndexOperandeContraire   : TIndexNombreUtilisable;
    NbMaxOperandes,
    NbOperandes              : TNbOperandes;
    Operateur                : TOperateur;
    NumeroChoixOperandes     : TNumeroChoixOperandes;
    NumeroOperande           : array [TIndexNombreUtilisable] of TIndexNombreGenere;
    ContraireOperande        : array [TIndexNombreUtilisable] of Boolean;
    NumeroChoixContrarietes  : TNumeroChoixContrarietes;
    IndexNombreDisponible    : array [TIndexNombreUtilisable] of TIndexNombreGenere; // OPTIMISATION n°13 : tableau statique
    NbNombresDisponibles     : TNbNombresUtilisables; // OPTIMISATION n°13 : tableau statique (compteur)
    Operation                : TOperation;
    Situation                : TSituation;
    OperandeResultatMemeType, // Indicateur d'opérande résultat de même type d'opération (OPTIMISATION n°4)
    OperationImpossible,      // Indicateur d'opération impossible ou multiplication/division par 1 (OPTIMISATIONS n°1 à 3)
    OperandeEgalResultat,     // Indicateur d'existance d'un opérande égal au résultat (OPTIMISATION n°7)
    OperandesContraires,      // Indicateur d'existence d'opérandes contraires : opposés ou inverses (OPTIMISATION n°8)
    Contrariete              : Boolean;
    Resultat                 : TValeur;
begin
NbMaxOperandes:=CalculeNbMaxOperandes;
// 1. On détermine les index des nombres disponibles dans le tableau Self.Nombre
NbNombresDisponibles:=0;
for IndexNombre:=Low(Nombre) to High(Nombre) do
  if not Nombre[IndexNombre].EstUtilise then
    begin
    IndexNombreDisponible[NbNombresDisponibles]:=IndexNombre;
    Inc(NbNombresDisponibles);
    end;
// 2. On choisit une opération à effectuer parmi les cas possibles
for NbOperandes := Low(TNbOperandes) to NbMaxOperandes do
  for Operateur := Low(TOperateur) to High(TOperateur) do
    for NumeroChoixOperandes := Low(TNumeroChoixOperandes) to NbChoixOperandes[NbOperandes, NbMaxOperandes]-1 do
      for NumeroChoixContrarietes := Low(TNumeroChoixContrarietes) to NbChoixContrarietes[NbOperandes]-2 do // OPTIMISATION n°5 : On ne peut avoir que des contraires donc il y a une possibilité en moins : la dernière !
        begin
        // 2.a On détermine les index des opérandes choisis parmi la liste des nombres DISPONIBLES
        OperandeResultatMemeType:=False; // Initialisation de l'indicateur d'opérande résultat de même type d'opération (OPTIMISATION n°4)
        OperationImpossible:=False; // Initialisation de l'indicateur d'opération impossible (OPTIMISATIONS n°1 à 3)
        OperandeEgalResultat:=False; // Initialisation de l'indicateur d'opérande = Résultat (OPTIMISATION n°7)
        OperandesContraires:=False; // Initialisation de l'indicateur d'opérandes contraires (OPTIMISATION n°8)
        if Operateur=oPlus then Resultat:=0 else Resultat:=1; // Initialisation du résultat de l'opération pour savoir si elle est possible
        for Contrariete:=False to True do // On teste d'abord les non contraires avant les contraire pour cumuler le résultat
          begin
          for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-1 do
            if Contrariete=((NumeroChoixContrarietes and NbChoixContrarietes[IndexOperande])>0) then
              begin
              NumeroOperande[IndexOperande]:=IndexNombreDisponible[NumeroOperandeChoix[NbOperandes, NbMaxOperandes, NumeroChoixOperandes, IndexOperande]];
              ContraireOperande[IndexOperande]:=Contrariete;
              if not EstOperationPossible( Resultat,
                                           Operateur,
                                           NumeroOperande[IndexOperande],
                                           ContraireOperande[IndexOperande]) then
                begin
                OperationImpossible:=True;
                Break;
                end;
              if (ocPasDeResultatMemeTypeOperande in OptimisationsCalcul) and
                 Nombre[NumeroOperande[IndexOperande]].EstResultat and
                 (Nombre[NumeroOperande[IndexOperande]].Operation.Operateur=Operateur) then
                begin // OPTIMISATION n°4 : On n'utilise pas un résultat de même type d'opération comme opérande
                OperandeResultatMemeType:=True;
                Break;
                end;
              end{if contrariete};
          if OperandeResultatMemeType or
             OperationImpossible then // Optimisations ne nécessitant que toutes les opérandes soient définies dans NumeroOperande et ContraireOperande
            Break; // Opérande non utilisable trouvé (OPTIMISATION n°4) ou opération impossible (OPTIMISATIONS n°1 à 3) alors on cherche d'autres possibilités...
          end{for Contrariete};
        if OperandeResultatMemeType or
           OperationImpossible then
          begin
          Inc(IA.NbCalculsEnvisages); // v1.2
          Continue
          end;
        // On teste chaque opérande pour savoir s'il est égal au résultat (OPTIMISATION n°7) : cela nécessite que NumeroOperande et ContraireOperande soient définis entièrement
        for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-1 do
          if (ocPasDeResultatEgalOperande in OptimisationsCalcul) and
             (Nombre[NumeroOperande[IndexOperande]].Valeur=Resultat) then
            begin
            OperandeEgalResultat:=True;
            Break;
            end;
        if OperandeEgalResultat then
          begin
          Inc(IA.NbCalculsEnvisages); // v1.2
          Continue
          end;
        // On teste si deux opérandes contraires existent (OPTIMISATION n°8)
        if (Operateur=oPlus) or (NbOperandes>2) then // ATTENTION : on peut diviser un nombre par lui-même car a/a=1 est autorisé (si 2 opérandes seulement) contrairement à a-a=0.
          for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-2 do // OPTIMISATION n°14 : IndexOperande < IndexOperandeContraire
            for IndexOperandeContraire:=IndexOperande+1 to NbOperandes-1 do
              if (ocPasDOperandesContraires in OptimisationsCalcul) and
                 (Nombre[NumeroOperande[IndexOperande]].Valeur=Nombre[NumeroOperande[IndexOperandeContraire]].Valeur) and
                 (ContraireOperande[IndexOperande]= not ContraireOperande[IndexOperandeContraire]) then
                begin
                OperandesContraires:=True;
                Break;
                end;
        if OperandesContraires then
          begin
          Inc(IA.NbCalculsEnvisages); // v1.2
          Continue
          end;
        // 2.b On crée une instance de la nouvelle opération
        Operation:=TOperation.Cree(Self, Operateur);
        // 2.c On ajoute les opérandes à la nouvelle opération (avec tri dans AjouteOperande)
        for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-1 do
         Operation.AjouteOperande(NumeroOperande[IndexOperande], ContraireOperande[IndexOperande], AjoutAvecTri);
        // 2.d On fait calculer le résultat en interne
        Operation.CalculeResultat;
        // À présent les données de la nouvelle situation sont : 1. NbMaxOperandes,
        //                                                       2. NbOperandes,
        //                                                       3. Operateur,
        //                                                       4. NumeroChoix,
        //                                                       5. NumeroOperande[0..NbOperandes]
        // On génère la situation suivante et on poursuit la recherche...}
        Situation:=TSituation.Cree(Operation);
        if (Abs(Operation.Resultat-IA.Compte)<=IA.DistanceRecherche) and
           (Situation.NbResultatsInutilises=1) and // OPTIMISATION n°6 : On ne garde la solution que s'il ne reste aucun résultat (intermédiaire) inutilisé
           Situation.EcritApercuEnonceSiInexistant(Operation.Resultat) and
           ((Ord(SortieFichier) and Ord(sfEnProfondeur))>0) then
             Situation.EcritApercuProfondeur;
        // v1.2
        if not FormMain.MenuItemOptimisation5.Checked or // Si optimisation 5 non activée OU
           (Operation.Resultat<>IA.Compte) then // Le compte n'est pas trouvé ALORS (OPTIMISATION n°9. v1.2)
          Situation.Cherche; // on continue le calcul en profondeur
        Situation.Detruit;
        Operation.Detruit;
        Inc(IA.NbCalculsEnvisages); // v1.2
        end;
end;
//-----------------------------------------------------------------------------
// METHODES DE LA CLASSE TStatSolution
//-----------------------------------------------------------------------------
constructor TStatSolution.Cree(const NbPlaques, NbLignesCalcul, ResultatIntermediaireMax : Integer; const Temps : TDateTime);
begin
Self.NbPlaques:=NbPlaques;
Self.NbLignesCalcul:=NbLignesCalcul;
Self.ResultatIntermediaireMax:=ResultatIntermediaireMax;
Self.RangComplexite:=0; // Défini plus tard
Inc(OrdreChrono);
Self.RangChrono:=OrdreChrono;
Self.Temps:=Temps;
end;
//-----------------------------------------------------------------------------
destructor TStatSolution.Detruit;
begin
end;
//-----------------------------------------------------------------------------
function TStatSolution.stApercu : String;
var n : Integer;
begin
n:=FormMain.ListBox.Items.Count;
Result:=Format( '%d Plaques, %d Lignes, Résultat Max=%d. Rangs: Complexe=%d/%d, Chrono=%d/%d (%s), Alpha=%d/%d.',
                [ NbPlaques, NbLignesCalcul, ResultatIntermediaireMax,
                  RangComplexite, n,
                  RangChrono, n, FormatDateTime('s.zzz"s"', Temps),
                  FormMain.ListBox.ItemIndex+1, n])
end;
//-----------------------------------------------------------------------------
initialization
//-----------------------------------------------------------------------------
InitialiseRepLocalAppData; // v1.3 : stRepLocalAppData remplace ParamStr(0)
// Initialisation des optimisations paramétrables (optimisation activée par défaut)
OptimisationsCalcul:=[ ocPasDeMultiplicationDivisionPar1,
                       ocPasDeResultatMemeTypeOperande,
                       ocPasDeResultatEgalOperande,
                       ocPasDOperandesContraires];
Sortie:=sPartout; // Sortie Ecran+Fichier
SortieFichier:=sfTout; // Sortie Type énoncé + En profondeur
OrdreChrono:=0;
TempsRecherche:=0;
NbCalculsEnvisages:=0; // v1.2
NiveauRecherche:=ndIndefini;
//-----------------------------------------------------------------------------
finalization
//-----------------------------------------------------------------------------
end.

