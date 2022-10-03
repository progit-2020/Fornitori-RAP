inherited S735FPunteggiFasceIncentiviDtM: TS735FPunteggiFasceIncentiviDtM
  OldCreateOrder = True
  Height = 177
  Width = 365
  object Q735: TOracleDataSet
    SQL.Strings = (
      'SELECT SG735.*, SG735.ROWID'
      'FROM SG735_PUNTEGGIFASCE_INCENTIVI SG735'
      'WHERE TIPOLOGIA = NVL(:TIPO,'#39'V'#39')'
      
        'ORDER BY CODQUOTA, FLESSIBILITA, SG735.PUNTEGGIO_DA, SG735.PUNTE' +
        'GGIO_A, SG735.DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A005400490050004F0005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E00450001000000000018000000500055004E005400450047004700
      49004F005F004400410001000000000016000000500055004E00540045004700
      470049004F005F00410001000000000008000000500045005200430001000000
      0000120000005400490050004F004C004F004700490041000100000000001000
      000043004F004400510055004F00540041000100000000001800000046004C00
      4500530053004900420049004C00490054004100010000000000}
    Left = 16
    Top = 8
    object Q735Quota: TStringField
      FieldKind = fkLookup
      FieldName = 'Quota'
      LookupDataSet = S735FPunteggiFasceIncentiviMW.selT765
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CODQUOTA'
      Size = 5
      Lookup = True
    end
    object Q735DescQuota: TStringField
      FieldKind = fkLookup
      FieldName = 'DescQuota'
      LookupDataSet = S735FPunteggiFasceIncentiviMW.selT765
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODQUOTA'
      Size = 200
      Lookup = True
    end
    object Q735DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q735DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object Q735PUNTEGGIO_DA: TFloatField
      DisplayLabel = 'Da punteggio'
      FieldName = 'PUNTEGGIO_DA'
      DisplayFormat = '##0.00'
      EditFormat = '##0.00'
    end
    object Q735PUNTEGGIO_A: TFloatField
      DisplayLabel = 'A punteggio'
      FieldName = 'PUNTEGGIO_A'
      DisplayFormat = '##0.00'
      EditFormat = '##0.00'
    end
    object Q735PERC: TFloatField
      DisplayLabel = '% incentivo'
      FieldName = 'PERC'
      DisplayFormat = '##0.00'
      EditFormat = '##0.00'
    end
    object Q735TIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Required = True
      Size = 1
    end
    object Q735CODQUOTA: TStringField
      FieldName = 'CODQUOTA'
      Required = True
      Size = 5
    end
    object Q735FLESSIBILITA: TStringField
      FieldName = 'FLESSIBILITA'
      Required = True
      Size = 1
    end
  end
end
