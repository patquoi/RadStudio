; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Le Compte Pour De Bon"
#define MyAppVersion "1.3.0.17"
#define MyAppPublisher "Patquoi.fr"
#define MyAppURL "http://patquoi.fr"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A7DAD056-862E-42CB-A78C-C08C1612C7CD}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppPublisher}\{#MyAppName}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
UninstallDisplayIcon={app}\Uninstall.ico
UninstallDisplayName={#MyAppName}
LicenseFile=..\bin\licence.txt
InfoBeforeFile=..\bin\lisezmoi.txt
InfoAfterFile=..\bin\lisezmoi.txt
WizardImageFile=..\ins\grande.bmp
WizardSmallImageFile=..\ins\petite.bmp
OutputDir=C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\lcpdb\ins\Output
OutputBaseFilename=inslcpdb
SetupIconFile=C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\lcpdb\src\lcpdb_Icon.ico
AppComments=Trouvez le bon compte !
AppContact=lcpdb@patquoi.fr
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
VersionInfoVersion={#MyAppVersion}
PrivilegesRequired=poweruser

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Icons]
Name: "{group}\lcpdb"; Filename: "{app}\lcpdb.exe"; IconFilename: "{app}\lcpdb.exe"; Comment: "Trouvez le bon compte !"; IconIndex: 0; Flags: createonlyiffileexists useapppaths
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Uninstall.ico"; Comment: "D�sinstalle Le Compte Pour De Bon"; IconIndex: 0
Name: "{group}\Aide du Compte Pour De Bon"; Filename: "{app}\html\index.html"; WorkingDir: "{app}\html"; Comment: "Aide en ligne du Compte Pour De Bon"
Name: "{group}\Lisez-Moi (Le Compte Pour De Bon)"; Filename: "{app}\lisez-moi.txt"; WorkingDir: "{app}"; Comment: "Fichier lisez-moi � lire en premier !"
Name: "{group}\Sources du Compte Pour De Bon"; Filename: "{app}\lcpdbsrc.zip"; Comment: "Code source du Compte Pour De Bon"

[Run]
Filename: "{app}\impcfgcpt.exe"; Parameters: """{app}"""; Description: "Importer une configuration d�j� existante"; Flags: postinstall skipifsilent
Filename: "{app}\lisezmoi.txt"; Description: "Lisez-moi !"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\lcpdb.exe"; Description: "Lancer l'application"; Flags: postinstall nowait skipifsilent

[Files]
Source: "Uninstall.ico"; DestDir: "{app}"
Source: "..\..\lcpdbsrc.zip"; DestDir: {app}

Source: "..\bin\licence.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\lisezmoi.txt"; DestDir: "{app}"; Flags: ignoreversion

Source: "..\bin\lcpdb.64.exe"; DestDir: "{app}"; DestName: "lcpdb.exe"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "..\bin\lcpdb.32.exe"; DestDir: "{app}"; DestName: "lcpdb.exe"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion

Source: "..\impcfgcpt\bin\impcfgcpt.exe"; DestDir: "{app}"; Flags: ignoreversion

Source: "..\bin\html\Statistiques.html"; DestDir: {app}\bin; Flags: ignoreversion
Source: "..\bin\html\icones.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\index.html"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\aspectavecicones.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\aspectaveclibelles.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametresboutonsmenus.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametres5.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametres1.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\arbresolutions.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\arbre.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\solutionmontree.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\recherche.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\Statistiques.html"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\lignedecommande.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonsolutionplussimple.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonsolutionpluscomplexe.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\lancement.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\licence.txt"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\license.txt"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonstats.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonsolutionlaplussimple.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonsolutionlapluscomplexe.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\menuarbre.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametres3.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametres4.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\parametres2.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutontableau.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutoneffacer.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\listesolutions.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutoncalculer.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\resultatexact.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\resultatfaux.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\erreur2.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\erreur1.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\2.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\3.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\divise.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\multiplie.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\entree.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\moins.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\plus.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\0.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\1.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\4.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\5.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\6.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\7.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\9.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\8.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\pave.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\saisiecalcul.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\tableausaisie.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonsuc.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\paveproposition.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutonpuc.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\plaquescompteremplis.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\plaquescomptevides.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\boutontas.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\1-75-25-100-6-4--551-simple.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion
Source: "..\bin\html\1-75-25-100-6-4--551-complexe.jpg"; DestDir: {app}\bin\html; Flags: ignoreversion