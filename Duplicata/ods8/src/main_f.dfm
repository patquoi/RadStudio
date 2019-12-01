object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Cr'#233'ation du dictionnaire + delta'
  ClientHeight = 797
  ClientWidth = 667
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
    Left = 337
    Top = 0
    Height = 528
    ExplicitLeft = 648
    ExplicitTop = 576
    ExplicitHeight = 100
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 778
    Width = 667
    Height = 19
    Panels = <>
  end
  object Panel: TPanel
    Left = 0
    Top = 528
    Width = 667
    Height = 250
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object PanelButtons: TPanel
      Left = 0
      Top = 209
      Width = 667
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object ButtonImporter: TButton
        Left = 8
        Top = 6
        Width = 75
        Height = 29
        Caption = '1. Importer'
        TabOrder = 0
        OnClick = ButtonImporterClick
      end
      object ButtonGenereL: TButton
        Left = 89
        Top = 6
        Width = 88
        Height = 29
        Caption = '2. G'#233'n'#233'rer L'
        TabOrder = 1
        OnClick = ButtonGenereLClick
      end
      object ButtonCalculerStats: TButton
        Left = 184
        Top = 6
        Width = 97
        Height = 29
        Caption = '3. Calculer Stats'
        TabOrder = 2
        OnClick = ButtonCalculerStatsClick
      end
    end
    object MemoInfos: TMemo
      Left = 0
      Top = 0
      Width = 667
      Height = 209
      Align = alClient
      TabOrder = 1
    end
  end
  object MemoDP: TMemo
    Left = 0
    Top = 0
    Width = 337
    Height = 528
    Align = alLeft
    Anchors = [akTop, akBottom]
    TabOrder = 2
  end
  object MemoDM: TMemo
    Left = 340
    Top = 0
    Width = 327
    Height = 528
    Align = alClient
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 3
  end
end
