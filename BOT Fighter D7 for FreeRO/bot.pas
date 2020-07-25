unit bot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, inifiles, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    xpos: TLabel;
    Label3: TLabel;
    ypos: TLabel;
    Label2: TLabel;
    colr: TLabel;
    colg: TLabel;
    colb: TLabel;
    Label4: TLabel;
    swith: TLabel;
    Image1: TImage;
    enemy: TImage;
    loot: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Label12: TLabel;
    Label10: TLabel;
    StaticText4: TStaticText;
    Bevel1: TBevel;
    StaticText6: TStaticText;
    flagloot: TCheckBox;
    flagmove: TCheckBox;
    flagskill: TCheckBox;
    flagfly: TCheckBox;
    flaghp: TCheckBox;
    Image2: TImage;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    xcenter: TEdit;
    ycenter: TEdit;
    StaticText9: TStaticText;
    radius: TEdit;
    Label17: TLabel;
    Label22: TLabel;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    timewing: TEdit;
    timeskill: TEdit;
    Bevel2: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    regtimer: TTimer;
    flagattack: TCheckBox;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    flagawak: TCheckBox;
    dfdf: TStaticText;
    Label5: TLabel;
    StaticText14: TStaticText;
    Edit1: TEdit;
    Timer4: TTimer;
    Timer5: TTimer;
    Date1: TDateTimePicker;
    flagteleport: TCheckBox;
    StaticText15: TStaticText;
    Label6: TLabel;
    StaticText16: TStaticText;
    timeteleport: TEdit;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    Edit3: TEdit;
    StaticText22: TStaticText;
    StaticText24: TStaticText;
    actiontimer: TTimer;
    moveflag: TCheckBox;
    Timer6: TTimer;
    chattimer: TTimer;
    Timer7: TTimer;
    moveflag2: TCheckBox;
    CheckBox1: TCheckBox;
    flagheal: TCheckBox;
    Label7: TLabel;
    stoptimer: TTimer;
    Label8: TLabel;
    logouttimer: TTimer;
    wakeuptimer: TTimer;
    Edit2: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    Label11: TLabel;
    CheckBox2: TCheckBox;
         procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actiontimerTimer(Sender: TObject);
    procedure flagteleportClick(Sender: TObject);
    procedure flagmoveClick(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure chattimerTimer(Sender: TObject);
    procedure Timer7Timer(Sender: TObject);
    procedure moveflagMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure moveflag2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stoptimerTimer(Sender: TObject);
    procedure logouttimerTimer(Sender: TObject);
    procedure wakeuptimerTimer(Sender: TObject);
   
                 private
  procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
      { Private declarations }
  public
          { Public declarations }
  end;
 type regfile = record
  name:string[255];
  key:string[255];
  date:string[255];
  activited:boolean;
 end;
  type RGBColor = record
  R,G,B:byte;
  end;
type regstat = record
  count:byte;
  time:byte;
  fly:boolean;
  end;

type timerval2 = record
  timerint:integer;
  labelint:integer;
  end;

  tlogout = class(tthread)
private
{ private declarations }
protected
procedure execute; override;
end;

var
  Form1: TForm1;
  DC,dc2:HDC; //экран
  Rect: TRect;
  WND,wnd2:HWND; //Экран
  h:HWND; //Хендл Окна
  a,b,c,deltaR,deltaRrad,ks,km:integer; //Счетчика таймера
  start:boolean;
  go,cenemy,cloot,reghp,regsp,gethendl:boolean;
  regen:regstat;
  regv:regfile;
  f:file of regfile;
  count:double;
  Ini: Tinifile;
  regactive,stop:boolean;
  action1,ubegan:boolean;
  kr:real;
  point:Tpoint;
  logoutth: tlogout;
  fl,flog,adress:textfile;
  adrRO,adrLog:string;
  timerval:timerval2;
  implementation

uses Unit3, Unit2;
 procedure tlogout.execute;
var fl:textfile;
s:string;
begin
s:='';

if fileexists('logout.st') then begin
try
assignfile(fl,'logout.st');
reset(fl);
readln(fl,s);

if ansipos('logout',s)<>0 then begin
form1.timer5.Enabled:=false;
form1.timer6.Enabled:=false;
form1.chattimer.Enabled:=false;
stop:=true;
form1.label8.Caption:='Stop';
form1.label8.Font.Color:=clred;

end;
if ansipos('work',s)=1 then begin
stop:=false;
form1.label8.Caption:='Start';
form1.label8.Font.Color:=clgreen;
form1.timer5.Enabled:=true;
form1.chattimer.Enabled:=true;

end;
closefile(fl);
except
showmessage('Файл logout.st не может быть открыт на запись');
end;
end;
end;

{$R *.dfm}
procedure logoutprocess;
begin
PostMessage(h,WM_KEYDOWN,vk_f6,0);
  sleep(10);
  PostMessage(h,WM_KEYUP,vk_f6,0);
  sleep(2000);
    PostMessage(h,WM_KEYDOWN,vk_return,0);
  sleep(10);
  PostMessage(h,WM_KEYUP,vk_return,0);
  sleep(1000);
  PostMessage(h,WM_KEYDOWN,vk_Escape,0);
  sleep(10);
  PostMessage(h,WM_KEYUP,vk_Escape,0);
  sleep(800);
  setcursorpos(331,356);
  sleep(200);
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
  sleep(10);
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
end;

function logoutbool:boolean;
begin
if (GetRValue(GetPixel(DC,600,123))=255) and
   (GetGValue(GetPixel(DC,600,123))=255) and
   (GetBValue(GetPixel(DC,600,123))=255) and
     (GetRValue(GetPixel(DC,43,253))=255) and
     (GetGValue(GetPixel(DC,43,253))=255) and
     (GetBValue(GetPixel(DC,43,253))=255) and
   (GetRValue(GetPixel(DC,224,105))=255) and
   (GetGValue(GetPixel(DC,224,105))=255) and
   (GetBValue(GetPixel(DC,224,105))=255) then

   logoutbool:=true else
   logoutbool:=false;
end;


procedure heal;
var
i:integer;
begin
 if form1.flagattack.checked then
  for i:=1 to strtoint(form1.edit4.text) do begin
if form1.flagattack.checked then begin
PostMessage(h,WM_KEYDOWN,VK_F7,0);
sleep(10);
PostMessage(h,WM_KEYUP,VK_F7,0);
sleep(10);
setcursorpos(320,244);
sleep(50);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
sleep(10);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
application.ProcessMessages;
sleep(700);
 end;
 end;
end;

function gp(x,y,r,g,b:integer):boolean;
begin
 if (GetRValue(GetPixel(DC2,x,y))=r) and
    (GetGValue(GetPixel(DC2,x,y))=g) and
    (GetBValue(GetPixel(DC2,x,y))=b) then gp:=True
    else gp:=false;

end;

procedure vhod;
begin

PostMessage(h, WM_CHAR, Ord('n'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('h'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('b'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('n'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('s'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('c'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('z'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('x'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('b'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('k'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('t'), 0);
sleep(50);
PostMessage(h, WM_CHAR, Ord('n'), 0);
sleep(500);
  PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
  sleep(50);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
  application.ProcessMessages;
  Sleep(2000);
    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
  sleep(50);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
  application.ProcessMessages;
  Sleep(5000);
 end;

procedure savechat;
begin
PostMessage(h, WM_CHAR, Ord('/'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('s'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('a'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('v'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('e'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('c'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('h'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('a'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('t'), 0);
sleep(100);
  PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
  sleep(100);
  PostMessage(h,WM_KEYUP,VK_RETURN,0);
end;

procedure showonline;
begin
PostMessage(h, WM_CHAR, Ord('@'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('s'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('h'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('o'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('w'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('o'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('n'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('l'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('i'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('n'), 0);
sleep(10);
PostMessage(h, WM_CHAR, Ord('e'), 0);
sleep(100);
  PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
  sleep(100);
  PostMessage(h,WM_KEYUP,VK_RETURN,0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var P,PT: TPoint;
pixe:array[0..3,0..3] of RGBcolor;
pixe2:array[0..3,0..3] of RGBcolor;
pixl:array[0..3,0..3] of RGBcolor;
pixl2:array[0..3,0..3] of RGBcolor;
n,m,k,l,xi,yi,c1,xp,yp,rp:integer;
pxl,hpclr,spclr:TColor;
inenter:Boolean;
//....
begin
label5.Caption:=edit1.Text;
label22.Caption:=timeskill.Text;
label17.caption:=timewing.Text;

xp:=strtoint(xcenter.text);
yp:=strtoint(ycenter.Text);
rp:=strtoint(radius.Text);
//Таймеры...
timer1.Interval:=strtoint(timeteleport.text)*1000;
timer2.Interval:=strtoint(timeskill.text)*1000;
regtimer.Interval:=strtoint(edit3.Text)*1000;
timer4.Interval:=strtoint(edit1.Text)*60000;
if timer1.Enabled then timer1.Enabled:=false else timer1.Enabled:=true;
if timer2.Enabled then timer2.Enabled:=false else timer2.Enabled:=true;
if timer3.Enabled then timer3.Enabled:=false else timer3.Enabled:=true;
if timer4.Enabled then timer4.Enabled:=false else timer4.Enabled:=true;
if start then start:=false else start:=true;

if start then begin
swith.Caption:='Включён';
swith.Font.Color:=$008000;
end
 else begin
 swith.Caption:='Выключен';
 swith.Font.Color:=$0000FF;
 end;
// Враг
 for n:=0 to 3 do
 for m:=0 to 3 do begin
 pixe[n,m].R:=GetRValue(getpixel(enemy.Canvas.Handle,2+n,2+m));
  pixe[n,m].g:=GetGValue(getpixel(enemy.Canvas.Handle,2+n,2+m));
  pixe[n,m].b:=GetBValue(getpixel(enemy.Canvas.Handle,2+n,2+m));
  end;
// Лут...
for n:=0 to 3 do
  for m:=0 to 3 do begin
  pixl[n,m].R:=GetRValue(getpixel(loot.Canvas.Handle,n,m));
  pixl[n,m].g:=GetGValue(getpixel(loot.Canvas.Handle,n,m));
  pixl[n,m].b:=GetBValue(getpixel(loot.Canvas.Handle,n,m));
  end;

WND:=Windows.GetDesktopWindow; //Весь рабочий стол
DC:=Windows.GetWindowDC(WND); //графич. часть рабоч стола
WND2:=GetForegroundWindow; //Получаем дескриптор активного окна
DC2:=Windows.GetWindowDC(WND2); //Получаем дескриптор активного окна.
// Начало
while (start) and (NOT application.Terminated) do begin
//Вход
if flagattack.Checked and gp(299,288,24,44,49) then
 begin
  inenter:=True;
 vhod;
 Sleep(2000);
          PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
    Sleep(5000);
 end;
 if inenter and gp(331,233,0,0,0) then Continue;

 if gp(351,250,0,0,0) or gp(351-1,250-1,0,0,0) or gp(351+1,250+1,0,0,0)
    or gp(351+1,250,0,0,0) or gp(351,250+1,0,0,0) or gp(351-1,250+1,0,0,0)
 then
  begin
    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
    end;

inenter:=False;    

if kr>=strtoint(radius.Text)-20 then kr:=0;
kr:=kr+0.4;
cenemy:=false;
cloot:=false;
GetCursorPos(P);
xpos.Caption:=IntToStr(P.X); //показываем координаты курсора
ypos.Caption:=IntToStr(P.Y);
For N:=0 to 20 DO //Считываем картинку
For M:=0 to 20 DO
  Begin
      Pxl:=GetPixel(DC,P.X-1+N,P.Y-1+M);//DC
    windows.setpixel(Image1.Canvas.Handle,N,M,PXL);
  End;
for n:=294 to 349 do
  for m:=271 to 275 do
  begin
  hpclr:=GetPixel(DC2,n,m);
  windows.SetPixel(Image2.Canvas.Handle,n-294,m-271,hpclr);
  end;

//Убегание
 if flagfly.Checked and flagmove.Checked and (not stop) then
  if (regen.fly) and (regtimer.Enabled)then begin
  PostMessage(h,WM_KEYDOWN,VK_F6,0);
  sleep(10);
  PostMessage(h,WM_KEYUP,VK_F6,0);
  regen.fly:=false;
  regen.count:=0;
  regtimer.Enabled:=false;
  end;

    //Лечение
 if flaghp.Checked and (not stop)then begin
  for n:=0 to 55 do
   for m:=0 to 2 do
     if (GetRValue(getpixel(image2.Canvas.Handle,n,m))>225) and
        (GetRValue(getpixel(image2.Canvas.Handle,n,m))<256) and
      (GetGValue(getpixel(image2.Canvas.Handle,n,m))>13) and
        (GetGValue(getpixel(image2.Canvas.Handle,n,m))<26) and
      (GetBValue(getpixel(image2.Canvas.Handle,n,m))>13) and
        (GetBValue(getpixel(image2.Canvas.Handle,n,m))<26)
      then reghp:=true;

 end;

  // Процесс лечени
  if flagfly.Checked and flagteleport.Checked and (not stop) then
    if reghp then begin
    PostMessage(h,WM_KEYDOWN,VK_F6,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_F6,0);
    sleep(1000);
//    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
//    sleep(10);
//    PostMessage(h,WM_KEYUP,VK_RETURN,0);
//    sleep(10);
//    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
//    sleep(100);
//    PostMessage(h,WM_KEYUP,VK_RETURN,0);
//    sleep(10);
    reghp:=false;
//      if random(100)=5 then begin
//    PostMessage(h,WM_KEYDOWN,VK_F1,0);
//    sleep(10);
//    PostMessage(h,WM_KEYUP,VK_F1,0);
//                    end;

    timeteleport.Text:='100';
    c:=100;
    timer1.Interval:=100000;
    timer7.Enabled:=true;

    regen.fly:=false;
    regen.count:=0;
    regtimer.Enabled:=false;
    ubegan:=false;
    timer6.Enabled:=true;

    heal;
        mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    sleep(100);
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);

      timeteleport.Text:=edit2.Text;
    c:=strtoint(edit2.Text);
    timer1.Interval:=strtoint(edit2.Text)*1000;
    timer7.Enabled:=false;
    end;
//...


//   if (not stop) and((strtoint(label6.Caption)>50) and (strtoint(label6.Caption)<175 )) and (flagheal.Checked) then begin
//    sleep(50);
//    heal;
//    sleep(200);
//
//    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
//    sleep(10);
//mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
//sleep(100);
//mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
//    sleep(10);
//mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
//sleep(10);
// timeteleport.Text:=edit2.Text;
//    c:=strtoint(edit2.Text);
//    timer1.Interval:=strtoint(edit2.Text)*1000;
//    timer7.Enabled:=false;
//    end;

//сравнение картинок...
  //Enemy
  for n:=0 to 3 do
  for m:=0 to 3 do begin
  pixe2[n,m].R:=GetRValue(getpixel(image1.Canvas.Handle,2+n,2+m));
  pixe2[n,m].g:=GetGValue(getpixel(image1.Canvas.Handle,2+n,2+m));
  pixe2[n,m].b:=GetBValue(getpixel(image1.Canvas.Handle,2+n,2+m));
   end;
   //Loot
  for n:=0 to 3 do
  for m:=0 to 3 do begin
  pixl2[n,m].R:=GetRValue(getpixel(image1.Canvas.Handle,n,m));
  pixl2[n,m].g:=GetGValue(getpixel(image1.Canvas.Handle,n,m));
  pixl2[n,m].b:=GetBValue(getpixel(image1.Canvas.Handle,n,m));
  end;
  //Враг сравнение
  k:=0;
  for n:=0 to 3 do
   for m:= 0 to 3 do
     if ((pixe[n,m].r>=pixe2[n,m].r-10) and (pixe[n,m].r<=pixe2[n,m].r+10))
      and ((pixe[n,m].g>=pixe2[n,m].g-10) and (pixe[n,m].g<=pixe2[n,m].g+10))
      and ((pixe[n,m].b>=pixe2[n,m].b-10) and (pixe[n,m].b<=pixe2[n,m].b+10)) then begin
  k:=k+1;
   end;
  if k=16 then begin
   cenemy:=true;
  label12.Caption:='Сходство есть';
  label12.Font.Color:=$008000;
   end
  else begin
  cenemy:=false;
  label12.Caption:='Сходства нет';
  label12.Font.Color:=$0000FF;
   end;
   //....
  //Лут сравнение
  k:=0;
  for n:=0 to 3 do
   for m:= 0 to 3 do
     if ((pixl[n,m].r<=pixl2[n,m].r+10) and (pixl[n,m].r>=pixl2[n,m].r-10))
      and ((pixl[n,m].g<=pixl2[n,m].g+10) and (pixl[n,m].g>=pixl2[n,m].g-10))
      and ((pixl[n,m].b<=pixl2[n,m].b+10) and (pixl[n,m].b>=pixl2[n,m].b-10)) then
    begin
   k:=k+1;
   end;
  if k=16 then begin
   cloot:=true;
  label10.Caption:='Сходство есть';
  label10.Font.Color:=$008000;
   end
  else begin
  cloot:=false;
  label10.Caption:='Сходства нет';
  label10.Font.Color:=$0000FF;
   end;
  //Вывод цвета текущей точки
  colR.Caption:=inttostr(GetRValue(getpixel(DC, P.x,P.y)));
  colG.Caption:=inttostr(GetGValue(getpixel(DC, P.x,P.y)));
  colB.Caption:=inttostr(GetBValue(getpixel(DC, P.x,P.y)));
  application.ProcessMessages;


  //*********  Действия  ***********
  if (flagattack.Checked) and (not stop) then begin
   if NOT gethendl then begin
   gethendl:=true;
   end;
    //Атака
    if cenemy and (not CheckBox2.Checked) then begin
    mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    if NOT timer7.Enabled then begin
       timer1.Enabled:=false;
    timer1.Interval:=10000;
    label6.Caption:=('10');
    c:=10;
    timer1.Enabled:=true;
              end;

    end;

    // Убегание от врага
    if cenemy and (CheckBox2.Checked) then begin
     PostMessage(h,WM_KEYDOWN,VK_F6,0);
     sleep(10);
     PostMessage(h,WM_KEYUP,VK_F6,0);
              end;



   //Подбор лута
    if cloot and flagloot.Checked then begin
     mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
     sleep(10);
     mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
    action1:=true;
    actiontimer.Interval:=1000;
    actiontimer.Enabled:=true;
    end;

   //Двигаем мышку
  // Обычно

    if (NOT cenemy) and (NOT cloot) then begin
        count:=count+3.141592654/20;
     if (sin(count)=0) and (cos(count)=1) then count:=0;
     setcursorpos(trunc(xp+(rp-kr)*cos(count)),trunc(yp-(rp-kr)*sin(count)));
     end else gethendl:=false;
   sleep(20);

    // Ищем врага
  if false then begin
    if (NOT cenemy) and (NOT cloot) then begin
       if (deltaR>0) and (deltaR<55) then ks:=-2;
       count:=count+3.141592654/20+ks;
     if (sin(count)=0) and (cos(count)=1) then count:=0;
     point.x:=trunc(strtoint(xcenter.Text)+(0+deltaR)*cos(count));
     point.y:=trunc(strtoint(ycenter.Text)-(0+deltaR)*sin(count));
    deltaRrad:=deltaRrad+1;
     if deltaRrad=10 then deltaR:=deltaR+7;
     if deltaRrad>=10 then deltaRrad:=0;
     if deltaR>=210 then deltaR:=0;
     ks:=0;
   //  if deltaR>150 then
     // if (random(15)=2) and (moveflag.Checked) then begin
     //  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
   // mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
  //  end;

    end else gethendl:=false;
  end;

   //конец действий
  application.ProcessMessages; //....

  end;
    //Очищаем картинки
  Image1.Picture.Graphic := nil;
  Image2.Picture.Graphic := nil;
end;//********************** Конец цыкла ************************
end;//Конец процедуры Button1


procedure TForm1.FormCreate(Sender: TObject);
begin
 if not RegisterHotkey(Handle, 1, MOD_ALT, VK_F1) then
  ShowMessage('Unable to assign Alt-F1 as hotkey.');
 Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
 xcenter.text:=inttostr(ini.ReadInteger('Mouse','XCenter',400));
 ycenter.text:=inttostr(ini.ReadInteger('Mouse','YCenter',314));
 radius.text:=inttostr(ini.ReadInteger('Mouse','Radius',55));
 timewing.text:=inttostr(ini.ReadInteger('Время','WingTime',240));
 timeskill.text:=inttostr(ini.ReadInteger('Время','SkillTime',240));
 flagloot.Checked:=ini.readbool('Настройки','TakeLoot',true);
 flagmove.Checked:=ini.readbool('Настройки','WingMove',false);
 flagteleport.Checked:=ini.ReadBool('Настройки','TeleportMove',true);
 flagskill.Checked:=ini.readbool('Настройки','UseSkill',false);
 flagfly.Checked:=ini.readbool('Настройки','Run',true);
 flaghp.Checked:=ini.readbool('Настройки','HPRegen',true);
 flagawak.Checked:=ini.readbool('Настройки','awak',false);
 Ini.Free;

 if fileexists(adrRO) then deletefile(adrRo);
 if fileexists('logout.st') then begin
 try
 assignfile(fl,'logout.st');
rewrite(fl);
    writeln(fl,'work');
    closefile(fl);
    except
    showmessage('Файл logout.st не может быть открыт на запись');
    end;
     end else
    showmessage('Файл logout.st не найден в папке с ботом!!!');
 //регистрация
 // try
 // assignfile(f,'c:\reginfo.rbf');
 //  reset(f);
 // read(f,regv);
 // if regv.activited then begin
 // form1.Caption:=form1.Caption+' - '+regv.name;
 // button1.Enabled:=true;
 // button4.Enabled:=false;
 // closefile(f);
 // end
 // except
 // assignfile(f,'c:\reginfo.rbf');
 // rewrite(f);
 // regv.name:='none';
 // regv.key:='none';
 // regv.date:='none';
 // regv.activited:=false;
 // write(f,regv);
 // button1.Enabled:=false;
 // button4.Enabled:=true;
 // closefile(f);
 // form1.Caption:='BOT Fighter v1.3 - NOT REGISTERED';
 // end;
 try
 assignfile(adress,'adress.cfg');
 reset(adress);
 readln(adress,adrRO);
 readln(adress,adrLog);
 closefile(adress);
 except
 showmessage('Файл adress.cfg не может быть открыт на запись');
 end;
 end;

procedure TForm1.FormDestroy(Sender: TObject);
 begin
 UnRegisterHotkey( Handle, 1 );
 end;

 procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if msg.hotkey = 1 then
  if flagattack.Checked=false then begin
                                 flagattack.Checked:=true;
                                 h:=GetForegroundWindow;
                                 SetWindowPos(h,HWND_TOP,-3,-3,0,0,SWP_NOSIZE);

                                 WND2:=GetForegroundWindow; //Получаем дескриптор активного окна
                                 DC2:=Windows.GetWindowDC(WND2); //Получаем дескриптор активного окна.
                                  end
                                  else
  flagattack.Checked:=false;
  end;
//телепорт
procedure TForm1.Timer1Timer(Sender: TObject);
begin
if (flagmove.Checked) and (not stop) then begin
PostMessage(h,WM_KEYDOWN,VK_F6,0);
sleep(10);
PostMessage(h,WM_KEYUP,VK_F6,0);
a:=0;
timer1.Interval:=strtoint(timewing.Text)*1000;
end;
if flagteleport.checked and (flagattack.Checked) and (not stop) then begin
    PostMessage(h,WM_KEYDOWN,VK_F6,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_F6,0);
    sleep(1500);
    PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
    sleep(1000);
        PostMessage(h,WM_KEYDOWN,VK_RETURN,0);
    sleep(10);
    PostMessage(h,WM_KEYUP,VK_RETURN,0);
    sleep(1000);
    if moveflag.Checked then begin
    sleep(100);
    setcursorpos(585,375);
    sleep(100);
     mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
       sleep(20);
     mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);

    sleep(2000);
    setcursorpos(314,256);
    sleep(100);
     mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
       sleep(20);
      mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
         end else
     if moveflag2.Checked then begin
       setcursorpos(339,260);
       sleep(10);
     mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
    sleep(10);
    mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
     end;

    c:=0;
    timer1.Interval:=strtoint(timeteleport.Text)*1000;
    c:=strtoint(timeteleport.Text);
    end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
if flagskill.Checked and (not stop) then begin
PostMessage(h,WM_KEYDOWN,VK_F5,0);
sleep(10);
PostMessage(h,WM_KEYUP,VK_F5,0);
b:=0;
timer2.Interval:=strtoint(timeskill.Text)*1000;
end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
if (a=0) and (NOT flagteleport.Checked) and (not stop) then a:=strtoint(timewing.Text);
if b=0 then b:=strtoint(timeskill.Text);
  if (c=0) and (flagteleport.Checked) and (not stop) then c:=strtoint(timeteleport.Text);

a:=a-1;
b:=b-1;
c:=c-1;
if flagmove.Checked and (not stop) then label17.Caption:=inttostr(a);
if flagskill.Checked and (not stop) then label22.Caption:=inttostr(b);
if flagteleport.Checked and (not stop) then label6.Caption:=inttostr(c);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
Ini.WriteInteger('Mouse','XCenter',400);
Ini.WriteInteger('Mouse','YCenter',314);
Ini.WriteInteger('Mouse','Radius',55);
Ini.WriteInteger('Время','WingTime',240);
Ini.WriteInteger('Время','SkillTime',240);
Ini.WriteBool('Настройки','TakeLoot',true);
Ini.WriteBool('Настройки','WingMove',false);
Ini.WriteBool('Настройки','TeleportMove',true);
Ini.WriteBool('Настройки','UseSkill',true);
Ini.WriteBool('Настройки','Run',true);
Ini.WriteBool('Настройки','HPRegen',true);
Ini.WriteBool('Настройки','HPRegen2',false);
Ini.WriteBool('Настройки','Awak',false);
 xcenter.text:=inttostr(ini.ReadInteger('Mouse','XCenter',400));
 ycenter.text:=inttostr(ini.ReadInteger('Mouse','YCenter',314));
 radius.text:=inttostr(ini.ReadInteger('Mouse','Radius',55));
 timewing.text:=inttostr(ini.ReadInteger('Время','WingTime',240));
 timeskill.text:=inttostr(ini.ReadInteger('Время','SkillTime',240));
 flagloot.Checked:=ini.readbool('Настройки','TakeLoot',true);
 flagmove.Checked:=ini.readbool('Настройки','WingMove',false);
 flagteleport.Checked:=ini.readbool('Настройки','TeleportMove',true);
 flagskill.Checked:=ini.readbool('Настройки','UseSkill',true);
 flagfly.Checked:=ini.readbool('Настройки','Run',true);
 flaghp.Checked:=ini.readbool('Настройки','HPRegen',true);
 flagawak.Checked:=ini.readbool('Настройки','awak',false);
Ini.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
Ini.WriteInteger('Mouse','XCenter',strtoint(xcenter.text));
Ini.WriteInteger('Mouse','YCenter',strtoint(ycenter.text));
Ini.WriteInteger('Mouse','Radius',strtoint(radius.text));
Ini.WriteInteger('Время','WingTime',strtoint(timewing.text));
Ini.WriteInteger('Время','SkillTime',strtoint(timeskill.text));
Ini.WriteBool('Настройки','TakeLoot',flagloot.Checked);
Ini.WriteBool('Настройки','WingMove',flagmove.Checked);
Ini.WriteBool('Настройки','TeleportMove',flagteleport.Checked);
Ini.WriteBool('Настройки','UseSkill',flagskill.Checked);
Ini.WriteBool('Настройки','Run',flagfly.Checked);
Ini.WriteBool('Настройки','HPRegen',flaghp.Checked);
Ini.WriteBool('Настройки','Awak',flagawak.Checked);
Ini.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form3.Visible:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
form2.Visible:=true;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
if flagawak.Checked and (not stop) then begin
PostMessage(h,WM_KEYDOWN,VK_F8,0);
sleep(10);
PostMessage(h,WM_KEYUP,VK_F8,0);
c:=0;
timer4.Interval:=strtoint(edit1.Text)*60000;

end;
end;

procedure TForm1.Timer5Timer(Sender: TObject);
begin
if not stop then begin
if c=0 then c:=strtoint(timeteleport.Text);
c:=c-1;
label5.Caption:=inttostr(c)
end;;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
if TRUE then begin
try
 // assignfile(f,'c:\reginfo.rbf');
 // reset(f);
 // read(f,regv);
 if true then begin
 // form1.Caption:='BOT Fighter v1.4'+' - '+regv.name;
 button1.Enabled:=true;
 button4.Enabled:=false;
 // closefile(f);
 // regactive:=true;
 end
 else form1.Caption:='BOT Fighter v1.4 - NOT REGISTERED';
 except
 assignfile(f,'c:\reginfo.rbf');
 rewrite(f);
 regv.name:='none';
 regv.key:='none';
 regv.date:='none';
 regv.activited:=false;
 write(f,regv);
 button1.Enabled:=false;
 button4.Enabled:=true;
 closefile(f);
 form1.Caption:='BOT Fighter v1.4 - NOT REGISTERED';
 regactive:=true;
  end;
 end;
end;


procedure TForm1.actiontimerTimer(Sender: TObject);
begin
action1:=false;
actiontimer.Enabled:=false;
end;

procedure TForm1.flagteleportClick(Sender: TObject);
begin
if flagteleport.Checked then flagmove.Checked:=false;
end;

procedure TForm1.flagmoveClick(Sender: TObject);
begin
if flagmove.Checked then flagteleport.Checked:=false;

end;

procedure TForm1.Timer6Timer(Sender: TObject);
begin
ubegan:=true;
timer6.Enabled:=false;
end;

procedure TForm1.chattimerTimer(Sender: TObject);
begin
if flagattack.Checked and checkbox1.Checked and (not stop) then
if NOT FIleExists('C:\Ro\Chat\Chat.txt') then begin
showonline;
sleep(1000);
savechat;
end;
end;

procedure TForm1.Timer7Timer(Sender: TObject);
begin
timeteleport.Text:=edit2.Text;
c:=strtoint(edit2.Text);
timer1.Interval:=strtoint(edit2.Text)*1000;
timer7.Enabled:=false;
end;

procedure TForm1.moveflagMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if moveflag2.Checked then moveflag2.Checked:=false;
end;

procedure TForm1.moveflag2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if moveflag.Checked then moveflag.Checked:=false;
end;


procedure TForm1.stoptimerTimer(Sender: TObject);
begin
logoutth := tlogout.create(true);
logoutth.freeonterminate := true;
logoutth.priority := tplower;
logoutth.resume;
end;

procedure TForm1.logouttimerTimer(Sender: TObject);
var sdate,stime,s,slog:string;
begin //проверяем, нужен ли logout
 if stop then
 begin
   while not logoutbool do
   begin
   application.ProcessMessages;
   logoutprocess;
   sleep(6000);
   end;
 logouttimer.Enabled:=false;
 wakeuptimer.enabled:=true;

//Записываем событие в лог
 try
 assignfile(flog,'\chatterlog\logout.txt');
    Append(flog);
      sdate:=datetostr(date);
      stime:=timetostr(time);
      slog:=(sdate+' '+stime+' Бот выключен по тревоге');
    writeln(flog,slog);
    writeln(flog,s);
    writeln(flog,'');
    closefile(flog);
  except
  showmessage('Файл logout.txt не может быть открыт на запись');
  end;

 end;
end;




procedure TForm1.wakeuptimerTimer(Sender: TObject);
begin
    PostMessage(h,WM_KEYDOWN,vk_return,0);
  sleep(10);
  PostMessage(h,WM_KEYUP,vk_return,0);
 try
 assignfile(fl,'logout.st');
rewrite(fl);
    writeln(fl,'work');
    closefile(fl);
except
showmessage('Файл logout.st не может быть открыт на запись');
end;

    sleep(6000);
logoutth := tlogout.create(true);
logoutth.freeonterminate := true;
logoutth.priority := tpnormal;
logoutth.resume;
logouttimer.Enabled:=true;
wakeuptimer.Enabled:=false;



end;

end.
