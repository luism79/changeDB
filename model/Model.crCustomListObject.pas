unit Model.crCustomListObject;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  System.Generics.Defaults, Model.crCustomBase, Model.crCustomObject;

type
  TcrCustomListObject<T> = class;

  TListItemNotification = (crAdded, crChanged, crNone);

  TAddNotifyEvent<T> = procedure(AObject: TcrCustomObject;
    const Action: TListItemNotification) of object;
  TChangeKeyNotityEvent = procedure(const ANewKey, AOldKey: string) of object;
  TRemoveNotityEvent = procedure(const AKey: string) of object;

  TcrCustomListObject<T> = class(TcrCustomBase)
  private
    FListItems: TDictionary<string, T>;
    FOnAfterAdd: TAddNotifyEvent<T>;
    FOnAfterRemove: TRemoveNotityEvent;
    FOnBeforeChangeKey: TChangeKeyNotityEvent;
    FOnSetNameEvent: TSetNameEvent;

    function GetItem(const AName: string): T;
    function GetCount: integer;
    function GetObject(AObject: T): TcrCustomObject;
    function GetValues: TList<T>;
    type
      TcrHackObject = class(TcrCustomObject)
      protected
        property OldName;
      end;
  protected
    procedure AssignProperties(AObject: TcrCustomObject); virtual;
    procedure ChangeKey(AObject: T); virtual;
    function DoNewObject(const AName: string): TcrCustomObject; overload; virtual; abstract;
    function DoNewObject: TcrCustomObject; overload; virtual; abstract;

    property ListItems: TDictionary<string, T> read FListItems;
  public
    constructor Create(AOwner: TObject); reintroduce; virtual;
    destructor Destroy; override;

    procedure Add(const AName: string; AObject: T); virtual;
    procedure Clear;
    function Contains(const Key: string): Boolean;
    function New: T; overload; virtual; abstract;
    function New(const AName: string): T; overload; virtual; abstract;
    procedure Remove(const AName: string); virtual;
    procedure ToStrings(AList: TStrings); virtual;

    property Count: integer read GetCount;
    property Items[const AName: string]: T read GetItem;
    property Values: TList<T> read GetValues;
    property OnAfterAdd: TAddNotifyEvent<T> read FOnAfterAdd write FOnAfterAdd;
    property OnAfterRemove: TRemoveNotityEvent read FOnAfterRemove write FOnAfterRemove;
    property OnBeforeChangeKey: TChangeKeyNotityEvent read FOnBeforeChangeKey write FOnBeforeChangeKey;
    property OnSetNameEvent: TSetNameEvent read FOnSetNameEvent write FOnSetNameEvent;
  end;

implementation

{ TcrCustomListObject<T> }

procedure TcrCustomListObject<T>.Add(const AName: string;
  AObject: T);
var
  Action: TListItemNotification;
begin
  AssignProperties(GetObject(AObject));
  Action := TListItemNotification(FListItems.ContainsValue(AObject).ToInteger);
  if Action = crChanged then
    ChangeKey(AObject);

  FListItems.AddOrSetValue(AName, AObject);

  if Assigned(FOnAfterAdd) then
    FOnAfterAdd(GetObject(AObject), Action);
end;

procedure TcrCustomListObject<T>.AssignProperties(AObject: TcrCustomObject);
begin
  TcrCustomObject(AObject).OnSetName := OnSetNameEvent;
end;

procedure TcrCustomListObject<T>.ChangeKey(AObject: T);
var
  obj: TcrCustomObject;
  pair: TPair<string, T>;
begin
  obj := GetObject(AObject);
  if Assigned(obj) and
     (obj.Name <> TcrHackObject(obj).OldName) then
  begin
    if Assigned(FOnBeforeChangeKey) then
      FOnBeforeChangeKey(obj.Name, TcrHackObject(obj).OldName);

    pair := FListItems.ExtractPair(TcrHackObject(obj).OldName);
    pair.Key := obj.Name;
  end;
end;

procedure TcrCustomListObject<T>.Clear;
begin
  FListItems.Clear;
end;

function TcrCustomListObject<T>.Contains(const Key: string): Boolean;
begin
  Result := FListItems.ContainsKey(Key);
end;

constructor TcrCustomListObject<T>.Create(AOwner: TObject);
begin
   FListItems := TDictionary<string, T>.Create(
    TDelegatedEqualityComparer<string>.Create(
      function(const Left, Right: string): boolean
      begin
        Result := Left.ToLower.GetHashCode = Right.ToLower.GetHashCode;
      end,
      function(const Value: string): integer
      begin
        Result := Value.GetHashCode;
      end)
    );

  inherited Create(AOwner);
end;

destructor TcrCustomListObject<T>.Destroy;
begin
  FreeAndNil(FListItems);
  inherited;
end;

function TcrCustomListObject<T>.GetCount: integer;
begin
  Result := FListItems.Count;
end;

function TcrCustomListObject<T>.GetItem(const AName: string): T;
begin
  FListItems.TryGetValue(AName, Result);
end;

function TcrCustomListObject<T>.GetObject(AObject: T): TcrCustomObject;
begin
  Result := TcrCustomObject(Pointer(@AObject)^);
end;

function TcrCustomListObject<T>.GetValues: TList<T>;
var
  item: T;
begin
  Result := TList<T>.Create;
  for item in FListItems.Values do
    Result.Add(item);
end;

procedure TcrCustomListObject<T>.Remove(const AName: string);
begin
  FListItems.Remove(AName);
  
  if Assigned(FOnAfterRemove) then
    FOnAfterRemove(AName);
end;

procedure TcrCustomListObject<T>.ToStrings(AList: TStrings);
var
  obj: T;
begin
  if Assigned(AList) then
  begin
    AList.Clear;
    for obj in FListItems.Values do
      AList.Add(GetObject(obj).Name);
  end;
end;

end.
