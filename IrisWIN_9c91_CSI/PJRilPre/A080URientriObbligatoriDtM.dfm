inherited A080FRientriObbligatoriDtM: TA080FRientriObbligatoriDtM
  OldCreateOrder = True
  Height = 143
  Width = 200
  object selT029: TOracleDataSet
    SQL.Strings = (
      'select T029.*, T029.rowid '
      'from T029_RIENTRI_OBBLIGATORI T029'
      'where CODICE = :TIPOCARTELLINO'
      'order by GG_LAVORATIVI, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A005400490050004F0043004100520054004500
      4C004C0049004E004F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000001A000000
      470047005F004C00410056004F00520041005400490056004900010000000000
      1E0000004400450043004F005200520045004E005A0041005F00460049004E00
      4500010000000000180000005200490045004E005400520049005F004F004200
      42004C00010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    OnNewRecord = OnNewRecord
    Left = 16
    Top = 16
    object selT029CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT029DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT029DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object selT029GG_LAVORATIVI: TFloatField
      FieldName = 'GG_LAVORATIVI'
      Required = True
    end
    object selT029RIENTRI_OBBL: TFloatField
      FieldName = 'RIENTRI_OBBL'
      Required = True
    end
  end
end
