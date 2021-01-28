object A018FRaggrPresDtM1: TA018FRaggrPresDtM1
  OldCreateOrder = True
  OnCreate = A018FRaggrPresDtM1Create
  OnDestroy = A018FRaggrPresDtM1Destroy
  Height = 87
  Width = 261
  object T270: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T270.*,T270.ROWID FROM T270_RAGGRPRESENZE T270 ORDER BY C' +
        'ODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    BeforePost = T270BeforePost
    AfterPost = T270AfterPost
    BeforeDelete = T270BeforeDelete
    AfterDelete = T270AfterDelete
    OnFilterRecord = T270FilterRecord
    Left = 140
    Top = 8
    object T270Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T270Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object T270CodInterno: TStringField
      FieldName = 'CodInterno'
      Size = 1
    end
    object T270IndNotturna: TStringField
      FieldName = 'IndNotturna'
      Size = 1
    end
    object T270IndFestiva: TStringField
      FieldName = 'IndFestiva'
      Size = 1
    end
    object T270INDPRESENZA: TStringField
      FieldName = 'INDPRESENZA'
      Size = 1
    end
  end
end
