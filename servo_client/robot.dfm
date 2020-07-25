object Form1: TForm1
  Left = 455
  Top = 250
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Robot'
  ClientHeight = 70
  ClientWidth = 136
  Color = clActiveCaption
  Constraints.MaxWidth = 152
  Constraints.MinWidth = 152
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCrem1ate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Button3: TButton
    Left = 80
    Top = 8
    Width = 49
    Height = 25
    Caption = 'Right'
    TabOrder = 0
    TabStop = False
    OnMouseDown = Button3MouseDown
    OnMouseUp = Button3MouseUp
  end
  object Button4: TButton
    Left = 8
    Top = 8
    Width = 49
    Height = 25
    Caption = 'Left'
    TabOrder = 1
    TabStop = False
    OnMouseDown = Button4MouseDown
    OnMouseUp = Button4MouseUp
  end
  object Button1: TButton
    Left = 40
    Top = 40
    Width = 57
    Height = 17
    Caption = #1041#1072#1079#1072
    TabOrder = 2
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Interval = 1200000
    OnTimer = Timer1Timer
    Left = 56
    Top = 16
  end
  object Timer2: TTimer
    Interval = 100
    OnTimer = Timer2Timer
    Top = 16
  end
  object baza: TIdTCPClient
    MaxLineAction = maException
    Host = '192.'
    Port = 27027
    Left = 40
    Top = 24
  end
end
