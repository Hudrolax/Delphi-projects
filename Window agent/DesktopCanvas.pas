unit DesktopCanvas;

interface
uses
  Graphics, Windows;

type
  TDesktopCanvas = class(TCanvas)
  private
    DC : HDC;
    function     GetWidth:Integer;
    function     GetHeight:Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
  end;

implementation


{ TDesktopCanvas object }
function TDesktopCanvas.GetWidth:Integer;
begin
  Result:=GetDeviceCaps(Handle,HORZRES);
end;

function TDesktopCanvas.GetHeight:Integer;
begin
  Result:=GetDeviceCaps(Handle,VERTRES);
end;

constructor TDesktopCanvas.Create;
begin
  inherited Create;
  DC := GetDC(0);
  Handle := DC;
end;

destructor TDesktopCanvas.Destroy;
begin
  Handle := 0;
  ReleaseDC(0, DC);
  inherited Destroy;
end;


end.
