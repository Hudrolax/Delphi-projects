unit Gvar;

interface
uses SysUtils, Types, Windows;
function IsDigit(s:string):boolean;
function IsDate(s:string):boolean;
function GetComputerNName: string;
function alphamin(s:string):string;
function GetFileDate(FileName: string): string;
var ND:integer;
vall,autoref:boolean;
RowS:integer;
IDSel,Gtmp,Gincass:string;

implementation
// �������� �� ������ �� �����

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


end.
 