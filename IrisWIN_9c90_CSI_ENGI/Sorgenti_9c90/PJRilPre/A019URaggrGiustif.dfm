inherited A019FRaggrGiustif: TA019FRaggrGiustif
  Left = 121
  Top = 124
  Width = 448
  Height = 199
  HelpContext = 19000
  Caption = '<A019> Raggruppamenti di giustificazione'
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 127
    Width = 440
  end
  inherited Panel1: TToolBar
    Width = 440
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 440
    Height = 98
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
      Top = 46
      Width = 385
      Height = 43
      Caption = 'Inquadramento'
      Columns = 3
      DataField = 'CodInterno'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Nessuno'
        'Causali a numero'
        'Pausa mensa')
      ParentFont = False
      TabOrder = 2
      TabStop = True
      Values.Strings = (
        'Z'
        'A'
        'B')
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
