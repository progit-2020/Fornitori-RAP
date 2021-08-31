object C001FGroupSelection: TC001FGroupSelection
  Left = 140
  Top = 91
  HelpContext = 1001200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<C001> Raggruppamenti'
  ClientHeight = 273
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlDisponibili: TPanel
    Left = 280
    Top = 41
    Width = 210
    Height = 232
    Align = alRight
    TabOrder = 0
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 84
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Dati disponibili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBoxDisponibili: TListBox
      Left = 1
      Top = 26
      Width = 208
      Height = 205
      Align = alBottom
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object PnlScelti: TPanel
    Left = 0
    Top = 41
    Width = 210
    Height = 232
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 88
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Dati selezionati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBoxScelti: TListBox
      Left = 1
      Top = 26
      Width = 208
      Height = 205
      Align = alBottom
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 41
    Align = alTop
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 184
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Font del gruppo'
      Glyph.Data = {
        5A010000424D5A01000000000000760000002800000017000000130000000100
        040000000000E400000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        0000000000308774477777777777777770308774477777777777777770308774
        4777777777818777703087744477777777717777703087744777777777717877
        7030877447777777777111777030877444477557777178777030877777777785
        7771778770308777777777757781111770308777777777757777777770308777
        7777775557777777703087777777777577777777703087777777777587777777
        7030877777777777557777777030877777777777777777777030800000000000
        0000000000308F0CCCCCCCCCCCCCC0F0F030888888888888888888888830}
      OnClick = SpeedButton1Click
    end
    object CmBBande: TComboBox
      Left = 5
      Top = 10
      Width = 168
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = CmBBandeChange
    end
    object BtnOK: TBitBtn
      Left = 329
      Top = 8
      Width = 75
      Height = 25
      Caption = '&OK'
      DoubleBuffered = True
      Kind = bkOK
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = BtnOKClick
    end
    object BtnCancel: TBitBtn
      Left = 410
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Annulla'
      DoubleBuffered = True
      Kind = bkCancel
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = BtnCancelClick
    end
  end
  object PnlButtons: TPanel
    Left = 210
    Top = 41
    Width = 70
    Height = 232
    Align = alClient
    TabOrder = 3
    object SpRemoveFromGroup: TSpeedButton
      Left = 21
      Top = 121
      Width = 30
      Height = 30
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = SpRemoveFromGroupClick
    end
    object SpAddToGroup: TSpeedButton
      Left = 20
      Top = 81
      Width = 30
      Height = 30
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = SpAddToGroupClick
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 126
    Top = 141
  end
end
