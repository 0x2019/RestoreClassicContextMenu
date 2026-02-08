unit uMain.UI.TweaksW;

interface

uses
  Winapi.Windows, System.SysUtils, Registry;

function RemoveShowMoreOptionsW(Enable: Boolean): Boolean;

implementation

function RemoveShowMoreOptionsW(Enable: Boolean): Boolean;
const
  ROOT = HKEY_CURRENT_USER;
  GUID = '{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}';
  PATH = 'Software\Classes\CLSID\' + GUID + '\InprocServer32';
var
  xReg: TRegistry;
begin
  Result := Enable;

  xReg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    xReg.RootKey := ROOT;

    if Enable then
    begin
      if xReg.OpenKey(PATH, True) then
      try
        try
          xReg.WriteString('', '');
        except
          on E: Exception do
            OutputDebugString(PChar('WriteString failed at ' + PATH + '\(Default): ' + E.Message));
        end;
      finally
        xReg.CloseKey;
      end;
    end
    else
    begin
      try
        if not xReg.DeleteKey('Software\Classes\CLSID\' + GUID) then
        begin
          xReg.DeleteKey(PATH);
          xReg.DeleteKey('Software\Classes\CLSID\' + GUID);
        end;
      except
        on E: Exception do
          OutputDebugString(PChar('DeleteKey failed at Software\Classes\CLSID\' + GUID + ': ' + E.Message));
      end;

      Result := False;
    end;
  finally
    xReg.Free;
  end;
end;

end.
