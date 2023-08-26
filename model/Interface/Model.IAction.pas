unit Model.IAction;

interface

uses
  System.Classes;

type
  IAction = Interface(IInterface)
    procedure EraseSection(const ASection: String);
    procedure LoadValuesSection(const ASection: String;
      AList: TStrings);
    procedure SaveConfig(const ASection, AParam: String;
      AListValues: TStrings); overload;
  end;

implementation

end.
