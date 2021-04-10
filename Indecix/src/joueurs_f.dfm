object FormJoueurs: TFormJoueurs
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'D'#233'finition des joueurs'
  ClientHeight = 247
  ClientWidth = 409
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 201
    Caption = ' Joueur de Gauche '
    TabOrder = 0
    object PaintBoxG1: TPaintBox
      Tag = 1
      Left = 16
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG2: TPaintBox
      Tag = 2
      Left = 71
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG3: TPaintBox
      Tag = 3
      Left = 126
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG4: TPaintBox
      Tag = 4
      Left = 16
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG5: TPaintBox
      Tag = 5
      Left = 71
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG6: TPaintBox
      Tag = 6
      Left = 126
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxG7: TPaintBox
      Tag = 7
      Left = 16
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxGA: TPaintBox
      Left = 71
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxGH: TPaintBox
      Tag = 1
      Left = 126
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
  end
  object GroupBox2: TGroupBox
    Left = 207
    Top = 8
    Width = 193
    Height = 201
    Caption = ' Joueur de Droite '
    TabOrder = 1
    object PaintBoxD1: TPaintBox
      Tag = 1
      Left = 16
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD2: TPaintBox
      Tag = 2
      Left = 71
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD3: TPaintBox
      Tag = 3
      Left = 126
      Top = 24
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD4: TPaintBox
      Tag = 4
      Left = 16
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD5: TPaintBox
      Tag = 5
      Left = 71
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD6: TPaintBox
      Tag = 6
      Left = 126
      Top = 79
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxD7: TPaintBox
      Tag = 7
      Left = 16
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxDA: TPaintBox
      Left = 71
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
    object PaintBoxDH: TPaintBox
      Tag = 1
      Left = 126
      Top = 134
      Width = 49
      Height = 49
      OnClick = PaintBoxClick
      OnPaint = PaintBoxPaint
    end
  end
  object ButtonOK: TButton
    Left = 240
    Top = 215
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object ButtonAnnuler: TButton
    Left = 321
    Top = 214
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 3
  end
end
