unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, StdCtrls, ZipForge;

type
  TForm1 = class(TForm)
    Button1: TButton;
    zp1: TZipForge;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  jpg: TJpegImage;
  bmp:TBitmap;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    bmp := TBitmap.Create;
    bmp.Width := Screen.Width;
    bmp.Height := Screen.Height;
    BitBlt(bmp.Canvas.Handle, 0,0, Screen.Width, Screen.Height,
           GetDC(0), 0,0,SRCAND);

    jpg := TJpegImage.Create;
    jpg.CompressionQuality:=30;
    jpg.Grayscale := false;
    jpg.Performance := jpBestSpeed;
    jpg.PixelFormat := jf8Bit;
    jpg.Assign(bmp);
      jpg.Performance := jpBestSpeed;
    jpg.PixelFormat := jf8Bit;
    jpg.Compress;
    jpg.SaveToFile('c:\temp\test.jpg');

  with zp1 do
  begin
      FileName:='c:\temp\test.zip';
      OpenArchive(fmCreate);
      BaseDir:='c:\temp\';
      AddFiles('test.jpg');
      CloseArchive;
  end;

end;

end.
