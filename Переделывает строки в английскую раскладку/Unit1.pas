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
     if Copy(s,i,1) = 'é' then s2:=s2+'q' else
     if Copy(s,i,1) = 'ö' then s2:=s2+'w' else
     if Copy(s,i,1) = 'ó' then s2:=s2+'e' else
     if Copy(s,i,1) = 'ê' then s2:=s2+'r' else
     if Copy(s,i,1) = 'å' then s2:=s2+'t' else
     if Copy(s,i,1) = 'í' then s2:=s2+'y' else
     if Copy(s,i,1) = 'ã' then s2:=s2+'u' else
     if Copy(s,i,1) = 'ø' then s2:=s2+'i' else
     if Copy(s,i,1) = 'ù' then s2:=s2+'o' else
     if Copy(s,i,1) = 'ç' then s2:=s2+'p' else
     //if Copy(s,i,1) = 'õ' then s2:=s2+'[' else
     //if Copy(s,i,1) = 'ú' then s2:=s2+']' else
     if Copy(s,i,1) = 'ô' then s2:=s2+'a' else
     if Copy(s,i,1) = 'û' then s2:=s2+'s' else
     if Copy(s,i,1) = 'â' then s2:=s2+'d' else
     if Copy(s,i,1) = 'à' then s2:=s2+'f' else
     if Copy(s,i,1) = 'ï' then s2:=s2+'g' else
     if Copy(s,i,1) = 'ð' then s2:=s2+'h' else
     if Copy(s,i,1) = 'î' then s2:=s2+'j' else
     if Copy(s,i,1) = 'ë' then s2:=s2+'k' else
     if Copy(s,i,1) = 'ä' then s2:=s2+'l' else
     //if Copy(s,i,1) = 'æ' then s2:=s2+';' else
     //if Copy(s,i,1) = 'ý' then s2:=s2+'''' else
     if Copy(s,i,1) = 'ÿ' then s2:=s2+'z' else
     if Copy(s,i,1) = 'ñ' then s2:=s2+'c' else
     if Copy(s,i,1) = 'ì' then s2:=s2+'v' else
     if Copy(s,i,1) = 'è' then s2:=s2+'b' else
     if Copy(s,i,1) = 'ò' then s2:=s2+'n' else
     if Copy(s,i,1) = 'ü' then s2:=s2+'m' else
     //if Copy(s,i,1) = 'á' then s2:=s2+',' else
     //if Copy(s,i,1) = 'þ' then s2:=s2+'.' else
     //if Copy(s,i,1) = '.' then s2:=s2+'/' else
     if Copy(s,i,1) = 'É' then s2:=s2+'Q' else
     if Copy(s,i,1) = 'Ö' then s2:=s2+'W' else
     if Copy(s,i,1) = 'Ó' then s2:=s2+'E' else
     if Copy(s,i,1) = 'Ê' then s2:=s2+'R' else
     if Copy(s,i,1) = 'Å' then s2:=s2+'T' else
     if Copy(s,i,1) = 'Í' then s2:=s2+'Y' else
     if Copy(s,i,1) = 'Ã' then s2:=s2+'U' else
     if Copy(s,i,1) = 'Ø' then s2:=s2+'I' else
     if Copy(s,i,1) = 'Ù' then s2:=s2+'O' else
     if Copy(s,i,1) = 'Ç' then s2:=s2+'P' else
     //if Copy(s,i,1) = 'Õ' then s2:=s2+'{' else
     //if Copy(s,i,1) = 'Ú' then s2:=s2+'}' else
     if Copy(s,i,1) = 'Ô' then s2:=s2+'A' else
     if Copy(s,i,1) = 'Û' then s2:=s2+'S' else
     if Copy(s,i,1) = 'Â' then s2:=s2+'D' else
     if Copy(s,i,1) = 'À' then s2:=s2+'F' else
     if Copy(s,i,1) = 'Ï' then s2:=s2+'G' else
     if Copy(s,i,1) = 'Ð' then s2:=s2+'H' else
     if Copy(s,i,1) = 'Î' then s2:=s2+'J' else
     if Copy(s,i,1) = 'Ë' then s2:=s2+'K' else
     if Copy(s,i,1) = 'Ä' then s2:=s2+'L' else
     //if Copy(s,i,1) = 'Æ' then s2:=s2+':' else
     //if Copy(s,i,1) = 'Ý' then s2:=s2+'"' else
     if Copy(s,i,1) = 'ß' then s2:=s2+'Z' else
     if Copy(s,i,1) = '×' then s2:=s2+'X' else
     if Copy(s,i,1) = 'Ñ' then s2:=s2+'C' else
     if Copy(s,i,1) = 'Ì' then s2:=s2+'V' else
     if Copy(s,i,1) = 'È' then s2:=s2+'B' else
     if Copy(s,i,1) = 'Ò' then s2:=s2+'N' else
     if Copy(s,i,1) = 'Ü' then s2:=s2+'M' else
     //if Copy(s,i,1) = 'Á' then s2:=s2+'<' else
     //if Copy(s,i,1) = 'Þ' then s2:=s2+'>' else
     //if Copy(s,i,1) = '.' then s2:=s2+'?';
    end;
    Writeln(f2,s2);
    end;
  CloseFile(f2);
  CloseFile(f1);
 end;

end.
