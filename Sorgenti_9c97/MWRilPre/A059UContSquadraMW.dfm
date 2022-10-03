inherited A059FContSquadraMW: TA059FContSquadraMW
  Height = 76
  Width = 188
  object D600B: TDataSource
    DataSet = Q600B
    Left = 112
    Top = 4
  end
  object Q600: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T600_SQUADRE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 8
    Top = 4
    object Q600CODICE: TStringField
      DisplayWidth = 6
      FieldName = 'CODICE'
      Origin = 'T600_SQUADRE.CODICE'
      Size = 5
    end
    object Q600DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T600_SQUADRE.DESCRIZIONE'
      Size = 40
    end
  end
  object D600: TDataSource
    DataSet = Q600
    Left = 36
    Top = 4
  end
  object Q600B: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T600_SQUADRE'
      'ORDER BY CODICE'
      '')
    Optimize = False
    Left = 76
    Top = 4
    object Q600BCODICE: TStringField
      DisplayWidth = 6
      FieldName = 'CODICE'
      Origin = 'T600_SQUADRE.CODICE'
      Size = 5
    end
    object Q600BDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T600_SQUADRE.DESCRIZIONE'
      Size = 40
    end
  end
end
