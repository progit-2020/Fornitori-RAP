inherited A126FBloccoRiepiloghiMW: TA126FBloccoRiepiloghiMW
  OldCreateOrder = True
  Height = 135
  Width = 278
  object scrBloccaRiep: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  T180P_BLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al,:utent' +
        'e);'
      '  commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      00000E0000003A005500540045004E0054004500050000000000000000000000}
    Left = 25
    Top = 56
  end
  object scrSbloccaRiep: TOracleQuery
    SQL.Strings = (
      'begin'
      '  T180P_SBLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al);'
      '  commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      0000}
    Left = 105
    Top = 56
  end
  object selT195: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MIN(DATARIF) DR1,MAX(DATARIF) DR2,MAX(DATA_CASSA) DC,COUN' +
        'T(*) TOT '
      'FROM T195_VOCIVARIABILI '
      
        'WHERE DATA_CASSA = (SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABI' +
        'LI)')
    Optimize = False
    Left = 25
    Top = 8
  end
  object selT199: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA_CASSA,ROWID FROM T199_DATACASSA')
    Optimize = False
    Left = 76
    Top = 8
  end
  object scrT193: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  update t193_vocipaghe_parametri set dal = add_months(dal,:mese' +
        ') '
      '  where dal is not null and autoinc_dal = '#39'S'#39';'
      '  update t193_vocipaghe_parametri set al = add_months(al,:mese) '
      '  where al is not null and autoinc_al = '#39'S'#39';'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004D0045005300450003000000000000000000
      0000}
    Left = 175
    Top = 56
  end
  object delT195Cassa: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T195_VOCIVARIABILI'
      'WHERE '
      'DATA_CASSA = (SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI)')
    Optimize = False
    Left = 144
    Top = 8
  end
end
