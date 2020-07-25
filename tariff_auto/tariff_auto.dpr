program tariff_auto;

uses
  Forms,
  tariff in 'tariff.pas' {Form1},
  Gvar in 'Gvar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
