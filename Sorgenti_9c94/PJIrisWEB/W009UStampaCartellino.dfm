inherited W009FStampaCartellino: TW009FStampaCartellino
  Tag = 405
  Width = 716
  Height = 405
  HelpType = htKeyword
  HelpKeyword = 'W009P0'
  Title = '(W009) Stampa cartellino'
  ExplicitWidth = 716
  ExplicitHeight = 405
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 19
    Top = 284
    Width = 658
    Height = 101
    ExtraTagParams.Strings = (
      'summary=elenco delle richieste di validazione cartellino')
    StyleRenderOptions.RenderZIndex = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di validazione cartellini'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT860
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 19
    ExplicitTop = 284
    ExplicitWidth = 658
    ExplicitHeight = 101
  end
  object lblParametrizzazione: TmeIWLabel [7]
    Left = 23
    Top = 124
    Width = 115
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
    ForControl = cmbParametrizzazione
    HasTabOrder = False
    FriendlyName = 'lblParametrizzazione'
    Caption = 'Parametrizzazione'
    Enabled = True
  end
  object cmbParametrizzazione: TmeIWComboBox [8]
    Left = 144
    Top = 124
    Width = 185
    Height = 21
    Css = 'select_perc50'
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
    Required = True
    OnChange = cmbParametrizzazioneChange
    UseSize = False
    TabOrder = 4
    ItemIndex = 0
    Items.Strings = (
      '')
    FriendlyName = 'cmbParametrizzazione'
    NoSelectionText = '-- No Selection --'
  end
  object lblElabDal: TmeIWLabel [9]
    Left = 350
    Top = 162
    Width = 159
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
    ForControl = edtDal
    HasTabOrder = False
    FriendlyName = 'lblElabDal'
    Caption = 'Periodo da elaborare dal '
    Enabled = True
  end
  object lblElabAl: TmeIWLabel [10]
    Left = 581
    Top = 162
    Width = 11
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
    ForControl = edtAl
    HasTabOrder = False
    FriendlyName = 'lblElabAl'
    Caption = 'al'
    Enabled = True
  end
  object btnAggiornamento: TmeIWButton [11]
    Left = 378
    Top = 218
    Width = 135
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
    Caption = 'Solo aggiornamento'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnAggiornamento'
    TabOrder = 6
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object btnStampa: TmeIWButton [12]
    Left = 532
    Top = 218
    Width = 135
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
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    TabOrder = 7
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object edtDal: TmeIWEdit [13]
    Left = 506
    Top = 162
    Width = 69
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 8
  end
  object edtAl: TmeIWEdit [14]
    Left = 598
    Top = 162
    Width = 69
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object chkAutoGiustificazione: TmeIWCheckBox [15]
    Left = 24
    Top = 218
    Width = 188
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
    Caption = 'Elabora auto-giustificazione  '
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    Checked = False
    FriendlyName = 'chkAutoGiustificazione'
  end
  object chkAggiornamentoBuoniPasto: TmeIWCheckBox [16]
    Left = 24
    Top = 243
    Width = 277
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
    Caption = 'Aggiornamento cartolina Buoni pasto/Ticket'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkAggiornamentoBuoniPasto'
  end
  object chkAggiornamentoScheda: TmeIWCheckBox [17]
    Left = 24
    Top = 162
    Width = 248
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
    Caption = 'Aggiornamento scheda riepilogativa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkAggiornamentoScheda'
  end
  object chkAggiornamentoAccessiMensa: TmeIWCheckBox [18]
    Left = 24
    Top = 189
    Width = 248
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
    Caption = 'Aggiornamento cartolina Accessi Mensa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = False
    FriendlyName = 'chkAggiornamentoAccessiMensa'
  end
  object chkVisRiepiloghi: TmeIWCheckBox [19]
    Left = 402
    Top = 119
    Width = 148
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
    Caption = 'Visualizza riepiloghi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    OnClick = chkVisRiepiloghiClick
    Checked = False
    FriendlyName = 'chkVisRiepiloghi'
  end
  object chkParametrizzazioniTipoCartellino: TmeIWCheckBox [20]
    Left = 350
    Top = 191
    Width = 353
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
    Caption = 'Utilizza parametrizzazione associata all'#39'anagrafico'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    Checked = False
    FriendlyName = 'chkParametrizzazioniTipoCartellino'
  end
  inherited pmnTabella: TPopupMenu
    Left = 600
    Top = 320
  end
  object dsrT860: TDataSource
    DataSet = cdsT860
    Left = 413
    Top = 308
  end
  object cdsT860: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 473
    Top = 308
  end
end
