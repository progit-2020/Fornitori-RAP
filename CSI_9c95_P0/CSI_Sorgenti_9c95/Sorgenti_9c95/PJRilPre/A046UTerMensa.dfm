inherited A046FTerMensa: TA046FTerMensa
  Left = 158
  Top = 92
  Width = 566
  Height = 501
  HelpContext = 46000
  Caption = '<A046> Regole accessi mensa'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 437
    Width = 558
    SizeGrip = False
  end
  inherited Panel1: TToolBar
    Width = 558
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 29
    Width = 558
    Height = 134
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label12: TLabel
      Left = 6
      Top = 81
      Width = 130
      Height = 13
      Caption = 'Intervallo minimo tra 2 pasti:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 6
      Top = 52
      Width = 168
      Height = 13
      Caption = 'Timbrature di mensa per ogni pasto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 301
      Top = 83
      Width = 171
      Height = 13
      Caption = 'Voce paghe importo convenzionato:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 301
      Top = 111
      Width = 127
      Height = 13
      Caption = 'Voce paghe importo intero:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 6
      Top = 111
      Width = 120
      Height = 13
      Caption = 'Intervallo della cena dalle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 213
      Top = 111
      Width = 16
      Height = 13
      Caption = 'alle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodice: TLabel
      Left = 6
      Top = 5
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
    object lblInterfaccia: TLabel
      Left = 155
      Top = 24
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 211
      Top = 40
      Width = 68
      Height = 32
      Columns = 2
      DataField = 'NUMTIMBPASTO'
      DataSource = DButton
      Items.Strings = (
        '1'
        '2')
      TabOrder = 1
      Values.Strings = (
        '1'
        '2')
    end
    object DBEdit1: TDBEdit
      Left = 239
      Top = 77
      Width = 40
      Height = 21
      DataField = 'DIFFTRA2TIMB'
      DataSource = DButton
      TabOrder = 3
    end
    object DBEdit2: TDBEdit
      Left = 507
      Top = 79
      Width = 42
      Height = 21
      DataField = 'VOCEPAGHE1'
      DataSource = DButton
      TabOrder = 6
    end
    object DBEdit3: TDBEdit
      Left = 507
      Top = 107
      Width = 42
      Height = 21
      DataField = 'VOCEPAGHE2'
      DataSource = DButton
      TabOrder = 7
    end
    object dedtCenaDalle: TDBEdit
      Left = 159
      Top = 107
      Width = 40
      Height = 21
      DataField = 'CENA_DALLE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object dedtCenaAlle: TDBEdit
      Left = 239
      Top = 107
      Width = 40
      Height = 21
      DataField = 'CENA_ALLE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object dchkAlimentabp: TDBCheckBox
      Left = 299
      Top = 52
      Width = 249
      Height = 17
      TabStop = False
      Alignment = taLeftJustify
      Caption = 'Alimenta tabella dei Buoni Pasto'
      DataField = 'ALIMENTA_BUONIPASTO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dcmbCodice: TDBLookupComboBox
      Left = 6
      Top = 20
      Width = 145
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A046FTerMensaDTM1.dsrInterfaccia
      TabOrder = 0
      OnKeyDown = dcmbCodiceKeyDown
    end
  end
  object GroupBox1: TGroupBox [3]
    Left = 0
    Top = 163
    Width = 558
    Height = 274
    Align = alClient
    Caption = 'Segnalazione anomalia/Applicazione importo intero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 8
      Top = 142
      Width = 316
      Height = 13
      Caption = 
        'Intervallo minimo tra 2 pasti convenzionati:....................' +
        '...................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOreMinime: TLabel
      Left = 8
      Top = 236
      Width = 316
      Height = 13
      Caption = 
        'Ore minime da rendere:..........................................' +
        '...........................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 40
      Width = 336
      Height = 13
      Caption = 
        'Timbratura di mensa compresa tra entrata/uscita.................' +
        '...................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 57
      Width = 340
      Height = 13
      Caption = 
        'Timbratura di mensa antecedente alla prima entrata..............' +
        '...................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 74
      Width = 335
      Height = 13
      Caption = 
        'Timbratura di mensa successiva all'#39'ultima uscita................' +
        '.....................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 8
      Top = 91
      Width = 340
      Height = 13
      Caption = 
        'Timbrature di presenza non esistenti............................' +
        '.............................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 8
      Top = 108
      Width = 339
      Height = 13
      Caption = 
        'Timbratura causalizzata.........................................' +
        '...................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOrarioSpezzato: TLabel
      Left = 8
      Top = 202
      Width = 340
      Height = 13
      Caption = 
        'Orario spezzato.................................................' +
        '........................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 8
      Top = 125
      Width = 340
      Height = 13
      Caption = 
        'Ore rese inferiori alle minime per pausa mensa..................' +
        '........................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 23
      Width = 336
      Height = 13
      Caption = 
        'Timbratura di mensa non compresa tra uscita/entrata.............' +
        '................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOrarioNoPausaMensa: TLabel
      Left = 8
      Top = 219
      Width = 339
      Height = 13
      Caption = 
        'Orario senza gestione pausa mensa...............................' +
        '..........................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 326
      Top = 7
      Width = 52
      Height = 13
      Caption = 'Anomalia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 468
      Top = 7
      Width = 79
      Height = 13
      Caption = 'Importo intero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 359
      Top = 23
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 359
      Top = 40
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 359
      Top = 57
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 359
      Top = 74
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 359
      Top = 91
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 359
      Top = 202
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 359
      Top = 219
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 359
      Top = 125
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 359
      Top = 142
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 359
      Top = 236
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label31: TLabel
      Left = 8
      Top = 185
      Width = 337
      Height = 13
      Caption = 
        'Non rispetta le regole di maturazione del buono pasto...........' +
        '..................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label32: TLabel
      Left = 359
      Top = 185
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 8
      Top = 164
      Width = 240
      Height = 13
      Caption = 'Intervallo di accesso mensa:............................dalle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label33: TLabel
      Left = 359
      Top = 164
      Width = 144
      Height = 13
      Caption = '................................................'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label34: TLabel
      Left = 299
      Top = 165
      Width = 16
      Height = 13
      Caption = 'alle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dchkMensaSuccessivaAnom: TDBCheckBox
      Left = 343
      Top = 71
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'TIMBDOPOUSCITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkMensaAntecedenteAnom: TDBCheckBox
      Left = 343
      Top = 54
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'TIMBANTECENTRATA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkMensaNonPresentiAnom: TDBCheckBox
      Left = 343
      Top = 88
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'CONTROLLOPRESENZA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkOrarioNoPausaMensaAnom: TDBCheckBox
      Left = 343
      Top = 216
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'PAUSAMENSAGESTITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkOreReseInferioriAnom: TDBCheckBox
      Left = 343
      Top = 122
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'PRESENZAMINIMA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dEdtIntervalloAnom: TDBEdit
      Left = 319
      Top = 139
      Width = 40
      Height = 21
      DataField = 'INTERVALLO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnChange = dchkMensaStimbrataAnomClick
    end
    object dchkOrarioSpezzatoAnom: TDBCheckBox
      Left = 343
      Top = 199
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'ORARIOSPEZZATO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 20
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkTimbrNonCausalizzataAnom: TDBCheckBox
      Left = 343
      Top = 105
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'CAUSALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaStimbrataAnom: TDBCheckBox
      Left = 343
      Top = 20
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MENSA_STIMBRATA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkMensaNonStimbrataAnom: TDBCheckBox
      Left = 343
      Top = 37
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MENSA_NON_STIMBRATA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dEdtOreMinimeAnom: TDBEdit
      Left = 319
      Top = 233
      Width = 40
      Height = 21
      DataField = 'ORE_MINIME'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      OnChange = dchkMensaStimbrataAnomClick
    end
    object dChkIntervalloIntero: TDBCheckBox
      Left = 500
      Top = 139
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'INTERVALLO_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dChkOreMinimeIntero: TDBCheckBox
      Left = 500
      Top = 233
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'ORE_MINIME_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 25
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaNonStimbrataIntero: TDBCheckBox
      Left = 500
      Top = 37
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MENSA_NON_STIMBRATA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaAntecedenteIntero: TDBCheckBox
      Left = 500
      Top = 54
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'TIMBANTECENTRATA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaSuccessivaIntero: TDBCheckBox
      Left = 500
      Top = 71
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'TIMBDOPOUSCITA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaNonPresentiIntero: TDBCheckBox
      Left = 500
      Top = 88
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'CONTROLLOPRESENZA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOrarioSpezzatoIntero: TDBCheckBox
      Left = 500
      Top = 199
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'ORARIOSPEZZATO_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOrarioNoPausaMensaIntero: TDBCheckBox
      Left = 500
      Top = 216
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'PAUSAMENSAGESTITA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOreReseInferioriIntero: TDBCheckBox
      Left = 500
      Top = 122
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'PRESENZAMINIMA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMensaStimbrataIntero: TDBCheckBox
      Left = 500
      Top = 20
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MENSA_STIMBRATA_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMaturaBuonoAnom: TDBCheckBox
      Left = 343
      Top = 182
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MATURA_BUONO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dchkMaturaBuonoIntero: TDBCheckBox
      Left = 500
      Top = 182
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'MATURA_BUONO_INTERO'
      DataSource = DButton
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMensaStimbrataAnomClick
    end
    object dEdtIntMensaDa: TDBEdit
      Left = 253
      Top = 161
      Width = 40
      Height = 21
      DataField = 'MENSA_DALLE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnChange = dchkMensaStimbrataAnomClick
    end
    object dChkIntMensaIntero: TDBCheckBox
      Left = 500
      Top = 161
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      DataField = 'INTERVALLO_PM_INTERO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dEdtIntMensaA: TDBEdit
      Left = 319
      Top = 161
      Width = 40
      Height = 21
      DataField = 'MENSA_ALLE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnChange = dchkMensaStimbrataAnomClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 437
    Top = 1
  end
  inherited DButton: TDataSource
    Left = 409
    Top = 1
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 381
    Top = 1
  end
  inherited ImageList1: TImageList
    Left = 465
    Top = 1
  end
  inherited ActionList1: TActionList
    Left = 493
    Top = 1
  end
end
