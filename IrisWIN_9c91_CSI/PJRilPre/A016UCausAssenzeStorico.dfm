inherited A016FCausAssenzeStorico: TA016FCausAssenzeStorico
  HelpContext = 16800
  BorderStyle = bsSingle
  Caption = '<A016> Causali di assenza - Parametri storicizzati'
  ClientHeight = 544
  ClientWidth = 590
  ExplicitWidth = 596
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 13
  object lblDescrizione: TLabel [0]
    Left = 8
    Top = 99
    Width = 99
    Height = 13
    Caption = 'Descrizione periodo :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCodice: TLabel [1]
    Left = 8
    Top = 72
    Width = 36
    Height = 13
    Caption = 'Codice:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblValorGiorOre: TLabel [2]
    Left = 8
    Top = 273
    Width = 140
    Height = 13
    Caption = 'Ore valorizzazione giornaliera:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblValorGiorOreComp: TLabel [3]
    Left = 8
    Top = 477
    Width = 140
    Height = 13
    Caption = 'Ore valorizzazione giornaliera:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblHMAssenza: TLabel [4]
    Left = 275
    Top = 123
    Width = 140
    Height = 13
    Caption = 'HH:MM per giorno di assenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausaliCompatibili: TLabel [5]
    Left = 275
    Top = 248
    Width = 86
    Height = 13
    Caption = 'Causali compatibili'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDescCausale: TLabel [6]
    Left = 130
    Top = 72
    Width = 58
    Height = 13
    Caption = 'Descrizione:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausaliCheckComp: TLabel [7]
    Left = 275
    Top = 332
    Width = 154
    Height = 13
    Caption = 'Controllo aggiuntivo competenze'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblVisualComp: TLabel [8]
    Left = 275
    Top = 375
    Width = 129
    Height = 13
    Caption = 'Visualizza le competenze di'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausaleFruizOre: TLabel [9]
    Left = 275
    Top = 203
    Width = 174
    Height = 13
    Caption = 'Causale da inserire se fruizione oraria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausaleHMAssenza: TLabel [10]
    Left = 275
    Top = 171
    Width = 177
    Height = 26
    AutoSize = False
    Caption = 'Causale cumulativa giornaliera delle fruizioni orarie'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  inherited StatusBar: TStatusBar
    Top = 526
    Width = 590
    ExplicitTop = 526
    ExplicitWidth = 590
  end
  inherited grbDecorrenza: TGroupBox
    Width = 590
    ExplicitWidth = 590
  end
  inherited ToolBar1: TToolBar
    Width = 590
    TabOrder = 0
    ExplicitWidth = 590
    inherited ToolButton2: TToolButton
      Visible = False
    end
    inherited ToolButton6: TToolButton
      Visible = False
    end
  end
  object dedtCodice: TDBEdit [14]
    Left = 48
    Top = 69
    Width = 56
    Height = 21
    Color = clBtnFace
    DataField = 'CODICE'
    DataSource = DButton
    TabOrder = 2
  end
  object dedtDescrizione: TDBEdit [15]
    Left = 113
    Top = 96
    Width = 465
    Height = 21
    DataField = 'DESCRIZIONE'
    DataSource = DButton
    TabOrder = 4
  end
  object drgpValorGior: TDBRadioGroup [16]
    Left = 8
    Top = 123
    Width = 249
    Height = 146
    Caption = 'Valorizzazione giornaliera'
    DataField = 'VALORGIOR'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Monte ore sett./gg. lav.'
      'Ore teoriche dell'#39'orario'
      'Monte ore sett./6'
      'Ore teoriche da anagrafico'
      'Ore del debito giornaliero'
      'Ore fisse')
    ParentFont = False
    TabOrder = 5
    Values.Strings = (
      'A'
      'B'
      'C'
      'D'
      'E'
      'F')
    OnChange = drgpValorGiorChange
  end
  object dedtValorGiorOre: TDBEdit [17]
    Left = 214
    Top = 270
    Width = 43
    Height = 21
    DataField = 'VALORGIOR_ORE'
    DataSource = DButton
    TabOrder = 6
    OnChange = OnDBEditOraChange
  end
  object drgpValorGiorComp: TDBRadioGroup [18]
    Left = 4
    Top = 302
    Width = 253
    Height = 171
    Caption = 'Valorizz. giorn. per competenze'
    DataField = 'VALORGIOR_COMP'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Come Valorizzazione giornaliera'
      'Monte ore sett./gg. lav.'
      'Ore teoriche dell'#39'orario'
      'Monte ore sett./6'
      'Ore teoriche da anagrafico'
      'Ore del debito giornaliero'
      'Ore fisse')
    ParentFont = False
    TabOrder = 7
    Values.Strings = (
      '-'
      'A'
      'B'
      'C'
      'D'
      'E'
      'F')
    OnChange = drgpValorGiorCompChange
  end
  object dedtValorGiorOreComp: TDBEdit [19]
    Left = 214
    Top = 474
    Width = 43
    Height = 21
    DataField = 'VALORGIOR_ORECOMP'
    DataSource = DButton
    TabOrder = 8
    OnChange = OnDBEditOraChange
  end
  object dchkValorGiorOrePropPT: TDBCheckBox [20]
    Left = 6
    Top = 501
    Width = 251
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Proporziona se part-time'
    DataField = 'VALORGIOR_ORE_PROPPT'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object dedtHMAssenza: TDBEdit [21]
    Left = 535
    Top = 123
    Width = 43
    Height = 21
    DataField = 'HMASSENZA'
    DataSource = DButton
    TabOrder = 10
    OnChange = OnDBEditOraChange
  end
  object dchkHMAssenzaPropPT: TDBCheckBox [22]
    Left = 275
    Top = 146
    Width = 303
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Proporziona se part-time'
    DataField = 'HMASSENZA_PROPPT'
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
  object dedtCausaliCompatibili: TDBEdit [23]
    Left = 275
    Top = 263
    Width = 282
    Height = 21
    Color = clBtnFace
    DataField = 'CAUSALI_COMPATIBILI'
    DataSource = DButton
    ReadOnly = True
    TabOrder = 15
  end
  object btnCausaliCompatibili: TButton [24]
    Left = 559
    Top = 263
    Width = 19
    Height = 21
    Caption = '...'
    TabOrder = 16
    OnClick = SelezioneCausali
  end
  object drgpStatoCompatibilta: TDBRadioGroup [25]
    Left = 275
    Top = 289
    Width = 303
    Height = 40
    Caption = 'Stato compatibilit'#224
    Columns = 3
    DataField = 'STATO_COMPATIBILITA'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Disattivato'
      'Compatibile'
      'Incompatibile')
    ParentFont = False
    TabOrder = 17
    Values.Strings = (
      'D'
      'C'
      'I')
  end
  object dedtDescCausale: TDBEdit [26]
    Left = 189
    Top = 69
    Width = 389
    Height = 21
    Color = clBtnFace
    DataField = 'DESC_CAUSALE'
    DataSource = DButton
    TabOrder = 3
  end
  object dedtCausaliCheckComp: TDBEdit [27]
    Left = 275
    Top = 347
    Width = 282
    Height = 21
    Color = clBtnFace
    DataField = 'CAUSALI_CHECKCOMPETENZE'
    DataSource = DButton
    ReadOnly = True
    TabOrder = 18
  end
  object btnCausaliCheckComp: TButton [28]
    Left = 559
    Top = 347
    Width = 19
    Height = 21
    Caption = '...'
    TabOrder = 19
    OnClick = SelezioneCausali
  end
  object dcmbVisualCompetenze: TDBComboBox [29]
    Left = 461
    Top = 372
    Width = 117
    Height = 21
    Style = csDropDownList
    DataField = 'CAUSALE_VISUALCOMPETENZE'
    DataSource = DButton
    TabOrder = 20
  end
  object grpFruizAbilSP: TGroupBox [30]
    Left = 275
    Top = 396
    Width = 303
    Height = 59
    Caption = 'Fruizioni abilitate allo scarico paghe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 21
    object dchkFruizAbilSPGiorni: TDBCheckBox
      Left = 8
      Top = 17
      Width = 89
      Height = 17
      Caption = 'Giorni'
      DataField = 'SCARICOPAGHE_FRUIZ_GG'
      DataSource = DButton
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkFruizAbilSPOre: TDBCheckBox
      Left = 8
      Top = 35
      Width = 66
      Height = 17
      Caption = 'Ore'
      DataField = 'SCARICOPAGHE_FRUIZ_ORE'
      DataSource = DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object dcmbCausaleFruizOre: TDBLookupComboBox [31]
    Left = 461
    Top = 199
    Width = 117
    Height = 21
    DataField = 'CAUSALE_FRUIZORE'
    DataSource = DButton
    TabOrder = 13
  end
  object dcmbCausaleHMAssenza: TDBLookupComboBox [32]
    Left = 461
    Top = 172
    Width = 117
    Height = 21
    DataField = 'CAUSALE_HMASSENZA'
    DataSource = DButton
    TabOrder = 12
  end
  object dchkCheckSoloCompetenze: TDBCheckBox [33]
    Left = 275
    Top = 225
    Width = 303
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Esclusione dei controlli utente'
    DataField = 'CHECK_SOLOCOMPETENZE'
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
  end
  object dchkAbbatteStrInd: TDBCheckBox [34]
    Left = 275
    Top = 459
    Width = 303
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Abbatte la maturazione di straordinario e indennit'#224
    DataField = 'ABBATTE_STRIND'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object dchkSceltaOrario: TDBCheckBox [35]
    Left = 275
    Top = 480
    Width = 303
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Considera il giustif. dalle..alle nella scelta dell'#39'orario'
    DataField = 'SCELTA_ORARIO'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 24
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object dchkRendicontaProgetti: TDBCheckBox [36]
    Left = 275
    Top = 501
    Width = 303
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Considera per rendicontazione progetti'
    DataField = 'RENDICONTA_PROGETTI'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 25
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 32
    inherited actRicerca: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrecedente: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actSuccessivo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actUltimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actInserisci: TAction
      ShortCut = 0
      Visible = False
      OnExecute = nil
    end
  end
end
