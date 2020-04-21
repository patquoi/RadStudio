program WordKillers;

uses
  Vcl.Forms,
  base in 'base.pas',
  cststr in 'cststr.pas',
  definition_f in 'definition_f.pas' {FormDefinitionMot},
  fdmatch_f in 'fdmatch_f.pas' {FormFeuilleMatch},
  joker_f in 'joker_f.pas' {FormJoker},
  listemots_f in 'listemots_f.pas' {FormListeMots},
  main_f in 'main_f.pas' {FormMain},
  nvrecord_f in 'nvrecord_f.pas' {FormNvRecord},
  patience_f in 'patience_f.pas' {FormPatience},
  prmpose_f in 'prmpose_f.pas' {FormParamPose},
  prmsrcdef_f in 'prmsrcdef_f.pas' {FormParamSrcDef},
  propos_f in 'propos_f.pas' {FormAPropos},
  propose_f in 'propose_f.pas' {FormPropositionPose},
  rechdico_f in 'rechdico_f.pas' {FormRechercheMots},
  saisietirage_f in 'saisietirage_f.pas' {FormSaisieTirage},
  situationjetons_f in 'situationjetons_f.pas' {FormSituationJetons},
  solutions_f in 'solutions_f.pas' {FormSolutions},
  statspartie_f in 'statspartie_f.pas' {FormStatsPartie},
  tirage_f in 'tirage_f.pas' {FormTirage},
  Vcl.Themes {v1.5DM},
  Vcl.Styles {v1.5DM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Word Killers';
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
