inherited A034FIntPagheMW: TA034FIntPagheMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object selC9ScaricoPaghe: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE'
      'FROM T200_CONTRATTI'
      'ORDER BY CODICE')
    Optimize = False
    AfterScroll = selC9ScaricoPagheAfterScroll
    Left = 48
    Top = 12
  end
  object delT193: TOracleQuery
    SQL.Strings = (
      'delete from t193_vocipaghe_parametri'
      'where cod_interfaccia = :codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 128
    Top = 8
  end
end
