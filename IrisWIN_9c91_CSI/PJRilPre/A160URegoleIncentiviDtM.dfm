inherited A160FRegoleIncentiviDtM: TA160FRegoleIncentiviDtM
  OldCreateOrder = True
  Height = 200
  Width = 472
  object selT760: TOracleDataSet
    SQL.Strings = (
      'SELECT t760.*, T760.ROWID '
      '  FROM T760_REGOLEINCENTIVI T760'
      ' ORDER BY LIVELLO, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    OracleDictionary.RangeValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000090000000E0000004C004900560045004C004C004F00010000000000
      1200000045004C0045004E0043004F004C004900560001000000000008000000
      5400490050004F00010000000000200000004100420042004100540054004900
      4D0045004E0054004F005F004D00410058000100000000002A00000050005200
      4F0050004F0052005A0049004F004E0045005F0049004E00430045004E005400
      490056004900010000000000140000004400450043004F005200520045004E00
      5A00410001000000000028000000500052004F0050004F0052005A0049004F00
      4E0045005F005000410052005400540049004D0045000100000000001E000000
      5400490050004F005F00510055004F00540045005100550041004E0054000100
      000000001E000000460049004C0045005F00490053005400520055005A004900
      4F004E004900010000000000}
    BeforePost = BeforePost
    OnCalcFields = selT760CalcFields
    Left = 20
    Top = 20
    object selT760DECORRENZA: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT760LIVELLO: TStringField
      FieldName = 'LIVELLO'
    end
    object selT760TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object selT760ELENCOLIV: TStringField
      FieldName = 'ELENCOLIV'
      Size = 100
    end
    object selT760ABBATTIMENTO_MAX: TFloatField
      FieldName = 'ABBATTIMENTO_MAX'
      OnSetText = selT760ABBATTIMENTO_MAXSetText
      OnValidate = selT760ABBATTIMENTO_MAXValidate
    end
    object selT760PROPORZIONE_INCENTIVI: TStringField
      FieldName = 'PROPORZIONE_INCENTIVI'
      Size = 1
    end
    object selT760PROPORZIONE_PARTTIME: TStringField
      FieldName = 'PROPORZIONE_PARTTIME'
      Size = 1
    end
    object selT760D_LIVELLO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_LIVELLO'
      Size = 50
      Calculated = True
    end
    object selT760TIPO_QUOTEQUANT: TStringField
      FieldName = 'TIPO_QUOTEQUANT'
      Size = 1
    end
    object selT760FILE_ISTRUZIONI: TStringField
      FieldName = 'FILE_ISTRUZIONI'
      Size = 100
    end
    object selT760SCAGLIONI_GGEFF: TStringField
      FieldName = 'SCAGLIONI_GGEFF'
      Size = 1
    end
  end
end
