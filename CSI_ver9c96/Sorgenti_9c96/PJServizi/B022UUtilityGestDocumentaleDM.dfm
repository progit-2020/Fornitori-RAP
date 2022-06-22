object B022FUtilityGestDocumentaleDM: TB022FUtilityGestDocumentaleDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 376
  Width = 754
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T030.MATRICOLA, '
      '  T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, '
      
        '  T960.NOME_FILE || DECODE(T960.EXT_FILE, '#39#39', '#39#39', '#39'.'#39' || T960.EX' +
        'T_FILE) INFO_FILE,'
      '  T960.PATH_STORAGE, '
      '  T960.DIMENSIONE, '
      '  T960.DATA_CREAZIONE, '
      '  T960.PROGRESSIVO,'
      '  T960.ID,'
      '  T960.ROWID,'
      '  T960.PROVENIENZA'
      'from '
      '  T960_DOCUMENTI_INFO T960, '
      '  :C700SelAnagrafe'
      ''
      '  and T030.PROGRESSIVO :OUT_JOIN = T960.PROGRESSIVO'
      '  :PATH_STORAGE '
      '  and T960.DATA_CREAZIONE between :DAL and :AL + 1 '
      'order by '
      '  T960.DATA_CREAZIONE')
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A0050004100540048005F00530054004F005200
      410047004500010000000000000000000000080000003A00440041004C000C00
      00000000000000000000060000003A0041004C000C0000000000000000000000
      200000003A004300370030003000530045004C0041004E004100470052004100
      46004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000120000003A004F005500
      54005F004A004F0049004E00010000000000000000000000}
    BeforePost = selT960BeforePost
    AfterPost = selT960AfterPost
    OnCalcFields = selT960CalcFields
    Left = 191
    Top = 24
    object selT960PATH_STORAGE: TStringField
      DisplayLabel = 'Area di storage'
      DisplayWidth = 20
      FieldName = 'PATH_STORAGE'
      Size = 1000
    end
    object selT960ID: TFloatField
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object selT960INFO_FILE: TStringField
      DisplayLabel = 'File'
      DisplayWidth = 30
      FieldName = 'INFO_FILE'
      Size = 200
    end
    object selT960DIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'DIMENSIONE'
      Visible = False
    end
    object selT960D_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Size = 10
      Calculated = True
    end
    object selT960DATA_CREAZIONE: TDateTimeField
      DisplayLabel = 'Data creazione'
      FieldName = 'DATA_CREAZIONE'
    end
    object selT960PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      DisplayWidth = 7
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT960MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT960NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 80
    end
    object selT960PROVENIENZA: TStringField
      FieldName = 'PROVENIENZA'
      Size = 1
    end
  end
  object dsrT960: TDataSource
    DataSet = selT960
    Left = 60
    Top = 24
  end
  object selT960PathStorage: TOracleDataSet
    SQL.Strings = (
      'select '
      '  DISTINCT UPPER(PATH_STORAGE) PATH_STORAGE'
      'from'
      '  T960_DOCUMENTI_INFO')
    Optimize = False
    Left = 56
    Top = 96
  end
  object selDataCreazioneMinMax: TOracleDataSet
    SQL.Strings = (
      'select '
      '  trunc(min(T960.DATA_CREAZIONE)) MIN, '
      '  trunc(max(T960.DATA_CREAZIONE)) MAX'
      'from'
      '  T960_DOCUMENTI_INFO T960'
      '')
    Optimize = False
    Left = 192
    Top = 96
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'select I091.*, I091.ROWID '
      'from   MONDOEDP.I091_DATIENTE I091'
      'where  I091.AZIENDA = :AZIENDA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 56
    Top = 160
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select T962.CODICE, T962.DESCRIZIONE, T962.CODICE_DEFAULT'
      'from   T962_TIPO_DOCUMENTI T962'
      'order by T962.DESCRIZIONE')
    ReadBuffer = 100
    Optimize = False
    Left = 376
    Top = 24
  end
  object dsrT962: TDataSource
    DataSet = selT962
    Left = 432
    Top = 24
  end
  object selT963: TOracleDataSet
    SQL.Strings = (
      'select T963.CODICE, T963.DESCRIZIONE, T963.CODICE_DEFAULT'
      'from   T963_UFFICIO_DOCUMENTI T963'
      'order by T963.DESCRIZIONE')
    ReadBuffer = 100
    Optimize = False
    Left = 376
    Top = 88
  end
  object dsrT963: TDataSource
    DataSet = selT963
    Left = 432
    Top = 88
  end
end
