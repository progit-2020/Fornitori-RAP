object A137FCalcoloSpeseAccesso: TA137FCalcoloSpeseAccesso
  Left = 188
  Top = 183
  HelpContext = 137000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A137> Calcolo spese di accesso'
  ClientHeight = 279
  ClientWidth = 497
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
  object lblMeseComp: TLabel
    Left = 37
    Top = 38
    Width = 87
    Height = 13
    Caption = 'Mese competenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object sbtMeseComp: TSpeedButton
    Left = 209
    Top = 34
    Width = 14
    Height = 21
    Caption = '...'
    NumGlyphs = 2
    OnClick = sbtMeseCompClick
  end
  object lblTipoTrasferta: TLabel
    Left = 37
    Top = 73
    Width = 84
    Height = 13
    Caption = 'Tipologia trasferta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblPresenzeEscluse: TLabel
    Left = 37
    Top = 106
    Width = 152
    Height = 13
    Caption = 'Causali da escludere dal calcolo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 37
    Top = 208
    Width = 79
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
    TabOrder = 6
    OnClick = BtnPrinterSetUpClick
  end
  object BtnStampa: TBitBtn
    Left = 209
    Top = 208
    Width = 78
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
    Left = 381
    Top = 208
    Width = 79
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 10
  end
  object cbxAggiorna: TCheckBox
    Left = 37
    Top = 158
    Width = 202
    Height = 17
    Caption = 'Aggiornamento del riepilogo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 244
    Width = 497
    Height = 16
    Align = alBottom
    TabOrder = 11
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 260
    Width = 497
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
    Width = 497
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 497
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 497
      Height = 24
      ExplicitWidth = 497
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object btnAnomalie: TBitBtn
    Left = 295
    Top = 208
    Width = 79
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
  object BtnAnteprima: TBitBtn
    Left = 123
    Top = 208
    Width = 79
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
    TabOrder = 7
    OnClick = BtnStampaClick
  end
  object edtMeseComp: TMaskEdit
    Left = 154
    Top = 34
    Width = 55
    Height = 21
    EditMask = '!00/0000;1;_'
    MaxLength = 7
    TabOrder = 1
    Text = '  /    '
  end
  object dcbxTipoTrasferta: TDBLookupComboBox
    Left = 133
    Top = 69
    Width = 90
    Height = 21
    DropDownWidth = 250
    KeyField = 'TIPO_MISSIONE'
    ListField = 'TIPO_MISSIONE;DESCRIZIONE'
    TabOrder = 2
    OnKeyDown = dcbxTipoTrasfertaKeyDown
  end
  object edtPresenzeEscluse: TEdit
    Left = 37
    Top = 120
    Width = 401
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object btnPresenzeEscluse: TButton
    Left = 444
    Top = 118
    Width = 16
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = btnPresenzeEscluseClick
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 433
    Top = 4
  end
end
