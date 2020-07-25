object Form1: TForm1
  Left = 314
  Top = 227
  Width = 403
  Height = 140
  Caption = 'Form1'
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
  object CheckBox1: TCheckBox
    Left = 8
    Top = 88
    Width = 113
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 0
  end
  object timer1: TTimer
    Enabled = False
    Interval = 20
    OnTimer = timer1Timer
    Left = 224
    Top = 48
  end
end
