object P554FElaborazioneContoAnnuale: TP554FElaborazioneContoAnnuale
  Left = 275
  Top = 130
  HelpContext = 3554000
  Caption = '<P554> Elaborazione conto annuale'
  ClientHeight = 560
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 106
  TextHeight = 13
  object pnlPeriodoElab: TPanel
    Left = 0
    Top = 24
    Width = 784
    Height = 32
    Align = alTop
    TabOrder = 1
    object lblMeseDa: TLabel
      Left = 196
      Top = 9
      Width = 41
      Height = 13
      Caption = 'Mese da'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtMeseDa: TSpeedButton
      Left = 297
      Top = 5
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseDaClick
    end
    object lblAnno: TLabel
      Left = 7
      Top = 9
      Width = 25
      Height = 13
      Caption = 'Anno'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblMeseA: TLabel
      Left = 370
      Top = 9
      Width = 35
      Height = 13
      Caption = 'Mese a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtMeseA: TSpeedButton
      Left = 465
      Top = 5
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseAClick
    end
    object edtMeseDa: TMaskEdit
      Left = 242
      Top = 5
      Width = 56
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
    end
    object edtAnno: TSpinEdit
      Left = 42
      Top = 5
      Width = 48
      Height = 22
      MaxLength = 4
      MaxValue = 9999
      MinValue = 1900
      TabOrder = 0
      Value = 2006
      OnChange = edtAnnoChange
    end
    object edtMeseA: TMaskEdit
      Left = 410
      Top = 5
      Width = 56
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 2
      Text = '  /    '
      OnDblClick = edtMeseADblClick
    end
  end
  object pnlImpostaDati: TPanel
    Left = 0
    Top = 56
    Width = 784
    Height = 108
    Align = alTop
    TabOrder = 2
    object lblDataChiusura: TLabel
      Left = 358
      Top = 64
      Width = 77
      Height = 13
      Caption = 'Data di chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataChiusura: TSpeedButton
      Left = 510
      Top = 60
      Width = 15
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtDataChiusuraClick
    end
    object chkAnnulla: TCheckBox
      Left = 212
      Top = 36
      Width = 150
      Height = 17
      Caption = 'Annulla dati conto annuale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkElaboraDatiCONTANNClick
    end
    object chkChiusura: TCheckBox
      Left = 212
      Top = 64
      Width = 77
      Height = 17
      Caption = 'Chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkElaboraDatiCONTANNClick
    end
    object edtDataChiusura: TMaskEdit
      Left = 440
      Top = 60
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 6
      Text = '  /  /    '
    end
    object rgpStatoCedolini: TRadioGroup
      Left = 212
      Top = 3
      Width = 287
      Height = 31
      Caption = 'Stato cedolini da considerare'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Solo chiusi'
        'Chiusi e aperti'
        'Solo aperti')
      ParentFont = False
      TabOrder = 1
    end
    object chkElaboraRiepiloghi: TCheckBox
      Left = 8
      Top = 36
      Width = 168
      Height = 17
      Caption = 'Calcola dati riepilogativi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkElaboraDatiCONTANNClick
    end
    object chkElaboraDatiCONTANN: TCheckBox
      Left = 8
      Top = 8
      Width = 150
      Height = 17
      Caption = 'Calcola dati conto annuale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkElaboraDatiCONTANNClick
    end
    object chkElabRisorseResidue: TCheckBox
      Left = 8
      Top = 64
      Width = 168
      Height = 17
      Caption = 'Distribuzione risorse residue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = chkElaboraDatiCONTANNClick
    end
    object chkEsportazione: TCheckBox
      Left = 8
      Top = 86
      Width = 168
      Height = 17
      Caption = 'Esportazione su file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkElaboraDatiCONTANNClick
    end
    object btnImpostazioni: TBitBtn
      Left = 212
      Top = 85
      Width = 88
      Height = 19
      Caption = 'Impostazioni...'
      TabOrder = 8
      OnClick = btnImpostazioniClick
    end
  end
  object pnlElaborazioni: TPanel
    Left = 0
    Top = 491
    Width = 784
    Height = 32
    Align = alBottom
    TabOrder = 5
    ExplicitTop = 493
    object btnEsegui: TBitBtn
      Left = 187
      Top = 4
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
    object btnChiudi: TBitBtn
      Left = 497
      Top = 4
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 3
    end
    object btnAnomalie: TBitBtn
      Left = 393
      Top = 4
      Width = 100
      Height = 25
      Caption = '&Anomalie'
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
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
    object btnVisualizzaFile: TBitBtn
      Left = 290
      Top = 4
      Width = 100
      Height = 25
      Caption = '&Visualizza file'
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
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 784
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 784
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 784
      Height = 24
      ExplicitWidth = 784
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
  object pnlTabelle: TPanel
    Left = 65
    Top = 164
    Width = 719
    Height = 327
    Align = alClient
    TabOrder = 4
    ExplicitHeight = 329
    object clbTabElab: TCheckListBox
      Left = 1
      Top = 1
      Width = 717
      Height = 325
      Align = alClient
      ItemHeight = 13
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnClick = clbTabElabClick
      ExplicitHeight = 327
    end
  end
  object pnlEtichettaTab: TPanel
    Left = 0
    Top = 164
    Width = 65
    Height = 327
    Align = alLeft
    TabOrder = 3
    ExplicitHeight = 329
    object lblTabelle: TLabel
      Left = 6
      Top = 6
      Width = 53
      Height = 26
      Caption = 'Tabelle da elaborare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object pnlBar: TPanel
    Left = 0
    Top = 523
    Width = 784
    Height = 37
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 525
    object StatusBar: TStatusBar
      Left = 1
      Top = 1
      Width = 782
      Height = 19
      Panels = <
        item
          Width = 200
        end
        item
          Width = 50
        end>
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 20
      Width = 782
      Height = 16
      Align = alBottom
      TabOrder = 1
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 208
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
  end
end
