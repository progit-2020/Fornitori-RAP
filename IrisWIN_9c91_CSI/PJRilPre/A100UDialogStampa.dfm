object A100FDialogStampa: TA100FDialogStampa
  Left = 193
  Top = 102
  HelpContext = 42000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A100> Stampa presenti/assenti'
  ClientHeight = 375
  ClientWidth = 425
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 42
    Top = 216
    Width = 216
    Height = 13
    Caption = 'Campo anagrafico di raggruppamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 36
    Top = 304
    Width = 100
    Height = 25
    Caption = 'S&tampante'
    TabOrder = 0
    OnClick = BtnPrinterSetUpClick
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
  end
  object BtnStampa: TBitBtn
    Left = 158
    Top = 304
    Width = 100
    Height = 25
    Caption = '&Stampa'
    TabOrder = 1
    OnClick = BtnStampaClick
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
  end
  object BtnClose: TBitBtn
    Left = 281
    Top = 304
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    TabOrder = 2
    Kind = bkClose
  end
  object GroupBox1: TGroupBox
    Left = 215
    Top = 27
    Width = 198
    Height = 174
    Caption = 'Impostazioni'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object LblDaData: TLabel
      Left = 110
      Top = 23
      Width = 80
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblAData: TLabel
      Left = 110
      Top = 54
      Width = 80
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblDaOra: TLabel
      Left = 110
      Top = 86
      Width = 80
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblAOra: TLabel
      Left = 110
      Top = 117
      Width = 80
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnDaData: TBitBtn
      Left = 8
      Top = 17
      Width = 98
      Height = 25
      Caption = 'Dalla data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnDaDataClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
    end
    object BtnAData: TBitBtn
      Left = 8
      Top = 48
      Width = 98
      Height = 25
      Caption = '  Alla data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnADataClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
    end
    object BtnDaOra: TBitBtn
      Left = 8
      Top = 79
      Width = 98
      Height = 25
      Caption = 'Dall'#39' ora:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnDaOraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333700000733333333F777773FF3333333007F0F70
        0333333773373377FF3333300FFF7FFF003333773F3333377FF33300F0FFFFF0
        F00337737333F37377F33707FFFF0FFFF70737F33337F33337FF300FFFFF0FFF
        FF00773F3337F333377F30707FFF0FFF70707F733337F333737F300FFFF09FFF
        FF0077F33377F33337733707FF0F9FFFF70737FF3737F33F37F33300F0FF9FF0
        F003377F7337F373773333300FFF9FFF00333377FF37F3377FF33300007F9F70
        000337777FF7FF77773333703070007030733373777777737333333333330333
        333333333337FF33333333333330003333333333337773333333}
      NumGlyphs = 2
    end
    object BtnAOra: TBitBtn
      Left = 8
      Top = 110
      Width = 98
      Height = 25
      Caption = '  All'#39' ora:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BtnAOraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333700000733333333F777773FF3333333007F0F70
        0333333773373377FF3333300FFF7FFF003333773F3333377FF33300F0FFFFF0
        F00337737333F37377F33707FFFF0FFFF70737F33337F33337FF300FFFFF0FFF
        FF00773F3337F333377F30707FFF0FFF70707F733337F333737F300FFFF09FFF
        FF0077F33377F33337733707FF0F9FFFF70737FF3737F33F37F33300F0FF9FF0
        F003377F7337F373773333300FFF9FFF00333377FF37F3377FF33300007F9F70
        000337777FF7FF77773333703070007030733373777777737333333333330333
        333333333337FF33333333333330003333333333337773333333}
      NumGlyphs = 2
    end
    object BtnAvanzati: TBitBtn
      Left = 8
      Top = 142
      Width = 98
      Height = 25
      Caption = 'Avanzate...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BtnAvanzatiClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F808880FFFFF
        FFF07808000FFFF808F000880FFFFFF08000778008FFFFF80088800080FFFFFF
        088080F808FFFF00070800FFFFFFFF088707FFF000FFFF00070808F080F808FF
        08708000800080F800870088888008F08000088000880FF808F007088808000F
        FFF087070808880FFFFF07087808000FFFFF087000880FFFFFFF}
    end
  end
  object DBLookUpCampo: TDBLookupComboBox
    Left = 42
    Top = 234
    Width = 219
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A042FStampaPreAssDtM1.D010
    TabOrder = 4
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 356
    Width = 425
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 340
    Width = 425
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 6
  end
  object CheckBox1: TCheckBox
    Left = 44
    Top = 260
    Width = 97
    Height = 17
    Caption = 'Salto pagina'
    TabOrder = 7
  end
  object CheckBox2: TCheckBox
    Left = 44
    Top = 280
    Width = 197
    Height = 17
    Caption = 'Considera anche personale turnista'
    TabOrder = 8
  end
  object CheckBox3: TCheckBox
    Left = 268
    Top = 260
    Width = 117
    Height = 17
    Caption = 'Stampa Tabellare'
    Enabled = False
    TabOrder = 9
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Width = 425
    TabOrder = 10
    inherited pnlSelAnagrafe: TPanel
      Width = 425
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
  object GroupBox2: TGroupBox
    Left = 9
    Top = 27
    Width = 200
    Height = 174
    Caption = 'Tipo stampa:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object RbtPresenti: TRadioButton
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Presenti'
      TabOrder = 0
      OnClick = RbtPresentiClick
    end
    object RbtAssenti: TRadioButton
      Left = 16
      Top = 52
      Width = 113
      Height = 17
      Caption = 'Assenti'
      TabOrder = 1
      OnClick = RbtAssentiClick
    end
    object RbtAssentiSenzaGiust: TRadioButton
      Left = 16
      Top = 81
      Width = 153
      Height = 17
      Caption = 'Assenti senza giust.'
      TabOrder = 2
      OnClick = RbtAssentiSenzaGiustClick
    end
    object RbtGrafico: TRadioButton
      Left = 16
      Top = 110
      Width = 169
      Height = 17
      Caption = 'Grafico presenze/assenze'
      TabOrder = 3
      OnClick = RbtGraficoClick
    end
    object RbtProspetto: TRadioButton
      Left = 16
      Top = 139
      Width = 169
      Height = 17
      Caption = 'Prospetto ore lavorate'
      TabOrder = 4
      OnClick = RbtProspettoClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 376
    Top = 8
  end
end
