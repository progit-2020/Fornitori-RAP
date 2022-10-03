inherited A167FRegistraIncentiviMW: TA167FRegistraIncentiviMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 231
  object selT765B: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT TIPOQUOTA '
      'from T765_TIPOQUOTE T '
      'where DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE'
      '                     WHERE CODICE = T.CODICE'
      '                       AND DECORRENZA <= :DATA)'
      'order by tipoquota')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F00540041000100000000001C0000004400
      4500530043005F005400490050004F00510055004F0054004100010000000000}
    Left = 83
    Top = 62
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select T.CODICE,T.DESCRIZIONE, T.TIPOQUOTA,'
      
        '  DECODE(TIPOQUOTA,'#39'A'#39','#39'Acconto'#39','#39'S'#39','#39'Saldo'#39','#39'T'#39','#39'Saldo totale'#39',' +
        #39'I'#39','#39'Saldo individuale'#39','#39'V'#39','#39'Saldo valutativo'#39','#39'C'#39','#39'Saldo collet' +
        'tivo'#39','
      
        '    '#39'D'#39','#39'Saldo collettivo valutativo'#39','#39'Q'#39','#39'Quota quantitativa'#39','#39 +
        'P'#39','#39'Penalizzazione'#39') DESC_TIPOQUOTA,'
      '  ACCONTI, CAUSALE_ASSESTAMENTO '
      'from T765_TIPOQUOTE T '
      'where DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE'
      '                     WHERE CODICE = T.CODICE'
      '                       AND DECORRENZA <= :DATA)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F00540041000100000000001C0000004400
      4500530043005F005400490050004F00510055004F0054004100010000000000}
    Left = 79
    Top = 14
  end
  object selSQL: TOracleQuery
    Optimize = False
    Left = 80
    Top = 118
  end
end
