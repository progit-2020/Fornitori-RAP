object A114FVisFile: TA114FVisFile
  Left = 265
  Top = 189
  Caption = '<A114> Log estrazione dati dal generatore di stampe'
  ClientHeight = 352
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 536
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnStampa: TBitBtn
      Left = 12
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Stampa'
      TabOrder = 0
      OnClick = btnStampaClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
    object btnSetup: TBitBtn
      Left = 110
      Top = 8
      Width = 90
      Height = 25
      Caption = 'S&tampante'
      TabOrder = 1
      OnClick = btnSetupClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    end
    object btnEsci: TBitBtn
      Left = 210
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      TabOrder = 2
      Kind = bkClose
    end
  end
  object memoAnomalie: TMemo
    Left = 112
    Top = 8
    Width = 280
    Height = 169
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object DbGrdLog: TDBGrid
    Left = 112
    Top = 184
    Width = 281
    Height = 120
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 424
    Top = 314
  end
  object SaveDialog1: TSaveDialog
    Left = 456
    Top = 315
  end
end
