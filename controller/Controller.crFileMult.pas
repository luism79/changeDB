unit Controller.crFileMult;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomFileCfg, Model.IActionFileCfg;

type
  TcrFileMult = class(TcrCustomFileCfg, IActionFileCfg)
  private
    FFileMult: TStrings;

    function GetDrive(const Index: Integer): char;
    procedure SetDrive(const Index: Integer; const Value: char);
  protected
    procedure SetFileName(const Value: string); override;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    procedure Apply;

    property Drive1: char index 0 read GetDrive write SetDrive;
    property Drive2: char index 1 read GetDrive write SetDrive;
    property FileName;
  end;
implementation

{ TcrFileMult }

procedure TcrFileMult.Apply;
begin
  if FileExists(FileName) then
    FFileMult.SaveToFile(FileName);
end;

destructor TcrFileMult.Destroy;
begin
  FreeAndNil(FFileMult);
  inherited;
end;

function TcrFileMult.GetDrive(const Index: Integer): char;
begin
  try
    Result := FFileMult.Strings[Index][1];
  except
    Result := #0;
  end;
end;

constructor TcrFileMult.Create(AOwner: TObject);
begin
  FFileMult := TStringList.Create;
  inherited Create(AOwner);
end;

procedure TcrFileMult.SetDrive(const Index: Integer; const Value: char);
var
  driveValue: string;
begin
  driveValue := Format('%s:', [UpperCase(Value)]);
  if Index < FFileMult.Count then
    FFileMult.Strings[Index] := driveValue
  else FFileMult.Insert(Index, driveValue);
end;

procedure TcrFileMult.SetFileName(const Value: string);
begin
  if Value <> FileName then
  begin
    FFileMult.Clear;
    if FileExists(Value) then
      FFileMult.LoadFromFile(Value);
  end;
  inherited SetFileName(Value);
end;

end.
