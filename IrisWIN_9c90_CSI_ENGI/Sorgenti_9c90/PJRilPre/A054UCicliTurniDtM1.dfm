object A054FCicliTurniDtM1: TA054FCicliTurniDtM1
  OldCreateOrder = True
  OnCreate = A054FCicliTurniDtM1Create
  OnDestroy = A054FCicliTurniDtM1Destroy
  Height = 68
  Width = 78
  object Q610: TOracleDataSet
    SQL.Strings = (
      'select T610.*, T610.ROWID '
      '  from T610_CICLI T610 '
      ' order by T610.CODICE')
    Optimize = False
    CachedUpdates = True
    BeforeInsert = Q610BeforeInsert
    BeforePost = Q610BeforePost
    AfterPost = Q610AfterPost
    AfterCancel = Q610AfterCancel
    BeforeDelete = Q610BeforeDelete
    AfterDelete = Q610AfterDelete
    Left = 16
    Top = 8
    object Q610CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T610_CICLI.CODICE'
      Required = True
      Size = 5
    end
    object Q610DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T610_CICLI.DESCRIZIONE'
      Size = 40
    end
  end
end
