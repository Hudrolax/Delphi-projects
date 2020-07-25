object Form1: TForm1
  Left = 243
  Top = 220
  Width = 403
  Height = 248
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
  object Button1: TButton
    Left = 16
    Top = 160
    Width = 89
    Height = 41
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object zp1: TZipForge
    ExtractCorruptedFiles = False
    CompressionLevel = clMax
    CompressionMode = 9
    CurrentVersion = '5.01 '
    SpanningMode = smNone
    SpanningOptions.AdvancedNaming = False
    SpanningOptions.VolumeSize = vsAutoDetect
    Options.FlushBuffers = True
    Options.OEMFileNames = True
    InMemory = False
    Zip64Mode = zmDisabled
    UnicodeFilenames = True
    EncryptionMethod = caPkzipClassic
    Left = 8
    Top = 16
  end
end
