program process_starter;

uses
  SysUtils, Classes, Gvar, Windows;

var i,pcount:integer;
f:TextFile;

process:TStringList;
begin
 While true do
  begin
   pcount:=0;
    process:=TStringList.Create;
    process.Clear;
    process:=GetProcess;
    for i:=0 to process.Count-1 do
    if process[i]='WAgent.exe' then pcount:=pcount+1;
   if pcount<1 then
    begin
     // WinExec('WAgent.exe',0);
      try
       assignfile(f,'process_log.txt');
       If not FileExists('process_log.txt') then
        rewrite(f)
       else
        append(f);
       Writeln(f,GetDateT+' Процесс WAgent не был обнаружен в памяти.');
      Closefile(f);
      except
      end;
    end;
   Sleep(5000);
  end;
end.
 