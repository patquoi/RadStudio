unit main_f;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
uses
  base, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;
//----------------------------------------------------------------------------
const
  NbLettresDico8  = 4031818;
//----------------------------------------------------------------------------
type
  TIndexDico8 = 0..NbLettresDico8-1;
  TDico8 = class
  private
    Index : array [TNbLettres] of Integer;
    Dico  : array [TIndexDico8] of Char;
  public
    ChargementDicoOk : Boolean;
    constructor Cree;
    destructor  Detruit;
    procedure Charge;
    function Existe(const stMot : String) : Boolean;
    function stMotDico(const TailleMot, IndexDico : Integer) : String;
  end{class TDico};
//----------------------------------------------------------------------------
  TFormMain = class(TForm)
    StatusBar: TStatusBar;
    Panel: TPanel;
    MemoDP: TMemo;
    Splitter: TSplitter;
    MemoDM: TMemo;
    PanelButtons: TPanel;
    MemoInfos: TMemo;
    ButtonImporter: TButton;
    ButtonGenereL: TButton;
    ButtonCalculerStats: TButton;
    procedure ButtonImporterClick(Sender: TObject);
    procedure ButtonGenereLClick(Sender: TObject);
    procedure ButtonCalculerStatsClick(Sender: TObject);
  private
    procedure AfficheInfo(const stMessage : String);
  public
    { Déclarations publiques }
  end;
//----------------------------------------------------------------------------
var
  FormMain: TFormMain;
//----------------------------------------------------------------------------
implementation
//----------------------------------------------------------------------------
{$R *.dfm}
//----------------------------------------------------------------------------
uses
  patience_f;
//----------------------------------------------------------------------------
const
  NbMotsDico8     : array [TNbLettres] of Integer = (81,633,2623,7980,17991,32230,48039,59584,62954,57784,46501,32962,20886,12077);
  nbl8 : array [TNbLettres] of Integer = (162,1899,10492,39900,107946,225610,384312,536256,629540,635624,558012,428506,292404,181155); // ODS8
var
  Dico7 : TDico7;
  Dico8 : TDico8;
//----------------------------------------------------------------------------
constructor TDico8.Cree;
begin
end;
//---------------------------------------------------------------------------
destructor TDico8.Detruit;
begin
end;
//---------------------------------------------------------------------------
procedure TDico8.Charge;
var i, j, x : Integer;
    c : array [0..2] of AnsiChar; // RX
    F : File of AnsiChar; // RX
begin
ChargementDicoOk:=False;
if not FileExists(ExtractFilePath(ParamStr(0))+stNomFichierDico) then
  begin
  Application.MessageBox(pChar(Format(stFrmFichierIntrouvable, [stNomFichierDico])), stErreurInattendue);
  Exit
  end;
AssignFile(F, ExtractFilePath(ParamStr(0))+stNomFichierDico);
try
  with FormPatience do
    begin
    Panel.Caption:='Chargement du dictionnaire généré...';
    Gauge.MaxValue:=(NbLettresDico8 div 5)-1; // v1.8 (ODS8)
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  Reset(F);
  Index[Low(TNbLettres)]:=0;
  for i:=Low(TNbLettres)+1 to High(TNbLettres) do
    Index[i]:=Index[i-1]+nbl8[i-1];
  for i:=0 to (NbLettresDico8 div 5)-1 do // v1.8 (ODS7)
    begin
    for j:=0 to 2 do Read(f, c[j]); // 3 octets = 5 lettres
    x:=Ord(c[0])+256*Ord(c[1])+65536*Ord(c[2]);
    for j:=4 downto 0 do
      begin
      Dico[5*i+j]:=Chr(Ord('A')+x div Puiss26[j]);
      x:=x mod Puiss26[j];
      end;
    if ((i=(NbLettresDico8 div 5)-1) or
        (i mod (NbLettresDico8 div 500)=0)) then // v1.8 (ODS8)
      with FormPatience do
        begin
        Gauge.Progress:=i;
        Gauge.Repaint;
        Panel.Repaint;
        end
    end;
    // ODS8 : les trois dernières lettres ne sont pas stockées dans le fichier
    Dico[NbLettresDico8-3]:='N';
    Dico[NbLettresDico8-2]:='N';
    Dico[NbLettresDico8-1]:='E';
finally
  CloseFile(F);
end{try}
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
procedure TFormMain.AfficheInfo(const stMessage : String);
begin
StatusBar.SimpleText:=stMessage;
MemoInfos.Lines.Add(stMessage);
end;
//----------------------------------------------------------------------------
procedure TFormMain.ButtonCalculerStatsClick(Sender: TObject);
var i : Integer;
   nl : array [0..25] of Integer;
begin
try
  AfficheInfo('Chargement du fichier généré...');
  Dico8:=TDico8.Cree;
  Dico8.Charge;
  AfficheInfo('Comptage des lettres...');
  with FormPatience do
    begin
    Panel.Caption:='Parcours du dictionnaire...';
    Gauge.MaxValue:=100;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  for i:=0 to 25 do
    nl[i]:=0;
  for i:=0 to NbLettresDico8-1 do
    Inc(nl[Ord(AnsiChar(Dico8.Dico[i]))-Ord('A')]);
  for i:=0 to 25 do
    AfficheInfo(' - Nombre de '+Chr(i+Ord('A'))+' : '+IntToStr(nl[i])+' ('+Format('%.3f %%', [(100.0*nl[i])/NbLettresDico8])+')');
finally
  Dico8.Detruit;
end;
end;
//----------------------------------------------------------------------------
procedure TFormMain.ButtonGenereLClick(Sender: TObject);
var NbLettresDico8,
    IndexDico8,
    i, j, k, l, x : Integer;
    sl8           : array [TNbLettres] of TStringList;
    stMot,
    stDeb, stFin,
    stNomFichier  : String;
    F             : Textfile;
    c             : array [0..2] of AnsiChar; // RX
    FL            : File of AnsiChar; // RX
begin
try
  // 1. On charge les mots de l'ODS8...
  AfficheInfo('Chargement de l''ODS8...');
  NbLettresDico8:=0;
  IndexDico8:=0;
  Dico8:=TDico8.Create;
  for l:=NbLettresMinMot to NbLettresMaxMot do
    begin
    sl8[l]:=TStringList.Create;
    stNomFichier:=ExtractFilePath(ParamStr(0))+'ods8\'+IntToStr(l)+'.txt';
    if not FileExists(stNomFichier) then
      begin
      Application.MessageBox(pChar(Format(stFrmFichierIntrouvable, [stNomFichier])), stErreurInattendue);
      Exit
      end;
    AssignFile(F, stNomFichier);
    try
      with FormPatience do
        begin
        Panel.Caption:='Chargement des mots de '+IntToStr(l)+' lettres en cours...';
        Gauge.MaxValue:=100;
        Gauge.MinValue:=0;
        Gauge.Progress:=Gauge.MinValue;
        Show;
        Panel.Repaint;
        end;
      Reset(F);
      AfficheInfo(' - Index des mots de '+IntToStr(l)+' : '+IntToStr(NbLettresDico8));
      Dico8.Index[l]:=NbLettresDico8;
      for k:=1 to NbMotsDico8[l] do
        begin
        ReadLn(F, stMot);
        sl8[l].Add(stMot);
        // on alimente Dico8...
        for i:=1 to l do
          Dico8.Dico[NbLettresDico8+i-1]:=stMot[i];
        Inc(NbLettresDico8, l);
        if (100*k) div NbMotsDico8[l]<>FormPatience.Gauge.Progress then
          with FormPatience do
            begin
            Gauge.Progress:=(100*k) div NbMotsDico8[l];
            Gauge.Repaint;
            Panel.Repaint;
            end;
        end;
    finally
      CloseFile(F);
    end{try};
    AfficheInfo(' - Nombre de mots de '+IntToStr(l)+' chargés : '+IntToStr(sl8[l].Count));
    end{for};
  AfficheInfo('Nombre de lettres total : '+IntToStr(NbLettresDico8));
  stDeb:='               ';
  stFin:='               ';
  for i := 0 to 14 do
    stDeb[i+1]:=Dico8.Dico[i];
  for i := 0 to 14 do
    stFin[15-i]:=Dico8.Dico[NbLettresDico8-i-1];
  AfficheInfo('Le dico va de '+stDeb+' jusqu''à '+stFin);

  // 2. On crée le nouveau dico L23456789ABCDEF
  AfficheInfo('Création du fichier L23456789ABCDEF...');
  AssignFile(FL, ExtractFilePath(ParamStr(0))+stNomFichierDico);
  try
    with FormPatience do
      begin
      Panel.Caption:='Ecriture du dictionnaire de mots en cours. Veuillez patienter SVP...';
      Gauge.MaxValue:=NbLettresDico8 div 5;
      Gauge.MinValue:=0;
      Gauge.Progress:=Gauge.MinValue;
      Show;
      Panel.Repaint;
      end;
    ReWrite(FL);
    for i:=0 to (NbLettresDico8 div 5)-1 do
      begin
      x:=0;
      for j:=0 to 4 do
        Inc(x, Puiss26[j]*(Ord(Dico8.Dico[5*i+j])-Ord('A')));
      for j:=0 to 2 do
         begin
         c[j]:=AnsiChar(Char(x mod 256));
         Write(FL, c[j]);
         x:=x div 256;
         end;
      if ((i=(NbLettresDico8 div 5)-1) or
          (i mod (NbLettresDico8 div 500)=0)) then
        with FormPatience do
          begin
          Gauge.Progress:=i;
          Gauge.Repaint;
          Panel.Repaint;
          end
      end;
  finally
    CloseFile(FL);
  end{try};

  try
    AfficheInfo('Rechargement du fichier généré...');
    Dico8.Detruit;
    Dico8:=TDico8.Cree;
    Dico8.Charge;
    AfficheInfo('Vérification des mots...');
    for l:=NbLettresMinMot to NbLettresMaxMot do
      AfficheInfo(' - les mots de '+IntToStr(l)+' lettres vont de "'+Dico8.stMotDico(l, 0)+'" jusqu''à "'+Dico8.stMotDico(l, NbMotsDico8[l]-1)+'"');
  finally
    Dico8.Detruit;
  end;
finally
  for l:=NbLettresMinMot to NbLettresMaxMot do
    sl8[l].Destroy;
end{try};
end;

procedure TFormMain.ButtonImporterClick(Sender: TObject);
var i,j,k,l,dtm   : Integer;
    stMot,
    stNomFichier  : String;
    F, FD         : Textfile;
    sl7, sl8      : TStringList;
begin
try
  // 1. On ouvre le dictionnaire ODS7...
  Dico7:=TDico7.Cree;
  // 2. On charge les mots de l'ODS7...
  AfficheInfo('Chargement de l''ODS7...');
  sl7:=TStringList.Create;
  for l:=NbLettresMinMot to NbLettresMaxMot do
    begin
    for k:=0 to (nbl[l] div l)-1 do
      begin
      stMot:=Dico7.stMotDico(l, k);
      sl7.Add(stMot);
      end
    end;
  AfficheInfo('Tri de la liste...');
  sl7.Sorted:=True;
  AfficheInfo('Nombre total de mots chargés : '+IntToStr(sl7.Count));
  // 3. On charge les mots de l'ODS8...
  AfficheInfo('Chargement de l''ODS8...');
  sl8:=TStringList.Create;
  for l:=NbLettresMinMot to NbLettresMaxMot do
    begin
    stNomFichier:=ExtractFilePath(ParamStr(0))+'ods8\'+IntToStr(l)+'.txt';
    if not FileExists(stNomFichier) then
      begin
      Application.MessageBox(pChar(Format(stFrmFichierIntrouvable, [stNomFichier])), stErreurInattendue);
      Exit
      end;
    AssignFile(F, stNomFichier);
    try
      with FormPatience do
        begin
        Panel.Caption:='Chargement des mots de '+IntToStr(l)+' lettres en cours...';
        Gauge.MaxValue:=100;
        Gauge.MinValue:=0;
        Gauge.Progress:=Gauge.MinValue;
        Show;
        Panel.Repaint;
        end;
      Reset(F);
      for k:=1 to NbMotsDico8[l] do
        begin
        ReadLn(F, stMot);
        sl8.Add(stMot);
        if (100*k) div NbMotsDico8[l]<>FormPatience.Gauge.Progress then
          with FormPatience do
            begin
            Gauge.Progress:=(100*k) div NbMotsDico8[l];
            Gauge.Repaint;
            Panel.Repaint;
            end;
        end;
    finally
      CloseFile(F);
    end{try}
    end{for};
  AfficheInfo('Tri de la liste...');
  sl8.Sorted:=True;
  AfficheInfo('Nombre total de mots chargés : '+IntToStr(sl8.Count));
  // 4. On calcule le delta (mots ajoutés)...
  MemoDP.Clear;
  with FormPatience do
    begin
    Panel.Caption:='Recherche des mots nouveaux en cours...';
    Gauge.MaxValue:=100;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  for i:=0 to sl8.Count-1 do
    begin
    if sl7.IndexOf(sl8.Strings[i])=-1 then
      MemoDP.Lines.Add(sl8.Strings[i]);
    if (100*i) div sl8.Count<>FormPatience.Gauge.Progress then
      with FormPatience do
        begin
        Gauge.Progress:=(100*i) div sl8.Count;
        Gauge.Repaint;
        Panel.Repaint;
        end;
    end{for};
  AfficheInfo('Nombre total de mots nouveaux : '+IntToStr(MemoDP.Lines.Count));
  AfficheInfo('Sauvegarde de la liste des mots nouveaux...');
  MemoDP.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Mots nouveaux.txt');
  // 5. On calcule le delta (mots retirés)...
  MemoDM.Clear;
  with FormPatience do
    begin
    Panel.Caption:='Recherche des mots retirés en cours...';
    Gauge.MaxValue:=100;
    Gauge.MinValue:=0;
    Gauge.Progress:=Gauge.MinValue;
    Show;
    Panel.Repaint;
    end;
  for i:=0 to sl7.Count-1 do
    begin
    if sl8.IndexOf(sl7.Strings[i])=-1 then
      MemoDM.Lines.Add(sl7.Strings[i]);
    if (100*i) div sl7.Count<>FormPatience.Gauge.Progress then
      with FormPatience do
        begin
        Gauge.Progress:=(100*i) div sl7.Count;
        Gauge.Repaint;
        Panel.Repaint;
        end;
    end{for};
  AfficheInfo('Nombre total de mots retirés : '+IntToStr(MemoDM.Lines.Count));
  AfficheInfo('Sauvegarde de la liste des mots retirés...');
  MemoDM.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Mots retirés.txt');

  AssignFile(FD, ExtractFilePath(ParamStr(0))+'Delta.js');
  ReWrite(FD);
  WriteLn(FD, 'const delta = [[');
  dtm:=0;
  for i:=NbLettresMinMot to NbLettresMaxMot do
    for j:=0 to sl8.Count-1 do
      if (Length(sl8.Strings[j])=i) and
         (sl7.IndexOf(sl8.Strings[j])=-1) then
        begin
        if dtm=i then
          WriteLn(FD, ',')
        else
          begin
          if dtm>0 then
            WriteLn(FD, '],[');
          dtm:=i;
          end;
        Write(FD, ''''+sl8.Strings[j]+'''');
        end;
  WriteLn(FD, ']];');
  CloseFile(FD);

finally
  sl7.Destroy;
  sl8.Destroy;
end{try};
end;
//----------------------------------------------------------------------------
end.
