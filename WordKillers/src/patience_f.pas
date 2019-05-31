unit patience_f;
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.ExtCtrls;
//---------------------------------------------------------------------------
type
  TFormPatience = class(TForm)
    Panel: TPanel;
    Gauge: TGauge;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
//---------------------------------------------------------------------------
var
  FormPatience: TFormPatience;
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
{$R *.dfm}
//---------------------------------------------------------------------------
procedure TFormPatience.FormCreate(Sender: TObject);
begin
DoubleBuffered:=True // Evite le scintillement
end;
//---------------------------------------------------------------------------
end.
