object FormFeuilleMatch: TFormFeuilleMatch
  Left = 0
  Top = 0
  Caption = 'Feuille de match'
  ClientHeight = 466
  ClientWidth = 580
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object StatusBar: TStatusBar
    Left = 0
    Top = 447
    Width = 580
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 0
    Width = 580
    Height = 447
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
    Zoom = 100
  end
end
