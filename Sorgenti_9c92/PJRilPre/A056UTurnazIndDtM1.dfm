object A056FTurnazIndDtM1: TA056FTurnazIndDtM1
  OldCreateOrder = True
  OnCreate = A056FTurnazIndDtM1Create
  OnDestroy = A056FTurnazIndDtM1Destroy
  Height = 78
  Width = 98
  object D620: TDataSource
    DataSet = Q620
    OnStateChange = D620StateChange
    Left = 44
    Top = 12
  end
  object Q620: TOracleDataSet
    SQL.Strings = (
      'SELECT T620.*,T620.ROWID '
      '  FROM T620_TURNAZIND T620'
      ' WHERE PROGRESSIVO = :PROGRESSIVO'
      ' ORDER BY DATA DESC')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    CachedUpdates = True
    BeforeInsert = Q620BeforeInsert
    AfterPost = Q620AfterPost
    BeforeDelete = Q620BeforeDelete
    AfterDelete = Q620AfterDelete
    Left = 16
    Top = 12
    object Q620PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T620_TURNAZIND.PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object Q620DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = 'T620_TURNAZIND.DATA'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q620TURNAZIONE: TStringField
      DisplayLabel = 'Turnazione'
      FieldName = 'TURNAZIONE'
      Origin = 'T620_TURNAZIND.TURNAZIONE'
      ReadOnly = True
      Size = 5
    end
    object Q620PARTENZA: TFloatField
      DisplayLabel = 'Partenza'
      FieldName = 'PARTENZA'
      Origin = 'T620_TURNAZIND.PARTENZA'
    end
    object Q620PIANIF_DA_CALENDARIO: TStringField
      DisplayLabel = 'Pianificazione da calendario'
      FieldName = 'PIANIF_DA_CALENDARIO'
      OnValidate = Q620PIANIF_DA_CALENDARIOValidate
      Size = 1
    end
    object Q620VERIFICA_TURNI: TStringField
      DisplayLabel = 'Verifica su gg lav.'
      DisplayWidth = 5
      FieldName = 'VERIFICA_TURNI'
      Size = 1
    end
    object Q620VERIFICA_RIPOSI: TStringField
      DisplayLabel = 'Verifica riposi'
      DisplayWidth = 5
      FieldName = 'VERIFICA_RIPOSI'
      Size = 1
    end
  end
end
