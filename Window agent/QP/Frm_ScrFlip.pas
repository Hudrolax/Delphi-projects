unit Frm_ScrFlip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DesktopCanvas, QuickPixel;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  B: TBitmap;
  Desktop: TDesktopCanvas;
  QP: TQuickPixel;
  X, Y: Integer;
  EndCopyIndex: Integer;
  Temp: TColor;
begin
  Left:= 0;
  Top:= 0;
  Width:= Screen.Width;
  Height:= Screen.Height;
  B:= nil;
  Desktop:= nil;
  try
    Desktop:= TDesktopCanvas.Create;
    B:= TBitmap.Create;
    B.Width:= Screen.Width;
    B.Height:= Screen.Height;
    B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Desktop, Rect(0, 0, B.Width, B.Height));
    B.PixelFormat:= pf24bit;
    B.SaveToFile('c:\test.bmp');
    QP:= TQuickPixel.Create(B);
    try
      for Y:= 0 to (QP.Height div 2)-1 do
      begin
        EndCopyIndex:= (QP.Height-1)-Y;
        for X:= 0 to QP.Width-1 do
        begin
          Temp:= QP.Pixel[X, Y];
          QP.Pixel[X, Y]:= QP.Pixel[X, EndCopyIndex];
          QP.Pixel[X, EndCopyIndex]:= Temp;
        end;
      end;
    finally
      QP.Free;
    end;
    with Image1.Picture.Bitmap do
    begin
      Width:= Image1.Width;
      Height:= Image1.Height;
      Canvas.CopyRect(Rect(0, 0, Width, Height), B.Canvas, Rect(0, 0, Width, Height));
    end;
  finally
    B.Free;
    Desktop.Free;
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  Close;
end;

end.
