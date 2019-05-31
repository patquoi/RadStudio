unit statspartie_f;
//----------------------------------------------------------------------------
interface
//----------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Menus, Vcl.ComCtrls, base;
//----------------------------------------------------------------------------
type
  TNatureStats = (nsScoreTour, nsScorePartie, nsRangTour, nsRangMoyen);
  //--------------------------------------------------------------------------
  TFormStatsPartie = class(TForm)
    PopupMenu: TPopupMenu;
    ActionList: TActionList;
    ImageList: TImageList;
    ActionAffichageRelatif: TAction;
    ActionScorePropositions: TAction;
    ActionScorePartie: TAction;
    ActionRangPropositions: TAction;
    ActionRangMoyen: TAction;
    ActionQuadrillage: TAction;
    ActionDiminuerTrait: TAction;
    ActionAugmenterTrait: TAction;
    MenuItemQuadrillage: TMenuItem;
    MenuItemAffichageRelatif: TMenuItem;
    MenuITemSeparateur1: TMenuItem;
    MenuItemDiminuerTrait: TMenuItem;
    MenuItemAugmenterTrait: TMenuItem;
    MenuItemSeparateur2: TMenuItem;
    MenuItemScoreProposition: TMenuItem;
    MenuItemScorePartie: TMenuItem;
    MenuItemRangPropositions: TMenuItem;
    MenuItemRangMoyen: TMenuItem;
    StatusBar: TStatusBar;
    procedure ActionExecute(Sender: TObject);
    procedure ActionDiminuerTraitExecute(Sender: TObject);
    procedure ActionAugmenterTraitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
//----------------------------------------------------------------------------
var
  FormStatsPartie: TFormStatsPartie;
//----------------------------------------------------------------------------
implementation
//----------------------------------------------------------------------------
uses System.Math, main_f, tirage_f, fdmatch_f;
//----------------------------------------------------------------------------
{$R *.dfm}
//----------------------------------------------------------------------------
const
  CouleurStats : array [TNatureStats, TCibleStats] of TColor = ((clRed,    clMaroon),
                                                                (clYellow, clOlive),
                                                                (clBlue,   clNavy),
                                                                (clAqua,   clTeal));
  NbDivisionsY = 10;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.ActionAugmenterTraitExecute(Sender: TObject);
begin
if Canvas.Pen.Width<4 then Canvas.Pen.Width:=Canvas.Pen.Width+1;
Repaint
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.ActionDiminuerTraitExecute(Sender: TObject);
begin
if Canvas.Pen.Width>1 then Canvas.Pen.Width:=Canvas.Pen.Width-1;
Repaint
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.ActionExecute(Sender: TObject);
begin
Repaint
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.FormCreate(Sender: TObject);
begin
DoubleBuffered:=True; // Empêche le scintillement
Canvas.Pen.Width:=2
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.FormHide(Sender: TObject);
begin
FormMain.ActionAffichageGrapheEvolution.Checked:=False;
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.FormPaint(Sender: TObject);
var i, j,
    x, y,
    NbDivisionsX,
    dxQuadrillage, dyQuadrillage : Integer;
begin
if (p=nil) or (p.Tour<3) then Exit;
NbDivisionsX:=p.Tour-2;
dxQuadrillage:=ClientWidth div NbDivisionsX;
dyQuadrillage:=(ClientHeight-StatusBar.Height) div NbdivisionsY;
with Canvas do
  begin
  // 1. On efface tout
  Brush.Color:=Color;
  FillRect(Rect(0, 0, ClientWidth-1, ClientHeight-1));
  // 2. On affiche le quadrillage le cas échéant
  if ActionQuadrillage.Checked then
    begin
    for i:=0 to NbDivisionsX do
      for j:=0 to NbdivisionsY do
        Canvas.Pixels[i*dxQuadrillage, j*dyQuadrillage]:=IfThen(j=NbDivisionsY div 2,
                                                                clWhite,
                                                                clSilver);
    end;
  if ActionAffichageRelatif.Checked then
    begin
    // Affichage relatif
    if ActionScorePropositions.Checked then
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScoreTour, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.ScoreTop[i+1]-p.Score[i+1])) div p.ScoreTop[i+1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
    if ActionScorePartie.Checked then
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScorePartie, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.CumulTop[i+1]-p.Cumul[i+1])) div p.CumulTop[i+1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
    if ActionRangPropositions.Checked then
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangTour, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.PosPrp[i+1]-1)) div p.NbSol[i+1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
    if ActionRangMoyen.Checked then
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangMoyen, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.CumulPosPrp[i+1]-1)) div p.CumulNbSol[i+1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
    end
  else
    begin
    // Affichage Joueur & Top. Utilise comme échelle ScoreMax & NbMaxSol
    if ActionScorePropositions.Checked then
      begin
      // D'abord les stats Machine
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScoreTour, csMachine];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.ScoreMax-p.ScoreTop[i+1])) div p.ScoreMax;
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      // Ensuite les stats Humain
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScoreTour, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.ScoreMax-p.Score[i+1])) div p.ScoreMax;
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      end{if ActionScoreProposition.Checked};
    if ActionScorePartie.Checked then
      begin
      // D'abord les stats Machine
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScorePartie, csMachine];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.CumulTop[p.Tour-1]-p.CumulTop[i+1])) div p.CumulTop[p.Tour-1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      // Ensuite les stats Humain
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsScorePartie, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.CumulTop[p.Tour-1]-p.Cumul[i+1])) div p.CumulTop[p.Tour-1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      end{if ActionScorePartie.Checked};
    if ActionRangPropositions.Checked then
      begin
      // D'abord les stats Machine
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangTour, csMachine];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.NbMaxSol-p.NbSol[i+1])) div p.NbMaxSol;
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      // Ensuite les stats Humain
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangTour, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*(p.NbMaxSol-p.NbSol[i+1]+p.PosPrp[i+1]-1)) div p.NbMaxSol;
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      end{if ActionRangPropositions.Checked};
    if ActionRangMoyen.Checked then
      begin
      // D'abord les stats Machine
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangMoyen, csMachine];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*((p.CumulNbSol[p.Tour-1]-p.CumulNbSol[i+1]) div (i+1))) div p.CumulNbSol[p.Tour-1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      // Ensuite les stats Humain
      for i:=0 to NbDivisionsX do
        begin
        Pen.Color:=CouleurStats[nsRangMoyen, csHumain];
        x:=i*dxQuadrillage;
        y:=(10*dyQuadrillage*((p.CumulNbSol[p.Tour-1]-p.CumulNbSol[i+1]+p.CumulPosPrp[i+1]-(i+1)) div (i+1))) div p.CumulNbSol[p.Tour-1];
        if i=0 then MoveTo(x, y) else LineTo(x, y);
        end;
      end{if ActionRangMoyen.Checked};
    end
  end
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.FormResize(Sender: TObject);
begin
Repaint
end;
//----------------------------------------------------------------------------
procedure TFormStatsPartie.FormShow(Sender: TObject);
begin
StatusBar.SimpleText:='';
FormMain.ActionAffichageGrapheEvolution.Checked:=True;
Top:=FormTirage.Top+FormTirage.Height;
Left:=FormMain.Left+FormMain.Width;
if FormFeuilleMatch<>nil then
  begin
  Width:=FormFeuilleMatch.Width;
  Height:=FormFeuilleMatch.Height
  end;
end;
//----------------------------------------------------------------------------
end.
