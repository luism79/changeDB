unit Helper.PersistentMain;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Menus, Winapi.Messages,
  System.Generics.Collections, Helper.CustomPersistent, Helper.PersistentCtrl,
  Vcl.Dialogs;

type
  TPersistentMain = class(TCustomPersistent)
  private
    FForm: TCustomForm;
    FListCtrls: TList<TPersistentCtrl>;

    procedure DoKeyDown(var Message: TWMKey);
    function FindShortCut(var Msg: TWMKey; var AControl: TPersistentCtrl): Boolean;
    function MessageHook(var Message: TMessage): Boolean;
    function AddPersisteCtrl(ACtrl: TControl; AShortCut: string): TPersistentCtrl;
  protected
  public
    constructor Create(AOwnerForm: TCustomForm; AControl: TControl = nil); reintroduce;
    destructor Destroy; override;

    procedure AddCtrl(ACtrl: TControl; AShortCut: string);
  end;


implementation

{ TPersistentMain }

procedure TPersistentMain.AddCtrl(ACtrl: TControl; AShortCut: string);
begin
  FListCtrls.Add(AddPersisteCtrl(ACtrl, AShortCut));
end;

function TPersistentMain.AddPersisteCtrl(ACtrl: TControl;
  AShortCut: string): TPersistentCtrl;
begin
  Result := TPersistentCtrl.Create(ACtrl);
  Result.ShortCut := TextToShortCut(AShortCut);
end;

constructor TPersistentMain.Create(AOwnerForm: TCustomForm;
  AControl: TControl);
begin
  FForm      := AOwnerForm;
  FListCtrls := TList<TPersistentCtrl>.Create;
  if not Assigned(AControl)  then
    inherited Create(AOwnerForm)
  else inherited Create(AControl);

  Application.HookMainWindow(MessageHook);
end;

destructor TPersistentMain.Destroy;
begin
  if Assigned(FListCtrls) then
  begin
    FListCtrls.Clear;
    FreeAndNil(FListCtrls);
  end;
  Application.UnhookMainWindow(MessageHook);
  inherited;
end;

procedure TPersistentMain.DoKeyDown(var Message: TWMKey);
var
  cltr: TPersistentCtrl;
begin
  if FindShortCut(Message, cltr) then
    cltr.Execute;
end;

function TPersistentMain.FindShortCut(var Msg: TWMKey;
  var AControl: TPersistentCtrl): Boolean;
var
  ctrl: TPersistentCtrl;
  ShortCut: TShortCut;
begin
// Vcl.Menus.ShortCut(msg.CharCode, ShiftState);
  ShortCut   := Vcl.Menus.ShortCutFromMessage(Msg);
  Result     := false;
  if ShortCut <> scNone then
  begin
    for ctrl in FListCtrls do
    begin
      if ctrl.Enabled and (ctrl.ShortCut = ShortCut) then
      begin
        AControl   := ctrl;
        Msg.Result := 1;
        Result     := true;
        Break;
      end;
    end;
  end;
end;

function TPersistentMain.MessageHook(var Message: TMessage): Boolean;
var
  activetedCtrl: boolean;
begin
  Result := false;
  activetedCtrl := (FForm.ActiveControl = Control) or (Control is TCustomForm);
  if Assigned(FForm) and
     FForm.Active and
     activetedCtrl then
    case Message.Msg of
      CM_APPKEYDOWN, WM_KEYDOWN:
        begin
          DoKeyDown(TWMKey(Message));
          Result := True;
        end;
    end;
end;

end.
