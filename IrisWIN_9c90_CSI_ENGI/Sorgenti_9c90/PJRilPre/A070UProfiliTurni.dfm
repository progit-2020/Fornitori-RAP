inherited A070FProfiliTurni: TA070FProfiliTurni
  Left = 249
  Top = 201
  Width = 447
  Height = 353
  HelpContext = 70000
  Caption = '<A070> Profili turni'
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 281
    Width = 439
  end
  inherited Panel1: TToolBar
    Width = 439
  end
  object GrbParametri: TGroupBox [2]
    Left = 0
    Top = 29
    Width = 431
    Height = 42
    TabOrder = 2
    object Label8: TLabel
      Left = 20
      Top = 16
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
    object Label9: TLabel
      Left = 142
      Top = 16
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
    object dEdtCodice: TDBEdit
      Left = 60
      Top = 13
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtDescrizione: TDBEdit
      Left = 203
      Top = 13
      Width = 213
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox [3]
    Left = 0
    Top = 72
    Width = 430
    Height = 199
    TabOrder = 3
    object Label1: TLabel
      Left = 20
      Top = 25
      Width = 222
      Height = 13
      Caption = 'Numero massimo di giorni consecutivi di lavoro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 49
      Width = 194
      Height = 13
      Caption = 'Numero minimo di notti per gruppo di notti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 20
      Top = 73
      Width = 202
      Height = 13
      Caption = 'Numero massimo di notti per gruppo di notti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 20
      Top = 97
      Width = 167
      Height = 13
      Caption = 'Numero di riposi dopo turno di notte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 20
      Top = 121
      Width = 173
      Height = 13
      Caption = 'Numero di giorni tra due turni di notte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 20
      Top = 145
      Width = 329
      Height = 13
      Caption = 
        'Numero consigliato di notti per un ciclo che termina in un giorn' +
        'o feriale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 20
      Top = 169
      Width = 332
      Height = 13
      Caption = 
        'Numero consigliato di notti per un ciclo che termina in un giorn' +
        'o festivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtNUMMAXGGCONSECUTIVIDILAVORO: TDBEdit
      Left = 365
      Top = 21
      Width = 50
      Height = 21
      DataField = 'NUMMAXGGCONSECUTIVIDILAVORO'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtNUMMINNOTTIPERGRUPPODINOTTI: TDBEdit
      Left = 365
      Top = 45
      Width = 50
      Height = 21
      DataField = 'NUMMINNOTTIPERGRUPPODINOTTI'
      DataSource = DButton
      TabOrder = 1
    end
    object dEdtNUMMAXNOTTIPERGRUPPODINOTTI: TDBEdit
      Left = 365
      Top = 69
      Width = 50
      Height = 21
      DataField = 'NUMMAXNOTTIPERGRUPPODINOTTI'
      DataSource = DButton
      TabOrder = 2
    end
    object dEdtNUMRIPOSIDOPOTURNODINOTTE: TDBEdit
      Left = 365
      Top = 93
      Width = 50
      Height = 21
      DataField = 'NUMRIPOSIDOPOTURNODINOTTE'
      DataSource = DButton
      TabOrder = 3
    end
    object dEdtNUMGGTRADUETURNIDINOTTE: TDBEdit
      Left = 365
      Top = 117
      Width = 50
      Height = 21
      DataField = 'NUMGGTRADUETURNIDINOTTE'
      DataSource = DButton
      TabOrder = 4
    end
    object dEdtNUMOKNOTTIPERCICLOFERIALE: TDBEdit
      Left = 365
      Top = 141
      Width = 50
      Height = 21
      DataField = 'NUMOKNOTTIPERCICLOFERIALE'
      DataSource = DButton
      TabOrder = 5
    end
    object dEdtNUMOKNOTTIPERCICLOFESTIVO: TDBEdit
      Left = 365
      Top = 165
      Width = 50
      Height = 21
      DataField = 'NUMOKNOTTIPERCICLOFESTIVO'
      DataSource = DButton
      TabOrder = 6
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 336
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 364
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 392
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 420
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 448
    Top = 2
  end
end
