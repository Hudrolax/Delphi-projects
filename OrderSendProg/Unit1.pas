unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn1: TButton;
    btn2: TButton;
    Edit4: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var f:textfile;
begin
  AssignFile(f,edit4.text);
  Rewrite(f);
  writeln(f,'0;'+edit1.text+';0.0;'+edit2.text+';'+edit3.text+';');
  CloseFile(f);
end;

procedure TForm1.btn2Click(Sender: TObject);
var f:textfile;
begin
AssignFile(f,edit4.text);
  Rewrite(f);
  writeln(f,'1;'+edit1.text+';0.0;'+edit2.text+';'+edit3.text+';');
  CloseFile(f);
end;

end.
