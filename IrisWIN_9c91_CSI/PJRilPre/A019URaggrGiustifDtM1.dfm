object A019FRaggrGiustifDtM1: TA019FRaggrGiustifDtM1
  OldCreateOrder = True
  OnCreate = A019FRaggrGiustifDtM1Create
  OnDestroy = A019FRaggrGiustifDtM1Destroy
  Height = 87
  Width = 218
  object T300: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T300.*,T300.ROWID FROM T300_RAGGRGIUSTIF T300 ORDER BY CO' +
        'DICE')
    Optimize = False
    BeforePost = T300BeforePost
    AfterPost = T300AfterPost
    BeforeDelete = T300BeforeDelete
    AfterDelete = T300AfterDelete
    OnNewRecord = T300NewRecord
    Left = 120
    Top = 8
    object T300Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T300Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object T300CodInterno: TStringField
      FieldName = 'CodInterno'
      Size = 1
    end
  end
end
