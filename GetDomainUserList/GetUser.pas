unit GetUser;

interface

uses Sysutils, Classes, Stdctrls, Comctrls, Graphics, Windows, Messages, Dialogs;

////////////////////////////////////////////////////////////////////////////////
{$EXTERNALSYM NetUserEnum}
function NetUserEnum(servername: LPWSTR;

  level,
  filter: DWORD;
  bufptr: Pointer;
  prefmaxlen: DWORD;
  entriesread,
  totalentries,
  resume_handle: LPDWORD): DWORD; stdcall;
external 'NetApi32.dll' Name 'NetUserEnum';

function NetApiBufferFree(Buffer: Pointer {LPVOID}): DWORD; stdcall;

external 'NetApi32.dll' Name 'NetApiBufferFree';
////////////////////////////////////////////////////////////////////////////////

procedure GetLocalUserList(ulist: TStringList);
procedure GetUUserList(ulist: TStringList;ulist2: TStringList;serv:PWideChar);

implementation

//------------------------------------------------------------------------------
// возвращает список пользователей локального хоста
//------------------------------------------------------------------------------

procedure GetLocalUserList(ulist: TStringList);
const

  NERR_SUCCESS = 0;
  FILTER_TEMP_DUPLICATE_ACCOUNT = $0001;
  FILTER_NORMAL_ACCOUNT = $0002;
  FILTER_PROXY_ACCOUNT = $0004;
  FILTER_INTERDOMAIN_TRUST_ACCOUNT = $0008;
  FILTER_WORKSTATION_TRUST_ACCOUNT = $0010;
  FILTER_SERVER_TRUST_ACCOUNT = $0020;

type

  TUSER_INFO_10 = record
    usri10_name,
      usri10_comment,
      usri10_usr_comment,
      usri10_full_name: PWideChar;
  end;
  PUSER_INFO_10 = ^TUSER_INFO_10;

var

  dwERead, dwETotal, dwRes, res: DWORD;
  inf: PUSER_INFO_10;
  info: Pointer;
  p: PChar;
  i: Integer;
begin

  if ulist = nil then
    Exit;
  ulist.Clear;

  info := nil;
  dwRes := 0;
  res := NetUserEnum(nil,
    10,
    FILTER_NORMAL_ACCOUNT,
    @info,
    65536,
    @dwERead,
    @dwETotal,
    @dwRes);
  if (res <> NERR_SUCCESS) or (info = nil) then
    Begin
      Showmessage('Ошибка!!!');
    Exit;
    End;
  p := PChar(info);
  for i := 0 to dwERead - 1 do
  begin
    inf := PUSER_INFO_10(p + i * SizeOf(TUSER_INFO_10));
    ulist.Add(WideCharToString(PWideChar((inf^).usri10_name)));
  end;

  NetApiBufferFree(info);
end;

procedure GetUUserList(ulist: TStringList;ulist2: TStringList;serv:PWideChar);
const

  NERR_SUCCESS = 0;
  FILTER_TEMP_DUPLICATE_ACCOUNT = $0001;
  FILTER_NORMAL_ACCOUNT = $0002;
  FILTER_PROXY_ACCOUNT = $0004;
  FILTER_INTERDOMAIN_TRUST_ACCOUNT = $0008;
  FILTER_WORKSTATION_TRUST_ACCOUNT = $0010;
  FILTER_SERVER_TRUST_ACCOUNT = $0020;

type

  TUSER_INFO_20 = record
    usri20_name:LPWSTR;
    usri20_full_name:LPWSTR;    usri20_comment:LPWSTR;    usri20_flags:DWORD;    usri20_user_id:DWORD;    end;
  PUSER_INFO_20 = ^TUSER_INFO_20;

var

  dwERead, dwETotal, dwRes, res: DWORD;
  inf: PUSER_INFO_20;
  info: Pointer;
  p: PChar;
  i: Integer;
begin

  if ulist = nil then
    Exit;
  if ulist2 = nil then
    Exit;

  ulist.Clear;
  ulist2.Clear;

  info := nil;
  dwRes := 0;
  res := NetUserEnum(serv,
    20,
    FILTER_NORMAL_ACCOUNT,
    @info,
    655366,
    @dwERead,
    @dwETotal,
    @dwRes);
  if (res <> NERR_SUCCESS) or (info = nil) then
    Exit;
  p := PChar(info);
  for i := 0 to dwERead - 1 do
  begin
    inf := PUSER_INFO_20(p + i * SizeOf(TUSER_INFO_20));
    ulist.Add(WideCharToString(PWideChar((inf^).usri20_name)));
    ulist2.Add(IntToStr(PWideChar((inf^).usri20_flags)));

  end;

  NetApiBufferFree(info);
end;

end.

