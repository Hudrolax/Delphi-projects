unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 i:integer;
begin
  for i:=1 to StrToInt(Edit1.Text) do
    WinExec('ddos.bat',1);
end;

procedure TForm1.Button2Click(Sender: TObject);
var f:TextFile;
begin
  AssignFile(f,'stopping.bat');
  rewrite(f);
  Writeln(f,'%SystemRoot%\system32\taskkill.exe /F /IM ping.exe');
  CloseFile(f);
  WinExec('stopping.bat',1);
  //DeleteFile('stopping.bat');
end;

end.
