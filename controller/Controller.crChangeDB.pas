unit Controller.crChangeDB;

interface

uses
  Vcl.Forms, Winapi.Windows, System.SysUtils, System.StrUtils, System.Classes, SystemUtils,
  Model.crCustomObject, Model.crCustomFileCfg, Model.crCustomAppReg, Model.crCustomServer,
  Model.crCustomDataBase, Model.crCustomListObject, Model.crCustomListDB, Controller.crListServers,
  Controller.crFileMult, Controller.crFileServer, Controller.crFileZeos, Model.crCustomBase;

type
  TcrChangeDB = class(TComponent)
  private
    FFileMult: TcrFileMult;
    FFileServer: TcrFileServer;
    FFileZeos: TcrFileZeos;
    FListServers: TcrListServers;
    FServer: TcrCustomServer;
    FServerName: string;
    FOnLoadNotifyEvent: TServerNotifyEvent;
    FOnBeforeApply: TObjectNotifyEvent;
    
    procedure DoRead(ARegistry: TcrCustomAppReg);
    procedure DoWrite(ARegistry: TcrCustomAppReg);
    function GetActiveServer: string;
    function GetChangeFile: TFileNameNotifyEvent;
    function GetForm: TForm;
    function GetOnAfterAddServer: TAddNotifyEvent<TcrCustomServer>;
    function GetOnAfterRemoveDataBase: TRemoveNotityEvent;
    function GetOnAfterRemoveServer: TRemoveNotityEvent;
    function GetRootKey: HWND;
    function GetSection: string;
    procedure InitializeServer(AServerName: string);
    function IsFormOwner: boolean;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure SaveSettingsWindow;
    procedure SetChangeFile(const Value: TFileNameNotifyEvent);
    procedure SetOnAfterAddServer(const Value: TAddNotifyEvent<TcrCustomServer>);
    procedure SetOnAfterRemoveServer(const Value: TRemoveNotityEvent);
    function WinPosStr: string;
    function GetOnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase>;
    procedure SetOnAfterRemoveDataBase(const Value: TRemoveNotityEvent);
    procedure SetOnAfterAddDataBase(const Value: TAddNotifyEvent<TcrCustomDataBase>);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Apply;
    procedure LoadServerInf(AServerName: string);
    procedure RemoveServer(AServerName: string);
    procedure SetListServer(AList: TStrings);

    property ActiveServer: string read GetActiveServer;
    property FileMult: TcrFileMult read FFileMult;
    property FileServer: TcrFileServer read FFileServer;
    property FileZeos: TcrFileZeos read FFileZeos;
    property RootKey: HWND read GetRootKey;
    property Section: string read GetSection;
    property Server: TcrCustomServer read FServer;
    property OnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase> read GetOnAfterAddDataBase write SetOnAfterAddDataBase;
    property OnAfterAddServer: TAddNotifyEvent<TcrCustomServer> read GetOnAfterAddServer write SetOnAfterAddServer;
    property OnAfterRemoveDataBase: TRemoveNotityEvent read GetOnAfterRemoveDataBase write SetOnAfterRemoveDataBase;
    property OnAfterRemoveServer: TRemoveNotityEvent read GetOnAfterRemoveServer write SetOnAfterRemoveServer;
    property OnBeforeApply: TObjectNotifyEvent read FOnBeforeApply write FOnBeforeApply;
    property OnChangeFileMult: TFileNameNotifyEvent read GetChangeFile write SetChangeFile;
    property OnLoadServer: TServerNotifyEvent read FOnLoadNotifyEvent write FOnLoadNotifyEvent;
  end;

implementation

const
  CS_KEY = 'General';
  CS_WINPOS = 'WinPos';

{ TcrChangeDB }

procedure TcrChangeDB.Apply;
begin
  if Assigned(FOnBeforeApply) then
    FOnBeforeApply(Self);
    
  FFileMult.Apply;
  FListServers.Apply(FServer);
  FFileServer.Apply(GetActiveServer);
  FFileZeos.Apply(FServer);
  SaveSettings;
end;

constructor TcrChangeDB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListServers := TcrListServers.Create(Self);
  FFileMult    := TcrFileMult.Create(Self);
  FFileServer  := TcrFileServer.Create(Self);
  FFileZeos    := TcrFileZeos.Create(Self);

  LoadSettings;
end;

destructor TcrChangeDB.Destroy;
begin
  SaveSettingsWindow;
  FreeAndNil(FServer);
  FreeAndNil(FListServers);
  inherited;
end;

procedure TcrChangeDB.DoRead(ARegistry: TcrCustomAppReg);
const
  Delims = [',',' '];

  procedure SetInternalWindowPlacement(AWinPos: string);
  var
    wp: TWindowPlacement;
  begin
    if not IsFormOwner then
      Exit;

    wp.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(GetForm.Handle, @wp);

    if EqualRect(wp.rcNormalPosition, GetForm.BoundsRect) and
      (AWinPos <> EmptyStr) then
    begin
      wp.rcNormalPosition.Left   := StrToIntDef(ExtractWord(1, AWinPos, Delims), GetForm.Left);
      wp.rcNormalPosition.Top    := StrToIntDef(ExtractWord(2, AWinPos, Delims), GetForm.Top);
      wp.rcNormalPosition.Right  := StrToIntDef(ExtractWord(3, AWinPos, Delims), GetForm.Left + GetForm.Width);
      wp.rcNormalPosition.Bottom := StrToIntDef(ExtractWord(4, AWinPos, Delims), GetForm.Top + GetForm.Height);

      SetWindowPlacement(GetForm.Handle, @wp);
    end;
  end;

begin
  SetInternalWindowPlacement(ARegistry.ReadString(WinPosStr, ''));
  FFileMult.FileName   := ARegistry.ReadString('FileMult', '');
  FFileServer.FileName := ARegistry.ReadString('FileServer', '');
  FFileZeos.FileName   := ARegistry.ReadString('FileZeos', '');
  InitializeServer(ARegistry.ReadString('ActiveServer', ''));
end;

procedure TcrChangeDB.DoWrite(ARegistry: TcrCustomAppReg);
begin
  ARegistry.WriteString('ActiveServer', ActiveServer);
  ARegistry.WriteString('FileMult', FFileMult.FileName);
  ARegistry.WriteString('FileServer', FFileServer.FileName);
  ARegistry.WriteString('FileZeos', FFileZeos.FileName);
end;

function TcrChangeDB.GetForm: TForm;
begin
  if Owner is TForm then
    Result := TForm(Owner)
  else Result := nil;
end;

function TcrChangeDB.GetOnAfterAddDataBase: TAddNotifyEvent<TcrCustomDataBase>;
begin
  Result := FListServers.OnAfterAddDataBase;
end;

function TcrChangeDB.GetOnAfterAddServer: TAddNotifyEvent<TcrCustomServer>;
begin
  Result := FListServers.OnAfterAdd;
end;

function TcrChangeDB.GetOnAfterRemoveDataBase: TRemoveNotityEvent;
begin
  Result := FListServers.OnAfterRemoveDataBase;
end;

function TcrChangeDB.GetOnAfterRemoveServer: TRemoveNotityEvent;
begin
  Result := FListServers.OnAfterRemove;
end;

procedure TcrChangeDB.LoadServerInf(AServerName: string);

  procedure InternalLoadServer;
  var
    server: TcrCustomServer;
  begin
    server := FListServers.Items[AServerName];
    try
      if not Assigned(server) then
        server := FListServers.New(AServerName);

    finally
      FServer := server;
    end;
  end;

begin
  try
    if AServerName <> FServerName then
    begin
      FServerName := AServerName;
      InternalLoadServer;
    end;
  finally
    if Assigned(FOnLoadNotifyEvent) then
      FOnLoadNotifyEvent(AServerName, FServer);
  end;
end;

procedure TcrChangeDB.LoadSettings;
var
  reg: TcrCustomAppReg;
begin
  reg := TcrCustomAppReg.Create(GetRootKey, GetSection);
  try
    DoRead(reg);
  finally
    reg.Free;
  end;
end;

procedure TcrChangeDB.RemoveServer(AServerName: string);
begin
  FListServers.Remove(AServerName);
  FServer := nil;
end;

function TcrChangeDB.GetActiveServer: string;
begin
  if FServer = nil then
    Result := ''
  else Result := FServer.Name;
end;

function TcrChangeDB.GetChangeFile: TFileNameNotifyEvent;
begin
  Result := FFileMult.OnFileNameChange;
end;

function TcrChangeDB.GetRootKey: HWND;
begin
  Result := HKEY_CURRENT_USER;
end;

function TcrChangeDB.GetSection: string;
begin
  Result := Format('Software\%s\%s', [ExtractFileName(ChangeFileExt(Application.ExeName, '')), CS_KEY]);
end;

procedure TcrChangeDB.InitializeServer(AServerName: string);
begin
  FServer     := FListServers.Items[AServerName];
  FServerName := ActiveServer;
end;

function TcrChangeDB.IsFormOwner: boolean;
begin
  Result := Assigned(Owner) and (Owner is TForm);
end;

procedure TcrChangeDB.SaveSettings;
var
  reg: TcrCustomAppReg;
begin
  reg := TcrCustomAppReg.Create(GetRootKey, GetSection);
  try
    DoWrite(reg);
  finally
    reg.Free;
  end;
end;

procedure TcrChangeDB.SaveSettingsWindow;

  procedure WriteWindowPostion(ARegistry: TcrCustomAppReg);
  var
    wp: TWindowPlacement;
  begin
    if not IsFormOwner then
      Exit;
    wp.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(GetForm.Handle, @wp);

    ARegistry.WriteString(WinPosStr,
      Format('%d,%d,%d,%d', [wp.rcNormalPosition.Left,
                             wp.rcNormalPosition.Top,
                             wp.rcNormalPosition.Right,
                             wp.rcNormalPosition.Bottom]));
  end;

var
  reg: TcrCustomAppReg;
begin
  reg := TcrCustomAppReg.Create(GetRootKey, GetSection);
  try
    WriteWindowPostion(reg);
  finally
    reg.Free;
  end;
end;

procedure TcrChangeDB.SetChangeFile(const Value: TFileNameNotifyEvent);
begin
  FFileMult.OnFileNameChange := Value;
end;

procedure TcrChangeDB.SetListServer(AList: TStrings);
begin
  FListServers.ToStrings(AList);
end;

procedure TcrChangeDB.SetOnAfterAddDataBase(const Value: TAddNotifyEvent<TcrCustomDataBase>);
begin
  FListServers.OnAfterAddDataBase := Value;
end;

procedure TcrChangeDB.SetOnAfterAddServer(const Value: TAddNotifyEvent<TcrCustomServer>);
begin
  FListServers.OnAfterAdd := Value;
end;

procedure TcrChangeDB.SetOnAfterRemoveDataBase(const Value: TRemoveNotityEvent);
begin
  FListServers.OnAfterRemoveDataBase := Value;
end;

procedure TcrChangeDB.SetOnAfterRemoveServer(const Value: TRemoveNotityEvent);
begin
  FListServers.OnAfterRemove := Value;
end;

function TcrChangeDB.WinPosStr: string;
begin
  Result := Format('%s(%dx%d)', [CS_WINPOS, Screen.Width, Screen.Height]);
end;

end.
