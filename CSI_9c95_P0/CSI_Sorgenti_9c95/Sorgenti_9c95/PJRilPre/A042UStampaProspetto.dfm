object A042FStampaProspetto: TA042FStampaProspetto
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  BeforePrint = QuickRepBeforePrint
  DataSet = A042FStampaPreAssMW.TabellaStampa
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE'
    'QRLOOPBAND1')
  Functions.DATA = (
    '0'
    '0'
    #39#39
    '0')
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
  PrinterSettings.MemoryLimit = 1000000
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PrevShowThumbs = False
  PrevShowSearch = False
  PrevInitialZoom = qrZoomOther
  PreviewDefaultSaveType = stQRP
  PreviewLeft = 0
  PreviewTop = 0
  object QRBand4: TQRBand
    Left = 38
    Top = 38
    Width = 718
    Height = 57
    AlignToBottom = False
    BeforePrint = QRBand4BeforePrint
    Color = clWhite
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
      Left = 0
      Top = 1
      Width = 66
      Height = 17
      Size.Values = (
        44.979166666666670000
        0.000000000000000000
        2.645833333333333000
        174.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taLeftJustify
      AlignToBand = True
      Color = clWhite
      Data = qrsDateTime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = ''
      Transparent = False
      ExportAs = exptText
      FontSize = 9
    end
    object QRLblAzienda: TQRLabel
      Left = 8
      Top = 21
      Width = 716
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        55.562500000000000000
        1894.416666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
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
    object QRSysData2: TQRSysData
      Left = 621
      Top = 1
      Width = 90
      Height = 17
      Size.Values = (
        44.979166666666670000
        1643.062500000000000000
        2.645833333333333000
        238.125000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taRightJustify
      AlignToBand = False
      Color = clWhite
      Data = qrsPageNumber
      Text = 'Pagina '
      Transparent = False
      ExportAs = exptText
      FontSize = 10
    end
    object QRLblGruppo: TQRLabel
      Left = 159
      Top = 37
      Width = 400
      Height = 17
      Size.Values = (
        44.979166666666670000
        420.687500000000000000
        97.895833333333330000
        1058.333333333333000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = True
      Caption = 'PROSPETTO DELLE ORE LAVORATE NEL GIORNO: dd/mm/yyyy'
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
  object QRGroup1: TQRGroup
    Left = 38
    Top = 95
    Width = 718
    Height = 0
    AlignToBottom = False
    BeforePrint = QRGroup1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRGroup2
    Size.Values = (
      0.000000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'TabellaStampa.Data'
    FooterBand = QRBand2
    Master = Owner
    ReprintOnNewPage = False
  end
  object QRGroup2: TQRGroup
    Left = 38
    Top = 95
    Width = 718
    Height = 110
    AlignToBottom = False
    BeforePrint = QRGroup2BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRBand1
    Size.Values = (
      291.041666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    FooterBand = QRBand3
    Master = Owner
    ReprintOnNewPage = False
    object QRLblUnitaOperativa: TQRLabel
      Left = 1
      Top = 25
      Width = 90
      Height = 19
      Size.Values = (
        50.270833333333330000
        2.645833333333333000
        66.145833333333330000
        238.125000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Unit'#224' operativa:'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape20: TQRShape
      Left = -1
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        -2.645833333333333000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape21: TQRShape
      Left = 1
      Top = 41
      Width = 716
      Height = 6
      Size.Values = (
        15.875000000000000000
        2.645833333333333000
        108.479166666666700000
        1894.416666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape22: TQRShape
      Left = 715
      Top = 44
      Width = 2
      Height = 66
      Size.Values = (
        174.625000000000000000
        1891.770833333333000000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape23: TQRShape
      Left = 1
      Top = 106
      Width = 715
      Height = 6
      Size.Values = (
        15.875000000000000000
        2.645833333333333000
        280.458333333333400000
        1891.770833333333000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRLabel6: TQRLabel
      Left = 69
      Top = 65
      Width = 130
      Height = 17
      Size.Values = (
        44.979166666666670000
        182.562500000000000000
        171.979166666666700000
        343.958333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Cognome e Nome'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape24: TQRShape
      Left = 200
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        529.166666666666700000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblEntrata: TQRLabel
      Left = 465
      Top = 49
      Width = 70
      Height = 57
      Size.Values = (
        150.812500000000000000
        1230.312500000000000000
        129.645833333333300000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Ora entrata dalle 07.00 alle 14.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape25: TQRShape
      Left = 462
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        1222.375000000000000000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblUscita: TQRLabel
      Left = 540
      Top = 49
      Width = 68
      Height = 57
      Size.Values = (
        150.812500000000000000
        1428.750000000000000000
        129.645833333333300000
        179.916666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Ora uscita dalle 07.00 alle 14.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape26: TQRShape
      Left = 332
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        878.416666666666700000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblConsecutive: TQRLabel
      Left = 611
      Top = 49
      Width = 104
      Height = 57
      Size.Values = (
        150.812500000000000000
        1616.604166666667000000
        129.645833333333300000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Totale ore consecutive dalle 07.00 alle 14.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape27: TQRShape
      Left = 537
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        1420.812500000000000000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblLimite1: TQRLabel
      Left = 202
      Top = 49
      Width = 131
      Height = 57
      Size.Values = (
        150.812500000000000000
        534.458333333333300000
        129.645833333333300000
        346.604166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Le ore consecutive dalle 07.00 alle 14.00 sono < 5'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape28: TQRShape
      Left = 608
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        1608.666666666667000000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLblLimite2: TQRLabel
      Left = 335
      Top = 49
      Width = 128
      Height = 57
      Size.Values = (
        150.812500000000000000
        886.354166666666700000
        129.645833333333300000
        338.666666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Le ore consecutive dalle 00.00 alle 23.59 sono >12'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRShape29: TQRShape
      Left = 67
      Top = 44
      Width = 2
      Height = 67
      Size.Values = (
        177.270833333333300000
        177.270833333333300000
        116.416666666666700000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel13: TQRLabel
      Left = 8
      Top = 65
      Width = 55
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        171.979166666666700000
        145.520833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Caption = 'Matricola'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FontSize = 10
    end
    object QRDBText2: TQRDBText
      Left = 96
      Top = 25
      Width = 43
      Height = 19
      Size.Values = (
        50.270833333333330000
        254.000000000000000000
        66.145833333333330000
        113.770833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'Gruppo'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
  end
  object QRBand1: TQRBand
    Left = 38
    Top = 205
    Width = 718
    Height = 28
    AlignToBottom = False
    BeforePrint = QRBand1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRBand3
    Size.Values = (
      74.083333333333330000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRShape10: TQRShape
      Left = -1
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        -2.645833333333333000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape11: TQRShape
      Left = 200
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        529.166666666666700000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape12: TQRShape
      Left = 537
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        1420.812500000000000000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape13: TQRShape
      Left = 332
      Top = -1
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        878.416666666666700000
        -2.645833333333333000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape14: TQRShape
      Left = 462
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        1222.375000000000000000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape15: TQRShape
      Left = 608
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        1608.666666666667000000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape16: TQRShape
      Left = 715
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        1891.770833333333000000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape17: TQRShape
      Left = 1
      Top = 23
      Width = 715
      Height = 6
      Size.Values = (
        15.875000000000000000
        2.645833333333333000
        60.854166666666670000
        1891.770833333333000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRDBNomeMedico: TQRDBText
      Left = 70
      Top = 5
      Width = 129
      Height = 17
      Size.Values = (
        44.979166666666670000
        185.208333333333300000
        13.229166666666670000
        341.312500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'Nome'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QRShape19: TQRShape
      Left = 67
      Top = -2
      Width = 2
      Height = 28
      Size.Values = (
        74.083333333333330000
        177.270833333333300000
        -5.291666666666667000
        5.291666666666667000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRDBMatricola: TQRDBText
      Left = 4
      Top = 5
      Width = 62
      Height = 17
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        13.229166666666670000
        164.041666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'Matricola'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QRDBOraEntrata: TQRDBText
      Left = 468
      Top = 5
      Width = 66
      Height = 17
      Size.Values = (
        44.979166666666670000
        1238.250000000000000000
        13.229166666666670000
        174.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'OraEntrata'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QRDBOraUscita: TQRDBText
      Left = 541
      Top = 5
      Width = 66
      Height = 17
      Size.Values = (
        44.979166666666670000
        1431.395833333333000000
        13.229166666666670000
        174.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'OraUscita'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QRDBTotale: TQRDBText
      Left = 628
      Top = 5
      Width = 71
      Height = 17
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        13.229166666666670000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'TotaleConsecutive'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QRDbLimite1: TQRDBText
      Left = 228
      Top = 5
      Width = 71
      Height = 17
      Size.Values = (
        44.979166666666670000
        603.250000000000000000
        13.229166666666670000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'Limite1'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
    object QrDbLimite2: TQRDBText
      Left = 363
      Top = 5
      Width = 71
      Height = 17
      Size.Values = (
        44.979166666666670000
        960.437500000000000000
        13.229166666666670000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A042FStampaPreAssMW.TabellaStampa
      DataField = 'Limite2'
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 10
    end
  end
  object QRBand3: TQRBand
    Left = 38
    Top = 233
    Width = 718
    Height = 14
    AlignToBottom = False
    BeforePrint = QRBand3BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRBand2
    Size.Values = (
      37.041666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object QRBand2: TQRBand
    Left = 38
    Top = 247
    Width = 718
    Height = 14
    AlignToBottom = False
    BeforePrint = QRBand2BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      37.041666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
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
    TextEncoding = AnsiEncoding
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
    TextEncoding = AnsiEncoding
    Left = 560
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = DefaultEncoding
    UseXLColumns = False
    Left = 632
  end
end
