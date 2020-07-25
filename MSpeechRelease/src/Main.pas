{ ############################################################################ }
{ #                                                                          # }
{ #  MSpeech v1.2 - Распознавание речи используя Google Speech API           # }
{ #                                                                          # }
{ #  License: GPLv3                                                          # }
{ #                                                                          # }
{ #  Author: Mikhail Grigorev (icq: 161867489, email: sleuthhound@gmail.com) # }
{ #                                                                          # }
{ ############################################################################ }

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ACS_Classes, NewACIndicators, ACS_FLAC, ACS_DXAudio,
  HTTPSend, SSL_OpenSSL, uJSON, ShellApi, Global, About, ACS_Misc, ACS_Filters, ACS_Wave,
  CoolTrayIcon, ImgList, Menus, JvAppStorage, JvAppIniStorage, JvComponentBase,
  JvFormPlacement, JvThread, Grids, JvAppHotKey, Vcl.ExtCtrls, Vcl.Buttons, Clipbrd,
  XMLIntf, XMLDoc, JvExControls, JvSpeedButton;

type
  TMainForm = class(TForm)
    DXAudioIn: TDXAudioIn;
    FLACOut: TFLACOut;
    FastGainIndicator: TFastGainIndicator;
    NULLOut: TNULLOut;
    SincFilter: TSincFilter;
    MSpeechTray: TCoolTrayIcon;
    TrayImageList: TImageList;
    MSpeechPopupMenu: TPopupMenu;
    MSpeechShowHide: TMenuItem;
    MSpeechAbout: TMenuItem;
    MSpeechExit: TMenuItem;
    JvFormStorage: TJvFormStorage;
    JvAppIniFileStorage: TJvAppIniFileStorage;
    JvThreadRecognize: TJvThread;
    GBMain: TGroupBox;
    LSignalLevel: TLabel;
    ProgressBar: TProgressBar;
    StartButton: TButton;
    StopButton: TButton;
    SettingsButton: TButton;
    AboutButton: TButton;
    MSpeechSettings: TMenuItem;
    SettingsPanel: TPanel;
    SettingsPageControl: TPageControl;
    TabSheetSettings: TTabSheet;
    TabSheetConnectSettings: TTabSheet;
    GBConnectSettings: TGroupBox;
    LProxyAddress: TLabel;
    LProxyPort: TLabel;
    LProxyUser: TLabel;
    LProxyUserPasswd: TLabel;
    CBUseProxy: TCheckBox;
    EProxyAddress: TEdit;
    EProxyPort: TEdit;
    EProxyUser: TEdit;
    CBProxyAuth: TCheckBox;
    EProxyUserPasswd: TEdit;
    TabSheetHotKey: TTabSheet;
    CBHotKey: TCheckBox;
    GBHotKey: TGroupBox;
    HotKetStringGrid: TStringGrid;
    IMHotKey: THotKey;
    SetHotKeyButton: TButton;
    DeleteHotKeyButton: TButton;
    TabSheetLog: TTabSheet;
    LogMemo: TMemo;
    ClearLogButton: TButton;
    SaveSettingsButton: TButton;
    TabSheetSendText: TTabSheet;
    GBSendText: TGroupBox;
    LClassName: TLabel;
    EClassNameReciver: TEdit;
    ImageList_Main: TImageList;
    CBEnableSendText: TCheckBox;
    LNote: TLabel;
    LMethodSendingText: TLabel;
    CBMethodSendingText: TComboBox;
    TabSheetRecord: TTabSheet;
    GBRecordSettings: TGroupBox;
    LMaxLevel: TLabel;
    LMaxLevelInterrupt: TLabel;
    LMinLevel: TLabel;
    LEMinLevelInterrupt: TLabel;
    LDevice: TLabel;
    LStopRecordAction: TLabel;
    EMaxLevel: TEdit;
    UpDownMaxLevel: TUpDown;
    CBMaxLevelControl: TCheckBox;
    EMinLevelInterrupt: TEdit;
    UpDownMinLevelInterrupt: TUpDown;
    UpDownMaxLevelInterrupt: TUpDown;
    UpDownMinLevel: TUpDown;
    EMinLevel: TEdit;
    StaticTextMinLevel: TStaticText;
    StaticTextMaxLevelInterrupt: TStaticText;
    StaticTextMinLevelInterrupt: TStaticText;
    EMaxLevelInterrupt: TEdit;
    CBDevice: TComboBox;
    MicSettingsButton: TButton;
    CBStopRecordAction: TComboBox;
    GBInterfaceSettings: TGroupBox;
    CBShowTrayEvents: TCheckBox;
    CBAlphaBlend: TCheckBox;
    AlphaBlendTrackBar: TTrackBar;
    CBLang: TComboBox;
    LLang: TLabel;
    AlphaBlendVar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure CoreLanguageChanged;
    procedure StartButtonClick(Sender: TObject);
    procedure FastGainIndicatorGainData(Sender: TComponent);
    procedure FLACOutDone(Sender: TComponent);
    procedure CBDeviceChange(Sender: TObject);
    procedure AboutButtonClick(Sender: TObject);
    procedure FLACOutThreadException(Sender: TComponent);
    procedure StopButtonClick(Sender: TObject);
    procedure EMinLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpDownMinLevelClick(Sender: TObject; Button: TUDBtnType);
    procedure EMinLevelInterruptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpDownMinLevelInterruptClick(Sender: TObject; Button: TUDBtnType);
    procedure MicSettingsButtonClick(Sender: TObject);
    procedure UpDownMaxLevelClick(Sender: TObject; Button: TUDBtnType);
    procedure EMaxLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EMaxLevelInterruptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpDownMaxLevelInterruptClick(Sender: TObject; Button: TUDBtnType);
    procedure NULLOutDone(Sender: TComponent);
    procedure CBMaxLevelControlClick(Sender: TObject);
    procedure MSpeechTrayStartup(Sender: TObject; var ShowMainForm: Boolean);
    procedure MSpeechTrayDblClick(Sender: TObject);
    procedure MSpeechExitClick(Sender: TObject);
    procedure MSpeechAboutClick(Sender: TObject);
    procedure JvThreadRecognizeExecute(Sender: TObject; Params: Pointer);
    procedure JvThreadRecognizeFinish(Sender: TObject);
    procedure StartRecognize;
    procedure StartRecord;
    procedure StartNULLRecord;
    procedure StopNULLRecord;
    procedure SyncFilterOn;
    procedure SyncFilterOff;
    procedure SettingsButtonClick(Sender: TObject);
    procedure CBUseProxyClick(Sender: TObject);
    procedure CBProxyAuthClick(Sender: TObject);
    procedure SaveSettingsButtonClick(Sender: TObject);
    procedure CBHotKeyClick(Sender: TObject);
    procedure SetHotKeyButtonClick(Sender: TObject);
    procedure DeleteHotKeyButtonClick(Sender: TObject);
    procedure HotKetStringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure MSpeechSettingsClick(Sender: TObject);
    procedure CBStopRecordActionChange(Sender: TObject);
    procedure ClearLogButtonClick(Sender: TObject);
    procedure CBEnableSendTextClick(Sender: TObject);
    procedure CBMethodSendingTextChange(Sender: TObject);
    procedure CBLangChange(Sender: TObject);
    procedure CBAlphaBlendClick(Sender: TObject);
    procedure AlphaBlendTrackBarChange(Sender: TObject);
    procedure NULLOutThreadException(Sender: TComponent);
  private
    { Private declarations }
    SessionEnding: Boolean;
    HotKeySelectedCell: Integer;
    FCount: Integer;
    FLanguage: WideString;
    procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
    procedure OnLanguageChanged(var Msg: TMessage); message WM_LANGUAGECHANGED;
    procedure msgBoxShow(var Msg: TMessage); message WM_MSGBOX;
    procedure DoHotKey(Sender:TObject);
    procedure LoadLanguageStrings;
  public
    { Public declarations }
    MSpeechMainFormHidden: Boolean;
    function HTTPPostFile(Const URL, FieldName, FileName: String; Const Data: TStream; Const ResultData: TStrings): Boolean;
    procedure LoadSettings;
    procedure RegisterHotKeys;
    procedure UnRegisterHotKeys;
    procedure ShowBalloonHint(BalloonTitle, BalloonMsg : WideString); overload;
    procedure ShowBalloonHint(BalloonTitle, BalloonMsg: WideString; BalloonIconType: TBalloonHintIcon); overload;
    function GetTextWnd(MyClassName: String): String;
    procedure SetTextWnd(MyClassName, MyText: String); overload;
    procedure SetTextWnd(MyText: String); overload;
    procedure InsTextWnd(MyClassName, MyText: String); overload;
    procedure InsTextWnd(MyText: String); overload;
    procedure CopyPasteTextWnd(MyClassName, MyText: String); overload;
    procedure CopyPasteTextWnd(MyText: String); overload;
    procedure SetCharTextWnd(MyText: String);
    procedure FindLangFile;
    property CoreLanguage: WideString read FLanguage;
  end;

var
  MainForm: TMainForm;

const
  MaxCaptionSize: Integer = 255;

implementation

{$R *.dfm}

var
  CommandList: TStringGrid;
  SaveFLACDone: Boolean = False;
  StopRecord: Boolean = False;
  FLACDoneCnt: Integer = 0;
  NULLOutStart: Boolean = False;
  NULLOutDoneCnt: Integer = 0;
  StartSaveSettings: Boolean = False;
  JvStartRecordHotKey: TJvApplicationHotKey;

procedure TMainForm.WMQueryEndSession(var Message: TMessage);
begin
  SessionEnding := True;
  Message.Result := 1;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  DevCnt: Integer;
  TF: TextFile;
  Str1, Str2: String;
  I, J: Integer;
begin
  // Для мультиязыковой поддержки
  MainFormHandle := Handle;
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Читаем настройки
  LoadINI(ExtractFilePath(Application.ExeName));
  MSpeechTray.Hint := ProgramsName;
  // Загружаем настройки локализации
  if INIFileLoaded then
    FLanguage := DefaultLanguage
  else
  begin
    if (GetSysLang = 'Русский') or (GetSysLang = 'Russian') or (MatchStrings(GetSysLang, 'Русский*')) then
      FLanguage := 'Russian'
    else
      FLanguage := 'English';
  end;
  LangDoc := NewXMLDocument();
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + dirLangs) then
    CreateDir(ExtractFilePath(Application.ExeName) + dirLangs);
  CoreLanguageChanged;
  // Заполняем список устройст записи
  CBDevice.Clear;
  if DXAudioIn.DeviceCount > 0 then
  begin
    for DevCnt := 0 to DXAudioIn.DeviceCount - 1 do
      CBDevice.Items.Add(DXAudioIn.DeviceName[DevCnt]);
    StartButton.Enabled := True;
  end
  else
  begin
    //CBDevice.Items.Add('Нет ни одного устройства записи');
    //StartButton.Enabled := False;
    MsgDie(ProgramsName, GetLangStr('MsgErr1'));
    Application.Terminate;
    Exit;
  end;
  if DXAudioIn.DeviceCount > DefaultAudioDeviceNumber then
    CBDevice.ItemIndex := DefaultAudioDeviceNumber
  else
    CBDevice.ItemIndex := 0;
  // Отключаем кнопки
  StopButton.Enabled := False;
  if FileExists(ExtractFilePath(Application.ExeName)+CommandFileName) then
  begin
    // Грузим список команд в StringGrid
    // Делаем такой изврат лишь с одной целью - легко реализуемый поиск по колонкам
    I := 0;
    CommandList := TStringGrid.Create(nil);
    AssignFile(TF, ExtractFilePath(Application.ExeName)+CommandFileName);
    Reset(TF);
    while not eof(TF) do
    begin
      Readln(TF, Str1);
      Inc(I);
      J := 0;
      while Pos(';', Str1)<>0 do
      begin
        Str2 := Copy(Str1,1,Pos(';', Str1)-1);
        Inc(J);
        Delete(Str1, 1, Pos(';', Str1));
        CommandList.Cells[J-1, I-1] := Str2;
      end;
      if Pos(';', Str1) = 0 then
      begin
        Inc(J);
        CommandList.Cells[J-1, I-1] := Str1;
      end;
      CommandList.ColCount := J;
      CommandList.RowCount := I+1;
    end;
    CloseFile(TF);
  end
  else
  begin
    MsgDie(ProgramsName, Format(GetLangStr('MsgErr2'), [CommandFileName]));
    Application.Terminate;
    Exit;
  end;
  // Фильтрация звука
  if SyncFilterEnable then
    SyncFilterOn;
  // Создаем горячие клавиши
  JvStartRecordHotKey := TJvApplicationHotKey.Create(self);
  with JvStartRecordHotKey do
  begin
    HotKey := TextToShortCut(StartRecordHotKey);
    Active := False;
    OnHotKey := DoHotKey;
  end;
  // Активируем настройки
  LoadSettings;
  // Активируем горячие клавиши
  RegisterHotKeys;
  StopRecord := True;
  FCount := 0;
  // Авто-активация записи
  if MaxLevelOnAutoControl then
    StartNULLRecord;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if not JvThreadRecognize.Terminated then
    JvThreadRecognize.Terminate;
  while not (JvThreadRecognize.Terminated) do
  begin
    Sleep(1);
    Forms.Application.ProcessMessages;
  end;
  if Assigned(CommandList) then
    CommandList.Free;
  if FileExists(ExtractFilePath(Application.ExeName) + OutFileName) then
    DeleteFile(ExtractFilePath(Application.ExeName) + OutFileName);
  // Разрегистрация гор. клавиш
  UnRegisterHotKeys;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := ((MSpeechMainFormHidden) or SessionEnding);
  if not CanClose then
  begin
    MSpeechTray.HideMainForm;
    MSpeechMainFormHidden := True;
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuShow');
  end;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    MSpeechTray.HideMainForm;
    MSpeechMainFormHidden := True;
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuShow');
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  SettingsPageControl.ActivePage := TabSheetSettings;
  SettingsPanel.Visible := False;
  MainForm.Height := GBMain.Top + GBMain.Height + 40;
  MainForm.Width := 629;
end;

procedure TMainForm.SettingsButtonClick(Sender: TObject);
begin
  if not SettingsPanel.Visible then
  begin
    // Активируем настройки
    LoadSettings;
    // Показываем настройки
    SettingsPanel.Visible := True;
    MainForm.Height := GBMain.Top + GBMain.Height + SettingsPageControl.Height + 75
  end
  else
  begin
    SettingsPanel.Visible := False;
    MainForm.Height := GBMain.Top + GBMain.Height + 40;
  end;
end;

procedure TMainForm.MSpeechAboutClick(Sender: TObject);
begin
  AboutForm.Show;
end;

procedure TMainForm.MSpeechExitClick(Sender: TObject);
begin
  MSpeechMainFormHidden := True;
  Close;
end;

procedure TMainForm.MSpeechSettingsClick(Sender: TObject);
begin
  MSpeechTray.ShowMainForm;
  MSpeechMainFormHidden := False;
  MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuHide');
  SettingsButtonClick(SettingsButton);
end;

{ Клик по пункту Скрыть/Показать контекстного меню в трее }
procedure TMainForm.MSpeechTrayDblClick(Sender: TObject);
begin
  if MSpeechMainFormHidden then
  begin
    MSpeechTray.ShowMainForm;
    MSpeechMainFormHidden := False;
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuHide');
  end
  else
  begin
    Application.Minimize;
    MSpeechTray.HideMainForm;
    MSpeechMainFormHidden := True;
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuShow');
  end;
end;

procedure TMainForm.MSpeechTrayStartup(Sender: TObject; var ShowMainForm: Boolean);
begin
  ShowMainForm := False;
  MSpeechMainFormHidden := True;
end;

procedure TMainForm.FastGainIndicatorGainData(Sender: TComponent);
begin
  try
    ProgressBar.Position := FastGainIndicator.GainValue;
    if not NULLOutStart then
    begin
      if FastGainIndicator.GainValue < MinLevelOnAutoRecognize then
        Inc(FLACDoneCnt);
      StaticTextMinLevel.Caption := IntToStr(FastGainIndicator.GainValue);
      StaticTextMinLevelInterrupt.Caption := IntToStr(FLACDoneCnt);
      if (StopRecordAction >= 0) and (StopRecordAction < 2) then
      begin
        if FLACDoneCnt >= MinLevelOnAutoRecognizeInterrupt then
          StopButton.Click;
      end;
    end
    else
    begin
      if FastGainIndicator.GainValue > MaxLevelOnAutoRecord then
        Inc(NULLOutDoneCnt);
      StaticTextMaxLevelInterrupt.Caption := IntToStr(NULLOutDoneCnt);
      if NULLOutDoneCnt >= MaxLevelOnAutoRecordInterrupt then
        StartButton.Click;
    end;
  except
    on e: Exception do
    begin
      //LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + 'Неизвестное исключение в процедуре FastGainIndicatorGainData - ' + e.Message);
      Exit;
    end;
  end;
end;

procedure TMainForm.FLACOutDone(Sender: TComponent);
begin
  FLACDoneCnt := 0;
  SaveFLACDone := True;
  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Файл ' + OutFileName + ' сохранен.');
  if not StartSaveSettings then
  begin
    if (StopRecordAction = 1) or (StopRecordAction = 3) then
    begin
      if StopRecord then
        StartRecognize;
    end;
  end;
end;

procedure TMainForm.FLACOutThreadException(Sender: TComponent);
begin
  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Ошибка записи в файл ' + OutFileName);
  FLACOut.Stop;
  MSpeechTray.IconIndex := 5;
  StartButton.Enabled := True;
  StopButton.Enabled := False;
  StopRecord := True;
end;

procedure TMainForm.CBDeviceChange(Sender: TObject);
begin
  DXAudioIn.DeviceNumber := CBDevice.ItemIndex;
end;

procedure TMainForm.CBHotKeyClick(Sender: TObject);
begin
  GBHotKey.Visible := CBHotKey.Checked;
end;

procedure TMainForm.CBMaxLevelControlClick(Sender: TObject);
begin
  LMaxLevel.Enabled := CBMaxLevelControl.Checked;
  EMaxLevel.Enabled := CBMaxLevelControl.Checked;
  LMaxLevelInterrupt.Enabled := CBMaxLevelControl.Checked;
  EMaxLevelInterrupt.Enabled := CBMaxLevelControl.Checked;
  UpDownMaxLevel.Enabled := CBMaxLevelControl.Checked;
  UpDownMaxLevelInterrupt.Enabled := CBMaxLevelControl.Checked;
end;

procedure TMainForm.CBUseProxyClick(Sender: TObject);
begin
  LProxyAddress.Enabled := CBUseProxy.Checked;
  LProxyPort.Enabled := CBUseProxy.Checked;
  EProxyAddress.Enabled := CBUseProxy.Checked;
  EProxyPort.Enabled := CBUseProxy.Checked;
  CBProxyAuth.Enabled := CBUseProxy.Checked;
end;

procedure TMainForm.CBProxyAuthClick(Sender: TObject);
begin
  LProxyUser.Enabled := CBProxyAuth.Checked;
  LProxyUserPasswd.Enabled := CBProxyAuth.Checked;
  EProxyUser.Enabled := CBProxyAuth.Checked;
  EProxyUserPasswd.Enabled := CBProxyAuth.Checked;
end;

procedure TMainForm.CBStopRecordActionChange(Sender: TObject);
begin
  if CBStopRecordAction.ItemIndex >= 2 then
  begin
    LMinLevel.Enabled := False;
    LEMinLevelInterrupt.Enabled := False;
    EMinLevel.Enabled := False;
    UpDownMinLevel.Enabled := False;
    EMinLevelInterrupt.Enabled := False;
    UpDownMinLevelInterrupt.Enabled := False;
  end
  else
  begin
    LMinLevel.Enabled := True;
    LEMinLevelInterrupt.Enabled := True;
    EMinLevel.Enabled := True;
    UpDownMinLevel.Enabled := True;
    EMinLevelInterrupt.Enabled := True;
    UpDownMinLevelInterrupt.Enabled := True;
  end;
end;

procedure TMainForm.EMaxLevelInterruptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if EMaxLevelInterrupt.Text = '' then
    EMaxLevelInterrupt.Text := '0';
  if StrToInt(EMaxLevelInterrupt.Text) > 100  then
    EMaxLevelInterrupt.Text := '100';
  if Key = VK_RETURN then
  begin
    UpDownMaxLevelInterrupt.Position := StrToInt(EMaxLevelInterrupt.Text);
    MaxLevelOnAutoRecordInterrupt := StrToInt(EMaxLevelInterrupt.Text);
  end;
end;

procedure TMainForm.EMinLevelInterruptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if EMinLevelInterrupt.Text = '' then
    EMinLevelInterrupt.Text := '0';
  if StrToInt(EMinLevelInterrupt.Text) > 100  then
    EMinLevelInterrupt.Text := '100';
  if Key = VK_RETURN then
  begin
    UpDownMinLevelInterrupt.Position := StrToInt(EMinLevelInterrupt.Text);
    MinLevelOnAutoRecognizeInterrupt := StrToInt(EMinLevelInterrupt.Text);
  end;
end;

procedure TMainForm.EMaxLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if EMaxLevel.Text = '' then
    EMaxLevel.Text := '0';
  if StrToInt(EMaxLevel.Text) > 100  then
    EMaxLevel.Text := '100';
  if Key = VK_RETURN then
  begin
    UpDownMaxLevel.Position := StrToInt(EMaxLevel.Text);
    MaxLevelOnAutoRecord := StrToInt(EMaxLevel.Text);
  end;
end;

procedure TMainForm.EMinLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if EMinLevel.Text = '' then
    EMinLevel.Text := '0';
  if StrToInt(EMinLevel.Text) > 100  then
    EMinLevel.Text := '100';
  if Key = VK_RETURN then
  begin
    UpDownMinLevel.Position := StrToInt(EMinLevel.Text);
    MinLevelOnAutoRecognize := StrToInt(EMinLevel.Text);
  end;
end;

procedure TMainForm.UpDownMaxLevelClick(Sender: TObject; Button: TUDBtnType);
begin
  MaxLevelOnAutoRecord := StrToInt(EMaxLevel.Text);
end;

procedure TMainForm.UpDownMinLevelClick(Sender: TObject; Button: TUDBtnType);
begin
  MinLevelOnAutoRecognize := StrToInt(EMinLevel.Text);
end;

procedure TMainForm.UpDownMaxLevelInterruptClick(Sender: TObject; Button: TUDBtnType);
begin
  MaxLevelOnAutoRecordInterrupt := StrToInt(EMaxLevelInterrupt.Text);
end;

procedure TMainForm.UpDownMinLevelInterruptClick(Sender: TObject; Button: TUDBtnType);
begin
  MinLevelOnAutoRecognizeInterrupt := StrToInt(EMinLevelInterrupt.Text);
end;

procedure TMainForm.MicSettingsButtonClick(Sender: TObject);
begin
  if (DetectWinVersionStr = 'Windows 7') then
    WinExec('SndVol.exe /r', SW_SHOW)
  else if (DetectWinVersionStr = 'Windows 8') then
    WinExec('SndVol.exe /r', SW_SHOW)
  else  if (DetectWinVersionStr = 'Windows XP') or (DetectWinVersionStr = 'Windows 2000') then
    WinExec('SndVol32.exe /r', SW_SHOW)
  //else if (DetectWinVersionStr = 'Windows Vista') or (DetectWinVersionStr = 'Windows 2008') then
  //  MsgInf(ProgramName, 'Для настройки параметров микрофона зайдите в Панель управления.' + #13 + 'Ваша версия OS: ' + DetectWinVersionStr)
  else
    MsgInf(ProgramsName, Format(GetLangStr('MsgInf1'), [#13, DetectWinVersionStr]));
end;

procedure TMainForm.AboutButtonClick(Sender: TObject);
begin
  AboutForm.Show;
end;

procedure TMainForm.SyncFilterOff;
begin
  FastGainIndicator.Input := DXAudioIn;
end;

procedure TMainForm.SyncFilterOn;
begin
  FastGainIndicator.Input := SincFilter;
end;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin
  SaveFLACDone := False;
  StopRecord := False;
  FLACDoneCnt := 0;
  StopNULLRecord;
  if not MaxLevelOnAutoControl then
    StartRecord;
end;

procedure TMainForm.StopButtonClick(Sender: TObject);
begin
  MSpeechTray.IconIndex := 0;
  StartButton.Enabled := True;
  StopButton.Enabled := False;
  StopRecord := True;
  FLACOut.Stop;
  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Получен запрос на остановку записи.');
end;

procedure TMainForm.StartNULLRecord;
begin
  if NULLOutStart then
    StopNULLRecord;
  if MaxLevelOnAutoControl then
  begin
    try
      NULLOut.Input := FastGainIndicator;
      NULLOut.Run;
    except
    end;
    NULLOutStart := True;
  end
end;

procedure TMainForm.StopNULLRecord;
begin
  if NULLOutStart then
  begin
    NULLOut.Stop(True);
    NULLOutStart := False;
  end;
end;

procedure TMainForm.NULLOutDone(Sender: TComponent);
begin
  NULLOutDoneCnt := 0;
  if MaxLevelOnAutoControl then
    StartRecord;
end;

procedure TMainForm.NULLOutThreadException(Sender: TComponent);
begin
  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Ошибка записи в пустоту');
  StopNULLRecord;
  MSpeechTray.IconIndex := 5;
end;

procedure TMainForm.StartRecord;
begin
  if FileExists('libFLAC.dll') then
  begin
    MSpeechTray.IconIndex := 1;
    StartButton.Enabled := False;
    StopButton.Enabled := True;
    if FileExists(ExtractFilePath(Application.ExeName) + OutFileName) then
      DeleteFile(ExtractFilePath(Application.ExeName) + OutFileName);
    //FLACOut.Input := FastGainIndicator;
    FLACOut.FileName := OutFileName;
    FLACOut.Run;
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Начата запись в файл ' + OutFileName);
  end
  else
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Не найдена библиотека libFLAC.dll');
end;

{ Запуск потока отправки данных и выполнения команды }
procedure TMainForm.StartRecognize;
begin
  if not JvThreadRecognize.Terminated then
      JvThreadRecognize.Terminate;
  if FileExists(ExtractFilePath(Application.ExeName) + OutFileName) then
    JvThreadRecognize.Execute(Self)
  else
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Ошибка чтения файла ' + OutFileName);
    StartButton.Enabled := True;
    StopButton.Enabled := False;
  end;
end;

{ Поток отправки данных и выполнения команды }
procedure TMainForm.JvThreadRecognizeExecute(Sender: TObject; Params: Pointer);
var
  Stream: TFileStream;
  Str: String;
  JSON, Jo: TJSONobject;
  ReplStr: String;
  RecognizeConfidence: Real;
  StrList: TStringList;
  RecognizeStr: String;
  K: Integer;
begin
  if GetFileSize(ExtractFilename(OutFileName)) > 0 then
  begin
    MSpeechTray.IconIndex := 4;
    StrList := TStringList.Create;
    StrList.Clear;
    StartButton.Enabled := False;
    StopButton.Enabled := False;
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Ждите, идет отправка запроса в Google...');
    try
      Stream := TFileStream.Create(ExtractFilename(OutFileName), fmOpenRead or fmShareDenyWrite);
    except
      on e: Exception do
      begin
        MSpeechTray.IconIndex := 5;
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + 'Поток JvThreadRecognize не может получить доступ к файлу ' + ExtractFilename(OutFileName) + ' Ошибка: ' + e.Message);
      end;
    end;
    try
      HTTPPostFile('https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=ru-RU', 'userfile', ExtractFilename(OutFileName), Stream, StrList);
    finally
      Stream.Free;
    end;
    if JvThreadRecognize.Terminated then
    begin
      StrList.Free;
      Exit;
    end;
    Str := UTF8ToString(StrList.Text);
    StrList.Free;
    if Length(Str) > 0  then
    begin
      MSpeechTray.IconIndex := 4;
      LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': JSON ответ сервера Google = ' + Trim(Str));
      try
        JSON := TJSONObject.Create(Str);
      except
        on e: Exception do
        begin
          MSpeechTray.IconIndex := 5;
          LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + 'Неизвестное исключение в потоке JvThreadRecognize - ' + e.Message);
          ShowBalloonHint(ProgramsName, GetLangStr('MsgErr3'),  bitError);
          JSON.Free;
          StopNULLRecord;
          if MaxLevelOnAutoControl then
            StartNULLRecord;
          Exit;
        end;
      end;
      try
        MSpeechTray.IconIndex := 4;
        // Запись не распознана
        if JSON.optString('status') = '5' then
        begin
          MSpeechTray.IconIndex := 2;
          LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + GetLangStr('MsgInf2'));
          ShowBalloonHint(ProgramsName, GetLangStr('MsgInf2'), bitWarning);
          StopNULLRecord;
          if MaxLevelOnAutoControl then
            StartNULLRecord;
        end
        // Запись успешно распознана
        else if JSON.optString('status') = '0' then
        begin
          MSpeechTray.IconIndex := 4;
          ReplStr := StringReplace(JSON.getString('hypotheses'),'[','',[RFReplaceall]);
          ReplStr := StringReplace(ReplStr,']','',[RFReplaceall]);
          Jo := TJSONObject.Create(ReplStr);
          try
            RecognizeStr := Jo.getString('utterance');
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Распознанная строка = ' + RecognizeStr);
            //LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Фраза: '+ Jo.getString('utterance'));
            FormatSettings.DecimalSeparator := '.';
            RecognizeConfidence := (StrToFloat(Jo.getString('confidence')))*100;
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Достоверность распознавания = ' + FloatToStr(RecognizeConfidence) + '%');
            // Передача текста
            if EnableSendText then
            begin
              if ClassNameReciver <> '' then
              begin
                if MethodSendingText = 0 then
                  InsTextWnd(ClassNameReciver, RecognizeStr)
                else if MethodSendingText = 1 then
                  CopyPasteTextWnd(ClassNameReciver, RecognizeStr)
                else
                  SetCharTextWnd(RecognizeStr);
              end
              else
              begin
                if MethodSendingText = 0 then
                  InsTextWnd(RecognizeStr)
                else if MethodSendingText = 1 then
                  CopyPasteTextWnd(RecognizeStr)
                else
                  SetCharTextWnd(RecognizeStr);
              end;
            end;
            // End
            K := CommandList.Cols[0].IndexOf(RecognizeStr);
            if K <> -1 then
            begin
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + 'Выполняем команду: ' + CommandList.Cells[1,K]);
              Beep;
              if JvThreadRecognize.Terminated then
              begin
                if (Assigned(JSON)) then JSON.Free;
                if (Assigned(Jo)) then Jo.Free;
                Exit;
              end;
              //ShowBalloonHint(ProgramsName, 'Команда распознана. Выполняем...');
              ShellExecute(0, 'open', PWideChar(CommandList.Cells[1,K]), nil, nil, SW_SHOWMINIMIZED);
              StopNULLRecord;
              if MaxLevelOnAutoControl then
                StartNULLRecord;
            end
            else
            begin
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + GetLangStr('MsgInf3'));
              ShowBalloonHint(ProgramsName, GetLangStr('MsgInf3'));
              StopNULLRecord;
              if MaxLevelOnAutoControl then
                StartNULLRecord;
            end;
          finally
            Jo.Free;
          end;
        end;
      finally
        JSON.Free;
      end;
    end
    else
    begin
      LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': ' + GetLangStr('MsgInf4'));
      ShowBalloonHint(ProgramsName, GetLangStr('MsgInf4'), bitError);
    end;
  end
  else
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': Ошибка чтения файла ' + OutFileName);
end;

procedure TMainForm.JvThreadRecognizeFinish(Sender: TObject);
begin
  StartButton.Enabled := True;
  StopButton.Enabled := False;
  MSpeechTray.IconIndex := 0;
end;

{ Отправка flac-файлы }
function TMainForm.HTTPPostFile(Const URL, FieldName, FileName: String; Const Data: TStream; Const ResultData: TStrings): Boolean;
const
  CRLF = #$0D + #$0A;
var
  HTTP: THTTPSend;
  Bound, Str: String;
begin
  Bound := IntToHex(Random(MaxInt), 8) + '_Synapse_boundary';
  HTTP := THTTPSend.Create;
  try
    if UseProxy then
    begin
      HTTP.ProxyHost := ProxyAddress;
      if ProxyPort <> '' then
        HTTP.ProxyPort := ProxyPort
      else
        HTTP.ProxyPort := '3128';
      if ProxyAuth then
      begin
        HTTP.ProxyUser := ProxyUser;
        HTTP.ProxyPass := ProxyUserPasswd;
      end;
      LogMemo.Lines.Add(Format('%s: Пробуем отправить данные через Proxy-сервер (Адрес: %s, Порт: %s, Логин: %s, Пароль: %s)',
                 [FormatDateTime('dd.mm.yy hh:mm:ss', Now), HTTP.ProxyHost, HTTP.ProxyPort, HTTP.ProxyUser, HTTP.ProxyPass]));
    end;
    Str := '--' + Bound + CRLF;
    Str := Str + 'content-disposition: form-data; name="' + FieldName + '";';
    Str := Str + ' filename="' + FileName + '"' + CRLF;
    Str := Str + 'Content-Type: audio/x-flac; rate=8000' + CRLF + CRLF;
    HTTP.Document.Write(Pointer(Str)^, Length(Str));
    HTTP.Document.CopyFrom(Data, 0);
    Str := CRLF + '--' + Bound + '--' + CRLF;
    HTTP.Document.Write(Pointer(Str)^, Length(Str));
    HTTP.MimeType := 'audio/x-flac; rate=8000, boundary=' + Bound;
    Result := HTTP.HTTPMethod('POST', URL);
    ResultData.LoadFromStream(HTTP.Document);
  finally
    HTTP.Free;
  end;
end;

procedure TMainForm.SaveSettingsButtonClick(Sender: TObject);
begin
  StartSaveSettings := True;
  // Останавливаем потоки распознавания и запись
  StopButton.Click;
  if not JvThreadRecognize.Terminated then
    JvThreadRecognize.Terminate;
  while not (JvThreadRecognize.Terminated) do
    Sleep(1);
  StopNULLRecord;
  // Устанавливаем новые настройки
  // Прокси
  UseProxy := CBUseProxy.Checked;
  ProxyAddress := EProxyAddress.Text;
  ProxyPort := EProxyPort.Text;
  ProxyAuth := CBProxyAuth.Checked;
  ProxyUser := EProxyUser.Text;
  ProxyUserPasswd := EProxyUserPasswd.Text;
  // Всплывашки
  ShowTrayEvents := CBShowTrayEvents.Checked;
  // Передача текста в другие программы
  EnableSendText := CBEnableSendText.Checked;
  ClassNameReciver := EClassNameReciver.Text;
  MethodSendingText := CBMethodSendingText.ItemIndex;
  // Аудио-устройство по-умолчанию
  DefaultAudioDeviceNumber := CBDevice.ItemIndex;
  // Уровни Max
  MaxLevelOnAutoRecord := StrToInt(EMaxLevel.Text);
  MaxLevelOnAutoRecordInterrupt := StrToInt(EMaxLevelInterrupt.Text);
  // Уровни Min
  MinLevelOnAutoRecognize := StrToInt(EMinLevel.Text);
  MinLevelOnAutoRecognizeInterrupt := StrToInt(EMinLevelInterrupt.Text);
  // Действие кнопки "Остановить запись"
  StopRecordAction := CBStopRecordAction.ItemIndex;
  // Горячая клавиша
  GlobalHotKeyEnable := CBHotKey.Checked;
  StartRecordHotKey := HotKetStringGrid.Cells[1,1];
  // Сохраняем настройки
  SaveINI(ExtractFilePath(Application.ExeName));
  // Авто-активация
  MaxLevelOnAutoControl := CBMaxLevelControl.Checked;
  // Активируем настройки
  LoadSettings;
  // Авто-активация записи
  if MaxLevelOnAutoControl then
    StartNULLRecord;
  StartSaveSettings := False;
end;

procedure TMainForm.LoadSettings;
begin
  // Прокси
  CBUseProxy.Checked := UseProxy;
  EProxyAddress.Text := ProxyAddress;
  EProxyPort.Text := ProxyPort;
  CBProxyAuth.Checked := ProxyAuth;
  EProxyUser.Text := ProxyUser;
  EProxyUserPasswd.Text := ProxyUserPasswd;
  CBUseProxyClick(CBUseProxy);
  CBProxyAuthClick(CBProxyAuth);
  // Авто-активация
  CBMaxLevelControl.Checked := MaxLevelOnAutoControl;
  CBMaxLevelControlClick(CBMaxLevelControl);
  // Всплывашки
  CBShowTrayEvents.Checked := ShowTrayEvents;
  // Передача текста в другие программы
  CBEnableSendText.Checked := EnableSendText;
  EClassNameReciver.Text := ClassNameReciver;
  CBMethodSendingText.ItemIndex := MethodSendingText;
  CBMethodSendingTextChange(CBMethodSendingText);
  // Ставим уровни Max
  EMaxLevel.Text := IntToStr(MaxLevelOnAutoRecord);
  UpDownMaxLevel.Position := MaxLevelOnAutoRecord;
  EMaxLevelInterrupt.Text := IntToStr(MaxLevelOnAutoRecordInterrupt);
  UpDownMaxLevelInterrupt.Position := MaxLevelOnAutoRecordInterrupt;
  // Ставим уровни Min
  EMinLevel.Text := IntToStr(MinLevelOnAutoRecognize);
  UpDownMinLevel.Position := MinLevelOnAutoRecognize;
  EMinLevelInterrupt.Text := IntToStr(MinLevelOnAutoRecognizeInterrupt);
  UpDownMinLevelInterrupt.Position := MinLevelOnAutoRecognizeInterrupt;
  // Действие кнопки "Остановить запись"
  CBStopRecordAction.ItemIndex := StopRecordAction;
  CBStopRecordActionChange(CBStopRecordAction);
  // Гор. клавиши
  HotKeySelectedCell := 1;
  GBHotKey.Visible := GlobalHotKeyEnable;
  CBHotKey.Checked := GlobalHotKeyEnable;
  HotKetStringGrid.RowCount := 2;
  HotKetStringGrid.ColWidths[0] := 250;
  HotKetStringGrid.Cells[0,1] := GetLangStr('StartStopRecord');
  HotKetStringGrid.Cells[1,1] := StartRecordHotKey;
  IMHotKey.HotKey := TextToShortCut(HotKetStringGrid.Cells[1,1]);
  // Регистрируем глобальные горячие клавиши
  RegisterHotKeys;
  // Прозрачность окна
  AlphaBlend := AlphaBlendEnable;
  AlphaBlendValue := AlphaBlendEnableValue;
  if AlphaBlendEnable then
  begin
    CBAlphaBlend.Checked := True;
    AlphaBlendTrackBar.Visible := True;
    AlphaBlendVar.Visible := True;
    AlphaBlendTrackBar.Position := AlphaBlendEnableValue;
    AlphaBlendVar.Caption := IntToStr(AlphaBlendEnableValue);
  end
  else
  begin
    CBAlphaBlend.Checked := False;
    AlphaBlendTrackBar.Visible := False;
    AlphaBlendVar.Visible := False;
  end;
  // Заполняем список языков
  FindLangFile;
end;

{ Регистрируем глобальные горячие клавиши }
procedure TMainForm.RegisterHotKeys;
begin
  if (StartRecordHotKey <> '') and GlobalHotKeyEnable then
  begin
    with JvStartRecordHotKey do
    begin
      HotKey := TextToShortCut(StartRecordHotKey);
      Active := True;
    end;
  end
  else
    JvStartRecordHotKey.Active := False;
end;

{ Разрегистрируем глобальные горячие клавиши }
procedure TMainForm.UnRegisterHotKeys;
begin
  if Assigned(JvStartRecordHotKey) then
    JvStartRecordHotKey.Free;
end;

{ Нажата горячая клавиша }
procedure TMainForm.DoHotKey(Sender:TObject);
begin
  if ShortCutToText((Sender as TJvApplicationHotKey).HotKey) = StartRecordHotKey then
  begin
    if StopRecord then
      StartButton.Click
    else
      StopButton.Click;
  end;
end;

{ Добавить горячую клавишу }
procedure TMainForm.SetHotKeyButtonClick(Sender: TObject);
var
  S: String;
  I: Integer;
begin
  S := ShortCutToText(IMHotKey.HotKey);
  for I := 1 to HotKetStringGrid.RowCount - 1 do
  begin
    if HotKetStringGrid.Cells[1,I] = S then
    begin
      MsgInf(ProgramsName, GetLangStr('HotKeyAlredyUses'));
      Exit;
    end;
  end;
  HotKetStringGrid.Cells[1,HotKeySelectedCell] := S;
end;

{ Удалить горячую клавишу }
procedure TMainForm.DeleteHotKeyButtonClick(Sender: TObject);
begin
  HotKetStringGrid.Cells[1,HotKeySelectedCell] := '';
  IMHotKey.HotKey := TextToShortCut('');
end;

{ Клик по строке StringGrid с горячими клавишами }
procedure TMainForm.HotKetStringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  HotKeySelectedCell := ARow;
  IMHotKey.HotKey := TextToShortCut(HotKetStringGrid.Cells[1,ARow]);
end;

{ Показываем всплывающе сообщение в трее }
procedure TMainForm.ShowBalloonHint(BalloonTitle, BalloonMsg: WideString);
begin
  if ShowTrayEvents then
    MSpeechTray.ShowBalloonHint(BalloonTitle, BalloonMsg, bitInfo, 10);
end;

{ Показываем всплывающе сообщение в трее с указанием его типа }
procedure TMainForm.ShowBalloonHint(BalloonTitle, BalloonMsg: WideString; BalloonIconType: TBalloonHintIcon);
begin
  if ShowTrayEvents then
    MSpeechTray.ShowBalloonHint(BalloonTitle, BalloonMsg, BalloonIconType, 10);
end;

procedure TMainForm.ClearLogButtonClick(Sender: TObject);
begin
  LogMemo.Clear;
end;

procedure TMainForm.CBEnableSendTextClick(Sender: TObject);
begin
  GBSendText.Visible := CBEnableSendText.Checked;
end;

{ Функция получения текста из поля активного окна, используя WM_GETTEXT }
function TMainForm.GetTextWnd(MyClassName: String): String;
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  pszWindowText : PChar;
  pszClassName: Array [0..255] of Char;
begin
  Result := '';
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        dwBytesNeeded := SendMessage(hFocusedWnd, WM_GETTEXTLENGTH, 0, 0);
        if dwBytesNeeded > 0 then
        begin
          GetMem(pszWindowText, dwBytesNeeded + 1);
          try
            ZeroMemory(pszWindowText, dwBytesNeeded + 1);
            if Boolean(GetClassName(hFocusedWnd, pszClassName, 256)) then
            begin
              if String(pszClassName) = MyClassName then
              begin
                if SendMessage(hFocusedWnd, WM_GETTEXT, dwBytesNeeded + 1, lParam(pszWindowText)) > 0 then
                  Result := pszWindowText;
              end;
            end;
          finally
            FreeMem(pszWindowText);
          end;
        end;
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура замены текста в поле активного окна, используя WM_SETTEXT }
procedure TMainForm.SetTextWnd(MyClassName, MyText: String);
var
 hFocusedWnd : HWND;
 dwThreadID : DWORD;
 pszClassName: Array [0..255] of Char;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Подключение успешно.');
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Найден фокус.');
        if Boolean(GetClassName(hFocusedWnd, pszClassName, 256)) then
        begin
          if String(pszClassName) = MyClassName then
          begin
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Найден класс ' + MyClassName);
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Отправляем команду.');
            if SendMessage(hFocusedWnd, WM_SETTEXT, 0, lParam(PChar(MyText))) > 0 then
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd (2) - Команда WM_SETTEXT успешно передана.');
          end;
        end;
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура замены текста в поле активного окна, используя WM_SETTEXT }
procedure TMainForm.SetTextWnd(MyText: String);
var
 hFocusedWnd : HWND;
 dwThreadID : DWORD;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd - Найден фокус.');
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd - Отправляем команду.');
        if SendMessage(hFocusedWnd, WM_SETTEXT, 0, lParam(PChar(MyText))) > 0 then
          LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetTextWnd - Команда WM_SETTEXT успешно передана.');
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура добавления текста в поле активного окна, используя EM_SETSEL и EM_REPLACESEL }
procedure TMainForm.InsTextWnd(MyClassName, MyText: String);
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  pszWindowText : PChar;
  pszClassName: Array [0..255] of Char;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Подключение успешно.');
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Найден фокус.');
        dwBytesNeeded := SendMessage(hFocusedWnd, WM_GETTEXTLENGTH, 0, 0);
        if dwBytesNeeded > 0 then
        begin
          LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - dwBytesNeeded > 0');
          GetMem(pszWindowText, dwBytesNeeded + 1);
          try
            ZeroMemory(pszWindowText, dwBytesNeeded + 1);
            if Boolean(GetClassName(hFocusedWnd, pszClassName, 256)) then
            begin
              if String(pszClassName) = MyClassName then
              begin
                LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Найден класс ' + MyClassName);
                LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Отправляем команду.');
                if SendMessage(hFocusedWnd, EM_SETSEL, wParam(dwBytesNeeded), lParam(dwBytesNeeded)) > 0 then
                  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Команда EM_SETSEL успешно передана.');
                if SendMessage(hFocusedWnd, EM_REPLACESEL, 0, lParam(PChar(MyText))) > 0 then
                  LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd (2) - Команда EM_REPLACESEL успешно передана.');
              end;
            end;
          finally
            FreeMem(pszWindowText);
          end;
        end
        else
          SetTextWnd(MyClassName, MyText);
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура добавления текста в поле активного окна, используя EM_SETSEL и EM_REPLACESEL }
procedure TMainForm.InsTextWnd(MyText: String);
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  pszWindowText : PChar;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd - Найден фокус.');
        dwBytesNeeded := SendMessage(hFocusedWnd, WM_GETTEXTLENGTH, 0, 0);
        if dwBytesNeeded > 0 then
        begin
          GetMem(pszWindowText, dwBytesNeeded + 1);
          try
            ZeroMemory(pszWindowText, dwBytesNeeded + 1);
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd - Отправляем команду.');
            if SendMessage(hFocusedWnd, EM_SETSEL, wParam(dwBytesNeeded), lParam(dwBytesNeeded)) > 0 then
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd - Команда EM_SETSEL успешно передана.');
            if SendMessage(hFocusedWnd, EM_REPLACESEL, 0, lParam(PChar(MyText))) > 0 then
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': InsTextWnd - Команда EM_REPLACESEL успешно передана.');
          finally
            FreeMem(pszWindowText);
          end;
        end
        else
          SetTextWnd(MyText);
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура добавления текста в поле активного окна, используя WM_PASTE }
procedure TMainForm.CopyPasteTextWnd(MyClassName, MyText: String);
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  //pszWindowText : PChar;
  pszClassName: Array [0..255] of Char;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd (2) - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd (2) - Найден фокус.');
        if Boolean(GetClassName(hFocusedWnd, pszClassName, 256)) then
        begin
          if String(pszClassName) = MyClassName then
          begin
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd (2) - Найден класс ' + MyClassName);
            LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd (2) - Отправляем команду.');
            Clipboard.Clear;
            Clipboard.AsText := MyText;
            if SendMessage(hFocusedWnd, WM_PASTE, 0, 0) > 0 then
              LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd (2) - Команда WM_PASTE успешно передана.');
          end;
        end;
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

procedure TMainForm.CopyPasteTextWnd(MyText: String);
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  pszWindowText : PChar;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd - Найден фокус.');
        Clipboard.Clear;
        Clipboard.AsText := MyText;
        if SendMessage(hFocusedWnd, WM_PASTE, 0, 0) > 0 then
          LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': CopyPasteTextWnd - Команда WM_PASTE успешно передана.');
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

{ Процедура добавления текста в поле активного окна, используя WM_CHAR }
procedure TMainForm.SetCharTextWnd(MyText: String);
var
  hFocusedWnd : HWND;
  dwThreadID : DWORD;
  dwBytesNeeded : DWord;
  pszWindowText : PChar;
  Cnt: Integer;
begin
  dwThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
  if dwThreadID <> 0 then
  begin
    LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetCharTextWnd - Найден процесс.');
    if AttachThreadInput(GetCurrentThreadId, dwThreadID, True) then
    begin
      hFocusedWnd := GetFocus;
      if hFocusedWnd <> 0 then
      begin
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetCharTextWnd - Найден фокус.');
        LogMemo.Lines.Add(FormatDateTime('dd.mm.yy hh:mm:ss', Now) + ': SetCharTextWnd - Отправляем текст...');
        for Cnt := 1 to Length(MyText) do
          PostMessage(hFocusedWnd, WM_CHAR, Word(MyText[Cnt]), 0);
        //PostMessage(hFocusedWnd, WM_KEYDOWN, VK_RETURN, 0);
      end;
      AttachThreadInput(GetCurrentThreadId, dwThreadID, False);
    end;
  end;
end;

procedure TMainForm.CBMethodSendingTextChange(Sender: TObject);
begin
  if CBMethodSendingText.ItemIndex = 2 then
  begin
    LClassName.Enabled := False;
    EClassNameReciver.Enabled := False;
  end
  else
  begin
    LClassName.Enabled := True;
    EClassNameReciver.Enabled := True;
  end;
end;

{ Прозрачность окон }
procedure TMainForm.CBAlphaBlendClick(Sender: TObject);
begin
  AlphaBlendEnable := CBAlphaBlend.Checked;
  // Вкл. прозрачность окна настроек
  AlphaBlend := AlphaBlendEnable;
  if AlphaBlendEnable then
  begin
    AlphaBlendTrackBar.Visible := True;
    AlphaBlendVar.Visible := True;
    AlphaBlendTrackBar.Position := AlphaBlendEnableValue;
    AlphaBlendVar.Caption := IntToStr(AlphaBlendEnableValue);
  end
  else
  begin
    AlphaBlendTrackBar.Visible := False;
    AlphaBlendVar.Visible := False;
  end;
end;

procedure TMainForm.AlphaBlendTrackBarChange(Sender: TObject);
begin
  AlphaBlendEnableValue := AlphaBlendTrackBar.Position;
  // Прозрачность окна настроек
  AlphaBlendValue := AlphaBlendEnableValue;
  AlphaBlendVar.Caption := IntToStr(AlphaBlendEnableValue);
end;

{ Отлавливаем событие WM_MSGBOX для изменения прозрачности окна }
procedure TMainForm.msgBoxShow(var Msg: TMessage);
var
  msgbHandle: HWND;
begin
  msgbHandle := GetActiveWindow;
  if msgbHandle <> 0 then
    MakeTransp(msgbHandle);
end;

{ Процедура поиска языковых файлов и заполнения списка }
procedure TMainForm.FindLangFile;
var
  SR: TSearchRec;
  I: Integer;
begin
  CBLang.Items.Clear;
  if FindFirst(ExtractFilePath(Application.ExeName) + dirLangs + '\*.*', faAnyFile or faDirectory, SR) = 0 then
  begin
    repeat
      if (SR.Attr = faDirectory) and ((SR.Name = '.') or (SR.Name = '..')) then // Чтобы не было файлов . и ..
      begin
        Continue; // Продолжаем цикл
      end;
      if MatchStrings(SR.Name, '*.xml') then
      begin
        // Заполняем лист
        CBLang.Items.Add(ExtractFileNameEx(SR.Name, False));
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  for I := 0 to CBLang.Items.Count-1 do
  begin
    if CBLang.Items[I] = CoreLanguage then
      CBLang.ItemIndex := I;
  end;
end;

procedure TMainForm.CBLangChange(Sender: TObject);
begin
  FLanguage := CBLang.Items[CBLang.ItemIndex];
  DefaultLanguage := CBLang.Items[CBLang.ItemIndex];
  CoreLanguageChanged;
end;

{ Функция для мультиязыковой поддержки }
procedure TMainForm.CoreLanguageChanged;
var
  LangFile: String;
begin
  if CoreLanguage = '' then
    Exit;
  try
    LangFile := ExtractFilePath(Application.ExeName) + dirLangs + CoreLanguage + '.xml';
    if FileExists(LangFile) then
      LangDoc.LoadFromFile(LangFile)
    else
    begin
      if FileExists(ExtractFilePath(Application.ExeName) + dirLangs + defaultLangFile) then
        LangDoc.LoadFromFile(ExtractFilePath(Application.ExeName) + dirLangs + defaultLangFile)
      else
      begin
        MsgDie(ProgramsName, 'Not found any language file!');
        Exit;
      end;
    end;
    Global.CoreLanguage := CoreLanguage;
    SendMessage(MainFormHandle, WM_LANGUAGECHANGED, 0, 0);
    SendMessage(AboutFormHandle, WM_LANGUAGECHANGED, 0, 0);
  except
    on E: Exception do
      MsgDie(ProgramsName, 'Error on CoreLanguageChanged: ' + E.Message + sLineBreak +
        'CoreLanguage: ' + CoreLanguage);
  end;
end;

{ Смена языка интерфейса по событию WM_LANGUAGECHANGED }
procedure TMainForm.OnLanguageChanged(var Msg: TMessage);
begin
  LoadLanguageStrings;
end;

{ Для мультиязыковой поддержки }
procedure TMainForm.LoadLanguageStrings;
begin
  Caption := GetLangStr('MSpeechCaption');
  if MSpeechPopupMenu.Items[0].Hint = 'MSpeechPopupMenuShow' then
  begin
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuShow');
    MSpeechPopupMenu.Items[0].Hint := 'MSpeechPopupMenuShow';
  end
  else
  begin
    MSpeechPopupMenu.Items[0].Caption := GetLangStr('MSpeechPopupMenuHide');
    MSpeechPopupMenu.Items[0].Hint := 'MSpeechPopupMenuHide';
  end;
  MSpeechPopupMenu.Items[1].Caption := GetLangStr('MSpeechPopupMenuSettings');
  MSpeechPopupMenu.Items[2].Caption := GetLangStr('MSpeechPopupMenuAbout');
  MSpeechPopupMenu.Items[3].Caption := GetLangStr('MSpeechPopupMenuExit');
  GBMain.Caption := Format(' %s ', [GetLangStr('GBMain')]);
  LSignalLevel.Caption := GetLangStr('LSignalLevel');
  StartButton.Caption := GetLangStr('StartButton');
  StopButton.Caption := GetLangStr('StopButton');
  SettingsButton.Caption := GetLangStr('SettingsButton');
  SaveSettingsButton.Caption := GetLangStr('SaveSettingsButton');
  TabSheetSettings.Caption := GetLangStr('TabSheetSettings');
  TabSheetRecord.Caption := GetLangStr('TabSheetRecord');
  TabSheetConnectSettings.Caption  := GetLangStr('TabSheetConnectSettings');
  TabSheetHotKey.Caption := GetLangStr('TabSheetHotKey');
  TabSheetLog.Caption := GetLangStr('TabSheetLog');
  TabSheetSendText.Caption := GetLangStr('TabSheetSendText');
  GBInterfaceSettings.Caption := Format(' %s ', [GetLangStr('GBInterfaceSettings')]);
  CBAlphaBlend.Caption := GetLangStr('CBAlphaBlend');
  CBShowTrayEvents.Caption := GetLangStr('CBShowTrayEvents');
  LLang.Caption := GetLangStr('LLang');
  GBRecordSettings.Caption := Format(' %s ', [GetLangStr('GBRecordSettings')]);
  LDevice.Caption := GetLangStr('LDevice');
  MicSettingsButton.Caption := GetLangStr('MicSettingsButton');
  LMaxLevel.Caption := GetLangStr('LMaxLevel');
  LMaxLevelInterrupt.Caption := GetLangStr('LMaxLevelInterrupt');
  LMinLevel.Caption := GetLangStr('LMinLevel');
  LEMinLevelInterrupt.Caption := GetLangStr('LEMinLevelInterrupt');
  CBMaxLevelControl.Caption := GetLangStr('CBMaxLevelControl');
  LStopRecordAction.Caption := GetLangStr('LStopRecordAction');
  CBStopRecordAction.Clear;
  CBStopRecordAction.Items.Add(GetLangStr('CBStopRecordActionItems1'));
  CBStopRecordAction.Items.Add(GetLangStr('CBStopRecordActionItems2'));
  CBStopRecordAction.Items.Add(GetLangStr('CBStopRecordActionItems3'));
  CBStopRecordAction.Items.Add(GetLangStr('CBStopRecordActionItems4'));
  CBStopRecordAction.ItemIndex := 0;
  GBConnectSettings.Caption := Format(' %s ', [GetLangStr('GBConnectSettings')]);
  CBUseProxy.Caption := GetLangStr('CBUseProxy');
  LProxyAddress.Caption := GetLangStr('LProxyAddress');
  LProxyPort.Caption := GetLangStr('LProxyPort');
  CBProxyAuth.Caption := GetLangStr('CBProxyAuth');
  LProxyUser.Caption := GetLangStr('LProxyUser');
  LProxyUserPasswd.Caption := GetLangStr('LProxyUserPasswd');
  CBHotKey.Caption := GetLangStr('CBHotKey');
  GBHotKey.Caption := Format(' %s ', [GetLangStr('GBHotKey')]);
  SetHotKeyButton.Caption := GetLangStr('SetHotKeyButton');
  DeleteHotKeyButton.Caption := GetLangStr('DeleteHotKeyButton');
  ClearLogButton.Caption := GetLangStr('ClearLogButton');
  CBEnableSendText.Caption := GetLangStr('CBEnableSendText');
  GBSendText.Caption := Format(' %s ', [GetLangStr('GBSendText')]);
  LMethodSendingText.Caption := GetLangStr('LMethodSendingText');
  LClassName.Caption := GetLangStr('LClassName');
  LNote.Caption := GetLangStr('LNote');
  // Позиционируем контролы
  CBLang.Left := LLang.Left + LLang.Width + 5;
  CBDevice.Left := LDevice.Left + LDevice.Width + 5;
  MicSettingsButton.Left := LDevice.Left + LDevice.Width + 5 + CBDevice.Width + 5;
  CBStopRecordAction.Left := LStopRecordAction.Left + LStopRecordAction.Width + 5;
  EProxyAddress.Left := LProxyAddress.Left + LProxyAddress.Width + 5;
  LProxyPort.Left := LProxyAddress.Left + LProxyAddress.Width + 5 + EProxyAddress.Width + 5;
  EProxyPort.Left := LProxyAddress.Left + LProxyAddress.Width + 5 + EProxyAddress.Width + 5 + LProxyPort.Width + 5;
end;

end.
