unit WorkDo;

interface
uses SysUtils, Types, Messages, Dialogs, Windows, TLHELP32, Classes, StdCtrls, Gvar, Math;

function Work2(cmd:string):string; // ������� ���
function Work3(cmd:string):string; // ����� �� �����������
function Work4(ClientID:integer;cmd:string):string; // ������� ���� � ����

implementation

function Work2(cmd:string):string; // ������� ���
begin
  Result := GetDateT();
end;

function Work3(cmd:string):string; // ����� �� �����������
var
  R:Integer;
  ATime: TDateTime;
  dop:string;
begin
  Randomize;
  R := RandomRange(0,4);
  if R=0 then
   Result := '������������!';
  if R=1 then
   Result := '����������� ���!';
  if (R=2) or (R=3) or (R=4) then
   begin
    ATime:=Time;
    R := RandomRange(0,3);
    dop:='!';
    if (R=1) or (R=2) or ((R=3)) then dop:=' ���!';
    if (ATime>=StrToTime('5:00:00')) and (ATime<StrToTime('12:00:00')) then
      Result := '������ ����'+dop;
    if (ATime>=StrToTime('12:00:00')) and (ATime<StrToTime('17:00:00')) then
      Result := '������ ����'+dop;
    if (ATime>=StrToTime('17:00:00')) and (ATime<StrToTime('23:00:00')) then
      Result := '������ �����'+dop;
    if ((ATime>=StrToTime('23:00:00')) and (ATime<=StrToTime('23:59:59')))
        or ((ATime>=StrToTime('00:00:00')) and (ATime<StrToTime('5:00:00'))) then
      Result := '������ ����'+dop;
   end;
end;

procedure CloseWindows(okno:Integer);
begin
  //ShowMessage('�������� ���� ����� '+inttostr(okno));
end;

function Work4(ClientID:integer;cmd:string):string;
const KolVo = 2;
var
i:Integer;
begin
  Result := '�� ���� ������� ����!'; 
  // 0 - ���� � ����
  // 1 - ����

  if AnsiPos('���',cmd)>0 then
  begin
    // ������� ��� ����
    for i:=0 to KolVo-1 do
      CloseWindows(i);
    Result := '��� ���� �������!';
    exit;
  end else
    if AnsiPos('� ����',cmd)>0 then
    begin
      // ������� ���� � ����
      CloseWindows(0);
      Result := '���� � ���� �������!';
      Exit;
    end;

  if ClientID = 0 then
    begin
      CloseWindows(0);
      Result := '���� �������!';
    end;
end;

end.
 