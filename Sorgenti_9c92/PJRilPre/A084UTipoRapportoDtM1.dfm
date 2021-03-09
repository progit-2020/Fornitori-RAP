object A084FTipoRapportoDtM1: TA084FTipoRapportoDtM1
  OldCreateOrder = True
  OnCreate = A076FIndGruppoDtM1Create
  OnDestroy = A084FTipoRapportoDtM1Destroy
  Height = 88
  Width = 241
  object Q450: TOracleDataSet
    SQL.Strings = (
      'SELECT T450.*,T450.ROWID FROM T450_TIPORAPPORTO T450'
      'ORDER BY CODICE')
    Optimize = False
    CachedUpdates = True
    BeforePost = Q450BeforePost
    AfterPost = Q450AfterPost
    AfterCancel = Q450AfterCancel
    BeforeDelete = Q450BeforeDelete
    AfterDelete = Q450AfterDelete
    OnNewRecord = Q450NewRecord
    Left = 96
    Top = 8
  end
end
