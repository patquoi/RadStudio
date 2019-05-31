object FormParamPose: TFormParamPose
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Qualit'#233' des solutions de la liste pour le choix de la pose'
  ClientHeight = 131
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelQualite: TLabel
    Left = 184
    Top = 80
    Width = 41
    Height = 13
    Caption = '&Qualit'#233' :'
  end
  object LabelProportion: TLabel
    Left = 232
    Top = 80
    Width = 20
    Height = 13
    Caption = '0%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelMax: TLabel
    Left = 476
    Top = 24
    Width = 29
    Height = 13
    Caption = '100%'
  end
  object LabelMin: TLabel
    Left = 180
    Top = 24
    Width = 17
    Height = 13
    AutoSize = False
    Caption = '0%'
  end
  object TrackBar: TTrackBar
    Left = 176
    Top = 40
    Width = 323
    Height = 28
    Hint = 'Qualit'#233' des solutions de la liste pour le choix de la pose'
    Max = 100
    Frequency = 2
    TabOrder = 1
    TickMarks = tmTopLeft
    OnChange = TrackBarChange
  end
  object RadioGroupTypeQualitePose: TRadioGroup
    Left = 16
    Top = 16
    Width = 145
    Height = 89
    Caption = ' T&ype de qualit'#233' de la pose '
    Items.Strings = (
      '&Top (100%)'
      'Rapport &Score/Top'
      '&Rang (1er=100%)')
    TabOrder = 0
    OnClick = RadioGroupTypeQualitePoseClick
  end
  object ButtonOK: TButton
    Left = 328
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object ButtonAnnuler: TButton
    Left = 416
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 3
    OnClick = ButtonAnnulerClick
  end
end
