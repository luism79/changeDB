unit Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, Vcl.StdCtrls, cxCheckBox, dxToggleSwitch, Vcl.WinXCtrls,
  Controller.crChangeDB, Model.crCustomBase, Model.crCustomFileCfg, CustomWindow;

type
  TFilteType = record
    Text: string;
    Filter: string;
  end;

  TfrmSettings = class(TfrmCustomWin)
    pgcSettings: TPageControl;
    tbsDefault: TTabSheet;
    lblPathZeos: TLabel;
    edtPathFileZeos: TcxButtonEdit;
    lblPathServer: TLabel;
    edtPathFileServer: TcxButtonEdit;
    dlgFileName: TOpenDialog;
    grpDirectories: TGroupBox;
    //****************************************
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFileServerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure edtPathFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Changed(AControl: TControl);
    function ChangeDB: TcrChangeDB;
    procedure DisableEditCtrls(AEnabled: boolean);
    procedure LoadDataPathFiles;
    procedure SetTabVisible(AVisible: boolean);
    procedure SetFileName(AObjectFile: TcrCustomFileCfg; const AFileName: string);
    procedure ShowDialog(AEdit: TcxButtonEdit; var AParam: TFilteType);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      ACustomOwner: TcrCustomBase); override;

    property Modified;
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

procedure TfrmSettings.Changed(AControl: TControl);

  function GetObjectFile: TcrCustomFileCfg;
  begin
    Result := nil;
    if Assigned(AControl) then
    begin
      if AControl.Parent = edtPathFileServer then
        Result := ChangeDB.FileServer
      else if AControl.Parent = edtPathFileZeos then
        Result := ChangeDB.FileZeos;
    end;
  end;

begin
  if Assigned(AControl) and (ChangeDB <> nil) then
    SetFileName(GetObjectFile, TEdit(AControl).Text);
end;

function TfrmSettings.ChangeDB: TcrChangeDB;
begin
  Result := TcrChangeDB(CustomOwner);
end;

constructor TfrmSettings.Create(AOwner: TComponent; ACustomOwner: TcrCustomBase);
begin
  inherited Create(AOwner, ACustomOwner);
  DisableEditCtrls(ChangeDB <> nil);
  LoadDataPathFiles;
end;

procedure TfrmSettings.DisableEditCtrls(AEnabled: boolean);
var
  i: integer;
begin
  for i := 0 to tbsDefault.ControlCount - 1 do
    tbsDefault.Controls[i].Enabled := AEnabled;
end;

procedure TfrmSettings.edtFileServerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  ft: TFilteType;
begin
  ft.Text   := 'Server Name';
  ft.Filter := '*.bde';
  ShowDialog(edtPathFileServer, ft);
end;

procedure TfrmSettings.edtPathFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  ft: TFilteType;
begin
  ft.Text   := 'Arquivo Zeos';
  ft.Filter := '*.zeos';
  ShowDialog(edtPathFileZeos, ft);
end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetFileName(ChangeDB.FileServer, edtPathFileServer.Text);
  SetFileName(ChangeDB.FileZeos, edtPathFileZeos.Text);
  inherited;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  inherited;
  SetTabVisible(false);
  pgcSettings.ActivePageIndex := 0;
  ActiveControl := edtPathFileServer;
end;

procedure TfrmSettings.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  inherited;
  OnChanged := Changed;
end;

procedure TfrmSettings.LoadDataPathFiles;
begin
  if ChangeDB = nil then
    Exit;

  edtPathFileServer.Text := ChangeDB.FileServer.FileName;
  edtPathFileZeos.Text   := ChangeDB.FileZeos.FileName;
end;

procedure TfrmSettings.SetFileName(AObjectFile: TcrCustomFileCfg; const AFileName: string);
begin
  if not Assigned(AObjectFile) then
    Exit;

  if AObjectFile.FileName <> AFileName then
    AObjectFile.FileName := AFileName;
end;

procedure TfrmSettings.SetTabVisible(AVisible: boolean);
var
  i: integer;
begin
  for I := 0 to pgcSettings.PageCount -1 do
    pgcSettings.Pages[i].TabVisible := AVisible;
end;

procedure TfrmSettings.ShowDialog(AEdit: TcxButtonEdit; var AParam: TFilteType);
begin
  dlgFileName.InitialDir := AEdit.Text;
  dlgFileName.Filter     := Format('%s|%s', [AParam.Text, AParam.Filter]);
  if dlgFileName.Execute then
    AEdit.Text := dlgFileName.FileName;
end;

end.
