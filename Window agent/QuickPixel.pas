unit QuickPixel;

interface
uses
  Windows, Graphics;

type
  TQuickPixel = class
  private
    FBitmap: TBitmap;
    FScanLines: array of PRGBTriple;
    function GetPixel(X, Y: Integer): TColor;
    procedure SetPixel(X, Y: Integer; const Value: TColor);
    function GetHeight: Integer;
    function GetWidth: Integer;
  public
    constructor Create(const ABitmap: TBitmap);
    property Pixel[X, Y: Integer]: TColor read GetPixel write SetPixel;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
  end;

implementation

{ TQuickPixel }

constructor TQuickPixel.Create(const ABitmap: TBitmap);
var
  I: Integer;
begin
  inherited Create;
  FBitmap:= ABitmap;
  FBitmap.PixelFormat:= pf24bit;
  SetLength(FScanLines, FBitmap.Height);
  for I:= 0 to FBitmap.Height-1 do
    FScanLines[I]:= FBitmap.ScanLine[I];
end;

function TQuickPixel.GetHeight: Integer;
begin
  Result:= FBitmap.Height;
end;

function TQuickPixel.GetPixel(X, Y: Integer): TColor;
var
  P: PRGBTriple;
begin
 try
  P:= FScanLines[Y];
  Inc(P, X);
  Result:= (P^.rgbtBlue shl 16) or (P^.rgbtGreen shl 8) or P^.rgbtRed;
  except
    end;
end;

function TQuickPixel.GetWidth: Integer;
begin
  Result:= FBitmap.Width;
end;

procedure TQuickPixel.SetPixel(X, Y: Integer; const Value: TColor);
var
  P: PRGBTriple;
begin
  P:= FScanLines[Y];
  Inc(P, X);
  P^.rgbtBlue:= (Value and $FF0000) shr 16;
  P^.rgbtGreen:= (Value and $00FF00) shr 8;
  P^.rgbtRed:= Value and $0000FF;
end;

end.
