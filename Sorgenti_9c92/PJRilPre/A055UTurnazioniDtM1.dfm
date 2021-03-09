object A055FTurnazioniDtM1: TA055FTurnazioniDtM1
  OldCreateOrder = True
  OnCreate = A055FTurnazioniDtM1Create
  OnDestroy = A055FTurnazioniDtM1Destroy
  Height = 67
  Width = 66
  object Q640: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T640.*,T640.ROWID FROM T640_TURNAZIONI T640 ORDER BY CODI' +
        'CE')
    Optimize = False
    CachedUpdates = True
    BeforeInsert = Q640BeforeInsert
    BeforePost = Q640BeforePost
    AfterPost = Q640AfterPost
    AfterCancel = Q640AfterCancel
    BeforeDelete = Q640BeforeDelete
    AfterDelete = Q640AfterDelete
    Left = 12
    Top = 8
    object Q640CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T640_TURNAZIONI.CODICE'
      Required = True
      Size = 5
    end
    object Q640DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T640_TURNAZIONI.DESCRIZIONE'
      Size = 40
    end
  end
end
