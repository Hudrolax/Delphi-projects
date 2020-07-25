unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;
type regfile = record
  name:string[255];
  key:string[255];
  date:string[255];
  activited:boolean;
  end;
type
  TForm2 = class(TForm)
    StaticText1: TStaticText;
    Edit1: TEdit;
    Edit2: TEdit;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    Button1: TButton;
    Button2: TButton;
    date2: TDateTimePicker;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  f:file of regfile;
  regv,regv2:regfile;
  gkey:string;

implementation

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
form2.Close;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
i:integer;
s:string;
n:string;
sk,nk:string;
sm:array[0..20] of string;
summ:integer;
begin
s:=edit1.Text;
n:=edit2.Text;
//Числовой эквивалент
for i:=0 to 20 do
sm[i]:='';
summ:=0;
s:=lowerCase(s);
sk:='';
nk:='';
for i:=1 to length(s) do begin
if (copy(s,i,1)='g') or (copy(s,i,1)='q') or (copy(s,i,1)='z') then sk:=sk+'1';
if (copy(s,i,1)='f') or (copy(s,i,1)='p') or (copy(s,i,1)='y') then sk:=sk+'2';
if (copy(s,i,1)='c') or (copy(s,i,1)='o') or (copy(s,i,1)='x') then sk:=sk+'3';
if (copy(s,i,1)='d') or (copy(s,i,1)='m') or (copy(s,i,1)='w') then sk:=sk+'4';
if (copy(s,i,1)='c') or (copy(s,i,1)='l') or (copy(s,i,1)='v') then sk:=sk+'5';
if (copy(s,i,1)='b') or (copy(s,i,1)='k') or (copy(s,i,1)='u') then sk:=sk+'6';
if (copy(s,i,1)='a') or (copy(s,i,1)='j') or (copy(s,i,1)='t') then sk:=sk+'7';
if (copy(s,i,1)='i') or (copy(s,i,1)='s') then sk:=sk+'8';
if (copy(s,i,1)='n') or (copy(s,i,1)='r') or (copy(s,i,1)='h') then sk:=sk+'9';
end;
for i:=1 to length(sk) do sm[i-1]:=copy(sk,i,1);
for i:=0 to length(sk)-1 do
summ:=summ+strtoint(sm[i]);
summ:=summ*99999-length(s);
nk:=inttostr(summ)+copy(sk,length(sk)-2,3);
gkey:=nk;
if gkey=edit2.text then begin
assignfile(f,'c:\reginfo.rbf');
rewrite(f);
regv.name:=edit1.text;
regv.activited:=true;
write(f,regv);
closefile(f);

try
assignfile(f,'c:\reginfo.rbf');
reset(f);
read(f,regv2);
if regv2.activited then begin
edit1.text:=regv2.name;
edit2.Text:=regv2.key;
edit1.Enabled:=false;
edit2.Enabled:=false;
closefile(f);
statictext1.Caption:=('Перезапустите программу');
                       end
except
assignfile(f,'c:\reginfo.rbf');
 rewrite(f);
 regv.name:='none';
 regv.key:='none';
 regv.date:='none';
 regv.activited:=false;
 write(f,regv);
 closefile(f);
end;

                        end
else begin
assignfile(f,'c:\reginfo.rbf');
rewrite(f);
regv.activited:=false;
write(f,regv);
closefile(f);
showmessage('Неверный ключ !!!');
edit2.text:='';
     end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
try
// assignfile(f,'c:\reginfo.rbf');
// reset(f);
// read(f,regv2);
// if regv2.activited then begin
// edit1.text:=regv2.name;
// edit2.Text:=regv2.key;
// edit1.Enabled:=false;
// edit2.Enabled:=false;
// closefile(f);
// statictext1.Caption:=('Перезапустите программу');
                    //   end
except
assignfile(f,'c:\reginfo.rbf');
 rewrite(f);
 regv.name:='none';
 regv.key:='none';
 regv.date:='none';
 regv.activited:=false;
 write(f,regv);
 closefile(f);
end;
 end;
end.
