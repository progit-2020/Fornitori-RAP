inherited A144FComuniMedLegaliMW: TA144FComuniMedLegaliMW
  OldCreateOrder = True
  Height = 326
  Width = 555
  object selT480: TOracleDataSet
    SQL.Strings = (
      'select * from T480_COMUNI'
      ':orderby')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 136
    Top = 32
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dscT480: TDataSource
    DataSet = selT480
    Left = 136
    Top = 96
  end
  object selT485: TOracleDataSet
    SQL.Strings = (
      'select * from T485_MEDICINELEGALI'
      'order by CODICE'
      '')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000000600
      0000430041005000010000000000160000004400450053004300520049005A00
      49004F004E0045000100000000001400000043004F0044005F0043004F004D00
      55004E0045000100000000001200000049004E0044004900520049005A005A00
      4F0001000000000010000000540045004C00450046004F004E004F0001000000
      00000A00000045004D00410049004C00010000000000}
    Left = 192
    Top = 32
  end
  object dscT485: TDataSource
    DataSet = selT485
    Left = 192
    Top = 96
  end
end
