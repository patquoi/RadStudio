unit anagrammes;

interface

const NbMinLettres = 2;
      NbMaxLettres = 15;
      NbMotsDico   = 393670;
      NbTirages    = 327648;

type  TNbLettres = NbMinLettres..NbMaxLettres;
      
const MaxIndexDico    : array[TNbLettres] of Integer = (79,700,3264,11087,28768,60442,107601,166034,227621,284084,329413,361540,381898,393669);
const MaxIndexTirage  : array[TNbLettres] of Integer = (63,545,2341, 7519,19430,41701, 76542,122426,173940,223809,265671,296275,316079,327647);

type  TNbMotsDico = 0..NbMotsDico-1;
      TNbTirages = 0..NbTirages-1;
      TAnagrammes = class(TObject)
      private
        function FNbAnagrammes : Integer;
      public
        iDico : Integer; // Index pour TDico
        Svt   : TAnagrammes;
        constructor Cree(const iPrmMot : Integer);
        destructor Detruit;
        procedure Ajoute(const iMot : Integer);
        property NbAnagrammes : Integer read FNbAnagrammes;
      end;


function TirageMot(const stMot : String) : String;
function IndexDico(const stMot : String) : Integer;
function IndexTirage(const stTirage : String) : Integer;

var ResTir : array[TNbTirages] of TAnagrammes;

implementation

uses dico, tirages;

// Variables pour Initialization
var t, m, iTirage  : Integer;
    stTirage       : String;

function TirageMot(const stMot : String) : String;
var i, j  : Integer;
    c     : Char;
    arMot : array of Char;
begin
SetLength(arMot, Length(stMot));
for i:=0 to Length(stMot)-1 do
  arMot[i]:=stMot[i+1];
for i:=0 to Length(stMot)-2 do
  for j:=i+1 to Length(stMot)-1 do
    if arMot[i]>arMot[j] then
      begin
      c:=arMot[i];
      arMot[i]:=arMot[j];
      arMot[j]:=c;
      end;
Result:='';
for i:=0 to Length(stMot)-1 do
  Result:=Result+arMot[i];
end;

function IndexDico(const stMot : String) : Integer;
var Nbl, iMin, iMax, iCrt : Integer;
begin
Result:=-1; // Pessimiste par défaut : on ne trouve pas
Nbl:=Length(stMot);
if Nbl>2 then
  iMin:=MaxIndexDico[Nbl-1]+1
else
  iMin:=0;
iMax:=MaxIndexDico[Nbl];
iCrt:=(iMin+iMax) div 2;
while (iCrt<>iMin) and (iCrt<>iMax) do
  begin
  if Dictionnaire[iCrt]=stMot then
    begin
    Result:=iCrt;
    Exit
    end;
  if Dictionnaire[iCrt]<stMot then
    iMin:=iCrt
  else
    iMax:=iCrt;
  iCrt:=(iMin+iMax) div 2;
  end;
if Dictionnaire[iMin]=stMot then Result:=iMin;
if Dictionnaire[iMax]=stMot then Result:=iMax;
end;

function IndexTirage(const stTirage : String) : Integer;
var Nbl, iMin, iMax, iCrt : Integer;
begin
Result:=-1; // Pessimiste par défaut : on ne trouve pas
Nbl:=Length(stTirage);
if Nbl>2 then
  iMin:=MaxIndexTirage[Nbl-1]+1
else
  iMin:=0;
iMax:=MaxIndexTirage[Nbl];
iCrt:=(iMin+iMax) div 2;
while (iCrt<>iMin) and (iCrt<>iMax) do
  begin
  if Tirage[iCrt]=stTirage then
    begin
    Result:=iCrt;
    Exit
    end;
  if Tirage[iCrt]<stTirage then
    iMin:=iCrt
  else
    iMax:=iCrt;
  iCrt:=(iMin+iMax) div 2;
  end;
if Tirage[iMin]=stTirage then Result:=iMin;
if Tirage[iMax]=stTirage then Result:=iMax;
end;

constructor TAnagrammes.Cree(const iPrmMot: Integer);
begin
iDico:=iPrmMot;
Svt:=Nil;
end;

destructor TAnagrammes.Detruit;
begin
if Svt<>Nil then
  Svt.Detruit
end;

procedure TAnagrammes.Ajoute(const iMot: Integer);
begin
if Svt<>Nil then
  Svt.Ajoute(iMot)
else
  Svt:=TAnagrammes.Cree(iMot);
end;

function TAnagrammes.FNbAnagrammes : Integer;
begin
 if Svt<>Nil then
   Result:=1+Svt.NbAnagrammes
 else
   Result:=1;
end;

initialization // On initialise ResTir avec les tableaux constants de dico et tirages...

for m:=Low(TNbMotsDico) to High(TNbMotsDico) do
  begin
  stTirage:=TirageMot(Dictionnaire[m]);
  iTirage:=IndexTirage(stTirage);
  if iTirage>-1 then
    if ResTir[iTirage]=nil then
      ResTir[iTirage]:=TAnagrammes.Cree(m)
    else
      ResTir[iTirage].Ajoute(m)
  end;

finalization // On libère la mémoire allouée pour ResTir...

for t:=Low(TNbTirages) to High(TNbTirages) do
  if ResTir[t]<>nil then
      ResTir[t].Free;

end.
