unit Model.crCustomFileCfg;

interface

uses
  System.Classes, System.SysUtils, Model.crCustomBase;

type
  TFileNameNotifyEvent = procedure(AObject: TcrCustomBase; const AFileName: string) of object;

  TcrCustomFileCfg = class(TcrCustomBase)
  private
    FFileName: string;
    FOnFileNameChange: TFileNameNotifyEvent;
  protected
    procedure SetFileName(const Value: string); virtual;
  public
    property FileName: string read FFileName write SetFileName;
    property OnFileNameChange: TFileNameNotifyEvent read FOnFileNameChange write FOnFileNameChange;
  end;
implementation

{ TcrCustomFileCfg }

procedure TcrCustomFileCfg.SetFileName(const Value: string);
begin
  FFileName := Value;

  if Assigned(OnFileNameChange) then
    OnFileNameChange(Self, Value);
end;

end.
