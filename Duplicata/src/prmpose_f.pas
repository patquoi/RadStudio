unit prmpose_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;
//---------------------------------------------------------------------------
type
  TTypeQualitePose = (tqpIndefini=-1, tqpTops, tqpRapportScoreTop, tqpRangSolution);
  TQualitePose     = 0..100;
  TFormParamPose = class(TForm)
    RadioGroupTypeQualitePose: TRadioGroup;
    LabelMin: TLabel;
    LabelMax: TLabel;
    LabelQualite: TLabel;
    LabelProportion: TLabel;
    TrackBar: TTrackBar;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    procedure FormShow(Sender: TObject);
    procedure RadioGroupTypeQualitePoseClick(Sender: TObject);
    procedure ButtonAnnulerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
  private
    TypeQualitePrc : TTypeQualitePose;
    QualitePrc     : TQualitePose;
    function DonneTypeQualite : TTypeQualitePose;
    function DonneQualite : TQualitePose;
    procedure ChangeTypeQualite(const TypeQualitePose : TTypeQualitePose);
    procedure ChangeQualite(const QualitePose : TQualitePose);
  public
    property TypeQualitePose : TTypeQualitePose read DonneTypeQualite write ChangeTypeQualite;
    property QualitePose : TQualitePose read DonneQualite write ChangeQualite;
    procedure LitParametres;
  end;
//---------------------------------------------------------------------------
var
  FormParamPose: TFormParamPose;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.IniFiles, base, main_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const stFrmPourcentage = '%d%%';
//---------------------------------------------------------------------------
procedure TFormParamPose.ButtonAnnulerClick(Sender: TObject);
begin
ChangeTypeQualite(TypeQualitePrc);
ChangeQualite(QualitePrc);
end;
//---------------------------------------------------------------------------
procedure TFormParamPose.FormCreate(Sender: TObject);
begin
LitParametres
end;
//---------------------------------------------------------------------------
procedure TFormParamPose.FormShow(Sender: TObject);
begin
TypeQualitePrc:=DonneTypeQualite;
QualitePrc:=DonneQualite;
RadioGroupTypeQualitePose.SetFocus
end;
//---------------------------------------------------------------------------
procedure TFormParamPose.RadioGroupTypeQualitePoseClick(Sender: TObject);
begin
with TrackBar do
  begin
  case RadioGroupTypeQualitePose.ItemIndex of
    0: begin Position:=100; Min:=0 end;
    1: begin Position:=50; Min:=10 end;
    2: begin Position:=90; Min:=50 end;
  end;
  LabelMin.Caption:=Format(stFrmPourcentage, [Min]);
  Enabled:=(RadioGroupTypeQualitePose.ItemIndex>0)
  end
end;
//---------------------------------------------------------------------------
procedure TFormParamPose.TrackBarChange(Sender: TObject);
begin
LabelProportion.Caption:=Format(stFrmPourcentage, [TrackBar.Position]);
if (RadioGroupTypeQualitePose.ItemIndex=1) and
   (TrackBar.Position=100) then
  RadioGroupTypeQualitePose.ItemIndex:=0
end;
//---------------------------------------------------------------------------
function TFormParamPose.DonneTypeQualite : TTypeQualitePose;
begin
Result:=TTypeQualitePose(RadioGroupTypeQualitePose.ItemIndex)
end;
//----------------------------------------------------------------------------
function TFormParamPose.DonneQualite : TQualitePose;
begin
Result:=TQualitePose(TrackBar.Position)
end;
//----------------------------------------------------------------------------
procedure TFormParamPose.ChangeTypeQualite(const TypeQualitePose : TTypeQualitePose);
begin
RadioGroupTypeQualitePose.ItemIndex:=Ord(TypeQualitePose)
end;
//----------------------------------------------------------------------------
procedure TFormParamPose.ChangeQualite(const QualitePose : TQualitePose);
begin
TrackBar.Position:=Ord(QualitePose)
end;
//----------------------------------------------------------------------------
procedure TFormParamPose.LitParametres;
var IniFile : TIniFile;
begin
try
  IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
  with IniFile do
    begin
    RadioGroupTypeQualitePose.ItemIndex:=ReadInteger(stSectionParametres, stEntreeOptionTQP, 0); // Par défaut : liste des tops
    TrackBar.Position:=ReadInteger(stSectionParametres, stEntreeOptionPQP, 100); // Par défaut : 100 correspondant aux tops
    end;
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
end.
