inherited A164FQuoteIncentiviMW: TA164FQuoteIncentiviMW
  OldCreateOrder = True
  Height = 194
  Width = 402
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 88
    Top = 72
  end
  object selDato2: TOracleDataSet
    Optimize = False
    Left = 168
    Top = 72
  end
  object selDato3: TOracleDataSet
    Optimize = False
    Left = 264
    Top = 72
  end
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
    Left = 24
    Top = 72
    object selT765CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT765DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT765TIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T265_CAUASSENZE'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F0054004100010000000000}
    Left = 327
    Top = 72
    object StringField1: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object StringField2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selP030: TOracleDataSet
    SQL.Strings = (
      'SELECT NUM_DEC_IMP_VOCE, ABBREVIAZIONE FROM P030_VALUTE T1 WHERE'
      'COD_VALUTA = :Cod_Valuta AND'
      'DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P030_VALUTE'
      '   WHERE DECORRENZA <= :Decorrenza '
      '   AND COD_VALUTA = T1.COD_VALUTA)')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0043004F0044005F00560041004C0055005400
      4100050000000000000000000000160000003A004400450043004F0052005200
      45004E005A0041000C0000000000000000000000}
    CommitOnPost = False
    Left = 266
    Top = 15
  end
  object selP150: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM P150_SETUP T1 WHERE '
      'DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P150_SETUP'
      '   WHERE DECORRENZA <= :Decorrenza)')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 326
    Top = 15
  end
  object selSQL: TOracleQuery
    Optimize = False
    Left = 328
    Top = 118
  end
  object selT770A: TOracleDataSet
    SQL.Strings = (
      'select A.*, B.decorrenza - 1 scadenza'
      'from t770_quote A, t770_quote B'
      'where A.DATO1 = B.DATO1'
      '  and A.DATO2 = B.DATO2'
      '  and A.DATO3 = B.DATO3'
      '  and A.CODTIPOQUOTA = B.CODTIPOQUOTA'
      '  and A.CAUSALE = B.CAUSALE'
      '  and B.Decorrenza > A.Decorrenza'
      '  and B.Decorrenza <= A.Decorrenza_Fine')
    Optimize = False
    Left = 165
    Top = 19
  end
end
