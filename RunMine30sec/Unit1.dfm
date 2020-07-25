object Form1: TForm1
  Left = 258
  Top = 181
  Width = 320
  Height = 170
  Caption = 'Run Min in 120 sec...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object tmr1: TTimer
    Interval = 120000
    OnTimer = tmr1Timer
    Left = 96
    Top = 32
  end
end
