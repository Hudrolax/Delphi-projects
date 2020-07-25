unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, StdCtrls, ExtCtrls, gvar, Registry, inifiles;

type
  TForm1 = class(TForm)
    ComPort: TBComPort;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    ListBox1: TListBox;
    Button1: TButton;
    Label3: TLabel;
    Timer2: TTimer;
    Label4: TLabel;
    Edit1: TEdit;
    Timer3: TTimer;
    Timer4: TTimer;
    PiakTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure PiakTimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  str:string;
  Ini: Tinifile;
  g_Port:string;
  g_Mode:string;
  g_Path:string;

var ReadyToWork:boolean;
implementation

{$R *.dfm}
procedure SetToReg;
var reg: tregistry;
begin
reg := tregistry.create;
reg.rootkey := HKEY_LOCAL_MACHINE;
reg.lazywrite := false;
reg.openkey('software\microsoft\windows\currentversion\run', false);
reg.writestring('CPScanProcess', application.exename+' /auto'); {вместо programma можно вставить что нибудь своё}
reg.closekey;
reg.free;
end;

function SetName2(n:integer):string;
var 
dateV,timeV:string;
begin
 dateV:=DateBezTochek(date);
 timeV:=TimeBezTochek(time);
 if Length(TimeV)=5 then
  TimeV:='0'+TimeV;
 result:=copy(dateV,5,4)+copy(dateV,3,2)+copy(dateV,1,2)+TimeV;
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

procedure FindAndCopy();
var
  F: TSearchRec;
  Path1: string;
begin
  Path1 := 'c:\scan\*.code';
  if FindFirst(Path1, faAnyFile, F) = 0 then
  begin
    repeat
      if CopyFile(pchar('c:\scan\'+f.Name),pchar(g_path+'\'+f.name),false) then
        begin
         CopyFile(pchar('c:\scan\'+copy(f.Name,1,length(f.name)-4)+'f'),pchar(g_path+'/'+copy(f.Name,1,length(f.name)-4)+'f'),false);
         DeleteFile('c:\scan\'+f.Name);
         DeleteFile('c:\scan\'+copy(f.Name,1,length(f.name)-4)+'f');
        end;
    until FindNext(F) <> 0;

    // Должен освободить ресурсы, используемые этими успешными, поисками
    FindClose(F);
  end;
end;
  
procedure TForm1.Timer4Timer(Sender: TObject);
begin
FindAndCopy();
end;

Procedure Log(s:string);
var log:textfile;
begin
 Form1.ListBox1.Items.Add(DateToStr(Date)+' '+TimeToStr(time)+': '+s);
 try
  assignfile(log,g_Path+'scan_log.log');
  if not FileExists(g_Path+'scan_log.log') then
    rewrite(log)
  else Append(log);
  Writeln(log,'['+GetDateT+'] '+s);
  CloseFile(log);
 except
   ShowMessage('Не могу получить доступ на запись в '+g_Path+'scan_log.log');
 end;

end;

procedure inicializeCOM();
var FindScan:boolean;
i:integer;
begin
 Form1.Label2.Font.Color:=clRed;
 Form1.Label2.Caption:='Инициализация сканера...';
 FindScan:=false;
 if g_Port='' then
  for i:=0 to 99 do
    begin
     try
      Form1.ComPort.Port:='COM'+inttostr(i);
      Form1.ComPort.Open;
      g_Port:='COM'+inttostr(i);
      FindScan:=true;
      ReadyToWork:=true;
      Form1.Label2.Font.Color:=clGreen;
      Form1.Label2.Caption:='Готов к Работе. Сканер найден на COM'+IntToStr(i);
      Log('Сканер найден на COM'+IntToStr(i)+'. Готов к работе.');
      except
       FindScan:=False;
       end;
      if FindScan then Break;
      Application.ProcessMessages;
    end
  else
     begin
      try
       Form1.ComPort.Port:=g_port;
       Form1.ComPort.Open;
       ReadyToWork:=true;
       Form1.Label2.Font.Color:=clGreen;
       Form1.Label2.Caption:='Готов к Работе. Сканер найден на '+g_port;
       Log('Сканер найден на '+g_Port+'. Готов к работе.');
      except
       //ShowMessage('Ошибка 0');
      end;
       end;
  if not ReadyToWork then
    ShowMessage('Сканер ШТРИХ-кодов не найден или не настроен на работу через COM Port!');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
process:TStringList;
pcount,i:integer;
begin
  // Завершам работу, если копия уже запущена
 pcount:=0;
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 for i:=0 to process.Count-1 do
  if process[i]='CPScanProcess.exe' then pcount:=pcount+1;

 if pcount>1 then Application.Terminate;

  process.Free;

  if not RegisterHotkey(Handle, 2, MOD_ALT, VK_F1) then
  ShowMessage('Unable to assign Alt-F1 as hotkey.');

 SetToReg;

  ReadyToWork:=False;
 //patch:=GetSpecialFolderPath($23)+'\scan\';

 Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
 g_Port:=ini.ReadString('General','COMPort','COM1');
 g_Mode:=ini.ReadString('General','Mode','3');
 g_Path:=Ini.ReadString('General','Path','c:\scan\');
 g_Path:=g_Path+'\';
 Edit1.Text:=g_port;
 Ini.Free;

 If NOT DirectoryExists(g_Path) then
  if not CreateDir(g_Path) then
    begin
      ShowMessage('Не могу создать папку '+g_Path+', пытаюсь создать c:\scan');
      sleep(1000);
      if not CreateDir('c:\scan') then
        ShowMessage('Не могу создать папку '+g_Path);
    end;
 If NOT DirectoryExists('c:\scan') then
  CreateDir('c:\scan');

 Log('Программа запущена на '+GetComputerNName);
timer1.Enabled:=true;
// for i:=0 to ParamCount do
  if ParamStr(1)='/auto' then
   timer2.Enabled:=true;
 end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var f:textfile;
begin
 timer3.Enabled:=false;
 try
   Form1.ComPort.Close;
   except
     end;
 Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'config.ini'); //Создаем файл настроек
 Ini.WriteString('General','ComPort',Edit1.Text);
 Ini.WriteString('General','Mode',g_Mode);
 Ini.WriteString('General','Path',g_Path);
 Ini.Free;

 Log('Программа закрыта на '+GetComputerNName);
 UnRegisterHotkey( Handle, 2 );

 AssignFile(f,'kill.bat');
 rewrite(f);
 write(f,'taskkill.exe /F /IM scan_process_control.exe');
 Closefile(f);
 winexec('kill.bat',0);
 sleep(1000);
 Deletefile('kill.bat');
 sleep(2000);

end;

procedure TForm1.WMHotkey( var msg: TWMHotkey );
 begin
  if (msg.hotkey = 2) then
    if form1.Visible then form1.Visible:=false
    else form1.Visible:=true;
  end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 timer1.Enabled:=false;
 inicializeCOM; // Инициализируем сканер (найдем где он и установим связь)
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.ComPortRxChar(Sender: TObject; Count: Integer);
var s:string;
begin
 ComPort.ReadStr(s,count);
 Str:=str+s;
 PiakTimer.Enabled:=false;
 PiakTimer.Enabled:=true;
end;

 procedure TForm1.Timer2Timer(Sender: TObject);
begin
Timer2.Enabled:=false;
Form1.Visible:=false;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
 var
process:TStringList;
pcount,i:integer;
begin
 timer3.Enabled:=false;
 pcount:=0;
 process:=TStringList.Create;
 process.Clear;
 process:=GetProcess;
 for i:=0 to process.Count-1 do
  if process[i]='scan_process_control.exe' then pcount:=pcount+1;

 if pcount<1 then WinExec('scan_process_control.exe',0);

  process.Free;

 timer3.Enabled:=true;
end;


procedure TForm1.PiakTimerTimer(Sender: TObject);
var
h,i:Integer;
strit:string;
nname:string;
nname2:string;
yea:Boolean;
f:textfile;
begin
  PiakTimer.Enabled:=false;
  for h:=1 to length(str) do
     if IsDigit(copy(str,h,1)) then
        strit:=strit+copy(str,h,1);
  str:=strit;

 try
   yea:=false;
     nname:=SetName2(0);
     for i:=0 to 9 do
      begin
        nname2:=nname+inttostr(i);
       if not FileExists(g_Path+nname2+'.code') then
        begin
         try
          AssignFile(f,g_Path+nname2+'.code');
         except
          Log('Не могу записать в '+g_Path+nname2+'.code');
          AssignFile(f,'c:\scan\'+nname2+'.code');
           end;

         yea:=true;
         Break;
        end;
      end;
    if not yea then
     begin
       Log('Нет свободных имен для кода '+str);
       Exit;
     end;
     rewrite(f);
     Write(f,str);
     CloseFile(f);

     try
       AssignFile(f,g_Path+nname2+'.f');
       rewrite(f);
       Closefile(f);
       except
         end;
    Log('Прочитано: '+str);
    str:='';
  except
    Log('Какое-то говно случилось!');
  end;
end;

end.
