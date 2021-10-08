inherited A081FTimbCausMW: TA081FTimbCausMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 84
  Width = 78
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T305_CAUGIUSTIF '
      'ORDER BY CODICE')
    Optimize = False
    Left = 20
    Top = 8
  end
end
