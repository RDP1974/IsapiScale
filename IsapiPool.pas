unit IsapiPool;

// 7 jul 2025 Roberto Della Pasqua www.dellapasqua.com
// 11 jul 2025 added trap exception for disconnect, tested working

interface

uses
  Windows,
  Classes,
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

threadvar
  DBC: TFDConnection;
threadvar
  Q: TFDQuery;
threadvar
  Q2: TFDQuery; // so to permit nested queries dataset
threadvar
  ThInit: boolean;

type
  TConnRecover = class
   procedure Recover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
  end;

threadvar
  RetryC: TConnRecover;

procedure InitConn;

implementation

procedure InitPool;
var
  oParams: TStrings;
begin
  oParams := TStringList.Create;
  oParams.Add('DriverID=MYSQL');
  oParams.Add('Password=1234');
  oParams.Add('User_Name=db');
  oParams.Add('Server=localhost');
  oParams.Add('Database=world');
  oParams.Add('Pooled=True');
  oParams.Add('Compress=False');
  oParams.Add('UseSSL=False');
  oParams.Add('POOL_CleanupTimeout=3600'); //36000000
  oParams.Add('POOL_ExpireTimeout=600'); //6000000 10MIN
  oParams.Add('POOL_MaximumItems=200');
  FDManager.Close;

  while FDManager.State <> dmsInactive do
    Sleep(0);

  FDManager.Open;
  FDManager.AddConnectionDef('MySQL_Pool', 'MySQL', oParams);
  oParams.Free;
end;

procedure TConnRecover.Recover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
   if (AException is EFDDBEngineException) and
     (EFDDBEngineException(AException).Kind = ekServerGone) then
     begin
      AAction := faRetry;
     end
  else
    AAction := faFail;
end;

procedure InitConn;
begin
  ThInit:=True;
  RetryC := TConnRecover.Create;
  DBC := TFDConnection.Create(nil);
  DBC.ConnectionDefName := 'MySQL_Pool';
  DBC.LoginPrompt := False;
  DBC.FetchOptions.Unidirectional := True;
  DBC.UpdateOptions.RequestLive := False;
  DBC.OnRecover := RetryC.Recover;
  Q := TFDQuery.Create(nil);
  Q.Connection := DBC;
  Q.FetchOptions.Unidirectional := True;
  Q.UpdateOptions.RequestLive := False;
  Q2 := TFDQuery.Create(nil);
  Q2.Connection := DBC;
  Q2.FetchOptions.Unidirectional := True;
  Q2.UpdateOptions.RequestLive := False;
  DBC.Connected := True;
end;

initialization
 InitPool;

end.
