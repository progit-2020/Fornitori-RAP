object P690FStampaFondi: TP690FStampaFondi
  Left = 0
  Top = 0
  HelpContext = 3690000
  Caption = '<P690>  Stampa fondi'
  ClientHeight = 397
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 106
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 718
    Height = 73
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 14
      Width = 110
      Height = 13
      Caption = 'Dalla decorrenza fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 223
      Top = 14
      Width = 96
      Height = 13
      Caption = 'Alla scadenza fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDecorrenzaDa: TMaskEdit
      Left = 120
      Top = 11
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtDecorrenzaDaExit
    end
    object edtDecorrenzaA: TMaskEdit
      Left = 322
      Top = 11
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnExit = edtDecorrenzaAExit
    end
    object btnDecorrenzaDa: TBitBtn
      Left = 191
      Top = 9
      Width = 15
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnDecorrenzaDaClick
    end
    object btnDecorrenzaA: TBitBtn
      Left = 393
      Top = 9
      Width = 15
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = btnDecorrenzaAClick
    end
    object chkRaggruppa: TCheckBox
      Left = 120
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Raggruppa fondi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkDettRisorse: TCheckBox
      Left = 322
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Dettaglio risorse'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object chkDettDestinazioni: TCheckBox
      Left = 505
      Top = 48
      Width = 129
      Height = 17
      Caption = 'Dettaglio destinazioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 73
    Width = 62
    Height = 283
    Align = alLeft
    TabOrder = 1
    object lblTabelle: TLabel
      Left = 6
      Top = 6
      Width = 43
      Height = 26
      Caption = 'Fondi da stampare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object clbFondi: TCheckListBox
    Left = 62
    Top = 73
    Width = 656
    Height = 283
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 356
    Width = 718
    Height = 41
    Align = alBottom
    TabOrder = 3
    object btnAnteprima: TBitBtn
      Left = 379
      Top = 8
      Width = 90
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
      TabOrder = 0
      OnClick = btnAnteprimaClick
    end
    object btnChiudi: TBitBtn
      Left = 544
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 1
    end
    object btnStampante: TBitBtn
      Left = 62
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Stampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      TabOrder = 2
      OnClick = btnStampanteClick
    end
    object btnStampa: TBitBtn
      Left = 223
      Top = 8
      Width = 91
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
      TabOrder = 3
      OnClick = btnAnteprimaClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 208
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 3
  end
end
