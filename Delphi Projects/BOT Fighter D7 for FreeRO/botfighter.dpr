program botfighter;

uses
  Forms,
  bot in 'bot.pas' {Form1},
  Unit3 in 'Unit3.pas' {Form3},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'BOT Fighter v1.4 - test version';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
