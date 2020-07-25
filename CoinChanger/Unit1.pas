unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, inifiles, StdCtrls;

type
  TForm1 = class(TForm)
    WorkTimer: TTimer;
    ftp: TIdFTP;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure WorkTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  EXEPath,FermName:string;
  Ini: Tinifile;

implementation

{$R *.dfm}

//........................................................................................................................
// Подключение к FTP
procedure connecttoftp;
var
  i:integer;
  ls2:TStringList;
  f:TextFile;
  s:string;
begin
   if Form1.ftp.Connected then form1.ftp.Disconnect;

   try
    Form1.ftp.Host:='hud.net.ru';
    Form1.ftp.Port:=21;
    Form1.ftp.Username:='ftp_com';
    Form1.ftp.Password:='nhbnsczxbktn';
    Form1.ftp.Connect();

    ls2:=TStringList.Create;
    ls2.Clear;
    Form1.ftp.List(ls2);

    if ls2.Count<>0 then
    for i:=0 to ls2.Count-1 do
     if AnsiPos('current_'+FermName+'.txt',ls2[i])<>0 then
      Form1.ftp.get('current_'+FermName+'.txt',EXEPath+'current_'+FermName+'.txt',true,false);

    if FileExists(EXEPath+'current_'+FermName+'.txt') then
    begin
     AssignFile(f,EXEPath+'current_'+FermName+'.txt');
     Reset(f);
     readln(f,s);
     CloseFile(f);

     if CopyFile(PChar(EXEPath+s),PChar(EXEPath+'cgminer.conf'),False) then
     begin
       Form1.lbl3.Caption := s;
       DeleteFile(EXEPath+'current_'+FermName+'.txt');
       AssignFile(f,EXEPath+'kill.bat');
       Rewrite(f);
       Writeln(f,'taskkill.exe /f /t /im cgminer.exe');
       CloseFile(f);
       WinExec(PChar(EXEPath+'kill.bat'),0);
       Form1.ftp.Delete('current_'+FermName+'.txt');
       Form1.ftp.Disconnect;
     end
     end
    except
    end;
end;

procedure TForm1.WorkTimerTimer(Sender: TObject);
begin
  WorkTimer.Enabled:=False;
  connecttoftp();
  WorkTimer.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EXEPath := extractfilepath(paramstr(0));

  if (not FileExists(EXEPath+'config.ini')) then
  begin
   Ini:=TiniFile.Create(EXEPath+'config.ini');
   Ini.WriteString('Base','FermName','');
   Ini.Free;
  end;

  Ini:=TiniFile.Create(EXEPath+'config.ini');
  FermName:=ini.ReadString('Base','FermName','');
  Ini.Free;

  if FermName = '' then
   begin
     ShowMessage('Не задано имя фермы в конфиге!!');
     Application.Terminate;
    end;
end;

end.
