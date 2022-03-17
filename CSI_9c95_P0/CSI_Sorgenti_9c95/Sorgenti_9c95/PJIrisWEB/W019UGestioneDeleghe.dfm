inherited W019FGestioneDeleghe: TW019FGestioneDeleghe
  Tag = 420
  Width = 720
  Height = 370
  HelpType = htKeyword
  HelpKeyword = 'W019P0'
  Title = '(W019) Gestione deleghe'
  ExplicitWidth = 720
  ExplicitHeight = 370
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
  object grdDeleghe: TmedpIWDBGrid [6]
    Left = 32
    Top = 244
    Width = 549
    Height = 77
    ExtraTagParams.Strings = (
      
        'summary=tabella contenente l'#39'elenco delle deleghe in corso di va' +
        'lidit'#224)
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
    Caption = 'Elenco deleghe attive'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdDelegheRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrI061
    FooterRowCount = 0
    FriendlyName = 'grdDeleghe'
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
    OnAfterCaricaCDS = grdDelegheAfterCaricaCDS
  end
  object lblCognomeCerca: TmeIWLabel [7]
    Left = 31
    Top = 157
    Width = 64
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
    ForControl = edtCognomeCerca
    HasTabOrder = False
    FriendlyName = 'lblCognomeCerca'
    Caption = 'Cognome:'
    Enabled = True
  end
  object edtCognomeCerca: TmeIWEdit [8]
    Left = 93
    Top = 157
    Width = 104
    Height = 21
    Css = 'input20'
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
    FriendlyName = 'edtCognomeCerca'
    SubmitOnAsyncEvent = True
    TabOrder = 3
    OnSubmit = edtCognomeCercaSubmit
  end
  object lblMatricolaCerca: TmeIWLabel [9]
    Left = 203
    Top = 157
    Width = 62
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
    FriendlyName = 'lblMatricolaCerca'
    Caption = 'Matricola:'
    Enabled = True
  end
  object edtMatricolaCerca: TmeIWEdit [10]
    Left = 261
    Top = 157
    Width = 83
    Height = 21
    Css = 'input10'
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
    FriendlyName = 'edtMatricolaCerca'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnSubmit = edtCognomeCercaSubmit
  end
  object edtUserCerca: TmeIWEdit [11]
    Left = 415
    Top = 157
    Width = 121
    Height = 21
    Css = 'input20'
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
    FriendlyName = 'edtMatricolaCerca'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnSubmit = edtCognomeCercaSubmit
  end
  object lblUserCerca: TmeIWLabel [12]
    Left = 363
    Top = 157
    Width = 46
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
    FriendlyName = 'lblMatricolaCerca'
    Caption = 'Utente:'
    Enabled = True
  end
  object btnFiltra: TmeIWButton [13]
    Left = 568
    Top = 160
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
    Caption = 'Filtra'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnFiltra'
    TabOrder = 8
    OnClick = btnFiltraClick
    medpDownloadButton = False
  end
  object edtProfiloAttuale: TmeIWEdit [14]
    Left = 204
    Top = 203
    Width = 118
    Height = 21
    Css = 'input20'
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
    FriendlyName = 'edtMatricolaCerca'
    ReadOnly = True
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnSubmit = edtCognomeCercaSubmit
  end
  object lblProfiloAttuale: TmeIWLabel [15]
    Left = 32
    Top = 203
    Width = 166
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
    ForControl = edtCognomeCerca
    HasTabOrder = False
    FriendlyName = 'lblCognomeCerca'
    Caption = 'Profilo in uso da delegare:'
    Enabled = True
  end
  object lblInfoDelegati: TmeIWLabel [16]
    Left = 31
    Top = 344
    Width = 89
    Height = 16
    Css = 'intestazione_rosso'
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
    FriendlyName = 'lblInfoDelegati'
    Caption = 'lblInfoDelegati'
    Enabled = True
  end
  object cdsI061: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 509
    Top = 256
  end
  object dsrI061: TDataSource
    DataSet = cdsI061
    Left = 453
    Top = 256
  end
end
