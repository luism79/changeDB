unit Model.crCustomListDataBase;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Model.crCustomObject,
  Model.crCustomListObject, Model.crCustomDataBase, Model.crCustomDB,
  Model.IActionListObjects, Model.IActionDataBase;

type
  TcrCustomListDatabase = class(TcrCustomListObject<TcrCustomDataBase>, IActionDataBase, IActionListObjects)
  private
    FOnAfterAddDBCon: TAddNotifyEvent<TcrCustomDB>;
    FOnAfterRemoveDBCon: TRemoveNotityEvent;

    procedure BeforeChangeKey(const ANewKey, AOldKey: string);
    procedure SetNameEvent(AObject: TcrCustomObject; const Value: string);
  protected
    procedure AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
    procedure AssignProperties(AObject: TcrCustomObject); override;
    function DoNewObject: TcrCustomObject; overload; override;
    function DoNewObject(const AName: string): TcrCustomObject; overload; override;

    property ListItems;
  public
    constructor Create(AOwner: TObject); override;

    procedure Add(const AName: string; AObject: TcrCustomDataBase); overload; override;
    procedure Add(AObject: TcrCustomDataBase); reintroduce; overload;
    function New: TcrCustomDataBase; overload; override;

    property OnAfterAddDBCon: TAddNotifyEvent<TcrCustomDB> read FOnAfterAddDBCon write FOnAfterAddDBCon;
    property OnAfterRemoveDBCon: TRemoveNotityEvent read FOnAfterRemoveDBCon write FOnAfterRemoveDBCon;
  end;

implementation

{ TcrCustomListDatabase }

procedure TcrCustomListDatabase.Add(AObject: TcrCustomDataBase);
begin
  if Assigned(AObject) then
    Add(AObject.Name, AObject)
  else Add(EmptyStr, AObject);
end;

procedure TcrCustomListDatabase.AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject; const Action: TListItemNotification);
begin
  if Assigned(FOnAfterAddDBCon) then
    FOnAfterAddDBCon(AObject, Action);
end;

procedure TcrCustomListDatabase.AfterRemoveDataBaseNotifyEvent(const AKey: string);
begin
  if Assigned(FOnAfterRemoveDBCon) then
    FOnAfterRemoveDBCon(AKey);
end;

procedure TcrCustomListDatabase.AssignProperties(AObject: TcrCustomObject);
begin
  inherited AssignProperties(AObject);
  TcrCustomDataBase(AObject).OnAfterAddDBCon    := AfterAddDataBaseNotifyEvent;
  TcrCustomDataBase(AObject).OnAfterRemoveDBCon := AfterRemoveDataBaseNotifyEvent;
end;

procedure TcrCustomListDatabase.BeforeChangeKey(const ANewKey, AOldKey: string);
var
  db: TcrCustomDataBase;
begin
  if (ANewKey <> AOldKey) and
     Contains(ANewKey) then
  begin
    db :=  Items[AOldKey];
    db.Name := AOldKey;
    raise Exception.Create('Nome do banco de dados já existe!');
  end;
end;

procedure TcrCustomListDatabase.Add(const AName: string; AObject: TcrCustomDataBase);
begin
  inherited Add(AName, AObject);
end;

constructor TcrCustomListDatabase.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  OnBeforeChangeKey := BeforeChangeKey;
end;

function TcrCustomListDatabase.DoNewObject: TcrCustomObject;
begin
  Result := DoNewObject('');
end;

function TcrCustomListDatabase.DoNewObject(const AName: string): TcrCustomObject;
begin
  if AName.IsEmpty then
    Result := TcrCustomDataBase.Create(Self)
  else Result := TcrCustomDataBase.Create(Self, AName);

  AssignProperties(Result);
end;

function TcrCustomListDatabase.New: TcrCustomDataBase;
begin
  Result := TcrCustomDataBase(DoNewObject);
end;

procedure TcrCustomListDatabase.SetNameEvent(AObject: TcrCustomObject; const Value: string);
begin

end;

end.
