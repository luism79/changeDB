unit WindowDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, CustomWindow, Model.crCustomBase,
  Model.crCustomListObject;

type
  TfrmWinDefault = class(TfrmCustomWin)
    pnlFooter: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOnModalResultOk: TChangeKeyNotityEvent;
  protected
    procedure SetCaption; virtual;
    property CustomOwner;
  public
    { Public declarations }

    property OnModalResultOk: TChangeKeyNotityEvent read FOnModalResultOk write FOnModalResultOk;
  end;

var
  frmWinDefault: TfrmWinDefault;

implementation

{$R *.dfm}

{ TfrmWinDefault }

procedure TfrmWinDefault.SetCaption;
begin

end;

procedure TfrmWinDefault.FormShow(Sender: TObject);
begin
  inherited;
  SetCaption;
end;

end.
