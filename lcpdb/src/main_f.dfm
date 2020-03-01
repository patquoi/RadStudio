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
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 518
    Height = 43
    AutoSize = True
    ButtonHeight = 39
    ButtonWidth = 39
    Caption = 'ToolBar'
    EdgeBorders = [ebTop, ebBottom]
    Images = VirtualImageListBoutons
    ParentShowHint = False
    PopupMenu = PopupMenuToolBar
    ShowHint = True
    TabOrder = 2
    Transparent = False
    object ToolButtonCompteNouveauTireAuSort: TToolButton
      Left = 0
      Top = 0
      Action = ActionCompteNouveauTirerAuSort
    end
    object ToolButtonCompteNouveauPropose: TToolButton
      Left = 39
      Top = 0
      Action = ActionCompteNouveauProposer
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
    end
    object ToolButtonCompteCalculerSolutions: TToolButton
      Left = 125
      Top = 0
      Action = ActionCompteCalculerSolutions
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
    end
    object ToolButtonAffichageEffacerSolutions: TToolButton
      Left = 211
      Top = 0
      Action = ActionAffichageEffacerSolutions
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
    end
    object ToolButtonArbreSolutionPlusSimple: TToolButton
      Left = 297
      Top = 0
      Action = ActionArbreSolutionPrecedenteComplexite
    end
    object ToolButtonArbreSolutionPlusTordue: TToolButton
      Left = 336
      Top = 0
      Action = ActionArbreSolutionSuivanteComplexite
    end
    object ToolButtonArbreSolutionLaPlusTordue: TToolButton
      Left = 375
      Top = 0
      Action = ActionArbreSolutionLaPlusTordue
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
  object PanelNombres: TPanel
    Left = 0
    Top = 43
    Width = 518
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
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
  object PanelResultats: TPanel
    Left = 0
    Top = 87
    Width = 518
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object SplitterV: TSplitter
      Left = 261
      Top = 0
      Width = 4
      Height = 431
      Beveled = True
      ExplicitHeight = 417
    end
    object ListBox: TListBox
      Left = 265
      Top = 0
      Width = 253
      Height = 431
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
    end
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 261
      Height = 431
      Align = alLeft
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HideSelection = False
      Images = VirtualImageListArbre
      Indent = 16
      ParentFont = False
      ParentShowHint = False
      PopupMenu = PopupMenuArbre
      ReadOnly = True
      ShowHint = False
      TabOrder = 1
      OnChange = TreeViewChange
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
      AutoHint = True
      Panels = <>
      ParentShowHint = False
      ShowHint = False
      SimplePanel = True
    end
  end
  object MainMenu: TMainMenu
    Left = 432
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
    Left = 464
    Top = 32
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
  object ActionList: TActionList
    Images = VirtualImageListBoutons
    Left = 464
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
    Left = 432
    Top = 32
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
    Left = 496
    Top = 32
  end
  object VirtualImageListArbre: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 12
        CollectionName = 'Arbre\A0'
        Disabled = False
        Name = 'A0'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Arbre\A1'
        Disabled = False
        Name = 'A1'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Arbre\A2'
        Disabled = False
        Name = 'A2'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Arbre\A3'
        Disabled = False
        Name = 'A3'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Arbre\A4'
        Disabled = False
        Name = 'A4'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Arbre\A5'
        Disabled = False
        Name = 'A5'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Arbre\A6'
        Disabled = False
        Name = 'A6'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Arbre\A7'
        Disabled = False
        Name = 'A7'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Arbre\A8'
        Disabled = False
        Name = 'A8'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Arbre\A9'
        Disabled = False
        Name = 'A9'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Arbre\AA'
        Disabled = False
        Name = 'AA'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Arbre\AB'
        Disabled = False
        Name = 'AB'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Arbre\AC'
        Disabled = False
        Name = 'AC'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Arbre\AD'
        Disabled = False
        Name = 'AD'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Arbre\AE'
        Disabled = False
        Name = 'AE'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Arbre\AF'
        Disabled = False
        Name = 'AF'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Arbre\AG'
        Disabled = False
        Name = 'AG'
      end>
    ImageCollection = ImageCollection
    Left = 336
    Top = 232
  end
  object ImageCollection: TImageCollection
    Images = <
      item
        Name = 'Boutons\B0'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C5445000000080000
              1000001008001008081800001808001808081810002100002108002110002121
              0029000029100029180029180829212129290029292131000031000831180839
              00003900083908003908083910003910103918003918083929004200004A0000
              5200005A00004200084A00085200085A00084208004A08005208005A08004A10
              005210005A10005210083929084229104A18004A31005218005A21004A21185A
              251C5A31004231105A39104A39185231185A31185639215447206300006B0000
              6308006B08007308006310006B10007310007B10008410006B18007318007B18
              008418008C18006321006B21006329006331086735006B31086B39086731186D
              36187B21008421008C21008429008C29088431008C310088350C6B42086B4210
              6B4A186B4A216B5221734210734218734221734A00734A1484420083440D734A
              21735218774E2183561A6B39316F3D295E4A296D4F2E7B39297B472B77522D7F
              582B5A5242735539666252786852845231865D3C84734A887352942100942900
              9C2500963105A23100A53900AD3100AD3900A54200A94600994C10A44A10B53D
              00B54C02B95200BD5A00AD5C14B96310C65A00C0620AC66B00CA690BCE7F00D2
              7D0C9C5A25A26323946241977743A56B21BF6F1EBF7527B9793BD6880CD88E12
              D68C1CD19031A08852A0885EAF8C54CF9A52E49928E4A72BE99C3FF0AB39EFB7
              36F5B64AF9C352FFCE56A7916DA4967FADA47EB8A887C0AF89CFB38DECB56BE8
              C580F7B768FBBD6FFFC667F9CB78FCD678F9D084FFD886FCE186CEBD9CC5BDAA
              D2C5A5DBC8A4E7CEA0E4D0B2DED6BDE2DAC6F1D3A7F7DE9CF7D6AFEFDEB5EDE4
              BFE9ECC5EFEFCEF7E7BDFFDE94FFE298FFE79CFFECA2FFDEADFFE7B1FFEFADFF
              EFB5FFE2BDF7E7C6FBEFBDFFEFC6FBF7B9FFF7BDFFF7C6F7EFCEF7F7CEFFEFCE
              FFF7CEFFFFCEE7E7D6EFE7D6EFEFD6EFF7D6F7EFD6F7F7D6FFEFD6FFF7D6FFFF
              D6E7D6DEF7EFDEF7F7DEF7FFDEFFF7DEFFFFDEEFF7E7EFFFE7F7EFE7F7F7E7FF
              EFE7FFEFEFFFF7E7F7FBEFFFFFE7FCF7F4FFFFEFFFFFF7FFFFFF2E455A610000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              250E9B6E5720000003EC4944415438CB4DD26B5013571407F0BB71825DE8426D
              93093A2D13185A2498D4696DB5AD2D33A19114C4DA87C507D83AB6506B844205
              AA5010941A54884C5084C414221024102184B781084429100C411E61C72E9BB1
              3C4C2A43326150B0D3BBE087FEBFECDE7B7F73CED907884F11C527886052D34E
              A566655554C254C832327ECB282DCD48DAE90744A2F8B884D484A3A9995A83F1
              FE7DDC864F4C4CF4355596A6A4647CE3E74D03717171A2B4A3B2C6DE099B8DB4
              FD65B30DE8EAEB8DF67E5D65D2C76F782008883E722C21ADA90FB791386EB393
              E460E32F3E5EA1E402D973CA0F450000A27D27AAFA1EF46665EA8829C24E5AC9
              014366BAC1EA7CBCD008EBC31C3956D5F2A029D373EB3A9DC3443EB693B8DD4A
              3A17EE11CBB3BF5205C077892D63A3BD7DC9C9A74D268751D7D88DE356A7D539
              FF74F97903750E7E90B58C8CF54DF618879C43DD593BBDBDEB4927492C2CDF5B
              5C7CF41A054EC85A2C630F07EC0B43838EEE81F40F92BB49EBE0E0DDE9A7CFDD
              EED36B2D9A2D23E30E92589E32997A0C0603EE30547AAD0BBDEB762FDDA1C08E
              1F5566CB284ECC12438E293B413A1D835AED472FBD72E7C9BF4BFFAC8763EEF8
              AAAA6378BC1FEEBDAA35CDCE1184D56E3466A5373C5A71AF2C6D580FC0BE6D7F
              34779ACD321F1FE4E52197CB35330BF3F7F4FCE2B3672BEE74F826BFDE52A26A
              D377E82BDE0DD5123333D3D3044992C4DCDCFCBCCBF5A4814681E37295BE4DDF
              ACFAF361FFE4E4E43895D1F171788B933D5EF05BBCF3C54F72556B5BDBF088D9
              6219369B3B3B3B6F7774E8F55DE691B1D1AD3410FFDEB6CF8F5F50D4B4B636B7
              B66B349ABA3AB5FA264C6DADE65697E57B6F20FA720B776FEC858BD715376A94
              D54A65797959F15598B2F2EADA5B5D551F8294E8607F9E2036F6B038EF7261A1
              948A442229901415152BD5B79B13417C7430DB5F20E01F3A7C487C3637574C25
              37EFFCA57C89B4B846D39A084E9EE4B2020242F8BB2223F71FC83E1313137320
              3C2C3BE7DCEF97F2AF28D5ED2510BCCD60FBFB734204828848A170F7EEC8885D
              61517B2821BD5ED32E074929DB592C3624011C4E089F2FE0F1B83C41B8108AF3
              0557AA350A90F4F3F64D4C5FDFC0406882399CE0CD1B376EE60AC2A3CEE4E416
              48CBEA14E093F75FC75026456019369B81A128C60A0A13EEC93E972F2D86C087
              4EA3D3518CC9A41AB118289D46A3636F067D1A75F06C5E41B15A011004815B28
              C660B0582C0646A7C135CA0E08FBEC60B638BFE8E62A40100856C5DAF92A1046
              65E7E6496FC8577F5CB05A0383FD3D685407063B880F7BE4880B152F00020114
              98A7071D0EC46005BE15C40F87535C9697BC006B02F5F444E185011FC99F2388
              D8FFEDB5926BE0FF622D18C6DCE41B18CCE5EDA5C07F1094DB2D9915CD150000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C544500005A040463
              00086B000C73100052180C5A08086F18146B00088400107B0010880018840018
              9000219413137B161A8D0010A50018A0080C9C0C149C0010AD0512AA0818A90D
              18B200219C04299C0021A50026AA0021B90029B90031B50A33B20031BD0029CA
              0818BD2131BD0031C60031CE0039C6143BC10021D6002DD6042DCE1231CE0031
              DE0839D60029EF0036EF0042CE0046D20842D2084AD21046CA1544D60852CE16
              54D20242E10446EF084EE2164EE00C5ADE0D57EC1856E21663E6311063310081
              29008C34008E3518633724734F107B4E2C7D29009C31009839009439009C3131
              A444399F213DCA393DC32552D22560D43563D2524FC52556E62565E4395DEC4B
              5DDE256FE23375DE3C78EF3B85EF4E7FE24A8CEF4491EC4C96F45A35737E397B
              81427373508A6F5EA96B60BF8C63968A73A4A55E7FAD6B7D9C6BA0B57F8C9C84
              B1AB88B3BD898ECA9EAE5E6BD6657EDE5694E66492EB569CF35A9CF764A0F16B
              A5F7737BCA7377DE8189DB8A96E4A094CAA29AE0B7A2C8BEA6D66BB3F784B1EF
              84C1FB84CAFF94ADEF90BDF78CBDFF8CCEFFA2AFF49AC3F794CBFC9CCAFB9CCE
              FF9CD6F794D6FF9CD6FFADBDE7B5C0F9A5CEF7A9D6F7B5D6F7A5D6FFADD6FFB5
              D6FFADDEF7B5DEF7A5DEFFADDEFFADE7F7A5E7FFADE7FFADEFFFBDB5E7BDC6E7
              C6B5D6CAB9DEBDBDEFBDBDF7C6C6E7CEC6EFBDC6FFC6CEEFC6CEF7CECEF7CED6
              E7BDD6FFC6D6FFBDDEF7B5DEFFBDDEFFC6DEFFBDE7EFB5E7F7BDE7F7C6E7F7B5
              E7FFBDE7FFC6E7FFBDEFF7C6EFF7B5EFFFBDEFFFC6EFFFC6F7FFD6B5B5DEB5B5
              D6BDC6DEBDCED6BDDED6C6DED6D6DEE6C8DBD6C6E7D6CEEFD6DEEFDEC6E7DECE
              E7DED6EFDEDEEFEBD6E2E7D6EFE7DEEFE7E7EFEFD6EFEFDEEFCEE7F7DED6F7DE
              DEF7E7DEF7EFDEF7CED6FFCEDEFFD6DEFFDEDEFFE7D6FFEFDEFFD6E7F7DEE7F7
              E7E7F7EFE7F7CEE7FFD6E7FFDEE7FFE7E7FFEFE7FFCEEFF7D6EFF7DEEFF7E7EF
              F7EFEFF7CEEFFFD6EFFFDEEFFFE7EFFFEFEFFFCEF7F7D6F7F7DEF7F7E7F7F7EF
              F7F7CEF7FFD6F7FFDEF7FFE7F7FFEFF7FFF7F7FFD6FFFFEFFFFF41B42D1F0000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              1B396216E9520000041E4944415438CB25926B50136714863FB5C0C8458A9972
              8B081D84B6140AE5165404913B55205245186E8A802254141A2ED61482082C64
              50424C965886D229759832C90676931DA6F4466BA71530764252F147B2B31926
              C99A185A0C90FCE8A63DDFCFF7BCE77BDE3307A49575F36598C12047C450F7EC
              DAADF080409FE2FEEFB6CC662B0EB5A5C78361054EAA4D167CA2FFD373098306
              64F04649CBF98FAB217E2FA72C3981CD01924535492A25BCEAF40456A5108565
              B333D35D51D1F189311149ADA3B81594778F8CF7B695252797B50F8B61583606
              C3EAFBE1CC206660509F95B29A416C4A1A2B219ECD8124881CC71119DD3DA81B
              280A78EB604039F4FD8E151486848484B62B162DA45A8D4BE1A1B6F40F5B752F
              1E75D55DEE3C9E5AC983C040913F2388A3FCDB6420D187BCAAD4B8B8B33D4A04
              4166BEFD3AFCBD88884840DEEF2C293D5FCE1B97F4712E24C4B36E0E2A945244
              2492A1F216865FA00F58573F9F79541A7B8C26894CACE891598C182645109140
              281075F87A7A02E99C5C67EEA44198CC6278FB1F93C9B888205258FC6098CF1F
              1BA83B03A45FF07A765FB40430186F160EEDBC7A6535E2386EC494A2D161FE90
              60F61E80AA4EB02DD4F35B25A74B4ACF41DB66AB85244D5BBBB30F0442E1085F
              A004A97111A5220C957F3339D9197DA29B34D30D188A4965F09898E61082A48A
              C179B1440463567D977FF4D1AA098BC96020B1B9395714616F1518C317A4B04C
              2A1E176E693AFC3F48B9707761C76C204935864EF4DF641D0618663661300C55
              B3319BAE8EF176F4D14AE1F696D5B2A8B85B917838D80F2008B62881DA583151
              F776ADEB5DBE01EF46277146057D95AC30A69FE7FEBD605E21A4179C72E49D0A
              012647E5B74F7B310F45C427863203BDF7EFDBE3960B7855E929316185AD0254
              2A4765F3E8C0E503DEC17EDE5E2EF5644D3D17C44445459DED413135FDE4D287
              D09DC9A65C0F7777F737DCB26B1BB8BF694148F88D518C5CD799696CE5485B5A
              C5EF7F7CDE909B955D53DF3CB54CD89C2074CC68549BAD3A13362F6C67474615
              CE6C68A6B94D4DDC252D6173381CA08833811B2CC68579A8B5F80833D0CFF74B
              876D43B3BC42509B4EA78DD283AEE3E57DA862B4BD2C3184E973F080470761B7
              3B69A7DD6E7F49A8341A70FBFDD8636C7652181DCB6BAF476EC3B4CDE9B4DB1D
              0EDAFD4CABD52C8369DF43F42D047B7BEDDBE341837DF5ECB5D3553642AFD1A8
              567FBC06363ECBF664D01B73CBAA6D6C5E5AA65EDB69D941102BAABF567FB876
              E512D858E39E39E9965553DBC8FD454563BBDC14A1556969F9EAC59C4C60DB58
              9B6AAA6F6C9E7AA2A75CB28D1EAE57FDF998962FE564E6E703FBE626F164E9D7
              1562938EE57C49E9F55AEDD3C7D75D72415E5E7E1E70CDA428EA3F348A9EAD55
              3DFDF93AFD774E46C147F9A73233C1FFD0746DDA083A9776F5A74FAE5EB9E872
              9FCA2C28C8C8F817B44837548F0F608E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53459116073B882866A84E168A8A384A158B60A1B4155A7530B9F40B9A3424
              292E8E826BC1C18FC5AA838BB3AE0EAE8220F801E2E4E8A4E82225FE2F29B488
              F1E0B81FEFEE3DEEDE0142A3C254B32B0AA89A65A4E231319B5B157B5E216004
              418C222A31534FA41733F01C5FF7F0F1F52EC2B3BCCFFD39824ADE64804F249E
              63BA61116F10CF6C5A3AE77DE2102B490AF139F1844117247EE4BAECF21BE7A2
              C302CF0C1999D43C7188582C76B0DCC1AC64A8C4D3C46145D5285FC8BAAC70DE
              E2AC566AAC754FFEC2405E5B49739DE630E2584202498890514319155888D0AA
              91622245FB310FFF90E34F924B2657198C1C0BA84285E4F8C1FFE077B766616A
              D24D0AC480EE17DBFE18037A768166DDB6BF8F6DBB7902F89F812BADEDAF3680
              D94FD2EB6D2D7C04F46F0317D76D4DDE032E7780C1275D322447F2D3140A05E0
              FD8CBE29070CDC027D6B6E6FAD7D9C3E0019EA6AF906383804C68B94BDEEF1EE
              DECEDEFE3DD3EAEF07BD6F72C56A123FA400000300504C544500000008080810
              10101818182121212929293131003131313939394242424A4A004A4A4A525252
              5A5A5A6363006363636B6B006B6B6B7373007373737B7B7B8484008484848C8C
              8C9494949C9C9CA5A5A5ADADADB5B5B5BDBDBDC6C6C6CECECED6D6D6DEDEDEE7
              E7E7EFEFEFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF30862E50000000
              097048597300000B1300000B1301009A9C180000000774494D4507E4021D0D20
              31553098DD000001834944415438CBBD93C976842010458BC1A0DD1A631C890A
              38D4FFFF624AD276CA9345B2CA3BBA787881E251427B03924820EAD6B62FD117
              69F4AF2D4440785C6B0690C78603154E0BDEBF811A9B09150366D435F6DF4087
              7241CD8009E5C001B5EED13E01B321F22D926D43CB01D03DAEACC869D7639CF0
              04C07D557D028BF4987320C15532C0AC88F3650BC8B34B5032CFE10AC035C953
              07F076637A6BDB57EEDF09F845F047D58DB086799BAB5172A0C0754B98A7DCC2
              0590013FB84F76AC2F5B0C5B8F05F33E58E42B82D6900AE6530919FC87B2E320
              A9DFCA471DD6B9F4FC34BB466478004B57381507C7C59E2C0437EE5D1F6F9CE6
              B8A2A2A868BDBB7B264B4F3796306A28205F84CF8B59505A74586B7B1B337266
              919A5A3B24EB1DE43A510A1F03456A4847C3D7BD9C20A3466DB003314C0B5D55
              BDFAA4F2246ACF74063342E1EF30FB11861E4CA02544E81E3528AF40ED88C1C0
              041E8E90E9353EA80730B9B22C753A50F555D97C8D896E1F9E373CEF61A4FFA2
              A7B738B301237F445929F804281022D8B7B4C9F20000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C5445080808081010
              1010101010181018211818181818211821212121212121292129312929212929
              2929293129293929312929313931312931313131313931393931394239313139
              393139393939394239394A39424239424A42394242424242424A424A4A424A52
              4A424A4A4A424A4A4A4A4A524A52524A525A52524A52525252525A525263525A
              5A525A635A52525A525A5A5A5A5A5A635A636363635A63636363636B636B6B6B
              6B6B6B6B73736B7373737373737B737B7B7B73737B737B7B7B7B7B7B847B8484
              84848484848C848C8C8C84848C8C8C8C9494948C8C948C9494949494949C9C94
              949C949C9C9C9C9C9CA5A59C9CA59CA5A5A5A5A5A5ADADA5A5ADA5ADADADADAD
              ADB5ADB5B5B5ADADB5B5ADB5B5B5BDB5B5BDBDBDBDBDC6C6BDBDC6C6C6C6C6CE
              CECECECECED6D6D6D6D6D6DED6DEDEDED6DEDEDEDEDEDEE7DEE7E7E7E7E7E7E7
              EFE7EFEFEFEFEFEFEFF7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0C0BED70000
              000174524E530040E6D866000000097048597300000B1300000B1301009A9C18
              0000000774494D4507E4021D0A3017C8B019F4000001C54944415438CBAD9351
              6F9B301485BB52D888C2D486480B4A86A50D678B9B4E76640706DBC888D46D6C
              A29953F182A828A51315FDFFCF35892A4573FA563F80C439C7DFBDD7E6E0E099
              D7DDED4D7995A5C97211788CD6B22112DF6784A1C9042174B696F48AC5C905E7
              7C9524F14F6F5A49862C2C8B22CF529EC4E711213261C15BF97225E4D045E11E
              42FE18FFE662924886B597A77C1BA7D8995FCB8465B6897F75E927C709A42E6B
              1CAFFE88F8678A3FBE1FE05F720F784B17717B70324B2543E0C61BFAC41EF4BA
              2693A6504DC2C86FABB3DF9C7455E0491BFC0591BFA1F7BAAFD4437C2E193CD8
              EAF6563F645209CD5BF0CE11D5993D5D535E747DA9840221083FCC189BB3F640
              17CDBEEB50670E000022C6DC8B276E0CD30DB1D655D93C61B8379523ADD32FFF
              ED979BEA3A521545D3FB83FF9A28B338CFE3D0F703A8A98AAADB2CDE61DCA6D1
              D81E0280A684503C45DFD372E7209B9C9AC706003600A3E1503CC710E279B0E4
              C54DDDB4BBE4114563082CD3344CCB8267A7A3BE789BB683B017E1EDB4EA2BBE
              0CE874E3D20DCB228E258023FDE571B4432AB31F0141100997A1EB1DEB7547D1
              5CA9D92AFBFD851102615F3310BFDB3F8BBA582F280C8B67FB9D1F0003856209
              06F1BAE60000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C5445081008101008
              0810181012121018181818101818182118182121181018211818211821212121
              211829292129291829312D140C2D292131312121312929292931312921293129
              31313F29123931253939293931314631214A3525523118523F29293539293942
              31393931423939393131394231424231424A39424239474C4840324C4F454152
              574C58585A5A4E565E5A4256634E5A634A5A6B4A676B5263635A635E52636B52
              6B6B5A676B4A6373526373526B7352637B526B7B52737B526B84634221634229
              634A296B42296B4A296342316B4A31734A397057416363636B685A5A736B636B
              63636B6B63736B6D6D65737B6B5A6B73636B736373736B73735A6B7B5A737B5A
              7B7B636B7B63737B6B737B6B7B7B73737B737B7B5A6B845A73848C5E35836044
              8C634A906B42986F4699734FA27948AD7B46927758A57B52A57B5AA584528486
              7894826FA58160A0846BAD7F4EAD8452AD885AB68350B18463B2896BBD905ABF
              8E65B5946BC39665BA9675C69A73CE9C6BCB9F78D0A578D6AD7B5A7B845A7B8C
              63738463738C637B84637B8C637B9463848C6B7B846B7B8C6B848C6B8494737B
              8C73848C73849473849C738C94738C9C7B848C7B84947B8C947B8C9C7B949C7B
              94A5848484848C9484949C8494A5849CA584A5AD84A5B58C84848C8C848C9CA5
              8C9CAD8CA5A594948494949C94A5A59C948CAD9C84B59C849C9C8CA59C8CADA5
              94B5A59CADB5A5B5ADA08CA5AD8CA5B58CADB594A5AD94A5B594ADB59CADB59C
              ADBDA5ADADADB5ADB5ADAD9CB5BDA5B5BDADBDBDA5B5C6AFC3CEBDA584CEA584
              D6A584D6AD84DEB584BDA58CCEAD8CCEB58CC6A594BDAD9CC1B1A0CBBA9FD6B5
              8CDEB58CDEB594D3C0AAE7AD84E7BD8CDEBD94E7B594DEBD9CE7BD94E7C694EC
              C39FDEC6A5DEC6ADE7C6A5ECC8AAF7C6A5F7CEA5EFD6ADF7D2ADC6CEBDCACECE
              D6C6B5D8CEC0E4D3B7E7D6BDDED6C6E7D6C6EFD6B5F7CEB5EFD6BDECDBCBF7D6
              B5F7DAB9F7DECAFCE4C8CEDEEFDAE2E7F7E7D6EDEEEEFFDECEFFE7CEFFE7D6FF
              EFCEFFEFD6FFEFDEFFF7D6FFF7DEFFF7E7FFFFE7FFFFEFFFFFFF13EBC2790000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              351C22153439000003F94944415438CB4DD27D4C1B751807F05F0221C89AC699
              CE4A1C7612C0F2521064A572C384A98C3111CB76E70E950E2B85C27891B7F2BE
              E6C7AF72F7831E8DF4BAD976D9AEBEA0C97410A0A8288CC1587032DCB2C926CB
              E6186C08090A2A6101370F16139F7FBF9FE479F2E40B74484791940E59582A8E
              E03B1D0C61436AC890D082360788208920280B66E958F5674BB78FDD5EFA5A93
              CED08C189ACD22A048368E882359B63D53957E67757EF4FECAF4A98C488DFA85
              669DB9D96C0134E2104B61ABB53536E6F0CCD4B0696A65FEC2A9687958EC9BC4
              4B661140C4B288B45AED1F46A9BE59BB693A54F9D7CAECF427D1AAF87D090994
              19017117A60816715951EF2CAD9D37553C73EEFEF2BDBBA7330EBCAE49202833
              6031CB438A81D6F6F8F45F174687CE3E5EB4BCBEFECFDD8EC36FBCA649A02880
              1884092DE23D4296EAABD9A9F1EAEBEB0F1EAC4DE41715A5A5ED8C2792000959
              4CB1B8B7AFF5BBEF9766AF0CD79EFB7C6C7AA232A7243F353A5AA52640227275
              777B9D7D82FDCF870F17AF8D0FE5A78EADFF7DA5B63855111119199F00D43616
              D9BDD8859EFF63E9E4ECEF933F568E2DAF5D3B535B9CAC88880857A901A228D2
              2190B49A1734CA0BAB371A4ABE98993F5F5B919BAC08DC161C1E0B388EA3DD6E
              BBBB670047A926566FD415949C1173634E72D0567F695814E8F60E0883BD8295
              E39288FD3F2C5E6C30E616579719DFDBA308F4F793EE08075EA7408A6FA22187
              9B351D8BE37565064361A1F1DD948840FF00E9B3CF0102DAB1AB47A05FECEA3A
              AE3DB632D9682A35941A73735E8D9049B63C191A0E3A2184B887C7FCD196E354
              C6E2AD9F4CE5797906FD1E45882CE0B14DC0D2981F7438FBBB928EC2987BBF9D
              ADA92ACF331C7A392844EAEBBB0930424E87CD6DB70B16DDC14F1746EB6ACA4B
              0DFA14C5D3BE0112695828E8B66288AD9C0BEF6FD535EDFA68E1FA507DD5FB46
              7D4A50A08F9F44A60C055E97954408B2E45B8CA52531EBCEFCC52335651BE009
              1F3FA95CA9044E37A3C63684AD0C63F9203BF3DB95C991FAAA0DB0D567CB2670
              F4B8599B1D41926174D94D9927967F19AF3715EA5F118144B6013A291B820CE6
              689A86BB9AB47BA7A72E37D694E9776FFF0F389193132B8F18ADD666B1C0BD5F
              CE4D8E3454E8939FDA26DE280B5602BEBFBFD3EBA1A0DB4AF77958187362F1D6
              A523D52208F493CAA42210B09DA290DA456A9D2DAEB6C4B7D3666E5E1DAE3626
              6F0F91F84AE472258024B29184D6DD2B385D9EB6839931D37357476A0A768BC0
              4F04A1A09782031E0E52DD1F93986F82993B27E67EBED45090B201A472793018
              7423C1C1926AC1A62521CCD6C69C1641E32320DB002E8ED45204B439699E841C
              6C4DEF98B9FC3FB003D8C5CEF3B4AD93D47A206C6B6A3F70F211080A91889F94
              CBFF055F23D3AD34668EB20000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C5445AD9C848C8C84
              8C8C8C948C8494948C94949C9C94849C94949C9C9CA59484A59C7BA59C84A59C
              8CA5A5ADAD947BAD9C8CADA594ADA5A5ADA5ADADADADB59C6BB5A57BB5ADADB5
              ADB5B5B5B5B5B5BDBD9C6BBD9C73BDA584BDB594BDBDBDBDBDC6C6A563C6A56B
              C6A573C6AD73C6AD7BC6B573C6B584C6C6CEC6CED6CEA563CEA56BCEAD63CEAD
              6BCEAD73CEB56BCEB584CEB594CEBD8CCEC6D6CECED6CECEDECED6DED6AD73D6
              B56BD6B573D6B57BD6BD94D6BD9CD6CEB5D6CEC6D6CECED6D6CED6D6D6D6D6E7
              D6DEE7DEB573DEB57BDEBD73DEBD7BDEBD84DEBD8CDEC684DEC68CDEC694DEC6
              9CDEC6A5DECE9CDECEADDECEB5DECEBDDED6B5DED6BDDED6C6DEDED6DEDEDEDE
              DEE7DEDEEFDEE7EFE7BD73E7BD7BE7BD84E7C67BE7C684E7C68CE7C694E7C69C
              E7CE84E7CE8CE7CE94E7CE9CE7CEA5E7D6A5E7D6ADE7D6C6E7DECEE7DEE7E7DE
              EFE7E7DEE7E7E7E7E7EFE7E7F7E7EFEFEFC67BEFC684EFC68CEFC694EFCE84EF
              CE8CEFCE94EFCE9CEFCEA5EFD69CEFD6A5EFD6ADEFD6B5EFDEB5EFDEC6EFE7DE
              EFEFE7EFEFEFEFEFF7EFF7F7F7D69CF7D6A5F7D6ADF7EFDEF7EFE7F7F7EFF7F7
              F7F7F7FFF7FFFFFFF7F7FFF7FFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D8317830000
              000174524E530040E6D866000000097048597300000B1300000B1301009A9C18
              0000000774494D4507E4021D0A2B39BD50DFA1000001984944415438CBCD534D
              53134114C46F14B48068818892CD522C65654B4FC02AE84199979D452DC5DB26
              FD1EEECC5A7A25546653ACBFDD3918E52BF16639973974D7EBE97E3D5353FFD5
              F9FEE12F04CBD9444A09835EBA33163F201EC64CBADC1D4378417A3B25C2B1BC
              FF7C199E91AD731123D60C4E3E1D5CC07F00A586610606AE82DE3F2F541B1188
              249BECFA308948B6F3FACC0003404961FC8C74DBB8AF16C69EF2FCAD43155831
              0A1C39509FAB43D6F6A47C3522481709B8E7A7B0123EF29715D19BD41809388F
              B1F49CA9FA2A078E31A86B93D68F9FFC22BC532A57AAD3C59073FF1202B33954
              A26F8D143E361395EF29809077BD8EFBE2D85ABEFDF0F7239FC571FB2D5C0661
              6F960B5BD7523C9FFEE36277A5D56E269D94DEA4A51126586BCDF5E8540E1B73
              8FDA419BF67C56C3B2B299F7B43E7D36CAA59935AF93B02D52EF1566FF5A742E
              EC687166390863525B90644B3FB87B71A1D1FCBDF069D054D0D4A52BD1653B8F
              E6EE07412B56903B8D31B5599C5D6E0621BDBC3AB6791B0BB3AD30BCB934A1BC
              D1C2CAFA8DC9FD5F6DACFED30FF9134F6675BFB1E184AE0000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Boutons\B6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200800000000561125
              2800000125694343504943432070726F66696C65000028919D90BF4AC44010C6
              BF445111AF5214442185ED818DA96CFC83E18A833317C16895DBCDE161760DD9
              3D0EDFC037D187B942107C029F40C1DA6FA38585DBB830CC8F61E6FB661608A3
              4A28B3B80F286D9B243DCA2FF3AB68F90D2176D14184AD4298BA3F3CCBE07D9F
              AF085C7EE93A2D7FDF9F6F49964630CF195AD48D058243723CB3B56306366EB3
              F484FC408EA4D292FC44DE934A3A76B3A9AAA6E247D36DB356EA8BA1AB337690
              A0873E06BC67842926A860D165D6AC9C22C60173820605EE6120982B94ACCDD8
              63714332544A704CCA48DCC6E3B7DDFA0DE832A2C6845ACEE10E8A9ACE0FEE7F
              BFC73ECEDBC960735E174DD1961618E1780CBC3F029D1C587F0656AF3D5E2BBF
              6FF3F4C46DCF3F6FFC02066E5074A7409B3E000000097048597300000B130000
              0B1301009A9C180000000774494D4507E4021D0D221ECCD7C706000000BB4944
              415438CBED92210EC240104527C12010956B919595D84A2412BB47A8C4209095
              486CE54AAE5059590449EDCACA31240FD106123A4D38409F9AE4BFF9D9DDACC8
              C25FACBE6376793D4544C49D370F43F53D944E44D2163D1942043488A40DD0AF
              A742A900B55780D6687015000A100FE6818332A0762E2E8C793173E5B51F84DA
              CD083E8E0DC1CE8F7C085647DE01F41140AF865001C43CA901C8A642A110BD48
              7A07349D0AC94D9B61AFEAEADC7C86FD7654776EF9E6BFBC018C8A838931511E
              620000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200800000000561125
              2800000125694343504943432070726F66696C65000028919D90BF4AC44010C6
              BF445111AF5214442185ED818DA96CFC83E18A833317C16895DBCDE161760DD9
              3D0EDFC037D187B942107C029F40C1DA6FA38585DBB830CC8F61E6FB661608A3
              4A28B3B80F286D9B243DCA2FF3AB68F90D2176D14184AD4298BA3F3CCBE07D9F
              AF085C7EE93A2D7FDF9F6F49964630CF195AD48D058243723CB3B56306366EB3
              F484FC408EA4D292FC44DE934A3A76B3A9AAA6E247D36DB356EA8BA1AB337690
              A0873E06BC67842926A860D165D6AC9C22C60173820605EE6120982B94ACCDD8
              63714332544A704CCA48DCC6E3B7DDFA0DE832A2C6845ACEE10E8A9ACE0FEE7F
              BFC73ECEDBC960735E174DD1961618E1780CBC3F029D1C587F0656AF3D5E2BBF
              6FF3F4C46DCF3F6FFC02066E5074A7409B3E000000097048597300000B130000
              0B1301009A9C180000000774494D4507E4021D0D22094F0442C1000001184944
              415438CBED932D6FC33018841F0D79CC30D4D030B07430B0703430B030B43030
              D0B470B065A585818629340C74D80D2C1F95F6177A92914FF7FAB95786B73619
              03D8E518A02AC01DF6FB7B2CA953453B35F8D8F3ADB12CC7C9AD063B680A590D
              9D1492EEB8A869D260B70817255D0C26488A0E5C92C6BF800F80E703E67E66BE
              CD707B8237F0B9077096B252C96152566EF09362D2586C8F1C15FCA88EA0E87E
              3452E6A1F0632EB784AA81A22D70670BA70394066CF152C4CAFFAF98452B7F71
              F986BAC33E064F93BE36C3CA5F4B6DABEC6D540A52BD272EFC264852BF14135E
              661EB3D401264A83012ED20BC4C64F2F299FA093B292DF0C2B7F25F557656F93
              FA32A9DF77B1F017438BE9AF96630DAEB5EF8FB0EB17EC1EAF25CB90B3E50000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F400000CAC7A5458745261772070726F66696C65207479706520657869660000
              78DAAD986B92E4B80D84FFF3143E02DF208EC367846FE0E3FB03A5EAEDD99959
              EF46B81555524B2C1204128984DCFECFBF8FFB177F29C7E6729156B556CF5FD6
              ACB173D1FCF3A7F73BF87CBFEF5F7C1FF1FF0FF7DDD783C8ADC4393DFF4A7FC7
              77EE973F7EF059238C1FEFBBF63E89ED9DE87DF09930D9CAB6DAFA6E24F7E373
              3FE47722DDCF45D526DF4D1DAFA9F31D784D793F499E1D7E26B1FFDDF71B59F0
              D22A8C4A31EE1492BFDFEDB1203D9F7ECF9D8F322EDC6B9F92BBA7F65A82437E
              D8DEE7ECFD7707FDE0E4CF95FBB3F7BFAEFEE4FCD8DFFBE94FBEACAF8FB8F8E5
              83507EEDFCEBE26F0BA72F8BE28F0FE2F6F3A7EDBC9F73563B673FBBEBB9E2D1
              FA22CABB8F77EC370C1CB83CDD9F550EE153B8967B2847F3DD4F82B3586E70CC
              A0211295E3420E2BF470C2BEE7192626E6B8A3708E71C674EFB52451E34C16A7
              6C47385192A6951A719B71BB94B81DBF6C09775DBDEBCDD058790586C6C06416
              EADF1EEEAF1EFE93C39D63BE0DC1B72F5F615734E4628645CEBE194540C279E3
              56AE833FC71B7EFF0D3F40950896EBE6C606BB1FCF14A3843FB0956E9C13E30A
              E7272B8293F54E808B58BB604C4844C0D7904AA8C14B8C12027E6C04A8637984
              7E061108A5C4859131A754A393D8A2ADCD6F24DCB1B1C41AED36DC44204AAA49
              888DA64EB0722EE047720343BDA4924B29B54869AE68E935D55C4BAD55AA915C
              9724598A541169A2D25B6AB995569BB4D6B4758D9AE0C0A255459BAAF61E5D67
              A1CE5C9DF19D3B238E34F228A30E196DE8E813F8CC3CCBAC53669B3AFB8A2B2D
              6862D525AB2D5D7D07B7618A9D77D975CB6E5B773F60EDA4934F39F5C869474F
              FF8ADA1BD59F8E7F10B5F0462DDE48D938F98A1A779DC8678A6074522C66442C
              E640C4C52200A0A3C5CCB79073B4C859CCBC4692A2448C2C161BB782458C10E6
              1D6239E12B767F44EE6FC5CD95F6B7E216FF57E49C85EEFF113947E87E8EDB2F
              A2B6ACCECD1BB1270BCDA73E917D8CE9545A3EDEF365E730720919E0377F6F74
              0F1F7187C56A1D38216D09496AC2F8B6C796D54FE263FFB93C2653CA39F023C4
              186BDE7D0D980E8B244A39098FC6B1A48BE27E39931FCC04E16ADC55C6585596
              B4E9D8AB943EBB4D03681A2343149DA7D63E4ED91062F127CEB38FEC60A3E03F
              1E7732177F1E02ACA7CCE25816EFE0D4CF2463B17638759B2B4F305B584B5319
              B1EE7C0762F91DAAA58C93D36E5402C7F6FB206827D4E237C99EA714734CA979
              76F81DB8F0DF91E0F775A5366F4FAD3A7F3FBB88A2B0DFF10380E78396A644B9
              C83C5AF6A9888071EA9A6B13B855B76250E6791A61AD820F8A15FA725C591990
              317A63B5B6350133EB8E3E24E672F1B5B4CF2D252929937009BBC7FD52F13AC2
              2AD533D269CE763C7D1CEAD91CBF620FBD9FE247CA6703AC6403EAF6D248DCB2
              157315C897342BA13F6B91D4BA4B72A0CDD6C58405C4AAADC6527D6B1D2C4DD2
              B221305E5A4869CF6EE69D86F9BB750BD9ACBBE89EA270F619B6FF8B8C1582AE
              7972EBCFA68E5FE42C5972819A7E895C928D9BD935DFFA98D00471E3975C8F14
              E73849C60298C2B2DAF2AE29AAFDBA00D339EA674EEDD9038E5E16E48FCB6B58
              322D0D906D236C824D960147E01D13B91C864EF05BE11A438A8110DFCFB562A8
              3797E674F5461E336D0DE5B6F7BB6017B3EE36F11D72013E1A64389E1DF876A2
              11871EBF572CB2208993B0C32D855751137DC24103E228830D9A1B4F6C0B5601
              9D77E359FB50086EED3DF0F8D8D11362F3789A73C090E00577AFD32D2DF103EC
              37CA0A58C95AE4E50E0FB691B356104D65B6180679150A660A68287B6F72AD25
              432E49592E72377499C0377959C968331F1AF310C8DD39C144A7DC2C2A30DBD4
              D558598B9301C59645EA96A37B159555235E642C3F9F159693BE13D4C98667DA
              6581265B759F5D6EBA047656C87E6060A047330E983FE164F078002868DF2032
              317D8726DBE99BF4C6294D0C8F068C3C018E12F4391C5834A6518E5A8FEFBAB3
              F4B52C96EC3A4230E68FB2CA4608A8398F34B3D454E8DCFC0F68B162B9CCAEE0
              9D9E96EF46967803E4201371116E18A9D01010E55430027E22D196804B10D0A1
              06D46904BA32DC0D57B0DC28D338CC321FE010F97C5390CAB3BA4EE0A7959C6A
              4CA3BAB00DECECC636BBA5E0E90E5860FC9B3C82847D69DFF38BCE1D25940499
              7A09A552A360885C700BF1994DB1DB8871826C60B4CC5BEB06C2C23F762D73E7
              F04C0DC6DF4BEB59DEF32DB0588553A63F037EEEF42237592BD198EB04C9C016
              DE4803695C9E9D52FE328489CF29F67BB1604C789554825212397C483C57EB25
              6838AB6FE296C03FA434A9B7C087B9282175DD23E08DB59898A8408FD4293259
              F3A602134427408EC9C74EE4583DB1F444DD3A760D6E29DF70DABC7E07920394
              6FF9B0D20F67577AD8D0D39B467DBE8E48FE97C3E1BB059BC131D71BD4F95BDC
              E61A2E203AF4A864F34A4349802ED270928B93BD88B9015A41C26E6A589B2689
              A8310BC24A64DEDE6F09A28AD483182E969E58B2A7B7EC2358165E7C0AAA8556
              4342A6485226F739063B087F5F4E244785B58B3B49C125751D85904FD5C7394A
              7621DB2EA48ECC993FE8FAEDD9FDE9C643FAB9D3EF864A0254534787DC075DE8
              F239E39A18732C6F49CBBA108495AC27FCA4FEA6AD925CC90C8693B2A66C2D98
              939A1D371E45AE8C21A69852F23A278E7C0A018DDF8B52F70557ABBB604A287C
              90FEBED540068476AAA0BBE8B7BA0EA28FD3A7E91C0C80ADC61871B6831A419D
              E1121D1F87148FF9F7B2FA9F52E337670A9238C289DB134C92E80550A39B8A2E
              562F602A1ECCB6E86442348EA2DC12260F64AF27F02166936E4498C68F9D2E95
              0D4E988172431A2406301602CC6F3D475BCE1A7F8D55AB0AB29CC735E4107407
              30831A930243B0628AAF9BA803541DB234922C1AADF093B12D7F64CB2AC074FE
              14FE9FCE4F6947C05A5247541B02C28A2D6921E1EC690DB2F9C17D1C511579D2
              FB2C264632B0C9C8D39C6094635A84C1282BDBF3B6860F75632992E718600574
              74C7777CF4AC243C229FE8E5D97E99B6DFD534DE9EA640ACBA3B538FA4A51C0F
              771D93ACB95B453761DC8CE8A977114BE8314C38A0FF2E93459C99833E2CBABC
              36D77EA52C7F3A9708A57612660179FCEB8D3A62874E7B21A02434D94FF55A56
              D1E1AD35ADB5A5C42413CCABED0A45519E9EF88C4553FC3BBE72DF6E5CC8DCAD
              6FBA4B041617D30AEA44BE231600DA05068C8E40001A13B971AA45E00C073836
              CA1CC5A29661071D530C9CD2F62B9A292DBFE3D76F67F7A2D30A2AB8F43454B7
              F0B330FA1AE5C346D083A64749D80923CA4C561FADBD32E12108219C929DC901
              7B25F0F874B416FF0E4411386B8251F046E936CD0A8E0000C85A26D833BB4CE3
              5895A7A76D146C847243099F882C81B696A90688D9A44017DC324C3650A906FA
              A80C13D528E60F5F51D8FED223C50A7A41CA5A4167FC843A3CB51F45CE414F81
              E24A24EBB6869424E94FD53D36343F35B786DFC2CD7D2E1051D62E5F9A6E567D
              0E0211D1401240D8A6E528EC8F3A863A0BE23299207C1648435DBEF4AA305635
              2221A70719B9D385E519864B8BA1229591B4BB1ADCC4329B021FD171FB2D36EE
              8B51BF350826C221DD4CC73CBBD790F7957C6C1B86BE8A2F57D1215493632F3A
              4EF3D5412968F0A3911061F6601FCDBA661B796CE46D3F99FD338E181A996152
              DFC176E88727791DB6949F7BC2DB765837796D42C553A32167CEC6061E76B7CD
              0F937DA6F1D11C8EFA9B02424F9ED04382B5CEB77E872F7C568483C9280A2892
              84825429905DE23423B17D2D07D78B95F91969E9A7274462FD213D7B463F4EFF
              04BEB73F90FD96348414416626489DF6DD59E9EB8D84D5AB2328515B9A86D56E
              1361DD43DFFED56B40999C4655B097C0A6E947B007CBD0ECEE851A56E46FD974
              5F9120C3355733AF25EB027117CE9ED6D0D1A392AF5F9D98BD40C8D739D12A99
              9AFB9F9E2B7B6B1A98B67FEF1A9FA7B8CBD49D2EA3ABDD27995807C8D66EBD1E
              BA294209529E6003DD56E669D3D27059B9379D6875321AA59C6C8250B452749E
              2E6FBBCD2DEA85815563C709082DBCD04D5F156B1A581EFA37E98470DA5FAF35
              56A5D8AFE5CD7968D7E80691B2298306FA77304875BA15AAB17564DE22D1D3E5
              20ECD19882B5CAB67B8A1C6DBE123A8B1F1399868AE32B43018F6E439DBDD102
              5874D980BB19600C8067E803C033BDF938D2795DA6734001232D15FF52C9C4E7
              7D89BD4ABA6F40B08862364D7E976A4CE33A34643D70D81EE169A600946474D2
              13D916A113924CCEF601114831C9E1562E448042D6050128F60AC77DCF60B491
              21BE5B1D6A243C140FD750E2A0943B97D795507F5694CC65D602E444E7C10C0E
              0E6ECFFB912031DCF757384DAD5DECB6662537E51B0B50AC054D380D148DCF2E
              4001AA7730AEF5B25FEF53BCB726D1FC5629CAA8B49D880009D5735C4FA1537B
              13D11FC1338C5B1F55FB2D1FCF59EAFE0B0E0D1DCC6899F1B3000000657A5458
              745261772070726F66696C6520747970652069707463000078DA3D4A410E8030
              0CBAF7153EA18346B7E72C9D076F1EFC7F648B11D242A176DD4FDAB610BBB106
              A2C5F0107F00251D3C643B419F8331551B6CAB4DB5278BEE4E37720AAB1EBE88
              B417F581175A0C6361E900000185694343504943432070726F66696C65000078
              9C7D913D48C3401CC55F53A52A15073B882864A84E568A8A384A158B60A1B415
              5A7530B9F44368D290A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A3
              93A28B94F8BFA4D022C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7
              C46C6E450CBC42C030BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7
              E7E855F226037C22F12CD30D8B789D787AD3D239EF138758495288CF89C70CBA
              20F123D76597DF38171D167866C8C8A4E68843C462B18DE536662543259E220E
              2BAA46F942D66585F31667B55C65CD7BF21706F3DA729AEB348710C722124842
              848C2A3650868508AD1A292652B41FF3F00F3AFE24B964726D8091631E15A890
              1C3FF81FFCEED62C4C4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B27
              80FF19B8D25AFE4A1D98F924BDD6D2C24740DF367071DDD2E43DE072071878D2
              254372243F4DA15000DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80
              834360B448D96B1EEFEE6AEFEDDF33CDFE7E00D8E072D047B5787C00000F5569
              545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B
              657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A72
              65537A4E54637A6B633964223F3E0A3C783A786D706D65746120786D6C6E733A
              783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D22584D5020
              436F726520342E342E302D4578697632223E0A203C7264663A52444620786D6C
              6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30
              322F32322D7264662D73796E7461782D6E7323223E0A20203C7264663A446573
              6372697074696F6E207264663A61626F75743D22220A20202020786D6C6E733A
              697074634578743D22687474703A2F2F697074632E6F72672F7374642F497074
              6334786D704578742F323030382D30322D32392F220A20202020786D6C6E733A
              786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F31
              2E302F6D6D2F220A20202020786D6C6E733A73744576743D22687474703A2F2F
              6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75
              7263654576656E7423220A20202020786D6C6E733A706C75733D22687474703A
              2F2F6E732E757365706C75732E6F72672F6C64662F786D702F312E302F220A20
              202020786D6C6E733A47494D503D22687474703A2F2F7777772E67696D702E6F
              72672F786D702F220A20202020786D6C6E733A64633D22687474703A2F2F7075
              726C2E6F72672F64632F656C656D656E74732F312E312F220A20202020786D6C
              6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F
              312E302F220A202020786D704D4D3A446F63756D656E7449443D2267696D703A
              646F6369643A67696D703A66333930626237312D373234322D346637302D6233
              63322D653363626533343965363539220A202020786D704D4D3A496E7374616E
              636549443D22786D702E6969643A35393334376431652D343039392D34636261
              2D616464342D336364396233623031323363220A202020786D704D4D3A4F7269
              67696E616C446F63756D656E7449443D22786D702E6469643A62653338346133
              332D383930662D343135612D386537622D313166306461316364663032220A20
              202047494D503A4150493D22322E30220A20202047494D503A506C6174666F72
              6D3D2257696E646F7773220A20202047494D503A54696D655374616D703D2231
              353832393734313839323738313237220A20202047494D503A56657273696F6E
              3D22322E31302E3138220A20202064633A466F726D61743D22696D6167652F70
              6E67220A202020786D703A43726561746F72546F6F6C3D2247494D5020322E31
              30223E0A2020203C697074634578743A4C6F636174696F6E437265617465643E
              0A202020203C7264663A4261672F3E0A2020203C2F697074634578743A4C6F63
              6174696F6E437265617465643E0A2020203C697074634578743A4C6F63617469
              6F6E53686F776E3E0A202020203C7264663A4261672F3E0A2020203C2F697074
              634578743A4C6F636174696F6E53686F776E3E0A2020203C697074634578743A
              417274776F726B4F724F626A6563743E0A202020203C7264663A4261672F3E0A
              2020203C2F697074634578743A417274776F726B4F724F626A6563743E0A2020
              203C697074634578743A526567697374727949643E0A202020203C7264663A42
              61672F3E0A2020203C2F697074634578743A526567697374727949643E0A2020
              203C786D704D4D3A486973746F72793E0A202020203C7264663A5365713E0A20
              202020203C7264663A6C690A20202020202073744576743A616374696F6E3D22
              7361766564220A20202020202073744576743A6368616E6765643D222F220A20
              202020202073744576743A696E7374616E636549443D22786D702E6969643A35
              623262376234352D393234632D343239332D383363312D393962363266646161
              353339220A20202020202073744576743A736F6674776172654167656E743D22
              47696D7020322E3130202857696E646F777329220A2020202020207374457674
              3A7768656E3D22323032302D30322D32395431323A30333A3039222F3E0A2020
              20203C2F7264663A5365713E0A2020203C2F786D704D4D3A486973746F72793E
              0A2020203C706C75733A496D616765537570706C6965723E0A202020203C7264
              663A5365712F3E0A2020203C2F706C75733A496D616765537570706C6965723E
              0A2020203C706C75733A496D61676543726561746F723E0A202020203C726466
              3A5365712F3E0A2020203C2F706C75733A496D61676543726561746F723E0A20
              20203C706C75733A436F707972696768744F776E65723E0A202020203C726466
              3A5365712F3E0A2020203C2F706C75733A436F707972696768744F776E65723E
              0A2020203C706C75733A4C6963656E736F723E0A202020203C7264663A536571
              2F3E0A2020203C2F706C75733A4C6963656E736F723E0A20203C2F7264663A44
              65736372697074696F6E3E0A203C2F7264663A5244463E0A3C2F783A786D706D
              6574613E0A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020200A2020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020200A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020200A2020202020202020202020202020202020202020202020
              202020200A3C3F787061636B657420656E643D2277223F3E395D974900000009
              7048597300000B1300000B1301009A9C180000000774494D4507E4021D0B0309
              C7162B90000008214944415458C38D977B6C5CD511C67F73EEBDBB6B9B241853
              037E353410A0798028241029014A10A550A0121495520A05A152514AA9543525
              A81004A481AA121281A6A848F48F8008B4A2E40182360F40140A79D48EE33C71
              C8C34012DB891F7BF7DE33D33FF6DA38EB90E4482B7977BD7766BEF9E63BDF88
              99F1E531D4128C103004302F20096A42520A68DBD46BEBD7F6D3B527A1A76710
              23A0765C35CDCD1193A7E699F4CD5A89F28A13C534445C8A910279C0E3240464
              386248C5118B1029823920C09BD2B6B164CF3CDBC9F2159FF359A7C3AB62E230
              C9817940715222084B348CCFDBD55735F2B3BB9A39676220A20E2700258CDCC8
              D859BC0A04CC1230A5E4433ED955B207E6B4B3EC1FDDC4710193220898858818
              46829800B961D4B09480907CF521AEBFE9641E79682ACD0D4E4227887890DC61
              0888998E882F188692B2F8C5CFECFE5F7570601F9819AA0E087152A2A9D933FD
              A21318DF3286EA6AA1BFE8D9D939C0BAFFC66CD91E6396431C088EFA53629E5E
              3895EBAE3D459C8088640964857B8D51AFA816514B19289698F3C0460B82370D
              F9B7216F9B63A549F0A6DD78C307F6DE7BFBAC949650AF784D519FA2AAE5F7BE
              C4BA0D07ECF63B3EB6285A6EE2D698B0D2F2D1527BFC0F5BADAF94A05A423545
              35417D0AA97A5407501F936ACA9C075A2D1FAD3678C7845526AC32586313CF5E
              6A7129C5FB049F28DE7B12F5789FE23541D5E35549D22249A22C5BB1DBC68E5D
              61B89526B2DAF2C19B36FF892DE6FD501203A8F7B832DB03120D58BCB8CB16CC
              DF4B9C38A0589E043170456EBB75020E61D15F77D8AC59EF5A5DED1B561DBD61
              E3C7AFB29FDCFE3F5BBB7EBF898F09252414CF95B3EBE5E985937032080825AD
              E2F7733A797D69B7A56A6592CB20E2D523E6E9D811DBCC19EFB1FF8B5C360156
              1E1F09A92A0CB275DB2CD6AEEDE6FA6B5BF1E4300354404270831402C7530B9B
              B8F3A7678A09982AE6850BA7BF65EBD7556392209AA3A1A9C83B1FCCE4EBF539
              C19570A68257C7DCB91D1CD81F6126189A5124C0B988ABAEAEA57A4C7EC2AFEF
              6F23F5F9B236A8CB889B828F2896027E714F279B36F799A8C74940101A975ED2
              82490C1A0125BABA723C3CAF15354335C4999568DD3868CBFEDE9331D30E1B13
              B39835AB0E316BDA9A6D1D9B874668E87B197E89087131E2F57FEEC1C40DB3BC
              A6C6C0CA22648460294BFEB69FED3B8B061E87042C7C6607719C47BDABD4254C
              E18B2F225ADB1310E3ABCE909C988159194153474747DF887C15EF8581FE1A16
              3DF72906B82476AC78631F469C09E348A92A8B0C4E81AA72CF47871EFECB0531
              577EA71E87620A9F7F36682B96F7802408392001224C8A2C5DDA85F721616B5B
              B77575BA110FB38A241250323D1F1D5C0831497104FCFC9E3AA64CAE15515089
              B9EFBE56FAFA73D97F2660119062E6D8B6D1B3F3D301731BD60DE0CD0301821E
              218800AEA2F723527031620157CCF63C3EFF7C7178BC53E6FE6EBB2D79B5EF08
              9C312024F59E0DEBFA08F7ECF6208E2F255938FE2338735C76A963F1920BAFA8
              8E8C8383C6BD77AFB7175EE8294FF32844B33B07C7EE5D2961774F8C59083298
              4174B46315951857CCCEF1D22B17CA98EA901DDBFAEDE65B3EE4C38F049320E3
              8C8D4654524472EC3FD08F237019C843501FAB6805110895CB2F0B58F2EA3439
              A12AE2B5D7F6D8B419ABF8E04387A91B11B7B27A370203C3D58E8D3049308B8E
              90ED11F8600E3138E78C1C2FBE72C1CBB982F1F88236BBE9C6ED741F1853D1EF
              AF40D1428484BABA31B896E600C11F67EFB3299101E62F68E1A4B1851FFCE98F
              5BEDA107F750A23FD3023B660D8243509A9A1CF2F1C7FB6CDAB40DA41EC42433
              62474F4224A1F7D0B7E560F7A04D98F83669E964BCF7C781E0107D8C5CE869DF
              7231EEECB34E92C6D31531771C3FB76C5C53FABA13FB74672F69A906B5048651
              3CC653CC8153264F09686A2C888B729E6BBE7B1A3264A98EFA80CCA052CD238F
              B573DE05A7CA79E7BBCC968565821EB38004A779AEF95E03CE1992A625366D4E
              6CDAB7D6502CE65073C7C6503C6120DCF0FD2AD6B6F5B2755301AFE5CFCBF97F
              751B5DE039B1DAF8A8ED629A4E0DC541C8D913ABE4FA9BEAC00587CDF891E31B
              A105A426BCF48A67CBA62A0C0FA4998F38BA861801B7DC5E4F636324220E519F
              02C6B65D89CDBC68355D5D791C865979522BAB1157F60B7937C0E4F30A2042EB
              DA0162AB46D45176D97258C25880088032FE74CFEAF767D0589793EC3A4E4012
              5A1A0359B8F05CA27010239F09A81E9144752716F9D7CAE9BCFB9F4BE49DF767
              CACAD51751372E4646256C59E12920E4ABFA7876D154EA6B45200529E2200284
              481CD75D5B2FF31E3D8B4852440A59D6157B033137FFF81B5C3CA346F2221470
              4C9F5E233FBA750226A5D11D134524201FC43CF1E424665F364E221766DEA20A
              0749D9B18822C02FEF6D92790B9A09A35E8C60444596C968484F4F2F6679B4BC
              4A6096A7BBBB17CB8A39FCCE100A558778F2A933B8EBCE6611C22F8D8D552E26
              805A8A99F0FAB2FD76CFDD1BD8DB954724254D00224484308899F7D869DC79C7
              C4971DF6D673CF6FFEF3DCDFEEC5A72146885142028F48444B8BB2E82FE772F9
              A56345244490C39C55C56A5676B398A2787677A93DFA703B4B16F7D0D35785BA
              38EBABC3398F631053874A98F93D072881E5A91D57E487B79ECC6F1E3C93FA5A
              370CBB4850B99A55EE860A94CA57A9E549C5F349E7A03DFFDC2E962FDD4B7B7B
              8C4FAB3019C0640C9822AE04BE40181E64F2941AAEBEA681DBEE68A0A93127A1
              8420E9705B64F46E58B99EA718016245841CA665C814C3FB909D7B8BD6B1A19B
              CFF7841C2C1E04E0849A02A7342893A67C8DA6530B22E27162883924D06CC9A9
              2AF75C02327603F07FFCB23FA9BE5A05930000000049454E44AE426082}
          end>
      end
      item
        Name = 'Boutons\B9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C54454A00397B003E
              981800A21614B21505AD1810AD1818B11428942129942E2088351473661AA929
              08A43120963F41A24846BD0008C50A02C51505CE1008BD1410CB0D10C30A20BD
              103CC11C18CE1818B9182DC51E31B9290CC33120BA3647C3544500008C10137B
              0800940A12980000A50002AD0804AD1505A40400BD020ABA0810BD1208B50205
              CB0A02D01400D21210CB420084310A973D2067373D9C2110BD341BCB3931C545
              49C3770C566D1599861562C34E545652B95852E06260E18764DE31B52923C51E
              35B53135C3331CDA1826D32331DB2333D33115EC0D21E71010F70C1CF71018EB
              181EE6222BEC1E2FE42B4EAD4652B94E46C6354CC6463CDE2939D6393FDE3E4C
              D44C5EB9415ABD6068AA3EA8943D5ECA5E6BC85D57DE3F5AF15866BD676BAC81
              67C56F6BD26DB5737B99A2897ED07597DE8E6FEB6786F1758CEB988CFB8EA5E7
              9C9EFD96A7F499B9F9967B7BCE848CF4C183B1B1A0F2A0CEA5ADB8E1BAC0FFCA
              C1FFA5FFA9ADFBADB3F7B5B9FFB5BDEFBDCBF9C5CEFFCECAF7E4D61000D61C08
              D61018DA1414D62118D61021DE1021E22835D64229D66352D6737BF16B73DE7B
              94DE8C86F77B7BF79A89DE73C6F78CA5EF949CFC99A7FFA59CF4ADA2F3B1ADF7
              AFC0E7CE9CFFCAB9F7C0C8FFCEC6DEDED6FFC8D6FFD6D6FFDED2D6EFC6D6F7D6
              D6E7DED6F7DEDEDEDEDEDEE7D6EFE7DEEBE2DEF7E7D6FFC6DEFFC6D6FFCED6FF
              D6DEFFD6D6FFDECEFFE7DEFFDEDEFFE7E7EFDEE7EFE7E7F7DEE7FFD6E7FFDEEF
              FFD6FFDEDEFFE7D6F7E7DEFFE7DEFFFFC6FFEFD6F3FBDEFCF7DED6CEFFD6DEFF
              E2DEEFDEDEFFE7DEFFDEE7FFD6EFEFD6EFFFE7E7EFE7EFEFEFE2E7F1E9ECE7E7
              FFE7EFFFEFDEFFEFEFFFF7E7F7F7E7FFF7EFE7F7EFEFF7EFF7F7EFFFFFCEFFFF
              D6F7FFDEE7FFE7E7FFE7EFFFE7F7FFE7FFFFEFE7FFEFEFFFEFF7FFEFFFEFF7E7
              F7F7E7FFF7E7E7F7EFEFF7EFF7F7EFFFF7EFE7F7F7EFF7F7F7F7F7FFF7F7EFF7
              FFF7F7FFFFF7FFE7FFE7EFFFE7F7FFE7FFFFE7E7FFEFEFFFEFF7FFEFFFFFEFE7
              FFF7EFFFF7F7FFF7FFFFF7DEFFFFE7FFFFEFFFFFF7FFFFFFFFFFE06E12590000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              1A1FA9005DEE000004254944415438CB0D937F54536518C75F3450445AA18840
              400886B94450E48782A488401C5042240483C45063A4088140AEACA8CCD002D4
              D40C53913A420D0D0EBACC883A76029BE8564CD9DDDD816DB17BEFB371B68BDC
              5BBC6FF7DFE779CEF93EE7733E5F6413F96B531400B10111048E9B9901A069D1
              E17C0CF040C01C2284BF264A33BDF1EF83046B09C63A1A40E49DD3405B043C81
              580D6927601D6B0D5E8BA40D300C0346ADC85FC7008220D810E6483B0C8E3579
              07F8B99D867BD285110887454200CC82684136C6F20750E7E606CF695C7C544D
              01C6431ACCB2F881F4968E886348AD37B4312332D941B7C005EE276E18871343
              2BFBEFB22C4DDF239A41E63E0A3C76EEABF3CD9EE793A3E2FD7C1704B5AC8A96
              2F8F595FD3AF03AD14436CC8DF63AE4C263B3B1A2B4F70F35BE41F109F9CB454
              1EF16CE8EA9F01DB08D6206F4F99ACC9408FCAE5555151097E1EB33F1D1DA83A
              101B2E8F1D60F104669141ADEF83A1E19AF035A3D1916B3E0BF860D608806E68
              FDD295B1FD777F7BBD1D312330505BA9AB8C48FA33794564427CE39196D10704
              B34911E1B189AB348040870F848557252DA984AA6591D16B17BDBFEE116331B1
              03894BE2AA38D68C741C97285FB172B9BC86FE35E6B9D0BF021B03CF52261E73
              9A5A0DF78F538930CB0DC444BEB03C4C82131756337A2C70CE314A340B1C8086
              EF3D5484B00D0FD4CA973DBFFADFC7EFBC76E73FE69C877FD08DFB0296A88B3D
              15699B1011CD43C3C9117177BEAF2FD8F55DB7551FE2F3C4C99F54CE7102A6AE
              8D5B32111885EB1ACD5BD85997B23DAFA2D34A35FB3CE3B57F6F91F231B6BF91
              BF2D03192941E81034B86B676A5676B1CA261AE6CF2ADCB121ADB4FBEBCE92F2
              E26D887709C2450CD37529A959E9694AEC9A2C2CF4DAB12D6BF3BE6FEB4B9415
              AF203C8DA72F4E70CEBD79C55B5ECADEE3EA5678CD9B57F86A56C6A68A927AD5
              D5120434D83A4C96AEDCED87F233D373950D255F782E0CD99F96999E5AD4EBB0
              574B9AD1A4E30787E2E562657946664A4569D9ADE00F17FEB86F7376CA9B0ED1
              7509D9249BDBC77B76E6577429F3B2538B730EDFFAA4F1A9333D3BB72ABAC731
              232297CA61BFA46A2828EBE27BF7A6E5BDB8C73E79D2D7BFE9F6E16A1337C36A
              29E4ECAC2B2F2DDAAAF88610555D6E4AA98A37B52DF409514F11A059C968D450
              929B9B9BA3B0131A5CCA825D9D2E91BFFDB1CF6CFD43A01F32CC2041F91B73CA
              14571DE6214E50A9DE56BA448A1F3B1AE4DD6AB5B6859CB86598421BCA95BD17
              1C168EC382DDE570598C6056B7CE5E7C5CAFF6F49E1F74E20CCA69E835DDB44A
              9502C1C54F4E8A1C580C7D1E8D1F9DDEEDED7EE4DD05BEA8AC53809B52797540
              CC5651329DB55AFBD605049C1AE93BEEFEB4EF7BA8DA4EE032833101811741CB
              E1697E8ADAFD64B39A61F46D4D2D9FA30B76F28BF6F2952BEDBF777C392851C5
              D35356EAEC29CA200A362BF388FE1F3E0086E26B2B04950000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Boutons\BA'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C6000007D37A5458745261772070726F66696C65207479706520657869660000
              78DAAD576B9233270CFCCF297284012104C7E1A5AADC20C74F0BB0D7DEC7B7DE
              4D3C6533060684BA25F5B8F9CFDFEAFEC227942BBAC8925349E9C227965842C5
              4DBEF6A7AC5F7FC5F5BB3EE10CE1FF53BFBB0F0474115ADA7FA59EF915FDFCF6
              C06D0FDF9EFB5D3E23219F85CEC06D41B29D6DB7F16824FAC3EEF7F12C54E6BE
              4925CBA3A9ED98DACFC465CAF992EC13DE16B1FFEEB1230ABC3418B32884499E
              AEF59BB705B4BF75B515DF82797EDD5F541C1AA6EB5802873C1DEFD65ED7A383
              9E9C7CBB73EFBD7FBF7BE7FC504F3FBDF3653A3EC2CDA7039E3F77FE72F1C3C6
              74B7283C0F8470D50FC7395FD59155E73E5D8D091E4D875197BB79C79EC1C406
              97D37A2CE1127C19F7B2AE822B639B0E70C6D5AF86ABFBE2035051E7A31FBE7A
              F573B5DD779818C30C8236841E68F56592504227C329DAE53508151A94815B0F
              D311A13BDC6DF16BDFB2F6EB3E63E7E13135782C66507F79B93F0DFEE472AADD
              5CE4AF7CF715EC0AC65C9861C8D92F660110AF07375E0EBE5D07FEEB813FA02A
              10E4E5E68C03D6ABED251AFB376ED1C299308FD1EEA8F04EC659002EC2DE0C63
              3C01812B79629FFC252188F7F06306401596078AA10101CF1C068C0C91280527
              2107DB1BCF885F73038714AC1BB909403025126053A802AC1819FC9198C1A1CA
              C49199130B67C7856BA21413A794245992AB421285258948962235538E9973CA
              92732EB996500839904B2A527229A5D6E02A36AA58AB627E454F0B8D5A6CDC52
              93965B69B5833E3D76EEA94BCFBDF43AC2A0813431D290914719757A37912966
              9C3CD39499679955C135258DCA9A54346BD17A47EDA0FAE1FA016AFEA0161652
              364FEEA8A1D789DC96F0964ED8300362217A202E8600081D0CB32BFB18832167
              985D25202838C048366CDCF08618208CD307567FC7EE0DB99770739C5FC22D7C
              879C33E8FE0FE41CA0FB88DB27A80D4B777D21B6A3D07C7A11A20FCF67F02857
              2D8554E0AA80FFC883BF6BDD2B13DBCC01FB5DA90DD2D9A74E95898C60F1A939
              A97257A7B374D11987595FC6641FD9E3985E25D86D64AB7BDFB7EED589EF5B96
              DAAA5C030699BB931B8900C86C5461749F5191895BA90A341270EB0596E5211E
              01AE502E15DAA59334DF26102D7A21D292B00E57A597392568185A070EDFA484
              D93D2BB28DF4CE3C33AA0E7212CD9E46E5393D26C4064F4887B7E0297BD8350C
              E1692D154F2FD3B1A7CC5A7F785EF7BA63780E62ECCD49064EF57CC4E2D0CD65
              88A68242D54A6FBD898D8D39607F4318D636CC4E46E5CB0BD378F99911600883
              D0C0F9882288A3B10543D6C112B817D146547428788E00C150C52E24A32F56D5
              9968F4CF28E77E49E636526A13E62294E0EE46AE691B9A453B50F18042C806AA
              80B885C4EE2D96419B52D7096B924EB7235EF796116B5517D4D09F8536AF9582
              CCF9236247F71571393D11F75BDE3A10177EBE00DD1F89FB156F37F380A8F31F
              CF7B204EF0A80FA5452428A4670F3C91A6C6A52DCFAB9BF7CAF2A126D07BBA71
              5B15F278F4AF56FD632B039E70504AEB3000135F906E1E822659041D7D888D80
              4FF00C4E4B2016B2E70C05618804D529F936B21BCA6D74A4A7E3C941DB935212
              3C095F0C785252E8D8383573A3DF2CC792D830A3800C3BA0E32E004A7AA247CC
              90AB8D0F34D6CE8A0A635E533B0AFE050436DBB894ED966EA8B5FC0BC73028B1
              ACA9D8B10C1DD369471ABE0C689DF0003685D750A74B5BD467427D9AB4E27310
              C87F620E603578154A096AB96A5337DF4208F31ADE3DD06DF5CD5E98F623D602
              727B98B8CE0A5C18F110639DBC433F8FE6A2B95AE8447ED415F93CD922DF8887
              6747DE4B2AD833383EAEFFD6BA771B8FFAC3D040478489D1793392054F4F8EDF
              85A7216D2005C315EAF361823B33FC8012C963FFA9CCF494FE5EC87EEEA5F4F7
              79DB631D0DDB2D57B8A2103F23E0A8CB17904887DCBAC91D36B987C0591D6A41
              B1FDC61681D261B77E56450EA3BF2E24C6ED1D129676C0758B3878999A5B7C78
              214D7C9725DC6B51E167B10C8C28859E4785430824F05F041258F13ED709CEAE
              05DDAB16ACF2CBF63BF1AA4804478233D3D7131D880478A923455E4F849F3935
              37B7C2B2D8B159581EE1A3FAC05C2D00A19940AA508516F466D5FB22E17EA96A
              4E119FC478F384E7222C6A4B67A8E90C93B0231DA551EE4A43B7D010131A9880
              CA8F344258A7619DB2578018C5B40AAD4A2602F04EBA73ACEE1C5B768E4DC8B1
              5D111B2ABCC4C093125888B895F9B006AA8B099A27A814CB081CC4BD22BD0A04
              614A84C91308411A42FF03A6B06082458B5EA3DD5205DEBC5BF98518705F0CD4
              B6640B942ADE0E2D73E94A5C486DF596B8E8242E5D89CBA595B9366906811864
              0203515856420A4848F0E6799C683D6E31AF2BE6D30A79306B59D46A46F27B9F
              F89A37F508BFC037706E6FB9ECFA9756FD9B00F7D43F3228506947DA05505701
              CCBF1492EE671C94DADFA4EE2E4615813EB423D6A6553E9C1C124AC79259DA77
              DCB75B0E8A9629C0B888922C6169CA2DAFF24AD4B6814BAB767A235B03DD01D1
              3596A01E20FAAC0DE2E5C81A3DB2A66D59A30FB286206BE6F51B01F2B1755FA7
              A0EE8729EA6A85B91F650D38507B10385E0B9F9882CA4454B9CFC2CA54B97F08
              AA022AE0E561C52B528894525051A0D291784023B9E05DD7578D4795DE0A766E
              72B7DE69CE2F8AEAA7AD7B75E2E72D1431FB5591DC0E861F542454F5D99046F1
              B2FE184BEEA5609A757E2723DC7F3AD96F17C26B6F71FF02EC3FBD7A08F5B490
              000000657A5458745261772070726F66696C6520747970652069707463000078
              DA3D4A490E804008BBF30A9FC0B4B8F09C09E3C19B07FF1F19626C032D2D72DD
              4FC852B04D7818CC6DA8257F002D14DCD376823A07636A6ED0AB8D6C4FB6BC3B
              55E8296BBD7D115D5EF5E5176347C87B5200000185694343504943432070726F
              66696C650000789C7D913D48C3401CC55F53A52A15073B882864A84E568A8A38
              4A158B60A1B4155A7530B9F44368D290A4B8380AAE05073F16AB0E2ECEBA3AB8
              0A82E0078893A393A28B94F8BFA4D022C683E37EBCBBF7B87B0708F53253CD8E
              28A06A96918AC7C46C6E450CBC42C030BA11C5B8C44C3D915EC8C0737CDDC3C7
              D7BB08CFF23EF7E7E855F226037C22F12CD30D8B789D787AD3D239EF13875849
              5288CF89C70CBA20F123D76597DF38171D167866C8C8A4E68843C462B18DE536
              662543259E220E2BAA46F942D66585F31667B55C65CD7BF21706F3DA729AEB34
              8710C722124842848C2A3650868508AD1A292652B41FF3F00F3AFE24B964726D
              8091631E15A8901C3FF81FFCEED62C4C4EB849C118D0F962DB1F2340601768D4
              6CFBFBD8B61B2780FF19B8D25AFE4A1D98F924BDD6D2C24740DF367071DDD2E4
              3DE072071878D2254372243F4DA15000DECFE89B7240FF2DD0B3EAF6D6DCC7E9
              0390A1AE966E80834360B448D96B1EEFEE6AEFEDDF33CDFE7E00D8E072D047B5
              787C00000F5569545874584D4C3A636F6D2E61646F62652E786D700000000000
              3C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D70
              43656869487A7265537A4E54637A6B633964223F3E0A3C783A786D706D657461
              20786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D7074
              6B3D22584D5020436F726520342E342E302D4578697632223E0A203C7264663A
              52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F7267
              2F313939392F30322F32322D7264662D73796E7461782D6E7323223E0A20203C
              7264663A4465736372697074696F6E207264663A61626F75743D22220A202020
              20786D6C6E733A697074634578743D22687474703A2F2F697074632E6F72672F
              7374642F4970746334786D704578742F323030382D30322D32392F220A202020
              20786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F
              6D2F7861702F312E302F6D6D2F220A20202020786D6C6E733A73744576743D22
              687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970
              652F5265736F757263654576656E7423220A20202020786D6C6E733A706C7573
              3D22687474703A2F2F6E732E757365706C75732E6F72672F6C64662F786D702F
              312E302F220A20202020786D6C6E733A47494D503D22687474703A2F2F777777
              2E67696D702E6F72672F786D702F220A20202020786D6C6E733A64633D226874
              74703A2F2F7075726C2E6F72672F64632F656C656D656E74732F312E312F220A
              20202020786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E63
              6F6D2F7861702F312E302F220A202020786D704D4D3A446F63756D656E744944
              3D2267696D703A646F6369643A67696D703A66656337306136662D623237652D
              346331622D613637392D343830623636323365333931220A202020786D704D4D
              3A496E7374616E636549443D22786D702E6969643A37323635653334372D6533
              31382D343061662D386133392D646439633936653431623439220A202020786D
              704D4D3A4F726967696E616C446F63756D656E7449443D22786D702E6469643A
              30623065326266352D326436652D343531332D626637332D3535353664623130
              36376131220A20202047494D503A4150493D22322E30220A20202047494D503A
              506C6174666F726D3D2257696E646F7773220A20202047494D503A54696D6553
              74616D703D2231353832393734353931383233303030220A20202047494D503A
              56657273696F6E3D22322E31302E3138220A20202064633A466F726D61743D22
              696D6167652F706E67220A202020786D703A43726561746F72546F6F6C3D2247
              494D5020322E3130223E0A2020203C697074634578743A4C6F636174696F6E43
              7265617465643E0A202020203C7264663A4261672F3E0A2020203C2F69707463
              4578743A4C6F636174696F6E437265617465643E0A2020203C69707463457874
              3A4C6F636174696F6E53686F776E3E0A202020203C7264663A4261672F3E0A20
              20203C2F697074634578743A4C6F636174696F6E53686F776E3E0A2020203C69
              7074634578743A417274776F726B4F724F626A6563743E0A202020203C726466
              3A4261672F3E0A2020203C2F697074634578743A417274776F726B4F724F626A
              6563743E0A2020203C697074634578743A526567697374727949643E0A202020
              203C7264663A4261672F3E0A2020203C2F697074634578743A52656769737472
              7949643E0A2020203C786D704D4D3A486973746F72793E0A202020203C726466
              3A5365713E0A20202020203C7264663A6C690A20202020202073744576743A61
              6374696F6E3D227361766564220A20202020202073744576743A6368616E6765
              643D222F220A20202020202073744576743A696E7374616E636549443D22786D
              702E6969643A63393735666134302D396238362D346566312D393934352D3762
              38633034626663633566220A20202020202073744576743A736F667477617265
              4167656E743D2247696D7020322E3130202857696E646F777329220A20202020
              202073744576743A7768656E3D22323032302D30322D32395431323A30393A35
              31222F3E0A202020203C2F7264663A5365713E0A2020203C2F786D704D4D3A48
              6973746F72793E0A2020203C706C75733A496D616765537570706C6965723E0A
              202020203C7264663A5365712F3E0A2020203C2F706C75733A496D6167655375
              70706C6965723E0A2020203C706C75733A496D61676543726561746F723E0A20
              2020203C7264663A5365712F3E0A2020203C2F706C75733A496D616765437265
              61746F723E0A2020203C706C75733A436F707972696768744F776E65723E0A20
              2020203C7264663A5365712F3E0A2020203C2F706C75733A436F707972696768
              744F776E65723E0A2020203C706C75733A4C6963656E736F723E0A202020203C
              7264663A5365712F3E0A2020203C2F706C75733A4C6963656E736F723E0A2020
              3C2F7264663A4465736372697074696F6E3E0A203C2F7264663A5244463E0A3C
              2F783A786D706D6574613E0A2020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020200A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20200A2020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020200A202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020200A20202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020200A2020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020200A202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020200A20202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              0A20202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020200A2020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020200A202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020200A20202020202020202020202020202020
              20202020202020202020200A3C3F787061636B657420656E643D2277223F3E4B
              548A7F00000300504C5445292929000000080808101010181818212121313131
              3939394242424A4A4A5252525A5A5A6363636B6B6B7373737B7B7B8484848C8C
              8C9494949C9C9CA5A5A5ADADADB5B5B5BDBDBDC6C6C6CECECED6D6D6DEDEDEE7
              E7E7EFEFEFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF0000EDB104C60000000174524E530040E6D86600000009
              7048597300000B1300000B1301009A9C180000000774494D4507E4021D0B0933
              FBF51AA8000000CA4944415438CBAD93D10E83200C456D512731636671325C48
              FFFF2F0788DB54DA25CBEE032FA7A1B7B75055BFCB2999D7304AB80740014F08
              001DCF1544B15827CC761871E19C4595317341072FE90236684D820F53B23823
              58221738110DC714DB407C40BEA15870DBE1CBE29DB2DCCEE27D1D2D57B89DC5
              E9ED5DA582A3C5767B031DF7306F3DF8424C575CB84FA729057D8A63E61C5431
              698B66489D5C4872965709D030DBEEE46D7E2EFCCC56E43ED29BD5A9C449AF3E
              F6A9C56F13FAE0979FD70B36B39AEA2F7A02B04C0C143A3357D0000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Boutons\BB'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C600000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C54455A5A5A000000
              0808081010101818182121212929293131313939394242424A4A4A5252526363
              636B6B6B7373737B7B7B8484848C8C8C9494949C9C9CA5A5A5ADADADB5B5B5BD
              BDBDC6C6C6CECECED6D6D6DEDEDEE7E7E7EFEFEFF7F7F7FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E8AE9D9F0000
              000174524E530040E6D866000000097048597300000B1300000B1301009A9C18
              0000000774494D4507E4021D0A1933B0F562CE000000C74944415438CBB592C1
              0E82400C4499C28A8844A2228221FDFFBF745B168DEC5ABC380738ECCBCCA46D
              96FDA261BF45109D6DA001F2876D01A0B480C203A0D6A809150D6686C8193583
              49B361E1912E093860AA1460E4296004334B57FF03D509425E7872F2959C5BA2
              26075D3429CE412086A5ED21026A0E0141C50AA83F1DD6351AB77450828ED1A4
              B49F5265E4EED561D2FE4238EAE331E47E92A566F7485EE0BB7B7AA1D56B5577
              73995F977D9DDF77F64119072715E9641C7565B9AB018DE67BD7667FD413BD20
              0C00903E15750000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A0'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100403000000EDDDE2
              5200000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F5345D18A821544143254270BA2228E52C52258286D85561D4C2EFD82260D49
              8A8BA3E05A70F063B1EAE0E2ACAB83AB20087E8038393A29BA4889FF4B0A2D62
              3C38EEC7BB7B8FBB7780502B31D56C9B0054CD3212D18898CEAC8A1DAF103082
              3E74634062A61E4B2EA6E039BEEEE1E3EB5D9867799FFB73F4285993013E9178
              8EE98645BC413CB369E99CF78983AC2029C4E7C4E3065D90F891EBB2CB6F9CF3
              0E0B3C3368A412F3C4416231DFC2720BB382A1124F13871455A37C21EDB2C279
              8BB35AAAB0C63DF90B03596D25C9759AC388620931C421424605459460214CAB
              468A8904ED473CFC438E3F4E2E995C4530722CA00C1592E307FF83DFDD9AB9A9
              4937291001DA5F6CFB6314E8D805EA55DBFE3EB6EDFA09E07F06AEB4A6BF5C03
              663F49AF36B5D011D0BB0D5C5C3735790FB8DC01069F74C9901CC94F53C8E580
              F733FAA60CD07F0B74ADB9BD35F671FA00A4A8ABE51BE0E01018CB53F6BAC7BB
              3B5B7BFBF74CA3BF1F4FD77299DD4340F400000030504C544500000008080824
              24244141415252527373737B7B7B848400888888AFAFAFD6D6D6DEDEDEE7E7E7
              EFEFEFF7F7F7FFFFFF89D1B419000000097048597300000B1300000B1301009A
              9C180000000774494D4507E4021D100D155DE716C0000000534944415408D763
              2887020620020208833908CAE8FFA3006670FCDFBF00CCB0FFE1FF11CCB09BB0
              7E0398C122F23F00A258EA175457FE250883E9FD0A033083E7FFFFCF1073FEAE
              9A0C51A300B30B6629040000FCAD3567E89AAB1E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100403000000EDDDE2
              5200000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F5345D18A821544143254270BA2228E52C52258286D85561D4C2EFD82260D49
              8A8BA3E05A70F063B1EAE0E2ACAB83AB20087E8038393A29BA4889FF4B0A2D62
              3C38EEC7BB7B8FBB7780502B31D56C9B0054CD3212D18898CEAC8A1DAF103082
              3E74634062A61E4B2EA6E039BEEEE1E3EB5D9867799FFB73F4285993013E9178
              8EE98645BC413CB369E99CF78983AC2029C4E7C4E3065D90F891EBB2CB6F9CF3
              0E0B3C3368A412F3C4416231DFC2720BB382A1124F13871455A37C21EDB2C279
              8BB35AAAB0C63DF90B03596D25C9759AC388620931C421424605459460214CAB
              468A8904ED473CFC438E3F4E2E995C4530722CA00C1592E307FF83DFDD9AB9A9
              4937291001DA5F6CFB6314E8D805EA55DBFE3EB6EDFA09E07F06AEB4A6BF5C03
              663F49AF36B5D011D0BB0D5C5C3735790FB8DC01069F74C9901CC94F53C8E580
              F733FAA60CD07F0B74ADB9BD35F671FA00A4A8ABE51BE0E01018CB53F6BAC7BB
              3B5B7BFBF74CA3BF1F4FD77299DD4340F400000030504C54450000000808082A
              2A2A5252528484006363636B6B6B7777778484849C9C9CD6D6D6DEDEDEE7E7E7
              EFEFEFF7F7F7FFFFFF700D5657000000097048597300000B1300000B1301009A
              9C180000000774494D4507E4021D100D2795304740000000514944415408D763
              708102062002020843DD00C2E078FF03C2D0FFB5DE00CCE06C3C5F0051A3F547
              00A2E6FE67881ACE7F7F206A180DF23740184CEB1F8019DCFBFF4374B1FE3F0C
              B522588001D5520800009A3025C09024EFA80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100403000000EDDDE2
              5200000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F5345D18A821544143254270BA2228E52C52258286D85561D4C2EFD82260D49
              8A8BA3E05A70F063B1EAE0E2ACAB83AB20087E8038393A29BA4889FF4B0A2D62
              3C38EEC7BB7B8FBB7780502B31D56C9B0054CD3212D18898CEAC8A1DAF103082
              3E74634062A61E4B2EA6E039BEEEE1E3EB5D9867799FFB73F4285993013E9178
              8EE98645BC413CB369E99CF78983AC2029C4E7C4E3065D90F891EBB2CB6F9CF3
              0E0B3C3368A412F3C4416231DFC2720BB382A1124F13871455A37C21EDB2C279
              8BB35AAAB0C63DF90B03596D25C9759AC388620931C421424605459460214CAB
              468A8904ED473CFC438E3F4E2E995C4530722CA00C1592E307FF83DFDD9AB9A9
              4937291001DA5F6CFB6314E8D805EA55DBFE3EB6EDFA09E07F06AEB4A6BF5C03
              663F49AF36B5D011D0BB0D5C5C3735790FB8DC01069F74C9901CC94F53C8E580
              F733FAA60CD07F0B74ADB9BD35F671FA00A4A8ABE51BE0E01018CB53F6BAC7BB
              3B5B7BFBF74CA3BF1F4FD77299DD4340F400000030504C544500000008080835
              35355E5E5E6B6B6B7373737B7B7B8484009C9C9CB5B5B5BDBDBDCACACAD6D6D6
              E7E7E7F7F7F7FFFFFF58088EFF000000097048597300000B1300000B1301009A
              9C180000000774494D4507E4021D100D37888757240000004D4944415408D763
              288702062002020883D909CAD0FFDF0061CC873298FEBF4F0033387EEC8730E4
              1EAD8730EC27EF9F0866CCFFFFFF2B98A17DFBFF618876C6FF06502BDEC3189E
              06A8964200009289374C9DB944750000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100403000000EDDDE2
              5200000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F5345D18A821544143254270BA2228E52C52258286D85561D4C2EFD82260D49
              8A8BA3E05A70F063B1EAE0E2ACAB83AB20087E8038393A29BA4889FF4B0A2D62
              3C38EEC7BB7B8FBB7780502B31D56C9B0054CD3212D18898CEAC8A1DAF103082
              3E74634062A61E4B2EA6E039BEEEE1E3EB5D9867799FFB73F4285993013E9178
              8EE98645BC413CB369E99CF78983AC2029C4E7C4E3065D90F891EBB2CB6F9CF3
              0E0B3C3368A412F3C4416231DFC2720BB382A1124F13871455A37C21EDB2C279
              8BB35AAAB0C63DF90B03596D25C9759AC388620931C421424605459460214CAB
              468A8904ED473CFC438E3F4E2E995C4530722CA00C1592E307FF83DFDD9AB9A9
              4937291001DA5F6CFB6314E8D805EA55DBFE3EB6EDFA09E07F06AEB4A6BF5C03
              663F49AF36B5D011D0BB0D5C5C3735790FB8DC01069F74C9901CC94F53C8E580
              F733FAA60CD07F0B74ADB9BD35F671FA00A4A8ABE51BE0E01018CB53F6BAC7BB
              3B5B7BFBF74CA3BF1F4FD77299DD4340F400000030504C544500000008080814
              14143939395A5A5A6363637373738484008C8C8C949494B5B5B5C8C8C8DEDEDE
              E7E7E7EFEFEFFFFFFFCC50C6BD000000097048597300000B1300000B1301009A
              9C180000000774494D4507E4021D100E0D65A6DD550000004D4944415408D763
              28870206200202284319C2E038F73F00CC60F9FF7F0384F1B74D01CCE0FC0555
              CCF36F328CF13F01CC60325CFF00620ECBFD0B6006EB7DA814CBFF23502B5AE1
              764119100000EA5935275BAC38110000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100403000000EDDDE2
              5200000184694343504943432070726F66696C65000028917D913D48C3401CC5
              5F5345D18A821544143254270BA2228E52C52258286D85561D4C2EFD82260D49
              8A8BA3E05A70F063B1EAE0E2ACAB83AB20087E8038393A29BA4889FF4B0A2D62
              3C38EEC7BB7B8FBB7780502B31D56C9B0054CD3212D18898CEAC8A1DAF103082
              3E74634062A61E4B2EA6E039BEEEE1E3EB5D9867799FFB73F4285993013E9178
              8EE98645BC413CB369E99CF78983AC2029C4E7C4E3065D90F891EBB2CB6F9CF3
              0E0B3C3368A412F3C4416231DFC2720BB382A1124F13871455A37C21EDB2C279
              8BB35AAAB0C63DF90B03596D25C9759AC388620931C421424605459460214CAB
              468A8904ED473CFC438E3F4E2E995C4530722CA00C1592E307FF83DFDD9AB9A9
              4937291001DA5F6CFB6314E8D805EA55DBFE3EB6EDFA09E07F06AEB4A6BF5C03
              663F49AF36B5D011D0BB0D5C5C3735790FB8DC01069F74C9901CC94F53C8E580
              F733FAA60CD07F0B74ADB9BD35F671FA00A4A8ABE51BE0E01018CB53F6BAC7BB
              3B5B7BFBF74CA3BF1F4FD77299DD4340F400000030504C544500000008080818
              18183B3B3B5A5A5A6363637373738484008484848C8C8C949494BDBDBDDEDEDE
              EFEFEFF7F7F7FFFFFF77949FFA000000097048597300000B1300000B1301009A
              9C180000000774494D4507E4021D100E354DA465CB000000514944415408D763
              288702062002020883C901CA90F90565F45F823098DE0740189C7F0C210C9EFF
              7F1DC00CFD3FE71F8119F69FEC3F43181FF21F8219B23FDE6F003398CFFF5580
              18C89CC4806A29040000977835B71E1E015A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008000000003A98A0
              BD00000124694343504943432070726F66696C65000028919D90BF4AC35014C6
              7F8DA2221504C5411432B8165C9AC9C53F181C0A358D60744A93168B490C494A
              F10D7C137D980E82E013F8040ACE7E373A3898C50B87EFC7E19CEFBBF7826527
              515A2EEE439A5585EB1D0697C195BDFC86C52EEBB4E9865199F706A73E8DE7F3
              9596D1978EF16A9EFBF32CC5A33292CE5559941715B40EC4CEACCA0DABD8BCF5
              BD63F183D88ED32C163F89F7E234366C76BD3499463F9EE636ED517631307DD5
              0E2E67F4E8633364CA84848A8E3453E70487AED4A520E49E92489A30526FA699
              8A1B5129279723912FD26D1AF2B6EBBCBE5286F298C8CB24DC91CAD3E461FEF7
              7BEDE3BCDE6C6DCDF3B008EBD682CA1A8FE1FD11D602D87886D5EB86AC95DF6F
              6B9871EA997FBEF10B202B508153AAAF03000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D10100751320B9400000052494441
              5418D36360201E0449A0F28BFF1733303030303041F9493DA8F24EEFFBFE0721
              F125CE9A3AFD374536C09421E9BF009AA1CF19500C65907E862660BF0CCD5D28
              6632303068428D806B518C26DA8F00AF4B10FF2FC341B20000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Arbre\A6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008000000003A98A0
              BD00000124694343504943432070726F66696C65000028919D90BF4AC35014C6
              7F8DA2221504C5411432B8165C9AC9C53F181C0A358D60744A93168B490C494A
              F10D7C137D980E82E013F8040ACE7E373A3898C50B87EFC7E19CEFBBF7826527
              515A2EEE439A5585EB1D0697C195BDFC86C52EEBB4E9865199F706A73E8DE7F3
              9596D1978EF16A9EFBF32CC5A33292CE5559941715B40EC4CEACCA0DABD8BCF5
              BD63F183D88ED32C163F89F7E234366C76BD3499463F9EE636ED517631307DD5
              0E2E67F4E8633364CA84848A8E3453E70487AED4A520E49E92489A30526FA699
              8A1B5129279723912FD26D1AF2B6EBBCBE5286F298C8CB24DC91CAD3E461FEF7
              7BEDE3BCDE6C6DCDF3B008EBD682CA1A8FE1FD11D602D87886D5EB86AC95DF6F
              6B9871EA997FBEF10B202B508153AAAF03000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D101018DC3A06610000007E494441
              5418D363602004982154548CF6C32F48C2CBFFFFFFFFDD8B8181818181898181
              8181417B4570C18F580606060606160606060686B9131918A4E4500DE3B8E485
              2AD0B91C95EF754900852FF1DE14CD807C1813624BA3EA6327068E7D3FE02ADE
              FFFFFFFFFF720E06060606460606060606532B86CBD75E3010070087A61E23ED
              15EAC80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008000000003A98A0
              BD00000124694343504943432070726F66696C65000028919D90BF4AC35014C6
              7F8DA2221504C5411432B8165C9AC9C53F181C0A358D60744A93168B490C494A
              F10D7C137D980E82E013F8040ACE7E373A3898C50B87EFC7E19CEFBBF7826527
              515A2EEE439A5585EB1D0697C195BDFC86C52EEBB4E9865199F706A73E8DE7F3
              9596D1978EF16A9EFBF32CC5A33292CE5559941715B40EC4CEACCA0DABD8BCF5
              BD63F183D88ED32C163F89F7E234366C76BD3499463F9EE636ED517631307DD5
              0E2E67F4E8633364CA84848A8E3453E70487AED4A520E49E92489A30526FA699
              8A1B5129279723912FD26D1AF2B6EBBCBE5286F298C8CB24DC91CAD3E461FEF7
              7BEDE3BCDE6C6DCDF3B008EBD682CA1A8FE1FD11D602D87886D5EB86AC95DF6F
              6B9871EA997FBEF10B202B508153AAAF03000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D10102CFD8EF2D400000064494441
              5418D363602004182194809321C3BAF30861C5D7FFFFFFBFC5C0C0C0C0C0C4C0
              C0C0C0E0F8BEC5FDCD4A54BD49B73850F89AAF0D5115DC6A46E5BBFDBF15842A
              12B4F1FB4654118E5BAF51F896B7BE23EBE168FE7FCB1259BE7963120703B100
              0095CB1BDD006FC26E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008000000003A98A0
              BD00000124694343504943432070726F66696C65000028919D90BF4AC35014C6
              7F8DA2221504C5411432B8165C9AC9C53F181C0A358D60744A93168B490C494A
              F10D7C137D980E82E013F8040ACE7E373A3898C50B87EFC7E19CEFBBF7826527
              515A2EEE439A5585EB1D0697C195BDFC86C52EEBB4E9865199F706A73E8DE7F3
              9596D1978EF16A9EFBF32CC5A33292CE5559941715B40EC4CEACCA0DABD8BCF5
              BD63F183D88ED32C163F89F7E234366C76BD3499463F9EE636ED517631307DD5
              0E2E67F4E8633364CA84848A8E3453E70487AED4A520E49E92489A30526FA699
              8A1B5129279723912FD26D1AF2B6EBBCBE5286F298C8CB24DC91CAD3E461FEF7
              7BEDE3BCDE6C6DCDF3B008EBD682CA1A8FE1FD11D602D87886D5EB86AC95DF6F
              6B9871EA997FBEF10B202B508153AAAF03000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D1011023843CE5A0000006C494441
              5418D36360C00E3834D1F8E776A10AF8FDF783319918181818180C7F1C4215B0
              3EFC41F1B52D9280CC14065D913748667EE760A8FF8EA445F1FA0F06EBEB4802
              22B27EB6221CBB38E05A24BEFFFFFF7F9704923B14FD0C5FFBA139FEB5219AC0
              7F74EFF9E1F03603003EDD1A9FCC5DA9660000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\A9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008000000003A98A0
              BD00000124694343504943432070726F66696C65000028919D90BF4AC35014C6
              7F8DA2221504C5411432B8165C9AC9C53F181C0A358D60744A93168B490C494A
              F10D7C137D980E82E013F8040ACE7E373A3898C50B87EFC7E19CEFBBF7826527
              515A2EEE439A5585EB1D0697C195BDFC86C52EEBB4E9865199F706A73E8DE7F3
              9596D1978EF16A9EFBF32CC5A33292CE5559941715B40EC4CEACCA0DABD8BCF5
              BD63F183D88ED32C163F89F7E234366C76BD3499463F9EE636ED517631307DD5
              0E2E67F4E8633364CA84848A8E3453E70487AED4A520E49E92489A30526FA699
              8A1B5129279723912FD26D1AF2B6EBBCBE5286F298C8CB24DC91CAD3E461FEF7
              7BEDE3BCDE6C6DCDF3B008EBD682CA1A8FE1FD11D602D87886D5EB86AC95DF6F
              6B9871EA997FBEF10B202B508153AAAF03000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D101115BB904B9D0000006F494441
              5418D36360201E7068227124EEFDFFFF7F2F03030303030B030303034389E4BE
              F3B71621A9B8E784A6FF3F079CC9CCC0C0C0C0A06CBE0B5585C0DEBD9A6876F6
              7CAF463326EDBF17030303030313CC25A20C3248EE5A74EFFFFF45109B181918
              1818182C9D5E1FBE4EAC1F01C93B18AE29093B9C0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AA'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100804000000B5FA37
              EA00000124694343504943432070726F66696C65000028919D903D4AC4501485
              BF44F10F6D542C442185ED80164E65E30F068B81313382D12A936470308921C9
              30B80377A28B9942105C812B50B0F6BC6861611A1F5CCEC7E5DE73DE7B603B49
              9896B3BB906655E17A87FEA57FE5CCBF61B3CD227BAC066199777AA77D1ACFE7
              2B96D19796F16A9EFBF3CC4571194AA7AA2CCC8B0AAC03717B52E58655ACDFF6
              BD63F183D889D22C123F8977A234326C76BD3419873F9EE636CB7176D1337DD5
              162E6774E8E23060CC88848A963453E78436FB529782807B4A426942ACDE4433
              1537A2524E2E47A2BE48B769C8DBACF3BA4A19C863242F9370472A4F9387F9DF
              EFB58FF37AD3DA98E64111D4AD19953D1CC2FB23ACF8B0F60C4BD70D590BBFDF
              D630D3AE67FEF9C62F1668507C17616603000000097048597300000B1300000B
              1301009A9C180000000774494D4507E4021D0A3412DCB6287F0000009A494441
              5428CF7D912112C23014445FAB2A9158B8014824B296EB71855A1CB61657D91E
              01D9BA87086DC324253F229979F37767B790FFA72C5CE7EC90F2BD8823EF632D
              5E95DF095791CEF9B501081E12A05CC526A04E5DAE1B1AB137FCE78924464EDE
              FDAAE680BDD8250E220F37E0914B6ADEF05C52D8F450593926C022517161A215
              A2EC0BE21C6AE0959615EA190C409B75B974B0CB74F101E63EB173EDDB00E100
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AB'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000C00000010080300000015BF6E
              3500000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000033504C54450A3030630018
              80001BB90029C100317E0826CE00318D243D97888CC6B5BDCBBDC0CECACADAD4
              D8DEDEDEEBEBEBF7F7F7FFFFFF9E0C30B70000000174524E530040E6D8660000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              3506DF77CD43000000564944415408D74DCC5B0EC0200844D1B1D0C1F7FE975B
              D4A89D2F4E482E801A719783D583F8508EE24BDA81919A3784E48ED880489CCF
              E037D5DD813EC185B2A105481B4CA32C3F742439F0603511D5B630D6122E7C1F
              191F02EA398CDE760000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AC'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000C00000010080300000015BF6E
              3500000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000033504C544550A2F0086200
              05A70000BD0000C6001B620F13A0084D6A4890978DC1BDB5C6C3C0D6D4D4DEDE
              DEE7E7E7EFEFEFF7F7F7FFFFFFEE129A7F0000000174524E530040E6D8660000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              36314CE73B8F000000554944415408D74DCE4112C0200803403423A0E8FFBF5B
              688B9A133B1C122232A59351C436B480E7460324210CD471017A8359DFA7F88D
              EA5E8E862F014B546FEBE5077AD4F08545CA89283761AEB12997CC4E079E07E5
              97025A623664710000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AD'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
              5300000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C544512151815181D
              15191D151A1E171C20191E221A1F231A1E251B20251A20261E22251F23292024
              29252B30272D35282D372B313630333931363E32393F34393E363A3F343A453B
              3F42393E443A3E443B42463A414A3E454B3F444A3F454D43464A40474D42474E
              43484E494C4F464B56474E54484F554B50544A51564E50554A51594B53595156
              5950555C50575D51565C52575D51585E545B5F565C5F515661545B61555B6154
              5C615A5F635A61675B62675D636C5E64686263636C6C6C646972666C716C6F77
              6B70736E7678717071707274777A7D777B807A7F807D7F837F81837D85878082
              8481828480848782888683898886888B8D8E8F8D8F8F898E908A8F918D939190
              919192929294939495959496969693969B94979A9898989B9B9B9B9E9F9D9D9D
              9E9E9E9F9F9F9C9FA19D9EA09EA1A2A0A09FA0A0A0A1A1A1A0A4A4A4A4A4A6A6
              A6A3A7A9A8A8A8ABABABABAFADADADADB1B1B1B2B2B2B3B3B3B1B3B7B4B4B4B8
              B8B8B9B9B9BCBCBCBCBDBDBDBDBDBDBEBEBEBFBFC0C0C0C1C1C1C2C2C2C1C2C5
              C3C4C6C5C5C5C6C6C6C7C7C7C8C8C8C9C9C9CBCBCBCCCCCCCDCDCDCDCECECECE
              CED8D9DB00000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000073B5C3780000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              1C2EAE84FA52000000D54944415418D363E8EAEAEC686F6B6D6D696E6901910C
              84057ABA43C30A6A5B5A9A9B81FCB6D616869E5867EF007F8F90DC9A96D62E90
              40BD83A1B98D85B1BE825E566F69555B0B43A08E9195A99A92A45B6382BAA2A5
              532A830F072BB780AC5F539ABCB08CAA968117438A0A3F3B8B668C3897848699
              B6AEA82B43597AB0BBB5342F130323338F8894A00B4345515E667CA4A7BD1C1F
              2713239BB21D437D757949614E627484AFA38998906D0443435D6579717E7672
              46525C5478506105434B4B0B42ACB0A28501E4E866A810900F1200892000008E
              C45F6A5B02DCF90000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AE'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
              5300000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB00000300504C5445EDEAE7EAE7E2
              EAE6E2EAE5E1E8E3DFE6E1DDE5E0DCE5E1DAE4DFDAE5DFD9E1DDDAE0DCD6DFDB
              D6DAD4CFD8D2CAD7D2C8D4CEC9CFCCC6CEC9C1CDC6C0CBC6C1C9C5C0CBC5BAC4
              C0BDC6C1BBC5C1BBC4BDB9C5BEB5C1BAB4C0BBB5C0BAB2BCB9B5BFB8B2BDB8B1
              BCB7B1B6B3B0B9B4A9B8B1ABB7B0AAB4AFABB5AEA9B1AFAAB5AEA6B4ACA6AEA9
              A6AFAAA3AFA8A2AEA9A3ADA8A2AEA7A1ABA4A0A9A3A0AEA99EABA49EAAA49EAB
              A39EA5A09CA59E98A49D98A29C93A19B979D9C9C9393939B968D99938E939088
              948F8C9189878E8F8E8F8D8B88858288847F85807F82807C807E7C827A787F7D
              7B7E7D7B7F7B787D77797C767779777472717072707076716F75706E726C6E6F
              6E6E6D6D6D6B6C6B6A6A6B6969696C69646B6865676767646464646160626262
              61616160606063605E62615F615E5D5F5F605F5F5F5E5E5E5F5B5B5B5B5B5959
              595C58565757575454545450525252524E4E4E4D4D4D4C4C4C4E4C484B4B4B47
              47474646464343434342424242424241414140403F3F3F3E3E3E3D3D3D3E3D3A
              3C3B393A3A3A3939393838383737373636363434343333333232323231313131
              31272624FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FAB7F910000
              00097048597300000B1300000B1301009A9C180000000774494D4507E4021D0A
              1D0865924EEE000000D54944415418D363E8EAEAEC686F6B6D6D696E6901910C
              84057ABA43C30A6A5B5A9A9B81FCB6D616869E5867EF007F8F90DC9A96D62E90
              40BD83A1B98D85B1BE825E566F69555B0B43A08E9195A99A92A45B6382BAA2A5
              532A830F072BB780AC5F539ABCB08CAA968117438A0A3F3B8B668C3897848699
              B6AEA82B43597AB0BBB5342F130323338F8894A00B4345515E667CA4A7BD1C1F
              2713239BB21D437D757949614E627484AFA38998906D0443435D6579717E7672
              46525C5478506105434B4B0B42ACB0A28501E4E866A810900F1200892000008E
              C45F6A5B02DCF90000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AF'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
              53000006817A5458745261772070726F66696C65207479706520657869660000
              78DAAD576B9233290EFCCF29E608201E12C7E119B137D8E34F02A2DA6D77EF37
              13B1AEB0A1284A48995282CDF8EF7FA6F90B1F221613224BCA29597C420E990A
              3A62CF27EF5F67C3FED51B7B3BDFC6CDF38030E4D1FA73CB45E7178CC7AF17EE
              1AAE7E1F37A24F48D4D0B5AC06FD5A99D0E9AF4E629CCEB80B6A288FD34959F8
              D5D54AA76D3A71BBA25FCFDBF46364DD9BD781C040A947CCF244C33B6FF7AF1C
              0FFCF996DD167C33E6B9DDB73E1834CEDF9000C8B7F01E00ED2B40DF40BE3DF3
              8EFED37B039F8A8EFB372C936284CE8F0F5CFC19FC0DF1CBC2FEF188BE3F28D3
              F24738FA9DB3CB9CE344574202A24933CA9A8BCE7A07132B20F7FBB5848BF18D
              E8F3BE322EB1C53690D36DB3155773D9115899C605D75D71D38DDD36D7E062A0
              418C96A891DF63E2993235BF780AEB7293D867DFBD80B746C3788F617A7C717B
              DDBCD76B4EB07277984A0EC616D5BF5EE67F3DFC379799B32D889C95072BF845
              2B73E1C6626EFD6216087153798B1BE07B29FDF6257F90AA60306E980501165B
              8F891ADD576EF9CDB3C7BC88F6548533DCD50020C2DA11CE380F066C723EBAE4
              2C436D9C038E02820A3C271FA882011723753849C1FB44864968AD8D77D8EDB9
              1429D11A86368188E8936770937D01592144E40F07410E95E8638831A6C8514C
              CCB1249F428A29254E4BE40A7B0E1C3931B370E6225E824449C22292A564CA1E
              1A1873CA9C25E75C0A9982850A6C15CC2F18A9547D0D35D654B94ACDB534A44F
              0B2DB6D4B849CBAD74EABE43267AEADCA5E75E8633034A31C288230D1E32F228
              13B936FD0C33CE3479CACCB33CAC29AB1FD7BF60CD296BB4995AF3F8610DA386
              F99A704B4EE2E20C8C5170609C170348685A9C597121D0626E716633A12822C1
              C9B8B831DD2DC64061188EE2740F775FCCFD23DE4C947FC41BFD8939B3A8FB7F
              306740DD276F3FB0D6D73ED73663A70A17A6D6A3FA30A790187C218B24AB7539
              440708C0E7EE4077D36A1D50196CEB1E44F8D1E5A70FE5DB9341FFE93CAD2BF1
              4C1276B9F763088A5752EEBB4FE959C78FE500A06864766F6DB4DF5BF504853C
              D2311CF2901CCEF32663FA9A4F20C0BC625F3B8BD38DEE89329DB5B00D1D3FC4
              B6E1CA5966149A67B4E4865342C28D5900706E2F4EAA4F619BACDE49DF3DD466
              1E41C3C6DB8DF5C602B3D2CDEE2347AF2B540E566D10292848E4715109CA4746
              607C8C06144774E6009CFD1E8466F97C422F6DB0EF7222EC76BAC6C76C8AD2CE
              0C2BBEB5136DF628114A2708EB7BF2F13C48E183CCCB7861F4D599C6B9A8AFC6
              C679ED54DB5981F13893BCC1EFE9781762B61A3230CB431700D803F972228F6E
              3FDB7D0CCE20ACDCDB2775DEDB9BB206A9862DB39F97B100C98DA5AA4542D140
              3934E947790FFAB4066FB4D4F5DD51D562844AE204772880A094700C6197869F
              A1BF736D8BF90E84FAB34A021532D56A9EFEE19F838E1296CDEA286ACE14F92D
              FAF0A484A6F940DA2669EE2179ED67A764701A8921685624D244F9A817127D82
              20AD069F10FCB326C769AE9F33506A272E9442B19AC1B645CDCFF0C1977FB260
              B3A6BE0D54B0F6DBC40E7126E1851F3942ABE91DB26F1585BAC09EB14D7908F0
              751C101A20418EAA47C058E817CD59AD599D56CE64993E48B9327053C1E5516F
              725D952C1F389AC791E32AFC0B32E16199AA93500C3ED80D009CC0DB891A08BF
              866B7E8ADFA910F63669A99F2A2F392D32D4420F5F74ECC9E687901F9E3893FA
              5232CE41E90AC9AA9A76826469D87A42A8E6EA94FCC6CEF552C986704F7AD431
              2EEA5B3AA1EDD80BFDC9D26371C4630492C338B7E59357262D15195D6B52048E
              3655126CC7BF960FDF1D90D361C52C151F208659956495AB388DC3BBC9438B7D
              2BBE825672BE9910523932F259A6CBC94795FC7913A67FADEEB3D37E7B3F1357
              DDB1A01133B7BB55204A1C4A8ECDD618FB97FDCA2D1C75C7D1236834FE915CD1
              F810EB568F8CCC64276EBDEE2C614049B46CA6330D1E487E7662F990107F2A2F
              FADCC61C9AFC0DC98FE38A4A53814DF3790261A9FDC65071E452B2F3E05E6F86
              66D7DFA0C2698449A7425B712CBBBAE87CA5B3606EB35C956CD2C3AD00193746
              F6C59C7AA81D4714B2F3CC5ECE4EFBA8C6D716FBA6457BABD505CCD21968BB4A
              10CE6EDDE6A4DBF03AA87E3B9CBCFAF376D83011875F7AE448665000BB838B40
              549748BE75DD557E4E78B33B17425185AEF8A3941F16BEED6FECFDB36F8E9CFB
              3DD918F93CF191EB740F34C3B93EE3BD492F09EA4F6C38A36D0CCD2B88F8A338
              7BC6FF8ABF011CF32CE141460154000000657A5458745261772070726F66696C
              6520747970652069707463000078DA3D4A410E80300CBAF7153EA103A2EE39CB
              F4E0CD83FF8F6C31425A2834AEFBE9B14C680DEE82AA8E94F903283DC1CDB611
              CC3138867A8375B6DDEDC9E2BB3183B214D20F5F44C50BF56117586B1BBBC400
              000185694343504943432070726F66696C650000789C7D913D48C3401CC55F53
              A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290A4B8
              380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022C683
              E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030BA11
              C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F12CD3
              0D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF38171D16
              7866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F31667
              B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD1A29
              2652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C4EB8
              49C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D98F9
              24BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000DECF
              E89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEFEE6A
              EFEDDF33CDFE7E00D8E072D047B5787C00000F5569545874584D4C3A636F6D2E
              61646F62652E786D7000000000003C3F787061636B657420626567696E3D22EF
              BBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964
              223F3E0A3C783A786D706D65746120786D6C6E733A783D2261646F62653A6E73
              3A6D6574612F2220783A786D70746B3D22584D5020436F726520342E342E302D
              4578697632223E0A203C7264663A52444620786D6C6E733A7264663D22687474
              703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D7379
              6E7461782D6E7323223E0A20203C7264663A4465736372697074696F6E207264
              663A61626F75743D22220A20202020786D6C6E733A697074634578743D226874
              74703A2F2F697074632E6F72672F7374642F4970746334786D704578742F3230
              30382D30322D32392F220A20202020786D6C6E733A786D704D4D3D2268747470
              3A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F220A202020
              20786D6C6E733A73744576743D22687474703A2F2F6E732E61646F62652E636F
              6D2F7861702F312E302F73547970652F5265736F757263654576656E7423220A
              20202020786D6C6E733A706C75733D22687474703A2F2F6E732E757365706C75
              732E6F72672F6C64662F786D702F312E302F220A20202020786D6C6E733A4749
              4D503D22687474703A2F2F7777772E67696D702E6F72672F786D702F220A2020
              2020786D6C6E733A64633D22687474703A2F2F7075726C2E6F72672F64632F65
              6C656D656E74732F312E312F220A20202020786D6C6E733A786D703D22687474
              703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F220A202020786D
              704D4D3A446F63756D656E7449443D2267696D703A646F6369643A67696D703A
              33396534353966302D623533352D346464342D616466312D6534623535316165
              32656630220A202020786D704D4D3A496E7374616E636549443D22786D702E69
              69643A34336266663734642D383562642D346464342D383831662D3138343163
              61663265663035220A202020786D704D4D3A4F726967696E616C446F63756D65
              6E7449443D22786D702E6469643A32333464386430382D303164652D34346661
              2D623561372D303064656265616661333437220A20202047494D503A4150493D
              22322E30220A20202047494D503A506C6174666F726D3D2257696E646F777322
              0A20202047494D503A54696D655374616D703D22313538323937343235343137
              31333438220A20202047494D503A56657273696F6E3D22322E31302E3138220A
              20202064633A466F726D61743D22696D6167652F706E67220A202020786D703A
              43726561746F72546F6F6C3D2247494D5020322E3130223E0A2020203C697074
              634578743A4C6F636174696F6E437265617465643E0A202020203C7264663A42
              61672F3E0A2020203C2F697074634578743A4C6F636174696F6E437265617465
              643E0A2020203C697074634578743A4C6F636174696F6E53686F776E3E0A2020
              20203C7264663A4261672F3E0A2020203C2F697074634578743A4C6F63617469
              6F6E53686F776E3E0A2020203C697074634578743A417274776F726B4F724F62
              6A6563743E0A202020203C7264663A4261672F3E0A2020203C2F697074634578
              743A417274776F726B4F724F626A6563743E0A2020203C697074634578743A52
              6567697374727949643E0A202020203C7264663A4261672F3E0A2020203C2F69
              7074634578743A526567697374727949643E0A2020203C786D704D4D3A486973
              746F72793E0A202020203C7264663A5365713E0A20202020203C7264663A6C69
              0A20202020202073744576743A616374696F6E3D227361766564220A20202020
              202073744576743A6368616E6765643D222F220A20202020202073744576743A
              696E7374616E636549443D22786D702E6969643A63616138396537312D626464
              652D343166312D626236662D303561343334393038353737220A202020202020
              73744576743A736F6674776172654167656E743D2247696D7020322E31302028
              57696E646F777329220A20202020202073744576743A7768656E3D2232303230
              2D30322D32395431323A30343A3134222F3E0A202020203C2F7264663A536571
              3E0A2020203C2F786D704D4D3A486973746F72793E0A2020203C706C75733A49
              6D616765537570706C6965723E0A202020203C7264663A5365712F3E0A202020
              3C2F706C75733A496D616765537570706C6965723E0A2020203C706C75733A49
              6D61676543726561746F723E0A202020203C7264663A5365712F3E0A2020203C
              2F706C75733A496D61676543726561746F723E0A2020203C706C75733A436F70
              7972696768744F776E65723E0A202020203C7264663A5365712F3E0A2020203C
              2F706C75733A436F707972696768744F776E65723E0A2020203C706C75733A4C
              6963656E736F723E0A202020203C7264663A5365712F3E0A2020203C2F706C75
              733A4C6963656E736F723E0A20203C2F7264663A4465736372697074696F6E3E
              0A203C2F7264663A5244463E0A3C2F783A786D706D6574613E0A202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020200A20
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020200A20202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020200A2020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020200A202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020200A20202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020200A2020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020200A202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              200A202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020200A20202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020200A2020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020200A202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020200A20202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020200A2020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020202020202020202020202020200A
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020200A202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020200A20202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020200A2020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              202020202020202020202020202020202020200A202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020200A20202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              2020202020202020202020202020202020202020202020202020202020202020
              20202020202020202020202020202020202020202020202020202020200A2020
              202020202020202020202020202020202020202020202020200A3C3F78706163
              6B657420656E643D2277223F3EDC15FF1300000300504C544518000021080821
              18183931314221214239314A10104A18104A4A4A63635A7B73738C21188C8C8C
              9C2121A5A5A5BD847BBD8C8CBD948CC67373C67B73C67B7BC68C84C68C8CC694
              8CC69C94C6A59CC6A5A5C6ADA5C6BDBDCE5252CE6363CE6B63CE6B6BCE7373CE
              8C8CCEA59CD64239D67373D68C8CD69C9CD6ADADD6BDBDDE4239DE5A5ADE8C8C
              DEC6BDE73939E77B7BE7EFE7E7EFEFEF3931EF3939EF524AEF9C9CEFADADEFE7
              E7EFEFE7F73931F73939F74239F7736BF79C9CF7CEC6F7CECEF7FFF7FF3931FF
              4239FF4242FF524AFF5252FF635AFF6363FF736BFF7373FF847BFF8484FF8C8C
              FF9494FFA5A5FFB5B5FFC6C6FFCECEFFD6D6FFD6DEFFDED6FFFFF7FFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8BD4B2C000000
              0174524E530040E6D866000000097048597300000B1300000B1301009A9C1800
              00000774494D4507E4021D0B040E163328F4000000C64944415418D3358F6B0F
              C1500C86EBCEDCE7123DCC90250866C9CC624472E2B2306C99FFFF5FB4C3F3A1
              CF7BD2363905205CD125840B3FC4E418C7F1FB3811DF77731B45ABC1601E45DB
              46D277C2309CD56A7D924333EEF8454C2B951E7B6C013E9EC452513AEC878076
              700F82605D2AB592D006FD70230EC5A2CEBEE930BC5E7D229759B0FC21A89733
              71C9A637ECB30A784A28A4F6AC3D826B484F4A699A92312C00B47794F2299BAA
              8DFCD53AC76A99E6ECFAF718343CDEF20CFC9F6BA1AE6923B4387F006D972B84
              287AFE180000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arbre\AG'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000185694343504943432070726F66696C65000028917D913D48C3401CC5
              5F53A52A15073B882864A84E568A8A384A158B60A1B4155A7530B9F44368D290
              A4B8380AAE05073F16AB0E2ECEBA3AB80A82E0078893A393A28B94F8BFA4D022
              C683E37EBCBBF7B87B0708F53253CD8E28A06A96918AC7C46C6E450CBC42C030
              BA11C5B8C44C3D915EC8C0737CDDC3C7D7BB08CFF23EF7E7E855F226037C22F1
              2CD30D8B789D787AD3D239EF138758495288CF89C70CBA20F123D76597DF3817
              1D167866C8C8A4E68843C462B18DE536662543259E220E2BAA46F942D66585F3
              1667B55C65CD7BF21706F3DA729AEB348710C722124842848C2A3650868508AD
              1A292652B41FF3F00F3AFE24B964726D8091631E15A8901C3FF81FFCEED62C4C
              4EB849C118D0F962DB1F2340601768D46CFBFBD8B61B2780FF19B8D25AFE4A1D
              98F924BDD6D2C24740DF367071DDD2E43DE072071878D2254372243F4DA15000
              DECFE89B7240FF2DD0B3EAF6D6DCC7E90390A1AE966E80834360B448D96B1EEF
              EE6AEFEDDF33CDFE7E00D8E072D04F66B2BB000000097048597300000B130000
              0B1301009A9C180000000774494D4507E4021D0A2C21E17DD130000002094944
              415438CB95933F4B634114C57F33195063366C784930FE83C8FAD07A171B4B03
              1622B13169042B3F808D602BD8F901046BB17A8D12116C644B216905096A3444
              764D5E788BECAA9BBCBB45306B8C2CEB81813B3367EE9C7BCF8C12115EC2F7A1
              5C1629957C6A354129211AD524939A444229A53AE89897939B1B5F1CE789FDFD
              5BCECE6A78DE230096D5C7C484453A1D976CB6271F8BE92FCF67D4B38242A129
              9B9BDFC8E52E787C6CF2168241432663B3BE6E61DBBAA54544B8BE6ECAC24259
              943A11688DE9E98278DE6F1CE77B7B0D4EC498AFB2B25215D7F5532282F67DD8
              DDFDC9E1E1252FDB313515261C36A452918EAA1B0D1FC72992CB358E014CB92C
              727474C7D353A7ECEDED0A809C9EFEE82AC5751F709C3BE6E713E8AB2B9F62B1
              DE455A5B1B211C0E30331379B31F17171EA5922FA65AF5A9D57E75110E0E6AE4
              F39F15C0C646495EEFDFDEDE53AD0ADA1878ED6DCB957BFE05AD158180425B56
              8078BC9FF7626828442CA6D0C9A4627C3CF2EE04B61D6174542B9D4828954EC7
              0906CD7F1F1E180891C9588442A095826CB6279FC9D818A3DBA49D1DBB1DEFED
              4DB6E3DE5EC3D2D227666703AAE3299F9FFBB2B555C7718AB8EEC39B375B561F
              CBCB36ABAB618687756702807A5D52B95CE3D871EEB8BCF4A8545A4E8C8C7C60
              6CEC238B8B16737346F5F7FFB54DBDFECE009E27542A22AEDB44298846030C0E
              6A150A75ABFA03F196DC9104B8CEB20000000049454E44AE426082}
          end>
      end>
    Left = 336
    Top = 184
  end
  object VirtualImageListBoutons: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Boutons\B0'
        Disabled = False
        Name = 'B0'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Boutons\B1'
        Disabled = False
        Name = 'B1'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Boutons\B2'
        Disabled = False
        Name = 'B2'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Boutons\B3'
        Disabled = False
        Name = 'B3'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Boutons\B4'
        Disabled = False
        Name = 'B4'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Boutons\B5'
        Disabled = False
        Name = 'B5'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Boutons\B6'
        Disabled = False
        Name = 'B6'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Boutons\B7'
        Disabled = False
        Name = 'B7'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Boutons\B8'
        Disabled = False
        Name = 'B8'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Boutons\B9'
        Disabled = False
        Name = 'B9'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Boutons\BA'
        Disabled = False
        Name = 'BA'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Boutons\BB'
        Disabled = False
        Name = 'BB'
      end>
    ImageCollection = ImageCollection
    Width = 32
    Height = 32
    Left = 336
    Top = 272
  end
end
