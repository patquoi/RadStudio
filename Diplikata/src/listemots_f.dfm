object FormListeMots: TFormListeMots
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'G'#233'n'#233'ration d'#39'une liste de mots avec lettres ch'#232'res'
  ClientHeight = 569
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
    Width = 100
    Height = 13
    Caption = 'jetons comportant...'
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
    Top = 498
    Width = 569
    Height = 2
  end
  object Bevel2: TBevel
    Left = 8
    Top = 351
    Width = 569
    Height = 2
  end
  object Bevel3: TBevel
    Left = 8
    Top = 47
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
  object RadioGroupAn: TRadioGroup
    Left = 8
    Top = 80
    Width = 185
    Height = 81
    Caption = ' An '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun An'
      'Un seul An'
      'Deux An'
      'Trois An (n'#233'cessitant 1 joker)')
    TabOrder = 3
    OnClick = RadioGroupClick
  end
  object RadioGroupOn: TRadioGroup
    Left = 8
    Top = 256
    Width = 185
    Height = 81
    Caption = ' On '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun On'
      'Un seul On'
      'Deux On '
      'Trois On (n'#233'cessitant 1 joker)')
    TabOrder = 5
    OnClick = RadioGroupClick
  end
  object RadioGroupEn: TRadioGroup
    Left = 8
    Top = 168
    Width = 185
    Height = 81
    Caption = ' En '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun En'
      'Un seul En'
      'Deux En'
      'Trois En (n'#233'cessitant 1 joker)')
    TabOrder = 4
    OnClick = RadioGroupClick
  end
  object RadioGroupH: TRadioGroup
    Left = 392
    Top = 80
    Width = 185
    Height = 65
    Caption = ' H '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun H'
      'Un seul H'
      'Deux H (n'#233'cessitant 1 joker)')
    TabOrder = 8
    OnClick = RadioGroupClick
  end
  object RadioGroupNg: TRadioGroup
    Left = 391
    Top = 144
    Width = 185
    Height = 65
    Caption = ' Ng '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Ng'
      'Un seul Ng'
      'Deux Ng (n'#233'cessitant 1 joker)')
    TabOrder = 9
    OnClick = RadioGroupClick
  end
  object RadioGroupUi: TRadioGroup
    Left = 392
    Top = 272
    Width = 185
    Height = 65
    Caption = ' Ui '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Ui'
      'Un seul Ui'
      'Deux Ui (n'#233'cessitant 1 joker)')
    TabOrder = 11
    OnClick = RadioGroupClick
  end
  object RadioGroupV: TRadioGroup
    Left = 200
    Top = 216
    Width = 185
    Height = 121
    Caption = ' V '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun V'
      'Un seul V'
      'Deux V'
      'Trois V (n'#233'cessitant 1 joker)')
    TabOrder = 7
    OnClick = RadioGroupClick
  end
  object RadioGroup4: TRadioGroup
    Left = 200
    Top = 360
    Width = 185
    Height = 129
    Caption = ' Jetons '#224' 4 pts (An, En, On, F, V) '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucune lettre '#224' 4 points'
      'Une seule lettre '#224' 4 points'
      'Deux lettres '#224' 4 points'
      'Trois lettres '#224' 4 points'
      'Quatre lettres '#224' 4 points'
      'Cinq lettres '#224' 4 points')
    TabOrder = 13
    OnClick = RadioGroupClick
  end
  object RadioButton1: TRadioButton
    Tag = 1
    Left = 9
    Top = 59
    Width = 169
    Height = 17
    Caption = 'Un nombre exact de &jetons :'
    TabOrder = 2
    OnClick = RadioButtonClick
  end
  object RadioButton2: TRadioButton
    Tag = 2
    Left = 8
    Top = 363
    Width = 169
    Height = 17
    Caption = 'Un nombre exact de &valeurs :'
    TabOrder = 12
    OnClick = RadioButtonClick
  end
  object RadioGroup10: TRadioGroup
    Left = 392
    Top = 360
    Width = 185
    Height = 129
    Caption = ' Jetons '#224' 10 points (H, Ng, Ui) '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucune lettre '#224' 10 points'
      'Une seule lettre '#224' 10 pts'
      'Deux lettres '#224' 10 pts'
      'Trois lettres '#224' 10 pts'
      'Quatre lettres '#224' 10 pts')
    TabOrder = 14
    OnClick = RadioGroupClick
  end
  object ButtonGenerer: TButton
    Left = 96
    Top = 523
    Width = 65
    Height = 25
    Caption = '&G'#233'n'#233'rer'
    Default = True
    Enabled = False
    TabOrder = 16
    OnClick = ButtonGenererClick
  end
  object ButtonAnnuler: TButton
    Left = 176
    Top = 523
    Width = 65
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 17
  end
  object ButtonReinitialiser: TButton
    Left = 16
    Top = 523
    Width = 65
    Height = 25
    Caption = '&R'#233'initialiser'
    TabOrder = 15
    OnClick = ButtonReinitialiserClick
  end
  object GroupBoxRq: TGroupBox
    Left = 256
    Top = 507
    Width = 321
    Height = 57
    Caption = ' Remarque '
    TabOrder = 18
    object Label4: TLabel
      Left = 11
      Top = 18
      Width = 302
      Height = 26
      AutoSize = False
      Caption = 
        'La liste des mots est g'#233'n'#233'r'#233'e dans un fichier texte nomm'#233' "liste' +
        'mots.txt" dans le dossier de Diplikata.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
  end
  object RadioGroupF: TRadioGroup
    Left = 200
    Top = 80
    Width = 185
    Height = 129
    Caption = ' F '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun F'
      'Un seul F'
      'Deux F'
      'Trois F (n'#233'cessitant 1 joker)')
    TabOrder = 6
    OnClick = RadioGroupClick
  end
  object RadioGroupOun: TRadioGroup
    Left = 391
    Top = 208
    Width = 185
    Height = 65
    Caption = ' Oun '
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Aucun Oun'
      'Un seul Oun'
      'Deux Oun (n'#233'cessitant 1 joker)')
    TabOrder = 10
    OnClick = RadioGroupClick
  end
end
