object A104FStampaMissioni: TA104FStampaMissioni
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  BeforePrint = QuickRepBeforePrint
  DataSet = A104FStampaMissioniDtM1.TabellaStampa
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE')
  Functions.DATA = (
    '0'
    '0'
    #39#39)
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Continuous = False
  Page.Values = (
    100.000000000000000000
    2970.000000000000000000
    100.000000000000000000
    2100.000000000000000000
    100.000000000000000000
    100.000000000000000000
    0.000000000000000000)
  PrinterSettings.Copies = 1
  PrinterSettings.OutputBin = Auto
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.UseStandardprinter = False
  PrinterSettings.UseCustomBinCode = False
  PrinterSettings.CustomBinCode = 0
  PrinterSettings.ExtendedDuplex = 0
  PrinterSettings.UseCustomPaperCode = False
  PrinterSettings.CustomPaperCode = 0
  PrinterSettings.PrintMetaFile = False
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PreviewWidth = 500
  PreviewHeight = 500
  PrevShowThumbs = False
  PrevShowSearch = False
  PrevInitialZoom = qrZoomOther
  PreviewDefaultSaveType = stPDF
  PreviewLeft = 0
  PreviewTop = 0
  object QRBand3: TQRBand
    Left = 38
    Top = 38
    Width = 718
    Height = 57
    AlignToBottom = False
    BeforePrint = QRBand3BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      150.812500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object QRSysData1: TQRSysData
      Left = 8
      Top = 1
      Width = 31
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        2.645833333333333000
        82.020833333333330000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      Data = qrsDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = ''
      Transparent = False
      ExportAs = exptText
      FontSize = 8
    end
    object QRSysData2: TQRSysData
      Left = 637
      Top = 1
      Width = 74
      Height = 17
      Size.Values = (
        44.979166666666670000
        1685.395833333333000000
        2.645833333333333000
        195.791666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      Color = clWhite
      Data = qrsPageNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = 'Pagina '
      Transparent = False
      ExportAs = exptText
      FontSize = 8
    end
    object QRLblAzienda: TQRLabel
      Left = 325
      Top = 10
      Width = 68
      Height = 17
      Size.Values = (
        44.979166666666670000
        859.895833333333300000
        26.458333333333330000
        179.916666666666700000)
      XLColumn = 0
      Alignment = taCenter
      AlignToBand = True
      Caption = 'MONDOEDP'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 9
    end
    object QRLblTitolo: TQRLabel
      Left = 248
      Top = 25
      Width = 221
      Height = 17
      Size.Values = (
        44.979166666666670000
        656.166666666666700000
        66.145833333333330000
        584.729166666666700000)
      XLColumn = 0
      Alignment = taCenter
      AlignToBand = True
      Caption = 'RIEPILOGO LIQUIDAZIONI MENSILI'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = QRLblTitoloPrint
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRLblCompetenza: TQRLabel
      Left = 272
      Top = 40
      Width = 174
      Height = 17
      Size.Values = (
        44.979166666666670000
        719.666666666666700000
        105.833333333333300000
        460.375000000000000000)
      XLColumn = 0
      Alignment = taCenter
      AlignToBand = True
      Caption = 'Mese/Anno scarico: 11/2001'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
  end
  object QRGroup4: TQRGroup
    Left = 38
    Top = 121
    Width = 718
    Height = 0
    AlignToBottom = False
    BeforePrint = QRGroup4BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    LinkBand = QRGroup1
    Size.Values = (
      0.000000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'TabellaStampa.MESESCARICO'
    Master = Owner
    ReprintOnNewPage = False
  end
  object QRGroup1: TQRGroup
    Left = 38
    Top = 121
    Width = 718
    Height = 1
    AlignToBottom = False
    BeforePrint = QRGroup1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      2.645833333333333000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'TabellaStampa.PROGRESSIVO'
    FooterBand = QRBand2
    Master = Owner
    ReprintOnNewPage = False
  end
  object QRGroup2: TQRGroup
    Left = 38
    Top = 122
    Width = 718
    Height = 68
    AfterPrint = QRGroup2AfterPrint
    AlignToBottom = False
    BeforePrint = QRGroup2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand2
    Size.Values = (
      179.916666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 
      'TabellaStampa.PROGRESSIVO +TabellaStampa.MESESCARICO + TabellaSt' +
      'ampa.MESECOMPETENZA + TabellaStampa.DATADA + TabellaStampa.ORADA'
    FooterBand = QRBand1
    Master = Owner
    ReprintOnNewPage = False
    object QRDBText14: TQRDBText
      Left = 42
      Top = 4
      Width = 45
      Height = 17
      Size.Values = (
        44.979166666666670000
        111.125000000000000000
        10.583333333333330000
        119.062500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DATADA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel12: TQRLabel
      Left = 8
      Top = 4
      Width = 33
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        10.583333333333330000
        87.312500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Inizio:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLabel13: TQRLabel
      Left = 8
      Top = 17
      Width = 38
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        44.979166666666670000
        100.541666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Da ora:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLabel14: TQRLabel
      Left = 104
      Top = 4
      Width = 27
      Height = 17
      Size.Values = (
        44.979166666666670000
        275.166666666666700000
        10.583333333333330000
        71.437500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Fine:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText15: TQRDBText
      Left = 134
      Top = 4
      Width = 38
      Height = 17
      Size.Values = (
        44.979166666666670000
        354.541666666666700000
        10.583333333333330000
        100.541666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DATAA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText15Print
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText16: TQRDBText
      Left = 48
      Top = 17
      Width = 39
      Height = 15
      Size.Values = (
        39.687500000000000000
        127.000000000000000000
        44.979166666666670000
        103.187500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ORADA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText16Print
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel15: TQRLabel
      Left = 104
      Top = 18
      Width = 33
      Height = 15
      Size.Values = (
        39.687500000000000000
        275.166666666666700000
        47.625000000000000000
        87.312500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'A ora:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText17: TQRDBText
      Left = 140
      Top = 18
      Width = 32
      Height = 15
      Size.Values = (
        39.687500000000000000
        370.416666666666700000
        47.625000000000000000
        84.666666666666670000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ORAA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText17Print
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel18: TQRLabel
      Left = 187
      Top = 4
      Width = 60
      Height = 17
      Size.Values = (
        44.979166666666670000
        494.770833333333300000
        10.583333333333330000
        158.750000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Tot. giorni:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText20: TQRDBText
      Left = 250
      Top = 4
      Width = 57
      Height = 17
      Size.Values = (
        44.979166666666670000
        661.458333333333300000
        10.583333333333330000
        150.812500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'TOTALEGG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText20Print
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel19: TQRLabel
      Left = 187
      Top = 18
      Width = 60
      Height = 15
      Size.Values = (
        39.687500000000000000
        494.770833333333300000
        47.625000000000000000
        158.750000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale ore:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText21: TQRDBText
      Left = 259
      Top = 18
      Width = 44
      Height = 15
      Size.Values = (
        39.687500000000000000
        685.270833333333300000
        47.625000000000000000
        116.416666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DURATA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      OnPrint = QRDBText21Print
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRShape8: TQRShape
      Left = 3
      Top = 1
      Width = 710
      Height = 1
      Size.Values = (
        2.645833333333333000
        7.937500000000000000
        2.645833333333333000
        1878.541666666667000000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape9: TQRShape
      Left = 3
      Top = 1
      Width = 1
      Height = 70
      Size.Values = (
        185.208333333333300000
        7.937500000000000000
        2.645833333333333000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape17: TQRShape
      Left = 712
      Top = 1
      Width = 1
      Height = 68
      Size.Values = (
        179.916666666666700000
        1883.833333333333000000
        2.645833333333333000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel2: TQRLabel
      Left = 318
      Top = 18
      Width = 54
      Height = 15
      Size.Values = (
        39.687500000000000000
        841.375000000000000000
        47.625000000000000000
        142.875000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Tipologia:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText27: TQRDBText
      Left = 371
      Top = 18
      Width = 266
      Height = 17
      Size.Values = (
        44.979166666666670000
        981.604166666666700000
        47.625000000000000000
        703.791666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DESCTIPOREGISTRAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel3: TQRLabel
      Left = 318
      Top = 4
      Width = 68
      Height = 15
      Size.Values = (
        39.687500000000000000
        841.375000000000000000
        10.583333333333330000
        179.916666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Commessa:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText28: TQRDBText
      Left = 387
      Top = 4
      Width = 110
      Height = 15
      Size.Values = (
        39.687500000000000000
        1023.937500000000000000
        10.583333333333330000
        291.041666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'COMMESSA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel16: TQRLabel
      Left = 49
      Top = 35
      Width = 17
      Height = 15
      Size.Values = (
        39.687500000000000000
        129.645833333333300000
        92.604166666666670000
        44.979166666666670000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Da:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText18: TQRDBText
      Left = 67
      Top = 35
      Width = 641
      Height = 15
      Size.Values = (
        39.687500000000000000
        177.270833333333300000
        92.604166666666670000
        1695.979166666667000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'PARTENZA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText19: TQRDBText
      Left = 67
      Top = 49
      Width = 641
      Height = 15
      Size.Values = (
        39.687500000000000000
        177.270833333333300000
        129.645833333333300000
        1695.979166666667000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DESTINAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLabel17: TQRLabel
      Left = 54
      Top = 49
      Width = 12
      Height = 15
      Size.Values = (
        39.687500000000000000
        142.875000000000000000
        129.645833333333300000
        31.750000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'A:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLabel5: TQRLabel
      Left = 502
      Top = 4
      Width = 27
      Height = 17
      Size.Values = (
        44.979166666666670000
        1328.208333333333000000
        10.583333333333330000
        71.437500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Prot:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object PROTOCOLLO: TQRDBText
      Left = 531
      Top = 4
      Width = 75
      Height = 17
      Size.Values = (
        44.979166666666670000
        1404.937500000000000000
        10.583333333333330000
        198.437500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'PROTOCOLLO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object StatoMiss: TQRDBText
      Left = 612
      Top = 4
      Width = 89
      Height = 17
      Size.Values = (
        44.979166666666670000
        1619.250000000000000000
        10.583333333333330000
        235.479166666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'STATO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
  end
  object QRSubDetail1: TQRSubDetail
    Left = 38
    Top = 270
    Width = 718
    Height = 15
    AlignToBottom = False
    BeforePrint = QRSubDetail1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = GroupFooterBand2
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = A104FStampaMissioniDtM1.SelM052
    FooterBand = GroupFooterBand2
    HeaderBand = GroupHeaderBand2
    PrintBefore = False
    PrintIfEmpty = True
    object QRDBText5: TQRDBText
      Left = 25
      Top = 0
      Width = 48
      Height = 15
      Size.Values = (
        39.687500000000000000
        66.145833333333330000
        0.000000000000000000
        127.000000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'CODICEINDENNITAKM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText12: TQRDBText
      Left = 80
      Top = 0
      Width = 257
      Height = 15
      Size.Values = (
        39.687500000000000000
        211.666666666666700000
        0.000000000000000000
        679.979166666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText6: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText13: TQRDBText
      Left = 600
      Top = 0
      Width = 105
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        277.812500000000000000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'IMPORTOINDENNITA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRShape19: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape27: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QrLblDettaglioKm: TQRLabel
      Left = 341
      Top = 0
      Width = 209
      Height = 15
      Size.Values = (
        39.687500000000000000
        902.229166666666700000
        0.000000000000000000
        552.979166666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
  end
  object QRSubDetail2: TQRSubDetail
    Left = 38
    Top = 326
    Width = 718
    Height = 16
    AlignToBottom = False
    BeforePrint = QRSubDetail2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand1
    Size.Values = (
      42.333333333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = A104FStampaMissioniDtM1.SelM050
    FooterBand = GroupFooterBand1
    HeaderBand = GroupHeaderBand1
    PrintBefore = False
    PrintIfEmpty = True
    object QRDBText7: TQRDBText
      Left = 25
      Top = 0
      Width = 48
      Height = 15
      Size.Values = (
        39.687500000000000000
        66.145833333333330000
        0.000000000000000000
        127.000000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'CODICERIMBORSOSPESE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText8: TQRDBText
      Left = 80
      Top = 0
      Width = 465
      Height = 15
      Size.Values = (
        39.687500000000000000
        211.666666666666700000
        0.000000000000000000
        1230.312500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText9: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRShape15: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape25: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblImportoRimborso: TQRLabel
      Left = 600
      Top = 0
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblImportoRimborso'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
  end
  object QRBand1: TQRBand
    Left = 38
    Top = 412
    Width = 718
    Height = 27
    AlignToBottom = False
    BeforePrint = QRBand1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      71.437500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRLabel23: TQRLabel
      Left = 453
      Top = 3
      Width = 86
      Height = 15
      Size.Values = (
        39.687500000000000000
        1198.562500000000000000
        7.937500000000000000
        227.541666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale trasferta'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLblTotale: TQRLabel
      Left = 600
      Top = 3
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        7.937500000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape5: TQRShape
      Left = 600
      Top = 17
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        44.979166666666670000
        275.166666666666700000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape6: TQRShape
      Left = 600
      Top = 19
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        50.270833333333330000
        275.166666666666700000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape7: TQRShape
      Left = 3
      Top = 23
      Width = 710
      Height = 1
      Size.Values = (
        2.645833333333333000
        7.937500000000000000
        60.854166666666670000
        1878.541666666667000000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape4: TQRShape
      Left = 8
      Top = 0
      Width = 697
      Height = 1
      Size.Values = (
        2.645833333333333000
        21.166666666666670000
        0.000000000000000000
        1844.145833333333000000)
      XLColumn = 0
      Pen.Style = psDot
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape12: TQRShape
      Left = 3
      Top = -3
      Width = 1
      Height = 27
      Size.Values = (
        71.437500000000000000
        7.937500000000000000
        -7.937500000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape14: TQRShape
      Left = 712
      Top = -13
      Width = 1
      Height = 37
      Size.Values = (
        97.895833333333340000
        1883.833333333333000000
        -34.395833333333340000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRDBText24: TQRDBText
      Left = 552
      Top = 3
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        7.937500000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
  end
  object QRBand2: TQRBand
    Left = 38
    Top = 439
    Width = 718
    Height = 29
    AlignToBottom = False
    BeforePrint = QRBand2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      76.729166666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRShape21: TQRShape
      Left = 3
      Top = 4
      Width = 710
      Height = 21
      Size.Values = (
        55.562500000000000000
        7.937500000000000000
        10.583333333333330000
        1878.541666666667000000)
      XLColumn = 0
      Pen.Width = 2
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QRLabel24: TQRLabel
      Left = 452
      Top = 8
      Width = 87
      Height = 15
      Size.Values = (
        39.687500000000000000
        1195.916666666667000000
        21.166666666666670000
        230.187500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale generale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLblTotaleGenerale: TQRLabel
      Left = 600
      Top = 8
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        21.166666666666670000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotaleGenerale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText25: TQRDBText
      Left = 552
      Top = 8
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        21.166666666666670000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
  end
  object GroupFooterBand1: TQRBand
    Left = 38
    Top = 358
    Width = 718
    Height = 21
    AlignToBottom = False
    BeforePrint = GroupFooterBand1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand6
    Size.Values = (
      55.562500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRLabel22: TQRLabel
      Left = 453
      Top = 6
      Width = 86
      Height = 15
      Size.Values = (
        39.687500000000000000
        1198.562500000000000000
        15.875000000000000000
        227.541666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale rimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText23: TQRDBText
      Left = 552
      Top = 6
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        15.875000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLblTotaleRimborsi: TQRLabel
      Left = 600
      Top = 6
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        15.875000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotaleRimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape2: TQRShape
      Left = 600
      Top = 4
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        10.583333333333330000
        275.166666666666700000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape11: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape22: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object GroupHeaderBand1: TQRBand
    Left = 38
    Top = 306
    Width = 718
    Height = 20
    AlignToBottom = False
    BeforePrint = GroupHeaderBand1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRSubDetail2
    Size.Values = (
      52.916666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
    object QRLabel8: TQRLabel
      Left = 8
      Top = 4
      Width = 51
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        10.583333333333330000
        134.937500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Rimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape16: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape24: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape29: TQRShape
      Left = 8
      Top = 0
      Width = 697
      Height = 1
      Size.Values = (
        2.645833333333333000
        21.166666666666670000
        0.000000000000000000
        1844.145833333333000000)
      XLColumn = 0
      Pen.Style = psDot
      Shape = qrsHorLine
      VertAdjust = 0
    end
  end
  object GroupHeaderBand2: TQRBand
    Left = 38
    Top = 250
    Width = 718
    Height = 20
    AlignToBottom = False
    BeforePrint = GroupHeaderBand2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRSubDetail1
    Size.Values = (
      52.916666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
    object QRLabel21: TQRLabel
      Left = 8
      Top = 4
      Width = 131
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        10.583333333333330000
        346.604166666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' chilometriche'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape20: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape28: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape3: TQRShape
      Left = 9
      Top = 0
      Width = 697
      Height = 1
      Size.Values = (
        2.645833333333333000
        23.812500000000000000
        0.000000000000000000
        1844.145833333333000000)
      XLColumn = 0
      Pen.Style = psDot
      Shape = qrsHorLine
      VertAdjust = 0
    end
  end
  object ChildBand1: TQRChildBand
    Left = 38
    Top = 342
    Width = 718
    Height = 16
    AlignToBottom = False
    BeforePrint = ChildBand1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = GroupFooterBand1
    Size.Values = (
      42.333333333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRSubDetail2
    PrintOrder = cboAfterParent
    object QRLabel20: TQRLabel
      Left = 112
      Top = 0
      Width = 433
      Height = 15
      Size.Values = (
        39.687500000000000000
        296.333333333333300000
        0.000000000000000000
        1145.645833333333000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'Indennit'#224' supplementare'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText22: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRDBText11: TQRDBText
      Left = 600
      Top = 0
      Width = 105
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        277.812500000000000000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'IMPORTOINDENNITASUPPLEMENTARE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRShape13: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape23: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object GroupFooterBand2: TQRBand
    Left = 38
    Top = 285
    Width = 718
    Height = 21
    AlignToBottom = False
    BeforePrint = GroupFooterBand2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = GroupHeaderBand1
    Size.Values = (
      55.562500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRLabel1: TQRLabel
      Left = 371
      Top = 6
      Width = 168
      Height = 15
      Size.Values = (
        39.687500000000000000
        981.604166666666700000
        15.875000000000000000
        444.500000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale indennit'#224' chilometriche'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText26: TQRDBText
      Left = 552
      Top = 6
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        15.875000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRLblTotaleIndennitaKm: TQRLabel
      Left = 600
      Top = 6
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        15.875000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotaleIndennitaKm'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape10: TQRShape
      Left = 600
      Top = 4
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        10.583333333333330000
        275.166666666666700000)
      XLColumn = 0
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape18: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape26: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand2: TQRChildBand
    Left = 38
    Top = 190
    Width = 718
    Height = 15
    AlignToBottom = False
    BeforePrint = ChildBand2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand3
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRGroup2
    PrintOrder = cboAfterParent
    object QRLblIndennitaDiTrasferta: TQRLabel
      Left = 8
      Top = 0
      Width = 151
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        0.000000000000000000
        399.520833333333300000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' di trasferta intera'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = QRLblIndennitaDiTrasfertaPrint
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRLblIndennitaDiTrasfertaDesc: TQRLabel
      Left = 160
      Top = 0
      Width = 393
      Height = 15
      Size.Values = (
        39.687500000000000000
        423.333333333333300000
        0.000000000000000000
        1039.812500000000000000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText4: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QrLblImportoTrasfertaIntera: TQRLabel
      Left = 600
      Top = 0
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaIntera'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape33: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape37: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand3: TQRChildBand
    Left = 38
    Top = 205
    Width = 718
    Height = 15
    AlignToBottom = False
    BeforePrint = ChildBand3BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand4
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand2
    PrintOrder = cboAfterParent
    object QrLblDescImportoTrasfertaSupHH: TQRLabel
      Left = 8
      Top = 0
      Width = 303
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        0.000000000000000000
        801.687500000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero delle ore massime/rimborso pasto'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnPrint = QrLblDescImportoTrasfertaSupHHPrint
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QrLblDescImportoTrasfertaSupHHDesc: TQRLabel
      Left = 312
      Top = 0
      Width = 241
      Height = 15
      Size.Values = (
        39.687500000000000000
        825.500000000000000000
        0.000000000000000000
        637.645833333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText1: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QrLblImportoTrasfertaSupHH: TQRLabel
      Left = 600
      Top = 0
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaSupHH'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape32: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape36: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand4: TQRChildBand
    Left = 38
    Top = 220
    Width = 718
    Height = 15
    AlignToBottom = False
    BeforePrint = ChildBand4BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand5
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand3
    PrintOrder = cboAfterParent
    object QrLblDescImportoTrasfertaSupGG: TQRLabel
      Left = 8
      Top = 0
      Width = 272
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        0.000000000000000000
        719.666666666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero massimo dei giorni nel mese'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QrLblDescImportoTrasfertaSupGGDesc: TQRLabel
      Left = 281
      Top = 0
      Width = 272
      Height = 15
      Size.Values = (
        39.687500000000000000
        743.479166666666700000
        0.000000000000000000
        719.666666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText2: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QrLblImportoTrasfertaSupGG: TQRLabel
      Left = 600
      Top = 0
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaSupGG'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape31: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape35: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand5: TQRChildBand
    Left = 38
    Top = 235
    Width = 718
    Height = 15
    AlignToBottom = False
    BeforePrint = ChildBand5BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = GroupHeaderBand2
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand4
    PrintOrder = cboAfterParent
    object QrLblDescImportoTrasfertaSupHHGG: TQRLabel
      Left = 8
      Top = 0
      Width = 229
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        0.000000000000000000
        605.895833333333300000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero massimo ore e giorni'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QrLblDescImportoTrasfertaSupHHGGDesc: TQRLabel
      Left = 238
      Top = 0
      Width = 315
      Height = 15
      Size.Values = (
        39.687500000000000000
        629.708333333333300000
        0.000000000000000000
        833.437500000000000000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRDBText3: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QrLblImportoTrasfertaSupHHGG: TQRLabel
      Left = 600
      Top = 0
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        275.166666666666700000)
      XLColumn = 0
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaSupHHGG'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape30: TQRShape
      Left = 3
      Top = -5
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        7.937500000000000000
        -13.229166666666670000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape34: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand6: TQRChildBand
    Left = 38
    Top = 379
    Width = 718
    Height = 17
    AlignToBottom = False
    BeforePrint = ChildBand6BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = ChildBand7
    Size.Values = (
      44.979166666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = GroupFooterBand1
    PrintOrder = cboAfterParent
    object QRLabel4: TQRLabel
      Left = 8
      Top = 4
      Width = 77
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        10.583333333333330000
        203.729166666666700000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Note rimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 8
    end
    object QRShape38: TQRShape
      Left = 3
      Top = 1
      Width = 1
      Height = 16
      Size.Values = (
        42.333333333333340000
        7.937500000000000000
        2.645833333333333000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape40: TQRShape
      Left = 712
      Top = 1
      Width = 1
      Height = 16
      Size.Values = (
        42.333333333333340000
        1883.833333333333000000
        2.645833333333333000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand7: TQRChildBand
    Left = 38
    Top = 396
    Width = 718
    Height = 16
    AlignToBottom = False
    BeforePrint = ChildBand7BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRBand1
    Size.Values = (
      42.333333333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand6
    PrintOrder = cboAfterParent
    object QrDbNoteRimborsi: TQRDBText
      Left = 9
      Top = 0
      Width = 696
      Height = 15
      Size.Values = (
        39.687500000000000000
        23.812500000000000000
        0.000000000000000000
        1841.500000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = True
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'NOTERIMBORSI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRShape39: TQRShape
      Left = 712
      Top = -6
      Width = 1
      Height = 29
      Size.Values = (
        76.729166666666670000
        1883.833333333333000000
        -15.875000000000000000
        2.645833333333333000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape41: TQRShape
      Left = 1
      Top = -5
      Width = 4
      Height = 29
      Size.Values = (
        76.729166666666670000
        2.645833333333333000
        -13.229166666666670000
        10.583333333333330000)
      XLColumn = 0
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object ChildBand8: TQRChildBand
    Left = 38
    Top = 95
    Width = 718
    Height = 26
    AlignToBottom = False
    BeforePrint = ChildBand8BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      68.791666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRBand3
    PrintOrder = cboAfterParent
    object QRShape42: TQRShape
      Left = 3
      Top = 1
      Width = 710
      Height = 23
      Size.Values = (
        60.854166666666670000
        7.937500000000000000
        2.645833333333333000
        1878.541666666667000000)
      XLColumn = 0
      Pen.Width = 2
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QrLblDipendenteb: TQRLabel
      Left = 9
      Top = 3
      Width = 696
      Height = 17
      Size.Values = (
        44.979166666666670000
        23.812500000000000000
        7.937500000000000000
        1841.500000000000000000)
      XLColumn = 0
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblDipendente'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = DefaultEncoding
    Left = 344
  end
  object QRRTFFilter1: TQRRTFFilter
    TextEncoding = DefaultEncoding
    Left = 416
  end
  object QRPDFFilter1: TQRPDFFilter
    CompressionOn = True
    TextEncoding = ASCIIEncoding
    Codepage = '1252'
    Left = 488
  end
  object QRHTMLFilter1: TQRHTMLFilter
    MultiPage = False
    PageLinks = False
    FinalPage = 0
    FirstLastLinks = False
    Concat = False
    ConcatCount = 1
    LinkFontSize = 12
    LinkFontName = 'Arial'
    TextEncoding = ASCIIEncoding
    Left = 560
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = DefaultEncoding
    UseXLColumns = False
    Left = 632
  end
end
