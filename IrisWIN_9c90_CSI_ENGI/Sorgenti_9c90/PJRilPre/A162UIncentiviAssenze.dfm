inherited A162FIncentiviAssenze: TA162FIncentiviAssenze
  Left = 55
  Top = 182
  HelpContext = 162000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A162> Abbattimento incentivi per assenze'
  ClientHeight = 554
  ClientWidth = 792
  ExplicitWidth = 808
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 536
    Width = 792
    ExplicitTop = 536
    ExplicitWidth = 792
  end
  inherited grbDecorrenza: TGroupBox
    Width = 792
    ExplicitWidth = 792
    inherited lblDecorrenza: TLabel
      Left = 5
      ExplicitLeft = 5
    end
    object Label3: TLabel [2]
      Left = 482
      Top = 15
      Width = 43
      Height = 13
      Caption = 'Data fine'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDecorrenzaFine: TSpeedButton [3]
      Left = 603
      Top = 11
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtDecorrenzaFineClick
    end
    inherited dedtDecorrenza: TDBEdit
      OnExit = dedtDecorrenzaExit
    end
    inherited chkStoriciPrec: TCheckBox
      Left = 156
      ExplicitLeft = 156
    end
    inherited chkStoriciSucc: TCheckBox
      Left = 237
      ExplicitLeft = 237
    end
    object dedtDataFine: TDBEdit
      Left = 529
      Top = 11
      Width = 73
      Height = 21
      DataField = 'DECORRENZA_FINE'
      DataSource = DButton
      TabOrder = 3
      OnChange = dedtDecorrenzaChange
    end
  end
  inherited ToolBar1: TToolBar
    Width = 792
    ExplicitWidth = 792
  end
  object dgrdAbbattimenti: TDBGrid [3]
    Left = 0
    Top = 301
    Width = 792
    Height = 235
    TabStop = False
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATO1'
        Title.Caption = 'Dato 1'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATO2'
        Title.Caption = 'Dato 2'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATO3'
        Title.Caption = 'Dato 3'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_FINE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAUSALE'
        Title.Caption = 'Causale'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_TIPOACCORPCAUSALI'
        Title.Caption = 'Tipo accorp.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_CODICIACCORPCAUSALI'
        Title.Caption = 'Codice accorp.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FRANCHIGIA_ASSENZE'
        Title.Caption = 'Franchigia'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERC_ABB_FRANCHIGIA'
        Title.Caption = '% abb. in franchigia'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERC_ABBATTIMENTO'
        Title.Caption = '% abb. al supero franchigia'
        Width = 127
        Visible = True
      end>
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 63
    Width = 792
    Height = 238
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblDato1: TLabel
      Left = 5
      Top = 9
      Width = 143
      Height = 13
      AutoSize = False
      Caption = 'Dato1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDato1: TDBText
      Left = 272
      Top = 9
      Width = 290
      Height = 13
      DataField = 'D_DATO1'
      DataSource = DButton
    end
    object lblDato2: TLabel
      Left = 5
      Top = 32
      Width = 143
      Height = 13
      AutoSize = False
      Caption = 'Dato2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDato2: TDBText
      Left = 272
      Top = 32
      Width = 290
      Height = 14
      DataField = 'D_DATO2'
      DataSource = DButton
    end
    object lblDato3: TLabel
      Left = 5
      Top = 55
      Width = 143
      Height = 13
      AutoSize = False
      Caption = 'Dato3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDato3: TDBText
      Left = 272
      Top = 55
      Width = 290
      Height = 15
      DataField = 'D_DATO3'
      DataSource = DButton
    end
    object lblTipoAccorp: TLabel
      Left = 4
      Top = 78
      Width = 114
      Height = 13
      Caption = 'Tipo accorpamento ass.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDescTipoAccorp: TDBText
      Left = 79
      Top = 97
      Width = 110
      Height = 15
      DataField = 'D_TIPOACCORP'
      DataSource = DButton
    end
    object lblPercAbb: TLabel
      Left = 649
      Top = 196
      Width = 139
      Height = 13
      Caption = '% abbatt. al supero franchigia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPercAbbFranc: TLabel
      Left = 534
      Top = 196
      Width = 104
      Height = 13
      Caption = '% abbatt. in franchigia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodAccorp: TLabel
      Left = 199
      Top = 78
      Width = 72
      Height = 13
      Caption = 'Codice accorp.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFranchigia: TLabel
      Left = 5
      Top = 196
      Width = 68
      Height = 13
      Caption = 'GG. franchigia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoAbbatt: TLabel
      Left = 4
      Top = 117
      Width = 85
      Height = 13
      Caption = 'Tipo abbattimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDescTipoAbbatt: TDBText
      Left = 81
      Top = 134
      Width = 308
      Height = 15
      DataField = 'D_TIPOABBAT'
      DataSource = DButton
    end
    object lblRisparmio: TLabel
      Left = 399
      Top = 134
      Width = 94
      Height = 13
      Caption = 'Risparmio bilancio:  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object dlblDescCausale: TDBText
      Left = 609
      Top = 97
      Width = 179
      Height = 15
      DataField = 'D_CAUSALE'
      DataSource = DButton
    end
    object Label5: TLabel
      Left = 534
      Top = 78
      Width = 91
      Height = 13
      Caption = 'Causale di assenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAssenzeAgg: TLabel
      Left = 87
      Top = 196
      Width = 92
      Height = 13
      Caption = 'Assenze aggiuntive'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblDescCodAccorp: TDBText
      Left = 272
      Top = 96
      Width = 245
      Height = 17
      DataField = 'D_CODICIACCORPCAUSALI'
      DataSource = DButton
    end
    object dcmbDato1: TDBLookupComboBox
      Left = 156
      Top = 4
      Width = 113
      Height = 21
      DataField = 'DATO1'
      DataSource = DButton
      DropDownWidth = 500
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrDato1
      TabOrder = 0
      OnCloseUp = dcmbDato1CloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbDato1KeyUp
    end
    object dcmbDato2: TDBLookupComboBox
      Left = 156
      Top = 28
      Width = 113
      Height = 21
      DataField = 'DATO2'
      DataSource = DButton
      DropDownWidth = 500
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrDato2
      TabOrder = 1
      OnCloseUp = dcmbDato2CloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbDato2KeyUp
    end
    object dcmbDato3: TDBLookupComboBox
      Left = 156
      Top = 52
      Width = 113
      Height = 21
      DataField = 'DATO3'
      DataSource = DButton
      DropDownWidth = 500
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrDato3
      TabOrder = 2
      OnCloseUp = dcmbDato3CloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbDato3KeyUp
    end
    object dcmbTipoAccorpCausali: TDBLookupComboBox
      Left = 5
      Top = 92
      Width = 70
      Height = 21
      DataField = 'COD_TIPOACCORPCAUSALI'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'COD_TIPOACCORPCAUSALI'
      ListField = 'COD_TIPOACCORPCAUSALI;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrT255
      PopupMenu = PopupMenu1
      TabOrder = 3
      OnCloseUp = dcmbTipoAccorpCausaliCloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbTipoAccorpCausaliKeyUp
    end
    object dedtPercAbb: TDBEdit
      Left = 649
      Top = 210
      Width = 70
      Height = 21
      DataField = 'PERC_ABBATTIMENTO'
      DataSource = DButton
      TabOrder = 16
    end
    object dedtPercAbbFranc: TDBEdit
      Left = 534
      Top = 210
      Width = 70
      Height = 21
      DataField = 'PERC_ABB_FRANCHIGIA'
      DataSource = DButton
      TabOrder = 15
    end
    object dchkAbbGGInt: TDBCheckBox
      Left = 534
      Top = 149
      Width = 185
      Height = 17
      Caption = 'Forza abbattimento giornata intera'
      DataField = 'FORZA_ABB_GGINT'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkAbbGGIntClick
    end
    object dcmbCodiciAccorpCausali: TDBLookupComboBox
      Left = 199
      Top = 92
      Width = 70
      Height = 21
      DataField = 'COD_CODICIACCORPCAUSALI'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'COD_CODICIACCORPCAUSALI'
      ListField = 'COD_CODICIACCORPCAUSALI;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrT256
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnCloseUp = dcmbCodiciAccorpCausaliCloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbCodiciAccorpCausaliKeyUp
    end
    object dedtFranchigia: TDBEdit
      Left = 5
      Top = 210
      Width = 70
      Height = 21
      DataField = 'FRANCHIGIA_ASSENZE'
      DataSource = DButton
      TabOrder = 8
      OnExit = dedtFranchigiaExit
    end
    object drdgGestioneFranchigia: TDBRadioGroup
      Left = 4
      Top = 160
      Width = 513
      Height = 33
      Caption = 'Gestione franchigia'
      Columns = 3
      DataField = 'GESTIONE_FRANCHIGIA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Rinnovo'
        'Annuale'
        'Decorrenza con rinnovo ann.')
      ParentFont = False
      TabOrder = 7
      Values.Strings = (
        'R'
        'A'
        'D')
      OnClick = drdgGestioneFranchigiaClick
    end
    object dchkFruitoOre: TDBCheckBox
      Left = 534
      Top = 126
      Width = 163
      Height = 17
      Caption = 'Considera frazioni di giornata'
      DataField = 'CONTA_FRUITO_ORE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dcmbTipoAbbattimento: TDBLookupComboBox
      Left = 5
      Top = 131
      Width = 70
      Height = 21
      DataField = 'TIPO_ABBATTIMENTO'
      DataSource = DButton
      DropDownWidth = 350
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE;RISPARMIO_BILANCIO'
      ListSource = A162FIncentiviAssenzeDtM.dsrT766
      PopupMenu = PopupMenu1
      TabOrder = 6
      OnCloseUp = dcmbTipoAbbattimentoCloseUp
      OnKeyDown = dcmbDato1KeyDown
      OnKeyUp = dcmbTipoAbbattimentoKeyUp
    end
    object dcmbCausale: TDBLookupComboBox
      Left = 534
      Top = 92
      Width = 70
      Height = 21
      DataField = 'CAUSALE'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A162FIncentiviAssenzeDtM.dsrT265
      PopupMenu = PopupMenu1
      TabOrder = 5
      OnCloseUp = dcmbCausaleCloseUp
      OnKeyDown = dcmbCausaleKeyDown
      OnKeyUp = dcmbCausaleKeyUp
    end
    object dedtAssenzeAgg: TDBEdit
      Left = 86
      Top = 210
      Width = 198
      Height = 21
      DataField = 'ASSENZE_AGGIUNTIVE'
      DataSource = DButton
      TabOrder = 9
      OnExit = dedtFranchigiaExit
    end
    object btnAssenzeAgg: TBitBtn
      Left = 285
      Top = 208
      Width = 16
      Height = 25
      Caption = '...'
      TabOrder = 10
      OnClick = btnAssenzeAggClick
    end
    object dchkPropFranchigia: TDBCheckBox
      Left = 313
      Top = 212
      Width = 204
      Height = 17
      Caption = 'Proporziona su gg.servizio (ass./cess.)'
      DataField = 'PROPORZIONE_FRANCHIGIA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkSoloGGInt: TDBCheckBox
      Left = 534
      Top = 172
      Width = 248
      Height = 17
      Caption = 'Considera solo ass. che coprono intera gg.'
      DataField = 'CONTA_SOLO_GGINT'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkSoloGGIntClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 390
    Top = 31
  end
  inherited DButton: TDataSource
    DataSet = A162FIncentiviAssenzeDtM.selT769
    Left = 418
    Top = 31
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 362
    Top = 31
  end
  inherited ImageList1: TImageList
    Left = 404
    Top = 56
  end
  inherited ActionList1: TActionList
    Left = 432
    Top = 56
  end
  object PopupMenu1: TPopupMenu
    Left = 616
    Top = 96
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
