unit main_f;

interface

uses
  baserechdiko, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormMain = class(TForm)
    Memo: TMemo;
    StatusBar: TStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormMain: TFormMain;
  RechDiko : TRechDiko;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
RechDiko:=TRechDiko.Cree;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
RechDiko.Detruit
end;

end.
