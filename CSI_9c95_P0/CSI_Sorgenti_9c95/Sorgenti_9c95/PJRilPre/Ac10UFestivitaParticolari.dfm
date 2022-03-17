inherited Ac10FFestivitaParticolari: TAc10FFestivitaParticolari
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<Ac10> Regole festivit'#224' particolari'
  ClientHeight = 541
  ClientWidth = 884
  ExplicitWidth = 900
  ExplicitHeight = 599
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 523
    Width = 884
    Panels = <
      item
        Text = 'Data'
        Width = 150
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Text = 'Record Dettaglio'
        Width = 50
      end>
    ExplicitTop = 523
    ExplicitWidth = 884
  end
  inherited Panel1: TToolBar
    Width = 884
    ExplicitWidth = 884
  end
  object pnlMaster: TPanel [2]
    Left = 0
    Top = 29
    Width = 884
    Height = 188
    Align = alTop
    TabOrder = 2
    object lblCompCausSost: TLabel
      Left = 487
      Top = 114
      Width = 182
      Height = 13
      Caption = 'Comportamento causale di esclusione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblCausSostit: TLabel
      Left = 27
      Top = 165
      Width = 98
      Height = 13
      Caption = 'Causali di esclusione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCausNOFruibili: TLabel
      Left = 15
      Top = 141
      Width = 110
      Height = 13
      Caption = 'S.P.: Causali non fruibili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCausInserimento: TLabel
      Left = 64
      Top = 114
      Width = 61
      Height = 13
      Caption = 'Causale S.P.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSceltePossibili: TLabel
      Left = 706
      Top = 88
      Width = 69
      Height = 13
      Caption = 'Scelte possibili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblScelta: TLabel
      Left = 48
      Top = 88
      Width = 77
      Height = 13
      Caption = 'Possibilit'#224' scelta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFineScelta: TLabel
      Left = 719
      Top = 11
      Width = 51
      Height = 13
      Caption = 'Fine scelta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblInizioScelta: TLabel
      Left = 516
      Top = 11
      Width = 55
      Height = 13
      Caption = 'Inizio scelta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCondizApplic: TLabel
      Left = 4
      Top = 63
      Width = 121
      Height = 13
      Caption = 'Condizioni di applicazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNOScelta: TLabel
      Left = 421
      Top = 88
      Width = 120
      Height = 13
      Caption = 'Comportamento no scelta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSelezioneAnagrafe: TLabel
      Left = 34
      Top = 38
      Width = 91
      Height = 13
      Caption = 'Selezione anagrafe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoFestivita: TLabel
      Left = 268
      Top = 11
      Width = 60
      Height = 13
      Caption = 'Tipo festivit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataFestivita: TLabel
      Left = 61
      Top = 11
      Width = 62
      Height = 13
      Caption = 'Data festivit'#224
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object btnSelezioneAnagrafe: TSpeedButton
      Left = 853
      Top = 35
      Width = 23
      Height = 21
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84828400000000000000
        0000848284FFFFFF00FFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF00000084828484828484828484828484828400000000000000FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000848284FFFFFFC6C3C6FFFFFFC6
        C3C6FFFFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848284
        848284FFFFFFC6C3C6FFFFFFFF0000FFFFFFC6C3C6FFFFFF848284848284FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000848284C6C3C6FFFFFFC6C3C6FF0000C6
        C3C6FFFFFFC6C3C6848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        848284FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF848284000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000848284C6C3C6FFFFFFC6C3C6FF0000C6
        C3C6FFFFFFC6C3C6848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848284
        848284FFFFFFC6C3C6FFFFFFFF0000FFFFFFC6C3C6FFFFFF848284848284FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000848284FFFFFFC6C3C6FFFFFFC6
        C3C6FFFFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000848284848284848284848284848284000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84828400000000000000
        0000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = btnSelezioneAnagrafeClick
    end
    object dEdtSelezioneAnagrafe: TDBEdit
      Left = 131
      Top = 35
      Width = 720
      Height = 21
      DataField = 'FILTRO_ANAGRA'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 7
    end
    object dCmbCompCausSost: TDBComboBox
      Left = 672
      Top = 111
      Width = 204
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'COMP_CAUSSOST'
      DataSource = DButton
      Items.Strings = (
        'B'
        'C'
        'Z')
      TabOrder = 14
      OnDrawItem = dCmbCompCausSostDrawItem
    end
    object btnCausSostituzione: TButton
      Left = 861
      Top = 162
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 18
      OnClick = btnCausSostituzioneClick
    end
    object dEdtCausSostituzione: TDBEdit
      Left = 131
      Top = 162
      Width = 730
      Height = 21
      DataField = 'CAUS_SOSTIT'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 17
    end
    object btnCausInComp: TButton
      Left = 861
      Top = 138
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 16
      OnClick = btnCausInCompClick
    end
    object dEdtCausInComp: TDBEdit
      Left = 131
      Top = 138
      Width = 730
      Height = 21
      DataField = 'CAUS_INCOMP'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 15
    end
    object dCmbCausInserimento: TDBLookupComboBox
      Left = 131
      Top = 111
      Width = 145
      Height = 21
      DataField = 'CAUS_INSERT'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = Ac10FFestivitaParticolariMW.dsrSelT265_All
      TabOrder = 13
    end
    object btnSceltePossibili: TButton
      Left = 861
      Top = 85
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 12
      OnClick = btnSceltePossibiliClick
    end
    object DEdtFlagScelta: TDBEdit
      Left = 781
      Top = 85
      Width = 80
      Height = 21
      DataField = 'SCELTE_POSSIBILI'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 11
    end
    object dCmbScelta: TDBComboBox
      Left = 131
      Top = 85
      Width = 284
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'FLAG_SCELTA'
      DataSource = DButton
      Items.Strings = (
        'S'
        'N'
        'L')
      TabOrder = 9
      OnChange = dCmbSceltaChange
      OnDrawItem = dCmbSceltaDrawItem
    end
    object btnFineScelta: TButton
      Left = 861
      Top = 8
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = btnFineSceltaClick
    end
    object btnInizioScelta: TButton
      Left = 657
      Top = 8
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = btnInizioSceltaClick
    end
    object dEdtFineScelta: TDBEdit
      Left = 775
      Top = 8
      Width = 86
      Height = 21
      DataField = 'FINE_SCELTA'
      DataSource = DButton
      TabOrder = 5
    end
    object dEdtInizioScelta: TDBEdit
      Left = 577
      Top = 8
      Width = 77
      Height = 21
      DataField = 'INIZIO_SCELTA'
      DataSource = DButton
      TabOrder = 3
    end
    object dCmbCondizApplic: TDBComboBox
      Left = 131
      Top = 60
      Width = 284
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'CONDIZIONE_APPLIC'
      DataSource = DButton
      Items.Strings = (
        'A'
        'B'
        'C'
        'S')
      TabOrder = 8
      OnDrawItem = dCmbCondizApplicDrawItem
    end
    object dCmbNOScelta: TDBComboBox
      Left = 546
      Top = 85
      Width = 145
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'COMP_NOSCELTA'
      DataSource = DButton
      Items.Strings = (
        'A'
        'B'
        'C'
        'Z')
      TabOrder = 10
      OnDrawItem = dCmbNOSceltaDrawItem
    end
    object btnDataFestivita: TButton
      Left = 210
      Top = 8
      Width = 15
      Height = 22
      Caption = '...'
      Enabled = False
      TabOrder = 1
      OnClick = btnDataFestivitaClick
    end
    object dcmbTipoFestivita: TDBComboBox
      Left = 336
      Top = 8
      Width = 133
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'TIPO_FESTIVITA'
      DataSource = DButton
      Items.Strings = (
        'A'
        'B'
        'C')
      TabOrder = 2
      OnChange = dcmbTipoFestivitaChange
      OnDrawItem = dcmbTipoFestivitaDrawItem
    end
    object dEdtDataFestivita: TDBEdit
      Left = 131
      Top = 8
      Width = 77
      Height = 21
      DataField = 'DATA_FESTIVITA'
      DataSource = DButton
      TabOrder = 0
    end
  end
  object pnlDetail: TPanel [3]
    Left = 0
    Top = 217
    Width = 884
    Height = 306
    Align = alClient
    TabOrder = 3
    inline frmToolbarFiglio: TfrmToolbarFiglio
      Left = 1
      Top = 1
      Width = 882
      Height = 23
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 882
      inherited tlbarFiglio: TToolBar
        Width = 882
        ExplicitWidth = 882
        inherited btnTFModifica: TToolButton
          OnClick = frmToolbarFigliobtnTFModificaClick
        end
        inherited btnTFAnnulla: TToolButton
          OnClick = frmToolbarFigliobtnTFAnnullaClick
        end
      end
      inherited actlstToolbarFiglio: TActionList
        inherited actTFModifica: TAction
          OnExecute = frmToolbarFiglioactTFModificaExecute
        end
      end
    end
    object dGrdDetail: TDBGrid
      Left = 1
      Top = 24
      Width = 882
      Height = 240
      Align = alClient
      DataSource = Ac10FFestivitaParticolariDtm.dsrSelCSI10Detail
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dGrdDetailEditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'TIPO_RECORD'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COGNOME'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MATRICOLA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_FESTIVITA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO_FESTIVITA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONDIZIONE_APPLIC'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INIZIO_SCELTA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FINE_SCELTA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FLAG_SCELTA'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'SCELTE_POSSIBILI'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCELTA_EFFETTUATA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_SCELTA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMP_NOSCELTA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAUS_INSERT'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CAUS_INCOMP'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CAUS_SOSTIT'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMP_CAUSSOST'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCELTA_DEFINITIVA'
          Width = 64
          Visible = True
        end>
    end
    object drgpFiltro: TRadioGroup
      Left = 1
      Top = 264
      Width = 882
      Height = 41
      Align = alBottom
      Caption = 'Filtro'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Manuali'
        'Automatici'
        'Tutti')
      ParentFont = False
      TabOrder = 2
      OnClick = drgpFiltroClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 456
    Top = 2
  end
  inherited DButton: TDataSource
    DataSet = Ac10FFestivitaParticolariDtm.selCSI010Master
    Left = 484
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 512
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 540
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 568
    Top = 2
  end
end
