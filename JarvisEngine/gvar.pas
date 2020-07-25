unit Gvar;

interface
uses SysUtils, Types, Windows, TLHELP32, Classes, StdCtrls, Controls;

const npos=9;
type
  TCodeString = array of string;
  
function IsDigit(s:string):boolean;
function IsDate(s:string):boolean;
function GetComputerNName: string;
function alphamin(s:string):string;
function InvertRaskl(s:string):string;
function alphaminBezTo4ek(s:string):string;
function GetFileDate(FileName: string): string;
function GetDateT:string;
function GetProcess:TStringList;
function FileVersion(AFileName: string): string;
function GetFileSize(const FileName:string):longint;
function IsSumm(s:string):boolean;
Function NePustaya(s:string):boolean;
function TimeBezTochek(k:TdateTime):string;
function DateBezTochek(k:TdateTime):string;
function T4kToZap(s:string):string;
function ZapToT4k(s:string):string;
function SetName2(n:integer):string;
function CodeStringToArray(s:string):TCodeString;
function ReturnDigitOnly(s:string):string;

type
  TWork = record
    id: Integer;
    name:string;
    words: array of string;
    Area:string;
    Status:integer;
    GetAccept:integer;
    Param:string;
    LastClient:integer;
  end;

  TClient = record
    name: string;
    IP: string;
    LastTime:TDateTime;
    LastDate:TDate;
    LastCommand:integer;
  end;

var
  LastWork,CurrentWork:integer;
  ZaprosPodtverjdeniya,Podtverjdenie:Boolean;
  WorkList:array of TWork;
  Clients:array of TClient;

implementation

Function NePustaya(s:string):boolean;
begin
 If s<>'' then Result:=true else Result:=False;
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

function CodeStringToArray(s:string):TCodeString;  // ������ ������ �� ������ ���� 34545*435345*34554*4554
var i,j:integer;
begin
 SetLength(result,0);
 SetLength(result,1);
 j:=0;
 for i:=1 to length(s) do
    if (copy(s,i,1)<>'/') AND (copy(s,i,1)<>'*') then
      result[j]:=result[j]+copy(s,i,1)
    else
      begin
        SetLength(result,length(result)+1);
        j:=j+1;
      end;
end;

// ���������� ������ �����
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
// �������
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
// ���������
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
          //��������� �������
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
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='@') or (copy(s,i,1)='@') then s1:=s1+'@' else
         if (copy(s,i,1)='!') or (copy(s,i,1)='!') then s1:=s1+'!' else
         if (copy(s,i,1)='^') or (copy(s,i,1)='^') then s1:=s1+'^' else
         if (copy(s,i,1)='&') or (copy(s,i,1)='&') then s1:=s1+'&' else
         if (copy(s,i,1)='>') or (copy(s,i,1)='>') then s1:=s1+'>' else
         if (copy(s,i,1)='<') or (copy(s,i,1)='<') then s1:=s1+'<' else
         if (copy(s,i,1)='`') or (copy(s,i,1)='`') then s1:=s1+'`' else
         if (copy(s,i,1)='~') or (copy(s,i,1)='~') then s1:=s1+'~' else
         if (copy(s,i,1)='  ') or (copy(s,i,1)='  ') then s1:=s1+'  ' else
         //�����
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

function InvertRaskl(s:string):string;
var
i:integer;
s1:string;
begin
s1:='';
InvertRaskl:='';
for i:=1 to length(s) do
// ���������
         if (copy(s,i,1)='Q') or (copy(s,i,1)='q') then s1:=s1+'�' else
         if (copy(s,i,1)='W') or (copy(s,i,1)='w') then s1:=s1+'�' else
         if (copy(s,i,1)='E') or (copy(s,i,1)='e') then s1:=s1+'�' else
         if (copy(s,i,1)='R') or (copy(s,i,1)='r') then s1:=s1+'�' else
         if (copy(s,i,1)='T') or (copy(s,i,1)='t') then s1:=s1+'�' else
         if (copy(s,i,1)='Y') or (copy(s,i,1)='y') then s1:=s1+'�' else
         if (copy(s,i,1)='U') or (copy(s,i,1)='u') then s1:=s1+'�' else
         if (copy(s,i,1)='I') or (copy(s,i,1)='i') then s1:=s1+'�' else
         if (copy(s,i,1)='O') or (copy(s,i,1)='o') then s1:=s1+'�' else
         if (copy(s,i,1)='P') or (copy(s,i,1)='p') then s1:=s1+'�' else
         if (copy(s,i,1)='A') or (copy(s,i,1)='a') then s1:=s1+'�' else
         if (copy(s,i,1)='S') or (copy(s,i,1)='s') then s1:=s1+'�' else
         if (copy(s,i,1)='D') or (copy(s,i,1)='d') then s1:=s1+'�' else
         if (copy(s,i,1)='F') or (copy(s,i,1)='f') then s1:=s1+'�' else
         if (copy(s,i,1)='G') or (copy(s,i,1)='g') then s1:=s1+'�' else
         if (copy(s,i,1)='H') or (copy(s,i,1)='h') then s1:=s1+'�' else
         if (copy(s,i,1)='J') or (copy(s,i,1)='j') then s1:=s1+'�' else
         if (copy(s,i,1)='K') or (copy(s,i,1)='k') then s1:=s1+'�' else
         if (copy(s,i,1)='L') or (copy(s,i,1)='l') then s1:=s1+'�' else
         if (copy(s,i,1)='Z') or (copy(s,i,1)='z') then s1:=s1+'�' else
         if (copy(s,i,1)='X') or (copy(s,i,1)='x') then s1:=s1+'�' else
         if (copy(s,i,1)='C') or (copy(s,i,1)='c') then s1:=s1+'�' else
         if (copy(s,i,1)='V') or (copy(s,i,1)='v') then s1:=s1+'�' else
         if (copy(s,i,1)='B') or (copy(s,i,1)='b') then s1:=s1+'�' else
         if (copy(s,i,1)='N') or (copy(s,i,1)='n') then s1:=s1+'�' else
         if (copy(s,i,1)='M') or (copy(s,i,1)='m') then s1:=s1+'�' else
          //��������� �������
         if (copy(s,i,1)=' ') or (copy(s,i,1)=' ') then s1:=s1+' ' else
         if (copy(s,i,1)=',') or (copy(s,i,1)=',') then s1:=s1+'�' else
         if (copy(s,i,1)='.') or (copy(s,i,1)='.') then s1:=s1+'�' else
         if (copy(s,i,1)='"') or (copy(s,i,1)='"') then s1:=s1+'�' else
         if (copy(s,i,1)='[') or (copy(s,i,1)='[') then s1:=s1+'�' else
         if (copy(s,i,1)=']') or (copy(s,i,1)=']') then s1:=s1+'�' else
         if (copy(s,i,1)='{') or (copy(s,i,1)='{') then s1:=s1+' ' else
         if (copy(s,i,1)='}') or (copy(s,i,1)='}') then s1:=s1+' ' else
         if (copy(s,i,1)='(') or (copy(s,i,1)='(') then s1:=s1+' ' else
         if (copy(s,i,1)=')') or (copy(s,i,1)=')') then s1:=s1+' ' else
         if (copy(s,i,1)=':') or (copy(s,i,1)=':') then s1:=s1+'�' else
         if (copy(s,i,1)='/') or (copy(s,i,1)='/') then s1:=s1+' ' else
         if (copy(s,i,1)='\') or (copy(s,i,1)='\') then s1:=s1+' ' else
         if (copy(s,i,1)='=') or (copy(s,i,1)='=') then s1:=s1+' ' else
         if (copy(s,i,1)='+') or (copy(s,i,1)='+') then s1:=s1+' ' else
         if (copy(s,i,1)='-') or (copy(s,i,1)='-') then s1:=s1+' ' else
         if (copy(s,i,1)='*') or (copy(s,i,1)='*') then s1:=s1+' ' else
         if (copy(s,i,1)='%') or (copy(s,i,1)='%') then s1:=s1+' ' else
         if (copy(s,i,1)='$') or (copy(s,i,1)='$') then s1:=s1+' ' else
         if (copy(s,i,1)='#') or (copy(s,i,1)='#') then s1:=s1+' ' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+' ' else
         if (copy(s,i,1)='@') or (copy(s,i,1)='@') then s1:=s1+' ' else
         if (copy(s,i,1)='!') or (copy(s,i,1)='!') then s1:=s1+' ' else
         if (copy(s,i,1)='^') or (copy(s,i,1)='^') then s1:=s1+' ' else
         if (copy(s,i,1)='&') or (copy(s,i,1)='&') then s1:=s1+' ' else
         if (copy(s,i,1)='>') or (copy(s,i,1)='>') then s1:=s1+' ' else
         if (copy(s,i,1)='<') or (copy(s,i,1)='<') then s1:=s1+' ' else
         if (copy(s,i,1)='`') or (copy(s,i,1)='`') then s1:=s1+' ' else
         if (copy(s,i,1)='~') or (copy(s,i,1)='~') then s1:=s1+' ' else
         if (copy(s,i,1)='  ') or (copy(s,i,1)='  ') then s1:=s1+'  ' else
         //�����
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
InvertRaskl:=s1;
end;

function AlphaMinBezTo4ek(s:string):string;
var
i:integer;
s1:string;
begin
s1:='';
AlphaMinBezTo4ek:='';
for i:=1 to length(s) do
// �������
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
          if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
 if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
  if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
   if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
    if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
     if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
      if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
       if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
        if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+'�' else
// ���������
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
          //��������� �������
         if (copy(s,i,1)=' ') or (copy(s,i,1)=' ') then s1:=s1+' ' else
         if (copy(s,i,1)=',') or (copy(s,i,1)=',') then s1:=s1+' ' else
         if (copy(s,i,1)='.') or (copy(s,i,1)='.') then s1:=s1+' ' else
         if (copy(s,i,1)='"') or (copy(s,i,1)='"') then s1:=s1+' ' else
         if (copy(s,i,1)='[') or (copy(s,i,1)='[') then s1:=s1+' ' else
         if (copy(s,i,1)=']') or (copy(s,i,1)=']') then s1:=s1+' ' else
         if (copy(s,i,1)='{') or (copy(s,i,1)='{') then s1:=s1+' ' else
         if (copy(s,i,1)='}') or (copy(s,i,1)='}') then s1:=s1+' ' else
         if (copy(s,i,1)='(') or (copy(s,i,1)='(') then s1:=s1+' ' else
         if (copy(s,i,1)=')') or (copy(s,i,1)=')') then s1:=s1+' ' else
         if (copy(s,i,1)=':') or (copy(s,i,1)=':') then s1:=s1+' ' else
         if (copy(s,i,1)='/') or (copy(s,i,1)='/') then s1:=s1+' ' else
         if (copy(s,i,1)='\') or (copy(s,i,1)='\') then s1:=s1+' ' else
         if (copy(s,i,1)='=') or (copy(s,i,1)='=') then s1:=s1+' ' else
         if (copy(s,i,1)='+') or (copy(s,i,1)='+') then s1:=s1+' ' else
         if (copy(s,i,1)='-') or (copy(s,i,1)='-') then s1:=s1+' ' else
         if (copy(s,i,1)='*') or (copy(s,i,1)='*') then s1:=s1+' ' else
         if (copy(s,i,1)='%') or (copy(s,i,1)='%') then s1:=s1+' ' else
         if (copy(s,i,1)='$') or (copy(s,i,1)='$') then s1:=s1+' ' else
         if (copy(s,i,1)='#') or (copy(s,i,1)='#') then s1:=s1+' ' else
         if (copy(s,i,1)='�') or (copy(s,i,1)='�') then s1:=s1+' ' else
         if (copy(s,i,1)='@') or (copy(s,i,1)='@') then s1:=s1+' ' else
         if (copy(s,i,1)='!') or (copy(s,i,1)='!') then s1:=s1+' ' else
         if (copy(s,i,1)='^') or (copy(s,i,1)='^') then s1:=s1+' ' else
         if (copy(s,i,1)='&') or (copy(s,i,1)='&') then s1:=s1+' ' else
         if (copy(s,i,1)='>') or (copy(s,i,1)='>') then s1:=s1+' ' else
         if (copy(s,i,1)='<') or (copy(s,i,1)='<') then s1:=s1+' ' else
         if (copy(s,i,1)='`') or (copy(s,i,1)='`') then s1:=s1+' ' else
         if (copy(s,i,1)='~') or (copy(s,i,1)='~') then s1:=s1+' ' else
         if (copy(s,i,1)='  ') or (copy(s,i,1)='  ') then s1:=s1+' ' else
         //�����
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
AlphaMinBezTo4ek:=s1;
end;

function ReturnDigitOnly(s:string):string;
var
i:integer;
s1:string;
begin
s1:='';
ReturnDigitOnly:='';
for i:=1 to length(s) do
         //�����
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
ReturnDigitOnly:=s1;
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

function IsSumm(s:string):boolean;
var i,k:integer;
begin
IsSumm:=false;;
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
              if copy(s,i,1)='0' then k:=k+1 else
               if copy(s,i,1)=',' then k:=k+1 else
                if copy(s,i,1)='.' then k:=k+1;
if k=i then IsSumm:=true else IsSumm:=false;
end;

function T4kToZap(s:string):string;
var i:integer;
begin
 result:='';
  for i:=1 to length(s) do
    if copy(s,i,1)='.' then
      result:=result+','
    else
      result:=result+copy(s,i,1);
end;

function ZapToT4k(s:string):string;
var i:integer;
begin
 result:='';
  for i:=1 to length(s) do
    if copy(s,i,1)=',' then
      result:=result+'.'
    else
      result:=result+copy(s,i,1);
end;
// �������� ������ �� ����
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
// ������ ��� ����������
function GetComputerNName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := '���'
end;

function DateBezTochek(k:TdateTime):string;
var i:integer;
ss,s:string;
begin
  s:=datetostr(k);
  for i:=1 to Length(s) do
    if (s[i]='.') or (s[i]=',') or (s[i]=':') then Continue else
      ss:=ss+s[i];
  Result:=ss;    
  end;

function TimeBezTochek(k:TdateTime):string;
var i:integer;
ss,s:string;
begin
  s:=timetostr(k);
  for i:=1 to Length(s) do
    if (s[i]='.') or (s[i]=',') or (s[i]=':') then Continue else
      ss:=ss+s[i];
  Result:=ss;    
  end;

// ���������� ��� ��� ����� � ����� �������
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

end.
 