{ ############################################################################ }
{ #                                                                          # }
{ #  MSpeech v1.2 - ������������� ���� ��������� Google Speech API           # }
{ #                                                                          # }
{ #  License: GPLv3                                                          # }
{ #                                                                          # }
{ #  Author: Grigorev Michael (icq: 161867489, email: sleuthhound@gmail.com) # }
{ #                                                                          # }
{ ############################################################################ }

program MSpeech;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  OnlyOneRun in 'OnlyOneRun.pas',
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  Global in 'Global.pas';

{$R *.res}

begin
  if not Init_Mutex(ProgramsName) then
  begin
    Application.MessageBox('��������� ��� ��������.', '������ �������', 0 or 48);
    Exit;
  end;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MSpeech - ������������� ������ � ������� GoogleSpeech';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
