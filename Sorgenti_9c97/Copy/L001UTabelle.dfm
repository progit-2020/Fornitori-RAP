object L001FTabelle: TL001FTabelle
  Left = 92
  Top = 86
  Caption = 'L001FTabelle'
  ClientHeight = 340
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 509
    Height = 313
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnExit = DBGrid1Exit
  end
  object Panel1: TPanel
    Left = 0
    Top = 313
    Width = 509
    Height = 27
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 0
      Top = 2
      Width = 81
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 80
    Top = 76
  end
  object Table1: TOracleDataSet
    ReadBuffer = 10000
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = Table1BeforePost
    AfterPost = Table1AfterPost
    BeforeDelete = Table1BeforeDelete
    AfterDelete = Table1AfterDelete
    OnDeleteError = Table1DeleteError
    OnEditError = Table1EditError
    OnPostError = Table1PostError
    Left = 52
    Top = 76
  end
end
