object A073FAcquistoBuoniDtM1: TA073FAcquistoBuoniDtM1
  OldCreateOrder = True
  OnCreate = A073FAcquistoBuoniDtM1Create
  OnDestroy = DataModuleDestroy
  Height = 103
  Width = 105
  object Q690: TOracleDataSet
    SQL.Strings = (
      'SELECT T690.*,T690.ROWID FROM T690_ACQUISTOBUONI T690'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY DATA DESC'
      '/*'
      'SELECT t690.*, t690.ROWID '
      'FROM t690_acquistobuoni t690 '
      'WHERE t690.progressivo = :PROGRESSIVO'
      'GROUP BY t690.progressivo, t690.data, '
      '         t690.buonipasto, t690.ticket, '
      '         t690.buoni_auto, t690.ticket_auto, '
      '         t690.buoni_recuperati, t690.buoni_recuperati_prec, '
      '         t690.ticket_recuperati, t690.ticket_recuperati_prec, '
      '         t690.note, t690.data_scadenza, t690.ROWID '
      'ORDER BY t690.data desc'
      '*/')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000900000016000000500052004F004700520045005300530049005600
      4F00010000000000080000004400410054004100010000000000140000004200
      55004F004E00490050004100530054004F000100000000000C00000054004900
      43004B004500540001000000000014000000420055004F004E0049005F004100
      550054004F00010000000000160000005400490043004B00450054005F004100
      550054004F0001000000000020000000420055004F004E0049005F0052004500
      4300550050004500520041005400490001000000000022000000540049004300
      4B00450054005F00520045004300550050004500520041005400490001000000
      0000080000004E004F0054004500010000000000}
    BeforePost = Q690BeforePost
    AfterPost = Q690AfterPost
    BeforeDelete = Q690BeforeDelete
    AfterDelete = Q690AfterPost
    OnNewRecord = Q690NewRecord
    Left = 28
    Top = 23
    object Q690PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q690DATA: TDateTimeField
      DisplayLabel = 'Data acquisto'
      DisplayWidth = 10
      FieldName = 'DATA'
      OnValidate = Q690DATAValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q690NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 10
      FieldName = 'NOTE'
      Size = 40
    end
    object Q690BUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      DisplayWidth = 5
      FieldName = 'BUONIPASTO'
    end
    object Q690BUONI_AUTO: TIntegerField
      DisplayLabel = 'Buoni automatici'
      DisplayWidth = 5
      FieldName = 'BUONI_AUTO'
      ReadOnly = True
    end
    object Q690BUONI_RECUPERATI: TIntegerField
      DisplayLabel = 'Buoni recuperati'
      DisplayWidth = 5
      FieldName = 'BUONI_RECUPERATI'
      ReadOnly = True
    end
    object Q690TICKET: TIntegerField
      DisplayLabel = 'Ticket'
      DisplayWidth = 5
      FieldName = 'TICKET'
    end
    object Q690TICKET_AUTO: TIntegerField
      DisplayLabel = 'Ticket automatici'
      DisplayWidth = 5
      FieldName = 'TICKET_AUTO'
      ReadOnly = True
    end
    object Q690TICKET_RECUPERATI: TIntegerField
      DisplayLabel = 'Ticket recuperati'
      DisplayWidth = 5
      FieldName = 'TICKET_RECUPERATI'
      ReadOnly = True
    end
    object Q690DATA_MAGAZZINO: TDateTimeField
      FieldName = 'DATA_MAGAZZINO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object Q690DATA_MAGAZZINOlk: TDateTimeField
      DisplayLabel = 'Data magazzino'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'DATA_MAGAZZINOlk'
      LookupDataSet = A073FAcquistoBuoniMW.selT691
      LookupKeyFields = 'DATA_ACQUISTO'
      LookupResultField = 'DATA_ACQUISTO'
      KeyFields = 'DATA_MAGAZZINO'
      ProviderFlags = [pfInWhere]
      EditMask = '!00/00/0000;1;_'
      Lookup = True
    end
    object Q690ID_BLOCCHETTI: TStringField
      DisplayLabel = 'Blocchetti acquistati'
      DisplayWidth = 15
      FieldName = 'ID_BLOCCHETTI'
      OnValidate = Q690ID_BLOCCHETTIValidate
      Size = 100
    end
  end
end
