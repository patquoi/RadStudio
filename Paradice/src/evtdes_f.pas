unit evtdes_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, base;

type
  TFormEvtDes = class(TForm)
    Panel: TPanel;
    ButtonPrm: TButton;
    ButtonPrc: TButton;
    ButtonSvt: TButton;
    ButtonDrn: TButton;
    DrawGrid: TDrawGrid;
    VirtualImageListEvts: TVirtualImageList;
    LabelNomEvenement: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelFamille: TLabel;
    LabelDefinition: TLabel;
    LabelFormule: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    VirtualImageListDes: TVirtualImageList;
    procedure ButtonPrmClick(Sender: TObject);
    procedure ButtonPrcClick(Sender: TObject);
    procedure ButtonSvtClick(Sender: TObject);
    procedure ButtonDrnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    TypeEvtCrt : TTypeEvt;
    EvtCrt : TEvenement; // Pour appel à TEvenement.DonneGain
    bmDe : array [TDe] of TBitMap;
    bmEvt : array [TTypeEvt] of TBitMap;
    procedure ChangeEvenement(NvTypeEvt : TTypeEvt); // Affecte TypeEvtCrt et EvtCrt;
    procedure AfficheInfos;
    procedure RafraichitBoutons;
  public
    { Déclarations publiques }
  end;

var
  FormEvtDes: TFormEvtDes;

implementation

{$R *.dfm}

uses
  plateau_f;

procedure TFormEvtDes.ChangeEvenement(NvTypeEvt : TTypeEvt);
begin
TypeEvtCrt:=NvTypeEvt;
FreeAndNil(EvtCrt);
EvtCrt:=TEvenement.Create(TypeEvtCrt);
end;

procedure TFormEvtDes.AfficheInfos;
begin
RafraichitBoutons;

LabelNomEvenement.Caption:=stNomEvenement[TypeEvtCrt];
LabelFamille.Caption:=stNomFamille[FamilleEvt[TypeEvtCrt]];
LabelDefinition.Caption:=stDefGain[DefGain[TypeEvtCrt]];
LabelFormule.Caption:=Format(stFrmGain[DefGain[TypeEvtCrt]], [stNomEvenement[TypeEvtCrt], TauxGain[TypeEvtCrt]]);
DrawGrid.Refresh;
end;

procedure TFormEvtDes.RafraichitBoutons;
begin
ButtonPrm.Enabled:=Ord(TypeEvtCrt)>1;
ButtonPrc.Enabled:=Ord(TypeEvtCrt)>1;
ButtonSvt.Enabled:=TypeEvtCrt<High(TTypeEvt);
ButtonDrn.Enabled:=TypeEvtCrt<High(TTypeEvt);
end;

procedure TFormEvtDes.FormCreate(Sender: TObject);
var d : TDe;
    e : TTypeEvt;
begin
if TypeEvtCrt=teIndefini then
  ChangeEvenement(TTypeEvt(1));
// Chargement des bitmaps de l'evt et des dés
for e:=Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  begin
  bmEvt[e]:=TBitMap.Create;
  VirtualImageListEvts.GetBitmap(Ord(e)-1, bmEvt[e]);
  end;
for d:=Succ(Low(TDe)) to High(TDe) do
  begin
  bmDe[d]:=TBitmap.Create;
  VirtualImageListDes.GetBitmap(Ord(d)-1, bmDe[d]);
  end;
end;

procedure TFormEvtDes.FormDestroy(Sender: TObject);
var d : TDe;
    e : TTypeEvt;
begin
FreeAndNil(EvtCrt);
// Libération des bitmaps de l'evt et des dés
for e:=Succ(Low(TTypeEvt)) to High(TTypeEvt) do
  FreeAndNil(bmEvt[e]);
for d:=Succ(Low(TDe)) to High(TDe) do
  FreeAndNil(bmDe[d]);
end;

procedure TFormEvtDes.FormKeyPress(Sender: TObject; var Key: Char);
begin // v1.1 : Echap permet de sortir
 if Key = #27 (* Echap *) then
   ModalResult := MrOk;
end;

procedure TFormEvtDes.FormShow(Sender: TObject);
begin
AfficheInfos;
end;

procedure TFormEvtDes.ButtonPrmClick(Sender: TObject);
begin
ChangeEvenement(TTypeEvt(1));
AfficheInfos;
end;

procedure TFormEvtDes.ButtonPrcClick(Sender: TObject);
begin
if Ord(TypeEvtCrt)>1 then
  ChangeEvenement(TTypeEvt(Ord(TypeEvtCrt)-1));
AfficheInfos;
end;

procedure TFormEvtDes.ButtonSvtClick(Sender: TObject);
begin
if TypeEvtCrt<High(TTypeEvt) then
  ChangeEvenement(TTypeEvt(Ord(TypeEvtCrt)+1));
AfficheInfos;
end;

procedure TFormEvtDes.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var x, y,
    tw, th : Integer;
    stGain : String;
begin
if ACol+ARow=0 then // Evénement
  DrawGrid.Canvas.Draw(Rect.Left, Rect.Top, bmEvt[TypeEvtCrt])
else
  if ACol=0 then
    DrawGrid.Canvas.Draw(Rect.Left, Rect.Top, bmDe[TDe(ARow)])
  else
    if ARow=0 then
      DrawGrid.Canvas.Draw(Rect.Left, Rect.Top, bmDe[TDe(ACol)])
    else // Affichage du gain
      begin
      stGain:=IntToStr(EvtCrt.DonneGain([TDe(ACol), TDe(ARow)]));
      with DrawGrid.Canvas, Rect do
        begin
        tw:=TextWidth(stGain);
        th:=TextHeight(stGain);
        x:=Left+(1+Right-Left-tw) div 2;
        y:=Top+(1+Bottom-Top-th) div 2;
        TextOut(x, y, stGain);
        end;
      end;
end;

procedure TFormEvtDes.ButtonDrnClick(Sender: TObject);
begin
ChangeEvenement(High(TTypeEvt));
AfficheInfos;
end;

end.
