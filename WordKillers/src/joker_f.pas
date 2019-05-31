unit joker_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;
//---------------------------------------------------------------------------
type
  TFormJoker = class(TForm)
    Panel: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    ButtonAnnuler: TButton;
    procedure ButtonAnnulerClick(Sender: TObject);
    procedure ButtonLettreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TimerEnabled : Boolean; // v1.5
  public
    stMot : string; // Mot formé avec un ou plusieurs jokers
  end;
//---------------------------------------------------------------------------
var
  FormJoker: TFormJoker;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses main_f;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
procedure TFormJoker.ButtonLettreClick(Sender: TObject);
begin
ModalResult:=1+StrToInt(Copy((Sender as TButton).Name,7,2));
end;
//---------------------------------------------------------------------------
procedure TFormJoker.FormCreate(Sender: TObject);
begin
TimerEnabled:=False // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormJoker.FormHide(Sender: TObject);
begin // v1.2
with FormMain do
  if ReflexionEnCours and TimerEnabled then
    EmpecheTempsImparti:=False // v1.5
end;
//---------------------------------------------------------------------------
procedure TFormJoker.FormShow(Sender: TObject);
begin
with FormMain do
  if ReflexionEnCours then
    begin
    TimerEnabled:=TimerReflexion.Enabled;
    if TimerEnabled then
      EmpecheTempsImparti:=True // v1.5 : on n'arrête plus le timer mais l'on empêche l'interruption de la réflexion pendant l'affichage d'un message.
    end
  else
    TimerEnabled:=False;
Panel.Caption:=stMot;
Panel.SetFocus // v1.5.1
end;
//---------------------------------------------------------------------------
procedure TFormJoker.ButtonAnnulerClick(Sender: TObject);
begin
ModalResult:=-1;
end;
//---------------------------------------------------------------------------
end.
