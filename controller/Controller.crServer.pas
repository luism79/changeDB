unit Controller.crServer;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomServer, Model.crCustomAppReg;

type
  TcrServer = class(TcrCustomServer)
  private
    procedure DoRead(ARegistry: TcrCustomAppReg);
    procedure DoWrite(ARegistry: TcrCustomAppReg);
    function GetSection: string;
  protected
    procedure Load; override;
  public
    procedure Apply;
    procedure Remove;
  end;

implementation

uses
  Controller.crChangeDB, Controller.crListServers, Model.crCustomDB, Model.crCustomDataBase;

{ TcrServer }

procedure TcrServer.Apply;
var
  r: TcrCustomAppReg;
begin
  r := TcrCustomAppReg.Create(TcrChangeDB(Owner).RootKey, GetSection);
  try
    DoWrite(r);
  finally
    r.Free;
  end;
end;

procedure TcrServer.DoRead(ARegistry: TcrCustomAppReg);

  function InternalCreateDBCon(ADBOwner: TcrCustomDB;
    ADataBaseName, AParam: string): TcrCustomDB;
  begin
    Result := TcrCustomDB.Create(ADBOwner);
    Result.Name       := ADataBaseName;
    Result.ParamValue := AParam;
  end;

  procedure InteralAddDataBase(ADataBaseName: string);
  var
    db: TcrCustomDataBase;
    listDBCon: TStrings;
    NameDBCon: string;
    Param: string;
  begin
    db := TcrCustomDataBase.Create(Self, ADataBaseName);
    listDBCon := TStringList.Create;
    try
      ARegistry.LoadKeySection(Format('%s\%s', [GetSection, ADataBaseName]), listDBCon);
      for NameDBCon in listDBCon do
      begin
        ARegistry.OpenKey(Format('%s\%s\%s', [GetSection, ADataBaseName, NameDBCon]), false);
        Param := ARegistry.ReadString('ParamValue', '');

        db.ItemsDBCon.Add(NameDBCon, InternalCreateDBCon(db, NameDBCon, Param));
      end;
    finally
      listDBCon.Free;
    end;
    ItemsDataBases.Add(db);
  end;

  procedure LoadSectionDataBase;
  var
    List: TStrings;
    s: string;
  begin
    List := TStringList.Create;
    try
      ARegistry.LoadKeySection(GetSection, List);
      for s in List do
        InteralAddDataBase(s);
    finally
      List.Free;
    end;
  end;


begin
  AppName        := ARegistry.ReadString('AppName', '');
  PassWord       := ARegistry.ReadString('PassWord', '');
  SetActiveDataBase(ARegistry.ReadString('ActiveDataBase', ''));
  LoadSectionDataBase;
  SelectDataBase[ActiveDataBase];
end;

procedure TcrServer.DoWrite(ARegistry: TcrCustomAppReg);

  procedure WriteDataBase;
  var
    db: TcrCustomDataBase;
    dbCon: TcrCustomDB;
    keyDB: string;
  begin
    for db in ItemsDataBases.Values do
    begin
      keyDB := Format('%s\%s', [GetSection, db.Name]);
      ARegistry.EraseSection(keyDB);
      ARegistry.OpenKey(keyDB, true);
      for dbCon in db.ItemsDBCon.Values do
      begin
        keyDB := Format('%s\%s\%s', [GetSection, db.Name, dbCon.Name]);
        ARegistry.OpenKey(keyDB, true);
        ARegistry.WriteString('ParamValue', dbCon.ParamValue);
      end;
    end;
  end;

begin
  SetActiveDataBase(ItemDBName);
  ARegistry.EraseSection(GetSection);
  ARegistry.OpenKey(GetSection, true);
  ARegistry.WriteString('ActiveDataBase', ItemDBName);
  ARegistry.WriteString('AppName', AppName);
  ARegistry.WriteString('PassWord', PassWord);

  WriteDataBase;
end;

function TcrServer.GetSection: string;
var
  Value: string;
begin
  Value := StringReplace(Name, '\', '/', [rfReplaceAll]);
  Result := Format('%s\%s', [TcrListServers(Owner).Section, Value]);
end;

procedure TcrServer.Load;
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

procedure TcrServer.Remove;
var
  r: TcrCustomAppReg;
begin
  r := TcrCustomAppReg.Create(TcrChangeDB(Owner).RootKey, GetSection);
  try
    r.EraseSection(GetSection);
  finally
    r.Free;
  end;
end;

end.
