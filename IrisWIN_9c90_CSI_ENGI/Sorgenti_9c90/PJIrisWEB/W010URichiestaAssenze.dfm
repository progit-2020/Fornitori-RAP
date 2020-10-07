inherited W010FRichiestaAssenze: TW010FRichiestaAssenze
  Tag = 406
  Width = 817
  Height = 553
  HelpType = htKeyword
  HelpKeyword = 'W010P0'
  ExplicitWidth = 817
  ExplicitHeight = 553
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 4
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
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 8
    Top = 465
    Width = 697
    Height = 79
    ExtraTagParams.Strings = (
      'summary=tabella contenente le richieste di giustificativi')
    StyleRenderOptions.RenderStatus = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di giustificativi'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT050
    OnBeforeCaricaCDS = grdRichiesteBeforeCaricaCDS
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 8
    ExplicitTop = 465
    ExplicitWidth = 697
    ExplicitHeight = 79
  end
  object cmbAccorpCausali: TmeIWComboBox [7]
    Left = 272
    Top = 106
    Width = 121
    Height = 21
    Css = 'select_perc33'
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
    OnChange = cmbAccorpCausaliChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 3
    ItemIndex = -1
    FriendlyName = 'cmbAccorpCausali'
    NoSelectionText = '-- No Selection --'
  end
  object lblLegenda1: TmeIWLabel [8]
    Left = 8
    Top = 295
    Width = 335
    Height = 16
    Css = 'legenda'
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
    FriendlyName = 'lblLegenda1'
    Caption = '<span class = "apice">(1)</span>Richiesta revocata'
    RawText = True
    Enabled = True
  end
  object lblLegenda2: TmeIWLabel [9]
    Left = 8
    Top = 317
    Width = 502
    Height = 16
    Css = 'legenda'
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
    FriendlyName = 'lblLegenda2'
    Caption = 
      '<span class = "apice">(2)</span>Richiesta preventiva non autoriz' +
      'zata</span>'
    RawText = True
    Enabled = True
  end
  object chkNoteIns: TmeIWCheckBox [10]
    Left = 185
    Top = 244
    Width = 121
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
    Caption = 'Note richiesta'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 6
    OnAsyncClick = chkNoteInsAsyncClick
    Checked = False
    FriendlyName = 'chkNoteIns'
  end
  object edtOre: TmeIWEdit [11]
    Left = 320
    Top = 166
    Width = 50
    Height = 21
    Hint = 
      'Ora di inizio o numero di ore per la richiesta di giustificativo' +
      ' in inserimento Formato hhmm'
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtOre'
    MaxLength = 5
    SubmitOnAsyncEvent = True
    TabOrder = 7
  end
  object edtAOre: TmeIWEdit [12]
    Left = 376
    Top = 166
    Width = 50
    Height = 21
    Hint = 
      'Ora di fine per la richiesta di giustificativo in inserimento. F' +
      'ormato hhmm'
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtAOre'
    MaxLength = 5
    SubmitOnAsyncEvent = True
    TabOrder = 8
  end
  object edtDal: TmeIWEdit [13]
    Left = 461
    Top = 166
    Width = 73
    Height = 21
    Hint = 
      'Data di inizio per la richiesta di giustificativo in inserimento' +
      '. Formato ddmmyyyy'
    Css = 'input_data_dmy dal'
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
    MaxLength = 10
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object edtAl: TmeIWEdit [14]
    Left = 561
    Top = 166
    Width = 73
    Height = 21
    Hint = 
      'Data di fine per la richiesta di giustificativo in inserimento. ' +
      'Formato ddmmyyyy'
    Css = 'input_data_dmy al'
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
    FriendlyName = 'edtAl'
    MaxLength = 10
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object lblDal: TmeIWLabel [15]
    Left = 438
    Top = 168
    Width = 18
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
    FriendlyName = 'lblDal'
    Caption = 'dal'
    Enabled = True
  end
  object lblAl: TmeIWLabel [16]
    Left = 544
    Top = 168
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
    FriendlyName = 'lblAl'
    Caption = 'al'
    Enabled = True
  end
  object memNoteIns: TmeIWMemo [17]
    Left = 312
    Top = 241
    Width = 314
    Height = 48
    Hint = 'Note relative alla richiesta in inserimento'
    Css = 'textarea_note inser'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BGColor = clNone
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 11
    SubmitOnAsyncEvent = True
    FriendlyName = 'memNoteIns'
  end
  object lblRiepAl: TmeIWLabel [18]
    Left = 6
    Top = 391
    Width = 72
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
    ForControl = edtRiepAl
    HasTabOrder = False
    FriendlyName = 'lblRiepAl'
    Caption = 'Riepilogo al'
    Enabled = True
  end
  object edtRiepAl: TmeIWEdit [19]
    Left = 94
    Top = 389
    Width = 73
    Height = 21
    Hint = 'Data per la visualizzazione del riepilogo. Formato ddmmyyyy'
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
    FriendlyName = 'edtRiepAl'
    MaxLength = 10
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object lblCausale: TmeIWLabel [20]
    Left = 6
    Top = 418
    Width = 63
    Height = 16
    Css = 'font_rosso'
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
    FriendlyName = 'lblCausale'
    Caption = 'lblCausale'
    Enabled = True
  end
  object btnInserisci: TmeIWButton [21]
    Left = 632
    Top = 264
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
    Caption = 'Inserisci'
    Confirmation = 'Inserire la richiesta per il periodo specificato?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInserisci'
    TabOrder = 13
    OnClick = btnInserisciClick
    medpDownloadButton = False
  end
  object btnNascondiRiepilogo: TmeIWButton [22]
    Left = 311
    Top = 385
    Width = 130
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
    Caption = 'Nascondi riepilogo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInserisci'
    TabOrder = 14
    OnAsyncClick = btnNascondiRiepilogoAsyncClick
    medpDownloadButton = False
  end
  object btnVisualizzaRiepilogo: TmeIWButton [23]
    Left = 181
    Top = 385
    Width = 124
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
    Caption = 'Visualizza riepilogo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizzaRiepilogo'
    TabOrder = 15
    OnClick = btnVisualizzaRiepilogoClick
    medpDownloadButton = False
  end
  object grdRiepilogo: TmeIWGrid [24]
    Left = 94
    Top = 416
    Width = 347
    Height = 43
    Css = 'grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
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
    Lines = tlNone
    OnRenderCell = grdRiepilogoRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdRiepilogo'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblGiustificativo: TmeIWLabel [25]
    Left = 157
    Top = 106
    Width = 83
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
    ForControl = cmbCausaliDisponibili
    HasTabOrder = False
    FriendlyName = 'lblGiustificativo'
    Caption = 'Giustificativo:'
    Enabled = True
  end
  object cmbCausaliDisponibili: TmeIWComboBox [26]
    Left = 399
    Top = 106
    Width = 314
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
    ScriptEvents = <
      item
        EventCode.Strings = (
          'if (FindElem("RGPTIPO_INPUT_1")) {'
          '  var Caus = this.options[this.selectedIndex].text.substr(0,5);'
          '  CausaleCambiata(Caus);'
          '}                                       ')
        Event = 'onChange'
      end
      item
        EventCode.Strings = (
          'if (FindElem("RGPTIPO_INPUT_1")) {'
          '  var Caus = this.options[this.selectedIndex].text.substr(0,5);'
          '  CausaleCambiata(Caus);'
          '}       ')
        Event = 'onKeyPress'
      end>
    UseSize = False
    TabOrder = 16
    ItemIndex = -1
    Sorted = True
    FriendlyName = 'cmbCausaliDisponibili'
    NoSelectionText = '-- No Selection --'
  end
  object lblFamiliari: TmeIWLabel [27]
    Left = 157
    Top = 133
    Width = 157
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
    FriendlyName = 'lblFamiliari'
    Caption = 'Familiare di riferimento: '
    Enabled = True
  end
  object cmbFamiliari: TmeIWComboBox [28]
    Left = 399
    Top = 133
    Width = 314
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
    UseSize = False
    TabOrder = 17
    ItemIndex = -1
    FriendlyName = 'cmbFamiliari'
    NoSelectionText = '-- No Selection --'
  end
  object rgpTipo: TmeIWRadioGroup [29]
    Left = 19
    Top = 167
    Width = 347
    Height = 24
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
      'Giornata'
      'Mezza giornata'
      'Numero Ore'
      'Da ore - A ore')
    Layout = glHorizontal
    ScriptEvents = <
      item
        EventCode.Strings = (
          
            'if ((FindElem("RGPTIPO_INPUT_1").checked) || (FindElem("RGPTIPO_' +
            'INPUT_2").checked)) {'
          '  EDTOREIWCL.style.visibility = "hidden";'
          '  EDTOREIWCL.value = "";'
          '  EDTAOREIWCL.style.visibility = "hidden";'
          '  EDTAOREIWCL.value = "";'
          '}'
          'else if (FindElem("RGPTIPO_INPUT_3").checked) {  '
          '  EDTOREIWCL.style.visibility = "visible";         '
          '  EDTAOREIWCL.style.visibility = "hidden";'
          '  EDTAOREIWCL.value = "";'
          '}'
          'else {'
          '  EDTOREIWCL.style.visibility = "visible";'
          '  EDTAOREIWCL.style.visibility = "visible";'
          '}'
          ''
          'try {'
          
            '  var CodCausale = CMBCAUSALIDISPONIBILIIWCL.options[CMBCAUSALID' +
            'ISPONIBILIIWCL.selectedIndex].text.substr(0,5);'
          '  CausaleCambiata(CodCausale);'
          '}'
          'catch(err) {'
          '  alert("Si '#232' verificato un errore: " + err.message);'
          '}'
          ''
          'return true;')
        Event = 'onClick'
      end>
    TabOrder = 18
  end
  object lblLegenda3: TmeIWLabel [30]
    Left = 11
    Top = 337
    Width = 485
    Height = 16
    Css = 'legenda'
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
    FriendlyName = 'lblLegenda3'
    Caption = 
      '<span class = "apice">(3)</span>Richiesta cancellata parzialment' +
      'e</span>'
    RawText = True
    Enabled = True
  end
  object btnImporta: TmeIWButton [31]
    Left = 488
    Top = 385
    Width = 177
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
    Caption = 'Conferma autorizzazioni'
    Confirmation = 'Confermare le autorizzazioni impostate?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnImporta'
    TabOrder = 19
    OnClick = btnImportaClick
    medpDownloadButton = False
  end
  object edtPeriodoDalAl: TmeIWEdit [32]
    Left = 700
    Top = 166
    Width = 73
    Height = 21
    Css = 'input_data_my al'
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
    FriendlyName = 'edtPeriodoDalAl'
    MaxLength = 10
    SubmitOnAsyncEvent = True
    TabOrder = 20
    OnAsyncChange = edtPeriodoDalAlAsyncChange
  end
  object lblPeriodoDalAl: TmeIWLabel [33]
    Left = 656
    Top = 168
    Width = 38
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
    ForControl = edtPeriodoDalAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDalAl'
    Caption = 'Mese:'
    Enabled = True
  end
  object btnCartellino: TmeIWImageFile [34]
    Left = 779
    Top = 167
    Width = 33
    Height = 21
    Hint = 'Visualizza cartellino del periodo'
    Css = 'padding_sx_20px'
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
    OnClick = btnCartellinoClick
    Cacheable = True
    FriendlyName = 'btnCartellino'
    ImageFile.Filename = 'img\btnConteggi2.png'
    medpDownloadButton = False
  end
  object rgpTipoMG: TmeIWRadioGroup [35]
    Left = 27
    Top = 197
    Width = 169
    Height = 23
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
    FriendlyName = 'rgpTipoMG'
    ItemIndex = 0
    Items.Strings = (
      'Mattina'
      'Pomeriggio')
    Layout = glHorizontal
    TabOrder = 21
  end
  inherited pmnTabella: TPopupMenu
    Left = 648
    Top = 480
  end
  object cdsAutorizzazione: TClientDataSet
    PersistDataPacket.Data = {
      6F0100009619E0BD01000000180000000D0000000000030000006F010B50524F
      475245535349564F04000100000000000A4E4F4D494E415449564F0100490000
      000100055749445448020002003C00094D41545249434F4C4101004900000001
      0005574944544802000200080005534553534F01004900000001000557494454
      480200020001000743415553414C450100490000000100055749445448020002
      00050009445F43415553414C4501004900000001000557494454480200020028
      00095449504F4749555354010049000000010005574944544802000200010003
      44414C040006000000000002414C0400060000000000094E554D45524F4F5245
      010049000000010005574944544802000200050004414F524501004900000001
      000557494454480200020005000C524553504F4E534142494C45010049000000
      01000557494454480200020014000E445F524553504F4E534142494C45010049
      0000000100055749445448020002003C000000}
    Active = True
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'NOMINATIVO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'MATRICOLA'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'SESSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'D_CAUSALE'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'TIPOGIUST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DAL'
        DataType = ftDate
      end
      item
        Name = 'AL'
        DataType = ftDate
      end
      item
        Name = 'NUMEROORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RESPONSABILE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'D_RESPONSABILE'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsAutorizzazioneCalcFields
    Left = 572
    Top = 481
    object cdsAutorizzazionePROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object cdsAutorizzazioneNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 60
    end
    object cdsAutorizzazioneMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsAutorizzazioneSESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object cdsAutorizzazioneCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object cdsAutorizzazioneD_CAUSALE: TStringField
      FieldName = 'D_CAUSALE'
      Size = 40
    end
    object cdsAutorizzazioneTIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Size = 1
    end
    object cdsAutorizzazioneDAL: TDateField
      FieldName = 'DAL'
    end
    object cdsAutorizzazioneAL: TDateField
      FieldName = 'AL'
    end
    object cdsAutorizzazioneNUMEROORE: TStringField
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object cdsAutorizzazioneAORE: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object cdsAutorizzazioneRESPONSABILE: TStringField
      FieldName = 'RESPONSABILE'
    end
    object cdsAutorizzazioneD_RESPONSABILE: TStringField
      FieldName = 'D_RESPONSABILE'
      Size = 60
    end
    object cdsAutorizzazioneC_OGGETTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_OGGETTO'
      Size = 100
      Calculated = True
    end
    object cdsAutorizzazioneC_TESTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TESTO'
      Size = 255
      Calculated = True
    end
    object cdsAutorizzazioneC_DATA_FIRMA: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_DATA_FIRMA'
      Size = 80
      Calculated = True
    end
  end
  object dsrT050: TDataSource
    DataSet = cdsT050
    Left = 486
    Top = 478
  end
  object cdsT050: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 438
    Top = 478
  end
end
