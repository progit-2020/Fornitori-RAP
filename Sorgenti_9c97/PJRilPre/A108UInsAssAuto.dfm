object A108FInsAssAuto: TA108FInsAssAuto
  Left = 375
  Top = 266
  HelpContext = 108000
  BorderIcons = [biSystemMenu]
  Caption = '<A108> Compensazione giornaliera automatica'
  ClientHeight = 156
  ClientWidth = 328
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
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 121
    Width = 328
    Height = 16
    Align = alBottom
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 137
    Width = 328
    Height = 19
    Panels = <
      item
        Text = '0 Records'
        Width = 300
      end
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 328
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 328
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 328
      Height = 24
      ExplicitWidth = 328
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
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 328
    Height = 97
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object lblMese: TLabel
      Left = 121
      Top = 6
      Width = 88
      Height = 13
      Caption = 'Mese da elaborare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnEsegui: TBitBtn
      Left = 24
      Top = 56
      Width = 90
      Height = 25
      Caption = '&Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      TabOrder = 2
      OnClick = btnEseguiClick
    end
    object BtnClose: TBitBtn
      Left = 216
      Top = 56
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
    object edtMese: TMaskEdit
      Left = 121
      Top = 22
      Width = 59
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
    end
    object btnMese: TButton
      Left = 180
      Top = 22
      Width = 17
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnMeseClick
    end
    object btnAnomalie: TBitBtn
      Left = 120
      Top = 56
      Width = 90
      Height = 25
      Caption = 'Anomalie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = btnAnomalieClick
    end
  end
end
