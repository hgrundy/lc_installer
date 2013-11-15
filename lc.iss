; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "LogicalCat"
#define MyAppVersion "3.0"
#define MyAppPublisher "LogicalCat LLC"
#define MyAppURL "http://www.logicalcat.com/"
#define MyAppExeName "winstart-browser.bat"
#define MyAppIcon "square_logo.ico"

#define NSSM "nssm64.exe"
#define JAVA "jre-7u45-windows-x64.exe"
#define NODE "node-v0.10.21-x64.msi"
#define GM "GraphicsMagick-1.3.18-Q16-win64-dll.exe"
#define USERPROFILE "C:\Users\r-b-h"

#define PET3DLL "pet3odbc.dll"
#define PET4DLL "pet4odbc.dll"  

#define DEVINST "c:\dev\lc_installer"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2752ABBC-503D-4F3E-AC37-95EF35E343E3}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=c:\logicalcat
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=C:\dev\lc_installer\out
OutputBaseFilename=setup
SetupIconFile="C:\dev\lc_installer\lib\square_logo.ico"
;Password=kitty
Compression=lzma
SolidCompression=yes
ChangesEnvironment=yes
LicenseFile=C:\dev\lc_installer\lib\license.rtf
InfoAfterFile=c:\dev\lc_installer\lib\post_install.rtf
ArchitecturesInstallIn64BitMode=x64



[Code]
function JREExists(): Boolean;
begin
  Result := FileExists(ExpandConstant('{pf64}\Java\jre7\bin\java.exe'));
end;


[Types]
Name: "full";   Description: "Full: Browser App and all LogicalCat Crawlers"
Name: "demo";   Description: "Demo: Browser App and Business Documents"
Name: "custom"; Description: "Custom: Select Individual Crawlers";           Flags: iscustom


[Components]
Name: "base";   Description: "LogicalCat Browser Application: For search and reporting. ";         Types: full demo custom; Flags: fixed
Name: "dox";    Description: "Common Business Documents: MS Office, PDF, txt/csv, etc.";           Types: full demo       
Name: "epf";    Description: "Common E&P Files: SHP, LAS, SGY and Raster Logs (.tif)";             Types: full        
Name: "pet";    Description: "IHS Petra: Wells, Logs, Tops, Project stats, etc.";                  Types: full
Name: "tks";    Description: "IHS Kingdom Suite:  Wells, Logs, Tops, Project stats, etc.";         Types: full
Name: "ggx";    Description: "LMKR GeoGraphix Discovery:  Wells, Logs, Tops, Project stats, etc."; Types: full          


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"


[Files]
Source: "{#DEVINST}\lib\node-v0.10.21-x64.msi";                   DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\jre-7u45-windows-x64.exe";                DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\rm_java.bat";                             DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\set_java_home.bat";                       DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\winstart-browser.bat";                    DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\winstart-server.bat";                     DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\nssm64.exe";                              DestDir: "{app}";                Flags: ignoreversion
Source: "{#DEVINST}\lib\GraphicsMagick-1.3.18-Q16-win64-dll.exe"; DestDir: "{app}\resources";      Flags: ignoreversion
Source: "{#DEVINST}\lib\square_logo.ico";                         DestDir: "{app}\resources";      Flags: ignoreversion
;Source: "{#DEVINST}\lib\pet3odbc.dll";                            DestDir: "{app}\resources";      Flags: ignoreversion; Components: pet
;Source: "{#DEVINST}\lib\pet4odbc.dll";                            DestDir: "{app}\resources";      Flags: ignoreversion; Components: pet
Source: "{#DEVINST}\lib\elasticsearch-0.90.x\*";                  DestDir: "{app}\elasticsearch";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\dev\lc_browser_app\*"; DestDir: "{app}\lc_browser_app"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: ".git,node_modules\lc_???_crawlers"

Source: "c:\dev\lc_browser_app\node_modules\lc_dox_crawlers\*"; DestDir: "{app}\lc_browser_app\node_modules\lc_dox_crawlers";  Flags: ignoreversion recursesubdirs createallsubdirs; Components: dox
Source: "c:\dev\lc_browser_app\node_modules\lc_epf_crawlers\*"; DestDir: "{app}\lc_browser_app\node_modules\lc_epf_crawlers";  Flags: ignoreversion recursesubdirs createallsubdirs; Components: epf
Source: "c:\dev\lc_browser_app\node_modules\lc_pet_crawlers\*"; DestDir: "{app}\lc_browser_app\node_modules\lc_pet_crawlers";  Flags: ignoreversion recursesubdirs createallsubdirs; Components: pet
Source: "c:\dev\lc_browser_app\node_modules\lc_ggx_crawlers\*"; DestDir: "{app}\lc_browser_app\node_modules\lc_ggx_crawlers";  Flags: ignoreversion recursesubdirs createallsubdirs; Components: ggx
;Source: "{#DEV}\lc_browser_app\node_modules\lc_tks_crawlers\*"; DestDir: "{app}\lc_browser_app\node_modules\lc_tks_crawlers";  Flags: ignoreversion recursesubdirs createallsubdirs; Components: tks


[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\resources\{#MyAppIcon}"

[Registry]
; set JAVA_HOME
; Setting JAVA_HOME var here works but is apparently not readable by elasticsearch later on--despite invoking as current (admin) user.
; As a workaround, I hard coded the path in elasticsearch\bin\service.bat to look for c:\program files\java\jre7
Root: HKLM64; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueName: "JAVA_HOME"; ValueType: String; ValueData: "{pf64}\java\jre7";

Root: HKLM64; Subkey: "SOFTWARE\Wow6432Node\ODBC\ODBCINST.INI\lc_petra_3_odbc"

[Run]

; Install Node
Filename: "{sys}\msiexec.exe"; Parameters: "/qb INSTALLDIR=c:\logicalcat\nodejs /i ""{app}\resources\{#NODE}"""; StatusMsg: "Installing Node.js..."


; Install Java (use default location)
Filename: "{app}\resources\{#JAVA}"; Parameters: " /s "; StatusMsg: "Installing JRE7..."; Check: Not JREExists()


; Add Firewall Rules
Filename: "{sys}\netsh.exe";   Parameters: "advfirewall firewall add rule name=""Node In""  program=""{app}\nodejs\node.exe"" dir=in  action=allow enable=yes"; Flags: runhidden; StatusMsg: "Installing Firewall Rules..."
Filename: "{sys}\netsh.exe";   Parameters: "advfirewall firewall add rule name=""Node Out"" program=""{app}\nodejs\node.exe"" dir=out action=allow enable=yes"; Flags: runhidden; StatusMsg: "Installing Firewall Rules..."


; Configure ElasticSearch service (and set start type to auto)
Filename: "{app}\elasticsearch\bin\service.bat"; Parameters: "install"; Flags: waituntilterminated runhidden; StatusMsg: "Installing ElasticSearch Service..."
Filename: "{app}\elasticsearch\bin\service.bat"; Parameters: "start";   Flags: waituntilterminated runhidden; StatusMsg: "Starting ElasticSearch Service..."
Filename: "{sys}\sc.exe"; Parameters: " config elasticsearch-service-x64 start= auto"; Flags: waituntilterminated runhidden; StatusMsg: "Set ElasticSearch Service to Automatic..."


; Add LogicalCat as Service
Filename: "{app}\{#NSSM}";     Parameters: "install {#MyAppName} ""{app}\nodejs\node.exe"" ""{app}\lc_browser_app\app.js"" ""8008"""; Flags: waituntilterminated runhidden; StatusMsg: "Installing LogicalCat Service..."
Filename: "{sys}\net.exe";     Parameters: "start {#MyAppName}"; Flags: waituntilterminated runhidden; StatusMsg: "Starting LogicalCat Service..."


; Pause to allow ElasticSearch time to wake up
Filename: "{sys}\ping.exe"; Parameters: "-n 10 localhost"; Flags: waituntilterminated runhidden; StatusMsg: "Wait a moment for ElasticSearch to initialize..."


[Run]
; Initialize app and crawler indexes
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\cli init";                                  Flags: waituntilterminated runhidden;                  StatusMsg: "Creating loc index..."
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\cli init_app";                              Flags: waituntilterminated runhidden;
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_dox_crawlers\cli init";     Flags: waituntilterminated runhidden; Components: dox; StatusMsg: "Creating dox index..."
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_dox_crawlers\cli init_app"; Flags: waituntilterminated runhidden; Components: dox;
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_epf_crawlers\cli init";     Flags: waituntilterminated runhidden; Components: epf; StatusMsg: "Creating epf index..."
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_epf_crawlers\cli init_app"; Flags: waituntilterminated runhidden; Components: epf;
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_ggx_crawlers\cli init";     Flags: waituntilterminated runhidden; Components: ggx; StatusMsg: "Creating ggx index..."
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_ggx_crawlers\cli init_app"; Flags: waituntilterminated runhidden; Components: ggx;
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_pet_crawlers\cli init";     Flags: waituntilterminated runhidden; Components: pet; StatusMsg: "Creating pet index..."
Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_pet_crawlers\cli init_app"; Flags: waituntilterminated runhidden; Components: pet;
;Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_tks_crawlers\cli init"; Flags: waituntilterminated runhidden; Components: tks; StatusMsg: "Creating tks index..."
;Filename: "{app}\nodejs\node.exe"; Parameters: "{app}\lc_browser_app\node_modules\lc_tks_crawlers\cli init"; Flags: waituntilterminated runhidden; Components: tks;

Filename: "{app}\resources\{#GM}"; Parameters: " /VERYSILENT /NOICONS /DIR=""{app}\graphics_magick"" ";           Flags: waituntilterminated runhidden; Components: epf; StatusMsg: "Installing GraphicsMagick..."

; Ask user to modify LogicalCat Service
Filename: {sys}\services.msc; WorkingDir: {sys}; Flags: shellexec postinstall; Description: Open Services Control Panel to edit Log On account

; Launch default browser to app page
Filename: "http://localhost:8008"; Flags: shellexec runasoriginaluser

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[UninstallRun]
; Remove System Service
Filename: "{sys}\net.exe"; Parameters: "stop {#MyAppName}"; Flags: runhidden;
Filename: "{app}\{#NSSM}"; Parameters: "remove {#MyAppName} confirm"; Flags: runhidden;
Filename: "{sys}\net.exe"; Parameters: "stop {#MyAppName}"; Flags: runhidden;


; Remove Firewall Rules
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Node In"" program=""{app}\nodejs\node.exe""";  Flags: runhidden;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Node Out"" program=""{app}\nodejs\node.exe"""; Flags: runhidden;


; Stop and Uninstall ElasticSearch Service
Filename: "{app}\elasticsearch\bin\service.bat"; Parameters: "stop";   Flags: waituntilterminated runhidden
Filename: "{app}\elasticsearch\bin\service.bat"; Parameters: "remove"; Flags: waituntilterminated runhidden


; Uninstall GraphicsMagick
Filename: "{app}\graphics_magick\unins000.exe"; Parameters: "/VERYSILENT ";


; Uninstall Node
Filename: "{sys}\msiexec.exe"; Parameters: "/passive /x ""{app}\resources\{#NODE}""";


; Uninstall Java (could not use msiexec x{program id} ~ weird bracket escape in this horrible editor?)
; nah...just leave it
;Filename: "{app}\rm_java.bat"; Flags: runhidden;


; Remove all leftovers
Filename: "{sys}\rmdir"; Parameters: "-r ""{app}""";


