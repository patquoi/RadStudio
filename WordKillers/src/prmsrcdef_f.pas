unit prmsrcdef_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;
//---------------------------------------------------------------------------
type
  TFormParamSrcDef = class(TForm)
    LabelExplication1: TLabel;
    LabelExplication2: TLabel;
    LabelTitreNom: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EditUrl1: TEdit;
    EditUrl2: TEdit;
    EditUrl3: TEdit;
    EditUrl4: TEdit;
    EditUrl5: TEdit;
    EditUrl6: TEdit;
    EditUrl7: TEdit;
    EditUrl8: TEdit;
    LabeledEditTest: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    procedure FormShow(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure ButtonTesterClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    procedure TesteBoutons;
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
const NbMinSrcDef       = 4;
      NbMaxSrcDef       = 8;
      stSectionSrcDef   = 'SrcDef';
      stEntreeNbrSrcDef = 'N';
      stEntreeNomSrcDef = 'N';
      stEntreeUrlSrcDef = 'A';
//---------------------------------------------------------------------------
var
  FormParamSrcDef: TFormParamSrcDef;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.IniFiles, Winapi.ShellApi, base, definition_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
procedure TFormParamSrcDef.ButtonOKClick(Sender: TObject);
var IniFile     : TIniFile;
    i, NbSrcDef : Integer;
begin
NbSrcDef:=NbMinSrcDef;
// 1. On calcule combien on a des sources définies
for i:=NbMaxSrcDef downto 1 do
  if ((FindComponent('Edit'+IntToStr(i)) as TEdit).Text<>'') or
     ((FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text<>'') then
    begin
    NbSrcDef:=i;
    Break
    end;
// 2. On vérifie que l'on a tous les champs définis.
for i:=1 to NbSrcDef do
  if (Trim((FindComponent('Edit'+IntToStr(i)) as TEdit).Text)='') or
     (Trim((FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text)='') then
    begin
    Application.MessageBox('Les champs nom et adresses sont obligatoires !',
                           pChar(Format('Définition incomplète de la source n°%d', [i])),
                           MB_ICONHAND);
    Abort
    end;
// 3. On sauvegarde les paramètres.
IniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+stNomFichierIni);
try
  IniFile.WriteInteger(stSectionSrcDef, stEntreeNbrSrcDef, NbSrcDef);
  for i:=1 to NbSrcDef do
    begin
    IniFile.WriteString(stSectionSrcDef, stEntreeNomSrcDef+IntToStr(i), (FindComponent('Edit'+IntToStr(i)) as TEdit).Text);
    IniFile.WriteString(stSectionSrcDef, stEntreeUrlSrcDef+IntToStr(i), (FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text)
    end
finally
  FreeAndNil(IniFile);
  ModalResult:=mrOk
end;
end;
//---------------------------------------------------------------------------
procedure TFormParamSrcDef.ButtonTesterClick(Sender: TObject);
var Numero : Integer;
begin
Numero:=(Sender as TButton).Tag;
ShellExecute(0, 'Open',
             pChar(Format((FindComponent('EditUrl'+IntToStr(Numero)) as TEdit).Text,
                          [LabeledEditTest.Text])),
             '',
             '', SW_SHOWMAXIMIZED)
end;
//---------------------------------------------------------------------------
procedure TFormParamSrcDef.EditChange(Sender: TObject);
begin
TesteBoutons
end;
//---------------------------------------------------------------------------
procedure TFormParamSrcDef.FormShow(Sender: TObject);
var IniFile     : TIniFile;
    i, NbSrcDef : Integer;

procedure ChargeSourcesPredefinies;
var i : Integer;
begin
for i:=1 to NbMinSrcDef do
  begin
  (FindComponent('Edit'+IntToStr(i)) as TEdit).Text:=stNomSrcDef[TSourceDefinitions(i-1)];
  (FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text:=stFrmURLSrcDef[TSourceDefinitions(i-1)]
  end;
end{ChargeSourcesPredefinies};

begin{FormShow}
if FormDefinitionMot.EditMot.Text<>'' then
  LabeledEditTest.Text:=FormDefinitionMot.EditMot.Text; // sinon 'Duplicata'

IniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+stNomFichierIni);
try
  NbSrcDef:=IniFile.ReadInteger(stSectionSrcDef, stEntreeNbrSrcDef, 0);
  if NbSrcDef=0 then // On charge les 4 sources prédéfinies
    ChargeSourcesPredefinies // v1.8.2 : code mis en procédure
  else // On charge les 4 sources prédéfinies puis les sources personnalisées enregistrées
    begin
    ChargeSourcesPredefinies; // v1.8.2 : on ne charge les sources prédéfinies depuis paramètres enregistrés
    for i:=1+NbMinSrcDef to NbSrcDef do
      begin
      (FindComponent('Edit'+IntToStr(i)) as TEdit).Text:=IniFile.ReadString(stSectionSrcDef, stEntreeNomSrcDef+IntToStr(i), '');
      (FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text:=IniFile.ReadString(stSectionSrcDef, stEntreeUrlSrcDef+IntToStr(i), '')
      end
    end;
finally
  FreeAndNil(IniFile);
  Testeboutons
end;
end;
//---------------------------------------------------------------------------
procedure TFormParamSrcDef.TesteBoutons;
var i : Integer;
begin
for i:=1 to NbMaxSrcDef do
  (FindComponent('Button'+IntToStr(i)) as TButton).Enabled:=((FindComponent('Edit'+IntToStr(i)) as TEdit).Text<>'') and
                                                            ((FindComponent('EditUrl'+IntToStr(i)) as TEdit).Text<>'')
end;
//---------------------------------------------------------------------------
end.
