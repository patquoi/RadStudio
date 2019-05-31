unit base;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
uses Classes, Graphics, Windows;
//----------------------------------------------------------------------------
const NbCasesCote         =  15;
      PositionRelativeMin = -14;
      PositionCaseDepart  =  0;
      PositionRelativeMax =  14;
      NbLettresAlphabet   =  29; // vKA
      NbJetonsSac         = 103; // vKA
      NbMaxJetonsTirage   =   7;
      NbMaxPlacesChevalet =  10;
      NbLettresMinMot     = 2;
      NbLettresMaxMot     = NbCasesCote;

      NbLettresDico       = 101764; // 101418; // 101402; // 101396; // 101390; // 101383; // 101339; // 98553; // 98515; // 98504; // 98461; // 98413; // 98402; // vKA. Gwodiko

      stVersionDico       = 'KA0'; // vKA
      BonusScrabble       = 50;
      NbMaxJokers         = 2;
      MinutesReflexion    = 3;
      VersionFichier      = $1000;

      stNomFichierIni   = 'Duplicata.ini';
      stSectionSac      = 'Sac';
      stJoker           = '?';
      stSuffixeRang : array [0..1] of String = ('er', '�me');
      ModeAutomatique   = True;
      ModeManuel        = False;
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
      TNumeroJetonSac      = 0..NbJetonsSac; // 0 = pas de jeton
      TOrdreJetonSac       = 1..NbJetonsSac; // Ordre de tirage des jetons dans le sac
      TNumeroJetonTirage   = 0..NbMaxJetonsTirage; // 0 = pas de jeton
      TOrdreJetonTirage    = 1..NbMaxJetonsTirage; // Ordre de tirage des jetons dans le jeu courant
      TOrdreJetonChevalet  = 1..NbMaxPlacesChevalet; // Place des jetons sur le chevalet
      TNumeroJetonChevalet = 0..NbMaxPlacesChevalet; // 0 = pas de jeton
      TChevalet            = array [TOrdreJetonChevalet] of TNumeroJetonSac;
      TDirection           = (dIndefinie, dHorizontale, dVerticale);
      TTour                = 1..NbJetonsSac;
      TNbLettres           = NbLettresMinMot..NbLettresMaxMot;
      TIndexDico           = 0..NbLettresDico-1;
      TNumeroJoker         = 0..NbMaxJokers;
      TOrdreJoker          = 1..NbMaxJokers; // Correspond aussi � TNumeroSac pour les jokers
      TPositionRelative    = PositionRelativeMin..PositionRelativeMax;
      TJoker               = array [TOrdreJoker] of TNumeroJoker;
      TLettreJoker         = array [TOrdreJoker] of TTypeJeton;
      TPlateau             = array [TCoordonnee, TCoordonnee] of TNumeroJetonSac;
      TSac                 = array [TOrdreJetonSac] of TOrdreJetonSac;
      TTirage              = array [TOrdreJetonTirage] of TNumeroJetonSac;
      TFormatRapport       = (frPourcentage, frNoteSur20);
     //-----------------------------------------------------------------------
      TAnagrammes = class(TObject)
      public
        NbAnagrammes : Integer;
        iDico : array of Integer; // Index pour TDico.stMotDico
      end;
     //-----------------------------------------------------------------------
      TDico = class
      private
        Index : array [TNbLettres] of Integer;
        Dico  : array [TIndexDico] of Char;
      public
        ChargementDicoOk : Boolean;
        constructor Cree;
        destructor  Detruit;
        function Existe(const stMot : String) : Boolean;
        function stMotDico(const TailleMot, IndexDico : Integer) : String;
        function IndexProchainMot(const IndexDebut : Integer; const stFiltre : String) : Integer;
      end{class TDico};
//---------------------------------------------------------------------------
const // Constantes pour le dictionnaire

      nbl : array [TNbLettres] of Integer            = (306,2589,8020,15540,18270,19124,14736,9576,6190,3641,2112,1092,448,120); // vKA : R�f�rence du gwodiko

      stNomFichierDico                               = 'L23456789ABCDEF'; // ODS
      stNomFichierRech                               = 'R23456789ABCDEF'; // ODS
      stMsgMotNonValable                             = 'Le mot %s n''est pas valable selon le Gwodiko.'#13;
      stDirection : array[TDirection] of String      = ('', 'Horizontalement',
                                                            'Verticalement');
      stFrmFichierIntrouvable   =  'Le fichier %s est introuvable !';
      stErreurInattendue        = 'Erreur inattendue';
      Proposition     : Boolean = True;
      CoupJoue        : Boolean = False;
      MaxFormatRapport: array [TFormatRapport] of Integer = (100, 20);
      stFormatRapport : array [TFormatRapport] of String = ('%', '/20');
//---------------------------------------------------------------------------
function stTirageTrie(const stTirage : String) : String;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses
  SysUtils, Math, IniFiles, StdCtrls, ShellApi, patience_f;
//---------------------------------------------------------------------------
const stAutreChoix    = #13#13'Cliquez sur une autre case d�part ou changez la s�lection des jetons.';
      stFrmSolution   = '%s : %s en %s';
      stCoordonneesIndefinies = ' - ';
      stLibreOccupee  : array [0..1] of String = ('Occup�e', 'Libre');
      AvecSautDeLigne : Boolean = True;
      SansSautDeLigne : Boolean = False;
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
constructor TDico.Cree;
var i : Integer;
    c : Char;
    F : File of Char;
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
    Panel.Caption:='Chargement du dictionnaire de mots en cours. Veuillez patienter SVP...';
    Gauge.MaxValue:=NbLettresDico div 100;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  Reset(F);
  Index[Low(TNbLettres)]:=0;
  for i:=Low(TNbLettres)+1 to High(TNbLettres) do
    Index[i]:=Index[i-1]+nbl[i-1];
  for i:=0 to NbLettresDico-1 do
    begin
    Read(f, c);
    Dico[i]:=c;
    if i mod 100 = 0 then
    with FormPatience do
      begin
      Gauge.Progress:=i div 100;
      Gauge.Repaint;
      Panel.Repaint;
      end;
    end;
    ChargementDicoOk:=True;
finally
  CloseFile(F);
  FormPatience.Release;
end{try}
end;
//---------------------------------------------------------------------------
destructor TDico.Detruit;
begin
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
Comp:=CompareStr(stMotDico(Taille, iMil), stMot);
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
  Comp:=CompareStr(stMotDico(Taille, iMil), stMot);
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
  Result:=-1 // Rien trouv�
end;
//---------------------------------------------------------------------------
end.
