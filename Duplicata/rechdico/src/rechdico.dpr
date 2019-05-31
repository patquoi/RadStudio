program rechdico;

uses
  Forms,
  baserechdico in 'baserechdico.pas',
  base in 'base.pas',
  main_f in 'main_f.pas' {FormMain},
  patience_f in 'patience_f.pas' {FormPatience};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Dictionnaire de recherche ODS4';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormPatience, FormPatience);
  Application.Run;
end.
