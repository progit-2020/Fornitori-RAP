inherited W022FSchedaValutazioni: TW022FSchedaValutazioni
  Tag = 423
  Width = 629
  Height = 363
  HelpType = htKeyword
  HelpKeyword = 'W022P0'
  Title = '(W022) Scheda di valutazione'
  ExplicitWidth = 629
  ExplicitHeight = 363
  DesignLeft = 8
  DesignTop = 8
  inherited lnkEsci: TmeIWLink
    TabOrder = 3
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 4
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object btnApplicaAnno: TmeIWButton [6]
    Left = 306
    Top = 192
    Width = 65
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
    Caption = 'Applica'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplicaAnno'
    ScriptEvents = <>
    TabOrder = 2
    OnClick = btnApplicaAnnoClick
    medpDownloadButton = False
  end
  object lblAnno: TmeIWLabel [7]
    Left = 135
    Top = 196
    Width = 112
    Height = 16
    Cursor = crAuto
    Css = 'intestazione'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = True
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
    Caption = 'Anno valutazione:'
    RawText = False
    Enabled = True
  end
  object edtAnno: TmeIWEdit [8]
    Left = 255
    Top = 194
    Width = 39
    Height = 21
    Cursor = crAuto
    Css = 'input5'
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
    FriendlyName = 'edtAnno'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 6
    PasswordPrompt = False
  end
  object btnRiepilogoSchede: TmeIWButton [9]
    Left = 391
    Top = 192
    Width = 65
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
    Caption = 'Riepilogo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInserisci'
    ScriptEvents = <>
    TabOrder = 7
    OnClick = btnRiepilogoSchedeClick
    medpDownloadButton = False
  end
  object chkVisualizzaDipNonValutabili: TmeIWCheckBox [10]
    Left = 16
    Top = 128
    Width = 265
    Height = 21
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
    Caption = 'Visualizza anche dipendenti non valutabili'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    ScriptEvents = <>
    Style = stNormal
    TabOrder = 8
    OnClick = chkVisualizzaDipNonValutabiliClick
    Checked = False
    FriendlyName = 'chkVisualizzaDipNonValutabili'
  end
  object dgrdSchede: TmedpIWDBGrid [11]
    Left = 60
    Top = 223
    Width = 462
    Height = 69
    Cursor = crAuto
    ExtraTagParams.Strings = (
      
        'summary=tabella contenente il riepilogo delle schede di valutazi' +
        'one')
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
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'Riepilogo schede'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = dgrdSchedeRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrSG710
    FooterRowCount = 0
    FriendlyName = 'dgrdSchede'
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
    OnAfterCaricaCDS = dgrdSchedeAfterCaricaCDS
  end
  object lblFrequenzaScheda: TmeIWLabel [12]
    Left = 116
    Top = 155
    Width = 70
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
    ForControl = rgpFrequenzaScheda
    HasTabOrder = False
    FriendlyName = 'lblFrequenzaScheda'
    Caption = 'Periodicit'#224':'
    RawText = False
    Enabled = True
  end
  object rgpFrequenzaScheda: TmeIWRadioGroup [13]
    Left = 192
    Top = 155
    Width = 301
    Height = 24
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
    OnClick = rgpFrequenzaSchedaClick
    SubmitOnAsyncEvent = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpFrequenzaScheda'
    ItemIndex = 0
    Items.Strings = (
      'Una scheda per anno'
      'Pi'#249' schede durante l'#39'anno')
    Layout = glHorizontal
    ScriptEvents = <>
    TabOrder = 9
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{395111C7-5036-482B-82D0-66242307FDFD}'
    ServerName = 'P714PComServer.P714COMServer'
    ComputerName = 'localhost'
    Left = 368
    Top = 8
  end
  object dsrSG710: TDataSource
    AutoEdit = False
    DataSet = cdsSG710
    Left = 312
    Top = 240
  end
  object cdsSG710: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 250
    Top = 238
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 424
    Top = 80
  end
end
