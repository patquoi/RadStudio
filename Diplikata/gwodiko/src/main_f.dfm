object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Kregwodiko'
  ClientHeight = 709
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 0
    Top = 313
    Width = 632
    Height = 4
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 640
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 632
    Height = 313
    Align = alTop
    Lines.Strings = (
      'Coller ici la liste des mots...')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 0
    Top = 317
    Width = 632
    Height = 348
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 665
    Width = 632
    Height = 44
    Align = alBottom
    TabOrder = 2
    object ButtonAnalyser: TButton
      Left = 4
      Top = 4
      Width = 89
      Height = 37
      Caption = '&Analyser'
      TabOrder = 0
      OnClick = ButtonAnalyserClick
    end
    object ButtonEnrichir: TButton
      Left = 96
      Top = 4
      Width = 83
      Height = 37
      Caption = '&Enrichir'
      TabOrder = 1
      OnClick = ButtonEnrichirClick
    end
    object ButtonGenerer: TButton
      Left = 180
      Top = 4
      Width = 83
      Height = 37
      Caption = '&G'#233'n'#233'rer'
      TabOrder = 2
      OnClick = ButtonGenererClick
    end
    object ButtonCalculer: TButton
      Left = 350
      Top = 4
      Width = 89
      Height = 37
      Caption = '&Calculer stats'
      TabOrder = 3
      OnClick = ButtonCalculerClick
    end
    object ButtonGenererJS: TButton
      Left = 264
      Top = 4
      Width = 85
      Height = 37
      Caption = 'G'#233'n'#233'rer &D7.js'
      TabOrder = 4
      OnClick = ButtonGenererJSClick
    end
  end
end
