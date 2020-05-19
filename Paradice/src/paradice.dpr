program paradice;

uses
  Vcl.Forms,
  plateau_f in 'plateau_f.pas' {FormPlateau},
  base in 'base.pas',
  apropos_f in 'apropos_f.pas' {FormAPropos},
  evtdes_f in 'evtdes_f.pas' {FormEvtDes},
  nvpartie_f in 'nvpartie_f.pas' {FormNvPartie};

{$R *.res}

begin
  Application.Initialize;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Paradice';
  Application.CreateForm(TFormPlateau, FormPlateau);
  Application.CreateForm(TFormNvPartie, FormNvPartie);
  Application.Run;
end.
