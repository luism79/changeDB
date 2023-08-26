unit CustomWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Model.crCustomBase;

type
  TChangedEventNotify = procedure(AControl: TControl) of object;

  TfrmCustomWin = class(TForm)
    pnlMain: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FModified: boolean;
    FOnChanged: TChangedEventNotify;
  protected
    FCustomOwner: TcrCustomBase;
    FCustomWinState: TFormState;

    procedure CMChanged(var Message: TCMChanged); message CM_CHANGED;
    procedure Loaded; override;

    property CustomOwner: TcrCustomBase read FCustomOwner;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent;
      ACustomOwner: TcrCustomBase); reintroduce; overload; virtual;

    property Modified: boolean read FModified;
    property OnChanged: TChangedEventNotify read FOnChanged write FOnChanged;
  end;

var
  frmCustomWin: TfrmCustomWin;

implementation

{$R *.dfm}

{ TfrmCustomWin }

procedure TfrmCustomWin.CMChanged(var Message: TCMChanged);
begin
  inherited;
  if not (fsCreating in FCustomWinState) then
  begin
    FModified := not boolean(Message.Unused);
    if Assigned(FOnChanged) then
      FOnChanged(Message.Child);
  end;
end;

constructor TfrmCustomWin.Create(AOwner: TComponent; ACustomOwner: TcrCustomBase);
begin
  Include(FCustomWinState, fsCreating);
  FCustomOwner := ACustomOwner;
  Create(AOwner);
end;

constructor TfrmCustomWin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmCustomWin.FormShow(Sender: TObject);
begin
  Exclude(FCustomWinState, fsCreating);
end;

procedure TfrmCustomWin.Loaded;
begin
  Include(FCustomWinState, fsCreating);
  inherited;
end;

end.
