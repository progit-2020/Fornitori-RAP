object A058FPianifTurni: TA058FPianifTurni
  Left = 486
  Top = 279
  HelpContext = 58000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '<A058> Pianificazione tabellone'
  ClientHeight = 389
  ClientWidth = 269
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
  object lblCopiaAss: TLabel
    Left = 8
    Top = 154
    Width = 308
    Height = 39
    Margins.Top = 15
    AutoSize = False
    Caption = 'Copia giustificativi in modalit'#224' non operativa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object lblProfilo: TLabel
    Left = 8
    Top = 114
    Width = 99
    Height = 13
    Caption = 'Profilo pianificazione:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dLblDescProfilo: TDBText
    Left = 111
    Top = 133
    Width = 74
    Height = 13
    AutoSize = True
    DataField = 'DESCRIZIONE'
    DataSource = A058FPianifTurniDtM1.dtsT082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dLblSquadra: TDBText
    Left = 88
    Top = 91
    Width = 172
    Height = 13
    DataField = 'DESCRIZIONE'
    DataSource = A058FPianifTurniDtM1.D600
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSquadra: TLabel
    Left = 8
    Top = 72
    Width = 178
    Height = 13
    Caption = 'Squadra per riferimento limiti operatori:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDataDa: TLabel
    Left = 8
    Top = 28
    Width = 41
    Height = 13
    Caption = 'Data da:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDataA: TLabel
    Left = 179
    Top = 28
    Width = 35
    Height = 13
    Caption = 'Data a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnStampa: TSpeedButton
    Left = 184
    Top = 314
    Width = 80
    Height = 25
    Caption = 'Stampa'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000C6C6
      C6000000FFFFFFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000C6C6C6000000FFFFFF000000C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C600FFFF00FFFF00FFFFC6C6C6C6C6C60000
      00000000000000FFFFFF000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C684
      8484848484848484C6C6C6C6C6C6000000C6C6C6000000FFFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00C6C6C6C6C6C6000000000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6000000C6C6C6000000C6C6C6000000FFFFFF000000
      000000000000000000000000000000000000000000000000000000C6C6C60000
      00C6C6C6000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C6C6C6000000C6C6C6000000FFFFFFFFFFFF
      FFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000000000
      00000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000
      00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = BEseguiClick
  end
  object BEsegui: TBitBtn
    Left = 8
    Top = 265
    Width = 255
    Height = 25
    Caption = '&Generazione nuova pianificazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    OnClick = BEseguiClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 370
    Width = 269
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '1 Record'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 354
    Width = 269
    Height = 16
    Align = alBottom
    Step = 5
    TabOrder = 13
  end
  object BitBtn3: TBitBtn
    Left = 8
    Top = 235
    Width = 255
    Height = 25
    Caption = '&Visualizzazione pianificazione esistente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    OnClick = BEseguiClick
  end
  object btnAnteprima: TBitBtn
    Left = 96
    Top = 314
    Width = 80
    Height = 25
    Caption = '&Anteprima'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    ParentFont = False
    TabOrder = 12
    OnClick = BEseguiClick
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 269
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 269
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 269
      Height = 24
      ExplicitWidth = 269
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
  object RgpTipo: TRadioGroup
    Left = 8
    Top = 194
    Width = 251
    Height = 35
    Caption = 'Tipo pianificazione'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Iniziale'
      'Corrente')
    ParentFont = False
    TabOrder = 7
    OnClick = RgpTipoClick
  end
  object dCmbProfili: TDBLookupComboBox
    Left = 8
    Top = 129
    Width = 96
    Height = 21
    DataField = 'CODICE'
    DataSource = A058FPianifTurniDtM1.dtsAusT058
    KeyField = 'CODICE'
    ListField = 'CODICE'
    ListSource = A058FPianifTurniDtM1.dtsT082
    PopupMenu = ppMnuAccedi
    TabOrder = 6
    OnCloseUp = dCmbProfiliCloseUp
    OnKeyUp = dCmbProfiliKeyUp
  end
  object dCmbSquadra: TDBLookupComboBox
    Left = 8
    Top = 87
    Width = 76
    Height = 21
    DropDownWidth = 150
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = A058FPianifTurniDtM1.D600
    ParentFont = False
    TabOrder = 5
    OnKeyDown = dCmbSquadraKeyDown
  end
  object edtDataDa: TMaskEdit
    Left = 8
    Top = 41
    Width = 69
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    OnExit = edtDataDaExit
  end
  object btnDataDa: TButton
    Left = 78
    Top = 41
    Width = 14
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btnDataDaClick
  end
  object edtDataA: TMaskEdit
    Left = 179
    Top = 41
    Width = 69
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
    OnDblClick = edtDataADblClick
    OnExit = edtDataDaExit
  end
  object btnDataA: TButton
    Left = 250
    Top = 41
    Width = 14
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = btnDataDaClick
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 314
    Width = 80
    Height = 25
    Caption = 'Stampante'
    Default = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    TabOrder = 11
    OnClick = BitBtn1Click
  end
  object chkIniCorr: TCheckBox
    Left = 8
    Top = 291
    Width = 177
    Height = 17
    Caption = 'Genera pianif. Iniziale\Corrente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object ppMnuAccedi: TPopupMenu
    Left = 14
    Top = 133
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 207
    Top = 107
  end
  object MyCompRep: TQRCompositeReport
    OnAddReports = MyOnAddReports
    Options = []
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = True
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = True
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrinterSettings.Orientation = poLandscape
    PrinterSettings.PaperSize = A4
    PageCount = 0
    Left = 245
    Top = 105
  end
end
