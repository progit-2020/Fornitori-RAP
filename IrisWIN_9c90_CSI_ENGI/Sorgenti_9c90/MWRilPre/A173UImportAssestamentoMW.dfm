inherited A173FImportAssestamentoMW: TA173FImportAssestamentoMW
  OldCreateOrder = True
  Height = 120
  Width = 125
  object selT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.PROGRESSIVO FROM T030_ANAGRAFICO T030 WHERE T030.MAT' +
        'RICOLA = :MATRICOLA')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    Left = 24
    Top = 64
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'select codice from t305_caugiustif where codice = :CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 72
    Top = 64
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select t070.*, t070.rowid '
      'from t070_schedariepil t070'
      'where progressivo = :PROG'
      '  and data = :DATA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 24
    Top = 8
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'select t071.*, t071.rowid '
      'from t071_schedafasce t071'
      'where progressivo = :PROG'
      '  and data = :DATA'
      '  and maggiorazione = '
      
        '      (select min(maggiorazione) from  t071_schedafasce where pr' +
        'ogressivo = :PROG and data = :DATA) '
      '  and rownum = 1')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 72
    Top = 8
  end
end
