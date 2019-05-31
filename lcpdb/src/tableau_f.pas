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
mailto:patquoi@free.fr
http://patquoi.free.fr

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
unit tableau_f;
//-----------------------------------------------------------------------------
interface
//-----------------------------------------------------------------------------
uses
  IA,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ExtCtrls, ComCtrls, ToolWin, System.ImageList;
//-----------------------------------------------------------------------------
const
  stSuffixePosition            : array [Boolean] of String = ('ère','ème'); // v1.2.4
  NbMaxLignesCalcul            =  5;
  NbValeursPlaques             = 14;
  NbChiffresOperateurs         = 15;
  HauteurDigit                 = 42;
  LargeurDigit                 = 24;
  LargeurEspace                = 20;
  EspaceChiffreOperateur       =  4;
  HauteurChiffreOperateur      = 52;
  ASCIIMinChiffreOperateur     = 42; // Code ASCII de *
  ASCIIMaxChiffreOperateur     = 61; // Code ASCII de =
  IndexImageChoixPlaque        = 25;
//-----------------------------------------------------------------------------
type
  TEtatTableau                 = (etIndefini, etAffichageSolution, etAttenteSaisie, etSaisieEnCours, etSaisieTerminee);
  TIndexChiffreOperateur       = 0..NbChiffresOperateurs-1;
  TIndexPlaque                 = 0..14;
  TNbResultats                 = 0..NbMaxLignesCalcul;
  TPlaque                      = 1..NbMaxPlaques;
  TPlaques                     = array [TPlaque] of TValeurPlaque;
  TStrPlaques                  = array [TPlaque] of String;
  TPlaquesChoisies             = array [TPlaque] of Boolean;
  TValeursIndexPlaque          = array [TIndexPlaque] of TValeurPlaque;
  TIndexValeurPlaque           = array [TValeurPlaque] of TIndexPlaque;
  TResultat                    = 1..NbMaxLignesCalcul;
  TResultats                   = array [TResultat] of TValeur;
  TStrResultats                = array [TResultat] of String;
  TResultatsChoisis            = array [TResultat] of Boolean;
  TLargeurChiffreOperateur     = array [TIndexChiffreOperateur] of Integer;
  TChiffreOperateur            = array [TIndexChiffreOperateur] of char;
  TIndexChiffreOperateurASCII  = array [ASCIIMinChiffreOperateur..ASCIIMaxChiffreOperateur] of TIndexChiffreOperateur;
  TTypeSaisie                  = (tsRien, tsOperande, tsOperateur, tsEgal, tsResultat);
  TOperationSaisie             = (osIndefinie, osAddition, osSoustraction, osMultiplication, osDivision);
  TErreurSaisie                = ( esIndefinie,
                                   esChiffreAttendu,
                                   esNombreSaisiIncompletOuInexistant,
                                   esNombreFormeIncorrect,
                                   esOperateursMemeType,
                                   esOperationImpossible,
                                   esResultatFaux,
                                   esResultatManquant,
                                   esOperateurAttendu,
                                   esCalculNonTermine,
                                   esSaisieAbandonnee,
                                   esCalculVide,
                                   esTableauCache); // Pour éviter de lancer la solution après action de cacher le tableau. v1.2
  TIconeMessage                = ( imAucune,
                                   imInformation,
                                   imAttention,
                                   imDrapeauVert,
                                   imDrapeauRouge);
  TMessagesErreurSaisie        = array [TErreurSaisie] of String;
//-----------------------------------------------------------------------------
  TFormTableau = class(TForm)
    ImageListChiffresOperateurs: TImageList;
    ImageListPlaques: TImageList;
    StatusBar: TStatusBar;
    Timer: TTimer;
    ImageListDifficulte: TImageList;
    ToolBarDifficulte: TToolBar;
    ToolButtonDifficulte: TToolButton; // v1.1
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect); // v1.0.2
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); // v1.0.2
    procedure FormClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FEtatTableau      : TEtatTableau;
    stPlaque          : TStrPlaques;
    Plaque            : TPlaques;
    PlaqueChoisie     : TPlaquesChoisies;
    stResultat        : TStrResultats;
    NbResultats       : TNbResultats;
    Resultat          : TResultats;
    ResultatChoisi    : TResultatsChoisis;
    stCalculEnCours,
    stNombreEnCours,
    stRangProposition : String; // v1.2.4
    DernierTypeSaisi  : TTypeSaisie;
    CalculAutomatique,
    ResultatCorrect   : Boolean; // Indique si le résultat saisi est correct ou non
    AvantDerniereOperation,
    DerniereOperation : TOperationSaisie;
    DernierOperande,
    DernierResultat   : TValeur;
    DebutChrono,
    ArretChrono       : TDateTime;
    IconeMessage      : TIconeMessage;
    function CalculeNbNombresDisponibles : Integer;
    procedure ChangeEtatTableau(const NouvelEtatTableau : TEtatTableau);
    property NbNombresDisponibles : Integer read CalculeNbNombresDisponibles;
    procedure AfficheIconeBarreStatut;
    procedure Rafraichit;
    procedure AjouteResultat(const stNouveauResultat : String);
    procedure AfficheSolution(const stSolution : String);
    procedure CochePlaqueSiPossible(const stNombreForme : String);
    procedure EffaceMessageBarreStatut;
    procedure AfficheMessageAvecIconeBarreStatut(const stMessage : String; const IconeMessage : TIconeMessage);
    procedure AfficheMessageErreurSaisie(const ErreurSaisie : TErreurSaisie);
    procedure AjouteSaisie(const Caractere : Char; const TypeSaisie : TTypeSaisie);
    procedure AfficheResultatAtteint;
    procedure AfficheResultatApproche;
    function stTempsSaisie : String;
  public
    DistanceSaisie : Integer;
    property EtatTableau : TEtatTableau read FEtatTableau write ChangeEtatTableau;
    procedure InitialiseSaisieCalcul;
    procedure LanceChrono;
    procedure CompareCalculSaisiAuxSolutionsTrouvees(const OptimiseCalculSaisi : Boolean);
    function TempsSaisie : Integer;
    procedure ArreteSaisieCalcul(const ErreurSaisie : TErreurSaisie); // Déplacée en public. v1.2
  end;
//-----------------------------------------------------------------------------
var
  FormTableau: TFormTableau;
//-----------------------------------------------------------------------------
const                                                      //(27,18,28,25,30,24,26,24,26,27,26,20,22,26,26)
                                                            // *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =
  IndexChiffreOperateurASCII : TIndexChiffreOperateurASCII = (12,10, 0,11,14,13, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0,14);
                                                           //  0   1   2   3   4   5   6   7   8   9  10  11  12  13  14
  ChiffreOperateur           : TChiffreOperateur           = ('0','1','2','3','4','5','6','7','8','9','+','-','*','/','=');
  LargeurChiffreOperateur    : TLargeurChiffreOperateur    = (26, 22, 25, 24, 26, 27, 25, 24, 24, 25, 35, 24, 28, 33, 36);

  ValeurIndexPlaque          : TValeursIndexPlaque         = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 75, 100);

                                                           // x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
  IndexValeurPlaque          : TIndexValeurPlaque          = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                                       (*1x*) 10, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*2x*)  0, 0, 0, 0, 0,11, 0, 0, 0, 0,
                                                       (*3x*)  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*4x*)  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*5x*) 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*6x*)  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*7x*)  0, 0, 0, 0, 0,13, 0, 0, 0, 0,
                                                       (*8x*)  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                       (*9x*)  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14);

   stMessageErreurSaisie        : TMessagesErreurSaisie    = ( 'Erreur indéfinie.',
                                                               'Chiffre attendu.',
                                                               'Nombre saisi incomplet ou inexistant. Chiffre attendu.',
                                                               'Nombre formé incorrect. Utiliser la touche [Ret.Arr] si autorisée.',
                                                               'Opérateurs de même types uniquement : + avec - et * avec /.',
                                                               'Opération impossible. Le quotient doit être entier et la différence supérieure à zéro.',
                                                               'Résultat FAUX ! Utiliser la touche [Ret.Arr] si autorisée puis ressaisir un nombre.',
                                                               'Résultat MANQUANT. Saisissez le résultat de l''opération.',
                                                               'Opérateur Attendu. Il faut effectuer une opération avant de définir le résultat.',
                                                               'Temps écoulé et calcul non terminé ou erroné.',
                                                               'Saisie abandonnée.',
                                                               'Calcul vide. Utiliser la touche [Echap] pour abandonner.',
                                                               'Saisie abandonnée (tableau masqué).'); // v1.2
   IndexImage                   : array [TIconeMessage] of Integer = ( -1, 16, 15, 12, 11);
   stOperateurEgalResultatSaisi : string = '.';
//-----------------------------------------------------------------------------
implementation
//-----------------------------------------------------------------------------
uses Vcl.StdCtrls, // Pour TLabel
     System.UITypes, // Pour MessageDlgPos
     Math,     // Pour Min
     main_f;
//-----------------------------------------------------------------------------
{$R *.dfm}
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheIconeBarreStatut;
begin
with StatusBar.Canvas do // On efface l'icône précédente (v1.0.3)
  begin
  Brush.Color:=StatusBar.Color;
  FillRect(Rect(2,3,18,19));
  end;
FormMain.ImageListArbre.Draw(StatusBar.Canvas, 2, 3, IndexImage[IconeMessage]);
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.Rafraichit;
var xd, xp, y, y1, y2, l,
    ddx, ddy, u, d, c, i  : Integer;
begin
Canvas.Brush.Color:=Color;
Canvas.FillRect(Rect(0, 0, ClientWidth-1, ClientHeight-1));
l:=3*LargeurDigit+6*EspaceChiffreOperateur;
y1:=64; y2:=144;
Canvas.Brush.Color:=clMaroon;
Canvas.FillRect(Rect((ClientWidth-l) div 2, 0, (ClientWidth+l) div 2, y1));
Canvas.Brush.Color:=clOlive;
Canvas.FillRect(Rect(0, y1, ClientWidth-1, y2));
Canvas.Brush.Color:=clBlack;
Canvas.FillRect(Rect(0, y2, ClientWidth-1, ClientHeight-1));

// 1. Affichage du compte à trouver
u:=IA.Compte mod 10;
d:=(IA.Compte div 10) mod 10;
c:=IA.Compte div 100;
ddx:=(ImageListChiffresOperateurs.Width-LargeurDigit) div 2;
ddy:=(ImageListChiffresOperateurs.Height-HauteurDigit) div 2;
y:=(y1-HauteurDigit) div 2-ddy;
xd:=(ClientWidth-LargeurDigit) div 2-ddx;
ImageListChiffresOperateurs.Draw(Canvas, xd-LargeurDigit-EspaceChiffreOperateur, y, c);
ImageListChiffresOperateurs.Draw(Canvas, xd, y, d);
ImageListChiffresOperateurs.Draw(Canvas, xd+LargeurDigit+EspaceChiffreOperateur, y, u);

// 2. Affichage des plaques
for i:=Low(TPlaque) to High(TPlaque) do
  begin
  xp:=i*((ClientWidth-NbMaxPlaques*ImageListPlaques.Width) div (1+NbMaxPlaques)+ImageListPlaques.Width);
  ImageListPlaques.Draw( Canvas,
                         xp-ImageListPlaques.Width,
                         y1+(y2-y1-ImageListPlaques.Height) div 2,
                         IndexValeurPlaque[Plaque[i]]);
  end;


case EtatTableau of    // 3b. Affichage de la solution courante
  etAffichageSolution: with FormMain.ListBox do
                         if ItemIndex>-1 then
                           AfficheSolution(Items[ItemIndex]);
  etSaisieEnCours,
  etSaisieTerminee:    AfficheSolution(' '+stCalculEnCours);
end{case of};

// 3. Affichage de l'icône de la barre de statut
AfficheIconeBarreStatut
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AjouteResultat(const stNouveauResultat : String);
begin
Inc(NbResultats);
stResultat[NbResultats]:=stNouveauResultat;
Resultat[NbResultats]:=StrToInt(stNouveauResultat);
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheSolution(const stSolution : String);
var x, y,
    i, iCar : Integer;
    ChercherNombre : Boolean;
    stNombreForme : String;
begin
for i:=Low(TPlaque) to High(TPlaque) do
  PlaqueChoisie[i]:=False;
for i:=Low(TResultat) to High(TResultat) do
  ResultatChoisi[i]:=False;
NbResultats:=0;
ChercherNombre:=True;
x:=EspaceChiffreOperateur; y:=180;
for i:=2 to Length(stSolution) do
  if stSolution[i]<>' ' then
    begin
    iCar:=IndexChiffreOperateurASCII[Ord(stSolution[i])];
    ImageListChiffresOperateurs.Draw(Canvas, x-(ImageListChiffresOperateurs.Width-LargeurChiffreOperateur[iCar]) div 2, y, iCar+10);
    Inc(x, LargeurChiffreOperateur[iCar]);
    if (stSolution[i]>='0') and (stSolution[i]<='9') then
      stNombreForme:=stNombreForme+stSolution[i]
    else
      begin
      if stNombreForme<>'' then
        begin
        if ChercherNombre then
          begin
          CochePlaqueSiPossible(stNombreForme);
          stNombreForme:='';
          end
        else
          begin
          stNombreForme:='';
          ChercherNombre:=true;
          end
        end;
      if (stSolution[i]=stOperateurEgal) or // Signe égal : '='
         (stSolution[i]=stOperateurEgalResultatSaisi) then // Signe égal résultat en cours de saisie : '.'
        ChercherNombre:=False
      end
    end
  else // Espace
    begin
    AjouteResultat(stNombreForme); // On ajoute le nombre à la liste des résultats.
    x:=EspaceChiffreOperateur;
    Inc(y, HauteurChiffreOperateur);
    stNombreForme:='';
    ChercherNombre:=true;
    end;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.CochePlaqueSiPossible(const stNombreForme : String);
var i : Integer;
begin
// 1. On teste les résultats intermédiaires
for i:=Low(TResultat) to NbResultats do
  if not ResultatChoisi[i] and (stNombreForme=stResultat[i]) then
    begin // C'est un résultat intermédiaire : on le pointe et on quitte
    ResultatChoisi[i]:=True;
    Exit;
    end;
// 2. On teste les plaques
for i:=Low(TPlaque) to High(TPlaque) do
  if not PlaqueChoisie[i] and (stNombreForme=stPlaque[i]) then
    begin // C'est une plaque : on la coche au tableau et on quitte
    ImageListChiffresOperateurs.Draw( Canvas,
                                      i*((ClientWidth-NbMaxPlaques*ImageListPlaques.Width) div (1+NbMaxPlaques)+ImageListPlaques.Width)-ImageListPlaques.Width div 2-14,
                                      128,
                                      IndexImageChoixPlaque);
    PlaqueChoisie[i]:=True;
    Exit;
    end;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormResize(Sender: TObject);
begin
Rafraichit
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormPaint(Sender: TObject);
begin
Rafraichit
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormHide(Sender: TObject);
begin
with FormMain do
  begin
  if Timer.Enabled then Timer.Enabled:=False; // On arrête le chrono
  MenuItemAffichageTableau.Checked:=False;
  ChangeVisibiliteTableau(False);
  ActionCompteCalculerSolutions.Enabled:=True;
  FormMain.ActionAffichageTableau.Checked:=False;
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.InitialiseSaisieCalcul;
var i : Integer;
begin
if FormMain.ListBox.ItemIndex>-1 then
  begin
  EtatTableau:=etAffichageSolution;
  AfficheMessageAvecIconeBarreStatut(IA.stConclusion+IA.stNbSolutionsTempsEcoule, imInformation);
  end
else
  begin
  EtatTableau:=etAttenteSaisie;
  EffaceMessageBarreStatut;
  IconeMessage:=imAucune;
  end;
for i:=Low(TPlaque) to High(TPlaque) do
  begin
  stPlaque[i]:=(FormMain.FindComponent('Label'+IntToStr(i)) as TLabel).Caption;
  Plaque[i]:=StrToInt(stPlaque[i]);
  PlaqueChoisie[i]:=False;
  end;
for i:=Low(TResultat) to High(TResultat) do
  begin
  stResultat[i]:='';
  Resultat[i]:=0;
  ResultatChoisi[i]:=False;
  end;
NbResultats:=0;
DernierTypeSaisi:=tsRien;
DerniereOperation:=osIndefinie;
AvantDerniereOperation:=osIndefinie;
DernierOperande:=0;
DernierResultat:=0;
stNombreEnCours:='';
stCalculEnCours:='';
CalculAutomatique:=FormMain.MenuItemCalculerResultat.Checked;
ResultatCorrect:=True;
ToolButtonDifficulte.ImageIndex:=-1; // v1.1
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.LanceChrono;
begin
if (EtatTableau<>etAffichageSolution) then
  with Timer do // Si saisie et temps limité, on lance le timer, on active
    if (FormMain.TempsReflexionSaisie>0) then
      begin
      DebutChrono:=Now;
      Tag:=0; // On force l'affichage
      Enabled:=True;
      end
    else
      Enabled:=False;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormShow(Sender: TObject);
begin
FormMain.ActionAffichageTableau.Checked:=True;
FormMain.ActionCompteCalculerSolutions.Enabled:=False;
Left:=Min(FormMain.Left+FormMain.Width,Screen.Width-Width);
Top:=FormMain.Top;
FormMain.MenuItemAffichageTableau.Checked:=True;
InitialiseSaisieCalcul;
LanceChrono;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.EffaceMessageBarreStatut;
begin
StatusBar.Panels.Items[1].Text:='';
Self.IconeMessage:=imAucune;
AfficheIconeBarreStatut;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheMessageAvecIconeBarreStatut(const stMessage : String; const IconeMessage : TIconeMessage);
begin
StatusBar.Panels.Items[1].Text:=stMessage;
Self.IconeMessage:=IconeMessage;
AfficheIconeBarreStatut;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheMessageErreurSaisie(const ErreurSaisie : TErreurSaisie);
begin
  AfficheMessageAvecIconeBarreStatut(stMessageErreurSaisie[ErreurSaisie], imAttention);
end;
//-----------------------------------------------------------------------------
function TFormTableau.TempsSaisie : Integer;
begin
Result:=Round(864000*Frac(ArretChrono-DebutChrono));
end;
//-----------------------------------------------------------------------------
function TFormTableau.stTempsSaisie : String;
begin
if not FormMain.MenuItemIllimite.Checked then
  Result:=Format('Temps écoulé : %.2f secondes.', [86400.0*Frac(ArretChrono-DebutChrono)])
else
  Result:='';
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AjouteSaisie(const Caractere : Char; const TypeSaisie : TTypeSaisie);
var i             : Integer;
    NombreEnCours : TValeur;
    NombreTrouve  : Boolean;
begin
NombreTrouve:=False;
case TypeSaisie of
  tsResultat,
  tsOperande:  stNombreEnCours:=stNombreEnCours+Caractere;
  tsEgal,
  tsOperateur: begin
               if (DernierTypeSaisi<>tsResultat) and  // tsResultat : On enregistre pas le résultat : c'est un nouveau nombre
                  (DernierTypeSaisi<>tsOperateur) then // tsOperateur : On change simplement d'opérateur
                 begin // On ne vérifie pas le nombre s'il s'agit du résultat saisi manuellement et on ne vérifie pas une deuxième fois un opérande quand on change d'opérateur.
                 // 1. On vérifie si le nombre saisi est une plaque ou un résultat inutilisé
                 for i:=Low(TResultat) to NbResultats do
                   if not ResultatChoisi[i] and
                      (stNombreEnCours = stResultat[i]) then
                       begin
                       ResultatChoisi[i]:=True; // On marque le dernier nombre saisi (résultat)
                       NombreTrouve:=True;
                       Break;
                       end;
                 if not NombreTrouve then
                   for i:=Low(TPlaque) to High(TPlaque) do
                     if not PlaqueChoisie[i] and
                        (stNombreEnCours = stPlaque[i]) then
                         begin
                         PlaqueChoisie[i]:=True; // On marque le dernier nombre saisi (plaque)
                         NombreTrouve:=True;
                         Break;
                         end;
                 if not NombreTrouve then
                   begin
                   // Si nombre en cours de saisie, on ne peut pas encore saisir d'opérateur
                   AfficheMessageErreurSaisie(esNombreSaisiIncompletOuInexistant);
                   Exit;
                   end;
                 // 2. On calcule le résultat de l'opération
                 NombreEnCours:=StrToInt(stNombreEnCours);
                 case DerniereOperation of
                   osIndefinie:      DernierResultat:=NombreEnCours;
                   osAddition:       Inc(DernierResultat, NombreEnCours);
                   osSoustraction:   if DernierResultat>NombreEnCours then
                                       Dec(DernierResultat, NombreEnCours)
                                     else
                                       begin
                                       AfficheMessageErreurSaisie(esOperationImpossible);
                                       Exit;
                                       end;
                   osMultiplication: if DernierResultat=0 then
                                       DernierResultat:=NombreEnCours
                                     else
                                       DernierResultat:=DernierResultat*NombreEnCours;
                   osDivision:       if DernierResultat mod NombreEnCours=0 then
                                       DernierResultat:=DernierResultat div NombreEnCours
                                     else
                                       begin
                                       AfficheMessageErreurSaisie(esOperationImpossible);
                                       Exit;
                                       end;
                 end{case of}
               end{if DernierTypeSaisi};  
               // On définit la dernière opération
               case Caractere of
                 #13: begin
                      if DernierTypeSaisi<>tsResultat then
                        begin // On ajoute le résultat calculé automatiquement
                        if CalculAutomatique then
                          begin
                          stCalculEnCours:=stCalculEnCours+stOperateurEgal;
                          AjouteResultat(IntToStr(DernierResultat)); // Ajoute le résultat à la liste des autres résultats calculés
                          stCalculEnCours:=stCalculEnCours+IntToStr(DernierResultat)+' ';
                          end
                        else
                          stCalculEnCours:=stCalculEnCours+stOperateurEgalResultatSaisi; // Permet d'identifier le dernier signe égal
                        end
                      else // On ajoute le résultat saisi manuellement et qui est correct
                        begin
                        AjouteResultat(IntToStr(DernierResultat)); // Ajoute le résultat à la liste des autres résultats calculés
                        stCalculEnCours:= copy( stCalculEnCours,
                                                1,
                                                Pos(stOperateurEgalResultatSaisi, stCalculEnCours)-1)+
                                          stOperateurEgal+
                                          IntToStr(StrToInt(stNombreEnCours))+
                                          ' ';
                        AfficheMessageAvecIconeBarreStatut('Résultat saisi EXACT.', imInformation);
                        end;
                      AvantDerniereOperation:=osIndefinie;
                      DerniereOperation:=osIndefinie;
                      DernierOperande:=0;
                      end;
                 '+': begin
                      if DerniereOperation<>osIndefinie then
                        AvantDerniereOperation:=DerniereOperation;
                      DerniereOperation:=osAddition;
                      end;
                 '-': begin
                      if DerniereOperation<>osIndefinie then
                        AvantDerniereOperation:=DerniereOperation;
                      DerniereOperation:=osSoustraction;
                      end;
                 '*': begin
                      if DerniereOperation<>osIndefinie then
                        AvantDerniereOperation:=DerniereOperation;
                      DerniereOperation:=osMultiplication;
                      end;
                 '/': begin
                      if DerniereOperation<>osIndefinie then
                        AvantDerniereOperation:=DerniereOperation;
                      DerniereOperation:=osDivision;
                      end;
               end{case of};
               stNombreEnCours:=''; // On réinitialise le nombre en cours
               end{tsOperateur:};
end{case of};
// On teste la fin de saisie (Compte est bon ou dernière ligne saisie)
if (TypeSaisie=tsEgal) and
   (CalculAutomatique or // Si résultat automatique, on ne passe qu'une fois dans l'état tsEgal
    (DernierTypeSaisi=tsResultat)) then // Sinon on passe de le deuxième état où l'on a déjà saisi le résultat
  begin
  ArretChrono:=Now();
  if DernierResultat=Compte then // Compte trouvé
    AfficheResultatAtteint
  else // On teste si plus de résultats disponibles (à part le dernier qui est le résultat)
    if (TypeSaisie=tsEgal) and
       (NbNombresDisponibles=1) and
       not ResultatChoisi[NbResultats] then
      AfficheResultatApproche; // Compte pas trouvé
  end;
case TypeSaisie of
  tsEgal:      if CalculAutomatique then
                 begin
                 DernierTypeSaisi:=tsRien;
                 DernierResultat:=0;
                 end
               else
                 case DernierTypeSaisi of
                   tsResultat: begin
                               DernierTypeSaisi:=tsRien; // On vient de finir de saisir le résultat manuellement
                               DernierResultat:=0;
                               end;
                   tsOperateur,// Cas du signe égal qui a écrasé un opérateur saisi par erreur            
                   tsOperande: DernierTypeSaisi:=tsEgal; // On vient de finir de saisir le dernier opérande
                 end{case of};
else
  DernierTypeSaisi:=TypeSaisie
end{case of};

if Caractere<>#13 then
  stCalculEnCours:=stCalculEnCours+Caractere;
if EtatTableau=etAttenteSaisie then
  EtatTableau:=etSaisieEnCours;
Repaint;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheResultatAtteint;
begin
DistanceSaisie:=0;
AfficheMessageAvecIconeBarreStatut(stLeCompteEstBon+stTempsSaisie+stRangProposition, imDrapeauVert); // v1.2.4 : Ajout stRangProposition
EtatTableau:=etSaisieTerminee;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.AfficheResultatApproche;
begin
DistanceSaisie:=abs(IA.Compte-Resultat[NbResultats]);
AfficheMessageAvecIconeBarreStatut( Format( stLeCompteEstApproche,
                                            [ DistanceSaisie,
                                              IA.Compte-DistanceSaisie,
                                              IA.Compte+DistanceSaisie])+
                                            stTempsSaisie,
                                    imDrapeauRouge);
EtatTableau:=etSaisieTerminee;
end;
//-----------------------------------------------------------------------------
function TFormTableau.CalculeNbNombresDisponibles : Integer;
var i : Integer;
begin
Result:=0;
for i:=Low(TPlaque) to High(TPlaque) do
  if not PlaqueChoisie[i] then Inc(Result);
for i:=Low(TResultat) to NbResultats do
  if not ResultatChoisi[i] then Inc(Result);
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.ChangeEtatTableau(const NouvelEtatTableau : TEtatTableau);
begin
FEtatTableau:=NouvelEtatTableau;
if (NouvelEtatTableau=etAffichageSolution) and
   Timer.Enabled then
  Timer.Enabled:=False;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.CompareCalculSaisiAuxSolutionsTrouvees(const OptimiseCalculSaisi : Boolean);
var i                : Integer;
    stCalculOptimise,
    stAvertissements : String;
begin
if OptimiseCalculSaisi then
  stCalculOptimise:=IA.stReduitEtOrdonneCalculSaisi(stCalculEnCours, stAvertissements)
else
  begin
  stCalculOptimise:='';
  stAvertissements:=stMessageErreurSaisie[esCalculNonTermine];
  end;
if FormMain.MenuItemEntreeAfficherInfosOptimisationApresSaisie.Checked then
  with FormMain.MemoOptimisationsCalculSaisi do
    begin
    Clear;
    Lines.Add(stAvertissements);
    end;
with FormMain.ListBox do
  begin
  if Items.Count<1 then
    with FormMain.ActionCompteCalculerSolutions do
      begin
      if not Enabled then Enabled:=True;
      Execute;
      end;
  if Items.Count>0 then
    begin
    i:=Items.IndexOf(' '+stCalculOptimise);
    if i>-1 then
      begin
      ItemIndex:=i;
      FormMain.ListBoxDblClick(FormMain.ListBox);

      //v1.2.4 (début) : affiche le rang de simplicité en bas du tableau le cas échéant
      i:=TStatSolution(FormMain.TreeView.Selected.Data).RangComplexite;
      stRangProposition:= Format( ' Classée %d%s sur %d en simplicité.',
                                  [i, stSuffixePosition[i>1], Items.Count]);
      AfficheResultatAtteint;
      stRangProposition:='';
      //v1.2.4 (fin)

      if IA.DistanceRecherche=0 then
        FormMain.AjouteStatistiqueDetailHumain(dsHumainClassesTrouves)
      else
        FormMain.AjouteStatistiqueDetailHumain(dsHumainClassesApproches);
      end
    else
      if OptimiseCalculSaisi then
        FormMain.AjouteStatistiqueDetailHumain(dsHumainNonClasses)
      else
        FormMain.AjouteStatistiqueDetailHumain(dsHumainNonTermines);
    end
  end;
  EtatTableau:=etAffichageSolution;
end;
//-----------------------------------------------------------------------------
// Evénements
//-----------------------------------------------------------------------------
procedure TFormTableau.FormKeyPress(Sender: TObject; var Key: Char);
var i : Integer;
begin
// Si Solution courante affichée : on interdit la saisie.
case EtatTableau of
  etAffichageSolution,
  etSaisieTerminee:    Exit;
end{case of};
case Key of
  #8:       if FormMain.MenuItemRetourArriereAutorise.Checked then
              if stNombreEnCours<>'' then
                begin
                stNombreEnCours:=copy(stNombreEnCours,1,Length(stNombreEnCours)-1);
                stCalculEnCours:=copy(stCalculEnCours,1,Length(stCalculEnCours)-1);
                Repaint;
                end
              else
                case DernierTypeSaisi of
                  tsOperateur: AfficheMessageAvecIconeBarreStatut('Inutile d''effacer l''opérateur : entrez-en un directement ou [ENTRÉE] pour mettre le résultat.', imInformation);
                end{case of};
  #27:      begin
            if stCalculEnCours='' then
              begin
              InitialiseSaisieCalcul;
              ArreteSaisieCalcul(esSaisieAbandonnee);
              Exit;
              end
            else
              begin
              InitialiseSaisieCalcul;
              Repaint;
              end;
            end;
  '0'..'9': case DernierTypeSaisi of
              tsOperande, // Nombre en cours de saisie
              tsRien,     // Nombre pas encore commencé
              tsOperateur: begin // Nombre saisi terminé
                           for i:=Low(TResultat) to NbResultats do
                             if not ResultatChoisi[i] and
                                (Pos(stNombreEnCours+Key, stResultat[i])>0) then
                               begin // Chiffre accepté :
                               AjouteSaisie(Key, tsOperande);
                               Exit;
                               end;
                           for i:=Low(TPlaque) to High(TPlaque) do
                             if not PlaqueChoisie[i] and
                                (Pos(stNombreEnCours+Key, stPlaque[i])>0) then
                               begin // Chiffre accepté :
                               AjouteSaisie(Key, tsOperande);
                               Exit;
                               end;
                           AfficheMessageErreurSaisie(esNombreFormeIncorrect);
                           Exit;
                           end;
              tsResultat,
              tsEgal:      AjouteSaisie(Key, tsResultat); // On saisit le résultat : on vérifie après la touche entrée
              end{case DernierTypeSaisi of};
  '+', '-',
  '*', '/': case DernierTypeSaisi of
              tsOperateur, // On change d'opérateur
              tsOperande:  begin
                           if DernierTypeSaisi=tsOperateur then
                             if FormMain.MenuItemRetourArriereAutorise.Checked then
                               DerniereOperation:=AvantDerniereOperation // On remet l'avant dernier opérateur comme dernier opérateur
                             else
                               begin
                               AfficheMessageErreurSaisie(esChiffreAttendu);
                               Exit;
                               end;
                           if (DerniereOperation=osIndefinie) or
                              (((DerniereOperation=osAddition) or
                                (DerniereOperation=osSoustraction)) and
                               ((Key='+') or (Key='-'))) or
                              (((DerniereOperation=osMultiplication) or
                                (DerniereOperation=osDivision)) and
                               ((Key='*') or (Key='/'))) then
                             begin
                             if FormMain.MenuItemRetourArriereAutorise.Checked and
                                (DernierTypeSaisi=tsOperateur) then
                               stCalculEnCours:=copy(stCalculEnCours,1,Length(stCalculEnCours)-1);
                             AjouteSaisie(Key, tsOperateur)
                             end
                           else
                             AfficheMessageErreurSaisie(esOperateursMemeType);
                           end;
              tsRien,
              tsEgal:      AfficheMessageErreurSaisie(esChiffreAttendu);
            end{case DernierTypeSaisi of};
  #13:      case DernierTypeSaisi of
              tsResultat:  begin
                           ResultatCorrect:=(DernierResultat=StrToInt(stNombreEnCours));
                           if ResultatCorrect then
                             AjouteSaisie(Key, tsEgal)
                           else
                             AfficheMessageErreurSaisie(esResultatFaux);
                           end;
              tsOperateur, // On écrase l'opérateur par le signe =
              tsOperande:  begin
                           if DernierTypeSaisi=tsOperateur then
                             if FormMain.MenuItemRetourArriereAutorise.Checked then
                               DerniereOperation:=AvantDerniereOperation
                             else
                               begin
                               AfficheMessageErreurSaisie(esChiffreAttendu);
                               Exit;
                               end;
                           if DerniereOperation<>osIndefinie then
                             begin
                             if FormMain.MenuItemRetourArriereAutorise.Checked and
                                (DernierTypeSaisi=tsOperateur) then
                               stCalculEnCours:=copy(stCalculEnCours,1,Length(stCalculEnCours)-1);
                             AjouteSaisie(Key, tsEgal)
                             end
                           else
                             AfficheMessageErreurSaisie(esOperateurAttendu);
                           end;
              tsRien,
              tsEgal:      if stCalculEnCours='' then // v1.0.2
                             AfficheMessageErreurSaisie(esCalculVide)
                           else
                             if CalculAutomatique then
                               AfficheResultatApproche
                             else
                               if (DernierTypeSaisi<>tsRien) then
                                 AfficheMessageErreurSaisie(esResultatManquant)
                               else
                                 AfficheResultatApproche;
            end{case of};
end{case of};
if EtatTableau=etSaisieTerminee then
  CompareCalculSaisiAuxSolutionsTrouvees(True); // True = On optimise le calcul saisi (réduit et ordonné) pour le rechercher dans les solutions trouvées
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormCreate(Sender: TObject);
begin
EtatTableau:=etIndefini;
Canvas.Font:=Font;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.ArreteSaisieCalcul(const ErreurSaisie : TErreurSaisie);
begin
ArretChrono:=Now();
Timer.Enabled:=False;
EtatTableau:=etSaisieTerminee;
if DernierTypeSaisi=tsResultat then
  begin // Cas où l'on a pas eu le temps de valider le résultat saisi (Calcul non automatique)
  ResultatCorrect:=(DernierResultat=StrToInt(stNombreEnCours)); // Le résultat est-il juste ?
  if ResultatCorrect then // Il faut changer le signe '.' par '=' servant à retrouver le résultat saisi.
    stCalculEnCours:= copy( stCalculEnCours,
                            1,
                            Pos(stOperateurEgalResultatSaisi, stCalculEnCours)-1)+
                      stOperateurEgal+
                      IntToStr(StrToInt(stNombreEnCours))+
                      ' ';
  end
else
  ResultatCorrect:= (DernierTypeSaisi=tsRien) and
                    (stCalculEnCours<>''); // Seul le cas tsRien est acceptable avec un calcul non vide (résultat validé).
if ResultatCorrect then
  if DernierResultat=Compte then
    AfficheResultatAtteint // Compte trouvé
  else
    AfficheResultatApproche // Compte approché
else // Calcul non terminé ou abandon
  AfficheMessageErreurSaisie(ErreurSaisie);
if ErreurSaisie<>esTableauCache then // v1.2
  CompareCalculSaisiAuxSolutionsTrouvees(ResultatCorrect);
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.TimerTimer(Sender: TObject);
var TempsRestant   : Integer;
    stTempsRestant : String;
begin
with Timer do
  begin
  TempsRestant:=FormMain.TempsReflexionSaisie-Trunc(86400*Frac(Now-DebutChrono));
  if TempsRestant<>Tag then
    begin
    Tag:=TempsRestant;
    stTempsRestant:=Format('%4d', [TempsRestant]);
    with FormTableau.Canvas do
      begin
      if TempsRestant<6 then
        Font.Color:=clRed
      else
        Font.Color:=clWhite;
      TextOut(ClientWidth-TextWidth(stTempsRestant)-4, 0, stTempsRestant);
      end{with};
    end{if TempsRestant};
  // On teste la saisie si temps imparti écoulé
  if FormMain.MenuItemArreterSaisieFinTempsImparti.Checked and
     (TempsRestant<=0) then
    ArreteSaisieCalcul(esCalculNonTermine);
  end{with};
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormClick(Sender: TObject);
begin
if EtatTableau<>etAffichageSolution then
  AfficheMessageAvecIconeBarreStatut('Utiliser le pavé numérique. [Entr] remplace "=" et permet de valider une ligne ou un calcul.', imInformation);
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.FormKeyDown(Sender: TObject; var Key: Word; // v1.0.2
  Shift: TShiftState);
begin
if (Key=VK_F4) and (ssAlt in Shift) then
  begin
  if EtatTableau in [etAttenteSaisie, etSaisieEnCours] then
    if MessageDlgPos( 'Fermer le tableau pendant la saisie d''un calcul entraîne son abandon.'#13#13'Êtes-vous sûr(e) de vouloir abandonner le calcul en cours ?',
                      mtWarning, [mbYes,mbNo],  0,
                      Left, Top+Height div 2)=mrYes then
      begin
      InitialiseSaisieCalcul;
      ArreteSaisieCalcul(esSaisieAbandonnee);
      Exit;
      end;
  Abort // Dans tous les autres cas, on ihnibe la fermeture du tableau
  end;
end;
//-----------------------------------------------------------------------------
procedure TFormTableau.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect); // v1.0.2
begin
AfficheIconeBarreStatut
end;
//-----------------------------------------------------------------------------
end.
