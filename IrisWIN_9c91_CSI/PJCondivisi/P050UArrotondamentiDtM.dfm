inherited P050FArrotondamentiDtM: TP050FArrotondamentiDtM
  OldCreateOrder = True
  Height = 118
  Width = 218
  object Q050K: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.*, P050.ROWID FROM P050_KARROTONDAMENTI P050 '
      'ORDER BY COD_ARROTONDAMENTO')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforeDelete = BeforeDelete
    AfterScroll = Q050KAfterScroll
    Left = 12
    Top = 8
    object Q050KCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod.arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
  end
  object Q050: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM P050_ARROTONDAMENTI P050'
      'WHERE COD_ARROTONDAMENTO=:COD_ARROTONDAMENTO'
      'ORDER BY COD_VALUTA,DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000260000003A0043004F0044005F004100520052004F005400
      4F004E00440041004D0045004E0054004F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 60
    Top = 8
    object Q050COD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod.arrotondamento'
      DisplayWidth = 5
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Visible = False
      Size = 5
    end
    object Q050DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q050DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q050COD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      DisplayWidth = 6
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object Q050DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q050VALORE: TFloatField
      DisplayLabel = 'Valore'
      DisplayWidth = 10
      FieldName = 'VALORE'
    end
    object Q050TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 2
    end
  end
  object D050: TDataSource
    DataSet = Q050
    Left = 108
    Top = 8
  end
end
