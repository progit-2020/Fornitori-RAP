inherited A020FCausPresStorico: TA020FCausPresStorico
  HelpContext = 20700
  BorderStyle = bsSingle
  Caption = '<A020> Causali di presenza - Parametri storicizzati'
  ClientHeight = 359
  ClientWidth = 533
  ExplicitWidth = 539
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodice: TLabel [0]
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
  object lblDescCausale: TLabel [1]
    Left = 110
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
  object lblDescrizione: TLabel [2]
    Left = 8
    Top = 160
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
  object lblCausCompDebitoGG: TLabel [3]
    Left = 8
    Top = 189
    Width = 183
    Height = 13
    Caption = 'Causale per compensazione debito gg:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausTimb: TLabel [4]
    Left = 8
    Top = 96
    Width = 138
    Height = 13
    Caption = 'Causalizzazione su timbrature'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblInclEsclOreNorm: TLabel [5]
    Left = 8
    Top = 120
    Width = 157
    Height = 13
    Caption = 'Inclusione/esclusione ore normali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited StatusBar: TStatusBar
    Top = 341
    Width = 533
    ExplicitTop = 341
    ExplicitWidth = 533
  end
  inherited grbDecorrenza: TGroupBox
    Width = 533
    ExplicitWidth = 533
  end
  inherited ToolBar1: TToolBar
    Width = 533
    ExplicitWidth = 533
    inherited ToolButton2: TToolButton
      Visible = False
    end
  end
  object dedtCodice: TDBEdit [9]
    Left = 48
    Top = 69
    Width = 56
    Height = 21
    Color = clBtnFace
    DataField = 'CODICE'
    DataSource = DButton
    TabOrder = 3
  end
  object dedtDescCausale: TDBEdit [10]
    Left = 176
    Top = 69
    Width = 349
    Height = 21
    Color = clBtnFace
    DataField = 'DESC_CAUSALE'
    DataSource = DButton
    TabOrder = 4
  end
  object dedtDescrizione: TDBEdit [11]
    Left = 110
    Top = 157
    Width = 415
    Height = 21
    DataField = 'DESCRIZIONE'
    DataSource = DButton
    TabOrder = 7
  end
  object dcmbCausCompDebitoGG: TDBLookupComboBox [12]
    Left = 196
    Top = 184
    Width = 76
    Height = 21
    DataField = 'CAUSCOMP_DEBITOGG'
    DataSource = DButton
    DropDownRows = 8
    DropDownWidth = 300
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    TabOrder = 8
  end
  object edtCausTimb: TEdit [13]
    Left = 176
    Top = 93
    Width = 349
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
    Text = 'edtCausTimb'
  end
  object edtInclEsclOreNorm: TEdit [14]
    Left = 176
    Top = 117
    Width = 349
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
    Text = 'edtInclEsclOreNorm'
  end
  object dchkRendicontaProgetti: TDBCheckBox [15]
    Left = 6
    Top = 211
    Width = 203
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
    TabOrder = 9
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object GrpArrGG: TGroupBox [16]
    Left = 8
    Top = 234
    Width = 264
    Height = 99
    Caption = 'Arrotondamento giornaliero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    object LblArrotondamento2: TLabel
      Left = 8
      Top = 19
      Width = 75
      Height = 13
      Caption = 'Arrotondamento'
    end
    object DEdtArrotondamento: TDBEdit
      Left = 205
      Top = 16
      Width = 43
      Height = 21
      DataField = 'ARROT_RIEPGG'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dchkPerdiArr: TDBCheckBox
      Left = 8
      Top = 39
      Width = 240
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Mantiene il resto nelle ore normali'
      DataField = 'ARROT_RIEPGG_ORENORM'
      DataSource = DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkArrFascie: TDBCheckBox
      Left = 8
      Top = 57
      Width = 240
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Applica l'#39'arrotondamento alle fasce'
      DataField = 'ARROT_RIEPGG_FASCE'
      DataSource = DButton
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkArrotRiepGGFineCont: TDBCheckBox
      Left = 8
      Top = 76
      Width = 240
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Applica dopo la compensazione del debito'
      DataField = 'ARROT_RIEPGG_FINECONT'
      DataSource = DButton
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 24
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 24
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 24
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 24
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 24
    inherited actRicerca: TAction
      Visible = False
    end
    inherited actPrimo: TAction
      Visible = False
    end
    inherited actPrecedente: TAction
      Visible = False
    end
    inherited actSuccessivo: TAction
      Visible = False
    end
    inherited actUltimo: TAction
      Visible = False
    end
    inherited actInserisci: TAction
      Visible = False
    end
  end
end
