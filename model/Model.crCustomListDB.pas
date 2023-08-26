unit Model.crCustomListDB;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Model.IActionListObjects, Model.crCustomObject,
  Model.crCustomListObject, Model.crCustomDB;

type
  TcrCustomListDB = class(TcrCustomListObject<TcrCustomDB>, IActionListObjects)
  private
  protected
    function DoNewObject: TcrCustomObject; overload; override;
    function DoNewObject(const AName: string): TcrCustomObject; overload; override;

    property ListItems;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Add(const AName: string; AObject: TcrCustomDB); override;
    function New: TcrCustomDB; overload; override;
  end;

implementation

{ TcrCustomListDB }

procedure TcrCustomListDB.Add(const AName: string; AObject: TcrCustomDB);
begin
  inherited Add(AName, AObject);
end;

constructor TcrCustomListDB.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
end;

destructor TcrCustomListDB.Destroy;
begin
  inherited;
end;

function TcrCustomListDB.DoNewObject: TcrCustomObject;
begin
  Result := DoNewObject('');
end;

function TcrCustomListDB.DoNewObject(const AName: string): TcrCustomObject;
begin
  if AName.IsEmpty then
    Result := TcrCustomDB.Create(Self)
  else Result := TcrCustomDB.Create(Self, AName);
  AssignProperties(Result);
end;

function TcrCustomListDB.New: TcrCustomDB;
begin
  Result := TcrCustomDB(DoNewObject);
end;

end.
