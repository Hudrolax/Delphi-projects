unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Button4: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  var napr_pred, napr_pred2, k:integer;

implementation

uses Math;

{$R *.dfm}
function InObj(x,y,dx,dy,dx1,dy1:integer):boolean;
begin
  Result:=False;
 if (x>dx) and (x<dx+dx1) AND (y>dy) and (y<dy+dy1) then
   Result:=true;
end;

Function CanMove(x,y:integer):boolean;
var i,j:integer;
begin
 Result:= true;
 for i:=x to x+Form1.Button1.Width do
  for j:=y to y+Form1.Button1.Height do
    if NOT InObj(i,j,0,0,Form1.Width-11,Form1.Height-25) OR
       InObj(i,j,Form1.Button2.Left,Form1.Button2.Top,Form1.Button2.Width,Form1.Button2.Height) OR
       InObj(i,j,Form1.Button3.Left,Form1.Button3.Top,Form1.Button3.Width,Form1.Button3.Height)
    then
      Result:=False;
end;

Function Move(napr:integer):boolean;
var X,Y:integer;
begin
 X:=Form1.Button1.Left;
 Y:=Form1.Button1.Top;
 if napr = 0 then
  Y:=y+10
 else if napr = 1 then
  X:=X+10
 else if napr = 2 then
  Y:=Y-10
 else if napr = 3 then
  X:=X-10;
 If CanMove(x,y) then
  begin
    Form1.Button1.Left:=X;
    Form1.Button1.Top:=Y;
    Move:=True;
  end
 else
    Move:=False;
 Application.ProcessMessages;
 If Tracert
 sleep(100);
end;

function Tracert:integer;
var x,y:integer;
begin
 x:=Form1.Button1.Left;
 y:=Form1.Button1.Top;
 While CanMove(x,y) do
  begin
   y:=y+1;
   if InObj(x,y) then
    begin
     Result:=0;
     Exit;
    end;
  end;

 x:=Form1.Button1.Left;
 y:=Form1.Button1.Top;
 While CanMove(x,y) do
  begin
   x:=x+1;
   if InObj(x,y) then
    begin
     Result:=1;
     Exit;
    end;
  end;

  x:=Form1.Button1.Left;
 y:=Form1.Button1.Top;
 While CanMove(x,y) do
  begin
   y:=y-1;
   if InObj(x,y) then
    begin
     Result:=2;
     Exit;
    end;
  end;

 x:=Form1.Button1.Left;
 y:=Form1.Button1.Top;
 While CanMove(x,y) do
  begin
   x:=x-1;
   if InObj(x,y) then
    begin
     Result:=3;
     Exit;
    end;
  end;

  Result:=5;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var napr:integer;
begin
  timer1.Enabled:=false;
 If DestCord(Form1.Button1.Left,Form1.Button1.Top,Form1.Button1.Width,Form1.Button1.Height) then
  begin
  Label1.Caption:='Да';
  Timer1.Enabled:=false;
  end
  else
  begin
    Randomize;
    napr:=RandomRange(0,3);
    if (napr_pred<>napr) then
      begin
       napr_pred:=napr;
      end;
       While Move(napr) do
        Label1.Caption:='Нет';
       end;
  end;
  timer1.Enabled:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Timer1.Enabled:=true;
end;

end.
