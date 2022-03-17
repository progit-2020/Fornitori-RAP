inherited A024FLimitiIndDtm: TA024FLimitiIndDtm
  OldCreateOrder = True
  Height = 143
  Width = 183
  object selT165: TOracleDataSet
    SQL.Strings = (
      'select T165.*, T165.ROWID'
      '  from T165_LIMITI_INDORARIA_TESTA T165'
      ' where T165.CODICE = :CODICE'
      ' order by T165.CODICE, T165.DECORRENZA desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = selT165AfterCancel
    AfterScroll = selT165AfterScroll
    OnNewRecord = OnNewRecord
    Left = 21
    Top = 14
    object selT165ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT165CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      ReadOnly = True
      Size = 5
    end
    object selT165DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selT165DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
  end
  object selT166: TOracleDataSet
    SQL.Strings = (
      'SELECT T166.*, T166.ROWID'
      '  FROM T166_LIMITI_INDORARIA_DETT T166'
      ' WHERE T166.ID = :ID'
      ' ORDER BY T166.TURNI, T166.ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    CachedUpdates = True
    OnNewRecord = selT166NewRecord
    Left = 84
    Top = 14
    object selT166ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT166TURNI: TIntegerField
      DisplayLabel = 'Turni'
      FieldName = 'TURNI'
    end
    object selT166GGLAV: TIntegerField
      DisplayLabel = 'Giorni lavorati'
      FieldName = 'GGLAV'
    end
    object selT166TIPO_PT: TStringField
      DisplayLabel = 'Tipo part-time'
      FieldName = 'TIPO_PT'
      Size = 1
    end
    object selT166PERC_PT: TFloatField
      DisplayLabel = 'Percentuale part-time'
      FieldName = 'PERC_PT'
    end
    object selT166ORE_MAX: TStringField
      DisplayLabel = 'Ore max'
      FieldName = 'ORE_MAX'
      Size = 6
    end
  end
end
