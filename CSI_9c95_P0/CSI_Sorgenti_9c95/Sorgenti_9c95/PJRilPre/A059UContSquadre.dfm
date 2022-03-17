object A059FContSquadre: TA059FContSquadre
  Left = 207
  Top = 218
  HelpContext = 59000
  BorderStyle = bsDialog
  Caption = '<A059> Controllo pianificazione'
  ClientHeight = 264
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 4
    Width = 58
    Height = 13
    Caption = 'Da squadra:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 12
    Top = 48
    Width = 51
    Height = 13
    Caption = 'A squadra:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LDaData: TLabel
    Left = 80
    Top = 96
    Width = 32
    Height = 13
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LAData: TLabel
    Left = 80
    Top = 124
    Width = 32
    Height = 13
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LSquadra1: TDBText
    Left = 80
    Top = 24
    Width = 52
    Height = 13
    AutoSize = True
    DataField = 'DESCRIZIONE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LSquadra2: TDBText
    Left = 80
    Top = 68
    Width = 52
    Height = 13
    AutoSize = True
    DataField = 'DESCRIZIONE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 204
    Top = 228
    Width = 85
    Height = 25
    Caption = 'Stampa'
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
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 20
    Top = 228
    Width = 85
    Height = 25
    Caption = 'Stampante'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 296
    Top = 228
    Width = 85
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
  end
  object RgpModalita: TRadioGroup
    Left = 12
    Top = 148
    Width = 357
    Height = 35
    Caption = 'Modalit'#224' di lavoro'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Operativa'
      'Non operativa')
    ParentFont = False
    TabOrder = 3
    OnClick = RgpModalitaClick
  end
  object BDaData: TBitBtn
    Left = 12
    Top = 91
    Width = 65
    Height = 21
    Caption = 'Da data...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BDaDataClick
  end
  object BAData: TBitBtn
    Left = 12
    Top = 119
    Width = 65
    Height = 21
    Caption = 'A data...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BDaDataClick
  end
  object cmbDaSquadra: TDBLookupComboBox
    Left = 12
    Top = 20
    Width = 65
    Height = 21
    DropDownWidth = 400
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    TabOrder = 6
    OnCloseUp = cmbDaSquadraCloseUp
    OnKeyDown = cmbDaSquadraKeyDown
  end
  object cmbASquadra: TDBLookupComboBox
    Left = 12
    Top = 64
    Width = 65
    Height = 21
    DropDownWidth = 400
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    TabOrder = 7
    OnCloseUp = cmbDaSquadraCloseUp
    OnKeyDown = cmbDaSquadraKeyDown
  end
  object BitBtn4: TBitBtn
    Left = 112
    Top = 228
    Width = 85
    Height = 25
    Caption = 'Anteprima'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    TabOrder = 8
    OnClick = BitBtn1Click
  end
  object RgpTipo: TRadioGroup
    Left = 12
    Top = 184
    Width = 357
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
    TabOrder = 9
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 344
    Top = 8
  end
end
