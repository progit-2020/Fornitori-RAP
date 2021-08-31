object A034FINTPAGHEDTM1: TA034FINTPAGHEDTM1
  OldCreateOrder = True
  OnCreate = A034FINTPAGHEDTM1Create
  OnDestroy = A034FINTPAGHEDTM1Destroy
  Height = 149
  Width = 240
  object selT190: TOracleDataSet
    SQL.Strings = (
      'SELECT T190.*,ROWID FROM T190_INTERFACCIAPAGHE T190'
      'ORDER BY CODICE,ORDINE')
    ReadBuffer = 100
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000001400
      000043004F00440049004E005400450052004E004F0001000000000008000000
      46004C00410047000100000000001400000056004F00430045005F0050004100
      4700480045000100000000000C0000004F005200440049004E00450001000000
      00000400000055004D00010000000000}
    ReadOnly = True
    CommitOnPost = False
    Filtered = True
    BeforeInsert = selT190BeforeDeleteInsert
    BeforePost = selT190BeforePost
    BeforeDelete = selT190BeforeDeleteInsert
    OnCalcFields = selT190CalcFields
    OnFilterRecord = selT190FilterRecord
    Left = 12
    Top = 12
    object selT190CODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selT190CODINTERNO: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'CODINTERNO'
      ReadOnly = True
      Required = True
      Size = 4
    end
    object selT190Descrizione: TStringField
      DisplayLabel = ' '
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'Descrizione'
      Size = 50
      Calculated = True
    end
    object selT190FLAG: TStringField
      CustomConstraint = 'X = '#39'S'#39' OR X = '#39'N'#39
      DisplayLabel = 'Scaricare'
      FieldName = 'FLAG'
      Required = True
      OnValidate = selT190FLAGValidate
      Size = 1
    end
    object selT190VOCE_PAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCE_PAGHE'
      Size = 6
    end
    object selT190UM: TStringField
      DisplayLabel = 'Misura'
      FieldName = 'UM'
      Size = 4
    end
    object selT190ORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
  end
  object dsc190: TDataSource
    DataSet = selT190
    Left = 12
    Top = 60
  end
end
