inherited A166FQuoteIndividualiMW: TA166FQuoteIndividualiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 244
  object selT765: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE, TIPOQUOTA '
      'FROM T765_TIPOQUOTE T765'
      'WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE'
      '                     WHERE CODICE = T765.CODICE'
      '                       AND DECORRENZA <=:DECORRENZA)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F0054004100010000000000}
    Left = 64
    Top = 16
    object selT765CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT765DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT765TIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
  end
  object selT770: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NVL(LTRIM(DATO1),'#39'*'#39') DATO1, NVL(LTRIM(DATO2),'#39'*'#39') DATO2,' +
        ' NVL(LTRIM(DATO3),'#39'*'#39') DATO3,'
      '       DECORRENZA, IMPORTO, PENALIZZAZIONE'
      'FROM T770_QUOTE T1'
      'WHERE '
      'CODTIPOQUOTA = :CODTIPOQUOTA AND'
      'CAUSALE = '#39' '#39' AND'
      'DECORRENZA <= (SELECT MAX(DECORRENZA)'
      '              FROM T770_QUOTE'
      
        '              WHERE DATO1 = T1.DATO1 AND DATO2 = T1.DATO2 AND DA' +
        'TO3 = T1.DATO3 AND CODTIPOQUOTA = T1.CODTIPOQUOTA AND DECORRENZA' +
        ' <= :DATAFINE)'
      'AND              '
      'DECORRENZA >= (SELECT NVL(MAX(DECORRENZA),:DATAINIZIO)'
      '              FROM T770_QUOTE'
      
        '              WHERE DATO1 = T1.DATO1 AND DATO2 = T1.DATO2 AND DA' +
        'TO3 = T1.DATO3 AND CODTIPOQUOTA = T1.CODTIPOQUOTA AND DECORRENZA' +
        ' <= :DATAINIZIO)'
      'ORDER BY DATO1,DATO2,DATO3,DECORRENZA DESC')
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A0043004F0044005400490050004F0051005500
      4F0054004100010000000000000000000000120000003A004400410054004100
      460049004E0045000C0000000000000000000000160000003A00440041005400
      410049004E0049005A0049004F000C0000000000000000000000}
    Left = 64
    Top = 78
  end
  object selT775b: TOracleDataSet
    SQL.Strings = (
      'select * '
      '  from T775_QUOTEINDIVIDUALI'
      ' where progressivo = :PROG'
      '   and :DEC <= SCADENZA'
      '   and :SCAD >= DECORRENZA'
      '   and codtipoquota = :COD'
      '   and nvl(rowid,'#39'0'#39') <> nvl(:RIGA,'#39'0'#39')')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00500052004F00470003000000000000000000
      0000080000003A004400450043000C00000000000000000000000A0000003A00
      53004300410044000C00000000000000000000000A0000003A00520049004700
      4100050000000000000000000000080000003A0043004F004400050000000000
      000000000000}
    Left = 127
    Top = 16
  end
  object selSQL: TOracleQuery
    Optimize = False
    Left = 127
    Top = 76
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select * from T030_anagrafico'
      'order by matricola')
    ReadBuffer = 10000
    Optimize = False
    Left = 183
    Top = 12
  end
  object selT775A: TOracleDataSet
    SQL.Strings = (
      'select T775.*,T775.rowid '
      'from T775_QUOTEINDIVIDUALI T775'
      'where PROGRESSIVO =:PROGRESSIVO'
      '  and CODTIPOQUOTA = :QUOTA'
      'order by DECORRENZA DESC')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A00510055004F0054004100
      050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004400450043004F005200520045004E005A004100
      01000000000010000000530043004100440045004E005A004100010000000000
      1800000043004F0044005400490050004F00510055004F005400410001000000
      00001C000000500045004E0041004C0049005A005A0041005A0049004F004E00
      450001000000000014000000530041004C0054004100500052004F0056004100
      0100000000000E00000049004D0050004F00520054004F000100000000000E00
      00004E0055004D005F004F005200450001000000000020000000500045005200
      43005F0049004E0044004900560049004400550041004C004500010000000000
      2000000050004500520043005F00530054005200550054005400550052004100
      4C0045000100000000001E00000043004F004E00530049004400450052004100
      5F00530041004C0044004F000100000000001600000050004500520043004500
      4E005400550041004C0045000100000000001600000053004F00530050004500
      4E00440049005F00500054000100000000001C00000053004F00530050004500
      4E00440049005F00510055004F0054004500010000000000}
    BeforePost = selT775ABeforePost
    AfterPost = selT775AAfterPost
    Left = 16
    Top = 80
    object IntegerField1: TIntegerField
      DisplayLabel = 'Progressivo'
      DisplayWidth = 5
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object StringField1: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Penalizzazione'
      DisplayWidth = 20
      FieldName = 'PENALIZZAZIONE'
      MaxValue = 100.000000000000000000
    end
    object StringField2: TStringField
      FieldName = 'SALTAPROVA'
      Size = 1
    end
    object FloatField2: TFloatField
      FieldName = 'IMPORTO'
    end
    object StringField3: TStringField
      FieldName = 'NUM_ORE'
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object FloatField3: TFloatField
      FieldName = 'PERC_INDIVIDUALE'
    end
    object FloatField4: TFloatField
      FieldName = 'PERC_STRUTTURALE'
    end
    object StringField4: TStringField
      FieldName = 'CONSIDERA_SALDO'
      Size = 1
    end
    object StringField5: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object FloatField5: TFloatField
      FieldName = 'PERCENTUALE'
    end
    object StringField6: TStringField
      FieldName = 'SOSPENDI_PT'
      Size = 1
    end
    object StringField7: TStringField
      FieldName = 'SOSPENDI_QUOTE'
      Size = 1
    end
  end
end
