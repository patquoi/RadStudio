object FormRechercheMots: TFormRechercheMots
  Left = 0
  Top = 0
  ActiveControl = Edit
  BorderIcons = [biSystemMenu]
  Caption = 'Recherche de mots'
  ClientHeight = 432
  ClientWidth = 584
  Color = clBtnFace
  Constraints.MaxWidth = 600
  Constraints.MinHeight = 125
  Constraints.MinWidth = 600
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    584
    432)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfosJokers: TLabel
    Left = 184
    Top = 40
    Width = 257
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Joker : '#171' ? '#187' remplace n'#39'importe quel jeton.'
    ExplicitWidth = 207
  end
  object LabelDoublesLettres: TLabel
    Left = 184
    Top = 56
    Width = 351
    Height = 13
    Caption = 
      'Doubles lettres : '#171' An '#187', '#171' Ch '#187', '#171' En '#187', '#171' Ng '#187', '#171' On '#187', '#171' Ou '#187 +
      ' et '#171' Ui '#187'.'
  end
  object RadioGroupOrdre: TRadioGroup
    Left = 8
    Top = 8
    Width = 169
    Height = 57
    Caption = ' Le crit'#232're ci-contre est un... '
    ItemIndex = 1
    Items.Strings = (
      '&Mot ou filtre de mots'
      '&Tirage (avec ou sans jokers)')
    TabOrder = 0
    OnClick = RadioGroupOrdreClick
  end
  object Edit: TEdit
    Left = 244
    Top = 13
    Width = 267
    Height = 22
    Anchors = [akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 1
    OnKeyPress = EditKeyPress
    ExplicitLeft = 194
  end
  object ButtonRechercher: TButton
    Left = 518
    Top = 13
    Width = 65
    Height = 23
    Anchors = [akTop, akRight]
    Caption = '&Rechercher'
    Default = True
    TabOrder = 2
    OnClick = ButtonRechercherClick
    ExplicitLeft = 468
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 409
    Width = 584
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    Panels = <>
    SimplePanel = True
    SizeGrip = False
    ExplicitTop = 419
    ExplicitWidth = 534
    ExplicitHeight = 19
  end
  object Memo: TMemo
    Left = 0
    Top = 75
    Width = 584
    Height = 334
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    ExplicitHeight = 344
  end
end
