inherited B021FTimbratureDM: TB021FTimbratureDM
  OldCreateOrder = True
  Height = 76
  Width = 191
  object selVT100: TOracleDataSet
    SQL.Strings = (
      
        'select VT100.BADGE, VT100.MATRICOLA, VT100.DATA, VT100.ORA, VT10' +
        '0.VERSO, VT100.RILEVATORE, VT100.CAUSALE'
      'from   USR_VT100_FIRLAB VT100,'
      '       T030_ANAGRAFICO T030,'
      '       T430_STORICO T430'
      'where  VT100.PROGRESSIVO = T430.PROGRESSIVO'
      'and    T030.PROGRESSIVO = T430.PROGRESSIVO'
      
        'and    trunc(sysdate) between T430.DATADECORRENZA and T430.DATAF' +
        'INE'
      
        'and    VT100.DATA between :INIZIO and :FINE - 1 /* correzione di' +
        ' un giorno per Firlab */'
      ':FILTRO_ANAG'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00460049004C00540052004F005F0041004E00
      410047000100000000000000000000000E0000003A0049004E0049005A004900
      4F000C00000000000000000000000A0000003A00460049004E0045000C000000
      0000000000000000}
    Left = 112
    Top = 16
  end
end
