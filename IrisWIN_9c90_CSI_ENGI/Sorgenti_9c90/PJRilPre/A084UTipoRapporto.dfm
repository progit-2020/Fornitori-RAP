inherited A084FTipoRapporto: TA084FTipoRapporto
  Left = 67
  Top = 133
  HelpContext = 84000
  Caption = '<A084> Tipi di rapporto'
  ClientHeight = 151
  ClientWidth = 402
  ExplicitWidth = 412
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 32
    Width = 36
    Height = 13
    Caption = 'Codice:'
  end
  object Label6: TLabel [1]
    Left = 84
    Top = 32
    Width = 58
    Height = 13
    Caption = 'Descrizione:'
  end
  inherited StatusBar: TStatusBar
    Top = 133
    Width = 402
  end
  inherited Panel1: TToolBar
    Width = 402
  end
  object DBEdit3: TDBEdit [4]
    Left = 8
    Top = 48
    Width = 69
    Height = 21
    DataField = 'CODICE'
    DataSource = DButton
    TabOrder = 2
  end
  object DBEdit4: TDBEdit [5]
    Left = 84
    Top = 48
    Width = 309
    Height = 21
    DataField = 'DESCRIZIONE'
    DataSource = DButton
    TabOrder = 3
  end
  object DBRadioGroup1: TDBRadioGroup [6]
    Left = 8
    Top = 72
    Width = 385
    Height = 53
    Caption = 'Tipo rapporto'
    Columns = 5
    DataField = 'TIPO'
    DataSource = DButton
    Items.Strings = (
      'Ruolo'
      'Supplente'
      'Incaricato'
      'Prova'
      'Altro')
    TabOrder = 4
    Values.Strings = (
      'R'
      'S'
      'I'
      'P'
      'A')
  end
  inherited MainMenu1: TMainMenu
    Left = 304
  end
  inherited DButton: TDataSource
    Left = 332
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 360
  end
end
