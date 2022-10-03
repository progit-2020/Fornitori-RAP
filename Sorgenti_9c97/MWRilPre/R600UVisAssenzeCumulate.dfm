object R600FVisAssenzeCumulate: TR600FVisAssenzeCumulate
  Left = 151
  Top = 108
  Caption = '<R600> Assenze cumulate'
  ClientHeight = 321
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 588
    Height = 321
    Align = alClient
    ColCount = 7
    DefaultRowHeight = 16
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 0
    ExplicitWidth = 484
  end
  object MainMenu1: TMainMenu
    Left = 408
    Top = 48
    object File1: TMenuItem
      Caption = 'File'
      object StampaVideata1: TMenuItem
        Caption = 'Stampa Videata'
        OnClick = StampaVideata1Click
      end
      object Copiainexcel1: TMenuItem
        Caption = 'Copia in excel'
        OnClick = Copiainexcel1Click
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 376
    Top = 48
  end
end
