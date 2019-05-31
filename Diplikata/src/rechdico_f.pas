unit rechdico_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, base;
//---------------------------------------------------------------------------
type
  TModeRecherche   = (mrMot, mrTirage); // Mot=Ordonn�. Tirage=D�sordonn�
  TPositionCritere = 1..NbCasesCote;
  TFormRechercheMots = class(TForm)
    RadioGroupOrdre: TRadioGroup;
    Edit: TEdit;
    ButtonRechercher: TButton;
    LabelInfosJokers: TLabel;
    StatusBar: TStatusBar;
    Memo: TMemo;
    LabelDoublesLettres: TLabel;
    procedure RadioGroupOrdreClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ButtonRechercherClick(Sender: TObject);
  private
    TimerEnabled : Boolean; // v1.5
    NbJokers : Integer;
    PosJoker : array [TPositionCritere] of TPositionCritere;
    procedure Recherche(stTirage : String); // v1.7.4 : plus de param�tre ModeRecherche
  public
    { D�clarations publiques }
  end;
//----------------------------------------------------------------------------
var
  FormRechercheMots: TFormRechercheMots;
//----------------------------------------------------------------------------
implementation
//----------------------------------------------------------------------------
{$R *.dfm}
//----------------------------------------------------------------------------
uses
  ShellApi, patience_f, main_f, langue;
//---------------------------------------------------------------------------
var
(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajout�e � la bo�te de dialogue
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
    Pourcentage,
    i1,i2,i3,
    i4,i5,i6,i7   : Integer; // vKA : iN remplace LettreJokerN pour parcourir les 29 lettres et non les 26 lettres de 'A' � 'Z'
    stMessage,
    stTirage      : String;
    ModeRecherche : TModeRecherche;
begin
ModeRecherche:=TModeRecherche(RadioGroupOrdre.ItemIndex);
// D�but vKA : On contr�le et on filtre les doubles lettres
// stTirage:=Edit.Text;
stMessage:=stControleLettresEnJetons(Edit.Text);
if stMessage<>'' then
  begin
  FormMain.AfficheMessage(stMessage, 'Recherche impossible', MB_ICONHAND);
  Exit;
  end;
stTirage:=stLettresEnJetons(Edit.Text);
if (Length(stTirage)<NbLettresMinMot) or (Length(stTirage)>NbLettresMaxMot) then
  begin
  FormMain.AfficheMessage('Vous devez entrer un tirage ou un filtre de 2 � 15 jetons.', 'Recherche impossible', MB_ICONHAND);
  Exit;
  end;

// Fin vKA
Taille:=Length(Edit.Text);
NbJokers:=0;
if Taille<NbLettresMinMot then
  begin
  FormMain.AfficheMessage(Format('Vous devez pr�ciser un tirage ou un filtre de mots d''au moins %d caract�res.',
                                 [NbLettresMinMot]),
                          'Crit�re non autoris�',
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
  FormMain.AfficheMessage(Format('Pour des soucis de dur�e de recherche, le nombre de jokers est limit� � %d en mode tirage.',
                                 [NbMaxJokers]),
                          'Crit�re non autoris�',
                          MB_ICONHAND);
  Edit.SetFocus; //v1.4.7
  Exit
  end;
NbMotsTrouves:=0;

(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajout�e � la bo�te de dialogue
// Cr�ation auto du nom de fichier de sortie
stNomFichierAuto:=stModeRecherche[ModeRecherche]+stTirage+'.txt';
for i:=1 to Length(stNomFichierAuto) do
  if stNomFichierAuto[i]='?' then
    stNomFichierAuto[i]:='_';
stNomFichierResultat:=stRepLocalAppData+stNomFichierAuto; // v1.7.4 : stRepLocalAppData remplace ExtractFilePath(ParamStr(0))
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
(* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajout�e � la bo�te de dialogue
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
        Memo.Lines.Add(stJetonsEnLettres(p.Dico.stMotDico(Length(stTirage), IndexMot))); // v1.4.6. vKA : stJetonsEnLettres
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
    // 2. On parcourt toutes les possibilit�s de jokers
    // d�but vKA : LettreJokerN allant de 'A' � 'Z' (Type TLettre) remplac� par iN (integer) allant de Ord(tjA) � Ord(tjZ)
    if NbJokers>0 then
      for i1:=Ord(tjA) to Ord(tjZ) do
        begin
        stTirage[PosJoker[1]]:=stLettreJeton[TTypeJeton(i1)][1];
        if NbJokers>1 then
          for i2:=i1 to Ord(tjZ) do
            begin
            stTirage[PosJoker[2]]:=stLettreJeton[TTypeJeton(i2)][1];
            if NbJokers>2 then
              for i3:=i2 to Ord(tjZ) do
                begin
                stTirage[PosJoker[3]]:=stLettreJeton[TTypeJeton(i3)][1];
                if NbJokers>3 then
                  for i4:=i3 to Ord(tjZ) do
                    begin
                    stTirage[PosJoker[4]]:=stLettreJeton[TTypeJeton(i4)][1];
                    if NbJokers>4 then
                      for i5:=i4 to Ord(tjZ) do
                        begin
                        stTirage[PosJoker[5]]:=stLettreJeton[TTypeJeton(i5)][1];
                        if NbJokers>5 then
                          for i6:=i5 to Ord(tjZ) do
                            begin
                            stTirage[PosJoker[6]]:=stLettreJeton[TTypeJeton(i6)][1];
                            if NbJokers>6 then
                              for i7:=i6 to Ord(tjZ) do
                                begin
                                stTirage[PosJoker[7]]:=stLettreJeton[TTypeJeton(i7)][1]; // fin vKA
                                Recherche(stTirage);
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
              Recherche(stTirage);
            end
        else
          Recherche(stTirage);
        end
    else
      Recherche(stTirage)
  end;
finally
  (* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajout�e � la bo�te de dialogue
  WriteLn(f, Format('%d mots trouv�(s)', [NbMotsTrouves]));
  CloseFile(f);
  *)
  StatusBar.SimpleText:=Format('%d mots trouv�(s)', [NbMotsTrouves]); // v1.4.6
  With FormPatience do
    begin
    Close;
    Release
    end;

  (* // v1.4.6 : on n'enregistre plus le resultat dans un fichier mais dans la ListBox ajout�e � la bo�te de dialogue
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
   ((Key<'A') or (Key>'Z') or (Key='Q') or (Key='X')) and // D�but vKA
   (Key<>'g') and
   (Key<>'h') and
   (Key<>'i') and
   (Key<>'n') and
   (Key<>'u') then // Fin vKA
  Key:=#0
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormCreate(Sender: TObject);
begin
TimerEnabled:=False; // v1.5
GenereFichierFRIni(self); //v1.8 gestion multilingue
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormHide(Sender: TObject);
begin
with FormMain do
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5 : On reprend la d�tection de temps imparti �coul�
end;
//----------------------------------------------------------------------------
procedure TFormRechercheMots.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : acc�s l'aide en ligne (F1)
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
StatusBar.SimpleText:=''; // v1.4.6
Memo.Clear; // v1.4.6
Edit.SetFocus; //v1.4.7
with FormMain do
  if ReflexionEnCours then
    begin
    TimerEnabled:=TimerReflexion.Enabled;
    if TimerEnabled then
      EmpecheTempsImparti:=True // v1.5 : on n'arr�te plus le timer mais l'on emp�che l'interruption de la r�flexion pendant l'affichage d'un message.
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
procedure TFormRechercheMots.Recherche(stTirage : String); // v1.7.4 : plus de param�tre ModeRecherche
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
  begin // On a trouv� des mots...
  Anagrammes:=(p.Dico.Rech.Tirages[Taille].Objects[iTirageRecherche] as TAnagrammes);
  for i:=0 to Anagrammes.NbAnagrammes-1 do
    begin
    Inc(NbMotsTrouves);
    stAnagramme:=p.Dico.stMotDico(Taille, Anagrammes.iDico[i]);
    // WriteLn(f, Format('%s ', [stAnagramme])); // v1.4.6
    Memo.Lines.Add(stJetonsEnLettres(stAnagramme)); // v1.4.6. vKA : stJetonsEnLettres
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
