unit Model.crCustomServer;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomBase, Model.crCustomObject, Model.crCustomListObject,
  Model.crCustomListDataBase, Model.crCustomDataBase, Model.IActionDataBase;

type
  TcrCustomServer = class;

  TServerNotifyEvent = procedure(const AServerName: string; AObject: TcrCustomObject) of object;

  TcrCustomServer = class(TcrCustomObject, IActionDataBase)
  private
    FActiveDataBase: string;
    FAppName: string;
    FDataBase: TcrCustomDataBase;
    FItemsDataBases: TcrCustomListDatabase;
    FPassWord: string;
    FOnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase>;
    FOnAfterRemoveDataBase: TRemoveNotityEvent;

    function GetItemDBName: string;
    function GetSelectDataBase(const AName: string): string;
    procedure SetNameEvent(AObject: TcrCustomObject; const Value: string);
  protected
    procedure AfterAddDataBaseNotifyEvent(ADataBase: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
    procedure SetActiveDataBase(const Value: string);
    procedure SetName(const Value: string); override;

    property ItemDatabase: TcrCustomDataBase read FDataBase;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure DataBaseToStrings(AList: TStrings);

    property ActiveDataBase: string read FActiveDataBase;
    property SelectDataBase[const AName: string]: string read GetSelectDataBase;
    property AppName: string read FAppName write FAppName;
    property ItemDBName: string read GetItemDBName;
    property ItemsDataBases: TcrCustomListDatabase read FItemsDataBases;
    property Name;
    property PassWord: string read FPassWord write FPassWord;
    property OnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase> read FOnAfterAddDataBase write FOnAfterAddDataBase;
    property OnAfterRemoveDataBase: TRemoveNotityEvent read FOnAfterRemoveDataBase write FOnAfterRemoveDataBase;
  end;

implementation

uses
  Helper.ConstMsg;

{ TcrCustomServer }

procedure TcrCustomServer.AfterAddDataBaseNotifyEvent(ADataBase: TcrCustomObject;
  const Action: TListItemNotification);
begin
  FDataBase := TcrCustomDataBase(ADataBase);
  if Assigned(FOnAfterAddDataBase) then
    FOnAfterAddDataBase(FDataBase, Action);
end;

constructor TcrCustomServer.Create(AOwner: TObject);
begin
  FItemsDataBases := TcrCustomListDatabase.Create(Self);
  FItemsDataBases.OnAfterAdd     := AfterAddDataBaseNotifyEvent;
  FItemsDataBases.OnAfterRemove  := AfterRemoveDataBaseNotifyEvent;
  FItemsDataBases.OnSetNameEvent := SetNameEvent;
  inherited Create(AOwner);
end;

procedure TcrCustomServer.DataBaseToStrings(AList: TStrings);
begin
  if Assigned(ItemsDataBases) then
    ItemsDataBases.ToStrings(AList);
end;

destructor TcrCustomServer.Destroy;
begin
  FreeAndNil(FItemsDataBases);
  inherited;
end;

function TcrCustomServer.GetItemDBName: string;
begin
  if Assigned(FDataBase) then
    Result := FDataBase.Name
  else Result := '';
end;

function TcrCustomServer.GetSelectDataBase(const AName: string): string;
begin
  FDataBase := FItemsDataBases.Items[AName];
  Result    := GetItemDBName;
end;

procedure TcrCustomServer.AfterRemoveDataBaseNotifyEvent(const AKey: string);
begin
  if Assigned(FOnAfterRemoveDataBase) then
    FOnAfterRemoveDataBase(AKey);
end;

procedure TcrCustomServer.SetActiveDataBase(const Value: string);
begin
  FActiveDataBase := Value;
end;

procedure TcrCustomServer.SetName(const Value: string);
begin
  if Trim(Value) = '' then
    raise Exception.Create('É necessário informar um nome do servidor!');

  inherited SetName(Value);
end;

procedure TcrCustomServer.SetNameEvent(AObject: TcrCustomObject;
  const Value: string);
begin
  if (Value <> AObject.Name) and
     FItemsDataBases.Contains(Value) then
    raise Exception.Create(SExistsDataBase);
end;

end.
