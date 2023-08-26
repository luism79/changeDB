unit DataBaseSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus, WindowDefault,
  Model.crCustomObject, Model.crCustomDB, Model.crCustomDataBase, Model.crCustomListObject,
  Model.crCustomBase, Helper.PersistentMain, Helper.PersistentCtrl, System.Math;

type
  TDataBaseSettings = class(TcrCustomBase)
  private
    FDataBase: TcrCustomDataBase;
    FRefDB: TcrCustomDataBase;
    FServerName: string;
    function GetDataBase: TcrCustomDataBase;
    function GetOnModalResultOk: TChangeKeyNotityEvent;
    procedure SetOnModalResultOk(const Value: TChangeKeyNotityEvent);
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    function Execute: boolean;

    property DataBase: TcrCustomDataBase read GetDataBase;
    property ServerName: string read FServerName write FServerName;
    property OnModalResultOk: TChangeKeyNotityEvent read GetOnModalResultOk write SetOnModalResultOk;
  end;

  TfrmDataBaseSettings = class(TfrmWinDefault)
    grpDataBase: TGroupBox;
    edtDataBase: TEdit;
    grpDBCon: TGroupBox;
    Panel1: TPanel;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    lstDBCon: TListBox;
    btnConfirm: TBitBtn;
    btnCancel: TBitBtn;
    btnEdit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure lstDBConClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDataBaseCtrl: TPersistentMain;

    procedure AddDataBase(AObject: TcrCustomObject;
      const Action: TListItemNotification);
    procedure AfterRemoveDataBase(const AKey: string);
    procedure DataBaseCtrl;
    function DataBaseSelected: string;
    function DBSettingsObject: TDataBaseSettings;
    procedure DoInternalUpdate;
    procedure DoRemove(const AIndex: integer);
    procedure SetDataBase;
    procedure SetRemoveEnabled(const AIndex: Integer);
    procedure ExecDataBase(ADataBase: TcrCustomDB; const Action: TListItemNotification);
  protected
    procedure SetCaption; override;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent;
      ACustomOwner: TcrCustomBase); override;
  end;

var
  frmDataBaseSettings: TfrmDataBaseSettings;

implementation

uses
  DataBase, Helper.ConstMsg;

const
  CS_CAPTION = 'Banco de Dados';

{$R *.dfm}

{ TDataBaseSettings }

constructor TDataBaseSettings.Create(AOwner: TObject);
begin
  FRefDB    := TcrCustomDataBase(AOwner);
  FDataBase := TcrCustomDataBase.Create(Self);
  FRefDB.Assing(FDataBase);

  inherited Create(AOwner);

  frmDataBaseSettings := TfrmDataBaseSettings.Create(Application, Self);
end;

destructor TDataBaseSettings.Destroy;
begin
  FreeAndNil(frmDataBaseSettings);
  inherited;
end;

function TDataBaseSettings.Execute: boolean;
begin
  Result := frmDataBaseSettings.ShowModal = mrOk;
  if Result then
  begin
    FRefDB.ItemsDBCon.Clear;
    FDataBase.Assing(FRefDB);
  end;
end;

function TDataBaseSettings.GetDataBase: TcrCustomDataBase;
begin
  Result := FDataBase;
end;

function TDataBaseSettings.GetOnModalResultOk: TChangeKeyNotityEvent;
begin
  Result := frmDataBaseSettings.OnModalResultOk;
end;

procedure TDataBaseSettings.SetOnModalResultOk(const Value: TChangeKeyNotityEvent);
begin
  frmDataBaseSettings.OnModalResultOk := Value;
end;

{ TfrmDataBaseSettings }

procedure TfrmDataBaseSettings.AddDataBase(AObject: TcrCustomObject;
  const Action: TListItemNotification);
begin
  if not Assigned(AObject) then
    Exit;

  if Action = crAdded then
    lstDBCon.ItemIndex := lstDBCon.Items.Add(AObject.Name)
  else lstDBCon.Items.Strings[lstDBCon.ItemIndex] := AObject.Name
end;

procedure TfrmDataBaseSettings.AfterRemoveDataBase(const AKey: string);
var
  Index: Integer;
begin
  Index := lstDBCon.Items.IndexOf(AKey);
  lstDBCon.Items.Delete(Index);
  Dec(Index);
  Index := Max(Index, lstDBCon.Count - 1);
  SetRemoveEnabled(SendMessage(lstDBCon.Handle, LB_SETCURSEL, Index, 0));
end;

procedure TfrmDataBaseSettings.btnAddClick(Sender: TObject);
begin
  ExecDataBase(DBSettingsObject.DataBase.ItemsDBCon.New, crAdded);
end;

procedure TfrmDataBaseSettings.btnConfirmClick(Sender: TObject);
begin
  try
    DoInternalUpdate;
    ModalResult := mrOk;
  except
    on E: Exception do
    begin
      Application.MessageBox(PWchar(E.Message),
        'Falha banco de dados...', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmDataBaseSettings.btnEditClick(Sender: TObject);
begin
  if lstDBCon.ItemIndex = -1 then
    Exit;

  ExecDataBase(DBSettingsObject.DataBase.ItemsDBCon.Items[DataBaseSelected], crChanged);
end;

procedure TfrmDataBaseSettings.btnRemoveClick(Sender: TObject);
var
  delete: boolean;
begin
  delete := Application.MessageBox(PWChar(Format(SDeleteDataBase, [DataBaseSelected])),
    'Confirmar...', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes;

  if delete then
    DoRemove(lstDBCon.ItemIndex);
end;

constructor TfrmDataBaseSettings.Create(AOwner: TComponent;
  ACustomOwner: TcrCustomBase);
begin
  inherited Create(AOwner, ACustomOwner);

  SetDataBase;
  DBSettingsObject.DataBase.OnAfterAddDBCon    := AddDataBase;
  DBSettingsObject.DataBase.OnAfterRemoveDBCon := AfterRemoveDataBase;
end;

procedure TfrmDataBaseSettings.DataBaseCtrl;
begin
  FDataBaseCtrl := TPersistentMain.Create(Self);
  FDataBaseCtrl.AddCtrl(btnAdd, 'Ctrl+Ins');
  FDataBaseCtrl.AddCtrl(btnEdit, 'Ctrl+Enter');
  FDataBaseCtrl.AddCtrl(btnRemove, 'Ctrl+Del');
end;

function TfrmDataBaseSettings.DataBaseSelected: string;
begin
  if lstDBCon.ItemIndex <> -1 then
    Result := lstDBCon.Items[lstDBCon.ItemIndex]
  else Result := '';
end;

function TfrmDataBaseSettings.DBSettingsObject: TDataBaseSettings;
begin
  Result := TDataBaseSettings(CustomOwner);
end;

procedure TfrmDataBaseSettings.DoInternalUpdate;
begin
  if Assigned(OnModalResultOk) then
    OnModalResultOk(edtDataBase.Text, DBSettingsObject.DataBase.Name);

  DBSettingsObject.DataBase.Name := edtDataBase.Text;
end;

procedure TfrmDataBaseSettings.DoRemove(const AIndex: integer);
begin
  if AIndex = -1 then
    Exit;

  DBSettingsObject.DataBase.ItemsDBCon.Remove(DataBaseSelected);
end;

procedure TfrmDataBaseSettings.ExecDataBase(ADataBase: TcrCustomDB;
  const Action: TListItemNotification);
var
  db: TDataBase;
  addDB: boolean;
begin
  db := TDataBase.Create(ADataBase);
  try
    db.DataBaseName := DBSettingsObject.GetDataBase.Name;
    addDB           := db.Execute;
    if addDB then
      DBSettingsObject.DataBase.ItemsDBCon.Add(db.DataBase.Name, db.DataBase)
    else if Action = crAdded then
      FreeAndNil(ADataBase);
  finally
    db.Free;
  end;
end;

procedure TfrmDataBaseSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FDataBaseCtrl);
  inherited;
end;

procedure TfrmDataBaseSettings.FormCreate(Sender: TObject);
begin
  inherited;

  SetRemoveEnabled(SendMessage(lstDBCon.Handle, LB_SETCURSEL, 0, 0));
  DataBaseCtrl;
end;

procedure TfrmDataBaseSettings.lstDBConClick(Sender: TObject);
begin
  SetRemoveEnabled(lstDBCon.ItemIndex);
end;

procedure TfrmDataBaseSettings.SetCaption;
begin
  if DBSettingsObject.ServerName.IsEmpty then
    Caption := CS_CAPTION
  else Caption := Format('%s [%s]', [CS_CAPTION, DBSettingsObject.ServerName]);
end;

procedure TfrmDataBaseSettings.SetDataBase;
begin
  if not Assigned(DBSettingsObject.DataBase) then
    Exit;

  edtDataBase.Text := DBSettingsObject.DataBase.Name;
  DBSettingsObject.DataBase.ItemsDBCon.ToStrings(lstDBCon.Items);
end;

procedure TfrmDataBaseSettings.SetRemoveEnabled(const AIndex: Integer);
begin
  btnEdit.Enabled   := (AIndex > -1);
  btnRemove.Enabled := (AIndex > -1);
end;

end.
