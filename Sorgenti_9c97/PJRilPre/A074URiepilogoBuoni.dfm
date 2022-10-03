object A074FRiepilogoBuoni: TA074FRiepilogoBuoni
  Left = 382
  Top = 143
  HelpContext = 74000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A074> Cartolina buoni pasto/ticket'
  ClientHeight = 389
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 9
    Top = 275
    Width = 180
    Height = 13
    Caption = 'Campo anagrafico di raggruppamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 11
    Top = 322
    Width = 80
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
    TabOrder = 3
    OnClick = BtnPrinterSetUpClick
  end
  object BtnStampa: TBitBtn
    Left = 97
    Top = 322
    Width = 80
    Height = 25
    Caption = '&Stampa'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 4
    OnClick = BtnStampaClick
  end
  object BtnClose: TBitBtn
    Left = 275
    Top = 322
    Width = 80
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 6
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 354
    Width = 367
    Height = 16
    Align = alBottom
    TabOrder = 7
    ExplicitTop = 359
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 370
    Width = 367
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
    ExplicitTop = 375
  end
  object dcmbRaggrAnagrafico: TDBLookupComboBox
    Left = 8
    Top = 294
    Width = 206
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    TabOrder = 2
    OnKeyDown = dcmbRaggrAnagraficoKeyDown
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 367
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 367
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 367
      Height = 24
      ExplicitWidth = 367
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
  object PageControl1: TPageControl
    Left = 0
    Top = 24
    Width = 367
    Height = 251
    ActivePage = tabMaturazione
    Align = alTop
    MultiLine = True
    Style = tsButtons
    TabOrder = 1
    object tabMaturazione: TTabSheet
      Caption = 'Maturazione'
      object ChkAggiorna: TCheckBox
        Left = 5
        Top = 127
        Width = 184
        Height = 17
        Caption = 'Aggiornamento del riepilogo'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object ChkDettaglio: TCheckBox
        Left = 5
        Top = 49
        Width = 186
        Height = 17
        Caption = 'Stampa dettaglio giornaliero '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ChkSaltoPagina: TCheckBox
        Left = 5
        Top = 103
        Width = 102
        Height = 17
        Caption = 'Salto pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object ChkAcquisto: TCheckBox
        Left = 5
        Top = 67
        Width = 146
        Height = 17
        Caption = 'Acquisto buoni/ticket'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object ChkInizioAnno: TCheckBox
        Left = 5
        Top = 85
        Width = 146
        Height = 17
        Caption = 'Calcolo da inizio anno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ChkInizioAnnoClick
      end
      object chkIgnoraAnomalie: TCheckBox
        Left = 5
        Top = 148
        Width = 126
        Height = 14
        Caption = 'Ignora le anomalie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object chkSoloElaborazione: TCheckBox
        Left = 5
        Top = 167
        Width = 180
        Height = 14
        Caption = 'Solo elaborazione senza stampa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      inline frmInputPeriodo: TfrmInputPeriodo
        Left = 0
        Top = 0
        Width = 359
        Height = 40
        Align = alTop
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = -92
        ExplicitTop = 72
        inherited btnIndietro: TBitBtn
          Left = 306
          ExplicitLeft = 306
        end
        inherited btnAvanti: TBitBtn
          Left = 328
          ExplicitLeft = 328
        end
      end
    end
    object tabAcquisto: TTabSheet
      Caption = 'Acquisto'
      ImageIndex = 1
      object lblIntUltimoAcquisto: TLabel
        Left = 157
        Top = 4
        Width = 72
        Height = 13
        Caption = 'Ultimo acquisto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 5
        Top = 4
        Width = 69
        Height = 13
        Caption = 'Mese acquisto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnDataAcquisto: TBitBtn
        Left = 134
        Top = 19
        Width = 17
        Height = 22
        Caption = '...'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = BtnDataAcquistoClick
      end
      object chkAcqDatiIndividuali: TCheckBox
        Left = 5
        Top = 45
        Width = 186
        Height = 17
        Caption = 'Stampa dati individuali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object chkAcqSaltoPagina: TCheckBox
        Left = 5
        Top = 63
        Width = 102
        Height = 17
        Caption = 'Salto pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object chkAcqAggiornamento: TCheckBox
        Left = 5
        Top = 81
        Width = 184
        Height = 17
        Caption = 'Aggiornamento del riepilogo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object edtDataAcquisto: TEdit
        Left = 5
        Top = 20
        Width = 128
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object btnEliminaAcquisto: TBitBtn
        Left = 286
        Top = 19
        Width = 50
        Height = 22
        Caption = 'Elimina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnEliminaAcquistoClick
      end
      object edtUltimoAcquisto: TEdit
        Left = 157
        Top = 18
        Width = 128
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 5
        Top = 106
        Width = 352
        Height = 44
        TabOrder = 7
        object edtFileSequenziale: TEdit
          Left = 15
          Top = 15
          Width = 191
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object btnFileSequenziale: TButton
          Left = 206
          Top = 14
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 1
          OnClick = btnFileSequenzialeClick
        end
        object btnParametriGemeaz: TButton
          Left = 227
          Top = 14
          Width = 65
          Height = 22
          Caption = 'Parametri...'
          TabOrder = 2
          OnClick = btnParametriGemeazClick
        end
      end
      object chkFileSequenziale: TCheckBox
        Left = 12
        Top = 105
        Width = 131
        Height = 14
        Caption = 'Genera file sequenziale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = chkFileSequenzialeClick
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 157
        Width = 352
        Height = 59
        TabOrder = 9
        object lblParPaghe: TLabel
          Left = 12
          Top = 18
          Width = 85
          Height = 13
          Caption = 'Parametrizzazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBText1: TDBText
          Left = 197
          Top = 14
          Width = 149
          Height = 17
          DataField = 'd_codice'
          DataSource = A074FRiepilogoBuoniDtM1.dcdsT191
        end
        object DBText2: TDBText
          Left = 102
          Top = 39
          Width = 244
          Height = 17
          DataField = 'd_nomefile'
          DataSource = A074FRiepilogoBuoniDtM1.dcdsT191
        end
        object dcmbParametrizzazione: TDBLookupComboBox
          Left = 101
          Top = 14
          Width = 90
          Height = 21
          DataField = 'codice'
          DataSource = A074FRiepilogoBuoniDtM1.dcdsT191
          DropDownWidth = 250
          KeyField = 'CODICE'
          ListField = 'CODICE;DESCRIZIONE'
          NullValueKey = 46
          TabOrder = 0
        end
      end
      object chkScaricoPaghe: TCheckBox
        Left = 12
        Top = 154
        Width = 162
        Height = 17
        Caption = 'Genera file per acquisto ticket'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = chkScaricoPagheClick
      end
    end
  end
  object btnAnomalie: TBitBtn
    Left = 187
    Top = 322
    Width = 80
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
    TabOrder = 5
    OnClick = btnAnomalieClick
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'Txt'
    Filter = 'File testo (*.txt)|*.txt|Tutti i files (*.*)|*.*'
    Left = 272
    Top = 8
  end
end
