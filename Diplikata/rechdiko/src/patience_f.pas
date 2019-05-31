unit patience_f;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, ExtCtrls;

type
  TFormPatience = class(TForm)
    Gauge: TGauge;
    Panel: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormPatience: TFormPatience;

implementation

{$R *.dfm}

procedure TFormPatience.FormCreate(Sender: TObject);
begin
DoubleBuffered:=True // Evite le scintillement
end;

end.
