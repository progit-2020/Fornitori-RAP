inherited A052FParCarMW: TA052FParCarMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 158
  object selT951: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T951.*,T951.ROWID FROM T951_STAMPACARTELLINO_DATI T951 WH' +
        'ERE CODICE = :CODICE'
      'ORDER BY NUMRIGA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    Left = 16
    Top = 24
  end
  object DI010: TDataSource
    Left = 64
    Top = 24
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T265_CAUASSENZE'
      'WHERE STAMPA <> '#39'B'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 16
    Top = 88
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM   T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 64
    Top = 88
  end
end
