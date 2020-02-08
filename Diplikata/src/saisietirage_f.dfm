object FormSaisieTirage: TFormSaisieTirage
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Proposition de tirage'
  ClientHeight = 175
  ClientWidth = 300
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelReliquat: TLabel
    Left = 0
    Top = 0
    Width = 150
    Height = 17
    Hint = 'Reliquat (en gris - non modifiable)'
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'AnBnCnDnEnFnGn'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clSilver
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object LabelNouveauTirage: TLabel
    Left = 150
    Top = 0
    Width = 150
    Height = 17
    Hint = 'Nouveau tirage (en blanc)'
    AutoSize = False
    Caption = 'AnBnCnDnEnFnGn'
    Color = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object LabelInformation: TLabel
    Left = 0
    Top = 152
    Width = 300
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Utilisez la touche Retour Arri'#232're pour effacer le dernier jeton.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Tag = 2
    Left = 24
    Top = 24
    Width = 25
    Height = 25
    Caption = '&A'
    TabOrder = 0
    OnClick = ButtonJetonClick
  end
  object Button2: TButton
    Tag = 3
    Left = 56
    Top = 24
    Width = 25
    Height = 25
    Hint = '@'
    Caption = 'An'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = ButtonJetonClick
  end
  object Button3: TButton
    Tag = 4
    Left = 88
    Top = 24
    Width = 25
    Height = 25
    Caption = '&B'
    TabOrder = 2
    OnClick = ButtonJetonClick
  end
  object Button4: TButton
    Tag = 5
    Left = 120
    Top = 24
    Width = 25
    Height = 25
    Caption = '&Ch'
    TabOrder = 3
    OnClick = ButtonJetonClick
  end
  object Button5: TButton
    Tag = 6
    Left = 152
    Top = 24
    Width = 25
    Height = 25
    Caption = '&D'
    TabOrder = 4
    OnClick = ButtonJetonClick
  end
  object Button6: TButton
    Tag = 7
    Left = 184
    Top = 24
    Width = 25
    Height = 25
    Caption = '&E'
    TabOrder = 5
    OnClick = ButtonJetonClick
  end
  object Button7: TButton
    Tag = 8
    Left = 216
    Top = 24
    Width = 25
    Height = 25
    Hint = '&'
    Caption = 'En'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ButtonJetonClick
  end
  object Button8: TButton
    Tag = 9
    Left = 248
    Top = 24
    Width = 25
    Height = 25
    Caption = '&F'
    TabOrder = 7
    OnClick = ButtonJetonClick
  end
  object Button9: TButton
    Tag = 10
    Left = 24
    Top = 56
    Width = 25
    Height = 25
    Caption = '&G'
    TabOrder = 8
    OnClick = ButtonJetonClick
  end
  object Button10: TButton
    Tag = 11
    Left = 56
    Top = 56
    Width = 25
    Height = 25
    Caption = '&H'
    TabOrder = 9
    OnClick = ButtonJetonClick
  end
  object Button11: TButton
    Tag = 12
    Left = 88
    Top = 56
    Width = 25
    Height = 25
    Caption = '&I'
    TabOrder = 10
    OnClick = ButtonJetonClick
  end
  object Button12: TButton
    Tag = 13
    Left = 120
    Top = 56
    Width = 25
    Height = 25
    Caption = '&J'
    TabOrder = 11
    OnClick = ButtonJetonClick
  end
  object Button13: TButton
    Tag = 14
    Left = 152
    Top = 56
    Width = 25
    Height = 25
    Caption = '&K'
    TabOrder = 12
    OnClick = ButtonJetonClick
  end
  object Button14: TButton
    Tag = 15
    Left = 184
    Top = 56
    Width = 25
    Height = 25
    Caption = '&L'
    TabOrder = 13
    OnClick = ButtonJetonClick
  end
  object Button15: TButton
    Tag = 16
    Left = 216
    Top = 56
    Width = 25
    Height = 25
    Caption = '&M'
    TabOrder = 14
    OnClick = ButtonJetonClick
  end
  object Button16: TButton
    Tag = 17
    Left = 248
    Top = 56
    Width = 25
    Height = 25
    Caption = '&N'
    TabOrder = 15
    OnClick = ButtonJetonClick
  end
  object Button17: TButton
    Tag = 18
    Left = 24
    Top = 88
    Width = 25
    Height = 25
    Hint = '$'
    Caption = 'Ng'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = ButtonJetonClick
  end
  object Button18: TButton
    Tag = 19
    Left = 56
    Top = 88
    Width = 25
    Height = 25
    Caption = '&O'
    TabOrder = 17
    OnClick = ButtonJetonClick
  end
  object Button19: TButton
    Tag = 20
    Left = 88
    Top = 88
    Width = 25
    Height = 25
    Hint = #176
    Caption = 'On'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    OnClick = ButtonJetonClick
  end
  object Button20: TButton
    Tag = 21
    Left = 120
    Top = 88
    Width = 25
    Height = 25
    Hint = #249
    Caption = 'Ou'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    OnClick = ButtonJetonClick
  end
  object Button22: TButton
    Tag = 23
    Left = 184
    Top = 88
    Width = 25
    Height = 25
    Caption = '&P'
    TabOrder = 21
    OnClick = ButtonJetonClick
  end
  object Button23: TButton
    Tag = 24
    Left = 217
    Top = 87
    Width = 25
    Height = 25
    Caption = '&R'
    TabOrder = 22
    OnClick = ButtonJetonClick
  end
  object Button24: TButton
    Tag = 25
    Left = 248
    Top = 88
    Width = 25
    Height = 25
    Caption = '&S'
    TabOrder = 23
    OnClick = ButtonJetonClick
  end
  object Button25: TButton
    Tag = 26
    Left = 24
    Top = 120
    Width = 25
    Height = 25
    Caption = '&T'
    TabOrder = 24
    OnClick = ButtonJetonClick
  end
  object Button26: TButton
    Tag = 27
    Left = 56
    Top = 120
    Width = 25
    Height = 25
    Caption = '&Ui'
    TabOrder = 25
    OnClick = ButtonJetonClick
  end
  object Button27: TButton
    Tag = 28
    Left = 89
    Top = 119
    Width = 25
    Height = 25
    Caption = '&V'
    TabOrder = 26
    OnClick = ButtonJetonClick
  end
  object Button28: TButton
    Tag = 29
    Left = 120
    Top = 120
    Width = 25
    Height = 25
    Caption = '&W'
    TabOrder = 29
    OnClick = ButtonJetonClick
  end
  object Button29: TButton
    Tag = 30
    Left = 152
    Top = 120
    Width = 25
    Height = 25
    Caption = '&Y'
    TabOrder = 30
    OnClick = ButtonJetonClick
  end
  object Button30: TButton
    Tag = 31
    Left = 184
    Top = 120
    Width = 25
    Height = 25
    Caption = '&Z'
    TabOrder = 31
    OnClick = ButtonJetonClick
  end
  object Button0: TButton
    Tag = 1
    Left = 216
    Top = 120
    Width = 25
    Height = 25
    Caption = '&?'
    TabOrder = 27
    OnClick = ButtonJetonClick
  end
  object ButtonOK: TButton
    Left = 248
    Top = 120
    Width = 25
    Height = 26
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 28
    OnClick = ButtonOKClick
  end
  object Button21: TButton
    Tag = 22
    Left = 152
    Top = 88
    Width = 25
    Height = 25
    Hint = #249
    Caption = 'Oun'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnClick = ButtonJetonClick
  end
end
