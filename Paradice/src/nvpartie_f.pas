unit nvpartie_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, base;

type
  TFormNvPartie = class(TForm)
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    Label1: TLabel;
    LabelNbJoueurs: TLabel;
    ButtonMin: TButton;
    ButtonMax: TButton;
    ButtonPrc: TButton;
    ButtonSvt: TButton;
    PaintBoxP1: TPaintBox;
    PaintBoxP2: TPaintBox;
    PaintBoxP3: TPaintBox;
    PaintBoxP4: TPaintBox;
    PaintBoxP5: TPaintBox;
    PaintBoxP6: TPaintBox;
    LabelJoueur1: TLabel;
    LabelJoueur2: TLabel;
    LabelJoueur3: TLabel;
    LabelJoueur4: TLabel;
    LabelJoueur6: TLabel;
    LabelJoueur5: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    PaintBoxC1: TPaintBox;
    PaintBoxC2: TPaintBox;
    PaintBoxC3: TPaintBox;
    PaintBoxC4: TPaintBox;
    PaintBoxC5: TPaintBox;
    PaintBoxC6: TPaintBox;
    Label2: TLabel;
    LabelPrixEvt: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonMinClick(Sender: TObject);
    procedure ButtonPrcClick(Sender: TObject);
    procedure ButtonSvtClick(Sender: TObject);
    procedure ButtonMaxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBoxCPaint(Sender: TObject);
    procedure PaintBoxPPaint(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    y0, dy, FNbj : Integer;
    procedure RafraichitInfos;
    procedure ChangeNbJoueurs(NvNbj : Integer);
    property Nbj : Integer read FNbj write ChangeNbJoueurs;
  public
    { Déclarations publiques }
  end;

var
  FormNvPartie: TFormNvPartie;

implementation

{$R *.dfm}

uses plateau_f;

procedure TFormNvPartie.RafraichitInfos;
var j : TJoueurId;
    Afficher : Boolean;
begin
LabelNbJoueurs.Caption := IntToStr(Nbj);
LabelPrixEvt.Caption := IntToStr(PrixEvt[Nbj]);
ButtonMin.Enabled := (Nbj > NbMinJoueurs);
ButtonPrc.Enabled := (Nbj > NbMinJoueurs);
ButtonSvt.Enabled := (Nbj < NbMaxJoueurs);
ButtonMax.Enabled := (Nbj < NbMaxJoueurs);
for j := Succ(Low(TJoueurId)) to Pred(High(TJoueurId)) do
  begin
  Afficher := Ord(j)<=Nbj;
  (FindComponent('LabelJoueur'+IntToStr(Ord(j))) as TLabel).Visible := Afficher;
  (FindComponent('PaintBoxP'+IntToStr(Ord(j))) as TPaintbox).Visible := Afficher;
  (FindComponent('CheckBox'+IntToStr(Ord(j))) as TCheckBox).Visible := Afficher;
  (FindComponent('PaintBoxC'+IntToStr(Ord(j))) as TPaintbox).Visible := Afficher
  end;
Height := y0 - dy * (NbMaxJoueurs - Nbj);
Refresh;
end;

procedure TFormNvPartie.ChangeNbJoueurs(NvNbj : Integer);
begin
FNbj := NvNbj;
RafraichitInfos;
end;

procedure TFormNvPartie.CheckBoxClick(Sender: TObject);
begin
Refresh
end;

procedure TFormNvPartie.FormShow(Sender: TObject);
var j       : TJoueurId;
begin
// On initialise l'écran
y0 := Height;
dy := PaintBoxP2.Top - PaintBoxP1.Top;
Nbj := NbMaxJoueurs; // Par défaut
for j := Succ(Low(TJoueurId)) to Pred(High(TJoueurId)) do
  begin
  (FindComponent('LabelJoueur'+IntToStr(Ord(j))) as TLabel).Caption := stNomJoueur[j];
  (FindComponent('CheckBox'+IntToStr(Ord(j))) as TCheckBox).Checked := (Ord(j)>=NbMinJoueurs); // Par défaut jeu solo
  end;
RafraichitInfos;
end;

procedure TFormNvPartie.PaintBoxCPaint(Sender: TObject);
var bmPion : TBitmap;
    pbPion : TPaintBox;
begin
pbPion := Sender as TPaintBox;
bmPion:=TBitmap.Create;
FormPlateau.VirtualImageListFonds.GetBitmap(pbPion.Tag, bmPion);
FormPlateau.VirtualImageListTypes.GetBitmap(Ord((FindComponent('CheckBox'+IntToStr(pbPion.Tag)) as TCheckBox).Checked), bmPion);
pbPion.Canvas.StretchDraw(TRect.Create(0, 0, pbPion.Width-1, pbPion.Height-1), bmPion);
FreeAndNil(bmPion);
end;

procedure TFormNvPartie.PaintBoxPPaint(Sender: TObject);
var bmPion : TBitmap;
    pbPion : TPaintBox;
begin
pbPion := Sender as TPaintBox;
bmPion:=TBitmap.Create;
FormPlateau.VirtualImageListJoueurs.GetBitmap(pbPion.Tag-1, bmPion);
pbPion.Canvas.StretchDraw(TRect.Create(0, 0, pbPion.Width-1, pbPion.Height-1), bmPion);
FreeAndNil(bmPion);
end;

procedure TFormNvPartie.ButtonMinClick(Sender: TObject);
begin
Nbj := NbMinJoueurs;
end;


procedure TFormNvPartie.ButtonPrcClick(Sender: TObject);
begin
if (Nbj > NbMinJoueurs) then
  Nbj := Nbj - 1;
end;

procedure TFormNvPartie.ButtonSvtClick(Sender: TObject);
begin
if (Nbj < NbMaxJoueurs) then
  Nbj := Nbj + 1;
end;

procedure TFormNvPartie.ButtonMaxClick(Sender: TObject);
begin
Nbj := NbMaxJoueurs;
end;

procedure TFormNvPartie.ButtonOKClick(Sender: TObject);
var j         : TJoueurId;
    Automate  : array [TJoueurId] of Boolean;
begin
try
  FreeAndNil(Partie);
except
end;
for j := Succ(Low(TJoueurId)) to Pred(High(TJoueurId)) do
  Automate[j] := (FindComponent('CheckBox'+IntToStr(Ord(j))) as TCheckBox).Checked;
Partie:= TPartie.Create(Nbj, Automate);
end;

end.
