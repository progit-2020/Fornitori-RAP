inherited WC015FSelEditGridFM: TWC015FSelEditGridFM
  Width = 577
  Height = 408
  ExplicitWidth = 577
  ExplicitHeight = 408
  inherited IWFrameRegion: TIWRegion
    Width = 577
    Height = 408
    ExplicitWidth = 577
    ExplicitHeight = 408
    object btnChiudi: TmeIWButton
      Left = 462
      Top = 31
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
      FriendlyName = 'btnChiudi'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object grdElenco: TmedpIWDBGrid
      Left = 24
      Top = 104
      Width = 529
      Height = 281
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
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
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
      OnRenderCell = grdElencoRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdElenco'
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
      medpContextMenu = ppMnu
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
      OnAfterCaricaCDS = grdElencoAfterCaricaCDS
      OnDataSet2Componenti = grdElencoDataSet2Componenti
      OnComponenti2DataSet = grdElencoComponenti2DataSet
    end
    object btnConferma: TmeIWButton
      Left = 381
      Top = 31
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
      Caption = 'OK'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblRicerca: TmeIWLabel
      Left = 240
      Top = 67
      Width = 46
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
      FriendlyName = 'lblRicerca'
      Caption = 'Ricerca'
      RawText = False
      Enabled = True
    end
    object edtRicerca: TmeIWEdit
      Left = 295
      Top = 64
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width20chr'
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
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtRicerca'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 2
      PasswordPrompt = False
    end
    object btnRicerca: TmeIWImage
      Left = 422
      Top = 62
      Width = 16
      Height = 16
      Cursor = crAuto
      Hint = 'Ricerca'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPadding = False
      BorderOptions.Color = clNone
      BorderOptions.Width = 0
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnRicercaClick
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
        001008060000001FF3FF61000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC610500000009704859730000104D0000104D01678C01E0000002
        024944415478DAA5D24B6B13611886E17B323961134D436C9A44A70B930A2E82
        284802369E5A1104D18A925241702FF80FFC0BAE74D7A50B37EA46A411126936
        BAF280D8A239A951DA26EDE460321373F04BE2424C82161F98C5F0CE5CF330DF
        2BA9AADAE13F22FD0E6C158BE47239DA48E2AE43A7DDC6E7F3E2F178FF0E64D2
        290A650DF754807D2E3B068344BEF89D2F991436638350284CA552190E140A05
        DE67BEB2C71FC6EB34E230D3EB506EC0B7AA68967E4347CD313313190E24932B
        68932176BB5C8C9B60D72FA0F6034AE2522B4DB65EDE277A659E56AB3508C412
        4954EF1C0EBB19BB00ACC6FE5017CF56458B6D1DE48F318E4E4FA228CA20B01C
        5FA1A69C4597CC5865B0C8FD6143005A134CA62EB0CC21C589DF1F180412F138
        167F84B2C949A50EE2E7F76230C098059CE616A9674BCC5FBC80D56A1D04D656
        5759576BEC0D9EA22EBEAA37BA87289A98FA80FAE115D9B72F882E44471FE3E3
        470F712B01DCD38791AD63BD61BBA1915F7B4D5D2B216F7C6276FF14AD23C746
        2FD2F34482AC5824BBC38924FA978A9BD86C367CE522C188847DFB09F5FA4D2C
        9133C3816EBA2F74B751D775B1811E244942131B5ABD7382038B5EAA1D1FEAE6
        22F6C8EC706054F2E934F2BD4B1CBC3141A9ED6563FD2A13A7CFFF3BD043B259
        9A772F13BCEEE4696C9CF0AD073B03BAF99C4AF16EE936B693D7383E776EE7C0
        9FF9099389F201BD95C89F0000000049454E44AE426082}
      FriendlyName = 'btnRicerca'
      TransparentColor = clNone
      JpegOptions.CompressionQuality = 90
      JpegOptions.Performance = jpBestSpeed
      JpegOptions.ProgressiveEncoding = False
      JpegOptions.Smoothing = True
      OutputType = ioPNG
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC015FSelEditGridFM.html'
  end
  object ppMnu: TPopupMenu
    Left = 192
    Top = 16
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      Hint = 'file_xls'
      OnClick = CopiaInExcelClick
    end
  end
end
