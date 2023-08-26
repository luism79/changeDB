unit Controller.crFileServer;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomFileCfg, Model.IActionFileCfg;

type
  TcrFileServer = class(TcrCustomFileCfg, IActionFileCfg)
  private
    FFileServer: TStrings;
    function GetServerName: string;
    procedure SetServerName(const Value: string);
  protected
    procedure SetFileName(const Value: string); override;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Apply; overload;
    procedure Apply(AServerName: string); overload;

    property FileName;
    property ServeName: string read GetServerName write SetServerName;
  end;
implementation

{ TcrFileServer }

procedure TcrFileServer.Apply;
begin
  if FileExists(FileName) then
    FFileServer.SaveToFile(FileName);
end;

procedure TcrFileServer.Apply(AServerName: string);
begin
  SetServerName(AServerName);
  Apply;
end;

constructor TcrFileServer.Create(AOwner: TObject);
begin
  FFileServer := TStringList.Create;
  inherited Create(AOwner);
end;

destructor TcrFileServer.Destroy;
begin
  FreeAndNil(FFileServer);
  inherited;
end;

function TcrFileServer.GetServerName: string;
begin
  try
    Result := StringReplace(FFileServer.Strings[0], 'SERVER NAME=', '', [rfReplaceAll, rfIgnoreCase]);
  except
    Result := '';
  end;
end;

procedure TcrFileServer.SetFileName(const Value: string);
begin
  if Value <> FileName then
  begin
    FFileServer.Clear;
    if FileExists(Value) then
      FFileServer.LoadFromFile(Value);

    inherited SetFileName(Value);
  end;
end;

procedure TcrFileServer.SetServerName(const Value: string);
var
  sValue: string;
begin
  sValue := Format('SERVER NAME=%s', [Value]);
  if FFileServer.Count = 0 then
    FFileServer.Insert(0, sValue)
  else FFileServer.Strings[0] := sValue;
end;

end.
