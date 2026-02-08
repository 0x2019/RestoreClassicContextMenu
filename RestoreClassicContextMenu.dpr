program RestoreClassicContextMenu;

uses
  Vcl.Forms,
  Winapi.Windows,
  uMain in 'uMain.pas' {frmMain},
  uExt in 'uExt.pas',
  uMain.UI in 'uMain.UI.pas',
  uMain.UI.TweaksR in 'uMain.UI.TweaksR.pas',
  uMain.UI.TweaksW in 'uMain.UI.TweaksW.pas',
  uMain.UI.Messages in 'uMain.UI.Messages.pas',
  uMain.UI.Strings in 'uMain.UI.Strings.pas';

var
  uMutex: THandle;

{$O+} {$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$R *.res}

begin
  if not IsWindowsVersionOrGreater(10, 0, 22000) then
  begin
    MessageBox(0, PChar(SWin11RequiredMsg), PChar(SWin11RequiredTitle), MB_ICONERROR or MB_OK);
    Halt(1);
  end;

begin
  uMutex := CreateMutex(nil, True, 'RCCM!');
  if (uMutex <> 0 ) and (GetLastError = 0) then begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  if uMutex <> 0 then
    CloseHandle(uMutex);
  end;
end;

end.
