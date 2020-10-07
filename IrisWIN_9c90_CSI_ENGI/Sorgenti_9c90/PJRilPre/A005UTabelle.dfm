inherited A005FTabelle: TA005FTabelle
  Left = 234
  HelpContext = 5000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A005> Dati liberi non storicizzati'
  ClientWidth = 457
  ExplicitWidth = 467
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 457
    ExplicitWidth = 457
  end
  inherited Panel1: TToolBar
    Width = 457
    ExplicitWidth = 457
  end
  object TabControl1: TTabControl [2]
    Left = 0
    Top = 29
    Width = 457
    Height = 386
    Align = alClient
    MultiLine = True
    TabOrder = 2
    OnChange = TabControl1Change
    OnChanging = TabControl1Changing
    object DBGrid1: TDBGrid
      Left = 4
      Top = 6
      Width = 449
      Height = 376
      Align = alClient
      DataSource = DButton
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = DBGrid1KeyDown
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 84
    Top = 56
  end
  inherited DButton: TDataSource
    AutoEdit = True
    Left = 170
    Top = 56
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 140
    Top = 56
  end
end
