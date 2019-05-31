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
  TSourceDefinitions = (sdWiktionnaire, sdCNRTL, sdReverso, sdLarousse);
//---------------------------------------------------------------------------
const // v1.8.2 : changement des sources : ajout de 1mot.net, suppression de reverso.
  stNomSrcDef : array [TSourceDefinitions] of String = ( '1mot.net', // v1.8.2
                                                         'Wiktionnaire',
                                                         'Centre National de Ressources Textuelles et Lexicales',
                                                         'Larousse'
                                                       );

  stFrmURLSrcDef : array [TSourceDefinitions] of String = ( 'http://1mot.net/%s',
                                                            'http://fr.wiktionary.org/wiki/%s',
                                                            'http://www.cnrtl.fr/definition/%s',
                                                            'http://www.larousse.fr/dictionnaires/francais/%s'
                                                          );

//---------------------------------------------------------------------------
var
  NbSrcDefPerso       : Integer; // v1.8.2 : en fait, c'est le nombre de sources enregistrées et non pas personnalisées
  FormDefinitionMot   : TFormDefinitionMot;
  stFrmURLSrcDefPerso : array of String;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.IniFiles, Winapi.ShellApi, base, main_f, prmsrcdef_f;
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

procedure ChargeSourcesPredefinies; // v1.8.2
var i : Integer;
begin
with ComboBoxSource.Items do
  for i:=Ord(Low(TSourceDefinitions)) to Ord(High(TSourceDefinitions)) do
    begin
    Add(stNomSrcDef[TSourceDefinitions(i)]);
    stFrmURLSrcDefPerso[i]:=stFrmURLSrcDef[TSourceDefinitions(i)];
    end;
end{ChargeSourcesPredefinies};

begin {ChargeSourcesDefinition}
ItemIdxSvg:=ComboBoxSource.ItemIndex;
ComboBoxSource.Items.Clear;
IniFile:=TIniFile.Create(stRepLocalAppData+stNomFichierIni); // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
try
  // 1. Chargement Sources enregistrées
  NbSrcDefPerso:=IniFile.ReadInteger(stSectionSrcDef, stEntreeNbrSrcDef, 0);
  if NbSrcDefPerso>0 then
    begin
    SetLength(stFrmURLSrcDefPerso, NbSrcDefPerso);
    // 1a. Chargement Sources prédéfinies. v1.8.2 : on ne charge les sources prédéfinies depuis paramètres enregistrés
    ChargeSourcesPredefinies();
    // 1b. Chargement Sources personnalisées. v1.8.2 : en fait, c'est le nombre de sources enregistrées
    with ComboBoxSource.Items do
      for i:=2+Ord(High(TSourceDefinitions)) to NbSrcDefPerso do // v1.8.2 : on part des définitions personnalisées
        begin
        ComboBoxSource.Items.Add(IniFile.ReadString(stSectionSrcDef, stEntreeNomSrcDef+IntToStr(i), ''));
        stFrmURLSrcDefPerso[i-1]:=IniFile.ReadString(stSectionSrcDef, stEntreeUrlSrcDef+IntToStr(i), '')
        end
    end
  else
    begin
    SetLength(stFrmURLSrcDefPerso, Ord(High(TSourceDefinitions))+1);
    // 1. Chargement Sources prédéfinies
    ChargeSourcesPredefinies(); // v1.8.2 (code mis en procédure)
    end;

  // 2. Chargement de la source de définitions sauvegardées dans la section [Paramètres] du fichier WordKillers.ini
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
ChargeSourcesDefinition
end;
//---------------------------------------------------------------------------
procedure TFormDefinitionMot.FormDestroy(Sender: TObject);
begin
if stFrmURLSrcDefPerso<>nil then
  Finalize(stFrmURLSrcDefPerso)
end;
//---------------------------------------------------------------------------
end.
