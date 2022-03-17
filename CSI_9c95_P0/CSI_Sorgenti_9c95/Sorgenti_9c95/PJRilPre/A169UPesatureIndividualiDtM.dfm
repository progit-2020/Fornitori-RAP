inherited A169FPesatureIndividualiDtM: TA169FPesatureIndividualiDtM
  OldCreateOrder = True
  Width = 686
  object selT773: TOracleDataSet
    SQL.Strings = (
      'select t773.*, t773.rowid '
      'from t773_pesaturegruppo t773'
      'order by anno, codgruppo, codtipoquota')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000B0000001200000043004F004400470052005500500050004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001E000000460049004C00540052004F005F0041004E00410047005200
      4100460045000100000000001800000043004F0044005400490050004F005100
      55004F0054004100010000000000160000005000450053004F005F0054004F00
      540041004C004500010000000000180000005000450053004F005F0049004E00
      44005F004D0049004E00010000000000180000005000450053004F005F004900
      4E0044005F004D004100580001000000000018000000510055004F0054004100
      5F0054004F00540041004C0045000100000000000E0000004400410054004100
      5200490046000100000000000800000041004E004E004F000100000000000C00
      0000430048004900550053004F00010000000000}
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT773AfterScroll
    OnFilterRecord = selT773FilterRecord
    OnNewRecord = selT773NewRecord
    Left = 32
    Top = 24
    object selT773ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
    end
    object selT773CODGRUPPO: TStringField
      FieldName = 'CODGRUPPO'
      Required = True
      Size = 10
    end
    object selT773DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT773FILTRO_ANAGRAFE: TStringField
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 4000
    end
    object selT773CODTIPOQUOTA: TStringField
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selT773PESO_TOTALE: TFloatField
      FieldName = 'PESO_TOTALE'
    end
    object selT773PESO_IND_MIN: TFloatField
      FieldName = 'PESO_IND_MIN'
    end
    object selT773PESO_IND_MAX: TFloatField
      FieldName = 'PESO_IND_MAX'
    end
    object selT773QUOTA_TOTALE: TFloatField
      FieldName = 'QUOTA_TOTALE'
      DisplayFormat = '###,###,###,##0.00'
    end
    object selT773DATARIF: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATARIF'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT773CHIUSO: TStringField
      FieldName = 'CHIUSO'
      Size = 1
    end
  end
end
