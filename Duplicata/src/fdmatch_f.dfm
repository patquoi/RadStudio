object FormFeuilleMatch: TFormFeuilleMatch
  Left = 0
  Top = 0
  Caption = 'Feuille de match'
  ClientHeight = 433
  ClientWidth = 566
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 14
  object StatusBar: TStatusBar
    Left = 0
    Top = 414
    Width = 566
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 447
    ExplicitWidth = 580
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 0
    Width = 566
    Height = 414
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
end
