inherited R003FStampa: TR003FStampa
  Left = 101
  Top = 167
  Caption = 'R003FStampa'
  ClientHeight = 482
  ClientWidth = 830
  OnDestroy = FormDestroy
  ExplicitWidth = 840
  ExplicitHeight = 512
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
    OnApplyPrinterSettings = QRepApplyPrinterSettings
    inherited Titolo: TQRBand
      Height = 43
      BeforePrint = TitoloBeforePrint
      Size.Values = (
        113.770833333333300000
        1899.708333333333000000)
      BandType = rbPageHeader
      ExplicitHeight = 43
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
        Top = 22
        Size.Values = (
          50.270833333333330000
          873.125000000000000000
          58.208333333333340000
          150.812500000000000000)
        FontSize = 10
        ExplicitTop = 22
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
    object BColonne: TQRBand
      Left = 38
      Top = 121
      Width = 718
      Height = 40
      Frame.DrawBottom = True
      AfterPrint = BColonneAfterPrint
      AlignToBottom = False
      BeforePrint = BColonneBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
    end
    object BRigaTabella: TQRBand
      Left = 38
      Top = 253
      Width = 718
      Height = 12
      AlignToBottom = False
      BeforePrint = BRigaTabellaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        31.750000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object BSommario: TQRBand
      Left = 38
      Top = 345
      Width = 718
      Height = 40
      Frame.DrawTop = True
      AfterPrint = BandaAfterPrint
      AlignToBottom = False
      BeforePrint = BSommarioBeforePrint
      TransparentBand = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
    end
    object BIntestazione: TQRGroup
      Left = 38
      Top = 161
      Width = 718
      Height = 40
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AfterPrint = BIntestazioneAfterPrint
      AlignToBottom = False
      BeforePrint = BIntestazioneBeforePrint
      TransparentBand = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      FooterBand = BTotali
      Master = QRep
      ReprintOnNewPage = False
    end
    object BTotali: TQRBand
      Left = 38
      Top = 305
      Width = 718
      Height = 40
      Frame.DrawTop = True
      AfterPrint = BandaAfterPrint
      AlignToBottom = False
      BeforePrint = BTotaliBeforePrint
      TransparentBand = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
    end
    object BGruppoProg: TQRGroup
      Left = 38
      Top = 241
      Width = 718
      Height = 12
      AlignToBottom = False
      BeforePrint = BGruppoProgBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        31.750000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'STR(cds920.PROGRESSIVO)'
      FooterBand = BDettaglio
      Master = QRep
      ReprintOnNewPage = False
    end
    object BDettaglio: TQRBand
      Left = 38
      Top = 265
      Width = 718
      Height = 40
      AfterPrint = BandaAfterPrint
      AlignToBottom = False
      BeforePrint = BDettaglioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
    end
    object BIntestazioneColonne: TQRChildBand
      Left = 38
      Top = 201
      Width = 718
      Height = 40
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = BColonneBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = BIntestazione
      PrintOrder = cboAfterParent
    end
    object BPaginaIntestazione: TQRChildBand
      Left = 38
      Top = 81
      Width = 718
      Height = 40
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Titolo
      PrintOrder = cboAfterParent
    end
  end
  inherited QRPDFFilter1: TQRPDFFilter
    Left = 176
  end
end
