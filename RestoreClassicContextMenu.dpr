program RestoreClassicContextMenu;

uses
  Vcl.Forms,
  Winapi.Windows,
  uMain in 'uMain.pas' {frmMain},
  uTweaksR in 'uTweaksR.pas',
  uTweaksW in 'uTweaksW.pas',
  uAppStrings in 'uAppStrings.pas',
  uExplorer in 'Common\uExplorer.pas',
  uForms in 'Common\uForms.pas',
  uMessageBox in 'Common\uMessageBox.pas',
  uOSUtils in 'Common\uOSUtils.pas',
  uAppController in 'uAppController.pas';

var
  uMutex: THandle;

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
