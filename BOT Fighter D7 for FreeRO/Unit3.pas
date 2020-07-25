unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormActivate(Sender: TObject);
begin
memo1.Clear;
memo1.Lines.Add('************************************* ������ *************************************');
memo1.Lines.Add('������ 1.3');
memo1.Lines.Add('��������� ������� ������������ Heal � Teleport, �������� ����� ����� ����������������');
memo1.Lines.Add('������ 1.2');
memo1.Lines.Add('��� ����������� ������ ���������, ������� ������� ���.');
memo1.Lines.Add('������ 1.1');
memo1.Lines.Add('��� �������� ��������, �������, ����������� ����� ����� �����������');
memo1.Lines.Add('������ 1.0');
memo1.Lines.Add('��� ����� ������ ���� � �������� ���, � ������ ��� ������');
memo1.Lines.Add('************************************* ������� *************************************');
memo1.Lines.Add('��� ��������� ������������ �� ���� ���� ��� ���� Ragnarok');
memo1.Lines.Add('� ������� �� ������ �������� �������� �������� �� ����� �������,');
memo1.Lines.Add('������� motronline.com.');
memo1.Lines.Add('��� ��������� ������ �� ������� ���������� (����� flee) � ������');
memo1.Lines.Add('�������� ��� ���� ������, ������, �����, �����, ������(� ����� ���������), ������(agility),���� � ������');
memo1.Lines.Add('����� ������������ �������, ����������, ������� �� ������� ������� �����,');
memo1.Lines.Add('������ ���� ������ (��� ������), ������ ���� �����, �������� ���, ���� ����� � �������� ����.');
memo1.Lines.Add('���� ������ ��������� �� ���� ��� ����� �������� ������ ��������, �� ��������� ��� ����������� ������ ������,');
memo1.Lines.Add('� ��� �������� ����� � �������� ���.');
memo1.Lines.Add('************************************* ���������� *************************************');
memo1.Lines.Add('1) ���������� ���������� ������ 1280�1024 (�������� �������� � ������)');
memo1.Lines.Add('2) ��������� ���� � ������� ������ � ����������� 640�480 (Setup.exe)');
memo1.Lines.Add('3) ���� � ����� ����� �� ������������ ����, �� ������ ������������.');
memo1.Lines.Add('��� ����� ��� ������� ����������� ��������� ����.');
memo1.Lines.Add('4) ����� ���� � ����� � ������� ����� ���� ������, ���, ����� ����� �������');
memo1.Lines.Add('��������� ���� ������� �������� ����� ������ (����� ��������� ���� �� ������!)');
memo1.Lines.Add('5) ������\������ ����� ������ ������, ���� ����� ����.');
memo1.Lines.Add('6) �� F5 ������ ������ �����, �� ���� ������� � ������ ��� �� ���� � ������ � ���������� ����� ��� ����� ������');
memo1.Lines.Add('7) �� F6 ������� ����� ������');
memo1.Lines.Add('8) �� F4 ������� ������.');
memo1.Lines.Add('9) �� F8 ������� ����� ��� ��������');
memo1.Lines.Add('10) �� F3 ������� Heal (���� ����)');
memo1.Lines.Add('11) �� F7 ������� Teleport (���� ����)');
memo1.Lines.Add('12) ��������� ���� � ���������� ������ ��������� ��� ����� ������������ ����� ��� ������� �����');
memo1.Lines.Add('������������� ���� ���� � ������ ������ ���� (������ ����� �� �������)');
memo1.Lines.Add('13) ����� ��� ������ ���� Start/Stop, ����� ������� �� ���� � ����� ���� ������������ ��� � ���� Alt+F1 ����� ������ �����');
memo1.Lines.Add('��� ���������� ���� � ����� ������ �� �� ������ � ������� ������. ���������� ��� ����� ��� �� ����� Alt+F1');
memo1.Lines.Add('� ���� ��������� ����� �������� �� hudrolax@mail.ru, ��������� ��������� ���� �� � ����� "BOT Fighter"');
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
form3.Close;
end;

end.
