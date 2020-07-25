unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, StdCtrls, BCPort;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Com: TBComPort;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SecondForStart:integer;

implementation

{$R *.dfm}
procedure TForm1.Timer1Timer(Sender: TObject);
 var
 GetStr: WideString;
  i,EnabledChips:Integer;
  OneChipIsDead,ConnectedToCom:Boolean;
  CRbyte,LFbyte:ShortInt;
  buffer:string;
  pred:string;
  http:TIdHTTP;
begin
  Timer1.Enabled := False;
  try
    http := TIdHTTP.Create(nil);
    http.ReadTimeout := 5000;
    try
     GetStr := http.Get('http://192.168.18.70/miner.php?ref=0&rig=0');
    except
     Sleep(5000);
     Timer1.Enabled := True;
     Exit;
    end;
  finally
    FreeAndNil(http);
  end;
  EnabledChips := 0;
  OneChipIsDead := false;
  for i:=1 to Length(GetStr)-1 do
    if Copy(GetStr,i,3) = '>Y<' then
    begin
     EnabledChips := EnabledChips + 1;
     SecondForStart := 0;
    end;
  for i:=1 to Length(GetStr)-1 do
    if (Copy(GetStr,i,6) = '>Dead<') or (Copy(GetStr,i,6) = '>Sick<') then
    begin
     OneChipIsDead := True;
     SecondForStart := 0;
    end;
  for I := 1 to Length(GetStr)-1 do
    if Copy(GetStr,i,29) = 'ERR: socket connect(0) failed' then
      SecondForStart := SecondForStart+1;
   Sleep(60000);

  GetStr:='';
  if (OneChipIsDead) or (EnabledChips < 12) or (SecondForStart >= 60) then
  begin
    CRbyte := 13; // HEX 0x0D
    LFbyte := 10; // HEX 0x0A
    pred:=Char(CRbyte)+ Char(LFbyte);

  ConnectedToCom := false;
  for i:=1 to 15 do
    try
     Com.Port := 'COM'+inttostr(i);
     Com.Open;
     buffer:='$KE'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     com.Read(PChar(buffer)^,Length(buffer));
     if AnsiPos('#OK',buffer)>0 then
      begin
       ConnectedToCom := true;
       Com.Close;
       Break;
       end
      else
      begin
        Com.Close
      end;
    except
      Com.Close;
      end;
    if NOT ConnectedToCom then
    begin
      ShowMessage('Не могу установить соединение с модулем KE!');
      Exit;
    end
    else
    begin
      // Тут ребутаем асик
     Com.Open;
     buffer:='$KE,REL,4,1'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     Sleep(5000);
     buffer:='$KE,REL,4,0'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     Com.Close;
     sleep(300000);
    end;
  end;

  Label1.Caption := 'ASIC работает нормально';
  Label1.Font.Color := clGreen;
  Timer1.Enabled := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  CRbyte,LFbyte:ShortInt;
  buffer:string;
  pred:string;
  ConnectedToCom:Boolean;
  i:Integer;
begin
  CRbyte := 13; // HEX 0x0D
    LFbyte := 10; // HEX 0x0A
    pred:=Char(CRbyte)+ Char(LFbyte);

  ConnectedToCom := false;
  for i:=1 to 15 do
    try
     Com.Port := 'COM'+inttostr(i);
     Com.Open;
     buffer:='$KE'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     com.Read(PChar(buffer)^,Length(buffer));
     if AnsiPos('#OK',buffer)>0 then
      begin
       ConnectedToCom := true;
       Com.Close;
       Break;
       end
      else
      begin
        Com.Close
      end;
    except
      Com.Close;
      end;
    if NOT ConnectedToCom then
    begin
      ShowMessage('Не могу установить соединение с модулем KE!');
      Exit;
    end
    else
    begin
      // Тут ребутаем асик
     Com.Open;
     buffer:='$KE,REL,4,1'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     Sleep(5000);
     buffer:='$KE,REL,4,0'+pred;
     com.Write(PChar(buffer)^,Length(buffer));
     Com.Close;
    end;
end;

end.
