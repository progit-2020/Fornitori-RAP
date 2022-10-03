object FrmTabelle99: TFrmTabelle99
  Left = 118
  Top = 171
  Caption = 'FrmTabelle99'
  ClientHeight = 288
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 269
    Width = 536
    Height = 19
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Width = 80
      end>
  end
  object MainMenu1: TMainMenu
    object File1: TMenuItem
      Caption = 'File'
      object ImpostaStampante1: TMenuItem
        Caption = '&Imposta Stampante'
        OnClick = ImpostaStampante1Click
      end
      object Stampa1: TMenuItem
        Caption = '&Stampa...'
        ShortCut = 16467
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Esci'
        OnClick = Exit1Click
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 32
  end
end
