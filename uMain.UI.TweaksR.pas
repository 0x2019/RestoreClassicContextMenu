unit uMain.UI.TweaksR;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, Registry;

function RemoveShowMoreOptionsR: Boolean;

implementation

function RemoveShowMoreOptionsR: Boolean;
const
  ROOT = HKEY_CURRENT_USER;
  GUID = '{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}';
  PATH = 'Software\Classes\CLSID\' + GUID + '\InprocServer32';
var
  xReg: TRegistry;
  defVal: string;
begin
  Result := False;
  xReg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    xReg.RootKey := ROOT;
    if xReg.OpenKeyReadOnly(PATH) then
    try
      if xReg.ValueExists('') and (xReg.GetDataType('') in [rdString, rdExpandString]) then
      begin
        defVal := xReg.ReadString('');
        Result := (defVal = '');
      end;
    finally
      xReg.CloseKey;
    end;
  finally
    xReg.Free;
  end;
end;

end.
