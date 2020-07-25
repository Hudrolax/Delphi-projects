program ScrFlip;

uses
  Forms,
  Frm_ScrFlip in 'Frm_ScrFlip.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'he he';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
