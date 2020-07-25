{ ############################################################################ }
{ #                                                                          # }
{ #  MSpeech v1.2 - Распознавание речи используя Google Speech API           # }
{ #                                                                          # }
{ #  License: GPLv3                                                          # }
{ #                                                                          # }
{ #  Author: Mikhail Grigorev (icq: 161867489, email: sleuthhound@gmail.com) # }
{ #                                                                          # }
{ ############################################################################ }

unit Global;

interface

uses
  Windows, SysUtils, IniFiles, Messages, XMLIntf, XMLDoc, Classes;

type
  TWinVersion = (wvUnknown,wv95,wv98,wvME,wvNT3,wvNT4,wvW2K,wvXP,wv2003,wvVista,wv7,wv2008,wv8);

const
  ProgramVersion = '1.3.0';
  ProgramsName = 'MSpeech';
  ININame = 'MSpeech.ini';
  // Для мультиязыковой поддержки
  WM_LANGUAGECHANGED = WM_USER + 1;
  WM_MSGBOX = WM_USER + 2;
  dirLangs = 'langs\';
  defaultLangFile = 'English.xml';

var
  OutFileName: String = 'out.flac';
  CommandFileName: String = 'MSpeechCommand.ini';
  DefaultAudioDeviceNumber: Integer = 0;
  MaxLevelOnAutoRecord: Integer = 57;
  MaxLevelOnAutoRecordInterrupt: Integer = 4;
  MinLevelOnAutoRecognize: Integer = 71;
  MinLevelOnAutoRecognizeInterrupt: Integer = 15;
  MaxLevelOnAutoControl: Boolean = False;
  SyncFilterEnable: Boolean = False;
  INIFileLoaded: Boolean = False;
  // Прокси
  UseProxy: Boolean = False;
  ProxyAuth: Boolean = False;
  ProxyAddress: String = '';
  ProxyPort: String = '';
  ProxyUser: String = '';
  ProxyUserPasswd: String = '';
  // Гор.клавиши
  GlobalHotKeyEnable: Boolean = False;
  StartRecordHotKey: String = 'Ctrl+Alt+F10';
  // Действие кнопки "Остановить запись"
  StopRecordAction: Integer = 0;
  // Всплывающие сообщения
  ShowTrayEvents: Boolean = False;
  // Передача текста в другие программы
  EnableSendText: Boolean = False;
  ClassNameReciver: String = 'Edit';
  MethodSendingText: Integer = 0;
  // Прозрачность окон
  AlphaBlendEnable: Boolean = False;
  AlphaBlendEnableValue: Integer = 255;
  // Для мультиязыковой поддержки
  CoreLanguage: String;
  MainFormHandle: HWND;
  AboutFormHandle: HWND;
  LangDoc: IXMLDocument;
  DefaultLanguage: String;

procedure LoadINI(INIPath: String);
procedure SaveINI(INIPath: String);
function DetectWinVersion : TWinVersion;
function DetectWinVersionStr : String;
function GetFileSize(FileName: String): Integer;
function MatchStrings(source, pattern: String): Boolean;
function ExtractFileNameEx(FileName: String; ShowExtension: Boolean): String;
// Для мультиязыковой поддержки
procedure MakeTransp(winHWND: HWND);
procedure MsgDie(Caption, Msg: WideString);
procedure MsgInf(Caption, Msg: WideString);
function GetLangStr(StrID: String): WideString;
function GetSystemDefaultUILanguage: UINT; stdcall; external kernel32 name 'GetSystemDefaultUILanguage';
function GetSysLang: AnsiString;

implementation

// Загружаем настройки
procedure LoadINI(INIPath: String);
var
  Path: WideString;
  INI: TIniFile;
begin
  Path := INIPath + ININame;
  INI := TIniFile.Create(Path);
  try
    if FileExists(Path) then
    begin
      DefaultLanguage := INI.ReadString('Main', 'DefaultLanguage', 'Russian');
      AlphaBlendEnable := INI.ReadBool('Main', 'AlphaBlendEnable', False);
      AlphaBlendEnableValue := INI.ReadInteger('Main', 'AlphaBlendEnableValue', 255);
      DefaultAudioDeviceNumber := INI.ReadInteger('Main', 'DefaultAudioDeviceNumber', 0);
      MaxLevelOnAutoControl := INI.ReadBool('Main', 'MaxLevelOnAutoControl', False);
      MaxLevelOnAutoRecord := INI.ReadInteger('Main', 'MaxLevelOnAutoRecord', 50);
      MaxLevelOnAutoRecordInterrupt := INI.ReadInteger('Main', 'MaxLevelOnAutoRecordInterrupt', 10);
      MinLevelOnAutoRecognize := INI.ReadInteger('Main', 'MinLevelOnAutoRecognize', 70);
      MinLevelOnAutoRecognizeInterrupt := INI.ReadInteger('Main', 'MinLevelOnAutoRecognizeInterrupt', 30);
      SyncFilterEnable := INI.ReadBool('Main', 'SyncFilterEnable', False);
      StopRecordAction := INI.ReadInteger('Main', 'StopRecordAction', 0);
      ShowTrayEvents := INI.ReadBool('Main', 'ShowTrayEvents', False);
      EnableSendText := INI.ReadBool('SendText', 'EnableSendText', False);
      ClassNameReciver := INI.ReadString('SendText', 'ClassNameReciver', 'Edit');
      MethodSendingText := INI.ReadInteger('SendText', 'MethodSendingText', 0);
      UseProxy := INI.ReadBool('Proxy', 'UseProxy', False);
      ProxyAddress := INI.ReadString('Proxy', 'ProxyServer', '');
      ProxyPort := INI.ReadString('Proxy', 'ProxyPort', '');
      ProxyAuth := INI.ReadBool('Proxy', 'ProxyAuth', False);
      ProxyUser := INI.ReadString('Proxy', 'ProxyUser', '');
      ProxyUserPasswd := INI.ReadString('Proxy', 'ProxyPassword', '');
      GlobalHotKeyEnable := INI.ReadBool('HotKey', 'HotKeyEnable', False);
      StartRecordHotKey := INI.ReadString('HotKey', 'StartRecordHotKey', 'Ctrl+Alt+F12');
      INIFileLoaded := True;
    end
    else
    begin
      INI.WriteBool('Main', 'AlphaBlendEnable', AlphaBlendEnable);
      INI.WriteInteger('Main', 'AlphaBlendEnableValue', AlphaBlendEnableValue);
      INI.WriteInteger('Main', 'DefaultAudioDeviceNumber', DefaultAudioDeviceNumber);
      INI.WriteBool('Main', 'MaxLevelOnAutoControl', MaxLevelOnAutoControl);
      INI.WriteInteger('Main', 'MaxLevelOnAutoRecord', MaxLevelOnAutoRecord);
      INI.WriteInteger('Main', 'MaxLevelOnAutoRecordInterrupt', MaxLevelOnAutoRecordInterrupt);
      INI.WriteInteger('Main', 'MinLevelOnAutoRecognize', MinLevelOnAutoRecognize);
      INI.WriteInteger('Main', 'MinLevelOnAutoRecognizeInterrupt', MinLevelOnAutoRecognizeInterrupt);
      INI.WriteBool('Main', 'SyncFilterEnable', SyncFilterEnable);
      INI.WriteInteger('Main', 'StopRecordAction', 0);
      INI.ReadBool('Main', 'ShowTrayEvents', False);
      INI.WriteBool('SendText', 'EnableSendText', EnableSendText);
      INI.WriteString('SendText', 'ClassNameReciver', ClassNameReciver);
      INI.WriteInteger('SendText', 'MethodSendingText', MethodSendingText);
      INI.WriteBool('Proxy', 'UseProxy', False);
      INI.WriteString('Proxy', 'ProxyServer', '');
      INI.WriteString('Proxy', 'ProxyPort', '');
      INI.WriteBool('Proxy', 'ProxyAuth', False);
      INI.WriteString('Proxy', 'ProxyUser', '');
      INI.WriteString('Proxy', 'ProxyPassword', '');
      INI.WriteBool('HotKey', 'HotKeyEnable', False);
      INI.WriteString('HotKey', 'StartRecordHotKey', 'Ctrl+Alt+F10');
      INIFileLoaded := False;
    end;
  finally
    INI.Free;
  end;
end;

procedure SaveINI;
var
  Path: WideString;
  INI: TIniFile;
begin
  Path := INIPath + ININame;
  INI := TIniFile.Create(Path);
  try
    INI.WriteString('Main', 'DefaultLanguage', DefaultLanguage);
    INI.WriteBool('Main', 'AlphaBlendEnable', AlphaBlendEnable);
    INI.WriteInteger('Main', 'AlphaBlendEnableValue', AlphaBlendEnableValue);
    INI.WriteInteger('Main', 'DefaultAudioDeviceNumber', DefaultAudioDeviceNumber);
    INI.WriteBool('Main', 'MaxLevelOnAutoControl', MaxLevelOnAutoControl);
    INI.WriteInteger('Main', 'MaxLevelOnAutoRecord', MaxLevelOnAutoRecord);
    INI.WriteInteger('Main', 'MaxLevelOnAutoRecordInterrupt', MaxLevelOnAutoRecordInterrupt);
    INI.WriteInteger('Main', 'MinLevelOnAutoRecognize', MinLevelOnAutoRecognize);
    INI.WriteInteger('Main', 'MinLevelOnAutoRecognizeInterrupt', MinLevelOnAutoRecognizeInterrupt);
    INI.WriteInteger('Main', 'StopRecordAction', StopRecordAction);
    INI.WriteBool('Main', 'ShowTrayEvents', ShowTrayEvents);
    INI.WriteBool('SendText', 'EnableSendText', EnableSendText);
    INI.WriteString('SendText', 'ClassNameReciver', ClassNameReciver);
    INI.WriteInteger('SendText', 'MethodSendingText', MethodSendingText);
    INI.WriteBool('Proxy', 'UseProxy', UseProxy);
    INI.WriteString('Proxy', 'ProxyServer', ProxyAddress);
    INI.WriteString('Proxy', 'ProxyPort', ProxyPort);
    INI.WriteBool('Proxy', 'ProxyAuth', ProxyAuth);
    INI.WriteString('Proxy', 'ProxyUser', ProxyUser);
    INI.WriteString('Proxy', 'ProxyUserPasswd', ProxyUserPasswd);
    INI.WriteBool('HotKey', 'HotKeyEnable', GlobalHotKeyEnable);
    INI.WriteString('HotKey', 'StartRecordHotKey', StartRecordHotKey);
    MsgInf(ProgramsName, 'Настройки сохранены.');
  finally
    INI.Free;
  end;
end;

{
DwMajorVersion:DWORD - старшая цифра версии Windows

  Windows 95      - 4
   Windows 98      - 4
   Windows Me      - 4
   Windows NT 3.51 - 3
   Windows NT 4.0  - 4
   Windows 2000    - 5
   Windows XP      - 5

DwMinorVersion: DWORD - младшая цифра версии

  Windows 95      - 0
   Windows 98      - 10
   Windows Me      - 90
   Windows NT 3.51 - 51
   Windows NT 4.0  - 0
   Windows 2000    - 0
   Windows XP      - 1 


DwBuildNumber: DWORD
 Win NT 4 - номер билда
 Win 9x   - старший байт - старшая и младшая цифры версии / младший - номер
билда

dwPlatformId: DWORD

 VER_PLATFORM_WIN32s            Win32s on Windows 3.1.
  VER_PLATFORM_WIN32_WINDOWS     Win32 on Windows 9x
  VER_PLATFORM_WIN32_NT          Win32 on Windows NT, 2000 


SzCSDVersion:DWORD
  NT - содержит PСhar с инфо о установленном ServicePack
  9x - доп. инфо, может и не быть
}
function DetectWinVersion: TWinVersion;
var
  OSVersionInfo : TOSVersionInfo;
begin
  Result := wvUnknown;                      // Неизвестная версия ОС
  OSVersionInfo.dwOSVersionInfoSize := sizeof(TOSVersionInfo);
  if GetVersionEx(OSVersionInfo)
    then
      begin
        case OSVersionInfo.DwMajorVersion of
          3:  Result := wvNT3;              // Windows NT 3
          4:  case OSVersionInfo.DwMinorVersion of
                0: if OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT
                   then Result := wvNT4     // Windows NT 4
                   else Result := wv95;     // Windows 95
                10: Result := wv98;         // Windows 98
                90: Result := wvME;         // Windows ME
              end;
          5:  case OSVersionInfo.DwMinorVersion of
                0: Result := wvW2K;         // Windows 2000
                1: Result := wvXP;          // Windows XP
                2: Result := wv2003;        // Windows 2003
                3: Result := wvVista;       // Windows Vista
              end;
          6:  case OSVersionInfo.DwMinorVersion of
                0: Result := wv2008;        // Windows 2008
                1: Result := wv7;           // Windows 7
              end;
          7:  case OSVersionInfo.DwMinorVersion of
                1: Result := wv8;           // Windows 8
              end;
        end;
      end;
end;

function DetectWinVersionStr: String;
const
  VersStr : Array[TWinVersion] of String = (
    'Unknown OS',
    'Windows 95',
    'Windows 98',
    'Windows ME',
    'Windows NT 3',
    'Windows NT 4',
    'Windows 2000',
    'Windows XP',
    'Windows Server 2003',
    'Windows Vista',
    'Windows 7',
    'Windows Server 2008',
    'Windows 8');
begin
  Result := VersStr[DetectWinVersion];
end;

function GetFileSize(FileName: String): Integer;
var
  FS: TFileStream;
begin
  Result := 0;
  try
    FS := TFileStream.Create(Filename, fmOpenRead);
  except
    Result := -1;
    FS.Free;
    Exit;
  end;
  if Result <> -1 then
    Result := FS.Size;
  FS.Free;
end;

{ Прозрачность окна MessageBox }
procedure MakeTransp(winHWND: HWND);
var
  exStyle: Longint;
begin
  exStyle := GetWindowLong(winHWND, GWL_EXSTYLE);
  if (exStyle and WS_EX_LAYERED = 0) then
  begin
    exStyle := exStyle or WS_EX_LAYERED;
    SetwindowLong(winHWND, GWL_EXSTYLE, exStyle);
  end;
  SetLayeredWindowAttributes(winHWND, 0, AlphaBlendEnableValue, LWA_ALPHA);
end;

// Для мультиязыковой поддержки
procedure MsgDie(Caption, Msg: WideString);
begin
  if AlphaBlendEnable then
    PostMessage(GetForegroundWindow, WM_MSGBOX, 0, 0);
  MessageBoxW(GetForegroundWindow, PWideChar(Msg), PWideChar(Caption), MB_ICONERROR);
end;

// Для мультиязыковой поддержки
procedure MsgInf(Caption, Msg: WideString);
begin
  if AlphaBlendEnable then
    PostMessage(GetForegroundWindow, WM_MSGBOX, 0, 0);
  MessageBoxW(GetForegroundWindow, PWideChar(Msg), PWideChar(Caption), MB_ICONINFORMATION);
end;

// Для мультиязыковой поддержки
function GetLangStr(StrID: String): WideString;
begin
  if (not Assigned(LangDoc)) or (not LangDoc.Active) then
  begin
    Result := '';
    Exit;
  end;
  if LangDoc.ChildNodes['strings'].ChildNodes.FindNode(StrID) <> nil then
    Result := LangDoc.ChildNodes['strings'].ChildNodes[StrID].Text
  else
    Result := 'String not found';
end;

function GetSysLang: AnsiString;
var
  WinLanguage: Array [0..50] of Char;
begin
  VerLanguageName(GetSystemDefaultLangID, WinLanguage, 50);
  Result := StrPas(WinLanguage);
end;

{Функция осуществляет сравнение двух строк. Первая строка
может быть любой, но она не должна содержать символов соответствия (* и ?).
Строка поиска (искомый образ) может содержать абсолютно любые символы.
Для примера: MatchStrings('David Stidolph','*St*') возвратит True.
Автор оригинального C-кода Sean Stanley
Автор портации на Delphi David Stidolph}
function MatchStrings(source, pattern: String): Boolean;
var
  pSource: array[0..255] of Char;
  pPattern: array[0..255] of Char;

  function MatchPattern(element, pattern: PChar): Boolean;

  function IsPatternWild(pattern: PChar): Boolean;
  begin
    Result := StrScan(pattern, '*') <> nil;
    if not Result then
      Result := StrScan(pattern, '?') <> nil;
  end;

  begin
    if 0 = StrComp(pattern, '*') then
      Result := True
    else if (element^ = Chr(0)) and (pattern^ <> Chr(0)) then
      Result := False
    else if element^ = Chr(0) then
      Result := True
    else
    begin
      case pattern^ of
        '*': if MatchPattern(element, @pattern[1]) then
            Result := True
          else
            Result := MatchPattern(@element[1], pattern);
        '?': Result := MatchPattern(@element[1], @pattern[1]);
      else
        if element^ = pattern^ then
          Result := MatchPattern(@element[1], @pattern[1])
        else
          Result := False;
      end;
    end;
  end;
begin
  StrPCopy(pSource, source);
  StrPCopy(pPattern, pattern);
  Result := MatchPattern(pSource, pPattern);
end;

{ Функция для получения имени файла из пути без или с его расширением.
  Возвращает имя файла, без или с его расширением.
  Входные параметры:
  FileName - имя файла, которое надо обработать
  ShowExtension - если TRUE, то функция возвратит короткое имя файла
  (без полного пути доступа к нему), с расширением этого файла, иначе, возвратит
  короткое имя файла, без расширения этого файла. }
function ExtractFileNameEx(FileName: String; ShowExtension: Boolean): String;
var
  I: Integer;
  S, S1: string;
begin
  I := Length(FileName);
  if I <> 0 then
  begin
    while (FileName[i] <> '\') and (i > 0) do
      i := i - 1;
    S := Copy(FileName, i + 1, Length(FileName) - i);
    i := Length(S);
    if i = 0 then
    begin
      Result := '';
      Exit;
    end;
    while (S[i] <> '.') and (i > 0) do
      i := i - 1;
    S1 := Copy(S, 1, i - 1);
    if s1 = '' then
      s1 := s;
    if ShowExtension = True then
      Result := s
    else
      Result := s1;
  end
  else
    Result := '';
end;

begin
end.
