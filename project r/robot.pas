unit robot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, StdCtrls, Buttons, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPServer, IdTCPConnection, IdTCPClient, DBF, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit1: TEdit;
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
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    Button34: TButton;
    ListBox2: TListBox;
    Label1: TLabel;
    dbf: TDBF;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button35: TButton;
    Button36: TButton;
    Timer2: TTimer;
    CheckBox2: TCheckBox;
    baza: TIdTCPClient;
    Edit4: TEdit;
    Label4: TLabel;
    procedure FormCrem1ate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button8Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button33Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Kup,Kdown,Kleft,Kright:Boolean;
  pause:Integer;
  vpered,nazad,vlevo,vpravo:Boolean;
  vpered1,nazad1,vlevo1,vpravo1:Boolean;
  rand:Boolean;

implementation

{$R *.dfm}


 procedure recorddemo(key:string);
 begin
   if pause=0 then pause:=100;
  form1.ListBox1.Items.Add('Пауза '+IntToStr(pause));
  pause:=0;
  Form1.ListBox1.Items.Add(key);

 end;


 procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if CheckBox1.Checked then
   begin
   CheckBox1.Checked:=False;
   Timer1.Enabled:=false;
   end else
    begin
    CheckBox1.Checked:=True;
    Timer1.Enabled:=True;
    end;



  end;


procedure TForm1.FormCrem1ate(Sender: TObject);
begin
 if not RegisterHotkey(Handle, 1, MOD_ALT, VK_F2) then
  ShowMessage('Unable to assign Alt-F2 as hotkey.');

     //??????? ??????? ?? ?????? ?? ????????
 try
  dbf.TableName:='base\scripts.dbf';
  if not FileExists('base\scripts.dbf') then begin
   dbf.AddFieldDefs('script',bfString,50,0);
   dbf.AddFieldDefs('filename',bfString,50,0);
   dbf.CreateTable;
   DBF.close;
  end;
  except
    end;

//com1.Open;
//com1.SetDTR(false);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
//   com1.Close;
 except
   end;
 try
//   com2.Close;
 except
   end;  
end;


//******************************
// Вперед +
procedure TFW;
begin
  if (not vpered1) and (not nazad1) then
  if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('up +');
   vpered1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вперед -
procedure FFW;
begin
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('up -');
   vpered1:=False;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Назад +
procedure TRV;
begin
 if (not nazad1) and (not vpered1) then
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('down +');
   nazad1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Назад -
procedure FRV;
begin
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('down -');
   nazad1:=false;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Влево +
procedure TLeft;
begin
 if (not vlevo1) and (not vpravo1) then
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('left +');
  vlevo1:=True;
 end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Влево -
procedure FLeft;
begin
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('left -');
  vlevo1:=False;
 end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вправо +
procedure TRight;
begin
 if (not vpravo1) and (not vlevo1) then
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('right +');
   vpravo1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вправо -
procedure FRight;
begin
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('right -');
  vpravo1:=false;
 end else ShowMessage('Отсутствует подключение к серверу!');
 end;

procedure exec(list:array of string);
 var i:integer;
 Stime:Integer;
begin
 for i:=0 to Length(list)-1 do
  begin

    if list[i]='Вперед +' then
    begin
     TFW;
     Continue;
      end;

    if list[i]='Вперед -' then
    begin
     FFW;
     Continue;
      end;
    if list[i]='Назад +' then
    begin
     TRV;
     Continue;
      end;

    if list[i]='Назад -' then
    begin
     FRV;
     Continue;
      end;

    if list[i]='Влево +' then
    begin
     TLeft;
     Continue;
      end;

    if list[i]='Влево -' then
    begin
     FLeft;
     Continue;
      end;

    if list[i]='Вправо +' then
    begin
     TRight;
     Continue;
      end;

    if list[i]='Вправо -' then
    begin
     FRight;
     Continue;
      end;

    if Pos('Пауза', list[i])=1 then
    begin
     Stime:=StrToInt(Copy(list[i],7,8));
     Sleep(Stime);
     Continue;
      end;
  end;

  FFW;
  FRV;
  FLeft;
  FRight;
  Form1.Edit1.SetFocus;
end;


//******************************
procedure TForm1.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TFW;
end;

procedure TForm1.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FFW;
end;

procedure TForm1.Button9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TRV;
end;

procedure TForm1.Button9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FRV;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
  37:if not Kright then
     begin
       {ВЛЕВО}
        SendMessage(form1.Button4.Handle, bm_SetState, 1, 0);
        TLeft;
        Kleft:=true;

       if not vlevo then
       begin
       if CheckBox1.Checked then recorddemo('Влево +');
       vlevo:=True;
       end;
     end;
  38:if not Kdown then
     begin
       {ВВЕРХ}
        SendMessage(form1.Button1.Handle, bm_SetState, 1, 0);
        TFW;
        Kup:=True;

        if not vpered then
        begin
        if CheckBox1.Checked then recorddemo('Вперед +');
        vpered:=True;
        end;
     end;
  39:if not Kleft then
     begin
       {ВПРАВО}
        SendMessage(form1.Button3.Handle, bm_SetState, 1, 0);
        TRight;
        Kright:=True;
        if not vpravo then
        begin
        if CheckBox1.Checked then recorddemo('Вправо +');
        vpravo:=True;
        end;
     end;
  40:if not Kup then
     begin
       {ВНИЗ}
        SendMessage(form1.Button9.Handle, bm_SetState, 1, 0);
        TRV;
        Kdown:=True;
       if not nazad then
       begin
       if CheckBox1.Checked then recorddemo('Назад +');
       nazad:=True;
       end;
     end;
end;


end;

procedure TForm1.Button2Click(Sender: TObject);
var
list:array of string;
i:integer;
begin
 SetLength(List,ListBox1.Count);
  for i:=0 to ListBox1.Count-1 do
  list[i]:=ListBox1.Items.Strings[i];

 exec(List);
end;


procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
  37:begin
       {ВЛЕВО}
        SendMessage(form1.Button4.Handle, bm_SetState, 0, 0);
        FLeft;
        Kleft:=False;

        if CheckBox1.Checked then
        begin
         recorddemo('Влево -');
         vlevo:=false;
        end;
     end;
  38:begin
       {ВВЕРХ}
        SendMessage(form1.Button1.Handle, bm_SetState, 0, 0);
        FFW;
        Kup:=false;

        if CheckBox1.Checked then
        begin
         recorddemo('Вперед -');
         vpered:=false;
        end;
     end;
  39:begin
       {ВПРАВО}
        SendMessage(form1.Button3.Handle, bm_SetState, 0, 0);
        FRight;
        Kright:=False;

        if CheckBox1.Checked then
        begin
         recorddemo('Вправо -');
         vpravo:=False;
        end;
     end;
  40:begin
       {ВНИЗ}
        SendMessage(form1.Button9.Handle, bm_SetState, 0, 0);
        FRV;
        Kdown:=False;

        if CheckBox1.Checked then
        begin
         recorddemo('Назад -');
         nazad:=False;
        end;
     end;
end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Вперед +');
 ListBox1.ItemIndex:=ListBox1.Count-1;
 Edit1.SetFocus;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Вперед -');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Назад +');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Назад -');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза '+Edit1.Text);
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
 ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Влево +');
 ListBox1.ItemIndex:=ListBox1.Count-1;
 Edit1.SetFocus;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Влево -');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Вправо +');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Вправо -');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
 try
  baza.Host:=Edit4.Text;
  baza.Connect();
  if baza.Connected then ShowMessage('Подключились!');
   except
   ShowMessage('Не могу подключиться !!!');
     end;


end;

procedure TForm1.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 TLeft;
end;

procedure TForm1.Button4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FLeft;
end;

procedure TForm1.Button3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TRight;
end;

procedure TForm1.Button3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FRight;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
ListBox1.Clear;
Edit1.SetFocus;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  try
  baza.Disconnect;
   except
   ShowMessage('Не могу отключиться!!!');
     end;
     Edit1.SetFocus;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 50');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 100');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 200');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 500');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 1000');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 2000');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 5000');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
ListBox1.Items.Insert(ListBox1.ItemIndex+1,'Пауза 10000');
ListBox1.ItemIndex:=ListBox1.Count-1;
Edit1.SetFocus;
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
 ListBox1.Items.SaveToFile('1.txt');
 Edit1.SetFocus;
end;

procedure TForm1.Button28Click(Sender: TObject);
begin
ListBox1.Items.SaveToFile('2.txt');
Edit1.SetFocus;
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
ListBox1.Items.SaveToFile('3.txt');
Edit1.SetFocus;
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
ListBox1.Items.LoadFromFile('1.txt');
Edit1.SetFocus;
end;

procedure TForm1.Button31Click(Sender: TObject);
begin
ListBox1.Items.LoadFromFile('2.txt');
Edit1.SetFocus;
end;

procedure TForm1.Button32Click(Sender: TObject);
begin
ListBox1.Items.LoadFromFile('3.txt');
Edit1.SetFocus;
end;

procedure TForm1.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
TFW;
end;

procedure TForm1.Button1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FFW;
end;

procedure TForm1.Button33Click(Sender: TObject);
begin
 ListBox1.Items.Delete(ListBox1.ItemIndex);
 Edit1.SetFocus;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
 with (Control as TListBox).Canvas do
  begin

    if Pos('Вперед',ListBox1.Items.Strings[index])>0 then
        begin
          Font.Color := clBlack;
          Brush.Color := TColor($82D2A8);
        end;

    if Pos('Назад',ListBox1.Items.Strings[index])>0 then
        begin
          Font.Color := clBlack;
          Brush.Color := TColor($7D7Dff);
        end;

    if Pos('Вправо',ListBox1.Items.Strings[index])>0 then
        begin
          Font.Color := clBlack;
          Brush.Color := TColor($69EAF8);
        end;

    if Pos('Влево',ListBox1.Items.Strings[index])>0 then
        begin
          Font.Color := clBlack;
          Brush.Color := TColor($ffE97d);
        end;


    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, (Control as TListBox).Items[Index]);
  end;

end;








procedure TForm1.Timer1Timer(Sender: TObject);
begin
 pause:=pause+100;
end;

procedure TForm1.Button34Click(Sender: TObject);
var
i,p,p1:integer;
 vpered,nazad,vlevo,vpravo:Boolean;
begin
 for i:=0 to Listbox1.Count-1 do
  begin
    p:=0;
    p1:=0;
   if ListBox1.Items.Strings[i]='Вперед +' then
   begin
    if not vpered then vpered:=True else
      begin
      ListBox1.Items.Delete(i);
      Continue;
      end;
    end;
   if ListBox1.Items.Strings[i]='Назад +' then
      begin
    if not nazad then nazad:=True else
      begin
      ListBox1.Items.Delete(i);
      Continue;
      end;
    end;

   if ListBox1.Items.Strings[i]='Влево +' then
      begin
    if not vlevo then vlevo:=True else
      begin
      ListBox1.Items.Delete(i);
      Continue;
      end;
    end;

   if ListBox1.Items.Strings[i]='Вправо +' then
      begin
    if not vpravo then vpravo:=True else
      begin
      ListBox1.Items.Delete(i);
      Continue;
      end;
    end;

   if (Pos('Пауза ',ListBox1.Items.Strings[i])=1) and (Pos('Пауза ',ListBox1.Items.Strings[i+1])=1) then
    begin
     p:=StrToInt(Copy(ListBox1.Items.Strings[i],7,10));
     p1:=StrToInt(Copy(ListBox1.Items.Strings[i+1],7,10));
     p:=p+p1;
     ListBox1.Items.Strings[i]:='Пауза '+inttostr(p);
     ListBox1.Items.Delete(i+1);
      end;

  end;
end;

procedure flood;
var i:Integer;
begin
 try
  Form1.ListBox2.Clear;
  form1.dbf.TableName:='base\scripts.dbf';
  Form1.dbf.Open;
  for i:=1 to Form1.dbf.RecordCount do
   begin
   form1.ListBox2.Items.Add(Form1.dbf.GetFieldData(1));
   form1.dbf.Next;
   end;

  Form1.dbf.close;
  except
    ShowMessage('Ошибка при открытии БД!');
    end;

  try
    Form1.dbf.Close;
  except
  end;
end;

procedure TForm1.Button35Click(Sender: TObject);
var
i:Integer;
f:textfile;
begin
try
 AssignFile(f,'base\'+Edit3.Text+'.txt');
 Rewrite(f);
 for i:=0 to ListBox1.Count-1 do
  begin
   Writeln(f,ListBox1.Items.Strings[i]);
    end;
 CloseFile(f);


  dbf.TableName:='base\scripts.dbf';
  dbf.Open;
  dbf.Append;
  dbf.SetFieldData(1,Edit2.Text);
  dbf.SetFieldData(2,Edit3.Text+'.txt');
  dbf.Post;
  dbf.Close;
  ShowMessage('Действие сохранено!');
  except
    ShowMessage('Не могу сохранить!!!');
    end;
    Flood;
  end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
timer2.Enabled:=False;
flood;
end;

procedure TForm1.Button36Click(Sender: TObject);
var
list:array of string;
i,k:Integer;
s:string;
f:TextFile;
begin
  k:=0;
    try
    dbf.Close;
     except
       end;

 try
   dbf.TableName:='base\scripts.dbf';
   dbf.Open;
   for i:=1 to dbf.RecordCount do
    begin
     if dbf.GetFieldData(1)=ListBox2.Items.Strings[ListBox2.ItemIndex] then
       begin
        AssignFile(f,'base\'+dbf.GetFieldData(2));
        Reset(f);
        while not Eof(f) do
         begin
          Readln(f,s);
          k:=k+1;
         end;

        CloseFile(f);

        SetLength(list,k);
        k:=0;
        AssignFile(f,'base\'+dbf.GetFieldData(2));
        Reset(f);
         while not Eof(f) do
          begin
            Readln(f,s);
            list[k]:=s;
            k:=k+1;
            end;
        CloseFile(f);
        Break;
       end;
     dbf.Next;
    end;


  except
     ShowMessage('Ошибка доступа к БД! Модуль ВЫПОЛНИТЬ');
  end;

  try
    dbf.Close;
    except
      end;

  exec(list);
 end;


procedure TForm1.CheckBox2Click(Sender: TObject);
var
a:array of string;
i,k:Integer;
s:string;
rand:integer;
f:TextFile;
begin
if CheckBox2.Checked then
 begin
  dbf.TableName:='base\scripts.dbf';
  dbf.Open;

  while CheckBox2.Checked do
   begin
    k:=0;
    rand:=RandomRange(1,dbf.RecordCount);
    dbf.GoToRecord(rand);
    AssignFile(f,'base\'+dbf.GetFieldData(2));
    Reset(f);
    while not Eof(f) do
     begin
       Readln(f,s);
       k:=k+1;
       end;
    CloseFile(f);
    SetLength(a,k);

    Reset(f);
    i:=0;
    while not Eof(f) do
    begin
      Readln(f,s);
      a[i]:=s;
      i:=i+1;
      end;
    CloseFile(f);
    exec(a);
    Application.ProcessMessages;
    Sleep(RandomRange(100,5000));
    end;

 SetLength(a,0);
 end;

 try
   dbf.Close;
   except
     end;

end;

end.
