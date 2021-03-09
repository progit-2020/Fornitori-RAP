object A100FElencoRiaperture: TA100FElencoRiaperture
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<A100> Riaperture richiesta missione'
  ClientHeight = 217
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPulsanti: TPanel
    Left = 0
    Top = 187
    Width = 314
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 249
    object Panel1: TPanel
      Left = 217
      Top = 0
      Width = 97
      Height = 30
      Align = alRight
      Caption = 'pnlChiudi'
      Padding.Left = 1
      Padding.Top = 1
      Padding.Right = 1
      Padding.Bottom = 1
      TabOrder = 0
      ExplicitLeft = 152
      ExplicitTop = 6
      object btnChiudi: TBitBtn
        Left = 2
        Top = 2
        Width = 93
        Height = 26
        Align = alClient
        Caption = '&Chiudi'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
          F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
          000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
          338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
          45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
          3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
          F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
          000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
          338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
          4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
          8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
          333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnChiudiClick
        ExplicitLeft = 16
        ExplicitTop = 6
        ExplicitWidth = 75
        ExplicitHeight = 25
      end
    end
  end
  object dgrdElenco: TDBGrid
    Left = 0
    Top = 0
    Width = 314
    Height = 187
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
