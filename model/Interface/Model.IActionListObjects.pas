unit Model.IActionListObjects;

interface

uses
  System.Classes, Model.crCustomObject;

type
  IActionListObjects = interface(IInterface)
    procedure AssignProperties(AObject: TcrCustomObject);
    function DoNewObject: TcrCustomObject; overload;
    function DoNewObject(const AName: string): TcrCustomObject; overload;
  end;

implementation

end.
