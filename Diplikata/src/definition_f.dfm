object FormDefinitionMot: TFormDefinitionMot
  Left = 0
  Top = 0
  ActiveControl = EditMot
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Recherche de la d'#233'finition d'#39'un mot'
  ClientHeight = 129
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LabelSource: TLabel
    Left = 16
    Top = 19
    Width = 40
    Height = 13
    Caption = '&Source :'
    FocusControl = ComboBoxSource
  end
  object LabelMot: TLabel
    Left = 16
    Top = 48
    Width = 25
    Height = 13
    Caption = '&Mot :'
    FocusControl = EditMot
  end
  object ComboBoxSource: TComboBox
    Left = 64
    Top = 16
    Width = 413
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object EditMot: TEdit
    Left = 64
    Top = 40
    Width = 409
    Height = 31
    CharCase = ecLowerCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    MaxLength = 30
    ParentFont = False
    TabOrder = 1
  end
  object ButtonRechercher: TButton
    Left = 29
    Top = 88
    Width = 100
    Height = 25
    Caption = '&Rechercher'
    Default = True
    TabOrder = 2
    OnClick = ButtonRechercherClick
  end
  object ButtonPersonnaliser: TButton
    Left = 190
    Top = 88
    Width = 100
    Height = 25
    Caption = '&Personnaliser'
    TabOrder = 3
    OnClick = ButtonPersonnaliserClick
  end
  object ButtonAnnuler: TButton
    Left = 358
    Top = 88
    Width = 100
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 4
  end
end
