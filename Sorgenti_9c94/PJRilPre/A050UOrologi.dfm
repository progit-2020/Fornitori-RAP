inherited A050FOrologi: TA050FOrologi
  Left = 127
  Top = 104
  HelpContext = 50000
  Caption = '<A050> Orologi di timbratura'
  ClientHeight = 418
  ClientWidth = 472
  ExplicitWidth = 480
  ExplicitHeight = 464
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 400
    Width = 472
    SizeGrip = False
    ExplicitTop = 381
    ExplicitWidth = 472
  end
  inherited Panel1: TToolBar
    Width = 472
    ExplicitWidth = 472
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 472
    Height = 371
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitHeight = 352
    object LCodice: TLabel
      Left = 2
      Top = 3
      Width = 33
      Height = 13
      Caption = 'Codice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LDescrizione: TLabel
      Left = 53
      Top = 3
      Width = 55
      Height = 13
      Caption = 'Descrizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 2
      Top = 147
      Width = 194
      Height = 13
      Caption = 'Timbrature di mensa se causalizzate con:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblIndirizzo: TLabel
      Left = 2
      Top = 44
      Width = 38
      Height = 13
      Caption = 'Indirizzo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDLocalita: TLabel
      Left = 131
      Top = 216
      Width = 91
      Height = 13
      Caption = 'Descrizione localit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodLocalita: TLabel
      Left = 363
      Top = 216
      Width = 56
      Height = 13
      Caption = 'Codice Istat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 2
      Top = 257
      Width = 48
      Height = 13
      Caption = 'Rilevatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 131
      Top = 257
      Width = 36
      Height = 13
      Caption = 'Scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBECodice: TDBEdit
      Left = 2
      Top = 19
      Width = 44
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      MaxLength = 2
      TabOrder = 0
    end
    object DBEDescr: TDBEdit
      Left = 53
      Top = 19
      Width = 416
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DBRGFunzione: TDBRadioGroup
      Left = 2
      Top = 85
      Width = 321
      Height = 36
      Caption = 'Funzione'
      Columns = 3
      DataField = 'FUNZIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Presenza'
        'Mensa'
        'Presenza/Mensa')
      ParentBackground = True
      ParentFont = False
      TabOrder = 3
      Values.Strings = (
        'P'
        'M'
        'E')
      OnChange = DBRGFunzioneChange
    end
    object ECausale: TDBLookupComboBox
      Left = 205
      Top = 143
      Width = 77
      Height = 21
      DataField = 'CAUSMENSA'
      DataSource = DButton
      DropDownWidth = 200
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A050FOrologiDtM1.D305
      PopupMenu = PopupMenu1
      TabOrder = 5
      OnKeyDown = ECausaleKeyDown
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 2
      Top = 164
      Width = 321
      Height = 36
      Caption = 'Verso di timbratura associato'
      Columns = 3
      DataField = 'VERSO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Nessuno'
        'Entrata'
        'Uscita')
      ParentBackground = True
      ParentFont = False
      TabOrder = 6
      Values.Strings = (
        'N'
        'E'
        'U')
      OnChange = DBRGFunzioneChange
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 314
      Width = 472
      Height = 57
      Align = alBottom
      Caption = 'Messaggi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ExplicitTop = 295
      object Label2: TLabel
        Left = 6
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Postazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 75
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Indirizzo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 145
        Top = 16
        Width = 51
        Height = 13
        Caption = 'Indirizzo IP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtPostazione: TDBEdit
        Left = 5
        Top = 31
        Width = 60
        Height = 21
        DataField = 'POSTAZIONE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dEdtIndirizzoTerm: TDBEdit
        Left = 74
        Top = 31
        Width = 60
        Height = 21
        DataField = 'INDIRIZZO_TERMINALE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dEdtIndirizzoIP: TDBEdit
        Left = 143
        Top = 31
        Width = 100
        Height = 21
        DataField = 'INDIRIZZO_IP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dChkRicezione: TDBCheckBox
        Left = 254
        Top = 31
        Width = 117
        Height = 17
        Caption = 'Ricezione Messaggi'
        DataField = 'RICEZIONE_MESSAG'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object dchkApplicaPercorrenza: TDBCheckBox
      Left = 2
      Top = 124
      Width = 321
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Pausa mensa: applica eventuale tempo di percorrenza'
      DataField = 'APPLICA_PERCORRENZA_PM'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dedtIndirizzo: TDBEdit
      Left = 2
      Top = 58
      Width = 467
      Height = 21
      DataField = 'INDIRIZZO'
      DataSource = DButton
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object drgpTipoLocalita: TDBRadioGroup
      Left = 2
      Top = 206
      Width = 123
      Height = 47
      Caption = 'Tipologia localit'#224
      DataField = 'TIPO_LOCALITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Comune (C)'
        'Personalizzata (P)')
      ParentBackground = True
      ParentFont = False
      TabOrder = 7
      Values.Strings = (
        'C'
        'P')
      OnChange = drgpTipoLocalitaChange
    end
    object dcmbDLocalita: TDBLookupComboBox
      Left = 131
      Top = 232
      Width = 225
      Height = 21
      DataField = 'D_LOCALITA'
      DataSource = DButton
      KeyField = 'DESCRIZIONE'
      ListField = 'DESCRIZIONE'
      ListSource = A050FOrologiDtM1.DSelLocalita
      PopupMenu = PopupMenu1
      TabOrder = 8
      OnKeyDown = dcmbDLocalitaKeyDown
    end
    object dedtCodLocalita: TDBEdit
      Left = 363
      Top = 232
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'COD_LOCALITA'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 9
    end
    object dedtRilevatore: TDBEdit
      Left = 2
      Top = 270
      Width = 123
      Height = 21
      DataField = 'RILEVATORE'
      DataSource = DButton
      MaxLength = 10
      TabOrder = 10
      OnChange = dedtRilevatoreChange
    end
    object dcmbScarico: TDBLookupComboBox
      Left = 131
      Top = 270
      Width = 225
      Height = 21
      DataField = 'SCARICO'
      DataSource = DButton
      KeyField = 'SCARICO'
      ListField = 'SCARICO'
      ListSource = A050FOrologiDtM1.dsrI100
      PopupMenu = PopupMenu1
      TabOrder = 11
      OnKeyDown = dcmbDLocalitaKeyDown
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 296
    Top = 29
  end
  inherited DButton: TDataSource
    Left = 269
    Top = 29
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 324
    Top = 29
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 29
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
