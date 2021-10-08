inherited W023FPianifOrari: TW023FPianifOrari
  Tag = 425
  Width = 642
  Height = 360
  HelpType = htKeyword
  HelpKeyword = 'W023P0'
  Title = '(W023) Pianificazioni giornaliere'
  ExplicitWidth = 642
  ExplicitHeight = 360
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 3
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 0
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 2
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object grdPianif: TmedpIWDBGrid [6]
    Left = 19
    Top = 200
    Width = 606
    Height = 142
    ExtraTagParams.Strings = (
      'summary=elenco delle pianificazioni giornaliere')
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
    Caption = 'Pianificazioni giornaliere'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdPianifRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT080
    FooterRowCount = 0
    FriendlyName = 'grdPianif'
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
    OnAfterCaricaCDS = grdPianifAfterCaricaCDS
  end
  object edtDal: TmeIWEdit [7]
    Left = 174
    Top = 159
    Width = 73
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
  object lblPeriodoDal: TmeIWLabel [8]
    Left = 19
    Top = 160
    Width = 159
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
    Caption = 'Periodo da elaborare dal '
    Enabled = True
  end
  object edtAl: TmeIWEdit [9]
    Left = 276
    Top = 159
    Width = 73
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
    FriendlyName = 'edtAl'
    SubmitOnAsyncEvent = True
    TabOrder = 6
  end
  object lblPeriodoAl: TmeIWLabel [10]
    Left = 254
    Top = 160
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
  object btnEsegui: TmeIWButton [11]
    Left = 368
    Top = 157
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
    TabOrder = 7
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object btnCancella: TmeIWButton [12]
    Left = 449
    Top = 157
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
    Caption = 'Cancella'
    Confirmation = 'Eliminare le pianificazioni presenti nel periodo indicato?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'meIWButton1'
    TabOrder = 8
    OnClick = btnCancellaClick
    medpDownloadButton = False
  end
  object dsrT080: TDataSource
    DataSet = cdsT080
    Left = 504
    Top = 264
  end
  object cdsT080: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 560
    Top = 264
  end
end
