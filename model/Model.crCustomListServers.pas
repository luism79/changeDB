unit Model.crCustomListServers;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Model.crCustomObject,
  Model.crCustomListObject, Model.crCustomServer, Model.crCustomDataBase,
  Model.IActionDataBase, Model.IActionListObjects;

type
  TcrCustomListServers = class(TcrCustomListObject<TcrCustomServer>, IActionDataBase, IActionListObjects)
  private
    FOnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase>;
    FOnAfterRemoveDataBase: TRemoveNotityEvent;

    procedure SetNameEvent(AObject: TcrCustomObject; const Value: string);
  protected
    procedure AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
    procedure AssignProperties(AObject: TcrCustomObject); override;
    function DoNewObject(const AName: string): TcrCustomObject; overload; override;

    property ListItems;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Add(const AName: string; AObject: TcrCustomServer); overload; override;
    procedure Add(AObject: TcrCustomServer); reintroduce; overload;
    function New(const AName: string): TcrCustomServer; overload; override;

    property OnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase> read FOnAfterAddDataBase write FOnAfterAddDataBase;
    property OnAfterRemoveDataBase: TRemoveNotityEvent read FOnAfterRemoveDataBase write FOnAfterRemoveDataBase;
  end;

implementation

{ TcrCustomListServers }

procedure TcrCustomListServers.Add(const AName: string; AObject: TcrCustomServer);
begin
  if not Assigned(AObject) then
    raise Exception.Create('É necessário informar um servidor!');

  inherited Add(AName, AObject);
end;

procedure TcrCustomListServers.Add(AObject: TcrCustomServer);
begin
  if Assigned(AObject) then
    Add(AObject.Name, AObject)
  else Add(EmptyStr, AObject);
end;

procedure TcrCustomListServers.AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject;
  const Action: TListItemNotification);
begin
  if Assigned(FOnAfterAddDataBase) then
    FOnAfterAddDataBase(AObject, Action);
end;

procedure TcrCustomListServers.AfterRemoveDataBaseNotifyEvent(const AKey: string);
begin
  if Assigned(FOnAfterRemoveDataBase) then
    FOnAfterRemoveDataBase(AKey);
end;

procedure TcrCustomListServers.AssignProperties(AObject: TcrCustomObject);
begin
  inherited AssignProperties(AObject);
  TcrCustomServer(AObject).OnAfterAddDataBase    := AfterAddDataBaseNotifyEvent;
  TcrCustomServer(AObject).OnAfterRemoveDataBase := AfterRemoveDataBaseNotifyEvent;
end;

constructor TcrCustomListServers.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
end;

destructor TcrCustomListServers.Destroy;
begin
  inherited;
end;

function TcrCustomListServers.DoNewObject(const AName: string): TcrCustomObject;
begin
  Result := TcrCustomServer.Create(Self, AName);
  AssignProperties(Result);
end;

function TcrCustomListServers.New(const AName: string): TcrCustomServer;
begin
  Result := TcrCustomServer(DoNewObject(AName));
end;

procedure TcrCustomListServers.SetNameEvent(AObject: TcrCustomObject; const Value: string);
begin

end;

end.
