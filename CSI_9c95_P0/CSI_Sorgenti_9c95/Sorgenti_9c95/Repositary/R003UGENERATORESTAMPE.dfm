inherited R003FGeneratoreStampe: TR003FGeneratoreStampe
  Left = 238
  Top = 165
  HelpContext = 77000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Generatore di stampe'
  ClientHeight = 561
  ClientWidth = 738
  ExplicitWidth = 754
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 250
    Top = 88
    Width = 2
    Height = 414
    ExplicitLeft = 153
    ExplicitTop = 93
    ExplicitHeight = 265
  end
  inherited StatusBar: TStatusBar
    Top = 543
    Width = 738
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Width = 300
      end
      item
        Width = 50
      end>
    ExplicitTop = 543
    ExplicitWidth = 641
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 738
    Height = 24
    ExplicitTop = 24
    ExplicitWidth = 738
    ExplicitHeight = 24
  end
  object PageControl1: TPageControl [3]
    Left = 252
    Top = 88
    Width = 486
    Height = 414
    ActivePage = tabGenerale
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 155
    ExplicitTop = 93
    ExplicitHeight = 409
    object tabGenerale: TTabSheet
      Caption = 'Generale'
      ExplicitHeight = 381
      object Label8: TLabel
        Left = 339
        Top = 7
        Width = 73
        Height = 13
        Caption = 'Formato pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 232
        Top = 7
        Width = 98
        Height = 13
        Caption = 'Orientamento pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQueryIntestazione: TLabel
        Left = 0
        Top = 215
        Width = 170
        Height = 13
        Caption = 'Testo nell'#39'intestazione delle pagine: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQueryFineStampa: TLabel
        Left = 0
        Top = 240
        Width = 136
        Height = 13
        Caption = 'Testo al fondo della stampa: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object grpGeneraTabella: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 285
        Width = 472
        Height = 98
        Align = alBottom
        Caption = 'Genera tabella sul database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ExplicitLeft = 0
        ExplicitTop = 283
        ExplicitWidth = 478
        object lblTabellaStampa: TLabel
          Left = 8
          Top = 14
          Width = 66
          Height = 13
          Caption = 'Nome Tabella'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDelete: TLabel
          Left = 231
          Top = 52
          Width = 194
          Height = 13
          Caption = 'Cancella i records con questa condizione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblChiavi: TLabel
          Left = 231
          Top = 14
          Width = 117
          Height = 13
          Caption = 'Chiave di aggiornamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dEdtChiavi: TDBEdit
          Left = 231
          Top = 28
          Width = 210
          Height = 21
          DataField = 'TABELLA_GENERATA_KEY'
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
        object dEdtDelete: TDBEdit
          Left = 231
          Top = 66
          Width = 210
          Height = 21
          DataField = 'TABELLA_GENERATA_DELETE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object btnChiavi: TButton
          Left = 443
          Top = 28
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnChiaviClick
        end
        object btnDelete: TButton
          Left = 443
          Top = 66
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = btnDeleteClick
        end
        object dgrpRicreaTabella: TDBRadioGroup
          Left = 8
          Top = 49
          Width = 210
          Height = 46
          DataField = 'TABELLA_GENERATA_DROP'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Ricrea tabella ad ogni elaborazione'
            'Aggiorna tabella gi'#224' esistente')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'S'
            'N')
          OnChange = dgrpRicreaTabellaChange
        end
        object dedtTabellaStampa: TDBEdit
          Left = 8
          Top = 28
          Width = 210
          Height = 21
          DataField = 'TABELLA_GENERATA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = hChange
        end
      end
      object grpVarie: TGroupBox
        Left = 297
        Top = 54
        Width = 178
        Height = 90
        Caption = 'Varie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object dchkValoreNullo: TDBCheckBox
          Left = 6
          Top = 15
          Width = 123
          Height = 17
          Caption = 'Evidenzia valori nulli'
          DataField = 'ValoreNullo'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkPeriodoStorico: TDBCheckBox
          Left = 6
          Top = 31
          Width = 145
          Height = 17
          Caption = 'Periodi storici'
          DataField = 'ConteggiGiornalieri'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkPeriodoStoricoClick
        end
        object dchkFiltriEsclusivi: TDBCheckBox
          Left = 6
          Top = 47
          Width = 153
          Height = 17
          Caption = 'Filtri esclusivi sui dipendenti'
          DataField = 'FiltroEsclusivo'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkCDCPercentualizzati: TDBCheckBox
          Left = 6
          Top = 63
          Width = 147
          Height = 17
          Caption = 'C.d.C. percentualizzati'
          DataField = 'CDC_Percentualizzati'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 3
        Top = 0
        Width = 89
        Height = 54
        Caption = 'Tipo stampa'
        DataField = 'TIPO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'A colonna'
          'A scheda')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'C'
          'S')
        OnChange = DBRadioGroup1Change
      end
      object grpFont: TGroupBox
        Left = 95
        Top = 0
        Width = 131
        Height = 54
        Caption = 'Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label2: TLabel
          Left = 25
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Nome'
        end
        object Label3: TLabel
          Left = 97
          Top = 12
          Width = 21
          Height = 13
          Caption = 'Dim.'
        end
        object DBEdit2: TDBEdit
          Left = 25
          Top = 26
          Width = 69
          Height = 21
          Color = cl3DLight
          DataField = 'FONTNAME'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = DBEdit2Change
        end
        object DBEdit3: TDBEdit
          Left = 97
          Top = 26
          Width = 28
          Height = 21
          Color = cl3DLight
          DataField = 'FONTSIZE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnChange = DBEdit2Change
        end
        object BFont: TBitBtn
          Left = 7
          Top = 26
          Width = 18
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BFontClick
        end
      end
      object grpIntestazione: TGroupBox
        Left = 3
        Top = 54
        Width = 138
        Height = 153
        Caption = 'Intestazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object dchkNomeAzienda: TDBCheckBox
          Left = 6
          Top = 15
          Width = 106
          Height = 17
          Caption = 'Nome azienda'
          DataField = 'STAMPA_AZIENDA'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkPeriodoSelezionato: TDBCheckBox
          Left = 6
          Top = 49
          Width = 115
          Height = 17
          Caption = 'Periodo selezionato'
          DataField = 'STAMPA_PERIODO'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkDataCorrente: TDBCheckBox
          Left = 6
          Top = 66
          Width = 97
          Height = 17
          Caption = 'Data corrente'
          DataField = 'STAMPA_DATA'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkNumeroPagina: TDBCheckBox
          Left = 6
          Top = 83
          Width = 97
          Height = 17
          Caption = 'Numero pagina'
          DataField = 'STAMPA_NUMPAG'
          DataSource = DButton
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTitoloStampa: TDBCheckBox
          Left = 6
          Top = 32
          Width = 106
          Height = 17
          Caption = 'Titolo stampa'
          DataField = 'STAMPA_TITOLO'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpStruttura: TGroupBox
        Left = 145
        Top = 54
        Width = 148
        Height = 153
        Caption = 'Struttura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object DBCheckBox1: TDBCheckBox
          Left = 6
          Top = 58
          Width = 97
          Height = 17
          Caption = 'Solo totali'
          DataField = 'TOTALI'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCheckBox2: TDBCheckBox
          Left = 6
          Top = 13
          Width = 106
          Height = 17
          Caption = 'Separatore di riga'
          DataField = 'SEPARAH'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCheckBox3: TDBCheckBox
          Left = 6
          Top = 28
          Width = 126
          Height = 17
          Caption = 'Separatore di colonna'
          DataField = 'SEPARAV'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBCheckBox4: TDBCheckBox
          Left = 6
          Top = 73
          Width = 97
          Height = 17
          Caption = 'Salto pagina'
          DataField = 'SALTOPAGINA'
          DataSource = DButton
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTotParziali: TDBCheckBox
          Left = 6
          Top = 88
          Width = 97
          Height = 17
          Caption = 'Totali parziali'
          DataField = 'TOTPARZIALI'
          DataSource = DButton
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkTotRiepilogoClick
        end
        object dchkTotGenerali: TDBCheckBox
          Left = 6
          Top = 118
          Width = 97
          Height = 17
          Caption = 'Totali generali'
          DataField = 'TOTGENERALI'
          DataSource = DButton
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTotRiepilogo: TDBCheckBox
          Left = 6
          Top = 103
          Width = 97
          Height = 17
          Caption = 'Totali di riepilogo'
          DataField = 'TOTRIEPILOGO'
          DataSource = DButton
          TabOrder = 6
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkTotRiepilogoClick
        end
        object dChkIntestazioneCol: TDBCheckBox
          Left = 6
          Top = 43
          Width = 136
          Height = 17
          Caption = 'Colonne nell'#39'intestazione'
          DataField = 'INTESTAZIONE_COLONNE'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkSaltoPaginaTotali: TDBCheckBox
          Left = 6
          Top = 133
          Width = 136
          Height = 17
          Caption = 'Salto pagina per tot.riep.'
          DataField = 'SALTOPAGINA_TOTALI'
          DataSource = DButton
          TabOrder = 8
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object cmbOrientamentoPag: TComboBox
        Left = 230
        Top = 26
        Width = 101
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Items.Strings = (
          '(non impostato)'
          'Verticale'
          'Orizzontale')
      end
      object cmbFormatoPag: TComboBox
        Left = 338
        Top = 26
        Width = 122
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Items.Strings = (
          '(non impostato)')
      end
      object drgpFiltroInServizio: TDBRadioGroup
        Left = 297
        Top = 144
        Width = 178
        Height = 63
        Caption = 'Dipendenti in servizio'
        DataField = 'FILTRO_INSERVIZIO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Tutti'
          'Almeno un giorno di servizio'
          'Nessun giorno di servizio')
        ParentFont = False
        TabOrder = 7
        Values.Strings = (
          'T'
          '1'
          '0')
      end
      object dcmbQueryIntestazione: TDBLookupComboBox
        Left = 182
        Top = 211
        Width = 293
        Height = 21
        DataField = 'QUERY_INTESTAZIONE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popmnuAccediA062
        TabOrder = 9
      end
      object dcmbQueryFineStampa: TDBLookupComboBox
        Left = 182
        Top = 236
        Width = 293
        Height = 21
        DataField = 'QUERY_FINESTAMPA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popmnuAccediA062
        TabOrder = 10
      end
    end
    object tabOrdinamento: TTabSheet
      Caption = 'Ordinamento'
      ImageIndex = 5
      ExplicitWidth = 575
      ExplicitHeight = 381
      object LSort: TListBox
        Left = 0
        Top = 0
        Width = 478
        Height = 386
        Style = lbOwnerDrawFixed
        Align = alClient
        Color = 8454016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popOrdinamento
        TabOrder = 0
        OnDblClick = LSortDblClick
        OnDragDrop = LSortDragDrop
        OnDragOver = LSortDragOver
        OnDrawItem = LSortDrawItem
        OnMouseDown = LSortMouseDown
        OnMouseUp = LSortMouseUp
        ExplicitWidth = 575
        ExplicitHeight = 381
      end
    end
    object tabAreaStampa: TTabSheet
      Caption = 'Area stampa'
      ExplicitWidth = 575
      ExplicitHeight = 381
      object Splitter3: TSplitter
        Left = 0
        Top = 90
        Width = 478
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 465
      end
      object pnlDettaglio: TPanel
        Left = 0
        Top = 93
        Width = 478
        Height = 293
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 575
        ExplicitHeight = 288
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 478
          Height = 17
          HelpContext = 5104
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = 'Dettaglio'
          TabOrder = 0
          ExplicitWidth = 575
          object LTop2: TLabel
            Left = 156
            Top = 2
            Width = 10
            Height = 13
            Caption = 'Y:'
          end
          object LLeft2: TLabel
            Left = 108
            Top = 2
            Width = 10
            Height = 13
            Caption = 'X:'
          end
        end
        object Dettaglio: TScrollBox
          Left = 0
          Top = 17
          Width = 478
          Height = 276
          Align = alClient
          Color = 8454143
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 1
          OnDragDrop = IntestazioneDragDrop
          OnDragOver = IntestazioneDragOver
          ExplicitWidth = 575
          ExplicitHeight = 271
        end
      end
      object pnlIntestazione: TPanel
        Left = 0
        Top = 0
        Width = 478
        Height = 90
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 575
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 478
          Height = 17
          HelpContext = 5104
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = 'Intestazione'
          TabOrder = 0
          ExplicitWidth = 575
          object LLeft: TLabel
            Left = 108
            Top = 2
            Width = 10
            Height = 13
            Caption = 'X:'
          end
          object LTop: TLabel
            Left = 156
            Top = 2
            Width = 10
            Height = 13
            Caption = 'Y:'
          end
        end
        object Intestazione: TScrollBox
          Left = 0
          Top = 17
          Width = 478
          Height = 73
          Align = alClient
          Color = 16777088
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 1
          OnDragDrop = IntestazioneDragDrop
          OnDragOver = IntestazioneDragOver
          ExplicitWidth = 575
        end
      end
    end
    object tabSelezioneCodici: TTabSheet
      Caption = 'Codici serbatoio'
      ImageIndex = 3
      ExplicitWidth = 575
      ExplicitHeight = 381
    end
    object tabFiltro: TTabSheet
      Caption = 'Filtro serbatoio'
      ExplicitWidth = 575
      ExplicitHeight = 381
      object Splitter2: TSplitter
        Left = 0
        Top = 138
        Width = 478
        Height = 2
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 132
        ExplicitWidth = 465
      end
      object pnlFiltro: TPanel
        Left = 0
        Top = 0
        Width = 478
        Height = 138
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 575
        object Memo1: TMemo
          Left = 0
          Top = 28
          Width = 478
          Height = 110
          Align = alClient
          Color = 8454143
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
          OnChange = Memo1Change
          OnDragDrop = Memo1DragDrop
          OnDragOver = Memo1DragOver
          ExplicitWidth = 575
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 478
          Height = 28
          Align = alTop
          BevelOuter = bvLowered
          TabOrder = 1
          ExplicitWidth = 575
          object lblDatoDalAl: TLabel
            Left = 152
            Top = 7
            Width = 128
            Height = 13
            AutoSize = False
            Caption = 'Filtra il periodo Dal..Al per:'
          end
          object chkFiltroEsclusivo: TCheckBox
            Left = 4
            Top = 6
            Width = 101
            Height = 17
            Caption = 'Filtro esclusivo'
            TabOrder = 0
            OnClick = chkFiltroEsclusivoClick
          end
          object cmbDatoDalAl: TComboBox
            Left = 283
            Top = 4
            Width = 192
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cmbDatoDalAlChange
          end
        end
      end
      object Memo2: TMemo
        Left = 0
        Top = 140
        Width = 478
        Height = 246
        Align = alClient
        Color = cl3DLight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
        ExplicitWidth = 575
        ExplicitHeight = 241
      end
    end
    object tabDettaglioSerbatoio: TTabSheet
      Caption = 'Dettaglio serbatoio'
      ImageIndex = 4
      ExplicitWidth = 575
      ExplicitHeight = 381
      object Splitter4: TSplitter
        Left = 0
        Top = 121
        Width = 478
        Height = 2
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 465
      end
      object lstKeyCumuloGlobale: TListBox
        Left = 0
        Top = 123
        Width = 478
        Height = 263
        Align = alClient
        Color = cl3DLight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 575
        ExplicitHeight = 258
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 478
        Height = 121
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 575
        object lstKeyCumulo: TListBox
          Left = 0
          Top = 0
          Width = 478
          Height = 121
          Style = lbOwnerDrawFixed
          Align = alClient
          ExtendedSelect = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          PopupMenu = popKeyCumulo
          TabOrder = 0
          OnDblClick = lstKeyCumuloDblClick
          OnDragDrop = lstKeyCumuloDragDrop
          OnDragOver = lstKeyCumuloDragOver
          OnDrawItem = lstKeyCumuloDrawItem
          OnMouseDown = lstKeyCumuloMouseDown
          OnMouseUp = lstKeyCumuloMouseUp
          ExplicitWidth = 575
        end
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 48
    Width = 738
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 253
      Top = 1
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
    object Label4: TLabel
      Left = 4
      Top = 1
      Width = 68
      Height = 13
      Caption = 'Nome stampa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 251
      Top = 16
      Width = 412
      Height = 21
      DataField = 'TITOLO'
      DataSource = DButton
      TabOrder = 1
    end
    object DBEdit4: TDBEdit
      Left = 4
      Top = 16
      Width = 244
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dChkStampaBloccata: TDBCheckBox
      Left = 668
      Top = 18
      Width = 64
      Height = 17
      Caption = 'Protetta'
      DataField = 'STAMPA_BLOCCATA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 502
    Width = 738
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 641
    object btnAnteprima: TBitBtn
      Left = 397
      Top = 2
      Width = 80
      Height = 25
      HelpContext = 2907
      Caption = '&Anteprima'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777700000000000077000FFFFFFFFFF070000FFFFFFF000080070FFFFFF08778
        08770FFFFF0877E880770FFFFF07777870770FFFFF07E77870770FFFFF08EE78
        80770FFFFFF0877807770FFFFFFF000077770FFFFFFFFFF077770FFFFFFF0000
        77770FFFFFFF070777770FFFFFFF007777770000000007777777}
      TabOrder = 2
      OnClick = btnAnteprimaClick
    end
    object BtnClose: TBitBtn
      Left = 652
      Top = 2
      Width = 80
      Height = 25
      HelpContext = 2908
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 5
    end
    object BitBtn1: TBitBtn
      Left = 312
      Top = 2
      Width = 80
      Height = 25
      Caption = 'Stampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00770000000000
        0777707777777770707700000000000007070778777BBB870007077887788887
        0707000000000000077007788887788070707000000000070700770777777770
        7070777077777776EEE078000000000E600870E6EEEEEEEE077778000000000E
        6008777707777786EEE077777000000800087777777777777777}
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 29
      Width = 738
      Height = 12
      Align = alBottom
      TabOrder = 6
      ExplicitWidth = 641
    end
    object btnStampa: TBitBtn
      Left = 482
      Top = 2
      Width = 80
      Height = 25
      HelpContext = 2907
      Caption = '&Stampa'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F7000000000000000003330FFFFFFFF
        03333330F0000F0F03333330FFFFFFFF03333330F00F000003333330FFFF0FF0
        33333330F07F0F0333333330FFFF003333333330000003333333}
      TabOrder = 3
      OnClick = btnAnteprimaClick
    end
    object btnTabella: TBitBtn
      Left = 567
      Top = 2
      Width = 80
      Height = 25
      HelpContext = 2907
      Caption = '&Tabella'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C8807FF7777777777FF700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnAnteprimaClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 0
      Top = 0
      Width = 298
      Height = 29
      Align = alLeft
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 298
      ExplicitHeight = 29
      inherited lblInizio: TLabel
        Top = 7
        ExplicitTop = 7
      end
      inherited lblFine: TLabel
        Left = 134
        Top = 7
        ExplicitLeft = 134
        ExplicitTop = 7
      end
      inherited edtInizio: TMaskEdit
        Top = 4
        ExplicitTop = 4
      end
      inherited edtFine: TMaskEdit
        Left = 149
        Top = 4
        ExplicitLeft = 149
        ExplicitTop = 4
      end
      inherited btnIndietro: TBitBtn
        Left = 247
        Top = 4
        ExplicitLeft = 247
        ExplicitTop = 4
      end
      inherited btnAvanti: TBitBtn
        Left = 269
        Top = 4
        ExplicitLeft = 269
        ExplicitTop = 4
      end
      inherited btnDataInizio: TBitBtn
        Top = 3
        ExplicitTop = 3
      end
      inherited btnDataFine: TBitBtn
        Left = 220
        Top = 3
        ExplicitLeft = 220
        ExplicitTop = 3
      end
    end
  end
  object Panel4: TPanel [6]
    Left = 0
    Top = 88
    Width = 250
    Height = 414
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 93
    ExplicitHeight = 409
    object ListBox1: TListBox
      Left = 0
      Top = 23
      Width = 250
      Height = 391
      Align = alClient
      ExtendedSelect = False
      ItemHeight = 13
      PopupMenu = popDatiCalcolati
      TabOrder = 0
      OnDblClick = ListBox1DblClick
      OnMouseDown = ListBox1MouseDown
      ExplicitWidth = 153
      ExplicitHeight = 386
    end
    object pnlSerbatoi: TPanel
      Left = 0
      Top = 0
      Width = 250
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 153
      object cmbSerbatoi: TComboBox
        Left = 0
        Top = 0
        Width = 250
        Height = 21
        Align = alClient
        Style = csDropDownList
        DropDownCount = 22
        PopupMenu = popDatiCalcolati
        TabOrder = 0
        OnChange = cmbSerbatoiChange
        ExplicitWidth = 153
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [7]
    Left = 0
    Top = 0
    Width = 738
    Height = 24
    Align = alTop
    TabOrder = 6
    TabStop = True
    ExplicitWidth = 641
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 738
      Height = 24
      ExplicitWidth = 641
      ExplicitHeight = 24
      inherited btnSuccessivo: TSpeedButton
        OnClick = frmSelAnagrafebtnSuccessivoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [8]
    Left = 272
    Top = 60
    inherited File1: TMenuItem
      object Esportazionestampa1: TMenuItem [1]
        Caption = 'Esportazione stampa'
        OnClick = Esportazionestampa1Click
      end
      object Importazionestampe1: TMenuItem [2]
        Caption = 'Importazione stampe'
        OnClick = Importazionestampe1Click
      end
      object N4: TMenuItem [3]
        Caption = '-'
      end
      object Interrogazionidiservizio1: TMenuItem [4]
        Caption = 'Interrogazioni di servizio'
        OnClick = Interrogazionidiservizio1Click
      end
      object N5: TMenuItem [5]
        Caption = '-'
      end
    end
  end
  inherited DButton: TDataSource [9]
    OnDataChange = DButtonDataChange
    Left = 300
    Top = 60
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [10]
    Left = 328
    Top = 60
  end
  inherited ImageList1: TImageList [11]
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 356
    Top = 60
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 244
    Top = 60
    object Caption1: TMenuItem
      Caption = 'Caption...'
      OnClick = Caption1Click
    end
    object Dimensioni1: TMenuItem
      Caption = 'Dimensioni..'
      OnClick = Dimensioni1Click
    end
    object VaiAlSerbatoio1: TMenuItem
      Caption = 'Vai al serbatoio...'
      ImageIndex = 0
      OnClick = VaiAlSerbatoio1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Cancella2: TMenuItem
      Caption = 'Cancella'
      OnClick = Cancella2Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Ripetisuogniriga1: TMenuItem
      Caption = 'Ripeti su ogni riga'
      OnClick = Ripetisuogniriga1Click
    end
    object Totale1: TMenuItem
      Caption = 'Totale'
      OnClick = Totale1Click
    end
    object Contatore1: TMenuItem
      Caption = 'Contatore'
      OnClick = Contatore1Click
    end
    object PercentualizzaperCdC1: TMenuItem
      Caption = 'Proporziona per CdC o per periodo'
      OnClick = PercentualizzaperCdC1Click
    end
    object Formato1: TMenuItem
      Caption = 'Formato'
      OnClick = Formato1Click
    end
    object ConvertiInValuta1: TMenuItem
      Caption = 'Converti in valuta'
      OnClick = ConvertiInValuta1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 384
    Top = 60
    object Pulisci1: TMenuItem
      Caption = 'Pulisci'
      OnClick = Pulisci1Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 412
    Top = 60
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object Elementiselezionatiinalto1: TMenuItem
      AutoCheck = True
      Caption = 'Elementi selezionati in alto'
      OnClick = Elementiselezionatiinalto1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.SQL'
    FileName = 'StampaIrisWIN.SQL'
    Filter = 
      'Scripts SQL (*.SQL)|*.SQL|Files di testo (*.txt)|*.txt|Tutti i f' +
      'iles (*.*)|*.*'
    Left = 564
    Top = 36
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.SQL'
    FileName = 'StampaIrisWIN.SQL'
    Filter = 
      'Scripts SQL (*.SQL)|*.SQL|Files di testo (*.txt)|*.txt|Tutti i f' +
      'iles (*.*)|*.*'
    Left = 592
    Top = 36
  end
  object popKeyCumulo: TPopupMenu
    OnPopup = popKeyCumuloPopup
    Left = 216
    Top = 60
    object mnuTotKeyCumulo: TMenuItem
      Caption = 'Totale'
      OnClick = mnuTotKeyCumuloClick
    end
  end
  object popOrdinamento: TPopupMenu
    OnPopup = popOrdinamentoPopup
    Left = 188
    Top = 60
    object mnuRotturaOrdinamento: TMenuItem
      Caption = 'Rottura di chiave'
      OnClick = mnuRotturaOrdinamentoClick
    end
    object mnuDiscendente: TMenuItem
      Caption = 'Discendente'
      OnClick = mnuDiscendenteClick
    end
  end
  object popDatiCalcolati: TPopupMenu
    Top = 117
    object Daticalcolati1: TMenuItem
      Caption = 'Dati calcolati'
      OnClick = Daticalcolati1Click
    end
    object Ordinealfabetico1: TMenuItem
      Caption = 'Ordine alfabetico'
      OnClick = Ordinealfabetico1Click
    end
    object NRicercaTesto: TMenuItem
      Caption = '-'
    end
    object Ricercatestocontenuto1: TMenuItem
      Caption = 'Ricerca testo contenuto'
      ShortCut = 16454
      OnClick = Ricercatestocontenuto1Click
    end
    object Successivo2: TMenuItem
      Caption = 'Successivo'
      ShortCut = 114
      OnClick = Successivo2Click
    end
  end
  object popmnuAccediA062: TPopupMenu
    Left = 520
    Top = 340
    object mnuAccediA062: TMenuItem
      Caption = 'Accedi'
      OnClick = mnuAccediA062Click
    end
  end
end
