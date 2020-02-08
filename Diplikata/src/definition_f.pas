unit definition_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;
//---------------------------------------------------------------------------
type
  TFormDefinitionMot = class(TForm)
    ComboBoxSource: TComboBox;
    LabelSource: TLabel;
    LabelMot: TLabel;
    EditMot: TEdit;
    ButtonRechercher: TButton;
    ButtonPersonnaliser: TButton;
    ButtonAnnuler: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure ButtonPersonnaliserClick(Sender: TObject);
    procedure ButtonRechercherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    procedure ChargeSourcesDefinition;
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
type
  TSourceDefinitions = (sdHaitiRef);
//---------------------------------------------------------------------------
const // vKA
  stNomSrcDef : array [TSourceDefinitions] of String = ( 'Haïti-Référence');
  stFrmURLSrcDef : array [TSourceDefinitions] of String = ( 'http://www.haiti-reference.com/pages/creole/diction/display.php?action=search&word=%s'); // v1.8KA : URL modifiée (+/pages)

//---------------------------------------------------------------------------
var
  NbSrcDefPerso       : Integer;
  FormDefinitionMot   : TFormDefinitionMot;
  stFrmURLSrcDefPerso : array of String;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.IniFiles, Winapi.ShellApi, base, main_f, prmsrcdef_f, langue;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.ButtonPersonnaliserClick(Sender: TObject);
begin
FormParamSrcDef:=TFormParamSrcDef.Create(self);
with FormParamSrcDef do
  try
    ShowModal
  finally
    Release;
    ChargeSourcesDefinition;
    EditMot.SetFocus
  end
end;
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.ButtonRechercherClick(Sender: TObject);
begin
if NbSrcDefPerso=0 then
  ShellExecute(0, 'Open',
               pChar(Format(stFrmURLSrcDef[TSourceDefinitions(ComboBoxSource.ItemIndex)], [EditMot.Text])),
               '',
               '', SW_SHOWMAXIMIZED)
else
  ShellExecute(0, 'Open',
               pChar(Format(stFrmURLSrcDefPerso[ComboBoxSource.ItemIndex], [EditMot.Text])),
               '',
               '', SW_SHOWMAXIMIZED)
end;
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.ChargeSourcesDefinition;
var i,
    ItemIdxSvg : Integer;
    IniFile    : TIniFile;
begin
ItemIdxSvg:=ComboBoxSource.ItemIndex;
ComboBoxSource.Items.Clear;
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  // Chargement Sources personnalisées
  NbSrcDefPerso:=IniFile.ReadInteger(stSectionSrcDef, stEntreeNbrSrcDef, 0);
  if NbSrcDefPerso>0 then
    begin
    SetLength(stFrmURLSrcDefPerso, NbSrcDefPerso);
    with ComboBoxSource.Items do
      for i:=1 to NbSrcDefPerso do
        begin
        ComboBoxSource.Items.Add(IniFile.ReadString(stSectionSrcDef, stEntreeNomSrcDef+IntToStr(i), ''));
        stFrmURLSrcDefPerso[i-1]:=IniFile.ReadString(stSectionSrcDef, stEntreeUrlSrcDef+IntToStr(i), '')
        end
    end
  else
    begin
    stFrmURLSrcDefPerso:=nil;
    // Chargement Sources prédéfinies
    with ComboBoxSource.Items do
      for i:=Ord(Low(TSourceDefinitions)) to Ord(High(TSourceDefinitions)) do
        Add(stNomSrcDef[TSourceDefinitions(i)]);
    end;
  // Chargement de la source de définitions sauvegardées dans la section [Paramètres] du fichier Diplikata.ini
  try
    if ItemIdxSvg>-1 then
      ComboBoxSource.ItemIndex:=ItemIdxSvg
    else
      ComboBoxSource.ItemIndex:=IniFile.ReadInteger(stSectionParametres, stEntreeActionsSD, 0);
  except
  end;
finally
  if ComboBoxSource.ItemIndex=-1 then
    ComboBoxSource.ItemIndex:=0;
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.FormCreate(Sender: TObject);
begin
ChargeSourcesDefinition;
GenereFichierFRIni(self); //v1.8 gestion multilingue
end;
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.FormDestroy(Sender: TObject);
begin
if stFrmURLSrcDefPerso<>nil then
  Finalize(stFrmURLSrcDefPerso)
end;
//---------------------------------------------------------------------------
initialization
NbSrcDefPerso:=0;
stFrmURLSrcDefPerso:=nil;
//---------------------------------------------------------------------------

end.
