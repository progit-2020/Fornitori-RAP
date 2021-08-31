inherited A018FRaggrPres: TA018FRaggrPres
  Left = 199
  Top = 91
  Width = 413
  Height = 344
  HelpContext = 18000
  Caption = '<A018> Raggruppamenti di presenza'
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 272
    Width = 405
  end
  inherited Panel1: TToolBar
    Width = 405
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 405
    Height = 243
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
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
    object Label2: TLabel
      Left = 68
      Top = 8
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
    object DBEdit1: TDBEdit
      Left = 8
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 68
      Top = 22
      Width = 325
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 8
      Top = 152
      Width = 385
      Height = 83
      Caption = 'Inquadramento'
      Columns = 2
      DataField = 'CodInterno'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Nessuno'
        'Straordinario'
        'Plus-Orario'
        'Reperibilit'#224
        'Guardia pronto soccorso'
        'Comando professionale breve'
        'Recupero ore'
        'Prestazioni Aggiuntive')
      ParentFont = False
      TabOrder = 5
      TabStop = True
      Values.Strings = (
        'Z'
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G')
    end
    object DBRadioGroup2: TDBRadioGroup
      Left = 8
      Top = 44
      Width = 385
      Height = 33
      Caption = 'Indennit'#224' notturna'
      Columns = 3
      DataField = 'IndNotturna'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Si'
        'No'
        'Modello d'#39'orario')
      ParentFont = False
      TabOrder = 2
      TabStop = True
      Values.Strings = (
        'S'
        'N'
        'M')
    end
    object DBRadioGroup3: TDBRadioGroup
      Left = 8
      Top = 80
      Width = 385
      Height = 33
      Caption = 'Indennit'#224' festiva'
      Columns = 3
      DataField = 'IndFestiva'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Si'
        'No'
        'Modello d'#39'orario')
      ParentFont = False
      TabOrder = 3
      TabStop = True
      Values.Strings = (
        'S'
        'N'
        'M')
    end
    object DBRadioGroup4: TDBRadioGroup
      Left = 8
      Top = 116
      Width = 385
      Height = 33
      Caption = 'Indennit'#224' di presenza'
      Columns = 3
      DataField = 'INDPRESENZA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Si'
        'No')
      ParentFont = False
      TabOrder = 4
      TabStop = True
      Values.Strings = (
        'S'
        'N')
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 258
  end
  inherited DButton: TDataSource
    Left = 314
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 286
  end
end
