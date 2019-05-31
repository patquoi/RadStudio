unit nvrecord_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, base;
//---------------------------------------------------------------------------
type
  TFormNvRecord = class(TForm)
    Panel: TPanel;
    PaintBox: TPaintBox;
    Timer: TTimer;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    NbLignesAllouees : Integer;
    TopAffichage : array of Integer;
    stRecord : array of String;
    AffichageEnCours : array of Boolean;
    function ProchaineLigne : Integer;
    function DerniereLigne : Integer;
  public
    procedure AfficheRecord(const r : TRecord);
  end;
//---------------------------------------------------------------------------
var
  FormNvRecord: TFormNvRecord;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.Math, main_f, langue;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const
  MaxAffichage = 20;
//---------------------------------------------------------------------------
procedure TFormNvRecord.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FormMain.GenereListeRecords(NAffichePas)
end;
//---------------------------------------------------------------------------
procedure TFormNvRecord.FormCreate(Sender: TObject);
begin
TopAffichage:=nil;
stRecord:=nil;
AffichageEnCours:=nil;
GenereFichierFRIni(self); //v1.8 gestion multilingue
end;
//---------------------------------------------------------------------------
procedure TFormNvRecord.PaintBoxPaint(Sender: TObject);
var i, h, l, dl, g, t : Integer;
begin
dl:=DerniereLigne;
with PaintBox.Canvas do
  begin
  h:=8+TextHeight('Q')*(1+dl)+Panel.Height;
  if Height<>h then Height:=h;
  for i:=0 to NbLignesAllouees-1 do
    if AffichageEnCours[i] then
      begin
      l:=8+TextWidth(stRecord[i]);
      t:=FormMain.Top+FormMain.Height div 16+
         8+FormMain.Height-FormMain.ClientHeight-
           FormMain.StatusBar.Height;
      g:=FormMain.Left+FormMain.Width div 16;
      if Width<l then Width:=l;
      if Top<>t then Top:=t;
      if Left<>g then Left:=g;
      TextOut(4, 4+i*TextHeight(stRecord[i]), stRecord[i]);
      end
    else
      if AffichageEnCours[i] then
        AffichageEnCours[i]:=False;
  end
end;
//---------------------------------------------------------------------------
procedure TFormNvRecord.TimerTimer(Sender: TObject);
var i : Integer;
begin
// 1. On incrémente le compteur de temps (1 toutes les 1/2 seconde)
Timer.Tag:=Timer.Tag+1;
// 2. On fait clignoter l'en-tête pour attirer l'attention
Panel.Font.Color:=IfThen(Timer.Tag mod 2=1, Panel.Color, clRed);
// 3. On met à jour les compteurs en cours
if AffichageEnCours<>nil then
  for i:=0 to NbLignesAllouees-1 do
    if AffichageEnCours[i] then
      AffichageEnCours[i]:=(Timer.Tag-TopAffichage[i]<=MaxAffichage);
// 4. On affiche/cache la fenêtre échéant
if DerniereLigne=-1 then
  begin
  Close;
  Timer.Enabled:=False;
  Width:=Constraints.MinWidth;
  Height:=Constraints.MinHeight;
  end
else
  begin
  if not Visible then Show;
  PaintBox.Repaint;
  BringToFront // v1.5.1 : dans le cas où une boîte de dialogue apparaît, la fenêtre des records peut être masquée.
  end;
end;
//---------------------------------------------------------------------------
function TFormNvRecord.ProchaineLigne : Integer;
var i : Integer;
begin
if TopAffichage=nil then
  begin
  NbLignesAllouees:=1;
  SetLength(TopAffichage, 1);
  SetLength(stRecord, 1);
  SetLength(AffichageEnCours, 1);
  TopAffichage[0]:=0;
  stRecord[0]:='';
  AffichageEnCours[0]:=False;
  Result:=0;
  Exit
  end
else
  begin
  Result:=-1;
  for i:=0 to NbLignesAllouees-1 do
    if not AffichageEnCours[i] then
      begin
      Result:=i;
      Break
      end;
  if Result=-1 then
    begin
    Inc(NbLignesAllouees);
    SetLength(TopAffichage, NbLignesAllouees);
    SetLength(stRecord, NbLignesAllouees);
    SetLength(AffichageEnCours, NbLignesAllouees);
    TopAffichage[NbLignesAllouees-1]:=0;
    stRecord[NbLignesAllouees-1]:='';
    AffichageEnCours[NbLignesAllouees-1]:=False;
    Result:=NbLignesAllouees-1
    end
  end
end;
//---------------------------------------------------------------------------
function TFormNvRecord.DerniereLigne : Integer;
var i : Integer;
begin
Result:=-1;
if AffichageEnCours<>nil then
 for i:=0 to NbLignesAllouees-1 do
   if AffichageEnCours[i] then
     Result:=i;
end;
//---------------------------------------------------------------------------
procedure TFormNvRecord.AfficheRecord(const r : TRecord);
const stFrmLibelle = ' (%s)';
var NumLigne : Integer;
function NbSources(const n : TNatureRecord) : Integer; begin Result:=Ord(EstSourceNatureRecord[srGenerale, n])+Ord(EstSourceNatureRecord[srProposition, n])+Ord(EstSourceNatureRecord[srTop, n]) end;
function NbNiveaux(const n : TNatureRecord) : Integer; begin Result:=Ord(EstNiveauNatureRecord[nvrTour, n])+Ord(EstNiveauNatureRecord[nvrPartie, n]) end;
function NbTypes(const n : TNatureRecord) : Integer; begin Result:=Ord(EstTypeNatureRecord[trMin, n])+Ord(EstTypeNatureRecord[trMax, n]) end;
begin
NumLigne:=ProchaineLigne;
stRecord[NumLigne]:=stNatureRecord[r.Nature];
if NbNiveaux(r.Nature)>1 then
  stRecord[NumLigne]:=stRecord[NumLigne]+' '+stNiveauRecord[r.Niveau]; // v1.5.6
if NbTypes(r.Nature)>1 then
  stRecord[NumLigne]:=stRecord[NumLigne]+' '+stTypeRecord[r.MinMax];
if NbSources(r.Nature)>1 then
  stRecord[NumLigne]:=stRecord[NumLigne]+' ('+stSourceRecord[r.Source]+')';
stRecord[NumLigne]:=stRecord[NumLigne]+' : ';
stRecord[NumLigne]:=stRecord[NumLigne]+r.stHTMLValeur(cirFenetre);
if (r.stLibelle<>'') and (r.Nature<>ntrNivDiff) then
  if (r.Nature=ntrScore) and (r.Niveau=nvrTour) then // v1.5.1 : les records de Score Tour sont en style & couleur (HTML)
    stRecord[NumLigne]:=stRecord[NumLigne]+Format(stFrmLibelle, [r.stLibelleSansCodeHTML])
  else
    stRecord[NumLigne]:=stRecord[NumLigne]+Format(stFrmLibelle, [r.stLibelle]);
TopAffichage[NumLigne]:=Timer.Tag;
AffichageEnCours[NumLigne]:=True;
if not Timer.Enabled then
  Timer.Enabled:=True;
end;
//---------------------------------------------------------------------------
end.
