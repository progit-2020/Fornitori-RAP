object S715FDialogStampa: TS715FDialogStampa
  Left = 321
  Top = 176
  HelpContext = 2715000
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = '<S715> Elaborazione schede di valutazione'
  ClientHeight = 548
  ClientWidth = 439
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
    Top = 513
    Width = 439
    Height = 16
    Align = alBottom
    TabOrder = 3
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 529
    Width = 439
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 439
    Height = 24
    Align = alTop
    TabOrder = 5
    TabStop = True
    ExplicitWidth = 439
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 439
      Height = 24
      ExplicitWidth = 439
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 439
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BtnPrinterSetUp: TBitBtn
      Left = 16
      Top = 9
      Width = 95
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = BtnPrinterSetUpClick
    end
    object btnAnomalie: TBitBtn
      Left = 220
      Top = 9
      Width = 95
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
    object BtnClose: TBitBtn
      Left = 323
      Top = 9
      Width = 95
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
    object btnEsegui: TBitBtn
      Left = 118
      Top = 9
      Width = 95
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
      TabOrder = 1
      OnClick = btnEseguiClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 439
    Height = 217
    Align = alTop
    TabOrder = 0
    object lblDataDa: TLabel
      Left = 24
      Top = 2
      Width = 48
      Height = 13
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataA: TLabel
      Left = 161
      Top = 2
      Width = 41
      Height = 13
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgpTipoValutazione: TRadioGroup
      Left = 16
      Top = 44
      Width = 129
      Height = 61
      Caption = 'Tipo valutazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Valutazione'
        'Autovalutazione'
        'Tutto')
      ParentFont = False
      TabOrder = 4
      OnClick = chkStampaClick
    end
    object edtDataDa: TMaskEdit
      Left = 24
      Top = 15
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnDblClick = edtDataDaDblClick
      OnExit = edtDataDaExit
    end
    object edtDataA: TMaskEdit
      Left = 161
      Top = 15
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnDblClick = edtDataADblClick
      OnExit = edtDataAExit
    end
    object rgpStatoAvanzamento: TRadioGroup
      Left = 16
      Top = 109
      Width = 129
      Height = 35
      Caption = 'Stato avanzamento'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Attuale'
        'Elenco')
      ParentFont = False
      TabOrder = 6
      OnClick = chkStampaClick
    end
    object btnStatoAvanzamento: TButton
      Left = 403
      Top = 121
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 8
      OnClick = btnStatoAvanzamentoClick
    end
    object edtStatoAvanzamento: TEdit
      Left = 153
      Top = 121
      Width = 250
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object btnDataDa: TButton
      Left = 95
      Top = 15
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnDataDaClick
    end
    object btnDataA: TButton
      Left = 233
      Top = 15
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = btnDataAClick
    end
    object rgpTipoChiusura: TRadioGroup
      Left = 154
      Top = 44
      Width = 264
      Height = 61
      Caption = 'Tipo chiusura'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 3
      Items.Strings = (
        'Scheda provvisoria'
        'Scheda bloccata'
        'Scheda definitiva'
        'Tutto')
      ParentFont = False
      TabOrder = 5
      OnClick = chkStampaClick
    end
    object rgpPresaVisione: TRadioGroup
      Left = 153
      Top = 150
      Width = 129
      Height = 61
      Caption = 'Presa visione valutato'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 3
      Items.Strings = (
        'Si'
        'No'
        'Manca'
        'Tutto')
      ParentFont = False
      TabOrder = 10
      OnClick = chkStampaClick
    end
    object rgpSchedeProtocollo: TRadioGroup
      Left = 289
      Top = 150
      Width = 129
      Height = 61
      Caption = 'Schede protocollate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Si'
        'No'
        'Tutto')
      ParentFont = False
      TabOrder = 11
      OnClick = chkStampaClick
    end
    object rgpDipValutabile: TRadioGroup
      Left = 16
      Top = 150
      Width = 129
      Height = 61
      Caption = 'Dipendente valutabile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Si'
        'No'
        'Tutto')
      ParentFont = False
      TabOrder = 9
      OnClick = chkStampaClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 241
    Width = 439
    Height = 231
    Align = alClient
    TabOrder = 1
    object chkChiudiScheda: TCheckBox
      Left = 24
      Top = 73
      Width = 122
      Height = 17
      Caption = 'Chiudi scheda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkStampaClick
    end
    object chkRiapriScheda: TCheckBox
      Left = 24
      Top = 96
      Width = 122
      Height = 17
      Caption = 'Riapri scheda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkStampaClick
    end
    object chkLegendaPunteggi: TCheckBox
      Left = 161
      Top = 165
      Width = 142
      Height = 17
      Caption = 'Includi legenda punteggi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = chkStampaClick
    end
    object chkAggiornaIncentivi: TCheckBox
      Left = 24
      Top = 142
      Width = 122
      Height = 17
      Caption = 'Aggiorna incentivi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chkStampaClick
    end
    object btnTipologieQuote: TButton
      Left = 161
      Top = 142
      Width = 86
      Height = 17
      Caption = 'Tipologie quote'
      TabOrder = 9
      OnClick = btnTipologieQuoteClick
    end
    object chkStampa: TCheckBox
      Left = 24
      Top = 165
      Width = 122
      Height = 17
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = chkStampaClick
    end
    object chkAvanzaStato: TCheckBox
      Left = 24
      Top = 50
      Width = 122
      Height = 17
      Caption = 'Avanza stato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkStampaClick
    end
    object chkRetrocediStato: TCheckBox
      Left = 24
      Top = 119
      Width = 122
      Height = 17
      Caption = 'Retrocedi stato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkStampaClick
    end
    object chkAggiornaPunteggi: TCheckBox
      Left = 24
      Top = 27
      Width = 122
      Height = 17
      Caption = 'Aggiorna punteggi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkStampaClick
    end
    object chkAssegnaValutatore: TCheckBox
      Left = 161
      Top = 27
      Width = 162
      Height = 17
      Caption = 'Assegna vecchio valutatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chkPresaVisione: TCheckBox
      Left = 161
      Top = 187
      Width = 117
      Height = 17
      Caption = 'Elenca prese visioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = chkStampaClick
    end
    object chkSostituisciRegola: TCheckBox
      Left = 161
      Top = 4
      Width = 99
      Height = 17
      Caption = 'Sostituisci regola'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkControllaRegola: TCheckBox
      Left = 24
      Top = 4
      Width = 122
      Height = 17
      Caption = 'Controlla regola'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkStampaClick
    end
    object chkFilePDF: TCheckBox
      Left = 24
      Top = 187
      Width = 122
      Height = 17
      Caption = 'Archivio PDF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = chkStampaClick
    end
    object chkProtocolla: TCheckBox
      Left = 24
      Top = 210
      Width = 122
      Height = 17
      Caption = 'Protocolla'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = chkStampaClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 324
  end
end
