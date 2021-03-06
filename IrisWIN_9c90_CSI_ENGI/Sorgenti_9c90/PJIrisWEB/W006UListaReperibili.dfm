inherited W006FListaReperibili: TW006FListaReperibili
  Tag = 404
  Width = 554
  Height = 314
  HelpType = htKeyword
  HelpKeyword = 'W006P0'
  Title = '(W006) Lista personale reperibile'
  ExplicitWidth = 554
  ExplicitHeight = 314
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 2
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 4
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 5
  end
  object btnEsegui: TmeIWButton [5]
    Left = 392
    Top = 140
    Width = 75
    Height = 25
    Cursor = crAuto
    Css = 'pulsante'
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
    Caption = 'Visualizza'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    ScriptEvents = <>
    TabOrder = 6
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object lblPeriodoDal: TmeIWLabel [6]
    Left = 19
    Top = 144
    Width = 171
    Height = 16
    Cursor = crAuto
    Css = 'intestazione'
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
    Alignment = taLeftJustify
    BGColor = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    NoWrap = True
    ConvertSpaces = False
    ForControl = edtDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Periodo da visualizzare dal '
    RawText = False
    Enabled = True
  end
  object edtDal: TmeIWEdit [7]
    Left = 191
    Top = 140
    Width = 73
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    Alignment = taLeftJustify
    BGColor = clNone
    FocusColor = clNone
    Editable = True
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDal'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 0
    PasswordPrompt = False
  end
  object lblPeriodoAl: TmeIWLabel [8]
    Left = 275
    Top = 144
    Width = 15
    Height = 16
    Cursor = crAuto
    Css = 'intestazione'
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
    Alignment = taLeftJustify
    BGColor = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    NoWrap = False
    ConvertSpaces = False
    ForControl = edtAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoAl'
    Caption = 'al '
    RawText = False
    Enabled = True
  end
  object edtAl: TmeIWEdit [9]
    Left = 299
    Top = 140
    Width = 73
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    Alignment = taLeftJustify
    BGColor = clNone
    FocusColor = clNone
    Editable = True
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtAl'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 3
    PasswordPrompt = False
  end
  object grdReperibili: TmeIWGrid [10]
    Left = 19
    Top = 185
    Width = 504
    Height = 112
    Cursor = crAuto
    OnHTMLTag = grdReperibiliHTMLTag
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
    StyleRenderOptions.RenderPadding = False
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
    OnRenderCell = grdReperibiliRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdReperibili'
    ColumnCount = 1
    OnCellClick = grdReperibiliCellClick
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
end
