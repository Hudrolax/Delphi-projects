program QPixels;

uses
  Forms,
  UQPForm in 'UQPForm.pas' {Form1},
  UQPixels in 'UQPixels.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

