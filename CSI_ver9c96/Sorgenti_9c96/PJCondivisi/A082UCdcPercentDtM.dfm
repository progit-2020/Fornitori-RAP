inherited A082FCdcPercentDtM: TA082FCdcPercentDtM
  OldCreateOrder = True
  Height = 72
  Width = 78
  object selT433: TOracleDataSet
    SQL.Strings = (
      'SELECT T433.*,T433.ROWID FROM T433_CDC_PERCENT T433'
      'WHERE PROGRESSIVO = :Progressivo'
      'ORDER BY DECORRENZA, CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E0045000100000000000C00000043004F0044004900430045000100
      0000000016000000500045005200430045004E005400550041004C0045000100
      00000000}
    QueryAllRecords = False
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = selT433CalcFields
    OnNewRecord = selT433NewRecord
    Left = 16
    Top = 10
    object selT433PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      DisplayWidth = 8
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selT433DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 30
      FieldName = 'DECORRENZA'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object selT433DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 30
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selT433CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 80
      FieldName = 'CODICE'
      Required = True
      OnSetText = selT433CODICESetText
      OnValidate = selT433CODICEValidate
      Size = 80
    end
    object selT433CODICE_DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'CODICE_DESCRIZIONE'
      Size = 100
      Calculated = True
    end
    object selT433PERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale (%)'
      DisplayWidth = 30
      FieldName = 'PERCENTUALE'
    end
  end
end
