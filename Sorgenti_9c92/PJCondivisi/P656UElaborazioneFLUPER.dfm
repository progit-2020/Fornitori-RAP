object P656FElaborazioneFLUPER: TP656FElaborazioneFLUPER
  Left = 272
  Top = 169
  HelpContext = 3656000
  Caption = '<P656> Elaborazione fornitura FLUPER'
  ClientHeight = 371
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel0: TPanel
    Left = 0
    Top = 24
    Width = 562
    Height = 49
    Align = alTop
    TabOrder = 0
    object lblMeseElaborazione: TLabel
      Left = 18
      Top = 19
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
      Left = 120
      Top = 15
      Width = 13
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseDaClick
    end
    object Label1: TLabel
      Left = 160
      Top = 19
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
      Left = 254
      Top = 15
      Width = 14
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseAClick
    end
    object edtMeseDa: TMaskEdit
      Left = 63
      Top = 15
      Width = 56
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
    end
    object edtMeseA: TMaskEdit
      Left = 199
      Top = 15
      Width = 56
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      OnDblClick = edtMeseADblClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 73
    Width = 562
    Height = 224
    Align = alTop
    TabOrder = 1
    object lblNomeFileOutput: TLabel
      Left = 231
      Top = 134
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
      Left = 532
      Top = 147
      Width = 15
      Height = 21
      Caption = '...'
      OnClick = sbtNomeFileOutputClick
    end
    object lblDataChiusura: TLabel
      Left = 231
      Top = 112
      Width = 66
      Height = 13
      Caption = 'Data chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataChiusura: TSpeedButton
      Left = 373
      Top = 108
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
    object btnDisattivaElaborazioni: TBitBtn
      Left = 400
      Top = 187
      Width = 147
      Height = 25
      Caption = 'Te&rmina elaborazione'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777FFFFFFFFFFFFFF777777777777777F77999FFFFFFFF9997799999FFFF99
        999778999999999999F7780F99999999F7F7780FF999999FF7F7780999999999
        97F77999999FF999999779999FFFFFF99997799FFFFFFFFFF997780FFFFFFFFF
        F7F7780000000000F7F778888888888887F77777777777777777}
      TabOrder = 5
      OnClick = btnDisattivaElaborazioniClick
    end
    object chkEsportazioneFile: TCheckBox
      Left = 17
      Top = 146
      Width = 112
      Height = 17
      Caption = 'Esportazione su file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object chkElaboraDatiFLUSSOA: TCheckBox
      Left = 17
      Top = 10
      Width = 150
      Height = 17
      Caption = 'Calcola dati Flusso A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object edtNomeFileOutput: TEdit
      Left = 231
      Top = 147
      Width = 302
      Height = 21
      TabOrder = 4
    end
    object edtDataChiusura: TMaskEdit
      Left = 302
      Top = 108
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
      TabOrder = 2
      Text = '  /  /    '
    end
    object rgpStatoCedolini: TRadioGroup
      Left = 231
      Top = 1
      Width = 287
      Height = 34
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
    object chkChiusura: TCheckBox
      Left = 17
      Top = 108
      Width = 77
      Height = 17
      Caption = 'Chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object chkAnnullaFLUPER: TCheckBox
      Left = 17
      Top = 70
      Width = 150
      Height = 17
      Caption = 'Annulla dati FLUPER'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object chkElaboraDatiFLUSSOB1_36: TCheckBox
      Left = 17
      Top = 26
      Width = 212
      Height = 17
      Caption = 'Calcola dati Flusso B (fino al campo 36)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object chkElaboraDatiFLUSSOB37: TCheckBox
      Left = 17
      Top = 42
      Width = 200
      Height = 17
      Caption = 'Calcola dati Flusso B (dal campo 37)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = chkElaboraDatiFLUSSOAClick
    end
    object RbtA: TRadioButton
      Left = 128
      Top = 138
      Width = 61
      Height = 17
      Caption = 'Flusso A'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      TabStop = True
      OnClick = RbtAClick
    end
    object RbtB: TRadioButton
      Left = 128
      Top = 155
      Width = 61
      Height = 17
      Caption = 'Flusso B'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = RbtBClick
    end
  end
  object pnlElaborazioni: TPanel
    Left = 0
    Top = 297
    Width = 562
    Height = 39
    Align = alTop
    TabOrder = 2
    object btnEsegui: TBitBtn
      Left = 17
      Top = 7
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
      Left = 447
      Top = 7
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
    object btnAnomalie: TBitBtn
      Left = 302
      Top = 7
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
      Left = 161
      Top = 7
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
    Width = 562
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 562
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 562
      Height = 24
      ExplicitWidth = 562
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnEreditaSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnEreditaSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object pnlBar: TPanel
    Left = 0
    Top = 333
    Width = 562
    Height = 38
    Align = alBottom
    Caption = 'pnlBar'
    TabOrder = 4
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 2
      Width = 560
      Height = 16
      Align = alBottom
      TabOrder = 0
    end
    object StatusBar: TStatusBar
      Left = 1
      Top = 18
      Width = 560
      Height = 19
      Panels = <
        item
          Width = 50
        end>
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 4
  end
end
