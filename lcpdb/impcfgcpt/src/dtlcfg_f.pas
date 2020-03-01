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

const stSection = 'Param�tres';

      ImgIdxMenu    = 0; // Menu (Affichage/Param�tres)
      ImgIdxBool    = 1; // Non/Oui
      NbEntrees     = 23;
      stEntree : Array[0..NbEntrees-1] of String = ('Optimisation1',
                                                    'Optimisation2',
                                                    'Optimisation3',
                                                    'Optimisation4',
                                                    'Optimisation5',
                                                    'NombreLimiteExemplairesPlaques',
                                                    'CalculerResultat',
                                                    'RetourArriereAutorise',
                                                    'Illimite',
                                                    '3Minutes',
                                                    '2Minutes',
                                                    '1Minute',
                                                    '45Secondes',
                                                    '30Secondes',
                                                    'ArreterSaisieFinTempsImparti',
                                                    'EcranTypeListe',
                                                    'EcranTypeArbre',
                                                    'FichierTypeEnonce',
                                                    'FichierTypeProfondeur',
                                                    'EntreeAfficherInfosOptimisationApresSaisie',
                                                    'SaisieAutomatiqueParametres',
                                                    'ToolBarAfficherImagesMenuPrincipal',
                                                    'ToolBarAfficherLibellesBoutons');
      stLibPrm : Array[0..NbEntrees-1] of String = ('Pas de multiplication/division par 1',
                                                    'Pas d''op�ration de m�me type en deux temps',
                                                    'Pas de r�sultat �gal � l''un des op�randes',
                                                    'Pas d''op�randes oppos�s/inverses dans une m�me op�ration',
                                                    'Pas de r�sultat interm�diaire �gal au compte',
                                                    'Nombre limit� d''exemplaires de plaques',
                                                    'Calculer automatiquement le r�sultat',
                                                    'Retour arri�re autoris�',
                                                    'Illimit�',
                                                    '3 minutes',
                                                    '2 minutes',
                                                    '1 minute',
                                                    '45 secondes',
                                                    '30 secondes',
                                                    'Arr�ter la saisie � la fin du temps imparti',
                                                    'Ecran > Type Liste',
                                                    'Ecran > Type Arbre',
                                                    'Fichier > Type Enonc�',
                                                    'Fichier > Type Profondeur',
                                                    'Afficher infos d''optimisation apr�s saisie calcul',
                                                    'Afficher le tableau apr�s nouveau compte',
                                                    'Afficher les images dans les menus',
                                                    'Afficher les libell�s sur les boutons');
      ValDefPrm : Array[0..NbEntrees-1] of Integer = (1,1,1,1,1,1,1,1,0,0,0,0,1,0,1,1,1,0,0,1,1,0,0);

//---------------------------------------------------------------------------

procedure TFormDetailConfig.LitParametres;
var i, j : Integer;
    IniFile : TIniFile;
begin
IniFile:=TIniFile.Create(LabeledEditFichierIni.Text);
try
  for i:=0 to TreeView.Items.Count-1 do
    for j:=0 to NbEntrees-1 do
      if TreeView.Items[i].Text = stLibPrm[j] then
        TreeView.Items[i].ImageIndex:=ImgIdxBool+IniFile.ReadInteger(stSection, stEntree[j], ValDefPrm[j])
finally
  FreeAndNil(IniFile);
end{try}
end;
//---------------------------------------------------------------------------

procedure TFormDetailConfig.FormShow(Sender: TObject);
var sr : TSearchRec;
begin
LabeledEditFichierIni.Text:=FormMain.LabeledEditDossierCourant.Text+stFiltreCptIni;
if FindFirst(LabeledEditFichierIni.Text, faNormal, sr)=0 then
  LabeledEditDateHeureModification.Text:=DateTimeToStr(sr.TimeStamp, TFormatSettings.Create('fr-FR'));
FindClose(sr);
TreeView.FullExpand;
LitParametres;
end;
//---------------------------------------------------------------------------

end.
