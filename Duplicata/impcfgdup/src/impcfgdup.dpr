program impcfgdup;

uses
  Vcl.Forms,
  main_f in 'main_f.pas' {FormMain},
  dtlcfg_f in 'dtlcfg_f.pas' {FormDetailConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
