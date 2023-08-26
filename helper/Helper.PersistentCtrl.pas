unit Helper.PersistentCtrl;

interface

uses
  System.Classes, System.SysUtils, Vcl.ActnList, Vcl.Controls, Vcl.StdCtrls, Vcl.Menus, Winapi.Messages,
  Helper.CustomPersistent;

type
  TPersistentCtrl = class(TCustomPersistent)
  private
    FAction: TAction;
    FDefWndMethod: TWndMethod;
    FShortCut: TShortCut;

    procedure DoShowHint(var Hint: string);
    function GetEnabled: boolean;
    function GetHint: string;
    function GetShortCutText: string;
    procedure SetShortCut(const Value: TShortCut);
  protected
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure NewWndMethod(var Msg: TMessage);

    property Control;
  public
    constructor Create(AControl: TControl); override;

    function Execute: boolean;

    property Action: TAction read FAction;
    property Enabled: boolean read GetEnabled;
    property Hint: string read GetHint;
    property ShortCut: TShortCut read FShortCut write SetShortCut;
  end;

implementation

{ TPersistentCtrl }

procedure TPersistentCtrl.CMHintShow(var Message: TCMHintShow);
var
  HintInfo: Vcl.Controls.PHintInfo;
begin
  HintInfo := Message.HintInfo;
  DoShowHint(HintInfo.HintStr);
  Message.Result   := 0;
  Message.HintInfo := HintInfo;
end;

constructor TPersistentCtrl.Create(AControl: TControl);
begin
  if Assigned(AControl) then
    FAction := AControl.Action as TAction;

  inherited Create(AControl);
  FDefWndMethod      := Control.WindowProc;
  Control.WindowProc := NewWndMethod;
end;

procedure TPersistentCtrl.DoShowHint(var Hint: string);
begin
  if (FShortCut <> scNone) and not Hint.IsEmpty then
    Hint := Format('%s (%s)', [Hint, GetShortCutText]);
end;

function TPersistentCtrl.Execute: boolean;
begin
  if Assigned(FAction) then
    Result := FAction.Execute
  else
  begin
    try
      TButton(Control).Click;
      Result := true;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

function TPersistentCtrl.GetEnabled: boolean;
begin
  if Assigned(FAction) then
    Result := FAction.Enabled
  else Result := Control.Enabled;
end;

function TPersistentCtrl.GetHint: string;
begin
  if Assigned(Control) then
    Result := Control.Hint
  else Result := '';
end;

function TPersistentCtrl.GetShortCutText: string;
begin
  if FShortCut = scNone then
    Result := EmptyStr
  else Result := Vcl.Menus.ShortCutToText(FShortCut);
end;

procedure TPersistentCtrl.NewWndMethod(var Msg: TMessage);
begin
  if Msg.Msg = CM_HINTSHOW then
    CMHintShow(TCMHintShow(Msg))
  else FDefWndMethod(Msg);
end;

procedure TPersistentCtrl.SetShortCut(const Value: TShortCut);
begin
  if FShortCut <> Value then
    FShortCut := Value;
end;

end.
