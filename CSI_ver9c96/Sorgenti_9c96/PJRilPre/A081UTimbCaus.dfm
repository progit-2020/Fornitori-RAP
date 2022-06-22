object A081FTimbCaus: TA081FTimbCaus
  Left = 412
  Top = 214
  HelpContext = 81000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A081> Elenco timbrature causalizzate'
  ClientHeight = 433
  ClientWidth = 496
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
  object lblCampoRaggr: TLabel
    Left = 262
    Top = 116
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
  object lblListaCausali: TLabel
    Left = 0
    Top = 32
    Width = 79
    Height = 13
    Caption = 'Causali richieste:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblDaData: TLabel
    Left = 364
    Top = 54
    Width = 61
    Height = 13
    Caption = 'LblDaData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblAData: TLabel
    Left = 364
    Top = 90
    Width = 53
    Height = 13
    Caption = 'LblAData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 1
    Top = 362
    Width = 100
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
    TabOrder = 11
    OnClick = BtnPrinterSetUpClick
  end
  object BtnPreView: TBitBtn
    Left = 111
    Top = 362
    Width = 100
    Height = 25
    Caption = 'Anteprima'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    TabOrder = 12
    OnClick = BtnPreViewClick
  end
  object BtnClose: TBitBtn
    Left = 324
    Top = 362
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 14
  end
  object dcmbCampoRaggr: TDBLookupComboBox
    Left = 262
    Top = 132
    Width = 206
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A081FTimbCausDtM1.D010
    TabOrder = 3
    OnKeyDown = dcmbCampoRaggrKeyDown
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 414
    Width = 496
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 398
    Width = 496
    Height = 16
    Align = alBottom
    TabOrder = 16
  end
  object CgpListaCausali: TCheckListBox
    Left = 0
    Top = 48
    Width = 258
    Height = 305
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object BtnDaData: TBitBtn
    Left = 262
    Top = 48
    Width = 98
    Height = 25
    Caption = 'Dalla data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
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
    ParentFont = False
    TabOrder = 1
    OnClick = BtnDaDataClick
  end
  object BtnAData: TBitBtn
    Left = 262
    Top = 84
    Width = 98
    Height = 25
    Caption = '  Alla data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
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
    ParentFont = False
    TabOrder = 2
    OnClick = BtnADataClick
  end
  object chkTotData: TCheckBox
    Left = 262
    Top = 224
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object chkTotRaggr: TCheckBox
    Left = 262
    Top = 184
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object chkTotCaus: TCheckBox
    Left = 262
    Top = 204
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per causale'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
  object BtnStampa: TBitBtn
    Left = 215
    Top = 362
    Width = 100
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
    TabOrder = 13
    OnClick = BtnPreViewClick
  end
  object chkSaltoCaus: TCheckBox
    Left = 262
    Top = 284
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Salto pagina per causale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object chkSaltoRaggr: TCheckBox
    Left = 262
    Top = 264
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Salto pagina raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object chkTotGenerale: TCheckBox
    Left = 262
    Top = 164
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totale generale'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 4
  end
  object chkStampaDett: TCheckBox
    Left = 262
    Top = 244
    Width = 160
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Stampa dettagli'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 496
    Height = 24
    Align = alTop
    TabOrder = 17
    TabStop = True
    ExplicitWidth = 496
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 496
      Height = 24
      ExplicitWidth = 496
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
    Left = 404
    Top = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 4
    Top = 48
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end
