inherited WC026FAllegatiIterFM: TWC026FAllegatiIterFM
  Width = 402
  Height = 272
  ExplicitWidth = 402
  ExplicitHeight = 272
  inherited IWFrameRegion: TIWRegion
    Width = 402
    Height = 272
    ExplicitWidth = 402
    ExplicitHeight = 272
    object btnChiudi: TmeIWButton
      Left = 289
      Top = 218
      Width = 75
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object grdAllegati: TmedpIWDBGrid
      Left = 32
      Top = 72
      Width = 332
      Height = 113
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
      Caption = 'grdAllegati'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdAllegatiRenderCell
      Summary = 'Elenco degli allegati associati alla richiesta'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdAllegati'
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
      medpRowSelect = False
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdAllegatiAfterCaricaCDS
      OnCancella = grdAllegatiCancella
      OnConferma = grdAllegatiConferma
      OnBeforeInserisci = grdAllegatiBeforeInserisci
    end
    object lblInfo: TmeIWLabel
      Left = 32
      Top = 239
      Width = 38
      Height = 16
      Css = 'informazione'
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
      FriendlyName = 'lblInfo'
      Caption = 'lblInfo'
      Enabled = True
    end
    object chkConfermaAllegatiOriginali: TmeIWCheckBox
      Left = 32
      Top = 210
      Width = 209
      Height = 21
      Visible = False
      Css = 'segnalazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Testo impostato a runtime'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 1
      OnAsyncClick = chkConfermaAllegatiOriginaliAsyncClick
      Checked = False
      FriendlyName = 'chkConfermaAllegatiOriginali'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC026FAllegatiIterFM.html'
  end
  object cdsAllegati: TClientDataSet
    PersistDataPacket.Data = {
      9C0000009619E0BD0100000018000000060000000000030000009C0002494408
      000400000000000749445F543936300800040000000000094E4F4D455F46494C
      45010049000000010005574944544802000200C800084558545F46494C450100
      4900000001000557494454480200020014000A44494D454E53494F4E45080004
      0000000000044E4F5445020049000000010005574944544802000200D0070000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftFloat
      end
      item
        Name = 'ID_T960'
        DataType = ftFloat
      end
      item
        Name = 'NOME_FILE'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'EXT_FILE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DIMENSIONE'
        DataType = ftFloat
      end
      item
        Name = 'NOTE'
        DataType = ftString
        Size = 2000
      end
      item
        Name = 'C_NOME_FILE'
        DataType = ftString
        Size = 221
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsAllegatiBeforeInsert
    BeforeEdit = cdsAllegatiBeforeEdit
    AfterPost = cdsAllegatiAfterPost
    AfterCancel = cdsAllegatiAfterCancel
    OnCalcFields = cdsAllegatiCalcFields
    OnNewRecord = cdsAllegatiNewRecord
    Left = 328
    Top = 24
    object cdsAllegatiC_NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      FieldKind = fkInternalCalc
      FieldName = 'C_NOME_FILE'
      Size = 221
    end
    object cdsAllegatiC_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_DIMENSIONE'
      Size = 50
      Calculated = True
    end
    object cdsAllegatiNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
    object cdsAllegatiID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object cdsAllegatiID_T960: TFloatField
      FieldName = 'ID_T960'
      Visible = False
    end
    object cdsAllegatiNOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 30
      FieldName = 'NOME_FILE'
      Visible = False
      Size = 200
    end
    object cdsAllegatiEXT_FILE: TStringField
      DisplayLabel = 'Estensione'
      DisplayWidth = 3
      FieldName = 'EXT_FILE'
      Visible = False
    end
    object cdsAllegatiDIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldName = 'DIMENSIONE'
      Visible = False
    end
  end
end
