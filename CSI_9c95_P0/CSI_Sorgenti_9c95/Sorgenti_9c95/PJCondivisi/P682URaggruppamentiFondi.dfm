inherited P682FRaggruppamentiFondi: TP682FRaggruppamentiFondi
  HelpContext = 3682000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<P682> Raggruppamenti fondi'
  ClientHeight = 354
  OnShow = FormShow
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 336
    ExplicitTop = 336
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 542
    Height = 108
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 8
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
    object Label2: TLabel
      Left = 10
      Top = 54
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
    object dedtCodice: TDBEdit
      Left = 10
      Top = 23
      Width = 103
      Height = 21
      DataField = 'COD_RAGGR'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtDescrizione: TDBEdit
      Left = 10
      Top = 69
      Width = 519
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 500
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid [3]
    Left = 0
    Top = 137
    Width = 542
    Height = 199
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
