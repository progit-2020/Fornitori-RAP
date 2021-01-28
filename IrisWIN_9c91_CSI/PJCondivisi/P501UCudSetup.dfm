inherited P501FCudSetup: TP501FCudSetup
  Left = 115
  HelpContext = 3501000
  Caption = '<P501> Configurazione dati aziendali'
  ClientHeight = 480
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel [0]
    Left = 9
    Top = 254
    Width = 49
    Height = 13
    Caption = 'Procedura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited StatusBar: TStatusBar
    Top = 462
    Width = 784
    ExplicitTop = 462
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Width = 784
    ExplicitWidth = 784
  end
  object pgcPrincipale: TPageControl [3]
    Left = 0
    Top = 73
    Width = 784
    Height = 389
    ActivePage = tshDatiCUD
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabWidth = 62
    object tshDatiGenerali: TTabSheet
      Caption = 'Azienda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object lblCodFiscale: TLabel
        Left = 9
        Top = 18
        Width = 66
        Height = 13
        Caption = 'Codice fiscale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDenominazione: TLabel
        Left = 9
        Top = 50
        Width = 73
        Height = 13
        Caption = 'Denominazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProvincia: TLabel
        Left = 9
        Top = 112
        Width = 44
        Height = 13
        Caption = 'Provincia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblComune: TLabel
        Left = 9
        Top = 81
        Width = 39
        Height = 13
        Caption = 'Comune'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCap: TLabel
        Left = 333
        Top = 112
        Width = 21
        Height = 13
        Caption = 'CAP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblEmail: TLabel
        Left = 9
        Top = 204
        Width = 28
        Height = 13
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIndirizzo: TLabel
        Left = 9
        Top = 143
        Width = 38
        Height = 13
        Caption = 'Indirizzo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTelefono: TLabel
        Left = 9
        Top = 174
        Width = 42
        Height = 13
        Caption = 'Telefono'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFax: TLabel
        Left = 285
        Top = 174
        Width = 17
        Height = 13
        Caption = 'Fax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodComune: TLabel
        Left = 333
        Top = 81
        Width = 74
        Height = 13
        Caption = 'Codice comune'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtProvincia: TDBEdit
        Left = 85
        Top = 108
        Width = 43
        Height = 21
        DataField = 'PROVINCIA'
        DataSource = DButton
        TabOrder = 4
      end
      object dedtComune: TDBEdit
        Left = 85
        Top = 77
        Width = 238
        Height = 21
        DataField = 'COMUNE'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtCap: TDBEdit
        Left = 416
        Top = 108
        Width = 69
        Height = 21
        DataField = 'CAP'
        DataSource = DButton
        TabOrder = 5
      end
      object dedtCodFiscale: TDBEdit
        Left = 85
        Top = 14
        Width = 220
        Height = 21
        DataField = 'COD_FISCALE'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtDenominazione: TDBEdit
        Left = 85
        Top = 46
        Width = 400
        Height = 21
        DataField = 'DENOMINAZIONE'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtEmail: TDBEdit
        Left = 85
        Top = 200
        Width = 400
        Height = 21
        DataField = 'E_MAIL'
        DataSource = DButton
        MaxLength = 50
        TabOrder = 9
      end
      object dedtIndirizzo: TDBEdit
        Left = 85
        Top = 139
        Width = 400
        Height = 21
        DataField = 'INDIRIZZO'
        DataSource = DButton
        TabOrder = 6
      end
      object dedtTelefono: TDBEdit
        Left = 85
        Top = 170
        Width = 177
        Height = 21
        DataField = 'TELEFONO'
        DataSource = DButton
        TabOrder = 7
      end
      object dedtFax: TDBEdit
        Left = 308
        Top = 170
        Width = 177
        Height = 21
        DataField = 'FAX'
        DataSource = DButton
        TabOrder = 8
      end
      object dedtCodComune: TDBEdit
        Left = 416
        Top = 77
        Width = 69
        Height = 21
        DataField = 'COD_COMUNE'
        DataSource = DButton
        TabOrder = 3
      end
    end
    object tshDatiCUD: TTabSheet
      Caption = 'CU'
      ImageIndex = 2
      object lblCodValuta: TLabel
        Left = 9
        Top = 27
        Width = 30
        Height = 13
        Caption = 'Valuta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dlblValuta: TDBText
        Left = 240
        Top = 27
        Width = 46
        Height = 13
        AutoSize = True
        DataField = 'D_VALUTA'
        DataSource = DButton
      end
      object lblFirmatario: TLabel
        Left = 9
        Top = 88
        Width = 45
        Height = 13
        Caption = 'Firmatario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 9
        Top = 58
        Width = 72
        Height = 13
        Caption = 'Codice ATECO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCUCodFiscaleSW: TLabel
        Left = 9
        Top = 149
        Width = 109
        Height = 13
        Caption = 'Codice fiscale software'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCUTipoFornitore: TLabel
        Left = 9
        Top = 119
        Width = 62
        Height = 13
        Caption = 'Tipo fornitore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dcbxValutaStampa: TDBLookupComboBox
        Left = 127
        Top = 23
        Width = 95
        Height = 21
        DataField = 'COD_VALUTA'
        DataSource = DButton
        DropDownWidth = 250
        KeyField = 'COD_VALUTA'
        ListField = 'COD_VALUTA; DESCRIZIONE;'
        ListSource = P501FCudSetupDtM.dsrP030
        TabOrder = 0
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dedtFirmatario: TDBEdit
        Left = 127
        Top = 85
        Width = 400
        Height = 21
        DataField = 'FIRMATARIO'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtCodATECO1: TDBEdit
        Left = 127
        Top = 55
        Width = 55
        Height = 21
        DataField = 'CODICE_ATECO_DMA'
        DataSource = DButton
        TabOrder = 1
      end
      object grpWEB: TGroupBox
        Left = 9
        Top = 217
        Width = 544
        Height = 133
        Caption = 'Stampa da web'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object lblWebPathIstruzioni: TLabel
          Left = 13
          Top = 45
          Width = 127
          Height = 13
          Caption = 'Nome file allegato istruzioni'
        end
        object lblWebAnnotazioni: TLabel
          Left = 13
          Top = 69
          Width = 111
          Height = 13
          Caption = 'Annotazione aggiuntiva'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblWEBDataStampa: TLabel
          Left = 311
          Top = 18
          Width = 48
          Height = 13
          Caption = 'Data firma'
        end
        object chkWEBStampa: TDBCheckBox
          Left = 13
          Top = 17
          Width = 63
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Abilitata'
          DataField = 'WEB_STAMPA'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtWEBPathIstruzioni: TDBEdit
          Left = 146
          Top = 42
          Width = 387
          Height = 21
          DataField = 'WEB_PATH_ISTRUZIONI'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object dmemoWEBAnnotazioni: TDBMemo
          Left = 146
          Top = 69
          Width = 387
          Height = 57
          DataField = 'WEB_ANNOTAZIONI'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 4
        end
        object dedtWebDataStampa: TDBEdit
          Left = 368
          Top = 15
          Width = 73
          Height = 21
          DataField = 'WEB_DATA_STAMPA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = dedtWebDataStampaChange
        end
        object btnWebDataStampa: TButton
          Left = 442
          Top = 15
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = btnWebDataStampaClick
        end
      end
      object dedtCUCodFiscaleSW: TDBEdit
        Left = 127
        Top = 146
        Width = 210
        Height = 21
        Color = cl3DLight
        DataField = 'COD_FISCALE_SW_DMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 4
      end
      object dedtCUTipoFornitore: TDBEdit
        Left = 127
        Top = 116
        Width = 43
        Height = 21
        Color = cl3DLight
        DataField = 'TIPO_FORNITORE'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 3
      end
    end
    object tshDati770: TTabSheet
      Caption = '770'
      ImageIndex = 1
      object lblTipoFornitore: TLabel
        Left = 6
        Top = 29
        Width = 62
        Height = 13
        Caption = 'Tipo fornitore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodiceAttivita: TLabel
        Left = 6
        Top = 54
        Width = 67
        Height = 13
        Caption = 'Codice attivit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblStatoEnte: TLabel
        Left = 6
        Top = 79
        Width = 25
        Height = 13
        Caption = 'Stato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNaturaGiuridica: TLabel
        Left = 6
        Top = 104
        Width = 74
        Height = 13
        Caption = 'Natura giuridica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSituazioneEnte: TLabel
        Left = 6
        Top = 129
        Width = 49
        Height = 13
        Caption = 'Situazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodFiscaleDicastero: TLabel
        Left = 6
        Top = 154
        Width = 112
        Height = 13
        Caption = 'Codice fiscale dicastero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 6
        Top = 179
        Width = 109
        Height = 13
        Caption = 'Codice fiscale software'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtTipoFornitore: TDBEdit
        Left = 125
        Top = 26
        Width = 43
        Height = 21
        DataField = 'TIPO_FORNITORE'
        DataSource = DButton
        TabOrder = 0
      end
      object dedCodiceAttivita: TDBEdit
        Left = 125
        Top = 51
        Width = 43
        Height = 21
        DataField = 'CODICE_ATTIVITA'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtStatoEnte: TDBEdit
        Left = 125
        Top = 76
        Width = 43
        Height = 21
        DataField = 'STATO_ENTE'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtNaturaGiuridica: TDBEdit
        Left = 125
        Top = 101
        Width = 43
        Height = 21
        DataField = 'NATURA_GIURIDICA'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtSituazioneEnte: TDBEdit
        Left = 125
        Top = 126
        Width = 43
        Height = 21
        DataField = 'SITUAZIONE_ENTE'
        DataSource = DButton
        TabOrder = 4
      end
      object dedtCodFiscaleDicastero: TDBEdit
        Left = 125
        Top = 151
        Width = 108
        Height = 21
        DataField = 'COD_FISCALE_DICASTERO'
        DataSource = DButton
        TabOrder = 5
      end
      object dedtCodFiscaleProdut2: TDBEdit
        Left = 125
        Top = 176
        Width = 108
        Height = 21
        DataField = 'COD_FISCALE_SW_DMA'
        DataSource = DButton
        TabOrder = 6
      end
      object GroupBox2: TGroupBox
        Left = 387
        Top = 6
        Width = 169
        Height = 327
        Caption = 'Data versamento tributi F24 EP'
        TabOrder = 7
        object Label12: TLabel
          Left = 8
          Top = 23
          Width = 40
          Height = 13
          Caption = 'Gennaio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 8
          Top = 48
          Width = 41
          Height = 13
          Caption = 'Febbraio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 8
          Top = 73
          Width = 29
          Height = 13
          Caption = 'Marzo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 8
          Top = 98
          Width = 26
          Height = 13
          Caption = 'Aprile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 8
          Top = 123
          Width = 35
          Height = 13
          Caption = 'Maggio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 8
          Top = 148
          Width = 34
          Height = 13
          Caption = 'Giugno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 8
          Top = 173
          Width = 28
          Height = 13
          Caption = 'Luglio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 8
          Top = 198
          Width = 33
          Height = 13
          Caption = 'Agosto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 8
          Top = 223
          Width = 48
          Height = 13
          Caption = 'Settembre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 8
          Top = 248
          Width = 35
          Height = 13
          Caption = 'Ottobre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 8
          Top = 273
          Width = 49
          Height = 13
          Caption = 'Novembre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 8
          Top = 298
          Width = 45
          Height = 13
          Caption = 'Dicembre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtGennaio: TDBEdit
          Left = 63
          Top = 20
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF01'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnGennaioClick
        end
        object btnGennaio: TButton
          Left = 136
          Top = 20
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = btnGennaioClick
        end
        object btnFebbraio: TButton
          Left = 136
          Top = 45
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnFebbraioClick
        end
        object dedtFebbraio: TDBEdit
          Left = 63
          Top = 45
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF02'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnFebbraioClick
        end
        object dedtMarzo: TDBEdit
          Left = 63
          Top = 70
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF03'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnMarzoClick
        end
        object btnMarzo: TButton
          Left = 136
          Top = 70
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = btnMarzoClick
        end
        object btnAprile: TButton
          Left = 136
          Top = 95
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = btnAprileClick
        end
        object dedtAprile: TDBEdit
          Left = 63
          Top = 95
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF04'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnAprileClick
        end
        object dedtMaggio: TDBEdit
          Left = 63
          Top = 120
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF05'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnMaggioClick
        end
        object btnMaggio: TButton
          Left = 136
          Top = 120
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 9
          OnClick = btnMaggioClick
        end
        object dedtGiugno: TDBEdit
          Left = 63
          Top = 145
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF06'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnGiugnoClick
        end
        object btnGiugno: TButton
          Left = 136
          Top = 145
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 11
          OnClick = btnGiugnoClick
        end
        object dedtLuglio: TDBEdit
          Left = 63
          Top = 170
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF07'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnLuglioClick
        end
        object btnLuglio: TButton
          Left = 136
          Top = 170
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 13
          OnClick = btnLuglioClick
        end
        object btnAgosto: TButton
          Left = 136
          Top = 195
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 15
          OnClick = btnAgostoClick
        end
        object dedtAgosto: TDBEdit
          Left = 63
          Top = 195
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF08'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnAgostoClick
        end
        object dedtSettembre: TDBEdit
          Left = 63
          Top = 220
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF09'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnSettembreClick
        end
        object btnSettembre: TButton
          Left = 136
          Top = 220
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 17
          OnClick = btnSettembreClick
        end
        object btnOttobre: TButton
          Left = 136
          Top = 245
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 19
          OnClick = btnOttobreClick
        end
        object dedtOttobre: TDBEdit
          Left = 63
          Top = 245
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF10'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnOttobreClick
        end
        object dedtNovembre: TDBEdit
          Left = 63
          Top = 270
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF11'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnNovembreClick
        end
        object btnNovembre: TButton
          Left = 136
          Top = 270
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 21
          OnClick = btnNovembreClick
        end
        object dedtDicembre: TDBEdit
          Left = 63
          Top = 295
          Width = 73
          Height = 21
          DataField = 'DATA_VERS_IRPEF12'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
          OnChange = dedtWebDataStampaChange
          OnDblClick = btnDicembreClick
        end
        object btnDicembre: TButton
          Left = 136
          Top = 295
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 23
          OnClick = btnDicembreClick
        end
      end
    end
    object tshDatiDMA: TTabSheet
      Caption = 'D.M.A.'
      ImageIndex = 4
      object lblCodFornitura: TLabel
        Left = 9
        Top = 21
        Width = 74
        Height = 13
        Caption = 'Codice fornitura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTipoFornit: TLabel
        Left = 9
        Top = 48
        Width = 62
        Height = 13
        Caption = 'Tipo fornitore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodInpdap: TLabel
        Left = 9
        Top = 75
        Width = 95
        Height = 13
        Caption = 'Progressivo azienda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodAteco: TLabel
        Left = 9
        Top = 102
        Width = 67
        Height = 13
        Caption = 'Codice ISTAT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodFirmaGiurid: TLabel
        Left = 9
        Top = 128
        Width = 107
        Height = 13
        Caption = 'Codice forma giuridica '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodFiscSw: TLabel
        Left = 9
        Top = 210
        Width = 109
        Height = 13
        Caption = 'Codice fiscale software'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 9
        Top = 155
        Width = 80
        Height = 13
        Caption = 'Codice comparto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 9
        Top = 182
        Width = 103
        Height = 13
        Caption = 'Codice sottocomparto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodFornitura: TDBEdit
        Left = 155
        Top = 18
        Width = 55
        Height = 21
        DataField = 'CODICE_FORNITURA_DMA'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtTipoFornitoreDMA: TDBEdit
        Left = 155
        Top = 45
        Width = 30
        Height = 21
        DataField = 'TIPO_FORNITORE_DMA'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtCodINPDAP: TDBEdit
        Left = 155
        Top = 72
        Width = 55
        Height = 21
        Color = cl3DLight
        DataField = 'CODICE_INPDAP_DMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 2
      end
      object dedtCodATECO: TDBEdit
        Left = 155
        Top = 99
        Width = 55
        Height = 21
        Color = cl3DLight
        DataField = 'CODICE_ATECO_DMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 3
      end
      object dedtCodFormaGiurid: TDBEdit
        Left = 155
        Top = 126
        Width = 55
        Height = 21
        DataField = 'CODICE_FORMA_GIUR_DMA'
        DataSource = DButton
        MaxLength = 4
        TabOrder = 4
      end
      object dedtCodFiscaleProdut: TDBEdit
        Left = 155
        Top = 207
        Width = 210
        Height = 21
        Color = cl3DLight
        DataField = 'COD_FISCALE_SW_DMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 7
      end
      object dchkFirmaDenuncia: TDBCheckBox
        Left = 9
        Top = 238
        Width = 136
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = 'Firma della denuncia'
        DataField = 'FIRMA_DENUNCIA_DMA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 8
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object dedtCodComparto: TDBEdit
        Left = 155
        Top = 153
        Width = 30
        Height = 21
        DataField = 'CODICE_COMPARTO_DMA'
        DataSource = DButton
        TabOrder = 5
      end
      object dedtCodSottoComparto: TDBEdit
        Left = 155
        Top = 180
        Width = 30
        Height = 21
        DataField = 'CODICE_SOTTOCOMPARTO_DMA'
        DataSource = DButton
        TabOrder = 6
      end
    end
    object tshDatiEMens: TTabSheet
      Caption = 'uniEMens'
      ImageIndex = 6
      object lblMatricolaInps: TLabel
        Left = 9
        Top = 20
        Width = 71
        Height = 13
        Caption = 'Matricola INPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodiceFiscaleSw: TLabel
        Left = 9
        Top = 128
        Width = 109
        Height = 13
        Caption = 'Codice fiscale software'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodSedeInps: TLabel
        Left = 9
        Top = 47
        Width = 87
        Height = 13
        Caption = 'Codice sede INPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodFiscMitt: TLabel
        Left = 9
        Top = 74
        Width = 106
        Height = 13
        Caption = 'Codice fiscale mittente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodIstat: TLabel
        Left = 9
        Top = 101
        Width = 67
        Height = 13
        Caption = 'Codice ISTAT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 9
        Top = 182
        Width = 156
        Height = 13
        Caption = 'Codice fiscale firmatario D.M.A. 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 9
        Top = 209
        Width = 149
        Height = 13
        Caption = 'Codice forma giuridica D.M.A. 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 9
        Top = 236
        Width = 123
        Height = 13
        Caption = 'Codice contratto D.M.A. 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 9
        Top = 155
        Width = 140
        Height = 13
        Caption = 'Progressivo azienda D.M.A. 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtMatricolaInps: TDBEdit
        Left = 176
        Top = 17
        Width = 151
        Height = 21
        DataField = 'MATRICOLA_INPS'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtCodFiscaleProdut1: TDBEdit
        Left = 176
        Top = 125
        Width = 210
        Height = 21
        TabStop = False
        Color = cl3DLight
        DataField = 'COD_FISCALE_SW_DMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 4
      end
      object dedtCodiceInps: TDBEdit
        Left = 176
        Top = 44
        Width = 47
        Height = 21
        DataField = 'SEDE_INPS'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtCodFiscaleMitt: TDBEdit
        Left = 176
        Top = 71
        Width = 119
        Height = 21
        DataField = 'COD_FISCALE_MITT_EMENS'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtCodiceIstat: TDBEdit
        Left = 176
        Top = 98
        Width = 47
        Height = 21
        DataField = 'CODICE_ISTAT_EMENS'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtCodFiscaleFirmaDMA2: TDBEdit
        Left = 176
        Top = 179
        Width = 210
        Height = 21
        TabStop = False
        Color = cl3DLight
        DataField = 'COD_FISCALE_FIRMA'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 6
      end
      object dedtCodFormaGiuridDMA2: TDBEdit
        Left = 176
        Top = 206
        Width = 55
        Height = 21
        DataField = 'CODICE_FORMA_GIUR_DMA2'
        DataSource = DButton
        MaxLength = 4
        TabOrder = 7
      end
      object dedtCodContrattoDMA2: TDBEdit
        Left = 176
        Top = 233
        Width = 55
        Height = 21
        DataField = 'COD_CONTRATTO_DMA2'
        DataSource = DButton
        MaxLength = 4
        TabOrder = 8
      end
      object dedtCodINPDAPDMA2: TDBEdit
        Left = 176
        Top = 152
        Width = 55
        Height = 21
        DataField = 'CODICE_INPDAP_DMA'
        DataSource = DButton
        TabOrder = 5
      end
    end
    object tshDatiINPGI: TTabSheet
      Caption = 'INPGI'
      ImageIndex = 10
      object Label5: TLabel
        Left = 9
        Top = 17
        Width = 73
        Height = 13
        Caption = 'Codice azienda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodINPGI: TDBEdit
        Left = 90
        Top = 14
        Width = 47
        Height = 21
        DataField = 'CODICE_AZIENDA_INPGI'
        DataSource = DButton
        TabOrder = 0
      end
    end
    object tshDatiEnpam: TTabSheet
      Caption = 'ENPAM'
      ImageIndex = 11
      object Label11: TLabel
        Left = 9
        Top = 17
        Width = 73
        Height = 13
        Caption = 'Codice azienda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodEnpam: TDBEdit
        Left = 90
        Top = 14
        Width = 47
        Height = 21
        DataField = 'CODICE_AZIENDA_ENPAM'
        DataSource = DButton
        TabOrder = 0
      end
    end
    object tshFirmatario: TTabSheet
      Caption = 'Firmatario'
      ImageIndex = 5
      object gpbDatiFirmatario: TGroupBox
        Left = 5
        Top = 16
        Width = 490
        Height = 257
        Caption = 'Dati relativi alla firma dei modelli CU, D.M.A. 2 e 770'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblCodFiscaleFirma: TLabel
          Left = 9
          Top = 17
          Width = 66
          Height = 13
          Caption = 'Codice fiscale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCodiceCarica: TLabel
          Left = 9
          Top = 215
          Width = 113
          Height = 13
          Caption = 'Codice carica CU e 770'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCognomeFirma: TLabel
          Left = 9
          Top = 53
          Width = 45
          Height = 13
          Caption = 'Cognome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNomeFirma: TLabel
          Left = 256
          Top = 53
          Width = 28
          Height = 13
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDataNascitaFirma: TLabel
          Left = 395
          Top = 93
          Width = 71
          Height = 13
          Caption = 'Data di nascita'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblComuneNascitaFirma: TLabel
          Left = 9
          Top = 93
          Width = 154
          Height = 13
          Caption = 'Comune o stato estero di nascita'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblProvinciaNascitaFirma: TLabel
          Left = 256
          Top = 93
          Width = 92
          Height = 13
          Caption = 'Provincia di nascita'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblComuneResidenzaFirma: TLabel
          Left = 9
          Top = 134
          Width = 98
          Height = 13
          Caption = 'Comune di residenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblProvinciaResidenzaFirma: TLabel
          Left = 256
          Top = 134
          Width = 103
          Height = 13
          Caption = 'Provincia di residenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCapResidenzaFirma: TLabel
          Left = 395
          Top = 134
          Width = 80
          Height = 13
          Caption = 'CAP di residenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblIndirizzoResidenzaFirma: TLabel
          Left = 9
          Top = 174
          Width = 97
          Height = 13
          Caption = 'Indirizzo di residenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTelefonoFirma: TLabel
          Left = 256
          Top = 174
          Width = 42
          Height = 13
          Caption = 'Telefono'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDecorrenzaCaricaFirma: TLabel
          Left = 256
          Top = 215
          Width = 108
          Height = 13
          Caption = 'Decorrenza carica 770'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtCodFiscaleFirma: TDBEdit
          Left = 9
          Top = 30
          Width = 210
          Height = 21
          DataField = 'COD_FISCALE_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object dedtCodiceCarica: TDBEdit
          Left = 9
          Top = 229
          Width = 43
          Height = 21
          DataField = 'CODICE_CARICA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object dedtCognomeFirma: TDBEdit
          Left = 9
          Top = 67
          Width = 210
          Height = 21
          DataField = 'COGNOME_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dedtNomeFirma: TDBEdit
          Left = 256
          Top = 67
          Width = 210
          Height = 21
          DataField = 'NOME_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object drgpSessoFirma: TDBRadioGroup
          Left = 256
          Top = 13
          Width = 138
          Height = 36
          Caption = 'Sesso'
          Columns = 2
          DataField = 'SESSO_FIRMA'
          DataSource = DButton
          Items.Strings = (
            'Maschio'
            'Femmina')
          TabOrder = 1
          Values.Strings = (
            'M'
            'F')
        end
        object dedtDataNascitaFirma: TDBEdit
          Left = 395
          Top = 107
          Width = 68
          Height = 21
          DataField = 'DATA_NASCITA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = dedtWebDataStampaChange
        end
        object dedtComuneNascitaFirma: TDBEdit
          Left = 9
          Top = 107
          Width = 210
          Height = 21
          DataField = 'COMUNE_NASCITA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object dedtProvinciaNascitaFirma: TDBEdit
          Left = 256
          Top = 107
          Width = 44
          Height = 21
          DataField = 'PROVINCIA_NASCITA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object dedtComuneResidenzaFirma: TDBEdit
          Left = 9
          Top = 147
          Width = 210
          Height = 21
          DataField = 'COMUNE_RESIDENZA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object dedtProvinciaResidenzaFirma: TDBEdit
          Left = 256
          Top = 147
          Width = 44
          Height = 21
          DataField = 'PROVINCIA_RESIDENZA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object dedtCapResidenzaFirma: TDBEdit
          Left = 395
          Top = 147
          Width = 44
          Height = 21
          DataField = 'CAP_RESIDENZA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object dedtIndirizzoResidenzaFirma: TDBEdit
          Left = 9
          Top = 187
          Width = 210
          Height = 21
          DataField = 'INDIRIZZO_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object dedtTelefonoFirma: TDBEdit
          Left = 256
          Top = 187
          Width = 210
          Height = 21
          DataField = 'TELEFONO_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object dedtDecorrenzaCaricaFirma: TDBEdit
          Left = 256
          Top = 229
          Width = 68
          Height = 21
          DataField = 'DECORRENZA_CARICA_FIRMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          OnChange = dedtWebDataStampaChange
        end
        object btnDataNascitaFirma: TButton
          Left = 464
          Top = 107
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = btnDataNascitaFirmaClick
        end
        object btnDecorrenzaCaricaFirma: TButton
          Left = 325
          Top = 229
          Width = 16
          Height = 21
          Caption = '...'
          TabOrder = 15
          OnClick = btnDecorrenzaCaricaFirmaClick
        end
      end
    end
    object tshDatiBanca: TTabSheet
      Caption = 'Tesoriere'
      ImageIndex = 3
      object lblCodSIA: TLabel
        Left = 9
        Top = 26
        Width = 80
        Height = 13
        Caption = 'Codice SIA/CUC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodABI: TLabel
        Left = 9
        Top = 59
        Width = 53
        Height = 13
        Caption = 'Codice ABI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodCAB: TLabel
        Left = 9
        Top = 92
        Width = 57
        Height = 13
        Caption = 'Codice CAB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblContoCorrente: TLabel
        Left = 9
        Top = 126
        Width = 70
        Height = 13
        Caption = 'Conto corrente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodIBAN: TLabel
        Left = 9
        Top = 160
        Width = 61
        Height = 13
        Caption = 'Codice IBAN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodSIA: TDBEdit
        Left = 96
        Top = 22
        Width = 70
        Height = 21
        DataField = 'COD_SIA'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtCodABI: TDBEdit
        Left = 96
        Top = 55
        Width = 70
        Height = 21
        DataField = 'COD_ABI'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtCodCAB: TDBEdit
        Left = 96
        Top = 88
        Width = 70
        Height = 21
        DataField = 'COD_CAB'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtContoCorrente: TDBEdit
        Left = 96
        Top = 122
        Width = 148
        Height = 21
        DataField = 'CONTO_CORRENTE'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtCodIBAN: TDBEdit
        Left = 96
        Top = 156
        Width = 190
        Height = 21
        DataField = 'COD_IBAN'
        DataSource = DButton
        TabOrder = 4
      end
    end
    object tshPostel: TTabSheet
      Caption = 'Postel'
      ImageIndex = 7
      object lblIdAbbonato: TLabel
        Left = 10
        Top = 8
        Width = 57
        Height = 13
        Caption = 'Id abbonato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTipologiaInvio: TLabel
        Left = 10
        Top = 48
        Width = 68
        Height = 13
        Caption = 'Tipologia invio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblColore: TLabel
        Left = 10
        Top = 89
        Width = 30
        Height = 13
        Caption = 'Colore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProcedura: TLabel
        Left = 10
        Top = 130
        Width = 49
        Height = 13
        Caption = 'Procedura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTrattamento: TLabel
        Left = 10
        Top = 171
        Width = 57
        Height = 13
        Caption = 'Trattamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCentroCosto: TLabel
        Left = 10
        Top = 212
        Width = 71
        Height = 13
        Caption = 'Centro di costo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIndirizzoDomicilio: TLabel
        Left = 155
        Top = 8
        Width = 81
        Height = 13
        Caption = 'Indirizzo domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCAPDomicilio: TLabel
        Left = 155
        Top = 48
        Width = 64
        Height = 13
        Caption = 'CAP domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblComuneDomicilio: TLabel
        Left = 155
        Top = 89
        Width = 82
        Height = 13
        Caption = 'Comune domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProvinciaDomicilio: TLabel
        Left = 155
        Top = 130
        Width = 87
        Height = 13
        Caption = 'Provincia domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescIndirizzoDomicilio: TLabel
        Left = 346
        Top = 26
        Width = 115
        Height = 13
        Caption = 'lblDescIndirizzoDomicilio'
      end
      object lblDescCAPDomicilio: TLabel
        Left = 346
        Top = 66
        Width = 98
        Height = 13
        Caption = 'lblDescCAPDomicilio'
      end
      object lblDescComuneDomicilio: TLabel
        Left = 346
        Top = 107
        Width = 116
        Height = 13
        Caption = 'lblDescComuneDomicilio'
      end
      object lblDescProvinciaDomicilio: TLabel
        Left = 346
        Top = 148
        Width = 121
        Height = 13
        Caption = 'lblDescProvinciaDomicilio'
      end
      object dedtIdAbbonato: TDBEdit
        Left = 10
        Top = 22
        Width = 120
        Height = 21
        DataField = 'ID_ABBONATO_POSTEL'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtTipologiaInvio: TDBEdit
        Left = 10
        Top = 62
        Width = 120
        Height = 21
        DataField = 'TIPOLOGIA_INVIO_POSTEL'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtColore: TDBEdit
        Left = 10
        Top = 103
        Width = 120
        Height = 21
        DataField = 'COLORE_POSTEL'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtProcedura: TDBEdit
        Left = 10
        Top = 144
        Width = 120
        Height = 21
        DataField = 'PROCEDURA_POSTEL'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtTrattamento: TDBEdit
        Left = 10
        Top = 185
        Width = 120
        Height = 21
        DataField = 'TRATTAMENTO_POSTEL'
        DataSource = DButton
        TabOrder = 4
      end
      object dedtCentroCosto: TDBEdit
        Left = 10
        Top = 226
        Width = 120
        Height = 21
        DataField = 'CENTRO_COSTO_POSTEL'
        DataSource = DButton
        TabOrder = 5
      end
      object dcmbIndirizzoDomicilio: TDBLookupComboBox
        Left = 155
        Top = 22
        Width = 185
        Height = 21
        DataField = 'IND_DOM_POSTEL'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 6
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbCAPDomicilio: TDBLookupComboBox
        Left = 155
        Top = 62
        Width = 185
        Height = 21
        DataField = 'CAP_DOM_POSTEL'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 7
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbComuneDomicilio: TDBLookupComboBox
        Left = 155
        Top = 103
        Width = 185
        Height = 21
        DataField = 'COM_DOM_POSTEL'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 8
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbProvinciaDomicilio: TDBLookupComboBox
        Left = 155
        Top = 144
        Width = 185
        Height = 21
        DataField = 'PRV_DOM_POSTEL'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 9
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
    end
    object tshCedolino: TTabSheet
      Caption = 'Cedolino'
      ImageIndex = 8
      object lblSedeServizio: TLabel
        Left = 11
        Top = 8
        Width = 63
        Height = 13
        Caption = 'Sede servizio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblUnitaOperativa: TLabel
        Left = 11
        Top = 48
        Width = 72
        Height = 13
        Caption = 'Unit'#224' operativa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQualifica: TLabel
        Left = 11
        Top = 89
        Width = 41
        Height = 13
        Caption = 'Qualifica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescSedeServizio: TLabel
        Left = 202
        Top = 26
        Width = 97
        Height = 13
        Caption = 'lblDescSedeServizio'
      end
      object lblDescUnitaOperativa: TLabel
        Left = 202
        Top = 66
        Width = 106
        Height = 13
        Caption = 'lblDescUnitaOperativa'
      end
      object lblDescQualifica: TLabel
        Left = 202
        Top = 107
        Width = 76
        Height = 13
        Caption = 'lblDescQualifica'
      end
      object lblInizioRapporto: TLabel
        Left = 11
        Top = 131
        Width = 91
        Height = 13
        Caption = 'Data inizio rapporto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescInizioRapporto: TLabel
        Left = 202
        Top = 149
        Width = 103
        Height = 13
        Caption = 'lblDescInizioRapporto'
      end
      object lblPartitaIva: TLabel
        Left = 11
        Top = 173
        Width = 50
        Height = 13
        Caption = 'Partita IVA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescPartitaIva: TLabel
        Left = 202
        Top = 191
        Width = 80
        Height = 13
        Caption = 'lblDescPartitaIva'
      end
      object lblPathFilePDFCed: TLabel
        Left = 11
        Top = 215
        Width = 106
        Height = 13
        Caption = 'Percorso archivio PDF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dcmbSedeServizio: TDBLookupComboBox
        Left = 11
        Top = 22
        Width = 185
        Height = 21
        DataField = 'SEDE_SERVIZIO_CED'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 0
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbUnitaOperativa: TDBLookupComboBox
        Left = 11
        Top = 62
        Width = 185
        Height = 21
        DataField = 'UNITA_OP_CED'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 1
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbQualifica: TDBLookupComboBox
        Left = 11
        Top = 103
        Width = 185
        Height = 21
        DataField = 'QUALIFICA_CED'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 2
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbInizioRapporto: TDBLookupComboBox
        Left = 11
        Top = 145
        Width = 185
        Height = 21
        DataField = 'DATA_INIZIO_CED'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 3
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object dcmbPartitaIva: TDBLookupComboBox
        Left = 11
        Top = 187
        Width = 185
        Height = 21
        DataField = 'PIVA_CED'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 4
        OnExit = dcmbDomicilioExit
        OnKeyDown = dcmbDomicilioKeyDown
      end
      object edtPathFilePDFCed: TDBEdit
        Left = 11
        Top = 229
        Width = 600
        Height = 21
        DataField = 'PATH_FILEPDF_CED'
        DataSource = DButton
        TabOrder = 5
      end
      object sbtPathFilePDFCed: TButton
        Left = 611
        Top = 229
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 6
        OnClick = sbtPathFilePDFCedClick
      end
    end
    object tshFamiliari: TTabSheet
      Caption = 'Familiari'
      ImageIndex = 9
      object grpDichiarazioneFamiliari: TGroupBox
        Left = 3
        Top = 2
        Width = 604
        Height = 291
        Caption = 'Dichiarazione relativa alle detrazioni IRPEF da WEB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblFamPathIstruzioni: TLabel
          Left = 17
          Top = 103
          Width = 127
          Height = 13
          Caption = 'Nome file allegato istruzioni'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFamNote: TLabel
          Left = 17
          Top = 142
          Width = 23
          Height = 13
          Caption = 'Note'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dchkFamStatoCivile: TDBCheckBox
          Left = 17
          Top = 79
          Width = 136
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Richiesta stato civile'
          DataField = 'FAM_STATO_CIVILE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtFamPathIstruzioni: TDBEdit
          Left = 17
          Top = 117
          Width = 295
          Height = 21
          DataField = 'FAM_PATH_ISTRUZIONI'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dmemFamNote: TDBMemo
          Left = 18
          Top = 156
          Width = 567
          Height = 123
          DataField = 'FAM_NOTE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 3
        end
        object grpPeriodoDichiarazione: TGroupBox
          Left = 17
          Top = 18
          Width = 211
          Height = 55
          Caption = 'Periodo abilitazione all'#39'accesso web'
          TabOrder = 0
          object lblFamDataDa: TLabel
            Left = 14
            Top = 16
            Width = 62
            Height = 13
            Caption = 'Inizio periodo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblFamDataA: TLabel
            Left = 114
            Top = 16
            Width = 58
            Height = 13
            Caption = 'Fine periodo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dedtFamDataDa: TDBEdit
            Left = 14
            Top = 30
            Width = 68
            Height = 21
            DataField = 'FAM_DATA_DA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = dedtWebDataStampaChange
          end
          object dedtFamDataA: TDBEdit
            Left = 114
            Top = 30
            Width = 68
            Height = 21
            DataField = 'FAM_DATA_A'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = dedtWebDataStampaChange
          end
          object btnFamDataDa: TButton
            Left = 82
            Top = 30
            Width = 16
            Height = 21
            Caption = '...'
            TabOrder = 1
            OnClick = btnFamDataDaClick
          end
          object btnFamDataA: TButton
            Left = 182
            Top = 30
            Width = 16
            Height = 21
            Caption = '...'
            TabOrder = 3
            OnClick = btnFamDataAClick
          end
        end
      end
    end
  end
  object GroupBox1: TGroupBox [4]
    Left = 0
    Top = 29
    Width = 784
    Height = 44
    Align = alTop
    TabOrder = 3
    object lblAnno: TLabel
      Left = 9
      Top = 18
      Width = 25
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtAnno: TDBEdit
      Left = 85
      Top = 14
      Width = 49
      Height = 21
      DataField = 'ANNO'
      DataSource = DButton
      MaxLength = 4
      TabOrder = 0
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 2
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 446
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 419
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 473
    Top = 2
    Bitmap = {
      494C010117001900240010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      8400000084000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF00848484000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008400000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C600000000000000000000000000000000000000BD000000
      BD000000FF000000FF008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C6000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFF0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFF0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400FFFF0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      84000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FF7EFFFDFFFF00009001FFF8FF7F0000
      C003FFF1FE7F0000E003FFE3FC0F0000E003FFC7FE770000E003E08FFF770000
      E003C01FFFF700000001803FFFF700008000001FF7FF0000E007001FF7FF0000
      E00F001FF77F0000E00F001FF73F0000E027001FF81F0000C073803FFF3F0000
      9E79C07FFF7F00007EFEE0FFFFFF0000FFFFFFFFFFFF8003FFFFFFFFFFFF8003
      FFFFFFFFFFFF8003FCFFFF3FFFFF8003F8FFFC3FFCFF8003F07FF03FFC3F8003
      E27FC000FC0F8003E63F000000038003FF3FC00000008003FF9FF03F00038003
      FFCFFC3FFC0F8003FFCFFF3FFC3F8003FFE7FFFFFCFF8003FFF3FFFFFFFF8007
      FFFFFFFFFFFF800FFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFCFF07C1FFFFDFFFDF7F07C1F8F9CFF7CF3F07C1B879C7D5C71F01019873
      C3E3C30F00018C23C181C38F00018407C3E3C3C70001820FC7D5C7C38003860F
      CFF7CFE3C1078807DFFFDFF1C1079183FFFFFFF0E38FBFC1FFFFFFF9E38FFFF3
      FFFFFFFFE38FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFC007FE1FFFFF
      FFFF8003FE07FC01FFFF00010600FC01FCFF0001FE01FC01FC3F0001F8010001
      FC0F0000F801000100030000F001000100008000C00100010003C000C0010003
      FC0FE001C0010007FC3FE007F001000FFCFFF007F80100FFFFFFF003F80101FF
      FFFFF803F80103FFFFFFFFFFF801FFFFF807FFFE847FFFFFF807FBFF00EFFFFF
      F807F1FD31BFFFFFF807F1FB39FFFF3FF807F8F3993FFC3FF807FC67CA1FF03F
      F803FE0FF40FC000FFF3FF1F9C070000FFF1FE0F9603C000F9F1FC6FCB01F03F
      F0F1F0F3FF80FC3FF0F1E1F9F7C0FF3FF9FBE7FCFFE0FFFFEFF3FFFFEFF0FFFF
      FFF7FFFFFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  inherited ActionList1: TActionList
    Left = 500
    Top = 2
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'File Rich Text Format (*.rtf)|*.rtf|File di testo (*.txt)|*.txt|' +
      'Tutti i files (*.*)|*.*'
    Left = 528
    Top = 2
  end
end
