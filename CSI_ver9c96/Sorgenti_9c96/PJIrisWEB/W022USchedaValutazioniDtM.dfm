object W022FSchedaValutazioniDtM: TW022FSchedaValutazioniDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 462
  Width = 715
  object D710: TDataSource
    AutoEdit = False
    DataSet = Q710
    Left = 16
    Top = 120
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'SELECT MATRICOLA, COGNOME||'#39' '#39'||NOME NOMINATIVO'
      'FROM   T030_ANAGRAFICO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 592
    Top = 8
  end
  object Q710: TOracleDataSet
    SQL.Strings = (
      'SELECT SG710.*, SG710.ROWID'
      'FROM   SG710_TESTATA_VALUTAZIONI SG710'
      'WHERE  SG710.PROGRESSIVO = :PROGRESSIVO'
      'AND    SG710.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND    SG710.DATA = :DATA'
      'AND   (   (SG710.CHIUSO = '#39'S'#39')'
      '       OR (    (NOT EXISTS (SELECT 1'
      
        '                            FROM SG710_TESTATA_VALUTAZIONI SG710' +
        'A'
      
        '                            WHERE SG710.PROGRESSIVO = SG710A.PRO' +
        'GRESSIVO'
      
        '                            AND SG710.TIPO_VALUTAZIONE = SG710A.' +
        'TIPO_VALUTAZIONE'
      '                            AND SG710.DATA = SG710A.DATA'
      '                            AND SG710A.CHIUSO = '#39'S'#39'))'
      '           AND (    (    (:VALUTATORE = '#39'S'#39')'
      
        '                     AND (SG710.STATO_AVANZAMENTO = (SELECT MAX(' +
        'SG710A.STATO_AVANZAMENTO)'
      
        '                                                     FROM SG710_' +
        'TESTATA_VALUTAZIONI SG710A'
      
        '                                                     WHERE SG710' +
        '.PROGRESSIVO = SG710A.PROGRESSIVO'
      
        '                                                     AND SG710.T' +
        'IPO_VALUTAZIONE = SG710A.TIPO_VALUTAZIONE'
      
        '                                                     AND SG710.D' +
        'ATA = SG710A.DATA)))'
      '                 OR (    (:VALUTATORE = '#39'N'#39')'
      
        '                     AND (SG710.STATO_AVANZAMENTO = (SELECT MAX(' +
        'CODSTAMPA)'
      
        '                                                     FROM SG746_' +
        'STATI_AVANZAMENTO'
      
        '                                                     WHERE CODRE' +
        'GOLA = SG710.CODREGOLA'
      
        '                                                     AND :DATA B' +
        'ETWEEN DECORRENZA AND DECORRENZA_FINE'
      
        '                                                     AND CODICE ' +
        '<= (SELECT MAX(SG710B.STATO_AVANZAMENTO)'
      
        '                                                                ' +
        '    FROM SG710_TESTATA_VALUTAZIONI SG710B'
      
        '                                                                ' +
        '    WHERE SG710B.PROGRESSIVO = SG710.PROGRESSIVO'
      
        '                                                                ' +
        '    AND SG710B.TIPO_VALUTAZIONE = SG710.TIPO_VALUTAZIONE'
      
        '                                                                ' +
        '    AND SG710B.DATA = SG710.DATA)))))))')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000220000003A005400490050004F005F00
      560041004C005500540041005A0049004F004E00450005000000000000000000
      00000A0000003A0044004100540041000C000000000000000000000016000000
      3A00560041004C0055005400410054004F005200450005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    BeforePost = Q710BeforePost
    AfterPost = Q710AfterPost
    BeforeDelete = Q710BeforeDelete
    AfterScroll = Q710AfterScroll
    OnCalcFields = Q710CalcFields
    OnNewRecord = Q710NewRecord
    OnPostError = Q710PostError
    Left = 16
    Top = 64
    object Q710DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      OnGetText = Q710DATAGetText
      DisplayFormat = 'yyyy'
      EditMask = '!0000;1;_'
    end
    object Q710PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo valutato'
      FieldName = 'PROGRESSIVO'
    end
    object Q710PROGRESSIVI_VALUTATORI: TStringField
      DisplayLabel = 'Progressivi valutatori'
      FieldName = 'PROGRESSIVI_VALUTATORI'
      Size = 50
    end
    object Q710D_VALUTATORE: TStringField
      DisplayLabel = 'Descrizione valutatore'
      FieldKind = fkCalculated
      FieldName = 'D_VALUTATORE'
      Size = 500
      Calculated = True
    end
    object Q710VALUTAZIONE_COMPLESSIVE: TStringField
      DisplayLabel = 'Valutazioni complessive'
      FieldName = 'VALUTAZIONE_COMPLESSIVE'
      Size = 4000
    end
    object Q710OBIETTIVI_AZIONI: TStringField
      DisplayLabel = 'Obiettivi azioni'
      FieldName = 'OBIETTIVI_AZIONI'
      Size = 500
    end
    object Q710PROPOSTE_FORMATIVE: TStringField
      DisplayLabel = 'Proposte formative'
      FieldName = 'PROPOSTE_FORMATIVE'
      Size = 500
    end
    object Q710COMMENTI_VALUTATO: TStringField
      DisplayLabel = 'Commenti valutato'
      FieldName = 'COMMENTI_VALUTATO'
      Size = 500
    end
    object Q710NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 500
    end
    object Q710TIPO_VALUTAZIONE: TStringField
      DisplayLabel = 'Tipo valutazione'
      FieldName = 'TIPO_VALUTAZIONE'
      Size = 1
    end
    object Q710DATA_COMPILAZIONE: TDateTimeField
      DisplayLabel = 'Data compilazione'
      FieldName = 'DATA_COMPILAZIONE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q710CHIUSO: TStringField
      FieldName = 'CHIUSO'
      Size = 1
    end
    object Q710STATO_SCHEDA: TStringField
      FieldKind = fkCalculated
      FieldName = 'STATO_SCHEDA'
      Size = 200
      Calculated = True
    end
    object Q710DATA_CHIUSURA: TDateTimeField
      FieldName = 'DATA_CHIUSURA'
    end
    object Q710PUNTEGGIO_FINALE_PESATO: TFloatField
      FieldName = 'PUNTEGGIO_FINALE_PESATO'
    end
    object Q710ACCETTAZIONE_VALUTATO: TStringField
      FieldName = 'ACCETTAZIONE_VALUTATO'
      Size = 1
    end
    object Q710PROPOSTE_FORMATIVE_1: TStringField
      FieldName = 'PROPOSTE_FORMATIVE_1'
      Size = 1
    end
    object Q710PROPOSTE_FORMATIVE_2: TStringField
      FieldName = 'PROPOSTE_FORMATIVE_2'
      Size = 1
    end
    object Q710PROPOSTE_FORMATIVE_3: TStringField
      FieldName = 'PROPOSTE_FORMATIVE_3'
      Size = 1
    end
    object Q710VALUTABILE: TStringField
      FieldName = 'VALUTABILE'
      Size = 1
    end
    object Q710IMPORTO_INCENTIVO: TFloatField
      FieldName = 'IMPORTO_INCENTIVO'
      OnGetText = Q710IMPORTO_INCENTIVOGetText
      OnSetText = Q710IMPORTO_INCENTIVOSetText
    end
    object Q710ORE_INCENTIVO: TStringField
      FieldName = 'ORE_INCENTIVO'
      OnGetText = Q710ORE_INCENTIVOGetText
      OnSetText = Q710ORE_INCENTIVOSetText
      Size = 7
    end
    object Q710ACCETTAZIONE_OBIETTIVI: TStringField
      FieldName = 'ACCETTAZIONE_OBIETTIVI'
      Size = 1
    end
    object Q710STATO_AVANZAMENTO: TIntegerField
      FieldName = 'STATO_AVANZAMENTO'
    end
    object Q710MODIFICA_SUBITO: TStringField
      FieldKind = fkCalculated
      FieldName = 'MODIFICA_SUBITO'
      Size = 1
      Calculated = True
    end
    object Q710CODREGOLA: TStringField
      FieldName = 'CODREGOLA'
      Size = 5
    end
    object Q710DAL: TDateTimeField
      FieldName = 'DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q710AL: TDateTimeField
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q710NUMERO_PROTOCOLLO: TIntegerField
      FieldName = 'NUMERO_PROTOCOLLO'
    end
    object Q710ANNO_PROTOCOLLO: TIntegerField
      FieldName = 'ANNO_PROTOCOLLO'
    end
    object Q710DATA_PROTOCOLLO: TDateTimeField
      FieldName = 'DATA_PROTOCOLLO'
    end
    object Q710TIPO_PROTOCOLLO: TStringField
      FieldName = 'TIPO_PROTOCOLLO'
      Size = 1
    end
    object Q710VALUTAZIONE_INTERMEDIA: TStringField
      FieldName = 'VALUTAZIONE_INTERMEDIA'
      Size = 500
    end
    object Q710ESITO_VALUTAZIONE_INTERMEDIA: TStringField
      FieldName = 'ESITO_VALUTAZIONE_INTERMEDIA'
      Size = 1
    end
    object Q710STORIA_VALUTAZIONE_INTERMEDIA: TStringField
      FieldKind = fkCalculated
      FieldName = 'STORIA_VALUTAZIONE_INTERMEDIA'
      Size = 4000
      Calculated = True
    end
    object Q710MESSAGGIO_VALIDAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'MESSAGGIO_VALIDAZIONE'
      Size = 1000
      Calculated = True
    end
  end
  object selSG701: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG701_AREE_VALUTAZIONI'
      'WHERE COD_AREA = :COD_AREA'
      'AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 328
    Top = 64
  end
  object selSG711: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.PUNTEGGIO, T.PERC_VALUTAZIONE, T.PUNTEGGIO_PESATO, T.VA' +
        'LUTABILE'
      'FROM   SG711_VALUTAZIONI_DIPENDENTE T'
      'WHERE  DATA = :DATA'
      'AND    PROGRESSIVO = :PROGRESSIVO'
      'AND    COD_AREA = :COD_AREA'
      'AND    TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND    STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      '')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000120000003A0043004F0044005F004100520045004100
      050000000000000000000000220000003A005400490050004F005F0056004100
      4C005500540041005A0049004F004E0045000500000000000000000000002400
      00003A0053005400410054004F005F004100560041004E005A0041004D004500
      4E0054004F00030000000000000000000000}
    Left = 80
    Top = 176
  end
  object Q711: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*, T.ROWID, T.ROWID as SG711_ROWID'
      'FROM   SG711_VALUTAZIONI_DIPENDENTE T'
      'WHERE  DATA = :DATA'
      'AND    PROGRESSIVO = :PROGRESSIVO'
      'AND    TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND    STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      'ORDER BY COD_AREA, COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = Q711BeforePost
    OnCalcFields = Q711CalcFields
    Left = 80
    Top = 64
    object Q711DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      ReadOnly = True
      Visible = False
    end
    object Q711PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object Q711COD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      FieldName = 'COD_AREA'
      ReadOnly = True
      Size = 5
    end
    object Q711D_AREA: TStringField
      DisplayLabel = 'Descrizione area'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_AREA'
      ReadOnly = True
      Size = 500
      Calculated = True
    end
    object Q711PERC_AREA: TFloatField
      DisplayLabel = 'Peso %'
      FieldKind = fkCalculated
      FieldName = 'PERC_AREA'
      ReadOnly = True
      Visible = False
      DisplayFormat = '00.00'
      Calculated = True
    end
    object Q711CF_PERC_AREA: TFloatField
      DisplayLabel = 'Peso %'
      FieldKind = fkCalculated
      FieldName = 'CF_PERC_AREA'
      ReadOnly = True
      DisplayFormat = '00.00'
      Calculated = True
    end
    object Q711PUNTEGGIO_AREA: TFloatField
      DisplayLabel = 'Punt. area'
      FieldKind = fkCalculated
      FieldName = 'PUNTEGGIO_AREA'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
    object Q711CF_PUNTEGGIO_AREA: TFloatField
      DisplayLabel = 'Punt. area'
      FieldKind = fkCalculated
      FieldName = 'CF_PUNTEGGIO_AREA'
      ReadOnly = True
      Calculated = True
    end
    object Q711COD_VALUTAZIONE: TStringField
      DisplayLabel = 'Cod. val.'
      FieldName = 'COD_VALUTAZIONE'
      ReadOnly = True
      Size = 5
    end
    object Q711D_VALUTAZIONE: TStringField
      DisplayLabel = 'Descrizione elem.'
      FieldKind = fkCalculated
      FieldName = 'D_VALUTAZIONE'
      ReadOnly = True
      Size = 1000
      Calculated = True
    end
    object Q711VALUTABILE: TStringField
      DisplayLabel = 'Valutabile'
      FieldName = 'VALUTABILE'
      Size = 1
    end
    object Q711GIUDICABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GIUDICABILE'
      Size = 1
      Calculated = True
    end
    object Q711PUNTEGGIO: TFloatField
      DisplayLabel = 'Punt. val.'
      FieldName = 'PUNTEGGIO'
    end
    object Q711D_PUNTEGGIO: TStringField
      DisplayLabel = 'Desc. punteggio'
      FieldKind = fkCalculated
      FieldName = 'D_PUNTEGGIO'
      Size = 6
      Calculated = True
    end
    object Q711TIPO_VALUTAZIONE: TStringField
      DisplayLabel = 'Tipo valutazione'
      FieldName = 'TIPO_VALUTAZIONE'
      ReadOnly = True
      Size = 1
    end
    object Q711DESC_VALUTAZIONE_AGG: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESC_VALUTAZIONE_AGG'
      ReadOnly = True
      Visible = False
      Size = 1000
    end
    object Q711VALUTAZIONE_ORIGINALE: TStringField
      DisplayLabel = 'Item originale'
      FieldKind = fkCalculated
      FieldName = 'VALUTAZIONE_ORIGINALE'
      ReadOnly = True
      Size = 1
      Calculated = True
    end
    object Q711COD_PUNTEGGIO: TStringField
      DisplayLabel = 'Cod. punteggio'
      FieldName = 'COD_PUNTEGGIO'
      Size = 5
    end
    object Q711SG711_ROWID: TStringField
      FieldName = 'SG711_ROWID'
      Size = 18
    end
    object Q711PERC_VALUTAZIONE: TFloatField
      DisplayLabel = 'Peso % item'
      FieldName = 'PERC_VALUTAZIONE'
      Visible = False
    end
    object Q711CF_PERC_VALUTAZIONE: TFloatField
      DisplayLabel = 'Peso % item'
      FieldKind = fkCalculated
      FieldName = 'CF_PERC_VALUTAZIONE'
      Calculated = True
    end
    object Q711SOGLIA_PUNTEGGIO: TStringField
      DisplayLabel = 'Soglia'
      FieldName = 'SOGLIA_PUNTEGGIO'
      Size = 5
    end
    object Q711STATO_AVANZAMENTO: TIntegerField
      DisplayLabel = 'Stato avanzamento'
      FieldName = 'STATO_AVANZAMENTO'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object Q711PUNTEGGI_ABILITATI: TStringField
      DisplayLabel = 'Punteggi abilitati'
      FieldKind = fkCalculated
      FieldName = 'PUNTEGGI_ABILITATI'
      Visible = False
      Size = 1
      Calculated = True
    end
    object Q711ELEMENTI_ABILITATI: TStringField
      DisplayLabel = 'Elementi abilitati'
      FieldKind = fkCalculated
      FieldName = 'ELEMENTI_ABILITATI'
      Visible = False
      Size = 1
      Calculated = True
    end
    object Q711PUNTEGGIO_PESATO: TFloatField
      DisplayLabel = 'Punt. val. pesato'
      FieldName = 'PUNTEGGIO_PESATO'
      Visible = False
    end
    object Q711CF_PUNTEGGIO_PESATO: TFloatField
      DisplayLabel = 'Punt. val. pesato'
      FieldKind = fkCalculated
      FieldName = 'CF_PUNTEGGIO_PESATO'
      Calculated = True
    end
    object Q711NOTE_PUNTEGGIO: TStringField
      DisplayLabel = 'Note punteggio'
      FieldName = 'NOTE_PUNTEGGIO'
      Size = 500
    end
  end
  object selSG700: TOracleDataSet
    SQL.Strings = (
      'SELECT SG700.*'
      'FROM SG700_VALUTAZIONI SG700, SG701_AREE_VALUTAZIONI SG701'
      'WHERE SG700.COD_AREA = SG701.COD_AREA'
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG701.COD_AREA = :COD_AREA'
      'AND :DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FINE'
      'ORDER BY SG700.COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 272
    Top = 64
  end
  object selSG730: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG730_PUNTEGGI T'
      'WHERE :DATA_VAL BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'AND DATO1 = :DATO1'
      'ORDER BY DECODE(ITEM_GIUDICABILE,'#39'S'#39',1,2), PUNTEGGIO, CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0044004100540041005F00560041004C000C00
      000000000000000000000C0000003A004400410054004F003100050000000000
      000000000000}
    Left = 440
    Top = 64
  end
  object D711: TDataSource
    AutoEdit = False
    DataSet = Q711
    Left = 80
    Top = 120
  end
  object insSG711: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG711_VALUTAZIONI_DIPENDENTE'
      '(DATA'
      ',PROGRESSIVO'
      ',COD_AREA'
      ',COD_VALUTAZIONE'
      ',VALUTABILE'
      ',PUNTEGGIO'
      ',TIPO_VALUTAZIONE'
      ',DESC_VALUTAZIONE_AGG'
      ',STATO_AVANZAMENTO'
      ',PERC_VALUTAZIONE)'
      'VALUES'
      '(:DATA'
      ',:PROGRESSIVO'
      ',:COD_AREA'
      ',:COD_VALUTAZIONE'
      ',DECODE(:PERC_VALUTAZIONE,0,'#39'N'#39','#39'S'#39')'
      ',NULL'
      ',:TIPO_VALUTAZIONE'
      ',:DESC_VALUTAZIONE_AGG'
      ',:STATO_AVANZAMENTO'
      ',:PERC_VALUTAZIONE)')
    Optimize = False
    Variables.Data = {
      04000000080000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000120000003A0043004F0044005F004100520045004100
      050000000000000000000000200000003A0043004F0044005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000022000000
      3A005400490050004F005F00560041004C005500540041005A0049004F004E00
      45000500000000000000000000002A0000003A0044004500530043005F005600
      41004C005500540041005A0049004F004E0045005F0041004700470005000000
      0000000000000000240000003A0053005400410054004F005F00410056004100
      4E005A0041004D0045004E0054004F0003000000000000000000000022000000
      3A0050004500520043005F00560041004C005500540041005A0049004F004E00
      4500040000000000000000000000}
    Left = 80
    Top = 232
  end
  object delSG711: TOracleQuery
    SQL.Strings = (
      'DELETE SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 80
    Top = 344
  end
  object MesiLavorati: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR C_PERIODI IS'
      
        '    SELECT GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYYY'#39 +
        ')) INIZIO, '
      
        '           LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39 +
        ')),:DATA_RIF) FINE'
      '    FROM   T430_STORICO'
      '    WHERE  PROGRESSIVO = :PROGR'
      
        '    AND    NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <= :DATA_R' +
        'IF'
      
        '    AND    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= TRUNC(:DA' +
        'TA_RIF,'#39'YYYY'#39')'
      '    AND    DATADECORRENZA <= :DATA_RIF '
      '    AND    DATAFINE >= TRUNC(:DATA_RIF,'#39'YYYY'#39')'
      '    :CODICI_TIPO_RAPPORTO'
      
        '    GROUP BY GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYY' +
        'Y'#39')),'
      
        '             LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYY' +
        'Y'#39')),:DATA_RIF)'
      
        '    HAVING GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYYY'#39 +
        ')) <= LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:D' +
        'ATA_RIF);'
      '    '
      '  nGG_ALLUNGA       INTEGER :=0;'
      '  nGG_DIFF_PARZIALE INTEGER :=0;'
      'BEGIN'
      '  :GG_DIFF:='#39#39';'
      '  FOR R_PERIODI IN C_PERIODI LOOP'
      '    IF :SALTA_ASSENZE = '#39'N'#39' THEN'
      '    BEGIN'
      '      SELECT COUNT(*)'
      '      INTO   nGG_ALLUNGA'
      '      FROM   T040_GIUSTIFICATIVI'
      '      WHERE  PROGRESSIVO = :PROGR'
      '      AND    DATA BETWEEN R_PERIODI.INIZIO AND R_PERIODI.FINE'
      '      AND    CAUSALE IN (SELECT CODICE'
      '                         FROM   T265_CAUASSENZE'
      '                         WHERE  ABBATTE_GGVALUTAZIONE = '#39'S'#39');'
      '    EXCEPTION'
      '      WHEN OTHERS THEN'
      '        nGG_ALLUNGA:=0;'
      '    END;'
      '    END IF;'
      '    BEGIN'
      '      SELECT R_PERIODI.FINE + 1 - R_PERIODI.INIZIO - nGG_ALLUNGA'
      '      INTO   nGG_DIFF_PARZIALE'
      '      FROM   DUAL;'
      '    EXCEPTION'
      '      WHEN OTHERS THEN'
      '        nGG_DIFF_PARZIALE:=0;'
      '    END;'
      '    IF :GG_DIFF IS NULL THEN'
      '      :GG_DIFF:=0;'
      '    END IF;'
      '    :GG_DIFF:=:GG_DIFF + nGG_DIFF_PARZIALE;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00500052004F00470052000300000000000000
      000000002A0000003A0043004F0044004900430049005F005400490050004F00
      5F0052004100500050004F00520054004F000100000000000000000000001000
      00003A00470047005F0044004900460046000300000000000000000000001C00
      00003A00530041004C00540041005F0041005300530045004E005A0045000500
      00000000000000000000120000003A0044004100540041005F00520049004600
      0C0000000000000000000000}
    Left = 248
    Top = 8
  end
  object selSG741: TOracleDataSet
    SQL.Strings = (
      'SELECT SG741.*'
      'FROM SG741_REGOLE_VALUTAZIONI SG741'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      'AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 496
    Top = 64
  end
  object selSG720: TOracleDataSet
    SQL.Strings = (
      '--Terza versione'
      'SELECT distinct cod_area'
      'FROM   SG720_PROFILI_AREE'
      'WHERE  :COND1'
      'AND    :COND2'
      'AND    :COND3'
      'AND    :COND4'
      'AND    :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'UNION'
      'SELECT distinct cod_area'
      'FROM   SG720_PROFILI_AREE'
      'WHERE  :COND5'
      'AND    :COND6'
      'AND    :COND7'
      'AND    :COND8'
      'AND    :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      ''
      '--Seconda versione'
      '/*SELECT distinct cod_area'
      'FROM   SG720_PROFILI_AREE'
      'WHERE  DATO1 = NVL(:DATO1,'#39' '#39') '
      'AND    DATO2 = NVL(:DATO2,'#39' '#39') '
      'AND    DATO3 = NVL(:DATO3,'#39' '#39') '
      'AND    DATO4 = NVL(:DATO4,'#39' '#39')'
      'AND    :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE*/'
      '-- Prima versione'
      '/*SELECT distinct cod_area'
      'FROM   SG720_PROFILI_AREE'
      'WHERE  ('
      
        '           (DATO1 = NVL(:DATO1,'#39' '#39') AND DATO2 = NVL(:DATO2,'#39' '#39') ' +
        'AND DATO3 = NVL(:DATO3,'#39' '#39') AND DATO4 = NVL(:DATO4,'#39' '#39'))'
      
        '        OR (DATO1 = NVL(:DATO1,'#39' '#39') AND DATO2 = NVL(:DATO2,'#39' '#39') ' +
        'AND DATO3 = NVL(:DATO3,'#39' '#39') AND DATO4 = '#39' '#39'            )'
      
        '        OR (DATO1 = NVL(:DATO1,'#39' '#39') AND DATO2 = NVL(:DATO2,'#39' '#39') ' +
        'AND DATO3 = '#39' '#39'             AND DATO4 = '#39' '#39'            )'
      
        '        OR (DATO1 = NVL(:DATO1,'#39' '#39') AND DATO2 = '#39' '#39'             ' +
        'AND DATO3 = '#39' '#39'             AND DATO4 = '#39' '#39'            )'
      
        '        OR (DATO1 = '#39' '#39'             AND DATO2 = '#39' '#39'             ' +
        'AND DATO3 = '#39' '#39'             AND DATO4 = '#39' '#39'            )'
      '       )'
      'AND    :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE*/')
    Optimize = False
    Variables.Data = {
      04000000090000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A0043004F004E00440031000100000000000000000000000C00
      00003A0043004F004E00440032000100000000000000000000000C0000003A00
      43004F004E00440033000100000000000000000000000C0000003A0043004F00
      4E00440034000100000000000000000000000C0000003A0043004F004E004400
      35000100000000000000000000000C0000003A0043004F004E00440036000100
      000000000000000000000C0000003A0043004F004E0044003700010000000000
      0000000000000C0000003A0043004F004E004400380001000000000000000000
      0000}
    Left = 384
    Top = 64
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 208
    Top = 64
  end
  object D010: TDataSource
    Left = 208
    Top = 120
  end
  object ElementiPersonalizzati: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      'AND COD_AREA = NVL(:COD_AREA,COD_AREA)'
      'AND DESC_VALUTAZIONE_AGG IS NOT NULL')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000012000000
      3A0043004F0044005F0041005200450041000500000000000000000000002400
      00003A0053005400410054004F005F004100560041004E005A0041004D004500
      4E0054004F00030000000000000000000000}
    Left = 416
    Top = 8
  end
  object selFormaz: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'A'#39' CODICE, '#39'Formazione residenziale'#39' DESCRIZIONE, 1 ORDI' +
        'NE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'B'#39' CODICE, '#39'Formazione sul campo'#39' DESCRIZIONE, 2 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'C'#39' CODICE, '#39'Affiancamento'#39' DESCRIZIONE, 3 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'D'#39' CODICE, '#39'Formazione a distanza'#39' DESCRIZIONE, 4 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'Z'#39' CODICE, '#39'Altro (specificare)'#39' DESCRIZIONE, 5 ORDINE'
      'FROM DUAL'
      'ORDER BY ORDINE')
    Optimize = False
    Left = 144
    Top = 64
    object selFormazCODICE: TStringField
      FieldName = 'CODICE'
      Size = 1
    end
    object selFormazDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 30
    end
    object selFormazORDINE: TFloatField
      FieldName = 'ORDINE'
    end
  end
  object dFormaz: TDataSource
    DataSet = selFormaz
    Left = 144
    Top = 120
  end
  object selT430a: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) N_VARIAZIONI'
      'FROM T430_STORICO T1'
      'WHERE T1.PROGRESSIVO = :PROGRESSIVO'
      'AND :DATARIF BETWEEN T1.DATADECORRENZA AND T1.DATAFINE'
      'AND EXISTS (SELECT 1'
      '            FROM T430_STORICO T2'
      '            WHERE T2.PROGRESSIVO = T1.PROGRESSIVO'
      '            AND T2.:DATO <> T1.:DATO'
      '            AND T2.DATADECORRENZA < T1.DATADECORRENZA'
      '            AND T2.DATAFINE >= :DATAINI)')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C00000000000000000000000A0000003A004400410054004F000100
      00000000000000000000100000003A00440041005400410049004E0049000C00
      00000000000000000000}
    Left = 648
    Top = 8
  end
  object CambioValutatore: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR CSG706 IS'
      '    SELECT DECORRENZA, DECORRENZA_FINE, PROGRESSIVO'
      '    FROM SG706_VALUTATORI_DIPENDENTE'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DINI <= DECORRENZA_FINE'
      '    AND :DFIN >= DECORRENZA;'
      'BEGIN'
      '  FOR RSG706 IN CSG706 LOOP'
      '    --Periodo esistente compreso'
      
        '    IF :DINI <= RSG706.DECORRENZA AND :DFIN >= RSG706.DECORRENZA' +
        '_FINE THEN'
      '      DELETE SG706_VALUTATORI_DIPENDENTE'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    --Periodo esistente esterno'
      
        '    ELSIF RSG706.DECORRENZA < :DINI AND RSG706.DECORRENZA_FINE >' +
        ' :DFIN THEN'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA_FINE = :DINI - 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '      INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '      (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VAL' +
        'UTATO)'
      '      VALUES'
      
        '      (RSG706.PROGRESSIVO, :DFIN + 1, RSG706.DECORRENZA_FINE, :P' +
        'ROGRESSIVO_VALUTATO);'
      '    --Fine esistente interseca periodo nuovo'
      '    ELSIF RSG706.DECORRENZA < :DINI THEN'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA_FINE = :DINI - 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    --Inizio esistente interseca periodo nuovo'
      '    ELSE'
      '      UPDATE SG706_VALUTATORI_DIPENDENTE'
      '      SET DECORRENZA = :DFIN + 1'
      '      WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '      AND DECORRENZA = RSG706.DECORRENZA'
      '      AND DECORRENZA_FINE = RSG706.DECORRENZA_FINE;'
      '    END IF;'
      '  END LOOP;'
      '  INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '  (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VALUTAT' +
        'O)'
      '  VALUES'
      
        '  (:PROGRESSIVO_VALUTATORE_NEW, :DINI, :DFIN, :PROGRESSIVO_VALUT' +
        'ATO);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000002A0000003A00500052004F00470052004500530053004900
      56004F005F00560041004C0055005400410054004F0003000000000000000000
      0000360000003A00500052004F0047005200450053005300490056004F005F00
      560041004C0055005400410054004F00520045005F004E004500570003000000
      00000000000000000A0000003A00440049004E0049000C000000000000000000
      00000A0000003A004400460049004E000C0000000000000000000000}
    Left = 520
    Top = 8
  end
  object cdsRiepilogoSchede: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'A'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'B'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'C'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'D'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 600
    Top = 344
  end
  object selRiepilogoSchede: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'1'#39' A,'
      '       SG710.CHIUSO B, T030.COGNOME || '#39' '#39' || T030.NOME C, '
      
        '       T030.MATRICOLA D, SG710.CODREGOLA || '#39'.'#39' || TO_CHAR(SG710' +
        '.STATO_AVANZAMENTO) E, TO_CHAR(SG710.PUNTEGGIO_FINALE_PESATO) F,' +
        ' SG710.VALUTABILE G'
      'FROM SG710_TESTATA_VALUTAZIONI SG710,'
      '     T030_ANAGRAFICO T030'
      'WHERE SG710.TIPO_VALUTAZIONE = :TIPO'
      'AND SG710.DATA = :DATA'
      'AND T030.PROGRESSIVO = :PROGRESSIVO'
      'AND T030.PROGRESSIVO = SG710.PROGRESSIVO'
      
        'AND SG710.STATO_AVANZAMENTO = (SELECT MAX(SG710C.STATO_AVANZAMEN' +
        'TO) '
      
        '                               FROM SG710_TESTATA_VALUTAZIONI SG' +
        '710C'
      
        '                               WHERE SG710C.PROGRESSIVO = SG710.' +
        'PROGRESSIVO'
      '                               AND SG710C.DATA = SG710.DATA'
      
        '                               AND SG710C.TIPO_VALUTAZIONE = SG7' +
        '10.TIPO_VALUTAZIONE)'
      'UNION'
      'SELECT '#39'2'#39' A,'
      '       SG711.COD_AREA B, SG701.DESCRIZIONE C,'
      '       SG711.COD_VALUTAZIONE D,'
      '       DECODE(SG701.TIPO_LINK_ITEM,'
      
        '              '#39'1'#39',CONCATENA_TESTO('#39'SELECT DESCRIZIONE FROM SG700' +
        '_VALUTAZIONI WHERE COD_AREA = '#39#39#39'||SG701.COD_AREA ||'#39#39#39' AND DECO' +
        'RRENZA = TO_DATE('#39#39#39'||TO_CHAR(SG701.DECORRENZA,'#39'DDMMYYYY'#39')||'#39#39#39',' +
        #39#39'DDMMYYYY'#39#39') ORDER BY COD_VALUTAZIONE'#39','#39' / '#39'),'
      
        '                  NVL(SG711.DESC_VALUTAZIONE_AGG,SG700.DESCRIZIO' +
        'NE)) E,'
      
        '       DECODE(SG701.TIPO_PUNTEGGIO_ITEMS,'#39'1'#39',TO_CHAR(SG711.PUNTE' +
        'GGIO),SG711.COD_PUNTEGGIO) F, SG711.VALUTABILE G'
      'FROM SG711_VALUTAZIONI_DIPENDENTE SG711,'
      '     SG701_AREE_VALUTAZIONI SG701,'
      '     SG700_VALUTAZIONI SG700,'
      '     T030_ANAGRAFICO T030'
      'WHERE SG711.TIPO_VALUTAZIONE = :TIPO'
      'AND SG711.DATA = :DATA'
      'AND SG711.COD_AREA = SG701.COD_AREA'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG700.COD_AREA (+)'
      'AND SG701.DECORRENZA = SG700.DECORRENZA (+)'
      'AND (   (SG701.TIPO_LINK_ITEM = '#39'1'#39')'
      
        '     OR (SG701.TIPO_LINK_ITEM <> '#39'1'#39' AND NVL(SG700.COD_VALUTAZIO' +
        'NE,'#39'#NULL#'#39') = DECODE(SG711.DESC_VALUTAZIONE_AGG,NULL,SG711.COD_' +
        'VALUTAZIONE,NVL(SG700.COD_VALUTAZIONE,'#39'#NULL#'#39'))))'
      'AND T030.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND T030.PROGRESSIVO = :PROGRESSIVO'
      'AND EXISTS (SELECT 1 '
      '            FROM SG710_TESTATA_VALUTAZIONI SG710 '
      
        '            WHERE SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZION' +
        'E '
      '            AND SG710.DATA = SG711.DATA'
      '            AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      
        '            AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENT' +
        'O'
      
        '            AND SG710.STATO_AVANZAMENTO = (SELECT MAX(SG710A.STA' +
        'TO_AVANZAMENTO) '
      
        '                                           FROM SG710_TESTATA_VA' +
        'LUTAZIONI SG710A'
      
        '                                           WHERE SG710A.PROGRESS' +
        'IVO = SG710.PROGRESSIVO'
      
        '                                           AND SG710A.DATA = SG7' +
        '10.DATA'
      
        '                                           AND SG710A.TIPO_VALUT' +
        'AZIONE = SG710.TIPO_VALUTAZIONE)'
      '            AND SG710.VALUTABILE = '#39'S'#39')'
      'ORDER BY A, B, D')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      00000A0000003A005400490050004F0005000000000000000000000018000000
      3A00500052004F0047005200450053005300490056004F000300000000000000
      00000000}
    Left = 600
    Top = 288
  end
  object updSG710: TOracleQuery
    SQL.Strings = (
      'UPDATE SG710_TESTATA_VALUTAZIONI'
      'SET CHIUSO = :CHIUSO,'
      
        '    DATA_CHIUSURA = DECODE(:CHIUSO,'#39'S'#39',DECODE(DATA_CHIUSURA,NULL' +
        ',TRUNC(SYSDATE),DATA_CHIUSURA),NULL),'
      
        '    DATA_COMPILAZIONE = DECODE(:AGGIORNA,'#39'S'#39',DECODE(DATA_CHIUSUR' +
        'A,NULL,TRUNC(SYSDATE),DATA_COMPILAZIONE),DATA_COMPILAZIONE)'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND   DATA = :DATA'
      'AND   TIPO_VALUTAZIONE = :TIPO_VAL'
      'AND   STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A005400490050004F005F00560041004C00
      0500000000000000000000000E0000003A00430048004900550053004F000500
      00000000000000000000120000003A0041004700470049004F0052004E004100
      050000000000000000000000240000003A0053005400410054004F005F004100
      560041004E005A0041004D0045004E0054004F00030000000000000000000000}
    Left = 16
    Top = 288
  end
  object updSG711: TOracleQuery
    SQL.Strings = (
      'UPDATE SG711_VALUTAZIONI_DIPENDENTE'
      'SET VALUTABILE = '#39'N'#39','
      '    PERC_VALUTAZIONE = 0,'
      '    PUNTEGGIO = NULL,'
      '    COD_PUNTEGGIO = NULL,'
      '    PUNTEGGIO_PESATO = 0'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND TIPO_VALUTAZIONE = :TIPO_VAL'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A005400490050004F005F00560041004C00
      050000000000000000000000240000003A0053005400410054004F005F004100
      560041004E005A0041004D0045004E0054004F00030000000000000000000000}
    Left = 80
    Top = 288
  end
  object selPeriodoSchede: TOracleDataSet
    SQL.Strings = (
      'SELECT MIN(DATA) DATA_MIN, MAX(DATA) DATA_MAX'
      'FROM SG710_TESTATA_VALUTAZIONI')
    Optimize = False
    Left = 168
    Top = 8
  end
  object selSG710: TOracleDataSet
    SQL.Strings = (
      
        'SELECT VALUTABILE, IMPORTO_INCENTIVO, ORE_INCENTIVO, STATO_AVANZ' +
        'AMENTO'
      'FROM SG710_TESTATA_VALUTAZIONI SG710'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = (SELECT MAX(SG710A.STATO_AVANZAMENTO) '
      '                         FROM SG710_TESTATA_VALUTAZIONI SG710A'
      
        '                         WHERE SG710A.PROGRESSIVO = SG710.PROGRE' +
        'SSIVO'
      '                         AND SG710A.DATA = SG710.DATA'
      
        '                         AND SG710A.TIPO_VALUTAZIONE = SG710.TIP' +
        'O_VALUTAZIONE)')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E004500050000000000000000000000}
    Left = 16
    Top = 176
  end
  object selSG767: TOracleDataSet
    SQL.Strings = (
      
        'select t767.codgruppo, t767.descrizione, t767.numore_min_dirigen' +
        'ti, t767.importo_max_dirigenti, t768.progressivo'
      'from t767_incquantgruppo t767, t768_incquantindividuali t768'
      'where t767.anno = :ANNO'
      'and t767.anno = t768.anno'
      'and t767.codgruppo = t768.codgruppo'
      'order by t767.codgruppo, t768.progressivo')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 664
    Top = 64
  end
  object selSG745: TOracleDataSet
    SQL.Strings = (
      'SELECT SG745.*, SG745.ROWID'
      'FROM SG745_CONSEGNA_VALUTAZIONI SG745'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 552
    Top = 64
  end
  object selV430a: TOracleDataSet
    SQL.Strings = (
      
        'select :HINTT030V430 t030.progressivo, t030.matricola, t030.cogn' +
        'ome, t030.nome'
      'from :QVistaOracle'
      'and :filtro'
      'and t030.progressivo = :progressivo'
      '')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F000300000000000000000000001A00
      00003A00480049004E0054005400300033003000560034003300300001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 496
    Top = 120
  end
  object cdsRegole: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'CODREGOLA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'PROGRESSIVO_VALUTATORE'
        DataType = ftInteger
      end
      item
        Name = 'STAMPA_ABILITATA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'STATO_ABILITATO'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 176
  end
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'SELECT SG746.*'
      'FROM SG746_STATI_AVANZAMENTO SG746'
      'WHERE :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'AND (CODREGOLA = :CODREGOLA OR :CODREGOLA IS NULL)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000140000003A0043004F0044005200450047004F004C004100050000000000
      000000000000}
    Left = 608
    Top = 64
  end
  object selI072: TOracleDataSet
    SQL.Strings = (
      'select filtro, progressivo'
      'from mondoedp.i072_filtroanagrafe'
      'where azienda = :AZIENDA'
      'and profilo = :FILTRO_ANAGRAFE'
      'order by progressivo')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000200000003A00460049004C00540052004F005F0041004E00
      410047005200410046004500050000000000000000000000}
    Left = 608
    Top = 176
  end
  object selV430b: TOracleDataSet
    SQL.Strings = (
      
        'select :HINTT030V430 t030.progressivo, t030.matricola, t030.cogn' +
        'ome, t030.nome'
      'from :QVistaOracle'
      'and :filtro'
      '')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0048004900
      4E00540054003000330030005600340033003000010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 608
    Top = 120
  end
  object insSG710: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG710_TESTATA_VALUTAZIONI'
      
        '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,VALUTAZIONE_COMPLESSIVE,OBIET' +
        'TIVI_AZIONI,PROPOSTE_FORMATIVE,COMMENTI_VALUTATO,DATA_COMPILAZIO' +
        'NE,'
      
        ' CHIUSO,DATA_CHIUSURA,ACCETTAZIONE_VALUTATO,PROPOSTE_FORMATIVE_1' +
        ',PROPOSTE_FORMATIVE_2,PROPOSTE_FORMATIVE_3,VALUTABILE,'
      
        ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI,STATO_AV' +
        'ANZAMENTO,PROGRESSIVI_VALUTATORI,PUNTEGGIO_FINALE_PESATO,NOTE,'
      
        ' CODREGOLA,DAL,AL,NUMERO_PROTOCOLLO,ANNO_PROTOCOLLO,DATA_PROTOCO' +
        'LLO,TIPO_PROTOCOLLO)'
      'SELECT'
      
        ' DATA,PROGRESSIVO,TIPO_VALUTAZIONE,VALUTAZIONE_COMPLESSIVE,OBIET' +
        'TIVI_AZIONI,PROPOSTE_FORMATIVE,COMMENTI_VALUTATO,DATA_COMPILAZIO' +
        'NE,'
      
        ' CHIUSO,DATA_CHIUSURA,ACCETTAZIONE_VALUTATO,PROPOSTE_FORMATIVE_1' +
        ',PROPOSTE_FORMATIVE_2,PROPOSTE_FORMATIVE_3,VALUTABILE,'
      
        ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI,STATO_AV' +
        'ANZAMENTO + 1,PROGRESSIVI_VALUTATORI,PUNTEGGIO_FINALE_PESATO,NOT' +
        'E,'
      
        ' CODREGOLA,DAL,AL,NUMERO_PROTOCOLLO,ANNO_PROTOCOLLO,DATA_PROTOCO' +
        'LLO,TIPO_PROTOCOLLO'
      'FROM SG710_TESTATA_VALUTAZIONI'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 16
    Top = 232
  end
  object insaSG711: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG711_VALUTAZIONI_DIPENDENTE'
      
        '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,COD_AREA,COD_VALUTAZIONE,VALU' +
        'TABILE,PUNTEGGIO,'
      
        ' DESC_VALUTAZIONE_AGG,COD_PUNTEGGIO,PERC_VALUTAZIONE,SOGLIA_PUNT' +
        'EGGIO,PUNTEGGIO_PESATO,'
      ' STATO_AVANZAMENTO,NOTE_PUNTEGGIO)'
      'SELECT '
      
        ' DATA,PROGRESSIVO,TIPO_VALUTAZIONE,COD_AREA,COD_VALUTAZIONE,VALU' +
        'TABILE,PUNTEGGIO,'
      
        ' DESC_VALUTAZIONE_AGG,COD_PUNTEGGIO,PERC_VALUTAZIONE,SOGLIA_PUNT' +
        'EGGIO,PUNTEGGIO_PESATO,'
      ' STATO_AVANZAMENTO + 1,NOTE_PUNTEGGIO'
      'FROM SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 144
    Top = 232
  end
  object selSG745a: TOracleDataSet
    SQL.Strings = (
      'SELECT DECODE(COUNT(*),0,'#39'N'#39','#39'S'#39') PRESA_VISIONE'
      'FROM SG745_CONSEGNA_VALUTAZIONI SG745'
      'WHERE SG745.TIPO_CONSEGNA = '#39'PV'#39
      'AND SG745.DATA = :DATA'
      'AND SG745.PROGRESSIVO = :PROGRESSIVO'
      'AND SG745.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND SG745.STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      'AND SG745.ESITO = '#39'S'#39
      'AND SG745.PROG_UTENTE = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 552
    Top = 120
  end
  object selSG711a: TOracleDataSet
    SQL.Strings = (
      'SELECT SUM(NVL(SG711.PUNTEGGIO,0)) / COUNT(*) PUNTEGGIO_MEDIO'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710'
      'WHERE SG711.COD_AREA = :COD_AREA'
      'AND SG711.COD_VALUTAZIONE = :COD_VALUTAZIONE'
      'AND SG711.DATA = :DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711A.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711A'
      '                               WHERE SG711A.DATA = SG711.DATA'
      
        '                               AND SG711A.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711A.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG711.VALUTABILE = '#39'S'#39
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000120000003A0043004F0044005F0041005200450041000500000000000000
      00000000200000003A0043004F0044005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000220000003A00540049005000
      4F005F00560041004C005500540041005A0049004F004E004500050000000000
      000000000000}
    Left = 144
    Top = 176
  end
  object selQ710: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'DATARIF'
        DataType = ftDateTime
      end
      item
        Name = 'D_DATA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'D_VALUTATORE'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'STATO_SCHEDA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'PUNTEGGIO_FINALE_PESATO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PERIODO_OBIETTIVI'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'OBIETTIVI_ACCETTATI'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PERIODO_COMPILAZIONE'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'PERIODO_RICHIESTA_VISIONE'
        DataType = ftString
        Size = 25
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 16
    Top = 16
  end
  object selSchedeCollegateAperte: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, SG711.COD_AREA, ' +
        'SG711.COD_VALUTAZIONE, SG701.DESCRIZIONE || '#39' - '#39' || SG700.DESCR' +
        'IZIONE DESCRIZIONE'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, T030_ANAGRAFICO T030, SG701_AREE_VALUTAZIONI SG701, SG' +
        '700_VALUTAZIONI SG700,'
      '     (SELECT /*+ unnest*/ COD_AREA_LINK, COD_VALUTAZIONE_LINK'
      
        '      FROM SG711_VALUTAZIONI_DIPENDENTE SG711A, SG701_AREE_VALUT' +
        'AZIONI SG701A, SG700_VALUTAZIONI SG700A'
      '      WHERE SG711A.PROGRESSIVO = :PROGRESSIVO'
      '      AND SG711A.DATA = :DATA'
      '      AND SG711A.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      '      AND SG711A.STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      '      AND SG701A.COD_AREA = SG711A.COD_AREA'
      
        '      AND :DATA BETWEEN SG701A.DECORRENZA AND SG701A.DECORRENZA_' +
        'FINE'
      '      AND SG700A.COD_AREA = SG701A.COD_AREA'
      '      AND SG700A.DECORRENZA = SG701A.DECORRENZA'
      '      AND (    SG701A.TIPO_LINK_ITEM = '#39'1'#39
      
        '           OR (SG701A.TIPO_LINK_ITEM = '#39'2'#39' AND SG700A.COD_VALUTA' +
        'ZIONE = SG711A.COD_VALUTAZIONE))'
      '      ) LINK'
      'WHERE SG711.COD_AREA = LINK.COD_AREA_LINK'
      'AND SG711.COD_VALUTAZIONE = LINK.COD_VALUTAZIONE_LINK'
      'AND SG711.DATA = :DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711B.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711B'
      '                               WHERE SG711B.DATA = SG711.DATA'
      
        '                               AND SG711B.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711B.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      'AND SG710.CHIUSO = '#39'N'#39
      'AND T030.PROGRESSIVO = SG710.PROGRESSIVO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      'AND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE '
      
        'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, SG711.COD_AREA' +
        ', SG711.COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000220000003A005400490050004F005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F0003000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 312
    Top = 176
  end
  object selSG711b: TOracleDataSet
    SQL.Strings = (
      'SELECT SG711.PROGRESSIVO,'
      
        '       SG711.PUNTEGGIO * DECODE(SG701.TIPO_PESO_PERCENTUALE,'#39'0'#39',' +
        'ROUND(NVL(SG711.PERC_VALUTAZIONE,0) * 100 / NVL(SG701.PESO_PERCE' +
        'NTUALE,0),5),NVL(SG711.PERC_VALUTAZIONE,0)) / 100 RAGG'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, SG701_AREE_VALUTAZIONI SG701, SG700_VALUTAZIONI SG700'
      'WHERE SG711.COD_AREA = :COD_AREA'
      'AND SG711.COD_VALUTAZIONE = :COD_VALUTAZIONE'
      'AND SG711.DATA = :DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711A.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711A'
      '                               WHERE SG711A.DATA = SG711.DATA'
      
        '                               AND SG711A.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711A.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG711.VALUTABILE = '#39'S'#39
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      'AND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE ')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000120000003A0043004F0044005F0041005200450041000500000000000000
      00000000200000003A0043004F0044005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000220000003A00540049005000
      4F005F00560041004C005500540041005A0049004F004E004500050000000000
      000000000000}
    Left = 208
    Top = 176
  end
  object selSchedeCollegateChiuse: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT T030.MATRICOLA, T030.COGNOME, T030.NOME, SG711.C' +
        'OD_AREA, '
      
        '       DECODE(SG701.TIPO_LINK_ITEM,'#39'1'#39','#39#39',SG711.COD_VALUTAZIONE)' +
        ' COD_VALUTAZIONE, '
      
        '       SG701.DESCRIZIONE ||  DECODE(SG701.TIPO_LINK_ITEM,'#39'1'#39','#39#39',' +
        #39' - '#39' || SG700.DESCRIZIONE) DESCRIZIONE'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, T030_ANAGRAFICO T030, SG701_AREE_VALUTAZIONI SG701, SG' +
        '700_VALUTAZIONI SG700,'
      
        '      (SELECT /*+ unnest*/ SG711A.COD_AREA, SG711A.COD_VALUTAZIO' +
        'NE'
      
        '      FROM SG711_VALUTAZIONI_DIPENDENTE SG711A, SG701_AREE_VALUT' +
        'AZIONI SG701A'
      '      WHERE SG711A.PROGRESSIVO = :PROGRESSIVO'
      '      AND SG711A.DATA = :DATA'
      '      AND SG711A.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      '      AND SG711A.STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      '      AND SG701A.COD_AREA = SG711A.COD_AREA'
      
        '      AND :DATA BETWEEN SG701A.DECORRENZA AND SG701A.DECORRENZA_' +
        'FINE'
      '      AND SG701A.TIPO_LINK_ITEM = '#39'0'#39') LINK'
      'WHERE SG711.DATA = :DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711B.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711B'
      '                               WHERE SG711B.DATA = SG711.DATA'
      
        '                               AND SG711B.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711B.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      'AND SG710.CHIUSO = '#39'S'#39
      'AND T030.PROGRESSIVO = SG710.PROGRESSIVO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      
        'AND (SG701.TIPO_LINK_ITEM = '#39'1'#39' OR (SG701.TIPO_LINK_ITEM = '#39'2'#39' A' +
        'ND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE))'
      'AND SG700.COD_AREA_LINK = LINK.COD_AREA'
      'AND SG700.COD_VALUTAZIONE_LINK = LINK.COD_VALUTAZIONE'
      
        'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, SG711.COD_AREA' +
        ', COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000220000003A005400490050004F005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F0003000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 312
    Top = 232
  end
  object updSG711a: TOracleQuery
    SQL.Strings = (
      'UPDATE SG711_VALUTAZIONI_DIPENDENTE SG711'
      'SET PUNTEGGIO = NULL,'
      '    COD_PUNTEGGIO = NULL,'
      '    PUNTEGGIO_PESATO = NULL'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND TIPO_VALUTAZIONE = :TIPO_VAL'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      'AND EXISTS (SELECT 1 FROM SG701_AREE_VALUTAZIONI SG701'
      '            WHERE SG701.COD_AREA = SG711.COD_AREA'
      
        '            AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DE' +
        'CORRENZA_FINE'
      '            AND TIPO_LINK_ITEM IN ('#39'1'#39','#39'2'#39'))')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A005400490050004F005F00560041004C00
      050000000000000000000000240000003A0053005400410054004F005F004100
      560041004E005A0041004D0045004E0054004F00030000000000000000000000}
    Left = 144
    Top = 288
  end
  object selSG742: TOracleDataSet
    SQL.Strings = (
      'SELECT SG742.*'
      'FROM SG742_ETICHETTE_VALUTAZIONI SG742'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044005200450047004F004C004100
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000}
    Left = 440
    Top = 120
  end
  object cdsNoteItem: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'COD_AREA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'D_AREA'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'COD_VALUTAZIONE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'D_VALUTAZIONE'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'COD_PUNTEGGIO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'D_PUNTEGGIO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'NOTE_PUNTEGGIO'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 296
  end
  object selSchedeAnno: TOracleDataSet
    SQL.Strings = (
      'select :data data'
      'from dual'
      'union'
      'select distinct data '
      'from sg710_testata_valutazioni'
      'where data between trunc(:data,'#39'YYYY'#39') and :data - 1'
      'and progressivo = :progressivo'
      'and tipo_valutazione = :tipo_valutazione'
      'union'
      'select :data_rich data'
      'from dual'
      'where :data_rich between trunc(:data,'#39'YYYY'#39') and :data'
      'order by data desc')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000014000000
      3A0044004100540041005F0052004900430048000C0000000000000000000000}
    Left = 88
    Top = 8
  end
  object selSG710b: TOracleQuery
    SQL.Strings = (
      
        'select greatest(nvl(max(data) + 1,to_date('#39'01011900'#39','#39'ddmmyyyy'#39')' +
        '),trunc(:data,'#39'y'#39')) inizio_periodo'
      'From sg710_testata_valutazioni'
      'where progressivo = :progressivo'
      'and tipo_valutazione = :tipo'
      'and data < :data')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 15
    Top = 344
  end
  object RuoloCessato: TOracleDataSet
    SQL.Strings = (
      
        'SELECT GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYYY'#39')) I' +
        'NIZIO, '
      
        '       LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:' +
        'DATA_RIF) FINE'
      'FROM   T430_STORICO, T450_TIPORAPPORTO T450'
      'WHERE  PROGRESSIVO = :PROGR'
      'AND    NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <= :DATA_RIF'
      'AND    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <= :DATA_RIF'
      
        'AND    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= TRUNC(:DATA_R' +
        'IF,'#39'YYYY'#39')'
      'AND    DATADECORRENZA <= :DATA_RIF '
      'AND    DATAFINE >= TRUNC(:DATA_RIF,'#39'YYYY'#39')'
      ':CODICI_TIPO_RAPPORTO'
      'AND    TIPORAPPORTO = T450.CODICE'
      'AND    T450.TIPO = '#39'R'#39
      
        'GROUP BY GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYYY'#39'))' +
        ','
      
        '         LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))' +
        ',:DATA_RIF)'
      
        'HAVING GREATEST(DATADECORRENZA,INIZIO,TRUNC(:DATA_RIF,'#39'YYYY'#39')) <' +
        '= LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:DATA_' +
        'RIF)')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00500052004F00470052000300000000000000
      000000002A0000003A0043004F0044004900430049005F005400490050004F00
      5F0052004100500050004F00520054004F000100000000000000000000001200
      00003A0044004100540041005F005200490046000C0000000000000000000000}
    Left = 320
    Top = 8
  end
  object selI071: TOracleDataSet
    SQL.Strings = (
      'select t030.progressivo,'
      '       t030.matricola,'
      '       t030.cognome||'#39' '#39'||t030.nome nominativo,'
      
        '       t030.matricola||'#39' '#39'||t030.cognome||'#39' '#39'||t030.nome matrico' +
        'la_nominativo,'
      '       i071.s710_stati_abilitati,'
      '       i060.nome_utente,'
      '       i061.filtro_anagrafe'
      'from t030_anagrafico t030,'
      
        '     (select progressivo, nvl(inizio,:DATA + 1) inizio, nvl(fine' +
        ',:DATA) fine '
      '      from t430_storico '
      '      where :DATA between datadecorrenza and datafine) servizio,'
      '     mondoedp.i060_login_dipendente i060, '
      '     mondoedp.i061_profili_dipendente i061,'
      '     mondoedp.i071_permessi i071'
      'where (t030.progressivo = :PROGRESSIVO OR :PROGRESSIVO = -1)'
      'and t030.matricola = i060.matricola'
      'and i060.azienda = :AZIENDA '
      'and i061.azienda = i060.azienda'
      'and i061.nome_utente = i060.nome_utente'
      'and servizio.progressivo = t030.progressivo'
      'and servizio.inizio <= :DATA '
      
        'and LEAST(:DATA,servizio.fine) between i061.inizio_validita and ' +
        'i061.fine_validita'
      'and i071.azienda = i061.azienda'
      'and i071.profilo = i061.permessi'
      'and i071.s710_stati_abilitati is not null'
      'and i071.s710_supervisorevalut = '#39'N'#39
      'order by 3,2')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 552
    Top = 176
  end
  object PeriodoScheda: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :DATA_MIN:=NULL;'
      '  :DAL:=NULL;'
      '  :AL:=NULL;'
      
        '  --Inizio MINIMO per la scheda attuale (inizio anno o giorno su' +
        'ccessivo alla data della scheda precedente)'
      '  SELECT NVL(MAX(DATA) + 1,TRUNC(:DATA_MAX,'#39'Y'#39'))'
      '  INTO   :DATA_MIN'
      '  FROM   SG710_TESTATA_VALUTAZIONI'
      '  WHERE  DATA BETWEEN TRUNC(:DATA_MAX,'#39'Y'#39') AND :DATA_MAX - 1'
      '  AND    PROGRESSIVO = :PROGRESSIVO'
      '  AND    TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE;'
      
        '  --Inizio e Fine periodo scheda attuale (inizio/fine rapporto s' +
        'e interni a inizio MINIMO/fine MASSIMA)'
      '  SELECT MIN(GREATEST(DATADECORRENZA,INIZIO,:DATA_MIN)), '
      
        '         MAX(LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYY' +
        'Y'#39')),:DATA_MAX))'
      '  INTO   :DAL, :AL'
      '  FROM   T430_STORICO'
      '  WHERE  PROGRESSIVO = :PROGRESSIVO'
      '  AND    NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <= :DATA_MAX'
      '  AND    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= :DATA_MIN'
      '  AND    DATADECORRENZA <= :DATA_MAX'
      '  AND    DATAFINE >= :DATA_MIN;'
      '  --'
      '  :DATA_INT:=NULL;'
      '  :DAL_INT:=NULL;'
      '  :AL_INT:=NULL;'
      '  :CHIUSO:='#39'N'#39';'
      '  --Inizio e Fine periodo della scheda intersecata'
      '  BEGIN'
      '    SELECT DATA, DAL, AL, CHIUSO'
      '    INTO   :DATA_INT, :DAL_INT, :AL_INT, :CHIUSO'
      '    FROM   SG710_TESTATA_VALUTAZIONI SG710A'
      '    WHERE  :DATA_MAX BETWEEN DAL AND DATA'
      '    AND    PROGRESSIVO = :PROGRESSIVO'
      '    AND    TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      '    AND    STATO_AVANZAMENTO = (SELECT MAX(STATO_AVANZAMENTO)'
      
        '                                FROM   SG710_TESTATA_VALUTAZIONI' +
        ' SG710B'
      '                                WHERE  SG710B.DATA = SG710A.DATA'
      
        '                                AND    SG710B.PROGRESSIVO = SG71' +
        '0A.PROGRESSIVO'
      
        '                                AND    SG710B.TIPO_VALUTAZIONE =' +
        ' SG710A.TIPO_VALUTAZIONE);'
      '  EXCEPTION'
      '    WHEN OTHERS THEN'
      '      NULL;'
      '  END;'
      'END;')
    Optimize = False
    Variables.Data = {
      040000000A000000120000003A0044004100540041005F004D0049004E000C00
      00000000000000000000080000003A00440041004C000C000000000000000000
      0000060000003A0041004C000C0000000000000000000000120000003A004400
      4100540041005F004D00410058000C0000000000000000000000180000003A00
      500052004F0047005200450053005300490056004F0003000000000000000000
      0000220000003A005400490050004F005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000120000003A00440041005400
      41005F0049004E0054000C0000000000000000000000100000003A0044004100
      4C005F0049004E0054000C00000000000000000000000E0000003A0041004C00
      5F0049004E0054000C00000000000000000000000E0000003A00430048004900
      550053004F00050000000000000000000000}
    Left = 280
    Top = 288
  end
  object updSG710a: TOracleQuery
    SQL.Strings = (
      'UPDATE SG710_TESTATA_VALUTAZIONI'
      'SET DAL = :DAL,'
      '    AL = :AL'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND   DATA = :DATA'
      'AND   TIPO_VALUTAZIONE = :TIPO_VAL')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A005400490050004F005F00560041004C00
      050000000000000000000000080000003A00440041004C000C00000000000000
      00000000060000003A0041004C000C0000000000000000000000}
    Left = 352
    Top = 288
  end
  object selStoriaValInterm: TOracleQuery
    SQL.Strings = (
      'select SG710F_STORIA_VAL_INTERM(:data,:progressivo,:tipo,:stato)'
      'From dual')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      000000000C0000003A0053005400410054004F00030000000000000000000000}
    Left = 279
    Top = 344
  end
  object insSG710auto: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG710_TESTATA_VALUTAZIONI'
      '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,STATO_AVANZAMENTO,'
      
        ' CODREGOLA,DAL,AL,DATA_COMPILAZIONE,PROGRESSIVI_VALUTATORI,PUNTE' +
        'GGIO_FINALE_PESATO,'
      ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI)'
      'SELECT'
      ' DATA,PROGRESSIVO,'#39'A'#39',1,'
      ' CODREGOLA,DAL,AL,TRUNC(SYSDATE),TO_CHAR(PROGRESSIVO),0,'
      ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI'
      'FROM SG710_TESTATA_VALUTAZIONI'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 24
    Top = 400
  end
  object insSG711auto: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG711_VALUTAZIONI_DIPENDENTE'
      '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,STATO_AVANZAMENTO,'
      ' COD_AREA,COD_VALUTAZIONE,VALUTABILE,'
      ' DESC_VALUTAZIONE_AGG,PERC_VALUTAZIONE,SOGLIA_PUNTEGGIO)'
      'SELECT '
      ' DATA,PROGRESSIVO,'#39'A'#39',1,'
      ' COD_AREA,COD_VALUTAZIONE,VALUTABILE,'
      ' DESC_VALUTAZIONE_AGG,PERC_VALUTAZIONE,SOGLIA_PUNTEGGIO'
      'FROM SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 96
    Top = 400
  end
  object cdsNoteValida: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'MOTIVAZIONE'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 352
  end
end
