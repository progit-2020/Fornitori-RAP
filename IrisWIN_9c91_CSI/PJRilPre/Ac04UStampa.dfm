object Ac04FStampa: TAc04FStampa
  Left = 150
  Top = 69
  Caption = 'Ac04FStampa'
  ClientHeight = 578
  ClientWidth = 1112
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RepR: TQuickRep
    Left = 0
    Top = -4
    Width = 1123
    Height = 794
    AfterPrint = RepRAfterPrint
    AfterPreview = RepRAfterPreview
    ShowingPreview = False
    BeforePrint = RepRBeforePrint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      70.000000000000000000
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
    PrintIfEmpty = False
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
    object QRBTitolo: TQRBand
      Left = 26
      Top = 38
      Width = 1059
      Height = 41
      AlignToBottom = False
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        108.479166666666700000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRLTitolo: TQRLabel
        Left = 493
        Top = 20
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          1304.395833333333000000
          52.916666666666670000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Timesheet'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLEnte: TQRLabel
        Left = 493
        Top = 0
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          1304.395833333333000000
          0.000000000000000000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Nome Ente'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object bndIntestazione: TQRGroup
      Left = 26
      Top = 79
      Width = 1059
      Height = 91
      AfterPrint = bndIntestazioneAfterPrint
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = True
      Size.Values = (
        240.770833333333300000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'PROGRESSIVO + ID_T750 + PERIODO_STAMPA'
      Master = RepR
      ReprintOnNewPage = False
      object qlblReportingPeriod: TQRLabel
        Left = 0
        Top = 6
        Width = 86
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          15.875000000000000000
          227.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Reporting period:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblDescProgetto: TQRLabel
        Left = 0
        Top = 27
        Width = 41
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          71.437500000000000000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Acronym:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblCodProgetto: TQRLabel
        Left = 0
        Top = 43
        Width = 76
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          113.770833333333300000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Project number:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblPartnerName: TQRLabel
        Left = 0
        Top = 59
        Width = 66
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          156.104166666666700000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Partner name:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblPartnerNumber: TQRLabel
        Left = 0
        Top = 75
        Width = 76
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          198.437500000000000000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Partner number:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblPeriodoStampa: TQRLabel
        Left = 264
        Top = 6
        Width = 31
        Height = 15
        Size.Values = (
          39.687500000000000000
          698.500000000000000000
          15.875000000000000000
          82.020833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Month:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblNominativoDip: TQRLabel
        Left = 528
        Top = 27
        Width = 106
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          71.437500000000000000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Name of the Employee:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblServizio: TQRLabel
        Left = 528
        Top = 43
        Width = 56
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          113.770833333333300000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Department:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblFunzione: TQRLabel
        Left = 528
        Top = 59
        Width = 26
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          156.104166666666700000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Role:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblNominativoResp: TQRLabel
        Left = 528
        Top = 75
        Width = 116
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          198.437500000000000000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Name of the Supervisor:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblReportingPeriod: TQRDBText
        Left = 118
        Top = 6
        Width = 81
        Height = 15
        Size.Values = (
          39.687500000000000000
          312.208333333333400000
          15.875000000000000000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'REPORTING_PERIOD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblDescProgetto: TQRDBText
        Left = 118
        Top = 27
        Width = 66
        Height = 15
        Size.Values = (
          39.687500000000000000
          312.208333333333400000
          71.437500000000000000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'DESC_PROGETTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblCodProgetto: TQRDBText
        Left = 118
        Top = 43
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          312.208333333333400000
          113.770833333333300000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'COD_PROGETTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblPartnerName: TQRDBText
        Left = 118
        Top = 59
        Width = 61
        Height = 15
        Size.Values = (
          39.687500000000000000
          312.208333333333400000
          156.104166666666700000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'PARTNER_NAME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblPartnerNumber: TQRDBText
        Left = 118
        Top = 75
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          312.208333333333400000
          198.437500000000000000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'PARTNER_NUMBER'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblNominativoResp: TQRDBText
        Left = 676
        Top = 75
        Width = 76
        Height = 15
        Size.Values = (
          39.687500000000000000
          1788.583333333333000000
          198.437500000000000000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'NOMINATIVO_RESP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblPeriodoStampaDesc: TQRDBText
        Left = 327
        Top = 6
        Width = 96
        Height = 15
        Size.Values = (
          39.687500000000000000
          865.187500000000000000
          15.875000000000000000
          254.000000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'PERIODO_STAMPA_DESC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblNominativoDip: TQRDBText
        Left = 676
        Top = 27
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          1788.583333333333000000
          71.437500000000000000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'NOMINATIVO_DIP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblServizio: TQRDBText
        Left = 676
        Top = 43
        Width = 41
        Height = 15
        Size.Values = (
          39.687500000000000000
          1788.583333333333000000
          113.770833333333300000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'SERVIZIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblFunzione: TQRDBText
        Left = 676
        Top = 59
        Width = 41
        Height = 15
        Size.Values = (
          39.687500000000000000
          1788.583333333333000000
          156.104166666666700000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'FUNZIONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblTipoTempo: TQRLabel
        Left = 528
        Top = 6
        Width = 106
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          15.875000000000000000
          280.458333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Type of working time:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTipoTempo: TQRDBText
        Left = 676
        Top = 6
        Width = 51
        Height = 15
        Size.Values = (
          39.687500000000000000
          1788.583333333333000000
          15.875000000000000000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'TIPO_TEMPO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndTotali: TQRBand
      Left = 26
      Top = 217
      Width = 1059
      Height = 24
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object dlblAttTot_1: TQRDBText
        Left = 42
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          111.125000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_2: TQRDBText
        Left = 86
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          227.541666666666700000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_3: TQRDBText
        Left = 130
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333300000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_4: TQRDBText
        Left = 174
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          460.375000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_5: TQRDBText
        Left = 218
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          576.791666666666600000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_6: TQRDBText
        Left = 262
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          693.208333333333400000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_7: TQRDBText
        Left = 306
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          809.625000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_8: TQRDBText
        Left = 350
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          926.041666666666600000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_9: TQRDBText
        Left = 394
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1042.458333333333000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRShape11: TQRShape
        Left = 40
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          105.833333333333300000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpTotTotAtt: TQRShape
        Left = 570
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1508.125000000000000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qlblTotMM: TQRLabel
        Left = 2
        Top = 5
        Width = 38
        Height = 15
        Size.Values = (
          39.687500000000000000
          5.291666666666667000
          13.229166666666670000
          100.541666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'TOTAL'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qshpTotProCod: TQRShape
        Left = 616
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          1629.833333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape14: TQRShape
        Left = 884
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          2338.916666666667000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape15: TQRShape
        Left = 930
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          2460.625000000000000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape19: TQRShape
        Left = 1012
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          2677.583333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object dlblTotAttMM: TQRDBText
        Left = 572
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_ATT_MM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProTot_1: TQRDBText
        Left = 618
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1635.125000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROTOT_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProTot_2: TQRDBText
        Left = 662
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1751.541666666667000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROTOT_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProTot_3: TQRDBText
        Left = 706
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1867.958333333333000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROTOT_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTotProMM: TQRDBText
        Left = 886
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2344.208333333333000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_PRO_MM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTotMM: TQRDBText
        Left = 1014
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2682.875000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_MM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_10: TQRDBText
        Left = 438
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1158.875000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblNonRendTot: TQRDBText
        Left = 840
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2222.500000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_NON_REND'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qshpTotNonRend: TQRShape
        Left = 838
        Top = 0
        Width = 1
        Height = 24
        Size.Values = (
          63.500000000000000000
          2217.208333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object dlblProTot_4: TQRDBText
        Left = 750
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1984.375000000000000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROTOT_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProTot_5: TQRDBText
        Left = 794
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2100.791666666667000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROTOT_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_11: TQRDBText
        Left = 482
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1275.291666666667000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttTot_12: TQRDBText
        Left = 526
        Top = 5
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1391.708333333333000000
          13.229166666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTTOT_12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndColonne: TQRChildBand
      Left = 26
      Top = 170
      Width = 1059
      Height = 32
      Frame.DrawTop = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.666666666666680000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndIntestazione
      PrintOrder = cboAfterParent
      object qlblGiorno: TQRLabel
        Left = 12
        Top = 10
        Width = 16
        Height = 15
        Size.Values = (
          39.687500000000000000
          31.750000000000000000
          26.458333333333330000
          42.333333333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Day'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblTotAttCod: TQRLabel
        Left = 572
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Total'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblDescProgetto2: TQRDBText
        Left = 256
        Top = 2
        Width = 66
        Height = 15
        Size.Values = (
          39.687500000000000000
          677.333333333333200000
          5.291666666666667000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'DESC_PROGETTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblTotGG: TQRLabel
        Left = 1014
        Top = 10
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2682.875000000000000000
          26.458333333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'TOTAL'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblAssFestivita: TQRLabel
        Left = 932
        Top = 4
        Width = 37
        Height = 28
        Size.Values = (
          74.083333333333340000
          2465.916666666667000000
          10.583333333333330000
          97.895833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Public Holi-days'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 6
      end
      object qlblAssAltre: TQRLabel
        Left = 970
        Top = 10
        Width = 41
        Height = 15
        Size.Values = (
          39.687500000000000000
          2566.458333333333000000
          26.458333333333330000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Absences'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 6
      end
      object QRShape9: TQRShape
        Left = 1012
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2677.583333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpColAttCod: TQRShape
        Left = 40
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          105.833333333333300000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpColProCod: TQRShape
        Left = 616
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          1629.833333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpColTotAtt: TQRShape
        Left = 570
        Top = 16
        Width = 1
        Height = 16
        Size.Values = (
          42.333333333333340000
          1508.125000000000000000
          42.333333333333340000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 930
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2460.625000000000000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpRigaDiv: TQRShape
        Left = 40
        Top = 16
        Width = 799
        Height = 1
        Size.Values = (
          2.645833333333333000
          105.833333333333300000
          42.333333333333330000
          2114.020833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object qlblAltriProgetti: TQRLabel
        Left = 692
        Top = 2
        Width = 71
        Height = 14
        Size.Values = (
          37.041666666666670000
          1830.916666666667000000
          5.291666666666667000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'OTHER projects'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_1: TQRDBText
        Left = 42
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          111.125000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_2: TQRDBText
        Left = 86
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          227.541666666666700000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_3: TQRDBText
        Left = 130
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333300000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_4: TQRDBText
        Left = 174
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          460.375000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_5: TQRDBText
        Left = 218
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          576.791666666666600000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_6: TQRDBText
        Left = 262
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          693.208333333333400000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_7: TQRDBText
        Left = 306
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          809.625000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_8: TQRDBText
        Left = 350
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          926.041666666666600000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_9: TQRDBText
        Left = 394
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1042.458333333333000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProCod_1: TQRDBText
        Left = 618
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1635.125000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROCOD_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProCod_2: TQRDBText
        Left = 662
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1751.541666666667000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROCOD_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProCod_3: TQRDBText
        Left = 706
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1867.958333333333000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROCOD_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_10: TQRDBText
        Left = 438
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1158.875000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qshpColNonRend: TQRShape
        Left = 838
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2217.208333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpColTotPro: TQRShape
        Left = 884
        Top = 0
        Width = 1
        Height = 32
        Size.Values = (
          84.666666666666680000
          2338.916666666667000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qlblTotPro: TQRLabel
        Left = 886
        Top = 4
        Width = 43
        Height = 28
        Size.Values = (
          74.083333333333320000
          2344.208333333333000000
          10.583333333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = ' Total OTHER'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProCod_4: TQRDBText
        Left = 750
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1984.375000000000000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROCOD_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProCod_5: TQRDBText
        Left = 794
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2100.791666666667000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROCOD_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_11: TQRDBText
        Left = 482
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1275.291666666667000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttCod_12: TQRDBText
        Left = 526
        Top = 19
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1391.708333333333000000
          50.270833333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTCOD_12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblNonRendCod: TQRDBText
        Left = 840
        Top = 4
        Width = 43
        Height = 28
        Size.Values = (
          74.083333333333320000
          2222.500000000000000000
          10.583333333333330000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'NON_REND_COD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndDettGG: TQRSubDetail
      Left = 26
      Top = 202
      Width = 1059
      Height = 15
      Frame.DrawTop = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = bndDettGGBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        39.687500000000000000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = RepR
      FooterBand = bndTotali
      PrintBefore = False
      PrintIfEmpty = True
      object dlblDescGiorno: TQRDBText
        Left = 2
        Top = 2
        Width = 20
        Height = 15
        Size.Values = (
          39.687500000000000000
          5.291666666666667000
          5.291666666666667000
          52.916666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'DESC_GIORNO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblGiorno: TQRDBText
        Left = 24
        Top = 2
        Width = 16
        Height = 15
        Size.Values = (
          39.687500000000000000
          63.500000000000000000
          5.291666666666667000
          42.333333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'GIORNO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblGiornoPrint
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_1: TQRDBText
        Left = 42
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          111.125000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_2: TQRDBText
        Left = 86
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          227.541666666666700000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_3: TQRDBText
        Left = 130
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          343.958333333333300000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_4: TQRDBText
        Left = 174
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          460.375000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_5: TQRDBText
        Left = 218
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          576.791666666666600000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_6: TQRDBText
        Left = 262
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          693.208333333333400000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_7: TQRDBText
        Left = 306
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          809.625000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_8: TQRDBText
        Left = 350
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          926.041666666666600000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_9: TQRDBText
        Left = 394
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1042.458333333333000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTotAttGG: TQRDBText
        Left = 572
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1513.416666666667000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_ATT_GG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProHH_1: TQRDBText
        Left = 618
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1635.125000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROHH_1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProHH_2: TQRDBText
        Left = 662
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1751.541666666667000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROHH_2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProHH_3: TQRDBText
        Left = 706
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1867.958333333333000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROHH_3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTotProGG: TQRDBText
        Left = 886
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2344.208333333333000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_PRO_GG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAssFestivita: TQRDBText
        Left = 932
        Top = 2
        Width = 37
        Height = 15
        Size.Values = (
          39.687500000000000000
          2465.916666666667000000
          5.291666666666667000
          97.895833333333320000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ASS_FESTIVITA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAssAltre: TQRDBText
        Left = 970
        Top = 2
        Width = 41
        Height = 15
        Size.Values = (
          39.687500000000000000
          2566.458333333333000000
          5.291666666666667000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ASS_ALTRE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblTotGG: TQRDBText
        Left = 1014
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2682.875000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TOT_GG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRShape27: TQRShape
        Left = 40
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          105.833333333333300000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDetProCod: TQRShape
        Left = 616
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          1629.833333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDetTotAtt: TQRShape
        Left = 570
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          1508.125000000000000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape30: TQRShape
        Left = 884
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          2338.916666666667000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape31: TQRShape
        Left = 930
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          2460.625000000000000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape35: TQRShape
        Left = 1012
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          2677.583333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object dlblAttHH_10: TQRDBText
        Left = 438
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1158.875000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblNonRendHH: TQRDBText
        Left = 840
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2222.500000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'NON_REND_HH'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qshpDetNonRend: TQRShape
        Left = 838
        Top = 0
        Width = 1
        Height = 15
        Size.Values = (
          39.687500000000000000
          2217.208333333333000000
          0.000000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Brush.Color = clBlack
        Pen.Width = 2
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object dlblProHH_4: TQRDBText
        Left = 750
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1984.375000000000000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROHH_4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblProHH_5: TQRDBText
        Left = 794
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          2100.791666666667000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'PROHH_5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_11: TQRDBText
        Left = 482
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1275.291666666667000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object dlblAttHH_12: TQRDBText
        Left = 526
        Top = 2
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1391.708333333333000000
          5.291666666666667000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ATTHH_12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        OnPrint = dlblAttHH_1Print
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndFirme: TQRChildBand
      Left = 26
      Top = 241
      Width = 1059
      Height = 40
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        2801.937500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndTotali
      PrintOrder = cboAfterParent
      object qlblFirmaDip: TQRLabel
        Left = 0
        Top = 7
        Width = 200
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          18.520833333333330000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Date and signature of the Employee:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblFirmaResp: TQRLabel
        Left = 528
        Top = 7
        Width = 200
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          18.520833333333330000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Date and signature of the Supervisor:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblGiustificaRitardoDip: TQRLabel
        Left = 0
        Top = 24
        Width = 200
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          63.500000000000000000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Explanation for late submission:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object qlblGiustificaRitardoResp: TQRLabel
        Left = 528
        Top = 24
        Width = 200
        Height = 15
        Size.Values = (
          39.687500000000000000
          1397.000000000000000000
          63.500000000000000000
          529.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Explanation for late validation:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
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
    Fonthandling = False
    TextEncoding = UTF8Encoding
    Codepage = '1252'
    SuppressDateTime = False
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
