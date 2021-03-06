unit baserechdico;
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
    stTirage : AnsiString; // RX (AnsiString)
    Anagrammes : TAnagrammes;
    Svt : TRechTirage;
    constructor Cree(const stTirage : AnsiString; const Anagrammes : TAnagrammes; const Svt : TRechTirage); // RX (AnsiString)
    destructor Detruit;
    function NbAnagrammes : Integer;
    function Nombre : Integer;
    procedure Ajoute(const stTirage : AnsiString; const iDico : Integer); // RX (AnsiString)
    procedure Sauve;
  end{class TTirage};
  //-------------------------------------------------------------------------
  TRechDico = class
  public
    Dico : TDico;
    NbLettres : array [TNbLettres] of TRechTirage;
    stTiragesMax : String;
    tfa, tft : TextFile;
    constructor Cree;
    destructor Detruit;
    procedure Ajoute(const NbLettres : TNbLettres; const stTirage : String; const iDico : Integer);
    procedure Remplit;
    procedure CreeFichierRechDico(const NbLettres : TNbLettres);
    procedure Sauve;
  end{class TRechDico};
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
constructor TRechTirage.Cree(const stTirage : AnsiString; const Anagrammes : TAnagrammes; const Svt : TRechTirage); // RX (AnsiString)
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
procedure TRechTirage.Ajoute(const stTirage : AnsiString; const iDico : Integer); // RX (AnsiString)
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
    n : AnsiChar; // RX (AnsiChar)
begin
for i:=1 to Length(stTirage) do
  BlockWrite(f, stTirage[i], sizeOf(stTirage[i]));
if Anagrammes<>Nil then
  begin
  n:=AnsiChar(Anagrammes.Nombre); // RX (au lieu de Char)
  BlockWrite(f, n, SizeOf(n));
  Anagrammes.Sauve
  end
else
  begin
  n:=#0; // RX (au lieu de Char)
  BlockWrite(f, n, SizeOf(n));
  end;
if Svt<>Nil then
  Svt.Sauve
end;
//---------------------------------------------------------------------------
constructor TRechDico.Cree;
var i : Integer;
begin
Dico:=TDico.Cree;
for i:=Low(TNbLettres) to High(TNbLettres) do
  NbLettres[i]:=Nil;
Remplit;
AssignFile(f, ExtractFilePath(ParamStr(0))+stNomFichierRech);
try
  Rewrite(f, 1);
  Sauve;
finally
  CloseFile(f)
end
end;
//---------------------------------------------------------------------------
destructor TRechDico.Detruit;
var i : Integer;
begin
Dico.Detruit;
for i:=Low(TNbLettres) to High(TNbLettres) do
  if NbLettres[i]<>Nil then
    NbLettres[i].Detruit
end;
//---------------------------------------------------------------------------
procedure TRechDico.Ajoute(const NbLettres : TNbLettres; const stTirage : String; const iDico : Integer);
begin
if Self.NbLettres[NbLettres]=Nil then
  Self.NbLettres[NbLettres]:=TRechTirage.Cree(stTirage, TAnagrammes.Cree(iDico, Nil), Nil)
else
  Self.NbLettres[NbLettres].Ajoute(stTirage, iDico)
end;
//---------------------------------------------------------------------------
procedure TRechDico.Remplit;
var i, j : Integer;
    stMot, stTirage : String;
  //-------------------------------------------------------------------------
  function stTirageMot(const stMot : String) : String;
  var k, l : Integer;
      ResultK : Char;
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
AssignFile(tfa, ExtractFilePath(ParamStr(0))+'Anagrammes.js');
ReWrite(tfa);
WriteLn(tfa, 'const anagrammes = [[');
AssignFile(tft, ExtractFilePath(ParamStr(0))+'Tirages.js');
ReWrite(tft);
WriteLn(tft, 'const tirages = [[');
with FormPatience do
  try
    Show;
    for i:=Low(TNbLettres) to High(TNbLettres) do
      begin
      Panel.Caption:=Format('Cr�ation du dictionnaire de %d/%d lettres...', [i, High(TNbLettres)]);
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
      CreeFichierRechDico(i);
      end{for};
  finally
    WriteLn(tft, ']]');
    WriteLn(tfa, ']]');
    CloseFile(tft);
    CloseFile(tfa);
    FormPatience.Release;
  end{try}
end;
//---------------------------------------------------------------------------
procedure TRechDico.CreeFichierRechDico(const NbLettres : TNbLettres);
const stSuffixe    : array [TNbLettres] of String = ('R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'RA', 'RB', 'RC', 'RD', 'RE', 'RF');
      stSfxComp    : array [TNbLettres] of String = ('Z2', 'Z3', 'Z4', 'Z5', 'Z6', 'Z7', 'Z8', 'Z9', 'ZA', 'ZB', 'ZC', 'ZD', 'ZE', 'ZF'); // Pour version PDF
      stSfxDico    : array [TNbLettres] of String = ('D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'DA', 'DB', 'DC', 'DD', 'DE', 'DF'); // Dico version PDF
      stTirageVide : array [TNbLettres] of String = ('    ',
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
      NbColonnes : array[TNbLettres] of Integer = (9,7,6,5,4,4,3,3,3,3,2,2,2,2);

var i,na,
    c,nc,
    l,nl,
    p,np : Integer;
    F : TextFile;
    t : TRechTirage;
    a : TAnagrammes;
    stMot,
    stDeb, stFin : String;
    sl,
    slDelta : TStringList; // ODS8

procedure EcritTirageEtMot(const stTirMot, stTirMotPrc : String; const Retour : Boolean);
var p : Integer;
    stAEcrire, stTir, stMot, stTirPrc : String;
begin
p:=AnsiPos(':',stTirMot);
stTir:=copy(stTirMot,1,p-1);
stMot:=copy(stTirMot,p+1,Length(stTirMot)-p);
if slDelta.IndexOf(stMot)>-1 then // ODS8 : on ajoute un ast�risque � c�t� des nouveaux mots
  stMot:=stMot+'*';
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

begin{TRechDico.CreeFichierRechDico}

// ODS8 : on ajoute un ast�risque � c�t� des nouveaux mots
slDelta:=TStringList.Create;
slDelta.LoadFromFile(ExtractFilePath(ParamStr(0))+'delta8.txt');

sl:=TStringList.Create;
sl.Sorted:=True; // Tri en temps r�el plus rapide
// 1. Fichier R*.txt avec 1 anagramme par ligne
AssignFile(f, ExtractFilePath(ParamStr(0))+stSuffixe[NbLettres]+'.txt');
if NbLettres>2 then
  begin
  WriteLn(tfa, ']],[');
  WriteLn(tft, '],[');
  end;
try
  Rewrite(f);
  t:=Self.NbLettres[NbLettres];
  repeat
    a:=t.Anagrammes;
    na:=0;
    repeat
      if a=t.Anagrammes then
        begin
        Write(f, t.stTirage, ': ');
        Write(tft, Format('''%s''', [t.stTirage]));
        Write(tfa, '[');
        end
      else
        Write(f, stTirageVide[NbLettres]);
      stMot:=Dico.stMotDico(NbLettres, a.iDico);
      sl.Add(t.stTirage+':'+stMot);
      WriteLn(f, stMot);
      Write(tfa, Format('%d', [a.iDico]));
      a:=a.Svt;
      Inc(na);
      if a<>Nil then
        Write(tfa, ',');
    until a=Nil;
    if na=20 then
      stTiragesMax:=stTiragesMax+' '+t.stTirage;
    t:=t.Svt;
    if t<>Nil then
      begin
      WriteLn(tft, ',');
      WriteLn(tfa, '],');
      end
  until t=Nil;
finally
  CloseFile(f);
end{try};

// 2. Fichier Z*.txt en colonne et 50 lignes / page
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
    WriteLn(f, 'Tirages de '+IntToStr(Ord(NbLettres))+' lettres de '+stDeb+' � '+stFin+' - Page '+IntToStr(p)+'/'+IntToStr(np));
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

// 3. Fichier D*.txt en colonne et 50 lignes / page
AssignFile(f, ExtractFilePath(ParamStr(0))+stSfxDico[NbLettres]+'.txt');
try
  Rewrite(f);
  nc:=2*NbColonnes[NbLettres];
  nl:=50;
  np:=1+sl.Count div nl div nc;
  for p:=1 to np do
    begin
    stDeb:=Dico.stMotDico(NbLettres, (p-1)*(nl*nc));
    if (p-1)*(nl*nc)+(nc-1)*nl+(nl-1)<nbl[NbLettres] div NbLettres then
      stFin:=Dico.stMotDico(NbLettres, (p-1)*(nl*nc)+(nc-1)*nl+(nl-1))
    else
      stFin:=Dico.stMotDico(NbLettres, nbl[NbLettres] div NbLettres-1);
    WriteLn(f, 'Mots de '+IntToStr(Ord(NbLettres))+' lettres de '+stDeb+' � '+stFin+' - Page '+IntToStr(p)+'/'+IntToStr(np));
    WriteLn(f, '');
    for l:=1 to nl do
      for c:=1 to nc do
        begin
        i:=(p-1)*(nl*nc)+(c-1)*nl+(l-1);
        if i<nbl[NbLettres] div NbLettres then
          begin
          stMot:=Dico.stMotDico(NbLettres, i);
          if slDelta.IndexOf(stMot)>-1 then // ODS8 : on ajoute un ast�risque � c�t� des nouveaux mots
            stMot:=stMot+'*';
          if i=0 then
            Write(f, stMot)
          else
            if c=nc then
              WriteLn(f, stMot)
            else
              Write(f, stMot)
          end
        else
          if c=nc then
            WriteLn(f, '')
          else
            Write(f, '');
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
end{TRehDico.CreeFichierRechDico};
//---------------------------------------------------------------------------
procedure TRechDico.Sauve;
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
