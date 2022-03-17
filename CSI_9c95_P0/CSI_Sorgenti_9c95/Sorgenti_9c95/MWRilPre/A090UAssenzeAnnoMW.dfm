inherited A090FAssenzeAnnoMW: TA090FAssenzeAnnoMW
  OnDestroy = DataModuleDestroy
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,CUMULO_FAMILIARI '
      'FROM T265_CAUASSENZE'
      'ORDER BY CODICE'
      '')
    ReadBuffer = 200
    Optimize = False
    Left = 24
    Top = 20
  end
end
