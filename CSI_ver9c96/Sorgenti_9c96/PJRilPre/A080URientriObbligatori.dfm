inherited A080FRientriObbligatori: TA080FRientriObbligatori
  HelpContext = 80400
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A080> Gestione rientri obbligatori'
  ClientHeight = 355
  ClientWidth = 510
  ExplicitWidth = 518
  ExplicitHeight = 409
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 337
    Width = 510
    ExplicitTop = 337
    ExplicitWidth = 510
  end
  inherited grbDecorrenza: TGroupBox
    Width = 510
    ExplicitWidth = 510
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
    end
  end
  inherited ToolBar1: TToolBar
    Width = 510
    ExplicitWidth = 510
  end
  object pnlDati: TPanel [3]
    Left = 0
    Top = 63
    Width = 510
    Height = 46
    Align = alTop
    TabOrder = 3
    object lblGiorniLavorativi: TLabel
      Left = 4
      Top = 14
      Width = 75
      Height = 13
      Caption = 'Giorni lavorativi:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRientriObbligatori: TLabel
      Left = 152
      Top = 14
      Width = 84
      Height = 13
      Caption = 'Rientri obbligatori:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtGiorniLavorativi: TDBEdit
      Left = 84
      Top = 11
      Width = 49
      Height = 21
      DataField = 'GG_LAVORATIVI'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dedtRientriObbligatori: TDBEdit
      Left = 242
      Top = 11
      Width = 49
      Height = 21
      DataField = 'RIENTRI_OBBL'
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
  object dgrdT029: TDBGrid [4]
    Left = 0
    Top = 109
    Width = 510
    Height = 228
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODICE'
        Title.Caption = 'Codice'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Title.Caption = 'Decorrenza'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GG_LAVORATIVI'
        Title.Caption = 'Giorni lavorativi'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RIENTRI_OBBL'
        Title.Caption = 'Rientri obbligatori'
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 32
  end
end
