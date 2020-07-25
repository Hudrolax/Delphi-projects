unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GetUser, StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  type
   USER_INFO_1 = record
     usri1_name: LPWSTR;
     usri1_password: LPWSTR;
     usri1_password_age: DWORD;
     usri1_priv: DWORD;
     usri1_home_dir: LPWSTR;
     usri1_comment: LPWSTR;
     usri1_flags: DWORD;
     usri1_script_path: LPWSTR;
   end;
   lpUSER_INFO_1 = ^USER_INFO_1;

   const UF_ACCOUNTDISABLE = $0002;

 function NetUserEnum(ServerName: PWideChar;
   Level,
   Filter: DWORD;
   var Buffer: Pointer;
   PrefMaxLen: DWORD;
   var EntriesRead,
   TotalEntries,
   ResumeHandle: DWORD): Longword; stdcall; external 'netapi32.dll';

 function NetApiBufferFree(pBuffer: PByte): Longint; stdcall; external
 'netapi32.dll';

 {...}


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
 var
   EntiesRead: DWORD;
   TotalEntries: DWORD;
   UserInfo: lpUSER_INFO_1;
   lpBuffer: Pointer;
   ResumeHandle: DWORD;
   Counter: Integer;
   NetApiStatus: LongWord;
   f:TextFile;
 i:integer;
 s:string;
 begin
   ResumeHandle := 0;
   repeat
     // NetApiStatus :=
    // NetUserEnum(PChar('\\NT-Domain'), 1, 0, lpBuffer, 0,EntiesRead, TotalEntries, ResumeHandle);
    NetApiStatus := NetUserEnum('dc1', 1, 0, lpBuffer, 0, EntiesRead,
       TotalEntries, ResumeHandle);
     UserInfo     := lpBuffer;

     for Counter := 0 to EntiesRead - 1 do
     begin
       s:='';
       if (UserInfo^.usri1_flags and UF_ACCOUNTDISABLE)=0	then s:='Block';

       listbox1.Items.Add(WideCharToString(UserInfo^.usri1_name) + ' --> ' +s);
       Inc(UserInfo);
     end;

     NetApiBufferFree(lpBuffer);
   until (NetApiStatus <> ERROR_MORE_DATA);

   AssignFile(f,'1.txt');
   Rewrite(f);
   for i:=0 to listbox1.count-1 do
    Writeln(f,listbox1.items.strings[i]);
   CloseFile(f);
 end;

 

end.
