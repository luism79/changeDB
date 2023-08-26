unit Model.crCustomObject;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomBase;

type
  TcrCustomObject = class;

  TSetNameEvent = procedure(AObject: TcrCustomObject; const AValue: string) of object;

  TcrCustomObject = class(TcrCustomBase)
  private
    FName: string;
    FOldName: string;
    FOnSetName: TSetNameEvent;
  protected
    procedure SetName(const Value: string); virtual;

    property OldName: string read FOldName;
  public
    constructor Create(AOwner: TObject); overload; override;
    constructor Create(AOwner: TObject; AName: string); reintroduce; overload;

    function Equals(Obj: TObject): Boolean; override;
    function GetHashCode: Integer; override;
    function ToString: string; override;

    property Name: string read FName write SetName;
    property OnSetName: TSetNameEvent read FOnSetName write FOnSetName;
  end;

implementation

{ TcrCustomObject }

constructor TcrCustomObject.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
end;

constructor TcrCustomObject.Create(AOwner: TObject; AName: string);
begin
  SetName(AName);
  Create(AOwner);
end;

function TcrCustomObject.Equals(Obj: TObject): Boolean;
begin
  if Assigned(Obj) and
     (Obj is TcrCustomObject) then
    Result := (TcrCustomObject(Obj).GetHashCode = GetHashCode)
  else Result := inherited Equals(Obj);
end;

function TcrCustomObject.GetHashCode: Integer;
begin
  Result := Name.ToLower.GetHashCode;
end;

procedure TcrCustomObject.SetName(const Value: string);
begin
  if Assigned(FOnSetName) then
    FOnSetName(Self, Value);

  FOldName := FName;
  FName    := Value;
end;

function TcrCustomObject.ToString: string;
begin
  Result := Format('%s [%s]', [LowerCase(FName), ClassName]);
end;

end.
