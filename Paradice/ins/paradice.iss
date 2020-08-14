; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Paradice"
#define MyAppVersion "1.1.5.6"
#define MyAppPublisher "Patquoi.fr"
#define MyAppURL "http://patquoi.fr"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CFB2B46D-C9E8-429A-837B-BA13E6BBF5BA}
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
OutputBaseFilename=insparadice
SetupIconFile=Paradice.ico
AppComments=Achetez des �v�nements de d�s !
AppContact=paradice@patquoi.fr
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
VersionInfoVersion={#MyAppVersion}
PrivilegesRequired=poweruser

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Icons]
Name: "{group}\Paradice"; Filename: "{app}\bin\Paradice.exe"; IconFilename: "{app}\bin\Paradice.exe"; Comment: "Achetez des �v�nements de d�s"; IconIndex: 0; Flags: createonlyiffileexists useapppaths
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\Uninstall.ico"; Comment: "D�sinstalle Paradice"; IconIndex: 0
Name: "{group}\Aide de Paradice"; Filename: "{app}\bin\html\index.html"; WorkingDir: "{app}\bin\html"; Comment: "Aide en ligne de Paradice"
Name: "{group}\Lisez-Moi (Paradice)"; Filename: "{app}\lisezmoi.txt"; WorkingDir: "{app}"; Comment: "Fichier lisez-moi � lire en premier !"
Name: "{group}\Sources de Paradice"; Filename: "{app}\paradice-win64-src.zip"; Comment: "Code source de Paradice"

[Registry]
Root: HKCR; SubKey: ".prdc"; ValueType: string; ValueData: "Paradice";
Root: HKCR; SubKey: "Paradice"; ValueType: string; ValueData: "Partie de Paradice";
Root: HKCR; SubKey: "Paradice\DefaultIcon"; ValueType: string; ValueData: "{app}\bin\Paradice.exe,0";
Root: HKCR; SubKey: "Paradice\shell\open\command"; ValueType: string; ValueData: "{app}\bin\Paradice.exe ""%1""";

[Run]
Filename: "{app}\lisezmoi.txt"; Description: "Lisez-moi !"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\bin\Paradice.exe"; Description: "Lancer l'application"; Flags: postinstall nowait skipifsilent

[Files]
Source: "Uninstall.ico"; DestDir: "{app}"
Source: "..\..\paradice-win64-src.zip"; DestDir: "{app}"
Source: "..\bin\paradice.64.exe"; DestDir: "{app}\bin"; DestName: "Paradice.exe"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "..\bin\paradice.32.exe"; DestDir: "{app}\bin"; DestName: "Paradice.exe"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion
Source: "..\bin\lisezmoi.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bin\html\index.html"; DestDir: "{app}\bin\html"; Flags: ignoreversion
Source: "..\bin\html\png\bdt.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\br.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\cd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\cdd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d1.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d2.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d3.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d4.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d5.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\d6.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\e.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\e0.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\e1.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\e2.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\e3.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\edd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ee.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\en.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\eo.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\es.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\fp.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\gde.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\j.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\mo.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\mp.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\mpep.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\mpo.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\mv.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ni.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\np.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\nvp.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\odj.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\p.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\p12.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\p4.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\p6.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pb.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pc.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj1.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj2.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj3.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj4.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj5.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pj6.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\plt.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pm.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\po.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pr.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\prdc.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pslcd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\pv.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\r.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\r2.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\r3.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\rdd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s5.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s6.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s7.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s8.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\s9.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\smp.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\smrdj.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\spedd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\spjc.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\spjd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\sptdd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\t.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\ta.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\tandp.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\th.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zdedd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zdi.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zdj.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zdldd.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zdm.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
Source: "..\bin\html\png\zds.png"; DestDir: "{app}\bin\html\png"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

