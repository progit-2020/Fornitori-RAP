inherited W037FRichiestaScioperi: TW037FRichiestaScioperi
  Width = 585
  Height = 480
  ExplicitWidth = 585
  ExplicitHeight = 480
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Top = 60
    ExplicitTop = 60
  end
  inherited grdRichieste: TmedpIWDBGrid
    Top = 160
    Width = 505
    Height = 79
    Caption = 'Notifiche di adesione sciopero'
    OnRenderCell = grdRichiesteRenderCell
    Summary = 'Elenco delle richieste di sciopero'
    medpComandiCustom = True
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitTop = 160
    ExplicitWidth = 505
    ExplicitHeight = 79
  end
  object rgnDettaglio: TmeIWRegion [7]
    Left = 16
    Top = 256
    Width = 505
    Height = 201
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDettaglio
    object grdDipendenti: TmedpIWDBGrid
      Left = 28
      Top = 93
      Width = 349
      Height = 89
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'grdDipendenti'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdDipendentiRenderCell
      Summary = 'Elenco dei dipendenti in servizio da selezionare per lo sciopero'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdDipendenti'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = False
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpContextMenu = pmnDipendenti
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = False
      medpRowSelect = False
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdDipendentiAfterCaricaCDS
    end
    object edtNumDipInServizio: TmeIWEdit
      Left = 174
      Top = 12
      Width = 53
      Height = 21
      Css = 'input_num_nnnnn width4chr align_right'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtNumDipInServizio'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      Enabled = False
    end
    object lblNumDipInServizio: TmeIWLabel
      Left = 28
      Top = 12
      Width = 138
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
      HasTabOrder = False
      FriendlyName = 'lblNumDipInServizio'
      Caption = 'Dipendenti in servizio:'
      Enabled = True
    end
    object lblNumDipScioperanti: TmeIWLabel
      Left = 28
      Top = 39
      Width = 144
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
      HasTabOrder = False
      FriendlyName = 'lblNumDipScioperanti'
      Caption = 'Dipendenti scioperanti:'
      Enabled = True
    end
    object edtNumDipScioperanti: TmeIWEdit
      Left = 174
      Top = 39
      Width = 53
      Height = 21
      Css = 'input_num_nnnnn width4chr align_right'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Alignment = taRightJustify
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtNumDipScioperanti'
      SubmitOnAsyncEvent = True
      TabOrder = 6
      Enabled = False
    end
    object lblNumDipAssenti: TmeIWLabel
      Left = 28
      Top = 66
      Width = 119
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
      HasTabOrder = False
      FriendlyName = 'lblNumDipAssenti'
      Caption = 'Dipendenti assenti:'
      Enabled = True
    end
    object edtNumDipAssenti: TmeIWEdit
      Left = 174
      Top = 66
      Width = 53
      Height = 21
      Css = 'input_num_nnnnn width4chr align_right'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtNumDipAssenti'
      SubmitOnAsyncEvent = True
      TabOrder = 7
      Enabled = False
    end
  end
  inherited pmnTabella: TPopupMenu
    Left = 527
    Top = 160
  end
  object tpDettaglio: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W037FDettaglioRG.html'
    RenderStyles = False
    Left = 472
    Top = 264
  end
  object pmnDipendenti: TPopupMenu
    Left = 312
    Top = 360
    object MenuItem1: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaCsvClick
    end
  end
end
