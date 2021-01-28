inherited P501FCudSetupMW: TP501FCudSetupMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 108
  Width = 163
  object selP030: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_VALUTA, DESCRIZIONE FROM P030_VALUTE T1'
      'WHERE DECORRENZA ='
      '  (SELECT MAX(DECORRENZA) FROM P030_VALUTE WHERE '
      '     DECORRENZA <= :DECORRENZA AND '
      '     COD_VALUTA = T1.COD_VALUTA)'
      'ORDER BY COD_VALUTA')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 17
    Top = 8
    object selP030COD_VALUTA: TStringField
      DisplayWidth = 14
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP030DESCRIZIONE: TStringField
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
    end
  end
  object dsrI010: TDataSource
    AutoEdit = False
    Left = 72
    Top = 8
  end
end
