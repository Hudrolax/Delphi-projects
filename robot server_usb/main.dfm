object Form1: TForm1
  Left = 442
  Top = 247
  Width = 530
  Height = 275
  Caption = 'Hudrolax roBOT Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    514
    237)
  PixelsPerInch = 96
  TextHeight = 13
  object log: TListBox
    Left = 0
    Top = 0
    Width = 521
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object server: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 27027
    Greeting.NumericCode = 0
    Greeting.Text.Strings = (
      'Connected')
    MaxConnectionReply.NumericCode = 0
    OnConnect = serverConnect
    OnExecute = serverExecute
    OnDisconnect = serverDisconnect
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Top = 208
  end
  object com1: TBComPort
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
    Left = 48
    Top = 208
  end
  object Timer1: TTimer
    Interval = 3600000
    OnTimer = Timer1Timer
    Left = 216
    Top = 184
  end
end
