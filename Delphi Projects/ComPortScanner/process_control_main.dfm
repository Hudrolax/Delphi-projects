object Form1: TForm1
  Left = 216
  Top = 122
  Width = 271
  Height = 143
  Caption = 'Scaner Process Controller'
  Color = clBtnFace
  Constraints.MaxHeight = 143
  Constraints.MaxWidth = 271
  Constraints.MinHeight = 143
  Constraints.MinWidth = 271
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
  object Button1: TButton
    Left = 72
    Top = 32
    Width = 113
    Height = 33
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 168
    Top = 80
  end
  object Timer2: TTimer
    Interval = 50
    OnTimer = Timer2Timer
    Left = 112
    Top = 88
  end
end
