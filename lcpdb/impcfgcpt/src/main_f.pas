unit main_f;
//---------------------------------------------------------------------------

interface
//---------------------------------------------------------------------------

uses
  Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ComCtrls;
//---------------------------------------------------------------------------

type
  TFormMain = class(TForm)
    ImageList: TImageList;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ButtonRechercher: TButton;
    Image3: TImage;
    Label3: TLabel;
    Timer: TTimer;
    LabeledEditLocalAppData: TLabeledEdit;
    Bevel1: TBevel;
    LabeledEditDossierCourant: TLabeledEdit;
    Image4: TImage;
    Image5: TImage;
    LabelParametres: TLabel;
    Image6: TImage;
    LabelFeuilleMatch: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ButtonToutCocher: TButton;
    ButtonToutDecocher: TButton;
    ButtonImporter: TButton;
    TimerRecherche: TTimer;
    Button0: TButton;
    ButtonSelectionner: TButton;
    OpenDialogCptIni: TOpenDialog;
    Button2: TButton;
    Button1: TButton;
    RadioGroupModeImport: TRadioGroup;
    procedure TimerTimer(Sender: TObject);
    procedure ButtonRechercherClick(Sender: TObject);
    procedure ButtonToutCocherClick(Sender: TObject);
    procedure ButtonToutDecocherClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure TimerRechercheTimer(Sender: TObject);
    procedure ButtonSelectionnerClick(Sender: TObject);
    procedure ButtonDetailsClick(Sender: TObject);
    procedure ButtonVoirClick(Sender: TObject);
    procedure ButtonImporterClick(Sender: TObject);
  private
    procedure AffecteImage(const ImageId : Integer; const Coche : boolean);
    function FichierExistantEtDeTailleNonNulle(const stNomFichier : String) : Boolean;
    function TrouveFichierDupIni(const stChemin : String) : Boolean;
    procedure AnalyseDossierTrouve;
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------

const stFiltreCptIni      = 'lcpdb.ini';
//---------------------------------------------------------------------------

var
  FormMain: TFormMain;
//---------------------------------------------------------------------------

implementation
//---------------------------------------------------------------------------

uses WinApi.Windows, System.SysUtils, ShellApi, System.StrUtils, dtlcfg_f;
//---------------------------------------------------------------------------

{$R *.dfm}
//---------------------------------------------------------------------------

const stFiltreStats       = 'Statistiques.html';
      stFiltreDossiers    = '*.*';

const stNomFichierAVoir : array [1..2] of String = (stFiltreCptIni, stFiltreStats);
//---------------------------------------------------------------------------

var stLecteurCourant,
    stCheminCibleInstall  : String; // Transmis en paramètres via Inslcpdb
    slCheminsTrv          : TStringList;
//---------------------------------------------------------------------------
function TFormMain.FichierExistantEtDeTailleNonNulle(const stNomFichier : String) : Boolean;
var sr : TSearchRec;
begin
Result:=False; // Pessimiste
if FileExists(stNomFichier) then
  if FindFirst(stNomFichier, faNormal, sr)=0 then
    begin
    Result:=(sr.Size>0); // Si taille nulle, on renvoie False
    FindClose(sr);
    end;
end;
//---------------------------------------------------------------------------
function TFormMain.TrouveFichierDupIni(const stChemin : String) : Boolean;
var i  : Char;
    sr : TSearchRec;
begin
Result:=False; // Pessimiste !
if stChemin = '' then // Lancement depuis le bouton Rechercher (appel initial)
  begin
    begin // On part de zéro... On balaie les lecteurs fixes
    for i := 'A' to 'Z' do // On scrute les lecteurs fixes (disques durs)
      begin
      stLecteurCourant[1]:=i;
      if GetDriveType(pChar(stLecteurCourant)) = DRIVE_FIXED then
        begin
        Result:=TrouveFichierDupIni(stLecteurCourant+'\');
        if Result then Exit; // On trouve on sort sinon on continue...
        end
      end
    end
  end
else // On a un chemin : on recherche d'abord lcpdb.ini
  begin
  LabeledEditDossierCourant.Text:=stChemin;
  LabeledEditDossierCourant.Repaint;
  if (slCheminsTrv.IndexOf(stChemin) = -1) then // Pas déjà trouvé
    if FindFirst(stChemin+stFiltreCptIni, faNormal, sr)=0 then
      begin // On a trouvé : on sort avec le chemin dans stDrnCheminTrv
      slCheminsTrv.Add(stChemin);
      Result:=True;
      FindClose(sr);
      Exit
      end
    else
      FindClose(sr);
  // On recherche ensuite en profondeur
  if FindFirst(stChemin+stFiltreDossiers, faDirectory+faHidden, sr)=0 then
    repeat
      if (sr.Name <> '.') and (sr.Name <> '..') and
         ((sr.Attr and faDirectory) = faDirectory) then
        begin
        Result:=TrouveFichierDupIni(stChemin+sr.Name+'\');
        if Result then
          begin
          FindClose(sr);
          Exit // On trouve on sort sinon on continue...
          end
        end
    until FindNext(sr) <> 0;
  FindClose(sr);
  end
end{TrouveFichierDupIni};
//---------------------------------------------------------------------------

procedure TFormMain.AffecteImage(const ImageId : Integer; const Coche : boolean);
var Image : TImage;
begin
Image := FindComponent('Image'+IntToStr(ImageId)) as TImage;
Image.Picture.Bitmap:= nil;
ImageList.GetBitmap(Ord(Coche), Image.Picture.Bitmap);
if ImageId > 4 then
  begin
  with FindComponent('CheckBox'+IntToStr(ImageId-4)) as TCheckBox do
    begin
    Enabled:=Coche;
    Checked:=Coche;
    end;
  (FindComponent('Button'+IntToStr(ImageId-4)) as TButton).Enabled:=Coche;
  if ImageId = 5 then Button0.Enabled:=Coche; // Bouton Détails
  end;
end{function TFormMain.AffecteImage};
//---------------------------------------------------------------------------

procedure TFormMain.AnalyseDossierTrouve;
begin
AffecteImage(5, FichierExistantEtDeTailleNonNulle(slCheminsTrv[slCheminsTrv.Count-1]+stFiltreCptIni));
AffecteImage(6, FichierExistantEtDeTailleNonNulle(slCheminsTrv[slCheminsTrv.Count-1]+stFiltreStats));
ButtonToutCocher.Enabled:=True;
ButtonToutDecocher.Enabled:=True;
ButtonImporter.Enabled:=True;
RadioGroupModeImport.Enabled:=True;
end;
//---------------------------------------------------------------------------

procedure TFormMain.TimerRechercheTimer(Sender: TObject);
begin
TimerRecherche.Enabled:=False;
if TrouveFichierDupIni('') then
  begin
  AffecteImage(4, True);
  AnalyseDossierTrouve;
  end
else
  begin
  AffecteImage(4, False);
  LabeledEditDossierCourant.Text:='';
  end;
ButtonRechercher.Enabled:=True;
ButtonSelectionner.Enabled:=True;
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonSelectionnerClick(Sender: TObject);
begin
if OpenDialogCptIni.Execute then
  begin
  LabeledEditDossierCourant.Text:=ExtractFilePath(OpenDialogCptIni.FileName);
  slCheminsTrv.Add(LabeledEditDossierCourant.Text);
  AnalyseDossierTrouve
  end
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonDetailsClick(Sender: TObject);
begin
FormDetailConfig:=TFormDetailConfig.Create(self);
with FormDetailConfig do
  try
    ShowModal
  finally
    Release
  end;
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonImporterClick(Sender: TObject);
var i, n      : Integer;
    stSource,
    stCible   : String;
begin
n:=0;
// On copie d'abord les fichiers...
for i:=1 to 2 do
  if (FindComponent('CheckBox'+IntToStr(i)) as TCheckBox).Checked then
    begin
    stSource:=LabeledEditDossierCourant.Text+stNomFichierAVoir[i];
    stCible:=LabeledEditLocalAppData.Text+stNomFichierAVoir[i];
    if not CopyFile(pChar(stSource), pChar(stCible), False) then
      begin
      Application.MessageBox(pChar(Format('Impossible de copier "%s" dans "%s" !', [stSource, LabeledEditLocalAppData.Text])), 'L''import a échoué !', MB_ICONHAND);
      exit;
      end
    else
      Inc(n);
    end;
if RadioGroupModeImport.ItemIndex = 1 {Déplacer} then
  // On supprime à la source le cas échéant...
  for i:=1 to 2 do
    if (FindComponent('CheckBox'+IntToStr(i)) as TCheckBox).Checked then
      begin
      stSource:=LabeledEditDossierCourant.Text+stNomFichierAVoir[i];
      if not DeleteFile(pChar(stSource)) then
        Application.MessageBox(pChar(Format('Impossible de supprimer "%s" !', [stSource])), 'Import impossible', MB_ICONHAND);
      end;
Application.MessageBox(pChar(Format('%d fichier(s) ont été %s(s) !', [n, IfThen(RadioGroupModeImport.ItemIndex=0, 'copié', 'déplacé')])), 'L''import a réussi !', MB_ICONINFORMATION);
Application.Terminate
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonVoirClick(Sender: TObject);
var stCheminEtNomFichierAVoir : String;
begin
stCheminEtNomFichierAVoir:=LabeledEditDossierCourant.Text+stNomFichierAVoir[(sender as TButton).Tag];
ShellExecute( 0, 'Open',
              pChar(ExtractFileName(stCheminEtNomFichierAVoir)),
              Nil,
              pChar(ExtractFilePath(stCheminEtNomFichierAVoir)),
              SW_SHOWNORMAL);
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonRechercherClick(Sender: TObject);
var i : Integer;
begin
// Initialisation
Image4.Picture.Bitmap:=nil;
for i:=1 to 2 do
  begin
  (FindComponent('Image'+IntToStr(i+4)) as TImage).Picture.Bitmap:=nil;
  with (FindComponent('CheckBox'+IntToStr(i)) as TCheckBox) do
    begin
    Enabled:=False;
    Checked:=False;
    end;
  (FindComponent('Button'+IntToStr(i)) as TButton).Enabled:=False
  end;
Button0.Enabled:=False;
LabeledEditDossierCourant.Text:='';
ButtonRechercher.Enabled:=False;
ButtonSelectionner.Enabled:=False;
ButtonToutCocher.Enabled:=False;
ButtonToutDecocher.Enabled:=False;
ButtonImporter.Enabled:=False;
RadioGroupModeImport.Enabled:=False;
// On lance la recherche via un timer pour rafraîchir la page
TimerRecherche.Enabled:=True;
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonToutCocherClick(Sender: TObject);
var i : Integer;
begin
for i:=1 to 2 do
  with FindComponent('CheckBox'+IntToStr(i)) as TCheckBox do
    Checked:=Enabled;
ButtonImporter.Enabled:=True;
RadioGroupModeImport.Enabled:=True;
end;
//---------------------------------------------------------------------------

procedure TFormMain.ButtonToutDecocherClick(Sender: TObject);
var i : Integer;
begin
for i:=1 to 2 do
  with FindComponent('CheckBox'+IntToStr(i)) as TCheckBox do
    Checked:=False;
ButtonImporter.Enabled:=False;
RadioGroupModeImport.Enabled:=False;
end;
//---------------------------------------------------------------------------

procedure TFormMain.CheckBoxClick(Sender: TObject);
var i   : Integer;
    OK  : Boolean;
begin
OK:=False;
for i:=1 to 2 do
  if (FindComponent('CheckBox'+IntToStr(i)) as TCheckBox).Checked then
    begin
    OK:=True;
    break;
    end;
ButtonImporter.Enabled:=OK;
RadioGroupModeImport.Enabled:=OK;
end;
//---------------------------------------------------------------------------

procedure TFormMain.TimerTimer(Sender: TObject);
//---------------------------------------------------------------------------
const stTitreMessage = 'Import de configuration lcpdb';
//---------------------------------------------------------------------------
function GetLocalAppDataDupFolder : String;
const stVarLocalAppData  = 'LocalAppData';
      stRepLocAppDataDup = '\Patquoi.fr\lcpdb';
var n : DWord;
begin
n:=0;
n:=GetEnvironmentVariable(pChar(stVarLocalAppData), nil, n);
if n>0 then
  begin
  SetLength(Result, n-1);
  if GetEnvironmentVariable(pChar(stVarLocalAppData), pChar(Result), n)<>n-1 then
    Result:=''
  else
    begin
    Result:=Result+stRepLocAppDataDup;
    if not DirectoryExists(Result) then
      if not ForceDirectories(Result) then
        Result:=''
      else
        Result:=Result+'\'
    else
      Result:=Result+'\';
    end
  end
else
  Result:=''
end{function stRepLocalAppDataDup};
//---------------------------------------------------------------------------
begin{function TFormMain.TimerTimer}
if Tag>0 then Exit; // Busy?
case Timer.Tag of
 0: begin // 1. EXISTENCE DE %LocalAppData% ?
    Tag:=1; // Busy
    LabeledEditLocalAppData.Text:=GetLocalAppDataDupFolder;
    if LabeledEditLocalAppData.Text = '' then
      begin
      AffecteImage(1, False);
      // Finalement on remplace %LocalAppData par le chemin cible de l'installation
      LabeledEditLocalAppData.Text:=stCheminCibleInstall;
      Timer.Tag:=Timer.Tag+1;
      end
    else
      begin
      AffecteImage(1, True);
      Timer.Tag:=Timer.Tag+1;
      end;
    Tag:=0; // Ready
    end;
 1: begin // 2. EXISTENCE de lcpdb.ini dans %LocalAppData% ?
    Tag:=1; // Busy
    if FichierExistantEtDeTailleNonNulle(LabeledEditLocalAppData.Text+'\lcpdb.ini') then
      begin
      AffecteImage(2, False);
      Timer.Enabled:=False;
      with Application do
        begin
        MessageBox('Vous avez déjà une configuration lcpdb dans votre dossier cible des données d''application.'#13#13+
                   'Elle sera donc prise en compte automatiquement après installation de la nouvelle version.', stTitreMessage, MB_ICONINFORMATION);
        Terminate
        end
      end
    else
      begin
      AffecteImage(2, True);
      Timer.Tag:=Timer.Tag+1;
      end;
    Tag:=0; // Ready
    end;
 2: begin
    Tag:=1; // Busy
    AffecteImage(3, True);
    ButtonRechercher.Enabled:=True;
    ButtonSelectionner.Enabled:=True;
    Timer.Enabled:=False;
    Application.MessageBox('Vous n''avez pas de configuration lcpdb dans votre dossier cible des données d''application.'#13#13+
                           'Si vous avez déjà installé lcpdb dans un autre dossier, vous pouvez importer la configuration en lançant une recherche ou en sélectionnant vous même le fichier de configuration.', stTitreMessage, MB_ICONINFORMATION);

    Tag:=0; // Ready
    end;
end{case Tag of};
end{function TFormMain.TimerTimer};
//---------------------------------------------------------------------------

initialization
stLecteurCourant:=' :';
stCheminCibleInstall:=ParamStr(1)+'\';
slCheminsTrv:=TStringList.Create;
slCheminsTrv.Sorted:=False;
//---------------------------------------------------------------------------

finalization
slCheminsTrv.Free;
//---------------------------------------------------------------------------

end.
