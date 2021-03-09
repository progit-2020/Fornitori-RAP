object A060FTimbIrregolari: TA060FTimbIrregolari
  Left = 183
  Top = 147
  HelpContext = 60000
  Caption = '<A060> Timbrature irregolari'
  ClientHeight = 350
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 766
    Height = 129
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 94
      Width = 41
      Height = 13
      Caption = 'Azienda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LAzienda: TLabel
      Left = 90
      Top = 94
      Width = 3
      Height = 13
    end
    object Label3: TLabel
      Left = 6
      Top = 110
      Width = 78
      Height = 13
      Caption = 'Badge / Chiave:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LBadge: TLabel
      Left = 90
      Top = 110
      Width = 3
      Height = 13
    end
    object LblDaData: TLabel
      Left = 121
      Top = 9
      Width = 47
      Height = 13
      Caption = 'lblDaData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblAData: TLabel
      Left = 122
      Top = 37
      Width = 40
      Height = 13
      Caption = 'lblAData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDalBadge: TLabel
      Left = 201
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Dal badge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAlBadge: TLabel
      Left = 201
      Top = 37
      Width = 42
      Height = 13
      Caption = 'Al badge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDaChiave: TLabel
      Left = 379
      Top = 8
      Width = 49
      Height = 13
      Caption = 'Da chiave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAChiave: TLabel
      Left = 379
      Top = 37
      Width = 42
      Height = 13
      Caption = 'A chiave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAScarico: TLabel
      Left = 578
      Top = 37
      Width = 44
      Height = 13
      Caption = 'A scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDaScarico: TLabel
      Left = 578
      Top = 9
      Width = 51
      Height = 13
      Caption = 'Da scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 166
      Top = 62
      Width = 110
      Height = 25
      Caption = 'Inizia recupero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      ParentFont = False
      TabOrder = 9
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 649
      Top = 93
      Width = 111
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 13
    end
    object BtnDaData: TBitBtn
      Left = 6
      Top = 4
      Width = 110
      Height = 25
      Caption = 'Dalla data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
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
      TabOrder = 0
      OnClick = BtnDaDataClick
    end
    object BtnAData: TBitBtn
      Left = 6
      Top = 32
      Width = 110
      Height = 25
      Caption = '  Alla data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
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
    object BitBtn4: TBitBtn
      Left = 486
      Top = 62
      Width = 110
      Height = 25
      Caption = 'Stampante...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00770000000000
        0777707777777770707700000000000007070778777BBB870007077887788887
        0707000000000000077007788887788070707000000000070700770777777770
        7070777077777776EEE078000000000E600870E6EEEEEEEE077778000000000E
        6008777707777786EEE077777000000800087777777777777777}
      ParentFont = False
      TabOrder = 11
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 649
      Top = 62
      Width = 111
      Height = 25
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
        1F7C1F7C1F7C1F7C000018631863186318631863186318631863186300001863
        00001F7C1F7C0000000000000000000000000000000000000000000000000000
        186300001F7C0000186318631863186318631863E07FE07FE07F186318630000
        000000001F7C0000186318631863186318631863104210421042186318630000
        186300001F7C0000000000000000000000000000000000000000000000000000
        1863186300000000186318631863186318631863186318631863186300001863
        0000186300001F7C000000000000000000000000000000000000000018630000
        1863000000001F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001863
        0000186300001F7C1F7C1F7C0000FF7F00000000000000000000FF7F00000000
        000000001F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F00000000000000000000FF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentFont = False
      TabOrder = 12
      OnClick = BitBtn5Click
    end
    object btnCancella: TBitBtn
      Left = 326
      Top = 62
      Width = 110
      Height = 25
      Caption = 'Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777770000777777777700778807777777007777880777770077277788
        0777778772222788807777872727278880777877277777888077787222722788
        807778772772278888077877722FFFF8880777777FF8888FF807777FF88F8FF8
        FF077FF88FFF8FF88877777FFFF8FFF87777FF77FF8FF8877777}
      ParentFont = False
      TabOrder = 10
      OnClick = btnCancellaClick
    end
    object cmbABadge: TComboBox
      Left = 255
      Top = 34
      Width = 115
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = cmbDaBadgeChange
    end
    object cmbDaBadge: TComboBox
      Left = 255
      Top = 6
      Width = 115
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = cmbDaBadgeChange
      OnKeyPress = cmbDaBadgeKeyPress
    end
    object btnRefresh: TBitBtn
      Left = 6
      Top = 62
      Width = 111
      Height = 25
      Caption = 'Refresh'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 8
      OnClick = btnRefreshClick
    end
    object cmbDaChiave: TComboBox
      Left = 433
      Top = 6
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 4
      OnChange = cmbDaChiaveChange
    end
    object cmbAChiave: TComboBox
      Left = 433
      Top = 34
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 5
      OnChange = cmbAChiaveChange
    end
    object cmbDaScarico: TComboBox
      Left = 634
      Top = 6
      Width = 126
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 6
      OnChange = cmbDaScaricoChange
    end
    object cmbAScarico: TComboBox
      Left = 634
      Top = 34
      Width = 126
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 7
      OnChange = cmbAScaricoChange
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 129
    Width = 766
    Height = 202
    Align = alClient
    DataSource = A060FTimbIrregolariMW.DI101
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Color = clBlue
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BADGE'
        Title.Color = clBlue
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EDBADGE'
        Title.Color = clBlue
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHIAVE'
        Title.Color = clBlue
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORA'
        Title.Color = clBlue
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VERSO'
        Title.Color = clBlue
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RILEV'
        Title.Color = clBlue
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAUSALE'
        Title.Color = clBlue
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AZIENDE'
        Title.Color = clBlue
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SCARICO'
        Title.Color = clBlue
        Width = 90
        Visible = True
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 331
    Width = 766
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 380
    Top = 88
  end
end
