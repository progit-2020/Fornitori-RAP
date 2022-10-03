inherited W018FRichiestaTimbrature: TW018FRichiestaTimbrature
  Tag = 406
  Width = 706
  Height = 401
  HelpType = htKeyword
  HelpKeyword = 'W018P0'
  ExplicitWidth = 706
  ExplicitHeight = 401
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 19
    Top = 280
    Width = 666
    Height = 65
    ExtraTagParams.Strings = (
      
        'summary=griglia per la visualizzazione e cancellazione delle ric' +
        'hieste di modifica timbrature')
    StyleRenderOptions.RenderPosition = True
    StyleRenderOptions.RenderFont = True
    StyleRenderOptions.RenderZIndex = True
    StyleRenderOptions.RenderAbsolute = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di modifica timbrature'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT105
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 19
    ExplicitTop = 280
    ExplicitWidth = 666
    ExplicitHeight = 65
  end
  object grdTimbrature: TmedpIWDBGrid [7]
    Left = 19
    Top = 168
    Width = 662
    Height = 66
    ExtraTagParams.Strings = (
      
        'summary=griglia per la visualizzazione, inserimento, modifica e ' +
        'cancellazione delle timbrature del giorno selezionato')
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
    Caption = 'Timbrature del giorno'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 10
    Lines = tlAll
    OnRenderCell = grdTimbratureRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT100
    FooterRowCount = 0
    FriendlyName = 'grdTimbrature'
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
    OnAfterCaricaCDS = grdTimbratureAfterCaricaCDS
  end
  object btnVisualizza: TmeIWButton [8]
    Left = 255
    Top = 132
    Width = 75
    Height = 25
    Css = 'pulsante'
    ShowHint = False
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
    FriendlyName = 'btnVisualizza'
    TabOrder = 4
    OnClick = btnVisualizzaClick
    medpDownloadButton = False
  end
  object edtDataFiltro: TmeIWEdit [9]
    Left = 168
    Top = 132
    Width = 73
    Height = 21
    Hint = 
      'Data per la visualizzazione delle timbrature del giorno. Formato' +
      ' ggmmyyyy'
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
    FriendlyName = 'edtDataFiltro'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnSubmit = edtDataFiltroSubmit
  end
  object lblDataFiltro: TmeIWLabel [10]
    Left = 24
    Top = 132
    Width = 143
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
    ForControl = edtDataFiltro
    HasTabOrder = False
    FriendlyName = 'lblDataFiltro'
    Caption = 'Timbrature del giorno:'
    Enabled = True
  end
  object btnRiepilogoOre: TmeIWButton [11]
    Left = 19
    Top = 364
    Width = 122
    Height = 25
    Css = 'pulsante'
    ShowHint = False
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Riepilogo ore'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizza'
    TabOrder = 7
    OnClick = btnRiepilogoOreClick
    medpDownloadButton = False
  end
  object btnImporta: TmeIWButton [12]
    Left = 147
    Top = 364
    Width = 177
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
    Caption = 'Conferma autorizzazioni'
    Confirmation = 'Confermare le autorizzazioni impostate?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnImporta'
    TabOrder = 8
    OnClick = btnImportaClick
    medpDownloadButton = False
  end
  object dsrT105: TDataSource
    DataSet = cdsT105
    Left = 526
    Top = 289
  end
  object cdsT105: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 574
    Top = 289
  end
  object dsrT100: TDataSource
    DataSet = cdsT100
    Left = 550
    Top = 185
  end
  object cdsT100: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 598
    Top = 185
  end
end
