inherited P050FArrotondamentiMW: TP050FArrotondamentiMW
  OldCreateOrder = True
  Height = 193
  Width = 222
  object Q030: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_VALUTA, DESCRIZIONE FROM P030_VALUTE T1'
      'WHERE DECORRENZA ='
      '  (SELECT MAX(DECORRENZA) FROM P030_VALUTE WHERE '
      '     DECORRENZA <= :DECORRENZA AND '
      '     COD_VALUTA = T1.COD_VALUTA)'
      'ORDER BY COD_VALUTA'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 26
    Top = 11
    object Q030COD_VALUTA: TStringField
      DisplayWidth = 14
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object Q030DESCRIZIONE: TStringField
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object D030: TDataSource
    DataSet = Q030
    Left = 70
    Top = 11
  end
end
