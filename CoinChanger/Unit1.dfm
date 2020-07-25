object Form1: TForm1
  Left = 235
  Top = 179
  Width = 529
  Height = 148
  Caption = 'CoinChanger'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 56
    Top = 8
    Width = 392
    Height = 24
    Caption = 'Coin Changer - '#1089#1084#1077#1085#1072' '#1082#1086#1085#1092#1080#1075#1086#1074' cgminer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 72
    Width = 236
    Height = 24
    Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1081' '#1082#1086#1085#1092#1080#1075' '#1073#1099#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 256
    Top = 72
    Width = 49
    Height = 24
    Caption = 'none'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object WorkTimer: TTimer
    Interval = 60000
    OnTimer = WorkTimerTimer
    Left = 472
    Top = 8
  end
  object ftp: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 60000
    Host = 'hud.net.ru'
    Passive = True
    Password = 'nhbnsczxbktn'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Username = 'ftp_com'
    Left = 472
    Top = 56
  end
end
