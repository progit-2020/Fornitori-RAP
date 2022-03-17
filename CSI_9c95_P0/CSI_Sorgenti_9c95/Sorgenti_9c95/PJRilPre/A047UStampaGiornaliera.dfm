inherited A047FStampaGiornaliera: TA047FStampaGiornaliera
  Left = 31
  Top = 38
  Caption = 'A047FStampaGiornaliera'
  OnDestroy = FormDestroy
  ExplicitWidth = 1040
  ExplicitHeight = 752
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    Top = -4
    DataSet = A047FTimbMensaDtM1.TabellaStampa
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
    ExplicitTop = -4
    inherited Titolo: TQRBand
      Height = 65
      Size.Values = (
        171.979166666666700000
        1899.708333333333000000)
      BandType = rbPageHeader
      ExplicitHeight = 65
      inherited LEnte: TQRLabel
        Top = 19
        Size.Values = (
          50.270833333333330000
          881.062500000000000000
          50.270833333333330000
          134.937500000000000000)
        FontSize = 12
        ExplicitTop = 19
      end
      inherited qlblSysData: TQRSysData
        Width = 78
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          0.000000000000000000
          206.375000000000000000)
        Data = qrsDateTime
        FontSize = 8
        ExplicitWidth = 78
      end
      inherited LTitolo: TQRLabel
        Left = 0
        Top = 42
        Width = 718
        Size.Values = (
          50.270833333333330000
          0.000000000000000000
          111.125000000000000000
          1899.708333333333000000)
        AutoSize = False
        AutoStretch = True
        FontSize = 10
        ExplicitLeft = 0
        ExplicitTop = 42
        ExplicitWidth = 718
      end
      inherited qlblSysPagina: TQRSysData
        Size.Values = (
          39.687500000000000000
          1767.416666666667000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
      end
    end
    object QRGroup1: TQRGroup
      Left = 38
      Top = 127
      Width = 718
      Height = 20
      AfterPrint = QRGroup1AfterPrint
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'DATA'
      FooterBand = QRBand1
      Master = QRep
      ReprintOnNewPage = False
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 167
      Width = 718
      Height = 20
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object qlblData: TQRLabel
        Left = 4
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
      object qlblNumPasti: TQRLabel
        Left = 112
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333300000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
      object qlblTotPranziGG: TQRLabel
        Left = 192
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
      object qlblTotCeneGG: TQRLabel
        Left = 304
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          804.333333333333300000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
    object ChildBand1: TQRChildBand
      Left = 38
      Top = 187
      Width = 718
      Height = 16
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = QRBand1
      Size.Values = (
        42.333333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = QRBand1
      PrintOrder = cboAfterParent
      object QRMemo1: TQRMemo
        Left = 112
        Top = 0
        Width = 589
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333000000
          0.000000000000000000
          1558.395833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object qlblPranzoGG: TQRLabel
        Left = 16
        Top = 0
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          42.333333333333330000
          0.000000000000000000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pranzo:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object DetailBand1: TQRBand
      Left = 38
      Top = 147
      Width = 718
      Height = 20
      AlignToBottom = False
      BeforePrint = DetailBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object SummaryBand1: TQRBand
      Left = 38
      Top = 219
      Width = 718
      Height = 24
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = SummaryBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object qlblTotalePasti: TQRLabel
        Left = 4
        Top = 4
        Width = 106
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          10.583333333333330000
          280.458333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totale Accessi:'
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
      object qlblTotCene: TQRLabel
        Left = 304
        Top = 4
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          804.333333333333300000
          10.583333333333330000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
      object qlblTotPranzi: TQRLabel
        Left = 192
        Top = 4
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          10.583333333333330000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
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
    object ChildBand2: TQRChildBand
      Left = 38
      Top = 243
      Width = 718
      Height = 16
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = SummaryBand1
      Size.Values = (
        42.333333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = SummaryBand1
      PrintOrder = cboAfterParent
      object QRMemo2: TQRMemo
        Left = 112
        Top = 0
        Width = 589
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333000000
          0.000000000000000000
          1558.395833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object qlblPranzoTot: TQRLabel
        Left = 16
        Top = 0
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          42.333333333333330000
          0.000000000000000000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pranzo:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 103
      Width = 718
      Height = 24
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRLabel1: TQRLabel
        Left = 8
        Top = 4
        Width = 29
        Height = 15
        Size.Values = (
          39.687500000000000000
          21.166666666666670000
          10.583333333333330000
          76.729166666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 112
        Top = 4
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333300000
          10.583333333333330000
          132.291666666666700000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Accessi'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object qlblIntPranzo: TQRLabel
        Left = 192
        Top = 4
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          508.000000000000000000
          10.583333333333330000
          113.770833333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Pranzo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object qlblIntCena: TQRLabel
        Left = 304
        Top = 4
        Width = 29
        Height = 15
        Size.Values = (
          39.687500000000000000
          804.333333333333300000
          10.583333333333330000
          76.729166666666670000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cena'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object qbndCenaGG: TQRChildBand
      Left = 38
      Top = 203
      Width = 718
      Height = 16
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = ChildBand1
      PrintOrder = cboAfterParent
      object QRMemo3: TQRMemo
        Left = 112
        Top = 0
        Width = 589
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333000000
          0.000000000000000000
          1558.395833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object qlblCenaGG: TQRLabel
        Left = 16
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          42.333333333333330000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cena:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object qbndCenaTot: TQRChildBand
      Left = 38
      Top = 259
      Width = 718
      Height = 16
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = ChildBand2
      PrintOrder = cboAfterParent
      object QRMemo4: TQRMemo
        Left = 112
        Top = 0
        Width = 589
        Height = 15
        Size.Values = (
          39.687500000000000000
          296.333333333333000000
          0.000000000000000000
          1558.395833333330000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object qlblCenaTot: TQRLabel
        Left = 16
        Top = 0
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          42.333333333333330000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cena:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
  end
end
