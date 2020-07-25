object Form1: TForm1
  Left = 248
  Top = 176
  BorderStyle = bsSingle
  Caption = 'BitCoin Exchange Calculator'
  ClientHeight = 526
  ClientWidth = 845
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
    Left = 8
    Top = 16
    Width = 94
    Height = 13
    Caption = 'BTC/USD - Buy:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 192
    Top = 16
    Width = 82
    Height = 13
    Caption = 'BTC/USD Sell'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 64
    Width = 82
    Height = 20
    Caption = #1055#1088#1080#1073#1099#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 72
    Top = 86
    Width = 11
    Height = 20
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 176
    Top = 40
    Width = 69
    Height = 13
    Caption = #1054#1073#1098#1077#1084' BTC'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 49
    Height = 16
    Caption = #1042' BTC:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 107
    Width = 62
    Height = 16
    Caption = 'BTC-E $:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 72
    Top = 104
    Width = 11
    Height = 20
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 123
    Width = 48
    Height = 16
    Caption = 'GOX $:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 72
    Top = 120
    Width = 11
    Height = 20
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 376
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Online'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 248
    Top = 144
    Width = 148
    Height = 16
    Caption = #1054#1088#1076#1077#1088#1072' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 32
    Top = 144
    Width = 151
    Height = 16
    Caption = #1054#1088#1076#1077#1088#1072' '#1085#1072' '#1087#1088#1086#1076#1072#1078#1091':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 464
    Top = 144
    Width = 151
    Height = 16
    Caption = #1054#1088#1076#1077#1088#1072' '#1085#1072' '#1087#1088#1086#1076#1072#1078#1091':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 672
    Top = 144
    Width = 148
    Height = 16
    Caption = #1054#1088#1076#1077#1088#1072' '#1085#1072' '#1087#1086#1082#1091#1087#1082#1091':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BuyBTC: TEdit
    Left = 104
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '25,00'
  end
  object SellBTC: TEdit
    Left = 280
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 1
    Text = '26,00'
  end
  object CheckGox: TCheckBox
    Left = 8
    Top = 40
    Width = 145
    Height = 17
    Caption = #1055#1088#1086#1076#1072#1078#1072' '#1085#1072' MT-Gox'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
    OnClick = CheckGoxClick
  end
  object VolBTC: TEdit
    Left = 248
    Top = 32
    Width = 105
    Height = 21
    TabOrder = 3
    Text = '2,0'
  end
  object Button1: TButton
    Left = 104
    Top = 56
    Width = 137
    Height = 25
    Caption = #1055#1077#1088#1077#1089#1095#1077#1090
    TabOrder = 4
    OnClick = Button1Click
  end
  object GetPriceOnline: TCheckBox
    Left = 256
    Top = 60
    Width = 161
    Height = 17
    Caption = #1055#1086#1083#1091#1095#1072#1090#1100' '#1082#1086#1090#1080#1088#1086#1074#1082#1080' '#1089' '#1073#1080#1088#1078
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 5
    OnClick = GetPriceOnlineClick
  end
  object Button2: TButton
    Left = 264
    Top = 112
    Width = 57
    Height = 17
    Caption = 'Button2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object sgAsk: TStringGrid
    Left = 8
    Top = 160
    Width = 201
    Height = 361
    ColCount = 4
    DefaultColWidth = 30
    DefaultRowHeight = 15
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 7
    ColWidths = (
      30
      36
      53
      54)
  end
  object sgBid: TStringGrid
    Left = 216
    Top = 160
    Width = 201
    Height = 361
    ColCount = 4
    DefaultColWidth = 30
    DefaultRowHeight = 15
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 8
    ColWidths = (
      30
      36
      53
      54)
  end
  object sgBid2: TStringGrid
    Left = 640
    Top = 160
    Width = 201
    Height = 361
    ColCount = 4
    DefaultColWidth = 30
    DefaultRowHeight = 15
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 9
    ColWidths = (
      30
      36
      53
      54)
  end
  object sgAsk2: TStringGrid
    Left = 432
    Top = 160
    Width = 201
    Height = 361
    ColCount = 4
    DefaultColWidth = 30
    DefaultRowHeight = 15
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 10
    ColWidths = (
      30
      36
      53
      54)
  end
  object http: TIdHTTP
    IOHandler = IdSSLIOHandlerSocket1
    MaxLineAction = maException
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'InternetExplorer'
    HTTPOptions = [hoForceEncodeParams]
    Left = 160
    Top = 80
  end
  object IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket
    SSLOptions.Method = sslvTLSv1
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 120
    Top = 88
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 208
    Top = 88
  end
end
