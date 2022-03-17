inherited B021FDizionarioAssenzeDM: TB021FDizionarioAssenzeDM
  OldCreateOrder = True
  Width = 236
  object selSingolo: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE '
      'FROM   T265_CAUASSENZE '
      'WHERE  FRUIBILE = '#39'S'#39' '
      'UNION ALL'
      'SELECT CODICE, DESCRIZIONE '
      'FROM   T265_CAUASSENZE T265, T430_STORICO T430 '
      'WHERE  T265.FRUIBILE = '#39'N'#39
      'AND    T430.PROGRESSIVO = :PROGRESSIVO'
      'AND    TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE '
      'AND    INSTR(T430.ABCAUSALE1,T265.CODICE) > 1'
      'ORDER BY 1')
    ReadBuffer = 150
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 104
    Top = 16
  end
  object selTutti: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE '
      'FROM   T265_CAUASSENZE '
      'ORDER BY 1')
    ReadBuffer = 300
    Optimize = False
    Left = 168
    Top = 16
  end
end
