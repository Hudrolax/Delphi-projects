unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient;

type
  TForm1 = class(TForm)
    IdIcmpClient1: TIdIcmpClient;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  GetReply:integer;
  AliveHost:Boolean;
  SendPing:Integer;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Form1.icmp1.Host:='mail.ru';
  Form1.icmp1.TTL:=114;
  Form1.icmp1.Ping;
  SendPing:=SendPing+1;
  Timer2.Enabled := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
AliveHost:=true;
end;

end.
