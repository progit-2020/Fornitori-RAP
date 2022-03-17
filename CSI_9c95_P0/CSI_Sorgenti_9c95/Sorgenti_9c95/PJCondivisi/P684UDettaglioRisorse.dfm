inherited P684FDettaglioRisorse: TP684FDettaglioRisorse
  HelpContext = 3684200
  Caption = '<P684> Risorse dettagliate'
  ClientHeight = 321
  ClientWidth = 684
  OnShow = FormShow
  ExplicitWidth = 692
  ExplicitHeight = 367
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 303
    Width = 684
    ExplicitTop = 303
    ExplicitWidth = 652
  end
  inherited Panel1: TToolBar
    Width = 684
    ExplicitWidth = 652
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 29
    Width = 684
    Height = 60
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 652
    object lblAnno: TLabel
      Left = 106
      Top = 10
      Width = 61
      Height = 13
      Caption = 'Decorrenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblFondo: TLabel
      Left = 186
      Top = 18
      Width = 371
      Height = 26
      AutoSize = False
      Caption = 'lblFondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lblCodTabella: TLabel
      Left = 5
      Top = 10
      Width = 69
      Height = 13
      Caption = 'Codice fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object edtFondo: TEdit
      Left = 5
      Top = 25
      Width = 92
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtFondo'
    end
    object edtDecorrenza: TEdit
      Left = 106
      Top = 25
      Width = 73
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtDecorrenza'
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 89
    Width = 684
    Height = 214
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 652
    object lblCodVoceDett: TLabel
      Left = 5
      Top = 48
      Width = 76
      Height = 13
      Caption = 'Cod.risorsa dett.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 88
      Top = 48
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
    object lblCodVoceGen: TLabel
      Left = 5
      Top = 5
      Width = 104
      Height = 13
      Caption = 'Codice voce generale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtxtCodVoceGen: TDBText
      Left = 88
      Top = 23
      Width = 496
      Height = 17
      DataField = 'DESCRIZIONE'
      DataSource = P684FDefinizioneFondiDtM.dsrP686
    end
    object lblDataRif: TLabel
      Left = 5
      Top = 112
      Width = 74
      Height = 13
      Caption = 'Data riferimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblQuantita: TLabel
      Left = 39
      Top = 143
      Width = 40
      Height = 13
      Caption = 'Quantit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatoBase: TLabel
      Left = 213
      Top = 143
      Width = 49
      Height = 13
      Caption = 'Dato base'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMoltiplicatore: TLabel
      Left = 365
      Top = 143
      Width = 62
      Height = 13
      Caption = 'Moltiplicatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImporto: TLabel
      Left = 528
      Top = 143
      Width = 75
      Height = 13
      Caption = 'Importo previsto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblArrotondamento: TLabel
      Left = 5
      Top = 173
      Width = 75
      Height = 13
      Caption = 'Arrotondamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtCodVoceGen: TDBEdit
      Left = 5
      Top = 63
      Width = 73
      Height = 21
      DataField = 'COD_VOCE_DET'
      DataSource = DButton
      TabOrder = 1
    end
    object dcmbCodVoceGen: TDBLookupComboBox
      Left = 5
      Top = 20
      Width = 73
      Height = 21
      DataField = 'COD_VOCE_GEN'
      DataSource = DButton
      DropDownWidth = 400
      KeyField = 'COD_VOCE_GEN'
      ListField = 'COD_VOCE_GEN;DESCRIZIONE'
      ListSource = P684FDefinizioneFondiDtM.dsrP686
      TabOrder = 0
      OnCloseUp = dcmbCodVoceGenCloseUp
      OnKeyDown = dcmbCodVoceGenKeyDown
      OnKeyUp = dcmbCodVoceGenKeyUp
    end
    object btnDataRif: TBitBtn
      Left = 158
      Top = 107
      Width = 15
      Height = 25
      Caption = '...'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = btnDataRifClick
    end
    object dedtDataRif: TDBEdit
      Left = 88
      Top = 109
      Width = 70
      Height = 21
      DataField = 'DATA_RIFERIMENTO'
      DataSource = DButton
      TabOrder = 3
    end
    object dedtQuantita: TDBEdit
      Left = 88
      Top = 140
      Width = 70
      Height = 21
      DataField = 'QUANTITA'
      DataSource = DButton
      TabOrder = 5
      OnExit = dedtQuantitaExit
    end
    object dedtDatoBase: TDBEdit
      Left = 266
      Top = 140
      Width = 70
      Height = 21
      DataField = 'DATOBASE'
      DataSource = DButton
      TabOrder = 6
      OnExit = dedtDatoBaseExit
    end
    object dedtMoltiplicatore: TDBEdit
      Left = 431
      Top = 140
      Width = 70
      Height = 21
      DataField = 'MOLTIPLICATORE'
      DataSource = DButton
      TabOrder = 7
      OnExit = dedtMoltiplicatoreExit
    end
    object dedtImporto: TDBEdit
      Left = 606
      Top = 140
      Width = 70
      Height = 21
      DataField = 'IMPORTO'
      DataSource = DButton
      TabOrder = 8
    end
    object dCmbArrotondamento: TDBLookupComboBox
      Left = 88
      Top = 170
      Width = 70
      Height = 21
      DataField = 'COD_ARROTONDAMENTO'
      DataSource = DButton
      KeyField = 'COD_ARROTONDAMENTO'
      ListField = 'COD_ARROTONDAMENTO'
      ListSource = P684FDefinizioneFondiDtM.dsrP050
      TabOrder = 9
      OnCloseUp = dCmbArrotondamentoCloseUp
      OnKeyDown = dcmbCodVoceGenKeyDown
      OnKeyUp = dCmbArrotondamentoKeyUp
    end
    object dmemDescrizione: TDBMemo
      Left = 88
      Top = 63
      Width = 588
      Height = 33
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 200
      TabOrder = 2
    end
    inline C600frmSelAnagrafe: TC600frmSelAnagrafe
      Left = 159
      Top = 137
      Width = 26
      Height = 24
      TabOrder = 10
      TabStop = True
      ExplicitLeft = 159
      ExplicitTop = 137
      ExplicitWidth = 26
      inherited pnlSelAnagrafe: TPanel
        Width = 26
        inherited btnSelezione: TBitBtn
          OnClick = TC600frmSelAnagrafe1btnSelezioneClick
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 432
    Top = 65530
  end
  inherited DButton: TDataSource
    Left = 460
    Top = 65530
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 488
    Top = 65530
  end
  inherited ImageList1: TImageList
    Left = 516
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 544
    Top = 65530
  end
end
