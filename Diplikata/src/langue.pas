unit langue; // v1.8 gestion multilingue

interface

uses Vcl.Forms;

procedure GenereFichierFRIni(const Form : TForm);

implementation

uses SysUtils, IniFiles, Controls, StdCtrls, ExtCtrls, Menus, ActnList;

const
  stNomFichierFRIni = 'FR.ini';
  stEntreeCaption   = 'Caption';
  stEntreeHint      = 'Hint';
  stEntreeItem      = 'Item';

procedure DefinitTypeCaptionHint(const Control : TControl; var stType, stCaption, stHint : String);
begin
stType:='';
stCaption:='';
stHint:='';
if Control is TLabel then
  begin
  stType:='Label';
  stCaption:=(Control as TLabel).Caption;
  stHint:=(Control as TLabel).Hint
  end
else
  if Control is TButton then
    begin
    stType:='Button';
    stCaption:=(Control as TButton).Caption;
    stHint:=(Control as TButton).Hint
    end
  else
    if Control is TPanel then
      begin
      stType:='Panel';
      stCaption:=(Control as TPanel).Caption;
      stHint:=(Control as TPanel).Hint
      end
    else
      if Control is TLabeledEdit then
        begin
        stType:='LabeledEdit';
        stCaption:=(Control as TLabeledEdit).EditLabel.Caption;
        stHint:=(Control as TLabeledEdit).Hint
        end
end;

procedure GenereFichierFRIni(const Form : TForm);
var IniFile : TIniFile;
procedure DefinitEntrees(const stSection, stType, stEntree, stCaption, stHint : String);
var stEntreeIni : String;
begin
if stType='' then
  if stEntree='' then
    stEntreeIni:=''
  else
    stEntreeIni:=stEntree+'.'
else
  stEntreeIni:=stType+'.'+stEntree+'.';
if stCaption<>'' then
  IniFile.WriteString(stSection, stEntreeIni+stEntreeCaption, stCaption);
if stHint<>'' then
  IniFile.WriteString(stSection, stEntreeIni+stEntreeHint, stHint);
end{DefinitEntrees};
procedure GenereSection(const Form : TForm);
var i, j         : Integer;
    Control,
    SubControl   : TControl;
    MenuItem     : TMenuItem;
    Action       : TAction;
    stSection,
    stSubSection,
    stEntree,
    stCaption,
    stHint,
    stType       : String;
begin
stSection:=Form.Name;
DefinitEntrees(stSection, '', '', Form.Caption, Form.Hint); // Titre et conseil de la fenêtre
// D'abord les contrôles
for i:=0 to Form.ControlCount-1 do
  begin
  Control:=Form.Controls[i];
  stEntree:=Control.Name;
  // Cas simple
  DefinitTypeCaptionHint(Control, stType, stCaption, stHint);
  DefinitEntrees(stSection, stType, stEntree, stCaption, stHint);
  // Cas des contrôles qui ont plusieurs libellés
  if Control is TGroupBox then
    begin
    stSubSection:=Control.Name;
    stCaption:=(Control as TGroupBox).Caption;
    stHint:=(Control as TGroupBox).Hint;
    DefinitEntrees(stSubSection, '', '', stCaption, stHint);
    for j:=0 to (Control as TGroupBox).ControlCount-1 do
      begin
      SubControl:=(Control as TGroupBox).Controls[i];
      stEntree:=SubControl.Name;
      DefinitTypeCaptionHint(SubControl, stType, stCaption, stHint);
      if (stType<>'') then // On a des Captions ou Hints
        DefinitEntrees(stSection, stType, stEntree, stCaption, stHint);
      end
    end;
  if Control is TRadioGroup then
    begin
    stSubSection:=Control.Name;
    stCaption:=(Control as TRadioGroup).Caption;
    stHint:=(Control as TRadioGroup).Hint;
    DefinitEntrees(stSubSection, '', '', stCaption, stHint);
    for j:=0 to (Control as TRadioGroup).Items.Count-1 do
      DefinitEntrees(stSubSection, stEntreeItem, IntToStr(j), (Control as TRadioGroup).Items.Strings[j], '');
    end
  end{for};
// Ensuite les MenuItems et Actions
for i:=0 to Form.ComponentCount-1 do
  begin
  if Form.Components[i] is TMenuItem then
    begin
    MenuItem:=Form.Components[i] as TMenuItem;
    stType:='MenuItem';
    stEntree:=MenuItem.Name;
    stCaption:=MenuItem.Caption;
    stHint:=MenuItem.Hint;
    DefinitEntrees(stSection, stType, stEntree, stCaption, stHint);
    end;
  if Form.Components[i] is TAction then
    begin
    Action:=Form.Components[i] as TAction;
    stType:='Action';
    stEntree:=Action.Name;
    stCaption:=Action.Caption;
    stHint:=Action.Hint;
    DefinitEntrees(stSection, stType, stEntree, stCaption, stHint);
    end
 end{for};
end{GenereSection};

begin{GenereFichierFRIni}
(* // À utiliser pour générer le fichier FR.ini 
IniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+stNomFichierFRIni);
try
  if Form<>nil then GenereSection(Form);
finally
  FreeAndNil(IniFile);
end{try}
*)
end{GenereFichierLangueFR};

end.
