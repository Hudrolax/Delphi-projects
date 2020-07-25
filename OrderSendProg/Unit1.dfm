object Form1: TForm1
  Left = 318
  Top = 237
  Width = 380
  Height = 206
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 16
    Width = 22
    Height = 16
    Caption = 'Lot'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 40
    Width = 48
    Height = 13
    Caption = 'SellLimit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 8
    Top = 56
    Width = 64
    Height = 13
    Caption = 'Take Profit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 80
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '0.1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 32
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit3: TEdit
    Left = 80
    Top = 56
    Width = 65
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object btn1: TButton
    Left = 24
    Top = 128
    Width = 113
    Height = 33
    Caption = 'Buy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 160
    Top = 128
    Width = 113
    Height = 33
    Caption = 'Sell'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn2Click
  end
  object Edit4: TEdit
    Left = 17
    Top = 80
    Width = 344
    Height = 25
    TabOrder = 5
    Text = 'C:\Program Files (x86)\Alpari NZ MT4\tester\files\1.txt'
  end
end
