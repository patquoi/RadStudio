object FormMain: TFormMain
  Left = 0
  Top = 0
  Width = 347
  Height = 442
  Caption = 'Dictionnaire de recherche'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 339
    Height = 389
    Align = alClient
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 389
    Width = 339
    Height = 19
    Panels = <>
  end
end
