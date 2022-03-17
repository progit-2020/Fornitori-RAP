object A036FTurniRepDTM1: TA036FTurniRepDTM1
  OldCreateOrder = True
  OnCreate = A036TurniRepDTM1Create
  OnDestroy = A036TurniRepDTM1Destroy
  Height = 77
  Width = 131
  object selT340: TOracleDataSet
    SQL.Strings = (
      'SELECT T340.*,T340.ROWID FROM T340_TURNIREPERIB T340'
      'WHERE PROGRESSIVO =:PROGRESSIVO'
      'ORDER BY ANNO DESC,MESE DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      450053004500010000000000160000005400550052004E00490049004E005400
      450052004900010000000000100000005400550052004E0049004F0052004500
      0100000000000E0000004F00520045004D004100470047000100000000001400
      00004F00520045004E004F004E004D0041004700470001000000000012000000
      46004C0041004700500041004700480045000100000000001000000056005000
      5F005400550052004E004F000100000000000C000000560050005F004F005200
      45000100000000001A000000560050005F004D0041004700470049004F005200
      41005400450001000000000020000000560050005F004E004F004E004D004100
      4700470049004F005200410054004500010000000000}
    BeforePost = selT340BeforePost
    AfterPost = selT340AfterDelete
    BeforeDelete = selT340BeforeDelete
    AfterDelete = selT340AfterDelete
    OnCalcFields = selT340CalcFields
    OnNewRecord = selT340NewRecord
    Left = 36
    Top = 12
    object selT340PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T340_TURNIREPERIB.PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT340ANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      Origin = 'T340_TURNIREPERIB.ANNO'
      Required = True
    end
    object selT340MESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 5
      FieldName = 'MESE'
      Origin = 'T340_TURNIREPERIB.MESE'
      Required = True
      MaxValue = 12.000000000000000000
      MinValue = 1.000000000000000000
    end
    object selT340CALCMESE: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      Calculated = True
    end
    object selT340TURNIINTERI: TFloatField
      DisplayLabel = 'Turni interi'
      DisplayWidth = 8
      FieldName = 'TURNIINTERI'
      Origin = 'T340_TURNIREPERIB.TURNIINTERI'
      MaxValue = 999.000000000000000000
    end
    object selT340VP_TURNO: TStringField
      DisplayLabel = 'Voce paghe '
      FieldName = 'VP_TURNO'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selT340TURNIORE: TStringField
      DisplayLabel = 'Turni ore'
      FieldName = 'TURNIORE'
      Origin = 'T340_TURNIREPERIB.TURNIORE'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selT340VP_ORE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_ORE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selT340OREMAGG: TStringField
      DisplayLabel = 'Ore maggiorate'
      FieldName = 'OREMAGG'
      Origin = 'T340_TURNIREPERIB.OREMAGG'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selT340VP_MAGGIORATE: TStringField
      DisplayLabel = 'Voce paghe '
      FieldName = 'VP_MAGGIORATE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selT340ORENONMAGG: TStringField
      DisplayLabel = 'Ore non magg'
      FieldName = 'ORENONMAGG'
      Origin = 'T340_TURNIREPERIB.ORENONMAGG'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selT340VP_NONMAGGIORATE: TStringField
      DisplayLabel = 'Voce Paghe '
      FieldName = 'VP_NONMAGGIORATE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selT340GETTONE_CHIAMATA: TIntegerField
      DisplayLabel = 'Gettone chiamata'
      FieldName = 'GETTONE_CHIAMATA'
      MaxValue = 999
    end
    object selT340VP_GETTONE_CHIAMATA: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_GETTONE_CHIAMATA'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selT340TURNI_OLTREMAX: TIntegerField
      DisplayLabel = 'Eccedenza turni'
      FieldName = 'TURNI_OLTREMAX'
      MaxValue = 999
    end
    object selT340VP_TURNI_OLTREMAX: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_TURNI_OLTREMAX'
      OnValidate = ValidaVoce
      Size = 6
    end
  end
end
