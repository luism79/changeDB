unit Controller.crListServers;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  System.Generics.Defaults, Model.crCustomObject, Model.crCustomServer,
  Model.crCustomListServers, Model.crCustomAppReg;

type
  TcrListServers = class(TcrCustomListServers)
  private
    FServerRemoved: TList<TcrCustomServer>;

    procedure DoRead(ARegistry: TcrCustomAppReg);
    procedure DoWrite(ARegistry: TcrCustomAppReg);
    function GetSection: string;
  protected
    procedure Load; override;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Apply(AServer: TcrCustomServer);
    procedure Remove(const AName: string); override;

    property Section: string read GetSection;
  end;

implementation

uses
  Controller.crChangeDB, Controller.crServer;

{ TcrListServers }

procedure TcrListServers.Apply(AServer: TcrCustomServer);
var
  r: TcrCustomAppReg;
begin
  if Assigned(AServer) then
    Add(AServer);

  r := TcrCustomAppReg.Create(TcrChangeDB(Owner).RootKey, GetSection);
  try
    DoWrite(r);
    FServerRemoved.Clear;
  finally
    r.Free;
  end;
end;

constructor TcrListServers.Create(AOwner: TObject);
begin
  FServerRemoved := TList<TcrCustomServer>.Create;
  inherited Create(AOwner);
end;

destructor TcrListServers.Destroy;
begin
  FreeAndNil(FServerRemoved);
  inherited Destroy;
end;

procedure TcrListServers.DoRead(ARegistry: TcrCustomAppReg);

  procedure InternalAddServer(AParam: string);
  var
    keyServer: string;
    sName: string;
    server: TcrServer;
  begin
    keyServer := format('%s\%s', [GetSection, AParam]);
    sName     := StringReplace(AParam, '/', '\', [rfReplaceAll]);
    if not Contains(sName) then
    begin
      ARegistry.OpenKey(keyServer, false);
      server := TcrServer.Create(Self, sName);
      Add(server);
    end;
  end;

  procedure LoadSectionServer;
  var
    List: TStrings;
    s: string;
  begin
    List := TStringList.Create;
    try
      ARegistry.LoadKeySection(GetSection, List);
      for s in List do
        InternalAddServer(s);
    finally
      List.Free;
    end;
  end;

begin
  LoadSectionServer;
end;

procedure TcrListServers.DoWrite(ARegistry: TcrCustomAppReg);

  procedure WriteItemsRemoved;
  var
    server: TcrCustomServer;
  begin
    for server in FServerRemoved do
      TcrServer(server).Remove;
  end;

  procedure WriteItemsServer;
  var
    server: TcrCustomServer;
  begin
    for server in ListItems.Values do
      TcrServer(server).Apply;
  end;

begin
  WriteItemsRemoved;
  WriteItemsServer;
end;

function TcrListServers.GetSection: string;
begin
  Result := Format('%s', [TcrChangeDB(Owner).Section]);
end;

procedure TcrListServers.Load;
var
  r: TcrCustomAppReg;
begin
  r := TcrCustomAppReg.Create(TcrChangeDB(Owner).RootKey, GetSection);
  try
    DoRead(r);
  finally
    r.Free;
  end;
end;

procedure TcrListServers.Remove(const AName: string);
begin
  FServerRemoved.Add(Items[AName]);
  inherited Remove(AName);
end;

end.
