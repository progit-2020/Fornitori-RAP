inherited A174FParPianifTurni: TA174FParPianifTurni
  HelpContext = 17400
  Caption = '<A174> Profili di pianificazione'
  ClientHeight = 537
  ClientWidth = 550
  ExplicitWidth = 566
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 519
    Width = 550
    ExplicitTop = 519
    ExplicitWidth = 550
  end
  inherited Panel1: TToolBar
    Width = 550
    ExplicitWidth = 550
  end
  object PgCtrlParametri: TPageControl [2]
    Left = 0
    Top = 67
    Width = 550
    Height = 452
    ActivePage = TSheetStampa
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object TSheetVisualizzazione: TTabSheet
      Caption = 'Pianificazione'
      object dRgModLavoro: TDBRadioGroup
        Left = 3
        Top = 3
        Width = 182
        Height = 95
        Caption = 'Modalit'#224' di lavoro'
        Columns = 2
        DataField = 'MODALITA_LAVORO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Operativa'
          'Non operativa')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'O'
          'N')
        OnClick = dRgModLavoroClick
      end
      object grpOpzioniPianif: TGroupBox
        Left = 2
        Top = 104
        Width = 528
        Height = 68
        Caption = 'Opzioni pianificazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dChkPianifGGFest: TDBCheckBox
          Left = 10
          Top = 19
          Width = 152
          Height = 17
          Caption = 'Pianificazione giorni festivi'
          DataField = 'PIANIF_GG_FEST'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkPinifSoloTurnista: TDBCheckBox
          Left = 316
          Top = 19
          Width = 196
          Height = 17
          Caption = 'Pianificazione solo se gestione turnista'
          DataField = 'PIANIF_SOLO_TURN'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkPianifGGAss: TDBCheckBox
          Left = 10
          Top = 42
          Width = 218
          Height = 17
          Caption = 'Pianificazione orario su giorni di assenza'
          DataField = 'PIANIF_GG_ASS'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkGiustifOperativi: TDBCheckBox
          Left = 316
          Top = 42
          Width = 125
          Height = 17
          Caption = 'Giustificativi operativi'
          DataField = 'ASSENZE_OPERATIVE'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpBoxProgressiva: TGroupBox
        Left = 2
        Top = 178
        Width = 528
        Height = 62
        Caption = 'Pianificazione progressiva'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object dchkGenera: TDBCheckBox
          Left = 9
          Top = 18
          Width = 166
          Height = 17
          Caption = 'Genera pianif. iniziale'
          DataField = 'GENERAZIONE'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkGeneraClick
        end
        object dchkIniziale: TDBCheckBox
          Left = 182
          Top = 18
          Width = 157
          Height = 17
          Caption = 'Visualizza pianif.iniziale'
          DataField = 'INIZIALE'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkCorrente: TDBCheckBox
          Left = 366
          Top = 18
          Width = 133
          Height = 17
          Caption = 'Visualizza pianif.corrente'
          DataField = 'CORRENTE'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkRendiOperativa: TDBCheckBox
          Left = 9
          Top = 38
          Width = 97
          Height = 17
          Caption = 'Rendi operativa'
          DataField = 'RENDI_OPERATIVA'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpOrd_Visualizzazione: TGroupBox
        Left = 191
        Top = 3
        Width = 339
        Height = 95
        Caption = 'Ordinamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblListaDati: TLabel
          Left = 6
          Top = 15
          Width = 103
          Height = 13
          Caption = 'Lista dati ordinamento'
        end
        object lblOrdVis: TLabel
          Left = 175
          Top = 15
          Width = 60
          Height = 13
          Caption = 'Ordinamento'
        end
        object lstElencoOrd: TListBox
          Left = 5
          Top = 29
          Width = 150
          Height = 58
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnDblClick = lstElencoOrdDblClick
        end
        object lstOrdinamento: TListBox
          Left = 175
          Top = 29
          Width = 150
          Height = 58
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnDblClick = lstOrdinamentoDblClick
          OnDragDrop = lstOrdinamentoDragDrop
          OnDragOver = lstOrdinamentoDragOver
          OnMouseDown = lstOrdinamentoMouseDown
        end
      end
    end
    object TSheetStampa: TTabSheet
      Caption = 'Stampa'
      ImageIndex = 1
      object lblTitolo: TLabel
        Left = 2
        Top = 3
        Width = 29
        Height = 13
        Caption = 'Titolo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDesc1: TLabel
        Left = 2
        Top = 43
        Width = 67
        Height = 13
        Caption = 'Descrizione 1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDesc2: TLabel
        Left = 290
        Top = 43
        Width = 67
        Height = 13
        Caption = 'Descrizione 2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 2
        Top = 84
        Width = 87
        Height = 13
        Caption = 'Note a pi'#232' pagina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMarginesx: TLabel
        Left = 3
        Top = 360
        Width = 54
        Height = 13
        Caption = 'Margine sx:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDimFont: TLabel
        Left = 3
        Top = 382
        Width = 79
        Height = 13
        Caption = 'Dimensione font:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNumGG: TLabel
        Left = 3
        Top = 404
        Width = 98
        Height = 13
        Caption = 'Num. giorni per pag.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOPagina: TLabel
        Left = 267
        Top = 404
        Width = 101
        Height = 13
        Caption = 'Orientamento pagina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCauEsclusione: TLabel
        Left = 3
        Top = 338
        Width = 117
        Height = 13
        Caption = 'Causali esclusione turno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDatoAnag: TLabel
        Left = 267
        Top = 377
        Width = 79
        Height = 13
        Caption = 'Dato anagrafico:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtTitolo: TDBEdit
        Left = 2
        Top = 17
        Width = 528
        Height = 21
        DataField = 'TITOLO'
        DataSource = DButton
        TabOrder = 0
      end
      object dEdtDesc1: TDBEdit
        Left = 2
        Top = 56
        Width = 240
        Height = 21
        DataField = 'DESCRIZIONE1'
        DataSource = DButton
        TabOrder = 1
      end
      object dEdtDesc2: TDBEdit
        Left = 290
        Top = 56
        Width = 240
        Height = 21
        DataField = 'DESCRIZIONE2'
        DataSource = DButton
        TabOrder = 2
      end
      object dEdtNotePagina: TDBEdit
        Left = 2
        Top = 98
        Width = 528
        Height = 21
        DataField = 'NOTE_STAMPA'
        DataSource = DButton
        TabOrder = 3
      end
      object drgDettStampa: TDBRadioGroup
        Left = 3
        Top = 122
        Width = 185
        Height = 39
        Caption = 'Dettaglio stampa'
        Columns = 2
        DataField = 'DETT_STAMPA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Sintetica'
          'Dettagliata')
        ParentFont = False
        TabOrder = 4
        Values.Strings = (
          'S'
          'D')
        OnClick = drgDettStampaClick
      end
      object drgRigheDip: TDBRadioGroup
        Left = 194
        Top = 122
        Width = 336
        Height = 39
        Caption = 'Righe per dipendente'
        Columns = 3
        DataField = 'RIGHE_DIP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          '2'
          '3'
          '4')
        ParentFont = False
        TabOrder = 5
        Values.Strings = (
          '2'
          '3'
          '4')
      end
      object dgrTipoStampa: TDBRadioGroup
        Left = 3
        Top = 162
        Width = 215
        Height = 84
        Caption = 'Tipo stampa'
        DataField = 'TIPO_STAMPA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Stampa preventiva(da pianificazione)'
          'Stampa consuntiva(da conteggi)')
        ParentFont = False
        TabOrder = 6
        Values.Strings = (
          'P'
          'C')
        OnClick = dgrTipoStampaClick
      end
      object grpDatiOpzionali: TGroupBox
        Left = 2
        Top = 250
        Width = 528
        Height = 80
        Caption = 'Dati opzionali da stampare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        object dChkTotTurni: TDBCheckBox
          Left = 10
          Top = 15
          Width = 97
          Height = 17
          Caption = 'Totali per turno'
          DataField = 'TOT_TURNO'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dChkTotTurniClick
        end
        object dchkTotTurnoOpe: TDBCheckBox
          Left = 10
          Top = 30
          Width = 143
          Height = 17
          Caption = 'Totali turno per operatori'
          DataField = 'TOT_OPE_TURNO'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTotCopertura: TDBCheckBox
          Left = 10
          Top = 45
          Width = 143
          Height = 17
          Caption = 'Totali copertura turni'
          DataField = 'TOT_GENERALI'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkToTurnitMese: TDBCheckBox
          Left = 195
          Top = 15
          Width = 143
          Height = 17
          Caption = 'Totali turni nel mese'
          DataField = 'TOT_TURNI_MESE'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkDettOrari: TDBCheckBox
          Left = 195
          Top = 30
          Width = 143
          Height = 17
          Caption = 'Dettaglio orari'
          DataField = 'DETT_ORARI'
          DataSource = DButton
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkTotLiquid: TDBCheckBox
          Left = 195
          Top = 45
          Width = 143
          Height = 17
          Caption = 'Totali liquidabile'
          DataField = 'TOT_LIQUIDABILE'
          DataSource = DButton
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkAssenze: TDBCheckBox
          Left = 385
          Top = 15
          Width = 118
          Height = 17
          Caption = 'Assenze'
          DataField = 'ASSENZE'
          DataSource = DButton
          TabOrder = 6
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkSaldiOre: TDBCheckBox
          Left = 385
          Top = 30
          Width = 106
          Height = 17
          Caption = 'Saldi ore'
          DataField = 'SALDI_ORE'
          DataSource = DButton
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkRigheNome: TDBCheckBox
          Left = 195
          Top = 60
          Width = 118
          Height = 17
          Caption = 'Nome su 2 righe'
          DataField = 'RIGHE_NOME'
          DataSource = DButton
          TabOrder = 8
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkVisOrario: TDBCheckBox
          Left = 10
          Top = 60
          Width = 97
          Height = 17
          Caption = 'Vis.orario'
          DataField = 'ORARIO_SINTETICO'
          DataSource = DButton
          TabOrder = 9
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkSeparatoreCol: TDBCheckBox
          Left = 385
          Top = 45
          Width = 125
          Height = 17
          Caption = 'Separatore di colonne'
          DataField = 'SEPARATORE_COL'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkSepratoreRighe: TDBCheckBox
          Left = 385
          Top = 60
          Width = 118
          Height = 15
          Caption = 'Separatore di righe'
          DataField = 'SEPARATORE_RIGHE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object dEdtMgSx: TDBEdit
        Left = 140
        Top = 357
        Width = 30
        Height = 21
        DataField = 'MARGINE_SX'
        DataSource = DButton
        TabOrder = 8
      end
      object dEdtDimFont: TDBEdit
        Left = 140
        Top = 379
        Width = 30
        Height = 21
        DataField = 'DIMENSIONE_FONT'
        DataSource = DButton
        TabOrder = 9
      end
      object dEdtNumGG: TDBEdit
        Left = 140
        Top = 401
        Width = 30
        Height = 21
        DataField = 'GG_PAGINA'
        DataSource = DButton
        TabOrder = 10
      end
      object dCmbOPagina: TDBComboBox
        Left = 374
        Top = 401
        Width = 125
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'ORIENTAMENTO_PAG'
        DataSource = DButton
        DropDownCount = 3
        Items.Strings = (
          'A'
          'O'
          'V')
        TabOrder = 11
        OnDrawItem = dCmbOPaginaDrawItem
      end
      object dEdtEcludiCaus: TDBEdit
        Left = 140
        Top = 335
        Width = 375
        Height = 21
        DataField = 'caus_ecluditurno'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 12
      end
      object btnCaus: TButton
        Left = 516
        Top = 335
        Width = 15
        Height = 21
        Caption = '...'
        TabOrder = 13
        OnClick = btnCausClick
      end
      object dCmbDatoAnag: TDBLookupComboBox
        Left = 374
        Top = 374
        Width = 125
        Height = 21
        DataField = 'DATO_ANAGRAFICO'
        DataSource = DButton
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        NullValueKey = 46
        TabOrder = 14
      end
      object grpOrd_Stampa: TGroupBox
        Left = 224
        Top = 162
        Width = 306
        Height = 84
        Caption = 'Ordinamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        object lblListaDatiStampa: TLabel
          Left = 3
          Top = 13
          Width = 103
          Height = 13
          Caption = 'Lista dati ordinamento'
        end
        object lblOrdStampa: TLabel
          Left = 161
          Top = 13
          Width = 60
          Height = 13
          Caption = 'Ordinamento'
        end
        object lstElencoOrdStampa: TListBox
          Left = 3
          Top = 28
          Width = 140
          Height = 49
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnDblClick = lstElencoOrdStampaDblClick
        end
        object lstOrdinamentoStampa: TListBox
          Left = 159
          Top = 28
          Width = 140
          Height = 49
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnDblClick = lstOrdinamentoStampaDblClick
          OnDragDrop = lstOrdinamentoDragDrop
          OnDragOver = lstOrdinamentoDragOver
          OnMouseDown = lstOrdinamentoMouseDown
        end
      end
    end
  end
  object pnlTOP: TPanel [3]
    Left = 0
    Top = 29
    Width = 550
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblCodProfilo: TLabel
      Left = 6
      Top = -2
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescProfilo: TLabel
      Left = 159
      Top = -2
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtCodice: TDBEdit
      Left = 6
      Top = 13
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtDesc: TDBEdit
      Left = 159
      Top = 13
      Width = 375
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 375
  end
  inherited DButton: TDataSource
    DataSet = A174FParPianifTurniDtm.selT082
    OnDataChange = DButtonDataChange
    Left = 403
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 431
  end
  inherited ImageList1: TImageList
    Left = 459
  end
  inherited ActionList1: TActionList
    Left = 487
  end
end
