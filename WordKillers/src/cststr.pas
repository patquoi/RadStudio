unit cststr; // v1.5
//---------------------------------------------------------------------------
interface
//---------------------------------------------------------------------------
uses base;
//---------------------------------------------------------------------------
// Feuille de match d�taill�e (Fdmd)
// v1.4 : Ajout Scores Jou�s + D�finitions
// v1.4.7 : Ajout Nb Moyen de Solutions + 2 lignes pour les sous-titres de colonnes
// v1.4.8 : En-t�te stats sur 3 niveaux avec regroupement des moyennes (le temps moyen rejoint scores, rangs et NbSol)
// v1.5 : permutation Temp Rang/Solution dans les moyenne pour conserver le m�me ordre
// v1.5 : d�coupage des cha�nes EnTete et PdPage suite � panique du compilateur avec des constantes de cha�nes trop longues (???)
// v1.5 : Unit� sp�cialis�e pour les longues constantes de cha�nes faisant d�caler les rep�res de localisation de sources
//---------------------------------------------------------------------------
const stHTMLSansNom    ='[Sans nom]'; stHTMLItaliqueSansNom='<I>'+stHTMLSansNom+'</I>';
      stHTMLImgNivDiff ='<img src="%s" width=55 height=13 title="%s">'; // vWK
      // v1.6 : L�gende Niveau de difficult� mis en constante . v1.6.2 : ajout de retours chariot pour mettre sur 3 lignes et emp�cher d'avoir un tableau de l�gende sur toute la largeur...
      stHTMLDefNivDiff ='<BR>'+stHTMLImgNivDiff+' = �valuation indisponible (pas de solution ou version &lt; v1.5), <BR>'+
                        stHTMLImgNivDiff+' = de ~79,5%% � 100%%, '+stHTMLImgNivDiff+' = de ~49%% � ~79,5%%, '+stHTMLImgNivDiff+' = de ~30,5%% � ~49%%, <BR>'+
                        stHTMLImgNivDiff+' = de ~19%% � ~30,5%%, '+stHTMLImgNivDiff+' = de ~11,5%% � ~19%%, '+stHTMLImgNivDiff+' = de ~7%% � ~11,5%%, '+stHTMLImgNivDiff+' = de ~4%% � ~7%%, <BR>'+
                        stHTMLImgNivDiff+' = de ~2%% � ~4%%, '+stHTMLImgNivDiff+' = de ~1%% � ~2%%, '+stHTMLImgNivDiff+' = de ~0,25%% � 1%%, '+stHTMLImgNivDiff+' = de 0%% � ~0,25%%.'+'</td></tr>'#13;

      stFrmHTMLFdmdEnT1='<?xml version="1.0" encoding="iso-8859-1"?>'#13+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Feuille de match d�taill�e - Word Killers</title><meta content="Feuille de match d�taill�e Word Killers" name="description"><meta content="Feuille de match d�taill�e, Word Killers" name="keywords"></head>'#13+'<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>Feuille de match d�taill�e - Word Killers</h1></center>'#13'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td align="center" ROWSPAN=3><I>T.</I></td><td align="center" ROWSPAN=3><I>Tirage</I></td><td COLSPAN=2 align="center"><I>Proposition</I></td><td COLSPAN=2 align="center">';
                        // v1.4.9 (ci-dessous) : proposition JOUEE
                        // v1.5   (ci-dessous) : Ajout Bonus 50 entre Solutions et Niveau de difficult�
                        // v1.6 : ajout de Tps calcul solutions, Nb sol./s et les moyennes
      stFrmHTMLFdmdEnT2='<I>Solution jou�e</I></td>'+'<td COLSPAN=3 align="center"><I>Score Tour</I></td>'+'<td COLSPAN=3 align="center"><I>Score Partie</I></td>'+'<td COLSPAN=2 align="center"><I>Tps r�flexion</I></td>'+'<td COLSPAN=15 align="center"><I>Statistiques</I></td></tr>'#13+
                        '<tr><td align="center" ROWSPAN=2><I>Pos.</I></td>'+'<td ROWSPAN=2><I>Mot<br>principal</I></td>'+'<td align="center" ROWSPAN=2><I>Pos.</I></td>'+'<td ROWSPAN=2><I>Mot<br>principal</I></td>'+'<td ROWSPAN=2><I>Prp</I></td>'+'<td ROWSPAN=2><I>Jou�</I></td>'+'<td ROWSPAN=2><I>Top</I></td>'+'<td ROWSPAN=2><I>Prp</I></td>'+'<td ROWSPAN=2><I>Jou�</I></td>'+'<td ROWSPAN=2><I>Top</I></td>'+'<td ROWSPAN=2 align="center"><I>Tour</I></td>'+'<td ROWSPAN=2 align="center"><I>Partie</I></td>'+'<td ROWSPAN=2><I>Rang</I></td>'+'<td ROWSPAN=2><I>Solutions</I></td>'+'<td ROWSPAN=2><I>Dont<br>B.50</I></td>'+'<td ROWSPAN=2><I>Niveau de<br>difficult�</I></td>'+'<td ROWSPAN=2><I>Rech.<br>sol.(s)</I></td>'+'<td ROWSPAN=2><I>Nb Sol./s</I></td>'+'<td COLSPAN=7 align="center"><I>Moyennes</I></td>'+'<td COLSPAN=2 align="center"><I>Scores%s</I></td></tr>'#13+
                        '<tr><td><I>Temps</I></td>'+'<td><I>Rang</I></td>'+'<td><I>Solutions</I></td>'+'<td><I>B.50</I></td>'+'<td><I>Niv.de diff.</I></td>'+'<td><I>R.sol.(s)</I></td>'+'<td><I>Nb Sol./s</I></td>'+'<td align="center"><I>T.</I></td>'+'<td align="center"><I>P.</I></td></tr>'#13;

      // v1.5.5 : Le mot principal de la solution jou�e n'est plus l'un des tops
      // v1.6.6 : Les nouveaux jetons du tirage sont en soulign�
      stFrmHTMLFdmdPdP1='</tbody></table>'#13#13+'<H2>L�gende</H2>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><td><B>Intitul�</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><I>T. (Tour)</I></td><td>Tour de jeu.</td></tr>'#13+
                        '<tr><td><I>Tirage</I></td><td>Contenu du chevalet. Les nouveaux jetons apparaissent en <U>soulign�</U>. Le joker est repr�sent� par un point d''interrogation (?).</td></tr>'#13+
                        '<tr><td><I>Mot principal de la proposition</I></td><td>Mot principal du coup propos� par le joueur et form� par les jetons pos�s � partir de la case indiqu�e par la position.</td></tr>'#13+
                        '<tr><td><I>Mot principal de la solution jou�e</I></td><td>Mot principal du coup jou�.</td></tr>'#13+
                        '<tr><td><I>Pos. (Position)</I></td><td>Coordonn�es de la case d�part du premier jeton pos� (le mot form� pouvant commencer avant).<BR>'+
                        'La lettre indique la ligne (de <TT>A</TT> � <TT>O</TT>) et le nombre indique la colonne (de <TT>1</TT> � <TT>15</TT>).<BR>'+
                        'Si les coordonn�es commencent par une lettre, les jetons sont pos�s horizontalement.<BR>'+
                        'Si les coordonn�es commencent par un chiffre, les jetons sont pos�s verticalement.</td></tr>'#13+
                        '<tr><td><I>Score Tour Prp (Propos�)</I></td><td>Score du coup propos� par le joueur. L''ast�risque indique qu''il s''agit d''un top.</td></tr>'#13+
                        '<tr><td><I>Score Tour Jou�</I></td><td>Score du coup (solution) qui a �t� jou�.</td></tr>'#13+
                        '<tr><td><I>Score Tour Top</I></td><td>Score du coup (solution) qui rapporte le plus de points possibles.</td></tr>'#13+
                        '<tr><td><I>Score Partie Prp (Propos�)</I></td><td>Cumul du score des coups propos�s � chaque tour par le joueur.</td></tr>'#13+
                        '<tr><td><I>Score Partie Jou�</I></td><td>Score de la partie jou�e.</td></tr>'#13+
                        '<tr><td><I>Score Partie Top</I></td><td>Cumul des scores les plus �lev�s de chaque tour.</td></tr>'#13+
                        '<tr><td><I>Tps r�flexion Tour</I></td><td>Temps de r�flexion �coul� entre le tirage et la proposition. Les temps atteignant ou d�passant la limite impartie sont en <font color="#FF000">rouge</font>.</td></tr>'#13+
                        '<tr><td><I>Tps r�flexion Partie</I></td><td>Temps de r�flexion �coul� depuis le d�but de la partie (cumul).</td></tr>'#13+
                        '<tr><td><I>Rang</I></td><td>Position de la proposition du joueur dans le classement de toutes les solutions possibles selon l''ordre d�croissant de leur score.</td></tr>'#13+
                        '<tr><td><I>Rang moyen</I></td><td>Position moyenne des propositions du joueur.</td></tr>'#13+
                        '<tr><td><I>Solutions</I></td><td>Nombre de solutions jouables distinctes (jetons pos�s diff�rents).</td></tr>'#13+
                        '<tr><td><I>Moyenne Solutions</I></td><td>Nombre moyen de solutions jouables distinctes (jetons pos�s diff�rents).</td></tr>'#13+
                        '<tr><td><I>B.50</I></td><td>Nombre de solutions jouables distinctes ayant le bonus 50 pour placement de tous les jetons du chevalet.<br>'#13+
                         '('#42') Au premier tour, le nombre est divis� par 14 (nombre de placements possibles d''un mot de 7 lettres au d�part).</td></tr>'#13+
                        '<tr><td><I>Moyenne B.50</I></td><td>Nombre moyen de solutions ayant le bonus 50 par tour au cours de la partie.</td></tr>'#13;
      // v1.6 : L�gende Niveau de difficult� mis en constante (stHTMLDefNivDiff)
      stFrmHTMLFdmdPdP2='<tr><td><I>Score (%s) T. (Tour)</I></td><td>Rapport entre le Score et le Score Top. Les nuances de couleurs sont relatives � la performance&nbsp;: '+
                        '<font color="#FF0000">rouge</font>=tr�s faible, <font color="#FFA000">orange</font>=faible, <font color="#FFFF00">jaune</font>=moyenne, <font color="#00FF00">vert</font>=bonne et <font color="#00FFFF">ciel</font>=top.</td></tr>'#13+
                        '<tr><td><I>Score (%s) P. (Partie)</I></td><td>Rapport entre le Cumul et le Cumul Top.</td></tr>'#13+
                        '<tr><td><I>Temps moyen</I></td><td>Temps de r�flexion moyen (temps cumul�/nombre de tours). Les temps atteignant ou d�passant la limite impartie sont en <font color="#FF000">rouge</font>.</td></tr>'#13+
                        '<tr><td><I>Niveau de difficult�</I></td><td>Evaluation donn�e � partir du pourcentage de solutions atteignant au moins la moiti� du score du top&nbsp;: '+
                        stHTMLDefNivDiff;
      // v1.3.2 : Pour avoir plac...
      // v1.3.10 : joker pos� (bleu fonc� �clairci)
      // v1.5.6 : Parties joker (lettre substitu�e)
      stFrmHTMLFdmdPdP3='<tr><td><I>Rech.sol.</I></td><td>Temps n�cessaire qu''il a fallu pour calculer toutes les solutions (exprim� en secondes). Information pour les parties g�n�r�es avec une version 1.6 ou ult�rieure uniquement.</td></tr>'#13+
                        '<tr><td><I>Nb Sol./s</I></td><td>Nombre moyen de solutions trouv�es en une seconde. Information pour les parties g�n�r�es avec une version 1.6 ou ult�rieure uniquement.</td></tr>'#13+
                        '</tbody></table><p>'#13#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td><B>Nature et style</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><U>SCORE</U></td><td>Score (soulign�) incluant un bonus de 50 points pour avoir plac� les 7 jetons sur le plateau de jeu (sauf Score Top).</td></tr>'#13+
                        '<tr><td><U>LETTRE</U></td><td>Lettre (soulign�e) correspondant � un jeton pos� sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><U><FONT COLOR="#0000FF">L</FONT><FONT COLOR="#00FFFF">E</FONT><FONT COLOR="#FFC0C0">T</FONT><FONT COLOR="#FF0000">T</FONT>'+
                        '<FONT COLOR="#4040FF">R</FONT><FONT COLOR="#00FFFF">E</FONT>'+
                        '</U></td><td>Lettre (color�e) correspondant � un jeton pos� sur une case bonus de la m�me couleur.</td></tr>'#13+
                        '<tr><td><I>LETTRE</I></td><td>Lettre (en italique) correspondant � un nouveau jeton du tirage.</td></tr>'#13+
                        '<tr><td>lettre</td><td>Lettre (en minuscule) attribu�e � un jeton joker pos� sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><FONT COLOR="#00FF00">LETTRE</FONT></td><td>Lettre substitu�e � un joker (parties "joker" uniquement).</td></tr>'#13+
                        '<tr><td>?</td><td>Jeton du tirage correspondant � un joker.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5 ligne ci-dessous : ajout code couleur pour les rapports (du rouge au vert via jaune/orange) en fonction de la performance.
      // v1.5 ligne ci-dessous : ajout espace ins�cable entre sur et %d pour emp�cher le retour � la ligne automatique par le navigateur
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

      // Liste des parties jou�es (LdPJ)
      // v1.5 : pour les deux lignes ci-dessous, ajout de la date et de l'heure apr�s le nom de partie
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJEnT= '<?xml version="1.0" encoding="iso-8859-1"?>'#13+
                        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>Parties jou�es - Word Killers</title><meta content="Parties jou�es Word Killers" name="description"><meta content="Parties jou�es, Word Killers" name="keywords"></head>'#13+
                        '<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>Parties jou�es - Word Killers</h1></center>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td ROWSPAN=2 align="center"><I>N�</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Nom</I>'+
                        '<td ROWSPAN=2 align="center"><I>Date Heure</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Coups</I></td>'#13+
                        '<td ROWSPAN=2 align="center"><I>Reliquat</I></td>'+
                        '<td ROWSPAN=2 align="center"><I>Temps</I></td>'+
                        '<td COLSPAN=3 align="center"><I>Score</I></td>'+
                        '<td COLSPAN=6 align="center"><I>Moyenne</I></td></tr>'#13+
                        '<tr><td align="center"><I>Propos�</I></td>'+
                        '<td align="center"><I>Jou�</I></td>'+
                        '<td align="center"><I>Top</I></td>'+
                        '<td align="center"><I>Rang</I></td>'+
                        '<td align="center"><I>Solutions</I></td>'+
                        '<td align="center"><I>Bonus&nbsp;50</I></td>'+
                        '<td align="center"><I>Niv.de diff.</I></td>'#13+
                        '<td align="center"><I>Rech.Sol.(s)</I></td>'#13+
                        '<td align="center"><I>Nb Sol./s</I></td></tr>'#13;

      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJPdP1='</tbody></table>'#13#13'<H2>L�gende</H2>'#13'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><td><B>Intitul�</B></td><td><B>Description</B></td></tr>'#13+
                        '<tr><td><I>Nom</I></td><td>Nom de fichier de la partie enregistr�e. Si la partie n''a pas �t� enregistr�e, '+stHTMLItaliqueSansNom+' est affich�. Si le nom de partie est color�, il s''agit d''une partie de type non standard (<FONT COLOR="#00FF00">vert</FONT>=parties "joker")</td></tr>'#13+
                        '<tr><td><I>Date Heure</I></td><td>Date et heure auxquelles la partie s''est termin�e.</td></tr>'#13+
                        '<tr><td><I>Coups</I></td><td>Nombre de coups jou�s dans la partie.</td></tr>'#13+
                        '<tr><td><I>Reliquat</I></td><td>Jetons non jou�s (le cas �ch�ant).</td></tr>'#13+
                        '<tr><td><I>Score Propos�</I></td><td>Score de la partie concernant uniquement les propositions du joueur. Les nuances de couleurs sont relatives � la performance&nbsp;: '+
                        '<font color="#FF0000">rouge</font>=tr�s faible, <font color="#FFA000">orange</font>=faible, <font color="#FFFF00">jaune</font>=moyenne et <font color="#00FF00">vert</font>=bonne.</td></tr>'#13;
      stFrmHTMLLdPJPdP2='<tr><td><I>Score Jou�</I></td><td>Score de la partie concernant uniquement les propositions plac�es sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><I>Score Top</I></td><td>Score Top de la partie (cumul des scores des meilleurs coups possibles � chaque tour).</td></tr>'#13'<tr><td><I>Temps</I></td><td>Temps de r�flexion �coul� durant la partie.</td></tr>'#13+
                        '<tr><td><I>Rang</I></td><td>Position moyenne des propositions du joueur dans le classement de toutes les solutions possibles selon l''ordre d�croissant de leur score.</td></tr>'#13+
                        '<tr><td><I>Solutions</I></td><td>Nombre moyen de solutions jouables distinctes (jetons pos�s diff�rents).<br>'#13+
                        '('#42') Niveau de difficult� pond�r� sur le nombre de solutions (Parties jou�es avec la version 1.5 de Word Killers) et non le score top (versions 1.5.1 ou ult�rieures).</td></tr>'#13+
                        '<tr><td><I>Bonus 50</I></td><td>Nombre moyen par tour de solutions possibles ayant un bonus de 50 points pour placement de tous les jetons sur le plateau de jeu.</td></tr>'#13+
                        '<tr><td><I>Niv.de diff.</I></td><td>Evaluation du niveau de difficult� donn�e � partir du pourcentage de solutions atteignant au moins la moiti� du score du top&nbsp;: '#13;
      // v1.6 : L�gende Niveau de difficult� mis en constante (stHTMLDefNivDiff).
      stFrmHTMLLdPJPdP3=stHTMLDefNivDiff+
                        '<tr><td><I>Rech.Sol.</I></td><td>Temps n�cessaire qu''il a fallu pour calculer toutes les solutions (exprim� en secondes). Information pour les parties g�n�r�es avec une version 1.6 ou ult�rieure uniquement.</td></tr>'#13+
                        '<tr><td><I>Nb Sol./s</I></td><td>Nombre moyen de solutions trouv�es en une seconde. Information pour les parties g�n�r�es avec une version 1.6 ou ult�rieure uniquement.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5 : pour les deux lignes ci-dessous, utilisation du format de rapport param�tr� (% ou /20). '%d (%s)' au lieu de '%d (%.1f %%)'
      // v1.5 : pour les deux lignes ci-dessous, utilisation d'un code couleur de rouge vers vert pour quantifier la performance
      // v1.5 : pour la ligne ci-dessous : ajout espace ins�cable entre sur et %d pour emp�cher le retour � la ligne automatique par le navigateur
      // v1.5 : pour les deux lignes ci-dessous, ajout de la date et de l'heure apr�s le nom de partie (pour la moyenne, fusion de cellule)
      // v1.5.1 : pour la ligne ci-dessous, ajout de %s pour mettre un ast�risque indiquant un niveau de difficult� NON pond�r� par le score top (mais le nombre de solutions).
      // v1.5 : nb sol avec bonus 50
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJLgn= '<tr><td align="right">%d.</td><td>%s</td><td align="center">%s</td><td align="right">%d</td><td><TT>%s</TT></td><td align="center">%s</td>'+'<td align="right">%d (<font color="%s">%s</font>)</td><td align="right">%d</td>'+'<td align="right">%d</td><td align="right">%d</td><td>sur&nbsp;%d%s</td>'+'<td align="right">%s</td>'#13+'<td align="center">'+stHTMLImgNivDiff+#13+'<td align="right">%s</td>'#13+'<td align="right">%s</td></tr>'#13;

      // v1.5.6 : ajout de 'des parties de type %s', align="left". v1.5 : nb sol avec bonus 50
      // v1.6 : ajout temps de calcul des solutions + Nb de solutions par seconde
      stFrmHTMLLdPJMoy= '<tr><td colspan=3><B>Moyenne des parties de type %s</B></td><td align="right"><B>%d</B></td><td><I>&nbsp;</I></td><td align="center"><B>%s</B></td>'+'<td align="right"><B>%d (<font color="%s">%s</font>)</B></td>'#13+'<td align="right"><B>%d</B></td><td align="right"><B>%d</B></td><td align="right"><B>%d</B></td><td><B>sur&nbsp;%d</B></td>'+'<td align="right"><B>%s</B></td>'#13+'<td align="center">'+stHTMLImgNivDiff+#13+'<td align="right"><B>%s</B></td>'#13+'<td align="right"><B>%s</B></td></tr>'#13;

      // v1.5.7 ci-dessous, colspan=3 pour les en-t�tes G�n�rale, Proposition et Top et ajout de Standard/Joker pour la ligne du dessous
      // v1.5.7 ci=dessous, EnT coup� en deux : Ent1 et Ent2
      stFrmHTMLLdREnT = '<?xml version="1.0" encoding="iso-8859-1"?>'#13+'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+'<html><head><title>Records - Word Killers</title>'+'<meta content="Records Word Killers" name="description"><meta content="Records, Word Killers" name="keywords"></head>'#13+'<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+'<center><h1>Records - Word Killers</h1></center>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><th rowspan=2>Nature</th><th>Source</th><th colspan=3>G�n�rale</th>'+'<th colspan=3>Proposition</th><th colspan=3>Top</th></tr>'#13+'<tr><th>Niveau</th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th>'+'<th>Tour</th><th>Partie Standard</th><th><FONT COLOR="#00FF00">Partie Joker</FONT></th></tr>'#13;

      stFrmHTMLLdR1LMax='<tr><td colspan=2><b>%s</b></td>%s</tr>'#13;
      stFrmHTMLLdR2LMin='<tr><td rowspan=2><b>%s</b></td><td align="center"><b>Min*</b></td>%s</tr>'#13;
      stFrmHTMLLdR2LMax='<tr><td align="center"><b>Max</b></td>%s</tr>'#13;

      // v1.5.7 : stFrmHTMLLdRCell est d�compos� en stFrmHTMLLdRTexte(stFrmHTMLLdRCell) pour pouvoir changer la couleur du texte suivant le type de partie
      stFrmHTMLLdRCell='<b>%s</b><br>%s<i>%s%s</i>%s'; // Valeur, Libell�, Nom Partie, Tour, Date Heure
      stFrmHTMLLdRTexte= '<td align="center">%s</td>';

      // v1.5.4 : balise incorrecte </br> supprim�e ci-dessous
      // v1.6.2 : ajout des l�gendes de records li�s au temps de calcul
      stFrmHTMLLdRPdP1= '</tbody></table>'#13'('#42') Valeur nulle exclue.'+'<H2>L�gende</H2>'#13+'<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+'<tr><th>Nature</th><th>Description</th>'#13+'<tr><td><I>D�tail du record</i></td><td align="center"><b>Valeur</b><br>(Infos&nbsp;compl�mentaires)<br><i>Nom&nbsp;de&nbsp;la&nbsp;partie&nbsp;:&nbsp;Tour</i><br>Date&nbsp;heure</td></tr>'#13+'<tr><td><b>Rang</b></td><td>Position des propositions du joueur dans le classement de toutes les solutions possibles selon l''ordre d�croissant de leur score.</td></tr>'#13;
      stFrmHTMLLdRPdP2= '<tr><td><b>Nombre de solutions (Nb sol.)</b></td><td>Nombre de solutions jouables distinctes (jetons pos�s diff�rents) lors d''un tour.</td></tr>'#13+'<tr><td><b>Top</b></td><td>Score maximal lors d''un tour ou somme des scores maximaux de chaque tour pour une partie.</td>'#13+'<tr><td><b>Rapport Score/Top</b></td><td>Rapport (en %% ou /20 selon l''option d''affichage des rapports) entre le score de la proposition et le top lors d''un tour.</td>'#13+'<tr><td><b>Niveau de difficult�</b></td><td>Evaluation du niveau de difficult� donn�e � partir du pourcentage de solutions atteignant au moins la moiti� du score du top&nbsp;:'#13;
      stFrmHTMLLdRPdP3= stHTMLDefNivDiff+
                        '<tr><td><B>Tps de calc. des sol.</B></td><td>Temps n�cessaire qu''il a fallu pour calculer toutes les solutions (exprim� en secondes).</td></tr>'#13+
                        '<tr><td><B>Nb sol. trouv�es / s.</B></td><td>Nombre moyen de solutions trouv�es en une seconde.</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';

      // v1.5.3 : d�fi n�1 : Mots de 15 lettres plac�s avec le moins de jetons possible
      stFrmHTMLD15lEnT= '<?xml version="1.0" encoding="iso-8859-1"?>'#13+
                        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'#13+
                        '<html><head><title>D�fi Word Killers n�1 : Former un mot de 15 lettres avec le moins de jetons possible</title><meta content="D�fi n�1 Word Killers" name="description"><meta content="D�fi n�1, Word Killers" name="keywords"></head>'#13+
                        '<body text="#fffff" vlink="#a0a0ff" link="#00ffff" bgcolor="#000000">'#13+
                        '<center><h1>D�fi Word Killers n�1&nbsp;:<br>Former un mot de 15 lettres avec le moins de jetons possible</h1></center>'#13+
                        'Voici la liste des d�fis relev�s. La liste est tri�e par ordre d�croissant de valeur des mots puis par ordre alphab�tique.<br>Vous trouverez la liste compl�te des mots <A HREF="./html/top15.txt">ici</A>.<br>'+' Le mot le plus difficile � placer jusqu''� ce jour appara�t en <b>gras</b>.<P>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><th colspan=3>D�fi</th><th colspan=6>Performance</th></tr>'#13+
                        '<tr><th>N�</th><th>Mot</th><th>Valeur</th><th>Jetons*</th><th>Coups*</th><th>Score</th><th>Cumul*</th><th>Date/Heure</th><th>Nom de partie</th></tr>'#13;

      stFrmHTMLD15lLgn= '<tr><td align="right">%s%d%s</td><td><TT>%s%s%s</TT></td><td align="right">%s%d%s</td><td align="right">%s%d%s</td><td align="right">%s%d%s</td>'+'<td align="right">%s%d%s</td><td align="right">%s%d%s</td><td align="center">%s%s%s</td><td><TT>%s%s%s</TT></td></tr>'#13;

      stFrmHTMLD15lPdp= '</tbody></table>'#13'('#42') Dernier coup du mot de 15 lettres <b>exclu</b>.'#13+
                        '<H2>L�gende</H2>'#13+
                        '<table cellspacing="1" cellpadding="2" border="1"><tbody>'#13+
                        '<tr><th>Nature</th><th>Description</th>'#13+
                        '<tr><td><b>Valeur</b></td><td>Cumul de la valeur des lettres du mot de quinze lettres, hors bonus et jokers</td></tr>'#13+
                        '<tr><td><b>Jetons</b></td><td>Nombre de jetons pos�s ne faisant pas partie du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Coups</b></td><td>Nombre de coups de pr�paration qu''il a fallu avant de pouvoir poser le mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Score</b></td><td>Score obtenu lors de la pose du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Cumul</b></td><td>Cumul des scores avant la pose du mot de quinze lettres</td></tr>'#13+
                        '<tr><td><b>Date/Heure</b></td><td>Date et heure auxquelles le d�fi a �t� relev�</td></tr>'#13+
                        '<tr><td><b>Nom de partie</b></td><td>Nom de la partie dans le cas o� elle a �t� enregistr�e</td></tr>'#13+
                        '</tbody></table>'#13'</body></html>';
//---------------------------------------------------------------------------
implementation
//---------------------------------------------------------------------------
end.

