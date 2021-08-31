inherited A067FRepSostBMW: TA067FRepSostBMW
  OldCreateOrder = True
  Height = 81
  object D265: TDataSource
    AutoEdit = False
    DataSet = Q265
    Left = 44
    Top = 8
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE'
      'WHERE INFLUCONT = '#39'D'#39
      'ORDER BY CODICE')
    Optimize = False
    AfterOpen = Q265AfterOpen
    Left = 16
    Top = 8
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'DATA,DAORE FROM T040_GIUSTIFICATIVI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND '
      'DATA BETWEEN :DATA1 AND :DATA2 AND'
      'CAUSALE = :CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 84
    Top = 8
  end
  object Del040: TOracleQuery
    SQL.Strings = (
      'DELETE /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'FROM T040_GIUSTIFICATIVI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND '
      'DATA = :DATA AND'
      'CAUSALE = :CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 124
    Top = 8
  end
  object Ins040: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T040_GIUSTIFICATIVI '
      '(PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE)'
      'VALUES'
      '(:PROGRESSIVO,:DATA,:CAUSALE,0,'#39'N'#39',:DAORE)'
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000000C0000003A00440041004F00520045000C0000000000
      000000000000}
    Left = 164
    Top = 8
  end
end
