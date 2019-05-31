object FormJoker: TFormJoker
  Left = 0
  Top = 0
  Caption = 'Attribuer une lettre au joker '#39'?'#39
  ClientHeight = 177
  ClientWidth = 249
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 33
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Tag = 1
    Left = 16
    Top = 40
    Width = 25
    Height = 25
    Caption = '&A'
    TabOrder = 1
    OnClick = ButtonLettreClick
  end
  object Button2: TButton
    Tag = 1
    Left = 47
    Top = 39
    Width = 25
    Height = 25
    Caption = '&B'
    TabOrder = 2
    OnClick = ButtonLettreClick
  end
  object Button3: TButton
    Tag = 1
    Left = 78
    Top = 39
    Width = 25
    Height = 25
    Caption = '&C'
    TabOrder = 3
    OnClick = ButtonLettreClick
  end
  object Button4: TButton
    Tag = 1
    Left = 109
    Top = 39
    Width = 25
    Height = 25
    Caption = '&D'
    TabOrder = 4
    OnClick = ButtonLettreClick
  end
  object Button5: TButton
    Tag = 1
    Left = 140
    Top = 39
    Width = 25
    Height = 25
    Caption = '&E'
    TabOrder = 5
    OnClick = ButtonLettreClick
  end
  object Button6: TButton
    Tag = 1
    Left = 171
    Top = 39
    Width = 25
    Height = 25
    Caption = '&F'
    TabOrder = 6
    OnClick = ButtonLettreClick
  end
  object Button7: TButton
    Tag = 1
    Left = 202
    Top = 39
    Width = 25
    Height = 25
    Caption = '&G'
    TabOrder = 7
    OnClick = ButtonLettreClick
  end
  object Button8: TButton
    Tag = 1
    Left = 16
    Top = 70
    Width = 25
    Height = 25
    Caption = '&H'
    TabOrder = 8
    OnClick = ButtonLettreClick
  end
  object Button9: TButton
    Tag = 1
    Left = 47
    Top = 71
    Width = 25
    Height = 25
    Caption = '&I'
    TabOrder = 9
    OnClick = ButtonLettreClick
  end
  object Button10: TButton
    Tag = 1
    Left = 78
    Top = 70
    Width = 25
    Height = 25
    Caption = '&J'
    TabOrder = 10
    OnClick = ButtonLettreClick
  end
  object Button11: TButton
    Tag = 1
    Left = 109
    Top = 70
    Width = 25
    Height = 25
    Caption = '&K'
    TabOrder = 11
    OnClick = ButtonLettreClick
  end
  object Button12: TButton
    Tag = 1
    Left = 140
    Top = 70
    Width = 25
    Height = 25
    Caption = '&L'
    TabOrder = 12
    OnClick = ButtonLettreClick
  end
  object Button13: TButton
    Tag = 1
    Left = 171
    Top = 70
    Width = 25
    Height = 25
    Caption = '&M'
    TabOrder = 13
    OnClick = ButtonLettreClick
  end
  object Button14: TButton
    Tag = 1
    Left = 202
    Top = 70
    Width = 25
    Height = 25
    Caption = '&N'
    TabOrder = 14
    OnClick = ButtonLettreClick
  end
  object Button15: TButton
    Tag = 1
    Left = 16
    Top = 102
    Width = 25
    Height = 25
    Caption = '&O'
    TabOrder = 15
    OnClick = ButtonLettreClick
  end
  object Button16: TButton
    Tag = 1
    Left = 47
    Top = 102
    Width = 25
    Height = 25
    Caption = '&P'
    TabOrder = 16
    OnClick = ButtonLettreClick
  end
  object Button17: TButton
    Tag = 1
    Left = 78
    Top = 101
    Width = 25
    Height = 25
    Caption = '&Q'
    TabOrder = 17
    OnClick = ButtonLettreClick
  end
  object Button18: TButton
    Tag = 1
    Left = 109
    Top = 101
    Width = 25
    Height = 25
    Caption = '&R'
    TabOrder = 18
    OnClick = ButtonLettreClick
  end
  object Button19: TButton
    Tag = 1
    Left = 140
    Top = 101
    Width = 25
    Height = 25
    Caption = '&S'
    TabOrder = 19
    OnClick = ButtonLettreClick
  end
  object Button20: TButton
    Tag = 1
    Left = 171
    Top = 101
    Width = 25
    Height = 25
    Caption = '&T'
    TabOrder = 20
    OnClick = ButtonLettreClick
  end
  object Button21: TButton
    Tag = 1
    Left = 202
    Top = 101
    Width = 25
    Height = 25
    Caption = '&U'
    TabOrder = 21
    OnClick = ButtonLettreClick
  end
  object Button22: TButton
    Tag = 1
    Left = 16
    Top = 133
    Width = 25
    Height = 25
    Caption = '&V'
    TabOrder = 22
    OnClick = ButtonLettreClick
  end
  object Button23: TButton
    Tag = 1
    Left = 47
    Top = 132
    Width = 25
    Height = 25
    Caption = '&W'
    TabOrder = 23
    OnClick = ButtonLettreClick
  end
  object Button24: TButton
    Tag = 1
    Left = 78
    Top = 132
    Width = 25
    Height = 25
    Caption = '&X'
    TabOrder = 24
    OnClick = ButtonLettreClick
  end
  object Button25: TButton
    Tag = 1
    Left = 109
    Top = 132
    Width = 25
    Height = 25
    Caption = '&Y'
    TabOrder = 25
    OnClick = ButtonLettreClick
  end
  object Button26: TButton
    Tag = 1
    Left = 140
    Top = 132
    Width = 25
    Height = 25
    Caption = '&Z'
    TabOrder = 26
    OnClick = ButtonLettreClick
  end
  object ButtonAnnuler: TButton
    Left = 171
    Top = 132
    Width = 56
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 27
    OnClick = ButtonAnnulerClick
  end
end
