program JarvisEngine;

uses
  Forms,
  main in 'main.pas' {Form1},
  WorkDo in 'WorkDo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
