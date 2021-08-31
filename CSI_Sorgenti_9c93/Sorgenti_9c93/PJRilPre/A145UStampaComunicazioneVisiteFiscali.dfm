inherited A145FStampaComunicazioneVisiteFiscali: TA145FStampaComunicazioneVisiteFiscali
  Caption = '<A145> Stampa comunicazioni'
  ClientHeight = 722
  ClientWidth = 1172
  Position = poDesigned
  ExplicitWidth = 1188
  ExplicitHeight = 760
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    Width = 1123
    Height = 794
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter, Compression]
    Page.Orientation = poLandscape
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    ExplicitWidth = 1123
    ExplicitHeight = 794
    inherited Titolo: TQRBand
      Width = 1047
      Height = 61
      Size.Values = (
        161.395833333333300000
        2770.187500000000000000)
      BandType = rbPageHeader
      ExplicitWidth = 1047
      ExplicitHeight = 61
      inherited LEnte: TQRLabel
        Left = 498
        Size.Values = (
          50.270833333333330000
          1317.625000000000000000
          0.000000000000000000
          134.937500000000000000)
        FontSize = 12
        ExplicitLeft = 498
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
        Left = 495
        Size.Values = (
          50.270833333333330000
          1309.687500000000000000
          63.500000000000000000
          150.812500000000000000)
        FontSize = 10
        ExplicitLeft = 495
      end
      inherited qlblSysPagina: TQRSysData
        Left = 997
        Size.Values = (
          39.687500000000000000
          2637.895833333333000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
        ExplicitLeft = 997
      end
    end
    object QRBDettaglio: TQRBand
      Left = 38
      Top = 199
      Width = 1047
      Height = 21
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QRBDettaglioBeforePrint
      Color = clWhite
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
        55.562500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBTNomeCognome: TQRDBText
        Left = 41
        Top = 3
        Width = 260
        Height = 15
        Size.Values = (
          39.687500000000000000
          108.479166666666700000
          7.937500000000000000
          687.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'NOMECOGNOME'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBTPrognosi: TQRDBText
        Left = 830
        Top = 3
        Width = 66
        Height = 15
        Size.Values = (
          39.687500000000000000
          2196.041666666667000000
          7.937500000000000000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'Prognosi'
        OnPrint = QRDBTPrognosiPrint
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBTNumAssenze: TQRDBText
        Left = 913
        Top = 3
        Width = 35
        Height = 15
        Size.Values = (
          39.687500000000000000
          2415.645833333333000000
          7.937500000000000000
          92.604166666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'NumAssenze'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBTGiorniAssenza: TQRDBText
        Left = 978
        Top = 3
        Width = 42
        Height = 15
        Size.Values = (
          39.687500000000000000
          2587.625000000000000000
          7.937500000000000000
          111.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'GiorniAssenza'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRDBTOperazione: TQRDBText
        Left = 778
        Top = 3
        Width = 45
        Height = 17
        Size.Values = (
          44.979166666666670000
          2058.458333333333000000
          7.937500000000000000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'Operazione'
        OnPrint = QRDBTOperazionePrint
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRShape1: TQRShape
        Left = 773
        Top = 0
        Width = 4
        Height = 21
        Size.Values = (
          55.562500000000000000
          2045.229166666667000000
          0.000000000000000000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 826
        Top = 0
        Width = 2
        Height = 21
        Size.Values = (
          55.562500000000000000
          2185.458333333333000000
          0.000000000000000000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape3: TQRShape
        Left = 909
        Top = 1
        Width = 2
        Height = 21
        Size.Values = (
          55.562500000000000000
          2405.062500000000000000
          2.645833333333333000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape4: TQRShape
        Left = 970
        Top = 0
        Width = 4
        Height = 21
        Size.Values = (
          55.562500000000000000
          2566.458333333333000000
          0.000000000000000000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRDBTDataPrimaComunicazione: TQRDBText
        Left = 308
        Top = 3
        Width = 90
        Height = 15
        Size.Values = (
          39.687500000000000000
          814.916666666666800000
          7.937500000000000000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'DATAPRIMACOMUNICAZIONE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRLGiaComunicato: TQRLabel
        Left = 4
        Top = 3
        Width = 30
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          7.937500000000000000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'QRLGiaComunicato'
        Color = clWhite
        OnPrint = QRLGiaComunicatoPrint
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object QRCBDettaglio: TQRChildBand
      Left = 38
      Top = 220
      Width = 1047
      Height = 22
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QRCBDettaglioBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = True
      ParentBand = QRBDettaglio
      PrintOrder = cboAfterParent
      object QRShape9: TQRShape
        Left = 773
        Top = 0
        Width = 4
        Height = 21
        Size.Values = (
          55.562500000000000000
          2045.229166666667000000
          0.000000000000000000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape10: TQRShape
        Left = 826
        Top = 0
        Width = 2
        Height = 21
        Size.Values = (
          55.562500000000000000
          2185.458333333333000000
          0.000000000000000000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape11: TQRShape
        Left = 909
        Top = 0
        Width = 2
        Height = 21
        Size.Values = (
          55.562500000000000000
          2405.062500000000000000
          0.000000000000000000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRShape12: TQRShape
        Left = 970
        Top = 0
        Width = 4
        Height = 21
        Size.Values = (
          55.562500000000000000
          2566.458333333333000000
          0.000000000000000000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLPeriodoAssenza: TQRLabel
        Left = 41
        Top = 2
        Width = 260
        Height = 15
        Size.Values = (
          39.687500000000000000
          108.479166666666700000
          5.291666666666667000
          687.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'QRLPeriodoAssenza'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        OnPrint = QRLPeriodoAssenzaPrint
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLSuddivisionePeriodo: TQRLabel
        Left = 830
        Top = 2
        Width = 66
        Height = 15
        Size.Values = (
          39.687500000000000000
          2196.041666666667000000
          5.291666666666667000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'QRLSuddivisionePeriodo'
        Color = clWhite
        OnPrint = QRLSuddivisionePeriodoPrint
        Transparent = False
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRDBTDomicilio: TQRDBText
        Left = 308
        Top = 2
        Width = 463
        Height = 15
        Size.Values = (
          39.687500000000000000
          814.916666666666800000
          5.291666666666667000
          1225.020833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'C_Domicilio'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRShapeDettSX: TQRShape
        Left = 783
        Top = 17
        Height = 1
        Size.Values = (
          2.645833333333333000
          2071.687500000000000000
          44.979166666666670000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsHorLine
        VertAdjust = 0
      end
    end
    object QRGroupMedLegale: TQRGroup
      Left = 38
      Top = 99
      Width = 1047
      Height = 40
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = True
      Size.Values = (
        105.833333333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = True
      Expression = 'TabellaStampa.MedLegDesc'
      Master = QRep
      ReprintOnNewPage = False
      object QRDBText1: TQRDBText
        Left = 4
        Top = 7
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          18.520833333333330000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MedLegDesc'
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
      object QRLabel1: TQRLabel
        Left = 656
        Top = 7
        Width = 387
        Height = 15
        Size.Values = (
          39.687500000000000000
          1735.666666666667000000
          18.520833333333330000
          1023.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = '(*)INS=Inserimento PROL=Prolungamento CAN=Cancellazione'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 796
        Top = 23
        Width = 247
        Height = 15
        Size.Values = (
          39.687500000000000000
          2106.083333333333000000
          60.854166666666680000
          653.520833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Prognosi vuota se manca certificato'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRDBText2: TQRDBText
        Left = 471
        Top = 7
        Width = 64
        Height = 15
        Size.Values = (
          39.687500000000000000
          1246.187500000000000000
          18.520833333333330000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MedLegTel'
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
      object QRDBText3: TQRDBText
        Left = 44
        Top = 23
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          116.416666666666700000
          60.854166666666670000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MedLegEmail'
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
      object QRLabel3: TQRLabel
        Left = 439
        Top = 7
        Width = 30
        Height = 15
        Size.Values = (
          39.687500000000000000
          1161.520833333333000000
          18.520833333333330000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Tel.'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 4
        Top = 23
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          10.583333333333330000
          60.854166666666680000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Email'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRDBText4: TQRDBText
        Left = 367
        Top = 23
        Width = 106
        Height = 15
        Size.Values = (
          39.687500000000000000
          971.020833333333300000
          60.854166666666670000
          280.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MedLegIndirizzo'
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
      object QRDBText5: TQRDBText
        Left = 655
        Top = 23
        Width = 85
        Height = 15
        Size.Values = (
          39.687500000000000000
          1733.020833333333000000
          60.854166666666670000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MedLegComune'
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
      object QRLabel5: TQRLabel
        Left = 334
        Top = 23
        Width = 30
        Height = 15
        Size.Values = (
          39.687500000000000000
          883.708333333333400000
          60.854166666666680000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Ind. '
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
    end
    object QRBIntestazione: TQRChildBand
      Left = 38
      Top = 139
      Width = 1047
      Height = 60
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        158.750000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = QRGroupMedLegale
      PrintOrder = cboAfterParent
      object QRLGiaComunicatoLbl: TQRLabel
        Left = 4
        Top = 4
        Width = 30
        Height = 35
        Size.Values = (
          92.604166666666680000
          10.583333333333330000
          10.583333333333330000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Gi'#224' com.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
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
      object QRLNomeCognomeLbl: TQRLabel
        Left = 41
        Top = 4
        Width = 260
        Height = 15
        Size.Values = (
          39.687500000000000000
          108.479166666666700000
          10.583333333333330000
          687.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Cognome e Nome'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
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
      object QRLPeriodoAssenzaLbl: TQRLabel
        Left = 41
        Top = 25
        Width = 260
        Height = 15
        Size.Values = (
          39.687500000000000000
          108.479166666666700000
          66.145833333333320000
          687.916666666666800000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Periodo assenza'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
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
      object QRLPrimaComunicazioneLbl: TQRLabel
        Left = 308
        Top = 4
        Width = 90
        Height = 15
        Size.Values = (
          39.687500000000000000
          814.916666666666800000
          10.583333333333330000
          238.125000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Prima comun.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLDomicilioLbl: TQRLabel
        Left = 308
        Top = 25
        Width = 148
        Height = 15
        Size.Values = (
          39.687500000000000000
          814.916666666666700000
          66.145833333333330000
          391.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Residenza o domicilio'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape5: TQRShape
        Left = 773
        Top = 0
        Width = 4
        Height = 60
        Size.Values = (
          158.750000000000000000
          2045.229166666667000000
          0.000000000000000000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLTipoOperazioneLbl: TQRLabel
        Left = 778
        Top = 4
        Width = 45
        Height = 45
        Size.Values = (
          119.062500000000000000
          2058.458333333333000000
          10.583333333333330000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Tipo oper. (*)'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape6: TQRShape
        Left = 826
        Top = 0
        Width = 2
        Height = 60
        Size.Values = (
          158.750000000000000000
          2185.458333333333000000
          0.000000000000000000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLPrognosiLbl: TQRLabel
        Left = 830
        Top = 4
        Width = 60
        Height = 45
        Size.Values = (
          119.062500000000000000
          2196.041666666667000000
          10.583333333333330000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Prognosi (giorni)'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRLabel8: TQRLabel
        Left = 913
        Top = 4
        Width = 128
        Height = 29
        Size.Values = (
          76.729166666666680000
          2415.645833333333000000
          10.583333333333330000
          338.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Malattie negli ultimi dodici mesi'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape7: TQRShape
        Left = 909
        Top = 0
        Width = 2
        Height = 60
        Size.Values = (
          158.750000000000000000
          2405.062500000000000000
          0.000000000000000000
          5.291666666666667000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLabel9: TQRLabel
        Left = 913
        Top = 40
        Width = 56
        Height = 15
        Size.Values = (
          39.687500000000000000
          2415.645833333333000000
          105.833333333333300000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Eventi'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape17: TQRShape
        Left = 909
        Top = 33
        Width = 136
        Height = 7
        Size.Values = (
          18.520833333333330000
          2405.062500000000000000
          87.312500000000000000
          359.833333333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel10: TQRLabel
        Left = 978
        Top = 40
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          2587.625000000000000000
          105.833333333333300000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        Caption = 'Giorni'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 8
      end
      object QRShape8: TQRShape
        Left = 970
        Top = 37
        Width = 4
        Height = 25
        Size.Values = (
          66.145833333333340000
          2566.458333333333000000
          97.895833333333340000
          10.583333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Shape = qrsVertLine
        VertAdjust = 0
      end
    end
    object QRCBNote: TQRChildBand
      Left = 38
      Top = 242
      Width = 1047
      Height = 22
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QRCBNoteBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333320000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = QRCBDettaglio
      PrintOrder = cboAfterParent
      object QRDBNote: TQRDBText
        Left = 76
        Top = 3
        Width = 961
        Height = 15
        Size.Values = (
          39.687500000000000000
          201.083333333333300000
          7.937500000000000000
          2542.645833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'Note'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 8
      end
      object QRlblNote: TQRLabel
        Left = 41
        Top = 3
        Width = 29
        Height = 15
        Frame.Style = psClear
        Size.Values = (
          39.687500000000000000
          108.479166666666700000
          7.937500000000000000
          76.729166666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Note'
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
  end
end
