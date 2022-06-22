inherited A015FPlusOraIndivMW: TA015FPlusOraIndivMW
  OldCreateOrder = True
  Height = 59
  Width = 71
  object T090: TOracleDataSet
    SQL.Strings = (
      'SELECT T090.*,T090.ROWID FROM T090_PLUSORAINDIV T090'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001D00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F000100000000000C0000005400
      490050004F0050004F00010000000000140000005400490050004F0044004500
      4200490054004F00010000000000080000004F00520045003100010000000000
      080000004F00520045003200010000000000080000004F005200450033000100
      00000000080000004F00520045003400010000000000080000004F0052004500
      3500010000000000080000004F00520045003600010000000000080000004F00
      520045003700010000000000080000004F005200450038000100000000000800
      00004F005200450039000100000000000A0000004F0052004500310030000100
      000000000A0000004F0052004500310031000100000000000A0000004F005200
      450031003200010000000000120000005400490050004F004700450053005400
      3100010000000000120000005400490050004F00470045005300540032000100
      00000000120000005400490050004F0047004500530054003300010000000000
      120000005400490050004F004700450053005400340001000000000012000000
      5400490050004F00470045005300540035000100000000001200000054004900
      50004F0047004500530054003600010000000000120000005400490050004F00
      47004500530054003700010000000000120000005400490050004F0047004500
      530054003800010000000000120000005400490050004F004700450053005400
      3900010000000000140000005400490050004F00470045005300540031003000
      010000000000140000005400490050004F004700450053005400310031000100
      00000000140000005400490050004F0047004500530054003100320001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      0000}
    OnNewRecord = T090NewRecord
    Left = 16
    Top = 8
    object T090Progressivo: TFloatField
      FieldName = 'Progressivo'
    end
    object T090Anno: TFloatField
      FieldName = 'Anno'
      Required = True
    end
    object T090DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object T090TipoPO: TStringField
      FieldName = 'TipoPO'
      Required = True
      Size = 1
    end
    object T090TipoDebito: TStringField
      FieldName = 'TipoDebito'
      Required = True
      Size = 1
    end
    object T090Ore1: TStringField
      FieldName = 'Ore1'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore2: TStringField
      FieldName = 'Ore2'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore3: TStringField
      FieldName = 'Ore3'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore4: TStringField
      FieldName = 'Ore4'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore5: TStringField
      FieldName = 'Ore5'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore6: TStringField
      FieldName = 'Ore6'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore7: TStringField
      FieldName = 'Ore7'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore8: TStringField
      FieldName = 'Ore8'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore9: TStringField
      FieldName = 'Ore9'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore10: TStringField
      FieldName = 'Ore10'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore11: TStringField
      FieldName = 'Ore11'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090Ore12: TStringField
      FieldName = 'Ore12'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object T090TipoGest1: TStringField
      FieldName = 'TipoGest1'
      Size = 1
    end
    object T090TipoGest2: TStringField
      FieldName = 'TipoGest2'
      Size = 1
    end
    object T090TipoGest3: TStringField
      FieldName = 'TipoGest3'
      Size = 1
    end
    object T090TipoGest4: TStringField
      FieldName = 'TipoGest4'
      Size = 1
    end
    object T090TipoGest5: TStringField
      FieldName = 'TipoGest5'
      Size = 1
    end
    object T090TipoGest6: TStringField
      FieldName = 'TipoGest6'
      Size = 1
    end
    object T090TipoGest7: TStringField
      FieldName = 'TipoGest7'
      Size = 1
    end
    object T090TipoGest8: TStringField
      FieldName = 'TipoGest8'
      Size = 1
    end
    object T090TipoGest9: TStringField
      FieldName = 'TipoGest9'
      Size = 1
    end
    object T090TipoGest10: TStringField
      FieldName = 'TipoGest10'
      Size = 1
    end
    object T090TipoGest11: TStringField
      FieldName = 'TipoGest11'
      Size = 1
    end
    object T090TipoGest12: TStringField
      FieldName = 'TipoGest12'
      Size = 1
    end
  end
end
