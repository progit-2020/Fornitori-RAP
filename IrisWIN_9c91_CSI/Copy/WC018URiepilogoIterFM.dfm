object WC018FRiepilogoIterFM: TWC018FRiepilogoIterFM
  Left = 0
  Top = 0
  Width = 433
  Height = 220
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 433
    Height = 220
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
    ClipRegion = False
    LayoutMgr = IWTemplateProcessorFrame
    ZIndex = 1000
    OnCreate = IWFrameRegionCreate
    Splitter = False
    object grdIter: TmedpIWDBGrid
      Left = 19
      Top = 66
      Width = 390
      Height = 110
      Cursor = crAuto
      ExtraTagParams.Strings = (
        
          'summary=tabella contenente lo stato delle autorizzazioni della r' +
          'ichiesta selezionata per ogni livello disponibile')
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
      OnRenderCell = grdIterRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      DataSource = dsrIter
      FooterRowCount = 0
      FriendlyName = 'grdIter'
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
    end
    object btnApplica: TmeIWButton
      Left = 204
      Top = 182
      Width = 121
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
      FriendlyName = 'btnChiudi'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnApplicaClick
      medpDownloadButton = False
    end
    object btnChiudi: TmeIWButton
      Left = 331
      Top = 182
      Width = 78
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
  end
  object jQRiepilogoIter: TIWJQueryWidget
    Enabled = True
    Left = 368
    Top = 8
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WC018FRiepilogoIterFM.html'
    RenderStyles = False
    Left = 72
    Top = 8
  end
  object cdsIter: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 110
    Top = 98
  end
  object dsrIter: TDataSource
    DataSet = cdsIter
    Left = 182
    Top = 98
  end
end
