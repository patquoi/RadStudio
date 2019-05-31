unit dtlcfg_f;
//---------------------------------------------------------------------------

interface
//---------------------------------------------------------------------------

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList;
//---------------------------------------------------------------------------

type
  TFormDetailConfig = class(TForm)
    LabeledEditFichierIni: TLabeledEdit;
    LabeledEditDateHeureModification: TLabeledEdit;
    TreeView: TTreeView;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
  private
    procedure LitParametres;
  public
    { D�clarations publiques }
  end;
//---------------------------------------------------------------------------

var
  FormDetailConfig: TFormDetailConfig;
//---------------------------------------------------------------------------

implementation
//---------------------------------------------------------------------------

uses System.SysUtils, System.IniFiles, main_f;
//---------------------------------------------------------------------------

{$R *.dfm}
//---------------------------------------------------------------------------

const stSectionAffichage  = 'Affichage';
      stSectionParametres = 'Param�tres';

      ImgIdxMenu    = 0; // Menu (Affichage/Param�tres)
      ImgIdxBool    = 1; // Non/Oui
      ImgIdxPartie  = 3; // Ind�fini/Standard/Joker
      ImgIdxTemps   = 6; // Ind�fini/Blitz/Semi-rapide/Normal
      ImgIdxPose    = 10; // Top/Score sur top/Rang
      ImgIdxRapport = 13;// Pourcentage/Note sur 20
//---------------------------------------------------------------------------

procedure TFormDetailConfig.LitParametres;
var i       : Integer;
    IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(LabeledEditFichierIni.Text);
try
  for i:=0 to TreeView.Items.Count-1 do
    begin
    if TreeView.Items[i].Text = 'Nouveaux records' then
      TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionAffichage, 'NR', True))
    else
      if TreeView.Items[i].Text = 'Rapports' then
        TreeView.Items[i].ImageIndex:=ImgIdxRapport+Ord(IniFile.ReadBool(stSectionAffichage, 'FR', False))
      else
        if TreeView.Items[i].Text = 'Journal de recherche' then
          TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'JRS', False))
        else
          if TreeView.Items[i].Text = 'Type de partie' then
            TreeView.Items[i].ImageIndex:=ImgIdxPartie+IniFile.ReadInteger(stSectionParametres, 'TP', 1)
          else
            if TreeView.Items[i].Text = 'Temps de r�flexion' then
              TreeView.Items[i].ImageIndex:=ImgIdxTemps+IniFile.ReadInteger(stSectionParametres, 'TR', 3)
            else
              if TreeView.Items[i].Text = 'Temps limit�' then
                TreeView.Items[i].ImageIndex:=ImgIdxBool+   Ord(IniFile.ReadBool(stSectionParametres, 'TL', True))
              else
                if TreeView.Items[i].Text = 'Proposition incorrecte sanctionn�e' then
                  TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'PIS', True))
                else
                  if TreeView.Items[i].Text = 'G�n�rer auto. Feuille de match d�taill�e' then
                    TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'GAF', True))
                  else
                    if TreeView.Items[i].Text = 'G�n�rer liste toutes solutions' then
                      TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'LTS', False))
                    else
                      if TreeView.Items[i].Text = 'Enregistrer automatiquement la partie' then
                        TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'EPA', True))
                      else
                        if TreeView.Items[i].Text = 'Placer la proposition automatiquement' then
                          TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'PPA', False))
                        else
                          if TreeView.Items[i].Text = 'Enregistrer les param�tres en quittant' then
                            TreeView.Items[i].ImageIndex:=ImgIdxBool+Ord(IniFile.ReadBool(stSectionParametres, 'EEQ', True))
                           else
                            if TreeView.Items[i].Text = 'Type' (* Qualit� de pose *) then
                              TreeView.Items[i].ImageIndex:=ImgIdxPose+IniFile.ReadInteger(stSectionParametres, 'TQP', 0)
                            else
                              if TreeView.Items[i].Text = 'Pourcentage' (* Qualit� de pose *) then
                                TreeView.Items[i].Text:=Format('Pourcentage (%d)', [IniFile.ReadInteger(stSectionParametres, 'PQP', 100)]);
    end{for};
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------

procedure TFormDetailConfig.FormShow(Sender: TObject);
var sr : TSearchRec;
begin
LabeledEditFichierIni.Text:=FormMain.LabeledEditDossierCourant.Text+stFiltreDupIni;
if FindFirst(LabeledEditFichierIni.Text, faNormal, sr)=0 then
  LabeledEditDateHeureModification.Text:=DateTimeToStr(sr.TimeStamp, TFormatSettings.Create('fr-FR'));
FindClose(sr);
TreeView.FullExpand;
LitParametres;
end;
//---------------------------------------------------------------------------

end.
