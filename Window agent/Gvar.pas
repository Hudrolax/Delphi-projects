unit Gvar;

interface
uses SysUtils, Types, Windows, TLHELP32, Classes, StdCtrls, QuickPixel, DesktopCanvas, Graphics, Forms;

function IsDigit(s:string):boolean;
function IsDate(s:string):boolean;
function GetComputerNName: string;
function alphamin(s:string):string;
function GetFileDate(FileName: string): string;
function GetDateT:string;
function GetProcess:TStringList;
function FileVersion(AFileName: string): string;
function GetFileSize(const FileName:string):longint;
function DateBezTochek(k:TdateTime):string;
procedure AddLog(s:string);
procedure SimulateKeyDown(Key : byte);
procedure SimulateKeyUp(Key : byte);
procedure SimulateKeystroke(Key : byte; extra : DWORD);
procedure SendKeys(s : string);
function GetSystemDir:string;
function FindWindow2(AppHnd:hWnd): boolean;
function FindImg(QP2:TQuickPixel):Tpoint;

 type
 Ttask = record
  id:string;
  name:string;
  filename:string;
  timeS,timePO:TDateTime;
  ImgPatch:string;
  script:TStringList;
 end;

var
 g_select_index:integer; // Индекс элемента выбранного задания
 g_reloadTasks:boolean;
 g_status:boolean;
 Task:array of Ttask;
 TaskList:TStringList;
 ExePatch:string;

implementation
// Функция находит координаты картинки на экране
function FindImg(QP2:TQuickPixel):Tpoint;
  var x,y, x2, y2:integer;
  Desktop: TDesktopCanvas;
  B: TBitmap;
  QP: TQuickPixel;
  find:boolean;
begin
 result.X:=0;
 result.Y:=0;
 try
 Desktop:= TDesktopCanvas.Create;
 B:= TBitmap.Create;
 B.Width:= Screen.Width;
 B.Height:= Screen.Height;
 B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
 B.PixelFormat:= pf24bit;
 QP:=TQuickPixel.Create(B);
 for X:=0 to QP.Width do
  for Y:=0 to QP.Height do
    begin
     find:=true;
      IF QP.Pixel[X,Y] = QP2.Pixel[0,0] then
       begin
        for x2:=0 to QP2.Width do
          for y2:=0 to QP2.Height do
             if QP2.Pixel[x2,y2]<> QP.Pixel[x+x2,y+y2] then
                find:=false;

       end else Find:=false;
     if find then
      begin
       result.X:=X;
       result.Y:=Y;
       try
         B.Free;
         Desktop.free;
         QP.Free;
         except
           end;
       Exit;
      end;
    end
  finally
  B.Free;
  Desktop.free;
  QP.Free;
    end;
end;

// Найти окно по подстроке в заголовке
function FindWindow2(AppHnd:hWnd): boolean;
begin
  try
    SetForegroundWindow(AppHnd);
    Sleep(5000);
    Result:=True;
  except
    Result:=False;
    end;
end;
// Определение системной папки
function GetSystemDir:string;
var
  a : Array[0..144] of char;
begin
GetSystemDirectory(a, sizeof(a));
Result:=StrPas(a);
end;

procedure SimulateKeyDown(Key : byte);
begin
    keybd_event(Key, 0, 0, 0);
end;

procedure SimulateKeyUp(Key : byte);
begin
    keybd_event(Key, 0, KEYEVENTF_KEYUP, 0);
end;

procedure SimulateKeystroke(Key : byte; extra : DWORD);
begin
    keybd_event(Key,extra,0,0);
    keybd_event(Key,extra,KEYEVENTF_KEYUP,0);
end;

procedure SendKeys(s : string);
var
    i : integer;
    flag : bool;
    w : word;
begin
    {Get the state of the caps lock key}
    flag := not GetKeyState(VK_CAPITAL) and 1 = 0;
    {If the caps lock key is on then turn it off}
    if flag then
        SimulateKeystroke(VK_CAPITAL, 0);
    for i := 1 to Length(s) do
        begin
            w := VkKeyScan(s[i]);
            {If there is not an error in the key translation}
            if ((HiByte(w) <> $FF) and (LoByte(w) <> $FF)) then
                begin
                    {If the key requires the shift key down - hold it down}
                    if HiByte(w) and 1 = 1 then
                        SimulateKeyDown(VK_SHIFT);
                        {Send the VK_KEY}
                    SimulateKeystroke(LoByte(w), 0);
                    {If the key required the shift key down - release it}
                    if HiByte(w) and 1 = 1 then
                        SimulateKeyUp(VK_SHIFT);
                end;
        end;
{if the caps lock key was on at start, turn it back on}
if flag then
    SimulateKeystroke(VK_CAPITAL, 0);
end;

//Добавление в лог
procedure AddLog(s:string);
var log:textfile;
begin
 try
  assignfile(log,ExePatch+'log.txt');
  if not FileExists(ExePatch+'log.txt') then
    rewrite(log)
  else Append(log);
  Writeln(log,'['+GetDateT+'] '+s);
  CloseFile(log);
 except
 end;
end;

function FileVersion(AFileName: string): string;
var
  szName: array[0..255] of Char;
  P: Pointer;
  Value: Pointer;
  Len: UINT;
  GetTranslationString: string;
  FFileName: PChar;
  FValid: boolean;
  FSize: DWORD;
  FHandle: DWORD;
  FBuffer: PChar;
begin
  try
    FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
    FValid := False;
    FSize := GetFileVersionInfoSize(FFileName, FHandle);
    if FSize > 0 then
    try
      GetMem(FBuffer, FSize);
      FValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
    except
      FValid := False;
      raise;
    end;
    Result := '';
    if FValid then
      VerQueryValue(FBuffer, '\VarFileInfo\Translation', p, Len)
    else
      p := nil;
    if P <> nil then
      GetTranslationString := IntToHex(MakeLong(HiWord(Longint(P^)),
        LoWord(Longint(P^))), 8);
    if FValid then
    begin
      StrPCopy(szName, '\StringFileInfo\' + GetTranslationString +
        '\FileVersion');
      if VerQueryValue(FBuffer, szName, Value, Len) then
        Result := StrPas(PChar(Value));
    end;
  finally
    try
      if FBuffer <> nil then
        FreeMem(FBuffer, FSize);
    except
    end;
    try
      StrDispose(FFileName);
    except
    end;
  end;
end;

// Возвращает размер файла
function GetFileSize(const FileName:string):longint;
var
SearchRec:TSearchRec;
begin
 if FindFirst(ExpandFileName(FileName),faAnyFile,SearchRec)=0
      then Result:=SearchRec.Size
    else Result:=-1;
 FindClose(SearchRec.FindHandle);
end;

function GetProcess:TStringList;
const
PROCESS_TERMINATE=$0001;
var
Co:BOOL;
FS:THandle;
FP:TProcessEntry32;
begin
result:=TStringList.Create;
FS:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
FP.dwSize:=Sizeof(FP);
Co:=Process32First(FS,FP);
while integer(Co) <> 0 do
begin
result.Add(FP.szExeFile);
Co:=Process32Next(FS,FP);
end;
CloseHandle(FS);
end;


function GetDateT:string;
begin
Result:= Datetostr(date)+' '+timetostr(time);
end;

function GetFileDate(FileName: string): string;
var
  FHandle: Integer;

begin
  FHandle := FileOpen(FileName, 0);
  try
    Result := DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
  finally
    FileClose(FHandle);
  end;
end;

function AlphaMin(s:string):string;
var
i:integer;
s1:string;
begin
s1:='';
AlphaMin:='';
for i:=1 to length(s) do
// Русские
 if (copy(s,i,1)='А') or (copy(s,i,1)='а') then s1:=s1+'а' else
  if (copy(s,i,1)='Б') or (copy(s,i,1)='б') then s1:=s1+'б' else
   if (copy(s,i,1)='В') or (copy(s,i,1)='в') then s1:=s1+'в' else
    if (copy(s,i,1)='Г') or (copy(s,i,1)='г') then s1:=s1+'г' else
     if (copy(s,i,1)='Д') or (copy(s,i,1)='д') then s1:=s1+'д' else
      if (copy(s,i,1)='Е') or (copy(s,i,1)='е') then s1:=s1+'е' else
       if (copy(s,i,1)='Ё') or (copy(s,i,1)='ё') then s1:=s1+'ё' else
        if (copy(s,i,1)='Ж') or (copy(s,i,1)='ж') then s1:=s1+'ж' else
         if (copy(s,i,1)='З') or (copy(s,i,1)='з') then s1:=s1+'з' else
          if (copy(s,i,1)='И') or (copy(s,i,1)='и') then s1:=s1+'и' else
          if (copy(s,i,1)='Й') or (copy(s,i,1)='й') then s1:=s1+'й' else
          if (copy(s,i,1)='К') or (copy(s,i,1)='к') then s1:=s1+'к' else
         if (copy(s,i,1)='Л') or (copy(s,i,1)='л') then s1:=s1+'л' else
        if (copy(s,i,1)='М') or (copy(s,i,1)='м') then s1:=s1+'м' else
       if (copy(s,i,1)='Н') or (copy(s,i,1)='н') then s1:=s1+'н' else
      if (copy(s,i,1)='О') or (copy(s,i,1)='о') then s1:=s1+'о' else
     if (copy(s,i,1)='П') or (copy(s,i,1)='п') then s1:=s1+'п' else
    if (copy(s,i,1)='Р') or (copy(s,i,1)='р') then s1:=s1+'р' else
   if (copy(s,i,1)='С') or (copy(s,i,1)='с') then s1:=s1+'с' else
  if (copy(s,i,1)='Т') or (copy(s,i,1)='т') then s1:=s1+'т' else
 if (copy(s,i,1)='У') or (copy(s,i,1)='у') then s1:=s1+'у' else
if (copy(s,i,1)='Ф') or (copy(s,i,1)='ф') then s1:=s1+'ф' else
if (copy(s,i,1)='Х') or (copy(s,i,1)='х') then s1:=s1+'х' else
 if (copy(s,i,1)='Ц') or (copy(s,i,1)='ц') then s1:=s1+'ц' else
  if (copy(s,i,1)='Ч') or (copy(s,i,1)='ч') then s1:=s1+'ч' else
   if (copy(s,i,1)='Ш') or (copy(s,i,1)='ш') then s1:=s1+'ш' else
    if (copy(s,i,1)='Щ') or (copy(s,i,1)='щ') then s1:=s1+'щ' else
     if (copy(s,i,1)='Ь') or (copy(s,i,1)='ь') then s1:=s1+'ь' else
      if (copy(s,i,1)='Ы') or (copy(s,i,1)='ы') then s1:=s1+'ы' else
       if (copy(s,i,1)='Ъ') or (copy(s,i,1)='ъ') then s1:=s1+'ъ' else
        if (copy(s,i,1)='Э') or (copy(s,i,1)='э') then s1:=s1+'э' else
         if (copy(s,i,1)='Ю') or (copy(s,i,1)='ю') then s1:=s1+'ю' else
         if (copy(s,i,1)='Я') or (copy(s,i,1)='я') then s1:=s1+'я' else
// Англицкие
         if (copy(s,i,1)='Q') or (copy(s,i,1)='q') then s1:=s1+'q' else
         if (copy(s,i,1)='W') or (copy(s,i,1)='w') then s1:=s1+'w' else
         if (copy(s,i,1)='E') or (copy(s,i,1)='e') then s1:=s1+'e' else
         if (copy(s,i,1)='R') or (copy(s,i,1)='r') then s1:=s1+'r' else
         if (copy(s,i,1)='T') or (copy(s,i,1)='t') then s1:=s1+'t' else
         if (copy(s,i,1)='Y') or (copy(s,i,1)='y') then s1:=s1+'y' else
         if (copy(s,i,1)='U') or (copy(s,i,1)='u') then s1:=s1+'u' else
         if (copy(s,i,1)='I') or (copy(s,i,1)='i') then s1:=s1+'i' else
         if (copy(s,i,1)='O') or (copy(s,i,1)='o') then s1:=s1+'o' else
         if (copy(s,i,1)='P') or (copy(s,i,1)='p') then s1:=s1+'p' else
         if (copy(s,i,1)='A') or (copy(s,i,1)='a') then s1:=s1+'a' else
         if (copy(s,i,1)='S') or (copy(s,i,1)='s') then s1:=s1+'s' else
         if (copy(s,i,1)='D') or (copy(s,i,1)='d') then s1:=s1+'d' else
         if (copy(s,i,1)='F') or (copy(s,i,1)='f') then s1:=s1+'f' else
         if (copy(s,i,1)='G') or (copy(s,i,1)='g') then s1:=s1+'g' else
         if (copy(s,i,1)='H') or (copy(s,i,1)='h') then s1:=s1+'h' else
         if (copy(s,i,1)='J') or (copy(s,i,1)='j') then s1:=s1+'j' else
         if (copy(s,i,1)='K') or (copy(s,i,1)='k') then s1:=s1+'k' else
         if (copy(s,i,1)='L') or (copy(s,i,1)='l') then s1:=s1+'l' else
         if (copy(s,i,1)='Z') or (copy(s,i,1)='z') then s1:=s1+'z' else
         if (copy(s,i,1)='X') or (copy(s,i,1)='x') then s1:=s1+'x' else
         if (copy(s,i,1)='C') or (copy(s,i,1)='c') then s1:=s1+'c' else
         if (copy(s,i,1)='V') or (copy(s,i,1)='v') then s1:=s1+'v' else
         if (copy(s,i,1)='B') or (copy(s,i,1)='b') then s1:=s1+'b' else
         if (copy(s,i,1)='N') or (copy(s,i,1)='n') then s1:=s1+'n' else
         if (copy(s,i,1)='M') or (copy(s,i,1)='m') then s1:=s1+'m' else
          //Служебные символы
         if (copy(s,i,1)=' ') or (copy(s,i,1)=' ') then s1:=s1+' ' else
         if (copy(s,i,1)=',') or (copy(s,i,1)=',') then s1:=s1+',' else
         if (copy(s,i,1)='.') or (copy(s,i,1)='.') then s1:=s1+'.' else
         if (copy(s,i,1)='"') or (copy(s,i,1)='"') then s1:=s1+'"' else
         if (copy(s,i,1)='[') or (copy(s,i,1)='[') then s1:=s1+'[' else
         if (copy(s,i,1)=']') or (copy(s,i,1)=']') then s1:=s1+']' else
         if (copy(s,i,1)='{') or (copy(s,i,1)='{') then s1:=s1+'{' else
         if (copy(s,i,1)='}') or (copy(s,i,1)='}') then s1:=s1+'}' else
         if (copy(s,i,1)='(') or (copy(s,i,1)='(') then s1:=s1+'(' else
         if (copy(s,i,1)=')') or (copy(s,i,1)=')') then s1:=s1+')' else
         if (copy(s,i,1)=':') or (copy(s,i,1)=':') then s1:=s1+':' else
         if (copy(s,i,1)='/') or (copy(s,i,1)='/') then s1:=s1+'/' else
         if (copy(s,i,1)='\') or (copy(s,i,1)='\') then s1:=s1+'\' else
         if (copy(s,i,1)='=') or (copy(s,i,1)='=') then s1:=s1+'=' else
         if (copy(s,i,1)='+') or (copy(s,i,1)='+') then s1:=s1+'+' else
         if (copy(s,i,1)='-') or (copy(s,i,1)='-') then s1:=s1+'-' else
         if (copy(s,i,1)='*') or (copy(s,i,1)='*') then s1:=s1+'*' else
         if (copy(s,i,1)='%') or (copy(s,i,1)='%') then s1:=s1+'%' else
         if (copy(s,i,1)='$') or (copy(s,i,1)='$') then s1:=s1+'$' else
         if (copy(s,i,1)='#') or (copy(s,i,1)='#') then s1:=s1+'#' else
         if (copy(s,i,1)='№') or (copy(s,i,1)='№') then s1:=s1+'№' else
         if (copy(s,i,1)='@') or (copy(s,i,1)='@') then s1:=s1+'@' else
         if (copy(s,i,1)='!') or (copy(s,i,1)='!') then s1:=s1+'!' else
         if (copy(s,i,1)='^') or (copy(s,i,1)='^') then s1:=s1+'^' else
         if (copy(s,i,1)='&') or (copy(s,i,1)='&') then s1:=s1+'&' else
         if (copy(s,i,1)='>') or (copy(s,i,1)='>') then s1:=s1+'>' else
         if (copy(s,i,1)='<') or (copy(s,i,1)='<') then s1:=s1+'<' else
         if (copy(s,i,1)='`') or (copy(s,i,1)='`') then s1:=s1+'`' else
         if (copy(s,i,1)='~') or (copy(s,i,1)='~') then s1:=s1+'~' else
         if (copy(s,i,1)='  ') or (copy(s,i,1)='  ') then s1:=s1+'  ' else
         //Цифры
          if (copy(s,i,1)='0') then s1:=s1+'0' else
          if (copy(s,i,1)='1') then s1:=s1+'1' else
         if (copy(s,i,1)='2') then s1:=s1+'2' else
        if (copy(s,i,1)='3') then s1:=s1+'3' else
       if (copy(s,i,1)='4') then s1:=s1+'4' else
      if (copy(s,i,1)='5') then s1:=s1+'5' else
     if (copy(s,i,1)='6') then s1:=s1+'6' else
    if (copy(s,i,1)='7') then s1:=s1+'7' else
   if (copy(s,i,1)='8') then s1:=s1+'8' else
  if (copy(s,i,1)='9') then s1:=s1+'9';
AlphaMin:=s1;
end;

function IsDigit(s:string):boolean;
var i,k:integer;
begin
IsDigit:=false;;
k:=1;
for i:=1 to length(s) do
    if copy(s,i,1)='1' then k:=k+1 else
      if copy(s,i,1)='2' then k:=k+1 else
       if copy(s,i,1)='3' then k:=k+1 else
        if copy(s,i,1)='4' then k:=k+1 else
         if copy(s,i,1)='5' then k:=k+1 else
          if copy(s,i,1)='6' then k:=k+1 else
           if copy(s,i,1)='7' then k:=k+1 else
            if copy(s,i,1)='8' then k:=k+1 else
             if copy(s,i,1)='9' then k:=k+1 else
              if copy(s,i,1)='0' then k:=k+1;
if k=i then IsDigit:=true else IsDigit:=false;
end;
// Проверка строки на дату
function IsDate(s:string):boolean;
var i:integer;
begin
if NOT IsDigit(copy(s,1,2)) then result:=false;
if copy(s,3,1)<>'.' then result:=false;
if NOT IsDigit(copy(s,4,2)) then result:=false;
if copy(s,6,1)<>'.' then result:=false;
if NOT IsDigit(copy(s,7,4)) then result:=false;
if length(s)>10 then result:=false;
end;
// Узнать имя компьютера
function GetComputerNName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := 'Нет'
end;

function DateBezTochek(k:TdateTime):string;
var i:integer;
ss,s:string;
begin
  s:=datetostr(k);
  for i:=1 to Length(s) do
    if (s[i]='.') or (s[i]=',') then Continue else
      ss:=ss+s[i];
  Result:=ss;    
  end;

end.
 