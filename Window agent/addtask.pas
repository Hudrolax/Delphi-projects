unit addtask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gvar, ComCtrls;

type
  TForm2 = class(TForm)
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
  Form2: TForm2;

implementation

{$R *.dfm}
procedure TForm2.WMHotkey( var msg: TWMHotkey );
 begin
  if (msg.hotkey = 1) and (form2.Visible) then
    form2.Memo1.Lines.Append('mouse ' +inttostr(mouse.CursorPos.X)+','+inttostr(mouse.CursorPos.Y));
  end;


procedure TForm2.Button1Click(Sender: TObject);
begin
 Form2.taskid.Text:='';
 Form2.Visible:=false;
end;

procedure TForm2.Button2Click(Sender: TObject);
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

 try
  assignfile(f,fname.Text+'.task');
  rewrite(f);
  Writeln(f,taskid.text);
  Writeln(f,TaskName.text);
  Writeln(f,fname.Text+'.task');
  Writeln(f,ImgPatch.Text);
  Writeln(f,timetostr(DateTimePicker1.Time));
  Writeln(f,timetostr(DateTimePicker2.Time));
  for i:=0 to memo1.Lines.Count-1 do
   Writeln(f,memo1.Lines.Strings[i]);
  Closefile(f);
  assignfile(f,'tasklist.cfg');
  Append(f);
  Writeln(f,fname.Text+'.task');
  Closefile(f);
  Showmessage('Задание создано успешно!');
  fname.Clear;
  taskid.Clear;
  TaskName.Clear;
  fname.Clear;
  ImgPatch.Clear;
  Memo1.Clear;
  g_reloadTasks:=true;
  Form2.Visible:=false;
 except
   addlog('Не удалось записать файл с заданием '+fname.Text+'.task');
 end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'run ';
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'kill ';
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'sleep ';
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'sleep 1000';
end;

procedure TForm2.Button14Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Up';
end;

procedure TForm2.Button15Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Down';
end;

procedure TForm2.Button16Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Left';
end;

procedure TForm2.Button17Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Right';
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Enter';
end;

procedure TForm2.Button11Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Esc';
end;

procedure TForm2.Button12Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Tab';
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key Space';
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'mouse ';
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key MouseLButton';
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'key MouseRButton';
Form2.Show;
end;

procedure TForm2.Button18Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'print ';
end;

procedure TForm2.FormShow(Sender: TObject);
begin
 if not RegisterHotkey(Handle, 1, MOD_ALT, VK_F1) then
  ShowMessage('Unable to assign Alt-F1 as hotkey.');
end;

procedure TForm2.FormHide(Sender: TObject);
begin
 UnRegisterHotkey( Handle, 1 );
end;

procedure TForm2.Button19Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'if (NoProcess = '+ProcName.Text+') ';
end;

procedure TForm2.Button20Click(Sender: TObject);
begin
memo1.Lines.Strings[memo1.CaretPos.y]:=memo1.Lines.Strings[memo1.CaretPos.y]+'BitmapClick <АдресФайла>';
end;

end.
