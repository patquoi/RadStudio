object FormMain: TFormMain
  Left = 1
  Top = 1
  Caption = 'Le Compte Pour De Bon'
  ClientHeight = 621
  ClientWidth = 518
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 534
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterH: TSplitter
    Left = 0
    Top = 518
    Width = 518
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    ExplicitTop = 504
    ExplicitWidth = 526
  end
  object PanelResultats: TPanel
    Left = 0
    Top = 86
    Width = 518
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 87
    ExplicitHeight = 431
    object SplitterV: TSplitter
      Left = 261
      Top = 0
      Width = 4
      Height = 432
      Beveled = True
      ExplicitHeight = 417
    end
    object ListBox: TListBox
      Left = 265
      Top = 0
      Width = 253
      Height = 432
      AutoComplete = False
      Align = alClient
      ItemHeight = 13
      ParentShowHint = False
      PopupMenu = PopupMenuListe
      ShowHint = False
      Sorted = True
      TabOrder = 0
      OnClick = ListBoxClick
      OnDblClick = ListBoxDblClick
      ExplicitHeight = 431
    end
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 261
      Height = 432
      Align = alLeft
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HideSelection = False
      Images = ImageListArbre
      Indent = 19
      ParentFont = False
      ParentShowHint = False
      PopupMenu = PopupMenuArbre
      ReadOnly = True
      ShowHint = False
      TabOrder = 1
      OnChange = TreeViewChange
      ExplicitHeight = 431
    end
  end
  object PanelNombres: TPanel
    Left = 0
    Top = 42
    Width = 518
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 43
    DesignSize = (
      518
      44)
    object Label1: TLabel
      Left = 24
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'1'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label2: TLabel
      Left = 96
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'2'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label3: TLabel
      Left = 168
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'3'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label4: TLabel
      Left = 240
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'4'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label5: TLabel
      Left = 312
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'5'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label6: TLabel
      Left = 384
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Plaque n'#176'6'
      Alignment = taCenter
      AutoSize = False
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object Label7: TLabel
      Left = 454
      Top = 7
      Width = 47
      Height = 30
      Hint = 'Compte '#224' trouver'
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Color = clMaroon
      Font.Charset = ANSI_CHARSET
      Font.Color = clYellow
      Font.Height = -21
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 518
    Height = 42
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar'
    EdgeBorders = [ebTop, ebBottom]
    Images = ImageListBoutons
    ParentShowHint = False
    PopupMenu = PopupMenuToolBar
    ShowHint = True
    TabOrder = 2
    Transparent = False
    object ToolButtonCompteNouveauTireAuSort: TToolButton
      Left = 0
      Top = 0
      Action = ActionCompteNouveauTirerAuSort
      AutoSize = True
    end
    object ToolButtonCompteNouveauPropose: TToolButton
      Left = 39
      Top = 0
      Action = ActionCompteNouveauProposer
      AutoSize = True
    end
    object ToolButtonSeparateur1: TToolButton
      Left = 78
      Top = 0
      Width = 8
      Caption = 'ToolButtonSeparateur1'
      Style = tbsSeparator
    end
    object ToolButtonCompteChercherSaisieSolution: TToolButton
      Left = 86
      Top = 0
      Action = ActionCompteChercherSaisirSolution
      AutoSize = True
    end
    object ToolButtonCompteCalculerSolutions: TToolButton
      Left = 125
      Top = 0
      Action = ActionCompteCalculerSolutions
      AutoSize = True
    end
    object ToolButtonSeparateur2: TToolButton
      Left = 164
      Top = 0
      Width = 8
      Caption = 'ToolButtonSeparateur2'
      Style = tbsSeparator
    end
    object ToolButtonAffichageTableau: TToolButton
      Left = 172
      Top = 0
      Action = ActionAffichageTableau
      AllowAllUp = True
      AutoSize = True
    end
    object ToolButtonAffichageEffacerSolutions: TToolButton
      Left = 211
      Top = 0
      Action = ActionAffichageEffacerSolutions
      AutoSize = True
    end
    object ToolButtonSeparateur3: TToolButton
      Left = 250
      Top = 0
      Width = 8
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButtonArbreSolutionLaPlusSimple: TToolButton
      Left = 258
      Top = 0
      Action = ActionArbreSolutionLaPlusSimple
      AutoSize = True
    end
    object ToolButtonArbreSolutionPlusSimple: TToolButton
      Left = 297
      Top = 0
      Action = ActionArbreSolutionPrecedenteComplexite
      AutoSize = True
    end
    object ToolButtonArbreSolutionPlusTordue: TToolButton
      Left = 336
      Top = 0
      Action = ActionArbreSolutionSuivanteComplexite
      AutoSize = True
    end
    object ToolButtonArbreSolutionLaPlusTordue: TToolButton
      Left = 375
      Top = 0
      Action = ActionArbreSolutionLaPlusTordue
      AutoSize = True
    end
    object ToolButtonSeparateur4: TToolButton
      Left = 414
      Top = 0
      Width = 8
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButtonAffichageStatistiques: TToolButton
      Left = 422
      Top = 0
      Action = ActionAffichageStatistiques
    end
    object ToolButtonInformationsAide: TToolButton
      Left = 461
      Top = 0
      Action = ActionInformationsAide
    end
  end
  object PanelInformations: TPanel
    Left = 0
    Top = 522
    Width = 518
    Height = 99
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object MemoOptimisationsCalculSaisi: TMemo
      Left = 0
      Top = 0
      Width = 518
      Height = 80
      Hint = 
        'Optimisations du calcul saisi dans le tableau en vue de le reche' +
        'rcher parmi les solutions trouv'#233'es'
      Align = alClient
      ParentShowHint = False
      ReadOnly = True
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
    object StatusBar: TStatusBar
      Left = 0
      Top = 80
      Width = 518
      Height = 19
      Panels = <>
    end
  end
  object MainMenu: TMainMenu
    Left = 408
    Top = 96
    object MenuItemPartie: TMenuItem
      Caption = '&Compte'
      object MenuItemCompteNouveau: TMenuItem
        Caption = '&Nouveau...'
        object MenuItemCompteNouveauTirerAuSort: TMenuItem
          Action = ActionCompteNouveauTirerAuSort
        end
        object MenuItemCompteNouveauProposer: TMenuItem
          Action = ActionCompteNouveauProposer
        end
        object MenuItemSeparateurA: TMenuItem
          Caption = '-'
        end
        object MenuItemSaisieAutomatiqueCompteNouveau: TMenuItem
          Action = ActionSaisieAutomatique
          AutoCheck = True
        end
      end
      object MenuItemSeparateur5: TMenuItem
        Caption = '-'
      end
      object MenuItemCompteCalculerSolutions: TMenuItem
        Action = ActionCompteCalculerSolutions
      end
      object MenuItemCompteChercherSaisirSolution: TMenuItem
        Action = ActionCompteChercherSaisirSolution
      end
      object MenuItemSeparateur6: TMenuItem
        Caption = '-'
      end
      object MenuItemCompteQuitter: TMenuItem
        Action = ActionCompteQuitter
      end
    end
    object MenuItemAffichage: TMenuItem
      Caption = '&Affichage'
      object MenuItemAffichageTableau: TMenuItem
        Action = ActionAffichageTableau
      end
      object MenuItemPaveNumerique: TMenuItem
        Caption = '&Pav'#233' num'#233'rique'
        Enabled = False
        Hint = '|Indique si le pav'#233' num'#233'rique est affich'#233' ou non'
        ShortCut = 24656
        OnClick = MenuItemPaveNumeriqueClick
      end
      object MenuItemStatistiques: TMenuItem
        Action = ActionAffichageStatistiques
      end
      object MenuItemSeparateur8: TMenuItem
        Caption = '-'
      end
      object MenuItemEffacerSolutions: TMenuItem
        Action = ActionAffichageEffacerSolutions
      end
    end
    object MenuItemParametres: TMenuItem
      Caption = '&Param'#232'tres'
      object MenuItemOptimisations: TMenuItem
        Caption = '&Optimisations de recherche'
        object MenuItemOptimisation1: TMenuItem
          AutoCheck = True
          Caption = 'Pas de &multiplication/division par 1'
          Checked = True
          Hint = 
            '|a x 1 ou a / 1 interdit car donne un op'#233'rande comme r'#233'sultat ce' +
            ' qui est inutile'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemOptimisation2: TMenuItem
          AutoCheck = True
          Caption = 
            'Pas de r'#233'sultat de m'#234'me &type d'#39'op'#233'ration que celle dont l'#39'un de' +
            's op'#233'randes est un r'#233'sultat'
          Checked = True
          Hint = '|[a * (b *c)] interdit car '#233'quivalent '#224' [a * b * c].'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemOptimisation3: TMenuItem
          AutoCheck = True
          Caption = 'Pas de &r'#233'sultat '#233'gal '#224' un des op'#233'randes'
          Checked = True
          Hint = 
            '|[a * ... = a] interdit car on obtient comme r'#233'sultat un op'#233'rand' +
            'e utilis'#233' dans l'#39'op'#233'ration ce qui est inutile.'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemOptimisation4: TMenuItem
          AutoCheck = True
          Caption = 'Pas d'#39'&op'#233'randes oppos'#233's ou inverses dans une m'#234'me op'#233'ration'
          Checked = True
          Hint = '|[a + ... - a] ou [a x ... / a] interdits car inutiles.'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemOptimisation5: TMenuItem
          AutoCheck = True
          Caption = 'Pas de r'#233'sultat &interm'#233'diaire '#233'gal au compte'
          Checked = True
          Hint = '|[a * b = x] ... [c * d = x] interdit car inutile.'
          OnClick = MenuItemAutoCheckClick
        end
      end
      object MenuItemPropositionCompte: TMenuItem
        Caption = '&Entr'#233'e d'#39'une proposition'
        object MenuItemNombreLimiteExemplairesPlaques: TMenuItem
          AutoCheck = True
          Caption = '&Nombre limit'#233' d'#39'exemplaires de plaques'
          Checked = True
          Hint = 
            '|Interdit/Autorise d'#39'utiliser plus de 2 exemplaires de 1 '#224' 10 et' +
            ' plus d'#39'1 exemplaire de 25, 50, 75 et 100'
          OnClick = MenuItemAutoCheckClick
        end
      end
      object MenuItemEntrees: TMenuItem
        Caption = 'Saisie du &calcul'
        object MenuItemCalculerResultat: TMenuItem
          AutoCheck = True
          Caption = '&Calculer automatiquement le r'#233'sultat des op'#233'rations'
          Checked = True
          Hint = 
            '|Calcule automatiquement ou pas le r'#233'sultat des op'#233'rations saisi' +
            'es'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemRetourArriereAutorise: TMenuItem
          AutoCheck = True
          Caption = '&Retour arri'#232're autoris'#233
          Checked = True
          Hint = 
            '|Autorise/Interdit de revenir en arri'#232're pendant la saisie du ca' +
            'lcul'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemSeparateur7: TMenuItem
          Caption = '-'
        end
        object MenuItemTempsReflexionSaisie: TMenuItem
          Caption = 'Temps de r'#233'flexion et de saisie'
          object MenuItemIllimite: TMenuItem
            Caption = '&Illimit'#233
            Hint = '|Aucune limite de temps de r'#233'flexion et de saisie des calculs'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
          object MenuItem3Minutes: TMenuItem
            Tag = 180
            Caption = '&3 minutes'
            Hint = '|Temps de r'#233'flexion et de saisie limit'#233' '#224' 3 minutes'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
          object MenuItem2Minutes: TMenuItem
            Tag = 120
            Caption = '&2 minutes'
            Hint = '|Temps de r'#233'flexion et de saisie limit'#233' '#224' 2 minutes'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
          object MenuItem1Minute: TMenuItem
            Tag = 60
            Caption = '&1 minute'
            Hint = '|Temps de r'#233'flexion et de saisie limit'#233' '#224' 1 minute'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
          object MenuItem45Secondes: TMenuItem
            Tag = 45
            Caption = '&45 secondes'
            Checked = True
            Hint = '|Temps de r'#233'flexion et de saisie limit'#233' '#224' 45 secondes'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
          object MenuItem30Secondes: TMenuItem
            Tag = 30
            Caption = '3&0 secondes'
            Hint = '|Temps de r'#233'flexion et de saisie limit'#233' '#224' 30 secondes'
            RadioItem = True
            OnClick = MenuItemTempsReflexionSaisieClick
          end
        end
        object MenuItemArreterSaisieFinTempsImparti: TMenuItem
          AutoCheck = True
          Caption = 'Arr'#234'ter la saisie '#224' la fin du temps imparti'
          Checked = True
          Hint = '|La saisie du calcul doit se faire pendant le temps limit'#233
          OnClick = MenuItemAutoCheckClick
        end
      end
      object MenuItemSorties: TMenuItem
        Caption = '&Sortie des r'#233'sultats'
        object MenuItemEcranTypeListe: TMenuItem
          AutoCheck = True
          Caption = 'Ecran > Type &Liste (par ordre alphab'#233'tique)'
          Checked = True
          Enabled = False
          Hint = 
            '|Les solutions sont toujours affich'#233'es dans la liste situ'#233'e '#224' dr' +
            'oite de la zone arborescente'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemEcranTypeArbre: TMenuItem
          AutoCheck = True
          Caption = 'Ecran > Type &Arbre (par ordre de complexit'#233')'
          Checked = True
          Hint = 
            '|Affiche ou non les solutions par ordre de complexit'#233' sous forme' +
            ' arborescente'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemSeparateur1: TMenuItem
          Caption = '-'
        end
        object MenuItemFichierTypeEnonce: TMenuItem
          AutoCheck = True
          Caption = 'Fichier > Type &Enonc'#233
          Hint = 
            '|Stocke les solutions telles qu'#39'elles aparaissent dans la liste,' +
            ' dans un fichier puis l'#39'affiche dans le bloc-notes'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemFichierTypeProfondeur: TMenuItem
          AutoCheck = True
          Caption = 'Fichier > Type &Profondeur'
          Hint = 
            '|Stocke les solutions en profondeur, sous forme de listes imbriq' +
            'u'#233'es du type (op'#233'rateur op'#233'randes), dans un fichier puis l'#39'affic' +
            'he'
          OnClick = MenuItemAutoCheckClick
        end
        object MenuItemSeparateur9: TMenuItem
          Caption = '-'
        end
        object MenuItemEntreeAfficherInfosOptimisationApresSaisie: TMenuItem
          AutoCheck = True
          Caption = 
            'Afficher les informations d'#39'optimisation apr'#232's saisie d'#39'un calcu' +
            'l'
          Checked = True
          Hint = 
            '|Affiche/Masque les optimisations du calcul saisi en dessous des' +
            ' solutions'
          OnClick = MenuItemAutoCheckClick
        end
      end
      object MenuItemSaisieAutomatiqueParametres: TMenuItem
        Action = ActionSaisieAutomatique
        AutoCheck = True
      end
      object MenuItemSeparateur4: TMenuItem
        Caption = '-'
      end
      object MenuItemRetablirParametreParDefaut: TMenuItem
        Action = ActionParametresRetablirParametresDefaut
      end
    end
    object MenuItemInfos: TMenuItem
      Caption = '&?'
      object MenuItemAPropos: TMenuItem
        Action = ActionInformationsAPropos
      end
      object MenuItemAide: TMenuItem
        Action = ActionInformationsAide
      end
    end
  end
  object PopupMenuArbre: TPopupMenu
    Left = 56
    Top = 97
    object MenuItemToutDevelopper: TMenuItem
      Caption = 'Tout &D'#233'velopper depuis ce niveau'
      ShortCut = 16452
      OnClick = MenuItemToutDevelopperClick
    end
    object MenuItemToutReduire: TMenuItem
      Caption = 'Tout &R'#233'duire depuis ce niveau'
      ShortCut = 16466
      OnClick = MenuItemToutReduireClick
    end
    object MenuItemSeparateur2: TMenuItem
      Caption = '-'
      ShortCut = 13
    end
    object MenuItemPremiereSolutionComplexite: TMenuItem
      Action = ActionArbreSolutionLaPlusSimple
    end
    object MenuItemSolutionPrecedenteComplexite: TMenuItem
      Action = ActionArbreSolutionPrecedenteComplexite
    end
    object MenuItemSolutionSuivanteComplexite: TMenuItem
      Action = ActionArbreSolutionSuivanteComplexite
    end
    object MenuItemDerniereSolutionComplexite: TMenuItem
      Action = ActionArbreSolutionLaPlusTordue
    end
    object MenuItemSeparateur3: TMenuItem
      Caption = '-'
    end
    object MenuItemPremiereSolutionChrono: TMenuItem
      Caption = 'Premi'#232're Solution Trouv'#233'e'
      ShortCut = 16417
      OnClick = MenuItemPremiereSolutionChronoClick
    end
    object MenuItemSolutionPrecedenteChrono: TMenuItem
      Caption = 'Solution Pr'#233'c'#233'dente (dans le temps)'
      ShortCut = 16421
      OnClick = MenuItemSolutionPrecedenteChronoClick
    end
    object MenuItemSolutionSuivanteChrono: TMenuItem
      Caption = 'Solution Suivante (dans le temps)'
      ShortCut = 16423
      OnClick = MenuItemSolutionSuivanteChronoClick
    end
    object MenuItemDerniereSolutionChrono: TMenuItem
      Caption = 'Derni'#232're Solution Trouv'#233'e'
      ShortCut = 16418
      OnClick = MenuItemDerniereSolutionChronoClick
    end
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 312
    Top = 272
  end
  object PopupMenuListe: TPopupMenu
    Left = 312
    Top = 97
    object MenuItemAfficherSolutionDansArbre: TMenuItem
      Caption = 'Afficher la solution dans l'#39'arbre'
      ShortCut = 13
      OnClick = ListBoxDblClick
    end
  end
  object ImageListArbre: TImageList
    DrawingStyle = dsTransparent
    Left = 144
    Top = 97
    Bitmap = {
      494C0101110013000C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEF0F000FDD6D600FAC4C400FAC5C500FDD9D900FFF3F3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEEE
      EE00FAA3A300E5505000D62F2F00CA151500CA151500D7323200E7545400FAA9
      A900FEF4F4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDD9D900EC65
      6500C8121200C0000000C0000000C0000000C0000000C0000000C0000000C913
      1300EF727200FDE3E30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDEAEA00EA606000C204
      0400C0000000C0000000E69B9B000000000000000000E9A7A700C0000000C000
      0000C4080800F0747400FEF5F500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFE00F6939300C40A0A00C000
      0000C0000000C0000000C00000000000000000000000C0000000C0000000C000
      0000C0000000CC181800FBAEAE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEE5E500E0444400C0000000C000
      0000C0000000C0000000C00000000000000000000000C0000000C0000000C000
      0000C0000000C0000000E8585800FFF3F3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDC4C400CF1F1F00C0000000C000
      0000C0000000C0000000C00000000000000000000000C0000000C0000000C000
      0000C0000000C0000000D7323200FDD5D5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAB1B100C4090900C0000000C000
      0000C0000000C0000000C00000000000000000000000C0000000C0000000C000
      0000C0000000C0000000CB171700FCC0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAADAD00C4080800C0000000C000
      0000C0000000C0000000CC3232000000000000000000C0000000C0000000C000
      0000C0000000C0000000CA151500FBBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCC1C100CD1B1B00C0000000C000
      0000C0000000C0000000DF7F7F00DF7F7F00DF7E7E00C0000000C0000000C000
      0000C0000000C0000000D62E2E00FCD1D1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEE1E100DE3F3F00C0000000C000
      0000C0000000C0000000C2090900DC717100CE3B3B00C0000000C0000000C000
      0000C0000000C0000000E5505000FEF0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFDFD00F3878700C3060600C000
      0000C0000000C0000000DC71710000000000FBF1F100C0000000C0000000C000
      0000C0000000C8121200FAA3A300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDE2E200E4505000C001
      0100C0000000C0000000CE3B3B00FBF1F100EAADAD00C0000000C0000000C000
      0000C2040400EC656500FEEEEE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCCDCD00E552
      5200C3070700C0000000C0000000C0000000C0000000C0000000C0000000C40A
      0A00EA606000FDD9D90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDE2
      E200F78F8F00DE414100CB181800C4090900C4090900CD1C1C00E0444400F693
      9300FDEAEA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFDFD00FEE1E100FCC2C200FBAFAF00FAB0B000FCC4C400FEE5E500FFFE
      FE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000486A4D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C5003939390039393900393939003A3A
      3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A
      3A003A3A3A003A3A3A003A3A3A003A3A3A000000000000000000F7FFFF000000
      0000E7EFE7009CA5C600636BCE005252CE005252CE006B6BCE009CA5C600E7EF
      E70000000000F7FFF700000000000000000000000000486A4D00000000000000
      0000000000000000000000000000F7F7F700EFEFEF00DEDEDE00B5BDC1000000
      000000000000000000000000000000000000C6C6C600C6C6C600C5C5C500C5C5
      C500C5C5C500C2C2C200C0C0C000BCBCBC00B8B8B800B2B2B200ABABAB00A4A4
      A400ADADAD00B9B9B900C6C6C600C6C6C60039393900393939003A3A3A003A3A
      3A003A3A3A003D3D3D003F3F3F0043434300474747004D4D4D00545454005B5B
      5B00525252004646460039393900393939000000000000000000F7FFF7009CA5
      C6003942D6003939F7003939F7003139FF003139FF003139FF003939F7003942
      D6009CA5C600F7FFF700000000000000000000000000486A4D00000000000000
      000000000000D4D4D600486A4D0008A0130008A0130000A7050008A01300DEDE
      DE0000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C2C2
      C200C0C0C000BCBCBC00B8B8B800B2B2B200ABABAB00A4A4A4009F9F9F00A0A0
      A0009E9E9E00ADADAD00B9B9B900C6C6C6003939390039393900393939003D3D
      3D003F3F3F0043434300474747004D4D4D00545454005B5B5B00606060005F5F
      5F0061616100525252004646460039393900F7FFF700F7FFF7007B84BD003939
      EF003139FF003139FF003139FF0021219C0018218C003939F7003139FF003139
      FF003939EF007B84BD00F7FFF700F7FFF700000000008D979000E7E7E700F7F7
      F7008D97900008A0130000BD000000BD000000BD000000BD000000BD0000B5BD
      C10000000000000000000000000000000000C2C2C200C0C0C000BCBCBC00B8B8
      B800B2B2B200ABABAB00A4A4A4009F9F9F00A0A0A0009E9E9E00989898009495
      9500919190008F8E8D00ADADAD00B9B9B9003D3D3D003F3F3F00434343004747
      47004D4D4D00545454005B5B5B00606060005F5F5F0061616100676767006B6A
      6A006E6E6F00707172005252520046464600000000009CA5C6003939EF003139
      F7003139FF003139FF003139FF0010104A00080821003939EF003139FF003139
      FF003139FF003939EF009CA5C60000000000000000008D9790000F621B0008A0
      130000BD000000BD000000BD000000BD000000BD000000BD000000BD0000B5BD
      C10000000000000000000000000000000000C1C1C100BDBDBD00B8B8B800B3B3
      B300ADADAD00A6A6A6009D9D9D00969696009292920084828100776F6C006156
      5100453A34003E36310063636200929292003E3E3E0042424200474747004C4C
      4C00525252005959590062626200696969006D6D6D007B7D7E00889093009EA9
      AE00BAC5CB00C1C9CE009C9C9D006D6D6D00E7E7EF003942D6003139FF003939
      F7003139FF003139FF003139FF003939E7003939E7003139FF003139FF003139
      FF003139FF003139FF003942D600E7EFE70000000000B5BDC1000062080000BD
      000000BD000000BD000000BD000000BD000000BD000000BD000000BD0000B5BD
      C10000000000000000000000000000000000B9B9B900B1B1B100A8A8A800A1A1
      A1009B9B9B0094939400837F7D00726964004D453F00352D270026201A001D19
      15001D181500231F1A004F4C49006C6C6C00464646004E4E4E00575757005E5E
      5E00646464006B6C6B007C8082008D969B00B2BAC000CAD2D800D9DFE500E2E6
      EA00E2E7EA00DCE0E500B0B3B600939393009CA5C6004242FF004242FF004242
      FF004242FF004242FF004242FF0010184A00080821003942F7004242FF004242
      FF004242FF004242FF003942F7009CA5C60000000000D4D4D6000F621B0000BD
      000000BD000000BD000000BD000000BD000000BD000000BD000000A70500D4D4
      D60000000000000000000000000000000000B4B4B4009FA0A0008F8F8D00807B
      77006C635D004A413A00302B25001D191500181512001D1815001E1A15002924
      20003E39340046423B0039333000717071004B4B4B00605F5F00707072007F84
      8800939CA200B5BEC500CFD4DA00E2E6EA00E7EAED00E2E7EA00E1E5EA00D6DB
      DF00C1C6CB00B9BDC400C6CCCF008E8F8E007373C6005252FF004A52FF004A52
      FF004A52FF004A52FF005252FF0021214200181821004A52EF004A52FF004A52
      FF004A52FF004A52FF004A52FF007373C60000000000EFEFEF000F621B0000BD
      000000BD000000BD000000BD000000BD000000BD000000BD000008A01300E7E7
      E70000000000000000000000000000000000A19F9C00564B4600372D2800251E
      1A00201C170055504E009B969300423F3B0025221E00443E390056514A00615B
      550059534B005C5550003F3A3600747270005E606300A9B4B900C8D2D700DAE1
      E500DFE3E800AAAFB10064696C00BDC0C400DADDE100BBC1C600A9AEB5009EA4
      AA00A6ACB400A3AAAF00C0C5C9008B8D8F006363CE005A63FF005A63FF006363
      FF006363FF006363FF006363FF0031394200313139005A5ADE006363FF006363
      FF006363FF006363FF006363FF006363CE000000000000000000486A4D0000BD
      000000BD000000BD000000BD000000A7050000BD000000BD000008A01300E7E7
      E700000000000000000000000000000000008482800025201B00221E19002923
      1F0036312B004A443F0087848000C6C4C300A2A19E004A4643003F3932004B45
      3E00544E470059514A005D57520083817F007B7D7F00DADFE400DDE1E600D6DC
      E000C9CED400B5BBC000787B7F00393B3C005D5E6100B5B9BC00C0C6CD00B4BA
      C100ABB1B800A6AEB500A2A8AD007C7E8000636BCE006B73F7007373FF007373
      FF007373FF007373FF006B73F7004A4A4A004A4A4A00636BCE007373FF007373
      FF007373FF007373FF007373FF00636BCE000000000000000000486A4D0008A0
      130000BD000000BD000000BD000008A0130008A013008D979000C0C3C6000000
      0000000000000000000000000000000000008B888600595651005F5B54006762
      5B00615B5400554F48004E484300443E3A007D7A7700C5C2C1009F9E9B005450
      4B004E47420067615A0073706B00A09E9D0074777900A6A9AE00A0A4AB00989D
      A4009EA4AB00AAB0B700B1B7BC00BBC1C500828588003A3D3E0060616400ABAF
      B400B1B8BD00989EA5008C8F94005F6162007B7BC6008484FF007B84FF008484
      FF008484FF008484FF007B7BE7005A6363005A636300737BC6008484FF007B84
      FF008484FF008484FF008484FF007B7BC6000000000000000000486A4D0008A0
      130000BD000000BD000000BD00008D9790000000000000000000000000000000
      000000000000000000000000000000000000C1C1C100716C66005E585100615C
      540068645E00635F5A005F5C56005C5651004D4740005D575000A4A4A000DBD9
      D800B7B3B100BDBDBC00C8C8C800C6C6C6003E3E3E008E939900A1A7AE009EA3
      AB00979BA1009CA0A500A0A3A900A3A9AE00B2B8BF00A2A8AF005B5B5F002426
      2700484C4E004242430037373700393939009CA5C6008C8CFF009494FF009494
      FF009494FF009494FF008C8CDE0073737B0073737B00848CC6009494FF009494
      FF009494FF009494FF008C8CFF00A5A5C6000000000000000000486A4D0008A0
      130000BD000000BD000000A70500C0C3C6000000000000000000000000000000
      000000000000000000000000000000000000CECECE009A97940078766E008785
      7D008889830086888200807F7A00908E8900A9A7A300BEBEBD00C6C6C600C7C7
      C700CDCDCD00C8C8C800C7C7C700C6C6C6003131310065686B0087899100787A
      820077767C0079777D007F8085006F71760056585C0041414200393939003838
      380032323200373737003838380039393900E7E7EF007373CE00A5A5FF00A5A5
      FF00A5A5FF00A5A5FF009C9CD6008C8C8C008C8C8C00949CC600A5A5FF00A5A5
      FF00A5A5FF00A5A5FF007373CE00E7EFE70000000000000000008D9790000F62
      1B0000BD000000BD0000486A4D00000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00CECECD00918F8A009193
      8D00ADAFAB00BFBFBE00C6C6C600C6C6C600C5C5C500C5C5C500C6C6C600C7C7
      C700C7C7C700C8C8C800C7C7C700C6C6C60031313100313132006E7075006E6C
      7200525054004040410039393900393939003A3A3A003A3A3A00393939003838
      380038383800373737003838380039393900F7FFF700A5A5C6009C9CEF00B5B5
      FF00B5B5FF00B5B5FF00ADADD600A5A5A500A5A5A500A5ADC600B5B5FF00B5B5
      FF00B5B5FF009C9CEF00A5A5C600F7FFF70000000000000000008D9790000062
      080000BD000008A01300DEDEDE00000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDCD00CDCDCD00CCCCCC00CBCB
      CB00C9C9C900C8C8C800C7C7C700C7C7C700C6C6C600C5C5C500C6C6C600C6C6
      C600C7C7C700C7C7C700C6C6C600C5C5C5003232320032323200333333003434
      340036363600373737003838380038383800393939003A3A3A00393939003939
      39003838380038383800393939003A3A3A00F7FFFF00F7FFF7008C94BD00ADAD
      EF00C6C6FF00C6C6FF00BDC6DE00BDBDC600BDBDC600BDBDD600C6C6FF00C6C6
      FF00ADADEF008C8CBD00F7FFF700000000000000000000000000C0C3C6000062
      0800486A4D00D4D4D60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDCD00CDCDCD00CCCCCC00CBCB
      CB00C9C9C900C8C8C800C7C7C700C7C7C700C6C6C600C5C5C500C6C6C600C6C6
      C600C7C7C700C7C7C700C6C6C600C5C5C5003232320032323200333333003434
      340036363600373737003838380038383800393939003A3A3A00393939003939
      39003838380038383800393939003A3A3A000000000000000000F7FFF700A5A5
      C6008C8CCE00C6CEF700D6D6FF00D6D6FF00D6D6FF00DED6FF00C6CEF7008C8C
      CE00A5A5C600F7FFF70000000000000000000000000000000000D4D4D6008D97
      9000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDCD00CDCDCD00CCCCCC00CBCB
      CB00C9C9C900C8C8C800C7C7C700C7C7C700C6C6C600C5C5C500C6C6C600C6C6
      C600C7C7C700C7C7C700C6C6C600C5C5C5003232320032323200333333003434
      340036363600373737003838380038383800393939003A3A3A00393939003939
      39003838380038383800393939003A3A3A000000000000000000F7FFF700F7FF
      F700E7E7EF00A5A5C6008C8CC6008C8CC6008C8CC6008C8CC600A5A5C600E7E7
      EF00F7FFF700F7FFF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010101000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C889700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004E4E4E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDE000000000000000000DEDE
      DE0000000000D6D6D60000000000525252000000000000000000000000000000
      000000000000000000000000000000000000000000008C889700000000000000
      0000000000000000000000000000F7F7F700F7F7F700DEDEDE00BDB5C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000393939007B7B7B00666666002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00000000008C8C8C000000000000000000000000000000
      000000000000000000000000000000000000000000008C889700000000000000
      000000000000D8D4DA003D248D002900B9002900B9003100C1003100C100DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EBEBEB0031313100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000018181800A2A2A200DEDEDE00FFFFFF00FFFFFF00A2A2A200080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004242420000000000BDBDBD000000000000000000000000000000
      000000000000000000000000000000000000000000008C889700EBEBEB00F7F7
      F700BDB5C6002900B9003100CE003100CE003100CE003100CE003100CE00BDB5
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000212121004E4E4E0031313100EBEBEB004E4E4E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000181818007B7B7B00FFFFFF00666666000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F7000808080008080800F7F7F7000000000000000000000000000000
      000000000000000000000000000000000000000000008C8897003D248D002900
      B9003100CE003100CE003100CE003100CE003100CE003100CE003100CE00BDB5
      C600000000000000000000000000000000000000000000000000000000000000
      000018181800F7F7F700FFFFFF00FFFFFF00FFFFFF00BABABA00181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000066666600FFFFFF004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD000000000042424200000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDB5C600180063003100
      CE003100CE003100CE003100CE003100CE003100CE003100CE003100CE00BDB5
      C600000000000000000000000000000000000000000000000000000000000000
      00003D3D3D00EBEBEB004E4E4E003D3D3D00CECECE00D6D6D600BABABA000808
      0800000000000000000000000000000000000000000000000000000000000000
      00000000000000000000080808008C8C8C00F7F7F7007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B00000000008C8C8C00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CACACE00180063003100
      CE003100CE003100CE003100CE003100CE003100CE003100CE003100C100CACA
      CE00000000000000000000000000000000000000000000000000000000000000
      000029292900CECECE000000000000000000BABABA00CECECE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000010101000BDBDBD00BDBDBD002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001818180000000000D6D6D600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EBEBEB00180063003100
      CE003100CE003100CE003100CE003100CE003100CE003100CE002900B900EBEB
      EB00000000000000000000000000000000000000000000000000000000000000
      000008080800F7F7F70008080800000000007F7F7F00F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A2A2A2008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F700313131009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000180063003100
      CE003100CE003100CE003100CE003100C1003100CE003100CE002900B900EBEB
      EB00000000000000000000000000000000000000000000000000000000000000
      000000000000D6D6D6004E4E4E00000000004E4E4E00FFFFFF00292929000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0008080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD0000000000DEDEDE000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D248D002900
      B9003100CE003100CE003100CE002900B9002900B9008C889700C0BDCB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BABABA00BABABA000000000021212100EBEBEB003D3D3D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE0042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7F7F700000000006B6B6B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8897002900
      B9003100CE003100CE003100CE008C8897000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F00F7F7F700101010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00F7F7F700BDBDBD008C8C8C0066666600080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000212121000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8897003D24
      8D003100CE003100CE003100C100C0BDCB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004E4E4E00FFFFFF004E4E4E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000018181800DEDEDE00FFFFFF00FFFFFF00FFFFFF00BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6D6D60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8897002608
      7E003100CE003100CE003D248D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000008080800CECECE00BABABA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000008080800292929000000
      000000000000000000000000000000000000DEDEDE000000000000000000F7F7
      F700EFEFEF004A4A4A0000000000424242000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8897001B00
      80003100CE002900B900D8D4DA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000008080800292929000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000031313100DEDEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0BDCB001800
      63003D248D00D8D4DA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D8D4DA008C88
      9700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      84000000000000000000000000003B3B3B007373730018181800000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      00000000000000000000000000004A4A4A004242420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000353535006F6F6F006F6F6F004242420018181800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000083838300B1B1B100626262000808080000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000003B3B3B00DEDEDE00FFFFFF00FFFFFF00EFEFEF00181818000000
      0000008484000084840000848400008484000000000000000000000000000000
      000000000000000000000000000029292900E7E7E70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7A7A7000808
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000808080083838300FFFFFF00DADADA0039393900000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      840008080800EFEFEF00FFFFFF0084848400F7F7F700FFFFFF00BDBDBD000000
      0000008484000084840000848400008484000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0035353500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000089898900F7F7F7005252520042424200424242004A4A4A000808
      0800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000039393900DADADA00F7F7F700525252000000
      0000000000000000000000000000000000000084840000848400008484000084
      84003B3B3B00FFFFFF00FFFFFF000000000073737300FFFFFF00F7F7F7000808
      0800008484000084840000848400008484000000000000000000000000000000
      000000000000000000000000000000000000CDCDCD0073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000008080800D2D2D2006F6F6F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000008080800DADADA00EBEBEB000000
      0000000000000000000000000000000000000084840000848400008484000084
      84003B3B3B00FFFFFF00FFFFFF00181818003B3B3B00FFFFFF00FFFFFF003B3B
      3B00008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000008E8E8E00CDCDCD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000018181800EFEFEF003535350000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000052525200B1B1B100F7F7F700B1B1B1000000
      0000000000000000000000000000000000000084840000848400008484000084
      840018181800FFFFFF00FFFFFF00DEDEDE00DEDEDE00FFFFFF00F7F7F7001818
      1800008484000084840000848400008484000000000000000000000000000000
      00000000000000000000000000000000000073737300E7E7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A00D2D2D20010101000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000046464600FFFFFF00DADADA0052525200000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      840000000000DEDEDE00FFFFFF00FFFFFF00FFFFFF00EFEFEF005A5A5A000000
      0000008484000084840000848400008484000000000000000000000000000000
      00000000000073737300353535000000000062626200FFFFFF00101010000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000089898900A7A7A700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DADADA008383830000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000008C8C8C00FFFFFF00DEDEDE003B3B3B0008080800000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      00000000000018181800CDCDCD003535350042424200FFFFFF00353535000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000008080800D2D2D2004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000029292900EBEBEB0031313100000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      84000000000018181800F7F7F700FFFFFF006363630000000000000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      0000000000000000000042424200EFEFEF008E8E8E00FFFFFF00525252000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F6F6F0000000000000000000000000089898900A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000062626200DADADA00080808000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000084848400FFFFFF00EFEFEF0018181800000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      000000000000000000000000000062626200FFFFFF00FFFFFF00737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D2D2D200A7A7A700525252006F6F6F00EFEFEF00A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000062626200DADADA008383830046464600EBEBEB00838383000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000008080800DEDEDE00FFFFFF0094949400000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      00000000000000000000000000000000000073737300FFFFFF00737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A700FFFFFF00FFFFFF00FFFFFF00F7F7F7004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000021212100EBEBEB00FFFFFF00FFFFFF00FFFFFF00DADADA000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000000000000181818005A5A5A0000000000000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000052525200181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005A5A5A00898989006F6F6F0018181800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010101000525252008383830083838300313131000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000024242400000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000063636300525252000808080000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000006B6B6B00B5B5B5005E5E5E000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000008C8C8C00636363000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000088888800FFFFFF00EFEFEF00D6D6D600D6D6D600AFAFAF004141
      4100008484000084840000848400008484000084840000848400008484000084
      84000000000063636300FFFFFF00FFFFFF00E7E7E70052525200000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000000000000000000000F7F7F700FFFFFF005E5E5E000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000005A5A5A00FFFFFF00FFFFFF00DEDEDE005A5A5A00000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004141
      4100008484000084840000848400008484000084840000848400008484000084
      840000000000DEDEDE00DEDEDE00FFFFFF00FFFFFF00FFFFFF00777777000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000000000000008080800FFFFFF00FFFFFF005E5E5E000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000063636300E7E7E700FFFFFF00FFFFFF00FFFFFF00737373000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000024242400F7F7F700FFFFFF00D6D6D60088888800414141000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000008080800000000002A2A2A00D6D6D600FFFFFF00F7F7F7000000
      0000008484000084840000848400008484000084840000848400008484000084
      840035353500CACACA00E7E7E700CACACA00FFFFFF00FFFFFF00D6D6D6005E5E
      5E00008484000084840000848400008484000084840000848400008484000084
      84000000000000000000000000005A5A5A00E7E7E700FFFFFF00E7E7E7000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000007B7B7B00FFFFFF00EFEFEF0024242400000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000808080052525200000000006B6B6B00FFFFFF00DEDEDE000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400B5B5B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007373
      7300008484000084840000848400008484000084840000848400008484000084
      840000000000141414003939390008080800B5B5B500FFFFFF00EFEFEF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000008080800D6D6D600FFFFFF00D6D6D600000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000009C9C9C00FFFFFF00F7F7F700FFFFFF00E7E7E700525252000000
      0000008484000084840000848400008484000084840000848400008484000084
      84005E5E5E00FFFFFF00B5B5B5005E5E5E00CACACA00FFFFFF00B5B5B5000808
      0800008484000084840000848400008484000084840000848400008484000084
      840000000000DEDEDE00FFFFFF00EFEFEF00FFFFFF00FFFFFF00737373000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000525252000808080052525200FFFFFF00FFFFFF00737373000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000084848400EFEFEF00FFFFFF00FFFFFF0052525200000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840008080800F7F7F700F7F7F70035353500BDBDBD00FFFFFF007B7B7B000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000DEDEDE00FFFFFF00EFEFEF009494940039393900000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840041414100F7F7F700AFAFAF0000000000D6D6D600FFFFFF00DEDEDE000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000002A2A2A00D6D6D600FFFFFF00E7E7E700080808000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000009C9C9C00FFFFFF009C9C9C00CACACA00FFFFFF007B7B7B000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000094949400FFFFFF00B5B5B5000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840041414100FFFFFF00FFFFFF008888880052525200FFFFFF00FFFFFF000808
      0800008484000084840000848400008484000084840000848400008484000084
      8400000000009C9C9C008484840008080800E7E7E700FFFFFF00777777000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000035353500FFFFFF00FFFFFF00F7F7F700FFFFFF007B7B7B000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000005A5A5A00FFFFFF00E7E7E7008C8C8C0073737300141414000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000088888800FFFFFF00FFFFFF00DEDEDE00FFFFFF00D6D6D6000000
      0000008484000084840000848400008484000084840000848400008484000084
      84002A2A2A00FFFFFF00FFFFFF00D6D6D600D6D6D600FFFFFF00525252000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000000000000B5B5B500FFFFFF00FFFFFF00FFFFFF009C9C9C000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000005A5A5A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C8C8C8000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000088888800FFFFFF00FFFFFF00E7E7E700242424000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000084848400F7F7F700FFFFFF00FFFFFF0084848400000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000035353500FFFFFF00FFFFFF00FFFFFF009C9C9C000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000008C8C8C00DEDEDE00EFEFEF00FFFFFF00FFFFFF00636363000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000414141007373730024242400000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      840000000000000000002A2A2A00777777005252520000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000000000000000000000000005E5E5E006B6B6B0035353500000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000001414140039393900000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      840000848400008484000084840000848400424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00F81F000000000000E007000000000000
      C003000000000000818100000000000001810000000000000180000000000000
      0180000000000000018000000000000001800000000000000000000000000000
      000000000000000001010000000000008001000000000000C003000000000000
      E007000000000000F00F000000000000BFFF00000000D00BBE1F00000000C003
      B80F000000000000800F000000008001800F000000000000800F000000000000
      800F000000000000800F000000000000C00F000000000000C01F000000000000
      C0FF000000000000C0FF000000000000C1FF000000000000C1FF000000000001
      C3FF00000000C003CFFF00000000C003000000000CFFBFFF0000000008FFBE1F
      0000000098FFB80F0000000098FF800F000000009081800F000000009181800F
      0000000091FF800F0000000091FF800F000000009181C00F000000009881C01F
      0000000098FFC0FF000000009CFFC0FF0000000098FFC1FF0000000000FFC1FF
      0000000000FFC3FF00000000FFFFCFFF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ImageListBoutons: TImageList
    Height = 32
    Width = 32
    Left = 408
    Top = 208
    Bitmap = {
      494C01010C000E000C0020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000008000000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00FAFEFD00FDFEFC00F5FDFD00FBFDFE00FCFBFD00FBFCFD00FAFCFB00FEF9
      F800F6E0DA00E5B2B300E9989D00DB908F00DB908F00E39B9B00E1B5B200F6E2
      DD00FEFAF900FBFBFA00FAFCFC00FCFBFD00FAFEFE00F2FEFE00FBFEFE00FBFD
      FE00FEFEFF0000000000000000000000000000000000E7FFE700FFFFFF00EFDE
      E200F7EFF700DEDEDE00E7EFD600E7EFD600E7DEDE00EFE7E700E2EBDE00D6DE
      DE00ECE9F100FFF7FF00FFEFFF00FFFFFF00FFFFF700F7FFEF00EFFFFF00EFF7
      FF00EFEFFF00C8C0F700ADB1F300EFEFFF00E7EFFF00F7FFFF00F7FFF700F7F7
      F700EFF7FF00F7F7FF00F7E7FF00FFEFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00FCFEFE00F6FEFE00F7FCFE00FEFBFE00FBFCFA00F2DDDA00D6797900BD2E
      3000B6050700BF010400B5020300C2030200C0020200BA040300C2010300B405
      0700BF323300D97E7E00F3E1DE00F9FCFA00FDFDFE00F9FEFE00F8FEFE00F8FE
      FE00FEFFFF00000000000000000000000000A5CEA000E7FFE700FFFFFF00FFF7
      FF00DEDEDE00F7F7FF00FFFFF700FFFFF700FFFFFF00FFF7FF00F7FFF700EFFF
      F700F7FFFF00FFF7FF00F7EFF700FFF7F700FFFFF700F7FFEF00EFFFF700EFFF
      FF00EFEFFF007B73B500413F96009C94EF00DEE7FF00F7F7FF00F7F7FF00E7E7
      FF00D2DEFF00868CDE00A799FC00A58CF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFE00FBFCFE00F8FCFC00F6E4E100CD656600BD0C1200C6000200BF02
      0000BE020000C0010000BD030200B4030400B6010300BA020100BE020000C001
      0000BE010000C5000300BD0F1400D16D6D00F6EAE300F8FBF900FCFDFE00FBFE
      FE00FEFFFF0000000000000000000000000075D07E00D6FFD600F7FFF700FFF7
      FF00DEE7F700EFEFFF00FFF7FF00FFF7FF00FFEFF700FFF7FF00FFFFFF00EFF7
      EF00EFF7FF00F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFF7EF00EFF7FF00EFF7
      FF00DEDEFF00544EC3002D18B9002D18B900ADB1F300E7DEFF00DEDEFF007B7B
      F7001018AD00020AC500100DCB001810D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002121
      2100000000000000000000000000000000000000000000000000000000000000
      0000ADADAD008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFFFF00FEFFFF00FEFFFF00FEFF
      FF00FAFEFD00FBFDFC00E8B3B000BA1C1C00C1040300BD050400BD000000C200
      0000C3010100BC040500D58A8700FBEDEB00FAEDED00D48C8900BB040500BF00
      0200C3000100BD000000BA030100BF040200BD222000ECBDBA00FAFDFD00FEFE
      FE00FFFEFF00FEFFFF00FEFFFF00FEFFFF004EB95200B5FFB900DEFFE700E7F7
      EF00DEE7F700EFF7FF00FFF7FF00FFF7FF00FFF7FF00FFF7FF00F7FFF700EFFF
      EF00EFFFF700E7FFF700E7FFF700F7FFFF00FFF7F700FFF7FF00EFF7F700E7EF
      FF00DEDEFF001818AD002110D6003528E200C0AFF7007B73B5002031A4001018
      AD00081CD6000010D6000810CE00100DCB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A5A5A00000000006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000008080800D6D6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FEFE00FEFDFE00F9FEFE00FDFD
      FE00F9F8F600DE8C8800B6060500C0010100C0000000C0000000BF000000C100
      0000C0010000CA5F5D00FEFDFD00FDFEFD00FDFEFE00FEFCFD00CB5F5D00C102
      0000C1000000BF000000C0000000C0000000BE010100B40A0900E0969400FCFA
      F900FEFDFE00FBFEFE00F8FEFE00FBFDFE001EC523008EFB8C00CEFFCE00DEFF
      E70000000000E7FFEF00EFF7F700FFF7F700FFF7F700FFFFF700F7FFF700E7FF
      E700EFFFEF00E7FFEF00EFFFEF00EFF7F700F7EFFF00FFF7FF00EFF7EF00DEE7
      FF009CA5FF001416A200181CC1007B7BF700E7E7FF00DEE7FF00202E94002031
      A4000829A9002031C300899AF700B9CAFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5000808080000000000080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004242420000000000000000002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFEFE00F7FEFE00FBFDFE00FDFD
      FD00DD8A8700C1020600C5010100BD010200BF000000C0000000C0000000BF00
      0000BC010000D96F6D00F7FEFE00FDFEFF00FDFDFF00F7FDFE00DA706E00BC02
      0100C0000000C0000000C0000000BF000000BD010100C1010100BC040800DF96
      9300FAFDFD00FCFDFE00F8FEFE00FBFEFE004CD44C0031B535004EB9520075D0
      7E009CE7A500CEFFD600E7FFEF00EFF7EF00FFE7E700FFF7F700F7FFF700DEFF
      DE00DEFFDE00BDEFBD00CEFFCE00EFFFEF00F7FFFF00EFEFFF00EFFFF700E7F7
      FF005263D6002031C3002031A4009CA5FF00EFF7FF00EFF7FF00D2DEFF004554
      C300899AF700D6EFFF00E7EFFF00EFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010101000000000000000000000000000181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000080808007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7FEFE00F6FEFE00F9FCF900E7AF
      AE00B6050500C5010100BD000000BD000100C0000000C0000000C0000000C000
      0000C3010100B7121300ECC4C500FCFDF800FBFDF700ECC6C700B7121300C201
      0200C0000000C0000000C0000000BF000000BF000000BE000000C3010100B40A
      0800EBBCB900F8FBF900F9FDFE00F2FEFE00B5FFB90067BD660046C64C0046C6
      4C0046C64C004EB952009CE7A500E7FFE700FFFFFF00FFEFFF00FFF7FF00EFFF
      EF00CEFFCE0060BD5A006FC56700D6FFD600EFFFEF00F7FFFF00EFFFF700DEF7
      FC002942D6000515C5001416A200E7E7FF00EFE7FF00FFF7FF00FFEFFF00EFE7
      FF00F7F7FF00F7F7FF00ECE9F100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A000808080000000000000000000000000000000000CECECE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000008080800000000000000000000000000000000000808
      0800CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFDFE00FBFDFE00F6E1DB00B819
      1800BF010000BE010200BD000100BF000000C0000000C0000000C0000000C000
      0000C1020100BF020000B5040700BD343300BE353300B4040700BE030000C001
      0100BF000000C0000000C0000000C0000000BF010000C2000000C2010100C001
      0100BD222100F7EAE300FDFDFE00FAFDFE00EFFFE700D6FFD600ADFBAD008EFB
      8C006DD26B005ECA5E0046AD4E009CE7A500E7F7DE00FFFFFF00FFFFFF00DEFF
      DE00ADFBAD0046C64C0033C335006DD26B00DEFFDE00EFFFF700E7F7EF00D2DE
      FF001014BD000515C5004554C300DEE7FF00EFFFFF00FFFFFF00FFF7FF00FFEF
      FF00FFF7EF00FFFFF700FFF7F700FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5000808
      0800000000000000000000000000000000000000000008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A500000000000000000000000000000000000000
      0000000000002929290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFCFC00FEFCFC00CB605A00C103
      0200C1000000BF000000BF000000C0000000C0000000C0000000C0000000C000
      0000C0010000C1000400C0030000C5020100C2020200BE020200BE000000C100
      0000BF000000C0000000C0000000C0000000C0000000C0000000BF000000C000
      0000C0030100D26E6E00FAFDFA00FBFBFC00EFFFEF00DEFFDE00E7FFEF00E7FF
      E700DEF7D600DEFFDE00B5FFB90060BD5A0075D07E00D6FFDE00EFFFF700DEFF
      E70067EB6F0031D3330039D6390029B531008EDE9700E7FFE700E7FFF700A2AD
      F400100DCB001818CE00868CDE00DEF7FC00C5F9CB00A5CEA000E7F7EF00FFF7
      F700FFFFEF00FFF7EF00F7EFF700EFEFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010101000000000000000
      000000000000000000000000000000000000000000006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000080808000000000000000000000000000000
      00000000000000000000080808006B6B6B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFCFC00F5D6D400B8090A00BE01
      0200C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C1000000BE010000BF040400C8555800B92A2700C1020300C2000000BF01
      0000BF000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000BD030200BC0D1200F5E2DF00F9FAFB00F7F7F700F7F7F700FFF7FF00FFFF
      FF00E7DEDE00EFF7E700D6FFE7005DC86B004CD44C0096FD9E00D6FFDE00CEFF
      CE0039D639001EEC2B0023D3260058F15A004EB95200C5F9CB00D6EFFF007B73
      D6002110D6000800BD00B9CAFF00D6FFE7005DC86B0046AD4E009CE7A500E7FF
      DE00EFF7E700FFFFF700F7F7FF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000424242000000000000000000000000000000
      0000000000000000000000000000000000000808080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000424242000000000000000000000000000000
      00000000000000000000000000000000000008080800C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFBFB00D56F6B00C4000200BE00
      0000BF000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000BD010000C0010000CE696900FCF9F700BD353300C0010200C2000000BF01
      0000BF000000C0000000C0000000C0000000C0000000C0000000C0000000BF00
      0000BD000000C4000200D97E7E00FCFCFB00FFEFFF00FFF7FF00FFEFFF00FFFF
      FF00E2EBDE00DEF7E700E7FFEF009CE7A50035C6460058F15A00CEFFCE008EFB
      8C0010E7210010F71C0033C3350096FD9E006DD26B0075D07E00D6EFFF004736
      BA002110DE001014BD00C6FFFF0075F1860023DB31001EEC2B0033C3350099F4
      A700E7FFEF00F7FFFF00EFFFEF00DEF7D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50008080800000000000000000000000000000000000000
      0000000000000000000000000000000000002121210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000212121000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEF5F600BC251F00C0000100BF00
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000BF00
      0000C2000000B6010200F7E3E600E4C5C700BB030300BF020100BE000000C100
      0000BF000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C2000000BD020000BF313200FDFAF900FFF7FF00FFEFFF00FFF7FF00F7F7
      F700E2EBDE00E7F7EF00EFF7F700D6FFDE0046C64C003EDE3F00A9FFA5004CD4
      4C0010F71C000DEC150046C64C00CEFFCE00B5FFB90067BD66009CCEE700202E
      94001014BD004554C30096F9B90031D3330010F71C000DEC150023D326005ECA
      5E00DEFFE700E7FFEF00E7FFE700A5CEA0000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD00080808007373730084848400000000000000000000000000000000000000
      0000CECECE00737373000000000000000000D6D6D60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000101010000000000000000000EFEF
      EF00313131000000000000000000000000000000000000000000BDBDBD000000
      0000393939000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECCECE00BE040400BE010000BF00
      0100C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000BF000000BA010100FCF4F200F3E3E400B0090700C4030300C1000000C000
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C0010000BF000000BC040600F5DFDD00FFFFF700F7FFEF00FFFFF700F7FF
      EF00DEE7D600F7F7EF00FFF7F700EFFFE70067EB6F0039D6390058F15A002BE4
      2F000CF710001EEC2B008EDE9700EFFFEF00E7FFDE009CE7A5001A6673001435
      8800143588003D94A8003FDE570022E61E0010E7210018DA1C0096FD9E0067BD
      6600B5F7B300DEFFDE00CEFFD60067BD66000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000393939000000
      0000EFEFEF00FFFFFF00FFFFFF00CECECE00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0010101000080808000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADADAD0000000000EFEFEF00FFFF
      FF00FFFFFF009C9C9C00000000000000000021212100FFFFFF00FFFFFF00FFFF
      FF002121210008080800BDBDBD00000000000000000000000000000000000000
      000000000000000000000000000000000000E29DA000BB020200C1000100C000
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000BF00
      0000BE000000B7010100E1B2B100FDFCFD00D5888800B9020300B6030000C000
      0000BF000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C0010000C3000100BA020300E6ADAF00EFFFF700EFFFEF00F7FFF700F7FF
      F700DEE7D600FFFFF700FFF7FF00F7FFEF00ADFBAD0033C3350023D3260022E6
      1E000DEC150031D33300CEFFCE00FFFFF700EFFFEF00E7FFF7003D94A8003D94
      A8001A6673003EAA680029DE3C0022E61E0023DB310075F18600C6FFD600B5F7
      B30067BD6600CEFFCE0096FD9E0041B95E000000000000000000000000000000
      0000000000000000000000000000000000009494940008080800000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0073737300A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000008080800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009C9C9C0021212100FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00313131000000000000000000181818000000000000000000000000000000
      000000000000000000000000000000000000DF808200BE020100C0000100C000
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000BF000000C1000100C3282900F5EEEB00F9FBF900D3858300C1030600C001
      0100C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C0000000C1000000BC020200E4919300F7EFFF00EFEFFF00F7FFF700F7FF
      F700E2EBDE00F7FFF700FFEFEF00FFFFF700D6FFDE005DC86B0023D3260022E6
      1E001EEC2B0058F15A00DEFFDE00F7F7F700F7FFFF00E7EFFF000829A9000018
      98003D94A8003EAA68001EC5230031D333006DD26B00E7FFDE00D6F7D600D6FF
      D60067BD66008EFB8C0058F15A0029DE3C000000000000000000000000000000
      00000000000000000000D6D6D600080808000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EFEFEF0008080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B0021212100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECE
      CE00000000000000000000000000000000000808080063636300000000000000
      000000000000000000000000000000000000DA727100C3010200BB010200C100
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000BF00
      0000BD010000C1010000BD040000C1414300FAF3F300FEFBFC00E3AEAF00B313
      1200BF000000C0000000BF000000C0000000C0000000C0000000C0000000C000
      0000C1000000BD010000C1020100D77E8000FFF7FF00F7EFFF00F7FFF700E7EF
      E700FFEFEF00FFEFEF00E1B8AD00FFFFF700EFFFE700ADFBAD0033C335003EDE
      3F0039D6390096FD9E00D6FFD600EFF7FF00EFEFFF009C94EF000515C5000C29
      B9001A66730096F9B90067EB6F005ECA5E00CEFFCE00F7FFE700FFFFF700E7FF
      E70098EB8C004CD44C0029DE3C0010E721000000000000000000000000000000
      0000000000003131310000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005252
      5200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE000000
      000000000000000000000000000000000000000000000000000008080800B5B5
      B50000000000000000000000000000000000D86F7100C3010100BA010000BF00
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000BF00
      0000BF000000C0000000BF000000BE000000C4454700F9F2F000FDFCFD00F2D9
      DC00BD353600BE020100BF010000C0000000BF000000C0000000C0000000C000
      0000BF000000BD010000C2020200D87E7E00FFFFFF00F7FFFF00EFF7EF00FFE7
      E700FFE7F700DE648700A4051500C3494500FFEFD600E7FFCE00B5F7B30060BD
      5A006FC56700DEFFD600E7FFDE00EFF7FF00E7E7FF004554C3000515C5000515
      B200A2ADF400DEFBF300DEFFDE00EFFFE700EFF7E700FFFFFF00FFF7FF00E7F7
      EF00D6FFDE0031B535002BE42F0010F71C00000000000000000000000000B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010101000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052525200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000018181800000000000000000000000000DF7F8200BF020200BF000000BF00
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C0000000C0000000C0000000C0000000BE010200C4404300F7F1EE00FBFC
      FD00FAF5F100CC5E5F00BC000100BC020000BF000000C0000000C0000000C000
      0000BE000000C1000000BC010100E3909100FFFFF700F7F7F700FFFFF700FFDE
      DE00FFC1CA00B5081200BD000400BA0A02009C3D3700FFFFDE00F7FFE700E4F7
      CA0081AC6B00FFEFD600FFFFE700F7F7FF00C6CEFF001818AD001818CE002031
      C300D6E7FF00E7EFF700F7FFF700FFFFF700FFF7FF00F7E7F700FFF7FF00F7FF
      FF00D6FFE70096FD9E0031D3330018DA1C000000000000000000000000000000
      0000C6C6C6000808080000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CECECE00000000004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECECE000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4A0000000000000000000000000000000000E29A9C00BD010200C1000100C000
      0100BF000000C0000000C0000000C0000000C0000000C0000000C0000000C000
      0000C0000000C0000000C0000000BF000000BC020000C2000100BF454700FCF7
      F300FBFEFF00FCFEFC00D5777600BC030300C0000000C0000000C0000000C000
      0000BE000000C2000000BA010200E7ACAC00FFFFF700FFF7EF00FFF7F700FFDE
      DE00BD102100D2001400CB050200BD10080098120A00FFF7EF00FFF7EF00FFFF
      F700C349450098120A00FFC0BA00FFE7FF00736BF100311EC5002814B100736B
      F100EFEFFF00F7FFFF00EFF7EF00F7FFF700FFF7F700FFF7FF00FFF7FF00FFEF
      EF00EFFFF700DEFFE700A9FFA5005ECA5E000000000000000000000000000000
      000000000000000000007B7B7B00080808000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CECECE0008080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C9C
      9C00000000000000000000000000000000000000000010101000000000000000
      000000000000000000000000000000000000ECCACA00C0020500BE000100C200
      0000BF000000C0000000C0000000C0000000BF000000BE000000BF000000BF00
      0000C0000000C0000000C0000000BF000000C3000100BF010000C2010200CA6F
      6C00FEFEFD00FEFCFF00F7FDFA00C8555700BF000000BF000000C0000000BF00
      0000BF000000BE000000BD040600F3DCDA00FFEFF700FFF7F700FFF7F700B952
      5600B5081200D0020A00CB101200BD100800B5081200FFC0BA00FFEFFF00FFDE
      E700BD102100AD0408007B131000FFCEFF00311EC5002110D600311EC500C8C0
      F700EFEFFF00E7F7EF00EFFFF700FFFFF700FFF7F700FFEFEF00FFC1CA00FFEF
      EF00FFF7F700F7F7E700EFFFE700CEFFCE000000000000000000000000000000
      0000000000000000000000000000000000003131310000000000000000000000
      0000EFEFEF00FFFFFF00FFFFFF00FFFFFF00EFEFEF0021212100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400ADADAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EFEFEF0021212100FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000008080800B5B5B50000000000000000000000
      000000000000000000000000000000000000FDF5F600BE211D00BC000100C300
      0000C0000000C0000000C0000000C0000000C4000000BE020000C3000100BF00
      0000C0000000C0000000C0000000C0000000BF000000C0000000C0000000B703
      0200EDD2D000F8FDFE00FDFCFC00F4E5E700B90B0C00BD030000C5000100BA01
      0000C3000000BC010100C02E2900FDF9F800FFF7FF00FFEFF700FFFFF700CE7B
      7B0098120A00A5000000F2A0B100E052580094000800F48C8400FFF7FF00F2A0
      B100BD000400D2001400970A310062158600200AC3001414DA00544EC300F7E7
      FF00F7F7FF00EFF7F700E7F7EF00FFF7EF00FFDEDE00B952560094000800C349
      4500F2A0B100FFF7F700FFF7EF00EFF7EF000000000000000000000000000000
      00000000000000000000000000000000000000000000D6D6D600080808000000
      0000BDBDBD00FFFFFF00FFFFFF00CECECE00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0084848400101010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D6D60000000000FFFFFF00FFFF
      FF00FFFFFF00CECECE00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000808080052525200000000000000000000000000000000000000
      000000000000000000000000000000000000FBFCFB00D2686500C3000200BF00
      0000BF000000C0000000C0000000BF000000BE000000C0000000BA000100BE02
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0000000BE00
      0000D78A8900FAFDFC00FDFEFD00FDFCFD00C9545400C2020000BF000000BF01
      0000BE000000C4000200D8797400F9FCFB00F7F7FF00E7DEFF00FFF7FF00FFDE
      DE00FFC1CA00F48C8400FFEFF700F48C8400A4051500E0525800FFDEEF00DE64
      8700D0020A00D200140099156D00560C77002110D600081CD600A799FC00FFE7
      FF00EFEFF700FFFFFF00FFFFF700FFF7EF00E0525800A4051500A5000000C531
      3900B952560067203D00FFEFEF00FFF7FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      730008080800BDBDBD0073737300000000000000000000000000000000000000
      0000DEDEDE007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000212121000000000000000000EFEF
      EF00424242000000000000000000000000000000000000000000FFFFFF000000
      0000101010000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F8FBFB00F3D1CF00BC070900BD03
      0200BF000000C0000000C0000000BF000000BE020100BB151500BF292D00BF01
      0000C0000000C0000000C0000000C0000000C0000000C0000000C0010100BE00
      0000D78B8A00FCFEFD00FDFEFE00FBFEFE00D57B7B00C2010000BF000000C100
      0000BD030300B90B0C00F5DDDA00F9FCFC00E7EFFF00DEE7FF00E7E7FF00DEDE
      FF00FFF7FF00FFE7E700FFE7F700FFC0BA00A5000000CB1B3400FFE7FF00970A
      3100D2001400CB1B3400C673DE002D18B9001821D60000189800E7DEFF00FFF7
      FF00FFF7FF00FFEFF700FFE7E700E1606200AD020000CB101200C5313900FFDE
      D600FFEFE700FFE7DE0089A29900E7DEDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000808080000000000000000000000
      000000000000000000000000000000000000000000000000000008080800ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFCFC00FCFBFB00CC585300BE03
      0200C0000000BF000000C0000000BF000000C5030200C8545200FCF3EF00B927
      2700BF000000BF000000C0000000BF000000BF000000BF000000BF000000B908
      0700F1D8D600FAFDFE00FEFEFE00FBFEFE00D6707000BB020000C2000000BD00
      0100C1040300CC686000FDFBFC00FCFCFC002031A400202E94004648A2004648
      A200868CDE00E7EFFF00FFEFFF00FFE7FF00B5081200B5081200F2A0B1008400
      42008400420099156D003C10BD001818AD001416A200947BDE00FFE7FF00FFDE
      DE00F2A0B100CE7B7B00C5313900A5000000B5081200C5313900FFDEDE00FFF7
      EF00FFFFF700F7F7EF00FFFFF700FFF7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000101010000000000000000000000000000000
      0000000000000000000000000000000000000808080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B6B6B000000000000000000000000000000
      000000000000000000000000000000000000080808006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFEFD00FAFDFE00F3DCD700B916
      1400BF010100C1000100C0000100BC000000C0010000B7090900F5E6E500E4B5
      B400B8030400BE030100BE020000BF000000C3010000BA030000BC060800D89C
      9A00FDFEFE00FDFFFD00FBFDFC00FCFAFB00B8313000C2010100BD020000C300
      0100BB1C1B00F8E6DF00FEFCFE00F8FEFE001818CE001818AD00292194004648
      A2004648A2004648A200C8C0F700FFE7FF00C5313900B508120099156D003E00
      7B003C10BD00200AC3001818CE002D18B900560C7700DE648700E0525800AD02
      0000B5081200A40515008C0000007B1310009C3D3700FFCED600FFF7FF00FFFF
      F700F7F7F700FFFFFF00FFFFF700FFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A50008080800000000000000
      00000000000000000000000000000000000000000000A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000080808000000000000000000000000000000
      0000000000000000000000000000212121000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFEFC00F9FEFF00FCFBF900E4A5
      A300BB030300C4000000BC000000C0000100C0010200BB020000D8868600FDFA
      FB00DA9B9700C3393B00B60E1000B6030500BD1D1D00CE5F5C00EACFCD00F7FB
      FE00FCFDFF00FBFCFF00FBFCFD00E3A4A300B7030200C3010100C3010100BC04
      0700EAB2B100F9FCFA00F8FDFE00F4FEFE00311EC500736BF100C6CEFF00D6D6
      FF00D6C8FF009C94EF00202E9400D6C8FF00DE64870084004200560C77003C10
      BD00100DCB000810CE002031C300A799FC0067203D00970A3100B5081200BD10
      0800BD102100E1606200FFC0BA00FFDED600FFEFF700FFF7FF00F7EFF700F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4A4A000000
      0000000000000000000000000000000000000000000008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00000000000000000000000000000000000000
      00000000000008080800CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFEFC00F6FEFE00F9FDFE00FCFE
      FC00D47B7900C2050700C4000000C1000100C1000100C3000000B5282600FCFA
      F900FBFDFD00FEFBFD00FDFDFD00FDFEFB00FCFDFD00FBFEFD00FDFEFE00FEFE
      FD00F8FCFB00FEFBFB00E5B8B600B80E0E00C0020000C2010100BA030700DB8B
      8800FBFDFD00FAFEFE00F6FEFE00FDFDFE00DEE7FF00E7E7FF00E7EFFF00D2DE
      FF00F7F7FF00E7DEFF004648A2004648A200B183C1003E007B00311EC5000810
      CE001018AD00899AF700D6E7FF00F7EFFF00FFE7F700B95256007B131000F48C
      8400FFDED600FFEFE700FFF7EF00FFF7EF00FFEFFF00FFEFFF00F7E7F700FFFF
      FF00FFEFEF00ECE9F100F7F7FF00E7EFF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000101010000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000018181800000000000000000000000000000000000808
      0800848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9FEFD00FEFDFE00F8FEFE00FCFF
      FE00FAF8F600D67B7900BA030300BF010000BD010000C0000200BA030100CA54
      5500ECC6C600FAFCFA00FEFDFE00FCFEFD00FCFDFE00FEFEFE00FEFDFE00FAFD
      FD00EED2D000CE636100B7050500C3020100C0000100B5050700DC898700FBFA
      F400FAFEFE00FCFEFE00FBFEFE00FCFDFE00F7F7F700F7F7FF00EFF7F700E7E2
      EF00FFF7FF00EFEFFF00C6CEFF00292194004736BA002814B1002110D600181C
      C1005263D600DEE7FF00EFEFFF00FFF7FF00FFFFF700FFFFF700FFE7E700FFEF
      EF00FFFFF700FFF7EF00FFF7EF00FFFFF700EFEFF700FFF7FF00FFF7FF00FFFF
      FF00FFEFF700FFFFFF00F7FFFF00E7F7FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5B5B50008080800000000000000000000000000424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000008080800000000000000000000000000313131000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFFFF00FEFFFF00FEFFFF00FFFE
      FF00FEFEFE00FAFEFC00E3A6A300BC171500BC030300BB020200BD000000C100
      0000BB010200B81E1E00C4565500D1747500D27E7F00CF767400C5575600BE23
      2600B7010100BD000000BD020100BF020200B8191800E6AFAD00FDFDFC00FDFE
      FE00FEFFFF0000000000FEFFFF00FEFFFF00FFFFF700FFF7F700FFFFFF00E7DE
      DE00FFF7FF00ECE9F100E7F7FF00868CDE002031A4002D18B9003C10BD003E00
      7B00C0AFF700FFF7FF00F7E7F700FFF7FF00FFF7FF00F7F7FF00F7EFFF00FFF7
      FF00FFFFFF00FFF7F700FFFFF700F7FFFF00FFFFFF00FFFFFF00FFF7FF00FFF7
      FF00EFF7EF00F7FFF700F7FFFF00EFF7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005A5A5A000000000000000000080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B00000000000000000010101000DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00F9FEFE00F7FDFE00FBFAF800F5DED800CC575300BB070900C3000200BB01
      0100BB020100BF010000BE020100B9020000BA010100C0010100C4010000C301
      0000BF000000C3000300B60A0A00CA615A00F8E1DD00FAFBFA00FBFDFE00F8FE
      FF00FEFFFF00000000000000000000000000FFF7EF00FFEFEF00FFFFFF00E7DE
      DE00FFFFFF00FFF7FF00EFF7FF00E7F7FF009CA5FF004736BA00621586003900
      4A00FFEFFF00FFF7FF00FFF7FF00FFF7FF00F7F7FF00F7F7FF00F7F7FF00FFF7
      FF00F7EFFF00F7EFF700F7FFFF00EFFFF700E7EFE700FFFFF700FFF7FF00FFF7
      FF00F7FFF700F7FFF700F7FFF700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001818180000000000A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000808080008080800949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00FEFDFE00F6FEFE00F8FDFE00FBFDFE00FAFAFA00F2D1CF00D3696600BD21
      1D00BF020600BD000300BF010200C5020100C2010100C0010100BA020300B406
      0600BB262000D66F6B00F3D5D300FDFBFC00FCFCFE00F6FDFF00F7FDFF00FDFD
      FE00FEFFFF00000000000000000000000000FFFFFF00FFFFFF00EFFFF700DEEF
      E700F7FFFF00FFF7FF00FFF7FF00FFEFFF00E7E7FF00F7EFFF00F7D6FF00B183
      C100FFFFFF00FFFFF700F7EFF700FFFFFF00FFFFF700FFFFF700FFEFF700FFEF
      FF00FFF7FF00FFF7FF00F7FFFF00EFFFF700EFFFE700F7FFEF00FFF7FF00FFEF
      FF00EFF7F700F7FFF700FFFFF700F7F7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE001010
      1000000000000000000000000000000000000000000000000000000000000000
      0000CECECE003939390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFF
      FF00F9FEFD00FDFEFC00FCFEFC00FCFEFD00FDFBFC00F8FCFC00F9FBFA00FCF5
      F500EDCDCA00E29C9B00DD828300D4727300D7727200E1818300E69EA000EDCC
      CC00FEF6F700FCFDFC00FAFEFE00FEFCFD00FAFEFE00F6FEFD00FDFEFD00FAFE
      FD00FEFFFF00000000000000000000000000F7F7F700F7FFFF00EFFFF700DEEF
      E700EFFFFF00EFEFFF00FFF7FF00FFF7FF00FFFFFF00F7F7F700FFF7FF00FFFF
      FF00F7FFF700F7FFF700FFF7F700FFF7F700FFFFEF00FFFFEF00FFF7FF00FFF7
      FF00FFEFFF00FFEFFF00F7FFFF00E7FFEF00EFFFE700F7FFE700FFF7FF00FFF7
      FF00EFEFF700F7FFF700FFFFF700FFF7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000948C7B007B735A008C7B6B008C84
      6B009C8C7B007B736300948C7300ADA58C007B6B5A00736B5A00AD9C8C008473
      6300847363009C8473008C73630094847B0073736B00848C8C00B7D3E40094BD
      DE008CBDE70078A5D0005A7BA500314A6B0025354A0031393900212121002121
      18002929210031312900313129003131290000000000EFDEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00EFDEDE00EFDE
      DE00EFDEDE00EFDEDE00EFDEDE00000000000000000000000000000000000000
      00000000000000000000EFEFE700F7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5948400948473007B6B5A00736B
      5A007B735A00736B520084736300948C73009C9484007B7363009C8C7B007B6B
      5A008473630094847300847363008C7B73006B6B63008C949C00B7D3E40094BD
      DE008CBDE70078A5D0005A7BA500314A6B002131460031393900212121001818
      180029292900313129003131290039352900EFEFEF00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00EFDEDE0000000000000000000000
      0000000000000000000000000000EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEC3AF00A59C8400847B6300A59C
      8C009C947B008C7B6B007B6B5A006B635200A59C8C00948C7300736B5A007B6B
      5A008473630084736300846B5A00736B5A005A5E5600A0ADB500B5D6EF0094C6
      E7008CBDE70078A5D0005A7BA500314A6B002131460031393900212121001818
      180029292900313129003131290039393100F7F7F700E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7D6D600E7DEDE00E7DEDE00EFDEDE00EFDEDE0000000000000000000000
      0000000000000000000000000000EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5AD94007B735A0084736300C6B5
      A500AD9C8C0094847300847363007B735A00ADA59400A5A58C007B6B5A008C84
      6B009C8C7B008C73630084736300736B63005E635A00AAC0D300B5D6EF0094C6
      E7008CBDE700789FCB005A7BA500314A6B002131460031393900212121001818
      180029292100313129003131290039393100FFFFFF00EFE7DE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7D6D600C6BD
      BD00ADADAD00C6BDBD00E7DEDE00EFDEDE000000000000000000000000000000
      0000000000000000000000000000EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000847363007B6B5A00847B6300948C
      73007B6B5A00736B5200736B5A00A59C8400B5AD9400A59C8C009C948400A594
      8400AD9C8C009C8473007B6B6300736B63005A5E5600B5C6D600B5D6EF0094BD
      E70084B5DE006596C3005A7BA500294A63002131460031393900212121001818
      180021212100313129003131290042393100FFFFFF00EFEFEF00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7D6D600CEC6C600ADA5AD0084A5
      BD0084B5C6009C949400D6CECE00EFDEDE000000000000000000000000000000
      00000000000000000000EFEFE700EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A59C8C008C846B00948C7B007B73
      5A007B735A00847B63006B635200A59484007B6B5A00736B5A009C9484009484
      6B00A59484009C847300736352007B7373005A686B00B7D3E400ADD6EF0094BD
      E70084ADD6006B94B500527BA500294263002131460031393900212121001818
      100021212100313129003131290042423900FFFFFF00FFF7F700E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DEDE00E7DEDE00E7D6D600D6CEC600ADA5AD008C9CA50073A5C60073AD
      C60073ADC60084949C00B5B5B500E7DEDE000000000000000000000000000000
      00000000000000000000EFEFEF00F7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C8C7B00BDB59C00BDB59C00ADA5
      8C00B5AD9C00AD9C8C007B735A0084736300A59C84008C8473007B736300BDAD
      9C00AD9C8C008C7B6B00847363005A5E560084848C00CADEF700ADD2F7008CBD
      E7007BADD6006B94B500426B90002942630012293F0025313900181818002929
      210029292900292921003939310042423900FFFFFF00FFFFFF0000000000E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
      DE00E7DED600D6CECE00B5ADB5008C9CA5006B9CBD0063A5C6006BA5C60073AD
      C60084BDDE009CBDD6008C8C8C00D6CECE000000000000000000000000000000
      000000000000EFEFE700EFEFEF00F7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C948400847B63009C9484009484
      73008C846B008C7B6B007B736300847B6300847B6B00736B5A00736B5A00948C
      73008C7B63008C7B630084736300636363009CA5B500B5D6EF009FC3EC0084B5
      DE00789FCB006384B100426B90002942630012293F0029313100181818002121
      210029292900292929003939310042423900FFFFFF00FFFFFF00F7F7F700E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00DED6
      CE00CEC6C60094A5AD006B9CB5006BA5C6006BA5C60073A5C60073ADCE007BBD
      DE0084C6E70094C6E7007B9CA500ADADAD00E7DEDE00E7E7E700000000000000
      0000EFEFE700EFEFEF00F7EFEF00F7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADA58C007B735A00948C7300847B
      630084736300847B6B008C846B00948473007B7363007B7363007B7363008473
      63007B6352008C736300736B5A0063636300B5C6D600AAC8EC0094BDDE0078A5
      D0006596C3005A88AD00426B9000294A63002131460021292D00121210002121
      210029292900313129004242390042423900FFFFFF00FFFFFF00FFFFFF000000
      0000E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7D6D600CEC6C600A5A5
      AD007B94AD0073ADC6006BA5CE006BA5C60063A5C6007BBDDE0084C6E7008CC6
      DE0084BDDE0084BDE70084BDDE00848C8C00CEC6C6000000000000000000EFEF
      E700EFEFEF00EFEFEF00F7EFEF00F7EFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000181818004A4A
      4A00212121000000000000000000000000000000000000000000000000001010
      1000393939001818180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000212121008484840010101000000000000000000073737300393939000000
      000018181800CECECE007B7B7B00000000000808080094949400B5B5B5001010
      10000000000052525200636363000000000000000000212121007B7B7B001010
      1000000000000000000000000000000000009C947B00B5A59400A59C84008C7B
      6B00948C7300948C7B00847B6300847363007B6B5A00847B6B00847B6B008473
      5A00846B5A008C736300736B630084848C00D6E7F700A5C6E7008CB5DE006B9C
      CE00658EBF005284A500426B9000294A6B0025354A0021292D00121210002121
      210029292900313129004242390042423900FFFFFF00FFFFFF00FFFFFF00F7F7
      F700E7DEDE00E7DEDE00E7DEDE00E7D6D600CEC6C600B5ADB500849CA5006B9C
      BD006BA5C60073ADC60073ADCE0084BDDE007BBDDE006BB5D60084C6E70094C6
      E7007BB5D6006BB5D6008CC6DE007BA5B500ADA5A500DEDEDE0000000000EFEF
      EF00EFEFEF00F7EFEF00F7EFEF00F7F7F7000000000000000000000000000000
      00000000000000000000000000000000000000000000101010009C9C9C00F7F7
      F700CECECE00313131000000000000000000000000000000000000000000A5A5
      A500DEDEDE00C6C6C60042424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00FFFFFF00D6D6D60021212100ADADAD00FFFFFF00DEDEDE000000
      00004A4A4A00FFFFFF00FFFFFF0094949400B5B5B500FFFFFF00F7F7F7002929
      290010101000E7E7E700FFFFFF009494940031313100E7E7E700FFFFFF009494
      9400000000000000000000000000000000009C948400A59C8400847B6B006B63
      52008C846B00948C7300847B63008C846B008C847300847B6B00847B6B008C7B
      6300947B6300846B5A00736B6300ADADB500D6E7FF009FC3EC0084B5DE006B9C
      CE005A90BD00527BA500426B9000314A6B0025354A0021292D00121210002121
      180029292100313129004242390042423900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EFEFEF00E7DED600DECECE00B5B5B500849CA5007BADC60073ADCE0073AD
      CE006BADCE007BB5D6008CC6E7009CCEE7008CCEE70084C6DE0084C6E7008CC6
      E7007BBDDE0084C6E70094CEE7009CC6DE00848C9400CEC6C60000000000EFEF
      EF00EFEFEF00F7EFEF00F7EFEF00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000073737300F7F7F700FFFF
      FF00FFFFFF00E7E7E70063636300000000000000000029292900B5B5B500FFFF
      FF00FFFFFF00FFFFFF00F7F7F700292929000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039393900EFEFEF00FFFFFF00F7F7F700FFFFFF00F7F7F7006B6B6B000000
      00000000000094949400FFFFFF00FFFFFF00FFFFFF00F7F7F700737373000000
      0000000000008C8C8C00FFFFFF00FFFFFF00F7F7F700FFFFFF00E7E7E7002929
      290000000000000000000000000000000000B5AD9C00A59484008C8473007B6B
      5A00847B6300847B6300847363008C7B6B007B6B5A007B7B6B00847B6B008C7B
      630094846B00736352007B736B00C0CED800BDD6EF0094B5DE007BADD6006596
      C3005A88AD00527BA500426B9000314A6B0025354A0021313100121210001818
      180029292100313129004242390042423900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7F7F700D6CEC60094A5AD00739CBD006BADCE006BA5C6006BADCE0084BD
      DE0073BDDE0084C6E70094C6E70094C6E700A5CEEF00A5CEE7009CCEEF009CCE
      E70094C6DE007BB5D60084C6E7008CC6E70084B5C6009C9C9C00E7DEDE00F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00F7F7F7000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E7E7E7004242420010101000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000052525200F7F7F700FFFFFF00FFFFFF008C8C8C00000000000000
      00000000000008080800D6D6D600FFFFFF00FFFFFF00CECECE00080808000000
      00000000000000000000A5A5A500FFFFFF00FFFFFF00F7F7F700313131000000
      000000000000000000000000000000000000ADA594008C8473008C846B008473
      63008C846B008C84730094847300A59484008C846B00737363008C7B73008473
      5A008C7363007B635200948C8400CBDBEC00ADC6DE0084A5CE006B9CCE005A90
      BD005284AD00527BA500426B9000314A6B0025354A0025313900121210001818
      180021212100292929004242390042393100FFFFFF00FFFFFF00FFFFFF00F7F7
      F700C6CED60084A5BD0073A5C6006BADCE0063A5C6007BB5D6008CBDDE0084C6
      DE0084BDDE0073B5DE0084C6DE00A5CEE70094CEE70094C6E7008CC6E70084BD
      DE0084C6E7009CCEE7009CCEE7009CCEE70094CEE7008C949400CEC6C600EFEF
      EF00F7EFEF00F7EFEF00F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000042424200DEDEDE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00E7E7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F70094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808009C9C9C00FFFFFF00FFFFFF00FFFFFF00D6D6D600212121000000
      0000080808009C9C9C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00949494000000
      00000000000021212100D6D6D600FFFFFF00FFFFFF00FFFFFF009C9C9C000000
      000000000000000000000000000000000000ADA58C008C846B00847B6300847B
      63009C9484009C947B00948C7300A59C8400948C7B00948C7B00A59C8C008C7B
      630084735A007B6B63009C949400CBDBEC008CADCE00739AC6006596C3005083
      B6004E7FAD004879A200426B9000314A6B00293F520031313900181810002118
      180021212100292921004242310042393100FFFFFF00FFFFFF00FFFFFF00DEE7
      E70084B5CE0073ADCE0073ADCE006BADCE007BB5DE0084C6E70094CEEF0094C6
      DE0084C6E70094C6E7008CC6E70094C6E70084C6E70094C6E7008CC6E7008CCE
      E7009CCEE700ADD6EF00ADD6EF0094C6E7008CCEE70094B5CE009C9C9C00E7DE
      DE00F7EFEF00F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00ADADAD0018181800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8C8C00FFFFFF00FFFFFF009C9C9C00E7E7E700FFFFFF00BDBDBD000000
      000063636300FFFFFF00FFFFFF007B7B7B007B7B7B00FFFFFF00F7F7F7002929
      290010101000D6D6D600FFFFFF00E7E7E7009C9C9C00FFFFFF00FFFFFF006363
      630000000000000000000000000000000000ADA58C008C7B6B007B7363008C84
      6B009C8C7B00CEC3AF009C947B009C948400BDB59C00B5A58C007B6B5200A594
      7B00847363005A5E5600C6D6E700B5CEF70084A5D6006596C3005A90BD005083
      B600467BAD004879A200355E8C0029426B0025354A0031393900292921001818
      10001818100031292100423931004C473900FFFFFF00FFFFFF00FFFFF700BDCE
      DE0063A5C6007BB5D6007BBDDE007BBDE70073BDDE007BBDDE0084C6E70084C6
      E70084BDDE0084C6E7007BBDE70084BDE70084C6E70084C6E70084C6E70094CE
      EF0084CEE70094CEEF008CC6E7009CCEE7009CCEE7008CC6E7008494A500BDB5
      B500EFEFEF00F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      6300E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00EFEFEF006B6B6B000000000029292900D6D6D600949494000000
      000018181800A5A5A5005A5A5A000000000000000000636363008C8C8C000000
      000010101000C6C6C600CECECE0029292900000000006B6B6B00E7E7E7004242
      420000000000000000000000000000000000ADA58C0084736300847363008473
      63008C846B00B5A594009C8C7B008C846B009C8C7B00A5947B0094846B00ADA5
      84007B735A00656D6D00CADEF700ADD2F70084ADE700658EBF005083B600467B
      AD00467BAD004879A200426B9000394A7300293F520031393900292929002118
      18002118100031292100423931004C473900FFFFFF00FFFFFF00F7F7F700A5C6
      DE007BBDDE007BBDDE007BBDE7007BBDDE007BBDDE008CBDDE0084BDE70084C6
      E700A5CEEF008CC6E7007BBDE70084C6E7007BBDDE0094C6E70084BDDE0084C6
      E7008CC6E7008CC6E70094CEE7009CC6E7007BBDDE0094C6E7008CC6DE009494
      9C00DEDEDE00F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      080063636300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600181818000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001010100000000000000000000000000008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000808080008080800000000000000000000000000101010000000
      000000000000000000000000000000000000736B520084736300948C7B008C84
      6B00A5948400B5A59400A59C8C007B73630073634A00B5A58C00B5A58C00ADA5
      8400736B5A0084848400D6E7FF009FC3EC0078A5D000658EBF004E7FAD004879
      A2004E7FAD00527BA5004F739900446083003142630032404800292929002121
      21002121180031292100423931004C473900FFFFFF00FFFFFF00F7F7F700B5D6
      EF0094CEEF007BC6E70084C6E70084C6E7008CC6E70094C6E7007BC6E70094CE
      EF0094CEE7009CCEEF008CC6EF007BBDDE007BBDE70084C6E70084C6E70094C6
      EF0084C6E7008CCEEF00ADD6EF00ADD6EF0094CEE70084C6DE00ADD6EF0094B5
      BD00BDBDBD00F7F7F700F7F7F700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001818
      1800ADADAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A006B6B6B000000000000000000181818007B7B7B00181818000000
      0000212121008484840010101000000000000000000073737300393939000000
      0000000000003131310008080800000000000000000010101000181818000000
      000000000000000000000000000000000000B5AD9C009C948400A59C8C007B6B
      5A008C7B6B00847B6300948473007B73630084736300948473008C846B008C84
      63006B675A008C949C00CADEF7008CB5DE00739AC6005A88AD004879A2004879
      A2005284A5005284A500527BA5004A638C00314A6B0032404800253139001821
      21002118180029292100423929004A423100FFFFFF00FFFFFF00FFFFFF00DEE7
      EF0094C6E70084BDE70084C6E7007BB5D60084C6E7008CC6E7007BC6E70084C6
      E70084C6E70084C6E7008CC6E7007BBDDE0094C6E7008CC6E70084C6EF0084C6
      E70084C6E7008CC6E7009CCEE70094C6E70094C6E7008CC6DE0073ADD60084BD
      DE00ADADAD00EFEFEF00FFF7F700FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7F7F7005252520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      0800DEDEDE00FFFFFF009C9C9C0029292900DEDEDE00FFFFFF008C8C8C000000
      00009C9C9C00FFFFFF00D6D6D60021212100ADADAD00FFFFFF00DEDEDE000000
      000031313100F7F7F700CECECE001818180029292900DEDEDE00F7F7F7003131
      310000000000000000000000000000000000ADA59400B5AD9C00C6B5A500A59C
      8C00CEC3AF00B5AD9400A59C8C008C84730094847300948473007B6B5200736B
      520073736300A0B1C100CADEF70094B5DE00789FCB00527BA5004F7399006081
      A5006B94B5005A88AD00527BA500466F9800394A7300293F5200253139001821
      21001818180029292100393529004C473900FFFFFF00FFFFFF00FFFFFF00F7F7
      F700C6D6E7008CBDDE0084BDDE009CCEEF0084C6E7008CC6E7007BBDDE008CC6
      E70084C6E7008CCEE70084C6E70084C6EF0094CEEF0084C6E70084BDDE008CC6
      EF008CC6E7009CCEEF009CC6E7008CC6E7008CC6DE009CCEE700A5D6EF00A5CE
      E700CECED600F7F7F700FFF7F700FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000018181800A5A5A500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E7E7E70052525200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00F7F7F700FFFFFF00E7E7E700313131000000
      000039393900EFEFEF00FFFFFF00F7F7F700FFFFFF00F7F7F7006B6B6B000000
      000029292900EFEFEF00FFFFFF00D6D6D600E7E7E700FFFFFF00DEDEDE001818
      1800000000000000000000000000000000009484730094847300948473007B73
      6300A59C8400A59C8400948C7B00A59C8400B5A59400C6B5A5008C846B005752
      410058584C00AAC0D300D6EFFF00A5C6F700739AC6005A7BA5006B84A00084A5
      BD008CB5CE007596BA006384B100527BA500446083002942630025354A002129
      2D0018212100292921004242310057524100FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EFF7F700B5D6EF0094CEE70084C6E70084C6E70084C6E7007BBDDE0094C6
      E7008CCEE70094CEE70094CEE7008CC6E7008CC6E70084C6DE0073B5D60094CE
      E70094CEEF00A5D6E7009CCEE70084C6E70094CEE7009CCEE700ADCEDE00D6DE
      DE00F7F7EF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000008C8C8C00F7F7F700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C60063636300F7F7F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D6D6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00FFFFFF00FFFFFF00F7F7F70039393900000000000000
      00000000000052525200F7F7F700FFFFFF00FFFFFF008C8C8C00000000000000
      0000000000004A4A4A00EFEFEF00FFFFFF00FFFFFF00E7E7E700313131000000
      000000000000000000000000000000000000847B63007B735A007B735A007B6B
      5A009C947B00A59C8C007B6B5A007B7363006B6352009C8C7B00A59C8C006B67
      5A00424239009FBACB00D6EFFF00A5C6F700789FCB006B84A000849CB500B7D3
      E400BDD6EF008CB5CE007596BA006384B1004F73990029426300293F52002531
      390029313100393931004C473900635A4E00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DEE7EF00ADD6EF0094CEE70094C6E70094C6E70084C6E70094C6
      E70094C6E7007BB5D60073ADD6008CC6E70094CEEF008CC6EF0084C6E70094CE
      E7007BB5D60094C6E70094C6E70094C6DE00B5CED600CED6D600EFEFEF00F7F7
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700FFFFFF00FFFF
      FF00FFFFFF00F7F7F700ADADAD00000000000000000029292900CECECE00FFFF
      FF00FFFFFF00FFFFFF00EFEFEF00080808000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000021212100D6D6D600FFFFFF00FFFFFF00FFFFFF00A5A5A500080808000000
      0000080808009C9C9C00FFFFFF00FFFFFF00FFFFFF00D6D6D600212121000000
      00000000000021212100E7E7E700FFFFFF00FFFFFF00DEDEDE00212121000000
      0000000000000000000000000000000000006B635200948C73008C7B6B00847B
      6300948C7B00B5AD9C008C846B00A5948400847B630063564200EFDECE00E7E2
      DA00848C8C00BDD6E700C8E4FC009FC3EC008CB5D6006B89B2009CADBD00D6E7
      F700DEF7FF00A5C6DE0084A5BD007596BA006081A50029426300293F52003240
      4800324048004C47390058584C006B635200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700B5D6EF0084C6E70084C6E700A5CEE7008CC6DE0084C6
      E70094CEE7008CC6E7008CC6E70084C6E70084C6E7008CCEEF0094CEEF009CCE
      EF0084C6E7008CC6DE009CC6DE00C6CED600EFEFEF00F7F7F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300EFEFEF00FFFF
      FF00FFFFFF008C8C8C001818180000000000000000000000000029292900D6D6
      D600FFFFFF00F7F7F7007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001010
      1000CECECE00FFFFFF00EFEFEF009C9C9C00F7F7F700FFFFFF006B6B6B000000
      00008C8C8C00FFFFFF00FFFFFF009C9C9C00E7E7E700FFFFFF00BDBDBD000000
      000021212100D6D6D600FFFFFF00EFEFEF00EFEFEF00FFFFFF00CECECE001010
      10000000000000000000000000000000000073635200847B6300A5948400ADA5
      9400ADA59400B5AD9C009C948400BDAD9C00A59C8C00948C7B00EEEEED00FFFF
      FF00FFFFFF00CADEF700A5C6DE008CB5DE0084A5CE0058779200415770009CAD
      BD00E7F7FF00CEE7FF009CBDDE007596BA006081A50041577000293F52003240
      4800454F4C00454F4C00636352006B6B5200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E7EFF70094C6DE0084BDDE009CCEE700ADD6EF007BBD
      E70094C6E70094C6E70094CEE70094C6E7009CCEE70094CEE7008CCEEF00A5D6
      EF00B5D6DE00BDD6DE00E7E7E700F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313131009C9C
      9C004A4A4A000000000000000000000000000000000000000000000000001818
      18008C8C8C005252520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      0800BDBDBD00D6D6D600313131000000000063636300E7E7E7004A4A4A000000
      00007B7B7B00EFEFEF006B6B6B000000000029292900D6D6D600949494000000
      00005A5A5A00FFFFFF00DEDEDE003131310031313100DEDEDE00EFEFEF002121
      2100000000000000000000000000000000007B6B5A00847363008C7B6B008C84
      6B007B735A008C7B6B008C846B00B5AD9400BDAD9C008C7B7300BDB5A500BDBD
      AD00E7E2DA00BDD6E7009CBDDE0084ADD6007596BA008CA5BD00849CAD009CAD
      BD00B5C6D600AAC0D3006B89B200446083006B84A00058779200415770004E5A
      5A004E5A5A0058584C006B635200736B5200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DEE7EF0094BDD60084BDDE008CC6DE0073B5
      D60084C6DE0084BDDE0084BDDE0084C6E70094C6EF0094C6E7009CCEDE00C6D6
      DE00E7E7E700F7F7F700F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080808000808080000000000000000000000000010101000000000000000
      0000000000001010100000000000000000000000000008080800000000000000
      0000000000004A4A4A0018181800000000000000000021212100393939000000
      000000000000000000000000000000000000847B6300847B6B00847B63008C84
      6B00736B5200736B5A00847B63009C8C7B00AD9C8C00A59C8C007B736B005858
      4C00A5B5AD00BDD6E700AAC8EC008CB5DE006B94B500ADC6DE00E7F7FF00EFFF
      FF00EFFFFF00DEF7FF00AAC0D300587792006F8294006F8294005A686B005A68
      6B005E635A0063635200736B52007B6B5200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDD6DE0084BDDE008CC6E700A5CE
      EF0073ADCE008CC6E70084BDDE008CC6DE00A5CEE700C6CED600E7EFEF00FFF7
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C7B6B008C846B008C7B6B009C8C
      7B00847363007B735A00847B6B00847363008C84730094847B00636352006B6B
      6300BDCEC600CBDBEC008CADCE0084A5CE0084A5D6000C142D006F829400D6E7
      F700E7F7FF00E7F7FF00E7FFFF00C6D6DE008C949C00788684006B7B7300636B
      63006B675A006B6B52007B735A007B735A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFF7F700A5CEE70084C6E70094CE
      E70084C6E7007BC6E70084C6DE00B5CED600DEE7E700F7F7F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000847B6B00847B6300847B63008C84
      6B007B735A00736B52008C7B6B00847B6300948473007B736B00575241007B7B
      7300E7E2DA00DEF7FF008CB5CE00658EBF006384B100183152008CA5BD00DEEF
      FF00D6E7F700C6D6E700C6D6DE00A0ADB500656D6D0073736B006B7363006B67
      5A006B6B5200736B52007B735A00847B5A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DEE7EF009CCEE7008CC6
      E70094C6DE00ADCEDE00D6DEDE00F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084736300847B63008C7B6B008C7B
      6B00847B63007B6B5A008C8473008C847300948C7B008C847B00575241005858
      4C00ADB5AD00DEF7FF00ADD6EF00658EBF00355E8C006B89B200CEDEFF00D6E7
      FF00BDD6E700B5C6D600849494004E5A5A0058584C00636352006B735A006B6B
      52006B6B52007B735A00847B5A00847B6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700CEDEE700ADCE
      DE00D6DEDE00EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B736300847B630094847300847B
      63008C7B6B007B735A008C846B008C8473008C8473008C7B7300635A4E005A5E
      560078868400B7D3E400AAC8EC0084ADD600658EBF00AAC8EC00D6E7FF00BDD6
      EF009FBACB0094A5AD004E5A5A003131290042423100635A4E007B7B5A00736B
      52007B735200847B5A00847B5A008C7B6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700F7F7
      F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B735A007B6B5A008C7B6B006B5A
      4A00736B52006B5A4A007B6B5A008C7B6B008C7B6B0094847B00736B63005858
      4C006B6B6300C0CED800D6EFFF00BDD6EF008CADCE00DEEFFF00D6E7FF00B5C6
      D60094A5AD00656D6D00454F4C006B675A006B6352006B674A008C8463008473
      5A00847B5A008C846300847B5A008C7B6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084735A00847B630084735A007B6B
      5200736B5200736B52007B735A008C7B63008C846B008C7B6B007B736300635A
      4E006B635200A5A59400E7E2DA00CECECA0084848400CECECA00E7E2DA00ADAD
      A5006B675A006B6B6300847B6B007B736300847B6B00847B6300847B6300847B
      6300847B5A00847B5A00847B6300847B6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084735A00847B630084735A007B73
      5A007B6B5A007B735A0084735A00847B63008C7B63008C7B6B007B735A006B5A
      4A00736B52009C8C7B00ADA58C009C947B00847B6B00736B5200948C7300847B
      63006B63520084736300847B6B007B6B5A00847363008C7B6300847B6300847B
      6300847B6300847B6300847B6300847B6300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000800000008000000100000001800000021000000
      2100000021000000210000002100000021000000210000002100000029000000
      29000800310008083900080039000800420000084A000010520000105A000021
      6B000C358800255A9C002363A200255A9C00F7F7E700FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFEFEF00FFEFE700F7E7
      E700EFE7E700F7DEE700F7DEE700F7DEE700E2D6EB00C6BDD6008E89BD007D6B
      AD007F5EA5007B397E007B104F00940039009C0029009C0029008C0029008E00
      3400940039009400390081003100810031005A5A5A0039393900000000000000
      0000000000000000000000000000000000000000000000000000313131001010
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B0018181800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000080000000800000010000000180000002100000021000000
      2900000021000008210000082100000021000000210000002100000029000000
      310008003900080039000800420000004A00000852000010630000186B000021
      7B000C358800255A9C002363A200255A9C00FFF7E700FFF7EF00FFF7EF00FFF7
      EF00F7EFE700F7EFE700F7EFE700F7F7E700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00F7EFE700F7EFE700F7E7E700F7DEE700F7DEE700EFDEE700EFD6E700CEBD
      DE00AE9ECA008C7FB5007F5EA500734281007B104F0081003100940039009C00
      3900980031008C0029008E0034008E0034006B6B6B00636363007B7B7B000000
      000000000000000000000000000000000000000000000808080084848400F7F7
      F700949494001010100000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00F7F7F700D6D6D600ADADAD004A4A4A000000
      0000000000008C8C8C004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000080000001000000018000000210000002100000029000000
      2900000029000008210000081800000018000000180000001800000021000000
      310000003900080042000800520008005A000008630000107300001884000021
      8C0005319600145CAD00216BA5002363A200F7F7EF00FFEFEF00FFEFEF00F7E7
      E700E7CEDE00DEBDD600DED6D600EFDEDE00F7E7E700FFEFEF00FFEFEF00FFF7
      EF00FFF7EF00FFF7EF00F7EFEF00F7EFE700F7E7DE00F7E7DE00F7DEE700F7DE
      E700EFD6E700DBC8E600AE9ECA008C7FB5007D6BAD00734281007B104F009400
      39009C0029009C002900980031009C002900B5B5B50000000000CECECE000000
      0000080808000000000000000000000000000808080000000000000000003131
      3100CECECE00D6D6D60018181800000000000000000000000000000000000000
      00000000000000000000B5B5B500C6C6C6006363630063636300636363002121
      210039393900949494006B6B6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF00DEDEDE00C6C6C600ADA5
      A500847B7B0063636300524A4A007B7B7B00C6C6C600EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000100000001000000018000000210000002900000029000000
      3100000029000000210000081800000010000000100000001000000018000000
      2900000031000000420008005A0000086300000873000018840000218C000025
      9C000042A5001063B9002775BF00216BA500FFEFE700FFE7E700F7D6DE00D6B5
      C600B1849C0096638C00A06B9C00B388AB00D6B5C600E7CEDE00F7E7DE00F7EF
      E700FFF7E700FFF7E700FFF7EF00FFF7EF00FFEFE700FFEFE700F7E7E700F7E7
      DE00F7E7DE00EFDEE700EFD6EF00DBC8E600B5B5D6008C7FB5007D6BAD007342
      81007B104F008E0034009800310098003100BDBDBD00CECECE00ADADAD000000
      0000949494008C8C8C000000000031313100D6D6D60008080800000000000000
      000008080800D6D6D60084848400000000000000000000000000000000000000
      0000000000000000000018181800CECECE00181818000000000018181800F7F7
      F700FFFFFF00FFFFFF00D6D6D600313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF00D6D6D600B5B5B5009C9494007B7B73006B636300635A5A00635A
      5A00524A4A00524A4A003939310021181800312929005A525200A5A5A500E7DE
      DE00000000000000000000000000000000000000080000000800000008000000
      0800000008000000180000002100000029000000290000003100000031000000
      3900000039000000290000001800000010000000080000000800000010000000
      100000002100000042000000520000086B0000107B0000188400002994000039
      A5000046A9000A62C0003190D100216BA500FFE7E700F7D6DE00C8A2B7009F39
      4400631031005A0C18006318350073355A008A507300A06B9C00C8A2B700DEC6
      D600EFDEE700FFEFE700FFF7E700FFF7E700FFF7EF00FFF7EF00FFF7EF00FFEF
      E700F7EFE700F7E7E700F7DEE700EFDEE700F7DEE700E2D6EB00B5B5D6008C7F
      B5007D6BAD007B397E007B104F008E0034007B7B7B00FFFFFF00848484000000
      00000808080094949400B5B5B500DEDEDE003131310000000000000000007373
      7300E7E7E700CECECE00292929006B6B6B00CECECE00CECECE00CECECE00CECE
      CE007B7B7B00000000000000000039393900BDBDBD000000000031313100ADAD
      AD00000000005A5A5A00CECECE004A4A4A000000000000000000000000000000
      00000000000000000000EFEFEF00E7E7E700CECECE00B5B5B50094948C007B73
      7300635A5A005A525200524A4A005A5252004A42420042393900393131003129
      2900292121002921210031292100423939003929290031292100181010002118
      18006B6B6B00DEDED60000000000000000000000080000000800000008000000
      1000000010000000180000002100000029000000310000003100000039000000
      3900000039000000310000002900000018000000100000000800000008000000
      100000002100000042000000520000086B000010840000218C00002994000042
      A500024CB500006BC6002BA7E4002775BF00FFE7E700CA94A000732437008810
      00009C140C00881000007B1000006B0800005A0C1800631835008A507300A06B
      9C00B388AB00DEBDD600EFD6DE00F7EFE700F7F7E700F7F7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7E700F7E7E700F7E7E700EFDEDE00EFDEE700F7DEEF00E2D6
      EB00B5B5D6008C7FB5007F5EA50073428100D6D6D60029292900E7E7E7004A4A
      4A000000000010101000E7E7E700B5B5B500080808000000000000000000A5A5
      A500949494000000000000000000101010003131310031313100313131003131
      310021212100000000000000000000000000737373008C8C8C0010101000B5B5
      B5000000000042424200E7E7E700000000000000000000000000F7F7F700DEDE
      DE00C6BDBD00A5A5A5008C8484007B737300636363005A5A5200524A4A004A42
      420042393900393131003931310029212100312929004239390042393900635A
      5A004A4A4A0042393900424239004A4242004A4242004A423900292121002121
      1800393129008484840000000000000000000018290000001800000010000000
      1800000018000000210000002900080031000800310000003900000039000000
      4200000042000000390000003100000021000000180000001000000010000000
      18000000290008004A0008005A00000873000018840000218C00053196000046
      A9000052B9000C7DD20039ABF0002775BF00E7C6C6008D1A1600B9210000B929
      0000B9290000AA260000A52100009018000084180000730C0000630404006B14
      180073355A0096638C00B388AB00DEB9CA00EFE7E700F7F7E700FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFEFE700F7E7E700F7E7DE00F7DEDE00F7DE
      DE00EFDEE700E2D6EB00B5B5DE008C7FB5005A5A5A000000000052525200DEDE
      DE0008080800CECECE00525252005A5A5A00BDBDBD0008080800000000001010
      1000D6D6D6002121210000000000393939009C9C9C009C9C9C008C8C8C009C9C
      9C007373730000000000000000000000000000000000C6C6C60031313100DEDE
      DE001010100021212100FFFFFF0021212100BDBDBD0084848400636363005A52
      520052524A00524A4A004A424200423939003931310039313100312929003931
      31004239390042393900524A4A00635A5200635252004A423900393931003931
      3100423939004239390039313100424242004A4A4A005A5252005A5A5A00736B
      6B00848484005A5A5A00D6D6D600000000002139560018214A00101039000000
      2900000021000800310008003100080039000800390008004200000042000000
      420000004A000000420000004200000031000000290000002100000021000000
      29000000390008005A0000086B0000107B0000188C00002994000031A200024C
      B5000A62C0000C7DD2004AB6F5002775BF00E09AA200CE311200EF360000E24E
      0800D4602500D4602500D6441500BD310000AA2600009C210000901800008418
      00006B0800006B1418007D2C4E00A4738A00E7C6C600FFEFE700FFF7EF00FFF7
      EF00F7F7EF00F7F7EF00FFF7E700FFF7E700FFF7EF00FFEFE700F7EFE700EFE7
      E700F7DEE700F7DEE700F7DEDE00EFD6DE00393939000000000000000000C6C6
      C6005A5A5A006B6B6B0000000000000000005A5A5A0042424200101010000000
      00004A4A4A00C6C6C60000000000000000000000000000000000000000000000
      000000000000000000007373730000000000000000007373730084848400ADAD
      AD006363630000000000ADADAD0021212100E7E7E700BDBDBD00636363003931
      310039312900312929004A4242004A424200424242004A4242004A4242004A42
      39004242390042423900424242004A4242004A42420052524A00524A4A00524A
      4A005A5A5A006B6B63007B7373008C848400A5A5A500C6C6C600D6CECE00DEDE
      DE00E7E7E700E7E7E700F7F7F70000000000293D6F0031396B001C255A000808
      390008003100080039000800390008004200080042000000420000004A000000
      4A0000084A00000852000008520000084A000008420000083900000839000008
      4200001052000010630000107300001884000021940000259C000039A5000052
      B9000A62C0000C88D6004AB6F5002775BF00DB898100E04E1600EF783C00F7BD
      9000F7E7BD00FFE7B500F7CEA500F7A56B00DE753300CA461000B9290000AA26
      0000942100009C0C08007B1313006B141800CA7B7300F7E7E700F7F7EF00F7F7
      EF00FFF7EF00FFF7E700FFF7E700FFF7E700F7F7EF00F7F7EF00F7F7EF00F7EF
      EF00F7E7E700EFDEE700F7DEDE00F7DEDE00DEDEDE00848484005A5A5A00C6C6
      C600181818000000000000000000000000000000000000000000ADADAD00DEDE
      DE009C9C9C00EFEFEF0063636300000000000000000000000000000000000000
      00000000000000000000D6D6D600C6C6C600ADADAD00F7F7F700848484008C8C
      8C00BDBDBD000000000000000000000000000000000000000000F7F7F700DED6
      D600ADADAD008484840052524A0042424200424239004A4242004A4242005A52
      52005A5A5200635A5A00635A5A00636363005A5A5A005A5A52005A5252008484
      7B00ADADAD00CECECE00DEDEDE00EFEFEF00F7F7F70000000000000000000000
      000000000000000000000000000000000000293D6F002B477B001C255A000000
      390000003900000042000000420000004A0000004A0000005200000852000008
      520000085A0000086300000863000010630000105A0000105A00001052000010
      5A00001063000010730000107B0000188C0000259C000031A2000039AD000052
      B9000B69CA002899E40052C3F9002775BF00C33D3900F1A06400FFE7AD00FFE7
      C600FFE7D600FFEFCE00F7EFCE00F7EFC600F7E7B500FCCB9400EB926400D252
      2500C6310000AA2600009C210000A01800008D1A1600E7C6BD00FFF7E700FFEF
      E700FFE7E700F7DEDE00EFD6DE00EFDEDE00F7E7E700F7EFE700FFEFEF00FFF7
      EF00FFF7EF00FFEFE700F7EFE700F7E7DE0039393900CECECE00EFEFEF006363
      6300000000000000000000000000000000000000000000000000212121009C9C
      9C00C6C6C600C6C6C60039393900000000000000000000000000000000000000
      0000000000000000000042424200BDBDBD00C6C6C6007B7B7B00080808004242
      4200FFFFFF001010100000000000000000000000000000000000000000000000
      000000000000F7F7F700CECECE00B5B5B50094949400BDBDBD00BDBDBD009494
      94007B7B7B0073737300737373007B737300524A4A0021181800181818001810
      10001818180029212100424242006B63630094949400E7E7E700000000000000
      00000000000000000000000000000000000029397B0029397B00081052000000
      31000000420000004A0000004A000008520000085A0000106300001063000018
      6B000018730000107B0000107B0000187B0000187B000018730000186B000010
      6B0000086B000018840000188C0000259C000031A2000031AD00003DB5000A62
      C0001E6FBF003F9CE90067C6FF00216BA500B2330A00F7D6B500F7EFCE00F7EF
      CE00F7E7CE00F7EFDE00FFEFD600F7E7D600F7EFD600F7E7C600F7E7B500FFD6
      A500F7A56B00D4602500C6390000CE2D0400CA3D2100F7CEC600FFE7E700F7DE
      DE00E7C6C600C8A2B700B1849C00B1849C00C8A2B700DEBDD600F7DEE700F7E7
      E700FFEFE700FFF7E700FFF7E700FFF7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424242001010100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F700EFEF
      EF00EFEFEF00E7E7E700D6D6D600CEC6C6008484840018181800181010001810
      100021181800292121003939310039393900ADADAD0000000000000000000000
      00000000000000000000000000000000000029397B0029397B00001052000000
      3900000052000000520000085A000008630000106B0000187300001873000021
      7B0000218400002994000021940008298C0008298C0008298C00002184000010
      730000086B000029940000259C000031A2000031AD00003DB500024CB5000B69
      CA001C8CD60039ABF00067C6FF002363A200B9290000BD312100DE7E6500F7CE
      A500F7E7C600FFE7CE00FFDECE00F7E7D600F7EFDE00F7E7CE00F7E7C600F7E7
      BD00FFE7BD00FFD69C00F39C5600E2561800E27F4E00EFDED600E7C6DE00D6A6
      BE00A4738A007D2C4E00631835007324370073355A0096638C00B388AB00D6B5
      C600EFD6DE00F7E7E700FFEFE700FFF7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFE7E7003931310018101000211810002118
      18003129210039393100CECECE00DEDED600EFEFEF0000000000000000000000
      0000000000000000000000000000000000002142730018366D0000084A000000
      420000004A000010630000106300000863000029840000318C00002984000042
      A500053196000039A5000039A5000042A5000042A5000042A5000042A5000042
      A5000039A5000046A9000039AD00003DB500024CB500005ABD000A62C0000C7D
      D2003F9CE90052C3F90068B7F7001A568300D6390800CE2D0400CE2D0400CE2D
      0400D2633500EFB18400F7E7BD00F7E7C600F7E7CE00F7E7C600F7E7CE00F7E7
      C600FFDEC600F7DEBD00F7E7AD00FCCB9400EFAD9400E7B5BD00B1849C007D2C
      4E006B1418006F0808006F0808006F080800520010005A0C1800732437008A50
      7300A4738A00C8A2B700E7C6D600F7DEE7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFEFEF006B6363002921210031292900312929003129
      290031292900ADA5A500D6D6D600CECECE00E7E7E70000000000000000000000
      0000000000000000000000000000000000002B477B0018366D0000084A000000
      4A0000105A0000106300003184000031840000318C000042A5000046A900145C
      AD001063B9001063B9000A62C0000A62C0000A62C0000A62C0000A62C000005A
      BD00005ABD00005ABD000052B900005ABD00006BC600006BC6000C7DD2001C8C
      D60039ABF00078D6FC006BB5EC001A568300FBC18400EC914400E6631600E142
      0200D6390800BD310000CA3D2100EB926400F7D6A900F7E7BD00F7DEBD00FFDE
      C600F7E7BD00FFDEB500F7E7B500F7E7BD00F4AFA200A95E6F007B1313009018
      0000A5210000A018000090180000841800007B100000730C0000630404005A0C
      18006310310073355A0096638C00C8A2B7000000000000000000000000000000
      0000000000000000000021212100212121000000000039393900080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000039393900101010000000000042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700EFEFEF00DEDEDE00B5B5B5004A4A4A004A4242004A4242004A424200524A
      4A005A5252006B6363006B6363006B6B6B00A59C9C0000000000000000000000
      000000000000000000000000000000000000214A73000831630000104A000010
      520000216B0000318400104C9900104AA4001E6FBF002775BF003190D1003F9C
      E9001C8CD6002899E4001C8CD6001C8CD600128ED800128ED8000C88D6000C7D
      D200007FCE00007FCE00007FCE00007FCE000C88D600128ED8002899E40036B7
      EF0056CEFF0086E1FC00548CAF0010395A00F7E7B500FFE7B500FFD6A500FBC1
      8400EC914400DE5A0C00E1420200C6310000C13B1400E27F4E00F7D6A900F7E7
      C600FFDEC600F7E7BD00FFDEC600E09AA200A431310084180000AA260000B921
      0000CE310000D2420800CA461000B2330A00AA2600009C210000901800007B10
      0000730C0000630404005A0C18007D2C4E000000000000000000000000000000
      0000000000000000000094949400EFEFEF008C8C8C00FFFFFF005A5A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00D6D6D6009C9C9C00FFFFFF00292929000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C6005A5252005A52
      5200524A4A00524A4A005A524A0063635A006B6363006B6363006B6B63006B63
      63006B63630063635A00635A5A006B636300847B7B00E7E7E700000000000000
      0000000000000000000000000000000000002142730000215A00001852000021
      63000D448300104C99002775BF003F9CE90068B7F70068B7F7006BB5EC0068B7
      F70067C6FF0052C3F90052C3F90052C3F9004AB6F5004AB6F50039ABF00039AB
      F0002BA7E4002BA7E4002BA7E4002BA7E40036B7EF0036B7EF0052C3F90056CE
      FF0086E1FC009CE7FF0021526B0000102900FFDEBD00FFDEBD00F7E7C600FFEF
      C600FFDEAD00FCCB9400F39C5600D2541600D6390800CE2D0400E7BDAD00FFF7
      DE00FFEFD600FFDECE00DB8981008D1A1600B2180D00D6210000DE310000D644
      1500F1A06400F7CEA500F7D6A900F7BD9000EF8C4A00D2541600BD310000AA26
      0000A0180000881000007B1000006B0800000000000000000000000000000000
      0000000000000000000010101000D6D6D600FFFFFF00A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000029292900F7F7F700FFFFFF0073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E700423942004A42
      42004A424A004A4A4A004A4A4A00424242003939390039313100313131002921
      21002118180018101000101008002929290073737300D6D6D600000000000000
      00000000000000000000000000000000000018366D0000184A00002963000042
      8400216BA500529ACF0068B7F7006FBDFB006FBDFB0098E2FF00A2ECFF0094DE
      FF009CE7FF009CE7FF0098E2FF0094DEFF0094DEFF0086D8FF0086D8FF0086D8
      FF0078D6FC0078CBF90078CBF90084D0F90084D0F90086E1FC0094DEFF00A2EC
      FF00ADEFFF00B1E7FF000829390000001000F7E7C600F7E7C600F7EFDE00F7EF
      D600F7E7C600F7DEB500F7DEB500FCCB9400F4964C00D4602500F7E7C600FFEF
      E700F7E7D600BF606B009C140C00CA290000DE310000EF460400EF8C4A00FFD6
      A500FFF7CE00F7F7DE00FFEFD600FFEFCE00FFEFC600FFE7B500FFBD8C00E27F
      4E00CA461000B5310000A5210000A01800000000000000000000000000000000
      000000000000000000005A5A5A00FFFFFF00E7E7E700EFEFEF00292929000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C8C8C00FFFFFF00E7E7E700D6D6D600101010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000736B6B00524A
      4A0073737300636363005A5A5A004A5252004242420039393900313131002929
      2900212121001818180010101000101010006B636300ADADAD00000000000000
      00000000000000000000000000000000000008316B0000104A000D448300216B
      A500529ACF0084D0F9006FBDFB0084D0F9006BB5EC00529ACF009CDEF700BDF7
      FF00AFD6F700BDEFFB00BDEFFB00BDEFFB00B5EFFF00B5EFFF00B5EFFF00B5EF
      FF00B5EFFF00B1E7FF00B5EFFF00B5EFFF00BDEFFB00BDEFFB00BDEFFB00C6EF
      FF00CEEFFF00A4C8DB000010210000000800F7D6B500FFE7C600F7EFC600F7DE
      BD00F7DEB500FFDEB500F7DEBD00F7DEAD00FFDEA500FFD6A500F7F7DE00F7DE
      DE00CA7B7300A9180800EF290000E1420200E26F2500FFBD8C00F7EFC600FFF7
      D600F7EFDE00FFE7D600FFE7CE00FFE7CE00F7E7CE00F7E7C600F7E7BD00FFE7
      AD00FFCE8C00E6945600D2541600B53100000000000000000000000000000000
      00000000000000000000737373007B7B7B00080808009C9C9C00313131000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C005252520018181800ADADAD00101010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A59CA5004A42
      42008484840073737300636363005A5A5A004A525200424A4A00393939003131
      3100292929002121210018181800101010005A5A5A008C8C8C00000000000000
      00000000000000000000000000000000000008316B0000104A002363A200529A
      CF006FBDFB0084D0F90078CBF90084D0F9005288A00000314A00204754007EA4
      AD00CEEFF700D6F7EF00D6F7EF00D6EFEF00D6EFEF00CEEFF700CEEFFF00CEEF
      FF00CEEFFF00CEEFF700D6F7F700D6F7F700DEF7F700DEF7F700E7F7EF00E7F7
      EF00DEEFF7007F96A4000000100000000800D6441500E27F4E00F7C39A00F7E7
      B500F7DEAD00FFDEAD00FFD6B500F7DEB500F7E7C600FFEFD600F7E7DE00DB89
      8100A9180800DE310000EF460400EC914400FFE7AD00FFEFCE00F7EFD600FFE7
      D600FFE7D600FFE7CE00F7E7C600EFE7BD00EFE7BD00F7DEBD00FFDEBD00FFD6
      B500FFD6B500FFD6A500FFCA8400EC9144000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6D6D6005252
      52007B7B7B0084848400737373006B6B6B00636363005A5A5A004A4A4A004242
      4200313939002931310029292900181818004A424200736B6B00F7F7F7000000
      00000000000000000000000000000000000008396B00001852003B79B9006BB5
      EC0086D8FF0094DEFF0094DEFF00437797000018290000182900000008000021
      2100CEEFEF00E7F7EF00E7F7EF00E7F7EF00D6F7EF00D6EFF700D6EFF700D6EF
      F700D6EFF700D6E7EF00D6EFEF00DEF7F700E7F7F700EFFBF700EFFBF700F4F7
      FC00E7EFF700526878000000080000000800DE5A0C00CE420000CE310000DE5D
      4B00FFD6B500F7E7C600F7E7BD00FFDEC600EFC6CE00E7B5BD00E7B5BD00DE77
      7300DE310000EC570D00F7B36B00FFE7CE00F7EFDE00FFEFCE00FFE7CE00FFE7
      CE00F7E7C600F7E7BD00F7E7C600F7DEBD00FFDEB500F7DEB500F7D6B500F7DE
      AD00F7D6A900FFD6A500F7D6A900FFD6A5000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFEFEF007B73
      73006B6B6B0094949400848484007B7B7B006B6B6B00636363005A5A5A005252
      520042424200393939003131310029292900393131006B636300D6D6D6000000
      00000000000000000000000000000000000000315A0000356700548CAF0078CB
      F90098E2FF00B5EFFF00AFD6F7007EA4AD0018394A0000101800002929007EA4
      AD00C5ECE900D6EFF700D6F7F700CEEFF700CEEFF700C6E7F700D6F7FF00B2D0
      E400B2D0E40052738800526878007F96A400D6E7E700F4F7FC00E7EFF700F4F7
      FC00EFEFFF00212129000808180000000000FCCB9400EC914400EC570D00D460
      2500FFEFCE00F7EFE700FFD6CE00E4968A00C54F5200A4313100C54F5200DE5D
      4B00E4652500FCCB9400FFF7CE00F7EFDE00FFEFD600FFEFCE00FFE7CE00FFE7
      CE00F7EFD600F7F7DE00FFF7DE00FFD6BD00FFD6AD00F7D6A900FFD6A500FFD6
      A500FFD69C00F7D69C00F7D6A900FFE7BD0000848400006B6B00004A4A00004A
      4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A
      4A00004A4A00004A4A00006B6B00008484000084840000636300004A4A00004A
      4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A4A00004A
      4A00004A4A00004A4A0000737300008484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B5005A5A5A009C9C9C00949494008C8C8C00848484007B737B006B6B6B006363
      630052525A004A4A4A0042424200393939002931310063635A00ADADAD000000
      00000000000000000000000000000000000000315A00004A7300529ACF0094DE
      FF009CE7FF00B1E7FF00C6EFFF00CEEFF700D6EFF700CEEFF700CEEFEF00D6FF
      FF00CEF7F700D6F7FF00CEEFF700CEEFFF00DEFFFF00D6FFFF00BFE4ED007EA4
      AD007EA4AD0018394A000010180008182900AABDC500DEEFF700F7FFFF00EFEF
      FF00DED6E700080818000000080000000000F7DEBD00FFE7A500FBC18400EFB1
      8400FFF7DE00FFDED600D66B5E00B2180D009C140C009C140C00A5100000CA3D
      2100FBCA9C00FFF7D600FFEFDE00FFEFDE00FFEFD600F7EFCE00FFE7C600FFE7
      C600FFE7C600F7EFCE00F7E7C600FFE7BD00FFD6B500F7CEA500FFCE9C00F7D6
      9C00FBCA9C00F7D6A900FFD6BD00E7BDAD0000848400004A4A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDE
      DE005A5A5A00949494009C9CA50094949C008C8C8C00848484007B7B7B00736B
      7300636363005A5A5A004A525200424A4A00393939005A5A5A00948C9400F7F7
      F7000000000000000000000000000000000008426B001A5683006BB5EC009CE7
      FF00A2ECFF00B5EFFF00D6FFFF00CEEFFF00CEEFF700E7FFFF00CEF7F700C5EC
      E900C5ECE900A4C8DB009CBDCE009CBDCE009CBDCE00C6EFFF00D6FFFF009CBD
      CE005E88A000001021000008100020475400BDD6DE00E7EFF700E7EFF700EFEF
      FF00AABDC500000000000000000000000000F7DEBD00EFE7BD00FFDEC600F7E7
      D600F7EFDE00DE777300B9290000B9290000B9290000AA260000AA260000D252
      2500F7DEB500FFF7CE00F7F7D600F7EFD600F7EFD600F7EFCE00FFEFC600FFDE
      BD00FFDEBD00F7DEBD00F7DEB500F7DEAD00FFD6AD00FFCE9C00F7D69C00F7D6
      9C00F7D6B500F4AFA200BF606B009F39440000848400004A4A00000000000000
      0000000000000000000000000000525252004242420000000000000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      0000000000000000000010101000525252005252520000000000000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000847B7B008C848400B5B5B500A5A5A5009C9C9C00949494008C8C8C008484
      840073737B006B6B6B006363630052525A004A4A4A004A4A4A007B737300DEDE
      DE0000000000000000000000000000000000185273004377970080C5E8009CE7
      FF00ADEFFF00BDF7FF00B5DEEF00D6F7FF00DEF7FF00CEEFEF00BFE4ED00D6FF
      FF00A5C5D200B5DEEF005268780010314200294A5E00A5C5D200CEEFFF00C6E7
      F700BFE4ED00BFE4ED00BDD6DE00D6EFEF00E7F7FF00EFFFFF00E7EFF700E7EF
      F70052626600000000000000000000000000FFDECE00F7E7CE00FFD6CE00F7CE
      C600FFC6BD00DE5D4B00EF360000E24E0800E2561800D2541600D24A0800C639
      0000CA461000E27F4E00EFB18400FFDEB500FFEFCE00F7EFCE00F7E7C600F7E7
      C600F7DEBD00FFDEBD00FFDEBD00FFD6B500F7D6A900FFD6A500F7D6A900FFD6
      B500CA7B73008D1A1600881000008810000000848400004A4A00000000000000
      0000000000000000000029292900FFFFFF00E7E7E70010101000000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000031313100E7E7E700FFFFFF00FFFFFF00BDBDBD00000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADA5A500736B6B00BDBDBD00ADADAD00A5A5A5009C9CA500949494008C8C
      8C00848484007B7B7B006B6B6B00636363005A5A5A004A4A4A006B6B6300CEC6
      C60000000000000000000000000000000000104273004377970080C5E800A2EC
      FF00ADEFFF00A7D3F100BDEFFB00A4C8DB00B2D0E400CEEFEF00DEFFFF00CEEF
      EF00A5C5D200527388001831520000102900001029006D91A700CEEFFF00DEFF
      FF00CEEFFF00CEEFF700DEF7FF00E7FFFF00C6DAE200E7F7F700E7F7F700D6E7
      E70021292900000000000000000000000000FFE7CE00F9C0B500DE777300C54F
      5200DE5D4B00EC5D3900EF783C00FBC18400FFDEA500FFDEAD00F7BD9000F1A0
      6400E26F2500D24A0800D2420800D2541600E6945600F7C39A00FFE7B500FFE7
      BD00F7DEBD00FFDEBD00FFD6B500FFD6B500FFDEB500F7E7BD00FFDEC600D66B
      5E009C140C00A01800009C2100009421000000848400004A4A00000000000000
      0000000000000000000000000000C6C6C600FFFFFF007B7B7B00000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      000000000000B5B5B500DEDEDE0010101000CECECE00FFFFFF00525252000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6D6D6006B636300BDBDBD00BDBDBD00B5B5B500ADADAD00A5A5A5009C9C
      9C00949494008C8C8C00848484007B737B006B6B6B005A5A5A00635A5A009C9C
      9C000000000000000000000000000000000008426B001A56830080C5E800ADEF
      FF00B1E7FF00A0CEE700A7D3F100294A5E00294A5E0052626600C5ECE900C5EC
      E900D6FFFF00B2D0E40089AFC00087A8B800A5C5D200C6EFFF00C6EFFF00C6E7
      F700DEFFFF00C6E7F700DEFFFF00DEF7F700E7F7FF00E7FFFF00EFFFFF007F96
      A40000000000000000000000000000000000F4AFA200C33D3900A91808009C14
      0C009C290400F1A06400FFE7BD00F7F7CE00F7EFD600FFE7D600FFE7CE00F7E7
      BD00F7E7AD00FBC18400EC914400DE5A0C00CE420000CE420000D2633500EFB1
      8400FFE7BD00FFDEBD00FFDEBD00FFDEBD00F7CEC600E7D6CE00F7BDBD00BD31
      2100D62D0000CE310000CE310000C639000000848400004A4A00000000000000
      00000000000000000000212121008C8C8C00FFFFFF00E7E7E700000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      000000000000B5B5B500F7F7F70021212100ADADAD00FFFFFF004A4A4A000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF00847B7B00A5A5A500C6C6C600BDBDBD00B5B5B500ADADAD00A5A5
      AD009C9CA500949494008C8C8C00848484007B7B7B006B6B6B005A5252007B7B
      7B000000000000000000000000000000000010426B00144A7300548CAF0080C5
      E800ADDEFF008DB3CF004A73840000082100082939000008100089AFC000D6FF
      FF00C5ECE900CEEFFF00D6EFFF00D6F7FF00CEEFFF00C6EFFF00D6F7FF00C6E7
      F700CEEFFF00DEFFFF00DEF7FF00C6DAE200CEEFF700E7FFFF00D6EFF7004252
      5A0000000800000000000000000000000000CA3D2100B9290000B9290000B929
      0000B2330A00F7A56B00FFE7B500FFEFC600FFEFCE00FFE7CE00F7E7CE00F7E7
      CE00FFE7C600F7DEBD00F7DEB500FBCA9C00F39C5600E6631600D2460000EB92
      6400F7E7D600FFDED600FFC6BD00DB898100BF606B00A95E6F00DE777300E04E
      1600DE5A0C00EF8C4A00FBC18400FCCB940000848400004A4A00000000000000
      00000000000031313100EFEFEF00FFFFFF00FFFFFF00FFFFFF004A4A4A000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000029292900EFEFEF00EFEFEF00FFFFFF009C9C9C00000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5B5B5007B7B7B00CECECE00C6C6C600C6C6C600BDBDBD00B5B5
      B500ADADAD00A5A5A5009C9C9C00949494008C8C8C0084848400635A5A00635A
      5A00F7F7F700000000000000000000000000214A730008396B0018527300548C
      AF00A7D3F100ADDEFF00A0CEE700527388004A73840089AFC000CEEFF700CEF7
      F700CEEFF700D6F7FF00CEEFFF00C6E7F700CEEFFF00B5DEEF009CBDCE004A73
      8400526878009CBDCE00C6E7F700DEFFFF00D6EFFF00DEF7FF0087A8B8000010
      290000001000000000000000000000000000EF360000E1420200E2561800D254
      1600D24A0800D2420800D4602500F1A06400FCCB9400FFDEAD00FFDEBD00FFDE
      C600FFE7C600FFE7C600FFDEBD00FFDEB500FFDEA500FFCA8400F39C5600F7C3
      9A00F7E7D600F4AFA200C33D3900B2180D00AA1205009C0C0800B2180D00EF78
      3C00FCCB9400FFF7C600FFF7D600FFEFD60000848400004A4A00000000000000
      000000000000B5B5B500FFFFFF001010100094949400FFFFFF008C8C8C000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000018181800E7E7E700F7F7F700FFFFFF008C8C8C00000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6D6D6006B636300949494009C9C9C00A59C9C00A5A5A500A5A5
      A500A5A5A5009C9CA5009C9C9C009C9C9C00949494008C8C9400736B6B005A5A
      5200D6D6D60000000000000000000000000018366D0010426B00144A7300214E
      77002B587F008DB3CF00A7D3F100C6EFFF00CEF7FF00CEEFFF00C6EFFF00C6EF
      FF00CEF7FF00D6F7FF00CEEFFF00CEEFFF00BFE4ED0087A8B8002E4F6D000018
      29000010210020475400CEEFFF00DEF7FF00CEEFFF00A4C8DB00395573000818
      390000002100000008000000000000000000EF783C00F7B36B00FFD69C00FFDE
      A500FFCA8400F39C5600DE753300CE520800CE520800DE753300F7A56B00FFCE
      9C00F7DEAD00F7DEB500F7DEB500FFDEB500F7D6B500F7DEB500F7DEB500F7E7
      CE00F9C0B500BD312100AA2600009C290400AA2600009C2100009C290400F7BD
      9000FFEFD600F7EFE700FFEFD600F7EFDE0000848400004A4A00000000000000
      000000000000BDBDBD00FFFFFF002121210073737300FFFFFF008C8C8C000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000084848400FFFFFF0010101000DEDEDE00FFFFFF00212121000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7F7F700848484007B737300736B6B006B63630063635A00635A
      5A006B6363005A52520052525200525252005A5252005A5252005A525200635A
      5200ADA5A500000000000000000000000000184273001842730018427300214A
      73002B587F00214A6B004377970087A8B800A0CEE700BDE2FF00CEF7FF00CEF7
      FF00CEEFFF00CEF7FF00C6F7FF00CEF7FF00CEF7FF00B5DEEF0089AFC0006D91
      A7006D91A700B2D0E400D6F7FF00AFD6F70089AFC0005E88A000293D6F001831
      5A0000183900000818000000080000000800FFDEAD00FFEFC600F7E7CE00FFE7
      CE00FFE7CE00FFE7BD00FFDEAD00FBC18400F4964C00E6631600D24A0800D254
      1600EF8C4A00FFD6A500F7E7BD00F7DEB500FFDEB500FFD6BD00F7CEC600E7C6
      C600DB898100CE2D0400DE310000D2420800CA461000D6390800CE310000D644
      1500EB926400F7CEA500FFE7C600FFEFD60000848400004A4A00000000000000
      0000000000006B6B6B00FFFFFF00B5B5B500DEDEDE00FFFFFF004A4A4A000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000073737300FFFFFF007B7B7B00B5B5B500FFFFFF00181818000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7DEDE00DED6D600D6CECE00CECECE00C6BDBD00B5B5
      B500ADADAD009C9C9C008C848400847B7B007B737300736B6B006B6363006363
      6300DEDEDE00000000000000000000000000214A7300214A7300214273001842
      7300214E77002D527700214E7700214A6B002D5277004A7384007EA4AD009CBD
      CE00B2D0E400BDE7F700BDE7F700C6EFFF00CEF7FF00C6EFFF00BDE2FF00BDE2
      FF00BDE2FF00A7D3F1008DB3CF005E88A000416294002B477B002B477B003152
      840018316700081839000010290000001000FFCE9C00FFE7B500FFE7C600FFE7
      CE00F7E7CE00F7EFD600FFEFCE00FFE7C600FFE7AD00FFCE8C00F79C5A00E465
      2500D24A0800F7C39A00FFE7D600FFDEBD00F7C39A00DE7E6500C54F5200D66B
      5E00EC5D3900E6562500F4964C00FCCB9400F7D69C00FFCA8400F1A06400DE75
      3300CE520800D24A0800D4602500F1A0640000848400004A4A00000000000000
      00000000000008080800CECECE00FFFFFF00E7E7E70073737300000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000008080800CECECE00FFFFFF00FFFFFF007B7B7B00000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000214273002B477B00214A73002142
      7300214E7700214A7300214A7300214A7300214A73002D5277002B587F003955
      73002D52770052738800527388005288A0005E88A0005E88A0005E88A0005E88
      A0005288A0004377970031528400315284003C5D860031528400416294004162
      940031528400293D6F001831520008183900E2561800DE753300F7B36B00F7D6
      9C00FFDEB500F7E7C600FFE7D600FFE7D600FFDEC600FFDEBD00F7DEAD00FCCB
      9400F7B36B00FFD6BD00F7D6DE00E4968A00BD312100B2180D009C2100009421
      0000D2522500FFCE8C00FFEFBD00F7F7DE00F7EFDE00F7EFDE00FFEFD600FFE7
      C600FCCB9400F39C5600E6631600D242080000848400004A4A00000000000000
      0000000000000000000008080800292929000000000000000000000000000000
      00000000000000000000004A4A00008484000084840000313100000000000000
      00000000000000000000080808005A5A5A003939390000000000000000000000
      0000000000000000000000636300008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000800000000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E000000780000000FFFFFFFFFFFFFFFF
      E000000700000000FFFFFFFFFFFFFFFFF000000700000000FFFFFFEFF3FFFFFF
      0000000000000000FFFFFF8FF8FFFFFF0000000008000000FFFFFE1FF87FFFFF
      0000000000000000FFFFFC1FFC1FFFFF0000000000000000FFFFF01FFC07FFFF
      0000000000000000FFFFC03FFC03FFFF0000000000000000FFFF803FFE00FFFF
      0000000000000000FFFE007FFE003FFF0000000000000000FFF8007FFF001FFF
      0000000000000000FFE0007FFF0007FF0000000000000000FFC000FFFF0001FF
      0000000000000000FF0000FFFF8000FF0000000000000000FC0001FFFF80003F
      0000000000000000F80001FFFFC0000F0000000000000000E00003FFFFC00007
      0000000000000000F00001FFFFC0000F0000000000000000FC0001FFFF80003F
      0000000000000000FF0000FFFF80007F0000000000000000FF8000FFFF0001FF
      0000000000000000FFE000FFFF0007FF0000000000000000FFF8007FFF000FFF
      0000000000000000FFFE007FFE003FFF0000000000000000FFFF003FFE00FFFF
      0000000000000000FFFFC03FFC01FFFF0000000000000000FFFFF03FFC07FFFF
      0000000000000000FFFFF81FFC1FFFFF0000000400000000FFFFFE1FF83FFFFF
      E000000700000000FFFFFF8FF8FFFFFFE000000700000000FFFFFFCFF3FFFFFF
      E000000700000000FFFFFFFFFFFFFFFF00000000800001FC0000000000000000
      000000000000007E0000000000000000000000000000007E0000000000000000
      00000000000000FE000000000000000000000000000000FC0000000000000000
      00000000000000FC000000000000000000000000200000F80000000000000000
      0000000000000030000000000000000000000000100000600000000000000000
      0000000000000020000000000000000000000000000000200000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FFFFFFFF
      000000000000000000000000FFFFFFFF000000000000000000000000FFFF003F
      000000000000000000000000FFF0000F000000000000000000000000FC000003
      000000000000000000000000C000000300000000000000000000000000000001
      00000000000000000000000000000001000000000000000000000000C000007F
      000000000000000000000000F800003F000000000000000000000000FFC0007F
      000000000000000000000000FFFE007F000000000000000000000000FFFC007F
      000000000000000000000000FFE0007F000000000000000000000000FF80003F
      000000000000000000000000FF80003F000000000000000000000000FFC0003F
      000000000000000000000000FFC0003F000000000000000000000000FFC0001F
      000000000000000000000000FFC0001F000000000000000000000000FFE0001F
      000000000000000000000000FFE0000F000000000000000000000000FFF0000F
      000000000000000000000000FFF0000F000000000000000000000000FFF0000F
      000000000000000000000000FFF0000F000000000000000000000000FFF80007
      000000000000000000000000FFF80007000000000000000000000000FFF80007
      000000000000000000000000FFFC0007000000000000000000000000FFFFFFFF
      000000000000000000000000FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageListBoutons
    Left = 408
    Top = 152
    object ActionCompteNouveauTirerAuSort: TAction
      Category = 'Compte'
      Caption = 'Tirer au &Hasard'
      Hint = '|Permet de tirer au sort instantan'#233'ment un compte '#224' trouver'
      ImageIndex = 0
      ShortCut = 24648
      OnExecute = ActionCompteNouveauTirerAuSortExecute
    end
    object ActionCompteNouveauProposer: TAction
      Category = 'Compte'
      Caption = '&Proposer...'
      Hint = '|Permet de proposer un compte '#224' trouver'
      ImageIndex = 1
      ShortCut = 24656
      OnExecute = ActionCompteNouveauProposerExecute
    end
    object ActionAffichageTableau: TAction
      Category = 'Affichage'
      Caption = '&Tableau'
      GroupIndex = 1
      Hint = '|Affiche/Cache le tableau'
      ImageIndex = 2
      ShortCut = 24660
      OnExecute = ActionAffichageTableauExecute
    end
    object ActionCompteCalculerSolutions: TAction
      Category = 'Compte'
      Caption = '&Calculer'
      Hint = '|Calcule et affiche toutes les solutions DISTINCTES du compte'
      ImageIndex = 3
      ShortCut = 24643
      OnExecute = ActionCompteCalculerSolutionsExecute
    end
    object ActionCompteChercherSaisirSolution: TAction
      Category = 'Compte'
      Caption = '&Saisir'
      Hint = '|Permet de saisir la solution trouv'#233'e au tableau'
      ImageIndex = 4
      ShortCut = 24659
      OnExecute = ActionCompteChercherSaisirSolutionExecute
    end
    object ActionCompteQuitter: TAction
      Category = 'Compte'
      Caption = '&Quitter'
      Hint = 
        '|Enregistre les param'#232'tres en cours et quitte le Compte Pour De ' +
        'Bon'
      ShortCut = 24657
      OnExecute = ActionCompteQuitterExecute
    end
    object ActionParametresRetablirParametresDefaut: TAction
      Category = 'Param'#232'tres'
      Caption = '&R'#233'tablir les param'#232'tres par d'#233'faut'
      Hint = '|R'#233'tablit tous les param'#232'tres par d'#233'faut'
      OnExecute = ActionParametresRetablirParametresDefautExecute
    end
    object ActionAffichageEffacerSolutions: TAction
      Category = 'Affichage'
      Caption = '&Effacer'
      Hint = 
        '|Efface le contenu de l'#39'arborescence, de la liste et de la zone ' +
        'de commentaire'
      ImageIndex = 5
      ShortCut = 24645
      OnExecute = ActionAffichageEffacerSolutionsExecute
    end
    object ActionInformationsAPropos: TAction
      Category = 'Informations'
      Caption = #192' &propos...'
      Hint = '|'#192' propos du Compte Pour De Bon : version, licence et contacts'
      ShortCut = 8304
      OnExecute = ActionInformationsAProposExecute
    end
    object ActionArbreSolutionLaPlusSimple: TAction
      Category = 'Arbre'
      Caption = 'Solution la + Simple'
      Hint = 
        '|Montre la solution la plus simple (le moins de plaques et d'#39'op'#233 +
        'rations utilis'#233'es)'
      ImageIndex = 6
      ShortCut = 16420
      OnExecute = ActionArbreSolutionLaPlusSimpleExecute
    end
    object ActionArbreSolutionLaPlusTordue: TAction
      Category = 'Arbre'
      Caption = 'Solution la + Complexe'
      Hint = 
        '|Montre la solution la plus complexe (le plus de plaques et d'#39'op' +
        #233'rations utilis'#233'es)'
      ImageIndex = 7
      ShortCut = 16419
      OnExecute = ActionArbreSolutionLaPlusTordueExecute
    end
    object ActionInformationsAide: TAction
      Category = 'Informations'
      Caption = '&Aide'
      Hint = 
        '|Aide HTML sur Le Compte Pour De Bon : R'#232'gle du jeu et utilisati' +
        'on'
      ImageIndex = 8
      ShortCut = 112
      OnExecute = ActionInformationsAideExecute
    end
    object ActionAffichageStatistiques: TAction
      Category = 'Affichage'
      Caption = '&Statistiques'
      Hint = 
        '|Affiche les statistiques sur les solutions trouv'#233'es par l'#39'humai' +
        'n et la machine'
      ImageIndex = 9
      ShortCut = 24649
      OnExecute = ActionAffichageStatistiquesExecute
    end
    object ActionArbreSolutionPrecedenteComplexite: TAction
      Category = 'Arbre'
      Caption = 'Solution + Simple'
      Hint = '|Montre la solution pr'#233'c'#233'dente (+ simple)'
      ImageIndex = 10
      OnExecute = ActionArbreSolutionPrecedenteComplexiteExecute
    end
    object ActionArbreSolutionSuivanteComplexite: TAction
      Category = 'Arbre'
      Caption = 'Solution + Complexe'
      Hint = '|Montre la solution suivante (+ complexe)'
      ImageIndex = 11
      OnExecute = ActionArbreSolutionSuivanteComplexiteExecute
    end
    object ActionSaisieAutomatique: TAction
      Category = 'Param'#232'tres'
      AutoCheck = True
      Caption = '&Afficher le tableau apr'#232's nouveau compte'
      Checked = True
      Hint = 
        '|D'#232's qu'#39'il y a un nouveau compte '#224' trouver, le tableau noir est ' +
        'affich'#233' pr'#234't '#224' la saisie des calculs'
      ShortCut = 24641
      OnExecute = MenuItemAutoCheckClick
    end
  end
  object PopupMenuToolBar: TPopupMenu
    Left = 312
    Top = 152
    object MenuItemToolBarAfficherImagesMenuPrincipal: TMenuItem
      AutoCheck = True
      Caption = 'Afficher les &images dans les menus'
      OnClick = MenuItemToolBarAfficherClick
    end
    object MenuItemToolBarAfficherLibellesBoutons: TMenuItem
      AutoCheck = True
      Caption = 'Afficher les &libell'#233's sur les boutons'
      OnClick = MenuItemToolBarAfficherClick
    end
  end
  object TimerAuto: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerAutoTimer
    Left = 312
    Top = 328
  end
end
