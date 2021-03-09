inherited W021FStampaCUD: TW021FStampaCUD
  Tag = 422
  Width = 534
  Height = 272
  HelpType = htKeyword
  HelpKeyword = 'W021P0'
  Title = '(W021) Stampa CUD/CU'
  ExplicitWidth = 534
  ExplicitHeight = 272
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object cmbCUD: TmeIWComboBox [6]
    Left = 107
    Top = 201
    Width = 104
    Height = 21
    Cursor = crAuto
    Css = 'input10'
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
    OnChange = cmbCUDChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 4
    ItemIndex = -1
    Sorted = False
    FriendlyName = 'cmbCUD'
  end
  object lblAnnoCUD: TmeIWLabel [7]
    Left = 48
    Top = 202
    Width = 77
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
    ForControl = cmbCUD
    HasTabOrder = False
    FriendlyName = 'lblAnnoCUD'
    Caption = 'CUD/CU del '
    RawText = False
    Enabled = True
  end
  object btnStampa: TmeIWButton [8]
    Left = 236
    Top = 199
    Width = 85
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
    TabOrder = 6
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object lnkIstrCUD: TmeIWLink [9]
    Left = 381
    Top = 201
    Width = 65
    Height = 17
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
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    ScriptEvents = <>
    DoSubmitValidation = False
    FriendlyName = 'lnkIstrCUD'
    OnClick = lnkIstrCUDClick
    TabOrder = 7
    RawText = False
    Caption = 'Istruzioni'
    medpDownloadButton = False
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{395111C7-5036-482B-82D0-66242307FDFD}'
    ServerName = 'P714PComServer.P714COMServer'
    ComputerName = 'localhost'
    Left = 336
    Top = 120
  end
end