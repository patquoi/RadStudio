object FormNvRecord: TFormNvRecord
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Nouveau record'
  ClientHeight = 52
  ClientWidth = 136
  Color = clWhite
  Constraints.MinHeight = 52
  Constraints.MinWidth = 136
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 0
    Top = 26
    Width = 136
    Height = 26
    Align = alClient
    OnPaint = PaintBoxPaint
    ExplicitLeft = 16
    ExplicitTop = -24
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 136
    Height = 26
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'Nouveau(x) record(s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
  end
end
