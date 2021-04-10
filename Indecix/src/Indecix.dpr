program Indecix;

uses
  Vcl.Forms,
  main_f in 'main_f.pas' {FormMain},
  base in 'base.pas',
  joueurs_f in 'joueurs_f.pas' {FormJoueurs};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
