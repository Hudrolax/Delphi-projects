program scan_process_control;

uses
  Forms,
  process_control_main in 'process_control_main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
