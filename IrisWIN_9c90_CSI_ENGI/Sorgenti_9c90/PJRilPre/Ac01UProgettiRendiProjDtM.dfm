inherited Ac01FProgettiRendiProjDtM: TAc01FProgettiRendiProjDtM
  OldCreateOrder = True
  OnDestroy = nil
  Height = 84
  Width = 95
  object selT750: TOracleDataSet
    SQL.Strings = (
      'select T750.*, T750.ROWID '
      'from T750_PROGETTI_RENDICONTO T750'
      'order by CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000001000000043004F0044005F00410052004500410001000000
      0000140000004400450043004F005200520045004E005A004100010000000000
      1E0000004400450043004F005200520045004E005A0041005F00460049004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000200000005000450053004F005F0050004500520043004500
      4E005400550041004C004500010000000000}
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT750AfterScroll
    OnCalcFields = selT750CalcFields
    OnFilterRecord = selT750FilterRecord
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 16
    object selT750ID: TFloatField
      DisplayLabel = 'ID Progetto'
      FieldName = 'ID'
    end
    object selT750CODICE: TStringField
      DisplayLabel = 'Progetto'
      FieldName = 'CODICE'
    end
    object selT750DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT750DECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT750DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT750ORE_MAX: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE_MAX'
      OnValidate = selT750ORE_MAXValidate
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT750TOT_ORE_MAX: TStringField
      DisplayLabel = 'Ore assegnate'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_MAX'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT750TOT_ORE_FRUITO: TStringField
      DisplayLabel = 'Ore fruite'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT750NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 4000
    end
    object selT750CHIUSURA_DAL: TDateTimeField
      DisplayLabel = 'Inizio chiusura'
      FieldName = 'CHIUSURA_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT750CHIUSURA_AL: TDateTimeField
      DisplayLabel = 'Fine chiusura'
      FieldName = 'CHIUSURA_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT750CAUASSPRES_INCLUSE: TStringField
      DisplayLabel = 'Causali da rendicontare'
      FieldName = 'CAUASSPRES_INCLUSE'
      Size = 1000
    end
    object selT750PARTNER_NUMBER: TStringField
      DisplayLabel = 'Partner number'
      FieldName = 'PARTNER_NUMBER'
      Size = 5
    end
    object selT750NOMINATIVO_RESP: TStringField
      DisplayLabel = 'Responsabile'
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
  end
end
