; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Ind�cix"
#define MyAppVersion "1.1.0.21"
#define MyAppPublisher "Patquoi.fr"
#define MyAppURL "http://patquoi.fr"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{80F0ECE6-1F09-43AC-BF1A-CF710FD31DA6}
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
LicenseFile="..\bin\licence.txt"
InfoBeforeFile="..\bin\lisezmoi.txt"
InfoAfterFile="..\bin\lisezmoi.txt"
WizardImageFile=grande.bmp
WizardSmallImageFile=petite.bmp
OutputDir=Output
OutputBaseFilename=insindecix
SetupIconFile=Indecix.ico
AppComments=Placez id�alement vos d�s !
AppContact=indecix@patquoi.fr
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
VersionInfoVersion={#MyAppVersion}
PrivilegesRequired=poweruser

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Icons]
Name: "{group}\Indecix"; Filename: "{app}\bin\Indecix.exe"; IconFilename: "{app}\bin\Indecix.exe"; Comment: "Placez id�alement vos d�s"; IconIndex: 0; Flags: createonlyiffileexists useapppaths
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Uninstall.ico"; Comment: "D�sinstalle Ind�cix"; IconIndex: 0
Name: "{group}\Aide d'Ind�cix"; Filename: "{app}\bin\html\index.html"; WorkingDir: "{app}\bin\html"; Comment: "Aide en ligne d'Ind�cix"
Name: "{group}\Lisez-Moi (Ind�cix)"; Filename: "{app}\lisezmoi.txt"; WorkingDir: "{app}"; Comment: "Fichier lisez-moi � lire en premier !"
Name: "{group}\Sources d'Ind�cix"; Filename: "{app}\Indecix-win64-src.zip"; Comment: "Code source d'Ind�cix"

[Run]
Filename: "{app}\lisezmoi.txt"; Description: "Lisez-moi !"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\bin\Indecix.exe"; Description: "Lancer l'application"; Flags: postinstall nowait skipifsilent

[Files]
Source: "Uninstall.ico"; DestDir: "{app}"
Source: "..\..\indecix-win64-src.zip"; DestDir: "{app}"
Source: "..\bin\indecix.64.exe"; DestDir: "{app}\bin"; DestName: "Indecix.exe"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "..\bin\indecix.32.exe"; DestDir: "{app}\bin"; DestName: "Indecix.exe"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion
Source: "..\bin\lisezmoi.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\html\index.html"; DestDir: "{app}\bin\html"; Flags: ignoreversion
Source: "..\bin\html\png\ddj.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ecran_1d6_a.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ecran_1d6_b.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_150.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_16.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_256.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_32.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_44.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\indecix_48.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ok.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\stop.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

