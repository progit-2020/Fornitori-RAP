inherited WA058FTabelloneTurniFM: TWA058FTabelloneTurniFM
  Width = 826
  Height = 768
  ExplicitWidth = 826
  ExplicitHeight = 768
  inherited IWFrameRegion: TIWRegion
    Width = 826
    Height = 768
    ExplicitWidth = 826
    ExplicitHeight = 768
    object grdTabControl: TmedpIWTabControl
      Left = 187
      Top = 34
      Width = 329
      Height = 24
      Css = 'gridTabControl'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
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
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdTabControl'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
      CssTabHeaders = 'medpTabControl'
    end
    object WA058TabelloneRG: TmeIWRegion
      Left = 16
      Top = 528
      Width = 785
      Height = 193
      RenderInvisibleControls = False
      BorderOptions.NumericWidth = 1
      BorderOptions.BorderWidth = cbwNumeric
      BorderOptions.Style = cbsSolid
      BorderOptions.Color = clNone
      LayoutMgr = TemplateTabelloneRG
      object grdTabellone: TmedpIWDBGrid
        Left = 249
        Top = 19
        Width = 320
        Height = 158
        ExtraTagParams.Strings = (
          'summary=tabellone turni')
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
        BorderSize = 1
        BorderStyle = tfDefault
        Caption = 'Tabellone turni'
        CellPadding = 0
        CellSpacing = 0
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FrameBuffer = 40
        Lines = tlAll
        OnRenderCell = grdTabelloneRenderCell
        UseFrame = False
        UseSize = False
        HeaderRowCount = 0
        CellRenderOptions = []
        ScrollToCurrentRow = False
        Columns = <>
        DataSource = DLista
        FooterRowCount = 0
        FriendlyName = 'grdTabellone'
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
        OnAfterCaricaCDS = grdTabelloneAfterCaricaCDS
      end
      object btnSalva: TmeIWButton
        Left = 17
        Top = 3
        Width = 83
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
        Caption = 'Registrazione'
        Color = clBtnFace
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'btnSalva'
        TabOrder = 13
        OnClick = btnSalvaClick
        medpDownloadButton = False
      end
      object btnCancella: TmeIWButton
        Left = 106
        Top = 3
        Width = 83
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
        Caption = 'Cancellazione'
        Color = clBtnFace
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'btnCancella'
        TabOrder = 14
        OnClick = btnCancellaClick
        medpDownloadButton = False
      end
      object btnOperativa: TmeIWButton
        Left = 17
        Top = 34
        Width = 100
        Height = 25
        Visible = False
        Css = 'pulsante'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Rendi operativa'
        Color = clBtnFace
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'btnOperativa'
        TabOrder = 15
        OnClick = btnOperativaClick
        medpDownloadButton = False
      end
    end
    object WA058ParametriRG: TmeIWRegion
      Left = 16
      Top = 64
      Width = 785
      Height = 449
      RenderInvisibleControls = False
      BorderOptions.NumericWidth = 1
      BorderOptions.BorderWidth = cbwNumeric
      BorderOptions.Style = cbsSolid
      BorderOptions.Color = clNone
      LayoutMgr = TemplateParametriRG
      object edtDataDa: TmeIWEdit
        Left = 19
        Top = 38
        Width = 70
        Height = 21
        Css = 'input_data_dmy'
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        NonEditableAsLabel = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'edtDataDa'
        SubmitOnAsyncEvent = True
        TabOrder = 0
      end
      object lblDataDa: TmeIWLabel
        Left = 17
        Top = 16
        Width = 48
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
        FriendlyName = 'lblDataDa'
        Caption = 'Data da'
        Enabled = True
      end
      object lblDataA: TmeIWLabel
        Left = 169
        Top = 16
        Width = 40
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
        FriendlyName = 'lblDataA'
        Caption = 'Data a'
        Enabled = True
      end
      object edtDataA: TmeIWEdit
        Left = 171
        Top = 38
        Width = 70
        Height = 21
        Css = 'input_data_dmy'
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        NonEditableAsLabel = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'edtDataA'
        SubmitOnAsyncEvent = True
        TabOrder = 1
      end
      object lblSquadra: TmeIWLabel
        Left = 19
        Top = 80
        Width = 247
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
        FriendlyName = 'lblSquadra'
        Caption = 'Squadra per riferimento limiti operatori'
        Enabled = True
      end
      object cmbSquadra: TMedpIWMultiColumnComboBox
        Left = 17
        Top = 102
        Width = 121
        Height = 21
        Css = 'medpMultiColumnCombo'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderBorder = False
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'cmbSquadra'
        SubmitOnAsyncEvent = True
        TabOrder = 2
        OnAsyncChange = cmbSquadraAsyncChange
        PopUpHeight = 15
        PopUpWidth = 0
        Text = ''
        ColCount = 2
        Items = <>
        ColumnTitles.Visible = False
        medpAutoResetItems = True
        CssInputText = 'width10chr'
        LookupColumn = 0
        CodeColumn = 0
      end
      object cmbProfili: TMedpIWMultiColumnComboBox
        Left = 19
        Top = 158
        Width = 121
        Height = 21
        Css = 'medpMultiColumnCombo'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderBorder = False
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'cmbProfili'
        SubmitOnAsyncEvent = True
        TabOrder = 3
        OnAsyncChange = cmbAsyncChange
        PopUpHeight = 15
        PopUpWidth = 0
        Text = ''
        ColCount = 2
        Items = <>
        ColumnTitles.Visible = False
        medpAutoResetItems = True
        CssInputText = 'width10chr'
        LookupColumn = 0
        CodeColumn = 0
      end
      object lblCopiaAss: TmeIWLabel
        Left = 21
        Top = 185
        Width = 276
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
        FriendlyName = 'lblCopiaAss'
        Caption = 'Copia giustificativi in modalit'#224' non operativa'
        Enabled = True
      end
      object rgpTipo: TmeIWRadioGroup
        Left = 22
        Top = 233
        Width = 176
        Height = 25
        Cursor = crDefault
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        SubmitOnAsyncEvent = True
        RawText = False
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'rgpTipo'
        ItemIndex = 0
        Items.Strings = (
          'Iniziale'
          'Corrente')
        Layout = glHorizontal
        TabOrder = 4
        OnAsyncClick = rgpTipoAsyncClick
      end
      object btnGeneraPDF: TmedpIWImageButton
        Left = 371
        Top = 283
        Width = 122
        Height = 28
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BorderOptions.Width = 0
        TabOrder = -1
        UseSize = False
        OnClick = btnGeneraPDFClick
        Cacheable = True
        FriendlyName = 'btnGeneraPDF'
        ImageFile.URL = 'img/btnPdf.png'
        medpDownloadButton = False
        Caption = 'Genera PDF per la stampa'
      end
      object btnVisualizzaPianif: TmeIWButton
        Left = 371
        Top = 219
        Width = 254
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
        Caption = 'Visualizzazione pianificazione esistente'
        Color = clBtnFace
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'btnVisualizzaPianif'
        TabOrder = 5
        OnClick = btnEseguiClick
        medpDownloadButton = False
      end
      object btnEsegui: TmedpIWImageButton
        Left = 371
        Top = 250
        Width = 254
        Height = 27
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BorderOptions.Width = 0
        TabOrder = -1
        UseSize = False
        OnClick = btnEseguiClick
        Cacheable = True
        FriendlyName = 'btnEsegui'
        ImageFile.URL = 'img/btnEsegui.png'
        medpDownloadButton = False
        Caption = 'Generazione nuova pianificazione'
      end
      object LblDescrSquadra: TmeIWLabel
        Left = 144
        Top = 102
        Width = 105
        Height = 16
        Css = 'descrizione'
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
        FriendlyName = 'LblDescrSquadra'
        Caption = 'LblDescrSquadra'
        Enabled = True
      end
      object LblDescrProfilo: TmeIWLabel
        Left = 149
        Top = 158
        Width = 92
        Height = 16
        Css = 'descrizione'
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
        FriendlyName = 'LblDescrProfilo'
        Caption = 'LblDescrProfilo'
        Enabled = True
      end
      object lblTipo: TmeIWLabel
        Left = 22
        Top = 211
        Width = 116
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
        FriendlyName = 'lblTipo'
        Caption = 'Tipo pianificazione'
        Enabled = True
      end
      object chkVisSaldiOre: TmeIWCheckBox
        Left = 19
        Top = 323
        Width = 316
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza colonna saldi ore(debito/pianif./residuo)'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 6
        OnAsyncClick = chkVisTotTurniAsyncClick
        Checked = False
        FriendlyName = 'chkVisSaldiOre'
      end
      object chkVisRiposi: TmeIWCheckBox
        Left = 19
        Top = 344
        Width = 306
        Height = 22
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza colonna  riposi/fest.lav. da inizio anno'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 7
        OnAsyncClick = chkVisTotTurniAsyncClick
        Checked = False
        FriendlyName = 'chkVisRiposi'
      end
      object chkVisTotTurni: TmeIWCheckBox
        Left = 19
        Top = 305
        Width = 288
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza colonna totale turni per dipendente'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 8
        OnAsyncClick = chkVisTotTurniAsyncClick
        Checked = False
        FriendlyName = 'chkVisTotTurni'
      end
      object lblDatiOpzionali: TmeIWLabel
        Left = 19
        Top = 262
        Width = 181
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
        FriendlyName = 'lblDatiOpzionali'
        Caption = 'Visualizzazione dati opzionali'
        Enabled = True
      end
      object chkVisRigaTurni: TmeIWCheckBox
        Left = 19
        Top = 284
        Width = 262
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza riga copertura turni squadra'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 9
        Checked = False
        FriendlyName = 'chkVisRigaTurni'
      end
      object chkVisBadge: TmeIWCheckBox
        Left = 19
        Top = 364
        Width = 316
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza colonna badge'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 10
        OnAsyncClick = chkVisTotTurniAsyncClick
        Checked = False
        FriendlyName = 'chkVisBadge'
      end
      object chkVisTabSint: TmeIWCheckBox
        Left = 19
        Top = 384
        Width = 316
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Visualizza tabellone sintetico'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 11
        OnAsyncClick = chkVisTotTurniAsyncClick
        Checked = False
        FriendlyName = 'chkVisTabSint'
      end
      object lnkProfilo: TmeIWLink
        Left = 19
        Top = 135
        Width = 124
        Height = 17
        Css = 'link'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Alignment = taLeftJustify
        Color = clNone
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = [fsUnderline]
        HasTabOrder = True
        DoSubmitValidation = False
        FriendlyName = 'lnkProfilo'
        OnClick = lnkProfiloClick
        TabOrder = 12
        RawText = False
        Caption = 'Profilo pianificazione'
        medpDownloadButton = False
      end
      object chkIniCorr: TmeIWCheckBox
        Left = 19
        Top = 405
        Width = 214
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Genera pianif. Iniziale\Corrente'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 16
        Checked = False
        FriendlyName = 'chkIniCorr'
      end
    end
  end
  object TemplateParametriRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA058ParametriRG.html'
    Left = 712
    Top = 80
  end
  object TemplateTabelloneRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA058TabelloneRG.html'
    Left = 736
    Top = 536
  end
  object cdsLista: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 614
    Top = 566
  end
  object cdsListaPag: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 614
    Top = 615
  end
  object DLista: TDataSource
    DataSet = cdsListaPag
    Left = 614
    Top = 663
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 568
    Top = 16
  end
  object pmnAzioni: TPopupMenu
    Left = 688
    Top = 592
    object ModificaItem: TMenuItem
      Caption = 'Modifica'
      Hint = 'submit'
      OnClick = ModificaItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InsCancGiustifItem: TMenuItem
      Caption = 'Ins/Canc Giustificativi'
      Hint = 'submit'
      OnClick = InsCancGiustifItemClick
    end
    object PianificazioneReperibilit1: TMenuItem
      Caption = 'Pianificazione Reperibilit'#224
      OnClick = PianificazioneReperibilit1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object VisComAassenzaItem: TMenuItem
      Caption = 'Visualizza competenze/residui assenza'
      Hint = 'submit'
      OnClick = VisComAassenzaItemClick
    end
  end
  object pmnAzioni2: TPopupMenu
    Left = 688
    Top = 648
    object MenuItem2: TMenuItem
      Caption = 'Copia pianificazione'
      Hint = 'submit'
      OnClick = CopiaPianifItemClick
    end
  end
end
