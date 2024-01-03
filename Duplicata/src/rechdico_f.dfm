object FormRechercheMots: TFormRechercheMots
  Left = 0
  Top = 0
  ActiveControl = Edit
  BorderIcons = [biSystemMenu]
  Caption = 'Recherche de mots'
  ClientHeight = 443
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  object LabelInfosJokers: TLabel
    Left = 184
    Top = 48
    Width = 216
    Height = 13
    Caption = 'Joker : '#171' ? '#187' remplace n'#39'importe quelle lettre.'
  end
  object RadioGroupOrdre: TRadioGroup
    Left = 8
    Top = 8
    Width = 169
    Height = 57
    Caption = ' Le crit'#232're ci-contre est un... '
    Items.Strings = (
      '&Mot ou filtre de mots'
      '&Tirage (avec ou sans jokers)')
    TabOrder = 0
    OnClick = RadioGroupOrdreClick
  end
  object Edit: TEdit
    Left = 184
    Top = 16
    Width = 129
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    TabOrder = 1
    OnKeyPress = EditKeyPress
  end
  object ButtonRechercher: TButton
    Left = 323
    Top = 16
    Width = 86
    Height = 25
    Caption = '&Rechercher'
    Default = True
    TabOrder = 2
    OnClick = ButtonRechercherClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 424
    Width = 418
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 391
    ExplicitWidth = 404
  end
  object Memo: TMemo
    Left = 0
    Top = 71
    Width = 418
    Height = 353
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    ExplicitTop = 38
    ExplicitWidth = 404
  end
end
