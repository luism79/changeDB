unit Model.crCustomDataBase;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomObject, Model.crCustomDB,
  Model.crCustomListObject, Model.crCustomListDB, Model.IActionDataBase;

type
  TcrCustomDataBase = class(TcrCustomDB, IActionDataBase)
  private
    FItemsDBCon: TcrCustomListDB;
    FOnAfterAddDBCon: TAddNotifyEvent<TcrCustomDB>;
    FOnAfterRemoveDBCon: TRemoveNotityEvent;

    procedure SetNameEvent(AObject: TcrCustomObject; const Value: string);
  protected
    procedure AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Assing(ADest: TcrCustomDB); override;

    property ItemsDBCon: TcrCustomListDB read FItemsDBCon;
    property Name;
    property OnAfterAddDBCon: TAddNotifyEvent<TcrCustomDB> read FOnAfterAddDBCon write FOnAfterAddDBCon;
    property OnAfterRemoveDBCon: TRemoveNotityEvent read FOnAfterRemoveDBCon write FOnAfterRemoveDBCon;
  end;

implementation

uses
  Helper.ConstMsg;

{ TcrCustomDataBase }

procedure TcrCustomDataBase.AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject; const Action: TListItemNotification);
begin
  if Assigned(FOnAfterAddDBCon) then
    FOnAfterAddDBCon(AObject, Action);
end;

procedure TcrCustomDataBase.AfterRemoveDataBaseNotifyEvent(const AKey: string);
begin
  if Assigned(FOnAfterRemoveDBCon) then
    FOnAfterRemoveDBCon(AKey);
end;

procedure TcrCustomDataBase.Assing(ADest: TcrCustomDB);
var
  db: TcrCustomDB;
  newDB: TcrCustomDB;
begin
  inherited Assing(ADest);
  if Assigned(ADest) then
  begin
    for db in FItemsDBCon.Values do
    begin
      newDB := TcrCustomDB.Create(ADest);
      db.Assing(newDB);
      TcrCustomDataBase(ADest).ItemsDBCon.Add(newDB.Name, newDB);
    end;
  end;
end;

procedure TcrCustomDataBase.SetNameEvent(AObject: TcrCustomObject; const Value: string);
begin
  if (Value <> AObject.Name) and
    FItemsDBCon.Contains(Value) then
    raise Exception.Create(SExistsDataBase);
end;

constructor TcrCustomDataBase.Create(AOwner: TObject);
begin
  FItemsDBCon := TcrCustomListDB.Create(Self);
  FItemsDBCon.OnAfterAdd     := AfterAddDataBaseNotifyEvent;
  FItemsDBCon.OnAfterRemove  := AfterRemoveDataBaseNotifyEvent;
  FItemsDBCon.OnSetNameEvent := SetNameEvent;
  inherited Create(AOwner);
end;

destructor TcrCustomDataBase.Destroy;
begin
  FreeAndNil(FItemsDBCon);
  inherited;
end;

end.
