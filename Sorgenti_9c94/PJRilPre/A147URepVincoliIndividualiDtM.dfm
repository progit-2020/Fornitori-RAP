inherited A147FRepVincoliIndividualiDtM: TA147FRepVincoliIndividualiDtM
  OldCreateOrder = True
  Height = 73
  Width = 76
  object selT385: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from T385_VINCOLI_REPERIB t'
      'where tipologia = :TIPO'
      'and progressivo = :PROGRESSIVO'
      'order by decorrenza, giorno')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A005400490050004F0005000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E004500010000000000120000005400490050004F004C004F004700
      490041000100000000000C000000470049004F0052004E004F00010000000000
      0A0000005400550052004E004900010000000000160000004400490053005000
      4F004E004900420049004C0045000100000000001A00000042004C004F004300
      430041005F005000490041004E0049004600010000000000}
    BeforePost = selT385BeforePost
    AfterPost = selT385AfterPost
    AfterScroll = selT385AfterScroll
    OnCalcFields = selT385CalcFields
    OnNewRecord = selT385NewRecord
    Left = 24
    Top = 16
    object selT385PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT385DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT385DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT385TIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Required = True
      Visible = False
      Size = 1
    end
    object selT385GIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'GIORNO'
      Required = True
      Size = 2
    end
    object selT385DescGiorno: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescGiorno'
      Size = 50
      Calculated = True
    end
    object selT385DISPONIBILE: TStringField
      DisplayLabel = 'Dispon.'
      FieldName = 'DISPONIBILE'
      Size = 1
    end
    object selT385BLOCCA_PIANIF: TStringField
      DisplayLabel = 'Blocco'
      FieldName = 'BLOCCA_PIANIF'
      Size = 1
    end
    object selT385TURNI: TStringField
      DisplayLabel = 'Turni'
      DisplayWidth = 100
      FieldName = 'TURNI'
      Size = 1000
    end
  end
end
