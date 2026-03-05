unit uAppController;

interface

uses
  Winapi.Windows, System.SysUtils, ShellAPI, uMain;

procedure AppController_LoadTweaks(AForm: TfrmMain);
procedure AppController_RestartExplorer(AForm: TfrmMain);
procedure AppController_RestartExplorerTimer(AForm: TfrmMain);

procedure AppController_About(AForm: TfrmMain);
procedure AppController_Exit(AForm: TfrmMain);
procedure AppController_ToggleShowMoreOptions(AForm: TfrmMain);

implementation

uses
  uExplorer, uMessageBox, uOSUtils,
  uAppStrings, uTweaksR, uTweaksW;

procedure AppController_LoadTweaks(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  AForm.chkRSMO.Checked := RemoveShowMoreOptionsR;
end;

procedure AppController_RestartExplorer(AForm: TfrmMain);
begin
  if AForm = nil then Exit;

  if UI_ConfirmYesNo(AForm, SRestartExplorerMsg) then
  begin
    AForm.btnRestartExplorer.Enabled := False;
    IsRestartingExplorer := True;

    ShellExecute(0, 'open', 'taskkill', '/f /im explorer.exe', nil, SW_HIDE);

    AForm.tmrRestartExplorer.Interval := 1000;
    AForm.tmrRestartExplorer.Enabled := True;
  end;
end;

procedure AppController_RestartExplorerTimer(AForm: TfrmMain);
var
  R: NativeInt;
begin
  if AForm = nil then Exit;

  if IsExplorerUILoaded then
  begin
    AForm.tmrRestartExplorer.Enabled := False;
    AForm.btnRestartExplorer.Enabled := True;
    IsRestartingExplorer := False;
    Exit;
  end;

  if not IsExplorerRunning then
  begin
    R := NativeInt(ShellExecute(AForm.Handle, 'open', 'explorer.exe', nil, nil, SW_SHOWNORMAL)); // 🚀 단일 캐스팅

    if R <= 32 then
      UI_MessageBox(AForm, Format(SRestartExplorerFailMsg, [R]), MB_ICONWARNING or MB_OK);
  end;
end;

procedure AppController_About(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  UI_MessageBox(AForm, Format(SAboutMsg, [APP_NAME, APP_VERSION, APP_RELEASE, APP_URL]), MB_ICONQUESTION or MB_OK);
end;

procedure AppController_Exit(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  AForm.Close;
end;

procedure AppController_ToggleShowMoreOptions(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  RemoveShowMoreOptionsW(AForm.chkRSMO.Checked);
end;

end.
