inherited A115FDatiLiberiStoricizzati: TA115FDatiLiberiStoricizzati
  Left = 201
  Top = 165
  HelpContext = 5000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A005> Dati liberi'
  ClientHeight = 400
  ClientWidth = 559
  ExplicitWidth = 575
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 382
    Width = 559
    ExplicitTop = 382
    ExplicitWidth = 559
  end
  inherited ToolBar1: TToolBar [1]
    Width = 559
    TabOrder = 1
    ExplicitWidth = 559
  end
  object pnlContenuto: TPanel [2]
    Left = 0
    Top = 63
    Width = 559
    Height = 319
    Align = alClient
    TabOrder = 2
    object dgrdDati: TDBGrid
      Left = 1
      Top = 76
      Width = 557
      Height = 242
      Align = alClient
      DataSource = DButton
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = dgrdDatiKeyDown
    end
    object pnlPrincipale: TPanel
      Left = 1
      Top = 34
      Width = 557
      Height = 42
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        557
        42)
      object lblCodice: TLabel
        Left = 4
        Top = 1
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
        Left = 141
        Top = 1
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
        Top = 15
        Width = 130
        Height = 21
        DataField = 'CODICE'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtDescrizione: TDBEdit
        Left = 141
        Top = 15
        Width = 413
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'DESCRIZIONE'
        DataSource = DButton
        TabOrder = 1
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 557
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lblSelDato: TLabel
        Left = 4
        Top = 9
        Width = 26
        Height = 13
        Caption = 'Dato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cmbSelDato: TComboBox
        Left = 40
        Top = 6
        Width = 209
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 0
        OnSelect = cmbSelDatoSelect
      end
    end
  end
  inherited grbDecorrenza: TGroupBox [3]
    Width = 559
    ParentDoubleBuffered = False
    TabOrder = 3
    ExplicitWidth = 559
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
