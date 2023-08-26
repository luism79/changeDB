unit Model.crCustomBase;

interface

uses
  System.Classes, System.SysUtils;

type
  TObjectNotifyEvent = procedure(AObject: TObject) of object;

  TcrCustomBase = class(TInterfacedObject)
  private
    FOwner: TObject;
  protected
    procedure Load; virtual;
  public
    constructor Create(AOwner: TObject); virtual;
    property Owner: TObject read FOwner;
  end;


implementation


{ TcrCustomBase }

constructor TcrCustomBase.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  Load;
end;

procedure TcrCustomBase.Load;
begin

end;

end.
