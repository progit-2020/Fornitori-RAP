object A009FProfiliAsseDtM1: TA009FProfiliAsseDtM1
  OnCreate = A009FProfiliAsseDtM1Create
  Left = 187
  Top = 134
  Height = 96
  Width = 217
  object T262: TTable
    Active = True
    OnNewRecord = T262NewRecord
    OnPostError = T262PostError
    DatabaseName = 'Alias_Iris'
    TableName = 'T262_ProfAssAnn.DB'
    Left = 8
    Top = 8
    object T262Anno: TSmallintField
      FieldName = 'Anno'
      Required = True
    end
    object T262CodProfilo: TStringField
      FieldName = 'CodProfilo'
      Required = True
      Size = 5
    end
    object T262CodRaggr: TStringField
      FieldName = 'CodRaggr'
      Required = True
      Size = 5
    end
    object T262UMisura: TStringField
      FieldName = 'UMisura'
      Size = 1
    end
    object T262Competenza1: TStringField
      FieldName = 'Competenza1'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione1: TSmallintField
      FieldName = 'Retribuzione1'
      MaxValue = 100
    end
    object T262Competenza2: TStringField
      FieldName = 'Competenza2'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione2: TSmallintField
      FieldName = 'Retribuzione2'
      MaxValue = 100
    end
    object T262Competenza3: TStringField
      FieldName = 'Competenza3'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione3: TSmallintField
      FieldName = 'Retribuzione3'
      MaxValue = 100
    end
    object T262Competenza4: TStringField
      FieldName = 'Competenza4'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione4: TSmallintField
      FieldName = 'Retribuzione4'
      MaxValue = 100
    end
    object T262Competenza5: TStringField
      FieldName = 'Competenza5'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione5: TSmallintField
      FieldName = 'Retribuzione5'
      MaxValue = 100
    end
    object T262Competenza6: TStringField
      FieldName = 'Competenza6'
      OnValidate = T262Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T262Retribuzione6: TSmallintField
      FieldName = 'Retribuzione6'
      MaxValue = 100
    end
    object T262D_Profilo: TStringField
      FieldName = 'D_Profilo'
      Lookup = True
      LookupDataSet = T261
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodProfilo'
      Size = 40
    end
    object T262D_Raggruppamento: TStringField
      FieldName = 'D_Raggruppamento'
      Lookup = True
      LookupDataSet = T260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
    end
  end
  object T261: TTable
    Active = True
    DatabaseName = 'Alias_Iris'
    TableName = 'T261_DescProfAss.db'
    Left = 40
    Top = 8
  end
  object T260: TTable
    Active = True
    Filter = 'ContASolare = '#39'S'#39
    Filtered = True
    DatabaseName = 'Alias_Iris'
    TableName = 'T260_RaggrAssenze.DB'
    Left = 100
    Top = 8
  end
  object D261: TDataSource
    AutoEdit = False
    DataSet = T261
    Left = 68
    Top = 8
  end
  object D260: TDataSource
    AutoEdit = False
    DataSet = T260
    Left = 128
    Top = 8
  end
end
