inherited W024FRichiestaStraordinari: TW024FRichiestaStraordinari
  Tag = 426
  Width = 718
  Height = 347
  HelpType = htKeyword
  HelpKeyword = 'W024P0'
  ExplicitWidth = 718
  ExplicitHeight = 347
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 5
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
    Caption = 'Richieste di straordinario mensile'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT065
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
    Css = 'grid w024_grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
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
    HeaderRowCount = 0
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
    Css = 'intestazione  align_center'
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
    HasTabOrder = False
    FriendlyName = 'lblMessaggio'
    Caption = 
      'Mese:  - Totale ore straordinario anno:  - Residuo ore compensab' +
      'ili anno:'
    RawText = True
    Enabled = True
  end
  object btnInserisci: TmeIWButton [9]
    Left = 582
    Top = 211
    Width = 121
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
    Caption = 'Nuova richiesta'
    Confirmation = 
      'Si vuole inserire una nuova richiesta di straordinario per il me' +
      'se di mm/yyyy?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInserisci'
    TabOrder = 3
    OnClick = btnInserisciClick
    medpDownloadButton = False
  end
  object dsrT065: TDataSource
    DataSet = cdsT065
    Left = 658
    Top = 262
  end
  object cdsT065: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 602
    Top = 262
  end
end
