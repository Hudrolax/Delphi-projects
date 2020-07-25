unit WorkDo;

interface
uses SysUtils, Types, Messages, Dialogs, Windows, TLHELP32, Classes, StdCtrls, Gvar, Math;

function Work2(cmd:string):string; // Который час
function Work3(cmd:string):string; // Ответ на приветствие
function Work4(ClientID:integer;cmd:string):string; // Закрыть окно в доме

implementation

function Work2(cmd:string):string; // Который час
begin
  Result := GetDateT();
end;

function Work3(cmd:string):string; // Ответ на приветствие
var
  R:Integer;
  ATime: TDateTime;
  dop:string;
begin
  Randomize;
  R := RandomRange(0,4);
  if R=0 then
   Result := 'Здравствуйте!';
  if R=1 then
   Result := 'Приветствую Вас!';
  if (R=2) or (R=3) or (R=4) then
   begin
    ATime:=Time;
    R := RandomRange(0,3);
    dop:='!';
    if (R=1) or (R=2) or ((R=3)) then dop:=' сэр!';
    if (ATime>=StrToTime('5:00:00')) and (ATime<StrToTime('12:00:00')) then
      Result := 'Доброе утро'+dop;
    if (ATime>=StrToTime('12:00:00')) and (ATime<StrToTime('17:00:00')) then
      Result := 'Добрый день'+dop;
    if (ATime>=StrToTime('17:00:00')) and (ATime<StrToTime('23:00:00')) then
      Result := 'Добрый вечер'+dop;
    if ((ATime>=StrToTime('23:00:00')) and (ATime<=StrToTime('23:59:59')))
        or ((ATime>=StrToTime('00:00:00')) and (ATime<StrToTime('5:00:00'))) then
      Result := 'Доброй ночи'+dop;
   end;
end;

procedure CloseWindows(okno:Integer);
begin
  //ShowMessage('Закрываю окно номер '+inttostr(okno));
end;

function Work4(ClientID:integer;cmd:string):string;
const KolVo = 2;
var
i:Integer;
begin
  Result := 'Не могу закрыть окна!'; 
  // 0 - Окно в зале
  // 1 - Тест

  if AnsiPos('все',cmd)>0 then
  begin
    // Закрыть все окна
    for i:=0 to KolVo-1 do
      CloseWindows(i);
    Result := 'Все окна закрыты!';
    exit;
  end else
    if AnsiPos('в зале',cmd)>0 then
    begin
      // Закрыть окно в зале
      CloseWindows(0);
      Result := 'Окно в зале закрыто!';
      Exit;
    end;

  if ClientID = 0 then
    begin
      CloseWindows(0);
      Result := 'Окно закрыто!';
    end;
end;

end.
 