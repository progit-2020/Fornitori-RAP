inherited S746FStatiAvanzamentoMW: TS746FStatiAvanzamentoMW
  OldCreateOrder = True
  Height = 303
  Width = 495
  object selSG741: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg741_regole_valutazioni'
      'where :data between decorrenza and decorrenza_fine'
      'order by codice')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    Left = 88
    Top = 16
  end
  object dSG741: TDataSource
    DataSet = selSG741
    Left = 88
    Top = 64
  end
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg746_stati_avanzamento'
      'where :data between decorrenza and decorrenza_fine'
      'and codregola = :codregola'
      'and codice < :codice'
      'union'
      'select :codice, :descrizione'
      'from dual'
      'where :codice <> 0'
      'order by codice, descrizione')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000140000003A0043004F0044005200450047004F004C004100050000000000
      0000000000000E0000003A0043004F0044004900430045000300000000000000
      00000000180000003A004400450053004300520049005A0049004F004E004500
      050000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 144
    Top = 16
  end
  object dSG746: TDataSource
    DataSet = selSG746
    Left = 144
    Top = 64
  end
end
