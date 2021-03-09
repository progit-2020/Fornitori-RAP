object A049FDialogStampa: TA049FDialogStampa
  Left = 321
  Top = 176
  HelpContext = 49000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A049> Cartolina accessi mensa'
  ClientHeight = 300
  ClientWidth = 415
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
  object Label2: TLabel
    Left = 233
    Top = 95
    Width = 85
    Height = 13
    Caption = 'Raggruppamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 7
    Top = 232
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
    TabOrder = 7
    OnClick = BtnPrinterSetUpClick
  end
  object BtnStampa: TBitBtn
    Left = 114
    Top = 232
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
    TabOrder = 8
    OnClick = BtnStampaClick
  end
  object BtnClose: TBitBtn
    Left = 328
    Top = 232
    Width = 80
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 10
  end
  object CkBAggiorna: TCheckBox
    Left = 233
    Top = 67
    Width = 180
    Height = 17
    Caption = 'Aggiornamento del riepilogo'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 7
    Top = 64
    Width = 222
    Height = 158
    TabOrder = 2
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 36
      Height = 13
      Caption = 'Orologi:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LBTerm: TCheckListBox
      Left = 5
      Top = 18
      Width = 212
      Height = 115
      ItemHeight = 13
      TabOrder = 0
    end
    object CkBSelectAll: TCheckBox
      Left = 6
      Top = 135
      Width = 113
      Height = 17
      Caption = 'Seleziona tutto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CkBSelectAllClick
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 265
    Width = 415
    Height = 16
    Align = alBottom
    TabOrder = 11
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 281
    Width = 415
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object dcmbRaggruppamento: TDBLookupComboBox
    Left = 233
    Top = 111
    Width = 175
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A049FStampaPastiMW.dsr010
    TabOrder = 4
    OnCloseUp = dcmbRaggruppamentoCloseUp
    OnKeyDown = dcmbRaggruppamentoKeyDown
    OnKeyUp = dcmbRaggruppamentoKeyUp
  end
  object chkSaltoPagina: TCheckBox
    Left = 233
    Top = 142
    Width = 154
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
  object chkDettaglio: TCheckBox
    Left = 233
    Top = 166
    Width = 154
    Height = 17
    Caption = 'Dettaglio individuale'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 415
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 415
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 415
      Height = 24
      ExplicitWidth = 415
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
    Left = 221
    Top = 232
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
    TabOrder = 9
    OnClick = btnAnomalieClick
  end
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 24
    Width = 415
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
    TabOrder = 1
    ExplicitTop = 24
    ExplicitWidth = 415
    inherited lblInizio: TLabel
      Left = 12
      ExplicitLeft = 12
    end
    inherited lblFine: TLabel
      Left = 141
      ExplicitLeft = 141
    end
    inherited edtInizio: TMaskEdit
      Left = 35
      ExplicitLeft = 35
    end
    inherited edtFine: TMaskEdit
      Left = 158
      ExplicitLeft = 158
    end
    inherited btnDataInizio: TBitBtn
      Left = 106
      ExplicitLeft = 106
    end
    inherited btnDataFine: TBitBtn
      Left = 229
      ExplicitLeft = 229
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 32
  end
end
