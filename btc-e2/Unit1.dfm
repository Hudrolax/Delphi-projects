object Form1: TForm1
  Left = 278
  Top = 177
  Width = 296
  Height = 86
  Caption = 'BTC-E Proxy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object server: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 3738
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = serverExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 48
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 144
    Top = 16
  end
  object Timer3: TTimer
    OnTimer = Timer3Timer
    Left = 216
    Top = 16
  end
end
