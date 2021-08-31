object A010FProfAsseIndDtM1: TA010FProfAsseIndDtM1
  OldCreateOrder = True
  OnCreate = L007FProfAsseIndDtM1Create
  OnDestroy = A010FProfAsseIndDtM1Destroy
  Height = 84
  Width = 220
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 75
    Top = 8
  end
  object T263: TOracleDataSet
    SQL.Strings = (
      'SELECT T263.*,T263.ROWID '
      '  FROM T263_PROFASSIND T263'
      ' WHERE T263.PROGRESSIVO = :PROGRESSIVO '
      ' ORDER BY T263.DAL DESC, T263.AL DESC, T263.CODRAGGR')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    AfterInsert = T263AfterInsert
    BeforePost = T263BeforePost
    AfterPost = T263AfterPost
    BeforeDelete = T263BeforeDelete
    AfterDelete = T263AfterDelete
    OnNewRecord = T263NewRecord
    Left = 12
    Top = 8
    object T263Progressivo: TFloatField
      FieldName = 'Progressivo'
    end
    object T263Anno: TFloatField
      FieldName = 'Anno'
    end
    object T263CodRaggr: TStringField
      FieldName = 'CodRaggr'
      Required = True
      OnChange = T263CodRaggrChange
      Size = 5
    end
    object T263UMisura: TStringField
      FieldName = 'UMisura'
      Size = 1
    end
    object T263Competenza1: TStringField
      FieldName = 'Competenza1'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione1: TFloatField
      FieldName = 'Retribuzione1'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza2: TStringField
      FieldName = 'Competenza2'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione2: TFloatField
      FieldName = 'Retribuzione2'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza3: TStringField
      FieldName = 'Competenza3'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione3: TFloatField
      FieldName = 'Retribuzione3'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza4: TStringField
      FieldName = 'Competenza4'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione4: TFloatField
      FieldName = 'Retribuzione4'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza5: TStringField
      FieldName = 'Competenza5'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione5: TFloatField
      FieldName = 'Retribuzione5'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza6: TStringField
      FieldName = 'Competenza6'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione6: TFloatField
      FieldName = 'Retribuzione6'
      MaxValue = 100.000000000000000000
    end
    object T263Aggiornabile: TStringField
      FieldName = 'Aggiornabile'
      Size = 1
    end
    object T263D_Raggruppamento: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object T263DATARES: TDateTimeField
      FieldName = 'DATARES'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object T263DECURTAZIONE: TStringField
      FieldName = 'DECURTAZIONE'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T263RAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object T263Dal: TDateTimeField
      FieldName = 'Dal'
      EditMask = '!99/99/9999;1;_'
    end
    object T263Al: TDateTimeField
      FieldName = 'Al'
      EditMask = '!99/99/9999;1;_'
    end
    object T263Note: TStringField
      FieldName = 'Note'
      Size = 2000
    end
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      
        'select T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE,max(T265.UM' +
        'ISURA) UMISURA'
      'from T260_RAGGRASSENZE T260, T265_CAUASSENZE T265'
      'where /*T260.CONTASOLARE = '#39'S'#39'*/ '
      
        'T260.CODICE in (select CODRAGGR from T265_CAUASSENZE where TIPOC' +
        'UMULO <> '#39'H'#39')'
      'and T260.CODICE = T265.CODRAGGR'
      'group by T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE'
      'order by T260.CODICE')
    Optimize = False
    Filtered = True
    AfterOpen = Q260AfterOpen
    AfterScroll = Q260AfterScroll
    OnFilterRecord = Q260FilterRecord
    Left = 48
    Top = 8
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE, T265.TIPOC' +
        'UMULO'
      '  FROM T260_RAGGRASSENZE T260, T265_CAUASSENZE T265'
      ' WHERE T260.CODICE = T265.CODRAGGR'
      '   AND T265.TIPOCUMULO IN ('#39'A'#39','#39'M'#39','#39'N'#39','#39'P'#39','#39'Q'#39','#39'R'#39','#39'S'#39','#39'U'#39')'
      ' ORDER BY T260.CODICE')
    Optimize = False
    Left = 112
    Top = 7
  end
end
