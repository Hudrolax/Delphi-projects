unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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
function Sim(s:string):string;
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var f1, f2:textfile;
s,s2:string;
i:Integer;
begin
 AssignFile(f1,'1.spr');
 AssignFile(f2,'2.spr');
 reset(f1);
 rewrite(f2);
 while not eof(f1) do
  begin
   readln(f1,s);
   s2:='';
   for i:=1 to Length(s) do
    begin
     if Copy(s,i,1) = '�' then s2:=s2+'q' else
     if Copy(s,i,1) = '�' then s2:=s2+'w' else
     if Copy(s,i,1) = '�' then s2:=s2+'e' else
     if Copy(s,i,1) = '�' then s2:=s2+'r' else
     if Copy(s,i,1) = '�' then s2:=s2+'t' else
     if Copy(s,i,1) = '�' then s2:=s2+'y' else
     if Copy(s,i,1) = '�' then s2:=s2+'u' else
     if Copy(s,i,1) = '�' then s2:=s2+'i' else
     if Copy(s,i,1) = '�' then s2:=s2+'o' else
     if Copy(s,i,1) = '�' then s2:=s2+'p' else
     //if Copy(s,i,1) = '�' then s2:=s2+'[' else
     //if Copy(s,i,1) = '�' then s2:=s2+']' else
     if Copy(s,i,1) = '�' then s2:=s2+'a' else
     if Copy(s,i,1) = '�' then s2:=s2+'s' else
     if Copy(s,i,1) = '�' then s2:=s2+'d' else
     if Copy(s,i,1) = '�' then s2:=s2+'f' else
     if Copy(s,i,1) = '�' then s2:=s2+'g' else
     if Copy(s,i,1) = '�' then s2:=s2+'h' else
     if Copy(s,i,1) = '�' then s2:=s2+'j' else
     if Copy(s,i,1) = '�' then s2:=s2+'k' else
     if Copy(s,i,1) = '�' then s2:=s2+'l' else
     //if Copy(s,i,1) = '�' then s2:=s2+';' else
     //if Copy(s,i,1) = '�' then s2:=s2+'''' else
     if Copy(s,i,1) = '�' then s2:=s2+'z' else
     if Copy(s,i,1) = '�' then s2:=s2+'c' else
     if Copy(s,i,1) = '�' then s2:=s2+'v' else
     if Copy(s,i,1) = '�' then s2:=s2+'b' else
     if Copy(s,i,1) = '�' then s2:=s2+'n' else
     if Copy(s,i,1) = '�' then s2:=s2+'m' else
     //if Copy(s,i,1) = '�' then s2:=s2+',' else
     //if Copy(s,i,1) = '�' then s2:=s2+'.' else
     //if Copy(s,i,1) = '.' then s2:=s2+'/' else
     if Copy(s,i,1) = '�' then s2:=s2+'Q' else
     if Copy(s,i,1) = '�' then s2:=s2+'W' else
     if Copy(s,i,1) = '�' then s2:=s2+'E' else
     if Copy(s,i,1) = '�' then s2:=s2+'R' else
     if Copy(s,i,1) = '�' then s2:=s2+'T' else
     if Copy(s,i,1) = '�' then s2:=s2+'Y' else
     if Copy(s,i,1) = '�' then s2:=s2+'U' else
     if Copy(s,i,1) = '�' then s2:=s2+'I' else
     if Copy(s,i,1) = '�' then s2:=s2+'O' else
     if Copy(s,i,1) = '�' then s2:=s2+'P' else
     //if Copy(s,i,1) = '�' then s2:=s2+'{' else
     //if Copy(s,i,1) = '�' then s2:=s2+'}' else
     if Copy(s,i,1) = '�' then s2:=s2+'A' else
     if Copy(s,i,1) = '�' then s2:=s2+'S' else
     if Copy(s,i,1) = '�' then s2:=s2+'D' else
     if Copy(s,i,1) = '�' then s2:=s2+'F' else
     if Copy(s,i,1) = '�' then s2:=s2+'G' else
     if Copy(s,i,1) = '�' then s2:=s2+'H' else
     if Copy(s,i,1) = '�' then s2:=s2+'J' else
     if Copy(s,i,1) = '�' then s2:=s2+'K' else
     if Copy(s,i,1) = '�' then s2:=s2+'L' else
     //if Copy(s,i,1) = '�' then s2:=s2+':' else
     //if Copy(s,i,1) = '�' then s2:=s2+'"' else
     if Copy(s,i,1) = '�' then s2:=s2+'Z' else
     if Copy(s,i,1) = '�' then s2:=s2+'X' else
     if Copy(s,i,1) = '�' then s2:=s2+'C' else
     if Copy(s,i,1) = '�' then s2:=s2+'V' else
     if Copy(s,i,1) = '�' then s2:=s2+'B' else
     if Copy(s,i,1) = '�' then s2:=s2+'N' else
     if Copy(s,i,1) = '�' then s2:=s2+'M' else
     //if Copy(s,i,1) = '�' then s2:=s2+'<' else
     //if Copy(s,i,1) = '�' then s2:=s2+'>' else
     //if Copy(s,i,1) = '.' then s2:=s2+'?';
    end;
    Writeln(f2,s2);
    end;
  CloseFile(f2);
  CloseFile(f1);
 end;

end.
