inherited A144FComuniMedLegaliDtm: TA144FComuniMedLegaliDtm
  OldCreateOrder = True
  Height = 131
  Width = 468
  object selT486: TOracleDataSet
    SQL.Strings = (
      'select T486.*, T486.ROWID'
      'from   T486_COMUNI_MEDLEGALI T486'
      'order by T486.MED_LEGALE'
      '')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001400000043004F0044005F0043004F004D0055004E004500
      010000000000140000004D00450044005F004C004500470041004C0045000100
      00000000}
    BeforePost = BeforePostNoStorico
    Left = 48
    Top = 32
    object selT486COD_COMUNE: TStringField
      DisplayLabel = 'Cod. comune'
      FieldName = 'COD_COMUNE'
      Required = True
      Size = 6
    end
    object selT486MED_LEGALE: TStringField
      DisplayLabel = 'Cod. med. legale'
      DisplayWidth = 10
      FieldName = 'MED_LEGALE'
      OnChange = selT486MED_LEGALEChange
      Size = 10
    end
    object selT486D_COMUNE: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_COMUNE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE'
      Size = 40
      Lookup = True
    end
    object selT486D_MEDLEGALE: TStringField
      DisplayLabel = 'Medicina legale'
      DisplayWidth = 60
      FieldKind = fkLookup
      FieldName = 'D_MED_LEGALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MED_LEGALE'
      Size = 60
      Lookup = True
    end
  end
end
