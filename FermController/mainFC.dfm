object Form1: TForm1
  Left = 312
  Top = 210
  Width = 668
  Height = 314
  Caption = 'FermController'
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
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 649
    Height = 273
    ItemHeight = 13
    TabOrder = 0
  end
  object Com1: TBComPort
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
    Left = 400
  end
  object IDServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 27032
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = IDServerExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 392
    Top = 48
  end
  object IDClient: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 2000
    Port = 27030
    Left = 352
  end
end
