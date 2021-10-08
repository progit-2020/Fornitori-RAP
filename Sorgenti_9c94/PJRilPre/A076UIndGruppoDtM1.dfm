inherited A076FIndGruppoDtM1: TA076FIndGruppoDtM1
  OldCreateOrder = True
  Height = 135
  Width = 174
  object Q161: TOracleDataSet
    SQL.Strings = (
      
        'select T161.DECORRENZA, T161.CODICE, T161.CODICE2, T161.INDENNIT' +
        'A, T161.ROWID '
      '  from T161_INDGRUPPO T161 '
      ' order by T161.CODICE, T161.CODICE2')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000000E00
      000043004F00440049004300450032000100000000001200000049004E004400
      45004E004E00490054004100010000000000140000004400450043004F005200
      520045004E005A004100010000000000}
    Left = 16
    Top = 12
    object Q161CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T161_INDGRUPPO.CODICE'
      Visible = False
      OnValidate = Q161CODICEValidate
    end
    object Q161CODICE2: TStringField
      FieldName = 'CODICE2'
      Visible = False
      OnValidate = Q161CODICEValidate
    end
    object Q161INDENNITA: TStringField
      DisplayLabel = 'Indennit'#224
      DisplayWidth = 1
      FieldName = 'INDENNITA'
      Origin = 'T161_INDGRUPPO.INDENNITA'
      OnValidate = BDEQ161INDENNITAValidate
      Size = 5
    end
    object Q161D_INDENNITA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupDataSet = A076FIndGRuppoMW.Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDENNITA'
      Size = 40
      Lookup = True
    end
    object Q161DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 12
      FieldName = 'DECORRENZA'
    end
    object Q161D_DescCodice: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DescCodice'
      LookupDataSet = A076FIndGRuppoMW.selCodice1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object Q161D_DescCodice2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DescCodice2'
      LookupDataSet = A076FIndGRuppoMW.selCodice2
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE2'
      Size = 40
      Lookup = True
    end
    object Q161D_CodiceInd: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodiceInd'
      LookupDataSet = A076FIndGRuppoMW.Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'INDENNITA'
      Size = 10
      Lookup = True
    end
  end
  object DselT161: TDataSource
    Left = 61
    Top = 12
  end
  object selaT161: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T161.DECORRENZA, T161.CODICE, T161.CODICE2, INDENNITA, T1' +
        '63.DESCRIZIONE FROM T161_INDGRUPPO T161, T163_CODICIINDENNITA T1' +
        '63 WHERE '
      'DECORRENZA = (SELECT MAX(DECORRENZA) FROM T161_INDGRUPPO WHERE '
      '  DECORRENZA <= :Decorrenza AND '
      '  CODICE = T161.CODICE AND'
      '  CODICE2 = T161.CODICE2) AND'
      'T161.INDENNITA = T163.CODICE(+)'
      'ORDER BY CODICE, CODICE2')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000E00
      000043004F00440049004300450032000100000000001200000049004E004400
      45004E004E004900540041000100000000001600000044004500530043005200
      49005A0049004F004E004500010000000000140000004400450043004F005200
      520045004E005A004100010000000000}
    Left = 16
    Top = 68
    object selaT161DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selaT161CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
    end
    object selaT161CODICE2: TStringField
      FieldName = 'CODICE2'
      Required = True
    end
    object selaT161INDENNITA: TStringField
      FieldName = 'INDENNITA'
      Size = 5
    end
    object selaT161DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object _updT161: TOracleQuery
    SQL.Strings = (
      'DECLARE '
      
        '  CURSOR C1 IS SELECT T161.*,T161.ROWID FROM T161_INDGRUPPO T161' +
        ' WHERE DECORRENZA = :OldDecorrenza;'
      '  P NUMBER;'
      'BEGIN'
      '  FOR T1 IN C1 LOOP'
      '    BEGIN'
      '      UPDATE T161_INDGRUPPO SET DECORRENZA = :NewDecorrenza'
      '        WHERE ROWID = T1.ROWID;'
      '    EXCEPTION'
      '      WHEN OTHERS THEN'
      '        P:=0;'
      '    END;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A004E00450057004400450043004F0052005200
      45004E005A0041000C00000000000000000000001C0000003A004F004C004400
      4400450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 68
    Top = 68
  end
  object _insT161: TOracleQuery
    SQL.Strings = (
      'DECLARE '
      
        '  CURSOR C1 IS SELECT T161.*,T161.ROWID FROM T161_INDGRUPPO T161' +
        ' WHERE DECORRENZA = :OldDecorrenza;'
      '  P NUMBER;'
      'BEGIN'
      '  FOR T1 IN C1 LOOP'
      '    BEGIN'
      '      INSERT INTO T161_INDGRUPPO '
      '        (CODICE, INDENNITA, CODICE2, DECORRENZA)'
      '      VALUES'
      '        (T1.CODICE, T1.INDENNITA, T1.CODICE2, :NewDecorrenza);'
      '    EXCEPTION'
      '      WHEN OTHERS THEN'
      '        P:=0;'
      '    END;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A004E00450057004400450043004F0052005200
      45004E005A0041000C00000000000000000000001C0000003A004F004C004400
      4400450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 120
    Top = 68
  end
end
