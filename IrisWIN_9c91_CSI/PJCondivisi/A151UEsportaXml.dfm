object A151FEsportaXml: TA151FEsportaXml
  Left = 0
  Top = 0
  Caption = '<A151> Esportazione in formato .XML'
  ClientHeight = 283
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 239
    Width = 684
    Height = 44
    Align = alBottom
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 473
      Top = 10
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnVisualizzaFile: TBitBtn
      Left = 232
      Top = 10
      Width = 100
      Height = 25
      Caption = '&Visualizza file'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      TabOrder = 1
      OnClick = btnVisualizzaFileClick
    end
    object btnEsegui: TBitBtn
      Left = 112
      Top = 10
      Width = 100
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
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 352
      Top = 10
      Width = 100
      Height = 25
      Caption = '&Anomalie'
      Enabled = False
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
      TabOrder = 3
      OnClick = btnAnomalieClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 181
    Width = 684
    Height = 58
    Align = alBottom
    TabOrder = 2
    object lblNomeFileOutput: TLabel
      Left = 16
      Top = 21
      Width = 90
      Height = 13
      Caption = 'File di esportazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtNomeFileOutput: TSpeedButton
      Left = 640
      Top = 18
      Width = 15
      Height = 21
      Caption = '...'
      OnClick = sbtNomeFileOutputClick
    end
    object lblURLWS: TLabel
      Left = 16
      Top = 35
      Width = 84
      Height = 13
      Caption = 'URL WebService'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtNomeFileOutput: TEdit
      Left = 112
      Top = 18
      Width = 527
      Height = 21
      TabOrder = 0
    end
    object edtURLWS: TEdit
      Left = 112
      Top = 32
      Width = 527
      Height = 21
      TabOrder = 1
    end
  end
  object pnlTassiAssenza: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 81
    Align = alTop
    TabOrder = 0
    object lblDescIdUfficio: TLabel
      Left = 303
      Top = 51
      Width = 350
      Height = 13
      AutoSize = False
      Caption = 'lblDescIdUfficio'
    end
    object Label2: TLabel
      Left = 16
      Top = 51
      Width = 44
      Height = 13
      Caption = 'ID Ufficio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 22
      Width = 52
      Height = 13
      Caption = 'ID Mittente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescIdMittente: TLabel
      Left = 303
      Top = 22
      Width = 350
      Height = 13
      AutoSize = False
      Caption = 'lblDescIdMittente'
    end
    object dcmbIdUfficio: TDBLookupComboBox
      Left = 112
      Top = 47
      Width = 185
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_CAMPO'
      ParentFont = False
      TabOrder = 1
      OnCloseUp = dcmbIdUfficioCloseUp
      OnKeyDown = dcmbIdMittenteKeyDown
      OnKeyUp = dcmbIdUfficioKeyUp
    end
    object dcmbIdMittente: TDBLookupComboBox
      Left = 112
      Top = 18
      Width = 185
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_CAMPO'
      ParentFont = False
      TabOrder = 0
      OnCloseUp = dcmbIdMittenteCloseUp
      OnKeyDown = dcmbIdMittenteKeyDown
      OnKeyUp = dcmbIdMittenteKeyUp
    end
  end
  object pnlLegge104: TPanel
    Left = 0
    Top = 81
    Width = 684
    Height = 100
    Align = alClient
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 48
      Height = 13
      Caption = 'Username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPassword: TLabel
      Left = 16
      Top = 43
      Width = 46
      Height = 13
      Caption = 'Password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 70
      Width = 57
      Height = 13
      Caption = 'Codice ente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtUsername: TEdit
      Left = 112
      Top = 13
      Width = 185
      Height = 21
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 112
      Top = 40
      Width = 185
      Height = 21
      TabOrder = 1
    end
    object edtCodiceEnte: TEdit
      Left = 112
      Top = 67
      Width = 185
      Height = 21
      TabOrder = 2
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xml'
    Filter = 'Xml Files (*.xml)|*.xml'
    Left = 584
    Top = 204
  end
end
