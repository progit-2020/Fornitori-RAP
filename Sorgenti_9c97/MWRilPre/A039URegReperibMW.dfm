inherited A039FRegReperibMW: TA039FRegReperibMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object selT350VP: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGIORATE,VP_' +
        'GETTONE_CHIAMATA,VP_TURNI_OLTREMAX,ROWID '
      'FROM T350_REGREPERIB T350'
      'WHERE ROWID <> :RIGAID'
      'ORDER BY CODICE'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00520049004700410049004400050000000000
      000000000000}
    CommitOnPost = False
    Left = 84
    Top = 52
  end
  object QCols: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME FROM COLS'
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    Optimize = False
    Left = 72
    Top = 4
  end
  object DCols: TDataSource
    AutoEdit = False
    DataSet = QCols
    Left = 124
    Top = 4
  end
  object updT340: TOracleQuery
    SQL.Strings = (
      'update T340_TURNIREPERIB'
      'set :NOMECAMPO = :VALORENEW'
      'where :NOMECAMPO = :VALOREOLD')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004E004F004D004500430041004D0050004F00
      010000000000000000000000140000003A00560041004C004F00520045004E00
      45005700050000000000000000000000140000003A00560041004C004F005200
      45004F004C004400050000000000000000000000}
    Left = 28
    Top = 52
  end
end
