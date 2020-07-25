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
Var SR:TSearchRec; // поисковая переменная
    FindRes:Integer; // переменная для записи результата поиска
    f:textfile;
begin
ListBox1.Clear; // очистка компонента ListBox1 перед занесением в него списка файлов

FindRes:=FindFirst('c:\scan\*.code',faAnyFile,SR); // задание условий поиска и начало поиска

While FindRes=0 do // пока мы находим файлы (каталоги), то выполнять цикл
   begin
      ListBox1.Items.Add(SR.Name); // добавление в список название найденного элемента

      If NOT FileExists(copy(SR.Name,1,15)+'.f') then
        begin
         assignfile(f,'c:\scan\'+copy(SR.Name,1,15)+'.f');
         rewrite(f);
         Closefile(f);
          end;
      FindRes:=FindNext(SR); // продолжение поиска по заданным условиям
   end;
FindClose(SR); // закрываем поиск
end;


end.
