unit DataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WindowDefault, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Model.crCustomBase, Model.crCustomListObject, Model.crCustomDB;

type
  TDataBase = class(TcrCustomBase)
  private
    FDataBase: TcrCustomDB;
    FDataBaseName: string;

    function GetOnModalResultOk: TChangeKeyNotityEvent;
    procedure SetOnModalResultOk(const Value: TChangeKeyNotityEvent);
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    function Execute: boolean;

    property DataBase: TcrCustomDB read FDataBase;
    property DataBaseName: string read FDataBaseName write FDataBaseName;
    property OnModalResultOk: TChangeKeyNotityEvent read GetOnModalResultOk write SetOnModalResultOk;
  end;

  TfrmDataBase = class(TfrmWinDefault)
    btnCancel: TBitBtn;
    lblName: TLabel;
    Label1: TLabel;
    edtName: TEdit;
    edtSecName: TEdit;
    btnConfirm: TBitBtn;
    procedure edtNameChange(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
  private
    { Private declarations }
    FTextEdit: TCaption;

    function DBOwner: TDataBase;
    procedure DoInternalUpdate;
    procedure SetDataBase;
  protected
    procedure SetCaption; override;
  public
    { Public declarations }
  end;

var
  frmDataBase: TfrmDataBase;

implementation

const
  CS_CAPTION = 'Banco de dados';

{$R *.dfm}

{ TDataBase }

constructor TDataBase.Create(AOwner: TObject);
begin
  FDataBase := TcrCustomDB(AOwner);
  inherited Create(Self);
  frmDataBase := TfrmDataBase.Create(Application, Self);
end;

destructor TDataBase.Destroy;
begin
  FreeAndNil(frmDataBase);
  inherited;
end;

function TDataBase.Execute: boolean;
begin
  Result := frmDataBase.ShowModal = mrOk;
end;

function TDataBase.GetOnModalResultOk: TChangeKeyNotityEvent;
begin
  Result := frmDataBase.OnModalResultOk;
end;

procedure TDataBase.SetOnModalResultOk(const Value: TChangeKeyNotityEvent);
begin
  frmDataBase.OnModalResultOk := Value;
end;

{ TfrmDataBase }

procedure TfrmDataBase.btnConfirmClick(Sender: TObject);
begin
  try
    DoInternalUpdate;
    ModalResult := mrOk;
  except
    on E: Exception do
      Application.MessageBox(PWChar(E.Message),
        'Falha banco de dados...', MB_ICONERROR);
  end;
end;

function TfrmDataBase.DBOwner: TDataBase;
begin
  Result := TDataBase(CustomOwner);
end;

procedure TfrmDataBase.DoInternalUpdate;
begin
  if Assigned(OnModalResultOk) then
    OnModalResultOk(edtName.Text, DBOwner.DataBase.Name);

  DBOwner.DataBase.Name       := edtName.Text;
  DBOwner.DataBase.ParamValue := edtSecName.Text;
end;

procedure TfrmDataBase.edtNameChange(Sender: TObject);
var
  changeValue: boolean;
begin
  changeValue := (FTextEdit = edtSecName.Text) or string(edtSecName.Text).IsEmpty;
  if changeValue then
    edtSecName.Text := edtName.Text;
  FTextEdit := edtName.Text;
end;

procedure TfrmDataBase.edtNameEnter(Sender: TObject);
begin
  FTextEdit := edtName.Text;
end;

procedure TfrmDataBase.FormCreate(Sender: TObject);
begin
  SetDataBase;
  ActiveControl := edtName;
  inherited;
end;

procedure TfrmDataBase.SetCaption;
begin
  if DBOwner.DataBaseName.IsEmpty then
    Caption := CS_CAPTION
  else Caption := Format('%s [%s]', [CS_CAPTION, DBOwner.DataBaseName]);
end;

procedure TfrmDataBase.SetDataBase;
begin
  if DBOwner = nil then
    Exit;

  edtName.Text    := DBOwner.DataBase.Name;
  edtSecName.Text := DBOwner.DataBase.ParamValue;
end;

end.
