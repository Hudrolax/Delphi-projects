object Form1: TForm1
  Left = 297
  Top = 231
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
  Visible = True
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
    TerminateWaitTime = 10000
    Left = 48
  end
end
