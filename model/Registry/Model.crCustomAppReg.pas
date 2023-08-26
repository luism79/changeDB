unit Model.crCustomAppReg;

interface

uses
  System.Classes, System.SysUtils, Winapi.Windows, System.Win.Registry, Model.IRegistryAction;

type

  TcrCustomAppReg = class(TInterfacedObject, IRegistryAction)
  private
    FRegistry: TRegistry;
  public
    constructor Create(ARootKey: HKEY; AKey: string);
    destructor Destroy; override;

    procedure EraseSection(const ASection: String);
    function OpenKey(const Key: string; Cancreate: boolean): boolean;
    function ReadBoolean(const AParam: string; ADefault: boolean): boolean;
    function ReadInteger(const AParam: string; ADefault: integer): integer;
    function ReadString(const AParam, ADefault: string): string;
    procedure LoadValuesSection(const ASection: String;
      AList: TStrings);
    procedure LoadKeySection(const ASection: String;
      AList: TStrings);
    procedure SaveConfig(const ASection, AParam: String;
      AListValues: TStrings); overload;
    procedure WriteBoolean(const AParam: string; AValue: boolean);
    procedure WriteInteger(const AParam: string; AValue: integer);
    procedure WriteString(const AParam, AValue: string);
  end;

implementation

{ TcrCustomAppReg }

constructor TcrCustomAppReg.Create(ARootKey: HKEY; AKey: string);
begin
  FRegistry := TRegistry.Create;
  FRegistry.RootKey := ARootKey;
  OpenKey(AKey, true);
end;

destructor TcrCustomAppReg.Destroy;
begin
  FreeAndNil(FRegistry);
  inherited;
end;

procedure TcrCustomAppReg.EraseSection(const ASection: String);
begin
  FRegistry.CloseKey;
  FRegistry.DeleteKey(ASection);
end;

function TcrCustomAppReg.ReadBoolean(const AParam: string; ADefault: boolean): boolean;
begin
  try
    Result := FRegistry.ReadBool(AParam);
  except
    Result := ADefault;
  end;
end;

function TcrCustomAppReg.ReadInteger(const AParam: string; ADefault: integer): integer;
begin
  try
    Result := FRegistry.ReadInteger(AParam);
  except
    Result := ADefault;
  end;
end;

function TcrCustomAppReg.ReadString(const AParam, ADefault: string): string;
begin
  try
    Result := FRegistry.ReadString(AParam);
  except
    Result := ADefault;
  end;
end;

procedure TcrCustomAppReg.LoadKeySection(const ASection: String; AList: TStrings);
begin
  FRegistry.CloseKey;
  FRegistry.OpenKeyReadOnly(ASection);
  FRegistry.GetKeyNames(AList);
end;

procedure TcrCustomAppReg.LoadValuesSection(const ASection: String; AList: TStrings);
begin
  FRegistry.CloseKey;
  FRegistry.OpenKeyReadOnly(ASection);
  FRegistry.GetValueNames(AList);
end;

function TcrCustomAppReg.OpenKey(const Key: string; Cancreate: boolean): boolean;
begin
  FRegistry.CloseKey;
  Result := FRegistry.OpenKey(Key, Cancreate)
end;

procedure TcrCustomAppReg.SaveConfig(const ASection, AParam: String;
  AListValues: TStrings);
var
  value: string;
  index: integer;
begin
  FRegistry.CloseKey;
  FRegistry.OpenKey(ASection, true);

  index := 0;
  for value in AListValues do
  begin
    WriteString(Format('%s%d', [AParam, index]), value);
    Inc(index);
  end;
end;


procedure TcrCustomAppReg.WriteBoolean(const AParam: string; AValue: boolean);
begin
  FRegistry.WriteBool(AParam, AValue);
end;

procedure TcrCustomAppReg.WriteInteger(const AParam: string; AValue: integer);
begin
  FRegistry.WriteInteger(AParam, AValue);
end;

procedure TcrCustomAppReg.WriteString(const AParam, AValue: string);
begin
  FRegistry.WriteString(AParam, AValue);
end;

end.
