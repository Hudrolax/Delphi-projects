unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPServer, gvar,
  IdTCPConnection, IdTCPClient, DBF, WorkDo, BCPort;

type
  TForm1 = class(TForm)
    server: TIdTCPServer;
    LogBox: TListBox;
    DBF1: TDBF;
    client: TIdTCPClient;
    DBF2: TDBF;
    procedure serverExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure Log(s: string);
begin
  Form1.LogBox.Items.Append(GetDateT() + ' Jarvis: ' + s);
end;

procedure SendMessageToClient(ClientID:Integer;msg:string);
begin
  form1.client.Host := Clients[ClientID].IP;
  Form1.client.Connect(5000);
  if form1.client.Connected then
  begin
    form1.client.WriteLn(msg);
    form1.client.Disconnect;
  end;
end;

procedure LoadCommBase();
var
  i,j,k:Integer;
  WordsTemp,s:string;
begin
  with Form1 do
  try
    DBF1.TableName:='comm.dbf';
    DBF1.Exclusive:=false;
    DBF1.Open;
    if DBF1.RecordCount=0 then
     begin
      Log('База данных клиентов пуста. Работа невозможна.');
      Exit;
     end;
    SetLength(WorkList,0);
    for i:=1 to DBF1.RecordCount do
    begin
      SetLength(WorkList,Length(WorkList)+1);
      WorkList[i-1].id := StrToInt(DBF1.GetFieldData(1));
      WorkList[i-1].name := DBF1.GetFieldData(2);
      WordsTemp := DBF1.GetFieldData(3);
      s:='';
      k:=0;
      for j:=1 to Length(WordsTemp) do
        if Copy(WordsTemp,j,1)<>',' then s:=s+Copy(WordsTemp,j,1)
        else
        begin
          SetLength(WorkList[i-1].words,Length(WorkList[i-1].words)+1);
          WorkList[i-1].words[k] :=s;
          s:='';
          k:=k+1;
         end;
      WorkList[i-1].Area := DBF1.GetFieldData(4);
      WorkList[i-1].Status := StrToInt(DBF1.GetFieldData(5));
      WorkList[i-1].GetAccept := StrToInt(DBF1.GetFieldData(6));
      WorkList[i-1].Param := DBF1.GetFieldData(7);
      WorkList[i-1].LastClient := StrToInt(DBF1.GetFieldData(8));
      DBF1.Next;
    end;
    DBF1.Close;
  except
    Log('не могу открыть comm.dbf!!!');
    DBF1.Close;
    Exit;
  end;
end;

procedure LoadClients();
var
  i:Integer;
  strtime,strdate,lastcommand:string;
begin
  with Form1 do
  try
    DBF2.TableName:='clients.dbf';
    DBF2.Exclusive:=false;
    DBF2.Open;
    if DBF2.RecordCount=0 then
     begin
      Log('База данных команд пуста. Работа невозможна.');
      Exit;
     end;
    for i:=1 to DBF2.RecordCount do
    begin
      SetLength(Clients,Length(Clients)+1);
      Clients[i-1].name := DBF2.GetFieldData(1);
      Clients[i-1].IP := DBF2.GetFieldData(2);
      strtime := DBF2.GetFieldData(3);
      if strtime = '' then strtime := '00:00:00';
      Clients[i-1].LastTime := StrToDateTime(strtime);

      strdate := DBF2.GetFieldData(4);
      if strdate = '' then strdate := '01.01.2010';
      Clients[i-1].LastDate := StrToDate(strdate);

      lastcommand := DBF2.GetFieldData(5);
      if lastcommand = '' then lastcommand := '-1';
      Clients[i-1].LastCommand := StrToInt(lastcommand);
      DBF2.Next;
    end;
    DBF2.Close;
  except
    Log('не могу открыть clients.dbf!!!');
    DBF2.Close;
    Exit;
  end;
end;

procedure SaveClients();
var
  i:Integer;
begin
   with Form1 do
  try
    DBF2.TableName:='clients.dbf';
    DBF2.Exclusive:=false;
    DBF2.Open;
    if DBF2.RecordCount=0 then
     begin
      Log('База данных команд пуста. Работа невозможна.');
      Exit;
     end;
    for i:=1 to DBF2.RecordCount do
    begin
      DBF2.SetFieldData(3,TimeToStr(Clients[i-1].LastTime));
      DBF2.SetFieldData(4,DateToStr(Clients[i-1].LastDate));
      DBF2.SetFieldData(5,inttostr(Clients[i-1].LastCommand));
      DBF2.Next;
      DBF2.Post;
    end;
    DBF2.Close;
  except
    Log('не могу сохранить clients.dbf!!!');
    DBF2.Close;
    Exit;
  end;
end;

procedure SaveWorks();
var
  i,j:Integer;
  s:string;
begin
  with Form1 do
  try
    DBF1.TableName:='comm.dbf';
    DBF1.Exclusive:=false;
    DBF1.Open;
    if DBF1.RecordCount=0 then
     begin
      Log('База данных команд пуста. Работа невозможна.');
      Exit;
     end;
    for i:=1 to DBF1.RecordCount do
    begin
      s:='';
      for j:=0 to Length(WorkList[i-1].Words)-1 do
        s:=s+WorkList[i-1].Words[j]+',';
      DBF1.SetFieldData(3,s);

      DBF1.SetFieldData(5,IntToStr(WorkList[i-1].Status));
      DBF1.SetFieldData(6,inttostr(WorkList[i-1].GetAccept));
      DBF1.SetFieldData(7,WorkList[i-1].Param);
      DBF1.SetFieldData(8,IntToStr(WorkList[i-1].LastClient));
      DBF1.Post;
      DBF1.Next;
    end;
    DBF1.Close;
  except
    Log('не могу сохранить comm.dbf!!!');
    DBF1.Close;
    Exit;
  end;
end;

function Work5(FermNumber:integer):string; // Перезагрузить ферму
begin
  Result := 'Я не могу перезагрузить ферму номер '+IntToStr(FermNumber);
  if (FermNumber=3) or (FermNumber=7) or (FermNumber=8) or (FermNumber=9) then // Доступные для перезагрузки фермы
  begin
    // Перезагрузка фермы
    if FermNumber = 3 then
    begin
    //  buffer:='$KE,REL,1,1'+pred;
     // Form1.com1.Write(PChar(buffer)^,Length(buffer));
      //Sleep(6000);
      //buffer:='$KE,REL,1,0'+pred;
      //Form1.com1.Write(PChar(buffer)^,Length(buffer));
      //Sleep(40000);
      //buffer:='$KE,REL,1,1'+pred;
      //Form1.com1.Write(PChar(buffer)^,Length(buffer));
      //Sleep(500);
      //buffer:='$KE,REL,1,0'+pred;
      //Form1.com1.Write(PChar(buffer)^,Length(buffer));
    end;
    Result := 'Ферма номер '+IntToStr(FermNumber)+' перезагружена.';
    WorkList[5].Param := '';
  end;
end;

function FindWork(CommStr:string):Integer;
type
  TWorkPoint = record
    id: Integer;
    Points:Integer;
  end;
var i,j,k:Integer;
WorkPoint:array of TWorkPoint;
WorkPointTemp:TWorkPoint;
WorkInPointlist:Boolean;
begin
 Result := -1;
 for i:=0 to Length(WorkList)-1 do // Идем по ворклисту
  for j:=0 to Length(WorkList[i].words)-1 do // Идем по словам ворка
    if (AnsiPos(WorkList[i].words[j],CommStr)>0) or (AnsiPos(WorkList[i].words[j],InvertRaskl(CommStr))>0) then
      begin
        WorkInPointlist := false;
        if Length(WorkPoint)>0 then // Ищем в поинтлисте и прибавляем балл
          begin
            for k:=0 to Length(WorkPoint)-1 do
             if WorkPoint[k].id = WorkList[i].id then
             begin
              WorkPoint[k].Points := WorkPoint[k].Points + 1;
              WorkInPointlist := True;
             end;

          end
        else WorkInPointlist := false;

        if not WorkInPointlist then
        begin
          SetLength(WorkPoint,Length(WorkPoint)+1);
          WorkPoint[Length(WorkPoint)-1].id := Worklist[i].id;
          WorkPoint[Length(WorkPoint)-1].Points := 1;
        end;
      end;

 // Если нашлось одно действие - возвращаем без сортировок
 if Length(WorkPoint) = 1 then
 begin
  Result := WorkPoint[0].id;
  Exit;
 end;

 // Сортируем действия по баллам
 if Length(WorkPoint)>0 then
  for i:=0 to Length(WorkPoint)-2 do
   for j:=0 to Length(WorkPoint)-2 do
     if WorkPoint[i].Points<WorkPoint[i+1].Points then
     begin
       WorkPointTemp := WorkPoint[i];
       WorkPoint[i]:=WorkPoint[i+1];
       WorkPoint[i+1]:=WorkPointTemp;
     end;

  if Length(WorkPoint)=0 then
    Result := -1
  else if Length(WorkPoint)>1 then
    if WorkPoint[0].Points = WorkPoint[1].Points then Result := -2
    else Result := WorkPoint[0].id;

  // Если нашли несколько действий с одинаковыми баллами
  // выбираем то, которое подходит под контекст предыдущего действия
  if LastWork <> -1 then
   if Result = -2 then
     for i:=0 to Length(WorkPoint)-1 do
      if (WorkPoint[i].Points = WorkPoint[0].Points)
       and (WorkList[WorkPoint[i].id].Area = WorkList[LastWork].Area) then
       begin
        Result := WorkPoint[i].id;
        Exit;
       end;

end;

function DoWork(ClientID,Work:Integer;cmd:string):string;
begin
  if Work = 2 then
    Result := Work2(cmd);

  if Work = 3 then
    Result := Work3(cmd);

  if Work = 4 then
    Result := Work4(ClientID,cmd);

  if Work = 5 then
    Result := Work5(StrToInt(Worklist[Work].Param));
end;

function GetWork(ClientID:integer;s:string):string;
  label ExitPoint;
  var
    FermNumber:string;
begin
  Result := '-1';
  if (CurrentWork = 0) and (ZaprosPodtverjdeniya) then
  begin
    Podtverjdenie := True;
  end;

  if (CurrentWork = 1) and (ZaprosPodtverjdeniya) then
  begin
    ZaprosPodtverjdeniya := false;
    Podtverjdenie := false;
    CurrentWork := -1;
    Result:='Ок';
    Exit;
  end;

  // Тут надо выяснять вопросы до запроса подтверждения команды
  if CurrentWork=5 then // Запрос на перезагрузку ферм
  begin
    FermNumber := ReturnDigitOnly(s);
    if (AnsiPos('перезагруз',s)>0) and (AnsiPos('ферм',s)>0) and (IsDigit(FermNumber)) then
    begin
      if (FermNumber='3') or (FermNumber='7') or (FermNumber='8') or (FermNumber='9') then
       WorkList[CurrentWork].Param := FermNumber
      else begin
        Result := 'Я не могу перезагрузить ферму номер '+FermNumber;
       goto ExitPoint;
      end;
    end
    else begin
      Result := 'Уточните, какую ферму надо перезагрузить?';
      goto ExitPoint;
      end;
  end;

  if (WorkList[CurrentWork].GetAccept = 1) and (not Podtverjdenie) then
  begin
   Result := 'Вы подтверждаете команду '+WorkList[CurrentWork].name+'?';
   ZaprosPodtverjdeniya := True;
   LastWork := CurrentWork;
   Exit;
  end;

  if (CurrentWork=0) and (ZaprosPodtverjdeniya=False) then
  goto ExitPoint;

  if CurrentWork = 0 then
  begin
   Result := DoWork(ClientID,LastWork,s);
   Clients[ClientID].LastCommand := LastWork;
   WorkList[LastWork].LastClient := ClientID;
  end
  else begin
   Result := DoWork(ClientID,CurrentWork,s);
   Clients[ClientID].LastCommand := CurrentWork;
   WorkList[CurrentWork].LastClient := ClientID;
  end;
  Clients[ClientID].LastTime := Time;
  Clients[ClientID].LastDate := Date;
  SaveClients();
  SaveWorks();

  ExitPoint:ZaprosPodtverjdeniya := false;
  Podtverjdenie := false;
  LastWork := CurrentWork;
  CurrentWork := -1;
end;

function ReadCommand(ClientID:integer;s:string):string;
var Answer:string;
begin
  Answer := '';
  CurrentWork := FindWork(s);
  if CurrentWork = -1 then
  begin
    // Команда не найдена
    Log('Команда не опознана.');
    Result := 'Команда не опознана.';
    Exit;
  end;

  if CurrentWork = -2 then
  begin
    // Найдено более одного совпадения
    Log('Найдено более одного совпадения, уточните команду.');
    Result := 'Найдено более одного совпадения, уточните команду.';
    Exit;
  end;

  Log('Пришла команда '+Worklist[CurrentWork].name+' от '+Clients[ClientID].name);
  Result := GetWork(ClientID,s);
end;

procedure TForm1.serverExecute(AThread: TIdPeerThread);
var
  s,s2,clientSTR,answer: string;
  i,ClientID:integer;
begin
  ClientID := -1;
  s := AThread.Connection.ReadLn;
  for i:=1 to length(s) do
    if copy(s,i,1)<>':' then clientSTR:=clientSTR+copy(s,i,1) else break;

  if AnsiPos('Hello!7950',s)>0 then
    begin
      Log('Подключился клиент '+clientSTR);
      AThread.Connection.WriteLn('Соединение с сервером '+GetComputerNName+' установлено!');
      exit;
    end;
 // Log('Пришла команда '+s);
  for i:=AnsiPos(':',s)+1 to Length(s) do
    s2 := s2+ Copy(s,i,1);

  for i:=0 to Length(Clients)-1 do
    if Clients[i].name = clientSTR then
      begin
        ClientID := i;
        Break;
      end;
  if (ClientID = -1) then
    Exit;
  answer := ReadCommand(ClientID,alphaminBezTo4ek(s2));
  if (answer<>'') and (answer<>'-1') then
   SendMessageToClient(ClientID,answer);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  server.Active := true;
 //Пробуем создать БД команд
 if not FileExists('comm.dbf') then
  try
  DBF1.TableName:='comm.dbf';
  DBF1.AddFieldDefs('Id',bfString,10,0);
  DBF1.AddFieldDefs('Name',bfString,100,0);
  DBF1.AddFieldDefs('Words',bfString,100,0);
  DBF1.AddFieldDefs('Area',bfString,100,0);
  DBF1.AddFieldDefs('Status',bfString,100,0);
  DBF1.AddFieldDefs('GetAccept',bfString,1,0);
  DBF1.AddFieldDefs('Param',bfString,100,0);
  DBF1.AddFieldDefs('LastClient',bfString,100,0);
  DBF1.CreateTable;
  DBF1.close;
  except
    Log('не могу создать comm.dbf!!!');
    Exit;
    end
 else LoadCommBase();

 //Пробуем создать БД клиентов
 if not FileExists('clients.dbf') then
  try
  DBF2.TableName:='clients.dbf';
  DBF2.AddFieldDefs('Name',bfString,100,0);
  DBF2.AddFieldDefs('IP',bfString,100,0);
  DBF2.AddFieldDefs('LastTime',bfString,100,0);
  DBF2.AddFieldDefs('LastDate',bfString,100,0);
  DBF2.AddFieldDefs('LastCommand',bfString,100,0);
  DBF2.CreateTable;
  DBF2.close;
  except
    Log('не могу создать clients.dbf!!!');
    Exit;
    end
 else LoadClients();

  LastWork := -1;
  CurrentWork := -1;
  Podtverjdenie := False;
  ZaprosPodtverjdeniya := False;

  Log('Привет. Я начал работу на компьютере ' + GetComputerNName);
end;

end.
