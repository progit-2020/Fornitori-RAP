object C011FDBList: TC011FDBList
  Left = 146
  Top = 48
  Width = 343
  Height = 386
  Caption = 'Elenco'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 331
    Width = 335
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 2
      Top = 2
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 82
      Top = 2
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object DBLookupListBox1: TDBLookupListBox
    Left = 0
    Top = 0
    Width = 335
    Height = 329
    Align = alClient
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = DataSource1
    TabOrder = 0
    OnDblClick = DBLookupListBox1DblClick
  end
  object DataSource1: TDataSource
  end
end
