unit JarvisMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,gvar, IdTCPServer;

type
  TForm1 = class(TForm)
    AutoCommandEdit: TEdit;
    Label1: TLabel;
    ManualEdit: TEdit;
    SendButton: TButton;
    client: TIdTCPClient;
    LogBox: TListBox;
    server: TIdTCPServer;
    procedure SendButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AutoCommandEditChange(Sender: TObject);
    procedure serverExecute(AThread: TIdPeerThread);
    procedure ManualEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
procedure Log(s: string);
begin
  Form1.LogBox.Items.Append(GetDateT() + ' Jarvis: ' + s);
end;

{$R *.dfm}
procedure SendMsgManual();
begin
  with Form1 do
  begin
   try
   client.Connect(5000);
   if (client.Connected) and (ManualEdit.Text <> '') then
   begin
    client.WriteLn('test:' + ManualEdit.Text);
    Form1.LogBox.Items.Append(GetDateT() + ' '+GetComputerNName+': ' + ManualEdit.Text);
   end;
   ManualEdit.Text := '';
   client.Disconnect;
   except
     Log('Не могу соединиться с сервером!');
     end;
  end;
end;

procedure TForm1.SendButtonClick(Sender: TObject);
begin
  SendMsgManual();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
  client.Connect;
  if client.Connected then
    client.WriteLn('test:Hello!');
  client.Disconnect;
  Except
    Log('Не могу соединиться с сервером!');
    end

end;

procedure TForm1.AutoCommandEditChange(Sender: TObject);
begin
  try
  client.Connect(5000);
  // Отправка и очистка
  if client.Connected then
  begin
    client.WriteLn('test:'+AutoCommandEdit.Text);
    Form1.LogBox.Items.Append(GetDateT() + ' '+GetComputerNName+': ' + AutoCommandEdit.Text);
  end;
  AutoCommandEdit.Text:='';
  client.Disconnect;
  except
    Log('Не могу соединиться с сервером!');
 end;
end;

procedure TForm1.serverExecute(AThread: TIdPeerThread);
var s:string;
begin
 s:=AThread.Connection.ReadLn();
 if s<>'' then Log(s);
end;

procedure TForm1.ManualEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=VK_Return then
    SendMsgManual();
end;

end.
