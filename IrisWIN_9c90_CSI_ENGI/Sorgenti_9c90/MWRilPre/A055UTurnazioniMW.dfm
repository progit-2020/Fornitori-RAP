inherited A055FTurnazioniMW: TA055FTurnazioniMW
  OldCreateOrder = True
  Height = 81
  Width = 448
  object Q641AggiornaTurnazione: TOracleQuery
    SQL.Strings = (
      'UPDATE T641_MOLTTURNAZIONE SET TURNAZIONE = :TURNAZIONE'
      'WHERE TURNAZIONE = :TURNAZIONE_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A005400550052004E0041005A0049004F004E00
      45000500000000000000000000001E0000003A005400550052004E0041005A00
      49004F004E0045005F004F004C004400050000000000000000000000}
    Left = 208
    Top = 8
  end
  object Q641CancellaTurnazione: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T641_MOLTTURNAZIONE'
      'WHERE TURNAZIONE = :TURNAZIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400550052004E0041005A0049004F004E00
      4500050000000000000000000000}
    Left = 340
    Top = 8
  end
  object Q610: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T610_CICLI'
      'ORDER BY CODICE'
      '')
    Optimize = False
    Left = 116
    Top = 8
  end
  object D641: TDataSource
    DataSet = Q641
    Left = 56
    Top = 8
  end
  object Q641: TOracleDataSet
    SQL.Strings = (
      'SELECT T641.*,T641.ROWID FROM T641_MOLTTURNAZIONE T641'
      'WHERE TURNAZIONE = :TURNAZIONE'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A005400550052004E0041005A0049004F004E00
      4500050000000000000000000000100000003A004F0052004400450052004200
      5900010000000000000000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = Q641BeforePost
    OnNewRecord = Q641NewRecord
    Left = 12
    Top = 8
    object Q641TURNAZIONE: TStringField
      FieldName = 'TURNAZIONE'
      Origin = 'T641_MOLTTURNAZIONE.TURNAZIONE'
      Visible = False
      Size = 5
    end
    object Q641ORDINE: TFloatField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
      Origin = 'T641_MOLTTURNAZIONE.ORDINE'
    end
    object Q641CICLO1: TStringField
      DisplayLabel = '1'#176' Ciclo'
      DisplayWidth = 10
      FieldName = 'CICLO1'
      Origin = 'T641_MOLTTURNAZIONE.CICLO1'
      OnValidate = Q641CICLO1Validate
      Size = 5
    end
    object Q641CICLO2: TStringField
      DisplayLabel = '2'#176' Ciclo'
      DisplayWidth = 10
      FieldName = 'CICLO2'
      Origin = 'T641_MOLTTURNAZIONE.CICLO2'
      OnValidate = Q641CICLO1Validate
      Size = 5
    end
    object Q641CICLO3: TStringField
      DisplayLabel = '3'#176' Ciclo'
      DisplayWidth = 10
      FieldName = 'CICLO3'
      Origin = 'T641_MOLTTURNAZIONE.CICLO3'
      OnValidate = Q641CICLO1Validate
      Size = 5
    end
    object Q641CICLO4: TStringField
      DisplayLabel = '4'#176' Ciclo'
      DisplayWidth = 10
      FieldName = 'CICLO4'
      Origin = 'T641_MOLTTURNAZIONE.CICLO4'
      OnValidate = Q641CICLO1Validate
      Size = 5
    end
    object Q641CICLO5: TStringField
      DisplayLabel = '5'#176' Ciclo'
      DisplayWidth = 10
      FieldName = 'CICLO5'
      Origin = 'T641_MOLTTURNAZIONE.CICLO5'
      OnValidate = Q641CICLO1Validate
      Size = 5
    end
    object Q641MULTIPLO: TFloatField
      CustomConstraint = 'x > 0 and x < 99'
      ConstraintErrorMessage = 'La molteplicit'#224' deve essere compresa fra 1 e 99'
      DisplayLabel = 'Molteplicit'#224
      FieldName = 'MULTIPLO'
      Origin = 'T641_MOLTTURNAZIONE.MULTIPLO'
      MaxValue = 99.000000000000000000
      MinValue = 1.000000000000000000
    end
  end
end
