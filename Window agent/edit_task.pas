unit edit_task;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gvar, ComCtrls;

type
  TForm3 = class(TForm)
    TaskName: TEdit;
    fname: TEdit;
    ImgPatch: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    taskid: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    ProcName: TEdit;
    Button19: TButton;
    Label9: TLabel;
    Button20: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
  private
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
procedure TForm3.WMHotkey( var msg: TWMHotkey );
 begin
  if (msg.hotkey = 1) and (form3.Visible) then
    form3.Memo1.Lines.Append('mouse ' +inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.Y));
  end;


procedure TForm3.Button1Click(Sender: TObject);
begin
 form3.taskid.Text:='';
 form3.Memo1.Clear;
 form3.TaskName.Text:='';
 form3.fname.Text:='';
 form3.ImgPatch.Text:='';
 form3.DateTimePicker1.Time:=strtotime('00:00:00');
 form3.DateTimePicker2.Time:=strtotime('00:00:00');
 form3.Visible:=false;
end;

procedure Tform3.Button2Click(Sender: TObject);
var f:textfile;
i:integer;
begin
 if fname.Text='' then
  begin
   showmessage('Вы не ввели имя файла для сохранения задания!');
   exit;
  end;
 if TaskName.Text='' then
  begin
   showmessage('Вы не ввели имя для задания!');
   exit;
  end;
 if ImgPatch.Text='' then
  begin
   showmessage('Вы не ввели адрес картинки!');
   exit;
  end;
 if not FileExists(ImgPatch.Text) then
  begin
   showmessage('Картинка по введенному адресу не существует!!');
   exit;
  end;

 RenameFile(fname.Text,fname.Text+'_');
 try
  assignfile(f,fname.Text);
  rewrite(f);
  Writeln(f,taskid.text);
  Writeln(f,TaskName.text);
  Writeln(f,fname.Text);
  Writeln(f,ImgPatch.Text);
  Writeln(f,timetostr(DateTimePicker1.Time));
  Writeln(f,timetostr(DateTimePicker2.Time));
  for i:=0 to memo1.Lines.Count-1 do
   Writeln(f,memo1.Lines.Strings[i]);
  Closefile(f);
   Showmessage('Задание перезаписано успешно!');
  fname.Clear;
  taskid.Clear;
  TaskName.Clear;
  fname.Clear;
  ImgPatch.Clear;
  Memo1.Clear;
  g_reloadTasks:=true;
  form3.Visible:=false;
  deletefile(fname.Text+'_');
 except
   RenameFile(fname.Text+'_',fname.Text);
   addlog('Не удалось записать файл с заданием '+fname.Text);
 end;
end;

procedure Tform3.Button3Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'run ';
end;

procedure Tform3.Button4Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'kill ';
end;

procedure Tform3.Button5Click(Sender: TObject);
begin
memo1.Lines.Append('sleep ');
end;

procedure Tform3.Button6Click(Sender: TObject);
begin
memo1.Lines.Append('sleep 1000');
end;

procedure Tform3.Button14Click(Sender: TObject);
begin
memo1.Lines.Append('key Up');
end;

procedure Tform3.Button15Click(Sender: TObject);
begin
memo1.Lines.Append('key Down');
end;

procedure Tform3.Button16Click(Sender: TObject);
begin
memo1.Lines.Append('key Left');
end;

procedure Tform3.Button17Click(Sender: TObject);
begin
memo1.Lines.Append('key Right');
end;

procedure Tform3.Button10Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Enter';
end;

procedure Tform3.Button11Click(Sender: TObject);
begin
memo1.Lines.Append('key Esc');
end;

procedure Tform3.Button12Click(Sender: TObject);
begin
memo1.Lines.Append('key Tab');
end;

procedure Tform3.Button13Click(Sender: TObject);
begin
memo1.Lines.Append('key Space');
end;

procedure Tform3.Button7Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'mouse ';
end;

procedure Tform3.Button8Click(Sender: TObject);
begin
 memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key MouseLButton';
end;

procedure Tform3.Button9Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key MouseRButton';
form3.Show;
end;

procedure Tform3.Button18Click(Sender: TObject);
begin
memo1.Lines.Append('print ');
end;

procedure Tform3.FormShow(Sender: TObject);
begin
 if not RegisterHotkey(Handle, 1, MOD_ALT, VK_F1) then
  ShowMessage('Unable to assign Alt-F1 as hotkey.');
end;

procedure Tform3.FormHide(Sender: TObject);
begin
 UnRegisterHotkey( Handle, 1 );
end;

procedure TForm3.Button19Click(Sender: TObject);
begin
 memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'if (NoProcess = '+ProcName.Text+') ';
 end;

procedure TForm3.Button20Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'BitmapClick <АдресФайла>';
end;

end.
