object Bc22FGeneratoreCartellini: TBc22FGeneratoreCartellini
  Left = 0
  Top = 0
  HelpContext = 9022000
  Caption = '<Bc22> Generatore cartellini'
  ClientHeight = 391
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuFile
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 285
    Width = 498
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 256
    ExplicitWidth = 135
  end
  object memLog: TMemo
    Left = 0
    Top = 288
    Width = 498
    Height = 103
    Align = alBottom
    Color = cl3DLight
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    WordWrap = False
  end
  object pnl1: TPanel
    Left = 0
    Top = 40
    Width = 498
    Height = 103
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    object lblDatabase: TLabel
      Left = 10
      Top = 11
      Width = 91
      Height = 13
      Caption = 'Database corrente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatabaseList: TLabel
      Left = 10
      Top = 34
      Width = 74
      Height = 13
      Caption = 'Database usati:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 381
      Top = 11
      Width = 49
      Height = 13
      Caption = 'Righe Log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblHome: TLabel
      Left = 10
      Top = 57
      Width = 31
      Height = 13
      Caption = 'Home:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPathLog: TLabel
      Left = 10
      Top = 80
      Width = 42
      Height = 13
      Caption = 'Path log:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDataBase: TEdit
      Left = 104
      Top = 8
      Width = 211
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object btnDataBase: TButton
      Left = 317
      Top = 7
      Width = 59
      Height = 23
      Caption = 'Cambia...'
      TabOrder = 1
      OnClick = btnDataBaseClick
    end
    object edtDataBaseList: TEdit
      Left = 104
      Top = 31
      Width = 211
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
    end
    object btnDatabaseList: TButton
      Left = 317
      Top = 30
      Width = 59
      Height = 23
      Caption = 'Cambia...'
      TabOrder = 4
      OnClick = btnDatabaseListClick
    end
    object sedtRigheLog: TSpinEdit
      Left = 436
      Top = 8
      Width = 54
      Height = 22
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 2
      Value = 1
    end
    object edtHome: TEdit
      Left = 104
      Top = 54
      Width = 211
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 5
    end
    object edtPathLog: TEdit
      Left = 104
      Top = 77
      Width = 211
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 7
    end
    object btnHome: TButton
      Left = 317
      Top = 53
      Width = 59
      Height = 23
      Caption = 'Cambia...'
      TabOrder = 6
      OnClick = btnHomeClick
    end
    object btnPathLog: TButton
      Left = 317
      Top = 76
      Width = 59
      Height = 23
      Caption = 'Cambia...'
      TabOrder = 8
      OnClick = btnPathLogClick
    end
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 498
    Height = 40
    ButtonHeight = 36
    ButtonWidth = 52
    Caption = 'tlbMain'
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object btnStart: TToolButton
      Left = 0
      Top = 0
      Action = actAvvio
    end
    object btn8: TToolButton
      Left = 52
      Top = 0
      Width = 9
      Caption = 'btn8'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object btnStop: TToolButton
      Left = 61
      Top = 0
      Action = actStop
    end
    object btn9: TToolButton
      Left = 113
      Top = 0
      Width = 9
      Caption = 'btn9'
      ImageIndex = 2
      Style = tbsSeparator
      Visible = False
    end
    object btnServizio: TToolButton
      Left = 122
      Top = 0
      Action = actServizio
      DropdownMenu = pmnServizio
    end
    object btn10: TToolButton
      Left = 174
      Top = 0
      Width = 9
      Caption = 'btn10'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object btnLeggiLog: TToolButton
      Left = 183
      Top = 0
      Action = actLeggiLog
    end
    object btn12: TToolButton
      Left = 235
      Top = 0
      Width = 8
      Caption = 'btn12'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object btnChiudi: TToolButton
      Left = 243
      Top = 0
      Action = actEsci
    end
  end
  object dgrdCartellini: TDBGrid
    Left = 0
    Top = 172
    Width = 498
    Height = 113
    Align = alClient
    DataSource = dsrVT860
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlTabella: TPanel
    Left = 0
    Top = 143
    Width = 498
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblNumRecord: TLabel
      Left = 443
      Top = 8
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Record: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnRefresh: TBitBtn
      Left = 10
      Top = 2
      Width = 103
      Height = 25
      Caption = 'Aggiorna'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = btnRefreshClick
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 332
    Top = 4
    object actAvvio: TAction
      Caption = 'Avvio'
      ImageIndex = 0
      OnExecute = actAvvioExecute
    end
    object actStop: TAction
      Caption = 'Stop'
      ImageIndex = 1
      Visible = False
      OnExecute = actStopExecute
    end
    object actEsci: TAction
      Caption = 'Chiudi'
      ImageIndex = 3
      OnExecute = actEsciExecute
    end
    object actServizio: TAction
      Caption = 'Servizio'
      ImageIndex = 2
      OnExecute = actServizioExecute
    end
    object actLeggiLog: TAction
      Caption = 'Leggi Log'
      Hint = 'Lettura dei log da database'
      ImageIndex = 5
      OnExecute = actLeggiLogExecute
    end
    object actServizioInstalla: TAction
      Caption = 'Installa'
      OnExecute = actServizioInstallaExecute
    end
    object actServizioDisinstalla: TAction
      Caption = 'Disinstalla'
      OnExecute = actServizioDisinstallaExecute
    end
    object actServizioStart: TAction
      Caption = 'Avvia'
      OnExecute = actServizioStartExecute
    end
    object actServizioStop: TAction
      Caption = 'Arresta'
      OnExecute = actServizioStopExecute
    end
    object actInfo: TAction
      Caption = 'Informazioni...'
      Visible = False
    end
  end
  object ImageList1: TImageList
    Left = 360
    Top = 4
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000848484008400
      0000840000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000084848400840000008484
      840084000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000840000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000008484000084840000848400000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000084000000840000008400000000FFFF0000000000000000000000
      00000000000000000000000000000000000000FFFF0000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF00840084000000000000000000C6C6C600000000000000
      0000000000008400000000000000000000008484840000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00848484008484
      84000084840000000000848484008484840000000000000000000000FF000000
      FF0000000000000000007B7B7B00000000007B7B7B00000000000000FF000000
      FF000000FF0000000000000000000000000000FFFF0000000000000000000000
      00000000000000FFFF00000000000000000000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000000000000000
      000000000000840000000000000000000000000000008484840000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000008484
      840000848400008484000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      000000FFFF000000000000FFFF0000FFFF000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF0000840000000000000000000000000000008484840000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000000000000000000000
      000000848400000000008484840084848400000000000000FF00000000000000
      FF000000FF000000FF007B7B7B00000000007B7B7B0000000000000000000000
      00000000FF000000FF00000000000000000000000000000000000000000000FF
      FF0000848400008484000000000000FFFF0000FFFF0000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      00000000000084000000000000000000000084848400848484008484840000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF000084840000FF
      FF0000FFFF000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      840000FFFF000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF000084000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000000000000000000084
      84000000000000FFFF00008484000000000000FFFF000000000000FFFF000084
      8400008484000084840000848400000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      0000000000008400000000000000000000008484840000FFFF0000FFFF0000FF
      FF00000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000007B7B7B00000000007B7B7B0000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      8400000000000000000000848400000000000000000000FFFF00000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF0000840000000000000000000000000000008484840000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000840000000000000084000000FF00000000000000
      0000000000000000FF000000FF00000000000084840000000000000000000084
      84000000000000848400008484000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      00000000000084000000000000000000000000000000000000008484840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000FF000000FF00000000000084840000FFFF0000FFFF000000
      000000848400008484000000000000FFFF000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000008484840084848400848484008484
      840000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF00000000000000000000FFFF00000000000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      000000000000840000000000000000000000000000008484840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000FFFF00000000000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000007B7B7B00000000007B7B7B0000000000000000000000
      FF000000FF000000000000000000000000000084840000848400008484000000
      00000084840000FFFF0000000000008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000FFFF00008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00F807FF7E00000000FBC7900100000000
      FB87C00300000000FBC7E00300000000FB87E00300000000FBC7E00300000000
      F803E00300000000FFF3000100000000FFF1800000000000F9F1E00700000000
      F4F1E00F00000000F6F1E00F00000000F9FBE02700000000EFF3C07300000000
      FFF79E7900000000FFFF7EFE00000000FF87FFFFF83F7FCA7F03F83FF21F01F8
      3E01E00F0403F03B1E00CC476241F07B8C2084639481F0538600A0736003F07B
      020131F90081F053010338F96040F07B00CF3C7984A0F05383FF3C396801F02B
      C1FF3C191083F05300FF9C0B6A41F02B807F8C438481FFFFC03FC4670203FC0F
      E0FFE00FF41FFC0FF07FF83FF83FFC0F00000000000000000000000000000000
      000000000000}
  end
  object mnuFile: TMainMenu
    Left = 392
    Top = 4
    object File1: TMenuItem
      Caption = 'File'
      object Pianificazione1: TMenuItem
        Caption = 'Pianificazione...'
        Visible = False
      end
      object actInfo1: TMenuItem
        Action = actInfo
      end
      object Esci1: TMenuItem
        Caption = 'Esci'
      end
    end
  end
  object pmnServizio: TPopupMenu
    Left = 440
    Top = 4
    object Installa1: TMenuItem
      Action = actServizioInstalla
    end
    object Disinstalla1: TMenuItem
      Action = actServizioDisinstalla
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Avvia1: TMenuItem
      Action = actServizioStart
    end
    object Arresta1: TMenuItem
      Action = actServizioStop
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuPriority: TMenuItem
      Caption = 'Priorit'#224
      object mnuLowest: TMenuItem
        Tag = 1
        Caption = 'Lowest'
      end
      object mnuLower: TMenuItem
        Tag = 2
        Caption = 'Lower'
      end
      object mnuNormal: TMenuItem
        Tag = 3
        Caption = 'Normal'
      end
      object mnuHigher: TMenuItem
        Tag = 4
        Caption = 'Higher'
      end
      object mnuHighest: TMenuItem
        Tag = 5
        Caption = 'Highest'
      end
    end
  end
  object tmrPianificazione: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrPianificazioneTimer
    Left = 416
    Top = 8
  end
  object dsrVT860: TDataSource
    AutoEdit = False
    OnStateChange = dsrVT860StateChange
    Left = 416
    Top = 208
  end
end