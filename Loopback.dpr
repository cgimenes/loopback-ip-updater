program Loopback;

uses
  SysUtils,
  Forms,
  Windows,
  IdHTTP,
  ShellAPI;

var
  IP: string;
  IdHTTP: TIdHTTP;

procedure ExecuteProgram(Nome, Parametros: String);
Var Comando : Array[0..1024] of Char;
    Parms : Array[0..1024] of Char;
begin
  StrPCopy(Comando,Nome);
  StrPCopy(Parms,Parametros);
  ShellExecute(0,nil,Comando,Parms,nil,SW_HIDE);
end;

begin
  try
    if Application.MessageBox('O driver "Microsoft Loopback Adapter" está instalado com o nome de "Loopback"?',
    'Loopback', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      IdHTTP := TIdHTTP.Create;
      try
        IP := IdHTTP.Get('http://www.chsoft.com.br/util/pegaip/');

        ExecuteProgram('cmd', '/c netsh int ip set address name = "Loopback" source = static addr = ' + IP);

        Application.MessageBox('Seu IP foi alterado com sucesso!', 'Loopback',
          MB_OK);
      finally
        FreeAndNil(IdHTTP);
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end.
