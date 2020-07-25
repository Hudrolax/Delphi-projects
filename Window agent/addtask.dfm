object Form2: TForm2
  Left = 453
  Top = 246
  Width = 564
  Height = 445
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1076#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  DesignSize = (
    556
    418)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 16
    Width = 63
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 40
    Width = 71
    Height = 13
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 0
    Top = 72
    Width = 61
    Height = 13
    Caption = #1050#1072#1088#1090#1080#1085#1082#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 0
    Top = 120
    Width = 47
    Height = 13
    Caption = #1057#1082#1088#1080#1087#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 312
    Top = 368
    Width = 233
    Height = 13
    Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1099' (Alt+F1)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 0
    Top = 104
    Width = 65
    Height = 13
    Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1089
  end
  object Label7: TLabel
    Left = 152
    Top = 104
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object Label8: TLabel
    Left = 312
    Top = 304
    Width = 142
    Height = 13
    Caption = #1045#1089#1083#1080' '#1079#1072#1087#1091#1097#1077#1085' '#1087#1088#1086#1094#1077#1089#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 312
    Top = 344
    Width = 243
    Height = 13
    Caption = #1055#1088#1080#1084#1077#1088': if (NoProcess = firefox.exe) run Script.com'
  end
  object TaskName: TEdit
    Left = 72
    Top = 8
    Width = 129
    Height = 21
    TabOrder = 0
  end
  object fname: TEdit
    Left = 72
    Top = 40
    Width = 129
    Height = 21
    TabOrder = 1
  end
  object ImgPatch: TEdit
    Left = 72
    Top = 72
    Width = 233
    Height = 21
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 0
    Top = 136
    Width = 305
    Height = 281
    Anchors = [akLeft, akTop, akBottom]
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 496
    Top = 388
    Width = 57
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 312
    Top = 388
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = Button2Click
  end
  object taskid: TEdit
    Left = 224
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 6
    Visible = False
  end
  object Button3: TButton
    Left = 312
    Top = 8
    Width = 105
    Height = 33
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 312
    Top = 48
    Width = 105
    Height = 17
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 312
    Top = 112
    Width = 105
    Height = 33
    Caption = #1055#1072#1091#1079#1072
    TabOrder = 9
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 312
    Top = 160
    Width = 105
    Height = 33
    Caption = #1055#1072#1091#1079#1072' 1000'#1084#1089
    TabOrder = 10
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 432
    Top = 8
    Width = 113
    Height = 33
    Caption = #1055#1077#1088#1077#1084#1077#1089#1090#1080#1090#1100' '#1084#1099#1096#1100
    TabOrder = 11
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 432
    Top = 64
    Width = 113
    Height = 33
    Caption = #1051#1077#1074#1072#1103' '#1082#1085#1086#1087#1082#1072
    TabOrder = 12
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 432
    Top = 112
    Width = 113
    Height = 33
    Caption = #1055#1088#1072#1074#1072#1103' '#1082#1085#1086#1087#1082#1072
    TabOrder = 13
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 432
    Top = 160
    Width = 113
    Height = 17
    Caption = 'Enter'
    TabOrder = 14
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 432
    Top = 184
    Width = 113
    Height = 17
    Caption = 'Esc'
    TabOrder = 15
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 432
    Top = 208
    Width = 113
    Height = 17
    Caption = 'TAB'
    TabOrder = 16
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 432
    Top = 232
    Width = 113
    Height = 17
    Caption = 'Space'
    TabOrder = 17
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 312
    Top = 208
    Width = 113
    Height = 17
    Caption = 'UP'
    TabOrder = 18
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 312
    Top = 232
    Width = 113
    Height = 17
    Caption = 'Down'
    TabOrder = 19
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 312
    Top = 256
    Width = 113
    Height = 17
    Caption = 'Left'
    TabOrder = 20
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 312
    Top = 280
    Width = 113
    Height = 17
    Caption = 'Right'
    TabOrder = 21
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 432
    Top = 256
    Width = 113
    Height = 17
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 22
    OnClick = Button18Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 72
    Top = 104
    Width = 73
    Height = 17
    Date = 40260.000000000000000000
    Time = 40260.000000000000000000
    Kind = dtkTime
    TabOrder = 23
  end
  object DateTimePicker2: TDateTimePicker
    Left = 176
    Top = 104
    Width = 73
    Height = 17
    Date = 40260.000000000000000000
    Time = 40260.000000000000000000
    Kind = dtkTime
    TabOrder = 24
  end
  object ProcName: TEdit
    Left = 312
    Top = 320
    Width = 161
    Height = 21
    TabOrder = 25
    Text = '1cv8recalc.exe'
  end
  object Button19: TButton
    Left = 480
    Top = 320
    Width = 65
    Height = 17
    Caption = #1042#1089#1090#1072#1074#1080#1090#1100
    TabOrder = 26
    OnClick = Button19Click
  end
  object Button20: TButton
    Left = 312
    Top = 72
    Width = 105
    Height = 25
    Caption = #1050#1083#1080#1082' '#1087#1086' '#1082#1072#1088#1090#1080#1085#1082#1077
    TabOrder = 27
    OnClick = Button20Click
  end
end
