object FormParamSrcDef: TFormParamSrcDef
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Personnalisation des sources de d'#233'finitions'
  ClientHeight = 320
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelExplication1: TLabel
    Left = 24
    Top = 14
    Width = 459
    Height = 13
    Caption = 
      'Vous pouvez d'#233'finir quatre sources de d'#233'finition suppl'#233'mentaires' +
      ' ci-dessous (nom et adresse).'
  end
  object LabelExplication2: TLabel
    Left = 24
    Top = 30
    Width = 301
    Height = 13
    Caption = 'Pour remplacer le mot '#224' rechercher dans l'#39'adresse, utilisez %s.'
  end
  object LabelTitreNom: TLabel
    Left = 24
    Top = 56
    Width = 181
    Height = 13
    Caption = 'Nom de la source des d'#233'finitions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 75
    Width = 10
    Height = 13
    Caption = '1.'
  end
  object Label2: TLabel
    Left = 8
    Top = 99
    Width = 10
    Height = 13
    Caption = '2.'
  end
  object Label3: TLabel
    Left = 8
    Top = 123
    Width = 10
    Height = 13
    Caption = '3.'
  end
  object Label4: TLabel
    Left = 8
    Top = 147
    Width = 10
    Height = 13
    Caption = '4.'
  end
  object Label5: TLabel
    Left = 8
    Top = 171
    Width = 10
    Height = 13
    Caption = '5.'
  end
  object Label6: TLabel
    Left = 8
    Top = 195
    Width = 10
    Height = 13
    Caption = '6.'
  end
  object Label7: TLabel
    Left = 8
    Top = 219
    Width = 10
    Height = 13
    Caption = '7.'
  end
  object Label8: TLabel
    Left = 8
    Top = 243
    Width = 10
    Height = 13
    Caption = '8.'
  end
  object LabelTitreUrl: TLabel
    Left = 230
    Top = 56
    Width = 241
    Height = 13
    Caption = 'Adresse de la page de d'#233'finition (http://...)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 24
    Top = 72
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 1
    OnChange = EditChange
  end
  object Edit2: TEdit
    Left = 24
    Top = 96
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 4
    OnChange = EditChange
  end
  object Edit3: TEdit
    Left = 24
    Top = 120
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 7
    OnChange = EditChange
  end
  object Edit4: TEdit
    Left = 24
    Top = 144
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 10
    OnChange = EditChange
  end
  object Edit5: TEdit
    Left = 24
    Top = 168
    Width = 200
    Height = 21
    TabOrder = 13
    OnChange = EditChange
  end
  object Edit6: TEdit
    Left = 24
    Top = 192
    Width = 200
    Height = 21
    TabOrder = 16
    OnChange = EditChange
  end
  object Edit7: TEdit
    Left = 24
    Top = 216
    Width = 200
    Height = 21
    TabOrder = 19
    OnChange = EditChange
  end
  object Edit8: TEdit
    Left = 24
    Top = 240
    Width = 200
    Height = 21
    TabOrder = 22
    OnChange = EditChange
  end
  object EditUrl1: TEdit
    Left = 228
    Top = 72
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 2
    OnChange = EditChange
  end
  object EditUrl2: TEdit
    Left = 228
    Top = 95
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 5
    OnChange = EditChange
  end
  object EditUrl3: TEdit
    Left = 228
    Top = 119
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 8
    OnChange = EditChange
  end
  object EditUrl4: TEdit
    Left = 228
    Top = 143
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 11
    OnChange = EditChange
  end
  object EditUrl5: TEdit
    Left = 228
    Top = 167
    Width = 400
    Height = 21
    TabOrder = 14
    OnChange = EditChange
  end
  object EditUrl6: TEdit
    Left = 228
    Top = 191
    Width = 400
    Height = 21
    TabOrder = 17
    OnChange = EditChange
  end
  object EditUrl7: TEdit
    Left = 228
    Top = 216
    Width = 400
    Height = 21
    TabOrder = 20
    OnChange = EditChange
  end
  object EditUrl8: TEdit
    Left = 228
    Top = 240
    Width = 400
    Height = 21
    TabOrder = 23
    OnChange = EditChange
  end
  object LabeledEditTest: TLabeledEdit
    Left = 632
    Top = 40
    Width = 80
    Height = 24
    CharCase = ecLowerCase
    EditLabel.Width = 75
    EditLabel.Height = 13
    EditLabel.Caption = 'Mot pour tester'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = 'ayisyen'
  end
  object Button1: TButton
    Tag = 1
    Left = 632
    Top = 72
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 3
    OnClick = ButtonTesterClick
  end
  object Button2: TButton
    Tag = 2
    Left = 632
    Top = 96
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 6
    OnClick = ButtonTesterClick
  end
  object Button3: TButton
    Tag = 3
    Left = 632
    Top = 120
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 9
    OnClick = ButtonTesterClick
  end
  object Button4: TButton
    Tag = 4
    Left = 632
    Top = 144
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 12
    OnClick = ButtonTesterClick
  end
  object Button5: TButton
    Tag = 5
    Left = 632
    Top = 168
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 15
    OnClick = ButtonTesterClick
  end
  object Button6: TButton
    Tag = 6
    Left = 632
    Top = 192
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 18
    OnClick = ButtonTesterClick
  end
  object Button7: TButton
    Tag = 7
    Left = 632
    Top = 216
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 21
    OnClick = ButtonTesterClick
  end
  object Button8: TButton
    Tag = 8
    Left = 632
    Top = 240
    Width = 80
    Height = 24
    Caption = 'Tester'
    TabOrder = 24
    OnClick = ButtonTesterClick
  end
  object ButtonOK: TButton
    Left = 24
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 25
    OnClick = ButtonOKClick
  end
  object ButtonAnnuler: TButton
    Left = 112
    Top = 280
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 26
  end
end
