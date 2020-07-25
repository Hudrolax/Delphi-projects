unit sver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Button1: TButton;
    Button2: TButton;
    Memo4: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
begin

for i:=0 to form1.Memo1.Lines.Count-1 do
 if strtofloat(form1.Memo1.Lines.Strings[i])<>strtofloat(form1.Memo2.Lines.Strings[i]) then
 form1.Memo3.Lines.Add(memo4.Lines.Strings[i]+'  '+memo1.Lines.Strings[i]+' и '+memo2.Lines.Strings[i]);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
i,j:integer;
s:string;
begin
for i:=0 to form1.Memo1.Lines.Count-1 do
if memo1.Lines.Strings[i]='' then memo1.Lines.Delete(i);

for i:=0 to form1.Memo4.Lines.Count-1 do
if memo4.Lines.Strings[i]='' then memo4.Lines.Delete(i);

for i:=0 to form1.Memo2.Lines.Count-1 do
if memo2.Lines.Strings[i]='' then memo2.Lines.Delete(i);

for i:=0 to form1.Memo1.Lines.Count-1 do
if copy(memo1.Lines.Strings[i],1,1)='-' then memo1.Lines.Strings[i]:=copy(memo1.Lines.Strings[i],2,length(memo1.Lines.Strings[i])-1);

for i:=0 to form1.Memo1.Lines.Count-1 do
 begin
 s:='';
  if ansipos(' ',memo1.Lines.Strings[i])<>0 then begin
   s:=s+copy(memo1.Lines.Strings[i],1,ansipos(' ',memo1.Lines.Strings[i]));
   s:=s+copy(memo1.Lines.Strings[i],ansipos(' ',memo1.Lines.Strings[i]),length(memo1.Lines.Strings[i]));
   memo1.Lines.Strings[i]:=s;
  end;
 end;

for i:=0 to memo4.Lines.Count-1 do
 if ansipos('Итого по клиенту:',memo4.Lines.Strings[i])<>0 then memo4.Lines.Delete(i);


 end;

procedure TForm1.Button3Click(Sender: TObject);
var i:INTEGER;
begin
for i:=2 to memo1.Lines.Count-1 do
  if strtofloat(memo1.Lines.strings[i])=strtofloat(memo1.Lines.Strings[i-1]) then memo1.Lines.Delete(i-1);

 for i:=3 to memo1.Lines.Count-1 do
  if strtofloat(memo1.Lines.strings[i])=(strtofloat(memo1.Lines.Strings[i-1])+strtofloat(memo1.Lines.strings[i-2]))
    then begin
    memo1.Lines.Delete(i-1);
    memo1.lines.Delete(i-2);
    end;

 for i:=4 to memo1.Lines.Count-1 do
  if strtofloat(memo1.Lines.strings[i])=strtofloat(memo1.Lines.Strings[i-1])+strtofloat(memo1.Lines.strings[i-2])+strtofloat(memo1.Lines.Strings[i-3])
    then begin
    memo1.Lines.Delete(i-1);
    memo1.lines.Delete(i-2);
    memo1.Lines.Delete(i-3);
    end;

for i:=5 to memo1.Lines.Count-1 do
  if strtofloat(memo1.Lines.strings[i])=strtofloat(memo1.Lines.Strings[i-1])+strtofloat(memo1.Lines.strings[i-2])+strtofloat(memo1.lines.strings[i-3])+strtofloat(memo1.lines.strings[i-4])
    then begin
    memo1.Lines.Delete(i-1);
    memo1.lines.Delete(i-2);
    memo1.Lines.Delete(i-3);
    memo1.Lines.Delete(i-4);
    end;

for i:=6 to memo1.Lines.Count-1 do
  if strtofloat(memo1.Lines.strings[i])=strtofloat(memo1.Lines.Strings[i-1])+strtofloat(memo1.Lines.strings[i-2])+strtofloat(memo1.lines.strings[i-3])+strtofloat(memo1.lines.strings[i-4])+strtofloat(memo1.lines.strings[i-5])
    then begin
    memo1.Lines.Delete(i-1);
    memo1.lines.Delete(i-2);
    memo1.Lines.Delete(i-3);
    memo1.Lines.Delete(i-4);
    memo1.Lines.Delete(i-5);
    end;


// for i:=1 to memo2.Lines.Count-1 do
//  if strtofloat(memo2.Lines.strings[i])=strtofloat(memo2.Lines.Strings[i-1]) then memo2.Lines.Delete(i-1);

// for i:=2 to memo2.Lines.Count-1 do
//  if strtofloat(memo2.Lines.strings[i])=strtofloat(memo2.Lines.Strings[i-1])+strtofloat(memo2.Lines.strings[i-2])
 //   then begin
 //   memo2.Lines.Delete(i-1);
 //   memo2.lines.Delete(i-2);
 //   end;

// for i:=3 to memo1.Lines.Count-1 do
//  if strtofloat(memo2.Lines.strings[i])=strtofloat(memo2.Lines.Strings[i-1])+strtofloat(memo2.Lines.strings[i-2])+strtofloat(memo2.Lines.Strings[i-3])
 //   then begin
 //   memo2.Lines.Delete(i-1);
 //   memo2.lines.Delete(i-2);
 //   memo2.Lines.Delete(i-3);
 //   end;

//for i:=4 to memo2.Lines.Count-1 do
//  if strtofloat(memo2.Lines.strings[i])=strtofloat(memo2.Lines.Strings[i-1])+strtofloat(memo2.Lines.strings[i-2])+strtofloat(memo2.lines.strings[i-3])+strtofloat(memo2.lines.strings[i-4])
 //   then begin
 //   memo2.Lines.Delete(i-1);
  //  memo2.lines.Delete(i-2);
  //  memo2.Lines.Delete(i-3);
  //  memo2.Lines.Delete(i-4);
  //  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var i:integer;
s:real;
begin
s:=0;
for i:=0 to memo1.Lines.Count-1 do
 s:=s+strtofloat(memo1.Lines.Strings[i]);
showmessage(floattostr(s));
end;

end.
