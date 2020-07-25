unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Timer1Timer(Sender: TObject);
var f:TextFile;
begin
 Timer1.Enabled := False;
 try
   AssignFile(f,'kill.bat');
   Rewrite(f);
   Writeln(f,'taskkill.exe /f /t /im cgminer.exe');
   CloseFile(f);
   WinExec('kill.bat',0);
   except
     end;
     Application.Terminate;
end;

end.
