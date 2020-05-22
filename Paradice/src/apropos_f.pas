unit apropos_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.Menus, Vcl.StdCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, base;

type
  TFormAPropos = class(TForm)
    Timer: TTimer;
    VirtualImageList: TVirtualImageList;
    PaintBox: TPaintBox;
    LabelVersion: TLabel;
    LabelSousVersion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LabelAlignement: TLabel;
    ImageCollection: TImageCollection;
    TimerLancement: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TimerLancementTimer(Sender: TObject);
  private
    bmParadice    : TBitMap;
    stVersion,
    stSousVersion : String;
    procedure DetermineVersion;
    procedure AfficheParadice(Couleur : TCouleur);
  public
  end;

var
  FormAPropos: TFormAPropos;

implementation

{$R *.dfm}

procedure TFormAPropos.DetermineVersion;
var
  VerInfoSize, VerValueSize, ParametreInutilise: DWord;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), ParametreInutilise);
if VerInfoSize <> 0 then
  begin
  {On alloue de la mémoire pour un pointeur sur les info de version : }
  GetMem(VerInfo, VerInfoSize);
  {On récupère ces informations : }
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  {On traite les informations ainsi récupérées : }
  with VerValue^ do
    begin
    stVersion:=Format('%d.%d.%d',
                      [dwFileVersionMS shr 16,
                       dwFileVersionMS and $FFFF,
                       dwFileVersionLS shr 16]);
    stSousVersion:=Format('.%d', [dwFileVersionLS and $FFFF]); // v1.5
    end;
  FreeMem(VerInfo, VerInfoSize);
  end
else
  raise EAccessViolation.Create('Erreur inattendue : aucune information de version incluse.');
end;

procedure TFormAPropos.FormClick(Sender: TObject);
begin
Self.ModalResult:=mrOk;
end;

procedure TFormAPropos.FormCreate(Sender: TObject);
begin
DetermineVersion;
LabelVersion.Caption:=stVersion;
LabelSousVersion.Caption:=stSousVersion;
{$IFDEF WIN64}
LabelAlignement.Caption:=Format(LabelAlignement.Caption, [64]);
{$ELSE}
LabelAlignement.Caption:=Format(LabelAlignement.Caption, [32]);
{$ENDIF}
end;

procedure TFormAPropos.FormKeyPress(Sender: TObject; var Key: Char);
begin
case Key of
 #27,
 #13: Self.ModalResult := mrOK;
end{case of};
end;

procedure TFormAPropos.AfficheParadice(Couleur : TCouleur);
begin
bmParadice:=TBitMap.Create;
VirtualImageList.GetBitmap(Ord(Couleur), bmParadice);
VirtualImageList.GetBitmap(0, bmParadice);
With PaintBox do
  Canvas.StretchDraw(TRect.Create(0, 0, Width, Height), bmParadice);
FreeAndNil(bmParadice);
end;

procedure TFormAPropos.TimerLancementTimer(Sender: TObject);
begin
Self.ModalResult := mrOK;
end;

procedure TFormAPropos.TimerTimer(Sender: TObject);
begin
Timer.Tag:=1+(Timer.Tag+1) mod  VirtualImageList.Images.Count;
AfficheParadice(TCouleur(Timer.Tag));
end;

end.
