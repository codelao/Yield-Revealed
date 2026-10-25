#define MyAppName "Yield Revealed"
#define MyAppVersion "0.9.5-beta"
#define MyAppPublisher "CodeLao"

[Setup]
AppId={{078D4BC2-DC91-408B-9CEF-CDF0D8427005}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={commonpf}\{#MyAppName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableWelcomePage=no
PrivilegesRequired=admin
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_x64_installer
SolidCompression=yes
WizardStyle=modern
LicenseFile=LICENSE.txt
WizardImageFile=qr.bmp

#include "custom.iss"