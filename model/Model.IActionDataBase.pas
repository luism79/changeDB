unit Model.IActionDataBase;

interface

uses
  System.Classes, Model.crCustomListObject, Model.crCustomDataBase;

type
  IActionDataBase = interface(IInterface)
    procedure AfterAddDataBaseNotifyEvent(ADataBase: TcrCustomDataBase;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBaseNotifyEvent(const AKey: string);
  end;

implementation

end.
