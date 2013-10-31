; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=My Program
AppVersion=1.5
DefaultDirName={pf}\My Program
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe
Compression=lzma2
SolidCompression=yes
OutputDir=c:\dev\lc_installer\out

[Files]
Source: "MyProg.exe"; DestDir: "{app}"
Source: "MyProg.chm"; DestDir: "{app}"
Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme
Source: "node-v0.10.21-x86.msi"; DestDir: "{tmp}"

[Icons]
Name: "{group}\My Program"; Filename: "{app}\MyProg.exe"

[Run]
Filename: "msiexec.exe"; Parameters: "/i ""{tmp}\node-v0.10.21-x86.msi"""