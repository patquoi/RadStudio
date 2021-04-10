unit joueurs_f;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, main_f;

type
  TFormJoueurs = class(TForm)
    PaintBoxG1: TPaintBox;
    PaintBoxG2: TPaintBox;
    PaintBoxG3: TPaintBox;
    PaintBoxG4: TPaintBox;
    PaintBoxG5: TPaintBox;
    PaintBoxG6: TPaintBox;
    PaintBoxGA: TPaintBox;
    PaintBoxGH: TPaintBox;
    PaintBoxG7: TPaintBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    PaintBoxD1: TPaintBox;
    PaintBoxD2: TPaintBox;
    PaintBoxD3: TPaintBox;
    PaintBoxD4: TPaintBox;
    PaintBoxD5: TPaintBox;
    PaintBoxD6: TPaintBox;
    PaintBoxD7: TPaintBox;
    PaintBoxDA: TPaintBox;
    PaintBoxDH: TPaintBox;
    ButtonOK: TButton;
    ButtonAnnuler: TButton;
    procedure PaintBoxPaint(Sender: TObject);
    procedure PaintBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    CoulJG, CoulJD : TCouleur;
    AutoJG, AutoJD : Boolean;
  public
    { Déclarations publiques }
  end;

var
  FormJoueurs: TFormJoueurs;

implementation

{$R *.dfm}

uses base;

procedure TFormJoueurs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if ModalResult = mrCancel then
  begin
  // On restaure les paramètres de joueurs
  CoulJr[jGauche] := CoulJG;
  CoulJr[jDroite] := CoulJD;
  p.Jr[jGauche].Automate := AutoJG;
  p.Jr[jDroite].Automate := AutoJD;
  end
else
  with FormMain do
    begin
    ColoreTexteJoueurs;
    Refresh
    end;
end;

procedure TFormJoueurs.FormCreate(Sender: TObject);
begin
// On sauvegarde les paramètres de joueurs
CoulJG := CoulJr[jGauche];
CoulJD := CoulJr[jDroite];
AutoJG := p.Jr[jGauche].Automate;
AutoJD := p.Jr[jDroite].Automate;
end;

procedure TFormJoueurs.PaintBoxClick(Sender: TObject);
var pb   : TPaintBox;
    Jr   : TIdJoueur;
begin
pb := Sender as TPaintBox;
case Copy(pb.Name,9,1)[1] of
 'G': Jr := jGauche;
 'D': Jr := jDroite;
else
  Jr := jIndefini;
end;
with FormMain do
  begin
  case Copy(pb.Name,10,1)[1] of
    '1'..'7': begin
              if CoulJr[Jr] <> TCouleur(pb.Tag) then
                CoulJr[Jr] := TCouleur(pb.Tag)
              end
  (* // Automate non pris en charge
  else
    if Ord(p.Jr[Jr].Automate) <> pb.Tag then
      p.Jr[Jr].Automate := (pb.Tag = 1); *)
  end{case of};
  end{with};
Refresh
end;

procedure TFormJoueurs.PaintBoxPaint(Sender: TObject);
var pb   : TPaintBox;
    Jr   : TIdJoueur;
    bm   : TBitmap;
    Rect,
    RExt,
    RInt : TRect;

begin
pb := Sender as TPaintBox;
with pb.Canvas.Brush do
  begin
  Color := clBlack;
  Style := bsSolid;
  end;
Rect := TRect.Create(0, 0, pb.Width-1, pb.Height-1);
RExt := TRect.Create(1, 1, pb.Width-2, pb.Height-2);
RInt := TRect.Create(2, 2, pb.Width-3, pb.Height-3);
bm := TBitmap.Create;
case Copy(pb.Name,9,1)[1] of
 'G': Jr := jGauche;
 'D': Jr := jDroite;
else
  Jr := jIndefini;
end;
with FormMain do
  begin
  case Copy(pb.Name,10,1)[1] of
    '1'..'7': begin
              VirtualImageListFnd.GetBitmap(pb.Tag, bm);
              pb.Canvas.StretchDraw(Rect, bm);
              if CoulJr[Jr] = TCouleur(pb.Tag) then
                begin
                pb.Canvas.FrameRect(Rect);
                pb.Canvas.FrameRect(RExt);
                pb.Canvas.FrameRect(RInt);
                end;
              end
  else
    begin
    VirtualImageListTJr.GetBitmap(pb.Tag, bm);
    pb.Canvas.StretchDraw(Rect, bm);
    if Ord(p.Jr[Jr].Automate) = pb.Tag then
      begin
      pb.Canvas.FrameRect(Rect);
      pb.Canvas.FrameRect(RExt);
      pb.Canvas.FrameRect(RInt);
      end;
    end
  end;
  FreeAndNil(bm);
  FreeAndNil(Rect);
  end
end;

end.
