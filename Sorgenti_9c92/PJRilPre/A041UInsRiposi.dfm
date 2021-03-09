object A041FInsRiposi: TA041FInsRiposi
  Left = 116
  Top = 178
  HelpContext = 41000
  Caption = '<A041> Inserimento automatico riposi'
  ClientHeight = 165
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sbtDataDa: TSpeedButton
    Left = 157
    Top = 53
    Width = 13
    Height = 21
    Caption = '...'
    NumGlyphs = 2
    OnClick = sbtDataDaClick
  end
  object lblDataDa: TLabel
    Left = 86
    Top = 40
    Width = 44
    Height = 13
    Caption = 'Dal mese'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDataA: TLabel
    Left = 204
    Top = 40
    Width = 37
    Height = 13
    Caption = 'Al mese'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object sbtDataA: TSpeedButton
    Left = 275
    Top = 53
    Width = 13
    Height = 21
    Caption = '...'
    NumGlyphs = 2
    OnClick = sbtDataAClick
  end
  object btnEsegui: TBitBtn
    Left = 24
    Top = 95
    Width = 92
    Height = 25
    Caption = '&Esegui'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000C40E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
      8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
      3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
      FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
      FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
    TabOrder = 2
    OnClick = btnEseguiClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 146
    Width = 374
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '1 Record'
    SizeGrip = False
  end
  object Progress: TProgressBar
    Left = 0
    Top = 130
    Width = 374
    Height = 16
    Align = alBottom
    TabOrder = 5
  end
  object BtnClose: TBitBtn
    Left = 258
    Top = 95
    Width = 92
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 4
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 374
    Height = 24
    Align = alTop
    TabOrder = 7
    TabStop = True
    ExplicitWidth = 374
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 374
      Height = 24
      ExplicitWidth = 374
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object btnAnomalie: TBitBtn
    Left = 142
    Top = 95
    Width = 92
    Height = 25
    Caption = '&Anomalie'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      04000000000068010000120B0000120B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333333333333333
      0000333333333933333333333333333833333333000033333BFB999BFB333333
      333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
      FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
      7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
      BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
      000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
      37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
      FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
      8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
      33333333333333FF733333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnAnomalieClick
  end
  object edtDataDa: TMaskEdit
    Left = 86
    Top = 53
    Width = 68
    Height = 21
    EditMask = '!00/0000;1;_'
    MaxLength = 7
    TabOrder = 0
    Text = '  /    '
    OnExit = edtDataDaExit
  end
  object edtDataA: TMaskEdit
    Left = 204
    Top = 53
    Width = 69
    Height = 21
    EditMask = '!00/0000;1;_'
    MaxLength = 7
    TabOrder = 1
    Text = '  /    '
    OnExit = edtDataAExit
  end
end
