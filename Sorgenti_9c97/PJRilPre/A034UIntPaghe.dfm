inherited A034FIntPaghe: TA034FIntPaghe
  Left = 252
  Top = 199
  HelpContext = 34000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A034> Attivazione voci variabili'
  ClientHeight = 407
  ClientWidth = 517
  ExplicitWidth = 533
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 389
    Width = 517
    ExplicitTop = 389
    ExplicitWidth = 517
  end
  inherited Panel1: TToolBar
    Width = 517
    ExplicitWidth = 517
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 517
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object DBText1: TDBText
      Left = 157
      Top = 5
      Width = 230
      Height = 13
      DataField = 'Descrizione'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblInterfaccia: TLabel
      Left = 6
      Top = 5
      Width = 73
      Height = 13
      AutoSize = False
      Caption = 'Interfaccia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 89
      Top = 5
      Width = 63
      Height = 13
      DataField = 'CODICE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnParAvanzati: TBitBtn
      Left = 395
      Top = 0
      Width = 99
      Height = 22
      Caption = 'Parametri avanzati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnParAvanzatiClick
    end
  end
  object DBGrid1: TDBGrid [3]
    Left = 0
    Top = 53
    Width = 517
    Height = 336
    Align = alClient
    DataSource = A034FINTPAGHEDTM1.dsc190
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited MainMenu1: TMainMenu
    Left = 300
    Top = 30
  end
  inherited DButton: TDataSource
    Left = 328
    Top = 30
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 356
    Top = 30
  end
  inherited ImageList1: TImageList
    Left = 244
    Top = 30
  end
  inherited ActionList1: TActionList
    Left = 272
    Top = 30
    inherited actInserisci: TAction
      Visible = False
    end
  end
end
