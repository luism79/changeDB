unit Helper.CustomPersistent;

interface

uses
  System.Classes, Vcl.Controls;

type
  TCustomPersistent = class(TPersistent)
  private
    FControl: TControl;
  protected
    property Control: TControl read FControl;
  public
    constructor Create(AControl: TControl); virtual;
  end;

implementation

{ TCustomPersistent }

constructor TCustomPersistent.Create(AControl: TControl);
begin
  FControl := AControl;
end;

end.
