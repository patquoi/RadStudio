program Kregwodiko;

uses
  Forms,
  main_f in 'main_f.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
