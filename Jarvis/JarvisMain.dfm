object Form1: TForm1
  Left = 197
  Top = 150
  Width = 445
  Height = 430
  Caption = 'Jarvis'
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
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 135
    Height = 13
    Caption = #1056#1091#1095#1085#1086#1081' '#1074#1074#1086#1076' '#1082#1086#1084#1072#1085#1076#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AutoCommandEdit: TEdit
    Left = 8
    Top = 8
    Width = 417
    Height = 21
    TabOrder = 1
    OnChange = AutoCommandEditChange
  end
  object ManualEdit: TEdit
    Left = 8
    Top = 48
    Width = 417
    Height = 21
    TabOrder = 0
    OnKeyPress = ManualEditKeyPress
  end
  object SendButton: TButton
    Left = 16
    Top = 80
    Width = 73
    Height = 17
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = SendButtonClick
  end
  object LogBox: TListBox
    Left = 8
    Top = 104
    Width = 417
    Height = 281
    ItemHeight = 13
    TabOrder = 3
  end
  object client: TIdTCPClient
    MaxLineAction = maException
    Host = '127.0.0.1'
    Port = 27030
    Left = 400
  end
  object server: TIdTCPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 27031
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = serverExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 360
  end
end
