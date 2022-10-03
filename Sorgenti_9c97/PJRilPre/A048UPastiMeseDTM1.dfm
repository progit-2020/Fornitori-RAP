object A048FPastiMeseDtM1: TA048FPastiMeseDtM1
  OldCreateOrder = True
  OnCreate = A036TurniRepDTM1Create
  OnDestroy = A036TurniRepDTM1Destroy
  Height = 175
  Width = 330
  object Q410: TOracleDataSet
    SQL.Strings = (
      'SELECT T410.*,T410.ROWID FROM T410_PASTI T410'
      'WHERE PROGRESSIVO =:PROGRESSIVO'
      'ORDER BY ANNO DESC,MESE DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000600000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      4500530045000100000000000E000000430041005500530041004C0045000100
      000000000A000000500041005300540049000100000000000C00000050004100
      5300540049003200010000000000}
    BeforePost = Q410BeforePost
    AfterPost = Q410AfterDelete
    BeforeDelete = Q410BeforeDelete
    AfterDelete = Q410AfterDelete
    OnCalcFields = Q410CalcFields
    OnNewRecord = Q410NewRecord
    Left = 36
    Top = 12
    object Q410PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T340_TURNIREPERIB.PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q410ANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      Origin = 'T340_TURNIREPERIB.ANNO'
      Required = True
    end
    object Q410MESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 5
      FieldName = 'MESE'
      Origin = 'T340_TURNIREPERIB.MESE'
      Required = True
      MaxValue = 12.000000000000000000
      MinValue = 1.000000000000000000
    end
    object Q410CALCMESE: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      Calculated = True
    end
    object Q410CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object Q410PASTI: TFloatField
      DisplayLabel = 'Pasti convenzionati'
      FieldName = 'PASTI'
    end
    object Q410PASTI2: TIntegerField
      DisplayLabel = 'Pasti interi'
      FieldName = 'PASTI2'
    end
  end
end
