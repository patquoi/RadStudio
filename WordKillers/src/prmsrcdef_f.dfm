object FormParamSrcDef: TFormParamSrcDef
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Personnalisation des sources de d'#233'finitions'
  ClientHeight = 323
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
    Left = 8
    Top = 8
    Width = 454
    Height = 13
    Caption = 
      'Vous pouvez d'#233'finir quatre sources de d'#233'finition suppl'#233'mentaires' +
      ' ci-dessous (nom et adresse).'
  end
  object LabelExplication2: TLabel
    Left = 8
    Top = 24
    Width = 319
    Height = 13
    Caption = 
      'Pour remplacer le mot '#224' rechercher dans l'#39'adresse, utilisez '#171' %s' +
      ' '#187'.'
  end
  object LabelTitreNom: TLabel
    Left = 24
    Top = 45
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
    Top = 68
    Width = 10
    Height = 13
    Caption = '1.'
  end
  object Label2: TLabel
    Left = 8
    Top = 95
    Width = 10
    Height = 13
    Caption = '2.'
  end
  object Label3: TLabel
    Left = 8
    Top = 122
    Width = 10
    Height = 13
    Caption = '3.'
  end
  object Label4: TLabel
    Left = 8
    Top = 149
    Width = 10
    Height = 13
    Caption = '4.'
  end
  object Label5: TLabel
    Left = 8
    Top = 176
    Width = 10
    Height = 13
    Caption = '5.'
  end
  object Label6: TLabel
    Left = 8
    Top = 203
    Width = 10
    Height = 13
    Caption = '6.'
  end
  object Label7: TLabel
    Left = 8
    Top = 230
    Width = 10
    Height = 13
    Caption = '7.'
  end
  object Label8: TLabel
    Left = 8
    Top = 255
    Width = 10
    Height = 13
    Caption = '8.'
  end
  object Label9: TLabel
    Left = 216
    Top = 45
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
    Top = 64
    Width = 181
    Height = 21
    Enabled = False
    TabOrder = 0
    OnChange = EditChange
  end
  object Edit2: TEdit
    Left = 24
    Top = 91
    Width = 181
    Height = 21
    Enabled = False
    TabOrder = 1
    OnChange = EditChange
  end
  object Edit3: TEdit
    Left = 24
    Top = 118
    Width = 181
    Height = 21
    Enabled = False
    TabOrder = 2
    OnChange = EditChange
  end
  object Edit4: TEdit
    Left = 24
    Top = 145
    Width = 181
    Height = 21
    Enabled = False
    TabOrder = 3
    OnChange = EditChange
  end
  object Edit5: TEdit
    Left = 24
    Top = 172
    Width = 181
    Height = 21
    TabOrder = 4
    OnChange = EditChange
  end
  object Edit6: TEdit
    Left = 24
    Top = 199
    Width = 181
    Height = 21
    TabOrder = 5
    OnChange = EditChange
  end
  object Edit7: TEdit
    Left = 24
    Top = 226
    Width = 181
    Height = 21
    TabOrder = 6
    OnChange = EditChange
  end
  object Edit8: TEdit
    Left = 24
    Top = 253
    Width = 181
    Height = 21
    TabOrder = 7
    OnChange = EditChange
  end
  object EditUrl1: TEdit
    Left = 216
    Top = 64
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 8
    OnChange = EditChange
  end
  object EditUrl2: TEdit
    Left = 216
    Top = 91
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 9
    OnChange = EditChange
  end
  object EditUrl3: TEdit
    Left = 216
    Top = 118
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 10
    OnChange = EditChange
  end
  object EditUrl4: TEdit
    Left = 216
    Top = 145
    Width = 400
    Height = 21
    Enabled = False
    TabOrder = 11
    OnChange = EditChange
  end
  object EditUrl5: TEdit
    Left = 216
    Top = 172
    Width = 400
    Height = 21
    TabOrder = 12
    OnChange = EditChange
  end
  object EditUrl6: TEdit
    Left = 216
    Top = 199
    Width = 400
    Height = 21
    TabOrder = 13
    OnChange = EditChange
  end
  object EditUrl7: TEdit
    Left = 216
    Top = 226
    Width = 400
    Height = 21
    TabOrder = 14
    OnChange = EditChange
  end
  object EditUrl8: TEdit
    Left = 216
    Top = 253
    Width = 400
    Height = 21
    TabOrder = 15
    OnChange = EditChange
  end
  object LabeledEditTest: TLabeledEdit
    Left = 622
    Top = 34
    Width = 90
    Height = 24
    EditLabel.Width = 75
    EditLabel.Height = 13
    EditLabel.Caption = 'Mot pour tester'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    Text = 'duplicata'
  end
  object Button1: TButton
    Tag = 1
    Left = 622
    Top = 64
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 17
    OnClick = ButtonTesterClick
  end
  object Button2: TButton
    Tag = 2
    Left = 622
    Top = 91
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 18
    OnClick = ButtonTesterClick
  end
  object Button3: TButton
    Tag = 3
    Left = 622
    Top = 118
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 19
    OnClick = ButtonTesterClick
  end
  object Button4: TButton
    Tag = 4
    Left = 622
    Top = 145
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 20
    OnClick = ButtonTesterClick
  end
  object Button5: TButton
    Tag = 5
    Left = 622
    Top = 172
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 21
    OnClick = ButtonTesterClick
  end
  object Button6: TButton
    Tag = 6
    Left = 622
    Top = 199
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 22
    OnClick = ButtonTesterClick
  end
  object Button7: TButton
    Tag = 7
    Left = 622
    Top = 226
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 23
    OnClick = ButtonTesterClick
  end
  object Button8: TButton
    Tag = 8
    Left = 622
    Top = 253
    Width = 90
    Height = 21
    Caption = 'Tester'
    TabOrder = 24
    OnClick = ButtonTesterClick
  end
  object ButtonOK: TButton
    Left = 24
    Top = 287
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 25
    OnClick = ButtonOKClick
  end
  object ButtonAnnuler: TButton
    Left = 104
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 26
  end
end
