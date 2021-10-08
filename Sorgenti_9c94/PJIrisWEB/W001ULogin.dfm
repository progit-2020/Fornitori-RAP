inherited W001FLogin: TW001FLogin
  Width = 694
  Height = 365
  HelpType = htKeyword
  HelpKeyword = 'W001P0'
  Title = '(W001) Login'
  LockUntilLoaded = False
  LockOnSubmit = False
  ExplicitWidth = 694
  ExplicitHeight = 365
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
  object lblAzienda: TmeIWLabel [6]
    Left = 144
    Top = 164
    Width = 49
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
    ForControl = edtAzienda
    HasTabOrder = False
    FriendlyName = 'lblAzienda'
    Caption = 'Azienda'
    Enabled = True
  end
  object lblUtente: TmeIWLabel [7]
    Left = 144
    Top = 192
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
    ForControl = edtUtente
    HasTabOrder = False
    FriendlyName = 'lblUtente'
    Caption = 'Utente'
    Enabled = True
  end
  object lblPassword: TmeIWLabel [8]
    Left = 144
    Top = 220
    Width = 60
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
    ForControl = edtPassword
    HasTabOrder = False
    FriendlyName = 'lblPassword'
    Caption = 'Password'
    Enabled = True
  end
  object lblNomeProfilo: TmeIWLabel [9]
    Left = 145
    Top = 248
    Width = 39
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
    ForControl = edtNomeProfilo
    HasTabOrder = False
    FriendlyName = 'lblNomeProfilo'
    Caption = 'Profilo'
    Enabled = True
  end
  object lblDatabase: TmeIWLabel [10]
    Left = 144
    Top = 277
    Width = 58
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
    ForControl = edtDatabase
    HasTabOrder = False
    FriendlyName = 'lblDatabase'
    Caption = 'Database'
    Enabled = True
  end
  object edtAzienda: TmeIWEdit [11]
    Left = 222
    Top = 164
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
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
    FriendlyName = 'Azienda'
    MaxLength = 30
    SubmitOnAsyncEvent = True
    TabOrder = 3
    OnSubmit = edtAziendaSubmit
  end
  object edtUtente: TmeIWEdit [12]
    Left = 222
    Top = 191
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
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
    FriendlyName = 'Utente'
    MaxLength = 30
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnSubmit = edtAziendaSubmit
  end
  object edtPassword: TmeIWEdit [13]
    Left = 222
    Top = 218
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
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
    FriendlyName = 'Password'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnSubmit = edtAziendaSubmit
    PasswordPrompt = True
  end
  object edtDatabase: TmeIWEdit [14]
    Left = 222
    Top = 273
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
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
    FriendlyName = 'Database'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    OnSubmit = edtAziendaSubmit
  end
  object cmbNomeProfilo: TmeIWComboBox [15]
    Left = 355
    Top = 245
    Width = 121
    Height = 21
    Visible = False
    Css = 'width20chr'
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
    ScriptEvents = <
      item
        EventCode.Strings = (
          'if (event.keyCode == 13) {'
          '  SubmitClick("LNKACCEDI", "", true);'
          '  return true;'
          '}')
        Event = 'onKeyPress'
      end>
    UseSize = False
    TabOrder = 9
    ItemIndex = -1
    FriendlyName = 'Profilo'
    NoSelectionText = '-- No Selection --'
  end
  object edtNomeProfilo: TmeIWEdit [16]
    Left = 222
    Top = 245
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
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
    FriendlyName = 'Profilo'
    MaxLength = 30
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnSubmit = edtAziendaSubmit
  end
  object lnkAccedi: TmeIWLink [17]
    Left = 303
    Top = 300
    Width = 40
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
    FriendlyName = 'Accedi'
    OnClick = lnkAccediClick
    TabOrder = 11
    RawText = False
    Caption = 'Accedi'
    medpDownloadButton = False
  end
  object lnkRecuperaPassword: TmeIWLink [18]
    Left = 222
    Top = 323
    Width = 118
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
    FriendlyName = 'lnkRecuperaPassword'
    OnClick = lnkRecuperaPasswordClick
    TabOrder = 12
    RawText = False
    Caption = 'Recupera password'
    medpDownloadButton = False
  end
  object btnAccedi: TmeIWButton [19]
    Left = 349
    Top = 292
    Width = 128
    Height = 25
    ExtraTagParams.Strings = (
      'style=width:98%')
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Accedi'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnAccedi'
    TabOrder = 13
    OnClick = lnkAccediClick
    medpDownloadButton = False
  end
  object xmlDoc: TXMLDocument
    Left = 488
    Top = 160
    DOMVendorDesc = 'MSXML'
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 539
    Top = 160
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 591
    Top = 160
  end
end
