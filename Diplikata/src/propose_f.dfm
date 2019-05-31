object FormPropositionPose: TFormPropositionPose
  Left = 0
  Top = 0
  ActiveControl = ButtonProposerCoupJoueur
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Proposition de pose'
  ClientHeight = 300
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 23
    Height = 13
    Caption = 'Pose'
  end
  object Label2: TLabel
    Left = 163
    Top = 8
    Width = 39
    Height = 13
    Caption = 'Reliquat'
  end
  object LabelPose: TLabel
    Left = 12
    Top = 24
    Width = 20
    Height = 18
    Caption = 'An'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object LabelReliquat: TLabel
    Left = 61
    Top = 24
    Width = 140
    Height = 18
    Alignment = taRightJustify
    Caption = 'AnChEnInNgOuUi'
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object LabelColonne: TLabel
    Left = 16
    Top = 194
    Width = 82
    Height = 13
    Caption = '&Colonne D'#233'part :'
    Enabled = False
    FocusControl = ComboBoxColonne
  end
  object LabelLigne: TLabel
    Left = 16
    Top = 216
    Width = 68
    Height = 13
    Caption = '&Ligne D'#233'part :'
    Enabled = False
    FocusControl = ComboBoxLigne
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 281
    Width = 212
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ButtonProposerCoupJoueur: TButton
    Left = 12
    Top = 52
    Width = 189
    Height = 25
    Caption = 'Afficher ma proposition'
    Default = True
    TabOrder = 0
    OnClick = ButtonProposerCoupJoueurClick
  end
  object ButtonA: TButton
    Left = 12
    Top = 84
    Width = 16
    Height = 16
    Action = ActionA
    TabOrder = 1
    TabStop = False
  end
  object ButtonAn: TButton
    Left = 28
    Top = 84
    Width = 20
    Height = 16
    Hint = '@'
    Action = ActionAn
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = False
  end
  object ButtonB: TButton
    Left = 48
    Top = 84
    Width = 16
    Height = 16
    Action = ActionB
    TabOrder = 3
    TabStop = False
  end
  object ButtonCh: TButton
    Left = 64
    Top = 84
    Width = 20
    Height = 16
    Action = ActionCh
    Caption = '&Ch'
    TabOrder = 4
    TabStop = False
  end
  object ButtonD: TButton
    Left = 84
    Top = 84
    Width = 16
    Height = 16
    Action = ActionD
    TabOrder = 5
    TabStop = False
  end
  object ButtonE: TButton
    Left = 100
    Top = 84
    Width = 16
    Height = 16
    Action = ActionE
    TabOrder = 6
    TabStop = False
  end
  object ButtonEn: TButton
    Left = 116
    Top = 84
    Width = 20
    Height = 16
    Hint = '&'
    Action = ActionEn
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    TabStop = False
  end
  object ButtonF: TButton
    Left = 136
    Top = 84
    Width = 16
    Height = 16
    Action = ActionF
    TabOrder = 8
    TabStop = False
  end
  object ButtonG: TButton
    Left = 152
    Top = 84
    Width = 16
    Height = 16
    Action = ActionG
    TabOrder = 9
    TabStop = False
  end
  object ButtonH: TButton
    Left = 168
    Top = 84
    Width = 16
    Height = 16
    Action = ActionH
    TabOrder = 10
    TabStop = False
  end
  object ButtonI: TButton
    Left = 184
    Top = 84
    Width = 16
    Height = 16
    Action = ActionI
    TabOrder = 11
    TabStop = False
  end
  object ButtonJ: TButton
    Left = 12
    Top = 100
    Width = 16
    Height = 16
    Action = ActionJ
    TabOrder = 12
    TabStop = False
  end
  object ButtonK: TButton
    Left = 28
    Top = 100
    Width = 16
    Height = 16
    Action = ActionK
    TabOrder = 13
    TabStop = False
  end
  object ButtonL: TButton
    Left = 44
    Top = 100
    Width = 16
    Height = 16
    Action = ActionL
    TabOrder = 14
    TabStop = False
  end
  object ButtonM: TButton
    Left = 60
    Top = 100
    Width = 16
    Height = 16
    Action = ActionM
    TabOrder = 15
    TabStop = False
  end
  object ButtonN: TButton
    Left = 76
    Top = 100
    Width = 16
    Height = 16
    Action = ActionN
    TabOrder = 17
    TabStop = False
  end
  object ButtonNg: TButton
    Left = 92
    Top = 100
    Width = 20
    Height = 16
    Hint = '$'
    Action = ActionNg
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    TabStop = False
  end
  object ButtonO: TButton
    Left = 112
    Top = 100
    Width = 16
    Height = 16
    Action = ActionO
    TabOrder = 18
    TabStop = False
  end
  object ButtonOn: TButton
    Left = 128
    Top = 100
    Width = 20
    Height = 16
    Hint = #176
    Action = ActionOn
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    TabStop = False
  end
  object ButtonOu: TButton
    Left = 148
    Top = 100
    Width = 20
    Height = 16
    Hint = #249
    Action = ActionOu
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    TabStop = False
  end
  object ButtonP: TButton
    Left = 168
    Top = 100
    Width = 16
    Height = 16
    Action = ActionP
    TabOrder = 21
    TabStop = False
  end
  object ButtonR: TButton
    Left = 184
    Top = 100
    Width = 16
    Height = 16
    Action = ActionR
    TabOrder = 22
    TabStop = False
  end
  object ButtonS: TButton
    Left = 12
    Top = 116
    Width = 16
    Height = 16
    Action = ActionS
    TabOrder = 23
    TabStop = False
  end
  object ButtonT: TButton
    Left = 28
    Top = 116
    Width = 16
    Height = 16
    Action = ActionT
    TabOrder = 24
    TabStop = False
  end
  object ButtonUi: TButton
    Left = 44
    Top = 116
    Width = 20
    Height = 16
    Action = ActionUi
    TabOrder = 25
    TabStop = False
  end
  object ButtonV: TButton
    Left = 64
    Top = 116
    Width = 16
    Height = 16
    Action = ActionV
    TabOrder = 36
    TabStop = False
  end
  object ButtonW: TButton
    Left = 80
    Top = 116
    Width = 16
    Height = 16
    Action = ActionW
    TabOrder = 37
    TabStop = False
  end
  object ButtonY: TButton
    Left = 96
    Top = 116
    Width = 16
    Height = 16
    Action = ActionY
    TabOrder = 38
    TabStop = False
  end
  object ButtonZ: TButton
    Left = 112
    Top = 116
    Width = 16
    Height = 16
    Action = ActionZ
    TabOrder = 26
    TabStop = False
  end
  object ButtonJoker: TButton
    Left = 128
    Top = 116
    Width = 16
    Height = 16
    Action = ActionJoker
    Caption = '&?'
    TabOrder = 27
    TabStop = False
  end
  object ButtonFin: TButton
    Left = 183
    Top = 116
    Width = 17
    Height = 16
    Action = ActionFin
    TabOrder = 29
    TabStop = False
  end
  object ButtonEffacer: TButton
    Left = 144
    Top = 116
    Width = 39
    Height = 16
    Action = ActionEffacer
    TabOrder = 28
    TabStop = False
  end
  object RadioGroupDirection: TRadioGroup
    Left = 13
    Top = 136
    Width = 188
    Height = 49
    Caption = ' Direction '
    Enabled = False
    Items.Strings = (
      '&Horizontalement'
      '&Verticalement')
    TabOrder = 30
    TabStop = True
    OnClick = RadioGroupDirectionClick
  end
  object ComboBoxColonne: TComboBox
    Left = 150
    Top = 191
    Width = 49
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    Enabled = False
    TabOrder = 31
    OnChange = ComboBoxChange
    Items.Strings = (
      '1'
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
  object ComboBoxLigne: TComboBox
    Left = 150
    Top = 216
    Width = 49
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    Enabled = False
    TabOrder = 32
    OnChange = ComboBoxChange
    Items.Strings = (
      'A'
      'B'
      'C'
      'D'
      'E'
      'F'
      'G'
      'H'
      'I'
      'J'
      'K'
      'L'
      'M'
      'N'
      'O')
  end
  object ButtonPlacer: TButton
    Left = 16
    Top = 248
    Width = 81
    Height = 25
    Caption = 'Placer'
    Default = True
    Enabled = False
    TabOrder = 33
    OnClick = ButtonPlacerClick
    OnKeyDown = ButtonPlacerKeyDown
  end
  object ButtonAnnuler: TButton
    Left = 112
    Top = 248
    Width = 85
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 34
  end
  object ActionList: TActionList
    Top = 65512
    object ActionA: TAction
      Category = 'SaisiePose'
      Caption = '&A'
      ShortCut = 65
      OnExecute = ActionLettreExecute
    end
    object ActionAn: TAction
      Category = 'SaisiePose'
      Caption = 'An'
      OnExecute = ActionLettreExecute
    end
    object ActionB: TAction
      Category = 'SaisiePose'
      Caption = '&B'
      ShortCut = 66
      OnExecute = ActionLettreExecute
    end
    object ActionCh: TAction
      Category = 'SaisiePose'
      Caption = 'Ch'
      OnExecute = ActionLettreExecute
    end
    object ActionD: TAction
      Category = 'SaisiePose'
      Caption = '&D'
      ShortCut = 68
      OnExecute = ActionLettreExecute
    end
    object ActionE: TAction
      Category = 'SaisiePose'
      Caption = '&E'
      ShortCut = 69
      OnExecute = ActionLettreExecute
    end
    object ActionEn: TAction
      Category = 'SaisiePose'
      Caption = 'En'
      OnExecute = ActionLettreExecute
    end
    object ActionF: TAction
      Category = 'SaisiePose'
      Caption = '&F'
      ShortCut = 70
      OnExecute = ActionLettreExecute
    end
    object ActionG: TAction
      Category = 'SaisiePose'
      Caption = '&G'
      ShortCut = 71
      OnExecute = ActionLettreExecute
    end
    object ActionH: TAction
      Category = 'SaisiePose'
      Caption = '&H'
      ShortCut = 72
      OnExecute = ActionLettreExecute
    end
    object ActionI: TAction
      Category = 'SaisiePose'
      Caption = '&I'
      ShortCut = 73
      OnExecute = ActionLettreExecute
    end
    object ActionJ: TAction
      Category = 'SaisiePose'
      Caption = '&J'
      ShortCut = 74
      OnExecute = ActionLettreExecute
    end
    object ActionK: TAction
      Category = 'SaisiePose'
      Caption = '&K'
      ShortCut = 75
      OnExecute = ActionLettreExecute
    end
    object ActionL: TAction
      Category = 'SaisiePose'
      Caption = '&L'
      ShortCut = 76
      OnExecute = ActionLettreExecute
    end
    object ActionM: TAction
      Category = 'SaisiePose'
      Caption = '&M'
      ShortCut = 77
      OnExecute = ActionLettreExecute
    end
    object ActionN: TAction
      Category = 'SaisiePose'
      Caption = '&N'
      ShortCut = 78
      OnExecute = ActionLettreExecute
    end
    object ActionNg: TAction
      Category = 'SaisiePose'
      Caption = 'Ng'
      OnExecute = ActionLettreExecute
    end
    object ActionO: TAction
      Category = 'SaisiePose'
      Caption = '&O'
      ShortCut = 79
      OnExecute = ActionLettreExecute
    end
    object ActionOn: TAction
      Category = 'SaisiePose'
      Caption = 'On'
      OnExecute = ActionLettreExecute
    end
    object ActionOu: TAction
      Category = 'SaisiePose'
      Caption = 'Ou'
      OnExecute = ActionLettreExecute
    end
    object ActionP: TAction
      Category = 'SaisiePose'
      Caption = '&P'
      ShortCut = 80
      OnExecute = ActionLettreExecute
    end
    object ActionR: TAction
      Category = 'SaisiePose'
      Caption = '&R'
      ShortCut = 82
      OnExecute = ActionLettreExecute
    end
    object ActionS: TAction
      Category = 'SaisiePose'
      Caption = '&S'
      ShortCut = 83
      OnExecute = ActionLettreExecute
    end
    object ActionT: TAction
      Category = 'SaisiePose'
      Caption = '&T'
      ShortCut = 84
      OnExecute = ActionLettreExecute
    end
    object ActionUi: TAction
      Category = 'SaisiePose'
      Caption = '&Ui'
      ShortCut = 85
      OnExecute = ActionLettreExecute
    end
    object ActionV: TAction
      Category = 'SaisiePose'
      Caption = '&V'
      ShortCut = 86
      OnExecute = ActionLettreExecute
    end
    object ActionW: TAction
      Category = 'SaisiePose'
      Caption = '&W'
      ShortCut = 87
      OnExecute = ActionLettreExecute
    end
    object ActionY: TAction
      Category = 'SaisiePose'
      Caption = '&Y'
      ShortCut = 89
      OnExecute = ActionLettreExecute
    end
    object ActionZ: TAction
      Category = 'SaisiePose'
      Caption = '&Z'
      ShortCut = 90
      OnExecute = ActionLettreExecute
    end
    object ActionJoker: TAction
      Category = 'SaisiePose'
      Caption = '& '
      ShortCut = 16458
      OnExecute = ActionLettreExecute
    end
    object ActionEffacer: TAction
      Category = 'SaisiePose'
      Caption = 'Effacer'
      ShortCut = 8
      OnExecute = ActionEffacerExecute
    end
    object ActionFin: TAction
      Category = 'SaisiePose'
      Caption = 'Ok'
      ShortCut = 13
      OnExecute = ActionFinExecute
    end
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Left = 32
    Top = 65512
    object MenuItemA: TMenuItem
      Action = ActionA
    end
    object MenuItemB: TMenuItem
      Action = ActionB
    end
    object MenuItemC: TMenuItem
      Action = ActionCh
    end
    object MenuItemD: TMenuItem
      Action = ActionD
    end
    object MenuItemE: TMenuItem
      Action = ActionE
    end
    object MenuItemF: TMenuItem
      Action = ActionF
    end
    object MenuItemG: TMenuItem
      Action = ActionG
    end
    object MenuItemH: TMenuItem
      Action = ActionH
    end
    object MenuItemI: TMenuItem
      Action = ActionI
    end
    object MenuItemJ: TMenuItem
      Action = ActionJ
    end
    object MenuItemK: TMenuItem
      Action = ActionK
    end
    object MenuItemL: TMenuItem
      Action = ActionL
    end
    object MenuItemM: TMenuItem
      Action = ActionM
    end
    object MenuItemN: TMenuItem
      Action = ActionN
    end
    object MenuItemO: TMenuItem
      Action = ActionO
    end
    object MenuItemP: TMenuItem
      Action = ActionP
    end
    object MenuItemR: TMenuItem
      Action = ActionR
    end
    object MenuItemS: TMenuItem
      Action = ActionS
    end
    object MenuItemT: TMenuItem
      Action = ActionT
    end
    object MenuItemU: TMenuItem
      Action = ActionUi
    end
    object MenuItemV: TMenuItem
      Action = ActionV
    end
    object MenuItemW: TMenuItem
      Action = ActionW
    end
    object MenuItemY: TMenuItem
      Action = ActionY
    end
    object MenuItemZ: TMenuItem
      Action = ActionZ
    end
    object MenuItemEffacer: TMenuItem
      Action = ActionEffacer
    end
    object MenuItemJoker: TMenuItem
      Action = ActionJoker
      Caption = '&?'
    end
  end
  object TimerPlacementAuto: TTimer
    Interval = 100
    OnTimer = TimerPlacementAutoTimer
    Left = 64
    Top = 65512
  end
end
