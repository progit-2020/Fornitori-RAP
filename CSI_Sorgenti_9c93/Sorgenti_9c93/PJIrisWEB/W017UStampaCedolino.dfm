inherited W017FStampaCedolino: TW017FStampaCedolino
  Tag = 417
  Width = 594
  Height = 296
  HelpType = htKeyword
  HelpKeyword = 'W017P0'
  Title = '(W017) Stampa cedolino'
  ExplicitWidth = 594
  ExplicitHeight = 296
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 3
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 5
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 7
  end
  object lblDataCedolinoDal: TmeIWLabel [6]
    Left = 8
    Top = 134
    Width = 115
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
    ForControl = edtDataCedolinoDal
    HasTabOrder = False
    FriendlyName = 'lblDataCedolinoDal'
    Caption = 'Elenca cedolini dal'
    Enabled = True
  end
  object edtDataCedolinoDal: TmeIWEdit [7]
    Left = 129
    Top = 132
    Width = 73
    Height = 21
    Css = 'input_data_my'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'TmeIWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 0
    OnSubmit = btnDataCedolinoClick
  end
  object chkCumuloVociArretrate: TmeIWCheckBox [8]
    Left = 107
    Top = 159
    Width = 153
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
    Caption = 'Cumulo voci arretrate'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    DoSubmitValidation = False
    Style = stNormal
    TabOrder = 2
    Checked = True
    FriendlyName = 'chkCumuloVociArretrate'
  end
  object chkStampaOrigine: TmeIWCheckBox [9]
    Left = 264
    Top = 166
    Width = 225
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
    Caption = 'Stampa origine voci ed eccezioni'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    DoSubmitValidation = False
    Style = stNormal
    TabOrder = 6
    Checked = False
    FriendlyName = 'chkCodiciDescrizioni'
  end
  object btnDataCedolino: TmeIWButton [10]
    Left = 313
    Top = 129
    Width = 121
    Height = 26
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Cedolini disponibili'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnDataCedolino'
    TabOrder = 8
    OnClick = btnDataCedolinoClick
    medpDownloadButton = False
  end
  object edtDataCedolinoAl: TmeIWEdit [11]
    Left = 232
    Top = 132
    Width = 73
    Height = 21
    Css = 'input_data_my'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDataCedolinoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnSubmit = btnDataCedolinoClick
  end
  object lblDataCedolinoAl: TmeIWLabel [12]
    Left = 212
    Top = 134
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
    ForControl = edtDataCedolinoAl
    HasTabOrder = False
    FriendlyName = 'lblDataCedolino'
    Caption = 'al'
    Enabled = True
  end
  object lblOpzioni: TmeIWLabel [13]
    Left = 21
    Top = 164
    Width = 46
    Height = 16
    Css = 'intestazione'
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
    FriendlyName = 'lblOpzioni'
    Caption = 'Opzioni'
    Enabled = True
  end
  object dgrdCedolini: TmedpIWDBGrid [14]
    Left = 21
    Top = 223
    Width = 255
    Height = 69
    ExtraTagParams.Strings = (
      'summary=tabella contenente i cedolini disponibili')
    Css = 'grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'Riepilogo cedolini'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = dgrdCedoliniRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrP441
    FooterRowCount = 0
    FriendlyName = 'dgrdCedolini'
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
    OnAfterCaricaCDS = dgrdCedoliniAfterCaricaCDS
  end
  object cdsRiepilogo: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 304
    Top = 226
  end
  object cdsDettaglio: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 369
    Top = 227
  end
  object cdsNote: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 429
    Top = 227
  end
  object cdsP441: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 170
    Top = 246
  end
  object dsrP441: TDataSource
    AutoEdit = False
    DataSet = cdsP441
    Left = 232
    Top = 248
  end
end
