object Form1: TForm1
  Left = 646
  Top = 229
  BorderStyle = bsSingle
  Caption = 'BOT Fighter v3.6 Pro Version for FreeRO   Hudrolax'
  ClientHeight = 470
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000000200000000
    0000000000000000000000000000000000000000800000800000008080008000
    00008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000FFFFFFFF0000000000000000000000FFF000000FFF00000000000000
    0000FF000000000000FF000000000000000FF0AA200000AA000FF00000000000
    00FF0AAA200000AAAA00FF00000000000FF0AAAA000000AAAAA00FF000000000
    0F02AAAA000000AAAAA000F000000000F02AAAAA000000AAAAA0000F00000000
    F0AAAAA0000000AAAAA2000F0000000FF00AAAA0000000AAAAA2000FF000000F
    00000000000000002AAA0000F000000F0000002A200AAAA200200000F000000F
    000000AAA02AAAAA00000000F000000F000000000000000000000000F000000F
    0002AAAAAAAAAAA222200000F000000F00000AAAAAAAAAAAAAAA0000F000000F
    F00000222222222AAAAAA20FF0000000F0000000222000000AA2000F00000000
    F0000000AAAAAAA22200000F000000000F000000AAAAAAAAA20000F000000000
    0FF00000AAAAAAAA20000FF00000000000FF00002AAAAAAA0000FF0000000000
    000FF000220000A2000FF000000000000000FF000000000000FF000000000000
    000000FFF000000FFF0000000000000000000000FFFFFFFF0000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFFFFFFFFFFFFF00FFFFFC003FFFF00
    00FFFE00007FFC00003FF800001FF000000FF000000FE0000007E0000007C000
    0003C0000003C0000003C0000003C0000003C0000003C0000003C0000003E000
    0007E0000007F000000FF000000FF800001FFC00003FFE00007FFF0000FFFFC0
    03FFFFF00FFFFFFFFFFFFFFFFFFF280000001000000020000000010004000000
    0000800000000000000000000000000000000000000000000000000080000080
    000000808000800000008000800080800000C0C0C000808080000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    00000000000000000FFFFF000000000FFAAAA0FF000000F0A200AAA0F00000F0
    A000AAA0F0000F0AA000AAA00F000F02000002A00F000F00AA2AA0000F000F0A
    AAAAA2200F000F0022222AAA0F0000F00AAAA200F00000F00AAAA200F000000F
    F200A0FF000000000FFFFF0000000000000000000000FFFF7200F83F6C00E00F
    6200C00770008003FFFF8003FFFF000109040001650000015C0000016E000001
    73008003610080036C00C0076200E00F7000F83FB806}
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 14
    Height = 16
    Caption = 'X:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object xpos: TLabel
    Left = 24
    Top = 8
    Width = 22
    Height = 13
    Caption = 'xpos'
  end
  object Label3: TLabel
    Left = 48
    Top = 8
    Width = 15
    Height = 16
    Caption = 'Y:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ypos: TLabel
    Left = 64
    Top = 8
    Width = 22
    Height = 13
    Caption = 'ypos'
  end
  object Label2: TLabel
    Left = 88
    Top = 8
    Width = 88
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1094#1074#1077#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object colr: TLabel
    Left = 176
    Top = 8
    Width = 10
    Height = 13
    Caption = 'R'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object colg: TLabel
    Left = 208
    Top = 8
    Width = 10
    Height = 13
    Caption = 'G'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object colb: TLabel
    Left = 240
    Top = 8
    Width = 9
    Height = 13
    Caption = 'B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 88
    Top = 32
    Width = 84
    Height = 16
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object swith: TLabel
    Left = 176
    Top = 32
    Width = 76
    Height = 16
    Caption = #1042#1099#1082#1083#1102#1095#1077#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image1: TImage
    Left = 8
    Top = 44
    Width = 20
    Height = 20
  end
  object enemy: TImage
    Left = 8
    Top = 72
    Width = 20
    Height = 20
    Picture.Data = {
      07544269746D617076060000424D760600000000000036000000280000001400
      000014000000010020000000000040060000C40E0000C40E0000000000000000
      000086415200A45C7100FCC1CF008F4D4500D46E7F00DA6A7D00FFD0DA00FFCF
      D700B8566100BA577200FFC6D600C9657D00C85E7600FFCAD900FFC0D1008F39
      3B00FFAAB600E6959E00D1737600F9C5C400683739009B5A7100FFDAE700894E
      4500C2627900BA547800FFE4EF00C0C0DC005D3C5D004C305100675873005833
      5D006D476F0051425E00FFC6D800853E4600BC7D8A009F4B6700B8616F00321B
      1D0097737A008B566C00FFE0EF0078464400AC587C00532E5800B5C1DD00BEC8
      E6005C3B5B0073426F008D5E8E00331F3200AAA4BE00B6B8D400F0B3C9003C1E
      2C0019181800231F1C001C1512007C5B4600BCA5B40076585F00E9D9ED002A28
      330058335D0078467600BDC9E600BBC7E4005536540071406B0072597500BEC7
      E500C0CBE9005F4C6B008F4669002A121900998F8800EBD5C400BB9B8800A57F
      6800DACEE80069525B00DACFE9002A28330072427200593A5A00C1CDEB00BAC6
      E2006E51700072416C00BFCBE800C1CDEB00513350004A2748008893A8003425
      250083675500D2BFB500F5F2F000EFDACD00856E8800B6B2C900CDCCE6002A29
      330072417100714A7200B5B3CE00BDC9E600AC86B1008B5B88007C587F00A7B2
      CC006E7284004C4B5100493F3800A88F7E00E5C4AC00C09B8300D2BFB300F7F3
      EF006A557000C4C9E300B5C4E000302B37008E5B8C0090629100796283006061
      7300554357008F648F00512F4E003E283400554840009F887800E4C3AB00E4C3
      AB00EACFBB00E8C8B300806452009389820054365D00BBC7E300B5C5E1003834
      4100231923009A6B9B00C3CFED00B0BBD60053415600432C3B00615349009983
      7300E4C3AC00E4C3AC00E4C3AC00EAD0BC00F7E9DF00A8988D00312134002C18
      3900563B640049335C0047345D005D3761008B5C8B0085588600563C56004C35
      47006D5E5300967F7000E5C4AC00E5C4AC00E5C4AC00EACFBC00EFDACB00F7EA
      E000AFA8A50043334C0083629800A47BAB00523C66004735600045325D004F2F
      5600311B2F003D2739007C695D00957F7100E5C3AC00E5C3AC00E6C4AD00EACF
      BB00F2DECF00F7E9DE00FCF4ED00ACA6A1004F3E4E008B689400C8ADDE00C8AA
      DB004A3562004F386300231526002819280086726400957F7000E5C3AC00E5C4
      AC00E6C4AD00E6C4AD00EBD0BC00F7E9DE00FDF4ED00FDF4ED00AAA4A0004F3D
      4D007B557D009B73A200AC8ABA00B18CBD0048305E004B2F590005040500A8A6
      A600F3E7DF00F4E8E000F4E8E000F4E8E000F4E9E100F4E7DD00F9EADF00FEF5
      EE00FDF4ED00A9A39F004936460070486F0088578800885788008C5C8C009667
      96004C2E59006D46720008070800FCFBFC00FCFBFC00FDFCFD00FDFCFD00FDFC
      FD00FDFCFD00FDF9F800FDF4ED00FDF5EE00A9A39F003B27360054284C006B39
      610076437000804B7D00663F6A0057386000704B75009E72A10008070800FDFC
      FC00FCFBFC00FCFBFC00FCFBFC00FDFCFD00FDFCFD00FDF9F800FDF4ED00ABA6
      A1004836460055284D006F3F68007A4A72007D4B7700643964004C3158004F38
      6300A87EAC00A478A60008070800FDFCFD00FDFCFD00FDFCFD00FDFBFC00FCFB
      FC00FCFBFC00FCF9F700AFA8A400433041007248700075457100865685008455
      8300804F7D004D2D54004B335F004E366000AA7DAC009A6B9B0008070800FDFC
      FD00FDFCFD00FDFCFD00FDFCFD00FCFBFC00FBFBFC00B2B0B100342231007B4E
      7B0070406B0074426F006C3E6C004F2E5400502D5400482C5600503C67004838
      6200A474A5009E6F9F0008070800FDFCFD00FDFCFD00FDFCFD00FDFCFD00FCFB
      FC00B8B7B800211622006B3C660078457400683B64004F2D55004A2C54005139
      650049335E004F3B66004A3862004F3B6600A071A1009B6C9C00030203000A09
      0A000A090A000A090A0009080900090809001D16230047365D00482548004F2D
      5500492C5300412C570044335D004F39630047325C004B3B64004E3A64004E38
      6300A476A500986A99009A6B9B009B6D9D008E5E8F006038640052386200583E
      69005A3E6900533F670048345E004B3C650046305A00432F5A00513A63005841
      6C004C355F004B345E00553F690056416900B388B700AC7FAF00A072A1009264
      93008758880056335D00523B6500563B66005E426E005F476F00513A6400523E
      6900583D67004E3760005E466E00634B72004F386100482F5A00513B65004C38
      6300}
  end
  object loot: TImage
    Left = 8
    Top = 96
    Width = 20
    Height = 20
    Picture.Data = {
      07544269746D617076060000424D760600000000000036000000280000001400
      000014000000010020000000000040060000C40E0000C40E0000000000000000
      000058466E005C4770005A4772005645700054416D0056436D005C4973005C47
      7400594A7400523D690057446D0067557F005E4B750056436D00604F77004E3D
      660056446E0058446E0059436D0053416C0054406A005D4A74005D4974005A49
      740056447100574A7400644C7700604C77005E4B740053416A00513F69005C4A
      750056446E004D3C6400624F76005B49720056446D0056426D0056426B005944
      6D0051416B00564872005C4B7400564874005A48740061507B006A517B00664E
      7700624E77005E4D7600614E770064527B004E3D66005D487400604E77006047
      70005C4D77005B47700054436D0056436D005C4B7400574C75005C4B74005647
      74005D49740069517D006B537C00644E790063446E00604A74005C487300604C
      760058476F00634F790057426D0058446D005D477200553B6400624A74004E3B
      6500574773005C4974005B4771005A4670005D4973005F4A7400694F7900604D
      7700624C78005B477100614C7600634F7900564166005F4D77005E4169005D46
      700056416B00513C67004E38640069517E0055446F0051416B0058447100614B
      76005C4771005D497300634D790063507A006A4F79006A557A0057416D00624C
      75005E4C74005E4974006F5C84006B537C005E49730056416C0057446F00624F
      78005746700054446E00574770005C4B74005B4770005A4773006B537D006A55
      7E005946700056436D005A4670005D416A005A4673005C436D00624D77006B52
      7B0060416B0054446F0056406B00533D660054426C005C47710054446F005442
      6D005C446E005D466F005F4C740020192500060404000705060007060600493A
      5D0057446E00514068005A497400543F680058416B00674D77005D4671005643
      6E0054446E005845710050426A005642690057446D00251B2A000C090800805E
      4900AF806100D9B49A00E4C4AC00322B2600100E0D00443458004F3E68004F42
      6A0059416D005F4B7400594874004F3B66004D3D63004A3A630029203200140E
      0C00150E0C0075533E00B1836500E7D3C600EAD0BD00E4C4AC00E4C3AC00E4C3
      AC00E4C4AC002D262200423457004F40690052446F004F416C0056426D004F3C
      6600241F1C00241F1C0071554400B4856700B4856700AE7E5F00E1CBBC00FCF4
      EE00EAD0BD00E4C3AC00E4C3AC00E4C3AC00E4C3AC00E4C3AC000E0C0B004D3F
      67004D3D66004E3C66005946700055416B00E4C4AC00E4C3AC00E4C3AC00E4C3
      AC00E4C3AB00C0947800E1CCBE00FCF9F800EAD2C000E4C3AC00E4C3AC00E4C3
      AC00E4C3AC00E4C3AC0038302B003E2D4F004E3C65004B3861004E3C66005B49
      7200EACFBB00EACFBB00EACFBB00EACFBB00E6C8B100C0947700DDC8BA00F9F7
      F600EEDCCF00E5C6B100E4C3AC00E4C3AC00E4C3AC00E4C3AC00E4C3AC000605
      05004B3962005A4771005B487200604B7500FBF3EC00FCF4EC00FDF5EE00FEF5
      EE00F3E0D100CDA78D00CBA38800EBD8CC00FAF7F600EEDDD000E5C6B100E4C3
      AC00E4C3AC00E4C3AC00E4C3AC0006050500554A720068537D004A3962005F4B
      7400FDF4ED00FEF5EE00FEF5EE00FDF4ED00FCF3EC00F1DED000CCA78D00CBA3
      8700F1E5E000FCFBFC00EFDDD100ECD6C600ECD3C100ECD3C100E4C4AD000705
      0500554674004A3761004E3A640055436E00FEF5EE00FEF5EF00FDF4ED00FCF3
      EC00FBF3EB00FBF3EC00F2DFD100D3B49F00E8D6CA00F3E6DE00FAF5F100FCF8
      F600FCF4ED00F4E3D700968173001F18280045335D00493960004C3966005F49
      7400FDF5EE00FDF5EE00FCF4EC00FBF3EB00FBF3EC00FCF3EC00FCF3EC00FCF3
      EC00F1DECF00EED7C600F9EEE400F4E3D6009F99940088756900261F2F004535
      5F004534620049356100574B76005B457000FCF4ED00FCF4EC00FBF3EB00FBF3
      EC00FCF3EC00FCF3EC00FCF3EC00FCF3EC00FBF3EC00FBF3EC00FBF3EC00D2AF
      96001A151200231B2D004F416800483561004536600047386100584471005242
      6E00FCF4EC00FCF3EC00FBF3EB00FBF3EC00FCF3EC00FCF3EC00FCF3EC00FCF3
      EC00FCF3EC00FBF3EC00F2E0D2006D564700272030004B406400503F69004738
      6100453660004D3B640057446D0058446E00FCF5F000FBF7F400FBF5F000FCF4
      ED00FCF4ED00FCF4EC00FCF3EC00FCF3EC00FCF3EC00FBF3EC0085776D00110F
      0E0045365B0058466E00503F690048355D0045355E004E3A6300604C75005843
      6E00}
  end
  object Label12: TLabel
    Left = 64
    Top = 72
    Width = 80
    Height = 13
    Caption = #1057#1093#1086#1076#1089#1090#1074#1072' '#1085#1077#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 64
    Top = 96
    Width = 80
    Height = 13
    Caption = #1057#1093#1086#1076#1089#1090#1074#1072' '#1085#1077#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 168
    Top = 48
    Width = 169
    Height = 321
    Shape = bsFrame
  end
  object Image2: TImage
    Left = 40
    Top = 128
    Width = 56
    Height = 3
  end
  object Label17: TLabel
    Left = 40
    Top = 240
    Width = 22
    Height = 13
    Caption = '240'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label22: TLabel
    Left = 48
    Top = 304
    Width = 22
    Height = 13
    Caption = '100'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 0
    Top = 401
    Width = 177
    Height = 7
    Shape = bsBottomLine
  end
  object Label5: TLabel
    Left = 48
    Top = 328
    Width = 15
    Height = 13
    Caption = '30'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 56
    Top = 280
    Width = 15
    Height = 13
    Caption = '20'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 288
    Top = 248
    Width = 40
    Height = 13
    Caption = 'F7 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 280
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Start'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 392
    Width = 19
    Height = 13
    Caption = #1061#1080#1083
  end
  object Label11: TLabel
    Left = 72
    Top = 392
    Width = 18
    Height = 13
    Caption = #1088#1072#1079
  end
  object StaticText1: TStaticText
    Left = 32
    Top = 48
    Width = 125
    Height = 17
    Caption = #1050#1072#1088#1090#1080#1085#1082#1072' '#1087#1086#1076' '#1082#1091#1088#1089#1086#1088#1086#1084
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 32
    Top = 72
    Width = 28
    Height = 17
    Caption = #1042#1088#1072#1075
    TabOrder = 1
  end
  object StaticText3: TStaticText
    Left = 32
    Top = 96
    Width = 22
    Height = 17
    Caption = #1051#1091#1090
    TabOrder = 2
  end
  object StaticText4: TStaticText
    Left = 8
    Top = 120
    Width = 29
    Height = 20
    Caption = 'HP:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object StaticText6: TStaticText
    Left = 176
    Top = 56
    Width = 72
    Height = 17
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object flagloot: TCheckBox
    Left = 176
    Top = 80
    Width = 97
    Height = 17
    Caption = #1055#1086#1076#1073#1080#1088#1072#1090#1100' '#1083#1091#1090
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object flagmove: TCheckBox
    Left = 176
    Top = 104
    Width = 97
    Height = 17
    Caption = #1070#1079#1072#1090#1100' '#1074#1080#1085#1075#1080
    TabOrder = 6
    OnClick = flagmoveClick
  end
  object flagskill: TCheckBox
    Left = 176
    Top = 152
    Width = 105
    Height = 17
    Caption = #1070#1079#1072#1090#1100' '#1089#1082#1080#1083#1083' F7'
    TabOrder = 7
  end
  object flagfly: TCheckBox
    Left = 176
    Top = 176
    Width = 81
    Height = 17
    Caption = #1059#1073#1077#1075#1072#1085#1080#1077
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object flaghp: TCheckBox
    Left = 176
    Top = 200
    Width = 81
    Height = 17
    Caption = 'HP '#1056#1077#1075#1077#1085
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object StaticText7: TStaticText
    Left = 8
    Top = 160
    Width = 56
    Height = 17
    Caption = #1062#1077#1085#1090#1088' X:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object StaticText8: TStaticText
    Left = 8
    Top = 184
    Width = 56
    Height = 17
    Caption = #1062#1077#1085#1090#1088' Y:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object xcenter: TEdit
    Left = 64
    Top = 160
    Width = 49
    Height = 21
    TabOrder = 12
    Text = '320'
  end
  object ycenter: TEdit
    Left = 64
    Top = 184
    Width = 49
    Height = 21
    TabOrder = 13
    Text = '240'
  end
  object StaticText9: TStaticText
    Left = 8
    Top = 208
    Width = 50
    Height = 17
    Caption = #1056#1072#1076#1080#1091#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object radius: TEdit
    Left = 64
    Top = 208
    Width = 49
    Height = 21
    TabOrder = 15
    Text = '70'
  end
  object StaticText10: TStaticText
    Left = 0
    Top = 240
    Width = 33
    Height = 17
    Caption = 'Wing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
  end
  object StaticText11: TStaticText
    Left = 0
    Top = 304
    Width = 43
    Height = 17
    Caption = 'F7 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
  end
  object StaticText12: TStaticText
    Left = 72
    Top = 240
    Width = 49
    Height = 17
    Caption = #1042#1088#1077#1084#1103'(c)'
    TabOrder = 18
  end
  object StaticText13: TStaticText
    Left = 80
    Top = 304
    Width = 49
    Height = 17
    Caption = #1042#1088#1077#1084#1103'('#1089')'
    TabOrder = 19
  end
  object timewing: TEdit
    Left = 128
    Top = 240
    Width = 41
    Height = 21
    TabOrder = 20
    Text = '240'
  end
  object timeskill: TEdit
    Left = 128
    Top = 304
    Width = 41
    Height = 21
    TabOrder = 21
    Text = '100'
  end
  object Button1: TButton
    Left = 152
    Top = 440
    Width = 81
    Height = 25
    Caption = 'Start/Stop'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 440
    Width = 49
    Height = 25
    Caption = 'Exit'
    TabOrder = 23
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 80
    Top = 440
    Width = 57
    Height = 25
    Caption = 'Help'
    TabOrder = 24
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 0
    Top = 440
    Width = 73
    Height = 25
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    Enabled = False
    TabOrder = 25
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 232
    Top = 376
    Width = 81
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 26
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 232
    Top = 408
    Width = 81
    Height = 25
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    TabOrder = 27
    OnClick = Button6Click
  end
  object flagattack: TCheckBox
    Left = 0
    Top = 408
    Width = 129
    Height = 17
    Caption = #1053#1072#1095#1072#1090#1100' '#1086#1093#1086#1090#1091' (Alt+F1)'
    TabOrder = 28
  end
  object flagawak: TCheckBox
    Left = 176
    Top = 224
    Width = 105
    Height = 17
    Caption = #1050#1091#1096#1072#1090#1100' '#1040#1074#1072#1082#1080
    TabOrder = 29
  end
  object dfdf: TStaticText
    Left = 0
    Top = 328
    Width = 33
    Height = 17
    Caption = #1040#1074#1072#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 30
  end
  object StaticText14: TStaticText
    Left = 80
    Top = 328
    Width = 51
    Height = 17
    Caption = #1042#1088#1077#1084#1103'('#1084')'
    TabOrder = 31
  end
  object Edit1: TEdit
    Left = 128
    Top = 328
    Width = 41
    Height = 21
    TabOrder = 32
    Text = '30'
  end
  object Date1: TDateTimePicker
    Left = 248
    Top = 56
    Width = 65
    Height = 17
    Date = 38853.645486817130000000
    Time = 38853.645486817130000000
    TabOrder = 33
    Visible = False
  end
  object flagteleport: TCheckBox
    Left = 176
    Top = 128
    Width = 97
    Height = 17
    Caption = #1070#1079#1072#1090#1100' Teleport'
    Checked = True
    State = cbChecked
    TabOrder = 34
    OnClick = flagteleportClick
  end
  object StaticText15: TStaticText
    Left = 0
    Top = 280
    Width = 51
    Height = 17
    Caption = 'Teleport'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 35
  end
  object StaticText16: TStaticText
    Left = 80
    Top = 280
    Width = 49
    Height = 17
    Caption = #1042#1088#1077#1084#1103'('#1089')'
    TabOrder = 36
  end
  object timeteleport: TEdit
    Left = 128
    Top = 280
    Width = 41
    Height = 21
    TabOrder = 37
    Text = '20'
  end
  object StaticText17: TStaticText
    Left = 288
    Top = 104
    Width = 43
    Height = 17
    Caption = 'F6 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 38
  end
  object StaticText18: TStaticText
    Left = 288
    Top = 200
    Width = 43
    Height = 17
    Caption = 'F4 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 39
  end
  object StaticText19: TStaticText
    Left = 288
    Top = 128
    Width = 43
    Height = 17
    Caption = 'F6 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 40
  end
  object StaticText20: TStaticText
    Left = 288
    Top = 152
    Width = 43
    Height = 17
    Caption = 'F5 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 41
  end
  object StaticText21: TStaticText
    Left = 288
    Top = 224
    Width = 43
    Height = 17
    Caption = 'F8 Key'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 42
  end
  object Edit3: TEdit
    Left = 144
    Top = 368
    Width = 25
    Height = 21
    TabOrder = 43
    Text = '3'
  end
  object StaticText22: TStaticText
    Left = 176
    Top = 368
    Width = 39
    Height = 19
    Caption = #1089#1077#1082#1091#1085#1076'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 44
  end
  object StaticText24: TStaticText
    Left = 0
    Top = 368
    Width = 137
    Height = 19
    Caption = #1059#1073#1077#1075#1072#1085#1080#1077' '#1095#1077#1088#1077#1079' 3 '#1091#1076#1072#1088#1072' '#1079#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 45
  end
  object moveflag: TCheckBox
    Left = 176
    Top = 296
    Width = 129
    Height = 17
    Caption = #1041#1086#1083#1100#1096#1072#1103' '#1087#1088#1086#1073#1077#1078#1082#1072
    TabOrder = 46
    OnMouseUp = moveflagMouseUp
  end
  object moveflag2: TCheckBox
    Left = 176
    Top = 272
    Width = 113
    Height = 17
    Caption = #1052#1072#1083#1072#1103' '#1087#1088#1086#1073#1077#1078#1082#1072
    TabOrder = 47
    OnMouseUp = moveflag2MouseUp
  end
  object CheckBox1: TCheckBox
    Left = 176
    Top = 320
    Width = 137
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1095#1072#1090
    TabOrder = 48
  end
  object flagheal: TCheckBox
    Left = 176
    Top = 248
    Width = 105
    Height = 17
    Caption = #1070#1079#1072#1090#1100' '#1093#1080#1083
    Checked = True
    State = cbChecked
    TabOrder = 49
  end
  object Edit2: TEdit
    Left = 0
    Top = 256
    Width = 41
    Height = 21
    TabOrder = 50
    Text = '20'
  end
  object Edit4: TEdit
    Left = 32
    Top = 384
    Width = 33
    Height = 21
    TabOrder = 51
    Text = '20'
  end
  object CheckBox2: TCheckBox
    Left = 176
    Top = 344
    Width = 105
    Height = 17
    Caption = #1056#1077#1078#1080#1084' '#1090#1088#1091#1089#1072
    TabOrder = 52
  end
  object regtimer: TTimer
    Enabled = False
    Interval = 3000
    Left = 112
    Top = 112
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = Timer1Timer
    Left = 120
    Top = 128
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 240000
    OnTimer = Timer2Timer
    Left = 120
    Top = 144
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 120
    Top = 160
  end
  object Timer4: TTimer
    Enabled = False
    Interval = 1800000
    OnTimer = Timer4Timer
    Left = 120
    Top = 176
  end
  object Timer5: TTimer
    Interval = 60000
    OnTimer = Timer5Timer
    Left = 120
    Top = 192
  end
  object actiontimer: TTimer
    Enabled = False
    OnTimer = actiontimerTimer
    Left = 120
    Top = 208
  end
  object Timer6: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = Timer6Timer
    Left = 152
    Top = 120
  end
  object chattimer: TTimer
    Interval = 90000
    OnTimer = chattimerTimer
    Left = 152
    Top = 96
  end
  object Timer7: TTimer
    Enabled = False
    Interval = 100000
    OnTimer = Timer7Timer
    Left = 152
    Top = 80
  end
  object stoptimer: TTimer
    Interval = 5000
    OnTimer = stoptimerTimer
    Left = 152
    Top = 64
  end
  object logouttimer: TTimer
    OnTimer = logouttimerTimer
    Left = 152
    Top = 144
  end
  object wakeuptimer: TTimer
    Enabled = False
    Interval = 600000
    OnTimer = wakeuptimerTimer
    Left = 152
    Top = 176
  end
end
