[Icons]
Name: {group}\Le Compte Pour De Bon; Filename: {app}\bin\lcpdb.exe; WorkingDir: {commondesktop}; IconFilename: {app}\bin\lcpdb.exe; Comment: Atelier du c�l�bre jeu t�l�vis�; IconIndex: 0; Components: ; Languages: 
Name: {group}\Aide; Filename: {app}\bin\html\index.html; WorkingDir: {app}\bin\html; Components: ; Languages: ; Comment: "Fichier d'aide HTML "
Name: {group}\Lisez-moi !; Filename: {app}\lisezmoi.txt; Comment: Fichier � lire en premier !
Name: {group}\Statistiques; Filename: {app}\bin\Statistiques.html; Comment: Statistiques cumul�es
Name: {group}\D�sinstallation; Filename: {app}\unins000.exe; WorkingDir: {app}; IconFilename: {app}\lcpdbX.ico; Comment: D�sinstalle le Compte Pour De Bon
[Setup]
AppCopyright=2005, Patrice Fouquet
AppName=Le Compte Pour De Bon
AppVerName=Le Compte Pour De Bon 1.2.6
LicenseFile=C:\Borland\Delphi2005\lcpdb\licence.txt
DefaultDirName={pf}\Ihsv\Le Compte Pour De Bon
ShowLanguageDialog=no
LanguageDetectionMethod=locale
WindowVisible=true
BackColor=clMaroon
DefaultGroupName=Ihsv\Le Compte Pour De Bon
AppPublisher=Patrice Fouquet
AppPublisherURL=http://patquoi.free.fr
AppSupportURL=http://patquoi.free.fr
AppUpdatesURL=http://patquoi.free.fr
AppComments=Licence Publique G�n�rale 2.0
AppContact=patquoi@free.fr
OutputDir=C:\Borland\Delphi2005\lcpdb\ins
OutputBaseFilename=inslcpdb
InfoAfterFile=C:\Borland\Delphi2005\lcpdb\lisezmoi.txt
InfoBeforeFile=C:\Borland\Delphi2005\lcpdb\lisezmoi.txt
SourceDir=C:\Borland\Delphi2005\lcpdb
VersionInfoVersion=1.2.6
VersionInfoCompany=Patrice Fouquet
VersionInfoDescription=Le Compte Pour De Bon
VersionInfoCopyright=2005, Patrice Fouquet
UninstallDisplayIcon={app}\lcpdbX.ico
DisableStartupPrompt=false
WizardImageFile=C:\Borland\Delphi2005\lcpdb\ins\gauche.bmp
WizardImageStretch=false
WizardSmallImageFile=C:\Borland\Delphi2005\lcpdb\ins\coin.bmp
SetupIconFile=C:\Borland\Delphi2005\lcpdb\src\lcpdb2.ico
ChangesAssociations=true
[Languages]
Name: Francais; MessagesFile: compiler:Languages\French.isl; LicenseFile: C:\Borland\Delphi2005\lcpdb\licence.txt
[Dirs]
Name: {app}\bin; Flags: uninsalwaysuninstall
Name: {app}\bin\html; Flags: uninsalwaysuninstall
Name: {app}\src; Flags: uninsalwaysuninstall
Name: {app}\dcu; Flags: uninsalwaysuninstall
[Files]
Source: lisezmoi.txt; DestDir: {app}; Components: 
Source: license.txt; DestDir: {app}; Languages: 
Source: licence.txt; DestDir: {app}
Source: src.zip; DestDir: {app}
Source: src\lcpdbX.ico; DestDir: {app}
Source: bin\license.txt; DestDir: {app}\bin
Source: bin\lcpdb.exe; DestDir: {app}\bin
Source: bin\licence.txt; DestDir: {app}\bin
Source: bin\html\Statistiques.html; DestDir: {app}\bin
Source: bin\html\icones.jpg; DestDir: {app}\bin\html
Source: bin\html\index.html; DestDir: {app}\bin\html
Source: bin\html\aspectavecicones.jpg; DestDir: {app}\bin\html
Source: bin\html\aspectaveclibelles.jpg; DestDir: {app}\bin\html
Source: bin\html\parametresboutonsmenus.jpg; DestDir: {app}\bin\html
Source: bin\html\parametres5.jpg; DestDir: {app}\bin\html
Source: bin\html\parametres1.jpg; DestDir: {app}\bin\html
Source: bin\html\arbresolutions.jpg; DestDir: {app}\bin\html
Source: bin\html\arbre.jpg; DestDir: {app}\bin\html
Source: bin\html\solutionmontree.jpg; DestDir: {app}\bin\html
Source: bin\html\recherche.jpg; DestDir: {app}\bin\html
Source: bin\html\Statistiques.html; DestDir: {app}\bin\html
Source: bin\html\lignedecommande.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonsolutionplussimple.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonsolutionpluscomplexe.jpg; DestDir: {app}\bin\html
Source: bin\html\lancement.jpg; DestDir: {app}\bin\html
Source: bin\html\licence.txt; DestDir: {app}\bin\html
Source: bin\html\license.txt; DestDir: {app}\bin\html
Source: bin\html\boutonstats.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonsolutionlaplussimple.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonsolutionlapluscomplexe.jpg; DestDir: {app}\bin\html
Source: bin\html\menuarbre.jpg; DestDir: {app}\bin\html
Source: bin\html\parametres3.jpg; DestDir: {app}\bin\html
Source: bin\html\parametres4.jpg; DestDir: {app}\bin\html
Source: bin\html\parametres2.jpg; DestDir: {app}\bin\html
Source: bin\html\boutontableau.jpg; DestDir: {app}\bin\html
Source: bin\html\boutoneffacer.jpg; DestDir: {app}\bin\html
Source: bin\html\listesolutions.jpg; DestDir: {app}\bin\html
Source: bin\html\boutoncalculer.jpg; DestDir: {app}\bin\html
Source: bin\html\resultatexact.jpg; DestDir: {app}\bin\html
Source: bin\html\resultatfaux.jpg; DestDir: {app}\bin\html
Source: bin\html\erreur2.jpg; DestDir: {app}\bin\html
Source: bin\html\erreur1.jpg; DestDir: {app}\bin\html
Source: bin\html\2.jpg; DestDir: {app}\bin\html
Source: bin\html\3.jpg; DestDir: {app}\bin\html
Source: bin\html\divise.jpg; DestDir: {app}\bin\html
Source: bin\html\multiplie.jpg; DestDir: {app}\bin\html
Source: bin\html\entree.jpg; DestDir: {app}\bin\html
Source: bin\html\moins.jpg; DestDir: {app}\bin\html
Source: bin\html\plus.jpg; DestDir: {app}\bin\html
Source: bin\html\0.jpg; DestDir: {app}\bin\html
Source: bin\html\1.jpg; DestDir: {app}\bin\html
Source: bin\html\4.jpg; DestDir: {app}\bin\html
Source: bin\html\5.jpg; DestDir: {app}\bin\html
Source: bin\html\6.jpg; DestDir: {app}\bin\html
Source: bin\html\7.jpg; DestDir: {app}\bin\html
Source: bin\html\9.jpg; DestDir: {app}\bin\html
Source: bin\html\8.jpg; DestDir: {app}\bin\html
Source: bin\html\pave.jpg; DestDir: {app}\bin\html
Source: bin\html\saisiecalcul.jpg; DestDir: {app}\bin\html
Source: bin\html\tableausaisie.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonsuc.jpg; DestDir: {app}\bin\html
Source: bin\html\paveproposition.jpg; DestDir: {app}\bin\html
Source: bin\html\boutonpuc.jpg; DestDir: {app}\bin\html
Source: bin\html\plaquescompteremplis.jpg; DestDir: {app}\bin\html
Source: bin\html\plaquescomptevides.jpg; DestDir: {app}\bin\html
Source: bin\html\boutontas.jpg; DestDir: {app}\bin\html
Source: bin\html\1-75-25-100-6-4--551-simple.jpg; DestDir: {app}\bin\html
Source: bin\html\1-75-25-100-6-4--551-complexe.jpg; DestDir: {app}\bin\html
[Run]
Filename: {app}\bin\lcpdb.exe; Description: Lancer Le Compte Pour De Bon; StatusMsg: Lancer Le Compte Pour De Bon; Flags: waituntilidle postinstall
