inherited A115FDatiLiberiStoricizzati: TA115FDatiLiberiStoricizzati
  Left = 201
  Top = 165
  HelpContext = 115000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A115> Dati liberi storicizzati'
  ClientHeight = 400
  ClientWidth = 559
  ExplicitWidth = 569
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 382
    Width = 559
    ExplicitTop = 382
    ExplicitWidth = 559
  end
  inherited grbDecorrenza: TGroupBox
    Width = 559
    ExplicitWidth = 559
  end
  inherited ToolBar1: TToolBar
    Width = 559
    ExplicitWidth = 559
  end
  object tbcMain: TTabControl [3]
    Left = 0
    Top = 63
    Width = 559
    Height = 319
    Align = alClient
    TabOrder = 3
    OnChange = tbcMainChange
    OnChanging = tbcMainChanging
    object pnlPrincipale: TPanel
      Left = 4
      Top = 6
      Width = 551
      Height = 91
      Align = alTop
      TabOrder = 0
      DesignSize = (
        551
        91)
      object lblCodice: TLabel
        Left = 4
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
      object lblDescrizione: TLabel
        Left = 4
        Top = 45
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
        Left = 4
        Top = 21
        Width = 85
        Height = 21
        DataField = 'CODICE'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtDescrizione: TDBEdit
        Left = 4
        Top = 62
        Width = 533
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'DESCRIZIONE'
        DataSource = DButton
        TabOrder = 1
      end
    end
    object dgrdDati: TDBGrid
      Left = 4
      Top = 97
      Width = 551
      Height = 218
      Align = alClient
      DataSource = DButton
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = dgrdDatiKeyDown
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 266
    Top = 19
    inherited File1: TMenuItem
      inherited Visionecorrente1: TMenuItem
        Checked = True
      end
    end
  end
  inherited DButton: TDataSource
    AutoEdit = True
    Left = 294
    Top = 19
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 322
    Top = 19
  end
  inherited ImageList1: TImageList
    Left = 350
    Top = 19
  end
  inherited ActionList1: TActionList
    Left = 378
    Top = 19
  end
end
