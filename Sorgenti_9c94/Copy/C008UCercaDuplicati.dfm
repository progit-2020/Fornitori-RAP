object C008FCercaDuplicati: TC008FCercaDuplicati
  Left = 318
  Top = 163
  Caption = 'Elementi duplicati'
  ClientHeight = 370
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 217
    Width = 345
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object lstColonne: TCheckListBox
    Left = 0
    Top = 0
    Width = 345
    Height = 217
    Align = alTop
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 220
    Width = 345
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 72
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ricerca'
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 188
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      TabOrder = 1
      Kind = bkClose
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 261
    Width = 345
    Height = 109
    Align = alClient
    DataSource = DataSource1
    PopupMenu = PopupMenu2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object PopupMenu1: TPopupMenu
    Left = 12
    Top = 8
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
  end
  object selDuplicati: TOracleDataSet
    Optimize = False
    ReadOnly = True
    Left = 112
    Top = 264
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = selDuplicati
    Left = 140
    Top = 264
  end
  object PopupMenu2: TPopupMenu
    Left = 80
    Top = 264
    object Accedia1: TMenuItem
      Caption = 'Accedi a...'
      OnClick = Accedia1Click
    end
  end
end
