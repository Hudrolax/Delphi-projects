object Form1: TForm1
  Left = 228
  Top = 153
  Width = 607
  Height = 369
  Caption = 'Form1'
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
  object IdIcmpClient1: TIdIcmpClient
    Left = 24
    Top = 8
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 80
    Top = 8
  end
  object Timer2: TTimer
    Enabled = False
    Left = 136
    Top = 8
  end
end
