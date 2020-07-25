program CPScanProcess;

uses
  Forms,
  main in 'main.pas' {Form1},
  Gvar in 'gvar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CPScanProcess';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
