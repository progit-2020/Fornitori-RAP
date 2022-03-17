object A094FSkLimitiStrDtM1: TA094FSkLimitiStrDtM1
  OldCreateOrder = True
  OnCreate = A094FSkLimitiStrDtM1Create
  OnDestroy = A094FSkLimitiStrDtM1Destroy
  Height = 182
  Width = 419
  object T800: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DATADECORR, NOMECAMPO1, NOMECAMPO2, TIPOLIMITE ,T800.ROWI' +
        'D FROM T800_CAMPILIMITI T800 ORDER BY DATADECORR')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000005000000140000005400490050004F004C0049004D00490054004500
      0100000000001400000044004100540041004400450043004F00520052000100
      00000000140000004E004F004D004500430041004D0050004F00310001000000
      0000140000004E004F004D004500430041004D0050004F003200010000000000
      20000000540052004F004E00430041005F004500430043004500440045004E00
      5A004500010000000000}
    BeforePost = T800BeforePost
    AfterPost = T800AfterPost
    BeforeDelete = T800BeforeDelete
    AfterDelete = T800AfterPost
    OnPostError = T800PostError
    Left = 16
    Top = 8
    object T800DATADECORR: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DATADECORR'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;'
    end
    object T800NOMECAMPO1: TStringField
      DisplayLabel = 'Campo 1'
      FieldName = 'NOMECAMPO1'
    end
    object T800NOMECAMPO2: TStringField
      DisplayLabel = 'Campo 2'
      FieldName = 'NOMECAMPO2'
    end
    object T800TIPOLIMITE: TStringField
      DisplayLabel = 'Tipo limite'
      FieldName = 'TIPOLIMITE'
      Required = True
      Size = 1
    end
  end
  object QAnno_810: TOracleDataSet
    SQL.Strings = (
      'select distinct anno, campo1, campo2'
      'from T810_Liquidabile'
      'order by anno,campo1,campo2'
      '')
    Optimize = False
    OnApplyRecord = QAnno_810ApplyRecord
    BeforePost = T800BeforePost
    AfterPost = QAnno_810Apply
    BeforeDelete = T800BeforeDelete
    AfterDelete = QAnno_810Apply
    AfterScroll = QAnno_810AfterScroll
    OnPostError = PostError
    Left = 20
    Top = 104
    object QAnno_810ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      OnValidate = QAnno_810ANNOValidate
      MaxValue = 3000
      MinValue = 1900
    end
    object QAnno_810CAMPO1: TStringField
      FieldName = 'CAMPO1'
      Origin = 'T810_LIQUIDABILE.CAMPO1'
      Size = 50
    end
    object QAnno_810CAMPO2: TStringField
      FieldName = 'CAMPO2'
      Origin = 'T810_LIQUIDABILE.CAMPO2'
      Size = 50
    end
  end
  object QAnno_811: TOracleDataSet
    SQL.Strings = (
      'select distinct anno, campo1, campo2'
      'from T811_Residuabile'
      'order by anno,campo1,campo2')
    Optimize = False
    OnApplyRecord = QAnno_811ApplyRecord
    BeforePost = T800BeforePost
    AfterPost = QAnno_811Apply
    BeforeDelete = T800BeforeDelete
    AfterDelete = QAnno_811Apply
    AfterScroll = QAnno_811AfterScroll
    OnPostError = PostError
    Left = 88
    Top = 104
    object QAnno_811ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      OnValidate = QAnno_811ANNOValidate
      MaxValue = 3000
      MinValue = 1900
    end
    object QAnno_811CAMPO1: TStringField
      FieldName = 'CAMPO1'
      Origin = 'T811_RESIDUABILE.CAMPO1'
      Size = 50
    end
    object QAnno_811CAMPO2: TStringField
      FieldName = 'CAMPO2'
      Origin = 'T811_RESIDUABILE.CAMPO2'
      Size = 50
    end
  end
  object Q820: TOracleDataSet
    SQL.Strings = (
      'SELECT T820.*,T820.ROWID FROM T820_LIMITIIND T820'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY ANNO DESC,MESE DESC,CAUSALE,DAL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      4500530045000100000000000E000000430041005500530041004C0045000100
      00000000100000005000520049004F0052004900540041000100000000001000
      0000420041004E00430041004F0052004500010000000000180000004F005200
      45005F00540045004F0052004900430048004500010000000000060000004F00
      52004500010000000000}
    BeforeEdit = Q820BeforeEdit
    BeforePost = T800BeforePost
    AfterPost = Q820AfterPost
    BeforeDelete = T800BeforeDelete
    AfterDelete = Q820AfterPost
    OnNewRecord = Q820NewRecord
    Left = 76
    Top = 8
    object Q820PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q820ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
    end
    object Q820MESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      Required = True
    end
    object Q820DAL: TIntegerField
      DisplayLabel = 'Dal'
      DisplayWidth = 2
      FieldName = 'DAL'
      MaxValue = 31
    end
    object Q820AL: TIntegerField
      DisplayLabel = 'Al'
      DisplayWidth = 2
      FieldName = 'AL'
      MaxValue = 31
    end
    object Q820Liquidabile: TStringField
      DisplayLabel = 'Liquidabile'
      FieldName = 'LIQUIDABILE'
      Required = True
      OnValidate = Q820PickListValidate
      Size = 1
    end
    object Q820CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      OnValidate = Q820PickListValidate
      Size = 5
    end
    object Q820ORE_TEORICHE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore teoriche'
      FieldName = 'ORE_TEORICHE'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object Q820ORE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore effettive'
      FieldName = 'ORE'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
  end
end
