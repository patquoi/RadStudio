object FormPropositionPose: TFormPropositionPose
  Left = 0
  Top = 0
  ActiveControl = ButtonProposerCoupJoueur
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Proposition de pose'
  ClientHeight = 354
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
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
    Left = 131
    Top = 8
    Width = 39
    Height = 13
    Caption = 'Reliquat'
  end
  object LabelPose: TLabel
    Left = 12
    Top = 24
    Width = 19
    Height = 36
    Caption = 'A'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LabelReliquat: TLabel
    Left = 37
    Top = 24
    Width = 133
    Height = 36
    Alignment = taRightJustify
    Caption = 'TUWXYYZ'
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -32
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LabelColonne: TLabel
    Left = 16
    Top = 240
    Width = 82
    Height = 13
    Caption = '&Colonne D'#233'part :'
    Enabled = False
    FocusControl = ComboBoxColonne
  end
  object LabelLigne: TLabel
    Left = 16
    Top = 264
    Width = 68
    Height = 13
    Caption = '&Ligne D'#233'part :'
    Enabled = False
    FocusControl = ComboBoxLigne
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 335
    Width = 184
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ButtonProposerCoupJoueur: TButton
    Left = 12
    Top = 76
    Width = 157
    Height = 25
    Caption = 'Afficher ma proposition'
    Default = True
    TabOrder = 1
    OnClick = ButtonProposerCoupJoueurClick
  end
  object ButtonA: TButton
    Left = 12
    Top = 112
    Width = 16
    Height = 16
    Action = ActionA
    TabOrder = 2
  end
  object ButtonB: TButton
    Left = 28
    Top = 112
    Width = 16
    Height = 16
    Action = ActionB
    TabOrder = 3
  end
  object ButtonC: TButton
    Left = 44
    Top = 112
    Width = 16
    Height = 16
    Action = ActionC
    TabOrder = 4
  end
  object ButtonD: TButton
    Left = 60
    Top = 112
    Width = 16
    Height = 16
    Action = ActionD
    TabOrder = 5
  end
  object ButtonE: TButton
    Left = 76
    Top = 112
    Width = 16
    Height = 16
    Action = ActionE
    TabOrder = 6
  end
  object ButtonF: TButton
    Left = 92
    Top = 112
    Width = 16
    Height = 16
    Action = ActionF
    TabOrder = 7
  end
  object ButtonG: TButton
    Left = 108
    Top = 112
    Width = 16
    Height = 16
    Action = ActionG
    TabOrder = 8
  end
  object ButtonH: TButton
    Left = 124
    Top = 112
    Width = 16
    Height = 16
    Action = ActionH
    TabOrder = 9
  end
  object ButtonI: TButton
    Left = 140
    Top = 112
    Width = 16
    Height = 16
    Action = ActionI
    TabOrder = 10
  end
  object ButtonJ: TButton
    Left = 156
    Top = 112
    Width = 16
    Height = 16
    Action = ActionJ
    TabOrder = 11
  end
  object ButtonK: TButton
    Left = 12
    Top = 128
    Width = 16
    Height = 16
    Action = ActionK
    TabOrder = 12
  end
  object ButtonL: TButton
    Left = 28
    Top = 128
    Width = 16
    Height = 16
    Action = ActionL
    TabOrder = 13
  end
  object ButtonM: TButton
    Left = 44
    Top = 128
    Width = 16
    Height = 16
    Action = ActionM
    TabOrder = 14
  end
  object ButtonN: TButton
    Left = 60
    Top = 128
    Width = 16
    Height = 16
    Action = ActionN
    TabOrder = 15
  end
  object ButtonO: TButton
    Left = 76
    Top = 128
    Width = 16
    Height = 16
    Action = ActionO
    TabOrder = 16
  end
  object ButtonP: TButton
    Left = 92
    Top = 128
    Width = 16
    Height = 16
    Action = ActionP
    TabOrder = 17
  end
  object ButtonQ: TButton
    Left = 108
    Top = 128
    Width = 16
    Height = 16
    Action = ActionQ
    TabOrder = 18
  end
  object ButtonR: TButton
    Left = 124
    Top = 128
    Width = 16
    Height = 16
    Action = ActionR
    TabOrder = 19
  end
  object ButtonS: TButton
    Left = 140
    Top = 128
    Width = 16
    Height = 16
    Action = ActionS
    TabOrder = 20
  end
  object ButtonT: TButton
    Left = 156
    Top = 128
    Width = 16
    Height = 16
    Action = ActionT
    TabOrder = 21
  end
  object ButtonU: TButton
    Left = 12
    Top = 144
    Width = 16
    Height = 16
    Action = ActionU
    TabOrder = 22
  end
  object ButtonV: TButton
    Left = 28
    Top = 144
    Width = 16
    Height = 16
    Action = ActionV
    TabOrder = 23
  end
  object ButtonW: TButton
    Left = 44
    Top = 144
    Width = 16
    Height = 16
    Action = ActionW
    TabOrder = 24
  end
  object ButtonX: TButton
    Left = 60
    Top = 144
    Width = 16
    Height = 16
    Action = ActionX
    TabOrder = 25
  end
  object ButtonY: TButton
    Left = 76
    Top = 144
    Width = 16
    Height = 16
    Action = ActionY
    TabOrder = 26
  end
  object ButtonZ: TButton
    Left = 92
    Top = 144
    Width = 16
    Height = 16
    Action = ActionZ
    TabOrder = 27
  end
  object ButtonJoker: TButton
    Left = 108
    Top = 144
    Width = 16
    Height = 16
    Action = ActionJoker
    Caption = '&?'
    TabOrder = 28
  end
  object ButtonEffacer: TButton
    Left = 124
    Top = 144
    Width = 48
    Height = 16
    Action = ActionEffacer
    TabOrder = 29
  end
  object RadioGroupDirection: TRadioGroup
    Left = 12
    Top = 170
    Width = 159
    Height = 63
    Caption = ' Direction '
    Enabled = False
    Items.Strings = (
      '&Horizontalement'
      '&Verticalement')
    TabOrder = 30
    OnClick = RadioGroupDirectionClick
  end
  object ComboBoxColonne: TComboBox
    Left = 122
    Top = 239
    Width = 49
    Height = 21
    Style = csDropDownList
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
    Left = 122
    Top = 264
    Width = 49
    Height = 21
    Style = csDropDownList
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
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Placer'
    Default = True
    TabOrder = 33
    OnClick = ButtonPlacerClick
    OnKeyDown = ButtonPlacerKeyDown
  end
  object ButtonAnnuler: TButton
    Left = 96
    Top = 296
    Width = 75
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
    object ActionB: TAction
      Category = 'SaisiePose'
      Caption = '&B'
      ShortCut = 66
      OnExecute = ActionLettreExecute
    end
    object ActionC: TAction
      Category = 'SaisiePose'
      Caption = '&C'
      ShortCut = 67
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
    object ActionO: TAction
      Category = 'SaisiePose'
      Caption = '&O'
      ShortCut = 79
      OnExecute = ActionLettreExecute
    end
    object ActionP: TAction
      Category = 'SaisiePose'
      Caption = '&P'
      ShortCut = 80
      OnExecute = ActionLettreExecute
    end
    object ActionQ: TAction
      Category = 'SaisiePose'
      Caption = '&Q'
      ShortCut = 81
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
    object ActionU: TAction
      Category = 'SaisiePose'
      Caption = '&U'
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
    object ActionX: TAction
      Category = 'SaisiePose'
      Caption = '&X'
      ShortCut = 88
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
    Left = 24
    Top = 65512
    object MenuItemA: TMenuItem
      Action = ActionA
    end
    object MenuItemB: TMenuItem
      Action = ActionB
    end
    object MenuItemC: TMenuItem
      Action = ActionC
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
    object MenuItemQ: TMenuItem
      Action = ActionQ
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
      Action = ActionU
    end
    object MenuItemV: TMenuItem
      Action = ActionV
    end
    object MenuItemW: TMenuItem
      Action = ActionW
    end
    object MenuItemX: TMenuItem
      Action = ActionX
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
    Left = 48
    Top = 65512
  end
end
