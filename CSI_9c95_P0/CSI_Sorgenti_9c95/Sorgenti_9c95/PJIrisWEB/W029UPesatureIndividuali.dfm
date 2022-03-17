inherited W029FPesatureIndividuali: TW029FPesatureIndividuali
  Tag = 436
  Width = 738
  Height = 455
  HelpType = htKeyword
  HelpKeyword = 'W029P0'
  Title = '(W029) Pesature individuali'
  ExplicitWidth = 738
  ExplicitHeight = 455
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object grdPesiDip: TmedpIWDBGrid [6]
    Left = 20
    Top = 299
    Width = 606
    Height = 138
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
    OnRenderCell = grdPesiDipRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT774
    FooterRowCount = 0
    FriendlyName = 'grdPesiDip'
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
    OnAfterCaricaCDS = grdPesiDipAfterCaricaCDS
  end
  object lblNumDip: TmeIWLabel [7]
    Left = 20
    Top = 252
    Width = 62
    Height = 16
    Cursor = crAuto
    Css = 'font_rosso'
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
    FriendlyName = 'lblNumDip'
    Caption = 'lblNumDip'
    RawText = False
    Enabled = True
  end
  object lblGruppo: TmeIWLabel [8]
    Left = 24
    Top = 116
    Width = 50
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
    FriendlyName = 'lblGruppo'
    Caption = 'Gruppo:'
    RawText = False
    Enabled = True
  end
  object lblQuota: TmeIWLabel [9]
    Left = 151
    Top = 116
    Width = 42
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
    FriendlyName = 'lblGruppo'
    Caption = 'Quota:'
    RawText = False
    Enabled = True
  end
  object lblAnno: TmeIWLabel [10]
    Left = 251
    Top = 116
    Width = 37
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
    FriendlyName = 'lblGruppo'
    Caption = 'Anno:'
    RawText = False
    Enabled = True
  end
  object btnModifica: TmeIWButton [11]
    Left = 20
    Top = 183
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
    Caption = 'Modifica'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnModifica'
    ScriptEvents = <>
    TabOrder = 4
    OnClick = btnModificaClick
    medpDownloadButton = False
  end
  object btnConferma: TmeIWButton [12]
    Left = 107
    Top = 183
    Width = 110
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
    FriendlyName = 'btnConferma'
    ScriptEvents = <>
    TabOrder = 6
    OnClick = btnConfermaClick
    medpDownloadButton = False
  end
  object btnAnnulla: TmeIWButton [13]
    Left = 230
    Top = 183
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
    TabOrder = 7
    OnClick = btnAnnullaClick
    medpDownloadButton = False
  end
  object cmbGruppo: TmeIWComboBox [14]
    Left = 24
    Top = 145
    Width = 121
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
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbGruppoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 8
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbGruppo'
  end
  object cmbQuota: TmeIWComboBox [15]
    Left = 151
    Top = 145
    Width = 83
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
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbQuotaChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 9
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbQuota'
  end
  object cmbAnno: TmeIWComboBox [16]
    Left = 251
    Top = 145
    Width = 83
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
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbAnnoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 10
    ItemIndex = 0
    Items.Strings = (
      ' ')
    Sorted = False
    FriendlyName = 'cmbQuota'
  end
  object grdRiepilogo: TmeIWGrid [17]
    Left = 88
    Top = 238
    Width = 300
    Height = 41
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
    Lines = tlAll
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
  object dsrT774: TDataSource
    DataSet = cdsT774
    Left = 528
    Top = 288
  end
  object cdsT774: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 576
    Top = 288
  end
  object selT774: TOracleDataSet
    SQL.Strings = (
      'select T774.ROWID, T774.*, '
      
        '       T030.COGNOME || '#39' '#39' || T030.NOME || '#39' ('#39' || T030.MATRICOL' +
        'A || '#39')'#39' DIPENDENTE'
      
        'from   t774_pesatureindividuali T774, T030_ANAGRAFICO T030, V430' +
        '_STORICO V430'
      'where  T774.anno = :ANNO'
      '  and  T774.codgruppo = :GRUPPO '
      '  and  T774.codtipoquota = :QUOTA '
      '  and  T774.PROGRESSIVO = T030.PROGRESSIVO'
      '  and  T774.PROGRESSIVO = T430PROGRESSIVO'
      '  and  T774.DATAFINE BETWEEN T430DATADECORRENZA AND T430DATAFINE'
      '  :FILTRORICERCA'
      'order by DIPENDENTE'
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0C0000003A00510055004F00540041000500000000000000000000001C000000
      3A00460049004C00540052004F00520049004300450052004300410001000000
      0000000000000000}
    CommitOnPost = False
    Left = 483
    Top = 288
  end
  object selT773: TOracleDataSet
    SQL.Strings = (
      'select distinct :DATI'
      '  from t773_pesaturegruppo T773, T765_TIPOQUOTE T765'
      ' where T773.CODTIPOQUOTA = T765.CODICE'
      
        '   and T765.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQ' +
        'UOTE'
      '                           WHERE CODICE = T765.CODICE'
      
        '                             AND DECORRENZA <= TO_DATE('#39'3112'#39'|| ' +
        'TO_CHAR(T773.ANNO),'#39'DDMMYYYY'#39'))'
      'order by :DATI')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00440041005400490001000000000000000000
      0000}
    OnFilterRecord = selT773FilterRecord
    Left = 435
    Top = 288
  end
  object selT773B: TOracleDataSet
    SQL.Strings = (
      'select T773.*'
      'from   t773_pesaturegruppo T773'
      'where  T773.anno = :ANNO'
      '  and  T773.codgruppo = :GRUPPO '
      '  and  T773.codtipoquota = :QUOTA '
      ''
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0C0000003A00510055004F0054004100050000000000000000000000}
    Left = 439
    Top = 348
  end
end
