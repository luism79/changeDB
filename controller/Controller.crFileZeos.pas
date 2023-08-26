unit Controller.crFileZeos;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Model.crCustomFileCfg, Model.IActionFileCfg,
  Model.crCustomServer, Model.crCustomDB, Model.crCustomDataBase;

type

  TcrFileZeos = class(TcrCustomFileCfg, IActionFileCfg)
  private
    FFileZeos: TStrings;
    FServer: TcrCustomServer;

    procedure SaveDataBase(ADataBase: TcrCustomDB;
      const ASection: string); overload;
    procedure SaveDataBase(ADataBase: TcrCustomDataBase); overload;
  protected
    procedure Apply; overload;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Apply(AServer: TcrCustomServer); overload;
    property FileName;
  end;

implementation

const
  CL_PARAM = 'Params';

{ TcrFileZeos }

procedure TcrFileZeos.Apply;
var
  DataBase: TcrCustomDataBase;
begin
  FFileZeos.LoadFromFile(FileName);
  FFileZeos.Clear;
  DataBase := FServer.ItemsDataBases.Items[FServer.ItemDBName];
  SaveDataBase(DataBase, CL_PARAM);
  SaveDataBase(DataBase);
  FFileZeos.SaveToFile(FileName);
end;

procedure TcrFileZeos.Apply(AServer: TcrCustomServer);
begin
  if Assigned(AServer) and not FileName.IsEmpty then
  begin
    FServer := AServer;
    Apply;
  end;
end;

constructor TcrFileZeos.Create(AOwner: TObject);
begin
  FFileZeos := TStringList.Create;
  inherited Create(AOwner);
end;

destructor TcrFileZeos.Destroy;
begin
  FreeAndNil(FFileZeos);
  inherited;
end;

procedure TcrFileZeos.SaveDataBase(ADataBase: TcrCustomDataBase);
var
  db: TcrCustomDB;
begin
  if not Assigned(ADataBase) then
    Exit;

  for db in ADataBase.ItemsDBCon.Values do
    SaveDataBase(db, db.Name);
end;

procedure TcrFileZeos.SaveDataBase(ADataBase: TcrCustomDB;
  const ASection: string);
begin
  if ASection.IsEmpty then
    Exit;

  FFileZeos.Add(Format('[%s]', [ASection]));
  if not Assigned(ADataBase) then
    Exit;

  FFileZeos.Add(Format('DATABASE NAME=%s', [IfThen(ASection = CL_PARAM, ADataBase.Name, ADataBase.ParamValue)]));
  FFileZeos.Add(Format('USER NAME=%s', ['sa']));
  FFileZeos.Add(Format('PASSWORD=%s', [FServer.PassWord]));
  FFileZeos.Add(Format('PROTOCOL=%s', ['mssql']));
  FFileZeos.Add(Format('LOGIN PROMPT=%d', [0]));
  FFileZeos.Add('');
end;

end.
