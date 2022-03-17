inherited A066FStampa: TA066FStampa
  Caption = 'A066FStampa'
  ExplicitWidth = 1040
  ExplicitHeight = 752
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
      Height = 77
      Size.Values = (
        203.729166666666700000
        1899.708333333333000000)
      ExplicitHeight = 77
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
        Left = 334
        Top = 38
        Width = 50
        Size.Values = (
          50.270833333333330000
          883.708333333333300000
          100.541666666666700000
          132.291666666666700000)
        Font.Height = -11
        FontSize = 8
        ExplicitLeft = 334
        ExplicitTop = 38
        ExplicitWidth = 50
      end
      inherited qlblSysPagina: TQRSysData
        Size.Values = (
          39.687500000000000000
          1767.416666666667000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
      end
      object LTitolo2: TQRLabel
        Left = 334
        Top = 56
        Width = 50
        Height = 19
        Size.Values = (
          50.270833333333330000
          883.708333333333300000
          148.166666666666700000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = True
        Caption = 'LTitolo'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 126
        Top = 20
        Width = 465
        Height = 19
        Size.Values = (
          50.270833333333330000
          333.375000000000000000
          52.916666666666670000
          1230.312500000000000000)
        XLColumn = 0
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Tabella di monetizzazione delle ore fatte in straordinario'
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
      Top = 132
      Width = 718
      Height = 17
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRGroup1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        44.979166666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'QStampa.LIVELLO'
      Master = QRep
      ReprintOnNewPage = False
      object QRDBText1: TQRDBText
        Left = 112
        Top = 1
        Width = 125
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333300000
          2.645833333333333000
          330.729166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A066FValutaStrDtM1.QStampa
        DataField = 'LIVELLO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object LLivello: TQRLabel
        Left = 4
        Top = 1
        Width = 101
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          2.645833333333333000
          267.229166666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Livello'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object DLivello: TQRLabel
        Left = 244
        Top = 1
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          645.583333333333200000
          2.645833333333333000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Livello'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object DetailBand1: TQRBand
      Left = 38
      Top = 149
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
    object QRGroup2: TQRGroup
      Left = 38
      Top = 149
      Width = 718
      Height = 0
      AlignToBottom = False
      BeforePrint = QRGroup2BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        0.000000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'QStampa.LIVELLO + QStampa.DAL'
      FooterBand = QRBand1
      Master = QRep
      ReprintOnNewPage = False
    end
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 115
      Width = 718
      Height = 17
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        44.979166666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object LFasce: TQRLabel
        Left = 264
        Top = 1
        Width = 239
        Height = 15
        Size.Values = (
          39.687500000000000000
          698.500000000000000000
          2.645833333333333000
          632.354166666666800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '15             30               50'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel1: TQRLabel
        Left = 200
        Top = 1
        Width = 57
        Height = 15
        Size.Values = (
          39.687500000000000000
          529.166666666666700000
          2.645833333333333000
          150.812500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Fasce(%)'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 28
        Top = 1
        Width = 22
        Height = 15
        Size.Values = (
          39.687500000000000000
          74.083333333333320000
          2.645833333333333000
          58.208333333333320000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Dal'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 116
        Top = 1
        Width = 15
        Height = 15
        Size.Values = (
          39.687500000000000000
          306.916666666666700000
          2.645833333333333000
          39.687500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Al'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 149
      Width = 718
      Height = 17
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        44.979166666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRDBText2: TQRDBText
        Left = 28
        Top = 1
        Width = 81
        Height = 15
        Size.Values = (
          39.687500000000000000
          74.083333333333320000
          2.645833333333333000
          214.312500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A066FValutaStrDtM1.QStampa
        DataField = 'DAL'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBText3: TQRDBText
        Left = 116
        Top = 1
        Width = 81
        Height = 15
        Size.Values = (
          39.687500000000000000
          306.916666666666700000
          2.645833333333333000
          214.312500000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A066FValutaStrDtM1.QStampa
        DataField = 'AL'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object DFasce: TQRLabel
        Left = 264
        Top = 1
        Width = 239
        Height = 15
        Size.Values = (
          39.687500000000000000
          698.500000000000000000
          2.645833333333333000
          632.354166666666800000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '15             30               50'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
  end
end
