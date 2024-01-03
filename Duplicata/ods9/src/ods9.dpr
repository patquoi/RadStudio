program ods9;

uses
  Vcl.Forms,
  main_f in 'main_f.pas' {FormMain},
  base in 'base.pas',
  patience_f in 'patience_f.pas' {FormPatience};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormPatience, FormPatience);
  Application.Run;
end.
