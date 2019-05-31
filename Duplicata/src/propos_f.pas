unit propos_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;
//---------------------------------------------------------------------------
type
  TFormAPropos = class(TForm)
    Image: TImage;
    LabelVersionOmbre: TLabel;
    LabelVersion: TLabel;
    LabelSousVersion: TLabel;
    Timer: TTimer;
    Memo: TMemo;
    LabelWeb: TLabel;
    LabelEMail: TLabel;
    procedure AllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure LabelWebClick(Sender: TObject);
    procedure LabelEMailClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
var
  FormAPropos: TFormAPropos;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
uses Winapi.ShellApi, main_f, base;
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
procedure TFormAPropos.AllClick(Sender: TObject);
begin
Close // v1.4.8
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.FormCreate(Sender: TObject);
begin // v1.5.3
Memo.Text:=StringReplace(Memo.Text, 'ODSx', stVersionDico, [rfReplaceAll]);
// v1.8.4 : affichage 32/64 bits dans l'À propos
{$IFDEF WIN32}
Memo.Text:=StringReplace(Memo.Text, 'yy', '32', [rfReplaceAll]);
{$ENDIF}
{$IFDEF WIN64}
Memo.Text:=StringReplace(Memo.Text, 'yy', '64', [rfReplaceAll]);
{$ENDIF}
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=112) and (Shift=[]) then // v1.5.2 : accès l'aide en ligne (F1)
  with FormMain do
    ActionInfosAideExecute(ActionInfosAide)
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key=#13) or (Key=#27) or (Key=#32) then ModalResult:=mrOk;
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.LabelEMailClick(Sender: TObject);
begin
ShellExecute(0, 'Open', pWideChar('mailto:'+LabelEMail.Caption), '', '', SW_SHOWNORMAL);
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.LabelWebClick(Sender: TObject);
begin
ShellExecute(0, 'Open', pWideChar('http://'+LabelWeb.Caption), '', '', SW_SHOWNORMAL);
end;
//---------------------------------------------------------------------------
procedure TFormAPropos.TimerTimer(Sender: TObject);
begin
ModalResult:=mrOk
end;
//---------------------------------------------------------------------------
end.
