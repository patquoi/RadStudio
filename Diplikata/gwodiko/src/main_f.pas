unit main_f;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    Splitter: TSplitter;
    Memo2: TMemo;
    Panel1: TPanel;
    ButtonAnalyser: TButton;
    ButtonEnrichir: TButton;
    ButtonGenerer: TButton;
    ButtonCalculer: TButton;
    ButtonGenererJS: TButton;
    procedure ButtonGenererJSClick(Sender: TObject);
    procedure ButtonCalculerClick(Sender: TObject);
    procedure ButtonGenererClick(Sender: TObject);
    procedure ButtonEnrichirClick(Sender: TObject);
    procedure ButtonAnalyserClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonAnalyserClick(Sender: TObject);
var i, j, l, NbMots : Integer;

function stVersionSansAcent(i : Integer) : String;
var p, l : Integer;
begin
Result:=Memo1.Lines[i];
while AnsiPos('�', Result)>0 do
  begin
  p:=AnsiPos('�', Result);
  l:=Length(Result);
  Result:=Copy(Result, 1, p-1)+'A'+Copy(Result, p+1, l);
  end{for i};
while AnsiPos('�', Result)>0 do
  begin
  p:=AnsiPos('�', Result);
  l:=Length(Result);
  Result:=Copy(Result, 1, p-1)+'E'+Copy(Result, p+1, l);
  end{for i};
while AnsiPos('�', Result)>0 do
  begin
  p:=AnsiPos('�', Result);
  l:=Length(Result);
  Result:=Copy(Result, 1, p-1)+'O'+Copy(Result, p+1, l);
  end{for i};
end;

begin
NbMots:=Memo1.Lines.Count;
Memo2.Lines.Add('D�but de l''analyse...');
// 1. On regarde l'ordre alphab�tique
for i:=0 to NbMots-1 do
  begin
  if i>0 then
    if stVersionSansAcent(i)<stVersionSansAcent(i-1) then
      Memo2.Lines.Add(Format('/!\ Le mot "%s" est situ� apr�s le mot "%s" /!\', [Memo1.Lines[i], Memo1.Lines[i-1]]));
  if i<NbMots-1 then
    if stVersionSansAcent(i)>stVersionSansAcent(i+1) then
      Memo2.Lines.Add(Format('/!\ Le mot "%s" est situ� avant le mot "%s" /!\', [Memo1.Lines[i], Memo1.Lines[i+1]]));
  // 2. On regarde les caract�res
  l:=Length(Memo1.Lines[i]);
  for j:=1 to l do
    begin
    if ((Memo1.Lines[i][j]<'A') or (Memo1.Lines[i][j]>'Z') or (Memo1.Lines[i][j]='Q') or (Memo1.Lines[i][j]='X')) and
       (Memo1.Lines[i][j]<>'�') and (Memo1.Lines[i][j]<>'�') and (Memo1.Lines[i][j]<>'�')  then // On autorise l'accent grave invalidant les doubles lettres
      begin
      Memo2.Lines.Add(Format('/!\ Le mot "%s" contient des caract�res incorrects /!\', [Memo1.Lines[i]]));
      break
      end;
    if (Memo1.Lines[i][j]='C') and ((j=l) or (Memo1.Lines[i][j+1]<>'H')) then
      begin
      Memo2.Lines.Add(Format('/!\ Le mot "%s" contient un C qui n''est pas suivi par un H /!\', [Memo1.Lines[i]]));
      break
      end;
    if (Memo1.Lines[i][j]='U') and
       (((j=1) and (Memo1.Lines[i][j+1]<>'I')) or
        ((j=l) and (Memo1.Lines[i][j-1]<>'O')) or
        ((j>1) and (j<l) and (Memo1.Lines[i][j+1]<>'I') and (Memo1.Lines[i][j-1]<>'O'))) then
      begin
      Memo2.Lines.Add(Format('/!\ Le mot "%s" contient un U qui n''est ni pr�c�d� par un O, ni suivi par un I /!\', [Memo1.Lines[i]]));
      break
      end;
    end{for j}
  end{for i};
Memo2.Lines.Add('Analyse termin�e.');
end;

procedure TFormMain.ButtonEnrichirClick(Sender: TObject);
var Trv : Boolean;
    i, j, k, nMots, p, ip, nDL, nRed : Integer;
    c,l,nc,nl,np : Integer;
    pDL : Array [0..7] of Integer;
    stDLCrt, stMot0, stMot,
    stDeb, stFin, stSuiteMot : String;
    fPDF : TextFile;
    slPDF : TStringList; // Pour Liste de mots en PDF VersionDico:VersionJetons
type TDoubleLettre     = (dlAn=1, dlCh, dlEn, dlNg, dlOn, dlOu, dlOun, dlUi); // v1.1 : Ajout du nouveau jeton "Oun" = �
const NbDoublesLettres = 8; // v1.1 : Ajout du nouveau jeton "Oun" = �
const stDL       : Array [TDoubleLettre] of String = ('AN','CH','EN','NG','ON','OU','�N','UI'); // v1.1 : Ajout du nouveau jeton "Oun" = �
      stSL       : Array [TDoubleLettre] of String = ('�', '�', '�', '�', '�', '�' ,'�',  '�');  // v1.1 : Ajout du nouveau jeton "Oun" = �
      stVoyelles = 'AEIOUWY���������'; // Lettres normales (A~Y) + lettres doubles des jetons (�~�) et lettres invalidant la double lettre potentielle (�~�) // v1.1 : Ajout du nouveau jeton "Oun" = �
      Puiss2 : Array [0..7] of Integer = (1,2,4,8,16,32,64,128);

procedure Trie;
var sl : TStringList;
begin
sl := TStringList.Create;
sl.Assign(Memo1.Lines);
sl.Sort;
Memo1.Lines.Assign(sl);
sl.Free
end;

function ConvertitEnJetons(const stMotAccents : String) : String;
var i : Integer;
    stMotJetons : String;
begin
stMotJetons:='';
for i:=1 to Length(stMotAccents) do
  case stMotAccents[i] of
    // Lettres-doubles sur jetons
    '�': stMotJetons:=stMotJetons+'An';
    '�': stMotJetons:=stMotJetons+'Ch';
    '�': stMotJetons:=stMotJetons+'En';
    '�': stMotJetons:=stMotJetons+'Ui';
    '�': stMotJetons:=stMotJetons+'Ng';
    '�': stMotJetons:=stMotJetons+'On';
    '�': stMotJetons:=stMotJetons+'Ou';
    '�': stMotJetons:=stMotJetons+'Oun'; // v1.1 : Ajout du nouveau jeton "Oun" = �
    // Lettres � accents
    '�': stMotJetons:=stMotJetons+'A';
    '�': stMotJetons:=stMotJetons+'E';
    '�': stMotJetons:=stMotJetons+'O';
  else
    stMotJetons:=stMotJetons+stMotAccents[i];
  end;
Result:=stMotJetons;
end;

function ConvertitEnCreole(const stMotAccents : String) : String;
var i : Integer;
    stMotDecompresse : String;
begin
stMotDecompresse:='';
for i:=1 to Length(stMotAccents) do
  case stMotAccents[i] of
    // Lettres-doubles sur jetons
    '�': stMotDecompresse:=stMotDecompresse+'an';
    '�': stMotDecompresse:=stMotDecompresse+'ch';
    '�': stMotDecompresse:=stMotDecompresse+'en';
    '�': stMotDecompresse:=stMotDecompresse+'ui';
    '�': stMotDecompresse:=stMotDecompresse+'ng';
    '�': stMotDecompresse:=stMotDecompresse+'on';
    '�': stMotDecompresse:=stMotDecompresse+'ou';
    '�': stMotDecompresse:=stMotDecompresse+'oun'; // v1.1 : Ajout du nouveau jeton "Oun" = �
    // Lettres � accents
    '�': stMotDecompresse:=stMotDecompresse+'�';
    '�': stMotDecompresse:=stMotDecompresse+'�';
    '�': stMotDecompresse:=stMotDecompresse+'�';
  else
    stMotDecompresse:=stMotDecompresse+LowerCase(stMotAccents[i]);
  end;
Result:=stMotDecompresse;
end;

procedure EcritPossibiliteMot(const stPossibilite, stPossibilitePrc : String; const Retour : Boolean);
var p,pp : Integer;
    stMotOriginal,
    stMotOriginalPrc,
    stMotJetons,
    stPossibiliteAEcrire : String;
begin
p:=AnsiPos(':', stPossibilite);
stMotOriginal:=copy(stPossibilite,1,p-1);
stMotJetons:=copy(stPossibilite,p+1,Length(stPossibilite)-p);
pp:=AnsiPos(':', stPossibilitePrc);
stMotOriginalPrc:=copy(stPossibilitePrc,1,pp-1);
if stMotOriginal=stMotOriginalPrc then
  stPossibiliteAEcrire:=#9+stMotJetons
else
  stPossibiliteAEcrire:=stMotOriginal+#9+stMotJetons;
if retour then
  WriteLn(fPDF, stPossibiliteAEcrire)
else
  Write(fPDF, stPossibiliteAEcrire)
end;

procedure RemplaceChOuUi(i : Integer);
var p,l : Integer;
    stMotOriginal,
    stMotJetons : String;
begin
stMotOriginal:=ConvertitEnCreole(Memo1.Lines[i]);
while AnsiPos('CH', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('CH', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'�'+Copy(Memo1.Lines[i], p+2, l);
  end{for i};
while AnsiPos('OU', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('OU', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'�'+Copy(Memo1.Lines[i], p+2, l);
  end{for i};
while AnsiPos('UI', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('UI', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'�'+Copy(Memo1.Lines[i], p+2, l);
  end{for i};
stMotJetons:=ConvertitEnJetons(Memo1.Lines[i]);
slPDF.Add(stMotOriginal+':'+stMotJetons);
end;

procedure RetireAccentsGraves(i : Integer);
var p, l : Integer;
begin
while AnsiPos('�', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('�', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'A'+Copy(Memo1.Lines[i], p+1, l);
  end{for i};
while AnsiPos('�', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('�', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'E'+Copy(Memo1.Lines[i], p+1, l);
  end{for i};
while AnsiPos('�', Memo1.Lines[i])>0 do
  begin
  p:=AnsiPos('�', Memo1.Lines[i]);
  l:=Length(Memo1.Lines[i]);
  Memo1.Lines[i]:=Copy(Memo1.Lines[i], 1, p-1)+'O'+Copy(Memo1.Lines[i], p+1, l);
  end{for i};
end;

function DoubleLettreAutorisee(iDL : TDoubleLettre; stFinMot, stMot : String) : Boolean;
var p : Integer;
begin
p:=AnsiPos(stDL[iDL], stFinMot);
case iDL of
  dlAn,dlEn,   // R�gle jetons An, En, On : doit �tre suivis d'une consonne
  dlOn, dlOun: // v1.3: Oun aussi
                  if (Length(stFinMot)=p+1) or
                     (AnsiPos(copy(stFinMot,p+2,1),stVoyelles)=0) then
                     Result:=True
                  else
                     Result:=False;
  // R�gle jeton Ng : jeton final + pr�c�d� d'une voyelle
  dlNg:           if (p=Length(stFinMot)-1) and
                     (AnsiPos(Copy(stMot,Length(stMot)-2,1),'I')>0) then // v1.3 : pr�c�d� d'un "I" et non plus simplement une voyelle
                     Result:=True
                  else
                     Result:=False;
else
  Result:=True
end{case of};
end;

begin{TFormMain.ButtonEnrichirClick}
slPDF:=TStringList.Create; // On triera � la fin
Memo2.Clear;
Memo2.Lines.Add('Remplacement de CH,OU,UI respectivement par �,�,�...');
nMots:=Memo1.Lines.Count-1; // On stocke le nombre de mots car on ajoute les nouveaux mots au bout de la liste !
// A. Pour chaque mot...
for i:=0 to nMots do
  // A1. On remplace C et U
  RemplaceChOuUi(i);

Memo2.Lines.Add('Ajout des combinaisons AN,CH,EN,NG,ON,�N...');
// B. Pour chaque mot...
for i:=0 to nMots do
  begin
  for j:=0 to 7 do pDL[j]:=0;
  stMot0:=Memo1.Lines[i]; // Mot original avant r�duction
  stSuiteMot:=stMot0;
  nDL:=0;

  // B1. On calcule le nombre et la position des doubles lettres dans l'ordre des lettres du mot
  for k:=1 to Length(stMot0)-1 do // Pour chaque position de lettre...
    for j:=1 to NbDoublesLettres do // Pour chaque double lettre possible
      begin
      stDLCrt:=stDL[TDoubleLettre(j)]; // Merci d�bogueur Delphi qui n'arrive pas � lire j comme il faut !
      if (AnsiPos(stDLCrt, stSuiteMot)>0) and
         (AnsiPos(stDLCrt, stSuiteMot)+Length(stMot0)-Length(stSuiteMot)=k) and
         DoubleLettreAutorisee(TDoubleLettre(j), stSuiteMot, stMot0) then // Y a-t-il une double lettre � traiter ?
        begin
        pDL[nDL]:=k;
        Inc(nDL);
        stSuiteMot:=Copy(stMot0, k+1, Length(stMot0)-k); // On ne retire que la premi�re des doubles-lettres (� cause de lettres communes entre doubles lettres comme dans ANG = AN+NG)
        break;
        end{if AnsiPos};
      end{for j};
    {for k}
  if nDL>0 then
  // B2. Pour chaque combinaison de mot - soit 2^(nDL-1) - On ajoute les nouvelles combinaison (avec au moins une r�duction de double lettre, la version longue existant d�j�)
    for p:=1 to Puiss2[nDL]-1 do
      begin
      stMot:=stMot0; // stMot = mot r�duit au fur et � mesure
      stSuiteMot:=stMot0; // stSuiteMot, suite du mot � traiter
      nRed:=0;
      // On traite - ou pas - chaque double lettre selon la combinaison (p)
      for ip:=0 to nDL-1 do
        if (p and Puiss2[ip])>0 then // Doit-on traiter la double lettre ou non ?
          begin
          Trv:=false;
          for j:=1 to NbDoublesLettres do
            begin
            stDLCrt:=stDL[TDoubleLettre(j)]; // Merci d�bogueur Delphi qui n'arrive pas � lire j comme il faut !
            k:=AnsiPos(stDLCrt, stSuiteMot)+Length(stMot0)-Length(stSuiteMot);
            if (AnsiPos(stDLCrt, stSuiteMot)>0) and (k=pDL[ip]) then // C'est la bonne double lettre � traiter (en retirant les r�ductions pr�c�dentes)
              begin
              if stMot[k-nRed]=stDLCrt[1] then // On v�rifie que la premi�re lettre � remplacer est bien la premi�re lettre de la double-lettre correspondance � cause de la 3�me possiblit� de ANG impossible � r�aliser (le N est commun)
                stMot:=Copy(stMot, 1, k-1-nRed)+stSL[TDoubleLettre(j)]+Copy(stMot, k+2-nRed, Length(stMot)-2);
              stSuiteMot:=Copy(stMot0, pDL[ip]+1, Length(stMot0)-pDL[ip]); // On ne retire que la premi�re des doubles-lettres (� cause de lettres communes entre doubles lettres comme dans ANG = AN+NG)
              Inc(nRed);
              Trv:=True;
              end;
             if Trv then break;
            end{for j}
          end{if p and 2^ip>0}
        else // M�me si l'on r�duit pas le mot, il faut quand m�me calculer la suite du mot
          stSuiteMot:=Copy(stMot0, pDL[ip]+1, Length(stMot0)-pDL[ip]); // On ne retire que la premi�re des doubles-lettres (� cause de lettres communes entre doubles lettres comme dans ANG = AN+NG)
        {for ip}
      if (Length(stMot)>1) and (Memo1.Lines.IndexOf(stMot)=-1) then
        begin
        Memo1.Lines.Add(stMot);
        slPDF.Add(ConvertitEnCreole(stMot0)+':'+ConvertitEnJetons(stMot));
        end
      end{for p}
    {if nDL>0}
  end{for i};

Memo2.Lines.Add('Remplacement de �,�,� respectivement par A,E,O...');
nMots:=Memo1.Lines.Count-1; // On stocke le nombre de mots car on ajoute les nouveaux mots au bout de la liste !

// C. Pour chaque mot...
for i:=0 to nMots do
  // A1. On remplace � par A ; � par E et � par O
  RetireAccentsGraves(i);

// D. On retrie la liste de mots compl�t�e des mots r�duits
Memo2.Lines.Add('Tri de la liste...');
Trie;
Memo2.Lines.Add('Enrichissement du fichier termin�.');

// E. Cr�ation d'un diko Kreyol<->Diplikata avec toutes les formations possible d'un mot avec des jetons
Memo2.Lines.Add('Cr�ation du dictionnaire Version Kreyol<->Version Diplikata...');
AssignFile(fPDF, ExtractFilePath(Application.ExeName)+'..\Ofisyeldiksyone.txt');
try
  slPDF.Sort;
  Rewrite(fPDF);
  nc:=2;
  nl:=52; // nl:=54 sans en-t�te
  np:=1+slPDF.Count div nl div nc;
  for p:=1 to np do
    begin
    stDeb:=copy(slPDF[(p-1)*(nl*nc)],1,AnsiPos(':',slPDF[(p-1)*(nl*nc)])-1);
    if (p-1)*(nl*nc)+(nc-1)*nl+(nl-1)<slPDF.Count then
      stFin:=copy(slPDF[(p-1)*(nl*nc)+(nc-1)*nl+(nl-1)],1,AnsiPos(':',slPDF[(p-1)*(nl*nc)+(nc-1)*nl+(nl-1)])-1)
    else
      stFin:=copy(slPDF[slPDF.Count-1],1,AnsiPos(':',slPDF[slPDF.Count-1])-1);
    WriteLn(fPDF, stDeb+' - '+stFin);
    WriteLn(fPDF, '');
    for l:=1 to nl do
      for c:=1 to nc do
        begin
        i:=(p-1)*(nl*nc)+(c-1)*nl+(l-1);
        if i<slPDF.Count then
          begin
          if i=0 then
            EcritPossibiliteMot(slPDF[i], '', False)
          else
            EcritPossibiliteMot(slPDF[i], slPDF[i-1], c=nc);
          end
        else
          EcritPossibiliteMot('', '!', c=nc);
        if c<nc then
          write(fPDF, #9);
        end;
    end;
finally
  CloseFile(fPDF);
  slPDF.Free;
end;
Memo2.Lines.Add('Cr�ation du dictionnaire termin�e.');
end{TFormMain.ButtonEnrichirClick};

procedure TFormMain.ButtonGenererClick(Sender: TObject);
var i, j, k, l, n, TailleMax : Integer;
    F : TextFile;

const NbDoublesLettres = 8; // v1.1 : Ajout du nouveau jeton "Oun" = �
const stDL   : Array [1..NbDoublesLettres] of String = ('AN','CH','EN','NG','ON','OU','�N','UI'); // v1.1 : Ajout du nouveau jeton "Oun" = �
      stSL   : Array [1..NbDoublesLettres] of String = ('�', '�', '�', '�', '�', '�' ,'�',  '�'); // v1.1 : Ajout du nouveau jeton "Oun" = �
      Puiss2 : Array [0..7] of Integer = (1,2,4,8,16,32,64,128);
procedure Trie;
var sl : TStringList;
begin
sl := TStringList.Create;
sl.Assign(Memo1.Lines);
sl.Sort;
Memo1.Lines.Assign(sl);
sl.Free
end;
begin

// A. On trie
Memo2.Lines.Add('Tri de la liste...');
Trie;

// B. On v�rifie qu'il n'y a pas de doublons...
Memo2.Lines.Add('V�rification de l''absence de doublons...');
for i:=1 to Memo1.Lines.Count-1 do
  if Memo1.Lines[i]=Memo1.Lines[i-1] then
    Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" doublonne /!\');

// C1. On v�rifie qu'il n'y a pas de C,U,Q,X...
Memo2.Lines.Add('V�rification de l''absence de C,Q,U et X...');
for i:=0 to Memo1.Lines.Count-1 do
  begin
  if AnsiPos('C',Memo1.Lines[i])>0 then
    Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" poss�de un "C" /!\');
  if AnsiPos('Q',Memo1.Lines[i])>0 then
    Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" poss�de un "Q" /!\');
  if AnsiPos('U',Memo1.Lines[i])>0 then
    Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" poss�de un "U" /!\');
  if AnsiPos('X',Memo1.Lines[i])>0 then
    Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" poss�de un "X" /!\');
  end;
// C2. On v�rifie qu'il n'y a pas de caract�re parasite...
for i:=0 to Memo1.Lines.Count-1 do
  begin
  l:=Length(Memo1.Lines[i]);
  for j:=1 to l do
    case Memo1.Lines[i][j] of
      'A'..'Z','�','�','�','�','�','�','�','�': begin  // v1.1 : Ajout du nouveau jeton "Oun" = �
                                            end
    else
      Memo2.Lines.Add(' /!\ le Mot "'+Memo1.Lines[i]+'" poss�de un caract�re interdit /!\');
    end
  end;
// D. On calcule le nombre de tailles de mots
Memo2.Lines.Add('Calcul de la taille maximale des mots...');
TailleMax:=2;
for i:=0 to Memo1.Lines.Count-1 do
  if Length(Memo1.Lines[i])>TailleMax then TailleMax:=Length(Memo1.Lines[i]);
if (TailleMax>15) then TailleMax:=15;
Memo2.Lines.Add(Format('Taille max : %d.', [TailleMax]));

// E. On cr��e le fichier final avec une ligne par taille de mots (les mots sont concat�n�s les uns derri�re les autres)
Memo2.Lines.Add('Cr�ation du fichier final...');
AssignFile(F, ExtractFilePath(Application.ExeName)+'..\Gwodikovilsen');
Rewrite(F);
n:=0;
For i:=2 to TailleMax do
  begin
  k:=0;
  For j:=0 to Memo1.Lines.Count-1 do
    if Length(Memo1.Lines[j])=i then
      begin
      Write(F, Memo1.Lines[j]);
      Inc(k); Inc(n, i);
      end;
  Memo2.Lines.Add(Format(' > Il y a %d mots de %d lettres soit %d lettres.', [k, i, k*i]));
  end;
Memo2.Lines.Add(Format(' > Le fichier contient %d lettres.', [n]));
CloseFile(F);
Memo2.Lines.Add('Traitement du fichier termin�.');
end;

procedure TFormMain.ButtonCalculerClick(Sender: TObject);
const OrdMin = 65; OrdMax = 220; // v1.1 : "Oun" = � = 220 !
var n : Array [OrdMin..OrdMax] of Integer;
    p : Array [OrdMin..OrdMax] of Integer;
    i, j, l, nl, pMax : Integer;
begin
nl:=0;
for i:=OrdMin to OrdMax do
  begin
  n[i]:=0;
  p[i]:=0;
  end;
For i:=0 to Memo1.Lines.Count-1 do
  begin
  l:=Length(Memo1.Lines[i]);
  for j:=1 to l do
    begin
    Inc(n[Ord(Memo1.Lines[i][j])]);
    Inc(nl);
    end;
  end;
// Classement
pMax:=0;
for i:=OrdMin to OrdMax do
  for j:=OrdMin to OrdMax do
    if n[i]<n[j] then
      begin
      Inc(p[i]);
      if p[i]>pMax then pMax:=p[i];
      end;
for i:=0 to pMax do
  for j:=OrdMin to OrdMax do
    if (p[j]=i) and (n[j]>0) then
      Memo2.Lines.Add(Format('%d. Jeton %s : %d sur %d soit %.2f%%.', [i+1, Chr(j), n[j], nl, (100.0*n[j])/nl]));
end;

procedure TFormMain.ButtonGenererJSClick(Sender: TObject);
var i, l, dl : Integer;
    sl : TStringList;
    tf : TextFile;
begin //
// Pour les jeux de lettres en Javascript...
sl := TStringList.Create;
sl.Sorted:=True;
Memo2.Lines.Add('Cr�ation du fichier Dico.js...');
AssignFile(tf, ExtractFilePath(Application.ExeName)+'..\Dico.js');
ReWrite(tf);
Write(tf, 'const dico = [[');
sl.Clear;
sl.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\gwodikovilsenenrichi.txt');
dl:=0;
try
  for l:=2 to 15 do
    begin
    for i:=0 to sl.Count-1 do
      if length(sl[i]) = l then
        begin
        if dl=l then WriteLn(tf, ',') else dl:=l;
        Write(tf, Format('''%s''', [sl[i]]))
        end;
    if l<15 then
      WriteLn(tf, '],[')
    else
      WriteLn(tf, ']];');
    end;
finally
  CloseFile(tf);
  Memo2.Lines.Add('Fin de cr�ation du fichier Dico.js.');
end;
Memo2.Lines.Add('Cr�ation du fichier Diko.js...');
AssignFile(tf, ExtractFilePath(Application.ExeName)+'..\Diko.js');
ReWrite(tf);
WriteLn(tf, 'const diko = [[');
sl.Clear;
sl.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\gwodikovilsen.txt');
dl:=0;
try
  for l:=2 to 15 do
    begin
    for i:=0 to sl.Count-1 do
      if length(sl[i]) = l then
        begin
        if dl=l then WriteLn(tf, ',') else dl:=l;
        Write(tf, Format('''%s''', [sl[i]]))
        end;
    if l<15 then
      WriteLn(tf, '],[')
    else
      WriteLn(tf, ']];');
    end;
finally
  sl.Free;
  CloseFile(tf);
  Memo2.Lines.Add('Fin de cr�ation du fichier Diko.js.');
end;
end;

end.
