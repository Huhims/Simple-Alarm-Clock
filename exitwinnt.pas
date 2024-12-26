UNIT ExitWinNT;
{$MODE OBJFPC}{$H+}

Interface
USES
{$IFDEF WINDOWS} Windows, {$ENDIF} SysUtils;

{$IFDEF WINDOWS}
CONST
LogOff   = EWX_LOGOFF   Or EWX_FORCEIFHUNG;
StandBy  = EWX_POWEROFF Or EWX_FORCEIFHUNG;
ReBoot   = EWX_REBOOT;   //Or EWX_FORCEIFHUNG;
ShutDown = EWX_SHUTDOWN; //Or EWX_FORCEIFHUNG;

ForceLogOff   = EWX_LOGOFF   Or EWX_FORCE;
ForceStandBy  = EWX_POWEROFF Or EWX_FORCE;
ForceReBoot   = EWX_REBOOT   Or EWX_FORCE;
ForceShutDown = EWX_SHUTDOWN Or EWX_FORCE;

Function ExitWin(lwParam: LongWord): Boolean;
{$ENDIF}
Implementation
{$IFDEF WINDOWS}
Function ExitWin(lwParam: LongWord): Boolean;
Var
hToken  : THandle;
TP,TPx  : TTokenPrivileges;
dwTPrev : DWORD;
dwTPReq : DWORD;
booToken: Boolean;
Const
ShutDownName = 'SeShutdownPrivilege';
Begin
Result:= False;
 if Win32Platform = VER_PLATFORM_WIN32_NT then
begin
booToken:= OpenProcessToken(GetCurrentProcess(),
TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY, hToken);

if booToken then
begin
booToken:= LookupPrivilegeValue
(nil, ShutDownName, TP.Privileges[0].LuID);

TP.PrivilegeCount:= 1;
TP.Privileges[0].Attributes:= SE_PRIVILEGE_ENABLED;
dwTPrev:= SizeOf(TPx);
dwTPReq:= 0;

if booToken then
begin
Windows.AdjustTokenPrivileges
(hToken, False, TP, dwTPrev, TPx, dwTPReq);

if ExitWindowsEx(lwParam, 0) then
begin
Result:= True;
CloseHandle(hToken);
end;
end;
end; // if booToken
end; // if WinPlatform
end;
{$ENDIF}
END.
