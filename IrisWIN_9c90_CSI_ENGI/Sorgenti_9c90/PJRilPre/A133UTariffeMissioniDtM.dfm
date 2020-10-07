inherited A133FTariffeMissioniDtM: TA133FTariffeMissioniDtM
  OldCreateOrder = True
  Height = 125
  Width = 341
  object selM065: TOracleDataSet
    SQL.Strings = (
      'select M065.*,M065.rowid '
      'from M065_TARIFFE_INDENNITA M065'
      'order by M065.codice,M065.cod_tariffa,M065.decorrenza')
    Optimize = False
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selM065AfterScroll
    Left = 72
    Top = 16
    object selM065CODICE: TStringField
      FieldName = 'CODICE'
      Size = 80
    end
    object selM065COD_TARIFFA: TStringField
      FieldName = 'COD_TARIFFA'
      Size = 10
    end
    object selM065DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM065IND_GIORNALIERA: TFloatField
      FieldName = 'IND_GIORNALIERA'
    end
    object selM065desc_trasferta: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_trasferta'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object selM065DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
    object selM065VOCEPAGHE_ESENTE: TStringField
      FieldName = 'VOCEPAGHE_ESENTE'
      Size = 6
    end
    object selM065VOCEPAGHE_ASSOG: TStringField
      FieldName = 'VOCEPAGHE_ASSOG'
      Size = 6
    end
    object selM065DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
  end
  object M066: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from M066_RIDUZIONI'
      'where codice=:codice'
      'order by cod_tariffa')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 72
    Top = 64
  end
end
