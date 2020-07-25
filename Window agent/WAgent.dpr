program WAgent;



uses
  Forms,
  wa in 'wa.pas' {Form1},
  addtask in 'addtask.pas' {Form2},
  edit_task in 'edit_task.pas' {Form3};

{$R *.res}
var i:integer;
begin
  Application.Initialize;
  Application.Title := 'Window Agent';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
