; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "WordKillers"
#define MyAppVersion "1.5"
#define MyAppPublisher "Patquoi.fr"
#define MyAppURL "http://patquoi.fr"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{8149B057-F8C7-4BF7-A763-B7AAE5104E0E}
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
UninstallDisplayName=WordKillers
LicenseFile=..\bin\licence.txt
InfoBeforeFile=..\bin\lisez-moi.txt
InfoAfterFile=..\bin\lisez-moi.txt
WizardImageFile=..\install\grande.bmp
WizardSmallImageFile=..\install\petite.bmp
OutputDir=C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\WordKillers\install\Output
OutputBaseFilename=inswordkillers
SetupIconFile=C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\WordKillers\src\WordKillers_Icon.ico
AppComments=Jeu en Mode Duplicate
AppContact=wordkillers@patquoi.fr
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
VersionInfoVersion={#MyAppVersion}
PrivilegesRequired=poweruser

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Icons]
Name: "{group}\WordKillers"; Filename: "{app}\WordKillers.exe"; IconFilename: "{app}\WordKillers.exe"; Comment: "Permet de jouer seul une partie Duplicate"; IconIndex: 0; Flags: createonlyiffileexists useapppaths
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Uninstall.ico"; Comment: "D�sinstalle WordKillers"; IconIndex: 0
Name: "{group}\Aide de WordKillers"; Filename: "{app}\html\index.html"; WorkingDir: "{app}\html"; Comment: "Aide en ligne de WordKillers"
Name: "{group}\Lisez-Moi (WordKillers)"; Filename: "{app}\lisez-moi.txt"; WorkingDir: "{app}"; Comment: "Fichier lisez-moi � lire en premier !"
Name: "{group}\Sources de WordKillers"; Filename: "{app}\WordKillers.zip"; Comment: "Code source de WordKillers"

[Registry]
Root: HKCR; SubKey: ".wkp"; ValueType: string; ValueData: "Word Killers";
Root: HKCR; SubKey: "WordKillers"; ValueType: string; ValueData: "Partie de Word Killers";
Root: HKCR; SubKey: "WordKillers\DefaultIcon"; ValueType: string; ValueData: "{app}\WordKillers.exe,0";
Root: HKCR; SubKey: "WordKillers\shell\open\command"; ValueType: string; ValueData: "{app}\WordKillers.exe ""%1""";

[Run]
Filename: "{app}\lisez-moi.txt"; Description: "Lisez-moi !"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\WordKillers.exe"; Description: "Lancer l'application"; Flags: postinstall nowait skipifsilent

[Files]
Source: "Uninstall.ico"; DestDir: "{app}"
Source: "..\..\WordKillers.zip"; DestDir: "{app}"
Source: "..\bin\delta8.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\WordKillers.64.exe"; DestDir: "{app}"; DestName: "WordKillers.exe"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "..\bin\WordKillers.32.exe"; DestDir: "{app}"; DestName: "WordKillers.exe"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion
Source: "..\bin\L23456789ABCDEF"; DestDir: "{app}"; Flags: solidbreak ignoreversion
Source: "..\bin\licence.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\lisez-moi.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\R23456789ABCDEF"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\html\0.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\0.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\1.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\-1.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\1.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\-1.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\10.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\10.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\2.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\2.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\3.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\3.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\4.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\4.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\5.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\5.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\6.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\6.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\7.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\7.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\8.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\8.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\9.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\9.png"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\actions.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\altf4.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\astuce.bmp"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\chevalet.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\choixsrcdef.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\contigus.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\defi1m15l_f.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\defi1m15l_h.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\definition.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\deplacer.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\exemple1A.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\exemple1B.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\exemple1C.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\exemple2.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\fdm.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\fdm.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\fdmd.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\fdmdpartiejoker.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\fdmpartiejoker.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\findepartie.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\graphe.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\hypophosphoreux.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\hypothequassiez.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\index.html"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\infosinternes.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\joker.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\listemots.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\listermotsalettrescheres.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\materiel.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\materiel2.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\menuinfos.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\menutestplacement.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\motsinvalides.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\nivdiffmoyen.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\note.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\options.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\partiejoker.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\partiesjouees.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\permuter.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\placement.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\placementincorrect.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\premiertour.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\prmsrcdef.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\propose1.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\propose2.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\propose3.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\propositiontirage.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\qualitepose.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\rechercher.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\records_f.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\records_h.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\resultatrecherche.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\resultattestplacement.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\schizothymiques.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\score.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\selection.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\situationjetons.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\solutionretenue.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\solutionretenue2.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\solutions.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\solutionunique.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\statistiques.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\temps.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\tempsecoule.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\top15.txt"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\trace.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\typespartie.gif"; DestDir: "{app}\html"; Flags: ignoreversion
Source: "..\bin\html\zootechnicienne.jpg"; DestDir: "{app}\html"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


