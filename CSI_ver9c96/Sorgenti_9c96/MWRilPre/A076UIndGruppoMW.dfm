inherited A076FIndGRuppoMW: TA076FIndGRuppoMW
  OldCreateOrder = True
  object Q163: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      '  FROM T163_CODICIINDENNITA'
      ' ORDER BY CODICE')
    Optimize = False
    Left = 72
    Top = 12
  end
  object selCodice2: TOracleDataSet
    Optimize = False
    AfterOpen = selCodice2AfterOpen
    Left = 72
    Top = 60
  end
  object selCodice1: TOracleDataSet
    Optimize = False
    AfterOpen = selCodice2AfterOpen
    Left = 16
    Top = 60
  end
  object selT161: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DECORRENZA FROM T161_INDGRUPPO ')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000001000000140000004400450043004F005200520045004E005A004100
      010000000000}
    Left = 152
    Top = 12
  end
end
