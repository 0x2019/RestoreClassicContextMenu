unit uTweaksR;

interface

uses
  Winapi.Windows, Registry;

function RemoveShowMoreOptionsR: Boolean;

implementation

function RemoveShowMoreOptionsR: Boolean;
const
  ROOT = HKEY_CURRENT_USER;
  GUID = '{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}';
  PATH = 'Software\Classes\CLSID\' + GUID + '\InprocServer32';
var
  Reg: TRegistry;
  defVal: string;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := ROOT;
    if Reg.OpenKeyReadOnly(PATH) then
    try
      if Reg.ValueExists('') and (Reg.GetDataType('') in [rdString, rdExpandString]) then
      begin
        defVal := Reg.ReadString('');
        Result := (defVal = '');
      end;
    finally
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

end.
