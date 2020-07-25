object Form1: TForm1
  Left = 280
  Top = 124
  BorderStyle = bsSingle
  Caption = 'QPixelsDemo'
  ClientHeight = 487
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 430
    Top = 115
    Width = 231
    Height = 276
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 430
    Top = 5
    Width = 231
    Height = 107
    Caption = 'Test Mode'
    TabOrder = 1
    object Label1: TLabel
      Left = 22
      Top = 16
      Width = 54
      Height = 13
      Caption = 'PixelFormat'
    end
    object RunTest: TButton
      Left = 7
      Top = 76
      Width = 85
      Height = 25
      Caption = 'RunTest'
      TabOrder = 0
      OnClick = RunTestClick
    end
    object rgGetSet: TRadioGroup
      Left = 134
      Top = 10
      Width = 85
      Height = 61
      ItemIndex = 0
      Items.Strings = (
        'Get'
        'Set')
      TabOrder = 1
    end
    object cbBPP: TComboBox
      Left = 6
      Top = 31
      Width = 85
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbBPPChange
      Items.Strings = (
        '1'
        '4'
        '8'
        '15'
        '16'
        '24'
        '32')
    end
    object chIndex: TCheckBox
      Left = 7
      Top = 56
      Width = 82
      Height = 17
      Caption = 'PaletteIndex'
      TabOrder = 3
    end
    object TestAll: TButton
      Left = 135
      Top = 76
      Width = 85
      Height = 25
      Caption = 'Test All Modes'
      TabOrder = 4
      OnClick = TestAllClick
    end
  end
  object rgEffects: TRadioGroup
    Left = 430
    Top = 395
    Width = 141
    Height = 66
    Caption = 'Choose Effect'
    Columns = 2
    Items.Strings = (
      'Blur'
      'Fly'
      'Blend'
      'Dragging'
      'Rubber')
    TabOrder = 2
    OnClick = rgEffectsClick
  end
  object LoadPic: TBitBtn
    Left = 580
    Top = 395
    Width = 81
    Height = 42
    Caption = 'LoadPicture'
    TabOrder = 3
    OnClick = LoadPicClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
      BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
      BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
      BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
      BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
      EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
      EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
      EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
      EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
    Layout = blGlyphTop
    NumGlyphs = 2
  end
  object chKeep: TCheckBox
    Left = 430
    Top = 465
    Width = 91
    Height = 17
    Caption = 'KeepChanges'
    TabOrder = 4
  end
  object btReset: TButton
    Left = 525
    Top = 465
    Width = 46
    Height = 18
    Caption = 'Reset'
    TabOrder = 5
    OnClick = btResetClick
  end
  object BitBtn1: TBitBtn
    Left = 580
    Top = 445
    Width = 81
    Height = 39
    Caption = 'SavePicture'
    TabOrder = 6
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    Layout = blGlyphTop
    NumGlyphs = 2
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = '.jpg'
    Filter = 'JPEG Image File (*.jpg)|*.jpg|Bitmaps (*.bmp)|*.bmp'
    Left = 395
    Top = 410
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = '.bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 395
    Top = 450
  end
end
