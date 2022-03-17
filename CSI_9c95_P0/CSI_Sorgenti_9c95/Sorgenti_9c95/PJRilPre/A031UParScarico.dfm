inherited A031FParScarico: TA031FParScarico
  Left = 211
  Top = 190
  HelpContext = 31000
  Caption = '<A031> Regole acquisizione timbrature'
  ClientHeight = 434
  ClientWidth = 657
  ExplicitWidth = 673
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 416
    Width = 657
    ExplicitTop = 416
    ExplicitWidth = 657
  end
  inherited Panel1: TToolBar
    Width = 657
    ExplicitWidth = 657
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 657
    Height = 387
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = -1
      Width = 68
      Height = 13
      Caption = 'Nome scarico:'
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 139
      Top = -1
      Width = 80
      Height = 13
      Caption = 'Aziende abilitate:'
      FocusControl = dedtAziende
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOffsetAnno: TLabel
      Left = 128
      Top = 64
      Width = 73
      Height = 13
      Caption = 'Offset dell'#39'anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 4
      Top = 13
      Width = 124
      Height = 21
      DataField = 'SCARICO'
      DataSource = DButton
      TabOrder = 0
    end
    object DBCheckBox1: TDBCheckBox
      Left = 4
      Top = 40
      Width = 111
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Scarico automatico'
      DataField = 'CORRENTE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 157
      Width = 651
      Height = 227
      Align = alBottom
      Caption = 'File sequenziale di input'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object Label2: TLabel
        Left = 6
        Top = 16
        Width = 47
        Height = 13
        Caption = 'Nome file:'
        FocusControl = DBEdit2
      end
      object Label4: TLabel
        Left = 413
        Top = 101
        Width = 54
        Height = 13
        Caption = 'IP Address:'
        FocusControl = EIPAddress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label3: TLabel
        Left = 6
        Top = 100
        Width = 84
        Height = 13
        Caption = 'Codice di Entrata:'
        FocusControl = DBEdit1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 149
        Top = 100
        Width = 80
        Height = 13
        Caption = 'Codice di Uscita:'
        FocusControl = DBEdit1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblExprChiave: TLabel
        Left = 6
        Top = 57
        Width = 95
        Height = 13
        Caption = 'Espressione chiave:'
        FocusControl = DBEdit1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBEdit2: TDBEdit
        Left = 6
        Top = 31
        Width = 512
        Height = 21
        DataField = 'NOMEFILE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBCheckBox2: TDBCheckBox
        Left = 297
        Top = 99
        Width = 109
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Protocollo TCP/IP'
        DataField = 'TCP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        Visible = False
        OnClick = DBCheckBox2Click
      end
      object EIPAddress: TDBEdit
        Left = 473
        Top = 97
        Width = 94
        Height = 21
        DataField = 'IPADDRESS'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Visible = False
      end
      object Button1: TButton
        Left = 521
        Top = 31
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = Button1Click
      end
      object DBEdit3: TDBEdit
        Left = 104
        Top = 97
        Width = 23
        Height = 21
        DataField = 'ENTRATA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object DBEdit4: TDBEdit
        Left = 235
        Top = 97
        Width = 23
        Height = 21
        DataField = 'USCITA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 124
        Width = 641
        Height = 98
        Align = alBottom
        Caption = 'Mappatura dei dati sul file di input'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object StringGrid1: TStringGrid
          Left = 2
          Top = 15
          Width = 637
          Height = 81
          Align = alClient
          ColCount = 13
          DefaultRowHeight = 18
          RowCount = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          ParentFont = False
          TabOrder = 0
          ColWidths = (
            64
            64
            64
            64
            62
            64
            64
            64
            64
            64
            64
            64
            64)
          RowHeights = (
            18
            18
            18)
        end
      end
      object dedtExprChiave: TDBEdit
        Left = 6
        Top = 72
        Width = 512
        Height = 21
        Color = clSilver
        DataField = 'EXPR_CHIAVE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object btnEditExprChiave: TButton
        Left = 521
        Top = 72
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = btnEditExprChiaveClick
      end
    end
    object DBCheckBox3: TDBCheckBox
      Left = 4
      Top = 63
      Width = 111
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Scarico Dating'
      DataField = 'TIPOSCARICO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = DBCheckBox3Click
    end
    object DBCheckBox4: TDBCheckBox
      Left = 276
      Top = 40
      Width = 210
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Procedura Oracle prima dell'#39'acquisizione'
      DataField = 'TRIGGER_BEFORE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox5: TDBCheckBox
      Left = 290
      Top = 63
      Width = 196
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Procedura Oracle dopo l'#39'acquisizione'
      DataField = 'TRIGGER_AFTER'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dedtAziende: TDBEdit
      Left = 139
      Top = 13
      Width = 347
      Height = 21
      Color = clSilver
      DataField = 'AZIENDE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object btnAziende: TButton
      Left = 487
      Top = 13
      Width = 20
      Height = 21
      Caption = '...'
      TabOrder = 2
      OnClick = btnAziendeClick
    end
    object drgpTipologiaTimbrature: TDBRadioGroup
      Left = 521
      Top = 0
      Width = 129
      Height = 69
      Caption = 'Tipologia timbrature'
      DataField = 'FUNZIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Presenza'
        'Mensa'
        'Presenza/Mensa')
      ParentFont = False
      TabOrder = 3
      Values.Strings = (
        'P'
        'M'
        'E')
    end
    object GroupBox3: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 87
      Width = 651
      Height = 64
      Align = alBottom
      Caption = 'Periodo di tolleranza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      object Label7: TLabel
        Left = 15
        Top = 18
        Width = 186
        Height = 13
        Caption = 'Giorni precedenti alla data elaborazione'
      end
      object Label8: TLabel
        Left = 15
        Top = 41
        Width = 185
        Height = 13
        Caption = 'Giorni successivi alla data elaborazione'
      end
      object dchkTimbNonTollLog: TDBCheckBox
        Left = 392
        Top = 17
        Width = 250
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Segnala anomalia se la timbratura '#232' fuori periodo'
        DataField = 'TIMB_NONTOLL_LOG'
        DataSource = DButton
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkTimbNonTollReg: TDBCheckBox
        Left = 438
        Top = 40
        Width = 204
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Registra la timbratura se '#232' fuori periodo'
        DataField = 'TIMB_NONTOLL_REG'
        DataSource = DButton
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dedtTimbNonTollGgPrec: TDBEdit
        Left = 208
        Top = 15
        Width = 39
        Height = 21
        DataField = 'TIMB_NONTOLL_GGPREC'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = dedtTimbNonTollGgPrecExit
      end
      object dedtTimbNonTollGgSucc: TDBEdit
        Left = 208
        Top = 38
        Width = 39
        Height = 21
        DataField = 'TIMB_NONTOLL_GGSUCC'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = dedtTimbNonTollGgSuccExit
      end
    end
    object dedtOffsetAnno: TDBEdit
      Left = 204
      Top = 61
      Width = 33
      Height = 21
      DataField = 'OFFSET_ANNO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnExit = dedtTimbNonTollGgPrecExit
    end
    object btnSrcTriggerBefore: TBitBtn
      Left = 491
      Top = 37
      Width = 23
      Height = 23
      Hint = 'Sorgente pl/sql'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnSrcTriggerBeforeClick
    end
    object btnSrcTriggerAfter: TBitBtn
      Left = 491
      Top = 60
      Width = 23
      Height = 23
      Hint = 'Sorgente pl/sql'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = btnSrcTriggerBeforeClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 408
    Top = 2
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 436
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 464
    Top = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 492
    Top = 2
  end
end
