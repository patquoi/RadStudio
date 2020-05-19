object FormNvPartie: TFormNvPartie
  Left = 0
  Top = 0
  ActiveControl = ButtonOK
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Nouvelle partie'
  ClientHeight = 359
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    297
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 101
    Height = 13
    Caption = 'Nombre de joueurs : '
  end
  object LabelNbJoueurs: TLabel
    Left = 123
    Top = 16
    Width = 14
    Height = 13
    AutoSize = False
    Caption = '6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PaintBoxP1: TPaintBox
    Tag = 1
    Left = 16
    Top = 47
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object PaintBoxP2: TPaintBox
    Tag = 2
    Left = 16
    Top = 85
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object PaintBoxP3: TPaintBox
    Tag = 3
    Left = 16
    Top = 123
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object PaintBoxP4: TPaintBox
    Tag = 4
    Left = 16
    Top = 161
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object PaintBoxP5: TPaintBox
    Tag = 5
    Left = 16
    Top = 199
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object PaintBoxP6: TPaintBox
    Tag = 6
    Left = 16
    Top = 237
    Width = 32
    Height = 32
    OnPaint = PaintBoxPPaint
  end
  object LabelJoueur1: TLabel
    Left = 64
    Top = 56
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelJoueur2: TLabel
    Left = 64
    Top = 94
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelJoueur3: TLabel
    Left = 64
    Top = 132
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelJoueur4: TLabel
    Left = 64
    Top = 170
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelJoueur6: TLabel
    Left = 64
    Top = 246
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelJoueur5: TLabel
    Left = 64
    Top = 208
    Width = 77
    Height = 13
    AutoSize = False
    Caption = 'Nom Joueur 5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PaintBoxC1: TPaintBox
    Tag = 1
    Left = 249
    Top = 47
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object PaintBoxC2: TPaintBox
    Tag = 2
    Left = 249
    Top = 85
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object PaintBoxC3: TPaintBox
    Tag = 3
    Left = 249
    Top = 123
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object PaintBoxC4: TPaintBox
    Tag = 4
    Left = 249
    Top = 161
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object PaintBoxC5: TPaintBox
    Tag = 5
    Left = 249
    Top = 199
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object PaintBoxC6: TPaintBox
    Tag = 6
    Left = 249
    Top = 237
    Width = 32
    Height = 32
    OnPaint = PaintBoxCPaint
  end
  object Label2: TLabel
    Left = 16
    Top = 288
    Width = 181
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Prix d'#39'achat unique d'#39'un '#233'v'#233'nement : '
  end
  object LabelPrixEvt: TLabel
    Left = 244
    Top = 288
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonOK: TButton
    Left = 34
    Top = 316
    Width = 91
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Commencer !'
    Default = True
    ModalResult = 1
    TabOrder = 10
    OnClick = ButtonOKClick
  end
  object ButtonAnnuler: TButton
    Left = 170
    Top = 316
    Width = 92
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 11
  end
  object ButtonMin: TButton
    Left = 160
    Top = 8
    Width = 25
    Height = 25
    Caption = ' |<'
    TabOrder = 0
    OnClick = ButtonMinClick
  end
  object ButtonMax: TButton
    Left = 254
    Top = 8
    Width = 25
    Height = 25
    Caption = '>|'
    TabOrder = 3
    OnClick = ButtonMaxClick
  end
  object ButtonPrc: TButton
    Left = 191
    Top = 8
    Width = 26
    Height = 25
    Caption = '<'
    TabOrder = 1
    OnClick = ButtonPrcClick
  end
  object ButtonSvt: TButton
    Left = 223
    Top = 8
    Width = 25
    Height = 25
    Caption = '>'
    TabOrder = 2
    OnClick = ButtonSvtClick
  end
  object CheckBox1: TCheckBox
    Left = 160
    Top = 55
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object CheckBox2: TCheckBox
    Left = 160
    Top = 93
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
  object CheckBox3: TCheckBox
    Left = 160
    Top = 131
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 6
    OnClick = CheckBoxClick
  end
  object CheckBox4: TCheckBox
    Left = 160
    Top = 169
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 7
    OnClick = CheckBoxClick
  end
  object CheckBox5: TCheckBox
    Left = 160
    Top = 207
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 8
    OnClick = CheckBoxClick
  end
  object CheckBox6: TCheckBox
    Left = 160
    Top = 245
    Width = 72
    Height = 17
    Caption = 'Automate'
    TabOrder = 9
    OnClick = CheckBoxClick
  end
end
