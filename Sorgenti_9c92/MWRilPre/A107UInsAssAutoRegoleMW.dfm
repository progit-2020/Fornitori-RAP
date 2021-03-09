inherited A107FInsAssAutoRegoleMW: TA107FInsAssAutoRegoleMW
  OldCreateOrder = True
  Height = 109
  Width = 76
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE WHERE '
      'TIPOCUMULO IN ('#39'A'#39','#39'H'#39') AND'
      'INFLUCONT IN ('#39'A'#39','#39'C'#39','#39'G'#39','#39'H'#39','#39'I'#39') AND'
      'CUMULO_FAMILIARI = '#39'N'#39' AND'
      'CODCAUINIZIO IS NULL'
      'ORDER BY CODICE')
    Optimize = False
    Left = 20
    Top = 8
    object selT265CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT265: TDataSource
    AutoEdit = False
    DataSet = selT265
    Left = 20
    Top = 52
  end
end
