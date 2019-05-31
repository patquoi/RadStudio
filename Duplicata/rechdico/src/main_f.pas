unit main_f;

interface

uses
  baserechdico, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
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
  RechDico : TRechDico;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
RechDico:=TRechDico.Cree;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
RechDico.Detruit
end;

end.
