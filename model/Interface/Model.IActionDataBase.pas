unit Model.IActionDataBase;

interface

uses
  System.Classes, Model.crCustomObject, Model.crCustomListObject;

type
  IActionDataBase = interface(IInterface)
    procedure AfterAddDataBaseNotifyEvent(AObject: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
    procedure SetNameEvent(AObject: TcrCustomObject; const Value: string);
  end;

implementation

end.
