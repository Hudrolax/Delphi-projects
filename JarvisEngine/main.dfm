object Form1: TForm1
  Left = 233
  Top = 161
  Width = 492
  Height = 534
  Caption = 'Jarvis Engine'
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
  object LogBox: TListBox
    Left = 8
    Top = 8
    Width = 433
    Height = 481
    ItemHeight = 13
    TabOrder = 0
  end
  object server: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 27030
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = serverExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 448
  end
  object DBF1: TDBF
    Exclusive = False
    Left = 448
    Top = 48
  end
  object client: TIdTCPClient
    MaxLineAction = maException
    Port = 27031
    Left = 448
    Top = 96
  end
  object DBF2: TDBF
    Exclusive = False
    Left = 448
    Top = 160
  end
end
