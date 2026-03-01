unit uOSUtils;

interface

uses
  Winapi.Windows, System.SysUtils;

function RtlGetVersion(var RTL_OSVERSIONINFOEXW): LONG; stdcall; external 'ntdll.dll' Name 'RtlGetVersion';
function IsWindowsVersionOrGreater(Major, Minor, Build: DWORD): Boolean;

implementation

function IsWindowsVersionOrGreater(Major, Minor, Build: DWORD): Boolean;
var
  winver: RTL_OSVERSIONINFOEXW;
begin
  FillChar(winver, SizeOf(winver), 0);
  winver.dwOSVersionInfoSize := SizeOf(winver);
  Result := False;
  if RtlGetVersion(winver) = 0 then
  begin
    if winver.dwMajorVersion > Major then
      Exit(True);
    if winver.dwMajorVersion = Major then
    begin
      if winver.dwMinorVersion > Minor then
        Exit(True);
      if winver.dwMinorVersion = Minor then
        Exit(winver.dwBuildNumber >= Build);
    end;
  end;
end;

end.
