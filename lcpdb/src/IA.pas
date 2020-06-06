(******************************************************************************
LE COMPTE POUR DE BON - Atelier de recherche de calculs de comptes � trouver

Copyright (C) 2005 Patrice FOUQUET

Ce programme est un logiciel libre ; vous pouvez le redistribuer et/ou le
modifier conform�ment aux dispositions de la Licence Publique G�n�rale GNU,
telle que publi�e par la Free Software Foundation ; version 2 de la licence,
ou encore toute version ult�rieure.

Ce programme est distribu� dans l'espoir qu'il sera utile,
mais SANS AUCUNE GARANTIE ; sans m�me la garantie implicite de COMMERCIALISATION
ou D'ADAPTATION A UN OBJET PARTICULIER. Pour plus de d�tail,
voir la Licence Publique G�n�rale GNU.

Vous devez avoir re�u un exemplaire de la Licence Publique G�n�rale GNU en m�me
temps que ce programme ; si ce n'est pas le cas,
�crivez � la Free Software Foundation Inc.,
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
  NbMaxPlaques               =  6; // Les 6 nombres donn�s au d�part
  NbMaxNombresGeneres        = 11; // Nombres donn�s (6 max) + R�sultats interm�diaires (5 max)
  NbMaxChoixOperandes        = 20; // Le plus de possibilit�s de choix = 4 op�randes parmi 6 = 20
  NbMaxChoixContrarietes     = 64; // Le plus de possibilit�s de choix = 6 indicateurs contraires = 2^6 = 64 possibilit�s
  NbChiffresMaxResultatMax   =  9; // Le r�sultat max peut avoir au maximum 9 chiffres
  NbOptimisationsCalcul      =  4; // Nombre d'optimisations de calcul param�trables
  NbMaxLignesCalcul          =  5; // Nombre maximum de lignes de calcul
  ndIndefini                 = -1;
  ndTresFacile               =  0;
  ndTresDifficile            =  8;
  ndIntrouvable              =  9;
  stPluriel                  : Array[Boolean] of String = ('', 's'); // Gestion du pluriel pour enlever les parenth�ses. v1.2
//-----------------------------------------------------------------------------
type
//-----------------------------------------------------------------------------
  TValeurPlaque              = 0..100; // Intervalle de valeurs des plaques (Utilis� uniquement dans tableau_f et pavenum_f)
  TIndexNombreGenere         = 0..NbMaxNombresGeneres-1; // Nombres utilis�s ou non
  TIndexNombreUtilisable     = 0..NbMaxPlaques-1; // Nombres utilisables uniquement
  TNbNombresUtilisables      = 0..NbMaxPlaques;
  TNbOperandes               = 2..NbMaxPlaques;
  TIndexLigneCalcul          = 0..NbMaxLignesCalcul-1;
  TNbLignesCalcul            = 0..NbMaxLignesCalcul;
  TNumeroChoixOperandes      = 0..NbMaxChoixOperandes-1; // Maximum : 4 op�randes parmi 6 = 20 choix possibles
  TNbChoixOperandes          = 0..NbMaxChoixOperandes; // Maximum : 4 op�randes parmi 6 = 20 choix possibles
  TNbChoixContrarietes       = 0..NbMaxChoixContrarietes; // Maximum : 6 indicateurs contraires = 2^6 = 64 possibilit�s
  TNumeroChoixContrarietes   = 0..NbMaxChoixContrarietes-1; // Maximum : 6 indicateurs contraires = 2^6 = 64 possibilit�s
  TOperateur                 = (oPlus, oMultiplie);
  TValeur                    = Integer; // OPTIMISATION n�10 (au lieu de Int64)

  TSortie                    = (sAucune, sEcran, sFichier, sPartout);
  TSortieEcran               = (seAucun, seTypeListe, seTypeArbre, seTout);
  TSortieFichier             = (sfAucun, sfTypeEnonce, sfEnProfondeur, sfTout);
  TOptimisationCalcul        = ( ocPasDeMultiplicationDivisionPar1, // Param�trable (Activ� par d�faut)
                                 ocPasDeResultatMemeTypeOperande, // Param�trable (Activ� par d�faut)
                                 ocPasDeResultatEgalOperande, // Param�trable (Activ� par d�faut)
                                 ocPasDOperandesContraires, // Param�trable (Activ� par d�faut)
                                 ocResultatInutilise, // Toujours activ�
                                 ocPasDeResultatEgalCompte); // Param�trable (Activ� par d�faut). v1.2
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
    FEstUtilise : Boolean; // True si Self est l'op�rande d'un r�sultat parmi Situation.Nombre
    function CalculeSiResultat : Boolean;
  public
    Valeur    : TValeur;
    Operation : TOperation; // Op�ration dans laquelle il est le r�sultat
    property EstUtilise : Boolean read FEstUtilise; // Lecture seule
    property EstResultat : Boolean read CalculeSiResultat; // Lecture seule
    constructor Cree(Situation : TSituation; const Valeur : TValeur); overload; // Constructeur
    constructor Cree(Situation : TSituation; const Nombre : TNombre); overload; // Constructeur de copie/d�r�f�rencement suivant Nombre.EstUtilise
    constructor Cree(Operation : TOperation); overload; // Cr�e le r�sultat d'Operation comme nombre
    destructor Detruit;
    function Copie(Situation: TSituation) : TNombre; // Copie/D�r�f�rence selon qu'il est utilis� ou non (OPTIMISATION n�11)
    procedure Utilise; // Passe EstUtilise � True
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
    NbOperandes   : TNbNombresUtilisables; // Rq : Th�oriquement c'est de type TNbOperandes mais pas en pure cr�ation o� on part de z�ro !
    IndexOperande : array [TIndexNombreUtilisable] of TIndexNombreGenere; // Index de l'op�rande dans Situation (de TIndexNombreUtilisable dans TIndexNombreGenere)
    Contraire     : array [TIndexNombreUtilisable] of Boolean;
    property Resultat    : TValeur read DonneResultat;
    constructor Cree(Situation : TSituation; const Operateur : TOperateur); overload; // Constructeur
    constructor Cree(Situation : TSituation; const Operation : TOperation); overload; // Cl�neur
    destructor Detruit;
    procedure CalculeResultat; // Calcule le r�sultat et le stocke dans FResultat.
    function OperandeAClasserAvant( const OperationSrc : TOperation; const IndexOperandeSrc : TIndexNombreGenere; const ContraireSrc : Boolean; const IndexOperationDst : TIndexNombreUtilisable; var ContenusIdentiques : Boolean) : Boolean;
    procedure AjouteOperande(const IndexOperande : TIndexNombreGenere; const Contraire, AvecTri : Boolean);
    procedure CopieNombresDans(Situation : TSituation); // Copie (cl�ne) les nombres de Self dans Situation
    procedure MarqueOperandesUtilises; // Marque les propri�t�s EstUtilise des op�randes de Self
    function NbOperations : Integer; // Retourne le nombre de niveaux d'op�rations sous-jacentes (0=op�ration avec uniquement des nombres donn�s)
    function ResultatMax : TValeur; // Retourne le r�sultat le plus �lev� trouv� dans les op�randes � tous les niveaux (nombres calcul�s uniquement)
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
    constructor Cree(const Operation : TOperation); overload;// G�n�rateur : fabrique une nouvelle situation � partir de l'op�ration
    destructor Detruit;
    procedure AjouteNombre(const Valeur : TValeur); overload;
    procedure AjouteNombre(const Nombre : TNombre); overload;
    procedure AjouteResultat(Operation : TOperation); // Ici on transmet OperantionSrc, on ne le cl�ne pas, il l'a d�j� �t� dans TSituation.Cree(OperationSrc)
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
var // Instances uniques : �vite la duplication d'une information unique
//-----------------------------------------------------------------------------

  SortieProfondeur,
  SortieEnonce            : Text;
  stRepLocalAppData, // v1.3 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  stNomFichierProfondeur,
  stNomFichierEnonce,
  stConclusion, // Indique si compte est bon ou approch�
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
  ParametreVide           : Boolean; // Utilis� pour PositionOperateur(...)
//-----------------------------------------------------------------------------
const
  stToolButton         : string = 'ToolButton'; // Pr�fixe d'objet utilis�s par les fiches  // v1.3 : ToolButton au lieu de SpeedButton
  stLabel               : string = 'Label';       // Pr�fixe d'objet utilis�s par les fiches
  stOperateurEgal       : string = '=';
  stSuffixeOperation    : string = ' op�ration';
  stSuffixePlaque       : string = ' plaque';
  stLeCompteEstBon      : string = 'Le compte est bon. ';
  stLeCompteEstApproche : string = 'Le compte est approch� (�%d) : %d ou %d. ';
  stAvertissementOptCalc: array [TOptimisationCalcul] of String = ( 'Multiplication/Division par 1. Op�ration ignor�e.',
                                                                    'Op�rande r�sultat d''une op�ration de m�me type trouv� : op�rations regroup�es.',
                                                                    'Op�rande �gal au r�sultat trouv� : op�ration ignor�e.',
                                                                    'Deux op�randes inverses ou oppos�s trouv�s. Op�randes ignor�s.',
                                                                    'R�sultat interm�diaire non utilis�. Op�ration ignor�e.',
                                                                    'R�sultat interm�diaire �gal au compte. Suite ignor�e.');
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

  NumeroOperandeChoix   : array [TNbOperandes, // Nombre d'op�randes � choisir
                                 TNbOperandes, // Nombre d'op�randes s�lectionnables
                                 TNumeroChoixOperandes, // N� de choix d'op�randes  1�Choix       2�Choix       3�Choix       4�Choix       5�Choix       6�Choix       7�Choix       8�Choix       9�Choix      10�Choix      11�Choix      12�Choix      13�Choix      14�Choix      15�Choix      16�Choix      17�Choix      18�Choix      19�Choix      20�Choix
                                 TIndexNombreUtilisable]{N�op�rande} of TIndexNombreUtilisable =
                                                                              ((((0,1,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 2 (1 possibilit�)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(1,2,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 3 (3 possibilit�s)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(2,3,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 4 (6 possibilit�s)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(0,4,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(1,4,0,0,0,0),(2,3,0,0,0,0),(2,4,0,0,0,0),(3,4,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 2 parmi 5 (10 possibilit�s)
                                                                                ((0,1,0,0,0,0),(0,2,0,0,0,0),(0,3,0,0,0,0),(0,4,0,0,0,0),(0,5,0,0,0,0),(1,2,0,0,0,0),(1,3,0,0,0,0),(1,4,0,0,0,0),(1,5,0,0,0,0),(2,3,0,0,0,0),(2,4,0,0,0,0),(2,5,0,0,0,0),(3,4,0,0,0,0),(3,5,0,0,0,0),(4,5,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 2 parmi 6 (15 possibilit�s)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 3 (1 possibilit�)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,2,3,0,0,0),(1,2,3,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 4 (4 possibilit�s)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,1,4,0,0,0),(0,2,3,0,0,0),(0,2,4,0,0,0),(0,3,4,0,0,0),(1,2,3,0,0,0),(1,2,4,0,0,0),(1,3,4,0,0,0),(2,3,4,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 3 parmi 5 (10 possibilit�s)
                                                                                ((0,1,2,0,0,0),(0,1,3,0,0,0),(0,1,4,0,0,0),(0,1,5,0,0,0),(0,2,3,0,0,0),(0,2,4,0,0,0),(0,2,5,0,0,0),(0,3,4,0,0,0),(0,3,5,0,0,0),(0,4,5,0,0,0),(1,2,3,0,0,0),(1,2,4,0,0,0),(1,2,5,0,0,0),(1,3,4,0,0,0),(1,3,5,0,0,0),(1,4,5,0,0,0),(2,3,4,0,0,0),(2,3,5,0,0,0),(2,4,5,0,0,0),(3,4,5,0,0,0))), // 3 parmi 6 (20 possibilit�s)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 4 parmi 4 (1 possibilit�)
                                                                                ((0,1,2,3,0,0),(0,1,2,4,0,0),(0,1,3,4,0,0),(0,2,3,4,0,0),(1,2,3,4,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 4 parmi 5 (5 possibilit�s)
                                                                                ((0,1,2,3,0,0),(0,1,2,4,0,0),(0,1,2,5,0,0),(0,1,3,4,0,0),(0,1,3,5,0,0),(0,1,4,5,0,0),(0,2,3,4,0,0),(0,2,3,5,0,0),(0,2,4,5,0,0),(0,3,4,5,0,0),(1,2,3,4,0,0),(1,2,3,5,0,0),(1,2,4,5,0,0),(1,3,4,5,0,0),(2,3,4,5,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 4 parmi 6 (15 possibilit�s)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,4,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),  // 5 parmi 5 (1 possibilit�)
                                                                                ((0,1,2,3,4,0),(0,1,2,3,5,0),(0,1,2,4,5,0),(0,1,3,4,5,0),(0,2,3,4,5,0),(1,2,3,4,5,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))), // 5 parmi 6 (6 possibilit�s)
                                                                               (((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0)),
                                                                                ((0,1,2,3,4,5),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0))));// 6 parmi 6 (1 possibilit�)
//-----------------------------------------------------------------------------
// D�clarations de m�thodes d'unit�s (exportables)
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
// Renvoie les optimisations effectu�es le cas �ch�ant.
// Si modification il y a : IdxDrnOperande, Operande[], Contraire[] et
//                          stAvertissements sont modifi�s
//-----------------------------------------------------------------------------
function TesteOptimisationOperandes( const Operateur : TOperateur; // Op�rateur de l'op�ration
                                     const Resultat : TValeur;
                                     const stPrefixeAvertissement : String;
                                     var   Operande  : TOperandesLigneCalcul; // Op�randes[0..IdxDrnOperande]
                                     var   Contraire : TMarquagesLigneCalcul;
                                     var   IdxDrnOperande : TIndexNombreUtilisable;
                                     var   stAvertissements : String) : TOptimisationsCalcul;
var i, j                  : Integer; // v1.2.1
    ASupprimer            : TMarquagesLigneCalcul;
begin
Result:=[]; // Pessimiste
// 1. D'abord les optimisations d'op�rations inutiles
//  - ocPasDeResultatEgalOperande
if (ocPasDeResultatEgalOperande in OptimisationsCalcul) then // Exception : Cas Compte par 1 = Compte
  for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
    if (Operande[i]=Resultat) then
      begin
      AjouteOptimisation(ocPasDeResultatEgalOperande, Result, stPrefixeAvertissement, stAvertissements);
      Exit; // �a ne sert � rien de continuer... La ligne va �tre supprim�e
      end;

// 2. Cas des op�randes inutiles :
//  - ocPasDOperandesContraires
//  - ocPasDeMultiplicationDivisionPar1
// On initialise les marqueurs
for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
  ASupprimer[i]:=False;
for i:=Low(TIndexNombreUtilisable) to IdxDrnOperande do
  begin
  if (ocPasDeMultiplicationDivisionPar1 in OptimisationsCalcul) and
     not ASupprimer[i] and // On ne traite pas un op�rande d�j� � supprimer
     (Operande[i]=1) and (Operateur=oMultiplie) then
    begin
    AjouteOptimisation(ocPasDeMultiplicationDivisionPar1, Result, stPrefixeAvertissement, stAvertissements);
    ASupprimer[i]:=True;
    end;
  if (ocPasDOperandesContraires in OptimisationsCalcul) and
     (IdxDrnOperande>1) then // Si 2 op�randes : autoris� (a-a=0 impossible � saisir mais a/a=1 possible et autoris� !)
    for j:=i+1 to IdxDrnOperande do
      if not ASupprimer[i] and not ASupprimer[j] and // On ne traite pas deux fois le m�me op�rande
         (Operande[i]=Operande[j]) and
         (Contraire[i]=not Contraire[j]) then
        begin
        AjouteOptimisation(ocPasDOperandesContraires, Result, stPrefixeAvertissement, stAvertissements);
        ASupprimer[i]:=True;
        ASupprimer[j]:=True;
        end
  end;
// 3. On supprime les op�randes marqu�es comme telles
for i:=IdxDrnOperande downto Low(TIndexNombreUtilisable) do
  if ASupprimer[i] then
    begin
    Dec(IdxDrnOperande); // v1.2.3 : la d�cr�mentation �tait dans la boucle or si les op�randes sont en queue, la boucle n'est pas parcourue !
    for j:=IdxDrnOperande-1 downto i do
      begin
      Operande[j]:=Operande[j+1];
      Contraire[j]:=Contraire[j+1];
      end
    end
end;
//-----------------------------------------------------------------------------
function PositionOperateur( const Operateur : TOperateur; // Indique le type d'op�ration
                            const stOperation : String; // Cha�ne de l'op�ration
                            var Contraire : Boolean; // Indique si l'op�rateur trouv� est contraire
                            var FinOperation : Boolean) : Integer; // Indique si '=' est l'op�rateur trouv�
var PosOperateur   : TPositionsOperateurs;
begin
FinOperation:=False; // 1 seul cas de fin donc False par d�faut
PosOperateur[0]:=Pos(stOperateur[Operateur], stOperation);
PosOperateur[1]:=Pos(stOperateurContraire[Operateur], stOperation);
if PosOperateur[0]+PosOperateur[1]=0 then
  begin // On atteint le dernier op�rande. PosOperateur = Pos(stOperateurEgal);
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
PosOperateur:=Pos(stOperateurEgal, stOperation); // On cherche o� se trouve l'op�rateur =
Resultat:=StrToInt(copy(stOperation, PosOperateur+1, Length(stOperation)-PosOperateur));// On extrait le r�sultat de l'op�ration
IdxDrnOperande:=0;
DrnOperandeTrv:=False;
// 2. On cherche l'op�rateur (entre + et *)
PosOperateurs[Ord(oPlus)]:=Pos(stOperateur[oPlus], stOperation)+Pos(stOperateurContraire[oPlus], stOperation);
PosOperateurs[Ord(oMultiplie)]:=Pos(stOperateur[oMultiplie], stOperation)+Pos(stOperateurContraire[oMultiplie], stOperation);
if PosOperateurs[Ord(oPlus)]>0 then
  Operateur:=oPlus
else
  Operateur:=oMultiplie;

Result:=stOperation;

// 3. On localise le premier op�rateur pour d�terminer le premier op�rande
PosOperateur:=PositionOperateur(Operateur, stOperation, Contraire[1], ParametreVide);

// 4. On d�termine l'op�rande et sa "contrari�t�" positive pour le premier
Operande[0]:=StrToInt(copy(stOperation, 1, PosOperateur-1));
stResteATraiter:=copy(stOperation, PosOperateur+1, Length(stOperation)-PosOperateur);
Contraire[0]:=False;

// 5. On d�termine les autres op�randes (� pr�sent on part de l'op�rateur (le premier) jusqu'au dernier op�rande)
Repeat
  Inc(IdxDrnOperande);
  PosOperateur:=PositionOperateur(Operateur, stResteATraiter, Contraire[IdxDrnOperande+1], DrnOperandeTrv);
  Operande[IdxDrnOperande]:=StrToInt(copy(stResteATraiter,1,PosOperateur-1));
  stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
Until DrnOperandeTrv;
// 5c. On teste les optimisations de calculs et on modifie le cas �ch�ant Operande, Contraire et IdxDrnOperande
Optimisations:=TesteOptimisationOperandes( Operateur,
                                           Resultat,
                                           stPrefixeAvertissement,
                                           Operande,
                                           Contraire,
                                           IdxDrnOperande,
                                           stAvertissements);
if (ocPasDeResultatEgalOperande in Optimisations) or // Si op�ration inutile OU
   (IdxDrnOperande=0) then // Il ne reste plus qu'un op�rande ALORS
  begin // On renvoie vide et on sort !
  Result:='';
  Exit;
  end;

// 6. On trie les op�randes par ordre de contrari�t� (Non-contraires puis contraires) et valeur (ordre d�croissant)
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
// 7. On reforme l'op�ration en cha�ne pour la transmettre
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
// FONCTION stReduitEtOrdonneCalculSaisi (avec sous-proc�dures et sous-fonctions
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
// Proc�dures internes (Phase 3)
//------------------------------------------------------------------------------
function LignesCalculMemeResultatOrdonnees(const IndexLigneCalcul1, IndexLigneCalcul2 : TIndexLigneCalcul) : Boolean;
var PosOperateur             : TPositionsOperateurs;
    DrnOperandeTrv    : Boolean;
    Operande                 : array [0..1] of TValeur;
    stResteATraiter          : array [0..1] of String;
    Index                    : array [0..1] of TIndexLigneCalcul;
    i                        : Integer;
begin
// On suppose ici que les r�sultats ont m�me valeur. On souhaite conna�tre laquelle des deux lignes de calcul on va prendre.
Index[0]:=IndexLigneCalcul1; Index[1]:=IndexLigneCalcul2;
// 1. On compare d'abord l'ordre des r�sultats dans la ligne les utilisant (ordre d�croissant)
if NbOperandesLigneCalcul[Index[0]]<>NbOperandesLigneCalcul[Index[1]] then
  begin
  Result:=(NbOperandesLigneCalcul[Index[0]]>NbOperandesLigneCalcul[Index[1]]);
  Exit;
  end;
// � partir d'ici les deux lignes de calcul ont le m�me nombre d'op�randes)
for i:=0 to 1 do
  stResteATraiter[i]:=stLigneCalcul[Index[i]];
repeat
  PosOperateur[0]:=PositionOperateur(OperateurLigneCalcul[Index[0]], stResteATraiter[0], ParametreVide, DrnOperandeTrv);
  PosOperateur[1]:=PositionOperateur(OperateurLigneCalcul[Index[1]], stResteATraiter[1], ParametreVide, DrnOperandeTrv);
  for i:=0 to 1 do
    begin
    Operande[i]:=StrToInt(copy(stResteATraiter[i], 1, PosOperateur[i]-1));
    stResteATraiter[i]:=copy(stResteATraiter[i], PosOperateur[i]+1, Length(stResteATraiter[i])); // v1.2.6 : Il manquait le principe de r�currence ce qui faisait une boucle infinie si les premiers op�randes �taient �gaux...
    end;
  if Operande[0]<>Operande[1] then
    begin
    Result:=(Operande[0]>Operande[1]);
    Exit;
    end;
  // � partir d'ici les i�mes op�randes sont �gaux, on continue...
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
// 2. On initialise les cha�nes de traitement
stCalculOperandes:='';
stResteATraiter:=stLigneCalcul[IndexLigne];
// 3. On extrait les op�randes et on va chercher les �ventuelles lignes qui
//    d�finissent les op�randes comme r�sultats interm�diaires
repeat
  PosOperateur:=PositionOperateur(OperateurLigneCalcul[IndexLigne], stResteATraiter, ParametreVide, DrnOperandeTrv);
  Operande:=StrToInt(copy(stResteATraiter, 1, PosOperateur-1));
  stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
  IndexLigneSvt:=High(TIndexLigneCalcul); // On calcul un minimum...
  for i:=0 to IndexLigne-1 do
    if (ResultatLigneCalcul[i]=Operande) and // On a trouv� une ligne dont le r�sultat est �gal � l'op�rande ET
       not LigneCalculUtilisee[i] and // ce r�sultat n'a pas encore �t� utilis� ET
       ((IndexLigneSvt=High(TIndexLigneCalcul)) or // SOIT on a pas encore trouv� de ligne concurrente
        (RangLigneMemeResultat[i]<RangLigneMemeResultat[IndexLigneSvt])) then // SOIT on en a une mais pas meilleure ALORS
      IndexLigneSvt:=i; // ON prend cette ligne
  if IndexLigneSvt<High(TIndexLigneCalcul) then
    begin
    LigneCalculUtilisee[IndexLigneSvt]:=True; // On a trouv� une ligne
    stCalculOperandes:=ConstruitCalculReduitEtOrdonne(stCalculOperandes, IndexLigneSvt);
    end;
until DrnOperandeTrv;
// 4. On reconstruit la ligne de calcul en intercalant les lignes de calcul des
//    op�randes entre la cha�ne construite et la ligne des r�sultats en
//    faisant attention aux cha�nes vides
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
// D�but FONCTION stReduitEtOrdonneCalculSaisi
//------------------------------------------------------------------------------
begin
Result:='';
NbLignesCalcul:=0;
stAvertissements:='Calcul saisi : '+stCalcul;
stAvertissements:=stAvertissements+#13#10'Optimisation des lignes...';
// Phase 1 : r�duit & ordonne chaque ligne ind�pendemment l'une de l'autre
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
// Phase 2 : r�duit & ordonne les lignes en groupant les op�rations de m�me type
//------------------------------------------------------------------------------
stAvertissements:=stAvertissements+#13#10'Regroupement des op�rations de m�me type...';
if NbLignesCalcul<2 then
  begin
  Result:=stLigneCalcul[0];
  stAvertissements:=stAvertissements+#13#10'Calcul optimis� (r�duit et ordonn�): '+Result;
  Exit; // On ne peut plus optimiser grand-chose : il ne reste qu'une ligne !
  end;
// 2a. On teste chaque ligne pour v�rifier les fusions possibles
for i:=1 to NbLignesCalcul-1 do // Pour chaque ligne de calcul (sauf la premi�re qui ne peut contenir de r�sultat interm�diaire)
  begin
  stResteATraiter:=copy(stLigneCalcul[i], 1, Pos(stOperateurEgal, stLigneCalcul[i])); // On vire le r�sultat de la ligne (on garde le signe '=')
  stPartieLigneTraitee:='';
  FusionLigne:=False;
  stOperateurSuivant:='';
  while stResteATraiter<>'' do
    begin
    // On localise le prochain op�rateur
    PosOperateur:=PositionOperateur(OperateurLigneCalcul[i], stResteATraiter, ParametreVide, ParametreVide);
    Operande:=StrToInt(copy(stResteATraiter,1,PosOperateur-1));
    ChangerSigne:=(stOperateurSuivant=stOperateurContraire[OperateurLigneCalcul[i]]); // On teste si l'op�rateur est contraire avant de r�cup�rer le suivant
    stOperateurSuivant:=copy(stResteATraiter,PosOperateur,1);
    stResteATraiter:=copy(stResteATraiter, PosOperateur+1, Length(stResteATraiter)-PosOperateur);
    // On regarde si l'op�rande n'est pas le r�sultat d'une ligne pr�c�dente
    FusionOperande:=False;
    for j:=0 to i-1 do
      if (stLigneCalcul[j]<>'') and // Ligne encore utile (pas fusionn�e et pas vide)
         (Operande=ResultatLigneCalcul[j]) and // Op�rande = R�sultat
         not LigneCalculUtilisee[j] then // R�sultat de la ligne non encore utilis�
        begin
        LigneCalculUtilisee[j]:=True; // L'op�rande a �t� trouv� comme r�sultat ALORS on le marque sa ligne comme utilis�e
        if (OperateurLigneCalcul[i]=OperateurLigneCalcul[j]) then // M�mes type d'op�ration
          begin // ALORS on fusionne : on remplace l'op�rande par la ligne de calcul
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
          if not FusionLigne then FusionLigne:=True; // Indique qu'il faudra r�duire et ordonner ensuite
          Break; // On a trouv� la ligne de calcul, on arr�te la recherche apr�s la fusion
          end
        end;
    if not FusionOperande then // L'op�rande courante N'a PAS �t� remplac�e par une ligne de calcul : on l'ajoute directement avec l'op�rateur suivant
      stPartieLigneTraitee:=stPartieLigneTraitee+IntToStr(Operande)+stOperateurSuivant;
    end{while};
  // Si une fusion de ligne a �t� faite on r�duit et ordonne la ligne de calcul � nouveau
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
// 2b. On supprime les lignes inutilis�es (sauf la derni�re) c'est-�-dire les lignes dont le r�sultat n'est pas utilis�.
stAvertissements:=stAvertissements+#13#10'Suppression des lignes dont le r�sultat n''est pas utilis�...';
for i:=0 to NbLignesCalcul-2 do
  if not LigneCalculUtilisee[i] and
     (stLigneCalcul[i]<>'') then
    begin
    stAvertissements:=stAvertissements+#13#10' - Ligne "'+stLigneCalcul[i]+'"';
    stLigneCalcul[i]:='';
    end;
// Phase 3: On trie les lignes de m�me r�sultat et on reconstitue le calcul 
//------------------------------------------------------------------------------
// 3a. On initialise les marqueurs
stAvertissements:=stAvertissements+#13#10'Tri des lignes et reconstitution du calcul finalis�...';
for i:=0 to NbLignesCalcul-1 do
  begin
  LigneCalculUtilisee[i]:=False; 
  RangLigneMemeResultat[i]:=0;
  end;
// 3b. On classe les lignes de m�me r�sultat (sauf la derni�re ligne bien s�r)
for i:=0 to NbLignesCalcul-3 do
  for j:=i+1 to NbLignesCalcul-2 do
    if (ResultatLigneCalcul[i]=ResultatLigneCalcul[j]) then
      if LignesCalculMemeResultatOrdonnees(i, j) then
        Inc(RangLigneMemeResultat[j])
      else
        Inc(RangLigneMemeResultat[i]);
// Phase 3 : On ordonne les lignes par r�currence
Result:=ConstruitCalculReduitEtOrdonne('', NbLignesCalcul-1); // Appel R�cursif
stAvertissements:=stAvertissements+#13#10'Calcul optimis� (r�duit et ordonn�): '+Result;
end;
//------------------------------------------------------------------------------
// Fin FONCTION stReduitEtOrdonneCalculSaisi
//------------------------------------------------------------------------------
function stVerifieNumeroOperandeChoix : string; // fonction de v�rification � usage unique et donc plus utilis� mais laiss� en guise d'exemple
var
    nmo,no : TNbOperandes;
    nco    : TNumeroChoixOperandes;
    ioc    : TIndexNombreUtilisable;
    x, xx  : Integer;
const Puiss6 : array [TIndexNombreUtilisable] of Integer = (46656,7776,1296,216,36,6);
begin
// V�rification de NumeroOperandeChoix
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
          Result:=Result+Format(#13#10'Index d''op�randes ind�finis pour ce choix (%d/%d,%d).', [no,nmo,nco]);
        if xx<=x then
          Result:=Result+Format(#13#10'Distribution irr�guli�re (%d/%d,%d) [%d!>%d].', [no,nmo,nco, xx,x]);
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
  // On fixe le niveau du compte cherch�
  with FormMain.TreeView do
    if (Items.Count>0) and
       (Items[0].getFirstChild<>nil) and
       (Items[0].getFirstChild.getFirstChild<>nil) then
      IA.NiveauRecherche:=Items[0].getFirstChild.ImageIndex+Items[0].getFirstChild.getFirstChild.ImageIndex-5;
  // On r�sume les infos du r�sultat
  IA.stConclusion:=IA.stLeCompteEstBon
  end
else
  begin
  // On fixe le niveau du compte cherch�
  IA.NiveauRecherche:=ndIntrouvable;
  // On r�sume les infos du r�sultat
  IA.stConclusion:=Format(stLeCompteEstApproche, [IA.DistanceRecherche, IA.Compte-IA.DistanceRecherche, IA.Compte+IA.DistanceRecherche]);
  end;
FormTableau.ToolButtonDifficulte.ImageIndex:=IA.NiveauRecherche;  // v1.1
IA.stNbSolutionsTempsEcoule:= Format( '%d solution%s en ', [ FormMain.ListBox.Items.Count,
                                                             stPluriel[FormMain.ListBox.Items.Count>1]])+ // Gestion du pluriel pour enlever les parenth�ses. v1.2
                              FormatDateTime('s''"''z', Tps)+ // v1.2
                              Format('. %d envisag�es.', [IA.NbCalculsEnvisages]); // v1.2
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
  // - On retire les compteurs indiqu�s par les images
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
  // On calcule le pourcentage que l'on affiche � la fin du libell� de chaque feuille de l'arbre. v1.2
  with FormMain.TreeView do // v1.2
    for i:=1 to Items.Count-1 do
      with Items[i] do
        if Parent<>nil then
          begin
          if HasChildren then Text:=TrimLeft(Text); // Retirer les espaces des noeuds de r�sultats interm�diaires max.
          if Pos('solution', Parent.Text)>0 then // Nombre de solutions
            Compteur:=FormMain.ListBox.Items.Count
          else
            begin
            stIntitule:=Items[i].Parent.Text;
            PosParentheseGauche:=Pos('(', stIntitule);
            if PosParentheseGauche>0 then
              if Pos('/', stIntitule)>0 then // On a d�j� calcul� le pourcentage pour le parent
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
begin // v1.3.2 proc�dure r��crite
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
// M�thodes de la classe TNombre
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
  Self.Operation := Nombre.Operation {TOperation.Cree(Self.Situation, Nombre.Operation)} // D�r�f�rence au lieu de copier (OPTIMISATION n�12)
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
function TNombre.Copie(Situation: TSituation) : TNombre; // Effectue une copie par allocation ou d�r�f�rencement suivant qu'il soit Utilis� ou non (OPTIMISATION n�11)
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
// M�thodes de la classe TOperation
//-----------------------------------------------------------------------------
constructor TOperation.Cree(Situation : TSituation; const Operateur : TOperateur); // Constructeur
begin
Self.Situation := Situation;
Self.Operateur := Operateur;
FResultat:=0; // R�sultat pas encore d�fini (0 par convention car r�sultat impossible)
NbOperandes:=0;
end;
//-----------------------------------------------------------------------------
constructor TOperation.Cree(Situation : TSituation; const Operation : TOperation); // Cl�neur
var i : Integer; // v1.2.1
begin
Self.Situation := Situation;
Self.Operateur := Operation.Operateur;
Self.FResultat := Operation.Resultat; // On fait confiance � la propri�t� de l'op�ration fournie !
NbOperandes:=0;
for i:=Low(Operation.IndexOperande) to Operation.NbOperandes-1 do
  AjouteOperande(Operation.IndexOperande[i], Operation.Contraire[i], AjoutSansTri);
end;
//-----------------------------------------------------------------------------
destructor TOperation.Detruit;
begin
end;
//-----------------------------------------------------------------------------
// Calcule le r�sultat et le stocke dans FResultat. Renvoie Vrai si l'op�ration
// est possible (>0 et division enti�re)
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
if FResultat=0 then CalculeResultat; // Si FResultat nul alors le r�sultat n'a jamais �t� calcul� (par s�curit�)
Result:=FResultat;
end;
//-----------------------------------------------------------------------------
// On veut comparer les nombres
//  - OperationSrc.Situation.Nombre[IndexOperandeSrc] de contrari�t� ContraireSrc �
//  - self.Situation.Nombre[self.IndexOperande[IndexOperationDst]] de
//    contrari�t� self.Contraire[IndexOperationDst]
// Renvoie True si le premier est � ajouter avant le deuxi�me. False sinon.
// ContenusIdentiques est modifi� : True si les contenus sont identiques
// (ind�pendamment des ordres de cr�ation). False sinon.
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
Result:=False; // Valeur par d�faut dans le cas o� les nombres sont strictement �gaux en contenu (mais le premier arriv� est le mieux plac� et n'est pas d�plac�).
ContenusIdentiques:=False; // Cas le plus fr�quent
// Ordre des Crit�res de comparaison :
// 1. Contrari�t� : Non Contraires d'abord ; Contraires ensuite
if ContraireSrc<>Self.Contraire[IndexOperationDst] then
  begin
  Result:=ContraireSrc<Self.Contraire[IndexOperationDst];
  Exit;
  end;
// Note : On peut maintenant utiliser UNIQUEMENT ContraireSrc car Self.Contraire[IndexOperationDst]=ContraireSrc !
NombreDst:=        Self.Situation.Nombre[Self.IndexOperande[IndexOperationDst]];
NombreSrc:=OperationSrc.Situation.Nombre[IndexOperandeSrc];
// 2. Valeur : Ordre d�croissant si non contraire ; Ordre croissant si contraire
if NombreSrc.Valeur<>NombreDst.Valeur then
  begin
  Result:=((NombreSrc.Valeur>NombreDst.Valeur) and Not ContraireSrc) or
          ((NombreSrc.Valeur<NombreDst.Valeur) and ContraireSrc);
  Exit;
  end;
// 3. Type : R�sultats d'abord ; Non R�sultats ensuite
if NombreSrc.EstResultat<>NombreDst.EstResultat then
  begin
  Result:=NombreSrc.EstResultat>NombreDst.EstResultat;
  Exit;
  end;
// 4. Cas des nombres non r�sultats �gaux : le premier arriv� est le mieux plac� !
if not NombreSrc.EstResultat then
  begin
  ContenusIdentiques:=True; // On indique n�anmoins qu'en contenu, ils sont �gaux
  Exit;
  end;
// Note : On consid�re maintenant que l'on traite UNIQUEMENT des r�sultats
// 5. Nombre d'op�randes : Ordre d�croissant (de surcro�t des non r�sultats sont
//                         � la fin si l'on consid�re qu'ils n'ont qu'un op�rande)
if NombreSrc.Operation.NbOperandes<>NombreDst.Operation.NbOperandes then
  begin
  Result:=NombreSrc.Operation.NbOperandes>NombreDst.Operation.NbOperandes;
  Exit;
  end;
// Note : � pr�sent, le nombre d'op�randes est identique.
// 6. ENFIN, on compare r�cursivement chaque op�rande dans l'ordre de leurs index respectifs.
// Si nombres strictement �gaux (comme deux non r�sultats de m�me valeur et contrari�t�),
// On passe aux op�randes suivantes de m�me index et ainsi de suite
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
    NombresEgaux : Boolean; // R�sultat de fonction inutilis� pour cet appel de fonction
begin
Inc(NbOperandes);
if AvecTri then
  begin
  if NbOperandes>1 then // On ne trie que s
    for i:=NbOperandes-2 downto Low(Self.IndexOperande) do
      if OperandeAClasserAvant(self, IndexOperande, Contraire, i, NombresEgaux) then
        begin // On d�cale les op�randes actuelles et on continue � chercher ant�rieurement
        Self.IndexOperande[i+1] := Self.IndexOperande[i];
        Self.Contraire[i+1]     := Self.Contraire[i];
        end
      else // On a trouv� l'endroit du nouvel op�rande
        begin
        Self.IndexOperande[i+1] := IndexOperande;
        Self.Contraire[i+1]     := Contraire;
        Exit;
        end;
  // On a pas encore affect� : il s'agit alors de la premi�re place !
  Self.IndexOperande[Low(Self.IndexOperande)] := IndexOperande;
  Self.Contraire[Low(Self.IndexOperande)]     := Contraire;
  end
else // Sans tri : on ajoute � la fin
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
// Marque les propri�t�s EstUtilise des op�randes de Self
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
// D'abord on �crit les op�rations ant�rieures
for i:=Low(IndexOperande) to NbOperandes-1 do
  if Situation.Nombre[IndexOperande[i]].EstResultat then
    Result:=Result+Situation.Nombre[IndexOperande[i]].Operation.stApercuEnonce;
// Ensuite, on peut �crire l'op�ration courante.
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
// M�thodes de la classe TSituation
//-----------------------------------------------------------------------------
constructor TSituation.Cree;
begin
SetLength(Nombre, 0);
end;
//-----------------------------------------------------------------------------
constructor TSituation.Cree(const Operation : TOperation); // Cl�neur : fabrique une nouvelle situation � partir d'une op�ration (et de sa situation)
var OperationDst : TOperation; // Cl�ne d'Operation
begin
// 1. On cl�ne d'abord Operation pour qu'elle soit � Self.
OperationDst := TOperation.Cree(Self, Operation);
// 2. On copie les nombres de Operation.Situation dans Situation (self)
Operation.CopieNombresDans(Self);
// 3. On marque les op�randes d'OperationDst comme utilis�
OperationDst.MarqueOperandesUtilises;
// 4. On ajoute le r�sultat comme nombre � Self
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
self.Nombre[i]:=Nombre.Copie(Self); {TNombre.Cree(Self, Nombre);} // OPTIMISATION n�11
end;
//-----------------------------------------------------------------------------
procedure TSituation.AjouteResultat(Operation : TOperation); // Ici on transmet Operation, on ne le cl�ne pas, il l'a d�j� �t� dans TSituation.Cree(Operation)
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
// Comme Pr�c�dent mais �crit uniquement si l'aper�u n'a pas d�j� �t� �crit
// et renvoie alors True ; sinon, n'�crit rien et renvoie False.
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
if MeilleurResultat or // Soit on a trouv� mieux...
   (FormMain.ListBox.Items.IndexOf(stApercu)<0) then // Soit on a pas trouv� mieux mais on a pas d�j� trouv� cette solution
  begin
  if MeilleurResultat then // Si meilleur R�sultat, on stocke la nouvelle distance et on vide les solutions
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
// Crit�re n�1 : NbPlaquesUtilisees
// Crit�re n�2 : NbOperations
// Crit�re n�3 : ResultatMax
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
Result:=True; // Optimiste par d�faut !
Operande := Nombre[NumeroOperande];
case Operateur of
  oPlus:      if ContraireOperande then
                begin
                if Resultat<=Operande.Valeur then
                  begin // OPTIMISATION n�1 : Pas de diff�rence n�gative ou nulle
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
                begin // OPTIMISATION n�3 : Pas de multiplication/division par 1
                Result:=False;
                Exit;
                end;
             if ContraireOperande then
                begin
                if Resultat mod Operande.Valeur <> 0 then
                  begin // OPTIMISATION n�2 : Pas de division non enti�re
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
    IndexNombreDisponible    : array [TIndexNombreUtilisable] of TIndexNombreGenere; // OPTIMISATION n�13 : tableau statique
    NbNombresDisponibles     : TNbNombresUtilisables; // OPTIMISATION n�13 : tableau statique (compteur)
    Operation                : TOperation;
    Situation                : TSituation;
    OperandeResultatMemeType, // Indicateur d'op�rande r�sultat de m�me type d'op�ration (OPTIMISATION n�4)
    OperationImpossible,      // Indicateur d'op�ration impossible ou multiplication/division par 1 (OPTIMISATIONS n�1 � 3)
    OperandeEgalResultat,     // Indicateur d'existance d'un op�rande �gal au r�sultat (OPTIMISATION n�7)
    OperandesContraires,      // Indicateur d'existence d'op�randes contraires : oppos�s ou inverses (OPTIMISATION n�8)
    Contrariete              : Boolean;
    Resultat                 : TValeur;
begin
NbMaxOperandes:=CalculeNbMaxOperandes;
// 1. On d�termine les index des nombres disponibles dans le tableau Self.Nombre
NbNombresDisponibles:=0;
for IndexNombre:=Low(Nombre) to High(Nombre) do
  if not Nombre[IndexNombre].EstUtilise then
    begin
    IndexNombreDisponible[NbNombresDisponibles]:=IndexNombre;
    Inc(NbNombresDisponibles);
    end;
// 2. On choisit une op�ration � effectuer parmi les cas possibles
for NbOperandes := Low(TNbOperandes) to NbMaxOperandes do
  for Operateur := Low(TOperateur) to High(TOperateur) do
    for NumeroChoixOperandes := Low(TNumeroChoixOperandes) to NbChoixOperandes[NbOperandes, NbMaxOperandes]-1 do
      for NumeroChoixContrarietes := Low(TNumeroChoixContrarietes) to NbChoixContrarietes[NbOperandes]-2 do // OPTIMISATION n�5 : On ne peut avoir que des contraires donc il y a une possibilit� en moins : la derni�re !
        begin
        // 2.a On d�termine les index des op�randes choisis parmi la liste des nombres DISPONIBLES
        OperandeResultatMemeType:=False; // Initialisation de l'indicateur d'op�rande r�sultat de m�me type d'op�ration (OPTIMISATION n�4)
        OperationImpossible:=False; // Initialisation de l'indicateur d'op�ration impossible (OPTIMISATIONS n�1 � 3)
        OperandeEgalResultat:=False; // Initialisation de l'indicateur d'op�rande = R�sultat (OPTIMISATION n�7)
        OperandesContraires:=False; // Initialisation de l'indicateur d'op�randes contraires (OPTIMISATION n�8)
        if Operateur=oPlus then Resultat:=0 else Resultat:=1; // Initialisation du r�sultat de l'op�ration pour savoir si elle est possible
        for Contrariete:=False to True do // On teste d'abord les non contraires avant les contraire pour cumuler le r�sultat
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
                begin // OPTIMISATION n�4 : On n'utilise pas un r�sultat de m�me type d'op�ration comme op�rande
                OperandeResultatMemeType:=True;
                Break;
                end;
              end{if contrariete};
          if OperandeResultatMemeType or
             OperationImpossible then // Optimisations ne n�cessitant que toutes les op�randes soient d�finies dans NumeroOperande et ContraireOperande
            Break; // Op�rande non utilisable trouv� (OPTIMISATION n�4) ou op�ration impossible (OPTIMISATIONS n�1 � 3) alors on cherche d'autres possibilit�s...
          end{for Contrariete};
        if OperandeResultatMemeType or
           OperationImpossible then
          begin
          Inc(IA.NbCalculsEnvisages); // v1.2
          Continue
          end;
        // On teste chaque op�rande pour savoir s'il est �gal au r�sultat (OPTIMISATION n�7) : cela n�cessite que NumeroOperande et ContraireOperande soient d�finis enti�rement
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
        // On teste si deux op�randes contraires existent (OPTIMISATION n�8)
        if (Operateur=oPlus) or (NbOperandes>2) then // ATTENTION : on peut diviser un nombre par lui-m�me car a/a=1 est autoris� (si 2 op�randes seulement) contrairement � a-a=0.
          for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-2 do // OPTIMISATION n�14 : IndexOperande < IndexOperandeContraire
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
        // 2.b On cr�e une instance de la nouvelle op�ration
        Operation:=TOperation.Cree(Self, Operateur);
        // 2.c On ajoute les op�randes � la nouvelle op�ration (avec tri dans AjouteOperande)
        for IndexOperande:=Low(TIndexNombreUtilisable) to NbOperandes-1 do
         Operation.AjouteOperande(NumeroOperande[IndexOperande], ContraireOperande[IndexOperande], AjoutAvecTri);
        // 2.d On fait calculer le r�sultat en interne
        Operation.CalculeResultat;
        // � pr�sent les donn�es de la nouvelle situation sont : 1. NbMaxOperandes,
        //                                                       2. NbOperandes,
        //                                                       3. Operateur,
        //                                                       4. NumeroChoix,
        //                                                       5. NumeroOperande[0..NbOperandes]
        // On g�n�re la situation suivante et on poursuit la recherche...}
        Situation:=TSituation.Cree(Operation);
        if (Abs(Operation.Resultat-IA.Compte)<=IA.DistanceRecherche) and
           (Situation.NbResultatsInutilises=1) and // OPTIMISATION n�6 : On ne garde la solution que s'il ne reste aucun r�sultat (interm�diaire) inutilis�
           Situation.EcritApercuEnonceSiInexistant(Operation.Resultat) and
           ((Ord(SortieFichier) and Ord(sfEnProfondeur))>0) then
             Situation.EcritApercuProfondeur;
        // v1.2
        if not FormMain.MenuItemOptimisation5.Checked or // Si optimisation 5 non activ�e OU
           (Operation.Resultat<>IA.Compte) then // Le compte n'est pas trouv� ALORS (OPTIMISATION n�9. v1.2)
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
Self.RangComplexite:=0; // D�fini plus tard
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
Result:=Format( '%d Plaques, %d Lignes, R�sultat Max=%d. Rangs: Complexe=%d/%d, Chrono=%d/%d (%s), Alpha=%d/%d.',
                [ NbPlaques, NbLignesCalcul, ResultatIntermediaireMax,
                  RangComplexite, n,
                  RangChrono, n, FormatDateTime('s.zzz"s"', Temps),
                  FormMain.ListBox.ItemIndex+1, n])
end;
//-----------------------------------------------------------------------------
initialization
//-----------------------------------------------------------------------------
InitialiseRepLocalAppData; // v1.3 : stRepLocalAppData remplace ParamStr(0)
// Initialisation des optimisations param�trables (optimisation activ�e par d�faut)
OptimisationsCalcul:=[ ocPasDeMultiplicationDivisionPar1,
                       ocPasDeResultatMemeTypeOperande,
                       ocPasDeResultatEgalOperande,
                       ocPasDOperandesContraires];
Sortie:=sPartout; // Sortie Ecran+Fichier
SortieFichier:=sfTout; // Sortie Type �nonc� + En profondeur
OrdreChrono:=0;
TempsRecherche:=0;
NbCalculsEnvisages:=0; // v1.2
NiveauRecherche:=ndIndefini;
//-----------------------------------------------------------------------------
finalization
//-----------------------------------------------------------------------------
end.

