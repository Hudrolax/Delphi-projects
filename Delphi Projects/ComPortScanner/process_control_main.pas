unit process_control_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, gvar, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
var
process:TStringList;
pcount,i:integer;
begin
 pcount:=0;
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 for i:=0 to process.Count-1 do
  if process[i]='CPScanProcess.exe' then pcount:=pcount+1;

 if pcount<1 then WinExec('CPScanProcess.exe /auto',0);

  process.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not RegisterHotkey(Handle, 3, MOD_ALT, VK_F2) then
  ShowMessage('Unable to assign Alt-F2 as hotkey.');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
UnRegisterHotkey( Handle, 3 );
end;

procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if (msg.hotkey = 3) then
    if form1.Visible then form1.Visible:=false
    else form1.Visible:=true;
  end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
Timer2.Enabled:=false;
form1.Visible:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Close;
end;

end.
