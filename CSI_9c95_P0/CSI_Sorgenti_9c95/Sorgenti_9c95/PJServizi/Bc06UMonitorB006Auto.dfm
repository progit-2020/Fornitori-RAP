object B006FScaricoAuto: TB006FScaricoAuto
  Left = 304
  Top = 228
  HelpContext = 9006000
  BorderStyle = bsSingle
  Caption = '<B006> IrisWIN - Acquisizione automatica timbrature'
  ClientHeight = 328
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 40
    Width = 471
    Height = 79
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 305
      Top = 7
      Width = 100
      Height = 13
      Caption = 'Acquisisci ogni minuti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatabase: TLabel
      Left = 10
      Top = 32
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
      Top = 55
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
    object Label2: TLabel
      Left = 357
      Top = 32
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
    object SpinEdit1: TSpinEdit
      Left = 412
      Top = 4
      Width = 54
      Height = 22
      MaxValue = 9999
      MinValue = 1
      TabOrder = 2
      Value = 60
      OnChange = SpinEdit1Change
    end
    object CheckBox1: TCheckBox
      Left = 10
      Top = 6
      Width = 102
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Avvio automatico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object chkAcquisisciDaPianificazione: TCheckBox
      Left = 133
      Top = 6
      Width = 155
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Acquisisci alle ore pianificate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkAcquisisciDaPianificazioneClick
    end
    object edtDataBase: TEdit
      Left = 104
      Top = 29
      Width = 191
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
    end
    object btnDataBase: TButton
      Left = 296
      Top = 29
      Width = 55
      Height = 21
      Caption = 'Cambia...'
      TabOrder = 4
      OnClick = btnDataBaseClick
    end
    object edtDataBaseList: TEdit
      Left = 104
      Top = 52
      Width = 191
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 5
    end
    object btnDatabaseList: TButton
      Left = 296
      Top = 52
      Width = 55
      Height = 21
      Caption = 'Cambia...'
      TabOrder = 6
      OnClick = btnDatabaseListClick
    end
    object SEdtSpinRowLog: TSpinEdit
      Left = 412
      Top = 29
      Width = 54
      Height = 22
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 7
      Value = 1
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 119
    Width = 471
    Height = 209
    Align = alClient
    Color = cl3DLight
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 471
    Height = 40
    ButtonHeight = 36
    ButtonWidth = 69
    Caption = 'ToolBar1'
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 2
    object ToolButton9: TToolButton
      Left = 0
      Top = 0
      Width = 9
      Caption = 'ToolButton9'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 9
      Top = 0
      Action = actAvvio
    end
    object ToolButton2: TToolButton
      Left = 78
      Top = 0
      Width = 9
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 87
      Top = 0
      Action = actStop
    end
    object ToolButton3: TToolButton
      Left = 156
      Top = 0
      Width = 9
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 165
      Top = 0
      Action = actServizio
      DropdownMenu = popmnuServizio
    end
    object ToolButton4: TToolButton
      Left = 234
      Top = 0
      Width = 9
      Caption = 'ToolButton4'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton10: TToolButton
      Left = 243
      Top = 0
      Action = actLeggiLog
    end
    object ToolButton5: TToolButton
      Left = 312
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton12: TToolButton
      Left = 320
      Top = 0
      Action = actCancellaLog
    end
    object ToolButton11: TToolButton
      Left = 389
      Top = 0
      Width = 8
      Caption = 'ToolButton11'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton8: TToolButton
      Left = 397
      Top = 0
      Action = actEsci
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 360000
    OnTimer = Timer1Timer
    Left = 92
    Top = 124
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 124
    object File1: TMenuItem
      Caption = 'File'
      object Pianificazione1: TMenuItem
        Caption = 'Pianificazione...'
        OnClick = Pianificazione1Click
      end
      object Esci1: TMenuItem
        Caption = 'Esci'
        OnClick = Esci1Click
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 4
    Top = 124
    object actAvvio: TAction
      Caption = 'Avvio'
      ImageIndex = 0
      OnExecute = BitBtn1Click
    end
    object actStop: TAction
      Caption = 'Stop'
      ImageIndex = 1
      OnExecute = BitBtn3Click
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
      Hint = 'Leggi B006.log'
      ImageIndex = 5
      OnExecute = actLeggiLogExecute
    end
    object actCancellaLog: TAction
      Caption = 'Cancella Log'
      Hint = 'Cancella B006.log'
      ImageIndex = 4
      Visible = False
      OnExecute = actCancellaLogExecute
    end
  end
  object ImageList1: TImageList
    Left = 32
    Top = 124
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
  object popmnuServizio: TPopupMenu
    Left = 120
    Top = 124
    object Installa1: TMenuItem
      Caption = 'Installa'
      OnClick = Installa1Click
    end
    object Disinstalla1: TMenuItem
      Caption = 'Disinstalla'
      OnClick = Disinstalla1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Avvia1: TMenuItem
      Caption = 'Avvia'
      OnClick = Avvia1Click
    end
    object Arresta1: TMenuItem
      Caption = 'Arresta'
      OnClick = Arresta1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuPriority: TMenuItem
      Caption = 'Priorit'#224
      object mnuLowest: TMenuItem
        Tag = 1
        Caption = 'Lowest'
        OnClick = mnuHighestClick
      end
      object mnuLower: TMenuItem
        Tag = 2
        Caption = 'Lower'
        OnClick = mnuHighestClick
      end
      object mnuNormal: TMenuItem
        Tag = 3
        Caption = 'Normal'
        OnClick = mnuHighestClick
      end
      object mnuHigher: TMenuItem
        Tag = 4
        Caption = 'Higher'
        OnClick = mnuHighestClick
      end
      object mnuHighest: TMenuItem
        Tag = 5
        Caption = 'Highest'
        OnClick = mnuHighestClick
      end
    end
  end
end
