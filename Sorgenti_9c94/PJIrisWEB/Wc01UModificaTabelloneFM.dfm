object Wc01FModificaTabelloneFM: TWc01FModificaTabelloneFM
  Left = 0
  Top = 0
  Width = 452
  Height = 200
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 452
    Height = 200
    Cursor = crAuto
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwThin
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clWebALICEBLUE
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = IWTemplateProcessorHTML1
    ZIndex = 1000
    OnCreate = IWFrameRegionCreate
    Splitter = False
    object grdRendicontazione: TmedpIWDBGrid
      Left = 16
      Top = 30
      Width = 281
      Height = 123
      Cursor = crAuto
      ExtraTagParams.Strings = (
        
          'summary=griglia per l'#39'inserimento delle richieste di giustificat' +
          'ivo')
      Css = 'grid'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderStatus = False
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
      OnRenderCell = grdRendicontazioneRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdRendicontazione'
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
      OnAfterCaricaCDS = grdRendicontazioneAfterCaricaCDS
    end
    object btnConferma: TmeIWButton
      Left = 129
      Top = 159
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
      Caption = 'Conferma'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnConfermaClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 222
      Top = 159
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAnnulla'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnAnnullaClick
      medpDownloadButton = False
    end
  end
  object jQModificaTabellone: TIWJQueryWidget
    Enabled = True
    Left = 100
    Top = 96
  end
  object IWTemplateProcessorHTML1: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'Wc01FModificaTabelloneFM.html'
    RenderStyles = False
    Left = 348
    Top = 92
  end
end