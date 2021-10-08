inherited P150FSetupMW: TP150FSetupMW
  OldCreateOrder = True
  object T480_COMUNI: TOracleDataSet
    SQL.Strings = (
      'Select CodCatastale,Citta,Cap,Provincia,Codice from T480_Comuni '
      ':ORDERBY ')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 56
    Top = 66
    object T480_COMUNICODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object T480_COMUNICITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object T480_COMUNICAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object T480_COMUNIPROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object T480_COMUNICODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object Q030: TOracleDataSet
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
    Left = 56
    Top = 8
    object Q030COD_VALUTA: TStringField
      DisplayWidth = 14
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object Q030DESCRIZIONE: TStringField
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
    end
  end
  object D030: TDataSource
    DataSet = Q030
    Left = 82
    Top = 8
  end
  object Q130: TOracleDataSet
    SQL.Strings = (
      
        'SELECT P130.* FROM P130_PAGAMENTI P130 ORDER BY P130.COD_PAGAMEN' +
        'TO')
    Optimize = False
    Left = 128
    Top = 8
    object Q130COD_PAGAMENTO: TStringField
      DisplayWidth = 7
      FieldName = 'COD_PAGAMENTO'
      Required = True
      Size = 5
    end
    object Q130DESCRIZIONE: TStringField
      DisplayWidth = 60
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object D130: TDataSource
    DataSet = Q130
    Left = 156
    Top = 8
  end
  object D480: TDataSource
    DataSet = T480_COMUNI
    Left = 138
    Top = 72
  end
end
