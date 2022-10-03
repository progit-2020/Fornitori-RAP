inherited Ac05FImportRimborsi: TAc05FImportRimborsi
  HelpContext = 1005000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<Ac05> Importazione rimborsi da agenzia viaggio'
  ClientHeight = 542
  ClientWidth = 784
  ExplicitWidth = 794
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 524
    Width = 784
    ExplicitTop = 524
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Width = 784
    ExplicitWidth = 784
  end
  object dgrdInput: TDBGrid [2]
    Left = 0
    Top = 157
    Width = 784
    Height = 350
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dgrdInputDrawColumnCell
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 29
    Width = 784
    Height = 128
    Align = alTop
    TabOrder = 3
    object lblStruttura: TLabel
      Left = 5
      Top = 2
      Width = 209
      Height = 13
      Align = alCustom
      Caption = 'Configurazione per l'#39'importazione dei rimborsi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNomeFile: TLabel
      Left = 5
      Top = 43
      Width = 205
      Height = 13
      Align = alCustom
      Caption = 'Nome file contenente i rimborsi da importare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 84
      Width = 77
      Height = 13
      Align = alCustom
      Caption = 'Tipo pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblTipoPagamento: TDBText
      Left = 128
      Top = 103
      Width = 137
      Height = 17
      DataField = 'TIPO_SOMMA_PAGAMENTO'
      DataSource = Ac05FImportRimborsiDM.dsrCdsIA100
    end
    object dcmbStruttura: TDBLookupComboBox
      Left = 5
      Top = 17
      Width = 343
      Height = 21
      DataField = 'NOME_STRUTTURA'
      DataSource = Ac05FImportRimborsiDM.dsrCdsIA100
      DropDownRows = 10
      DropDownWidth = 600
      KeyField = 'NOME_STRUTTURA'
      ListField = 'NOME_STRUTTURA;NOME_FILE'
      ListSource = Ac05FImportRimborsiDM.dsrIA100
      NullValueKey = 46
      TabOrder = 0
    end
    object btnImportRimborsi: TButton
      Left = 366
      Top = 95
      Width = 115
      Height = 25
      Action = actImportaRimborsi
      Caption = 'Importa file su tabella'
      TabOrder = 6
    end
    object btnCollegaRimborsi: TButton
      Left = 487
      Top = 95
      Width = 147
      Height = 25
      Action = actCollegaRimborsi
      Caption = 'Collega rimborsi alle missioni'
      TabOrder = 7
    end
    object rgpFiltro: TRadioGroup
      Left = 366
      Top = 46
      Width = 369
      Height = 31
      Caption = 'Filtro rimborsi'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Non collegati'
        'Collegati'
        'Entrambi')
      ParentFont = False
      TabOrder = 5
      OnClick = rgpFiltroClick
    end
    object chkSoloDipendenti: TCheckBox
      Left = 366
      Top = 18
      Width = 184
      Height = 19
      Caption = 'Elabora solo dipendenti selezionati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkSoloDipendentiClick
    end
    object btnAnomalie: TBitBtn
      Left = 640
      Top = 95
      Width = 95
      Height = 25
      Caption = '&Anomalie'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 8
      OnClick = btnAnomalieClick
    end
    object btnNomeFile: TButton
      Left = 333
      Top = 58
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 2
      OnClick = btnNomeFileClick
    end
    object edtNomeFile: TEdit
      Left = 5
      Top = 58
      Width = 327
      Height = 21
      TabOrder = 1
      Text = 'edtNomeFile'
    end
    object dcmbTipoPagamento: TDBLookupComboBox
      Left = 5
      Top = 99
      Width = 116
      Height = 21
      DataField = 'CODICE_PAGAMENTO'
      DataSource = Ac05FImportRimborsiDM.dsrCdsIA100
      DropDownRows = 10
      DropDownWidth = 200
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = Ac05FImportRimborsiDM.dsrM049
      NullValueKey = 46
      TabOrder = 3
    end
  end
  object ProgressBar1: TProgressBar [4]
    Left = 0
    Top = 507
    Width = 784
    Height = 17
    Align = alBottom
    TabOrder = 4
  end
  inherited MainMenu1: TMainMenu
    Left = 504
    Top = 65530
  end
  inherited DButton: TDataSource
    DataSet = Ac05FImportRimborsiDM.selInputDati
    Left = 468
    Top = 65530
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 440
    Top = 65530
  end
  inherited ImageList1: TImageList
    Left = 404
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 376
    Top = 65530
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actStampa: TAction
      Visible = False
    end
    inherited actGomma: TAction
      Visible = False
    end
    object actImportaRimborsi: TAction
      Caption = 'actImportaRimborsi'
      Hint = 'Importa file su database'
      OnExecute = actImportaRimborsiExecute
    end
    object actCollegaRimborsi: TAction
      Caption = 'actCollegaRimborsi'
      Hint = 'Collega rimborsi alle missioni'
      OnExecute = actCollegaRimborsiExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 328
    Top = 349
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Microsoft Excel|*.xls;*.xlsx'
    Left = 540
    Top = 65530
  end
end
