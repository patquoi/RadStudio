unit baserechdiko;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  base;
//---------------------------------------------------------------------------
type
  TAnagrammes = class
  public
    iDico : Integer; // Index dans base.TDico.Dico
    Svt : TAnagrammes;
    constructor Cree(const iDico : Integer; const Svt : TAnagrammes);
    destructor Detruit;
    function Nombre : Integer;
    procedure Ajoute(const iDico : Integer);
    procedure Sauve;
  end{TAnagrammes};
  //-------------------------------------------------------------------------
  TRechTirage = class
  public
    stTirage : AnsiString; // RX (Ansi)
    Anagrammes : TAnagrammes;
    Svt : TRechTirage;
    constructor Cree(const stTirage : AnsiString; const Anagrammes : TAnagrammes; const Svt : TRechTirage); // RX (Ansi)
    destructor Detruit;
    function NbAnagrammes : Integer;
    function Nombre : Integer;
    procedure Ajoute(const stTirage : AnsiString; const iDico : Integer); // RX (Ansi)
    procedure Sauve;
  end{class TTirage};
  //-------------------------------------------------------------------------
  TRechDiko = class
  public
    Dico : TDico;
    NbLettres : array [TNbLettres] of TRechTirage;
    tfa, tft : TextFile; // 20180722 : Pour app Javascrip
    constructor Cree;
    destructor Detruit;
    procedure Ajoute(const NbLettres : TNbLettres; const stTirage : AnsiString; const iDico : Integer); // RX (Ansi)
    procedure Remplit;
    procedure CreeFichierRechDiko(const NbLettres : TNbLettres);
    procedure Sauve;
  end{class TRechDiko};
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses Classes, SysUtils, StrUtils, patience_f;
//---------------------------------------------------------------------------
var f : File;
//---------------------------------------------------------------------------
constructor TAnagrammes.Cree(const iDico : Integer; const Svt : TAnagrammes);
begin
Self.iDico:=iDico;
Self.Svt:=Svt;
end;
//---------------------------------------------------------------------------
destructor TAnagrammes.Detruit;
begin
if Svt<>nil then
  Svt.Detruit;
end;
//---------------------------------------------------------------------------
function TAnagrammes.Nombre : Integer;
begin
if Svt=Nil then
  Result:=1
else
  Result:=1+Svt.Nombre;
end;
//---------------------------------------------------------------------------
procedure TAnagrammes.Ajoute(const iDico : Integer);
var NvSvt : TAnagrammes;
begin
if Self.iDico>iDico then
  begin
  NvSvt:=Svt;
  Self.Svt:=TAnagrammes.Cree(Self.iDico, NvSvt);
  Self.iDico:=iDico;
  end
else // Self.stTirage<stTirage
  if Svt=Nil then
    Svt:=TAnagrammes.Cree(iDico, Nil)
  else
    Svt.Ajoute(iDico)
end;
//---------------------------------------------------------------------------
procedure TAnagrammes.Sauve;
var i : Word;
begin
i:=Word(iDico);
BlockWrite(f, i, SizeOf(i));
if Svt<>Nil then
  Svt.Sauve
end;
//---------------------------------------------------------------------------
constructor TRechTirage.Cree(const stTirage : AnsiString; const Anagrammes : TAnagrammes; const Svt : TRechTirage); // RX (Ansi)
begin
Self.stTirage:=stTirage;
Self.Anagrammes:=Anagrammes;
Self.Svt:=Svt;
end;
//---------------------------------------------------------------------------
destructor TRechTirage.Detruit;
begin
if Anagrammes<>Nil then
  Anagrammes.Detruit;
if Svt<>nil then
  Svt.Detruit;
end;
//---------------------------------------------------------------------------
function TRechTirage.Nombre : Integer;
begin
if Svt=Nil then
  Result:=1
else
  Result:=1+Svt.Nombre;
end;
//---------------------------------------------------------------------------
function TRechTirage.NbAnagrammes : Integer;
begin
if Anagrammes=Nil then
  Result:=0
else
  Result:=Anagrammes.Nombre;
end;
//---------------------------------------------------------------------------
procedure TRechTirage.Ajoute(const stTirage : AnsiString; const iDico : Integer); // RX (Ansi)
var NvSvt : TRechTirage;
begin
if Self.stTirage=stTirage then
  if Anagrammes=Nil then
    Anagrammes:=TAnagrammes.Cree(iDico, Nil)
  else
    Anagrammes.Ajoute(iDico)
else
  if Self.stTirage>stTirage then
    begin
    NvSvt:=Svt;
    Self.Svt:=TRechTirage.Cree(Self.stTirage, Self.Anagrammes, NvSvt);
    Self.stTirage:=stTirage;
    Self.Anagrammes:=TAnagrammes.Cree(iDico, Nil);
    end
  else // Self.stTirage<stTirage
    if Svt=Nil then
      Svt:=TRechTirage.Cree(stTirage, TAnagrammes.Cree(iDico, Nil), Nil)
    else
      Svt.Ajoute(stTirage, iDico);
end;
//---------------------------------------------------------------------------
procedure TRechTirage.Sauve;
var i : Integer;
    n : AnsiChar; // RX (Ansi)
begin
for i:=1 to Length(stTirage) do
  BlockWrite(f, stTirage[i], sizeOf(stTirage[i]));
if Anagrammes<>Nil then
  begin
  n:=AnsiChar(Anagrammes.Nombre); // RX (Ansi)
  BlockWrite(f, n, SizeOf(n));
  Anagrammes.Sauve
  end
else
  begin
  n:=AnsiChar(0); // RX (Ansi)
  BlockWrite(f, n, SizeOf(n));
  end;
if Svt<>Nil then
  Svt.Sauve
end;
//---------------------------------------------------------------------------
constructor TRechDiko.Cree;
var i : Integer;
begin
Dico:=TDico.Cree;
for i:=Low(TNbLettres) to High(TNbLettres) do
  NbLettres[i]:=Nil;
Remplit;
AssignFile(f, ExtractFilePath(ParamStr(0))+'R23456789ABCDEF');
try
  Rewrite(f, 1);
  Sauve;
finally
  CloseFile(f)
end
end;
//---------------------------------------------------------------------------
destructor TRechDiko.Detruit;
var i : Integer;
begin
Dico.Detruit;
for i:=Low(TNbLettres) to High(TNbLettres) do
  if NbLettres[i]<>Nil then
    NbLettres[i].Detruit
end;
//---------------------------------------------------------------------------
procedure TRechDiko.Ajoute(const NbLettres : TNbLettres; const stTirage : AnsiString; const iDico : Integer); // RX (Ansi)
begin
if Self.NbLettres[NbLettres]=Nil then
  Self.NbLettres[NbLettres]:=TRechTirage.Cree(stTirage, TAnagrammes.Cree(iDico, Nil), Nil)
else
  Self.NbLettres[NbLettres].Ajoute(stTirage, iDico)
end;
//---------------------------------------------------------------------------
procedure TRechDiko.Remplit;
var i, j : Integer;
    stMot, stTirage : AnsiString; // RX (Ansi)
  //-------------------------------------------------------------------------
  function stTirageMot(const stMot : AnsiString) : AnsiString; // RX (Ansi)
  var k, l : Integer;
      ResultK : AnsiChar; // RX (Ansi)
  begin
  Result:=stMot;
  for k:=1 to Length(stMot)-1 do
    for l:=k+1 to Length(stMot) do
      if Result[k]>Result[l] then
        begin
        ResultK:=Result[k];
        Result[k]:=Result[l];
        Result[l]:=ResultK
        end
  end;
  //-------------------------------------------------------------------------
begin
FormPatience:=TFormPatience.Create(Nil);
// deb 20180722 : Pour app Javascript
AssignFile(tfa, 'Anagrammes.js');
ReWrite(tfa);
WriteLn(tfa, 'const anagrammes = [[');
AssignFile(tft, 'Tirages.js');
ReWrite(tft);
WriteLn(tft, 'const tirages = [[');
// fin 20180722 : Pour app Javascript
with FormPatience do
  try
    Show;
    for i:=Low(TNbLettres) to High(TNbLettres) do
      begin
      Panel.Caption:=Format('Création du dictionnaire de %d/%d lettres...', [i, High(TNbLettres)]);
      Panel.Repaint;
      Gauge.MinValue:=0;
      Gauge.MaxValue:=nbl[i] div i-1;
      for j:=0 to nbl[i] div i-1 do
        begin
        stMot:=Dico.stMotDico(i, j);
        stTirage:=stTirageMot(stMot);
        Ajoute(i, stTirage, j);
        Gauge.Progress:=j;
        Gauge.Repaint
        end;
      CreeFichierRechDiko(i);
      end{for};
  finally
    // deb 20180722 : Pour app Javascript
    WriteLn(tft, ']];');
    WriteLn(tfa, ']]];');
    CloseFile(tft);
    CloseFile(tfa);
    // fin 20180722 : Pour app Javascript
    FormPatience.Release;
  end{try}
end;
//---------------------------------------------------------------------------
procedure TRechDiko.CreeFichierRechDiko(const NbLettres : TNbLettres);
const stSuffixe    : array [TNbLettres] of AnsiString = ('R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'RA', 'RB', 'RC', 'RD', 'RE', 'RF'); // RX (Ansi)
      stSfxComp    : array [TNbLettres] of AnsiString = ('Z2', 'Z3', 'Z4', 'Z5', 'Z6', 'Z7', 'Z8', 'Z9', 'ZA', 'ZB', 'ZC', 'ZD', 'ZE', 'ZF'); // RX (Ansi)
      stTirageVide : array [TNbLettres] of AnsiString = ('    ',
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
                                                         '               ',
                                                         '                ',
                                                         '                 ');
      NbColonnes : array[TNbLettres] of Integer = (4,5,3,3,3,2,2,2,2,2,2,2,1,1);

var i,
    c,nc,
    l,nl,
    p,np : Integer;
    F : TextFile;
    t : TRechTirage;
    a : TAnagrammes;
    stMot,
    stDeb, stFin : AnsiString; // RX (Ansi)
    sl : TStringList;

function DecompresseLettres(const stTirage, stMot : AnsiString) : AnsiString; // RX (Ansi)
var i,j : Integer;
    stTirMot : AnsiString;
begin
stTirMot:='';
for i:=1 to Length(stTirage) do
  case stTirage[i] of
    'Â': stTirMot:=stTirMot+'An';
    'Ç': stTirMot:=stTirMot+'Ch';
    'Ê': stTirMot:=stTirMot+'En';
    'Î': stTirMot:=stTirMot+'Ui';
    'Ñ': stTirMot:=stTirMot+'Ng';
    'Ô': stTirMot:=stTirMot+'On';
    'Û': stTirMot:=stTirMot+'Ou';
  else
    stTirMot:=stTirMot+stTirage[i];
  end;

// On retrie le tirage en tenant compte des doubles lettres
for i:=2 to Length(stTirMot) do
  if stTirMot[i]>'Z' then
    for j:=1 to i-2 do
      if (stTirMot[j]<='Z') and (stTirMot[i-1]<stTirMot[j]) then
        stTirMot:=copy(stTirMot,1,j-1)+stTirMot[i-1]+stTirMot[i]+copy(stTirMot,j,i-j-1)+copy(stTirMot,i+1,Length(stTirMot)-i);
stTirMot:=stTirMot+':';
for i:=1 to Length(stMot) do
  case stMot[i] of
    'Â': stTirMot:=stTirMot+'An';
    'Ç': stTirMot:=stTirMot+'Ch';
    'Ê': stTirMot:=stTirMot+'En';
    'Î': stTirMot:=stTirMot+'Ui';
    'Ñ': stTirMot:=stTirMot+'Ng';
    'Ô': stTirMot:=stTirMot+'On';
    'Û': stTirMot:=stTirMot+'Ou';
  else
    stTirMot:=stTirMot+stMot[i];
  end;
Result:=stTirMot;
end;

procedure EcritTirageEtMot(const stTirMot, stTirMotPrc : AnsiString; const Retour : Boolean); // RX (Ansi)
var p : Integer;
    stAEcrire, stTir, stMot, stTirPrc : AnsiString; // RX (Ansi)
begin
p:=AnsiPos(':',stTirMot);
stTir:=copy(stTirMot,1,p-1);
stMot:=copy(stTirMot,p+1,Length(stTirMot)-p);
stTirPrc:=copy(stTirMotPrc,1,AnsiPos(':',stTirMotPrc)-1);
if stTirPrc=stTir then
  stAEcrire:=#9+stMot
else
  stAEcrire:=stTir+':'#9+stMot;
if Retour then
  WriteLn(f, stAEcrire)
else
  Write(f, stAEcrire);
end;

begin{TRechDiko.CreeFichierRechDiko}
sl:=TStringList.Create;
// 1. Fichier R*.txt avec 1 lettre par jeton et 1 anagramme par ligne
AssignFile(f, ExtractFilePath(ParamStr(0))+stSuffixe[NbLettres]+'.txt');
// deb 20180722 : Pour app Javascript
if NbLettres>2 then
  begin
  WriteLn(tfa, ']],[');
  WriteLn(tft, '],[');
  end;
// fin 20180722 : Pour app Javascript
try
  Rewrite(f);
  t:=Self.NbLettres[NbLettres];
  repeat
    a:=t.Anagrammes;
    repeat
      if a=t.Anagrammes then
        begin
        Write(f, t.stTirage, ': ');
        // deb 20180722 : Pour app Javascript
        Write(tft, Format('''%s''', [t.stTirage]));
        Write(tfa, '[');
        // fin 20180722 : Pour app Javascript
        end
      else
        Write(f, stTirageVide[NbLettres]);
      stMot:=Dico.stMotDico(NbLettres, a.iDico);
      sl.Add(DecompresseLettres(t.stTirage, stMot));
      WriteLn(f, stMot);
      // deb 20180722 : Pour app Javascript
      Write(tfa, Format('%d', [a.iDico]));
      // fin 20180722 : Pour app Javascript
      a:=a.Svt;
      // deb 20180722 : Pour app Javascript
      if a<>Nil then
        Write(tfa, ',');
      // fin 20180722 : Pour app Javascript
    until a=Nil;
    t:=t.Svt;
    // deb 20180722 : Pour app Javascript
    if t<>Nil then
      begin
      WriteLn(tft, ',');
      WriteLn(tfa, '],');
      end
    // fin 20180722 : Pour app Javascript
  until t=Nil;
finally
  CloseFile(f);
end{try};

// 2. Fichier Z*.txt avec 2ème lettre de jeton en minuscule, en colonne et 25 lignes / page
sl.Sorted:=True;
AssignFile(f, ExtractFilePath(ParamStr(0))+stSfxComp[NbLettres]+'.txt');
try
  Rewrite(f);
  nc:=NbColonnes[NbLettres];
  nl:=50;
  np:=1+sl.Count div nl div nc;
  for p:=1 to np do
    begin
    stDeb:=copy(sl[(p-1)*(nl*nc)],1,AnsiPos(':',sl[(p-1)*(nl*nc)])-1);
    if (p-1)*(nl*nc)+(nc-1)*nl+(nl-1)<sl.Count then
      stFin:=copy(sl[(p-1)*(nl*nc)+(nc-1)*nl+(nl-1)],1,AnsiPos(':',sl[(p-1)*(nl*nc)+(nc-1)*nl+(nl-1)])-1)
    else
      stFin:=copy(sl[sl.Count-1],1,AnsiPos(':',sl[sl.Count-1])-1);
    WriteLn(f, 'Tirages de '+IntToStr(Ord(NbLettres))+' lettres de '+stDeb+' à '+stFin+' - Page '+IntToStr(p)+'/'+IntToStr(np));
    WriteLn(f, '');
    for l:=1 to nl do
      for c:=1 to nc do
        begin
        i:=(p-1)*(nl*nc)+(c-1)*nl+(l-1);
        if i<sl.Count then
          begin
          if i=0 then
            EcritTirageEtMot(sl[i], '', False)
          else
            EcritTirageEtMot(sl[i], sl[i-1], c=nc);
          end
        else
          EcritTirageEtMot('', '!', c=nc);
        if c<nc then
          write(f, #9);
        end;
    WriteLn(f, '');
    WriteLn(f, '');
    end
finally
  CloseFile(f);
end;
sl.Free
end{TRechDiko.CreeFichierRechDiko};
//---------------------------------------------------------------------------
procedure TRechDiko.Sauve;
var i, n : Integer;
begin
for i:=Low(TNbLettres) to High(TNbLettres) do
  if NbLettres[i]<>Nil then
    begin
    n:=NbLettres[i].Nombre;
    BlockWrite(f, n, SizeOf(n));
    NbLettres[i].Sauve
    end
  else
    begin
    n:=0;
    BlockWrite(f, n, SizeOf(n));
    end
end;
//---------------------------------------------------------------------------
end.
