unit cststr; // v1.5
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses base;
//---------------------------------------------------------------------------
// Feuille de match détaillée (Fdmd)
// v1.4 : Ajout Scores Joués + Définitions
// v1.4.7 : Ajout Nb Moyen de Solutions + 2 lignes pour les sous-titres de colonnes
// v1.4.8 : En-tête stats sur 3 niveaux avec regroupement des moyennes (le temps moyen rejoint scores, rangs et NbSol)
// v1.5 : permutation Temp Rang/Solution dans les moyenne pour conserver le même ordre
// v1.5 : découpage des chaînes EnTete et PdPage suite à panique du compilateur avec des constantes de chaînes trop longues (???)
// v1.5 : Unité spécialisée pour les longues constantes de chaînes faisant décaler les repères de localisation de sources
//---------------------------------------------------------------------------
const stHTMLSansNom    ='[Sans nom]'; stHTMLItaliqueSansNom='<I>'+stHTMLSansNom+'</I>';
      stHTMLImgNivDiff ='<img src="%s" width=55 height=13 title="%s">'; // vWK
      // v1.6 : Légende Niveau de difficulté mis en constante . v1.6.2 : ajout de retours chariot pour mettre sur 3 lignes et empêcher d'avoir un tableau de légende sur toute la largeur...
      stHTMLDefNivDiff ='<BR>'+stHTMLImgNivDiff+' = évaluation indisponible (pas de solution ou version &lt; v1.5), <BR>'+
                        stHTMLImgNivDiff+' = de ~79,5%% à 100%%, '+stHTMLImgNivDiff+' = de ~49%% à ~79,5%%, '+stHTMLImgNivDiff+' = de ~30,5%% à ~49%%, <BR>'+
                        stHTMLImgNivDiff+' = de ~19%% à ~30,5%%, '+stHTMLImgNivDiff+' = de ~11,5%% à ~19%%, '+stHTMLImgNivDiff+' = de ~7%% à ~11,5%%, '+stHTMLImgNivDiff+' = de ~4%% à ~7%%, <BR>'+
                        stHTMLImgNivDiff+' = de ~2%% à ~4%%, '+stHTMLImgNivDiff+' = de ~1%% à ~2%%, '+stHTMLImgNivDiff+' = de ~0,25%% à 1%%, '+stHTMLImgNivDiff+' = de 0%% à ~0,25%%.'+'</td></tr>'#13;

      stFrmHTMLFdmdEnT1='<?xml version="1.0" encoding="iso-8859-1"?>'#13+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Feuille de match détaillée - Word Killers</title><meta content="Feuille de match détaillée Word Killers" name="description"><meta content="Feuille de match détaillée, Word Killers" name="keywords"></head>'#13+'<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>Feuille de match détaillée - Word Killers</h1></center>'#13'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td align="center" ROWSPAN=3><I>T.</I></td><td align="center" ROWSPAN=3><I>Tirage</I></td><td COLSPAN=2 align="center"><I>Proposition</I></td><td COLSPAN=2 align="center">';
                        // v1.4.9 (ci-dessous) : proposition JOUEE
                        // v1.5   (ci-dessous) : Ajout Bonus 50 entre Solutions et Niveau de difficulté
                        // v1.6 : ajout de Tps calcul solutions, Nb sol./s et les moyennes
      stFrmHTMLFdmdEnT2='<I>Solution jouée</I></td>'+'<td COLSPAN=3 align="center"><I>Score Tour</I></td>'+'<td COLSPAN=3 align="center"><I>Score Partie</I></td>'+'<td COLSPAN=2 align="center"><I>Tps réflexion</I></td>'+'<td COLSPAN=15 align="center"><I>Statistiques</I></td></tr>'#13+
                        '<tr><td align="center" ROWSPAN=2><I>Pos.</I></td>'+'<td ROWSPAN=2><I>Mot<br>principal</I></td>'+'<td align="center" ROWSPAN=2><I>Pos.</I></td>'+'<td ROWSPAN=2><I>Mot<br>principal</I></td>'+'<td ROWSPAN=2><I>Prp</I></td>'+'<td ROWSPAN=2><I>Joué</I></td>'+'<td ROWSPAN=2><I>Top</I></td>'+'<td ROWSPAN=2><I>Prp</I></td>'+'<td ROWSPAN=2><I>Joué</I></td>'+'<td ROWSPAN=2><I>Top</I></td>'+'<td ROWSPAN=2 align="center"><I>Tour</I></td>'+'<td ROWSPAN=2 align="center"><I>Partie</I></td>'+'<td ROWSPAN=2><I>Rang</I></td>'+'<td ROWSPAN=2><I>Solutions</I></td>'+'<td ROWSPAN=2><I>Dont<br>B.50</I></td>'+'<td ROWSPAN=2><I>Niveau de<br>difficulté</I></td>'+'<td ROWSPAN=2><I>Rech.<br>sol.(s)</I></td>'+'<td ROWSPAN=2><I>Nb Sol./s</I></td>'+'<td COLSPAN=7 align="center"><I>Moyennes</I></td>'+'<td COLSPAN=2 align="center"><I>Scores%s</I></td></tr>'#13+
                        '<tr><td><I>Temps</I></td>'+'<td><I>Rang</I></td>'+'<td><I>Solutions</I></td>'+'<td><I>B.50</I></td>'+'<td><I>Niv.de diff.</I></td>'+'<td><I>R.sol.(s)</I></td>'+'<td><I>Nb Sol./s</I></td>'+'<td align="center"><I>T.</I></td>'+'<td align="center"><I>P.</I></td></tr>'#13;

      // v1.5.5 : Le mot principal de la solution jouée n'est plus l'un des tops
      // v1.6.6 : Les nouveaux jetons du tirage sont en souligné
      stFrmHTMLFdmdPdP1='</tbody></table>'#13#13+'<H2>Légende</H2>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><td><B>Intitulé</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><I>T. (Tour)</I></td><td>Tour de jeu.</td></tr>'#13+
                        '<tr><td><I>Tirage</I></td><td>Contenu du chevalet. Les nouveaux jetons apparaissent en <U>souligné</U>. Le joker est représenté par un point d''interrogation (?).</td></tr>'#13+
                        '<tr><td><I>Mot principal de la proposition</I></td><td>Mot principal du coup proposé par le joueur et formé par les jetons posés à partir de la case indiquée par la position.</td></tr>'#13+
                        '<tr><td><I>Mot principal de la solution jouée</I></td><td>Mot principal du coup joué.</td></tr>'#13+
                        '<tr><td><I>Pos. (Position)</I></td><td>Coordonnées de la case départ du premier jeton posé (le mot formé pouvant commencer avant).<BR>'+
                        'La lettre indique la ligne (de <TT>A</TT> à <TT>O</TT>) et le nombre indique la colonne (de <TT>1</TT> à <TT>15</TT>).<BR>'+
                        'Si les coordonnées commencent par une lettre, les jetons sont posés horizontalement.<BR>'+
                        'Si les coordonnées commencent par un chiffre, les jetons sont posés verticalement.</td></tr>'#13+
                        '<tr><td><I>Score Tour Prp (Proposé)</I></td><td>Score du coup proposé par le joueur. L''astérisque indique qu''il s''agit d''un top.</td></tr>'#13+
                        '<tr><td><I>Score Tour Joué</I></td><td>Score du coup (solution) qui a été joué.</td></tr>'#13+
                        '<tr><td><I>Score Tour Top</I></td><td>Score du coup (solution) qui rapporte le plus de points possibles.</td></tr>'#13+
                        '<tr><td><I>Score Partie Prp (Proposé)</I></td><td>Cumul du score des coups proposés à chaque tour par le joueur.</td></tr>'#13+
                        '<tr><td><I>Score Partie Joué</I></td><td>Score de la partie jouée.</td></tr>'#13+
                        '<tr><td><I>Score Partie Top</I></td><td>Cumul des scores les plus élevés de chaque tour.</td></tr>'#13+
                        '<tr><td><I>Tps réflexion Tour</I></td><td>Temps de réflexion écoulé entre le tirage et la proposition. Les temps atteignant ou dépassant la limite impartie sont en <font color="#FF000">rouge</font>.</td></tr>'#13+
                        '<tr><td><I>Tps réflexion Partie</I></td><td>Temps de réflexion écoulé depuis le début de la partie (cumul).</td></tr>'#13+
                        '<tr><td><I>Rang</I></td><td>Position de la proposition du joueur dans le classement de toutes les solutions possibles selon l''ordre décroissant de leur score.</td></tr>'#13+
                        '<tr><td><I>Rang moyen</I></td><td>Position moyenne des propositions du joueur.</td></tr>'#13+
                        '<tr><td><I>Solutions</I></td><td>Nombre de solutions jouables distinctes (jetons posés différents).</td></tr>'#13+
                        '<tr><td><I>Moyenne Solutions</I></td><td>Nombre moyen de solutions jouables distinctes (jetons posés différents).</td></tr>'#13+
                        '<tr><td><I>B.50</I></td><td>Nombre de solutions jouables distinctes ayant le bonus 50 pour placement de tous les jetons du chevalet.<br>'#13+
                         '('#42') Au premier tour, le nombre est divisé par 14 (nombre de placements possibles d''un mot de 7 lettres au départ).</td></tr>'#13+
                        '<tr><td><I>Moyenne B.50</I></td><td>Nombre moyen de solutions ayant le bonus 50 par tour au cours de la partie.</td></tr>'#13;
      // v1.6 : Légende Niveau de difficulté mis en constante (stHTMLDefNivDiff)
      stFrmHTMLFdmdPdP2='<tr><td><I>Score (%s) T. (Tour)</I></td><td>Rapport entre le Score et le Score Top. Les nuances de couleurs sont relatives à la performance&nbsp;: '+
                        '<font color="#FF0000">rouge</font>=très faible, <font color="#FFA000">orange</font>=faible, <font color="#FFFF00">jaune</font>=moyenne, <font color="#00FF00">vert</font>=bonne et <font color="#00FFFF">ciel</font>=top.</td></tr>'#13+
                        '<tr><td><I>Score (%s) P. (Partie)</I></td><td>Rapport entre le Cumul et le Cumul Top.</td></tr>'#13+
                        '<tr><td><I>Temps moyen</I></td><td>Temps de réflexion moyen (temps cumulé/nombre de tours). Les temps atteignant ou dépassant la limite impartie sont en <font color="#FF000">rouge</font>.</td></tr>'#13+
                        '<tr><td><I>Niveau de difficulté</I></td><td>Evaluation donnée à partir du pourcentage de solutions atteignant au moins la moitié du score du top&nbsp;: '+
                        stHTMLDefNivDiff;
      // v1.3.2 : Pour avoir plac...
      // v1.3.10 : joker posé (bleu foncé éclairci)
      // v1.5.6 : Parties joker (lettre substituée)
      stFrmHTMLFdmdPdP3='<tr><td><I>Rech.sol.</I></td><td>Temps nécessaire qu''il a fallu pour calculer toutes les solutions (exprimé en secondes). Information pour les parties générées avec une version 1.6 ou ultérieure uniquement.</td></tr>'#13+
                        '<tr><td><I>Nb Sol./s</I></td><td>Nombre moyen de solutions trouvées en une seconde. Information pour les parties générées avec une version 1.6 ou ultérieure uniquement.</td></tr>'#13+
                        '</tbody></table><p>'#13#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td><B>Nature et style</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><U>SCORE</U></td><td>Score (souligné) incluant un bonus de 50 points pour avoir placé les 7 jetons sur le plateau de jeu (sauf Score Top).</td></tr>'#13+
                        '<tr><td><U>LETTRE</U></td><td>Lettre (soulignée) correspondant à un jeton posé sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><U><FONT COLOR="#0000FF">L</FONT><FONT COLOR="#00FFFF">E</FONT><FONT COLOR="#FFC0C0">T</FONT><FONT COLOR="#FF0000">T</FONT>'+
                        '<FONT COLOR="#4040FF">R</FONT><FONT COLOR="#00FFFF">E</FONT>'+
                        '</U></td><td>Lettre (colorée) correspondant à un jeton posé sur une case bonus de la même couleur.</td></tr>'#13+
                        '<tr><td><I>LETTRE</I></td><td>Lettre (en italique) correspondant à un nouveau jeton du tirage.</td></tr>'#13+
                        '<tr><td>lettre</td><td>Lettre (en minuscule) attribuée à un jeton joker posé sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><FONT COLOR="#00FF00">LETTRE</FONT></td><td>Lettre substituée à un joker (parties "joker" uniquement).</td></tr>'#13+
                        '<tr><td>?</td><td>Jeton du tirage correspondant à un joker.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5 ligne ci-dessous : ajout code couleur pour les rapports (du rouge au vert via jaune/orange) en fonction de la performance.
      // v1.5 ligne ci-dessous : ajout espace insécable entre sur et %d pour empêcher le retour à la ligne automatique par le navigateur
      // v1.5 : ajout du nombre de bonus 50 (moyenne)
      // v1.6 : ajout du tps recherche solutions + nbsol/s
      // v1.8.3 : Tirage en police fixe (TT)
      stFrmHTMLFdmdLgn ='<tr><td align="right">%d.</td><td><TT>%s</TT></td>'+
                        '<td align="center"><TT>%s</TT></td><td>%s</td>'+
                        '<td align="center"><TT>%s</TT></td><td>%s</td>'+
                        '<td align="right">%s</td><td align="right">%s</td><td align="left">/%s</td>'+
                        '<td align="right">%d</td><td align="right">%d</td><td align="left">/%d</td>'+
                        '<td align="center">%s</td><td align="center">%s</td>'+
                        '<td align="right">%d%s</td><td align="left">sur&nbsp;%d</td>'+
                        '<td align="right">%s</td>'+
                        '<td align="center">'+stHTMLImgNivDiff+
                        '<td align="right">%s</td>'+
                        '<td align="right">%s</td>'+
                        '</td><td align="center">%s</td><td align="right">%d%s</td><td align="left">sur&nbsp;%d</td>'+
                        '<td align="right">%s</td>'+
                        '<td align="center">'+stHTMLImgNivDiff+
                        '<td align="right">%s</td>'+
                        '<td align="right">%s</td>'+
                        '<td align="right"><font color="%s">%.1f</font></td><td align="right"><font color="%s">%.1f</font></td></tr>'#13;

      // Liste des parties jouées (LdPJ)
      // v1.5 : pour les deux lignes ci-dessous, ajout de la date et de l'heure après le nom de partie
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJEnT= '<?xml version="1.0" encoding="iso-8859-1"?>'#13+
                        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Parties jouées - Word Killers</title><meta content="Parties jouées Word Killers" name="description"><meta content="Parties jouées, Word Killers" name="keywords"></head>'#13+
                        '<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>Parties jouées - Word Killers</h1></center>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td ROWSPAN=2 align="center"><I>N°</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Nom</I>'+
                        '<td ROWSPAN=2 align="center"><I>Date Heure</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Coups</I></td>'#13+
                        '<td ROWSPAN=2 align="center"><I>Reliquat</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Temps</I></td>'+
                        '<td COLSPAN=3 align="center"><I>Score</I></td>'+
                        '<td COLSPAN=6 align="center"><I>Moyenne</I></td></tr>'#13+
                        '<tr><td align="center"><I>Proposé</I></td>'+
                        '<td align="center"><I>Joué</I></td>'+
                        '<td align="center"><I>Top</I></td>'+
                        '<td align="center"><I>Rang</I></td>'+
                        '<td align="center"><I>Solutions</I></td>'+
                        '<td align="center"><I>Bonus&nbsp;50</I></td>'+
                        '<td align="center"><I>Niv.de diff.</I></td>'#13+
                        '<td align="center"><I>Rech.Sol.(s)</I></td>'#13+
                        '<td align="center"><I>Nb Sol./s</I></td></tr>'#13;

      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJPdP1='</tbody></table>'#13#13'<H2>Légende</H2>'#13'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td><B>Intitulé</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><I>Nom</I></td><td>Nom de fichier de la partie enregistrée. Si la partie n''a pas été enregistrée, '+stHTMLItaliqueSansNom+' est affiché. Si le nom de partie est coloré, il s''agit d''une partie de type non standard (<FONT COLOR="#00FF00">vert</FONT>=parties "joker")</td></tr>'#13+
                        '<tr><td><I>Date Heure</I></td><td>Date et heure auxquelles la partie s''est terminée.</td></tr>'#13+
                        '<tr><td><I>Coups</I></td><td>Nombre de coups joués dans la partie.</td></tr>'#13+
                        '<tr><td><I>Reliquat</I></td><td>Jetons non joués (le cas échéant).</td></tr>'#13+
                        '<tr><td><I>Score Proposé</I></td><td>Score de la partie concernant uniquement les propositions du joueur. Les nuances de couleurs sont relatives à la performance&nbsp;: '+
                        '<font color="#FF0000">rouge</font>=très faible, <font color="#FFA000">orange</font>=faible, <font color="#FFFF00">jaune</font>=moyenne et <font color="#00FF00">vert</font>=bonne.</td></tr>'#13;
      stFrmHTMLLdPJPdP2='<tr><td><I>Score Joué</I></td><td>Score de la partie concernant uniquement les propositions placées sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><I>Score Top</I></td><td>Score Top de la partie (cumul des scores des meilleurs coups possibles à chaque tour).</td></tr>'#13'<tr><td><I>Temps</I></td><td>Temps de réflexion écoulé durant la partie.</td></tr>'#13+
                        '<tr><td><I>Rang</I></td><td>Position moyenne des propositions du joueur dans le classement de toutes les solutions possibles selon l''ordre décroissant de leur score.</td></tr>'#13+
                        '<tr><td><I>Solutions</I></td><td>Nombre moyen de solutions jouables distinctes (jetons posés différents).<br>'#13+
                        '('#42') Niveau de difficulté pondéré sur le nombre de solutions (Parties jouées avec la version 1.5 de Word Killers) et non le score top (versions 1.5.1 ou ultérieures).</td></tr>'#13+
                        '<tr><td><I>Bonus 50</I></td><td>Nombre moyen par tour de solutions possibles ayant un bonus de 50 points pour placement de tous les jetons sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><I>Niv.de diff.</I></td><td>Evaluation du niveau de difficulté donnée à partir du pourcentage de solutions atteignant au moins la moitié du score du top&nbsp;: '#13;
      // v1.6 : Légende Niveau de difficulté mis en constante (stHTMLDefNivDiff).
      stFrmHTMLLdPJPdP3=stHTMLDefNivDiff+
                        '<tr><td><I>Rech.Sol.</I></td><td>Temps nécessaire qu''il a fallu pour calculer toutes les solutions (exprimé en secondes). Information pour les parties générées avec une version 1.6 ou ultérieure uniquement.</td></tr>'#13+
                        '<tr><td><I>Nb Sol./s</I></td><td>Nombre moyen de solutions trouvées en une seconde. Information pour les parties générées avec une version 1.6 ou ultérieure uniquement.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5 : pour les deux lignes ci-dessous, utilisation du format de rapport paramétré (% ou /20). '%d (%s)' au lieu de '%d (%.1f %%)'
      // v1.5 : pour les deux lignes ci-dessous, utilisation d'un code couleur de rouge vers vert pour quantifier la performance
      // v1.5 : pour la ligne ci-dessous : ajout espace insécable entre sur et %d pour empêcher le retour à la ligne automatique par le navigateur
      // v1.5 : pour les deux lignes ci-dessous, ajout de la date et de l'heure après le nom de partie (pour la moyenne, fusion de cellule)
      // v1.5.1 : pour la ligne ci-dessous, ajout de %s pour mettre un astérisque indiquant un niveau de difficulté NON pondéré par le score top (mais le nombre de solutions).
      // v1.5 : nb sol avec bonus 50
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJLgn= '<tr><td align="right">%d.</td><td>%s</td><td align="center">%s</td><td align="right">%d</td><td><TT>%s</TT></td><td align="center">%s</td>'+'<td align="right">%d (<font color="%s">%s</font>)</td><td align="right">%d</td>'+'<td align="right">%d</td><td align="right">%d</td><td>sur&nbsp;%d%s</td>'+'<td align="right">%s</td>'#13+'<td align="center">'+stHTMLImgNivDiff+#13+'<td align="right">%s</td>'#13+'<td align="right">%s</td></tr>'#13;

      // v1.5.6 : ajout de 'des parties de type %s', align="left". v1.5 : nb sol avec bonus 50
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJMoy= '<tr><td colspan=3><B>Moyenne des parties de type %s</B></td><td align="right"><B>%d</B></td><td><I>&nbsp;</I></td><td align="center"><B>%s</B></td>'+'<td align="right"><B>%d (<font color="%s">%s</font>)</B></td>'#13+'<td align="right"><B>%d</B></td><td align="right"><B>%d</B></td><td align="right"><B>%d</B></td><td><B>sur&nbsp;%d</B></td>'+'<td align="right"><B>%s</B></td>'#13+'<td align="center">'+stHTMLImgNivDiff+#13+'<td align="right"><B>%s</B></td>'#13+'<td align="right"><B>%s</B></td></tr>'#13;

      // v1.5.7 ci-dessous, colspan=3 pour les en-têtes Générale, Proposition et Top et ajout de Standard/Joker pour la ligne du dessous
      // v1.5.7 ci=dessous, EnT coupé en deux : Ent1 et Ent2
      stFrmHTMLLdREnT = '<?xml version="1.0" encoding="iso-8859-1"?>'#13+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+'<html><head><title>Records - Word Killers</title>'+'<meta content="Records Word Killers" name="description"><meta content="Records, Word Killers" name="keywords"></head>'#13+'<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+'<center><h1>Records - Word Killers</h1></center>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><th rowspan=2>Nature</th><th>Source</th><th colspan=3>Générale</th>'+'<th colspan=3>Proposition</th><th colspan=3>Top</th></tr>'#13+'<tr><th>Niveau</th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th></tr>'#13;

      stFrmHTMLLdR1LMax='<tr><td colspan=2><b>%s</b></td>%s</tr>'#13;
      stFrmHTMLLdR2LMin='<tr><td rowspan=2><b>%s</b></td><td align="center"><b>Min*</b></td>%s</tr>'#13;
      stFrmHTMLLdR2LMax='<tr><td align="center"><b>Max</b></td>%s</tr>'#13;

      // v1.5.7 : stFrmHTMLLdRCell est décomposé en stFrmHTMLLdRTexte(stFrmHTMLLdRCell) pour pouvoir changer la couleur du texte suivant le type de partie
      stFrmHTMLLdRCell='<b>%s</b><br>%s<i>%s%s</i>%s'; // Valeur, Libellé, Nom Partie, Tour, Date Heure
      stFrmHTMLLdRTexte= '<td align="center">%s</td>';

      // v1.5.4 : balise incorrecte </br> supprimée ci-dessous
      // v1.6.2 : ajout des légendes de records liés au temps de calcul
      stFrmHTMLLdRPdP1= '</tbody></table>'#13'('#42') Valeur nulle exclue.'+'<H2>Légende</H2>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><th>Nature</th><th>Description</th>'#13+'<tr><td><I>Détail du record</i></td><td align="center"><b>Valeur</b><br>(Infos&nbsp;complémentaires)<br><i>Nom&nbsp;de&nbsp;la&nbsp;partie&nbsp;:&nbsp;Tour</i><br>Date&nbsp;heure</td></tr>'#13+'<tr><td><b>Rang</b></td><td>Position des propositions du joueur dans le classement de toutes les solutions possibles selon l''ordre décroissant de leur score.</td></tr>'#13;
      stFrmHTMLLdRPdP2= '<tr><td><b>Nombre de solutions (Nb sol.)</b></td><td>Nombre de solutions jouables distinctes (jetons posés différents) lors d''un tour.</td></tr>'#13+'<tr><td><b>Top</b></td><td>Score maximal lors d''un tour ou somme des scores maximaux de chaque tour pour une partie.</td>'#13+'<tr><td><b>Rapport Score/Top</b></td><td>Rapport (en %% ou /20 selon l''option d''affichage des rapports) entre le score de la proposition et le top lors d''un tour.</td>'#13+'<tr><td><b>Niveau de difficulté</b></td><td>Evaluation du niveau de difficulté donnée à partir du pourcentage de solutions atteignant au moins la moitié du score du top&nbsp;:'#13;
      stFrmHTMLLdRPdP3= stHTMLDefNivDiff+
                        '<tr><td><B>Tps de calc. des sol.</B></td><td>Temps nécessaire qu''il a fallu pour calculer toutes les solutions (exprimé en secondes).</td></tr>'#13+
                        '<tr><td><B>Nb sol. trouvées / s.</B></td><td>Nombre moyen de solutions trouvées en une seconde.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5.3 : défi n°1 : Mots de 15 lettres placés avec le moins de jetons possible
      stFrmHTMLD15lEnT= '<?xml version="1.0" encoding="iso-8859-1"?>'#13+
                        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Défi Word Killers n°1 : Former un mot de 15 lettres avec le moins de jetons possible</title><meta content="Défi n°1 Word Killers" name="description"><meta content="Défi n°1, Word Killers" name="keywords"></head>'#13+
                        '<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>Défi Word Killers n°1&nbsp;:<br>Former un mot de 15 lettres avec le moins de jetons possible</h1></center>'#13+
                        'Voici la liste des défis relevés. La liste est triée par ordre décroissant de valeur des mots puis par ordre alphabétique.<br>Vous trouverez la liste complète des mots <A HREF="./html/top15.txt">ici</A>.<br>'+' Le mot le plus difficile à placer jusqu''à ce jour apparaît en <b>gras</b>.<P>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><th colspan=3>Défi</th><th colspan=6>Performance</th></tr>'#13+
                        '<tr><th>N°</th><th>Mot</th><th>Valeur</th><th>Jetons*</th><th>Coups*</th><th>Score</th><th>Cumul*</th><th>Date/Heure</th><th>Nom de partie</th></tr>'#13;

      stFrmHTMLD15lLgn= '<tr><td align="right">%s%d%s</td><td><TT>%s%s%s</TT></td><td align="right">%s%d%s</td><td align="right">%s%d%s</td><td align="right">%s%d%s</td>'+'<td align="right">%s%d%s</td><td align="right">%s%d%s</td><td align="center">%s%s%s</td><td><TT>%s%s%s</TT></td></tr>'#13;

      stFrmHTMLD15lPdp= '</tbody></table>'#13'('#42') Dernier coup du mot de 15 lettres <b>exclu</b>.'#13+
                        '<H2>Légende</H2>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><th>Nature</th><th>Description</th>'#13+
                        '<tr><td><b>Valeur</b></td><td>Cumul de la valeur des lettres du mot de quinze lettres, hors bonus et jokers</td></tr>'#13+
                        '<tr><td><b>Jetons</b></td><td>Nombre de jetons posés ne faisant pas partie du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Coups</b></td><td>Nombre de coups de préparation qu''il a fallu avant de pouvoir poser le mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Score</b></td><td>Score obtenu lors de la pose du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Cumul</b></td><td>Cumul des scores avant la pose du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Date/Heure</b></td><td>Date et heure auxquelles le défi a été relevé</td></tr>'#13+
                        '<tr><td><b>Nom de partie</b></td><td>Nom de la partie dans le cas où elle a été enregistrée</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
end.

