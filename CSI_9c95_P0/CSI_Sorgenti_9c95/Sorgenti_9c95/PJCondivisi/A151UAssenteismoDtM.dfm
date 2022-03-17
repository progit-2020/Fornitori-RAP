inherited A151FAssenteismoDtM: TA151FAssenteismoDtM
  OldCreateOrder = True
  Height = 97
  Width = 122
  object selT151: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from T151_ASSENTEISMO t'
      'order by codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePostNoStorico
    AfterScroll = selT151AfterScroll
    Left = 40
    Top = 24
  end
end
