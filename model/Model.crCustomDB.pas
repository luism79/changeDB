unit Model.crCustomDB;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomObject;

type
  TcrCustomDB = class(TcrCustomObject)
  private
    FParamValue: string;
  protected
    procedure SetName(const Value: string); override;
  public
    procedure Assing(ADest: TcrCustomDB); virtual;

    property Name;
    property ParamValue: string read FParamValue write FParamValue;
  end;

implementation

{ TcrCustomDB }

procedure TcrCustomDB.Assing(ADest: TcrCustomDB);
begin
  if Assigned(ADest) then
  begin
    if not Name.IsEmpty then
      ADest.Name := Name;

    ADest.ParamValue := ParamValue;
    ADest.OnSetName  := OnSetName;
  end;
end;

procedure TcrCustomDB.SetName(const Value: string);
var
  ChangeValue: boolean;
begin
  if Trim(Value) = '' then
    raise Exception.Create('É necessário informar um nome do banco de dados!');

  ChangeValue := Name = FParamValue;
  inherited SetName(Value);

  if ChangeValue then
    FParamValue := Name;
end;

end.
