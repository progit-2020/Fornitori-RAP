object A100FRicalcoloIndTrasp: TA100FRicalcoloIndTrasp
  Left = 319
  Top = 238
  HelpContext = 100001
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A100> Ricalcolo indennit'#224' chilometriche'
  ClientHeight = 120
  ClientWidth = 229
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 33
    Top = 24
    Width = 92
    Height = 13
    Caption = 'Mese di scarico da:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 39
    Top = 48
    Width = 86
    Height = 13
    Caption = 'Mese di scarico a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnRicalcola: TBitBtn
    Left = 33
    Top = 79
    Width = 79
    Height = 25
    HelpContext = 100001
    Caption = 'Ricalcola'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777744777777777777742247777777777742222477777777742222224777
      77774222A22224777777222A7A2224777777A2A777A2224777777A77777A2224
      777777777777A2224777777777777A2224777777777777A2224777777777777A
      2224777777777777A2247777777777777A2277777777777777A7}
    TabOrder = 0
    OnClick = BtnRicalcolaClick
  end
  object BtnChiudi: TBitBtn
    Left = 116
    Top = 79
    Width = 79
    Height = 25
    Caption = 'Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
  object mskDataDa: TMaskEdit
    Left = 128
    Top = 21
    Width = 54
    Height = 21
    EditMask = '!99/0000;1;_'
    MaxLength = 7
    TabOrder = 2
    Text = '  /    '
  end
  object mskDataA: TMaskEdit
    Left = 128
    Top = 45
    Width = 54
    Height = 21
    EditMask = '!99/0000;1;_'
    MaxLength = 7
    TabOrder = 3
    Text = '  /    '
  end
end
