unit rechdico_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, base;
//---------------------------------------------------------------------------
type
  TModeRecherche   = (mrMot, mrTirage); // Mot=Ordonné. Tirage=Désordonné
  TPositionCritere = 1..NbCasesCote;
  TLettre          = 'A'..'Z';
  TFormRechercheMots = class(TForm)
    RadioGroupOrdre: TRadioGroup;
    Edit: TEdit;
    ButtonRechercher: TButton;
    LabelInfosJokers: TLabel;
    StatusBar: TStatusBar;
    Memo: TMemo;
    procedure RadioGroupOrdreClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ButtonRechercherClick(Sender: TObject);
  private
    TimerEnabled : Boolean; // v1.5
    NbJokers : Integer;
    PosJoker : array [TPositionCritere] of TPositionCritere;
    slDelta7 : TStringList; // v1.8
    procedure Recherche(stTirage : String); // v1.8.2 : plus de paramètre ModeRecherche
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
var
  FormRechercheMots: TFormRechercheMots;
//---------------------------------------------------------------------------
implementation
//----------------------------------------------------------------------------
{$R *.dfm}
//----------------------------------------------------------------------------
uses
  main_f, patience_f;
//---------------------------------------------------------------------------
var
(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajoutée à la boîte de dialogue
  F                    : TextFile;
  stNomFichierAuto,
  stNomFichierResultat : String;
*)
  NbMotsTrouves,
  iPossJokers          : Integer;
//----------------------------------------------------------------------------
const
  NbMaxJokers     = 7;
  stModeRecherche : array [TModeRecherche] of String  = ('Mots ', 'Tirage ');
  NbPossJokers    : array [0..NbMaxJokers] of Integer = (1, 26, 351, 3276, 23751, 142506, 736281, 3365856);
//----------------------------------------------------------------------------
procedure TFormRechercheMots.ButtonRechercherClick(Sender: TObject);
var i, Taille,
    IndexMot,
    Pourcentage   : Integer;
    LettreJoker1,
    LettreJoker2,
    LettreJoker3,
    LettreJoker4,
    LettreJoker5,
    LettreJoker6,
    LettreJoker7  : Char;
    stTirage,
    stMot         : String; // v1.8
    ModeRecherche : TModeRecherche;
begin
ModeRecherche:=TModeRecherche(RadioGroupOrdre.ItemIndex);
stTirage:=Edit.Text;
Taille:=Length(Edit.Text);
NbJokers:=0;
if Taille<NbLettresMinMot then
  begin
  FormMain.AfficheMessage(Format('Vous devez préciser un tirage ou un filtre de mots d''au moins %d caractères.',
                                 [NbLettresMinMot]),
                          'Critère non autorisé',
                          MB_ICONHAND);
  Edit.SetFocus; //v1.4.7
  Exit
  end;
// 1. On calcule le nombre de jokers
for i:=Low(TPositionCritere) to High(TPositionCritere) do
  if (i<=Taille) and (stTirage[i]=stJoker) then
    begin
    Inc(NbJokers);
    PosJoker[NbJokers]:=i
    end;
if (ModeRecherche=mrTirage) and (NbJokers>NbMaxJokers) then
  begin
  FormMain.AfficheMessage(Format('Pour des soucis de durée de recherche, le nombre de jokers est limité à %d en mode tirage.',
                                 [NbMaxJokers]),
                          'Critère non autorisé',
                          MB_ICONHAND);
  Edit.SetFocus; //v1.4.7
  Exit
  end;
NbMotsTrouves:=0;

(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajoutée à la boîte de dialogue
// Création auto du nom de fichier de sortie
stNomFichierAuto:=stModeRecherche[ModeRecherche]+stTirage+'.txt';
for i:=1 to Length(stNomFichierAuto) do
  if stNomFichierAuto[i]='?' then
    stNomFichierAuto[i]:='_';
stNomFichierResultat:=stRepLocalAppData+stNomFichierAuto; // v1.8.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
// Ouverture du fichier de sortie
AssignFile(f, stNomFichierResultat);
*)
Memo.Clear; // v 1.4.6
FormPatience:=TFormPatience.Create(Self);
try
  with FormPatience do
    begin
    Panel.Caption:='Recherche en cours. Veuillez patienter SVP...';
    Gauge.MinValue:=0;
    Gauge.MaxValue:=100;
    Gauge.Progress:=0;
    iPossJokers:=0;
    Show;
    Repaint
    end;
(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajoutée à la boîte de dialogue
  Rewrite(f);
  WriteLn(f, Format('%s: %s', [stModeRecherche[ModeRecherche], stTirage]));
*)
  if ModeRecherche=mrMot then
    begin
    IndexMot:=-1;
    repeat
      IndexMot:=p.Dico.IndexProchainMot(IndexMot, stTirage);
      if IndexMot>-1 then
        begin
        // WriteLn(f, Format('%s ', [p.Dico.stMotDico(Length(stTirage), IndexMot)])); // v1.4.6
        stMot:=p.Dico.stMotDico(Length(stTirage), IndexMot);
        if slDelta7.IndexOf(stMot)>-1 then Memo.Lines.Add('*'+stMot) // v1.8
        else Memo.Lines.Add(stMot); // v1.4.6
        Inc(NbMotsTrouves);
        with FormPatience do
          begin
          Pourcentage:=(100*(IndexMot+1)) div (nbl[Taille] div Taille);
          Gauge.Progress:=Pourcentage;
          Repaint
          end{with}
        end{if IndexMot>-1}
    until IndexMot=-1
    end
  else
    begin
    // 2. On parcourt toutes les possibilités de jokers
    if NbJokers>0 then
      for LettreJoker1:=Low(TLettre) to High(TLettre) do
        begin
        stTirage[PosJoker[1]]:=LettreJoker1;
        if NbJokers>1 then
          for LettreJoker2:=LettreJoker1 to High(TLettre) do
            begin
            stTirage[PosJoker[2]]:=LettreJoker2;
            if NbJokers>2 then
              for LettreJoker3:=LettreJoker2 to High(TLettre) do
                begin
                stTirage[PosJoker[3]]:=LettreJoker3;
                if NbJokers>3 then
                  for LettreJoker4:=LettreJoker3 to High(TLettre) do
                    begin
                    stTirage[PosJoker[4]]:=LettreJoker4;
                    if NbJokers>4 then
                      for LettreJoker5:=LettreJoker4 to High(TLettre) do
                        begin
                        stTirage[PosJoker[5]]:=LettreJoker5;
                        if NbJokers>5 then
                          for LettreJoker6:=LettreJoker5 to High(TLettre) do
                            begin
                            stTirage[PosJoker[6]]:=LettreJoker6;
                            if NbJokers>6 then
                              for LettreJoker7:=LettreJoker6 to High(TLettre) do
                                begin
                                stTirage[PosJoker[7]]:=LettreJoker7;
                                Recherche(stTirage) // v1.8.2 : plus de paramètre ModeRecherche
                                end
                            else
                              Recherche(stTirage)
                            end
                        else
                          Recherche(stTirage)
                        end
                    else
                      Recherche(stTirage)
                    end
                else
                  Recherche(stTirage)
                end
            else
              Recherche(stTirage);
            end
        else
          Recherche(stTirage);
        end
    else
      Recherche(stTirage)
  end;
finally
  (* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajoutée à la boîte de dialogue
  WriteLn(f, Format('%d mots trouvé(s)', [NbMotsTrouves]));
  CloseFile(f);
  *)
  StatusBar.SimpleText:=Format('%d mots trouvé(s). (*) Nouveauté ODS7.', [NbMotsTrouves]); // v1.4.6. v1.8 : ajout de ' (*) Nouveauté ODS7.'
  With FormPatience do
    begin
    Close;
    Release
    end;

  (* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajoutée à la boîte de dialogue
  ShellExecute(0,
               'Open',
               pChar(ExtractFileName(stNomFichierResultat)),
               nil,
               pChar(ExtractFilePath(stNomFichierResultat)), // v1.4 (plus de guillemets)
               SW_SHOWNORMAL);
  *)
end{try}
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.EditKeyPress(Sender: TObject; var Key: Char);
begin
if (Key<>#8) and
   (Key<>'?') and
   ((Key<'A') or
    (Key>'Z')) and
   ((Key<'a') or
    (Key>'z')) then
  Key:=#0
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormCreate(Sender: TObject);
begin
TimerEnabled:=False; // v1.5
// v1,8 : Nouveautés ODS7
slDelta7:=TStringList.Create;
slDelta7.Sorted:=true;
slDelta7.LoadFromFile(ExtractFilePath(ParamStr(0))+'delta7.txt');
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormDestroy(Sender: TObject);
begin
slDelta7.Free
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormHide(Sender: TObject);
begin
with FormMain do
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5 : On reprend la détection de temps imparti écoulé
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : accès l'aide en ligne (F1)
  with FormMain do
    ActionInfosAideExecute(ActionInfosAide)
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormKeyPress(Sender: TObject; var Key: Char);
begin // v1.4.7
if Key=#27 then Close
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormShow(Sender: TObject);
begin
Edit.Text:=''; // v1.4.6
StatusBar.SimpleText:='(*) Nouveauté ODS7.'; // v1.8 (au lieu de '')
Memo.Clear; // v1.4.6
Edit.SetFocus; //v1.4.7
with FormMain do
  if ReflexionEnCours then
    begin
    TimerEnabled:=TimerReflexion.Enabled;
    if TimerEnabled then
      EmpecheTempsImparti:=True // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
    end
  else
    TimerEnabled:=False
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.RadioGroupOrdreClick(Sender: TObject);
begin
Edit.SetFocus
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.Recherche(stTirage : String); // v1.8.2 : plus de paramètre ModeRecherche
var i,
    iTirageRecherche,
    Pourcentage,
    Taille            : Integer;
    Anagrammes        : TAnagrammes;
    stAnagramme       : String;
begin // ModeRecherche est obligatoirement mrTirage
Taille:=Length(stTirage);
stTirage:=stTirageTrie(stTirage);
iTirageRecherche:=p.Dico.Rech.Tirages[Taille].IndexOf(stTirage);
if iTirageRecherche>-1 then
  begin // On a trouvé des mots...
  Anagrammes:=(p.Dico.Rech.Tirages[Taille].Objects[iTirageRecherche] as TAnagrammes);
  for i:=0 to Anagrammes.NbAnagrammes-1 do
    begin
    Inc(NbMotsTrouves);
    stAnagramme:=p.Dico.stMotDico(Taille, Anagrammes.iDico[i]);
    // WriteLn(f, Format('%s ', [stAnagramme])); // v1.4.6
    if slDelta7.IndexOf(stAnagramme)>-1 then Memo.Lines.Add('*'+stAnagramme) // v1.8
    else Memo.Lines.Add(stAnagramme) // v1.4.6
    end
  end;
Inc(iPossJokers);
with FormPatience do
  begin
  Pourcentage:=(100*iPossJokers) div NbPossJokers[NbJokers];
  if Gauge.Progress<>Pourcentage then
    begin
    Gauge.Progress:=Pourcentage;
    Repaint
    end
  end
end;
//----------------------------------------------------------------------------
end.
