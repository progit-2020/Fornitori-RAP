inherited P684FGenerale: TP684FGenerale
  HelpContext = 3684100
  Caption = '<P684> Generale'
  ClientHeight = 258
  ClientWidth = 570
  OnShow = FormShow
  ExplicitWidth = 578
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 240
    Width = 570
    ExplicitTop = 240
    ExplicitWidth = 570
  end
  inherited Panel1: TToolBar
    Width = 570
    TabOrder = 2
    ExplicitWidth = 570
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 29
    Width = 570
    Height = 60
    Align = alTop
    TabOrder = 3
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
      Width = 70
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
    Width = 570
    Height = 151
    Align = alClient
    TabOrder = 0
    object lblCodVoce: TLabel
      Left = 5
      Top = 11
      Width = 60
      Height = 13
      Caption = 'Codice voce'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 53
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
    object Label2: TLabel
      Left = 169
      Top = 11
      Width = 68
      Height = 13
      Caption = 'Ordine stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoVoce: TLabel
      Left = 5
      Top = 107
      Width = 83
      Height = 13
      Caption = 'Tipo destinazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtCodVoceGen: TDBEdit
      Left = 5
      Top = 25
      Width = 58
      Height = 21
      DataField = 'COD_VOCE_GEN'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtOrdineStampa: TDBEdit
      Left = 169
      Top = 25
      Width = 49
      Height = 21
      DataField = 'ORDINE_STAMPA'
      DataSource = DButton
      TabOrder = 3
    end
    object dcmbTipoVoce: TDBComboBox
      Left = 5
      Top = 121
      Width = 145
      Height = 21
      DataField = 'TIPO_VOCE'
      DataSource = DButton
      ItemHeight = 13
      TabOrder = 2
    end
    object dmemDescrizione: TDBMemo
      Left = 5
      Top = 67
      Width = 558
      Height = 33
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 200
      TabOrder = 1
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 400
    Top = 65535
  end
  inherited DButton: TDataSource
    Left = 428
    Top = 65535
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 456
    Top = 65535
  end
  inherited ImageList1: TImageList
    Left = 484
    Top = 65535
  end
  inherited ActionList1: TActionList
    Left = 512
    Top = 65535
  end
end
