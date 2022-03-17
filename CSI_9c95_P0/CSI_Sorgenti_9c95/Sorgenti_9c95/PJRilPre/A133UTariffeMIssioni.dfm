inherited A133FTariffeMissioni: TA133FTariffeMissioni
  HelpContext = 3133000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A133> Tariffe trasferte'
  ClientHeight = 465
  ClientWidth = 600
  ExplicitWidth = 616
  ExplicitHeight = 523
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 447
    Width = 600
    ExplicitTop = 447
    ExplicitWidth = 600
  end
  inherited grbDecorrenza: TGroupBox
    Width = 600
    ExplicitWidth = 600
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
    end
  end
  inherited ToolBar1: TToolBar
    Width = 600
    ExplicitWidth = 600
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 63
    Width = 600
    Height = 133
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblCodContratto: TLabel
      Left = 3
      Top = 6
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
    object dlblDTrasferta: TDBText
      Left = 153
      Top = 24
      Width = 66
      Height = 13
      AutoSize = True
      DataField = 'desc_trasferta'
      DataSource = DButton
    end
    object lblCodPosizioneEconomica: TLabel
      Left = 3
      Top = 48
      Width = 73
      Height = 13
      Caption = 'Indennit'#224' giorn.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescrizione: TLabel
      Left = 81
      Top = 92
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
    object lblCodLivello: TLabel
      Left = 3
      Top = 92
      Width = 62
      Height = 13
      Caption = 'Codice tariffa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcbxCodice: TDBLookupComboBox
      Left = 3
      Top = 21
      Width = 142
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE; DESCRIZIONE'
      TabOrder = 0
      OnKeyDown = dcbxCodiceKeyDown
    end
    object dedtIndGiornaliera: TDBEdit
      Left = 3
      Top = 64
      Width = 70
      Height = 21
      DataField = 'IND_GIORNALIERA'
      DataSource = DButton
      TabOrder = 1
    end
    object dedtDescrizione: TDBEdit
      Left = 81
      Top = 107
      Width = 464
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 3
    end
    object dedtCodTariffa: TDBEdit
      Left = 3
      Top = 107
      Width = 70
      Height = 21
      DataField = 'COD_TARIFFA'
      DataSource = DButton
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 272
      Top = 48
      Width = 273
      Height = 55
      Caption = 'Codici voce paghe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object lblCategoriaEconomica: TLabel
        Left = 7
        Top = 14
        Width = 101
        Height = 13
        Caption = 'Esente da tassazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 152
        Top = 14
        Width = 105
        Height = 13
        Caption = 'Soggetto a tassazione'
      end
      object dEdtCodVoceEsente: TDBEdit
        Left = 7
        Top = 29
        Width = 70
        Height = 21
        DataField = 'VOCEPAGHE_ESENTE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dEdtCodVoceAssog: TDBEdit
        Left = 152
        Top = 29
        Width = 70
        Height = 21
        DataField = 'VOCEPAGHE_ASSOG'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object pnlComuniGriglia: TPanel [4]
    Left = 0
    Top = 196
    Width = 600
    Height = 251
    Align = alClient
    TabOrder = 4
    object dgrdEsenzioni: TDBGrid
      Left = 1
      Top = 24
      Width = 598
      Height = 226
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    inline frmToolbarFiglio: TfrmToolbarFiglio
      Left = 1
      Top = 1
      Width = 598
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 598
      inherited tlbarFiglio: TToolBar
        Width = 598
        ExplicitWidth = 598
      end
      inherited actlstToolbarFiglio: TActionList
        inherited actTFCopiaSu: TAction
          Visible = True
          OnExecute = TCopiaSuGrigliaClick
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 368
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 396
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 424
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 452
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 480
    Top = 32
  end
end
