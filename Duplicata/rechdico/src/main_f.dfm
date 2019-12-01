object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Dictionnaire de recherche'
  ClientHeight = 403
  ClientWidth = 331
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
    Width = 331
    Height = 384
    Align = alClient
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 384
    Width = 331
    Height = 19
    Panels = <>
  end
end
