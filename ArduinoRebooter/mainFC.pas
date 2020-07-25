unit mainFC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, IdTCPConnection, IdTCPClient, IdBaseComponent,
  IdComponent, IdTCPServer, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Com1: TBComPort;
    ListBox1: TListBox;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pred:string;
  ConnectedToCom:Boolean;
  CRbyte,LFbyte:ShortInt;
  buffer:string;

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

procedure SetREL(rel:string;p:string);
begin
  buffer:='$KE,REL,'+rel+','+p+pred;
  Form1.com1.Write(PChar(buffer)^,Length(buffer));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled := False;
 if (FileExists('c:\jarvis\rebootArduino1.f')) then
 begin
  DeleteFile('c:\jarvis\rebootArduino1.f');
  SetREL('1','1');
  Sleep(10000);
  SetREL('1','0');
 end;
 Timer1.Enabled := True;
end;

end.
