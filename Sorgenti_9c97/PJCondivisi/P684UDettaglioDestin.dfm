inherited P684FDettaglioDestin: TP684FDettaglioDestin
  HelpContext = 3684400
  Caption = '<P684> Destinazioni dettagliate'
  ClientHeight = 379
  ClientWidth = 652
  OnShow = FormShow
  ExplicitWidth = 660
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 361
    Width = 652
    ExplicitTop = 361
    ExplicitWidth = 652
  end
  inherited Panel1: TToolBar
    Width = 652
    ExplicitWidth = 652
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 29
    Width = 652
    Height = 60
    Align = alTop
    TabOrder = 2
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
    Width = 652
    Height = 272
    Align = alClient
    TabOrder = 3
    object lblCodVoceDett: TLabel
      Left = 5
      Top = 48
      Width = 77
      Height = 13
      Caption = 'Cod.destin. dett.'
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
    object lblCodAccorpamento: TLabel
      Left = 5
      Top = 246
      Width = 123
      Height = 13
      Caption = 'Codici accorpamento voci'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFiltroDipendenti: TLabel
      Left = 5
      Top = 170
      Width = 74
      Height = 13
      Caption = 'Filtro dipendenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 109
      Width = 66
      Height = 13
      Caption = 'Importo speso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 138
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
    object dedtCodAccorpamento: TDBEdit
      Left = 134
      Top = 243
      Width = 494
      Height = 21
      DataField = 'CODICI_ACCORPAMENTOVOCI'
      DataSource = DButton
      MaxLength = 500
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object btnCodAccorpamento: TBitBtn
      Left = 629
      Top = 241
      Width = 17
      Height = 25
      Caption = '...'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 8
      OnClick = btnCodAccorpamentoClick
    end
    object dmemFiltroDipendenti: TDBMemo
      Left = 5
      Top = 192
      Width = 641
      Height = 41
      DataField = 'FILTRO_DIPENDENTI'
      DataSource = DButton
      MaxLength = 500
      TabOrder = 6
    end
    inline C600frmSelAnagrafe: TC600frmSelAnagrafe
      Left = 89
      Top = 166
      Width = 26
      Height = 24
      TabOrder = 9
      TabStop = True
      ExplicitLeft = 89
      ExplicitTop = 166
      ExplicitWidth = 26
      inherited pnlSelAnagrafe: TPanel
        Width = 26
        ExplicitWidth = 26
        inherited btnSelezione: TBitBtn
          Top = 0
          OnClick = C600frmSelAnagrafebtnSelezioneClick
          ExplicitTop = 0
        end
      end
    end
    object dedtImportoSpeso: TDBEdit
      Left = 88
      Top = 106
      Width = 92
      Height = 21
      DataField = 'IMPORTO'
      DataSource = DButton
      TabOrder = 3
    end
    object dcmbArrotSpeso: TDBLookupComboBox
      Left = 88
      Top = 135
      Width = 58
      Height = 21
      DataField = 'COD_ARROTONDAMENTO'
      DataSource = DButton
      KeyField = 'COD_ARROTONDAMENTO'
      ListField = 'COD_ARROTONDAMENTO'
      ListSource = P684FDefinizioneFondiDtM.dsrP050
      TabOrder = 5
      OnCloseUp = dcmbArrotSpesoCloseUp
      OnKeyDown = dcmbCodVoceGenKeyDown
      OnKeyUp = dcmbArrotSpesoKeyUp
    end
    object btnVisDettaglio: TBitBtn
      Left = 183
      Top = 104
      Width = 104
      Height = 25
      Caption = 'Visualizza dettaglio'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = btnVisDettaglioClick
    end
    object dmemDescrizione: TDBMemo
      Left = 88
      Top = 63
      Width = 558
      Height = 33
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 200
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 420
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 476
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 2
  end
end
