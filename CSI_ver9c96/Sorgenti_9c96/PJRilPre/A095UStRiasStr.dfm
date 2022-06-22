object A095FStRiasStr: TA095FStRiasStr
  Tag = 527
  Left = 96
  Top = 189
  HelpContext = 95000
  BorderIcons = [biSystemMenu]
  Caption = '<A095> Liquidazione automatica straordinario'
  ClientHeight = 361
  ClientWidth = 524
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 342
    Width = 524
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 326
    Width = 524
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 524
    Height = 148
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object BtnPrinterSetUp: TBitBtn
      Left = 5
      Top = 120
      Width = 125
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00770000000000
        0777707777777770707700000000000007070778777BBB870007077887788887
        0707000000000000077007788887788070707000000000070700770777777770
        7070777077777776EEE078000000000E600870E6EEEEEEEE077778000000000E
        6008777707777786EEE077777000000800087777777777777777}
      TabOrder = 10
      OnClick = BtnPrinterSetUpClick
    end
    object BtnStampa: TBitBtn
      Left = 133
      Top = 92
      Width = 125
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
      TabOrder = 7
      OnClick = BtnStampaClick
    end
    object BtnClose: TBitBtn
      Left = 392
      Top = 120
      Width = 125
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 12
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 4
      Width = 201
      Height = 48
      Caption = 'Mese da riepilogare:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 23
        Width = 34
        Height = 13
        Caption = 'Anno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 105
        Top = 23
        Width = 35
        Height = 13
        Caption = 'Mese:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SEAnno: TSpinEdit
        Left = 50
        Top = 20
        Width = 49
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
      object SEMese: TSpinEdit
        Left = 146
        Top = 20
        Width = 41
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        MaxValue = 12
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
      end
    end
    object CheckBox1: TCheckBox
      Left = 219
      Top = 31
      Width = 134
      Height = 17
      Caption = 'Salto pagina '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object BtnPreView: TBitBtn
      Left = 5
      Top = 92
      Width = 125
      Height = 25
      Caption = 'Anteprima'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777700000000000077000FFFFFFFFFF070000FFFFFFF000080070FFFFFF08778
        08770FFFFF0877E880770FFFFF07777870770FFFFF07E77870770FFFFF08EE78
        80770FFFFFF0877807770FFFFFFF000077770FFFFFFFFFF077770FFFFFFF0000
        77770FFFFFFF070777770FFFFFFF007777770000000007777777}
      TabOrder = 6
      OnClick = BtnStampaClick
    end
    object CheckBox2: TCheckBox
      Left = 219
      Top = 51
      Width = 149
      Height = 17
      Caption = 'Totali per raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object CheckBox3: TCheckBox
      Left = 219
      Top = 71
      Width = 149
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
    object chkLiquidazione: TCheckBox
      Left = 219
      Top = 11
      Width = 141
      Height = 17
      Caption = 'Effettua liquidazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = chkLiquidazioneClick
    end
    object BitBtn1: TBitBtn
      Left = 261
      Top = 92
      Width = 125
      Height = 25
      Caption = '&Solo liquidazione'
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
      TabOrder = 8
      OnClick = BtnStampaClick
    end
    object rgpDisponibilita: TRadioGroup
      Left = 5
      Top = 54
      Width = 201
      Height = 35
      Caption = 'Disponibilit'#224' liquidabile'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Mensile'
        'Annuale')
      ParentFont = False
      TabOrder = 1
    end
    object btnAnomalie: TBitBtn
      Left = 197
      Top = 120
      Width = 125
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
      TabOrder = 11
      OnClick = btnAnomalieClick
    end
    object btnAnnullaLiq: TBitBtn
      Left = 392
      Top = 92
      Width = 125
      Height = 25
      Caption = '&Annulla liquidazione'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF000084FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF0000840000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        00FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000840000FF000084000084FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000840000FF000084FFFFFFFFFFFFFFFFFFFFFFFF0000840000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 9
      OnClick = btnAnnullaLiqClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 172
    Width = 524
    Height = 154
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object GroupBox2: TGroupBox
      Left = 265
      Top = 0
      Width = 259
      Height = 154
      Align = alClient
      Caption = 'Dettaglio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Dettaglio: TCheckListBox
        Left = 2
        Top = 15
        Width = 255
        Height = 137
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnMouseDown = DettaglioMouseDown
        OnMouseUp = DettaglioMouseUp
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 265
      Height = 154
      Align = alLeft
      Caption = 'Intestazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Intestazione: TCheckListBox
        Left = 2
        Top = 15
        Width = 261
        Height = 137
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnMouseDown = IntestazioneMouseDown
        OnMouseUp = IntestazioneMouseUp
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 524
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 524
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 524
      Height = 24
      ExplicitWidth = 524
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
    Left = 416
    Top = 4
  end
end
