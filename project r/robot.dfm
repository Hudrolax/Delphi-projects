object Form1: TForm1
  Left = 237
  Top = 155
  Width = 562
  Height = 817
  Caption = 'Robot'
  Color = clBtnFace
  Constraints.MinHeight = 482
  Constraints.MinWidth = 523
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCrem1ate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  DesignSize = (
    554
    790)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 200
    Top = 496
    Width = 75
    Height = 16
    Caption = #1044#1077#1081#1089#1090#1074#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 368
    Top = 456
    Width = 103
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103':'
  end
  object Label3: TLabel
    Left = 368
    Top = 496
    Width = 57
    Height = 13
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
  end
  object Label4: TLabel
    Left = 352
    Top = 16
    Width = 48
    Height = 13
    Caption = #1057#1077#1088#1074#1077#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 248
    Top = 16
    Width = 33
    Height = 41
    Caption = 'FW'
    TabOrder = 0
    TabStop = False
    OnKeyDown = Button1KeyDown
    OnKeyUp = Button1KeyUp
    OnMouseDown = Button1MouseDown
    OnMouseUp = Button1MouseUp
  end
  object Button2: TButton
    Left = 192
    Top = 424
    Width = 65
    Height = 25
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 1
    TabStop = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 288
    Top = 56
    Width = 49
    Height = 25
    Caption = 'Right'
    TabOrder = 2
    TabStop = False
    OnMouseDown = Button3MouseDown
    OnMouseUp = Button3MouseUp
  end
  object Button4: TButton
    Left = 192
    Top = 56
    Width = 49
    Height = 25
    Caption = 'Left'
    TabOrder = 3
    TabStop = False
    OnMouseDown = Button4MouseDown
    OnMouseUp = Button4MouseUp
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 185
    Height = 787
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 4
    OnDrawItem = ListBox1DrawItem
  end
  object Button5: TButton
    Left = 248
    Top = 144
    Width = 49
    Height = 17
    Caption = 'FW+'
    TabOrder = 5
    TabStop = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 248
    Top = 192
    Width = 49
    Height = 17
    Caption = 'RV+'
    TabOrder = 6
    TabStop = False
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 240
    Top = 248
    Width = 49
    Height = 17
    Caption = #1055#1072#1091#1079#1072
    TabOrder = 7
    TabStop = False
    OnClick = Button7Click
  end
  object Edit1: TEdit
    Left = 192
    Top = 248
    Width = 41
    Height = 21
    TabOrder = 8
    Text = '1000'
  end
  object Button8: TButton
    Left = 272
    Top = 424
    Width = 65
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 9
    TabStop = False
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 248
    Top = 72
    Width = 33
    Height = 41
    Caption = 'RV'
    TabOrder = 10
    TabStop = False
    OnMouseDown = Button9MouseDown
    OnMouseUp = Button9MouseUp
  end
  object Button10: TButton
    Left = 248
    Top = 160
    Width = 49
    Height = 17
    Caption = 'FW-'
    TabOrder = 11
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 248
    Top = 208
    Width = 49
    Height = 17
    Caption = 'RV-'
    TabOrder = 12
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 192
    Top = 168
    Width = 49
    Height = 17
    Caption = 'Left +'
    TabOrder = 13
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 192
    Top = 184
    Width = 49
    Height = 17
    Caption = 'Left -'
    TabOrder = 14
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 304
    Top = 168
    Width = 49
    Height = 17
    Caption = 'Right +'
    TabOrder = 15
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 304
    Top = 184
    Width = 49
    Height = 17
    Caption = 'Right-'
    TabOrder = 16
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 392
    Top = 48
    Width = 105
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 17
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 392
    Top = 80
    Width = 105
    Height = 25
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 18
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 192
    Top = 280
    Width = 49
    Height = 17
    Caption = #1087' 50'
    TabOrder = 19
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 192
    Top = 304
    Width = 49
    Height = 17
    Caption = #1087' 100'
    TabOrder = 20
    OnClick = Button19Click
  end
  object Button20: TButton
    Left = 192
    Top = 328
    Width = 49
    Height = 17
    Caption = #1087' 200'
    TabOrder = 21
    OnClick = Button20Click
  end
  object Button21: TButton
    Left = 192
    Top = 352
    Width = 49
    Height = 17
    Caption = #1087' 500'
    TabOrder = 22
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 256
    Top = 280
    Width = 49
    Height = 17
    Caption = #1087' 1000'
    TabOrder = 23
    OnClick = Button22Click
  end
  object Button23: TButton
    Left = 256
    Top = 304
    Width = 49
    Height = 17
    Caption = #1087' 2000'
    TabOrder = 24
    OnClick = Button23Click
  end
  object Button24: TButton
    Left = 256
    Top = 328
    Width = 49
    Height = 17
    Caption = #1087' 5000'
    TabOrder = 25
    OnClick = Button24Click
  end
  object Button25: TButton
    Left = 256
    Top = 352
    Width = 49
    Height = 17
    Caption = #1087' 10000'
    TabOrder = 26
    OnClick = Button25Click
  end
  object Button26: TButton
    Left = 511
    Top = 759
    Width = 41
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Exit'
    TabOrder = 27
    OnClick = Button26Click
  end
  object Button27: TButton
    Left = 320
    Top = 240
    Width = 73
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' 1'
    TabOrder = 28
    OnClick = Button27Click
  end
  object Button28: TButton
    Left = 320
    Top = 272
    Width = 73
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' 2'
    TabOrder = 29
    OnClick = Button28Click
  end
  object Button29: TButton
    Left = 320
    Top = 304
    Width = 73
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1090#1080#1100' 3'
    TabOrder = 30
    OnClick = Button29Click
  end
  object Button30: TButton
    Left = 408
    Top = 240
    Width = 73
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' 1'
    TabOrder = 31
    OnClick = Button30Click
  end
  object Button31: TButton
    Left = 408
    Top = 272
    Width = 73
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' 2'
    TabOrder = 32
    OnClick = Button31Click
  end
  object Button32: TButton
    Left = 408
    Top = 304
    Width = 73
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' 3'
    TabOrder = 33
    OnClick = Button32Click
  end
  object Button33: TButton
    Left = 192
    Top = 392
    Width = 65
    Height = 17
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 34
    OnClick = Button33Click
  end
  object CheckBox1: TCheckBox
    Left = 200
    Top = 472
    Width = 113
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1100' (Alt+F2)'
    TabOrder = 35
  end
  object Button34: TButton
    Left = 424
    Top = 400
    Width = 73
    Height = 25
    Caption = #1063#1080#1089#1090#1082#1072
    Enabled = False
    TabOrder = 36
    Visible = False
    OnClick = Button34Click
  end
  object ListBox2: TListBox
    Left = 192
    Top = 520
    Width = 153
    Height = 161
    ItemHeight = 13
    TabOrder = 37
  end
  object Edit2: TEdit
    Left = 368
    Top = 472
    Width = 161
    Height = 21
    TabOrder = 38
  end
  object Edit3: TEdit
    Left = 368
    Top = 512
    Width = 161
    Height = 21
    TabOrder = 39
  end
  object Button35: TButton
    Left = 368
    Top = 544
    Width = 65
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 40
    OnClick = Button35Click
  end
  object Button36: TButton
    Left = 352
    Top = 608
    Width = 97
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 41
    OnClick = Button36Click
  end
  object CheckBox2: TCheckBox
    Left = 352
    Top = 648
    Width = 81
    Height = 17
    Caption = #1040#1074#1090#1086#1087#1080#1083#1086#1090
    TabOrder = 42
    OnClick = CheckBox2Click
  end
  object Edit4: TEdit
    Left = 408
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 43
    Text = '192.168.18.2'
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 504
    Top = 360
  end
  object dbf: TDBF
    Exclusive = False
    Left = 496
    Top = 320
  end
  object Timer2: TTimer
    Interval = 50
    OnTimer = Timer2Timer
    Left = 504
    Top = 416
  end
  object baza: TIdTCPClient
    MaxLineAction = maException
    Host = '192.168.18.2'
    Port = 27015
    Left = 288
    Top = 688
  end
end
