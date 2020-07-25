unit wa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, QuickPixel, DesktopCanvas, Gvar, addtask,
  Menus, ComCtrls, edit_task, DateUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Xpos: TLabel;
    Ypos: TLabel;
    ListBox1: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Label5: TLabel;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    Label6: TLabel;
    StatusL: TLabel;
    Label7: TLabel;
    Engine: TTimer;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label8: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label9: TLabel;
    DateTimePicker2: TDateTimePicker;
    Button5: TButton;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EngineTimer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FindImage:boolean;

implementation

{$R *.dfm}
// Функция сравнивает картинку с предпологаемой копией на экране
function TryImg(x,y:integer;QP,QP2:TQuickPixel):boolean;
var x2,y2:integer;
qp1h,qp1w,qp2h,qp2w:integer;
begin
 result:=false;
  qp1h:=QP.Height;
  qp1w:=QP.Width;
  qp2h:=QP2.Height;
  qp2w:=QP2.Width;
 for X2:=0 to qp2w-1 do
  for Y2:=0 to qp2h-1 do
    if (X+x2<qp1w-1) and (Y+y2<qp1h-1) then
     begin
      IF QP2.Pixel[X2,Y2] <> QP.Pixel[X+x2,Y+y2] then
        begin
          result:=false;
          Exit;
        end;
     end

    else
    begin
      result:=false;
      Exit;
    end;
 result:=true;
end;

function FindProcess(ProcessName:string):boolean;
var pcount,i:integer;
process:TStringList;
begin
 Result:=false;
 pcount:=0;
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 for i:=0 to process.Count-1 do
  if process[i]=ProcessName then pcount:=pcount+1;
 if pcount>0 then Result:=True;;
 process.Free;
end;

procedure CmdParse(condition,cmd,param:string);
var
  f:textfile;
  s,X,Y:string;
  i,count,j, DX, DY, qp1h, qp1w, X2, Y2:integer;
  Cond1, Cond2, Oper :string;
    B,B2:TBitmap;
    ClickPoint:TPoint;
    QP,QP2: TQuickPixel;
    FindImage:boolean;
    Desktop:TDesktopCanvas;
  label RunScript, Finall;
begin
 Cond1:='';
 Cond2:='';
 Oper:='';

 if condition<>'' then
  begin

     // Читаем условие
   for j:=1 to length(condition) do
    if copy(condition,j,1)<>' ' then
     begin
      if copy(condition,j,1)='=' then
       begin
        Oper:=copy(condition,j,1);
        Continue;
       end
      else
       if Oper='' then
        Cond1:=Cond1+copy(condition,j,1)
       else
        Cond2:=Cond2+copy(condition,j,1);
     end
    else
      Continue;
    addlog('Найдено условие '+Cond1+Oper+Cond2+'. Команда '+cmd+' параметр '+param);
    // Разбираем условие
    If (Cond1='NoProcess') or (Cond2='NoProcess') then
      begin
       If Cond1='NoProcess' then
         begin
          if NOT FindProcess(Cond2) then
             goto RunScript;
         end
       else
         if NOT FindProcess(Cond1) then
             goto RunScript;
      end;
   addlog('Условие не выполнено. Команда игнорируется.');   
   Exit;
  end;

 RunScript:

 if (cmd='run') and (param<>'') then // Запускаем
  begin
   try
     WinExec(Pchar(param),SW_NORMAL);
     addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
     except
     addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
       end;
   end
 else if (cmd='sleep') and (param<>'') then // Спим
 begin
      try
       sleep(strtoint(param));
      except
        end
 end
 else if (cmd='kill') and (param<>'') then // завершаем
      begin
       try
         assignfile(f,'killer.bat');
         rewrite(f);
         Writeln(f,'taskkill.exe /F /IM '+param);
         Closefile(f);
         sleep(10);
         WinExec('killer.bat',SW_HIDE);
         sleep(1000);
         DeleteFile('killer.bat');
         addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
         except
         addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
           end;
      end
 else if (cmd='mouse') and (param<>'') then // двигаем мышу
      try
       s:='';
       count:=0;
       for i:=1 to length(param) do
        if (copy(param,i,1)<>',') and (count=0) then
          x:=x+copy(param,i,1)
        else
          begin
           if (copy(param,i,1)<>',') then
            y:=y+copy(param,i,1);
           count:=count+1;
          end;
       try
       setcursorpos(strtoint(x),strtoint(y));
       except
         end;
       addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
       except
        addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
         end
 else if (cmd='BitmapClick') and (param<>'') then // двигаем мышу
      try
        x2:=0;
        y2:=0;
             // Фоткаем экран
        Desktop:= TDesktopCanvas.Create;
        B:= TBitmap.Create;
        B2:= TBitmap.Create;
        B2.LoadFromFile(param);
        B.Width:= Screen.Width;
        B.Height:= Screen.Height;
        B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
        B.PixelFormat:= pf24bit;
        QP:=TQuickPixel.Create(B);
        qp1h:=QP.Height;
        qp1w:=QP.Width;
        QP2:=TQuickPixel.Create(B2);
        FindImage:=false;

        if (qp1h=0) or (qp1w=0) or (QP2.Height=0) or (QP2.Width=0) then goto Finall;
         For X2:=0 to qp1w-1 do
           begin
             for Y2:=0 to qp1h-1 do
              if QP.Pixel[X2,Y2]=QP2.Pixel[0,0] then
                 begin
                   if TryImg(X2,Y2,QP,QP2) then
                     begin
                      FindImage:=true;
                      Break;
                     end;
                 end;
            if FindImage then Break;
           end;
       Finall:
       if FindImage then
        begin
          DX:=QP2.Width div 2;
          DY:=QP2.Height div 2;
          setcursorpos(X2+DX,Y2+DY);
          sleep(100);
          mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
          sleep(50);
          mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
        end
       else
         addlog('ОШИБКА: Картинка '+param+' НЕ найдена для клика.');
       except
        addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
         end
 else if (cmd='key') and (param<>'') then // нажимаем кнопку
    begin
      if param='MouseLButton' then
        try
          mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
          sleep(10);
          mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
        except
          addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
        end
      else
      if param='MouseRButton' then
        try
          mouse_event(MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
          sleep(10);
          mouse_event(MOUSEEVENTF_RIGHTUP,0,0,0,0);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
        except
          addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
        end
      else if param='Enter' then
         begin
          try
          SimulateKeystroke(VK_RETURN,0);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
          except
            end;
         end
      else if param='Esc' then
         begin
          try
          SimulateKeystroke(VK_ESCAPE,0);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
          except
            end
         end
      else if param='Del' then
         try
         SimulateKeystroke(VK_DELETE,0)
         except
           end
      else if param='Tab' then
         try
          SimulateKeystroke(VK_TAB,0)
         except
           end
       else if param='Space' then
         try
           SimulateKeystroke(VK_SPACE,0)
         except
         end
       else if param='Up' then
         try
         SimulateKeystroke(VK_UP,0)
         except
           end
       else if param='Down' then
         try
         SimulateKeystroke(VK_DOWN,0)
         except
           end
       else if param='Left' then
        try
         SimulateKeystroke(VK_LEFT,0)
         except
           end
       else if param='Right' then
       try
         SimulateKeystroke(VK_RIGHT,0)
         except
           end;
      end
   else if (cmd='print') and (param<>'') then // печатаем
        try
          SendKeys(param);
          addlog('Команда '+cmd+' с параметром '+param+' выполнена.');
          except
          addlog('ОШИБКА: Команда '+cmd+' с параметром '+param+' НЕ выполнена.');
            end;


end;
// Выполнение скрипта
procedure Scripting(id:integer);
var i,j,count,Ot:integer;
cmdO,cmd,param,condition :string;
begin
 for i:=0 to Task[id].script.Count-1 do
  begin
   try
   condition:='';
   cmd:='';
   param:='';
   count:=0;
   Ot:=1;
   cmdO:=Task[id].script.Strings[i];
   if copy(cmdO,1,4)='if (' then
     begin
      Ot:=5;
      for j:=5 to length(cmdO) do
       if copy(cmdO,j,1)<>')' then
        begin
          condition:=condition+copy(cmdO,j,1);
          Ot:=Ot+1;
        end
       else Break;
      Ot:=Ot+2;
     end;
   // Читаем команду
   for j:=Ot to length(cmdO) do
    if copy(cmdO,j,1)<>' ' then
      if count=0 then
        cmd:=cmd+copy(cmdO,j,1)
      else
        param:=param+copy(cmdO,j,1)
    else Count:=count+1;
    CmdParse(condition,cmd,param);
    except
      end;
  end;
end;

// Считываем задания из файла
function ReadTasks(pos:integer; fadr:string):boolean;  //F - имя файла с заданием, pos - позиция в массиве
var i:integer;
f:textfile;
s:string;
begin
 if FileExists(fadr) then
  try
    assignfile(f,fadr);
    reset(f);
    // Читаем основные параметры
    readln(f,s);
    Task[pos].id:=s;
    readln(f,s);
    Task[pos].name:=s;
    readln(f,s);
    Task[pos].filename:=s;
    readln(f,s);
    Task[pos].ImgPatch:=s;
    readln(f,s);
    Task[pos].timeS:=strtotime(s);
    readln(f,s);
    Task[pos].timePO:=strtotime(s);
    Task[pos].script:=TStringList.Create;
    // читаем скрипт
    While not eof(f) do
      begin
       readln(f,s);
       Task[pos].script.Append(s);
      end;
    CloseFile(f);
    except
     addlog('Ошибка чтения файла с заданием '+fadr);
    end
 else
  addlog('Файл с заданием '+fadr+' не найден.');
end;

// Подготовка к загрузке заданий
procedure PreLoadTasks;
var ini:textfile;
s:string;
i:integer;
begin
  try
    TaskList.Free;
  except
  end;
  SetLength(Task,0);
  TaskList:=TStringList.Create;
  try
    assignfile(ini,'tasklist.cfg');
    reset(ini);
   while not eof(ini) do
    begin
     readln(ini,s);
     TaskList.Append(s);
    end;
   Closefile(ini);

   // Считываем все сохраненные задания
   for i:=0 to TaskList.Count-1 do
    begin
     SetLength(Task,length(Task)+1);
     ReadTasks(i,TaskList.Strings[i]);
    end;

  except
    addlog('Не удалось считать список заданий');
    end;
End;

procedure Process(id:integer);
var
  B,B2: TBitmap;
  Desktop: TDesktopCanvas;
  QP,QP2: TQuickPixel;
  X, Y, X2, Y2: Integer;
  Xwin,YWin: Integer;
  Temp: TColor;
  qp1h,qp1w:integer;
  Year, Mounth, Day, hour,min,sec,sec100:word;
  FindImage2:boolean;
label Finall;
begin
  DecodeTime(Time,hour,min,sec,sec100);
  DecodeDate(Date,Year, Mounth, Day);

  if TimeOf(Task[id].timeS)<TimeOf(Task[id].timePO) then
       if (TimeOf(Time)>TimeOf(Task[id].timeS)) and (TimeOf(Time)<TimeOf(Task[id].timePO)) then
          sleep(1)
       else
         Exit
  else
   if (TimeOf(Time)<TimeOf(Task[id].timeS)) and (TimeOf(Time)<TimeOf(Task[id].timePO)) then
     sleep(1)
   else
      Exit;

  try
  B:= nil;
  Desktop:= nil;
  except
    end;
  try

    //addlog('Пытаюсь сфоткать экран');
    // Фоткаем экран
    Desktop:= TDesktopCanvas.Create;
    B:= TBitmap.Create;
    B2:= TBitmap.Create;
    B2.LoadFromFile(Task[id].ImgPatch);
    B.Width:= Screen.Width;
    B.Height:= Screen.Height;
    B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
  //  B.PixelFormat:= pf24bit;
//    QPOld:=TQuickPixel.Create(BOld);
//    BOld.Assign(B);
    QP:=TQuickPixel.Create(B);
    qp1h:=QP.Height;
    qp1w:=QP.Width;
    QP2:=TQuickPixel.Create(B2);
    FindImage:=false;
   // B.SaveToFile(ExePatch+'scrLog\'+'1.bmp');
   // B2.SaveToFile(ExePatch+'scrLog\'+'12.bmp');
   // addlog('Сфоткал');
    if (qp1h=0) or (qp1w=0) or (QP2.Height=0) or (QP2.Width=0) then goto Finall;
    For X:=0 to qp1w-1 do
    begin
      for Y:=0 to qp1h-1 do
        if QP.Pixel[X,Y]=QP2.Pixel[0,0] then
          begin
            XWin:=X;
            YWin:=Y;
            if TryImg(X,Y,QP,QP2) then
            begin
             FindImage:=true;
             Break;
            end;
          end;
     if FindImage then Break;
    end;
   // if not FindImage then addlog('Не нашел совпадений');
    if FindImage then
      begin
       addlog(Task[id].name+': Найдено совпадение с картинкой '+Task[id].ImgPatch+' в точке '+inttostr(X)+','+inttostr(Y)+'. Запускается скрипт.');
       //       DecodeTime(Task[id].timeS,hour2,min2,sec2,sec1002);
//       DecodeTime(Task[id].timePO,hour3,min3,sec3,sec1003);

//       Odin:=true;
//       if (QPOld.Height<>0) and (QPOld.Width<>0) then
//       for x3:=0 to QP.Width do
//        for y3:=0 to QP.Height-50 do
//         if QP.Pixel[x3,y3]<>QPOld.Pixel[x3,y3] then
//          begin
//           Odin:=false;
//           goto SaveImg;
//          end;
//        SaveImg:
//        if Odin then
        B.SaveToFile(ExePatch+'scrLog\'+'scr-'+inttostr(day)+inttostr(Mounth)+inttostr(Year)+'-'+inttostr(hour)+inttostr(min)+inttostr(sec)+'.bmp');
       FindImage2:=false;
       try
        // B.Free;
        // B2.Free;
        // Desktop.Free;
       //  qp.Free;
       //  qp2.Free;
         B:= nil;
         Desktop:= nil;
         // Фоткаем экран
         Desktop:= TDesktopCanvas.Create;
          B:= TBitmap.Create;
          B2:= TBitmap.Create;
          B2.LoadFromFile('Подробно.bmp');
          B.Width:= Screen.Width;
          B.Height:= Screen.Height;
          B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
          B.PixelFormat:= pf24bit;
         QP:=TQuickPixel.Create(B);
         qp1h:=QP.Height;
         qp1w:=QP.Width;
         QP2:=TQuickPixel.Create(B2);

             For X:=0 to qp1w-1 do
             begin
                for Y:=0 to qp1h-1 do
                  if QP.Pixel[X,Y]=QP2.Pixel[0,0] then
                     begin
                       XWin:=X;
                        YWin:=Y;
                        if TryImg(X,Y,QP,QP2) then
                        begin
                            FindImage2:=true;
                            Break;
                         end;
                     end;
               if FindImage2 then Break;
              end;
         If FindImage2 then
         begin
           // Тыкаем мышкой в картинку
             setcursorpos(X+10,Y+10);
             sleep(100);
             mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
             sleep(10);
             mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
             sleep(100);
         //    B.Free;
          //   Desktop.Free;
             B:= nil;
             Desktop:= nil;
             Desktop:= TDesktopCanvas.Create;
             B:= TBitmap.Create;
             B.Width:= Screen.Width;
             B.Height:= Screen.Height;
             B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
             B.SaveToFile(ExePatch+'scrLog\'+'подробно-'+inttostr(day)+inttostr(Mounth)+inttostr(Year)+'-'+inttostr(hour)+inttostr(min)+inttostr(sec)+'.bmp');
             B.PixelFormat:= pf24bit;
             sleep(500);
             SimulateKeystroke(VK_RETURN,0);
         end;
         Finally
       end;
           if not FindImage2 then
           begin
            // Тыкаем мышкой в картинку
             setcursorpos(X+5,Y+5);
             sleep(100);
             mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
             sleep(10);
             mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
             sleep(100);

             setcursorpos(X+5,Y+5);
             sleep(100);
             mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
             sleep(10);
             mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
             sleep(100);

             setcursorpos(X+5,Y+5);
             sleep(100);
             mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
             sleep(10);
             mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
             sleep(100);

             addlog('По умолчанию тычу мышкой в картинку, жму Enter и жду 5 секунд...');
             CmdParse('','key','Enter');
             sleep(10);
             CmdParse('','key','Enter');
             Sleep(5000);
            end;


        if Task[id].timeS=Task[id].timePO then
        begin
         Scripting(id);
         goto Finall;
        end;

       //addlog(floattostr(TimeOf(time))+' '+floattostr(TimeOf(Task[id].timeS))+' '+floattostr(TimeOf(Task[id].timePO))+' ');
       if TimeOf(Task[id].timeS)<TimeOf(Task[id].timePO) then
          if (TimeOf(Time)>TimeOf(Task[id].timeS)) and (TimeOf(Time)<TimeOf(Task[id].timePO)) then
             Scripting(id)
          else
             addlog('Скрипт запущен не был, т.к. время не вписывается в заданный в задании интервал.')
       else
          if (TimeOf(Time)<TimeOf(Task[id].timeS)) and (TimeOf(Time)<TimeOf(Task[id].timePO)) then
            Scripting(id)
          else
            addlog('Скрипт запущен не был, т.к. время не вписывается в заданный в задании интервал.');
      end;

  Finall:
//    B.Free;
//    B2.Free;
//    Desktop.Free;
//    qp.Free;
//    qp2.Free;
  finally
    try
     B.Free;
     B2.Free;
      Desktop.Free;
      qp.Free;
      qp2.Free;
    except
      end
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var i:integer;
begin
 Form1.ListBox1.Clear;
 try
  for i:=0 to length(Task)-1 do
   form1.ListBox1.Items.Append(Task[i].id+' '+Task[i].name);
  except
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i:integer;
pos:TPoint;
begin
Getcursorpos(Pos);
Xpos.Caption:=inttostr(Pos.X);
Ypos.Caption:=inttostr(Pos.Y);
if g_select_index<>1813218121 then
 begin
  Button5.Enabled:=true;
//  ShowMessage('111');
 end
  else Button5.Enabled:=false;
 if g_reloadTasks then
  begin
    g_reloadTasks:=false;
    PreLoadTasks;
     Form1.ListBox1.Clear;
    try
    for i:=0 to length(Task)-1 do
     form1.ListBox1.Items.Append(Task[i].id+' '+Task[i].name);
    except
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var ini:textfile;
process:TStringList;
pcount,i:integer;
var x,y:integer;
begin
  // Завершам работу, если копия уже запущена
 pcount:=0;
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 for i:=0 to process.Count-1 do
  if process[i]='WAgent.exe' then pcount:=pcount+1;
  if pcount>1 then Application.Terminate;

  process.Free;

// pcount:=0;
// process:=TStringList.Create;
// process.Clear;
// process:=GetProcess;
// for i:=0 to process.Count-1 do
//  if process[i]='process_starter.exe' then pcount:=pcount+1;
//  if pcount<1 then
//    try
//      WinExec('process_starter.exe',0);
//      except
//        end;
//
//  process.Free;
  g_select_index:=1813218121;
  ExePatch:=extractfilepath(paramstr(0));
 // Создадим файл настроек
  if not FileExists(ExePatch+'tasklist.cfg') then
  try
   assignfile(ini,'tasklist.cfg');
   rewrite(ini);
   Closefile(ini);
  except
    addlog('Не удалось создать список заданий.');
  end;
  if not DirectoryExists(ExePatch+'scrLog') then CreateDir(ExePatch+'scrLog');
  
 PreLoadTasks; // загрузим задания


 if not RegisterHotkey(Handle, 2, MOD_ALT, VK_F2) then
  ShowMessage('Unable to assign Alt-F2 as hotkey.');

 addlog('Программа запущена на '+GetComputerNName);
 for i:=0 to ParamCount do
  if ParamStr(i)='/run' then
    try
      if g_status then
       begin
        Button1.Caption:='Запустить';
        StatusL.Caption:='Выключено';
        StatusL.Font.Color:=clRed;
        Engine.Enabled:=false;
        g_status:=false;
        end
      else
       begin
        // Сотрем рисунок с формы
         for x:=0 to Image1.Picture.Bitmap.Width do
           for y:=0 to Image1.Picture.Bitmap.Height do
             Image1.Picture.Bitmap.Canvas.Pixels[x,y]:=clBtnFace;

        Button1.Caption:='Остановить';
        StatusL.Caption:='Включено';
        StatusL.Font.Color:=clGreen;
        Engine.Enabled:=true;
        g_status:=true;
       end;
     timer2.Enabled:=true;
    except
    end;
end;
procedure TForm1.ListBox1Click(Sender: TObject);
var index:string;
i,len,ind:integer;
begin
  if ListBox1.Items.Strings[ListBox1.ItemIndex]<>'' then
    begin
     ind:=0;
     i:=1;
     index:='';
     len:=length(ListBox1.Items.Strings[ListBox1.ItemIndex]);
     while (copy(ListBox1.Items.Strings[ListBox1.ItemIndex],i,1)<>' ') and (i<len) do
      begin
       index:=index+copy(ListBox1.Items.Strings[ListBox1.ItemIndex],i,1);
       i:=i+1;
      end;
     for i:=0 to length(Task)-1 do
      if index=Task[i].id then
        ind:=i;
     g_select_index:=ind;
     try
      if not g_status then
        Image1.Picture.LoadFromFile(Task[g_select_index].ImgPatch);
     except
       addlog('Не могу загрузить картинку '+Task[g_select_index].ImgPatch);
       end;
     DateTimePicker1.Time:=Task[g_select_index].timeS;
     DateTimePicker2.Time:=Task[g_select_index].timePO;
     Memo1.Clear;
     For i:=0 to Task[g_select_index].script.Count-1 do
      memo1.Lines.Append(Task[g_select_index].script.Strings[i]);
     DateTimePicker1.Enabled:=true;
     DateTimePicker2.Enabled:=true;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
f:textfile;
begin
    try
     Task[g_select_index].timeS:=DateTimePicker1.Time;
     Task[g_select_index].timePO:=DateTimePicker2.Time;
     assignfile(f,ExePatch+Task[g_select_index].filename);
     rewrite(f);
     Writeln(f,Task[g_select_index].id); // записали индекс
     Writeln(f,Task[g_select_index].name); // записали имя
     Writeln(f,Task[g_select_index].filename); // записали имя файла задания
     Writeln(f,Task[g_select_index].ImgPatch); // записали адрес картинки
     Writeln(f,timetostr(Task[g_select_index].timeS));  // время С
     Writeln(f,timetostr(Task[g_select_index].timePO)); // Время ПО
     Task[g_select_index].script.Clear;
     for i:=0 to memo1.Lines.Count-1 do
     if memo1.Lines.Strings[i]<>'' then
      begin
       Task[g_select_index].script.Append(memo1.Lines.Strings[i]);
       Writeln(f,Task[g_select_index].script.Strings[i]); // записали строку скрипта
      end;
     Closefile(f);
      except
      addlog('Не могу сохранить файл настроек '+ExePatch+Task[g_select_index].filename);
        end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
vsego:array[1..255] of string;
est:array[1..255] of string;
i:integer;
begin
 for i:=1 to 255 do
  begin
   vsego[i]:=inttostr(i);
  end;
 for i:=0 to length(Task)-1 do
  est[i+1]:=task[i].id;
 for i:=1 to 255 do
  if vsego[i]<>est[i] then
    begin
     form2.taskid.Text:=vsego[i];
     Break;
    end;
 Form2.Visible:=true;
 Form2.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,y:integer;
begin
 if g_status then
  begin
   Button1.Caption:='Запустить';
   StatusL.Caption:='Выключено';
   StatusL.Font.Color:=clRed;
   Engine.Enabled:=false;
   g_status:=false;
  end
 else
  begin
   // Сотрем рисунок с формы
   for x:=0 to Image1.Picture.Bitmap.Width do
    for y:=0 to Image1.Picture.Bitmap.Height do
      Image1.Picture.Bitmap.Canvas.Pixels[x,y]:=clBtnFace;

   Button1.Caption:='Остановить';
   StatusL.Caption:='Включено';
   StatusL.Font.Color:=clGreen;
   Engine.Enabled:=true;
   g_status:=true;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.EngineTimer(Sender: TObject);
var i:integer;
begin
 Engine.Enabled:=false;
 For i:=0 to length(Task)-1 do
  Process(i);
 Engine.Enabled:=true;
end;

procedure TForm1.N1Click(Sender: TObject);
var i:integer;
list:TStringList;
f:textfile;
begin
 list:=TStringList.Create;
 for i:=0 to TaskList.Count-1 do
  if TaskList.Strings[i]<>Task[g_select_index].filename then
    list.Append(TaskList.Strings[i]);
 TaskList:=list;
// list.Destroy;
 try
   assignfile(f,'tasklist.cfg');
   rewrite(f);
   for i:=0 to TaskList.Count-1 do
      Writeln(f,TaskList.Strings[i]);
   Closefile(f);
   except
     end;
 deletefile(Task[g_select_index].filename);
 g_reloadTasks:=true;
 end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
UnRegisterHotkey( Handle, 2 );
addlog('Программа закрыта на '+GetComputerNName);
end;

procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if (msg.hotkey = 2) then
    if form1.Visible then form1.Visible:=false
    else form1.Visible:=true;
  end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if g_select_index<>1813218121 then
    begin
     form3.taskid.Text:=inttostr(g_select_index);
     form3.TaskName.Text:=Task[g_select_index].name;
     form3.fname.Text:=Task[g_select_index].filename;
     form3.ImgPatch.Text:=Task[g_select_index].ImgPatch;
     form3.Memo1.Lines:=Task[g_select_index].script;
     form3.DateTimePicker1.Time:=Task[g_select_index].timeS;
     form3.DateTimePicker2.Time:=Task[g_select_index].timePO;
    end;
 Form3.Visible:=true;
 Form3.Show;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
 timer2.Enabled:=false;
 form1.Visible:=false;
 form2.Visible:=false;
 form3.Visible:=false;
end;

end.
