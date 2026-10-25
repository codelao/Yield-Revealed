[Languages]
Name: en; MessagesFile: "compiler:Default.isl"
Name: ru; MessagesFile: "compiler:Languages\Russian.isl"

[Messages]
en.BeveledLabel=English
ru.BeveledLabel=Русский

; welcome page
ru.SetupWindowTitle=Установка
ru.WelcomeLabel2=Примечание: Рекомендуется оставить ярлык для удобного запуска после установки.
en.SetupWindowTitle=Installation
en.WelcomeLabel2=Note: It is recommended to keep shortcut for convenient launching after the installation.

[Files]
Source: "setup.cmd"; DestDir: "{app}\setup"; Flags: ignoreversion
Source: "..\bin\YieldRevealed.cmd"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "..\messages.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\package.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\package-lock.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\requirements.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\server.js"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\src\*"; DestDir: "{app}\src"; Flags: ignoreversion
Source: "..\public\*"; DestDir: "{app}\public"; Flags: ignoreversion
Source: "..\models\*"; DestDir: "{app}\models"; Flags: ignoreversion

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\bin\YieldRevealed.cmd"; WorkingDir: "{app}";

[Run]
Filename: "{cmd}"; Parameters: "/c ""{app}\setup\setup.cmd"""; WorkingDir: "{app}"; StatusMsg: "Installing dependencies..."; Flags: waituntilterminated
