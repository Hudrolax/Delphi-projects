unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    procedure timer1Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    h:HWND;


implementation

{$R *.dfm}

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
    if not checkbox1.Checked then
      begin
      CheckBox1.Checked:=true;
      timer1.Enabled:=true;
      end else
      begin
      CheckBox1.Checked:=false;
      timer1.Enabled:=false;
      end;


  end;

end;


procedure TForm1.timer1Timer(Sender: TObject);
begin
  keybd_event(VK_DELETE,VK_DELETE,KEYEVENTF_EXTENDEDKEY,0);
sleep(30);
keybd_event(VK_DELETE,VK_DELETE,KEYEVENTF_KEYUP,0);
Sleep(30);
keybd_event(VK_RETURN,VK_RETURN,KEYEVENTF_EXTENDEDKEY,0);
sleep(30);
keybd_event(VK_RETURN,VK_RETURN,KEYEVENTF_KEYUP,0);
end;

end.
