inherited P032FCambiDtM: TP032FCambiDtM
  OldCreateOrder = True
  Height = 151
  Width = 274
  object selP032: TOracleDataSet
    SQL.Strings = (
      'SELECT P032.*, ROWID FROM P032_CAMBI P032'
      'ORDER BY COD_VALUTA1, COD_VALUTA2, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePost
    AfterScroll = selP032AfterScroll
    Left = 8
    Top = 8
    object selP032DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      OnChange = selP032DECORRENZAChange
    end
    object selP032DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selP032COD_VALUTA1: TStringField
      DisplayLabel = 'Da valuta'
      FieldName = 'COD_VALUTA1'
      Required = True
      Size = 10
    end
    object selP032D_CodVal1: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodVal1'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA1'
      Size = 40
      Lookup = True
    end
    object selP032COD_VALUTA2: TStringField
      DisplayLabel = 'A valuta'
      FieldName = 'COD_VALUTA2'
      Required = True
      Size = 10
    end
    object selP032D_CodVal2: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_CodVal2'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA2'
      Size = 40
      Lookup = True
    end
    object selP032COEFF_CALCOLI: TFloatField
      DisplayLabel = 'Coefficiente di cambio'
      FieldName = 'COEFF_CALCOLI'
    end
  end
end
