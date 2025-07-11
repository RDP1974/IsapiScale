library IsapiScale;
// 7 jul 2025 Roberto Della Pasqua www.dellapasqua.com
// 11 jul 2025 added trap exception for reconnect, tested working

uses
  MSHeap,
  //RDPMM64,
  Windows,
  SysUtils,
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  WM1 in 'WM1.pas' {WM: TWebModule},
  IsapiPool;

{$R *.res}

function DllMain(hinst: HINST; fdwReason: DWORD; lpReserved: Pointer): BOOL; stdcall;
begin
  if fdwReason = DLL_THREAD_DETACH then // cleaning threadvar
  begin
   if Assigned(RetryC) then FreeAndNil(RetryC);
   if Assigned(Q) then FreeAndNil(Q);
   if Assigned(Q2) then FreeAndNil(Q2);
   if Assigned(DBC) then FreeAndNil(DBC);
  end;
  Result := True;
end;

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.MaxConnections := 5000;
  Application.CacheConnections := True;
  Application.Run;
end.
