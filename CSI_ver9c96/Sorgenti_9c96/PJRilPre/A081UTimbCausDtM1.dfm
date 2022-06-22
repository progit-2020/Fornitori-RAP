object A081FTimbCausDtM1: TA081FTimbCausDtM1
  OldCreateOrder = True
  OnCreate = A081FTimbCausDtM1Create
  OnDestroy = A081FTimbCausDtM1Destroy
  Height = 117
  Width = 276
  object D010: TDataSource
    Left = 24
    Top = 8
  end
  object QGiustificativiAssenza: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Left = 124
    Top = 8
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 228
    Top = 8
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 56
  end
end
