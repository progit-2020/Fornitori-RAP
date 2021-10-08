object A058FTabellone: TA058FTabellone
  Left = 265
  Top = 233
  Caption = 'A058FTabellone'
  ClientHeight = 612
  ClientWidth = 1002
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesigned
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object QRep: TQuickRep
    Left = 0
    Top = 0
    Width = 1123
    Height = 794
    BeforePrint = QRepBeforePrint
    DataSet = A058FPianifTurniDtM1.T058Stampa
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Courier New'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter, Compression]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      50.000000000000000000
      50.000000000000000000
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
    PrintIfEmpty = False
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsMDIForm
    PreviewInitialState = wsMaximized
    PrevShowThumbs = False
    PrevShowSearch = False
    PrevInitialZoom = qrZoomOther
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object PageHeaderBand1: TQRBand
      Left = 19
      Top = 38
      Width = 1085
      Height = 52
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = PageHeaderBand1BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        137.583333333333300000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRSysData1: TQRSysData
        Left = 0
        Top = 0
        Width = 31
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          0.000000000000000000
          82.020833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = True
        Color = clWhite
        Data = qrsDate
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 7
      end
      object QRSysData2: TQRSysData
        Left = 1049
        Top = 0
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          2775.479166666667000000
          0.000000000000000000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = True
        Color = clWhite
        Data = qrsPageNumber
        Text = ''
        Transparent = False
        ExportAs = exptText
        FontSize = 7
      end
      object QRTitolo: TQRLabel
        Left = 467
        Top = 2
        Width = 151
        Height = 20
        Size.Values = (
          52.916666666666670000
          1235.604166666667000000
          5.291666666666667000
          399.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Tabellone turni'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 12
      end
      object QRData: TQRLabel
        Left = 494
        Top = 33
        Width = 97
        Height = 18
        Size.Values = (
          47.625000000000000000
          1307.041666666667000000
          87.312500000000000000
          256.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = True
        Caption = 'dal // al //'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QRLblSituazione: TQRLabel
        Left = 450
        Top = 18
        Width = 185
        Height = 17
        Size.Values = (
          44.979166666666670000
          1190.625000000000000000
          47.625000000000000000
          489.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = True
        Caption = '(situazione consuntiva)'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object Intestazione: TQRBand
      Left = 19
      Top = 90
      Width = 1085
      Height = 24
      Frame.DrawBottom = True
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        63.500000000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRSquadra: TQRDBText
        Left = 2
        Top = 3
        Width = 91
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          7.937500000000000000
          240.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Squadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QRDSquadra: TQRDBText
        Left = 103
        Top = 3
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          272.520833333333300000
          7.937500000000000000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'DSquadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
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
    object Gruppo: TQRGroup
      Left = 19
      Top = 141
      Width = 1085
      Height = 15
      AlignToBottom = False
      BeforePrint = GruppoBeforePrint
      Color = clWhite
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = True
      ParentFont = False
      Size.Values = (
        39.687500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'T058Stampa.Squadra + T058Stampa.Datainizio'
      FooterBand = PiedeLiquid
      Master = QRep
      ReprintOnNewPage = False
    end
    object Dettaglio: TQRBand
      Left = 19
      Top = 156
      Width = 1085
      Height = 33
      AlignToBottom = False
      BeforePrint = DettaglioBeforePrint
      Color = clWhite
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        87.312500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRBadge: TQRDBText
        Left = 0
        Top = 1
        Width = 37
        Height = 14
        Size.Values = (
          37.041666666666670000
          0.000000000000000000
          2.645833333333333000
          97.895833333333320000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Matricola'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 5
      end
      object QRNome: TQRDBText
        Left = 0
        Top = 16
        Width = 108
        Height = 14
        Size.Values = (
          37.041666666666670000
          0.000000000000000000
          42.333333333333330000
          285.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Nome'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 5
      end
      object QROp: TQRDBText
        Left = 240
        Top = 1
        Width = 17
        Height = 17
        Size.Values = (
          44.979166666666670000
          635.000000000000000000
          2.645833333333333000
          44.979166666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Operatore'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakAnywhere
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 5
      end
      object QrLblDebito: TQRLabel
        Left = 194
        Top = 1
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          2.645833333333333000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLblAssegnato: TQRLabel
        Left = 194
        Top = 9
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          23.812500000000000000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QRLblScostamento: TQRLabel
        Left = 194
        Top = 17
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          44.979166666666670000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QrLblTotTurno1: TQRLabel
        Left = 264
        Top = 1
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          2.645833333333333000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QrLblTotTurno2: TQRLabel
        Left = 264
        Top = 9
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          23.812500000000000000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QrLblTotTurno3: TQRLabel
        Left = 264
        Top = 17
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          44.979166666666670000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
      object QrLblTotTurno4: TQRLabel
        Left = 264
        Top = 25
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          66.145833333333340000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        OnPrint = QrLblTotTurno4Print
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 5
      end
    end
    object PiedeLiquid: TQRBand
      Left = 19
      Top = 189
      Width = 1085
      Height = 22
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = PiedeLiquidBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object qlblLiquid: TQRLabel
        Left = 2
        Top = 4
        Width = 100
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          10.583333333333330000
          264.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Liquidabile'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
    end
    object Piede3: TQRChildBand
      Left = 19
      Top = 334
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = Piede3BeforePrint
      Color = clWhite
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Piede2
      PrintOrder = cboAfterParent
      object QRMAssenze: TQRMemo
        Left = 45
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          119.062500000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Lines.Strings = (
          'Assenze')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRLAssenze: TQRLabel
        Left = 2
        Top = 1
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Assenze:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
    end
    object Piede2: TQRChildBand
      Left = 19
      Top = 318
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = Piede2BeforePrint
      Color = clWhite
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = TotTotaliGG
      PrintOrder = cboAfterParent
      object QRLOrari: TQRLabel
        Left = 2
        Top = 1
        Width = 31
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          82.020833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Orari:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRMOrari: TQRMemo
        Left = 45
        Top = 1
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          119.062500000000000000
          2.645833333333333000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Lines.Strings = (
          'Orari')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRLblTemp: TQRLabel
        Left = 120
        Top = 0
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          317.500000000000000000
          0.000000000000000000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'QRLblTemp'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
    end
    object Piede4: TQRChildBand
      Left = 19
      Top = 350
      Width = 1085
      Height = 52
      Frame.DrawTop = True
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        137.583333333333300000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Piede3
      PrintOrder = cboAfterParent
      object QRNota: TQRLabel
        Left = 2
        Top = 10
        Width = 461
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          26.458333333333330000
          1219.729166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 
          'NOTA: Ogni richiesta di variazione al presente turno dovr'#224' esser' +
          'e trasmessa a questo ufficio'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRDesc1: TQRLabel
        Left = 52
        Top = 30
        Width = 116
        Height = 17
        Size.Values = (
          44.979166666666670000
          137.583333333333300000
          79.375000000000000000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'L'#39'UFFICIO DEL PERSONALE'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRDesc2: TQRLabel
        Left = 487
        Top = 30
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666670000
          1288.520833333333000000
          79.375000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = True
        Caption = 'IL DIRETTORE SANITARIO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
    end
    object Piede5: TQRChildBand
      Left = 19
      Top = 232
      Width = 1085
      Height = 70
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = Piede5BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        185.208333333333300000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = PiedeTotOrario
      PrintOrder = cboAfterParent
      object QRLTurno2: TQRLabel
        Left = 23
        Top = 25
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          60.854166666666670000
          66.145833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '2'#176'Turno:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLTurno3: TQRLabel
        Left = 23
        Top = 37
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          60.854166666666670000
          97.895833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '3'#176'Turno:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLTurno1: TQRLabel
        Left = 23
        Top = 13
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          60.854166666666670000
          34.395833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '1'#176'Turno:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLTurno4: TQRLabel
        Left = 23
        Top = 49
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          60.854166666666670000
          129.645833333333300000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '4'#176'Turno:'
        Color = clWhite
        OnPrint = QRLTurno4Print
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLTotaliTurno: TQRLabel
        Left = 2
        Top = 1
        Width = 66
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totali turno:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLMin: TQRLabel
        Left = 72
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          190.500000000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Min(Fs)'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLMax: TQRLabel
        Left = 105
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          277.812500000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Max(Fs)'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRDBMin1: TQRDBText
        Left = 67
        Top = 13
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          177.270833333333300000
          34.395833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMIN1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMax1: TQRDBText
        Left = 100
        Top = 13
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          264.583333333333300000
          34.395833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMAX1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMin2: TQRDBText
        Left = 67
        Top = 25
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          177.270833333333300000
          66.145833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMIN2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMax2: TQRDBText
        Left = 100
        Top = 25
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          264.583333333333300000
          66.145833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMAX2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMax3: TQRDBText
        Left = 100
        Top = 37
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          264.583333333333300000
          97.895833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMAX3'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMin3: TQRDBText
        Left = 67
        Top = 37
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          177.270833333333300000
          97.895833333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMIN4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMax4: TQRDBText
        Left = 100
        Top = 49
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          264.583333333333300000
          129.645833333333300000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMAX4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRDBMin4: TQRDBText
        Left = 67
        Top = 49
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          177.270833333333300000
          129.645833333333300000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.Q600B
        DataField = 'DETTMIN4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
    end
    object IntestazioneCalendario: TQRChildBand
      Left = 19
      Top = 114
      Width = 1085
      Height = 27
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = IntestazioneCalendarioBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        71.437500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Intestazione
      PrintOrder = cboAfterParent
      object QRLBadge: TQRLabel
        Left = 16
        Top = 1
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          42.333333333333330000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Matricola'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLNome: TQRLabel
        Left = 18
        Top = 11
        Width = 21
        Height = 13
        Size.Values = (
          34.395833333333330000
          47.625000000000000000
          29.104166666666670000
          55.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRLOp: TQRLabel
        Left = 240
        Top = 1
        Width = 16
        Height = 13
        Size.Values = (
          34.395833333333330000
          635.000000000000000000
          2.645833333333333000
          42.333333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Op.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object LblAssegnato: TQRLabel
        Left = 176
        Top = 9
        Width = 66
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          23.812500000000000000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ore assegnate'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object LblDebito: TQRLabel
        Left = 176
        Top = 1
        Width = 66
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          2.645833333333333000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Debito contr.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object LblScostamento: TQRLabel
        Left = 176
        Top = 17
        Width = 56
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          44.979166666666670000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Scostamento'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QrTotale: TQRLabel
        Left = 264
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          698.500000000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totale '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QrTurno: TQRLabel
        Left = 264
        Top = 9
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          698.500000000000000000
          23.812500000000000000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'turni'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QrLblDatoLibero: TQRLabel
        Left = 889
        Top = 6
        Width = 76
        Height = 13
        Size.Values = (
          34.395833333333330000
          2352.145833333333000000
          15.875000000000000000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'QrLblDatoLibero'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
    end
    object PiedeTotOrario: TQRChildBand
      Left = 19
      Top = 211
      Width = 1085
      Height = 21
      AlignToBottom = False
      BeforePrint = Piede1BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        55.562500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = PiedeLiquid
      PrintOrder = cboAfterParent
      object QRLTotali: TQRLabel
        Left = 2
        Top = 1
        Width = 91
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          240.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totali per orario:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
      object QRMTotali: TQRMemo
        Left = 228
        Top = 1
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          603.250000000000000000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
    end
    object TotTotaliGG: TQRChildBand
      Left = 19
      Top = 302
      Width = 1085
      Height = 16
      AlignToBottom = False
      BeforePrint = TotTotaliGGBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Piede5
      PrintOrder = cboAfterParent
      object qrLblTotGen: TQRLabel
        Left = 23
        Top = 1
        Width = 86
        Height = 13
        Size.Values = (
          34.395833333333330000
          60.854166666666670000
          2.645833333333333000
          227.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totali Generali: '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 7
      end
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
