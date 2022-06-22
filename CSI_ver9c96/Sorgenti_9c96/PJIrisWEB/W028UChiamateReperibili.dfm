inherited W028FChiamateReperibili: TW028FChiamateReperibili
  Tag = 435
  Width = 752
  Height = 438
  HelpType = htKeyword
  HelpKeyword = 'W028P0'
  Title = '(W028) Chiamate in reperibilit'#224
  ExplicitWidth = 752
  ExplicitHeight = 438
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object grdChiamate: TmedpIWDBGrid [6]
    Left = 16
    Top = 290
    Width = 720
    Height = 138
    ExtraTagParams.Strings = (
      
        'summary=elenco delle chiamate in reperibilit'#224' con i relativi esi' +
        'ti')
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
    Caption = 'Chiamate in reperibilit'#224
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdChiamateRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT390
    FooterRowCount = 0
    FriendlyName = 'grdChiamate'
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
    OnAfterCaricaCDS = grdChiamateAfterCaricaCDS
  end
  object edtDal: TmeIWEdit [7]
    Left = 480
    Top = 172
    Width = 69
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 4
  end
  object edtAl: TmeIWEdit [8]
    Left = 575
    Top = 172
    Width = 69
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 6
  end
  object rgpTipoEsito: TmeIWRadioGroup [9]
    Left = 174
    Top = 172
    Width = 269
    Height = 25
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpTipoEsitoClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipoEsito'
    ItemIndex = 3
    Items.Strings = (
      'Trovato'
      'Non trovato'
      'Annullato'
      'Tutti')
    Layout = glHorizontal
    TabOrder = 7
  end
  object rgpTipoUtente: TmeIWRadioGroup [10]
    Left = 28
    Top = 172
    Width = 120
    Height = 25
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpTipoUtenteClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipoUtente'
    ItemIndex = 0
    Items.Strings = (
      'Proprio'
      'Tutti')
    Layout = glHorizontal
    TabOrder = 8
  end
  object btnEsegui: TmeIWButton [11]
    Left = 664
    Top = 170
    Width = 75
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Visualizza'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    TabOrder = 9
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object lblPeriodoDal: TmeIWLabel [12]
    Left = 455
    Top = 172
    Width = 18
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
    ForControl = edtDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'dal'
    Enabled = True
  end
  object lblPeriodoAl: TmeIWLabel [13]
    Left = 555
    Top = 172
    Width = 11
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
    ForControl = edtAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoAl'
    Caption = 'al'
    Enabled = True
  end
  object cmbFiltroDato1: TmeIWComboBox [14]
    Left = 77
    Top = 227
    Width = 121
    Height = 21
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
    ItemsHaveValues = True
    OnChange = cmbFiltroDato1Change
    UseSize = False
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'cmbFiltroDato1'
    NoSelectionText = '-- No Selection --'
  end
  object cmbFiltroDato2: TmeIWComboBox [15]
    Left = 77
    Top = 254
    Width = 121
    Height = 21
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
    ItemsHaveValues = True
    OnChange = cmbFiltroDato1Change
    UseSize = False
    TabOrder = 11
    ItemIndex = -1
    FriendlyName = 'cmbFiltroDato2'
    NoSelectionText = '-- No Selection --'
  end
  object lblFiltroDato1: TmeIWLabel [16]
    Left = 31
    Top = 225
    Width = 40
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
    ForControl = cmbFiltroDato1
    HasTabOrder = False
    FriendlyName = 'lblFiltroDato1'
    Caption = 'Dato 1'
    Enabled = True
  end
  object lblFiltroDato2: TmeIWLabel [17]
    Left = 31
    Top = 252
    Width = 40
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
    ForControl = cmbFiltroDato2
    HasTabOrder = False
    FriendlyName = 'lblFiltroDato2'
    Caption = 'Dato 2'
    Enabled = True
  end
  object lblLegendaFiltri: TmeIWLabel [18]
    Left = 19
    Top = 203
    Width = 101
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
    FriendlyName = 'lblLegendaFiltri'
    Caption = 'Filtro dipendenti'
    Enabled = True
  end
  object dsrT390: TDataSource
    DataSet = cdsT390
    Left = 552
    Top = 360
  end
  object cdsT390: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 360
  end
end
