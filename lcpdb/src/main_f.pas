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
unit main_f;
//-----------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------
uses
//-----------------------------------------------------------------------------
  IA,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Menus, ImgList, IniFiles, Buttons,
  ToolWin, ActnList, System.Actions, System.ImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList;
//-----------------------------------------------------------------------------
const
//-----------------------------------------------------------------------------
  NbPlaquesSelectionnables   = 24;
  // ImageIndex pour l'arbre
  DiffIndexImageNbOperations =  4;
  DiffIndexImageNbPlaques    = -2;
  IndexImageResultatMax      = 10;
  IndexImageDrapeau          = 11;
  IndexImageSolution         = 13;
//-----------------------------------------------------------------------------
type
//-----------------------------------------------------------------------------
  TIndexPlaqueSelectionnable = 0..NbPlaquesSelectionnables-1;
  TPlaquesSelectionnables = array [TIndexPlaqueSelectionnable] of TValeur;
  TPlaquesSelectionnees = array [TIndexPlaqueSelectionnable] of Boolean;
//-----------------------------------------------------------------------------
// Types pour les statistiques
//-----------------------------------------------------------------------------
  TTypeValeurStatistiques           = ( tvsNombre,
                                        tvsNiveau,
                                        tvsApproche,
                                        tvsTemps,
                                        tvsAvecTempsLimite,
                                        tvsNbDecomptes, tvsNbSolutions, tvsRang); // v1.0.3
  TDetailStatistiques               = ( dsMachineRecherches,
                                        dsMachineTrouves,
                                        dsMachineApproches,
                                        dsHumainRecherches,
                                        dsHumainNonTermines,
                                        dsHumainNonClasses,
                                        dsHumainClasses,
                                        dsHumainClassesTrouves,
                                        dsHumainClassesApproches);

  TValeursStatistiques              = array [TDetailStatistiques] of Integer;
  TStrValeursStatistiques           = array [TDetailStatistiques] of String;
  TParametresTypeValeurStatistiques = array [TTypeValeurStatistiques] of String;
  TStatistiques = class
  private
    Nombre,
    Niveau,   // Cumul de niveaux : TNiveauDifficulte;
    Approche, // Cumul des approches : Distances au compte
    Temps,    // Cumul de dixièmes de secondes
    AvecTempsLimite, // Indique le nombre de recherches en temps limité
    NbDecomptes, NbSolutions, Rang : TValeursStatistiques; // v1.0.3 (nombre de solutions trouvées par recherche + rang de la solution saisie)
  public
    function stPourcent(const TypeValeur : TTypeValeurStatistiques;
                        const Detail     : TDetailStatistiques) : String;
    function stTemps(const Detail        : TDetailStatistiques) : String;
    function stValeur(const TypeValeur   : TTypeValeurStatistiques;
                      const Detail       : TDetailStatistiques) : String;
    function stDecompte(const Detail     : TDetailStatistiques) : String; // v1.0.3
    procedure GenerePageHTML;
    procedure Ajoute( const DetailHumain, DetailMachine : TDetailStatistiques;
                      const Niveau : TNiveauDifficulte;
                      const ApprocheHumain, ApprocheMachine,
                            TempsHumain, TempsMachine, AvecTempsLimite,
                            Rang, NbSolutions : Integer); // v1.0.3
    constructor Cree;
    destructor Detruit;
  end;
//-----------------------------------------------------------------------------
  TFormMain = class(TForm)
    ActionList: TActionList;
    ActionCompteNouveauTirerAuSort: TAction;
    ActionCompteNouveauProposer: TAction;
    ActionCompteCalculerSolutions: TAction;
    ActionCompteChercherSaisirSolution: TAction;
    ActionCompteQuitter: TAction;
    ActionAffichageTableau: TAction;
    ActionAffichageEffacerSolutions: TAction;
    ActionAffichageStatistiques: TAction;
    ActionParametresRetablirParametresDefaut: TAction;
    ActionInformationsAide: TAction;
    ActionInformationsAPropos: TAction;
    ActionArbreSolutionLaPlusSimple: TAction;
    ActionArbreSolutionLaPlusTordue: TAction;
    ActionArbreSolutionPrecedenteComplexite: TAction;
    ActionArbreSolutionSuivanteComplexite: TAction; // v1.2
    MainMenu: TMainMenu;
    PopupMenuArbre: TPopupMenu;
    PopupMenuListe: TPopupMenu;
    PopupMenuToolBar: TPopupMenu;
    MenuItemPartie: TMenuItem;
    MenuItemParametres: TMenuItem;
    MenuItemInfos: TMenuItem;
    MenuItemOptimisations: TMenuItem;
    MenuItemOptimisation1: TMenuItem;
    MenuItemOptimisation2: TMenuItem;
    MenuItemOptimisation3: TMenuItem;
    MenuItemOptimisation4: TMenuItem;
    MenuItemOptimisation5: TMenuItem; // v1.2
    MenuItemSorties: TMenuItem;
    MenuItemEcranTypeListe: TMenuItem;
    MenuItemEcranTypeArbre: TMenuItem;
    MenuItemSeparateur1: TMenuItem;
    MenuItemFichierTypeEnonce: TMenuItem;
    MenuItemFichierTypeProfondeur: TMenuItem;
    MenuItemAffichage: TMenuItem;
    MenuItemAffichageTableau: TMenuItem;
    MenuItemPaveNumerique: TMenuItem;
    MenuItemToutDevelopper: TMenuItem;
    MenuItemToutReduire: TMenuItem;
    MenuItemSolutionSuivanteComplexite: TMenuItem;
    MenuItemSeparateur2: TMenuItem;
    MenuItemSolutionPrecedenteComplexite: TMenuItem;
    MenuItemCompteNouveau: TMenuItem;
    MenuItemCompteNouveauTirerAuSort: TMenuItem;
    MenuItemCompteNouveauProposer: TMenuItem;
    MenuItemPremiereSolutionComplexite: TMenuItem;
    MenuItemDerniereSolutionComplexite: TMenuItem;
    MenuItemSeparateur3: TMenuItem;
    MenuItemPremiereSolutionChrono: TMenuItem;
    MenuItemDerniereSolutionChrono: TMenuItem;
    MenuItemSolutionPrecedenteChrono: TMenuItem;
    MenuItemSolutionSuivanteChrono: TMenuItem;
    MenuItemAfficherSolutionDansArbre: TMenuItem;
    MenuItemEntrees: TMenuItem;
    MenuItemCalculerResultat: TMenuItem;
    MenuItemRetourArriereAutorise: TMenuItem;
    MenuItemTempsReflexionSaisie: TMenuItem;
    MenuItemIllimite: TMenuItem;
    MenuItem3Minutes: TMenuItem;
    MenuItem2Minutes: TMenuItem;
    MenuItem1Minute: TMenuItem;
    MenuItem45Secondes: TMenuItem;
    MenuItem30Secondes: TMenuItem;
    MenuItemSeparateur4: TMenuItem;
    MenuItemRetablirParametreParDefaut: TMenuItem;
    MenuItemSeparateur5: TMenuItem;
    MenuItemCompteCalculerSolutions: TMenuItem;
    MenuItemCompteChercherSaisirSolution: TMenuItem;
    MenuItemSeparateur6: TMenuItem;
    MenuItemCompteQuitter: TMenuItem;
    MenuItemEntreeAfficherInfosOptimisationApresSaisie: TMenuItem;
    MenuItemSeparateur7: TMenuItem;
    MenuItemArreterSaisieFinTempsImparti: TMenuItem;
    MenuItemPropositionCompte: TMenuItem;
    MenuItemNombreLimiteExemplairesPlaques: TMenuItem;
    MenuItemSeparateur8: TMenuItem;
    MenuItemEffacerSolutions: TMenuItem;
    MenuItemAPropos: TMenuItem;
    MenuItemSeparateur9: TMenuItem;
    MenuItemAide: TMenuItem;
    MenuItemStatistiques: TMenuItem;
    MenuItemToolBarAfficherImagesMenuPrincipal: TMenuItem;
    MenuItemToolBarAfficherLibellesBoutons: TMenuItem;
    MenuItemSeparateurA: TMenuItem;
    MenuItemSaisieAutomatiqueCompteNouveau: TMenuItem; // v1.2
    ToolBar: TToolBar;
    ToolButtonCompteNouveauTireAuSort: TToolButton;
    ToolButtonCompteNouveauPropose: TToolButton;
    ToolButtonSeparateur1: TToolButton;
    ToolButtonCompteChercherSaisieSolution: TToolButton;
    ToolButtonCompteCalculerSolutions: TToolButton;
    ToolButtonSeparateur2: TToolButton;
    ToolButtonAffichageTableau: TToolButton;
    ToolButtonAffichageEffacerSolutions: TToolButton;
    ToolButtonSeparateur3: TToolButton;
    ToolButtonArbreSolutionLaPlusSimple: TToolButton;
    ToolButtonArbreSolutionLaPlusTordue: TToolButton;
    ToolButtonArbreSolutionPlusSimple: TToolButton;
    ToolButtonArbreSolutionPlusTordue: TToolButton;
    ToolButtonSeparateur4: TToolButton;
    ToolButtonAffichageStatistiques: TToolButton;
    ToolButtonInformationsAide: TToolButton;
    PanelResultats: TPanel;
    PanelNombres: TPanel;
    PanelInformations: TPanel;
    ListBox: TListBox;
    TreeView: TTreeView;
    MemoOptimisationsCalculSaisi: TMemo;
    SplitterV: TSplitter;
    SplitterH: TSplitter;
    Timer: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TimerAuto: TTimer;
    ActionSaisieAutomatique: TAction;
    MenuItemSaisieAutomatiqueParametres: TMenuItem;
    VirtualImageListArbre: TVirtualImageList;
    ImageCollection: TImageCollection;
    VirtualImageListBoutons: TVirtualImageList;
    StatusBar: TStatusBar;
    procedure TimerAutoTimer(Sender: TObject);
    procedure NettoieAffichage;
    procedure NettoieAffichageSaufMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionArbreSolutionSuivanteComplexiteExecute(Sender: TObject);
    procedure ActionArbreSolutionPrecedenteComplexiteExecute(Sender: TObject);
    procedure ActionAffichageStatistiquesExecute(Sender: TObject);
    procedure ActionInformationsAideExecute(Sender: TObject);
    procedure ActionArbreSolutionLaPlusTordueExecute(Sender: TObject);
    procedure ActionArbreSolutionLaPlusSimpleExecute(Sender: TObject);
    procedure ActionInformationsAProposExecute(Sender: TObject);
    procedure ActionAffichageEffacerSolutionsExecute(Sender: TObject);
    procedure ActionParametresRetablirParametresDefautExecute(Sender: TObject);
    procedure ActionCompteChercherSaisirSolutionExecute(Sender: TObject);
    procedure ActionCompteQuitterExecute(Sender: TObject);
    procedure ActionCompteCalculerSolutionsExecute(Sender: TObject);
    procedure ActionAffichageTableauExecute(Sender: TObject);
    procedure ActionCompteNouveauProposerExecute(Sender: TObject);
    procedure ActionCompteNouveauTirerAuSortExecute(Sender: TObject);
    procedure MenuItemToolBarAfficherClick(Sender: TObject);
    procedure MenuItemTempsReflexionSaisieClick(Sender: TObject);
    procedure MenuItemAutoCheckClick(Sender: TObject);
    procedure MenuItemPaveNumeriqueClick(Sender: TObject);
    procedure MenuItemToutDevelopperClick(Sender: TObject);
    procedure MenuItemToutReduireClick(Sender: TObject);
    procedure MenuItemDerniereSolutionComplexiteClick(Sender: TObject);
    procedure MenuItemPremiereSolutionChronoClick(Sender: TObject);
    procedure MenuItemSolutionPrecedenteChronoClick(Sender: TObject);
    procedure MenuItemSolutionSuivanteChronoClick(Sender: TObject);
    procedure MenuItemDerniereSolutionChronoClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    IniFile      : TIniFile;
    Statistiques : TStatistiques;
    function RecherchePossible : Boolean;
    function TableauAffichable : Boolean;
    procedure EffaceArbre;
    procedure AfficheStatistiqueSolution;
    procedure MontreSolutionOrdreChrono(const Ordre : Integer);
    procedure AfficheSolutionDansTableau;
  public
    TempsReflexionSaisie : Integer;
    procedure EffaceSolutions;
    procedure EffacePlaquesEtCompte;
    function CreeNoeudSiInexistant(const TreeNode : TTreeNode; const stIntitule : String; const Pluriel : Boolean; ImageIndex : Integer) : TTreeNode;
    procedure ChangeVisibiliteTableau(const RendreVisible : Boolean);
    procedure EnregistreParametres(const MenuItem : TMenuItem); overload; // v1.2 (overload)
    procedure EnregistreParametres(const PopupMenu : TPopupMenu); overload; // v1.2. Pour enregistrer les paramètres de l'aspect de la barre d'outils et des menus.
    procedure ChargeParametres(const MenuItem : TMenuItem); overload; // v1.2 (overload)
    procedure ChargeParametres(const PopupMenu : TPopupMenu); overload; // v1.2. Pour charger les paramètres de l'aspect de la barre d'outils et des menus.
    procedure EnregistreStatistiques;
    procedure ChargeStatistiques(var Statistiques : TStatistiques);
    procedure AjouteStatistiqueDetailHumain(const DetailHumain : TDetailStatistiques);
  end;
//-----------------------------------------------------------------------------
var
  TopChrono : TDateTime; // Top départ de la recherche des solutions par la machine
  FormMain  : TFormMain;
//-----------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------
uses StrUtils, ShellApi,
     tableau_f, pavenum_f, propos_f;
//-----------------------------------------------------------------------------
{$R *.dfm}
//-----------------------------------------------------------------------------
const
  PlaqueSelectionnable                  : TPlaquesSelectionnables
                                        = (1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,25,50,75,100);
  stNomFichierIni                       : string = 'lcpdb.ini'; // v1.3 : nom unique et non plus tiré du chemin+nom de l'exécutable (Application.ExeName)
  stHTMLEspaceInsecable                 : String = '&nbsp;';
  stFrmMoyenneEtPourcentage             : String = '%.1f';
  stSectionParametres                   : String = 'Paramètres';
  stSectionStatistiques                 : String = 'Statistiques';
  stAvertissementParametresIncorrects   : String = 'Les paramètres entrés sont incorrects : ils doivent être 7 nombres entiers strictements positifs.';
  stAvertissementParametresInsuffisants : String = 'Le nombre de paramètres est insuffisant : il faut préciser 6 plaques et un compte à trouver.';
  stParametrePrefixeStatistiques        : TParametresTypeValeurStatistiques
                                        = ( 'Nombre', 'Niveau', 'Approche', 'Temps', 'AvecTempsLimite',
                                            'NbDecomptes', 'NbSolutions', 'Rang'); // v1.0.3
  stParametreSuffixeStatistiques        : TStrValeursStatistiques
                                        = ( 'MachineRecherches',
                                            'MachineTrouves',
                                            'MachineApproches',
                                            'HumainRecherches',
                                            'HumainNonTermines',
                                            'HumainNonClasses',
                                            'HumainClasses',
                                            'HumainClassesTrouves',
                                            'HumainClassesApproches');
  stHTMLDebutStatistiques             : String =
'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
'<html><head><title>Aide - Le Compte Pour De Bon</title><meta content="Statistiques Le Compte Pour De Bon" name="description"><meta content="Statistiques, Le Compte Pour De Bon" name="keywords"></head>'#13+
'<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
'<center><h1>Statistiques - Le Compte Pour De Bon</h1>'#13+
'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
'<tr><td><p align="center">M/H </p></td><td>Statistique</td><td>Nombre</td><td>%</td><td>Niv.Moyen</td><td>Approche</td><td>Tps Moyen</td><td>% Tps Limité</td><td>Rang/Nb.Solutions</td></tr>'#13;
  stFrmHTMLLigneStatistiques          : TStrValeursStatistiques =
('<tr><td rowspan="3"><p align="center">Machine</p></td><td>Comptes Recherchés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td>'+'<td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;- </tt>dont Trouvés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;- </tt>dont Approchés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td rowspan="7"><p align="center">Humain</p></td><td>Comptes Recherchés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td>'+'<td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;- </tt>dont Non Terminés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;- </tt>dont Non Classés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;- </tt>dont Classés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;&nbsp;&nbsp;· </tt>dont Trouvés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13,
 '<tr><td><tt>&nbsp;&nbsp;&nbsp;· </tt>dont Approchés</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td><td align="right">%s</td></tr>'#13);
  stHTMLFinStatistiques               : String =
'</tbody></table><br></center>'#13+
'<b>Niveaux des comptes trouvés</b>&nbsp;: de 0 (très facile) à 8 (très difficile). 9 = Compte introuvable.<br>Calcul du niveau&nbsp;: Nombre de plaques utilisées + Nombre de lignes de calcul - 3 (en prenant la solution la plus simple).<br>'#13+
'<b>Temps</b>&nbsp;: Temps de recherche pour la machine et temps de saisie pour l''humain - Temps en secondes.<br>'#13+
'<b>Approche</b>&nbsp;: Distance entre le compte à trouver et le résultat final du calcul (différence en valeur absolue).<br>'#13+
'<b>Non Terminé</b>&nbsp;: Calcul non terminé à la fin du temps limité ou abandonné.<br>'#13+
'<b>Non Classé</b>&nbsp;: Calcul dont le résultat n''est pas le meilleur résultat possible (il y a mieux).<br>'#13+
'<b>Classé</b>&nbsp;: Calcul dont le résultat est le meilleur résultat possible (il n''y a pas mieux&nbsp;: compte trouvé comme approché).<br>'#13+
'Par conséquent, un calcul classé (après réduction et ordonnancement) est retrouvé parmi les résultats trouvés par la machine.<br>'#13+
'<b>Trouvé</b>&nbsp;: Calcul dont le résultat est le compte à trouver, de surcroît il s''agit d''un résultat classé.<br>'#13+
'<b>Approché</b>&nbsp;: Calcul dont le résultat n''est pas le compte à trouver mais est le meilleur résultat possible et donc classé.<br>'#13+
'<b>% Temps Limité</b>&nbsp;: Proportion de calculs saisis en temps limité.<br>'#13+
'<b>Rang/Nb.Solutions</b>&nbsp;: Nombre (moyen) de solutions trouvées par la machine par tirage. Sous forme de fraction : rang (moyen) de la solution saisie par rapport au nombre (moyen) de solutions trouvées.<br><br>'#13+ // v1.0.3
'<u>Note</u>&nbsp;: Les données "Temps" et "Niveaux" des "Comptes Recherchés" ne comptabilisent pas ceux des "Comptes Non terminés".'#13+
'</body></html>'#13;
//-----------------------------------------------------------------------------
// Méthodes de la classe TStatistiques
//-----------------------------------------------------------------------------
constructor TStatistiques.Cree;
begin
FormMain.ChargeStatistiques(Self);
end;
//-----------------------------------------------------------------------------
destructor TStatistiques.Detruit;
begin
FormMain.EnregistreStatistiques;
end;
//-----------------------------------------------------------------------------
function TStatistiques.stTemps(const Detail : TDetailStatistiques) : String;
begin
Result:=Format(stFrmMoyenneEtPourcentage, [0.0]); // Par défaut, on a rien
if Detail=dsHumainRecherches then
  begin // Le temps des Calculs Non Terminés ne sont pas comptés alors on retire le nombre de Calculs Non Terminés
  if (Nombre[Detail]-Nombre[dsHumainNonTermines])>0 then
    Result:=Format( stFrmMoyenneEtPourcentage,
                    [Temps[Detail]/(Nombre[Detail]-Nombre[dsHumainNonTermines])/10])
  end
else
  if (Nombre[Detail]>0) then 
    Result:=Format( stFrmMoyenneEtPourcentage,
                    [Temps[Detail]/Nombre[Detail]/10]);
if Result=Format(stFrmMoyenneEtPourcentage, [0.0]) then
  Result:=stHTMLEspaceInsecable; // On n'affiche pas de zéro, ça montre les cases affectées plus facilement
end;
//-----------------------------------------------------------------------------
function TStatistiques.stPourcent( const TypeValeur : TTypeValeurStatistiques;
                                   const Detail : TDetailStatistiques) : String;
begin
Result:=Format(stFrmMoyenneEtPourcentage, [0.0]); // Par défaut, on a rien
case TypeValeur of
  tvsNombre:          begin
                      if (Detail in [ dsMachineTrouves,
                                      dsMachineApproches]) and
                         (Nombre[dsMachineRecherches]>0) then
                        Result:=Format( stFrmMoyenneEtPourcentage,
                                        [100*Nombre[Detail]/Nombre[dsMachineRecherches]]);
                      if (Detail in [ dsHumainNonTermines,
                                      dsHumainNonClasses,
                                      dsHumainClasses]) and
                         (Nombre[dsHumainRecherches]>0) then
                        Result:=Format( stFrmMoyenneEtPourcentage,
                                        [100*Nombre[Detail]/Nombre[dsHumainRecherches]]);
                      if (Detail in [ dsHumainClassesTrouves,
                                      dsHumainClassesApproches]) and
                         (Nombre[dsHumainClasses]>0) then
                        Result:=Format( stFrmMoyenneEtPourcentage,
                                        [100*Nombre[Detail]/Nombre[dsHumainClasses]]);
                      end;
  tvsAvecTempsLimite: if Nombre[Detail]>0 then
                        Result:=Format( stFrmMoyenneEtPourcentage,
                                        [100*AvecTempsLimite[Detail]/Nombre[Detail]]);
end{case of};
if Result=Format(stFrmMoyenneEtPourcentage, [0.0]) then
  Result:=stHTMLEspaceInsecable; // On n'affiche pas de zéro, ça montre les cases affectées plus facilement
end;
//-----------------------------------------------------------------------------
function TStatistiques.stValeur( const TypeValeur : TTypeValeurStatistiques;
                                 const Detail     : TDetailStatistiques) : String;
begin
if TypeValeur=tvsNombre then
  begin
  Result:=IntToStr(Nombre[Detail]);
  if Result='0' then
    Result:=stHTMLEspaceInsecable; // On n'affiche pas de zéro, ça montre les cases affectées plus facilement
  end
else
  begin
  Result:=Format(stFrmMoyenneEtPourcentage, [0.0]); // Par défaut, on a rien
  if (Detail=dsHumainRecherches) and (TypeValeur=tvsApproche) then
    begin // L'approche des Calculs Non Terminés ne sont pas comptés (non sens) alors on retire le nombre de Calculs Non Terminés
    if (Nombre[Detail]-Nombre[dsHumainNonTermines])>0 then // ça évite de diviser par zéro !
      Result:=Format(stFrmMoyenneEtPourcentage, [Approche[Detail]/(Nombre[Detail]-Nombre[dsHumainNonTermines])]);
    end
  else
    if Nombre[Detail]>0 then // ça évite de diviser par zéro !
      case TypeValeur of
        tvsNiveau:          Result:=Format(stFrmMoyenneEtPourcentage, [Niveau[Detail]/Nombre[Detail]]);
        tvsApproche:        if Detail<>dsHumainNonTermines then // Pas de notion d'approche pour Non Terminés
                              Result:=Format(stFrmMoyenneEtPourcentage, [Approche[Detail]/Nombre[Detail]]);
        tvsAvecTempsLimite: Result:=Format(stFrmMoyenneEtPourcentage, [AvecTempsLimite[Detail]/Nombre[Detail]]);
      end{case of};
  if (Result=Format(stFrmMoyenneEtPourcentage, [0.0])) then
    Result:=stHTMLEspaceInsecable; // On n'affiche pas de zéro (sauf pour Approche car 0=Compte trouvé), ça montre les cases affectées plus facilement
  end
end;
//-----------------------------------------------------------------------------
function TStatistiques.stDecompte(const Detail : TDetailStatistiques) : String; // v1.0.3
begin
if Detail<dsHumainClasses then // On affiche que le nombre (moyen) de solutions
  begin
  if NbDecomptes[Detail]=0 then
    Result:=stHTMLEspaceInsecable // Division par zéro : On n'affiche rien
  else
    Result:=Format(stFrmMoyenneEtPourcentage, [NbSolutions[Detail]/NbDecomptes[Detail]]);
  end
else // On affiche ici le rang (moyen) / le nombre (moyen) de solutions
  begin
  if NbDecomptes[Detail]*Rang[Detail]=0 then
    Result:=stHTMLEspaceInsecable // Zéro ou Division par zéro : On n'affiche rien
  else
    Result:=Format(stFrmMoyenneEtPourcentage, [Rang[Detail]/NbDecomptes[Detail]])+'/'+Format(stFrmMoyenneEtPourcentage, [NbSolutions[Detail]/NbDecomptes[Detail]]);
  end;
if (Result=Format(stFrmMoyenneEtPourcentage, [0.0])) then
  Result:=stHTMLEspaceInsecable; // On n'affiche pas de zéro
end;
//-----------------------------------------------------------------------------
procedure TStatistiques.GenerePageHTML;
var F : TextFile;
    d : TDetailStatistiques; 
begin
try
  AssignFile(F, stRepLocalAppData+'Statistiques.html'); // v1.3 : stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
  Rewrite(F);
  Write(f, stHTMLDebutStatistiques);
  for d:=Low(TDetailStatistiques) to High(TDetailStatistiques) do
    Write(f, Format(stFrmHTMLLigneStatistiques[d], [ stValeur(tvsNombre, d),
                                                     stPourcent(tvsNombre, d),
                                                     stValeur(tvsNiveau, d),
                                                     stValeur(tvsApproche, d),
                                                     stTemps(d),
                                                     stPourcent(tvsAvecTempsLimite, d),
                                                     stDecompte(d)])); // v1.0.3
  Write(f, stHTMLFinStatistiques);
finally
  CloseFile(F);
end{try};
end;
//-----------------------------------------------------------------------------
procedure TStatistiques.Ajoute( const DetailHumain, DetailMachine : TDetailStatistiques;
                                const Niveau : TNiveauDifficulte;
                                const ApprocheHumain, ApprocheMachine,
                                      TempsHumain, TempsMachine, AvecTempsLimite,
                                      Rang, NbSolutions : Integer); // v1.0.3
begin
// Statistiques Machine
Inc(self.Nombre[DetailMachine]);
Inc(self.Niveau[DetailMachine], Niveau);
Inc(self.Approche[DetailMachine], ApprocheMachine);
Inc(self.Temps[DetailMachine], TempsMachine);
Inc(self.NbDecomptes[DetailMachine]); // v1.0.3
Inc(self.NbSolutions[DetailMachine], NbSolutions); // v1.0.3
case DetailMachine of
  dsMachineTrouves,
  dsMachineApproches: begin // Groupe des détails Machine
                      Inc(self.Nombre[dsMachineRecherches]);
                      Inc(self.Niveau[dsMachineRecherches], Niveau);
                      Inc(self.Approche[dsMachineRecherches], ApprocheMachine);
                      Inc(self.Temps[dsMachineRecherches], TempsMachine);
                      Inc(self.NbDecomptes[dsMachineRecherches]); // v1.0.3
                      Inc(self.NbSolutions[dsMachineRecherches], NbSolutions); // v1.0.3
                      end;
end;
// Statistiques Humain
Inc(self.Nombre[DetailHumain]);
Inc(self.Niveau[DetailHumain], Niveau);
Inc(self.Approche[DetailHumain], ApprocheHumain);
Inc(self.Temps[DetailHumain], TempsHumain);
Inc(self.AvecTempsLimite[DetailHumain], AvecTempsLimite);
Inc(self.NbDecomptes[DetailHumain]); // v1.0.3
Inc(self.NbSolutions[DetailHumain], NbSolutions); // v1.0.3
Inc(self.Rang[DetailHumain], Rang); // v1.0.3
case DetailHumain of
 // dsHumainRecherches:
  dsHumainNonTermines:      begin // On ne compte pas le temps et l'approche (pas de sens)
                            Inc(self.Nombre[dsHumainRecherches]);
                            Inc(self.Niveau[dsHumainRecherches], Niveau);
                            Inc(self.AvecTempsLimite[dsHumainRecherches], AvecTempsLimite);
                            Inc(self.NbDecomptes[dsHumainRecherches]); // v1.0.3
                            Inc(self.NbSolutions[dsHumainRecherches], NbSolutions); // v1.0.3
                            Inc(self.Rang[dsHumainRecherches], Rang); // v1.0.3
                            end;
  dsHumainNonClasses,
  dsHumainClasses,
  dsHumainClassesTrouves,
  dsHumainClassesApproches: begin // Groupe des détails Humain
                            Inc(self.Nombre[dsHumainRecherches]);
                            Inc(self.Niveau[dsHumainRecherches], Niveau);
                            Inc(self.Approche[dsHumainRecherches], ApprocheHumain);
                            Inc(self.Temps[dsHumainRecherches], TempsHumain);
                            Inc(self.AvecTempsLimite[dsHumainRecherches], AvecTempsLimite);
                            Inc(self.NbDecomptes[dsHumainRecherches]); // v1.0.3
                            Inc(self.NbSolutions[dsHumainRecherches], NbSolutions); // v1.0.3
                            Inc(self.Rang[dsHumainRecherches], Rang); // v1.0.3
                            if DetailHumain in [dsHumainClassesTrouves, dsHumainClassesApproches] then
                              begin // Sous-groupe des détails de Calculs Classés
                              Inc(self.Nombre[dsHumainClasses]);
                              Inc(self.Niveau[dsHumainClasses], Niveau);
                              Inc(self.Approche[dsHumainClasses], ApprocheHumain);
                              Inc(self.Temps[dsHumainClasses], TempsHumain);
                              Inc(self.AvecTempsLimite[dsHumainClasses], AvecTempsLimite);
                              Inc(self.NbDecomptes[dsHumainClasses]); // v1.0.3
                              Inc(self.NbSolutions[dsHumainClasses], NbSolutions); // v1.0.3
                              Inc(self.Rang[dsHumainClasses], Rang); // v1.0.3
                              end;
                            end;
  end{case of};
GenerePageHTML;
end;
//-----------------------------------------------------------------------------
// Méthodes de la classe TFormMain
//-----------------------------------------------------------------------------
procedure TFormMain.NettoieAffichage;
begin
// Nettoyage (listes, arbres, mémos)
EffaceSolutions;
TreeView.Repaint;
ListBox.Repaint;
with MemoOptimisationsCalculSaisi do
  begin
  Clear;
  Repaint;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.NettoieAffichageSaufMemo;
begin
// Nettoyage (listes, arbres, mémos)
EffaceSolutions;
TreeView.Repaint;
ListBox.Repaint;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.FormShow(Sender: TObject);
var i : Integer;
begin
// Lecture des paramètres
if ParamCount=0 then
  begin
  // Splash
  ActionInformationsAPropos.Execute;
  Exit;
  end;
try
  if ParamCount>6 then
    begin
    for i:=1 to NbMaxPlaques+1 do
      (FindComponent(stLabel+IntToStr(i)) as TLabel).Caption:=ParamStr(i);
    IA.Compte:=StrToInt(Label7.Caption);
    with FormTableau do // v1.0.6
      if Visible then
        begin
        InitialiseSaisieCalcul;
        Repaint;
        LanceChrono;
        SetFocus;
        end
      else // v1.0.6
        TimerAuto.Enabled:=True; // Permet d'activer le tableau. Impossible dans OnShow
    end
  else
    MessageDlgPos( stAvertissementParametresInsuffisants,
                   mtWarning, [mbOK], 0,
                   Left, Top+Height div 2);
except
  on E:Exception do
    MessageDlgPos( stAvertissementParametresIncorrects,
                   mtWarning, [mbOK], 0,
                   Left, Top+Height div 2);
end{try};
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EffaceArbre;
var i : Integer;
begin
with TreeView do
  begin
  for i:=0 to Items.Count-1 do
    if Items[i].Data<>Nil then TStatSolution(Items[i].Data).Detruit;
  Items.Clear;
  if (Ord(SortieEcran) and Ord(seTypeArbre))>0 then
    begin
    TreeView.Items.Add(nil, '');
    TreeView.Items[0].ImageIndex:=-1;
    TreeView.Items[0].SelectedIndex:=-1;
    end;
  end;
end;
//-----------------------------------------------------------------------------
function TFormMain.CreeNoeudSiInexistant(const TreeNode : TTreeNode; const stIntitule : String; const Pluriel : Boolean; ImageIndex : Integer) : TTreeNode;
var Comp, iInf, iSup, iMil : Integer;
    stNvIntitule           : String;
begin
if Pluriel then stNvIntitule:=stIntitule+'s (0)' else stNvIntitule:=stIntitule+' (0)';
Result:=nil; Comp:=-1; iMil:=0;
if TreeNode.Count>0 then
  begin
  iInf:=0; iSup:=TreeNode.Count-1;
  iMil:=(iInf+iSup) div 2;
  Comp:=Ord(stNvIntitule>TreeNode[iMil].Text)-Ord(stNvIntitule<TreeNode[iMil].Text);
  while (Comp<>0) and (iSup>iInf) do
    begin
    if iSup-iInf=1 then
      case Comp of
        1: iInf:=iSup;
       -1: iSup:=iInf;
      end
    else
      if Comp<0 then
        iSup:=iMil
      else
        iInf:=iMil;
    iMil:=(iInf+iSup) div 2;
    Comp:=Ord(stNvIntitule>TreeNode[iMil].Text)-Ord(stNvIntitule<TreeNode[iMil].Text);
    end;
  end;
if TreeNode.Count=0 then
  Result:=TreeView.Items.AddChild(TreeNode, stNvIntitule)
else
  case Comp of
   -1: Result:=TreeView.Items.Insert(TreeNode[iMil], stNvIntitule);
    0: Result:=TreeNode[iMil];
    1: Result:=TreeView.Items.Add(TreeNode[iMil], stNvIntitule);
  end;
Result.ImageIndex:=ImageIndex;
Result.SelectedIndex:=ImageIndex;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.AfficheSolutionDansTableau;
begin
with FormTableau do
  begin
  EtatTableau:=etAffichageSolution;
  if Visible then Repaint
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ListBoxClick(Sender: TObject);
begin
StatusBar.SimpleText:=IA.stConclusion+IA.stNbSolutionsTempsEcoule;
AfficheSolutionDansTableau;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.TreeViewChange(Sender: TObject; Node: TTreeNode);
var Index : Integer;
begin
if TreeView.Selected<>nil then
  begin
  with ListBox do
    begin
    Index:=Items.IndexOf(TreeView.Selected.Text);
    if Index>-1 then
      begin
      ItemIndex:=Index;
      AfficheSolutionDansTableau;
      end{if Index}
    end{with};
  AfficheStatistiqueSolution
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemAutoCheckClick(Sender: TObject);
begin
// AutoCheck = True : Ne pas supprimer le commentaire. Référencé aussi par ActionSaisieAutomatique.OnExecute. v1.2
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ChangeVisibiliteTableau(const RendreVisible : Boolean);
begin
FormTableau.Visible:=RendreVisible;
if not RendreVisible then // Abandonne la saisie mais n'affiche pas la solution. v1.2
 with FormTableau do
   begin
   InitialiseSaisieCalcul;
   ArreteSaisieCalcul(esTableauCache); // Paramètre spécial évitant d'afficher la solution.
   end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemPaveNumeriqueClick(Sender: TObject);
begin
FormPaveNumerique.Visible:=not (Sender as TMenuItem).Checked;
end;
//-----------------------------------------------------------------------------
function TFormMain.RecherchePossible : Boolean;
var i           : Integer;
    LabelNombre : TLabel;
begin
Result:=False; // Pessimiste
try
  for i:=1 to NbMaxPlaques+1 do
    begin
    LabelNombre:=FindComponent('Label'+IntToStr(i)) as TLabel;
    if (LabelNombre.Caption='') or (StrToInt(LabelNombre.Caption)<=0) then
      begin
      MessageDlgPos( Format( IfThen(i<NbMaxPlaques+1,'La plaque n°%d','Le compte')+' doit avoir une valeur supérieure à 0.',
                             [i]),
                     mtWarning, [mbOK], 0,
                     Left, Top+Height div 2);
      Exit;
      end
    else
      if (i<NbMaxPlaques+1) and (Label7.Caption<>'') and (StrToInt(LabelNombre.Caption)=StrToInt(Label7.Caption)) then
        begin
        MessageDlgPos( 'Aucune plaque ne doit être égale au compte à trouver',
                       mtWarning, [mbOK], 0,
                       Left, Top+Height div 2);
        Exit;
        end
    end;
  Result:=True;
except
  on E:Exception do
    MessageDlgPos( stAvertissementParametresIncorrects,
                   mtWarning, [mbOK], 0,
                   Left, Top+Height div 2);
end{try};
end;
//-----------------------------------------------------------------------------
function TFormMain.TableauAffichable : Boolean;
var i           : Integer;
    LabelPlaque : TLabel;
begin
Result:=False; // Pessimiste
try
  for i:=1 to NbMaxPlaques do
    begin
    LabelPlaque:=FindComponent('Label'+IntToStr(i)) as TLabel;
    if LabelPlaque.Caption='' then
      begin
      MessageDlgPos( Format( 'La plaque n°%d est indéfinie. Elle doit être comprise entre 1 et 10 ou être égale à 25, 50, 75 ou 100.',
                          [i]),
                     mtWarning, [mbOK], 0,
                     Left, Top+Height div 2);
      Exit;
      end;
    case StrToInt(LabelPlaque.Caption) of
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 75, 100: begin end;
    else
      begin
      MessageDlgPos( Format( 'La plaque n°%d a une valeur incorrecte. Elle doit être comprise entre 1 et 10 ou être égale à 25, 50, 75 ou 100.',
                             [i]),
                     mtWarning, [mbOK], 0,
                     Left, Top+Height div 2);
      Exit;
      end{else}
    end{case of}
    end{for};
  if (Label7.Caption='') or (StrToInt(Label7.Caption)<101) or (StrToInt(Label7.Caption)>999) then
    begin
    MessageDlgPos( 'Le compte à trouver est indéfini ou incorrect. Il doit être compris entre 101 et 999.',
                   mtWarning, [mbOK], 0,
                   Left, Top+Height div 2);
    Exit;
    end;
  Result:=True;
except
  on E:Exception do
    MessageDlgPos( stAvertissementParametresIncorrects,
                   mtWarning, [mbOK], 0,
                   Left, Top+Height div 2);
end{try};
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ListBoxDblClick(Sender: TObject);
begin
if ListBox.ItemIndex=-1 then Exit;
if (Ord(IA.SortieEcran) and Ord(seTypeArbre))>0 then
  begin
  with ListBox do
    (Items.Objects[ItemIndex] as TTreeNode).Selected:=True;
  AfficheStatistiqueSolution
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemToutDevelopperClick(Sender: TObject);
begin
with TreeView do
  if Selected<>nil then Selected.Expand(True);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemToutReduireClick(Sender: TObject);
begin
with TreeView do
  if Selected<>nil then Selected.Collapse(True);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemDerniereSolutionComplexiteClick(Sender: TObject);
begin
end;
//-----------------------------------------------------------------------------
procedure TFormMain.TimerTimer(Sender: TObject);
begin
Randomize;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.FormDestroy(Sender: TObject);
begin
Statistiques.Detruit;
EnregistreParametres(MenuItemParametres);
EnregistreParametres(PopupMenuToolBar); // v1.2
IniFile.Destroy;
EffaceArbre; // Permet de détruire les instances de TStatSolution le cas échéant
end;
//-----------------------------------------------------------------------------
procedure TFormMain.AfficheStatistiqueSolution;
begin
if (TreeView.Selected<>nil) and
   (TreeView.Selected.Data<>nil) then
  StatusBar.SimpleText:=TStatSolution(TreeView.Selected.Data).stApercu
else
  StatusBar.SimpleText:=IA.stConclusion+IA.stNbSolutionsTempsEcoule;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EffaceSolutions;
begin
StatusBar.SimpleText:='';
EffaceArbre;
ListBox.Clear;
IA.OrdreChrono:=0; // On repart à zéro dans les ordres chronologiques
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EffacePlaquesEtCompte;
var i : Integer;
begin
for i:=1 to NbMaxPlaques+1 do
  (FormMain.FindComponent('Label'+IntToStr(i)) as TLabel).Caption:='';
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MontreSolutionOrdreChrono(const Ordre : Integer);
var i : Integer;
begin
with TreeView.Items do
  for i:=0 to Count-1 do
    if (Item[i].Data<>nil) and
       ((TStatSolution(Item[i].Data)).RangChrono=Ordre) then
      begin
      Item[i].Selected:=True;
      Break;
      end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemPremiereSolutionChronoClick(Sender: TObject);
begin
if TreeView.Items.Count>0 then
  MontreSolutionOrdreChrono(1);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemDerniereSolutionChronoClick(Sender: TObject);
begin
if TreeView.Items.Count>0 then
  MontreSolutionOrdreChrono(ListBox.Items.Count);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemSolutionPrecedenteChronoClick(Sender: TObject);
begin
if (TreeView.Items.Count>0) and
   (TreeView.Selected<>nil) then
  begin
  if TreeView.Selected.Data=nil then
    ActionArbreSolutionSuivanteComplexiteExecute(MenuItemSolutionSuivanteComplexite);
  MontreSolutionOrdreChrono(TStatSolution(TreeView.Selected.Data).RangChrono-1);
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemSolutionSuivanteChronoClick(Sender: TObject);
begin
if (TreeView.Items.Count>0) and
   (TreeView.Selected<>nil) then
  begin
  if TreeView.Selected.Data=nil then
    ActionArbreSolutionSuivanteComplexiteExecute(MenuItemSolutionSuivanteComplexite);
  MontreSolutionOrdreChrono(TStatSolution(TreeView.Selected.Data).RangChrono+1);
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemTempsReflexionSaisieClick(Sender: TObject);
var MenuItem : TMenuItem;
begin
MenuItem:=Sender as TMenuItem;
TempsReflexionSaisie:=MenuItem.Tag;
MenuItem.Checked:=True;
if (FormTableau<>nil) and
   FormTableau.Visible then
  FormTableau.LanceChrono;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.FormCreate(Sender: TObject);
begin
// Paramètres Séparateurs France 
FormatSettings.DecimalSeparator:=',';
FormatSettings.ThousandSeparator:=' ';
TempsReflexionSaisie:=0;
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.3 : nom unique et non plus tiré du chemin+nom de l'exécutable (Application.ExeName));
ChargeParametres(MenuItemParametres);
ChargeParametres(PopupMenuToolBar); // v1.2
Statistiques:=TStatistiques.Cree;
Application.ShowHint:=True; // v1.2
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EnregistreParametres(const MenuItem : TMenuItem);
var i : Integer;
begin
with MenuItem do
  for i:=0 to Count-1 do
    if Items[i].Count>0 then
      EnregistreParametres(Items[i])
    else
      if Items[i].Caption<>'-' then
        IniFile.WriteBool( stSectionParametres,
                           copy(Items[i].Name, 9, Length(Items[i].Name)-8),
                           Items[i].Checked);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EnregistreParametres(const PopupMenu : TPopupMenu);
var i : Integer;
begin
with PopupMenu do
  for i:=0 to Items.Count-1 do
    if Items[i].Caption<>'-' then
      IniFile.WriteBool( stSectionParametres,
                         copy(Items[i].Name, 9, Length(Items[i].Name)-8),
                         Items[i].Checked);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ChargeParametres(const MenuItem : TMenuItem);
var i : Integer;
begin
with MenuItem do
  for i:=0 to Count-1 do
    if Items[i].Count>0 then
      ChargeParametres(Items[i])
    else
      if Items[i].Caption<>'-' then
        begin
        Items[i].Checked:=IniFile.ReadBool( stSectionParametres,
                                            copy(Items[i].Name, 9, Length(Items[i].Name)-8),
                                            Items[i].Checked);
        if (MenuItem=MenuItemTempsReflexionSaisie) and
           Items[i].Checked then
          MenuItemTempsReflexionSaisieClick(Items[i]);
        if Items[i]=MenuItemSaisieAutomatiqueParametres then // v1.2
          ActionSaisieAutomatique.Checked:=MenuItemSaisieAutomatiqueParametres.Checked;
        end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ChargeParametres(const PopupMenu : TPopupMenu);
var i : Integer;
begin
with PopupMenu do
  for i:=0 to Items.Count-1 do
    if Items[i].Caption<>'-' then
      begin
      Items[i].Checked:=IniFile.ReadBool( stSectionParametres,
                                          copy(Items[i].Name, 9, Length(Items[i].Name)-8),
                                          Items[i].Checked);
      if ((Items[i]=MenuItemToolBarAfficherImagesMenuPrincipal) or
          (Items[i]=MenuItemToolBarAfficherLibellesBoutons)) and
         Items[i].Checked then
        MenuItemToolBarAfficherClick(Items[i]);
      end;  
end;
//-----------------------------------------------------------------------------
procedure TFormMain.EnregistreStatistiques;
var d : TDetailStatistiques;
    tv : TTypeValeurStatistiques;
begin
for d:=Low(TDetailStatistiques) to High(TDetailStatistiques) do
  for tv:=Low(TTypeValeurStatistiques) to High(TTypeValeurStatistiques) do
    case tv of
      tvsNombre:          IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.Nombre[d]);
      tvsNiveau:          IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.Niveau[d]);
      tvsApproche:        IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.Approche[d]);
      tvsTemps:           IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.Temps[d]);
      tvsAvecTempsLimite: IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.AvecTempsLimite[d]);
      tvsNbDecomptes:     IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.NbDecomptes[d]); // v1.0.3
      tvsNbSolutions:     IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.NbSolutions[d]); // v1.0.3
      tvsRang:            IniFile.WriteInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], Statistiques.Rang[d]);        // v1.0.3
    end{case of};
Statistiques.GenerePageHTML;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ChargeStatistiques(var Statistiques : TStatistiques);
var d : TDetailStatistiques;
    tv : TTypeValeurStatistiques;
begin
for d:=Low(TDetailStatistiques) to High(TDetailStatistiques) do
  for tv:=Low(TTypeValeurStatistiques) to High(TTypeValeurStatistiques) do
    case tv of
      tvsNombre:          Statistiques.Nombre[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);
      tvsNiveau:          Statistiques.Niveau[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);
      tvsApproche:        Statistiques.Approche[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);
      tvsTemps:           Statistiques.Temps[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);
      tvsAvecTempsLimite: Statistiques.AvecTempsLimite[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);
      tvsNbDecomptes:     Statistiques.NbDecomptes[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0); // v1.0.3
      tvsNbSolutions:     Statistiques.NbSolutions[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0); // v1.0.3
      tvsRang:            Statistiques.Rang[d]:=IniFile.ReadInteger(stSectionStatistiques, stParametrePrefixeStatistiques[tv]+stParametreSuffixeStatistiques[d], 0);        // v1.0.3
    end{case of};
end;
//-----------------------------------------------------------------------------
procedure TFormMain.AjouteStatistiqueDetailHumain(const DetailHumain : TDetailStatistiques);
var DetailMachine : TDetailStatistiques;
    Rang, NbSolutions : Integer;
begin
if IA.DistanceRecherche=0 then
  DetailMachine:=dsMachineTrouves
else
  DetailMachine:=dsMachineApproches;
if (ListBox.Items.Count>0) and
   (TreeView.Selected<>nil) and
   (TreeView.Selected.Data<>nil) then
  begin
  Rang:=TStatSolution(TreeView.Selected.Data).RangComplexite;
  NbSolutions:=ListBox.Items.Count;
  end
else
  begin
  Rang:=0;
  NbSolutions:=ListBox.Items.Count;
  end;
Statistiques.Ajoute( DetailHumain, DetailMachine,
                     IA.NiveauRecherche,
                     FormTableau.DistanceSaisie, IA.DistanceRecherche,
                     FormTableau.TempsSaisie, Round(864000*IA.TempsRecherche),
                     Ord(not MenuItemIllimite.Checked),
                     Rang, NbSolutions);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionCompteNouveauTirerAuSortExecute(Sender: TObject);
var PlaqueChoisie : TPlaquesSelectionnees;
    i, x : Integer;
begin
EffaceSolutions;
for i:=Low(TIndexPlaqueSelectionnable) to High(TIndexPlaqueSelectionnable) do
  PlaqueChoisie[i]:=False;
IA.Compte:=101+Random(899);
for i:=1 to NbMaxPlaques do
  begin
  repeat
    x:=Random(NbPlaquesSelectionnables);
  until not PlaqueChoisie[x];
  PlaqueChoisie[x]:=True;
  (FindComponent('Label'+IntToStr(i)) as TLabel).Caption:=IntToStr(PlaqueSelectionnable[x]);
  end;
Label7.Caption:=IntToStr(IA.Compte);
if ActionSaisieAutomatique.Checked then // v1.2
  with FormTableau do
    if Visible then
      begin
      InitialiseSaisieCalcul;
      Repaint;
      LanceChrono;
      SetFocus;
      end
    else // v1.0.6
      ActionAffichageTableau.Execute;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionCompteNouveauProposerExecute(Sender: TObject);
begin
FormPaveNumerique:=TFormPaveNumerique.Create(Self);
with FormPaveNumerique do
  try
    if ShowModal=mrOk then // v1.0.6
      if ActionSaisieAutomatique.Checked then // v1.2
        with FormTableau do
          if Visible then
            begin
            InitialiseSaisieCalcul;
            Repaint;
            LanceChrono;
            SetFocus;
            end
          else
            ActionAffichageTableau.Execute;
  finally
    Release;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionAffichageTableauExecute(Sender: TObject);
begin
with MenuItemAffichageTableau do
  begin
  if not Checked and not TableauAffichable then Exit;
  ChangeVisibiliteTableau(not Checked);
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionCompteCalculerSolutionsExecute(Sender: TObject);
var Valeur : TValeur;
    i      : Integer;
    s      : TSituation;
    TreeNode : TTreeNode;
begin
// On rafraîchit le tableau le cas échéant (mais les plaques et comptes doivent être corrects c'est-à-dire affichables)
if not RecherchePossible then Exit;

// On inhibe les boutons le temps du calcul
ActionCompteCalculerSolutions.Enabled:=False;
ActionCompteChercherSaisirSolution.Enabled:=False;

// Type de sortie
IA.Sortie:=TSortie(  Ord(MenuItemEcranTypeListe.Checked or MenuItemEcranTypeArbre.Checked)+
                   2*Ord(MenuItemFichierTypeEnonce.Checked or MenuItemFichierTypeProfondeur.Checked));
if (Ord(IA.Sortie) and Ord(sFichier))>0 then
  IA.SortieFichier:=TSortieFichier(  Ord(MenuItemFichierTypeEnonce.Checked)+
                                   2*Ord(MenuItemFichierTypeProfondeur.Checked))
else
  IA.SortieFichier:=sfAucun;
if (Ord(IA.Sortie) and Ord(sEcran))>0 then
  IA.SortieEcran:=TSortieEcran(  Ord(MenuItemEcranTypeListe.Checked)+
                               2*Ord(MenuItemEcranTypeArbre.Checked))
else
  IA.SortieEcran:=seAucun;

// Nettoyage
NettoieAffichageSaufMemo;
// On déclenche le chrono
main_f.TopChrono:=Now;

// Paramétrage des optimisations demandées
IA.OptimisationsCalcul:=[];
if MenuItemOptimisation1.Checked then IA.OptimisationsCalcul:=IA.OptimisationsCalcul+[ocPasDeMultiplicationDivisionPar1];
if MenuItemOptimisation2.Checked then IA.OptimisationsCalcul:=IA.OptimisationsCalcul+[ocPasDeResultatMemeTypeOperande];
if MenuItemOptimisation3.Checked then IA.OptimisationsCalcul:=IA.OptimisationsCalcul+[ocPasDeResultatEgalOperande];
if MenuItemOptimisation4.Checked then IA.OptimisationsCalcul:=IA.OptimisationsCalcul+[ocPasDOperandesContraires];
if MenuItemOptimisation5.Checked then IA.OptimisationsCalcul:=IA.OptimisationsCalcul+[ocPasDeResultatEgalCompte]; // v1.2

// Création de l'instance de classe de recherche
IA.DistanceRecherche:=$7FFFFFFF;
IA.NbCalculsEnvisages:=0; // v1.2
s := TSituation.Cree;
try
  for i:=1 to NbMaxPlaques do
    if FindComponent('Label'+IntToStr(i)) is TLabel then
      begin
      Valeur:=StrToInt((FindComponent('Label'+IntToStr(i)) as TLabel).Caption); // OPTIMISATION n°10 : StrToInt au lieu de StrToInt64
      if Valeur > 0 then s.AjouteNombre(Valeur);
      end;
  if (Ord(IA.Sortie) and Ord(sFichier)>0) then IA.InitialiseSortie;
  s.Cherche;
  if (Ord(IA.Sortie) and Ord(sEcran)>0) and
     (Ord(IA.SortieEcran) and Ord(seTypeArbre)>0) then
    with TreeView do
      begin
      TreeNode:=Items[0];
      for i:=1 to ListBox.Count do
        begin
        if not TreeNode.HasChildren then
          if TreeNode.Parent.GetNextChild(TreeNode)<>nil then
            TreeNode:=TreeNode.Parent.GetNextChild(TreeNode)
          else
            begin
            repeat
              TreeNode:=TreeNode.Parent; // On remonte jusqu'à ce qu'il y en ait un ou plus de parent
            until (TreeNode.Parent.GetNextChild(TreeNode)<>nil) or
                  (TreeNode.Parent=nil);
            if TreeNode.Parent<>nil then
              TreeNode:=TreeNode.Parent.GetNextChild(TreeNode);
            end{else};
        if TreeNode.HasChildren then
          repeat
            TreeNode:=TreeNode.getFirstChild;
          until not TreeNode.HasChildren;
        TStatSolution(TreeNode.Data).RangComplexite:=i;
        end
      end;
finally
  s.Detruit;
  IA.FinaliseSortie(Now-main_f.TopChrono);
  ActionCompteCalculerSolutions.Enabled:=True;
  ActionCompteChercherSaisirSolution.Enabled:=True;
end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionCompteQuitterExecute(Sender: TObject);
begin
Close;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionCompteChercherSaisirSolutionExecute(Sender: TObject);
begin
with FormTableau do
  begin
  Hide;
  ListBox.ItemIndex:=-1;
  TreeView.Selected:=Nil;
  EtatTableau:=etAttenteSaisie;
  ActionAffichageTableau.Execute;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionParametresRetablirParametresDefautExecute(Sender: TObject);
begin
if MessageDlgPos('Êtes-vous sûr(e) de vouloir rétablir tous les paramètres par défaut ?',
                  mtConfirmation, [mbYes, mbNo], 0,
                  Left, Top+Height div 2)=mrNo then Exit;

MenuItemOptimisation1.Checked:=True;
MenuItemOptimisation2.Checked:=True;
MenuItemOptimisation3.Checked:=True;
MenuItemOptimisation4.Checked:=True;
MenuItemOptimisation5.Checked:=True; // v1.2

MenuItemNombreLimiteExemplairesPlaques.Checked:=True;

MenuItemCalculerResultat.Checked:=True;
MenuItemRetourArriereAutorise.Checked:=True;
MenuItem45Secondes.Checked:=True;
MenuItemArreterSaisieFinTempsImparti.Checked:=True;

MenuItemEcranTypeListe.Checked:=True;
MenuItemEcranTypeArbre.Checked:=True;
MenuItemFichierTypeEnonce.Checked:=False;
MenuItemFichierTypeProfondeur.Checked:=False;
MenuItemEntreeAfficherInfosOptimisationApresSaisie.Checked:=True;

ActionSaisieAutomatique.Checked:=True; // v1.2

MenuItemToolBarAfficherImagesMenuPrincipal.Checked:=False; // v1.2
MenuItemToolBarAfficherLibellesBoutons.Checked:=False; // v1.2
MenuItemToolBarAfficherClick(nil); // v1.2
end;
//-----------------------------------------------------------------------------
procedure TFormMain.FormResize(Sender: TObject);
begin
// Positionnement du partage Arbre/Liste
if MenuItemEcranTypeArbre.Checked then
  TreeView.Width:=(PanelResultats.Width-SplitterV.Width) div 2
else
  TreeView.Width:=0;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionAffichageEffacerSolutionsExecute(Sender: TObject);
begin
 NettoieAffichage;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionInformationsAProposExecute(Sender: TObject);
begin
FormAPropos:=TFormAPropos.Create(Application);
with FormAPropos do
  try
    ShowModal;
  finally
    Release;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.MenuItemToolBarAfficherClick(
  Sender: TObject);
begin
// Libellés sur les boutons
with ToolBar do
  if MenuItemToolBarAfficherLibellesBoutons.Checked then
    begin
    ToolBar.ButtonHeight:=47;
    ToolBar.ShowCaptions:=True
    end
  else
    begin
    ToolBar.ShowCaptions:=False;
    ToolBar.ButtonHeight:=39;
    ToolBar.ButtonWidth:=39;
    end;
// Images dans le menu
with MainMenu do
  if MenuItemToolBarAfficherImagesMenuPrincipal.Checked then
    Images:=VirtualImageListBoutons
  else
    Images:=nil;
with PopupMenuArbre do
  if MenuItemToolBarAfficherImagesMenuPrincipal.Checked then
    Images:=VirtualImageListBoutons
  else
    Images:=nil;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionArbreSolutionLaPlusSimpleExecute(Sender: TObject);
begin
with TreeView do
  if Items.Count>0 then
    begin
    Items[0].Selected:=True;
    while Selected.HasChildren do
      Selected.getFirstChild.Selected:=True;
    end;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionArbreSolutionLaPlusTordueExecute(Sender: TObject);
begin
with TreeView do
  if Items.Count>0 then
    Items[Items.Count-1].Selected:=True;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionInformationsAideExecute(Sender: TObject);
begin
ShellExecute( 0,
              'Open',
              'index.html',
              Nil,
              pChar(ExtractFilePath(Application.ExeName)+'html\'),
              SW_SHOWNORMAL);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionAffichageStatistiquesExecute(Sender: TObject);
begin
ShellExecute( 0,
              'Open',
              'Statistiques.html',
              Nil,
              pChar(stRepLocalAppData), // v1.3 : stRepLocalAppData remplace ExtractFilePath(Application.ExeName)
              SW_SHOWNORMAL);
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionArbreSolutionPrecedenteComplexiteExecute(
  Sender: TObject); // v1.0.2
begin
with TreeView do
  if Selected<>nil then
    begin
    // Cas n°1 : On a une solution soeur précédente : on la sélectionne
    if (Selected.Parent<>nil) and
       (Selected.Parent.GetPrevChild(Selected)<>nil) then
      Selected.Parent.GetPrevChild(Selected).Selected:=True
    else // Sinon, on remonte jusqu'à avoir une soeur précédente (changement de noeud)
      begin
      while (Selected.Parent<>nil) and
            (Selected.Parent.GetPrevChild(Selected)=nil) do
        Selected.Parent.Selected:=True;
      if (Selected.Parent<>nil) then
        Selected.Parent.GetPrevChild(Selected).Selected:=True;
      while Selected.HasChildren do // On prend la dernière soeur
        Selected.GetLastChild.Selected:=True;
      end
    end
  else
    ActionArbreSolutionLaPlusSimple.Execute;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.ActionArbreSolutionSuivanteComplexiteExecute(
  Sender: TObject); // v1.0.2
begin
with TreeView do
  if Selected<>nil then
    begin
    if (Selected.Parent<>nil) and
       not Selected.HasChildren (*v1.0.5*) then 
      if (Selected.Parent.GetNextChild(Selected)<>nil) then
        Selected.Parent.GetNextChild(Selected).Selected:=True
      else
        begin
        repeat
          Selected.Parent.Selected:=True; // On remonte jusqu'à ce qu'il y en ait un ou plus de parent
        until (Selected.Parent=nil) or // v1.0.5 : inversion des conditions !
              (Selected.Parent.GetNextChild(Selected)<>nil);
        if Selected.Parent<>nil then
          Selected.Parent.GetNextChild(Selected).Selected:=True;
        end{else};
    if Selected.HasChildren then
      repeat
        Selected.getFirstChild.Selected:=True;
      until not Selected.HasChildren;
    end
  else
    ActionArbreSolutionLaPlusTordue.Execute;
end;
//-----------------------------------------------------------------------------
procedure TFormMain.TimerAutoTimer(Sender: TObject); // v1.0.6
begin
with TimerAuto do
  begin
  Tag:=Tag+1; // Compteur de passages
  if (Tag<2) then Exit; // Premier passage (avant que le temps du timer ne se soit écoulé)
  // Deuxième passage (le temps indiqué par Interval est écoulé : on peut afficher le tableau)
  Tag:=0;
  Enabled:=False;
  if ActionSaisieAutomatique.Checked then // v1.2
    ActionAffichageTableau.Execute;
  end;
end;
//-----------------------------------------------------------------------------
end.
