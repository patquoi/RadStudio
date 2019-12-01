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
      NbLettresAlphabet   =  26;
      NbJetonsSac         = 102;
      NbMaxJetonsTirage   =   7;
      NbMaxPlacesChevalet =  10;
      NbLettresMinMot     = 2;
      NbLettresMaxMot     = NbCasesCote;
      NbLettresDico       = 4031818; // 3942506; // 3942512 // 3867567 // 3791166 // 3688194
	    stVersionDico       = 'ODS8'; // 'ODS7' // 'ODS6' // 'ODS5' // 'ODS4'
      BonusScrabble       = 50;
      NbMaxJokers         = 2;
      MinutesReflexion    = 3;
      VersionFichier      = $1000;

      stNomFichierIni   = 'Duplicata.ini';
      stSectionSac      = 'Sac';
      stJoker           = '?';
      stSuffixeRang : array [0..1] of String = ('er', 'ème');
      ModeAutomatique   = True;
      ModeManuel        = False;
//----------------------------------------------------------------------------
type  TBonus = (bAucun,
                bLettreCompteDouble, bLettreCompteTriple,
                bMotCompteDouble, bMotCompteTriple);
      TCoordonnee = 0..NbCasesCote-1;
      TTypeJeton = (tjIndefini,
                    tjJoker, tjA, tjB, tjC, tjD, tjE, tjF, tjG, tjH,
                    tjI,     tjJ, tjK, tjL, tjM, tjN, tjO, tjP, tjQ,
                    tjR,     tjS, tjT, tjU, tjV, tjW, tjX, tjY, tjZ);
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
      TOrdreJoker          = 1..NbMaxJokers; // Correspond aussi à TNumeroSac pour les jokers
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
      nbl : array [TNbLettres] of Integer          //= (150,1713,9456,36385,99732,209972,357312,497781,581490,583286,506724,385658,259700,158835);
                                                   //= (154,1767,9764,37415,102210,214431,365136,509157,595260,598862,522204,398970,269906,165930);
                                                   //= (160,1830,10036,38225,103908,217490,370632,517203,604870,609796,533616,409383,278488,171930);
                                                   //= (160,1863,10256,39115,106086,221718,377272,525897,615870,621104,543972,417651,284998,176550);
												                           //= (160,1863,10256,39115,106086,221718,377272,525897,615870,621093,543948,417651,285012,176565);
                                                     = (162,1899,10492,39900,107946,225610,384312,536256,629540,635624,558012,428506,292404,181155); // ODS8


      Puiss26 : array [0..4]              of Integer = (1,26,676,17576,456976);
      stNomFichierDico                               = 'L23456789ABCDEF'; // ODS
      stNomFichierRech                               = 'R23456789ABCDEF'; // ODS
      stMsgMotNonValable                             = 'Le mot %s n''est pas valable selon l''ODS8.'#13;
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
const stAutreChoix    = #13#13'Cliquez sur une autre case départ ou changez la sélection des jetons.';
      stFrmSolution   = '%s : %s en %s';
      stCoordonneesIndefinies = ' - ';
      stLibreOccupee  : array [0..1] of String = ('Occupée', 'Libre');
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
var i, j, x : Integer;
    c : array [0..2] of AnsiChar; // RX
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
    Panel.Caption:='Chargement du dictionnaire de mots en cours. Veuillez patienter SVP...';
    Gauge.MaxValue:=(NbLettresDico div 5)-1;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  Reset(F);
  Index[Low(TNbLettres)]:=0;
  for i:=Low(TNbLettres)+1 to High(TNbLettres) do
    Index[i]:=Index[i-1]+nbl[i-1];
  for i:=0 to (NbLettresDico div 5)-1 do
    begin
    for j:=0 to 2 do Read(f, c[j]); // 3 octets = 5 lettres
    x:=Ord(c[0])+256*Ord(c[1])+65536*Ord(c[2]);
    for j:=4 downto 0 do
      begin
      Dico[5*i+j]:=Chr(Ord('A')+x div Puiss26[j]);
      x:=x mod Puiss26[j];
      end;
    if ((i=(NbLettresDico div 5)-1) or
        (i mod (NbLettresDico div 500)=0)) then
      with FormPatience do
        begin
        Gauge.Progress:=i;
        Gauge.Repaint;
        Panel.Repaint;
        end
    end;
    Dico[NbLettresDico-3]:='N'; // ODS8 (3 lettres non stockées);
    Dico[NbLettresDico-2]:='N'; // ODS8 (3 lettres non stockées);
    Dico[NbLettresDico-1]:='E'; // ODS8 (3 lettres non stockées);
    for i:=NbLettresMinMot to NbLettresMaxMot do
      MessageBox(0, pChar('les mots de '+IntToStr(i)+' lettres vont de "'+stMotDico(i, 0)+'" jusqu''à "'+stMotDico(i, (nbl[i] div i)-1)+'"'), 'Vérification', 0);

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
  Result:=-1 // Rien trouvé
end;
//---------------------------------------------------------------------------
end.
