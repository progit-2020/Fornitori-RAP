object A027FCarMen: TA027FCarMen
  Left = 302
  Top = 167
  HelpContext = 27000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  Caption = '<A027> Cartellino mensile'
  ClientHeight = 413
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
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
  object BitBtn1: TBitBtn
    Left = 272
    Top = 210
    Width = 145
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
    TabOrder = 11
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 272
    Top = 144
    Width = 145
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
    TabOrder = 9
    OnClick = BitBtn2Click
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 394
    Width = 427
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '1 Record'
  end
  object BitBtn3: TBitBtn
    Left = 272
    Top = 177
    Width = 145
    Height = 25
    Caption = '&Anteprima'
    Default = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    TabOrder = 10
    OnClick = BitBtn1Click
  end
  object BitBtn5: TBitBtn
    Left = 272
    Top = 279
    Width = 145
    Height = 25
    Caption = '&File di testo'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
    TabOrder = 13
    OnClick = BitBtn1Click
  end
  object BitBtn4: TBitBtn
    Left = 272
    Top = 244
    Width = 145
    Height = 25
    Caption = '&Solo aggiornamento'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
    TabOrder = 12
    OnClick = BitBtn4Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 378
    Width = 427
    Height = 16
    Align = alBottom
    TabOrder = 16
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 427
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 427
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 427
      Height = 24
      ExplicitWidth = 427
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = TfrmSelAnagrafe1btnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = TfrmSelAnagrafe1R003DatianagraficiClick
      end
    end
  end
  object chkNumPagina: TCheckBox
    Left = 8
    Top = 130
    Width = 116
    Height = 17
    Caption = 'Numera pagine da'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = chkNumPaginaClick
  end
  object edtNumPagina: TSpinEdit
    Left = 128
    Top = 128
    Width = 61
    Height = 22
    MaxValue = 999999
    MinValue = 1
    TabOrder = 5
    Value = 1
  end
  object btnStampaAscii: TBitBtn
    Left = 272
    Top = 313
    Width = 145
    Height = 25
    Caption = 'Stampa in modalit'#224' testo'
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
    TabOrder = 14
    OnClick = btnStampaAsciiClick
  end
  object chkAutoGiustificazione: TCheckBox
    Left = 8
    Top = 71
    Width = 157
    Height = 17
    Caption = 'Elabora auto-giustificazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnAnomalie: TBitBtn
    Left = 272
    Top = 345
    Width = 145
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
    TabOrder = 15
    OnClick = btnAnomalieClick
  end
  object chkIgnoraAnomalieStampa: TCheckBox
    Left = 8
    Top = 109
    Width = 225
    Height = 17
    Caption = 'Ignora le anomalie su anteprima/stampa'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 3
  end
  object pnlParametrizzazioneStampa: TGroupBox
    Left = 8
    Top = 174
    Width = 252
    Height = 95
    Caption = 'Parametrizzazione di stampa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object DBText1: TDBText
      Left = 9
      Top = 56
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 16
      Width = 88
      Height = 13
      Caption = 'Parametrizzazione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object NomeStampa: TDBLookupComboBox
      Left = 9
      Top = 31
      Width = 89
      Height = 21
      DropDownWidth = 400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = R400FCartellinoDtM.D950
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnKeyDown = NomeStampaKeyDown
    end
    object chkParametrizzazioniTipoCartellino: TCheckBox
      Left = 9
      Top = 73
      Width = 220
      Height = 17
      Caption = 'Utilizza parametrizzazioni del tipo cartellino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlAggiornamento: TGroupBox
    Left = 8
    Top = 271
    Width = 252
    Height = 99
    Caption = 'Opzioni di aggiornamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object chkIgnoraAnomalie: TCheckBox
      Left = 9
      Top = 37
      Width = 194
      Height = 17
      Caption = 'Ignora le anomalie su aggiornamento'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = CAggiornamentoClick
    end
    object CAggiornamento: TCheckBox
      Left = 9
      Top = 17
      Width = 225
      Height = 17
      Caption = 'Aggiornamento scheda riepilogativa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = CAggiornamentoClick
    end
    object chkBuoniPasto: TCheckBox
      Left = 9
      Top = 56
      Width = 232
      Height = 17
      Caption = 'Aggiornamento cartolina Buoni pasto/Ticket'
      TabOrder = 2
      OnClick = CAggiornamentoClick
    end
    object chkAccessiMensa: TCheckBox
      Left = 9
      Top = 76
      Width = 219
      Height = 17
      Caption = 'Aggiornamento cartolina Accessi Mensa'
      TabOrder = 3
      OnClick = CAggiornamentoClick
    end
  end
  object chkPaginaParita: TCheckBox
    Left = 8
    Top = 151
    Width = 99
    Height = 17
    Caption = 'Pagina di parit'#224
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object chkAbbattimentoBancaOre: TCheckBox
    Left = 8
    Top = 89
    Width = 180
    Height = 17
    Caption = 'Elabora abbattimento banca ore'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnBloccoRiepiloghi: TBitBtn
    Left = 272
    Top = 67
    Width = 145
    Height = 25
    Caption = 'B&locco riepiloghi'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
      FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
      00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
      BFBFBFBFBFBF000000FFFFFF0000FFFFFFFF0000FFFFFFFF0000007F7F7F7F7F
      7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
      0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
      7F7F7FFFFFFF0000000000000000FF00007F00007F000000000000FFFFFF7F7F
      7F7F7F7F000000FFFFFF000000BFBFBF0000000000FF0000000000FF00007F00
      00FF00007F00007F0000000000FF0000007F7F7F000000FFFFFF000000FFFFFF
      000000FFFFFF0000000000FF0000FF0000FF0000FF00007F000000FFFFFF0000
      007F7F7F000000FFFFFF000000FFFFFF0000000000FF000000FFFFFF0000FF00
      00FF00007F0000FF0000000000FF000000BFBFBF000000FFFFFF000000FFFFFF
      7F7F7FFFFFFF000000000000FFFFFFFFFFFF0000FF000000000000FFFFFF7F7F
      7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
      0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFBFBFBF000000FFFFFF0000FFFFFFFF0000FFFFFFFF000000BFBFBFBFBF
      BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
      00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 18
    OnClick = btnBloccoRiepiloghiClick
  end
  object btnStraoAutorizzati: TBitBtn
    Left = 272
    Top = 100
    Width = 145
    Height = 25
    Caption = 'Straordinari autorizzati'
    TabOrder = 19
    OnClick = btnStraoAutorizzatiClick
  end
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 24
    Width = 427
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
    TabOrder = 20
    ExplicitTop = 24
    ExplicitWidth = 427
    inherited edtInizio: TMaskEdit
      OnExit = frmInputPeriodoedtInizioExit
    end
    inherited edtFine: TMaskEdit
      OnExit = frmInputPeriodoedtFineExit
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 292
    Top = 2
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Cartel.Txt'
    Filter = 'File di Testo (*.txt)|*.txt|Tutti i files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 320
    Top = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 2
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
