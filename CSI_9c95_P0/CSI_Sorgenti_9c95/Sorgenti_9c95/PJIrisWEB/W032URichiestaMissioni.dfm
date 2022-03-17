inherited W032FRichiestaMissioni: TW032FRichiestaMissioni
  Tag = 439
  Width = 698
  Height = 1052
  HelpType = htKeyword
  HelpKeyword = 'W032P0'
  ExplicitWidth = 698
  ExplicitHeight = 1052
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 3
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 0
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 1
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 2
  end
  inherited grdRichieste: TmedpIWDBGrid
    Top = 128
    Width = 658
    Height = 58
    ExtraTagParams.Strings = (
      '')
    Caption = 'Richieste di missione'
    OnRenderCell = grdRichiesteRenderCell
    Summary = 'Elenco delle richieste di trasferta/rimborsi'
    DataSource = dsrM140
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitTop = 128
    ExplicitWidth = 658
    ExplicitHeight = 58
  end
  object tabMissioni: TmedpIWTabControl [7]
    Left = 19
    Top = 192
    Width = 212
    Height = 20
    Css = 'gridTabControl'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfDefault
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'tabMissioni'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChanging = tabMissioniTabControlChanging
    OnTabControlChange = tabMissioniTabControlChange
  end
  object lnkDocumento: TmeIWLink [8]
    Left = 456
    Top = 192
    Width = 139
    Height = 17
    Hint = 'Visualizza documento informativo'
    Css = 'link spazio_sx'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkDocumento'
    OnClick = lnkDocumentoClick
    TabOrder = 12
    RawText = False
    Caption = 'Documento informativo'
    medpDownloadButton = False
  end
  object rgRimborsi: TmeIWRegion [9]
    Left = 16
    Top = 776
    Width = 658
    Height = 133
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpRimborsi
    object grdRimborsi: TmedpIWDBGrid
      Left = 20
      Top = 38
      Width = 327
      Height = 56
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'Rimborsi'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 10
      Lines = tlAll
      OnRenderCell = grdRimborsiRenderCell
      Summary = 'Elenco delle richieste di rimborso'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <
        item
          Alignment = taLeftJustify
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end>
      DataSource = dsrM150
      FooterRowCount = 0
      FriendlyName = 'grdAnticipi'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdRimborsiAfterCaricaCDS
    end
    object lblAutRimborsi: TmeIWLabel
      Left = 26
      Top = 16
      Width = 23
      Height = 16
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblAutRimborsi'
      Caption = 'S/N'
      Enabled = True
    end
    object lblRespRimborsi: TmeIWLabel
      Left = 72
      Top = 16
      Width = 105
      Height = 16
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblRespRimborsi'
      Caption = 'Nominativo resp.'
      Enabled = True
    end
  end
  object rgDettaglioGG: TmeIWRegion [10]
    Left = 16
    Top = 924
    Width = 658
    Height = 109
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDettaglioGG
    object grdDettaglioGG: TmedpIWDBGrid
      Left = 19
      Top = 30
      Width = 327
      Height = 56
      ExtraTagParams.Strings = (
        '')
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'Dettagli attivit'#224
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 10
      Lines = tlAll
      OnRenderCell = grdDettaglioGGRenderCell
      Summary = 'Elenco dei dettagli delle attivit'#224
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <
        item
          Alignment = taLeftJustify
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end>
      DataSource = dsrM143
      FooterRowCount = 0
      FriendlyName = 'grdAnticipi'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdDettaglioGGAfterCaricaCDS
    end
  end
  object rgAnticipi: TmeIWRegion [11]
    Left = 16
    Top = 551
    Width = 658
    Height = 219
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpAnticipi
    object rgpAccredito: TmeTIWAdvRadioGroup
      Left = 18
      Top = 7
      Width = 494
      Height = 57
      Css = 'groupbox fs100 width70chr'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderStatus = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebBLACK
      BorderWidth = 0
      Caption = 'Corresponsione dell'#39'anticipo tramite'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpAccredito'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Accredito su c/c bancario o postale'
        'Assegno bancario non trasferibile')
      ItemIndex = 0
      Layout = glHorizontal
      SubmitOnAsyncEvent = True
      TabOrder = 7
      OnClick = rgpAccreditoClick
    end
    object chkDelegato: TmeIWCheckBox
      Left = 22
      Top = 132
      Width = 402
      Height = 21
      Cursor = crAuto
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Delego la seguente persona alla riscossione del corrispettivo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 8
      OnClick = chkDelegatoClick
      Checked = False
      Enabled = False
      FriendlyName = 'chkDelegato'
    end
    object edtCercaDelegato: TmeIWEdit
      Left = 280
      Top = 159
      Width = 179
      Height = 21
      ParentCustomHint = False
      Visible = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtCercaDelegato'
      SubmitOnAsyncEvent = True
      TabOrder = 9
      OnSubmit = edtCercaDelegatoSubmit
    end
    object lblDelegato: TmeIWLabel
      Left = 22
      Top = 170
      Width = 259
      Height = 16
      Visible = False
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      ForControl = edtCercaDelegato
      HasTabOrder = False
      FriendlyName = 'lblDelegato'
      Caption = 'Cerca delegato per cognome / matricola:'
      Enabled = True
    end
    object cmbDelegato: TmeIWComboBox
      Left = 280
      Top = 186
      Width = 179
      Height = 21
      Visible = False
      Css = 'combobox'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      UseSize = False
      TabOrder = 10
      ItemIndex = -1
      FriendlyName = 'cmbDelegato'
      NoSelectionText = '--'
    end
    object btnCercaDelegato: TmeIWButton
      Left = 465
      Top = 171
      Width = 111
      Height = 25
      Visible = False
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Cerca delegato'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnCercaDelegato'
      TabOrder = 11
      OnClick = btnCercaDelegatoClick
      medpDownloadButton = False
    end
    object grdAnticipi: TmedpIWDBGrid
      Left = 22
      Top = 54
      Width = 325
      Height = 56
      ExtraTagParams.Strings = (
        '')
      Css = 'grid gridTrasparente'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'Anticipi'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 10
      Lines = tlAll
      OnRenderCell = grdAnticipiRenderCell
      Summary = 'Elenco delle richieste di anticipo'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <
        item
          Alignment = taLeftJustify
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end>
      DataSource = dsrM160
      FooterRowCount = 0
      FriendlyName = 'grdAnticipi'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdAnticipiAfterCaricaCDS
    end
    object lblTotAnticipi: TmeIWLabel
      Left = 392
      Top = 96
      Width = 80
      Height = 16
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblTotAnticipi'
      Caption = 'lblTotAnticipi'
      Enabled = True
    end
  end
  object rgDettaglio: TmeIWRegion [12]
    Left = 16
    Top = 225
    Width = 658
    Height = 318
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDettaglio
    object cgpMotivEstero: TmeTIWAdvCheckGroup
      Left = 22
      Top = 170
      Width = 327
      Height = 40
      Css = 'groupbox fs100 width98pc'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clNone
      Caption = 
        'In applicazione di quanto disposto con D.G.R. n. 41-13507 del 27' +
        '.09.2004, concernente l'#39'emanazione delle direttive in merito all' +
        'e spese per missioni (L. 191/2004), si dichiara che la presente ' +
        'richiesta di autorizzazione '#232' motivata da:'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpMotivEstero'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 5
    end
    object cgpIpotesiEstero: TmeTIWAdvCheckGroup
      Left = 119
      Top = 224
      Width = 393
      Height = 41
      Css = 'groupbox fs100 width98pc'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = 11776947
      Caption = 'Si dichiara che la trasferta rientra nell'#39'ipotesi seguente:'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpIpotesiEstero'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 6
    end
    object grdMezzi: TmeIWGrid
      Left = 18
      Top = 117
      Width = 437
      Height = 47
      Css = 'grid gridTrasparente'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdMezziRenderCell
      Summary = 'Elenco dei mezzi di trasporto'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdMezzi'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object lblNoteMezzoProprio: TmeIWLabel
      Left = 22
      Top = 288
      Width = 1299
      Height = 16
      Css = 'intestazione note_pie'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblNoteMezzoProprio'
      Caption = 
        '(**) L'#39'indicazione preventiva della targa del veicolo di proprie' +
        't'#224' del dipendente '#232' indispensabile ai fini della copertura assic' +
        'urativa prevista dall'#39'art.7, punto 6 della vigente disciplina (D' +
        '.D. 213 del 08.08.2006)'
      Enabled = True
    end
    object lblDatiObbligatori: TmeIWLabel
      Left = 22
      Top = 271
      Width = 118
      Height = 16
      Css = 'intestazione note_pie'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblNoteTarga'
      Caption = '(*) Dati obbligatori'
      Enabled = True
    end
    object grdDati: TmeIWGrid
      Left = 18
      Top = 36
      Width = 437
      Height = 47
      Css = 'grid gridTrasparente'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdMezziRenderCell
      Summary = 'Elenco dei dati personalizzati associati alla trasferta'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdDati'
      ColumnCount = 2
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object lblMezzi: TmeIWLabel
      Left = 18
      Top = 95
      Width = 136
      Height = 16
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblMezzi'
      Caption = '(*) Mezzi di trasporto'
      Enabled = True
    end
  end
  inherited pmnTabella: TPopupMenu
    Left = 568
    Top = 136
  end
  object dsrM140: TDataSource
    DataSet = cdsM140
    Left = 408
    Top = 132
  end
  object cdsM140: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 132
  end
  object tpAnticipi: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W032FAnticipiRG.html'
    RenderStyles = False
    Left = 632
    Top = 561
  end
  object dsrM160: TDataSource
    DataSet = cdsM160
    Left = 272
    Top = 616
  end
  object cdsM160: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 616
  end
  object tpDettaglio: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W032FDettaglioRG.html'
    RenderStyles = False
    Left = 632
    Top = 225
  end
  object tpRimborsi: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W032FRimborsiRG.html'
    RenderStyles = False
    Left = 632
    Top = 785
  end
  object dsrM150: TDataSource
    DataSet = cdsM150
    Left = 264
    Top = 826
  end
  object cdsM150: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 826
  end
  object cdsM143: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 970
  end
  object dsrM143: TDataSource
    DataSet = cdsM143
    Left = 264
    Top = 970
  end
  object tpDettaglioGG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W032FDettaglioGGRG.html'
    RenderStyles = False
    Left = 632
    Top = 929
  end
end
