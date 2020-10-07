object B014FBrowseStruttura: TB014FBrowseStruttura
  Left = 253
  Top = 230
  Caption = '<B014> Browse struttura'
  ClientHeight = 266
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdIADati: TDBGrid
    Left = 0
    Top = 83
    Width = 579
    Height = 164
    Align = alClient
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 83
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 2
      Top = 4
      Width = 25
      Height = 13
      Caption = 'Filtro:'
    end
    object Label1: TLabel
      Left = 2
      Top = 32
      Width = 30
      Height = 13
      Caption = 'Script:'
    end
    object edtFiltroIADati: TEdit
      Left = 38
      Top = 2
      Width = 427
      Height = 21
      TabOrder = 0
    end
    object btnRefresh: TBitBtn
      Left = 469
      Top = 2
      Width = 105
      Height = 25
      Caption = 'Refresh'
      Default = True
      TabOrder = 1
      OnClick = btnRefreshClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnEseguiStruttura: TBitBtn
      Left = 469
      Top = 57
      Width = 105
      Height = 25
      Caption = 'Esegui struttura'
      TabOrder = 4
      OnClick = btnEseguiStrutturaClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
    end
    object edtScript: TEdit
      Left = 38
      Top = 30
      Width = 427
      Height = 21
      TabOrder = 2
    end
    object btnEseguiScript: TBitBtn
      Left = 469
      Top = 30
      Width = 105
      Height = 25
      Caption = 'Esegui script'
      TabOrder = 3
      OnClick = btnEseguiScriptClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFF00000FF
        FFFFFFFF0BF3330FFFFF00000FB3000000FFBFF00BF0BF33330FFBBFBFBBFB33
        330F0FFB330BB03000FF0BB3B330F000000FBFF30B30BFB33330FBB30F30FBF3
        33303FF3F330B000000F3BBF330BF03000FFBFFBFBFBBF33330FFBB00FB0FB33
        330F33303BF3000000FFFFFF3FB3330FFFFFFFFFF33000FFFFFF}
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 247
    Width = 579
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end
