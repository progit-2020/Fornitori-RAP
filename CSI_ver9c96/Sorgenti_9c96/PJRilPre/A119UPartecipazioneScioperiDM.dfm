inherited A119FPartecipazioneScioperiDM: TA119FPartecipazioneScioperiDM
  OldCreateOrder = True
  Height = 76
  Width = 93
  object selT250: TOracleDataSet
    SQL.Strings = (
      'select T250.*, T250.ROWID'
      'from   T250_SCIOPERI T250'
      'order by T250.DATA desc')
    Optimize = False
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T250_ID'
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001400
      000043004F0044005F0043004F004D0055004E00450001000000000012000000
      49004E0044004900520049005A005A004F000100000000000600000043004100
      500001000000000010000000540045004C00450046004F004E004F0001000000
      00000A00000045004D00410049004C00010000000000}
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    BeforeDelete = BeforeDelete
    AfterScroll = selT250AfterScroll
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 16
    object selT250ID: TFloatField
      DisplayLabel = '(**) ID'
      DisplayWidth = 6
      FieldName = 'ID'
      Visible = False
    end
    object selT250DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT250CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT250TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldName = 'TIPOGIUST'
      Size = 1
    end
    object selT250DAORE: TStringField
      DisplayLabel = 'Da ore'
      FieldName = 'DAORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT250AORE: TStringField
      DisplayLabel = 'A ore'
      FieldName = 'AORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT250SELEZIONE_ANAGRAFICA: TStringField
      DisplayLabel = 'Selezione anagrafica'
      DisplayWidth = 25
      FieldName = 'SELEZIONE_ANAGRAFICA'
      Size = 2000
    end
    object selT250GG_NOTIFICA: TIntegerField
      DisplayLabel = 'GG notifica'
      FieldName = 'GG_NOTIFICA'
      MaxValue = 99
    end
  end
end
