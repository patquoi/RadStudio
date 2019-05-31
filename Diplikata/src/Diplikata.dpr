program Diplikata;

uses
  Vcl.Forms,
  main_f in 'main_f.pas' {FormMain},
  base in 'base.pas',
  cststr in 'cststr.pas',
  tirage_f in 'tirage_f.pas' {FormTirage},
  patience_f in 'patience_f.pas' {FormPatience},
  fdmatch_f in 'fdmatch_f.pas' {FormFeuilleMatch},
  joker_f in 'joker_f.pas' {FormJoker},
  solutions_f in 'solutions_f.pas' {FormSolutions},
  statspartie_f in 'statspartie_f.pas' {FormStatsPartie},
  saisietirage_f in 'saisietirage_f.pas' {FormSaisieTirage},
  rechdico_f in 'rechdico_f.pas' {FormRechercheMots},
  situationjetons_f in 'situationjetons_f.pas' {FormSituationJetons},
  propose_f in 'propose_f.pas' {FormPropositionPose},
  propos_f in 'propos_f.pas' {FormAPropos},
  nvrecord_f in 'nvrecord_f.pas' {FormNvRecord},
  prmpose_f in 'prmpose_f.pas' {FormParamPose},
  listemots_f in 'listemots_f.pas' {FormListeMots},
  definition_f in 'definition_f.pas' {FormDefinitionMot},
  prmsrcdef_f in 'prmsrcdef_f.pas' {FormParamSrcDef},
  langue in 'langue.pas';
  
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Diplikata';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormTirage, FormTirage);
  Application.CreateForm(TFormFeuilleMatch, FormFeuilleMatch);
  Application.CreateForm(TFormJoker, FormJoker);
  Application.CreateForm(TFormSolutions, FormSolutions);
  Application.CreateForm(TFormStatsPartie, FormStatsPartie);
  Application.CreateForm(TFormSaisieTirage, FormSaisieTirage);
  Application.CreateForm(TFormRechercheMots, FormRechercheMots);
  Application.CreateForm(TFormNvRecord, FormNvRecord);
  Application.CreateForm(TFormParamPose, FormParamPose);
  Application.CreateForm(TFormDefinitionMot, FormDefinitionMot);
  Application.Run;
end.
