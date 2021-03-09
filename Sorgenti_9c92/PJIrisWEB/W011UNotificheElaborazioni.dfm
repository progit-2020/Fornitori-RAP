inherited W011FNotificheElaborazioni: TW011FNotificheElaborazioni
  Tag = 408
  Width = 685
  Height = 311
  HelpType = htKeyword
  HelpKeyword = 'W011P0'
  ExplicitWidth = 685
  ExplicitHeight = 311
  DesignLeft = 8
  DesignTop = 8
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 4
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object memLog: TmeIWMemo [6]
    Left = 59
    Top = 215
    Width = 241
    Height = 75
    Cursor = crAuto
    Css = 'textarea_note height6'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    BGColor = clNone
    Editable = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 8
    Font.Style = []
    ScriptEvents = <>
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 3
    SubmitOnAsyncEvent = True
    FriendlyName = 'memLog'
  end
  object memTesto: TmeIWMemo [7]
    Left = 371
    Top = 215
    Width = 241
    Height = 73
    Cursor = crAuto
    Css = 'textarea_note height6'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    BGColor = clNone
    Editable = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 8
    Font.Style = []
    ScriptEvents = <>
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 6
    SubmitOnAsyncEvent = True
    FriendlyName = 'memTesto'
  end
  object grdMessaggi: TmedpIWDBGrid [8]
    Left = 59
    Top = 147
    Width = 553
    Height = 62
    Cursor = crAuto
    ExtraTagParams.Strings = (
      
        'summary=tabella contenente i messaggi automatici di esito delle ' +
        'operazioni di importazione delle richieste web')
    Css = 'grid'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'Notifiche'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdMessaggiRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT280
    FooterRowCount = 0
    FriendlyName = 'grdMessaggi'
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
    OnAfterCaricaCDS = grdMessaggiAfterCaricaCDS
  end
  object dsrT280: TDataSource
    DataSet = cdsT280
    Left = 347
    Top = 152
  end
  object cdsT280: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 395
    Top = 152
  end
end
