inherited A068FStampa: TA068FStampa
  Left = 22
  Top = 65
  Caption = 'A068FStampa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    inherited Titolo: TQRBand
      Height = 71
      Size.Values = (
        187.854166666666700000
        1899.708333333333000000)
      ExplicitHeight = 71
      inherited LEnte: TQRLabel
        Size.Values = (
          50.270833333333330000
          881.062500000000000000
          0.000000000000000000
          134.937500000000000000)
        FontSize = 12
      end
      inherited qlblSysData: TQRSysData
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          0.000000000000000000
          113.770833333333300000)
        FontSize = 8
      end
      inherited LTitolo: TQRLabel
        Top = 46
        Size.Values = (
          50.270833333333330000
          873.125000000000000000
          121.708333333333300000
          150.812500000000000000)
        FontSize = 10
        ExplicitTop = 46
      end
      inherited qlblSysPagina: TQRSysData
        Size.Values = (
          39.687500000000000000
          1767.416666666667000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
      end
      object LTitolo1: TQRLabel
        Left = 330
        Top = 24
        Width = 57
        Height = 19
        Size.Values = (
          50.270833333333330000
          873.125000000000000000
          63.500000000000000000
          150.812500000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = True
        Caption = 'LTitolo'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object QRGroup1: TQRGroup
      Left = 38
      Top = 129
      Width = 718
      Height = 0
      AlignToBottom = False
      BeforePrint = QRGroup1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'C700SelAnagrafe.T430SQUADRA'
      FooterBand = QRBand1
      Master = QRep
      ReprintOnNewPage = False
    end
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 109
      Width = 718
      Height = 20
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRLabel1: TQRLabel
        Left = 4
        Top = 2
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          5.291666666666667000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'SQUADRA'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 152
        Top = 2
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          402.166666666666700000
          5.291666666666667000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'MATTINO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 264
        Top = 2
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          698.500000000000000000
          5.291666666666667000
          187.854166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'POMERIGGIO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 376
        Top = 2
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          994.833333333333300000
          5.291666666666667000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'NOTTE'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel5: TQRLabel
        Left = 492
        Top = 2
        Width = 57
        Height = 15
        Size.Values = (
          39.687500000000000000
          1301.750000000000000000
          5.291666666666667000
          150.812500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'SM.NOTTE'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel6: TQRLabel
        Left = 604
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1598.083333333333000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'RIPOSO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object DetailBand1: TQRBand
      Left = 38
      Top = 129
      Width = 718
      Height = 0
      AlignToBottom = False
      BeforePrint = DetailBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 129
      Width = 718
      Height = 36
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        95.250000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRDBText1: TQRDBText
        Left = 4
        Top = 2
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          5.291666666666667000
          206.375000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'T430SQUADRA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBText2: TQRDBText
        Left = 4
        Top = 18
        Width = 145
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          47.625000000000000000
          383.645833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'T430D_SQUADRA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object Mattino: TQRMemo
        Left = 152
        Top = 2
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          402.166666666666700000
          5.291666666666667000
          298.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object Pomeriggio: TQRMemo
        Left = 264
        Top = 2
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          698.500000000000000000
          5.291666666666667000
          298.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object Notte: TQRMemo
        Left = 376
        Top = 2
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          994.833333333333300000
          5.291666666666667000
          298.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object Smonto: TQRMemo
        Left = 492
        Top = 2
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          1301.750000000000000000
          5.291666666666667000
          298.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object Riposo: TQRMemo
        Left = 604
        Top = 2
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          1598.083333333333000000
          5.291666666666667000
          298.979166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        Transparent = False
        WordWrap = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
    end
  end
end
