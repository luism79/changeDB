program ChangeDB;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  main in 'main.pas' {frmMain},
  SystemUtils in '..\..\..\_Components\SMComponents\source\Lib\SystemUtils.pas',
  Model.crCustomBase in 'model\Model.crCustomBase.pas',
  Model.crCustomObject in 'model\Model.crCustomObject.pas',
  Model.crCustomDB in 'model\Model.crCustomDB.pas',
  Model.crCustomListObject in 'model\Model.crCustomListObject.pas',
  Model.crCustomDataBase in 'model\Model.crCustomDataBase.pas',
  Model.crCustomListDB in 'model\Model.crCustomListDB.pas',
  Model.crCustomListDataBase in 'model\Model.crCustomListDataBase.pas',
  Model.crCustomServer in 'model\Model.crCustomServer.pas',
  Model.crCustomListServers in 'model\Model.crCustomListServers.pas',
  Model.crCustomFileCfg in 'model\Model.crCustomFileCfg.pas',
  Model.IAction in 'model\Interface\Model.IAction.pas',
  Model.IActionFileCfg in 'model\Interface\Model.IActionFileCfg.pas',
  Model.IRegistryAction in 'model\Interface\Model.IRegistryAction.pas',
  Model.crCustomAppReg in 'model\Registry\Model.crCustomAppReg.pas',
  Controller.crChangeDB in 'controller\Controller.crChangeDB.pas',
  Controller.crListServers in 'controller\Controller.crListServers.pas',
  Controller.crFileMult in 'controller\Controller.crFileMult.pas',
  Controller.crFileServer in 'controller\Controller.crFileServer.pas',
  Controller.crServer in 'controller\Controller.crServer.pas',
  Settings in 'Settings.pas' {frmSettings},
  DataBaseSettings in 'DataBaseSettings.pas' {frmDataBaseSettings},
  Controller.crFileZeos in 'controller\Controller.crFileZeos.pas',
  Model.IActionDataBase in 'model\Interface\Model.IActionDataBase.pas',
  WindowDefault in 'WinDefault\WindowDefault.pas' {frmWinDefault},
  DataBase in 'DataBase.pas' {frmDataBase},
  Helper.PersistentCtrl in 'helper\Helper.PersistentCtrl.pas',
  Helper.PersistentMain in 'helper\Helper.PersistentMain.pas',
  Helper.CustomPersistent in 'helper\Helper.CustomPersistent.pas',
  Helper.ConstMsg in 'helper\Helper.ConstMsg.pas',
  Model.IActionListObjects in 'model\Interface\Model.IActionListObjects.pas',
  CustomWindow in 'WinDefault\CustomWindow.pas' {frmCustomWin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
