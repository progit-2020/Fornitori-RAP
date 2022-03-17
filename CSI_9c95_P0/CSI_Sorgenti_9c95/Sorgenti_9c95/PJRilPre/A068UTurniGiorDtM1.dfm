object A068FTurniGiorDtM1: TA068FTurniGiorDtM1
  OldCreateOrder = True
  OnCreate = A068FTurniGiorDtM1Create
  Height = 200
  Width = 400
  object Q081: TOracleDataSet
    SQL.Strings = (
      'SELECT TURNO1,TURNO2 FROM T081_PROVVISORIO WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 48
    Top = 8
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'COUNT(*) FROM T040_GIUSTIFICATIVI'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA AND '
      'TIPOGIUST = '#39'I'#39)
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 88
    Top = 8
  end
  object selT080: TOracleDataSet
    SQL.Strings = (
      'SELECT T080.TURNO1, T080.TURNO2 '
      '  FROM T080_PIANIFORARI T080'
      ' WHERE T080.PROGRESSIVO = :PROGRESSIVO '
      '   AND T080.DATA = :DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 48
    Top = 64
  end
  object selTemp: TOracleDataSet
    Optimize = False
    Left = 88
    Top = 64
  end
end
