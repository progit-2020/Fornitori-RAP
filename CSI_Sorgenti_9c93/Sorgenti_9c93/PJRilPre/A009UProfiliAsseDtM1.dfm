inherited A009FProfiliAsseDtM1: TA009FProfiliAsseDtM1
  OldCreateOrder = True
  Height = 105
  Width = 266
  object dsrT261: TDataSource
    AutoEdit = False
    DataSet = selT261
    Left = 60
    Top = 52
  end
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 144
    Top = 4
  end
  object D262: TDataSource
    AutoEdit = False
    DataSet = Q262
    Left = 216
    Top = 4
  end
  object selT262: TOracleDataSet
    SQL.Strings = (
      'SELECT T262.*,T262.ROWID '
      'FROM T262_PROFASSANN T262'
      'ORDER BY ANNO,CODPROFILO,CODRAGGR')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001A0000000800000041004E004E004F00010000000000140000004300
      4F004400500052004F00460049004C004F000100000000001000000043004F00
      4400520041004700470052000100000000000E00000055004D00490053005500
      520041000100000000001600000043004F004D0050004500540045004E005A00
      410031000100000000001A00000052004500540052004900420055005A004900
      4F004E00450031000100000000001600000043004F004D005000450054004500
      4E005A00410032000100000000001A0000005200450054005200490042005500
      5A0049004F004E00450032000100000000001600000043004F004D0050004500
      540045004E005A00410033000100000000001A00000052004500540052004900
      420055005A0049004F004E00450033000100000000001600000043004F004D00
      50004500540045004E005A00410034000100000000001A000000520045005400
      52004900420055005A0049004F004E0045003400010000000000160000004300
      4F004D0050004500540045004E005A00410035000100000000001A0000005200
      4500540052004900420055005A0049004F004E00450035000100000000001600
      000043004F004D0050004500540045004E005A00410036000100000000001A00
      000052004500540052004900420055005A0049004F004E004500360001000000
      000016000000500052004F0050004F0052005A0049004F004E00450001000000
      00000A00000053004F004D004D004100010000000000040000004D0047000100
      000000000C0000004100520052004600410056000100000000000E0000004400
      41005400410052004500530001000000000010000000500052004F0050004700
      47004D004D000100000000002A0000004100520052005F0043004F004D005000
      4500540045004E005A0041005F0049004E005F004F0052004500010000000000
      340000004D00410058005F0046005200550049005A0049004F004E0045005F00
      470049004F0052004E005F0049004E005F004F00520045000100000000002200
      000046005200550049005A005F0041004E004E004F005F004D0049004E004900
      4D0041000100000000002E00000046005200550049005A005F0041004E004E00
      4F005F0043004F004E00540049004E0055004100540049005600410001000000
      0000}
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterScroll = selT262AfterScroll
    OnFilterRecord = FiltroDizionario
    OnNewRecord = selT262NewRecord
    Left = 12
    Top = 4
    object selT262Anno: TFloatField
      DisplayWidth = 12
      FieldName = 'Anno'
      Required = True
    end
    object selT262CodProfilo: TStringField
      DisplayLabel = 'Cod.profilo'
      DisplayWidth = 10
      FieldName = 'CodProfilo'
      Required = True
      Size = 5
    end
    object selT262D_Profilo: TStringField
      DisplayLabel = 'Profilo'
      DisplayWidth = 18
      FieldKind = fkLookup
      FieldName = 'D_Profilo'
      LookupDataSet = selT261
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodProfilo'
      Size = 40
      Lookup = True
    end
    object selT262CodRaggr: TStringField
      DisplayLabel = 'Cod.raggr'
      DisplayWidth = 9
      FieldName = 'CodRaggr'
      Required = True
      Size = 5
    end
    object selT262D_Raggruppamento: TStringField
      DisplayLabel = 'Raggruppamento'
      DisplayWidth = 19
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object selT262UMisura: TStringField
      DisplayWidth = 8
      FieldName = 'UMisura'
      Size = 1
    end
    object selT262Competenza1: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza1'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione1: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione1'
      MaxValue = 100.000000000000000000
    end
    object selT262Competenza2: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza2'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione2: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione2'
      MaxValue = 100.000000000000000000
    end
    object selT262Competenza3: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza3'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione3: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione3'
      MaxValue = 100.000000000000000000
    end
    object selT262Competenza4: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza4'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione4: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione4'
      MaxValue = 100.000000000000000000
    end
    object selT262Competenza5: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza5'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione5: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione5'
      MaxValue = 100.000000000000000000
    end
    object selT262Competenza6: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza6'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262Retribuzione6: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione6'
      MaxValue = 100.000000000000000000
    end
    object selT262PROPORZIONE: TStringField
      FieldName = 'PROPORZIONE'
      Size = 1
    end
    object selT262SOMMA: TStringField
      FieldName = 'SOMMA'
      Size = 1
    end
    object selT262MG: TStringField
      FieldName = 'MG'
      Size = 1
    end
    object selT262ARRFAV: TStringField
      FieldName = 'ARRFAV'
      Size = 1
    end
    object selT262DATARES: TDateTimeField
      FieldName = 'DATARES'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT262PROPGGMM: TStringField
      FieldName = 'PROPGGMM'
      Size = 1
    end
    object selT262ARR_COMPETENZA_IN_ORE: TStringField
      FieldName = 'ARR_COMPETENZA_IN_ORE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT262MAX_FRUIZIONE_GIORN_IN_ORE: TStringField
      FieldName = 'MAX_FRUIZIONE_GIORN_IN_ORE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT262FRUIZ_ANNO_MINIMA: TStringField
      FieldName = 'FRUIZ_ANNO_MINIMA'
      OnValidate = selT262Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object selT262FRUIZ_MINIMA_DAL: TDateTimeField
      FieldName = 'FRUIZ_MINIMA_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT262RAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object selT262COMPETENZE_PERSONALIZZATE: TStringField
      FieldName = 'COMPETENZE_PERSONALIZZATE'
      Size = 1
    end
    object selT262FRUIZ_MAX_NUM_GG: TIntegerField
      FieldName = 'FRUIZ_MAX_NUM_GG'
    end
  end
  object selT261: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T261_DESCPROFASS ORDER BY CODICE')
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 56
    Top = 4
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Descrizione from T260_RaggrAssenze '
      'WHERE  ContASolare = '#39'S'#39
      'ORDER BY Codice ')
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 116
    Top = 4
  end
  object Q262: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T262.ANNO,T262.CODPROFILO,T262.CODRAGGR,T260.DESCRIZIONE,' +
        'T262.UMISURA,'
      
        '               T262.COMPETENZA1,T262.COMPETENZA2,T262.COMPETENZA' +
        '3,T262.COMPETENZA4,'
      '               T262.COMPETENZA5,T262.COMPETENZA6'
      'FROM T262_ProfAssAnn T262, T260_RaggrAssenze T260'
      'WHERE  ANNO = :ANNO AND'
      '               CODPROFILO = :CODPROFILO AND'
      '               T262.CODRAGGR = T260.CODICE'
      'ORDER BY CODRAGGR')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F004400500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 188
    Top = 4
    object Q262ANNO: TFloatField
      FieldName = 'ANNO'
      Origin = 'T262_PROFASSANN.ANNO'
    end
    object Q262CODPROFILO: TStringField
      DisplayLabel = 'PROFILO'
      FieldName = 'CODPROFILO'
      Origin = 'T262_PROFASSANN.CODPROFILO'
      Size = 5
    end
    object Q262CODRAGGR: TStringField
      DisplayLabel = 'ASSENZA'
      FieldName = 'CODRAGGR'
      Origin = 'T262_PROFASSANN.CODRAGGR'
      Size = 5
    end
    object Q262DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T260_RAGGRASSENZE.DESCRIZIONE'
      Size = 40
    end
    object Q262UMISURA: TStringField
      DisplayLabel = 'U.M.'
      FieldName = 'UMISURA'
      Origin = 'T262_PROFASSANN.UMISURA'
      Size = 1
    end
    object Q262COMPETENZA1: TStringField
      FieldName = 'COMPETENZA1'
      Origin = 'T262_PROFASSANN.COMPETENZA1'
      Size = 7
    end
    object Q262COMPETENZA2: TStringField
      FieldName = 'COMPETENZA2'
      Origin = 'T262_PROFASSANN.COMPETENZA2'
      Size = 7
    end
    object Q262COMPETENZA3: TStringField
      FieldName = 'COMPETENZA3'
      Origin = 'T262_PROFASSANN.COMPETENZA3'
      Size = 7
    end
    object Q262COMPETENZA4: TStringField
      FieldName = 'COMPETENZA4'
      Origin = 'T262_PROFASSANN.COMPETENZA4'
      Size = 7
    end
    object Q262COMPETENZA5: TStringField
      FieldName = 'COMPETENZA5'
      Origin = 'T262_PROFASSANN.COMPETENZA5'
      Size = 7
    end
    object Q262COMPETENZA6: TStringField
      FieldName = 'COMPETENZA6'
      Origin = 'T262_PROFASSANN.COMPETENZA6'
      Size = 7
    end
  end
end
