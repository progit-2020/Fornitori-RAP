object A062FQueryServizioDtM1: TA062FQueryServizioDtM1
  OldCreateOrder = True
  OnCreate = A062FQueryServizioDtM1Create
  OnDestroy = A062FQueryServizioDtM1Destroy
  Height = 86
  Width = 110
  object dsrT002: TDataSource
    DataSet = selT002
    Left = 59
    Top = 16
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select distinct T002.NOME'
      
        '  from T002_QUERYPERSONALIZZATE T002, T006_ASSOCIA_QUERYPERS_RAG' +
        'GR T006, T005_RAGGRQUERYPERS T005'
      ' where T002.APPLICAZIONE = :APPLICAZIONE'
      '   and upper(T002.NOME) = upper(T006.COD_QUERY)'
      '   and T006.ID = T005.ID'
      '   and T005.DESCRIZIONE = :COD_RAGGR'
      ' order by upper(T002.NOME)')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000140000003A0043004F0044005F00
      52004100470047005200050000000000000000000000}
    Filtered = True
    OnFilterRecord = selT002FilterRecord
    Left = 16
    Top = 16
    object selT002NOME: TStringField
      FieldName = 'NOME'
      Origin = 'T002_QUERYPERSONALIZZATE.NOME'
      Size = 30
    end
  end
end
