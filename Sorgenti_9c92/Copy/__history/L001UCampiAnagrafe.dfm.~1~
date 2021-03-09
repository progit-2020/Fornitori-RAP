object L001FCampiAnagrafe: TL001FCampiAnagrafe
  Left = 345
  Top = 151
  HelpContext = 1000
  Caption = '<L001> Ridefinizione campi anagrafici'
  ClientHeight = 418
  ClientWidth = 475
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
    Width = 475
    Height = 391
    Align = alClient
    DataSource = D010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 391
    Width = 475
    Height = 27
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 0
      Top = 1
      Width = 75
      Height = 25
      Kind = bkOK
      TabOrder = 0
    end
    object Button1: TButton
      Left = 144
      Top = 1
      Width = 137
      Height = 25
      Caption = 'Assegna valori di default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object D010: TDataSource
    DataSet = I010
    Left = 84
    Top = 76
  end
  object I010: TOracleDataSet
    SQL.Strings = (
      'SELECT I010.*,I010.ROWID FROM I010_CAMPIANAGRAFICI I010 '
      'WHERE APPLICAZIONE = DECODE(:APPLICAZIONE,'#39'PAGHE'#39','#39'PAGHE'#39','#39'*'#39')'
      'ORDER BY :ORDINAMENTO'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000180000003A004F00520044004900
      4E0041004D0045004E0054004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000007000000140000004E004F004D0045005F00430041004D0050004F00
      010000000000160000004E004F004D0045005F004C004F004700490043004F00
      0100000000001200000050004F00530049005A0049004F004E00450001000000
      000016000000560041004C005F00440045004600410055004C00540001000000
      00000E0000005200490043004500520043004100010000000000180000004100
      500050004C004900430041005A0049004F004E0045000100000000001A000000
      500052004F00560056004500440049004D0045004E0054004F00010000000000}
    AfterOpen = I010AfterOpen
    BeforeInsert = I010BeforeInsert
    AfterPost = I010AfterPost
    BeforeDelete = I010BeforeInsert
    OnPostError = I010PostError
    Left = 40
    Top = 76
    object I010NOME_CAMPO: TStringField
      DisplayLabel = 'Nome dato'
      DisplayWidth = 20
      FieldName = 'NOME_CAMPO'
      Size = 40
    end
    object I010NOME_LOGICO: TStringField
      DisplayLabel = 'Ridefinito'
      DisplayWidth = 20
      FieldName = 'NOME_LOGICO'
      Size = 40
    end
    object I010POSIZIONE: TFloatField
      DisplayLabel = 'Posizione'
      DisplayWidth = 5
      FieldName = 'POSIZIONE'
      Precision = 2
    end
    object I010RICERCA: TIntegerField
      DisplayLabel = 'Ricerca'
      DisplayWidth = 5
      FieldName = 'RICERCA'
    end
    object I010VAL_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 5
      FieldName = 'VAL_DEFAULT'
      Size = 50
    end
    object I010APPLICAZIONE: TStringField
      FieldName = 'APPLICAZIONE'
      Visible = False
      Size = 6
    end
    object I010PROVVEDIMENTO: TStringField
      DisplayLabel = 'Provv.'
      FieldName = 'PROVVEDIMENTO'
      Size = 1
    end
  end
end
