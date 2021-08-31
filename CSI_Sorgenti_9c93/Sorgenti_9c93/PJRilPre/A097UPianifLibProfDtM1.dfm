object A097FPianifLibProfDtM1: TA097FPianifLibProfDtM1
  OldCreateOrder = True
  OnCreate = A056FTurnazIndDtM1Create
  OnDestroy = A056FTurnazIndDtM1Destroy
  Height = 73
  Width = 210
  object D320: TDataSource
    AutoEdit = False
    DataSet = Q320
    OnStateChange = D320StateChange
    Left = 140
    Top = 12
  end
  object D310: TDataSource
    AutoEdit = False
    OnDataChange = D310DataChange
    Left = 40
    Top = 12
  end
  object Q320: TOracleDataSet
    SQL.Strings = (
      'SELECT T320.*,T320.ROWID FROM T320_PIANLIBPROFESSIONE T320'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 AND :DATA2'
      'ORDER BY DATA,DALLE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    BeforePost = Q320BeforePost
    AfterPost = Q320AfterDelete
    BeforeDelete = Q320BeforeDelete
    AfterDelete = Q320AfterDelete
    OnCalcFields = Q320CalcFields
    OnNewRecord = Q320NewRecord
    Left = 112
    Top = 12
    object Q320PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q320DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q320D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 10
      Calculated = True
    end
    object Q320DALLE: TStringField
      DefaultExpression = 'hh.nn'
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = Q320DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q320ALLE: TStringField
      DefaultExpression = 'hh.nn'
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = Q320DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q320CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      OnValidate = Q320CAUSALEValidate
      Size = 5
    end
    object Q320D_CAUSALE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupDataSet = A097FPianifLibProfMW.Q275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
  end
end
