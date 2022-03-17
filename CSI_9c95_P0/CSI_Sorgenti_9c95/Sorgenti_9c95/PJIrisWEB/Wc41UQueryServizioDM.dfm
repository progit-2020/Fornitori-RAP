object Wc41FQueryServizioDM: TWc41FQueryServizioDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object selT002: TOracleDataSet
    Optimize = False
    Filtered = True
    OnFilterRecord = selT002FilterRecord
    Left = 32
    Top = 16
  end
end
