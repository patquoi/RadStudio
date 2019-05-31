program iAspic;

uses
  Vcl.Forms,
  main_f in 'main_f.pas' {FormMain},
  couleurs_f in 'couleurs_f.pas' {FormCouleurs},
  Base in 'Base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCouleurs, FormCouleurs);
  Application.Run;
end.
