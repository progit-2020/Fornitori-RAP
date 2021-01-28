inherited P050FArrotondamentiValuteDtM: TP050FArrotondamentiValuteDtM
  OldCreateOrder = True
  Height = 95
  Width = 58
  object Q050: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.*,P050.ROWID FROM P050_ARROTONDAMENTI P050'
      'WHERE COD_ARROTONDAMENTO=:COD_ARROTONDAMENTO'
      'ORDER BY COD_ARROTONDAMENTO, COD_VALUTA, DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000260000003A0043004F0044005F004100520052004F005400
      4F004E00440041004D0045004E0054004F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePost
    AfterDelete = AfterDelete
    OnCalcFields = Q050CalcFields
    OnNewRecord = OnNewRecord
    Left = 8
    Top = 8
    object Q050COD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod.arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object Q050DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      OnChange = Q050DECORRENZAChange
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q050DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q050COD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object Q050DES_VALUTA: TStringField
      DisplayLabel = 'Desc.valuta'
      FieldKind = fkCalculated
      FieldName = 'DES_VALUTA'
      Calculated = True
    end
    object Q050DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q050VALORE: TFloatField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
    end
    object Q050TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 2
    end
  end
end
