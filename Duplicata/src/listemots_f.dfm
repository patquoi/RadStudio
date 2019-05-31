object FormListeMots: TFormListeMots
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'G'#233'n'#233'ration de liste de mots '#224' lettres ch'#232'res'
  ClientHeight = 573
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 133
    Height = 13
    Caption = 'G'#233'n'#233'rer la liste des mots &de'
    FocusControl = ComboBoxNbLettresMin
  end
  object Label2: TLabel
    Left = 196
    Top = 16
    Width = 6
    Height = 13
    Caption = '&'#224
    FocusControl = ComboBoxNbLettresMax
  end
  object Label3: TLabel
    Left = 260
    Top = 16
    Width = 101
    Height = 13
    Caption = 'lettres comportant...'
  end
  object LabelResume: TLabel
    Left = 368
    Top = 16
    Width = 209
    Height = 25
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 47
    Width = 569
    Height = 2
  end
  object Bevel2: TBevel
    Left = 7
    Top = 351
    Width = 569
    Height = 2
  end
  object Bevel3: TBevel
    Left = 8
    Top = 498
    Width = 569
    Height = 2
  end
  object ComboBoxNbLettresMin: TComboBox
    Left = 148
    Top = 13
    Width = 41
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = '2'
    OnChange = ComboBoxNbLettresMinChange
    Items.Strings = (
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15')
  end
  object ComboBoxNbLettresMax: TComboBox
    Left = 211
    Top = 13
    Width = 41
    Height = 21
    Style = csDropDownList
    ItemIndex = 13
    TabOrder = 1
    Text = '15'
    Items.Strings = (
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15')
  end
  object RadioButton1: TRadioButton
    Tag = 1
    Left = 8
    Top = 55
    Width = 161
    Height = 17
    Caption = 'Un nombre exact de &lettres :'
    TabOrder = 2
    OnClick = RadioButtonClick
  end
  object RadioGroupJ: TRadioGroup
    Left = 8
    Top = 80
    Width = 185
    Height = 81
    Caption = ' J '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun J'
      'Un seul J'
      'Deux J (n'#233'cessitant 1 joker)')
    TabOrder = 3
    OnClick = RadioGroupClick
  end
  object RadioGroupK: TRadioGroup
    Left = 199
    Top = 80
    Width = 185
    Height = 105
    Caption = ' K '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun K'
      'Un seul K'
      'Deux K (n'#233'cessitant 1 joker)'
      'Trois K (n'#233'cessitant 2 jokers)')
    TabOrder = 4
    OnClick = RadioGroupClick
  end
  object RadioGroupW: TRadioGroup
    Left = 391
    Top = 80
    Width = 185
    Height = 81
    Caption = ' W '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun W'
      'Un seul W'
      'Deux W (n'#233'cessitant 1 joker)')
    TabOrder = 5
    OnClick = RadioGroupClick
  end
  object RadioGroupQ: TRadioGroup
    Left = 8
    Top = 167
    Width = 185
    Height = 81
    Caption = ' Q '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Q'
      'Un seul Q'
      'Deux Q (n'#233'cessitant 1 joker)')
    TabOrder = 6
    OnClick = RadioGroupClick
  end
  object RadioGroupZ: TRadioGroup
    Left = 199
    Top = 191
    Width = 185
    Height = 105
    Caption = ' Z '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Z'
      'Un seul Z'
      'Deux Z (n'#233'cessitant 1 joker)'
      'Trois Z (n'#233'cessitant 2 jokers)')
    TabOrder = 7
    OnClick = RadioGroupClick
  end
  object RadioGroupX: TRadioGroup
    Left = 391
    Top = 167
    Width = 185
    Height = 81
    Caption = ' X '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun X'
      'Un seul X'
      'Deux X (n'#233'cessitant 1 joker)')
    TabOrder = 8
    OnClick = RadioGroupClick
  end
  object RadioGroupY: TRadioGroup
    Left = 391
    Top = 254
    Width = 185
    Height = 81
    Caption = ' Y '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Y'
      'Un seul Y'
      'Deux Y (n'#233'cessitant 1 joker)')
    TabOrder = 9
    OnClick = RadioGroupClick
  end
  object RadioButton2: TRadioButton
    Tag = 2
    Left = 8
    Top = 359
    Width = 161
    Height = 17
    Caption = 'Un nombre exact de &valeurs :'
    TabOrder = 10
    OnClick = RadioButtonClick
  end
  object RadioGroup8: TRadioGroup
    Left = 200
    Top = 359
    Width = 185
    Height = 105
    Caption = ' Lettres '#224' 8 points (J, Q) '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucune lettre '#224' 8 points'
      'Une seule lettre '#224' 8 points'
      'Deux lettres '#224' 8 points'
      'Trois lettres '#224' 8 points')
    TabOrder = 11
    OnClick = RadioGroupClick
  end
  object RadioGroup10: TRadioGroup
    Left = 391
    Top = 359
    Width = 185
    Height = 130
    Caption = ' Lettres '#224' 10 points (K, W, X, Y, Z) '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucune lettre '#224' 10 points'
      'Une seule lettre '#224' 10 points'
      'Deux lettres '#224' 10 points'
      'Trois lettres '#224' 10 points'
      'Quatre lettres '#224' 10 points')
    TabOrder = 12
    OnClick = RadioGroupClick
  end
  object ButtonReinitialiser: TButton
    Left = 8
    Top = 523
    Width = 65
    Height = 25
    Caption = '&R'#233'initialiser'
    TabOrder = 13
    OnClick = ButtonReinitialiserClick
  end
  object ButtonGenerer: TButton
    Left = 80
    Top = 523
    Width = 65
    Height = 25
    Caption = '&G'#233'n'#233'rer'
    Default = True
    Enabled = False
    TabOrder = 14
    OnClick = ButtonGenererClick
  end
  object ButtonAnnuler: TButton
    Left = 152
    Top = 523
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 15
  end
  object GroupBoxRq: TGroupBox
    Left = 256
    Top = 504
    Width = 321
    Height = 57
    Caption = ' Remarque '
    TabOrder = 16
    object Label4: TLabel
      Left = 11
      Top = 18
      Width = 302
      Height = 26
      AutoSize = False
      Caption = 
        'La liste de mots est g'#233'n'#233'r'#233'e dans un fichier texte nomm'#233' "listem' +
        'ots.txt" dans le dossier de Duplicata.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
  end
end
