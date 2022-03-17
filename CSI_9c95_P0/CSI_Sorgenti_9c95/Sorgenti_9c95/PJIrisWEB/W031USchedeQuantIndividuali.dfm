inherited W031FSchedeQuantIndividuali: TW031FSchedeQuantIndividuali
  Tag = 439
  Width = 801
  Height = 661
  HelpType = htKeyword
  HelpKeyword = 'W031P0'
  Title = '(W031) Schede quantitative individuali'
  ExplicitWidth = 801
  ExplicitHeight = 661
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited lblCommentoCorrente: TmeIWLabel
    Width = 154
    Height = 18
    ExplicitWidth = 154
    ExplicitHeight = 18
  end
  object tbSchede: TmedpIWTabControl [6]
    Left = 21
    Top = 296
    Width = 300
    Height = 27
    Cursor = crAuto
    Css = 'gridTabControl'
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
    CellRenderOptions = []
    FriendlyName = 'tbSchede'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'TabControl'
  end
  object chkSupervisore: TmeIWCheckBox [7]
    Left = 24
    Top = 252
    Width = 121
    Height = 21
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
    Caption = 'Supervisore'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    ScriptEvents = <>
    Style = stNormal
    TabOrder = 4
    OnClick = chkSupervisoreClick
    Checked = False
    FriendlyName = 'chkSupervisore'
  end
  object lblGruppo: TmeIWLabel [8]
    Left = 23
    Top = 128
    Width = 57
    Height = 18
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
    HasTabOrder = False
    FriendlyName = 'lblGruppo'
    Caption = 'Gruppo:'
    RawText = False
    Enabled = True
  end
  object lblQuota: TmeIWLabel [9]
    Left = 151
    Top = 128
    Width = 49
    Height = 18
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
    HasTabOrder = False
    FriendlyName = 'lblQuota'
    Caption = 'Quota:'
    RawText = False
    Enabled = True
  end
  object lblAnno: TmeIWLabel [10]
    Left = 252
    Top = 128
    Width = 41
    Height = 18
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
    HasTabOrder = False
    FriendlyName = 'lblAnno'
    Caption = 'Anno:'
    RawText = False
    Enabled = True
  end
  object lblNumDip: TmeIWLabel [11]
    Left = 25
    Top = 172
    Width = 69
    Height = 18
    Cursor = crAuto
    Css = 'font_rosso'
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
    HasTabOrder = False
    FriendlyName = 'lblNumDip'
    Caption = 'lblNumDip'
    RawText = False
    Enabled = True
  end
  object btnApplica: TmeIWButton [12]
    Left = 410
    Top = 252
    Width = 112
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
    Caption = 'Applica modifiche'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplica'
    ScriptEvents = <>
    TabOrder = 6
    OnClick = btnApplicaClick
    medpDownloadButton = False
  end
  object lnkIstruzioni: TmeIWLink [13]
    Left = 350
    Top = 303
    Width = 65
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    ScriptEvents = <>
    DoSubmitValidation = False
    FriendlyName = 'lnkIstruzioni'
    OnClick = lnkIstruzioniClick
    TabOrder = 7
    RawText = False
    Caption = 'Istruzioni'
    medpDownloadButton = False
  end
  object grdRiepilogo: TmeIWGrid [14]
    Left = 25
    Top = 188
    Width = 190
    Height = 53
    Cursor = crAuto
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
    OnRenderCell = grdRiepilogoRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdRiepilogo'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object cmbSupervisore: TmeIWComboBox [15]
    Left = 125
    Top = 247
    Width = 121
    Height = 21
    Cursor = crAuto
    Css = 'select_perc50'
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 8
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbSupervisore'
  end
  object cmbGruppo: TmeIWComboBox [16]
    Left = 19
    Top = 145
    Width = 121
    Height = 21
    Cursor = crAuto
    Css = 'select_perc50'
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbGruppoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 9
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbGruppo'
  end
  object cmbQuota: TmeIWComboBox [17]
    Left = 151
    Top = 145
    Width = 83
    Height = 21
    Cursor = crAuto
    Css = 'select_perc50'
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbQuotaChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 10
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbQuota'
  end
  object cmbAnno: TmeIWComboBox [18]
    Left = 252
    Top = 145
    Width = 83
    Height = 21
    Cursor = crAuto
    Css = 'select_perc50'
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbAnnoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 11
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbAnno'
  end
  object W031QuoteQualitativeRG: TmeIWRegion [19]
    Left = 18
    Top = 531
    Width = 670
    Height = 106
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = tpQuoteQualitative
    ZIndex = 1000
    Splitter = False
    object grdQuoteQual: TmeIWGrid
      Left = 9
      Top = 28
      Width = 331
      Height = 58
      Cursor = crAuto
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
      OnRenderCell = grdQuoteQualRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      FriendlyName = 'grdQuoteQual'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
  end
  object W031SchedeIndividualiRG: TmeIWRegion [20]
    Left = 20
    Top = 340
    Width = 668
    Height = 173
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = tpSchedeIndividuali
    ZIndex = 1000
    Splitter = False
    object grdSchedeDip: TmedpIWDBGrid
      Left = 8
      Top = 130
      Width = 331
      Height = 34
      Cursor = crAuto
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
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdSchedeDipRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      DataSource = dsrT768
      FooterRowCount = 0
      FriendlyName = 'grdSchedeDip'
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
      OnAfterCaricaCDS = grdSchedeDipAfterCaricaCDS
    end
    object btnModifica: TmeIWButton
      Left = 28
      Top = 92
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
      Caption = 'Modifica'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnModifica'
      ScriptEvents = <>
      TabOrder = 12
      OnClick = btnModificaClick
      medpDownloadButton = False
    end
    object btnConferma: TmeIWButton
      Left = 167
      Top = 91
      Width = 110
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
      Caption = 'Applica modifiche'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 13
      OnClick = btnConfermaClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 327
      Top = 91
      Width = 110
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAnnulla'
      ScriptEvents = <>
      TabOrder = 14
      OnClick = btnAnnullaClick
      medpDownloadButton = False
    end
    object btnStampa: TmeIWButton
      Left = 507
      Top = 91
      Width = 110
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
      Caption = 'Stampa gruppo'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnStampa'
      ScriptEvents = <>
      TabOrder = 15
      OnClick = btnStampaClick
      medpDownloadButton = False
    end
    object lnkLegendaFlex: TmeIWLink
      Left = 416
      Top = 12
      Width = 113
      Height = 17
      Cursor = crAuto
      Css = 'link'
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
      Color = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = [fsUnderline]
      ScriptEvents = <>
      DoSubmitValidation = False
      FriendlyName = 'lnkLegendaFlex'
      OnClick = lnkLegendaFlexClick
      TabOrder = 16
      RawText = False
      Caption = 'Legenda Flessibilit'#224
      medpDownloadButton = False
    end
    object rgpTipoSchede: TmeIWRadioGroup
      Left = 111
      Top = 8
      Width = 173
      Height = 25
      Cursor = crDefault
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
      OnClick = rgpTipoSchedeClick
      SubmitOnAsyncEvent = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoSchede'
      ItemIndex = 2
      Items.Strings = (
        'firmate'
        'da firmare'
        'tutte')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 17
    end
    object lblVisualizzazione: TmeIWLabel
      Left = 3
      Top = 8
      Width = 127
      Height = 18
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
      HasTabOrder = False
      FriendlyName = 'lblVisualizzazione'
      Caption = 'Visualizza schede:'
      RawText = False
      Enabled = True
    end
  end
  object dsrT768: TDataSource
    AutoEdit = False
    DataSet = cdsT768
    Left = 712
    Top = 173
  end
  object cdsT768: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 712
    Top = 129
  end
  object selT767Dati: TOracleDataSet
    SQL.Strings = (
      'select distinct :DATI'
      '  from t767_incquantgruppo T767, T765_TIPOQUOTE T765'
      ' where T767.CODTIPOQUOTA = T765.CODICE'
      
        '   and T765.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQ' +
        'UOTE'
      '                           WHERE CODICE = T765.CODICE'
      
        '                             AND DECORRENZA <= TO_DATE('#39'3112'#39'|| ' +
        'TO_CHAR(T767.ANNO),'#39'DDMMYYYY'#39'))'
      'order by :DATI')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00440041005400490001000000000000000000
      0000}
    OnFilterRecord = selT767DatiFilterRecord
    Left = 631
    Top = 221
  end
  object selT767: TOracleDataSet
    SQL.Strings = (
      'select T767.*, t767.rowid'
      'from   t767_incquantgruppo T767'
      'where  T767.anno = :ANNO'
      '  and  T767.codgruppo = :GRUPPO '
      '  and  T767.codtipoquota = :QUOTA '
      ''
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0C0000003A00510055004F0054004100050000000000000000000000}
    AfterScroll = selT767AfterScroll
    Left = 627
    Top = 129
  end
  object selT768Tot: TOracleDataSet
    SQL.Strings = (
      'select T768.*'
      'from   t768_incquantindividuali T768'
      'where  T768.anno = :ANNO'
      '  and  T768.codgruppo = :GRUPPO '
      '  and  T768.codtipoquota = :QUOTA '
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0C0000003A00510055004F0054004100050000000000000000000000}
    CommitOnPost = False
    Left = 691
    Top = 221
  end
  object selT760: TOracleDataSet
    SQL.Strings = (
      'select file_istruzioni'
      '  from t760_regoleincentivi'
      ' where file_istruzioni is not null'
      '   and rownum = 1')
    ReadBuffer = 31
    Optimize = False
    Left = 571
    Top = 129
  end
  object dsrT767: TDataSource
    DataSet = selT767
    Left = 628
    Top = 173
  end
  object selT770: TOracleDataSet
    SQL.Strings = (
      
        'select T770.dato1, T770.dato2, T770.dato3, t770.tipo_stampaquant' +
        ', MAX(T770.importo) IMPORTO, MAX(T770.num_ore) ORE, '
      
        '       round(oreminuti(MAX(T770.num_ore)) * MAX(T770.importo) / ' +
        '60,2) quantitativo, '
      '       SUM(T770A.IMPORTO) * 12 qualitativo'
      '  from t770_QUOTE T770, t770_QUOTE T770A'
      'where T770.codtipoquota = :QUOTA'
      
        '  and :DATARIF BETWEEN T770.decorrenza and nvl(T770.decorrenza_f' +
        'ine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      '  and NVL(T770.dato1,'#39' '#39') = NVL(T770A.dato1,'#39' '#39')'
      '  and NVL(T770.dato2,'#39' '#39') = NVL(T770A.dato2,'#39' '#39')'
      '  and NVL(T770.dato3,'#39' '#39') = NVL(T770A.dato3,'#39' '#39')'
      '  and T770A.codtipoquota in (:ACCONTI)'
      
        '  and :DATARIF BETWEEN T770A.decorrenza and nvl(T770A.decorrenza' +
        '_fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) '
      '  and NVL(T770.dato1,'#39' '#39') || NVL(T770.dato3,'#39' '#39') IN '
      '     (SELECT NVL(T768.dato1,'#39' '#39') || NVL(T768.dato3,'#39' '#39')'
      '        FROM T768_INCQUANTINDIVIDUALI T768'
      '       WHERE t768.ANNO = TO_CHAR(:DATARIF,'#39'YYYY'#39')'
      '         AND T768.CODTIPOQUOTA = :QUOTA'
      '         AND T768.CODGRUPPO = :GRUPPO)'
      
        'GROUP BY T770.dato1, T770.dato2, T770.dato3, t770.tipo_stampaqua' +
        'nt'
      'order by T770.dato1, T770.dato2, T770.dato3')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A00510055004F00540041000500000000000000
      00000000100000003A004100430043004F004E00540049000100000000000000
      00000000100000003A0044004100540041005200490046000C00000000000000
      000000000E0000003A00470052005500500050004F0005000000000000000000
      0000}
    Left = 763
    Top = 129
  end
  object dsrT770: TDataSource
    DataSet = selT770
    Left = 764
    Top = 177
  end
  object dsrSG715: TDataSource
    AutoEdit = False
    DataSet = selSG715
    Left = 456
    Top = 172
  end
  object selSG715: TOracleDataSet
    SQL.Strings = (
      'select SG715.*, SG715.rowid'
      'from   SG715_VALUT_POSIZIONATI SG715'
      'where  SG715.anno = :ANNO'
      '  and  SG715.progressivo = :PROGRESSIVO'
      ''
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 455
    Top = 128
  end
  object selT768: TOracleDataSet
    SQL.Strings = (
      'select T768.ROWID, T768.*, '
      '       LPAD(TRIM(NUMORE_ACCETTATE),6,'#39'0'#39') NUMORE,'
      '       DECODE(INF_OBIETTIVI,'#39'S'#39','#39'SI'#39','#39'NO'#39') OBIETTIVI,'
      '       DECODE(ACCETT_VALUTAZIONE,'#39'S'#39','#39'SI'#39','#39'NO'#39') VALUTAZIONE,'
      '       DECODE(CONFERMATO,'#39'S'#39','#39'SI'#39','#39'NO'#39') FIRMA,'
      '       T030.MATRICOLA,'
      
        '       T030.COGNOME || '#39' '#39' || T030.NOME || '#39' ('#39' || T030.MATRICOL' +
        'A || '#39')'#39' DIPENDENTE,'
      
        '       DECODE(FLESSIBILITA,'#39#39','#39#39',DECODE(INSTR(FLESSIBILITA,'#39'1'#39'),' +
        '0,'#39#39','#39'Turnazione'#39') || '
      '       DECODE(INSTR(FLESSIBILITA,'#39'1,'#39'),0,'#39#39','#39' - '#39') || '
      
        '       DECODE(INSTR(FLESSIBILITA,'#39'2'#39'),0,'#39#39','#39'Progetti quantitativ' +
        'i'#39') ||'
      '       DECODE(INSTR(FLESSIBILITA,'#39'2,'#39'),0,'#39#39','#39' - '#39') || '
      
        '       DECODE(INSTR(FLESSIBILITA,'#39'3'#39'),0,'#39#39','#39'Straordinario fino a' +
        ' 110 ore compreso quantitativo'#39') ||'
      '       DECODE(INSTR(FLESSIBILITA,'#39'3,'#39'),0,'#39#39','#39' - '#39') || '
      
        '       DECODE(INSTR(FLESSIBILITA,'#39'4'#39'),0,'#39#39','#39'Altre condizioni'#39')) ' +
        'DESC_FLESSIBILITA,'
      
        '       DECODE(PARTTIME,100,'#39#39',DECODE(FLESSIBILITA,'#39#39','#39'NO'#39',DECODE' +
        '(INSTR(FLESSIBILITA,'#39','#39'),0,'#39'NO'#39','#39'SI'#39'))) FLESSIBILE,'
      
        '       DECODE(NVL(T030V.COGNOME,'#39#39'),'#39#39','#39#39', T030V.COGNOME || '#39' '#39' ' +
        '|| T030V.NOME || '#39' ('#39' || T030V.MATRICOLA || '#39')'#39') VALUTATORE'
      '       :DESCTAB'
      
        ' from  t768_incquantindividuali T768, T030_ANAGRAFICO T030, V430' +
        '_STORICO V430, SG706_VALUTATORI_DIPENDENTE SG706, T030_ANAGRAFIC' +
        'O T030V  '
      ' where T768.anno = :ANNO'
      '   and T768.codgruppo = :GRUPPO '
      '   and T768.codtipoquota = :QUOTA '
      '   and T768.PROGRESSIVO = T030.PROGRESSIVO'
      '   and T768.PROGRESSIVO = T430PROGRESSIVO'
      '   and :DATARIF BETWEEN T430DATADECORRENZA AND T430DATAFINE'
      '   and T768.PROGRESSIVO = SG706.PROGRESSIVO_VALUTATO (+)'
      
        '   and TO_DATE('#39'31/12/'#39' || TO_CHAR(:ANNO),'#39'DD/MM/YYYY'#39') BETWEEN ' +
        'SG706.DECORRENZA (+) AND SG706.DECORRENZA_FINE (+)'
      '   and SG706.PROGRESSIVO = T030V.PROGRESSIVO (+)'
      '  :FILTRO'
      '  :FILTRORICERCA'
      'order by DATO1,DATO2,DATO3,DIPENDENTE'
      '')
    Optimize = False
    Variables.Data = {
      0400000007000000100000003A00440045005300430054004100420001000000
      00000000000000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0C0000003A00510055004F005400410005000000000000000000000010000000
      3A0044004100540041005200490046000C00000000000000000000000E000000
      3A00460049004C00540052004F000100000000000000000000001C0000003A00
      460049004C00540052004F005200490043004500520043004100010000000000
      000000000000}
    OnApplyRecord = selT768ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    Left = 668
    Top = 128
  end
  object tpSchedeIndividuali: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W031FSchedeIndividualiRG.html'
    RenderStyles = False
    Left = 608
    Top = 345
  end
  object tpQuoteQualitative: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W031FQuoteQualitativeRG.html'
    RenderStyles = False
    Left = 612
    Top = 533
  end
  object selValutatori: TOracleDataSet
    SQL.Strings = (
      
        'select distinct t030.cognome || '#39' '#39' || t030.nome || '#39' ('#39' || t030' +
        '.matricola || '#39')'#39' VALUTATORE, t030.progressivo'
      'from t030_anagrafico t030,'
      '     mondoedp.i060_login_dipendente i060, '
      '     mondoedp.i061_profili_dipendente i061,'
      '     mondoedp.i071_permessi i071'
      'where t030.matricola = i060.matricola'
      'and i060.azienda = :AZIENDA '
      'and i061.azienda = i060.azienda'
      'and i061.nome_utente = i060.nome_utente'
      'and :DATA between i061.inizio_validita and i061.fine_validita'
      'and i071.azienda = i061.azienda'
      'and i071.profilo = i061.permessi'
      'and i071.s710_stati_abilitati is not null'
      'and i071.s710_supervisorevalut = '#39'N'#39
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 512
    Top = 128
  end
  object CambioValutatore: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR CSG706 IS'
      '    SELECT DECORRENZA, DECORRENZA_FINE, PROGRESSIVO'
      '    FROM SG706_VALUTATORI_DIPENDENTE'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DINI <= DECORRENZA_FINE'
      '    AND :DFIN >= DECORRENZA;'
      'BEGIN'
      '  FOR RSG706 IN CSG706 LOOP'
      '    --Periodo esistente compreso'
      
        '    IF :DINI <= RSG706.DECORRENZA AND :DFIN >= RSG706.DECORRENZA' +
        '_FINE THEN'
      '      DELETE SG706_VALUTATORI_DIPENDENTE'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    --Periodo esistente esterno'
      
        '    ELSIF RSG706.DECORRENZA < :DINI AND RSG706.DECORRENZA_FINE >' +
        ' :DFIN THEN'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA_FINE = :DINI - 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '      INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '      (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VAL' +
        'UTATO)'
      '      VALUES'
      
        '      (RSG706.PROGRESSIVO, :DFIN + 1, RSG706.DECORRENZA_FINE, :P' +
        'ROGRESSIVO_VALUTATO);'
      '    --Fine esistente interseca periodo nuovo'
      '    ELSIF RSG706.DECORRENZA < :DINI THEN'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA_FINE = :DINI - 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    --Inizio esistente interseca periodo nuovo'
      '    ELSE'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA = :DFIN + 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    END IF;'
      '  END LOOP;'
      '  INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '  (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VALUTAT' +
        'O)'
      '  VALUES'
      
        '  (:PROGRESSIVO_VALUTATORE_NEW, :DINI, :DFIN, :PROGRESSIVO_VALUT' +
        'ATO);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000002A0000003A00500052004F00470052004500530053004900
      56004F005F00560041004C0055005400410054004F0003000000000000000000
      00000A0000003A00440049004E0049000C00000000000000000000000A000000
      3A004400460049004E000C0000000000000000000000360000003A0050005200
      4F0047005200450053005300490056004F005F00560041004C00550054004100
      54004F00520045005F004E0045005700030000000000000000000000}
    Left = 692
    Top = 277
  end
end
