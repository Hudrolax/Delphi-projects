unit robot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCPort, StdCtrls, Buttons, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPServer, IdTCPConnection, IdTCPClient, Math;

type
  TForm1 = class(TForm)
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    baza: TIdTCPClient;
    Button1: TButton;
    procedure FormCrem1ate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
       procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Kup,Kdown,Kleft,Kright:Boolean;
  pause:Integer;
  vpered,nazad,vlevo,vpravo:Boolean;
  vpered1,nazad1,vlevo1,vpravo1:Boolean;
  rand:Boolean;

implementation

{$R *.dfm}



procedure TForm1.FormCrem1ate(Sender: TObject);
begin
 try
  baza.Host:='hud.net.ru';
  baza.Connect();
   except
   ShowMessage('Не могу подключиться !!!');
     end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
baza.Disconnect;
end;


//******************************
// Вперед +
procedure TFW;
begin
  if (not vpered1) and (not nazad1) then
  if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('up +');
   vpered1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вперед -
procedure FFW;
begin
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('up -');
   vpered1:=False;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Назад +
procedure TRV;
begin
 if (not nazad1) and (not vpered1) then
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('down +');
   nazad1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Назад -
procedure FRV;
begin
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('down -');
   nazad1:=false;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Влево +
procedure TLeft;
begin
 //if (not vlevo1) and (not vpravo1) then
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('left +');
  vlevo1:=True;
 end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Влево -
procedure FLeft;
begin
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('left -');
  vlevo1:=False;
 end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вправо +
procedure TRight;
begin
 //if (not vpravo1) and (not vlevo1) then
 if Form1.baza.Connected then
  begin
   Form1.baza.WriteLn('right +');
   vpravo1:=True;
  end else ShowMessage('Отсутствует подключение к серверу!');
end;

// Вправо -
procedure FRight;
begin
 if Form1.baza.Connected then
 begin
  Form1.baza.WriteLn('right -');
  vpravo1:=false;
 end else ShowMessage('Отсутствует подключение к серверу!');
 end;

//******************************
procedure TForm1.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TFW;
end;

procedure TForm1.Button1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FFW;
end;

procedure TForm1.Button9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TRV;
end;

procedure TForm1.Button9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
FRV;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
case key of
  37:if true then
     begin
       {ВЛЕВО}
        SendMessage(form1.Button4.Handle, bm_SetState, 1, 0);
        TLeft;
        Kleft:=true;

     end;
  38:if not Kdown then
     begin
       {ВВЕРХ}
        TFW;
        Kup:=True;

     end;
  39:if true then
     begin
       {ВПРАВО}
        SendMessage(form1.Button3.Handle, bm_SetState, 1, 0);
        TRight;
        Kright:=True;
     end;
  40:if not Kup then
     begin
       {ВНИЗ}
        TRV;
        Kdown:=True;
     end;
end;


end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
case key of
  37:begin
       {ВЛЕВО}
        SendMessage(form1.Button4.Handle, bm_SetState, 0, 0);
        FLeft;
        Kleft:=False;

     end;
  38:begin
       {ВВЕРХ}
        FFW;
        Kup:=false;

     end;
  39:begin
       {ВПРАВО}
        SendMessage(form1.Button3.Handle, bm_SetState, 0, 0);
        FRight;
        Kright:=False;

     end;
  40:begin
       {ВНИЗ}
        FRV;
        Kdown:=False;

     end;
end;
end;

procedure TForm1.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
 TLeft;
end;

procedure TForm1.Button4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
FLeft;
Button4.Visible := false;
Button4.Visible := true;
end;

procedure TForm1.Button3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
TRight;
end;

procedure TForm1.Button3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := false;
  Timer1.Enabled := true;
FRight;
Button3.Visible := false;
Button3.Visible := true;
end;

procedure TForm1.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
TFW;
end;

procedure TForm1.Button1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FFW;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
Form1.SetFocus;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 Form1.Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 TRight;
 TLeft;
 Sleep(1000);
 fleft;
 FRight;
end;

end.
