object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Diplikata'
  ClientHeight = 1986
  ClientWidth = 1212
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poDesigned
  ShowHint = True
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 192
  TextHeight = 25
  object StatusBar: TStatusBar
    Left = 0
    Top = 1946
    Width = 1212
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoHint = True
    Panels = <
      item
        Width = 854
      end
      item
        Alignment = taCenter
        Style = psOwnerDraw
        Text = 'Temps'
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 100
      end>
    SizeGrip = False
    OnDrawPanel = StatusBarDrawPanel
    ExplicitTop = 1945
    ExplicitWidth = 1198
  end
  object MainMenu: TMainMenu
    Images = ImageListActions
    Left = 56
    Top = 24
    object MenuItemPartie: TMenuItem
      Caption = '&Partie'
      object MenuItemPartieNouvelle: TMenuItem
        Action = ActionPartieNouvelle
      end
      object MenuItemPartieDemonstration: TMenuItem
        Action = ActionPartieDemonstration
      end
      object MenuItemSeparateur5: TMenuItem
        Caption = '-'
      end
      object MenuItemPartieOuvrir: TMenuItem
        Action = ActionPartieOuvrir
      end
      object MenuItemPartieEnregistrer: TMenuItem
        Action = ActionPartieEnregistrer
      end
      object MenuItemPartieEnregistrerSous: TMenuItem
        Action = ActionPartieEnregistrerSous
      end
      object MenuItemSeparateur6: TMenuItem
        Caption = '-'
      end
      object MenuItemPartieQuitter: TMenuItem
        Action = ActionPartieQuitter
      end
    end
    object MenuItemOptions: TMenuItem
      Caption = '&Options'
      object MenuItemOptionsJournalRecherche: TMenuItem
        Action = ActionOptionsJournalRecherche
        AutoCheck = True
      end
      object MenuItemOptionsGenererAutoFDM: TMenuItem
        Action = ActionOptionsGenererAutoFDM
        AutoCheck = True
      end
      object MenuItemOptionsListeToutesSolutions: TMenuItem
        Action = ActionOptionsListeToutesSolutions
        AutoCheck = True
      end
      object MenuItemOptionsEnregistrerPartieAuto: TMenuItem
        Action = ActionOptionsEnregistrerPartieAuto
        AutoCheck = True
      end
      object MenuItemOptionsQualitePose: TMenuItem
        Action = ActionOptionsQualitePose
      end
      object MenuItemOptionsPlacerPropositionAuto: TMenuItem
        Action = ActionOptionsPlacerPropositionAuto
        AutoCheck = True
      end
      object MenuItemSeparateur3: TMenuItem
        Caption = '-'
      end
      object MenuItemOptionsTypePartie: TMenuItem
        Caption = 'Type de partie'
        object MenuItemOptionsTypePartieBlitz: TMenuItem
          Action = ActionOptionsTypePartieBlitz
          GroupIndex = 2
          RadioItem = True
        end
        object MenuItemOptionsTypePartieSemiRapide: TMenuItem
          Action = ActionOptionsTypePartieSemiRapide
          GroupIndex = 2
          RadioItem = True
        end
        object MenuItemOptionsTypePartieNormale: TMenuItem
          Action = ActionOptionsTypePartieNormale
          GroupIndex = 2
          RadioItem = True
        end
        object MenuItemSeparateur7: TMenuItem
          Caption = '-'
          GroupIndex = 3
        end
        object MenuItemOptionsTypePartieStandard: TMenuItem
          Action = ActionOptionsTypePartieStandard
          GroupIndex = 4
          RadioItem = True
        end
        object MenuItemOptionsTypePartieJoker: TMenuItem
          Action = ActionOptionsTypePartieJoker
          GroupIndex = 4
          RadioItem = True
        end
      end
      object MenuItemOptionsTempsLimite: TMenuItem
        Action = ActionOptionsTempsLimite
        AutoCheck = True
      end
      object MenuItemOptionsSanctions: TMenuItem
        Action = ActionOptionsSanctions
        AutoCheck = True
      end
      object MenuItemSeparateur4: TMenuItem
        Caption = '-'
      end
      object MenuItemOptionsEnregistrer: TMenuItem
        Action = ActionOptionsEnregistrer
      end
      object MenuItemOptionsAppliquer: TMenuItem
        Action = ActionOptionsAppliquer
      end
      object MenuItemOptionsReinitialiser: TMenuItem
        Action = ActionOptionsReinitialiser
      end
      object MenuItemOptionsEnregistrerEnQuittant: TMenuItem
        Action = ActionOptionsEnregistrerEnQuittant
        AutoCheck = True
      end
      object MenuItemSeparateur9: TMenuItem
        Caption = '-'
      end
      object MenuItemOptionsViderListePartiesJouees: TMenuItem
        Action = ActionOptionsViderListePartiesJouees
      end
      object MenuItemOptionsReinitialiserRecords: TMenuItem
        Action = ActionOptionsReinitialiserRecords
      end
    end
    object MenuItemActions: TMenuItem
      Caption = '&Actions'
      object MenuItemActionsPasserSonTour: TMenuItem
        Action = ActionActionsPasserSonTour
      end
      object MenuItemActionsChangerTirage: TMenuItem
        Action = ActionActionsChangerTirage
      end
      object MenuItemActionsProposerTirage: TMenuItem
        Action = ActionActionsProposerTirage
      end
      object MenuItemSeparateur8: TMenuItem
        Caption = '-'
      end
      object MenuItemActionsRechercherMots: TMenuItem
        Action = ActionActionsRechercherMots
      end
      object MenuItemActionsListerMotsLettresCheres: TMenuItem
        Action = ActionActionsListerMotsLettresCheres
      end
      object MenuItemActionsRechercherDefinitionMot: TMenuItem
        Action = ActionActionsRechercherDefinitionMot
      end
    end
    object MenuItemAffichage: TMenuItem
      Caption = '&Affichage'
      object MenuItemFrancais: TMenuItem
        Action = ActionAffichageFrancais
      end
      object MenuItemKreyolAyisyen: TMenuItem
        Action = ActionAffichageKreyolAyisyen
      end
      object MenuItemSeparateur0: TMenuItem
        Caption = '-'
      end
      object MenuItemAffichageTirage: TMenuItem
        Action = ActionAffichageTirage
        AutoCheck = True
      end
      object MenuItemAffichageFeuilleMatch: TMenuItem
        Action = ActionAffichageFeuilleMatch
        AutoCheck = True
      end
      object MenuItemAffichageGrapheEvolution: TMenuItem
        Action = ActionAffichageGrapheEvolution
        AutoCheck = True
      end
      object MenuItemAffichageSituationJetons: TMenuItem
        Action = ActionAffichageSituationJetons
      end
      object MenuItemAffichageNouveauxRecords: TMenuItem
        Action = ActionAffichageNouveauxRecords
        AutoCheck = True
      end
      object MenuItemSeparateur1: TMenuItem
        Caption = '-'
      end
      object MenuItemAffichageFeuilleMatchDetaillee: TMenuItem
        Action = ActionAffichageFeuilleMatchDetaillee
      end
      object MenuItemAffichageRecords: TMenuItem
        Action = ActionAffichageRecords
      end
      object MenuItemAffichagePartiesJouees: TMenuItem
        Action = ActionAffichagePartiesJouees
      end
      object MenuItemAffichageListeDefisReleves: TMenuItem
        Caption = 'Liste des d'#233'fis relev'#233's (HTML)'
        GroupIndex = 1
        Hint = 'Affiche sous format HTML la liste des d'#233'fis relev'#233's'
        object MenuItemAffichageDefisReleves1M15L: TMenuItem
          Action = ActionAffichageListeDefisReleves1M15L
        end
      end
      object MenuItemSeparateur2: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MenuItemAffichageRapportsPourcentage: TMenuItem
        Action = ActionAffichageRapportsPourcentage
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
      object MenuItemAffichageRapportNoteSur20: TMenuItem
        Action = ActionAffichageRapportsNoteSur20
        AutoCheck = True
        GroupIndex = 1
        RadioItem = True
      end
    end
    object MenuItemInfos: TMenuItem
      Caption = '&?'
      object MenuItemInfosAide: TMenuItem
        Action = ActionInfosAide
      end
      object MenuItemInfosAPropos: TMenuItem
        Action = ActionInfosAPropos
      end
      object MenuItemInfosInternes: TMenuItem
        Action = ActionInfosInternes
      end
    end
  end
  object ActionList: TActionList
    Images = ImageListActions
    Left = 24
    Top = 24
    object ActionActionsChangerTirage: TAction
      Category = 'Actions'
      Caption = 'C&hanger le tirage'
      Hint = 
        'Permet de changer le tirage lorsqu'#39'il ne permet pas de jouer ou ' +
        'd'#39'ouvrir le jeu'
      ShortCut = 16456
      OnExecute = ActionActionsChangerTirageExecute
    end
    object ActionActionsPasserSonTour: TAction
      Category = 'Actions'
      Caption = '&Passer son tour'
      Hint = 'Permet de passer son tour quand on n'#39'a pas assez de proposition'
      ShortCut = 16464
      OnExecute = ActionActionsPasserSonTourExecute
    end
    object ActionActionsProposerTirage: TAction
      Category = 'Actions'
      Caption = 'P&roposer un tirage'
      Hint = 'Proposer le tirage '#224' venir'
      ShortCut = 16466
      OnExecute = ActionActionsProposerTirageExecute
    end
    object ActionActionsRechercherMots: TAction
      Category = 'Actions'
      Caption = 'Rechercher des &mots...'
      Hint = 
        'Permet de rechercher des mots correspondant '#224' un tirage ou un fi' +
        'ltre'
      ShortCut = 16461
      OnExecute = ActionActionsRechercherMotsExecute
    end
    object ActionActionsListerMotsLettresCheres: TAction
      Category = 'Actions'
      Caption = 'Lister des mots '#224' lettres ch'#232'res...'
      Hint = 'Permet de g'#233'n'#233'rer une liste de mots contenant des lettres ch'#232'res'
      ShortCut = 24652
      OnExecute = ActionActionsListerMotsLettresCheresExecute
    end
    object ActionActionsRechercherDefinitionMot: TAction
      Category = 'Actions'
      Caption = 'Rechercher la d'#233'finition d'#39'un mot...'
      Hint = 'Rechercher sur internet la d'#233'finition d'#39'un mot'
      ShortCut = 24644
      OnExecute = ActionActionsRechercherDefinitionMotExecute
    end
    object ActionAffichageFeuilleMatch: TAction
      Category = 'Affichage'
      AutoCheck = True
      Caption = '&Feuille de match'
      Hint = 
        'Affiche/Cache la feuille de match situ'#233'e '#224' droite et sous le che' +
        'valet'
      ShortCut = 16454
      OnExecute = ActionAffichageFeuilleMatchExecute
    end
    object ActionAffichageTirage: TAction
      Category = 'Affichage'
      AutoCheck = True
      Caption = '&Tirage'
      Hint = 
        'Affiche/Cache le chevalet situ'#233' en haut '#224' droite du plateau de j' +
        'eu'
      ShortCut = 16468
      OnExecute = ActionAffichageTirageExecute
    end
    object ActionAffichageGrapheEvolution: TAction
      Category = 'Affichage'
      AutoCheck = True
      Caption = '&Graphe d'#39#233'volution'
      Hint = 'Affiche/Cache le graphe d'#39#233'volution'
      ShortCut = 16455
      OnExecute = ActionAffichageGrapheEvolutionExecute
    end
    object ActionAffichageFeuilleMatchDetaillee: TAction
      Category = 'Affichage'
      Caption = 'Feuille de match &D'#233'taill'#233'e (HTML)'
      Hint = 'G'#233'n'#232're et affiche la feuille de match d'#233'taill'#233'e (HTML)'
      ShortCut = 16452
      OnExecute = ActionAffichageFeuilleMatchDetailleeExecute
    end
    object ActionAffichageRapportsPourcentage: TAction
      Category = 'Affichage'
      AutoCheck = True
      Caption = 'Rapports sous forme de %'
      GroupIndex = 1
      Hint = 'Affiche les rapports de stats sous forme de pourcentages'
      OnExecute = ActionOptionsRapportsExecute
    end
    object ActionAffichageRapportsNoteSur20: TAction
      Tag = 1
      Category = 'Affichage'
      AutoCheck = True
      Caption = 'Rapports sous forme de note (/20)'
      GroupIndex = 1
      Hint = 'Affiche les rapports de stats sous forme de notes sur 20'
      OnExecute = ActionOptionsRapportsExecute
    end
    object ActionAffichageSituationJetons: TAction
      Category = 'Affichage'
      Caption = 'S&ituation des jetons'
      Hint = 'Affiche l'#39'ordre du tirage et combien il reste de jetons'
      ShortCut = 16457
      OnExecute = ActionAffichageSituationJetonsExecute
    end
    object ActionAffichagePartiesJouees: TAction
      Category = 'Affichage'
      Caption = 'Parties jou'#233'es (HTML)'
      Hint = 'Affiche les infos sur les parties jou'#233'es termin'#233'es'
      ShortCut = 16469
      OnExecute = ActionAffichagePartiesJoueesExecute
    end
    object ActionAffichageRecords: TAction
      Category = 'Affichage'
      Caption = 'Re&cords (HTML)'
      Hint = 'Affiche tous les records'
      ShortCut = 16451
      OnExecute = ActionAffichageRecordsExecute
    end
    object ActionAffichageNouveauxRecords: TAction
      Category = 'Affichage'
      AutoCheck = True
      Caption = 'Nouveau&x records'
      Checked = True
      Hint = 'Affiche ou non en temps r'#233'el les records battus'
      ShortCut = 16472
      OnExecute = ActionVideExecute
    end
    object ActionAffichageListeDefisReleves1M15L: TAction
      Category = 'Affichage'
      Caption = 
        'D'#233'fi n'#176'1 : Formation d'#39'un mot de 15 jetons avec le moins de jeto' +
        'ns possible'
      Hint = 'Affiche la liste des d'#233'fis relev'#233's'
      OnExecute = ActionAffichageListeDefisReleves1M15LExecute
    end
    object ActionInfosAPropos: TAction
      Category = 'Infos'
      Caption = #192' &propos...'
      Hint = 'Affiche les informations de version et de licence'
      ShortCut = 24688
      OnExecute = ActionInfosAProposExecute
    end
    object ActionInfosAide: TAction
      Category = 'Infos'
      Caption = '&Aide'
      Hint = 'Aide HTML sur l'#39'utilisation de Diplikata'
      ShortCut = 112
      OnExecute = ActionInfosAideExecute
    end
    object ActionInfosInternes: TAction
      Category = 'Infos'
      Caption = '&Informations internes'
      ShortCut = 8304
      OnExecute = ActionInfosInternesExecute
    end
    object ActionOptionsListeToutesSolutions: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'G'#233'n'#233'rer et afficher la liste de toutes les solutions'
      Hint = 
        'G'#233'n'#232're puis affiche ou non la liste de toutes les solutions apr'#232 +
        's chaque coup'
      OnExecute = ActionOptionsListeToutesSolutionsExecute
    end
    object ActionOptionsJournalRecherche: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Journal de recherche des solutions'
      Hint = 'D'#233'marre/Termine la trace du moteur de recherche des solutions'
      ShortCut = 16458
      OnExecute = ActionOptionsJournalRechercheExecute
    end
    object ActionOptionsTempsLimite: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Temps limit'#233
      Checked = True
      Hint = 'Active/D'#233'sactive la limitation du temps de r'#233'flexion'
      ShortCut = 16460
      OnExecute = ActionVideExecute
    end
    object ActionOptionsSanctions: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Propositions invalides sanctionn'#233'es'
      Checked = True
      Hint = 
        'Active/D'#233'sactive les sanctions pour proposition non valide (z'#233'ro' +
        ' point)'
      ShortCut = 16467
      OnExecute = ActionVideExecute
    end
    object ActionOptionsEnregistrer: TAction
      Category = 'Options'
      Caption = 'Enregistrer les param'#232'tres'
      Hint = 'M'#233'morise les param'#232'tres pour le prochain d'#233'marrage'
      ShortCut = 16473
      OnExecute = ActionOptionsEnregistrerExecute
    end
    object ActionOptionsEnregistrerEnQuittant: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Enregistrer les param'#232'tres en quittant'
      Checked = True
      Hint = 'Enregistre automatiquement ou non les param'#232'tres en quittant'
      ShortCut = 24641
      OnExecute = ActionVideExecute
    end
    object ActionOptionsReinitialiser: TAction
      Category = 'Options'
      Caption = 'R'#233'tablir les param'#232'tres par d'#233'faut'
      Hint = 'R'#233'tablit les options par d'#233'faut de r'#232'gles et d'#39'affichage'
      ShortCut = 16474
      OnExecute = ActionOptionsReinitialiserExecute
    end
    object ActionOptionsGenererAutoFDM: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'G'#233'n'#233'rer automatiquement la feuille de match HTML'
      Checked = True
      Hint = 'G'#233'n'#232're ou non apr'#232's chaque coup la feuille de match HTML'
      OnExecute = ActionVideExecute
    end
    object ActionOptionsViderListePartiesJouees: TAction
      Category = 'Options'
      Caption = 'Vider la liste des parties jou'#233'es'
      Hint = 'Vide la liste des parties jou'#233'es du menu Affichage'
      ShortCut = 16470
      OnExecute = ActionOptionsViderListePartiesJoueesExecute
    end
    object ActionOptionsEnregistrerPartieAuto: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Enregistrer automatiquement la partie'
      Checked = True
      Hint = 
        'Enregistre automatiquement ou non la partie apr'#232's chaque coup jo' +
        'u'#233
      ShortCut = 16449
      OnExecute = ActionVideExecute
    end
    object ActionOptionsPlacerPropositionAuto: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Placer automatiquement la proposition'
      Hint = 
        'Place automatiquement la proposition au lieu de la meilleure sol' +
        'ution'
      OnExecute = ActionVideExecute
    end
    object ActionOptionsReinitialiserRecords: TAction
      Category = 'Options'
      Caption = 'R'#233'initialiser les records'
      Hint = 'R'#233'initialise tous les records'
      ShortCut = 24666
      OnExecute = ActionOptionsReinitialiserRecordsExecute
    end
    object ActionOptionsAppliquer: TAction
      Category = 'Options'
      Caption = 'R'#233'tablir les param'#232'tres enregistr'#233's'
      Hint = 'R'#233'tablit les derniers param'#232'tres enregistr'#233's'
      ShortCut = 24665
      OnExecute = ActionOptionsAppliquerExecute
    end
    object ActionOptionsQualitePose: TAction
      Category = 'Options'
      Caption = 'Qualit'#233' des solutions pour le choix de la pose...'
      Hint = 'Param'#232'tres de la qualit'#233' de la liste de choix de la pose'
      ShortCut = 16465
      OnExecute = ActionOptionsQualitePoseExecute
    end
    object ActionOptionsTypePartieBlitz: TAction
      Tag = 1
      Category = 'Options'
      Caption = 'Blitz (&1 minute)'
      GroupIndex = 2
      Hint = 'Dur'#233'e d'#39'une partie Blitz'
      ShortCut = 16433
      OnExecute = ActionOptionsTypePartieDureeExecute
    end
    object ActionOptionsTypePartieSemiRapide: TAction
      Tag = 2
      Category = 'Options'
      Caption = 'Semi-rapide (&2 minutes)'
      GroupIndex = 2
      Hint = 'Dur'#233'e d'#39'une partie semi-rapide'
      ShortCut = 16434
      OnExecute = ActionOptionsTypePartieDureeExecute
    end
    object ActionOptionsTypePartieNormale: TAction
      Tag = 3
      Category = 'Options'
      Caption = 'Normale (&3 minutes)'
      GroupIndex = 2
      Hint = 'Dur'#233'e d'#39'une partie normale'
      ShortCut = 16435
      OnExecute = ActionOptionsTypePartieDureeExecute
    end
    object ActionOptionsTypePartieStandard: TAction
      Tag = 1
      Category = 'Options'
      Caption = 'Standard'
      GroupIndex = 4
      Hint = 'Active/D'#233'sactive le type de partie "Standard"'
      ShortCut = 16432
      OnExecute = ActionOptionsTypePartieTirageExecute
    end
    object ActionOptionsTypePartieJoker: TAction
      Tag = 2
      Category = 'Options'
      Caption = 'Jo&ker'
      GroupIndex = 4
      Hint = 'Active/D'#233'sactive le type de partie "Joker"'
      ShortCut = 16459
      OnExecute = ActionOptionsTypePartieTirageExecute
    end
    object ActionPartieNouvelle: TAction
      Category = 'Partie'
      Caption = '&Nouvelle'
      Hint = 'Commence une nouvelle partie'
      ShortCut = 16462
      OnExecute = ActionPartieNouvelleExecute
    end
    object ActionPartieOuvrir: TAction
      Category = 'Partie'
      Caption = '&Ouvrir...'
      Hint = 'Ouvre une partie sauvegard'#233'e'
      ShortCut = 16463
      OnExecute = ActionPartieOuvrirExecute
    end
    object ActionPartieEnregistrerSous: TAction
      Category = 'Partie'
      Caption = 'Enregistrer &sous...'
      Hint = 'Enregistre la partie en cours sous un autre nom'
      ShortCut = 24645
      OnExecute = ActionPartieEnregistrerSousExecute
    end
    object ActionPartieEnregistrer: TAction
      Category = 'Partie'
      Caption = '&Enregistrer'
      Hint = 'Enregistre la partie en cours'
      ShortCut = 16453
      OnExecute = ActionPartieEnregistrerExecute
    end
    object ActionPartieQuitter: TAction
      Category = 'Partie'
      Caption = '&Quitter'
      Hint = 'Quitte Diplikata'
      OnExecute = ActionPartieQuitterExecute
    end
    object ActionPartieDemonstration: TAction
      Category = 'Partie'
      Caption = '&D'#233'monstration'
      Hint = 'L'#39'ordinateur joue tout seul sans intervention de votre part'
      ShortCut = 123
      OnExecute = ActionPartieDemonstrationExecute
    end
    object ActionAffichageFrancais: TAction
      Category = 'Affichage'
      Caption = 'Fran'#231'ais'
      ImageIndex = 2
      OnExecute = ActionAffichageLangueExecute
    end
    object ActionAffichageKreyolAyisyen: TAction
      Tag = 1
      Category = 'Affichage'
      Caption = 'Krey'#242'l Ayisyen'
      ImageIndex = 3
      OnExecute = ActionAffichageLangueExecute
    end
    object ActionPlacementHorizontal: TAction
      Tag = 1
      Category = 'Placement'
      Caption = 'Placer &Horizontalement'
      Hint = 'Place horizontalement les jetons s'#233'lectionn'#233's du chevalet'
      ImageIndex = 0
      OnExecute = ActionPlacementExecute
    end
    object ActionPlacementVertical: TAction
      Tag = 2
      Category = 'Placement'
      Caption = 'Placer &Verticalement'
      Hint = 'Place verticalement les jetons s'#233'lectionn'#233's du chevalet'
      ImageIndex = 1
      OnExecute = ActionPlacementExecute
    end
    object ActionTestPlacementHorizontal: TAction
      Tag = 3
      Category = 'Placement'
      Caption = 'Tester &Horizontalement'
      Hint = 'Teste le placement horizontal des jetons s'#233'lectionn'#233's'
      ImageIndex = 0
      OnExecute = ActionPlacementExecute
    end
    object ActionTestPlacementVertical: TAction
      Tag = 4
      Category = 'Placement'
      Caption = 'Tester &Verticalement'
      Hint = 'Teste le placement vertical des jetons s'#233'lectionn'#233's'
      ImageIndex = 1
      OnExecute = ActionPlacementExecute
    end
  end
  object ImageListActions: TImageList
    Left = 24
    Top = 56
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003410D1003410D2003410D2003310
      D200330FD2003410D2003410D200330FD200340FD1003410D2003410D200340F
      D1003310D2003410D200340FD2003310D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003410D1003410D2003410D2003310
      D200330FD2003410D2003410D200330FD200340FD1003410D2003410D200340F
      D1003310D2003410D200340FD2003310D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008080800080808000C0C0C000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003410D1003410D2003410D2003310
      D200330FD2003410D2003410D200330FD200340FD1003410D2003410D200340F
      D1003310D2003410D200340FD2003310D2000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C000C0C0
      C000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED00340FD1003410D100340FD100330F
      D100330FD100340FD1003410D200330FD100340FD100340FD200340FD100340F
      D100330FD100340FD100340FD100330FD1000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      000000000000808080008080800080808000808080008080800080808000C0C0
      C000C0C0C0000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003410D1003410D2003410D2003310
      D200330FD2003410D2003410D1003310D1003310D1003310D1003410D200340F
      D1003310D2003410D200340FD2003310D200000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000808080008080
      8000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000C0C0C000C0C0C00000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003410D1003410D2003410D2003310
      D200330FD2003410D200360CDA002F04DD003005DC003508E000340FD200340F
      D1003310D2003410D200340FD2003310D2000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000C0C0C000C0C0C000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED003610CD003610CD003610CD003610
      CD003610CD003610CD007671C40021826A00227C75009BBAB1003610CD003610
      CD003610CD003610CD003610CD003610CD000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000C0C0C000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED002E0FDC002E0FDC002E0FDC002E0F
      DC002E0FDC002E0FDC009788F700423656002D388300D7D1FF002F10DC002E0F
      DC002E0FDC002E0FDC002E0FDC002E0FDC000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED00A4200000A4200000A4200000A420
      0000A4200000A4200000D08B7800AB898D00B1A0A000F4E6DF00A4210000A420
      0000A4200000A4200000A4200000A42000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009C1F04009C1F04009C1F04009C1F
      04009C1F04009C1F0400CD8F8700C2E4D50087B69300F5EBEA009D2004009C1F
      04009C1F04009C1F04009C1F04009C1F04000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009F2000009F2000009F2000009F20
      00009F1F00009F1F00009A160000990E00009C100000970E00009E1F00009F1F
      00009F2000009F2000009E1F00009F2000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009F1F00009F2000009F1F00009F1F
      00009F1F00009F1F00009F2000009F2000009F2000009F2000009F2000009F1F
      00009F1F00009F1F00009E1F00009F1F00000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009E2000009E2000009E2000009E20
      00009E1F00009F2000009E2000009E1F00009E1F00009E2000009F2000009E1F
      00009E2000009E2000009E1F00009F2000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009F2000009F2000009F2000009F20
      00009F1F00009F2000009F2000009F1F00009F1F00009F2000009F2000009E1F
      00009F2000009F2000009E1F00009F2000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009F2000009F2000009F2000009F20
      00009F1F00009F2000009F2000009F1F00009F1F00009F2000009F2000009F1F
      00009F2000009F2000009E1F00009F2000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009523000095230000952300009523
      000095230000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003929
      ED003929ED003929ED003929ED003929ED009F1F00009F2000009F1F00009F1F
      00009F1F00009F1F00009F2000009F1F00009F1F00009F1F00009F1F00009F1F
      00009F1F00009F1F00009E1F00009F1F0000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000FFFFFF3F00000000
      FFDFFE1F00000000FF8FFC0F00000000FF87F80700000000E003F00300000000
      C001E00700000000C001FC1F00000000C003FC1F00000000C007FC1F00000000
      FF8FFC1F00000000FF9FFC1F00000000FFBFFC1F00000000FFFFFC3F00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenuPlacement: TPopupMenu
    AutoHotkeys = maManual
    Images = ImageListActions
    Left = 56
    Top = 56
    object MenuItemPlacementGaucheDroite: TMenuItem
      Action = ActionPlacementHorizontal
    end
    object MenuItemPlacementHautBas: TMenuItem
      Action = ActionPlacementVertical
    end
  end
  object PopupMenuTestPlacement: TPopupMenu
    AutoHotkeys = maManual
    Images = ImageListActions
    Left = 56
    Top = 88
    object MenuItemTestPlacementHorizontal: TMenuItem
      Action = ActionTestPlacementHorizontal
    end
    object MenuItemTestPlacementVertical: TMenuItem
      Action = ActionTestPlacementVertical
    end
  end
  object TimerMelangeur: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerMelangeurTimer
    Left = 88
    Top = 24
  end
  object TimerDicoOk: TTimer
    OnTimer = TimerDicoOkTimer
    Left = 88
    Top = 56
  end
  object TimerReflexion: TTimer
    Enabled = False
    Interval = 250
    OnTimer = TimerReflexionTimer
    Left = 88
    Top = 88
  end
  object TimerDemonstration: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDemonstrationTimer
    Left = 88
    Top = 120
  end
  object TimerAPropos: TTimer
    OnTimer = TimerAProposTimer
    Left = 88
    Top = 152
  end
  object TimerClignotement: TTimer
    OnTimer = TimerClignotementTimer
    Left = 88
    Top = 184
  end
  object OpenDialog: TOpenDialog
    OnShow = OpenDialogShow
    DefaultExt = 'dup'
    Filter = 'Partie Diplikata (*.dip)|*.dip'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'S'#233'lectionnez le fichier de partie Diplikata sauvegard'#233'e'
    Left = 120
    Top = 24
  end
  object SaveDialog: TSaveDialog
    OnShow = SaveDialogShow
    DefaultExt = 'dup'
    Filter = 'Partie Diplikata (*.dip)|*.dip'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Sp'#233'cifiez le chemin et le nom de partie sauvegard'#233'e'
    Left = 152
    Top = 24
  end
end
