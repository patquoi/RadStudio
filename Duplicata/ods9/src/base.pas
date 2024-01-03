unit base;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
const NbCasesCote         =  15;
      NbLettresMinMot     =   2;
      NbLettresMaxMot     = NbCasesCote;
      NbLettresDico       = 4031818; // ODS8
//----------------------------------------------------------------------------
type
      TNbLettres                = NbLettresMinMot..NbLettresMaxMot;
      TIndexDico                = 0..NbLettresDico-1;
      TDico8 = class
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
//----------------------------------------------------------------------------
const
      Puiss26 : array [0..4] of Integer   = (1,26,676,17576,456976);
      nbl : array [TNbLettres] of Integer = (162,1899,10492,39900,107946,225610,384312,536256,629540,635624,558012,428506,292404,181155); // ODS8
      stFrmFichierIntrouvable             =  'Le fichier %s est introuvable !';
      stErreurInattendue                  = 'Erreur inattendue';
      stNomFichierDico                    = 'L23456789ABCDEF'; // ODS
//----------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses
  System.SysUtils, Vcl.Forms,
  patience_f;
//---------------------------------------------------------------------------
constructor TDico8.Cree;
var i, j, x : Integer;
    c : array [0..2] of AnsiChar; // RX
    F : File of AnsiChar; // RX
    stNomFichier : String;
begin
ChargementDicoOk:=False;
stNomFichier:=ExtractFilePath(ParamStr(0))+'ods8\'+stNomFichierDico;
if not FileExists(stNomFichier) then
  begin
  Application.MessageBox(pChar(Format(stFrmFichierIntrouvable, [stNomFichierDico])), stErreurInattendue);
  Exit
  end;
AssignFile(F, stNomFichier);
FormPatience:=TFormPatience.Create(Nil);
try
  with FormPatience do
    begin
    Panel.Caption:='Chargement du dictionnaire de mots en cours. Veuillez patienter SVP...';
    Gauge.MaxValue:=(NbLettresDico div 5)-1; // v1.8
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  Reset(F);
  Index[Low(TNbLettres)]:=0;
  for i:=Low(TNbLettres)+1 to High(TNbLettres) do
    Index[i]:=Index[i-1]+nbl[i-1];
  for i:=0 to (NbLettresDico div 5)-1 do // v1.8
    begin
    for j:=0 to 2 do Read(f, c[j]); // 3 octets = 5 lettres
    x:=Ord(c[0])+256*Ord(c[1])+65536*Ord(c[2]);
    for j:=4 downto 0 do
      begin
      Dico[5*i+j]:=Chr(Ord('A')+x div Puiss26[j]);
      x:=x mod Puiss26[j];
      end;
    if ((i=(NbLettresDico div 5)-1) or
        (i mod (NbLettresDico div 500)=0)) then // v1.8
      with FormPatience do
        begin
        Gauge.Progress:=i;
        Gauge.Repaint;
        Panel.Repaint;
        end
    end;
    Dico[NbLettresDico-1]:='E'; // le E final a disparu...
    ChargementDicoOk:=True;
finally
  CloseFile(F);
  FormPatience.Release;
end{try}
end;
//---------------------------------------------------------------------------
destructor TDico8.Detruit;
begin
end;
//---------------------------------------------------------------------------
function TDico8.stMotDico(const TailleMot, IndexDico : Integer) : String;
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
function TDico8.Existe(const stMot : String) : Boolean;
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
function TDico8.IndexProchainMot(const IndexDebut : Integer; const stFiltre : String) : Integer;
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
