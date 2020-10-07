inherited Wc01FRichiestaRendiProj: TWc01FRichiestaRendiProj
  Tag = 100401
  Width = 733
  Height = 677
  HelpType = htKeyword
  HelpKeyword = 'Wc01P0'
  ExplicitWidth = 733
  ExplicitHeight = 677
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 4
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
  inherited btnSendFile: TmeIWButton
    TabOrder = 3
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 19
    Top = 242
    Width = 686
    Height = 75
    ExtraTagParams.Strings = (
      'summary=tabella contenente le richieste di straordinario mensile')
    StyleRenderOptions.RenderPosition = True
    StyleRenderOptions.RenderFont = True
    StyleRenderOptions.RenderZIndex = True
    StyleRenderOptions.RenderAbsolute = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BorderStyle = tfDefault
    Caption = 'Richieste di rendicontazione'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT755
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 19
    ExplicitTop = 242
    ExplicitWidth = 686
    ExplicitHeight = 75
  end
  object grdRiepilogo: TmeIWGrid [7]
    Left = 253
    Top = 157
    Width = 198
    Height = 39
    Cursor = crAuto
    Css = 'grid w024_grid'
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
    Lines = tlNone
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
  object lblMessaggio: TmeIWLabel [8]
    Left = 117
    Top = 135
    Width = 467
    Height = 16
    Cursor = crAuto
    Css = 'intestazione  align_center'
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
    FriendlyName = 'lblMessaggio'
    Caption = 
      'Mese:  - Totale ore straordinario anno:  - Residuo ore compensab' +
      'ili anno:'
    RawText = True
    Enabled = True
  end
  object tabRichiestaRendiProj: TmedpIWTabControl [9]
    Left = 19
    Top = 323
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
    FriendlyName = 'tabRichiestaRendiProj'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
  end
  object btnConfermaPianificazione: TmeIWButton [10]
    Left = 381
    Top = 325
    Width = 124
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
    Caption = 'Conferma pianificazione'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnConfermaPianificazione'
    ScriptEvents = <>
    TabOrder = 5
    OnClick = btnConfermaPianificazioneClick
    medpDownloadButton = False
  end
  object btnVisRich: TmeIWButton [11]
    Left = 600
    Top = 325
    Width = 113
    Height = 25
    Cursor = crAuto
    Visible = False
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
    Caption = 'Visualizza richiesta'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisRich'
    ScriptEvents = <>
    TabOrder = 6
    OnClick = btnVisRichClick
    medpDownloadButton = False
  end
  object cmbFiltroProgetti: TmeIWComboBox [12]
    Left = 456
    Top = 215
    Width = 249
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
    ItemsHaveValues = True
    NoSelectionText = '-- No Selection --'
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbFiltroProgettiChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = False
    SubmitOnAsyncEvent = True
    TabOrder = 7
    ItemIndex = -1
    Sorted = True
    FriendlyName = 'cmbFiltroProgetti'
  end
  object lblFiltroProgetti: TmeIWLabel [13]
    Left = 366
    Top = 220
    Width = 58
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
    HasTabOrder = False
    FriendlyName = 'lblFiltroProgetti'
    Caption = 'Progetto:'
    RawText = False
    Enabled = True
  end
  object btnStampa: TmeIWButton [14]
    Left = 528
    Top = 325
    Width = 66
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
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    ScriptEvents = <>
    TabOrder = 8
    OnClick = btnStampaClick
    medpDownloadButton = False
  end
  object Wc01RichiesteRG: TmeIWRegion [15]
    Left = 16
    Top = 356
    Width = 545
    Height = 117
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = tpRichieste
    ZIndex = 1000
    Splitter = False
  end
  object Wc01ProspettoRG: TmeIWRegion [16]
    Left = 16
    Top = 479
    Width = 545
    Height = 161
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = tpProspetto
    ZIndex = 1000
    Splitter = False
    object grdProspetto: TmedpIWDBGrid
      Left = 69
      Top = 26
      Width = 320
      Height = 121
      Cursor = crAuto
      ExtraTagParams.Strings = (
        'summary=griglia per la visualizzazione delle assenze')
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
      BorderColors.Color = clWebSKYBLUE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfDefault
      Caption = 'Prospetto rendicontazione'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdProspettoRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      DataSource = DLista
      FooterRowCount = 0
      FriendlyName = 'grdProspetto'
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
      OnAfterCaricaCDS = grdProspettoAfterCaricaCDS
    end
  end
  inherited pmnTabella: TPopupMenu
    Left = 456
    Top = 256
  end
  object dsrT755: TDataSource
    DataSet = cdsT755
    Left = 658
    Top = 262
  end
  object cdsT755: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 602
    Top = 262
  end
  object tpProspetto: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'Wc01FProspettoRG.html'
    RenderStyles = False
    Left = 32
    Top = 490
  end
  object DLista: TDataSource
    DataSet = Wc01FRichiestaRendiProjDM.cdsListaPag
    Left = 494
    Top = 583
  end
  object tpRichieste: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'Wc01FRichiesteRG.html'
    RenderStyles = False
    Left = 32
    Top = 369
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{0C94F43B-4783-4BA0-9128-297C40CEE7EF}'
    ServerName = 'Bc28PPrintServer_COM.Bc28PrintServer'
    ComputerName = 'localhost'
    Left = 480
    Top = 16
  end
end
