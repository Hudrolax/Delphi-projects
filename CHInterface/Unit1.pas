unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP;

type
  TForm1 = class(TForm)
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk4: TCheckBox;
    chk5: TCheckBox;
    chk6: TCheckBox;
    chk7: TCheckBox;
    chk8: TCheckBox;
    chk9: TCheckBox;
    chk10: TCheckBox;
    chk11: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    cbb1: TComboBox;
    btn1: TButton;
    ftp: TIdFTP;
    chk12: TCheckBox;
    lbl12: TLabel;
    lbl13: TLabel;
    chk13: TCheckBox;
    chk14: TCheckBox;
    lbl14: TLabel;
    lbl15: TLabel;
    chk15: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  EXEPath:string;

implementation

{$R *.dfm}
function connecttoftp():boolean;
begin
   if not Form1.ftp.Connected then
    try
     Form1.ftp.Host:='hud.net.ru';
     Form1.ftp.Port:=21;
     Form1.ftp.Username:='ftp_com';
     Form1.ftp.Password:='nhbnsczxbktn';
     Form1.ftp.Connect();
    except
    end;

    if Form1.ftp.Connected then Result:=True else Result:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 EXEPath := extractfilepath(paramstr(0));
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  f:TextFile;
  cointext:string;
begin
 if cbb1.Text = 'Novacoin Virpool' then cointext:='novacoin.conf' else
  if cbb1.Text = 'coinotron LTC' then cointext:='coinotron_LTC.conf' else
   if cbb1.Text = 'coinotron FTC' then cointext:='coinotron_FTC.conf' else
    if cbb1.Text = 'WeMineLTC LTC' then cointext:='cgminer_wemineltc.conf' else
    if cbb1.Text = 'DogeCoin' then cointext:='cgminer_doge.conf';
 AssignFile(f,'conf_ferm.txt');
 Rewrite(f);
 Writeln(f,cointext);
 CloseFile(f);
 if connecttoftp() then
 begin
  if chk1.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms1.txt',false);
    lbl1.Caption:='OK';
    lbl1.Font.Color := clGreen;
   end;

  if chk2.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms2.txt',false);
    lbl2.Caption:='OK';
    lbl2.Font.Color := clGreen;
   end;

  if chk3.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms3.txt',false);
    lbl3.Caption:='OK';
    lbl3.Font.Color := clGreen;
   end;

  if chk4.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms4.txt',false);
    lbl4.Caption:='OK';
    lbl4.Font.Color := clGreen;
   end;
   
  if chk5.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms5.txt',false);
    lbl5.Caption:='OK';
    lbl5.Font.Color := clGreen;
   end;

  if chk6.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms6.txt',false);
    lbl6.Caption:='OK';
    lbl6.Font.Color := clGreen;
   end;

  if chk7.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms7.txt',false);
    lbl7.Caption:='OK';
    lbl7.Font.Color := clGreen;
   end;

  if chk8.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms8.txt',false);
    lbl8.Caption:='OK';
    lbl8.Font.Color := clGreen;
   end;

  if chk9.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_server.txt',false);
    lbl9.Caption:='OK';
    lbl9.Font.Color := clGreen;
   end;

  if chk10.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_hudro.txt',false);
    lbl10.Caption:='OK';
    lbl10.Font.Color := clGreen;
   end;

  if chk11.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_tekilla.txt',false);
    lbl11.Caption:='OK';
    lbl11.Font.Color := clGreen;
   end;

  if chk12.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms9.txt',false);
    lbl12.Caption:='OK';
    lbl12.Font.Color := clGreen;
   end;

  if chk13.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms10.txt',false);
    lbl13.Caption:='OK';
    lbl13.Font.Color := clGreen;
   end;

  if chk14.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms11.txt',false);
    lbl14.Caption:='OK';
    lbl14.Font.Color := clGreen;
   end;

  if chk15.Checked then
   begin
    ftp.Put('conf_ferm.txt','current_ms12.txt',false);
    lbl15.Caption:='OK';
    lbl15.Font.Color := clGreen;
   end;
 end;
 DeleteFile('conf_ferm.txt');
 ftp.Disconnect;
end;

end.
