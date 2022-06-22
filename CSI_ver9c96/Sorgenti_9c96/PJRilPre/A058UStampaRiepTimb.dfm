object A058FStampaRiepTimb: TA058FStampaRiepTimb
  Left = 0
  Top = 0
  Caption = 'A058FStampaRiepTimb'
  ClientHeight = 604
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object QRRiepTimb: TQRPQuickrep
    Left = 8
    Top = 0
    Width = 794
    Height = 1123
    BeforePrint = QRRiepTimbBeforePrint
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
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
    PreviewInitialState = wsNormal
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    LabelSettings.FirstLabel = 0
    LabelSettings.LabelCount = 0
    PrepareAutomatically = False
    object QRBandTitolo: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      AlignToBottom = False
      BeforePrint = QRBandTitoloBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        156.104166666666700000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object QRlblRiepTimb: TQRLabel
        Left = 294
        Top = 14
        Width = 161
        Height = 17
        Size.Values = (
          44.979166666666670000
          777.875000000000000000
          37.041666666666670000
          425.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Riepilogo timbrature'
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
      object QrLblTimbrature: TQRLabel
        Left = 302
        Top = 40
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          799.041666666666700000
          105.833333333333300000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Timbrature'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QrLblNominativo: TQRLabel
        Left = 122
        Top = 40
        Width = 97
        Height = 17
        Size.Values = (
          44.979166666666670000
          322.791666666666700000
          105.833333333333300000
          256.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cognome Nome'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object QrLblMatricola: TQRLabel
        Left = 4
        Top = 40
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          105.833333333333300000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Matricola'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
    end
    object QRDett: TQRBand
      Left = 38
      Top = 97
      Width = 718
      Height = 24
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = QRDettBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QrEdtOra: TQRDBText
        Left = 373
        Top = 3
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          986.895833333333300000
          7.937500000000000000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QREdtData: TQRDBText
        Left = 302
        Top = 3
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          799.041666666666700000
          7.937500000000000000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QREdtNome: TQRDBText
        Left = 122
        Top = 3
        Width = 73
        Height = 17
        Size.Values = (
          44.979166666666670000
          322.791666666666700000
          7.937500000000000000
          193.145833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        OnPrint = QREdtNomePrint
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
      object QREdtMatricola: TQRDBText
        Left = 4
        Top = 3
        Width = 113
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          7.937500000000000000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        OnPrint = QREdtMatricolaPrint
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
    end
  end
end
