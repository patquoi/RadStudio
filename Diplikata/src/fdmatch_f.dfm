object FormFeuilleMatch: TFormFeuilleMatch
  Left = 0
  Top = 0
  Caption = 'Feuille de match'
  ClientHeight = 453
  ClientWidth = 572
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object StatusBar: TStatusBar
    Left = 0
    Top = 434
    Width = 572
    Height = 19
    Panels = <>
    SimplePanel = True
    SizeGrip = False
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 0
    Width = 572
    Height = 434
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
