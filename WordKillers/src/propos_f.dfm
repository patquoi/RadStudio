object FormAPropos: TFormAPropos
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #192' propos de Duplicata...'
  ClientHeight = 229
  ClientWidth = 353
  Color = 4194368
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClick = AllClick
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTitreOmbre: TLabel
    Left = 4
    Top = 4
    Width = 353
    Height = 60
    Alignment = taCenter
    AutoSize = False
    Caption = 'Word Killers'
    Font.Charset = ANSI_CHARSET
    Font.Color = clOlive
    Font.Height = -48
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
  end
  object LabelVersionOmbre: TLabel
    Left = 0
    Top = 63
    Width = 192
    Height = 26
    Alignment = taRightJustify
    AutoSize = False
    Caption = '1.x.x'
    Font.Charset = ANSI_CHARSET
    Font.Color = 8163597
    Font.Height = -23
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
  end
  object LabelVersion: TLabel
    Left = 0
    Top = 64
    Width = 193
    Height = 26
    Alignment = taRightJustify
    AutoSize = False
    Caption = '1.x.x'
    Font.Charset = ANSI_CHARSET
    Font.Color = 9632516
    Font.Height = -23
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = AllClick
  end
  object LabelSousVersion: TLabel
    Left = 194
    Top = 64
    Width = 161
    Height = 26
    AutoSize = False
    Caption = '.x'
    Font.Charset = ANSI_CHARSET
    Font.Color = 8163597
    Font.Height = -23
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = AllClick
  end
  object LabelWeb: TLabel
    Left = 0
    Top = 192
    Width = 353
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'patquoi.fr/#duplicata'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = LabelWebClick
  end
  object LabelEMail: TLabel
    Left = 0
    Top = 208
    Width = 353
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'duplicata@patquoi.fr'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = LabelEMailClick
  end
  object LabelTitre: TLabel
    Left = 0
    Top = 0
    Width = 353
    Height = 60
    Alignment = taCenter
    AutoSize = False
    Caption = 'Word Killers'
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -48
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
  end
  object Memo: TMemo
    Left = 0
    Top = 87
    Width = 353
    Height = 107
    TabStop = False
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'version yy bits'
      ''
      'Licence Publique G'#233'n'#233'rale version 2.0'
      'Ce logiciel est fourni sans aucune garantie que ce soit.'
      ''
      'Dictionnaire int'#233'gr'#233' : ODSx'
      'R'#233'alisation : Patrice Fouquet (2007)')
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnClick = AllClick
  end
  object Timer: TTimer
    Interval = 5000
    OnTimer = TimerTimer
    Left = 8
    Top = 72
  end
end
