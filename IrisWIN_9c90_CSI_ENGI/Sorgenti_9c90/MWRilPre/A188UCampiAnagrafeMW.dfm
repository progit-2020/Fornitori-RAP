inherited A188FCampiAnagrafeMW: TA188FCampiAnagrafeMW
  OldCreateOrder = True
  Height = 86
  Width = 149
  object selCols: TOracleDataSet
    SQL.Strings = (
      'SELECT TABLE_NAME,COLUMN_NAME,DATA_DEFAULT FROM COLS'
      
        'WHERE TABLE_NAME IN ('#39'T030_ANAGRAFICO'#39','#39'T430_STORICO'#39','#39'P430_ANAG' +
        'RAFICO'#39')')
    Optimize = False
    Left = 64
    Top = 12
  end
  object updI010: TOracleQuery
    SQL.Strings = (
      'UPDATE I010_CAMPIANAGRAFICI '
      '   SET VAL_DEFAULT = :VAL_DEFAULT '
      ' WHERE NOME_CAMPO = :NOME_CAMPO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00560041004C005F0044004500460041005500
      4C005400050000000000000000000000160000003A004E004F004D0045005F00
      430041004D0050004F00050000000000000000000000}
    Left = 20
    Top = 12
  end
end
