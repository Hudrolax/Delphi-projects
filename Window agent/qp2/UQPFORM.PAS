unit UQPForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  UQPixels, ComCtrls, ExtCtrls, Math, Jpeg, Buttons, Dialogs, ExtDlgs;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    RunTest: TButton;
    rgGetSet: TRadioGroup;
    cbBPP: TComboBox;
    chIndex: TCheckBox;
    Label1: TLabel;
    TestAll: TButton;
    rgEffects: TRadioGroup;
    OpenPictureDialog1: TOpenPictureDialog;
    LoadPic: TBitBtn;
    chKeep: TCheckBox;
    btReset: TButton;
    BitBtn1: TBitBtn;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure RunTestClick(Sender: TObject);
    procedure cbBPPChange(Sender: TObject);
    procedure TestAllClick(Sender: TObject);
    procedure rgEffectsClick(Sender: TObject);
    procedure LoadPicClick(Sender: TObject);
    procedure btResetClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  public
    procedure TestOneMode(BPP: integer; ByIndex, SetPix, DrawBmp: boolean);
    procedure Blur;
    procedure FlyImage;
    procedure LoadPicture;
  end;

const
  SomeColors: array[0..7] of TColor =
  (clBlack, clWhite, clRed, clGreen, clBlue, clGray, clLime, clAqua);
  BPPs: array[0..6] of integer = (1, 4, 8, 15, 16, 24, 32);

var
  Form1: TForm1;
  Bmp, NewBmp: TBitmap;
  QP, QP2: TQuickPixels;
  Freq: int64;
  TestBPP, Cnt: integer;
  Effect: integer;
  w, h: integer;
  x0: integer = -1;
  y0: integer = -1;
  FullRct, Rct: TRect;
implementation

{$R *.DFM}
{$R PIC.RES}

procedure TForm1.FormCreate(Sender: TObject);
var
  RS: TResourceStream;
  JP: TJpegImage;
begin
  cbBPP.ItemIndex := 6;
  TestBpp := 32;
  rgGetSet.ItemIndex := 0;
  RS := TResourceStream.Create(HInstance, 'PICT', 'RT_RCDATA');
  JP := TJpegImage.Create;
  Bmp := TBitmap.Create;
  try
    JP.LoadFromStream(RS);
    Bmp.Assign(JP);
  finally
    JP.Free;
    RS.Free;
  end;
  NewBmp := TBitmap.Create;
  QP := TQuickPixels.Create;
  QP2 := TQuickPixels.Create;
  QueryPerformanceFrequency(Freq);
  Cnt := 70000000 div Freq;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  xi, yi, xx, yy, ifi: integer;
  r, g, b: byte;
  c: TColor;

  procedure CalcXY(xi, yi, x, y, x0, y0, w1, h1: Integer; var xx, yy: Integer);
  var
    xb, yb, cf: double;
  begin
    {quasirubber surface
    x0 - old mouse coord
    x-   current
    xi -  new point
    xx -   old point (calculated from xi)
    xb -  sticking border point
    -----------------
    |                |
    |    x0        x |
    |                |
    |         xi     |
    |  xx            |
    |                |
    --xb-------------      }

    cf := y * xi - yi * x;
    if (xi < x) then
    begin
      xb := 0;
      yb := cf / (xi - x);
      if yb < 0 then
      begin
        xb := cf / (y - yi);
        yb := 0;
      end;
      if yb > h1 then
      begin
        xb := (h1 * (xi - x) - cf) / (yi - y);
        yb := h1;
      end;
    end
    else
    begin
      xb := w1;
      yb := (cf + w1 * (yi - y)) / (xi - x);
      if yb < 0 then
      begin
        xb := cf / (y - yi);
        yb := 0;
      end;
      if yb > h1 then
      begin
        xb := (h1 * (xi - x) - cf) / (yi - y);
        yb := h1;
      end;
    end;
    if xb <> x then
      xx := Round(xb + (x0 - xb) * (xi - xb) / (x - xb));
    if yb <> y then
      yy := Round(yb + (y0 - yb) * (yi - yb) / (y - yb));
  end;

begin
  case Effect of
    2: if PtInRect(FullRct, Point(x, y)) then
      begin
        for xi := 0 to w - 1 do
          for yi := 0 to h - 1 do
          begin
            ifi := Trunc(2 * (Hypot(x - xi, y - yi)));
            if ifi > 255 then
              ifi := 255;
            c := QP.getpixel(xi, yi);
            r := getRValue(c);
            g := getGValue(c);
            b := getBValue(c);
            r := (r * (255 - ifi) + 128 * ifi) shr 8;
            g := (g * (255 - ifi) + 128 * ifi) shr 8;
            b := (b * (255 - ifi) + 128 * ifi) shr 8;
            c := RGB(r, g, b);
            QP2.SetPixel(xi, yi, c);
          end;
        BitBlt(Canvas.Handle, 0, 0, w - 1, h - 1, NewBmp.Canvas.Handle, 0, 0,
          srccopy);
      end;
    3: if (ssLeft in Shift) and PtInRect(FullRct, Point(x, y)) then
      begin
        xx := x0 + w - x;
        yy := y0 + h - y;
        for xi := 0 to w - 1 do
          for yi := 0 to h - 1 do
            QP2.SetPixel(xi, yi, QP.GetPixel((xi + xx) mod w, (yi + yy) mod h));
        BitBlt(Canvas.Handle, 0, 0, w - 1, h - 1, NewBmp.Canvas.Handle, 0, 0,
          srccopy);
      end;
    4: if (ssLeft in Shift) and PtInRect(rct, point(x, y)) then
      begin
        for xi := 0 to w - 1 do
          for yi := 0 to h - 1 do
          begin
            CalcXY(xi, yi, x - Ord(xi = x), y, x0, y0, w, h, xx, yy);
            if (xx >= 0) and (yy >= 0) and (xx < w) and (yy < h) then
            begin
              c := QP.GetPixel(xx, yy);
              QP2.SetPixel(xi, yi, c);
            end;
          end;
        BitBlt(Canvas.Handle, 0, 0, w - 1, h - 1, NewBmp.Canvas.Handle, 0, 0,
          srccopy);
      end;
  end;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, j: integer;
  col: TColor;
begin
  if PtInRect(rct, Point(x, y)) then
  begin
    case Effect of
      2:
        begin
          Col := RGB(128, 128, 128);
          for i := 0 to w - 1 do
            for j := 0 to h - 1 do
              QP2.SetPixel(i, j, col);
          BitBlt(Canvas.Handle, 0, 0, w, h, NewBmp.Canvas.Handle, 0, 0,
            srccopy);
        end;
      3: if ssLeft in Shift then
        begin
          x0 := x;
          y0 := y;
          Screen.Cursor := crSizeAll;
        end;
      4: if ssLeft in Shift then
        begin
          x0 := x;
          y0 := y;
          Screen.Cursor := crHandPoint;
        end;
    end;
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Effect=4) and chKeep.Checked then begin
    Bmp.Assign(NewBmp);
    QP.Attach(Bmp);
    QP2.Attach(NewBmp);
  end;
  x0 := -1;
  y0 := -1;
  Screen.Cursor := crDefault;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  QP.Free;
  QP2.Free;
  Bmp.Free;
  NewBmp.Free;
end;

procedure TForm1.TestOneMode(BPP: integer; ByIndex, SetPix, DrawBmp: boolean);
var
  SmallBmp: TBitmap;
  Tim1, Tim2: int64;
  Seconds, OverHead: double;
  SetGet, sByIndex: string;
  i, j: DWord;
  Col: TColor;
begin
  SmallBmp := TBitmap.Create;
  SmallBmp.Width := 8;
  SmallBmp.Height := 8;
  case BPP of
    1: SmallBmp.PixelFormat := pf1bit;
    4: SmallBmp.PixelFormat := pf4bit;
    8: SmallBmp.PixelFormat := pf8bit;
    15: SmallBmp.PixelFormat := pf15bit;
    16: SmallBmp.PixelFormat := pf16bit;
    24: SmallBmp.PixelFormat := pf24bit;
    32: SmallBmp.PixelFormat := pf32bit;
  end;
  if DrawBmp then
  begin
    Refresh;
    SmallBmp.Canvas.Brush.Color := clWhite;
    SmallBmp.Canvas.FillRect(Rect(0, 0, SmallBmp.Width, SmallBmp.Height));
  end;
  QueryPerformanceCounter(Tim1);
  for i := 1 to Cnt * 1000000 do
  begin
    j := i and 7;
  end;
  QueryPerformanceCounter(Tim2);
  OverHead := (Tim2 - Tim1 + j -j) / Freq;
  if SetPix then
    SetGet := 'Set'
  else
    SetGet := 'Get';
  if BPP > 8 then
    ByIndex := False;
  if ByIndex then
    sByIndex := 'Indx'
  else
    sByIndex := '';
  QP.Attach(SmallBmp);
  if QP.BPP <= 8 then
    QP.ByPaletteIndex := ByIndex
  else
    QP.ByPaletteIndex := False;
  if SetPix then
  begin
    QueryPerformanceCounter(Tim1);
    for i := 1 to Cnt * 1000000 do
    begin
      j := i and 7;
      QP.SetPixel(j, j, clRed);
    end;
    QueryPerformanceCounter(Tim2);
    if DrawBmp then
      Canvas.StretchDraw(Rect(0, 0, 80, 80), SmallBmp);
    Seconds := (Tim2 - Tim1) / Freq;
  end
  else
  begin
    for i := 0 to 7 do
      for j := 0 to 7 do
        SmallBmp.Canvas.Pixels[i, j] := SomeColors[j];
    QueryPerformanceCounter(Tim1);
    for i := 1 to Cnt * 1000000 do
    begin
      j := i and 7;
      Col := QP.GetPixel(j, j);
    end;
    QueryPerformanceCounter(Tim2);
    if DrawBmp then
      Canvas.StretchDraw(Rect(0, 0, 80, 80), SmallBmp);
    Seconds := (Tim2 - Tim1) / Freq;
  end;
  Memo1.Lines.Add(Format('%2d bpp %s%4s: %5f MP/s',
    [BPP, SetGet, sByIndex, Cnt / (Seconds - OverHead)]));
  SmallBmp.Free;
end;

procedure TForm1.RunTestClick(Sender: TObject);
begin
  Effect := 0;
  TestOneMode(TestBpp, chIndex.Checked, rgGetSet.ItemIndex = 1, True);
end;

procedure TForm1.cbBPPChange(Sender: TObject);
begin
  TestBpp := BPPs[cbBPP.ItemIndex]
end;

procedure TForm1.TestAllClick(Sender: TObject);
var
  i: Integer;
  GetSet, byIndx: Boolean;
begin
  Refresh;
  Effect := 0;
  Memo1.Clear;
  for GetSet := False to True do
  begin
    for i := 0 to 6 do
      for byIndx := False to (i < 3) do
        TestOneMode(BPPs[i], byIndx, GetSet, False);
    Memo1.Lines.Add('');
  end;
end;

procedure TForm1.rgEffectsClick(Sender: TObject);
begin
  Refresh;
  Effect := rgEffects.ItemIndex;
  case Effect of
    0: Blur;
    1: FlyImage;
  else
    begin
      NewBmp.Assign(Bmp);
      Canvas.Draw(0, 0, NewBmp);
      QP.Attach(Bmp);
      QP2.Attach(NewBmp);
      w := QP.Width;
      h := QP.Height;
      Rct := Rect(5, 5, w - 6, h - 6);
      FullRct := Rect(0, 0, w - 1, h - 1);
    end;
  end;
end;

procedure TForm1.Blur;
var
  fl: array[-1..1, -1..1] of integer;
  bm: TBitmap;
  i, j, k, l: integer;
  r, g, b: integer;
  c: tcolor;
begin
  for k := -1 to 1 do
    for l := -1 to 1 do
      fl[k, l] := 1;
  fl[0, 0] := 4;
  bm := TBitmap.Create;
  bm.width := 200;
  bm.height := 200;
  bm.PixelFormat := pf24bit;
  QP.Attach(bm);
  for i := 0 to 9 do
  begin
    bm.Canvas.MoveTo(0, 10 + i * 20);
    bm.Canvas.LineTo(200, 10 + i * 20);
    bm.Canvas.MoveTo(10 + i * 20, 0);
    bm.Canvas.LineTo(10 + i * 20, 200);
  end;
  canvas.Draw(0, 0, bm);
  for i := 1 to QP.Width - 2 do
    for j := 1 to QP.Height - 2 do
    begin
      r := 0;
      b := 0;
      g := 0;
      for k := -1 to 1 do
        for l := -1 to 1 do
        begin
          c := QP[i + k, j + l];
          inc(r, fl[k, l] * GetRValue(c));
          inc(g, fl[k, l] * GetGValue(c));
          inc(b, fl[k, l] * GetBValue(c));
        end;
      QP[i, j] := RGB(r div 12, g div 12, b div 12);
    end;
  canvas.Draw(0, 210, bm);
  bm.free;
end;

procedure TForm1.FlyImage;
var
  k, x_new, y_new, x0, y0: integer;
  fac: double;
  cosphi, sinphi, x, y, dx, dy: integer;

const
  BinaryFactor = 10;

  function rnd(const x, y: Integer): TPoint;
  begin
    Result.X := x shr BinaryFactor;
    Result.Y := y shr BinaryFactor;
  end;

begin
  NewBmp.Assign(Bmp);
  QP.Attach(Bmp);
  QP2.Attach(NewBmp);
  w := QP.Width;
  h := QP.Height;
  x0 := (w div 2);
  y0 := (h div 2);
  for k := 1 to 1080 do
  begin
    fac := Sqr(1080 / k);
    dx := round(w * 512 * cos(k * Pi / 400) * (1 - fac));
    dy := round(w * 512 * sin(k * Pi / 400) * (1 - fac));
    cosphi := round(fac * cos(k * Pi / 180) * (2 shl (BinaryFactor - 1)));
    sinphi := round(fac * sin(k * Pi / 180) * (2 shl (BinaryFactor - 1)));
    for x_new := 0 to w - 1 do
    begin
      y := ((-x_new + x0) * sinphi - y0 * cosphi) + (y0 shl BinaryFactor) + dx;
      x := ((-x0 + x_new) * cosphi - y0 * sinphi) + (x0 shl BinaryFactor) + dy;
      for y_new := 0 to h - 1 do
      begin
        with rnd(x, y) do
          if (x >= 0) and (x < w) and (y >= 0) and (y < h) then
            QP2.SetPixel(x_new, y_new, QP.getpixel(x, y))
          else
            QP2.SetPixel(x_new, y_new, clSilver);
        inc(y, cosphi);
        inc(x, sinphi);
      end;
    end;
    BitBlt(Canvas.Handle, 0, 0, w, h, NewBmp.canvas.handle, 0, 0, srccopy);
  end;
end;

procedure TForm1.LoadPicClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    LoadPicture;
  Refresh;
end;

procedure TForm1.btResetClick(Sender: TObject);
begin
  if OpenPictureDialog1.FileName<>'' then
    LoadPicture;
  Refresh;
end;

procedure TForm1.LoadPicture;
var
  JP: TJpegImage;
  Bm: TBitmap;
  ScaleX, ScaleY: Double;
  NewX, NewY: Integer;
begin
  JP := TJpegImage.Create;
  Bm := TBitmap.Create;
  try
    if UpperCase(ExtractFileExt(OpenPictureDialog1.FileName))='.BMP' then
      BM.LoadFromFile(OpenPictureDialog1.FileName)
    else begin
      JP.LoadFromFile(OpenPictureDialog1.FileName);
      Bm.Assign(JP);
    end;
    ScaleX := Bm.Width / 400;
    ScaleY := Bm.Height / 400;
    if ScaleX > ScaleY then
      if ScaleX > 1 then
      begin
        NewX := 400;
        NewY := Round(Bm.Height / ScaleX);
        Bmp.Width := NewX;
        Bmp.Height := NewY;
        SetStretchBltMode(Bmp.Canvas.Handle, HALFTONE);
        StretchBlt(Bmp.Canvas.Handle, 0, 0, NewX, NewY,
          Bm.Canvas.Handle, 0, 0, Bm.Width, Bm.Height, SrcCopy);
      end
      else
        Bmp.Assign(Bm)
    else if ScaleY > 1 then
    begin
      NewY := 400;
      NewX := Round(Bm.Width / ScaleY);
      Bmp.Width := NewX;
      Bmp.Height := NewY;
      SetStretchBltMode(Bmp.Canvas.Handle, HALFTONE);
      StretchBlt(Bmp.Canvas.Handle, 0, 0, NewX, NewY,
        Bm.Canvas.Handle, 0, 0, Bm.Width, Bm.Height, SrcCopy);
    end
    else
      Bmp.Assign(Bm)
  finally
    JP.Free;
    Bm.Free;
    Effect:=0;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if Assigned(NewBmp) then
    if SavePictureDialog1.Execute then
      NewBmp.SaveToFile(SavePictureDialog1.FileName);
end;

end.

