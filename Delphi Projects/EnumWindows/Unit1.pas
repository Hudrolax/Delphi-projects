unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
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
var i:integer;
h:HWND;
s:PAnsiChar;
begin
 h:=0;
   while true do
    begin
     GetWindowText(h,s,0);
      if AnsiPos('Delphi',s)>0 then
       begin
        ShowMessage(s);
        Break;
       end;
      h:=h+1;
      end;
end;

end.
