program SpyMIne;

uses
  Forms,
  spymining in '..\spymining.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
