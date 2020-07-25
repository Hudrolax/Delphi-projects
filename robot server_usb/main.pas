unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls, Gvar,
  ExtCtrls;

type
  TForm1 = class(TForm)
    log: TListBox;
    server: TIdTCPServer;
    com1: TBComPort;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure serverExecute(AThread: TIdPeerThread);
    procedure serverConnect(AThread: TIdPeerThread);
    procedure serverDisconnect(AThread: TIdPeerThread);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
user='Hudrolax';
password='7950295';

var
  Form1: TForm1;
  authorized:Boolean;
  s:string;
CRbyte,LFbyte:ShortInt;
buffer:string;
pred:string;


implementation

{$R *.dfm}
procedure FF1;
begin
  buffer:='$KE,REL,1,1'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure FF0;
begin
  buffer:='$KE,REL,1,0'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure RR1;
begin
  buffer:='$KE,REL,2,1'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure RR0;
begin
  buffer:='$KE,REL,2,0'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure L1;
begin
  buffer:='$KE,REL,3,1'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure L0;
begin
  buffer:='$KE,REL,3,0'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure R1;
begin
  buffer:='$KE,REL,4,1'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure R0;
begin
  buffer:='$KE,REL,4,0'+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 {Открываем COM порты для связи с устройством}

 try
  log.Items.Add('Пробую открыть COM1...');
  com1.Open;
  log.Items.Add('Порт COM1 открыт и готов к работе.');
  except
    log.Items.Add('Не могу открыть COM1');
    end;

{Запускаем Сервер}
server.Active:=True;

CRbyte := 13; // HEX 0x0D
LFbyte := 10; // HEX 0x0A
pred:=Char(CRbyte)+ Char(LFbyte);

if server.Active then
 log.Items.Add('Сервер запущен на '+GetComputerNName+' и готов к работе.');
end;

procedure TForm1.serverExecute(AThread: TIdPeerThread);
var s:string;
begin
//  s:=AThread.Connection.ReadLn(s); // Читаем команду
//  if not authorized then
//  begin
//   AThread.Connection.WriteLn('Authorization plz...');
//   if Pos('user',s)=1 then
//    begin
//     if Copy(s,6,20)='Hudrolax' then
//      begin
//       AThread.Connection.WriteLn('Username is OK, password please.');
//       s:=AThread.Connection.ReadLn(s); // Читаем команду
//       if Pos('pass',s)=1 then
//        if Copy(s,6,20)='7950295' then
//          begin
//           AThread.Connection.WriteLn('Password is OK,welcome...');
//           authorized:=True;
//            end;
//      end else
//        begin
//          AThread.Connection.WriteLn('Wrong Username! Disconnecting...');
//          AThread.Connection.Disconnect;
//          end;
//
//   end;
//  end;



 if Form1.log.Count>500 then Form1.log.Clear; // чистим лог

 s:=AThread.Connection.ReadLn(s); // Читаем команду
 
  // Вверх +
 if s='up +' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com1.SetDTR(true);
    FF1;
   Exit;
  end;

 // Вверх -
 if s='up -' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com1.SetDTR(false);
   FF0;
   Exit;
  end;

 // Вниз +
 if s='down +' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com1.SetRTS(true);
   RR1;
   Exit;
  end;

  // Вниз -
 if s='down -' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com1.SetRTS(false);
   RR0;
   Exit;
  end;

  // Влево +
 if s='left +' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com2.SetDTR(true);
   L1;
   Exit;
  end;

  // Влево -
 if s='left -' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com2.SetDTR(false);
   L0;
   Exit;
  end;

   // Вправо +
 if s='right +' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com2.SetRTS(true);
   R1;
   Exit;
  end;

  // Вправо -
 if s='right -' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
//   form1.com2.SetRTS(false);
   R0;
   Exit;
  end;

 // Дисконнект
  if s='exit' then
  begin
   log.Items.Add('Get: '+s);
   log.Selected[log.Count-1]:=True;
   AThread.Connection.Disconnect;
   Exit;
  end;


end;

procedure TForm1.serverConnect(AThread: TIdPeerThread);
begin
 log.Items.Add('Client connected...');
 log.Selected[log.Count-1]:=True;
end;

procedure TForm1.serverDisconnect(AThread: TIdPeerThread);
begin
 log.Items.Add('Client disconnected...');
 log.Selected[log.Count-1]:=True;
 authorized:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 Log.Clear;
end;

end.
