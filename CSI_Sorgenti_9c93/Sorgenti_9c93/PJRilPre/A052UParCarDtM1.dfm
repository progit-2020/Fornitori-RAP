object A052FParCarDtM1: TA052FParCarDtM1
  OldCreateOrder = True
  OnCreate = A052FParCarDtM1Create
  OnDestroy = A052FParCarDtM1Destroy
  Height = 235
  Width = 284
  object selT950: TOracleDataSet
    SQL.Strings = (
      'SELECT T950.*,T950.ROWID FROM T950_STAMPACARTELLINO T950'
      'ORDER BY CODICE')
    ReadBuffer = 10
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    BeforeInsert = BDEQ950BeforeInsert
    BeforePost = selT950BeforePost
    AfterPost = BDEQ950AfterPost
    BeforeDelete = BDEQ950BeforeDelete
    AfterDelete = selT950AfterDelete
    AfterScroll = selT950AfterScroll
    OnFilterRecord = selT950FilterRecord
    Left = 16
    Top = 8
  end
end
