unit solutions_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;
//---------------------------------------------------------------------------
type
  TTypePose = (tpMeilleure, tpAucune, tpManuelle); // v1.4
  TFormSolutions = class(TForm)
    StatusBar: TStatusBar;
    ListBox: TListBox;
    LabelPresentation: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
  private
    DernierChoix : Integer;
  public
    Score : Integer;
    function ChoisitSolution(const slSolutions : TStringList) : TTypePose; // v1.4 : Permet de spécifier entre le choix parmi les meilleures et une solution proposée
  end;
//---------------------------------------------------------------------------
var
  FormSolutions: TFormSolutions;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses System.Math, base, main_f, fdmatch_f, tirage_f, prmpose_f, definition_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
const // v1.5 : Chaîne avec retours-chariots remplacée par un tableau de chaînes sans retours-chariots :
  NbLignesLibelle = 4; // v1.5
  stFrmLibelle : array [1..NbLignesLibelle] of String = ('%d solution(s) rapportent le score de %d points (%d%% %s)...', // v1.5.5 "(%d%% %s)..."
                                                         ' - Cliquez (une fois) sur une solution pour la visualiser ou utilisez les flèches,',
                                                         ' - Double cliquez sur celle que vous souhaitez jouer',
                                                         ' ou appuyez sur la touche [Entrée] si la solution souhaitée est sélectionnée.');
  stQualite    : array [TTypeQualitePose] of String = ('','du top','du top', 'du rang'); // v1.5.5
//---------------------------------------------------------------------------
procedure TFormSolutions.FormCreate(Sender: TObject);
begin
ListBox.Sorted:=True // v1.5 : pour trier sur la position
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.ListBoxDblClick(Sender: TObject);
begin
ModalResult:=MrOk;
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.FormHide(Sender: TObject);
begin
if DernierChoix>-1 then
  begin
  with ListBox.Items.Objects[DernierChoix] as TSolution do
    begin
    FormMain.RetireProposition(x, y, d);
    DechargeLettresJoker(p.LettreJoker);
    end
  end
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin // v1.6
if (Shift = [ssShift, ssCtrl]) and (Key=68) then // Raccourci Maj+Ctrl+D > Definition de mot
  FormMain.ActionActionsRechercherDefinitionMotExecute(FormMain.ActionActionsRechercherDefinitionMot)
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.FormKeyPress(Sender: TObject; var Key: Char);
begin
// v1.5.1 : Touche Entrée = mrOk ; Touche Echap = mrCancel
if (Key=#13) and (ListBox.ItemIndex>-1) then
  ModalResult:=MrOk;
if Key=#27 then
  ModalResult:=mrCancel;
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.FormShow(Sender: TObject);
var i,LgrMax:Integer;
begin
Top:=FormTirage.Top+FormTirage.Height;
Left:=FormMain.Left+FormMain.Width;
// v1.5 : on calcule la taille minimale du libellé du texte
LgrMax:=LabelPresentation.Canvas.TextWidth(stFrmLibelle[1]);
for i:=2 to NbLignesLibelle do
  LgrMax:=Max(LgrMax,LabelPresentation.Canvas.TextWidth(stFrmLibelle[i]));
with LabelPresentation.Constraints do
  begin
  MinWidth:=LgrMax;
  MinHeight:=NbLignesLibelle*LabelPresentation.Canvas.TextHeight(LabelPresentation.Caption)
  end;
if FormFeuilleMatch<>nil then
  begin
  Width:=FormFeuilleMatch.Width;
  Height:=FormFeuilleMatch.Height
  end;
ListBox.ItemIndex:=-1;
DernierChoix:=-1;
end;
//---------------------------------------------------------------------------
procedure TFormSolutions.ListBoxClick(Sender: TObject);
begin
if DernierChoix>-1 then
  with ListBox.Items.Objects[DernierChoix] as TSolution do
    begin
    FormMain.RetireProposition(x, y, d);
    DechargeLettresJoker(p.LettreJoker);
    end;
DernierChoix:=ListBox.ItemIndex;
with ListBox.Items.Objects[DernierChoix] as TSolution do
  begin
  ChargeLettresJoker(p.LettreJoker);
  FormMain.PoseProposition(x, y, d, Chevalet, Debut, Fin);
  end;
if FormDefinitionMot<>nil then // v1.6 : propose le mot pour la recherche de définition (Maj+Ctrl+D)
  // vKA : Affichage des lettres doubles : ajout de stLettresDoubles(...) et utilisation d'AnsiLowerCase au lieu de LowerCase pour les lettres accentuées
  FormDefinitionMot.EditMot.Text:=AnsilowerCase(stLettresDoubles((FormSolutions.ListBox.Items.Objects[DernierChoix] as TSolution).stMot)); // v1.8KA on inverse l'ordre de AnsiLowerCase et stLettresDoubles sinon on a des parenthèses !!!
end;
//---------------------------------------------------------------------------
function TFormSolutions.ChoisitSolution(const slSolutions : TStringList) : TTypePose; // v1.4 (TTypePose)
var i             : Integer;
    stMsgSolution : String;
    PosSol        : array of Integer; // v1.5 : on classe les solutions par ordre de préférence de pose (selon suggestion Règle Scrabble duplicate)
                                      //        1. Le moins de jokers possibles, 2. Si moins de 7 jetons sur le chevalet alors priorité à tout placer sinon le moins de jetons à placer, 3. Le moins de valeur à placer.
procedure ClasseSolutions; // v1.5 : classement des solutions
  var i, j,
      NbJetonsTirage : Integer;
      NbJetonsAPlacer,
      NbJokersAPlacer,
      ValeurAPlacer : array of Integer;
  begin
  NbJetonsTirage:=p.NbJetonsAJouer;
  SetLength(PosSol, slSolutions.Count);
  SetLength(NbJetonsAPlacer, slSolutions.Count);
  SetLength(NbJokersAPlacer, slSolutions.Count);
  SetLength(ValeurAPlacer, slSolutions.Count);
  for i:=0 to slSolutions.Count-1 do
    with slSolutions.Objects[i] as TSolution do
      begin
      PosSol[i]:=1;
      NbJetonsAPlacer[i]:=Fin-Debut+1;
      NbJokersAPlacer[i]:=p.NbJokersAPlacer(Chevalet, Debut, Fin);
      ValeurAPlacer[i]:=p.ValeurAPlacer(Chevalet, Debut, Fin);
      end;
  for i:=0 to slSolutions.Count-1 do
    for j:=0 to slSolutions.Count-1 do
      if (NbJokersAPlacer[i]>NbJokersAPlacer[j]) or        // 1. Le moins de jokers à placer
         ((NbJokersAPlacer[i]=NbJokersAPlacer[j]) and
          (((NbJetonsTirage<NbMaxJetonsTirage) and         // 2a. SI Moins de 7 jetons dans le tirage ALORS
            (Ord(NbJetonsAPlacer[i]=NbJetonsTirage)<           // Tout placer...
             Ord(NbJetonsAPlacer[j]=NbJetonsTirage))) or       // ...est la priorité
           ((NbJetonsTirage=NbMaxJetonsTirage) and         // 2b. SINON
            (NbJetonsAPlacer[i]>NbJetonsAPlacer[j])))) or  // Le moins de jetons à placer
         ((NbJokersAPlacer[i]=NbJokersAPlacer[j]) and
          (((NbJetonsTirage<NbMaxJetonsTirage) and
            (Ord(NbJetonsAPlacer[i]=NbJetonsTirage)=
             Ord(NbJetonsAPlacer[j]=NbJetonsTirage))) or
           ((NbJetonsTirage=NbMaxJetonsTirage) and
            (NbJetonsAPlacer[i]=NbJetonsAPlacer[j]))) and
          (ValeurAPlacer[i]>ValeurAPlacer[j])) then       //  3. Le moins de valeur à placer (total de la valeur des jetons à placer)
        Inc(PosSol[i]);
  Finalize(NbJetonsAPlacer);
  Finalize(NbJokersAPlacer);
  Finalize(ValeurAPlacer)
  end{procedure ClasseSolutions};
begin
if slSolutions.Count=0 then // v1.4
  begin
  Result:=tpAucune;
  Exit
  end
else
  Result:=tpMeilleure;
ListBox.Items.Clear; // v1.4.1
if slSolutions.Count=1 then // v1.5 : on n'ajoute pas la position de choix si qu'une seule solution
  ListBox.Items.AddObject(slSolutions.Strings[0], slSolutions.Objects[0]) // vKA : affichage des lettres doubles : ajout de stLettresDoubles(...)
else
  begin
  ClasseSolutions;  // v1.5 : classement des solutions
  for i:=0 to slSolutions.Count-1 do
    ListBox.Items.AddObject(Format('%4d. ', [PosSol[i]])+ // v1.5 : classement des solutions
                            slSolutions.Strings[i],
                            slSolutions.Objects[i]);
  Finalize(PosSol) // v1.5 : classement des solutions
  end;
if FormMain.DemoEnCours then // Démo : on choisit au hasard
  begin
  ListBox.ItemIndex:=Random(slSolutions.Count);
  Exit
  end;
if slSolutions.Count=1 then // v1.4 : On a déplacé ici le cas solution unique pour pouvoir annuler la pose de la meilleure solution
  begin // Si une seule solution, pas besoin d'afficher, le choix est fait !
  ListBox.ItemIndex:=0;
  if FormDefinitionMot<>nil then // v1.6 : propose le mot pour la recherche de définition (Maj+Ctrl+D)
    // vKA : Affichage des lettres doubles : ajout de stLettresDoubles(...) et utilisation d'AnsiLowerCase au lieu de LowerCase pour les lettres accentuées
    FormDefinitionMot.EditMot.Text:=AnsiLowerCase(stLettresDoubles((FormSolutions.ListBox.Items.Objects[FormSolutions.ListBox.ItemIndex] as TSolution).stMot)); // v1.8KA on inverse l'ordre de AnsiLowerCase et stLettresDoubles sinon on a des parenthèses !!!
  with ListBox.Items.Objects[FormSolutions.ListBox.ItemIndex] as TSolution, FormMain do
    begin // On la présente avant de la mettre en place
    ChargeLettresJoker(p.LettreJoker);
    PoseProposition(x, y, d, Chevalet, Debut, Fin);
    if not FormMain.DemoEnCours then // v1.4 : ChoixFait permet de savoir si l'on annule et on choisit la pose manuelle d'une autre solution
      begin // v1.5 : stMsgSolution
      stMsgSolution:=Format('Il n''y a qu''une seule solution rapportant le score de %d points (%d%% %s) avec le mot ', // v1.5 : deux ':' consécutifs éliminés. v1.5.5 : Qualité "(%s)". v1.5.6 : Retour à la ligne supprimé.
                            [p.ScoreSolPose, // v1.5.5 : à la place de p.ScoreTop[p.Tour],
                             FormParamPose.QualitePose, stQualite[FormParamPose.TypeQualitePose]])+ // v1.5.5
                            FormSolutions.ListBox.Items.Strings[FormSolutions.ListBox.ItemIndex]+'.'#13#13+
                            FormSolutions.StatusBar.SimpleText;
      case AfficheMessage(stMsgSolution, // v1.5 : stMsgSolution
                          'Solution unique',
                          MB_ICONINFORMATION+MB_OKCANCEL) of
        IDOK:     if FormMain.ActionOptionsPlacerPropositionAuto.Checked then // v1.6.9
                    begin
                    FormMain.PlacementPropositionAuto:=True;
                    Result:=tpManuelle
                    end
                  else
                    Result:=tpMeilleure;
        IDCANCEL: begin
                  FormMain.PlacementPropositionAuto:=False; // v1.6.9
                  Result:=tpManuelle
                  end
      end{case of}
      end;
    RetireProposition(x, y, d);
    DechargeLettresJoker(p.LettreJoker);
    Exit
    end
  end
else
  begin
  // v1.5 : Chaîne avec retours-chariots remplacée par un tableau de chaînes sans retours-chariots :
  LabelPresentation.Caption:=Format(stFrmLibelle[1], [slSolutions.Count,
                                                      p.ScoreSolPose, // v1.5.5 : à la place de p.ScoreTop[p.Tour],
                                                      FormParamPose.QualitePose, stQualite[FormParamPose.TypeQualitePose]]); // v1.5.5
  for i:=2 to NbLignesLibelle do
    LabelPresentation.Caption:=LabelPresentation.Caption+#13+stFrmLibelle[i];
  if ShowModal = mrCancel then // v1.4
    begin
    FormMain.PlacementPropositionAuto:=False; // v1.6.9
    Result:=tpManuelle
    end
  else
    if FormMain.ActionOptionsPlacerPropositionAuto.Checked then // v1.6.9
      begin
      FormMain.PlacementPropositionAuto:=True;
      Result:=tpManuelle
      end
    else
      Result:=tpMeilleure;
  if ListBox.ItemIndex=-1 then
    ListBox.ItemIndex:=0
  end
end;
//---------------------------------------------------------------------------
end.
