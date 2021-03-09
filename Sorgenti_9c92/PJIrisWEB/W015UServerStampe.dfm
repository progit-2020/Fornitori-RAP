inherited W015FServerStampe: TW015FServerStampe
  Tag = 414
  Width = 685
  Height = 235
  HelpType = htKeyword
  HelpKeyword = 'W015P0'
  Title = '(W015) Generatore di stampe'
  ExplicitWidth = 685
  ExplicitHeight = 235
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
  object lblPeriodoDal: TmeIWLabel [6]
    Left = 17
    Top = 150
    Width = 159
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
    ForControl = edtDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Periodo da elaborare dal '
    RawText = False
    Enabled = True
  end
  object lblPeriodoAl: TmeIWLabel [7]
    Left = 250
    Top = 150
    Width = 11
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
    ForControl = edtAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoAl'
    Caption = 'al'
    RawText = False
    Enabled = True
  end
  object edtDal: TmeIWEdit [8]
    Left = 175
    Top = 149
    Width = 69
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    MaxLength = 10
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 3
    PasswordPrompt = False
  end
  object edtAl: TmeIWEdit [9]
    Left = 277
    Top = 150
    Width = 69
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    MaxLength = 10
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 6
    PasswordPrompt = False
  end
  object btnStampa: TmeIWButton [10]
    Left = 554
    Top = 150
    Width = 111
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
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    ScriptEvents = <>
    TabOrder = 7
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object lblParametrizzazione: TmeIWLabel [11]
    Left = 17
    Top = 194
    Width = 115
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
    ForControl = cmbParametrizzazione
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Parametrizzazione'
    RawText = False
    Enabled = True
  end
  object cmbParametrizzazione: TmeIWComboBox [12]
    Left = 175
    Top = 194
    Width = 294
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
    NoSelectionText = '-- No Selection --'
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 8
    ItemIndex = -1
    Sorted = False
    FriendlyName = 'cmbParametrizzazione'
  end
  object rgpFormatoStampa: TmeIWRadioGroup [13]
    Left = 464
    Top = 151
    Width = 74
    Height = 25
    Cursor = crDefault
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
    SubmitOnAsyncEvent = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpFormatoStampa'
    ItemIndex = 0
    Items.Strings = (
      'pdf'
      'xls')
    Layout = glHorizontal
    ScriptEvents = <>
    TabOrder = 9
  end
  object lblFormatoStampa: TmeIWLabel [14]
    Left = 361
    Top = 149
    Width = 108
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
    ForControl = edtDal
    HasTabOrder = False
    FriendlyName = 'lblFormatoStampa'
    Caption = 'Formato stampa:'
    RawText = False
    Enabled = True
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{D1FA98B6-6C13-4F6F-B862-E55B7A6FD1EA}'
    ServerName = 'A077PCOMServer.A077COMServer'
    ComputerName = 'localhost'
    Left = 368
    Top = 8
  end
  object DCOMConnection2: TDCOMConnection
    ServerGUID = '{F257D48B-2FDF-40BF-A701-EC19EBC7DBBE}'
    ServerName = 'P077PCOMServer.P077ComServer'
    ComputerName = 'localhost'
    Left = 424
    Top = 8
  end
end
