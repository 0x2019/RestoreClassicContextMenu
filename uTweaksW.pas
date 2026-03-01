unit uTweaksW;

interface

uses
  Winapi.Windows, System.SysUtils, Registry;

function RemoveShowMoreOptionsW(AOption: Boolean): Boolean;

implementation

function RemoveShowMoreOptionsW(AOption: Boolean): Boolean;
const
  ROOT = HKEY_CURRENT_USER;
  GUID = '{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}';
  PATH = 'Software\Classes\CLSID\' + GUID + '\InprocServer32';
var
  Reg: TRegistry;
begin
  Result := AOption;

  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := ROOT;

    if AOption then
    begin
      if Reg.OpenKey(PATH, True) then
      try
        try
          Reg.WriteString('', '');
        except
          on E: Exception do
            OutputDebugString(PChar('WriteString failed at ' + PATH + '\(Default): ' + E.Message));
        end;
      finally
        Reg.CloseKey;
      end;
    end
    else
    begin
      try
        if not Reg.DeleteKey('Software\Classes\CLSID\' + GUID) then
        begin
          Reg.DeleteKey(PATH);
          Reg.DeleteKey('Software\Classes\CLSID\' + GUID);
        end;
      except
        on E: Exception do
          OutputDebugString(PChar('DeleteKey failed at Software\Classes\CLSID\' + GUID + ': ' + E.Message));
      end;

      Result := False;
    end;
  finally
    Reg.Free;
  end;
end;

end.
