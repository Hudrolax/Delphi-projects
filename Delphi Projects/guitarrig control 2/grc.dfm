object Form1: TForm1
  Left = 246
  Top = 184
  Width = 538
  Height = 237
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 184
    Width = 59
    Height = 13
    Caption = #1054#1090#1082#1083#1102#1095#1077#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 161
    Height = 21
    TabOrder = 0
    Text = 'Distortion'
  end
  object Edit2: TEdit
    Left = 192
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit3: TEdit
    Left = 272
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Edit4: TEdit
    Left = 360
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Edit5: TEdit
    Left = 440
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object Edit777: TEdit
    Left = 0
    Top = 184
    Width = 73
    Height = 21
    TabOrder = 5
    Text = 'COM3'
  end
  object Button1: TButton
    Left = 88
    Top = 184
    Width = 81
    Height = 17
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 6
    OnClick = Button1Click
  end
  object com: TBComPort
    BaudRate = br9600
    ByteSize = bs8
    InBufSize = 2048
    OutBufSize = 2048
    Parity = paNone
    Port = 'COM3'
    SyncMethod = smThreadSync
    StopBits = sb1
    Timeouts.ReadInterval = -1
    Timeouts.ReadTotalMultiplier = 0
    Timeouts.ReadTotalConstant = 0
    Timeouts.WriteTotalMultiplier = 100
    Timeouts.WriteTotalConstant = 1000
    OnRxChar = comRxChar
    Left = 488
    Top = 160
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 432
    Top = 168
  end
end
