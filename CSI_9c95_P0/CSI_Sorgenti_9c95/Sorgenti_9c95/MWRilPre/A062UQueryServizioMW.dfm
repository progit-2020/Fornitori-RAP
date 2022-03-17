inherited A062FQueryServizioMW: TA062FQueryServizioMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 188
  Width = 309
  object cdsValori: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VARIABILE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALORE'
        DataType = ftString
        Size = 1000
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
        Fields = 'VARIABILE'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'VARIABILE'
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsValoriBeforeInsert
    BeforeDelete = cdsValoriBeforeDelete
    Left = 249
    Top = 13
    object cdsValoriVARIABILE: TStringField
      DisplayLabel = 'Variabile'
      DisplayWidth = 15
      FieldName = 'VARIABILE'
      ReadOnly = True
    end
    object cdsValoriTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object cdsValoriVALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 15
      FieldName = 'VALORE'
      Size = 1000
    end
  end
  object selT002Riga: TOracleDataSet
    SQL.Strings = (
      'select RIGA, POSIZ'
      '  from T002_QUERYPERSONALIZZATE       '
      ' where NOME = :nome '
      '   and APPLICAZIONE = :applicazione'
      ' order by POSIZ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F004D00450005000000000000000000
      00001A0000003A004100500050004C004900430041005A0049004F004E004500
      050000000000000000000000}
    Left = 124
    Top = 12
  end
  object S1: TOracleScript
    AutoCommit = True
    OutputOptions = [ooFeedback, ooError]
    Left = 128
    Top = 64
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA, UTENTE, PAROLACHIAVE'
      'FROM MONDOEDP.I090_ENTI'
      'WHERE UTENTE = :UTENTE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 72
    Top = 63
  end
  object CreateTab: TOracleDataSet
    Optimize = False
    Left = 15
    Top = 63
  end
  object delT002: TOracleQuery
    SQL.Strings = (
      'delete'
      '  from t002_querypersonalizzate'
      '  where nome=:nome '
      '  and applicazione = :applicazione'
      ':FILTRO')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004E004F004D00450005000000000000000000
      00001A0000003A004100500050004C004900430041005A0049004F004E004500
      0500000000000000000000000E0000003A00460049004C00540052004F000100
      00000000000000000000}
    BeforeQuery = delT002BeforeQuery
    Left = 20
    Top = 12
  end
  object insT002: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  INSERT INTO T002_QUERYPERSONALIZZATE (APPLICAZIONE,NOME,POSIZ,' +
        'RIGA)'
      '  VALUES (:APPLICAZIONE,:NOME,:POSIZ,:RIGA);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A004E004F004D00450005000000000000000000
      00000C0000003A0050004F00530049005A000300000000000000000000000A00
      00003A0052004900470041000500000000000000000000001A0000003A004100
      500050004C004900430041005A0049004F004E00450005000000000000000000
      0000}
    AfterQuery = insT002AfterQuery
    Left = 68
    Top = 12
  end
  object Q1: TOracleDataSet
    ReadBuffer = 2000
    Optimize = False
    QueryAllRecords = False
    CountAllRecords = True
    Left = 188
    Top = 17
  end
  object DS1: TDataSource
    DataSet = Q1
    Left = 184
    Top = 68
  end
  object dsrValori: TDataSource
    DataSet = cdsValori
    Left = 249
    Top = 67
  end
  object selT002TrovaQuery: TOracleQuery
    SQL.Strings = (
      'select count(distinct T002.NOME) as NUM_REC'
      '  from T002_QUERYPERSONALIZZATE T002'
      ' where T002.APPLICAZIONE = :APPLICAZIONE'
      '   and trim(T002.NOME) = trim(:QRY_NOME)')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000120000003A005100520059005F00
      4E004F004D004500050000000000000000000000}
    Left = 16
    Top = 120
  end
  object selT005: TOracleDataSet
    SQL.Strings = (
      'select T005.ID, T005.DESCRIZIONE, count(*)'
      
        '  from T005_RAGGRQUERYPERS T005, T006_ASSOCIA_QUERYPERS_RAGGR T0' +
        '06'
      ' where T005.ID = T006.ID'
      ' group by T005.ID, T005.DESCRIZIONE'
      ' having count(*) > 0'
      ' order by T005.DESCRIZIONE')
    Optimize = False
    Left = 88
    Top = 121
  end
end
