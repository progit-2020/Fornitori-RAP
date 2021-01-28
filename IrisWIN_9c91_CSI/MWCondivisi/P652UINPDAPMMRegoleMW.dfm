inherited P652FINPDAPMMRegoleMW: TP652FINPDAPMMRegoleMW
  OldCreateOrder = True
  Height = 197
  Width = 335
  object V430: TOracleDataSet
    SQL.Strings = (
      'select *  from'
      '(select COLUMN_NAME '
      '  from cols'
      ' where table_name='#39'T430_STORICO'#39' OR table_name='#39'T030_ANAGRAFICO'#39
      '   and COLUMN_NAME<>'#39'PROGRESSIVO'#39
      'UNION '
      'select '#39'PROGRESSIVO'#39' as COLUMN_NAME FROM DUAL)'
      'ORDER BY COLUMN_NAME')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000001600000043004F004C0055004D004E005F004E0041004D00
      4500010000000000}
    Left = 183
    Top = 88
    object V430COLUMN_NAME: TStringField
      FieldName = 'COLUMN_NAME'
      Required = True
      Size = 30
    end
  end
  object dsrV430: TDataSource
    DataSet = V430
    Left = 184
    Top = 136
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 232
    Top = 92
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 266
    Top = 92
  end
  object P660B: TOracleDataSet
    SQL.Strings = (
      'SELECT P660.PARTE, P660.NUMERO, P660.DESCRIZIONE'
      '  FROM P660_FLUSSIREGOLE P660'
      ' WHERE P660.NOME_FLUSSO=:NOMEFLUSSO'
      '   AND P660.PARTE=:PARTE'
      
        '   AND P660.DECORRENZA=(SELECT MAX(DECORRENZA) FROM P660_FLUSSIR' +
        'EGOLE '
      '                         WHERE NOME_FLUSSO=:NOMEFLUSSO'
      '                           AND PARTE = P660.PARTE'
      '                           AND NUMERO = P660.NUMERO'
      '                           AND DECORRENZA <=:DECORRENZA)'
      'ORDER BY P660.PARTE,P660.NUMERO')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004E004F004D00450046004C00550053005300
      4F00050000000000000000000000160000003A004400450043004F0052005200
      45004E005A0041000C00000000000000000000000C0000003A00500041005200
      54004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000030000000A000000500041005200540045000100000000000C000000
      4E0055004D00450052004F000100000000001600000044004500530043005200
      49005A0049004F004E004500010000000000}
    Left = 92
    Top = 8
    object P660BPARTE: TStringField
      FieldName = 'PARTE'
      Required = True
      Size = 5
    end
    object P660BNUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
      Size = 4
    end
    object P660BDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
  end
  object sel200: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT '#39#39'COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DE' +
        'SCRIZIONE'
      'FROM P200_VOCI P200'
      'WHERE P200.DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P200_VOCI WHERE '
      '    ((DECORRENZA <= :DataCassa AND CASSA_COMPETENZA = '#39'CS'#39') OR '
      
        '    (DECORRENZA <= :DataCompetenza AND CASSA_COMPETENZA = '#39'CM'#39'))' +
        ' AND'
      '    COD_VOCE = P200.COD_VOCE AND'
      '    COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE)'
      '  AND :CodContratto is null  '
      'UNION ALL'
      
        'SELECT DISTINCT COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DESC' +
        'RIZIONE'
      'FROM P200_VOCI P200'
      'WHERE P200.DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P200_VOCI WHERE '
      '    ((DECORRENZA <= :DataCassa AND CASSA_COMPETENZA = '#39'CS'#39') OR '
      
        '    (DECORRENZA <= :DataCompetenza AND CASSA_COMPETENZA = '#39'CM'#39'))' +
        ' AND'
      '    COD_VOCE = P200.COD_VOCE AND'
      '    COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE)'
      '  AND :CodContratto is not null  '
      'ORDER BY COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A00440041005400410043004100530053004100
      0C00000000000000000000001E0000003A00440041005400410043004F004D00
      50004500540045004E005A0041000C00000000000000000000001A0000003A00
      43004F00440043004F004E00540052004100540054004F000500000000000000
      00000000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000001000000043004F0044005F0056004F004300450001000000
      00002200000043004F0044005F0056004F00430045005F005300500045004300
      490041004C004500010000000000160000004400450053004300520049005A00
      49004F004E0045000100000000001A00000043004F0044005F0043004F004E00
      540052004100540054004F00010000000000}
    Left = 103
    Top = 86
    object sel200COD_CONTRATTO: TStringField
      FieldName = 'COD_CONTRATTO'
      Size = 5
    end
    object sel200COD_VOCE: TStringField
      FieldName = 'COD_VOCE'
      Required = True
      Size = 5
    end
    object sel200COD_VOCE_SPECIALE: TStringField
      FieldName = 'COD_VOCE_SPECIALE'
      Required = True
      Size = 5
    end
    object sel200DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
end
