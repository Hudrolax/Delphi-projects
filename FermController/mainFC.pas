unit mainFC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, IdTCPConnection, IdTCPClient, IdBaseComponent,
  IdComponent, IdTCPServer, StdCtrls;

type
  TForm1 = class(TForm)
    Com1: TBComPort;
    IDServer: TIdTCPServer;
    IDClient: TIdTCPClient;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure IDServerExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  CRbyte,LFbyte:ShortInt;
  buffer:string;
  pred:string;
  ConnectedToCom:Boolean;

implementation

{$R *.dfm}
function GetDateT: string;
begin
  Result := Datetostr(date) + ' ' + timetostr(time);
end;

procedure Log(s:string);
var s1:string;
begin
    if s = '' then
    Exit;

  if Form1.ListBox1.Items.Count > 500 then
    Form1.ListBox1.Clear;
  s1 := GetDateT + ': ' + s;
  Form1.ListBox1.Items.Append(s1);
  Form1.ListBox1.TopIndex := Form1.ListBox1.Items.Count - 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
i:Integer;
begin
  //ConnectedToCom := false;
  IDServer.Active:=True;

CRbyte := 13; // HEX 0x0D
LFbyte := 10; // HEX 0x0A
pred:=Char(CRbyte)+ Char(LFbyte);

 for i:=1 to 15 do
  try
    Log('Пробую открыть COM'+IntToStr(i));
    Com1.Port := 'COM'+inttostr(i);
    Com1.Open;
    buffer:='$KE'+pred;
    com1.Write(PChar(buffer)^,Length(buffer));
    com1.Read(PChar(buffer)^,Length(buffer));
   if AnsiPos('#OK',buffer)>0 then
    begin
      ConnectedToCom := True;
      Log('Нашел модуль KE на '+Com1.Port+', связь установлена.');
      Break;
    end
    else
    begin
     Log('НЕ получилось открыть.');
     Com1.Close

     end;
    except
      Log('Ошибка при открытии порта!!!');
      Com1.Close;
      end;
  if NOT ConnectedToCom then
  begin
    ShowMessage('Не могу установить соединение с модулем KE!');
    Exit;
  end;
  // Тут модуль уже найден.
end;

procedure TForm1.IDServerExecute(AThread: TIdPeerThread);
var
  s: string;
begin
  // REL4- ferm 3
  // REL3 - ferm 7
  // REL2 - ferm 4
  // REL1 - ferm 8
  s := AThread.Connection.ReadLn;
  Log('Пришла команда: '+s);
  if s='reboot REL1' then
    begin
      buffer:='$KE,REL,1,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      Log('Выключил. Жду 40 сек...');
      buffer:='$KE,REL,1,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(40000);
      buffer:='$KE,REL,1,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,1,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
     // IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Reload REL1 OK');
        IDClient.Disconnect;
      end;
    end;
  if s='reboot REL2' then
    begin
      buffer:='$KE,REL,2,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      Log('Выключил. Жду 40 сек...');
      buffer:='$KE,REL,2,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(40000);
      buffer:='$KE,REL,2,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,2,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Reload REL2 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='reboot REL3' then
    begin
      buffer:='$KE,REL,3,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      buffer:='$KE,REL,3,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Выключил. Жду 40 сек...');
      Sleep(40000);
      buffer:='$KE,REL,3,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,3,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Reload REL3 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='reboot REL4' then
    begin
      buffer:='$KE,REL,4,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      Log('Выключил. Жду 40 сек...');
      buffer:='$KE,REL,4,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(40000);
      buffer:='$KE,REL,4,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,4,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
     // IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Reload REL4 OK');
        IDClient.Disconnect;
      end;
    end;

    if s='on REL1' then
    begin
      buffer:='$KE,REL,1,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,1,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
     // IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:On REL1 OK');
        IDClient.Disconnect;
      end;
    end;
  if s='on REL2' then
    begin
      buffer:='$KE,REL,2,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,2,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:On REL2 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='on REL3' then
    begin
      buffer:='$KE,REL,3,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,3,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
     // IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:On REL3 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='on REL4' then
    begin
      buffer:='$KE,REL,4,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(500);
      buffer:='$KE,REL,4,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Включил!');

      IDClient.Host := '192.168.18.2';
    //  IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:On REL4 OK');
        IDClient.Disconnect;
      end;
    end;

    if s='off REL1' then
    begin
      buffer:='$KE,REL,1,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      buffer:='$KE,REL,1,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Выключил.');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Off REL1 OK');
        IDClient.Disconnect;
      end;
    end;
  if s='off REL2' then
    begin
      buffer:='$KE,REL,2,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      buffer:='$KE,REL,2,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Выключил.');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Off REL2 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='off REL3' then
    begin
      buffer:='$KE,REL,3,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      buffer:='$KE,REL,3,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Выключил.');

      IDClient.Host := '192.168.18.2';
     // IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Off REL3 OK');
        IDClient.Disconnect;
      end;
    end;

   if s='off REL4' then
    begin
      buffer:='$KE,REL,4,1'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Sleep(10000);
      buffer:='$KE,REL,4,0'+pred;
      Form1.com1.Write(PChar(buffer)^,Length(buffer));
      Log('Выключил.');

      IDClient.Host := '192.168.18.2';
      //IDClient.Connect();
      if IDClient.Connected then
      begin
        IDClient.WriteLn('FermController:Off REL4 OK');
        IDClient.Disconnect;
      end;
    end;
end;

end.
