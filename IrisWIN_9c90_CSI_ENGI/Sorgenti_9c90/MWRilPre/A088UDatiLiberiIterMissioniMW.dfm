inherited A088FDatiLiberiIterMissioniMW: TA088FDatiLiberiIterMissioniMW
  OldCreateOrder = True
  Height = 115
  Width = 318
  object selT430Colonne: TOracleDataSet
    SQL.Strings = (
      'select column_name from cols '
      'where  table_name = '#39'T430_STORICO'#39
      'order by column_name')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 48
    Top = 16
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select distinct NOME'
      'from   T002_QUERYPERSONALIZZATE'
      'order by NOME')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = selT002FilterRecord
    Left = 144
    Top = 16
  end
end
