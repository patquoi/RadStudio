unit couleurs_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFormCouleurs = class(TForm)
    GroupBoxTerrainDroite: TGroupBox;
    StatusBar: TStatusBar;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    GroupBoxPionsGauche: TGroupBox;
    GroupBoxPionsDroite: TGroupBox;
    GroupBoxTerrainGauche: TGroupBox;
    RadioButtonGTB: TRadioButton;
    RadioButtonGTR: TRadioButton;
    RadioButtonGTV: TRadioButton;
    ImageGTB: TImage;
    ImageGTR: TImage;
    ImageGTV: TImage;
    ImageDTB: TImage;
    ImageDTR: TImage;
    ImageDTV: TImage;
    RadioButtonDTV: TRadioButton;
    RadioButtonDTR: TRadioButton;
    RadioButtonDTB: TRadioButton;
    ImageGPB: TImage;
    ImageGPC: TImage;
    ImageGPJ: TImage;
    ImageGPM: TImage;
    ImageGPO: TImage;
    ImageGPP: TImage;
    ImageGPR: TImage;
    ImageGPV: TImage;
    RadioButtonGPB: TRadioButton;
    RadioButtonGPC: TRadioButton;
    RadioButtonGPJ: TRadioButton;
    RadioButtonGPM: TRadioButton;
    RadioButtonGPO: TRadioButton;
    RadioButtonGPP: TRadioButton;
    RadioButtonGPR: TRadioButton;
    RadioButtonGPV: TRadioButton;
    ImageDPO: TImage;
    ImageDPP: TImage;
    ImageDPR: TImage;
    ImageDPV: TImage;
    RadioButtonDPV: TRadioButton;
    RadioButtonDPR: TRadioButton;
    RadioButtonDPP: TRadioButton;
    RadioButtonDPO: TRadioButton;
    ImageDPB: TImage;
    ImageDPC: TImage;
    ImageDPJ: TImage;
    ImageDPM: TImage;
    RadioButtonDPM: TRadioButton;
    RadioButtonDPJ: TRadioButton;
    RadioButtonDPC: TRadioButton;
    RadioButtonDPB: TRadioButton;
    ButtonAppliquer: TButton;
    procedure ButtonAppliquerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormCouleurs: TFormCouleurs;

implementation

{$R *.dfm}

uses Vcl.Samples.Gauges, base, main_f;

procedure TFormCouleurs.ButtonAppliquerClick(Sender: TObject);

procedure ChangeCouleurPanels(const stPrefixePanel : String);
  begin
  (FormMain.FindComponent(stPrefixePanel+'JGauche') as TPanel).Font.Color:=CouleurJoueur[CouleurPion[jGauche]];
  (FormMain.FindComponent(stPrefixePanel+'JDroite') as TPanel).Font.Color:=CouleurJoueur[CouleurPion[jDroite]];
  end;

procedure ChangeCouleursGauge(const Gauge : TGauge);
  begin
  with Gauge do
    begin
    ForeColor:=CouleurJoueur[CouleurPion[jGauche]];
    BackColor:=CouleurJoueur[CouleurPion[jDroite]];
    end
  end;
begin
CouleurTerrain[cGauche]:= TCouleurTerrain(0*Ord(RadioButtonGTB.Checked)+
                                          1*Ord(RadioButtonGTR.Checked)+
                                          2*Ord(RadioButtonGTV.Checked));
CouleurTerrain[cDroite]:= TCouleurTerrain(0*Ord(RadioButtonDTB.Checked)+
                                          1*Ord(RadioButtonDTR.Checked)+
                                          2*Ord(RadioButtonDTV.Checked));
CouleurPion[jGauche]:= TCouleurPion(0*Ord(RadioButtonGPB.Checked)+
                                    1*Ord(RadioButtonGPC.Checked)+
                                    2*Ord(RadioButtonGPJ.Checked)+
                                    3*Ord(RadioButtonGPM.Checked)+
                                    4*Ord(RadioButtonGPO.Checked)+
                                    5*Ord(RadioButtonGPP.Checked)+
                                    6*Ord(RadioButtonGPR.Checked)+
                                    7*Ord(RadioButtonGPV.Checked));
CouleurPion[jDroite]:= TCouleurPion(0*Ord(RadioButtonDPB.Checked)+
                                    1*Ord(RadioButtonDPC.Checked)+
                                    2*Ord(RadioButtonDPJ.Checked)+
                                    3*Ord(RadioButtonDPM.Checked)+
                                    4*Ord(RadioButtonDPO.Checked)+
                                    5*Ord(RadioButtonDPP.Checked)+
                                    6*Ord(RadioButtonDPR.Checked)+
                                    7*Ord(RadioButtonDPV.Checked));
FormMain.DrawGrid.Repaint;
ChangeCouleursGauge(FormMain.GaugeOccupation);
ChangeCouleursGauge(FormMain.GaugeDistanceJ);
ChangeCouleursGauge(FormMain.GaugeDistanceB);
ChangeCouleurPanels('PanelTitre');
ChangeCouleurPanels('PanelTemps');
FormMain.AfficheScoreEtPhase
end;

procedure TFormCouleurs.FormShow(Sender: TObject);
begin
case CouleurTerrain[cGauche] of
  ctBleu:   RadioButtonGTB.Checked:=true;
  ctRouge:  RadioButtonGTR.Checked:=true;
  ctVert:   RadioButtonGTV.Checked:=true;
end{case of};
case CouleurTerrain[cDroite] of
  ctBleu:   RadioButtonDTB.Checked:=true;
  ctRouge:  RadioButtonDTR.Checked:=true;
  ctVert:   RadioButtonDTV.Checked:=true;
end{case of};
case CouleurPion[jGauche] of
  cpBleu:   RadioButtonGPB.Checked:=true;
  cpCiel:   RadioButtonGPC.Checked:=true;
  cpJaune:  RadioButtonGPJ.Checked:=true;
  cpMauve:  RadioButtonGPM.Checked:=true;
  cpOrange: RadioButtonGPO.Checked:=true;
  cpPourpre:RadioButtonGPP.Checked:=true;
  cpRouge:  RadioButtonGPR.Checked:=true;
  cpVert:   RadioButtonGPV.Checked:=true;
end{case of};
case CouleurPion[jDroite] of
  cpBleu:   RadioButtonDPB.Checked:=true;
  cpCiel:   RadioButtonDPC.Checked:=true;
  cpJaune:  RadioButtonDPJ.Checked:=true;
  cpMauve:  RadioButtonDPM.Checked:=true;
  cpOrange: RadioButtonDPO.Checked:=true;
  cpPourpre:RadioButtonDPP.Checked:=true;
  cpRouge:  RadioButtonDPR.Checked:=true;
  cpVert:   RadioButtonDPV.Checked:=true;
end{case of};
end;

end.
