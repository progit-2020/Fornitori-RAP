object A096FProfiliLibProfDtM1: TA096FProfiliLibProfDtM1
  OldCreateOrder = True
  OnCreate = A054FCicliTurniDtM1Create
  Height = 69
  Width = 141
  object D311: TDataSource
    AutoEdit = False
    DataSet = Q311
    Left = 88
    Top = 8
  end
  object Q310: TOracleDataSet
    SQL.Strings = (
      'SELECT T310.*, T310.ROWID'
      'FROM T310_DESCLIBPROF T310'
      'ORDER BY CODICE')
    Optimize = False
    BeforePost = Q310BeforePost
    AfterPost = Q310AfterPost
    BeforeDelete = Q310BeforeDelete
    AfterDelete = Q310AfterDelete
    AfterScroll = Q310AfterScroll
    Left = 16
    Top = 8
    object Q310CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object Q310DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object Q311: TOracleDataSet
    SQL.Strings = (
      'SELECT T311.*, T311.ROWID'
      'FROM T311_DETTLIBPROF T311'
      'WHERE CODICE = :CODICE'
      'ORDER BY GIORNO,DALLE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = Q311BeforePost
    AfterPost = Q311AfterPost
    BeforeDelete = Q311BeforeDelete
    AfterDelete = Q311AfterDelete
    OnCalcFields = Q311CalcFields
    OnNewRecord = Q311NewRecord
    Left = 60
    Top = 8
    object Q311CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object Q311GIORNO: TIntegerField
      DisplayLabel = 'Giorno'
      FieldName = 'GIORNO'
      Required = True
      MaxValue = 7
      MinValue = 1
    end
    object Q311D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 12
      Calculated = True
    end
    object Q311DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = Q311DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q311ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = Q311DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q311CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      OnValidate = Q311CAUSALEValidate
      Size = 5
    end
    object Q311D_CAUSALE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupDataSet = A096FProfiliLibProfMW.Q275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
  end
end
