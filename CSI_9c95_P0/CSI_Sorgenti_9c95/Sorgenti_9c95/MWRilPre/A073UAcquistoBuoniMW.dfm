inherited A073FAcquistoBuoniMW: TA073FAcquistoBuoniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 304
  object BuoniPasto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 80
  end
  object selT680: TOracleDataSet
    SQL.Strings = (
      
        'select last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39')) ' +
        'DATA,NVL(BUONIPASTO,0) + NVL(VARBUONIPASTO,0) BUONIPASTO'
      'from T680_BUONIMENSILI'
      'where PROGRESSIVO=:PROGRESSIVO'
      
        'and last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39'))>:DA' +
        'TADAL'
      
        'and last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39'))<=:D' +
        'ATAAL'
      'order by ANNO,MESE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004400
      41004C000C00000000000000000000000E0000003A0044004100540041004100
      4C000C0000000000000000000000}
    Left = 96
    Top = 80
  end
  object selT690: TOracleDataSet
    SQL.Strings = (
      'select T690.data_magazzino, T691.data_scadenza, T690.buonipasto '
      'from T690_ACQUISTOBUONI T690, T691_MAGAZZINOBUONI T691'
      'where T690.PROGRESSIVO=:PROGRESSIVO'
      'and T690.DATA <= :DATA'
      'and T690.DATA_MAGAZZINO = T691.DATA_ACQUISTO(+)'
      'order by T690.data_magazzino')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 208
    Top = 80
  end
  object selT691: TOracleDataSet
    SQL.Strings = (
      'select * from t691_magazzinobuoni'
      'order by DATA_ACQUISTO DESC')
    Optimize = False
    Left = 24
    Top = 8
  end
  object selT690DataInizio: TOracleDataSet
    SQL.Strings = (
      'select DATA from T690_ACQUISTOBUONI'
      'where PROGRESSIVO=:PROGRESSIVO'
      'and DATA<=:DATA'
      'order by DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 96
    Top = 8
  end
  object selT690_IDBLOCCHETTI: TOracleDataSet
    SQL.Strings = (
      
        'select T690.PROGRESSIVO,T690.DATA,T030.MATRICOLA,T030.COGNOME,T0' +
        '30.NOME,T690.BUONIPASTO,T690.TICKET,T690.ID_BLOCCHETTI,T690.ROWI' +
        'D'
      'from T690_ACQUISTOBUONI T690, T030_ANAGRAFICO T030'
      'where (:IDRIGA is null or T690.ROWID <> :IDRIGA)'
      
        'and '#39','#39'||replace(T690.ID_BLOCCHETTI,'#39' '#39','#39#39')||'#39','#39' like '#39'%,'#39'||:ID_' +
        'BLOCCHETTO||'#39',%'#39
      'and T030.PROGRESSIVO = T690.PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00490044005200490047004100050000000000
      0000000000001C0000003A00490044005F0042004C004F004300430048004500
      540054004F00050000000000000000000000}
    Left = 208
    Top = 8
  end
end
