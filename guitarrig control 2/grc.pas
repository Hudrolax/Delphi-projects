unit grc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCPort, ExtCtrls, inifiles;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    com: TBComPort;
    Edit777: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure comRxChar(Sender: TObject; Count: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  connected:Boolean;
  Ini: Tinifile;
  Current:Integer;
  prev:string;
  ed1_x1,ed1_x2,ed1_y1,ed1_y2:Integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not connected then
   try
    com.Port:=Edit777.Text;
    com.Open;
   // Button1.Caption:='Отключить';
    connected:=true;
    Button1.Caption:='Отключить';
    Label1.Caption:='Подключен';
    label1.Font.Color:=clGreen;
    Timer1.Enabled:=True;
   except
     ShowMessage('Ошибка подключения к модулю!');
   end
  else
  try
   Timer1.Enabled:=False;
   com.Close;
   connected:=false;
   Button1.Caption:='Подключить';
   Label1.Caption:='Отключен';
    label1.Font.Color:=clRed;
    except
      Timer1.Enabled:=True;
      end;

end;

procedure TForm1.comRxChar(Sender: TObject; Count: Integer);
var s:string;
begin

  com.ReadStr(s,count);
  s:=Copy(s,Length(s)-2,1);
 // Edit1.Text:=s;
  if (s='1') or (s='0') then
  begin
   if (s='0') and (Prev<>'0') then
   begin
     Prev:='0';
    // Если кнопка нажата (0), то переключаем
    if Current=1 then
     begin
      setcursorpos(StrToInt(Edit2.Text),StrToInt(Edit3.Text));
      Sleep(20);
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      Sleep(5);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      Current:=0;
     end
     else if Current=0 then
     begin
      setcursorpos(StrToInt(Edit4.Text),StrToInt(Edit5.Text));
      Sleep(20);
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
      Sleep(5);
      mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
      Current:=1;
     end;
   end;

   if s<>'0' then
     prev:='1';

   Edit1.Text:=s;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
CRbyte,LFbyte:ShortInt;
buffer:string;
begin
  CRbyte := 13; // HEX 0x0D
  LFbyte := 10; // HEX 0x0A

  buffer:='$KE,RD,1'+Char(CRbyte)+ Char(LFbyte);
  com.Write(PChar(buffer)^,Length(buffer));

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Current:=1;
 prev:='1';
 Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
 ed1_x1:=ini.ReadInteger('Mouse','X1',0);
 ed1_y1:=ini.ReadInteger('Mouse','Y1',0);
 ed1_x2:=ini.ReadInteger('Mouse','X2',0);
 ed1_y2:=ini.ReadInteger('Mouse','Y2',0);
 Edit2.Text:=IntToStr(ed1_x1);
 Edit3.Text:=IntToStr(ed1_y1);
 Edit4.Text:=IntToStr(ed1_x2);
 Edit5.Text:=IntToStr(ed1_y2);
 Ini.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
 Ini.WriteInteger('Mouse','X1',StrToInt(Edit2.text));
 Ini.WriteInteger('Mouse','Y1',StrToInt(Edit3.text));
 Ini.WriteInteger('Mouse','X2',StrToInt(Edit4.text));
 Ini.WriteInteger('Mouse','Y2',StrToInt(Edit5.text));
 Ini.Free;
end;

end.
