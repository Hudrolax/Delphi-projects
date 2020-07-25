unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ssl_openssl,httpsend,cHash, StdCtrls, DateUtils,
  ExtCtrls, IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,inifiles, TLHELP32;
type
  TForm1 = class(TForm)
    server: TIdTCPServer;
    Timer1: TTimer;
    Timer3: TTimer;
    function  PostMethod(Meth:string):WideString;
    procedure serverExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer3Timer(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
  end;

  TApiKey = record
   key:WideString;
   secret:WideString;
  end;

var
  Form1: TForm1;
  nonceGetInfo,nonceTransHistory,nonceTradeHistory,nonceActiveOrders,nonceTrade,nonceCancelOrder:integer;
  Ini:TIniFile;
  GetInfoKey,TransHistory,TradeHistory,ActiveOrders,Trade,CancelOrder:TApiKey;
  ClientPort,ClientIP,ServerPort:string;

implementation



{$R *.dfm}
function GetProcess: TStringList;
const
  PROCESS_TERMINATE = $0001;
var
  Co: BOOL;
  FS: THandle;
  FP: TProcessEntry32;
begin
  Result := TStringList.Create;
  FS := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FP.dwSize := Sizeof(FP);
  Co := Process32First(FS, FP);
  while Integer(Co) <> 0 do
  begin
    Result.Add(FP.szExeFile);
    Co := Process32Next(FS, FP);
  end;
  CloseHandle(FS);
end;


procedure SendMessageToClient(msg:WideString);
var
client:TIdTCPClient;
begin
  client := TIdTCPClient.Create(nil);
  client.Port := StrToInt(ClientPort);
  client.Host := ClientIP;
  try
   client.Connect();
   if client.Connected then
   begin
      client.WriteLn(msg);
      client.Disconnect;
   end;
  finally
    client.Free;
  end;
end;

function  Tform1.PostMethod(Meth:string):widestring;
var a:integer;
   nonce:Cardinal;
   str:string;
   hm:T512BitDigest;   //вот эта хрень куда записывается результат
                       //подписи строки запроса  секретным ключом
                       //не забудь подключить cHash для работы с ней
                       //вроде как можно было обойтись одними только
                       //средствами synapse или Indy но у меня не получилось
                       // и я брал первое что попалось под руку

   h:THTTPSend;        // Не получилось использоать ИНДИ(не помню почему) там чтото криво срабатывало,
                       // я подключил другой модуль тоже очень хороший. файлы идут с проектом
                       // в любом случае не забудь подключить httpsend и ssl_openssl
                       //а еще почитать про синапс
   stream:TStringStream;
   Key,Sekret:WideString;
   var NF:TextFile;
begin
    if AnsiPos('getInfo',Meth)>0 then
    begin
      nonceGetInfo := nonceGetInfo+1;
      nonce := nonceGetInfo;
      try
       AssignFile(NF,'nonceGetInfo.d');
       Rewrite(NF);
       write(NF,nonceGetInfo);
        finally
       CloseFile(NF);
          end;
      Key := GetInfoKey.key;
      Sekret := GetInfoKey.secret;
    end else
    if AnsiPos('TransHistory',Meth)>0 then
    begin
      nonceTransHistory := nonceTransHistory+1;
      nonce := nonceTransHistory;
      try
       AssignFile(NF,'nonceTransHistory.d');
       Rewrite(NF);
       write(NF,nonceTransHistory);
        finally
       CloseFile(NF);
          end;
      Key := TransHistory.key;
      Sekret := TransHistory.secret;
    end else
    if AnsiPos('TradeHistory',Meth)>0 then
    begin
      nonceTradeHistory := nonceTradeHistory+1;
      nonce := nonceTradeHistory;
      try
       AssignFile(NF,'nonceTradeHistory.d');
       Rewrite(NF);
       write(NF,nonceTradeHistory);
        finally
       CloseFile(NF);
          end;
      Key := TradeHistory.key;
      Sekret := TradeHistory.secret;
    end else
    if AnsiPos('ActiveOrders',Meth)>0 then
    begin
      nonceActiveOrders := nonceActiveOrders+1;
      nonce := nonceActiveOrders;
      try
       AssignFile(NF,'nonceActiveOrders.d');
       Rewrite(NF);
       write(NF,nonceActiveOrders);
        finally
       CloseFile(NF);
          end;
      Key := ActiveOrders.key;
      Sekret := ActiveOrders.secret;
    end else
    if AnsiPos('CancelOrder',Meth)>0 then
    begin
      nonceCancelOrder := nonceCancelOrder+1;
      nonce := nonceCancelOrder;
      try
       AssignFile(NF,'nonceCancelOrder.d');
       Rewrite(NF);
       write(NF,nonceCancelOrder);
        finally
       CloseFile(NF);
          end;
      Key := CancelOrder.key;
      Sekret := CancelOrder.secret;
    end else
    if AnsiPos('Trade',Meth)>0 then
    begin
      nonceTrade := nonceTrade+1;
      nonce := nonceTrade;
      try
       AssignFile(NF,'nonceTrade.d');
       Rewrite(NF);
       write(NF,nonceTrade);
        finally
       CloseFile(NF);
          end;
      Key := Trade.key;
      Sekret := Trade.secret;
    end;

    stream:=TStringStream.Create('');  // подготавливаем Стрим для строки запроса
                                       // почему стрим, а не строку? в метод подписи
                                       // нужно будет передавать адрес а не строку
                                       // а  вообще я сам нихуя не понял XD
    stream.WriteString('method='+Meth);
    stream.WriteString('&nonce='+inttostr(nonce));
    stream.Position:=0;

   // Key:='YFDDCOX5-XBHA4399-7OB0E9TX-0RZ42IH6-6CD5F4ZT';  //твой Api ключ
   // Sekret:='fcb7bfe595905a1a052938e1dc9a91aa509e427e55dfa85f86340ffaa23b5289'; //твой секретный ключ



    hm:=CalcHMAC_SHA512(Sekret,'method='+Meth+'&nonce='+inttostr(nonce));   //подписываем строку запроса  секретным ключом

    str:=SHA512DigestToHex(hm); // зачем-то переводим результат в Hex
                                //давно было не помню зачем XD
                                //связано со специфичностью то ли данного модуля HTTP
                                // то ли самого  HTTP

    h:=THTTPSend.Create;
    h.Headers.Clear;
    h.Headers.Append('key:'+Key);   //заполняем хидерсы запроса
    h.Headers.Append('sign:'+str);
    h.MimeType:='application/x-www-form-urlencoded';

    h.document.clear;
    h.Document.LoadFromStream(stream);  //запоняем сам запрос
    h.HTTPMethod('POST','https://btc-e.com/tapi/'); //отправляем запрос

    stream.Position:=0;
    h.Document.SaveToStream(stream); //ответ в тот же самый стрим в котором был запрос
                                     //чоп не создавать новый стрим XD
    stream.Position:=0;

    Result:=stream.ReadString(h.Document.Size);

    h.Free;
    stream.Free;
end;

procedure TForm1.serverExecute(AThread: TIdPeerThread);
var s:string;
var PostData:WideString;
f:TextFile;
begin
  s := AThread.Connection.ReadLn;
  if FileExists(extractfilepath(paramstr(0))+'log_proxy2.txt') then
    begin
      AssignFile(f,extractfilepath(paramstr(0))+'log_proxy2.txt');
      rewrite(f);
      Writeln(f,'Получил команду '+s+' от TradeBot.');
      CloseFile(f);
    end;
  // выполняем команду
  try
   PostData:=PostMethod(s);
  except
  end;

    if FileExists(extractfilepath(paramstr(0))+'log_proxy2.txt') then
    begin
      AssignFile(f,extractfilepath(paramstr(0))+'log_proxy2.txt');
      rewrite(f);
      Writeln(f,'Посылаю ответ '+s+PostData);
      CloseFile(f);
    end;

  // Отвечаем
  SendMessageToClient(s+PostData);
end;

procedure TForm1.FormCreate(Sender: TObject);
var NF:TextFile;
s:string;
process:TStringList;
pcount,i:Integer;
begin
  // Завершаем работу, если копия уже запущена
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 pcount:=0;
 for i:=0 to process.Count-1 do
  if process[i]='btceproxy2.exe' then pcount:=pcount+1;
  if pcount>1 then Application.Terminate;

 try
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'keys2.ini');
  ServerPort := ini.ReadString('Base','ServerPort','3739');
  ClientIP := ini.ReadString('Base','ClientIP','127.0.0.1');
  ClientPort := ini.ReadString('Base','ClientPort','3737');

  GetInfoKey.key:=ini.ReadString('GetInfoKey','key','');
  GetInfoKey.secret:=ini.ReadString('GetInfoKey','secret','');

  TransHistory.key:=ini.ReadString('TransHistory','key','');
  TransHistory.secret:=ini.ReadString('TransHistory','secret','');

  TradeHistory.key:=ini.ReadString('TradeHistory','key','');
  TradeHistory.secret:=ini.ReadString('TradeHistory','secret','');

  ActiveOrders.key:=ini.ReadString('ActiveOrders','key','');
  ActiveOrders.secret:=ini.ReadString('ActiveOrders','secret','');

  Trade.key:=ini.ReadString('Trade','key','');
  Trade.secret:=ini.ReadString('Trade','secret','');

  CancelOrder.key:=ini.ReadString('CancelOrder','key','');
  CancelOrder.secret:=ini.ReadString('CancelOrder','secret','');

  Ini.Free;
  except
    end;

 server.DefaultPort := StrToInt(ServerPort);

  if FileExists('nonceGetInfo.d') then
  try
    AssignFile(NF,'nonceGetInfo.d');
    reset(NF);
    Read(NF,s);
    nonceGetInfo:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  if FileExists('nonceTransHistory.d') then
  try
    AssignFile(NF,'nonceTransHistory.d');
    reset(NF);
    Read(NF,s);
    nonceTransHistory:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  if FileExists('nonceTradeHistory.d') then
  try
    AssignFile(NF,'nonceTradeHistory.d');
    reset(NF);
    Read(NF,s);
    nonceTradeHistory:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  if FileExists('nonceActiveOrders.d') then
  try
    AssignFile(NF,'nonceActiveOrders.d');
    reset(NF);
    Read(NF,s);
    nonceActiveOrders:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  if FileExists('nonceTrade.d') then
  try
    AssignFile(NF,'nonceTrade.d');
    reset(NF);
    Read(NF,s);
    nonceTrade:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  if FileExists('nonceCancelOrder.d') then
  try
    AssignFile(NF,'nonceCancelOrder.d');
    reset(NF);
    Read(NF,s);
    nonceCancelOrder:=StrToInt(s);
  finally
   CloseFile(NF);
  end;

  server.Active := True;
  Timer1.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:=false;
 Form1.Visible := False;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not FileExists('keys.ini') then
try
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'keys2.ini'); //Создаем файл настроек
  ini.WriteString('Base','ServerPort','3739');
  ini.WriteString('Base','ClientIP','127.0.0.1');
  ini.WriteString('Base','ClientPort','3737');

  ini.WriteString('GetInfoKey','key','');
  ini.WriteString('GetInfoKey','secret','');

  ini.WriteString('TransHistory','key','');
  ini.WriteString('TransHistory','secret','');

  ini.WriteString('TradeHistory','key','');
  ini.WriteString('TradeHistory','secret','');

  ini.WriteString('ActiveOrders','key','');
  ini.WriteString('ActiveOrders','secret','');

  ini.WriteString('Trade','key','');
  ini.WriteString('Trade','secret','');

  ini.WriteString('CancelOrder','key','');
  ini.WriteString('CancelOrder','secret','');
  Ini.Free
 except
   end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  if FileExists('t2.bat') then
  begin
    DeleteFile('t2.bat');
    Close();
  end;
end;

end.
