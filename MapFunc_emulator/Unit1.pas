unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function To4kToZap(s: string): string;
function ZapToT4k(s: string): string;  

var
  Form1: TForm1;

implementation

{$R *.dfm}
function ZapToT4k(s: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if copy(s, i, 1) = ',' then
      Result := Result + '.'
    else
      Result := Result + copy(s, i, 1);
end;

function To4kToZap(s: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if copy(s, i, 1) = '.' then
      Result := Result + ','
    else
      Result := Result + copy(s, i, 1);
end;

procedure TForm1.Button1Click(Sender: TObject);
var map:Extended;
x,in_min,in_max,out_min,out_max:Extended;

begin
  x:= StrToFloat(To4kToZap(Edit1.Text));
  in_min:= StrToFloat(To4kToZap(Edit2.Text));
  in_max:= StrToFloat(To4kToZap(Edit3.Text));
  out_min:= StrToFloat(To4kToZap(Edit4.Text));
  out_max:= StrToFloat(To4kToZap(Edit5.Text));

  map := (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
  Label1.Caption := FloatToStr(map);
end;

end.
