inherited A129FIndennitaKmDtm: TA129FIndennitaKmDtm
  OldCreateOrder = True
  Height = 115
  Width = 183
  object SelM021: TOracleDataSet
    SQL.Strings = (
      'select m021.*, m021.rowid '
      'from m021_tipiindennitakm m021'
      'order by codice, decorrenza')
    ReadBuffer = 500
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000000E000000
      49004D0050004F00520054004F000100000000001C0000004100520052004F00
      54004F004E00440041004D0045004E0054004F00010000000000180000004300
      4F00440056004F004300450050004100470048004500010000000000}
    BeforePost = BeforePost
    OnCalcFields = SelM021CalcFields
    Left = 24
    Top = 16
    object SelM021CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object SelM021DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SelM021DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
    object SelM021DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object SelM021IMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object SelM021ARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Size = 5
    end
    object SelM021descarrotondamento: TStringField
      FieldKind = fkLookup
      FieldName = 'descarrotondamento'
      LookupKeyFields = 'COD_ARROTONDAMENTO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ARROTONDAMENTO'
      Size = 40
      Lookup = True
    end
    object SelM021CODVOCEPAGHE: TStringField
      FieldName = 'CODVOCEPAGHE'
      Size = 6
    end
  end
end
