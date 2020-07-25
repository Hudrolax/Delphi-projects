unit tariff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gvar, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    start: TCheckBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure startClick(Sender: TObject);
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  h:HWND;
  defeat,defeat2,startproc:boolean;

implementation

{$R *.dfm}
procedure find;
begin
keybd_event(vk_Down,$28,KEYEVENTF_EXTENDEDKEY,0);
sleep(10);
keybd_event(vk_Down,$28,KEYEVENTF_KEYUP,0);
end;

procedure select;
begin
keybd_event(vk_Space,$20,KEYEVENTF_EXTENDEDKEY,0);
sleep(10);
keybd_event(vk_Space,$20,KEYEVENTF_KEYUP,0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
if not RegisterHotkey(Handle, 1,MOD_CONTROL, VK_F1) then
  ShowMessage('Unable to assign Ctrl-F1 as hotkey.');

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 UnRegisterHotkey( Handle, 1 );
end;

procedure TForm1.WMHotkey( var msg: TWMHotkey );
begin
    if msg.hotkey = 1 then begin
    h:=GetForegroundWindow; //Получаем дескриптор
  label1.Caption:='Включено';
  label1.Font.Color:=clGreen;
  startproc:=true;
  timer1.Enabled:=true;
  end;

end;


procedure TForm1.startClick(Sender: TObject);
var i,j:integer;
begin
if start.Checked and (startproc) then begin
defeat:=false;
defeat2:=false;

// Если не только цыфры, то нах
for i:=0 to form1.Memo1.Lines.Count-1 do
 if NOT IsDigit(form1.Memo1.Lines.Strings[i]) then defeat:=true;
//Если меньше 2-х, то нах
 if form1.Memo1.Lines.Count<2 then defeat:=true;
//Если ID не по порядку, то нах
for i:=0 to form1.Memo1.Lines.Count-2 do
 if strtoint(form1.Memo1.Lines.Strings[i])>strtoint(form1.Memo1.Lines.Strings[i+1]) then defeat2:=true;

 if defeat2 then showmessage('ID клиентов идет не по порядку! Бойко проебал!');

 if defeat then begin
  ShowMessage('Поле ввода данных заполнено не верно!');
  form1.Memo1.Lines.Clear;
 end;

  end;
if (start.Checked) and (NOT defeat) and (NOT defeat2) and (startproc) then begin

for j:=2 to strtoint(form1.memo1.Lines.Strings[0]) do
 find;
 select;

 for i:=1 to Form1.Memo1.Lines.Count-1 do begin
 application.ProcessMessages;
   for j:=strtoint(form1.Memo1.Lines.Strings[i-1])+1 to strtoint(form1.Memo1.Lines.Strings[i]) do begin
      find;
      end;
   select;
  end;
 end;
 startproc:=false;
 label1.Caption:='Выключено';
 label1.Font.Color:=clRed;
 start.Checked:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
form1.Memo1.Lines.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   timer1.Enabled:=false;
   if start.Checked=false then start.Checked:=true else
  start.Checked:=false;
end;

end.
