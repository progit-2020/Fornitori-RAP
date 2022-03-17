object A116FLiquidazioneOreAnniPrec: TA116FLiquidazioneOreAnniPrec
  Tag = 527
  Left = 216
  Top = 128
  HelpContext = 116000
  BorderIcons = [biSystemMenu]
  Caption = '<A116> Liquidazione ore anni precedenti'
  ClientHeight = 406
  ClientWidth = 592
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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 387
    Width = 592
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 371
    Width = 592
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  object pnlPrincipale: TPanel
    Left = 0
    Top = 24
    Width = 592
    Height = 212
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 17
      Top = 12
      Width = 178
      Height = 13
      Caption = 'Anno del quale valutare le ore residue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMeseLiquidazione: TLabel
      Left = 17
      Top = 38
      Width = 156
      Height = 13
      Caption = 'Mese calcolo ore non recuperate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataLiquidazione: TSpeedButton
      Left = 266
      Top = 34
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtDataLiquidazioneClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 479
      Top = 4
      Width = 110
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = BtnPrinterSetUpClick
    end
    object BtnStampa: TBitBtn
      Left = 479
      Top = 65
      Width = 110
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
      Left = 479
      Top = 187
      Width = 110
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 10
    end
    object chkSaltoPag: TCheckBox
      Left = 315
      Top = 32
      Width = 142
      Height = 17
      Caption = 'Salto pagina '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object BtnPreView: TBitBtn
      Left = 479
      Top = 34
      Width = 110
      Height = 25
      Caption = 'Anteprima'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        033333777777777773333330777777703333333773F333773333333330888033
        33333FFFF7FFF7FFFFFF0000000000000003777777777777777F0FFFFFFFFFF9
        FF037F3333333337337F0F78888888887F037F33FFFFFFFFF37F0F7000000000
        8F037F3777777777F37F0F70AAAAAAA08F037F37F3333337F37F0F70ADDDDDA0
        8F037F37F3333337F37F0F70A99A99A08F037F37F3333337F37F0F70A99A99A0
        8F037F37F3333337F37F0F70AAAAAAA08F037F37FFFFFFF7F37F0F7000000000
        8F037F3777777777337F0F77777777777F037F3333333333337F0FFFFFFFFFFF
        FF037FFFFFFFFFFFFF7F00000000000000037777777777777773}
      NumGlyphs = 2
      TabOrder = 7
      OnClick = BtnStampaClick
    end
    object chkTotaliRaggr: TCheckBox
      Left = 315
      Top = 57
      Width = 142
      Height = 17
      Caption = 'Totali per raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chkTotaliGen: TCheckBox
      Left = 315
      Top = 83
      Width = 142
      Height = 17
      Caption = 'Totali generali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object btnEffettuaLiq: TBitBtn
      Left = 479
      Top = 95
      Width = 110
      Height = 25
      Caption = '&Solo registrazione'
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
      TabOrder = 9
      OnClick = BtnStampaClick
    end
    object edtAnno: TSpinEdit
      Left = 219
      Top = 7
      Width = 62
      Height = 22
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      MaxValue = 3000
      MinValue = 1900
      ParentFont = False
      TabOrder = 0
      Value = 1900
    end
    object gpbParametriLiquidazione: TGroupBox
      Left = 6
      Top = 58
      Width = 299
      Height = 66
      Caption = 'Parametri di liquidazione/abbattimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lblArrotondamento: TLabel
        Left = 165
        Top = 20
        Width = 75
        Height = 13
        Caption = 'Arrotondamento'
      end
      object lblLimiteOreLiquidabili: TLabel
        Left = 12
        Top = 21
        Width = 90
        Height = 13
        Caption = 'Limite ore liquidabili'
      end
      object edtArrotLiq: TMaskEdit
        Left = 247
        Top = 16
        Width = 26
        Height = 21
        EditMask = '!999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Text = '   '
      end
      object edtMaxLiq: TMaskEdit
        Left = 108
        Top = 17
        Width = 45
        Height = 21
        EditMask = '!999:99;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        Text = ':  .  '
        OnExit = edtMaxLiqExit
      end
      object chkAbbattimentoOre: TCheckBox
        Left = 12
        Top = 44
        Width = 261
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Abbattimento ore residue superiori al limite'
        TabOrder = 2
      end
    end
    object edtData: TMaskEdit
      Left = 219
      Top = 34
      Width = 48
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
    end
    object chkCessati: TCheckBox
      Left = 315
      Top = 108
      Width = 150
      Height = 17
      Caption = 'Considera cessati nell'#39'anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object btnCancella: TBitBtn
      Left = 479
      Top = 126
      Width = 110
      Height = 25
      Caption = '&Cancellazione'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF00000000
        0FFFFFFF0F8888880FFFFFFF0F0707080FFFFFFF0F0708080FFFFFFF0F070708
        0FFFFFFF0F0708080FFFFFFF0F0707080FFFFF0F0F0708080F0FFFF00F070708
        00FFFFFF0F0708080FFFFFFF080808080FFFFFF00000000000FFFFF0F7778888
        80FFFFF00000000000FFFFFFFF08880FFFFFFFFFFF00000FFFFF}
      TabOrder = 12
      OnClick = btnCancellaClick
    end
    object btnAnomalie: TBitBtn
      Left = 479
      Top = 156
      Width = 110
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
      TabOrder = 13
      OnClick = btnAnomalieClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 236
    Width = 592
    Height = 135
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object GroupBox2: TGroupBox
      Left = 297
      Top = 0
      Width = 295
      Height = 135
      Align = alClient
      Caption = 'Dettaglio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object clbDettaglio: TCheckListBox
        Left = 2
        Top = 15
        Width = 291
        Height = 118
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnMouseDown = clbDettaglioMouseDown
        OnMouseUp = clbDettaglioMouseUp
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 297
      Height = 135
      Align = alLeft
      Caption = 'Intestazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object clbIntestazione: TCheckListBox
        Left = 2
        Top = 15
        Width = 293
        Height = 118
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnMouseDown = clbIntestazioneMouseDown
        OnMouseUp = clbIntestazioneMouseUp
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 592
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 592
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 592
      Height = 24
      ExplicitWidth = 592
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
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 65535
  end
end
