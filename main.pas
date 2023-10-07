unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Vcl.StdCtrls, Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.Buttons, System.Math,
  Vcl.Menus, cxButtons, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  WindowDefault, Controller.crChangeDB, Model.crCustomBase,
  Model.crCustomObject, Model.crCustomDataBase, Model.crCustomListObject,
  Model.crCustomServer, Helper.PersistentMain;

type
  TfrmMain = class(TfrmWinDefault)
    grpMult: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Drive1: TDriveComboBox;
    Drive2: TDriveComboBox;
    grpServer: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbDataBase: TComboBox;
    cbServer: TComboBox;
    edtAppName: TEdit;
    btnOk: TBitBtn;
    btnApply: TBitBtn;
    edtPathFile: TcxButtonEdit;
    Label4: TLabel;
    ilMain: TImageList;
    dlgFileName: TOpenDialog;
    btnSettings: TcxButton;
    btnAddDB: TSpeedButton;
    pnlDataBase: TPanel;
    edtPassWord: TEdit;
    ActionManager1: TActionManager;
    actDataBaseAdd: TAction;
    actDataBaseEdit: TAction;
    actDataBaseRemove: TAction;
    btnEditDB: TSpeedButton;
    btnDelDB: TSpeedButton;
    pnlServer: TPanel;
    btnDelServer: TSpeedButton;
    actServerRemove: TAction;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPathFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure edtPathFilePropertiesEditValueChanged(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure cbServerExit(Sender: TObject);
    procedure actDataBaseRemoveExecute(Sender: TObject);
    procedure actDataBaseEditExecute(Sender: TObject);
    procedure actDataBaseAddExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actServerRemoveExecute(Sender: TObject);
  private
    { Private declarations }
    FChangeDB: TcrChangeDB;
    FServerCtrl: TPersistentMain;
    FDataBaseCtrl: TPersistentMain;

    procedure AddCtrlPersistet;
    procedure AddEditDataBase(ADataBase: TcrCustomDataBase;
      const Action: TListItemNotification);
    procedure AfterAddDataBase(AObject: TcrCustomObject; const Action: TListItemNotification);
    procedure AfterRemoveDataBase(const AKey: string);
    procedure AfterAddServer(AObject: TcrCustomObject; const Action: TListItemNotification);
    procedure AfterRemoveServer(const AKey: string);
    procedure Apply;
    procedure BeforeApply(AObject: TObject);
    procedure ChangeFileMult(AObject: TcrCustomBase;
      const AFileName: string);
    procedure Changed(AControl: TControl);
    procedure LoadServerInf(const AServerName: string; AObject: TcrCustomObject);
    procedure RemoveItemComboBox(AComboBox: TComboBox; const AIndex: Integer);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Settings, DataBaseSettings, Helper.PersistentCtrl, Helper.ConstMsg;

procedure TfrmMain.actDataBaseAddExecute(Sender: TObject);

  function CreateNewDataBase: TcrCustomDataBase;
  begin
    Result := FChangeDB.Server.ItemsDataBases.New;
  end;

begin
  AddEditDataBase(CreateNewDataBase, crAdded);
  cbDataBase.SelectAll;
end;

procedure TfrmMain.actDataBaseRemoveExecute(Sender: TObject);
var
  delete: boolean;
begin
  FocusControl(cbDataBase);
  delete := Application.MessageBox(PWchar(Format(SDeleteDataBase, [cbDataBase.Text])),
    'Confirmar...', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes;

  if delete then
  begin
    FChangeDB.Server.ItemsDataBases.Remove(cbDataBase.Text);
    Perform(CM_CHANGED, 0, Winapi.Windows.LPARAM(cbDataBase));
  end;
end;

procedure TfrmMain.actDataBaseEditExecute(Sender: TObject);

  function GetDataBase: TcrCustomDataBase;
  begin
    Result := FChangeDB.Server.ItemsDataBases.Items[cbDataBase.Text];
  end;

begin
  AddEditDataBase(GetDataBase, crChanged);
  cbDataBase.SelectAll;
end;

procedure TfrmMain.ActionManager1Update(Action: TBasicAction; var Handled: Boolean);

  procedure SetEnbledCtrlServer;
  begin
    actServerRemove.Enabled := Assigned(FChangeDB) and
                               (cbServer.Items.Count > 0) and
                               (cbServer.Text <> '');
  end;

  procedure SetEnabledCtrlDB;
  begin
    actDataBaseAdd.Enabled    := Assigned(FChangeDB) and
                                 (cbServer.Text <> '');
    actDataBaseEdit.Enabled   := actDataBaseAdd.Enabled and
                                 (cbDataBase.Text <> '');
    actDataBaseRemove.Enabled := actDataBaseAdd.Enabled and
                                 (cbDataBase.Items.Count > 0) and
                                 (cbDataBase.Text <> '');
  end;

begin
  SetEnbledCtrlServer;
  SetEnabledCtrlDB;
end;

procedure TfrmMain.actServerRemoveExecute(Sender: TObject);
var
  delete: boolean;
begin
  FocusControl(cbServer);
  delete := Application.MessageBox(PWChar(Format(SDeleteServer, [cbServer.Text])),
    'Confirmar...', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes;

  if delete then
  begin
    FChangeDB.RemoveServer(cbServer.Text);
    LoadServerInf(FChangeDB.ActiveServer, FChangeDB.Server);
  end;
end;

procedure TfrmMain.AddCtrlPersistet;

  procedure ServerCtrl;
  begin
    FServerCtrl := TPersistentMain.Create(Self, cbServer);
    FServerCtrl.AddCtrl(btnDelServer, 'Ctrl+Del');
  end;

  procedure DataBaseCtrl;
  begin
    FDataBaseCtrl := TPersistentMain.Create(Self, cbDataBase);
    FDataBaseCtrl.AddCtrl(btnAddDB, 'Ctrl+Ins');
    FDataBaseCtrl.AddCtrl(btnEditDB, 'Ctrl+Enter');
    FDataBaseCtrl.AddCtrl(btnDelDB, 'Ctrl+Del');
  end;

begin
  ServerCtrl;
  DataBaseCtrl;
end;

procedure TfrmMain.AddEditDataBase(ADataBase: TcrCustomDataBase;
  const Action: TListItemNotification);
var
  dbSettings: TDataBaseSettings;
begin
  FocusControl(cbDataBase);
  dbSettings := TDataBaseSettings.Create(ADataBase);
  try
    dbSettings.ServerName := FChangeDB.ActiveServer;
    if dbSettings.Execute then
    begin
      FChangeDB.Server.ItemsDataBases.Add(ADataBase);
      Perform(CM_CHANGED, 0, Winapi.Windows.LPARAM(cbDataBase));
    end
    else if Action = crAdded then
      FreeAndNil(ADataBase);
  finally
    FreeAndNil(dbSettings);
  end;
end;

procedure TfrmMain.AfterAddDataBase(AObject: TcrCustomObject;
  const Action: TListItemNotification);
var
  Index: Integer;
begin
  if Action <> crNone then
  begin
    if Action = crChanged then
    begin
      Index := cbDataBase.Items.IndexOf(cbDataBase.Text);
      cbDataBase.Items.Strings[Index] := FChangeDB.Server.ItemDBName;
    end
    else cbDataBase.Items.Add(AObject.Name);

    cbDataBase.Text := FChangeDB.Server.ItemDBName;
  end;
end;

procedure TfrmMain.AfterAddServer(AObject: TcrCustomObject;
  const Action: TListItemNotification);
begin
  if Action <> crNone then
  begin
    if cbServer.Items.IndexOf(AObject.Name) = -1 then
      cbServer.Items.Add(AObject.Name);
  end;
end;

procedure TfrmMain.AfterRemoveDataBase(const AKey: string);
begin
  RemoveItemComboBox(cbDataBase, cbDataBase.Items.IndexOf(AKey));
end;

procedure TfrmMain.AfterRemoveServer(const AKey: string);
begin
  RemoveItemComboBox(cbServer, cbServer.Items.IndexOf(AKey));
end;

procedure TfrmMain.Apply;
begin
  if not btnApply.Enabled then
    Exit;

  try
    FChangeDB.Apply;
  except
    on E: Exception do
    begin
      Application.MessageBox(PWChar(E.Message),
        'Ocorreu uma falha na gravação...', MB_ICONERROR);
      Abort;
    end;
  end;
end;

procedure TfrmMain.BeforeApply(AObject: TObject);
begin
  if not Assigned(FChangeDB) then
    Exit;

  FChangeDB.FileMult.Drive1 := Drive1.Drive;
  FChangeDB.FileMult.Drive2 := Drive2.Drive;
  FChangeDB.Server.AppName  := edtAppName.Text;
  FChangeDB.Server.PassWord := edtPassWord.Text;
  FChangeDB.Server.SelectDataBase[cbDataBase.Text];
end;

procedure TfrmMain.btnApplyClick(Sender: TObject);
begin
  Apply;
  Perform(CM_CHANGED, 1, Winapi.Windows.LPARAM(btnApply));
end;

procedure TfrmMain.btnOkClick(Sender: TObject);
begin
  Apply;
  Close;
end;

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
  frmSettings := TfrmSettings.Create(Self, TcrCustomBase(FChangeDB));
  try
    frmSettings.ShowModal;
    if frmSettings.Modified then
      Perform(CM_CHANGED, 0, Winapi.Windows.LPARAM(Sender));
  finally
    FreeAndNil(frmSettings);
  end;
end;

procedure TfrmMain.cbServerExit(Sender: TObject);
begin
  if cbServer.Text <> FChangeDB.ActiveServer then
    FChangeDB.LoadServerInf(cbServer.Text);
end;

procedure TfrmMain.Changed(AControl: TControl);
begin
  btnApply.Enabled := Modified;
end;

procedure TfrmMain.ChangeFileMult(AObject: TcrCustomBase;
  const AFileName: string);
begin
  edtPathFile.Text := AFileName;
  Drive1.Drive     := FChangeDB.FileMult.Drive1;
  Drive2.Drive     := FChangeDB.FileMult.Drive2;
end;

procedure TfrmMain.edtPathFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  dlgFileName.InitialDir := edtPathFile.Text;
  if dlgFileName.Execute then
    edtPathFile.Text := dlgFileName.FileName;
end;

procedure TfrmMain.edtPathFilePropertiesEditValueChanged(Sender: TObject);
begin
  if FChangeDB.FileMult.FileName <> edtPathFile.Text then
    FChangeDB.FileMult.FileName := edtPathFile.Text;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FChangeDB);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  FChangeDB := TcrChangeDB.Create(Self);

  ChangeFileMult(nil, FChangeDB.FileMult.FileName);
  FChangeDB.SetListServer(cbServer.Items);
  LoadServerInf(FChangeDB.ActiveServer, FChangeDB.Server);

  FChangeDB.OnLoadServer          := LoadServerInf;
  FChangeDB.OnAfterAddServer      := AfterAddServer;
  FChangeDB.OnAfterRemoveServer   := AfterRemoveServer;
  FChangeDB.OnChangeFileMult      := ChangeFileMult;
  FChangeDB.OnAfterAddDataBase    := AfterAddDataBase;
  FChangeDB.OnAfterRemoveDataBase := AfterRemoveDataBase;
  FChangeDB.OnBeforeApply         := BeforeApply;
  ActiveControl                   := cbServer;

  AddCtrlPersistet;
end;

procedure TfrmMain.FormShow(Sender: TObject);

  procedure SettignsCombobox(AComboBox: TComboBox);
  var
    ctrl: TWinControl;
  begin
    ctrl := AComboBox.Parent;

    SetWindowRgn(AComboBox.Handle,
                 CreateRectRgn(2, 2, AComboBox.Width - 2,
                               AComboBox.Height - 2), True);
    if Assigned(ctrl) then
      SendMessage(AComboBox.Handle, CB_SETDROPPEDWIDTH, ctrl.Width, 0);
  end;

begin
  inherited;
  SettignsCombobox(cbServer);
  SettignsCombobox(cbDataBase);
  SendMessage(cbDataBase.Handle, CB_SETEDITSEL, -1, 0);

  OnChanged := Changed;
end;

procedure TfrmMain.LoadServerInf(const AServerName: string;
  AObject: TcrCustomObject);

  procedure resetServerInf;
  begin
    cbServer.Text := AServerName;
    edtAppName.Clear;
    edtPassWord.Clear;
    cbDataBase.Clear;
  end;

begin
  resetServerInf;
  if Assigned(AObject) then
  begin
    edtAppName.Text  := TcrCustomServer(AObject).AppName;
    edtPassWord.Text := TcrCustomServer(AObject).PassWord;
    TcrCustomServer(AObject).DataBaseToStrings(cbDataBase.Items);
    cbDataBase.Text := TcrCustomServer(AObject).ActiveDataBase
  end;
end;

procedure TfrmMain.RemoveItemComboBox(AComboBox: TComboBox; const AIndex: Integer);
begin
  AComboBox.Items.Delete(AIndex);
  AComboBox.Text := '';
end;

//procedure TfrmMain.StayOnTop(const AValue: boolean);
//const
//  HWND_STYLE: array[Boolean] of HWND = (HWND_NOTOPMOST, HWND_TOPMOST);
//
//begin
//  SetWindowPos(Handle, HWND_STYLE[AValue], 0, 0, 0, 0,
//    SWP_NOMOVE or SWP_NOSIZE or SWP_NOOWNERZORDER);
//end;

end.

