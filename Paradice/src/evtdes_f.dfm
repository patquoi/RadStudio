object FormEvtDes: TFormEvtDes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ev'#233'nements de d'#233's'
  ClientHeight = 400
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelNomEvenement: TLabel
    Left = 56
    Top = 16
    Width = 227
    Height = 22
    Alignment = taCenter
    AutoSize = False
    Caption = 'Nom de l'#39#233'v'#233'nement de d'#233's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 315
    Width = 134
    Height = 13
    Caption = 'Type de d'#233'finition de gain : '
  end
  object Label2: TLabel
    Left = 8
    Top = 334
    Width = 48
    Height = 13
    Caption = 'Formule : '
  end
  object Label3: TLabel
    Left = 8
    Top = 296
    Width = 112
    Height = 13
    Caption = 'Famille d'#39#233'v'#233'nements : '
  end
  object LabelFamille: TLabel
    Left = 285
    Top = 296
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Famille'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelDefinition: TLabel
    Left = 271
    Top = 315
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = 'D'#233'finition'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelFormule: TLabel
    Left = 279
    Top = 334
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Formule'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel: TPanel
    Left = 0
    Top = 355
    Width = 333
    Height = 45
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonPrm: TButton
      Left = 8
      Top = 14
      Width = 75
      Height = 20
      Caption = '|< &Premier'
      TabOrder = 0
      OnClick = ButtonPrmClick
    end
    object ButtonPrc: TButton
      Left = 89
      Top = 14
      Width = 75
      Height = 20
      Caption = '< Pr'#233'&c'#233'dent'
      TabOrder = 1
      OnClick = ButtonPrcClick
    end
    object ButtonSvt: TButton
      Left = 170
      Top = 14
      Width = 75
      Height = 20
      Caption = '&Suivant >'
      TabOrder = 2
      OnClick = ButtonSvtClick
    end
    object ButtonDrn: TButton
      Left = 251
      Top = 14
      Width = 75
      Height = 20
      Caption = '&Dernier >|'
      TabOrder = 3
      OnClick = ButtonDrnClick
    end
  end
  object DrawGrid: TDrawGrid
    Left = 51
    Top = 44
    Width = 232
    Height = 232
    TabStop = False
    ColCount = 7
    DefaultColWidth = 32
    DefaultRowHeight = 32
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = DrawGridDrawCell
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 333
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 356
    Width = 333
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 3
  end
  object VirtualImageListEvts: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 177
        CollectionName = 'Cases\Case_01_Somme'
        Disabled = False
        Name = 'Case_01_Somme'
      end
      item
        CollectionIndex = 178
        CollectionName = 'Cases\Case_02_Produit'
        Disabled = False
        Name = 'Case_02_Produit'
      end
      item
        CollectionIndex = 179
        CollectionName = 'Cases\Case_03_Ecart'
        Disabled = False
        Name = 'Case_03_Ecart'
      end
      item
        CollectionIndex = 180
        CollectionName = 'Cases\Case_04_Rapport'
        Disabled = False
        Name = 'Case_04_Rapport'
      end
      item
        CollectionIndex = 181
        CollectionName = 'Cases\Case_05_NbD'#233's1'
        Disabled = False
        Name = 'Case_05_NbD'#233's1'
      end
      item
        CollectionIndex = 182
        CollectionName = 'Cases\Case_06_NbD'#233's2'
        Disabled = False
        Name = 'Case_06_NbD'#233's2'
      end
      item
        CollectionIndex = 183
        CollectionName = 'Cases\Case_07_NbD'#233's3'
        Disabled = False
        Name = 'Case_07_NbD'#233's3'
      end
      item
        CollectionIndex = 184
        CollectionName = 'Cases\Case_08_NbD'#233's4'
        Disabled = False
        Name = 'Case_08_NbD'#233's4'
      end
      item
        CollectionIndex = 185
        CollectionName = 'Cases\Case_09_NbD'#233's5'
        Disabled = False
        Name = 'Case_09_NbD'#233's5'
      end
      item
        CollectionIndex = 186
        CollectionName = 'Cases\Case_10_NbD'#233's6'
        Disabled = False
        Name = 'Case_10_NbD'#233's6'
      end
      item
        CollectionIndex = 187
        CollectionName = 'Cases\Case_11_Pair'
        Disabled = False
        Name = 'Case_11_Pair'
      end
      item
        CollectionIndex = 188
        CollectionName = 'Cases\Case_12_Impair'
        Disabled = False
        Name = 'Case_12_Impair'
      end
      item
        CollectionIndex = 189
        CollectionName = 'Cases\Case_13_Somme=5'
        Disabled = False
        Name = 'Case_13_Somme=5'
      end
      item
        CollectionIndex = 190
        CollectionName = 'Cases\Case_14_Somme=6'
        Disabled = False
        Name = 'Case_14_Somme=6'
      end
      item
        CollectionIndex = 191
        CollectionName = 'Cases\Case_15_Somme=7'
        Disabled = False
        Name = 'Case_15_Somme=7'
      end
      item
        CollectionIndex = 192
        CollectionName = 'Cases\Case_16_Somme=8'
        Disabled = False
        Name = 'Case_16_Somme=8'
      end
      item
        CollectionIndex = 193
        CollectionName = 'Cases\Case_17_Somme=9'
        Disabled = False
        Name = 'Case_17_Somme=9'
      end
      item
        CollectionIndex = 194
        CollectionName = 'Cases\Case_18_Produit=4'
        Disabled = False
        Name = 'Case_18_Produit=4'
      end
      item
        CollectionIndex = 195
        CollectionName = 'Cases\Case_19_Produit=6'
        Disabled = False
        Name = 'Case_19_Produit=6'
      end
      item
        CollectionIndex = 196
        CollectionName = 'Cases\Case_20_Produit=12'
        Disabled = False
        Name = 'Case_20_Produit=12'
      end
      item
        CollectionIndex = 197
        CollectionName = 'Cases\Case_21_Ecart=0'
        Disabled = False
        Name = 'Case_21_Ecart=0'
      end
      item
        CollectionIndex = 198
        CollectionName = 'Cases\Case_22_Ecart=1'
        Disabled = False
        Name = 'Case_22_Ecart=1'
      end
      item
        CollectionIndex = 199
        CollectionName = 'Cases\Case_23_Ecart=2'
        Disabled = False
        Name = 'Case_23_Ecart=2'
      end
      item
        CollectionIndex = 200
        CollectionName = 'Cases\Case_24_Ecart=3'
        Disabled = False
        Name = 'Case_24_Ecart=3'
      end
      item
        CollectionIndex = 201
        CollectionName = 'Cases\Case_25_Rapport=2'
        Disabled = False
        Name = 'Case_25_Rapport=2'
      end
      item
        CollectionIndex = 202
        CollectionName = 'Cases\Case_26_Rapport=3'
        Disabled = False
        Name = 'Case_26_Rapport=3'
      end>
    ImageCollection = FormPlateau.ImageCollection
    Width = 32
    Height = 32
    Left = 8
    Top = 56
  end
  object VirtualImageListDes: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 181
        CollectionName = 'Cases\Case_05_NbD'#233's1'
        Disabled = False
        Name = 'Case_05_NbD'#233's1'
      end
      item
        CollectionIndex = 182
        CollectionName = 'Cases\Case_06_NbD'#233's2'
        Disabled = False
        Name = 'Case_06_NbD'#233's2'
      end
      item
        CollectionIndex = 183
        CollectionName = 'Cases\Case_07_NbD'#233's3'
        Disabled = False
        Name = 'Case_07_NbD'#233's3'
      end
      item
        CollectionIndex = 184
        CollectionName = 'Cases\Case_08_NbD'#233's4'
        Disabled = False
        Name = 'Case_08_NbD'#233's4'
      end
      item
        CollectionIndex = 185
        CollectionName = 'Cases\Case_09_NbD'#233's5'
        Disabled = False
        Name = 'Case_09_NbD'#233's5'
      end
      item
        CollectionIndex = 186
        CollectionName = 'Cases\Case_10_NbD'#233's6'
        Disabled = False
        Name = 'Case_10_NbD'#233's6'
      end>
    ImageCollection = FormPlateau.ImageCollection
    Width = 32
    Height = 32
    Left = 8
    Top = 16
  end
end
