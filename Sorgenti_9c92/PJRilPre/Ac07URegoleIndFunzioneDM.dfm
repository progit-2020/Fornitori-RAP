inherited Ac07FRegoleIndFunzioneDM: TAc07FRegoleIndFunzioneDM
  OldCreateOrder = True
  Height = 134
  Width = 226
  object selCSI004: TOracleDataSet
    SQL.Strings = (
      'select CSI004.*, CSI004.ROWID '
      'from CSI004_INDFUNZIONE CSI004'
      'order by CODICE, CONTRATTO, DECORRENZA')
    Optimize = False
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'CSI004_ID'
    SequenceField.ApplyMoment = amOnNewRecord
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
    AfterScroll = selCSI004AfterScroll
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 16
    object selCSI004CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selCSI004D_CODICE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CODICE'
      Size = 100
      Calculated = True
    end
    object selCSI004CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object selCSI004D_CONTRATTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CONTRATTO'
      Size = 40
      Calculated = True
    end
    object selCSI004DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selCSI004DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selCSI004ID: TFloatField
      FieldName = 'ID'
    end
    object selCSI004ASSENZE_TOLLERATE: TStringField
      FieldName = 'ASSENZE_TOLLERATE'
      Size = 2000
    end
  end
  object dsrCodice: TDataSource
    Left = 95
    Top = 68
  end
  object dsrT200: TDataSource
    Left = 159
    Top = 68
  end
end
