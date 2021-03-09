inherited W027FDetrazioniIRPEF: TW027FDetrazioniIRPEF
  Tag = 434
  Width = 733
  Height = 434
  HelpType = htKeyword
  HelpKeyword = 'W027P0'
  Title = '(W027) Detrazioni fiscali'
  ExplicitWidth = 733
  ExplicitHeight = 434
  DesignLeft = 8
  DesignTop = 8
  object grdDetrazioni: TmedpIWDBGrid [6]
    Left = 17
    Top = 266
    Width = 697
    Height = 75
    ExtraTagParams.Strings = (
      'summary=tabella contenente i familiari a carico')
    Css = 'grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfDefault
    Caption = 'Familiari a carico'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdDetrazioniRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <
      item
        Alignment = taLeftJustify
        BGColor = clNone
        DoSubmitValidation = True
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        Header = False
        Height = '0'
        ShowHint = True
        VAlign = vaMiddle
        Visible = True
        Width = '0'
        Wrap = False
        RawText = False
        Css = ''
        BlobCharLimit = 0
        CompareHighlight = hcNone
        Title.Alignment = taCenter
        Title.BGColor = clNone
        Title.DoSubmitValidation = True
        Title.Font.Color = clNone
        Title.Font.Size = 10
        Title.Font.Style = []
        Title.Header = False
        Title.Height = '0'
        Title.ShowHint = True
        Title.VAlign = vaMiddle
        Title.Visible = True
        Title.Width = '0'
        Title.Wrap = False
        Title.RawText = True
      end>
    DataSource = dsrSG122
    FooterRowCount = 0
    FriendlyName = 'grdDetrazioni'
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
  object lblDetrazioniDipendente: TmeIWLabel [7]
    Left = 27
    Top = 242
    Width = 293
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
    FriendlyName = 'lblDetrazioniDipendente'
    Caption = 'Detrazioni per lavoro dipendente e assimilato: '
    Enabled = True
  end
  object rgpDetrazioniDipendente: TmeIWRadioGroup [8]
    Left = 316
    Top = 242
    Width = 72
    Height = 19
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
    FriendlyName = 'rgpDetrazioniDipendente'
    ItemIndex = 0
    Items.Strings = (
      'Si'
      'No')
    Layout = glHorizontal
    TabOrder = 5
  end
  object btnConferma: TmeIWButton [9]
    Left = 132
    Top = 395
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
    Caption = 'Conferma'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnConferma'
    TabOrder = 6
    OnClick = btnConfermaClick
    medpDownloadButton = False
  end
  object btnAnnulla: TmeIWButton [10]
    Left = 228
    Top = 395
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
    Caption = 'Annulla'
    Confirmation = 
      'Si '#232' sicuri di voler abbandonare la dichiarazione senza salvare ' +
      'le eventuali modifiche apportate?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnAnnulla'
    TabOrder = 7
    OnClick = btnAnnullaClick
    medpDownloadButton = False
  end
  object lblTitoloDichiarazione: TmeIWLabel [11]
    Left = 19
    Top = 130
    Width = 397
    Height = 16
    Css = 'intestazione font_grassetto font_grande'
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
    FriendlyName = 'lblTitoloDichiarazione'
    Caption = 
      'Dichiarazione relativa alle detrazioni IRPEF spettanti per l'#39'ann' +
      'o '
    Enabled = True
  end
  object lblUltimoAggiornamento: TmeIWLabel [12]
    Left = 27
    Top = 168
    Width = 180
    Height = 16
    Css = 'intestazione font_grassetto'
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
    FriendlyName = 'lblUltimoAggiornamento'
    Caption = 'Data ultimo aggiornamento: '
    Enabled = True
  end
  object lnkIstrDetr: TmeIWLink [13]
    Left = 27
    Top = 193
    Width = 65
    Height = 17
    Css = 'intestazione'
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
    FriendlyName = 'lnkIstrDetr'
    OnClick = lnkIstrDetrClick
    TabOrder = 8
    RawText = False
    Caption = 'Istruzioni'
    medpDownloadButton = False
  end
  object btnRipristina: TmeIWButton [14]
    Left = 324
    Top = 395
    Width = 149
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
    Caption = 'Ripristina valori iniziali'
    Confirmation = 
      'Si '#232' sicuri di voler ripristinare i valori iniziali della dichia' +
      'razione perdendo le modifiche apportate?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnRipristina'
    TabOrder = 9
    OnClick = btnRipristinaClick
    medpDownloadButton = False
  end
  object lblStatoCivile: TmeIWLabel [15]
    Left = 27
    Top = 216
    Width = 68
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
    FriendlyName = 'lblStatoCivile'
    Caption = 'Stato civile'
    Enabled = True
  end
  object cbxStatoCivile: TmeIWComboBox [16]
    Left = 115
    Top = 215
    Width = 92
    Height = 21
    Css = 'select_cour50'
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'cbxStatoCivile'
    NoSelectionText = '-- No Selection --'
  end
  object lblNote: TmeIWLabel [17]
    Left = 29
    Top = 360
    Width = 28
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
    FriendlyName = 'lblNote'
    Caption = 'Note'
    Enabled = True
  end
  object lblDetrazioniDipendenteSiNo: TmeIWLabel [18]
    Left = 394
    Top = 242
    Width = 34
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
    FriendlyName = 'lblDetrazioniDipendenteSiNo'
    Caption = 'Si/No'
    Enabled = True
  end
  object dsrSG122: TDataSource
    DataSet = cdsSG122
    Left = 667
    Top = 316
  end
  object cdsSG122: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 611
    Top = 316
  end
end
