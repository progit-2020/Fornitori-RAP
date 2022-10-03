object A117FOreLiquidateAnniPrecDtM: TA117FOreLiquidateAnniPrecDtM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 81
  Width = 269
  object Q134: TOracleDataSet
    SQL.Strings = (
      'SELECT T134.*,T134.ROWID FROM T134_ORELIQUIDATEANNIPREC T134'
      'WHERE PROGRESSIVO = :Progressivo'
      'ORDER BY ANNO DESC,DATA DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F0003000000040000001127000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000600000016000000500052004F004700520045005300530049005600
      4F000100000000001A0000004F00520045005F004C0049005100550049004400
      4100540045000100000000000800000041004E004E004F000100000000000800
      000044004100540041000100000000001C000000560041005200490041005A00
      49004F004E0045005F004F0052004500010000000000080000004E004F005400
      4500010000000000}
    CommitOnPost = False
    AfterOpen = Q134AfterOpen
    BeforePost = Q134BeforePost
    AfterPost = Q134AfterPost
    BeforeDelete = Q134BeforeDelete
    AfterDelete = Q134AfterDelete
    OnCalcFields = Q134CalcFields
    OnNewRecord = Q134NewRecord
    Left = 24
    Top = 8
    object Q134PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object Q134ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
    end
    object Q134DATA: TDateTimeField
      FieldName = 'DATA'
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object Q134ORE_LIQUIDATE: TStringField
      FieldName = 'ORE_LIQUIDATE'
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object Q134VARIAZIONE_ORE: TStringField
      FieldName = 'VARIAZIONE_ORE'
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object Q134NOTE: TStringField
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 100
    end
    object Q134OREPERSE: TStringField
      DisplayLabel = 'Ore perse'
      FieldName = 'OREPERSE'
      Size = 1
    end
    object Q134OREPERSE_TOT: TStringField
      DisplayLabel = 'Totale ore perse'
      FieldKind = fkCalculated
      FieldName = 'OREPERSE_TOT'
      Size = 7
      Calculated = True
    end
    object Q134OREPERSE_RES: TStringField
      DisplayLabel = 'Residuo ore perse'
      FieldKind = fkCalculated
      FieldName = 'OREPERSE_RES'
      Size = 7
      Calculated = True
    end
  end
end
