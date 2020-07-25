object Form1: TForm1
  Left = 567
  Top = 325
  BorderStyle = bsSingle
  Caption = #1057#1091#1087#1077#1088' '#1074#1099#1076#1077#1083#1103#1083#1082#1072
  ClientHeight = 569
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 152
    Top = 56
    Width = 85
    Height = 16
    Caption = #1042#1099#1082#1083#1102#1095#1077#1085#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 246
    Height = 13
    Caption = #1042#1074#1086#1076#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1073#1086#1083#1100#1096#1077' 1-'#1075#1086' ID. '#1057#1083#1077#1076#1080#1090#1100' '#1079#1072' '#1090#1077#1084','
  end
  object Label3: TLabel
    Left = 0
    Top = 16
    Width = 224
    Height = 13
    Caption = #1095#1090#1086#1073' '#1073#1099#1083#1080' '#1074#1099#1076#1077#1083#1077#1085#1099' ID '#1086#1076#1085#1086#1075#1086' '#1074#1080#1076#1072' '#1089#1082#1080#1076#1082#1080
  end
  object Memo1: TMemo
    Left = 0
    Top = 32
    Width = 145
    Height = 537
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object start: TCheckBox
    Left = 152
    Top = 88
    Width = 105
    Height = 17
    Caption = #1055#1086#1077#1093#1072#1083#1080' (Ctrl+F1)'
    TabOrder = 1
    OnClick = startClick
  end
  object Button1: TButton
    Left = 152
    Top = 136
    Width = 97
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 536
    Width = 105
    Height = 33
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 160
    Top = 168
  end
end
