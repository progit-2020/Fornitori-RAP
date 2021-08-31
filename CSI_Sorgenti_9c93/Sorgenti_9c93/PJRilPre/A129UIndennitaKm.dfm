inherited A129FIndennitaKm: TA129FIndennitaKm
  Left = 236
  Top = 156
  HelpContext = 129000
  Caption = '<A129> Indennit'#224' chilometriche'
  ClientHeight = 269
  ClientWidth = 536
  ExplicitWidth = 552
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 251
    Width = 536
    ExplicitTop = 251
    ExplicitWidth = 536
  end
  inherited grbDecorrenza: TGroupBox
    Width = 536
    ExplicitWidth = 536
  end
  inherited ToolBar1: TToolBar
    Width = 536
    ExplicitWidth = 536
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 63
    Width = 536
    Height = 188
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object lblDescrizione: TLabel
      Left = 83
      Top = 41
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
    object LblIndennitaKmNelComune: TLabel
      Left = 42
      Top = 71
      Width = 101
      Height = 13
      Caption = 'Importo indennita km:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dLblValuta1: TDBText
      Left = 215
      Top = 72
      Width = 56
      Height = 13
      AutoSize = True
      DataField = 'descvaluta'
    end
    object LblArrImportiKmNelComune: TLabel
      Left = 14
      Top = 102
      Width = 129
      Height = 13
      Caption = 'Arrot. importo indennit'#224' Km:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dLblArrImportiKmNelComune: TDBText
      Left = 215
      Top = 103
      Width = 134
      Height = 13
      AutoSize = True
      DataField = 'descarrotondamento'
      DataSource = DButton
    end
    object Label1: TLabel
      Left = 105
      Top = 12
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
      Left = 45
      Top = 133
      Width = 96
      Height = 13
      Caption = 'Codice voce paghe:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtDescrizione: TDBEdit
      Left = 144
      Top = 38
      Width = 377
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtImporto: TDBEdit
      Left = 144
      Top = 68
      Width = 62
      Height = 21
      DataField = 'IMPORTO'
      DataSource = DButton
      TabOrder = 1
    end
    object dcmbArrotondamento: TDBLookupComboBox
      Left = 144
      Top = 98
      Width = 65
      Height = 21
      DataField = 'ARROTONDAMENTO'
      DataSource = DButton
      DropDownWidth = 250
      KeyField = 'COD_ARROTONDAMENTO'
      ListField = 'COD_ARROTONDAMENTO;DESCRIZIONE;VALORE'
      PopupMenu = PopupMenu1
      TabOrder = 2
      OnKeyDown = dcmbArrotondamentoKeyDown
    end
    object dEdtCodice: TDBEdit
      Left = 144
      Top = 8
      Width = 62
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      MaxLength = 40
      TabOrder = 3
    end
    object dEdtCodicePaghe: TDBEdit
      Left = 144
      Top = 129
      Width = 62
      Height = 21
      DataField = 'CODVOCEPAGHE'
      DataSource = DButton
      MaxLength = 40
      TabOrder = 4
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 384
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 412
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 440
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 468
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 496
    Top = 32
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 162
    object NuovoElemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = NuovoElemento1Click
    end
  end
end
