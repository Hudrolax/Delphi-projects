unit helpUnit;
interface
uses WinApi;
implementation

function DelDir(dir: string): Boolean; 
var
  fos: TSHFileOpStruct; 
begin 
  ZeroMemory(@fos, SizeOf(fos)); 
  with fos do 
  begin 
    wFunc  := FO_DELETE; 
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION; 
    pFrom  := PChar(dir + #0); 
  end; 
  Result := (0 = ShFileOperation(fos)); 
end;

end.
 