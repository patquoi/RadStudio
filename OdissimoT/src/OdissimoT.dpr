program OdissimoT;

uses
  System.StartUpCopy,
  FMX.Forms,
  main_f in 'main_f.pas' {FormMain},
  dico in 'dico.pas',
  tirages in 'tirages.pas',
  anagrammes in 'anagrammes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
