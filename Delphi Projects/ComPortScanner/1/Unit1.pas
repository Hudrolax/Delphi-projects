unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
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
Var SR:TSearchRec; // ��������� ����������
    FindRes:Integer; // ���������� ��� ������ ���������� ������
    f:textfile;
begin
ListBox1.Clear; // ������� ���������� ListBox1 ����� ���������� � ���� ������ ������

FindRes:=FindFirst('c:\scan\*.code',faAnyFile,SR); // ������� ������� ������ � ������ ������

While FindRes=0 do // ���� �� ������� ����� (��������), �� ��������� ����
   begin
      ListBox1.Items.Add(SR.Name); // ���������� � ������ �������� ���������� ��������

      If NOT FileExists(copy(SR.Name,1,15)+'.f') then
        begin
         assignfile(f,'c:\scan\'+copy(SR.Name,1,15)+'.f');
         rewrite(f);
         Closefile(f);
          end;
      FindRes:=FindNext(SR); // ����������� ������ �� �������� ��������
   end;
FindClose(SR); // ��������� �����
end;


end.
