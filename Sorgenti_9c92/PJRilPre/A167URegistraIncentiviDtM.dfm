inherited A167FRegistraIncentiviDtM: TA167FRegistraIncentiviDtM
  OldCreateOrder = True
  Height = 392
  Width = 926
  object dsrI010: TDataSource
    AutoEdit = False
    Left = 28
    Top = 128
  end
  object selT775: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, decorrenza, NVL(scadenza,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39')) SCADENZA, codtipoquota, importo, '
      
        '       penalizzazione, saltaprova, num_ore, perc_individuale, pe' +
        'rc_strutturale, considera_saldo, '
      '       percentuale, sospendi_pt, sospendi_quote, '
      
        '       LEAST(NVL(SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:DFIN)' +
        ' - GREATEST(DECORRENZA,:DINI) + 1 GIORNI'
      '  from T775_QUOTEINDIVIDUALI T'
      ' where PROGRESSIVO = :PROGRESSIVO '
      '   and DECORRENZA <= :DFIN'
      '   and NVL(SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= :DINI'
      'order by codtipoquota, decorrenza')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A004400460049004E000C00
      000000000000000000000A0000003A00440049004E0049000C00000000000000
      00000000}
    Left = 136
    Top = 62
  end
  object selT760: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T760_REGOLEINCENTIVI T760'
      
        'WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCEN' +
        'TIVI'
      '                     WHERE DECORRENZA <= :DECORRENZA'
      '                       AND LIVELLO = T760.LIVELLO)'
      'AND LIVELLO = :LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000100000003A004C004900560045004C004C00
      4F00050000000000000000000000}
    Left = 184
    Top = 14
  end
  object selT762: TOracleDataSet
    SQL.Strings = (
      'select t762.*,t762.rowid '
      'from t762_incentivimaturati t762'
      'where anno = :ANNO'
      '  and progressivo = :PROG'
      'order by anno, mese, codtipoquota')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F00030000000000000000000000}
    Left = 24
    Top = 16
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,INCENTIVI,PIANTA'
      'from t460_parttime'
      'order by CODICE')
    ReadBuffer = 500
    Optimize = False
    Left = 356
    Top = 14
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'select T040.PROGRESSIVO, T040.CAUSALE, T040.DATA, T040.TIPOGIUST' +
        ', T040.DATANAS,'
      
        '       T769.COD_TIPOACCORPCAUSALI, T769.COD_CODICIACCORPCAUSALI,' +
        ' t769.decorrenza, t769.decorrenza_FINE, '
      
        '       T769.GESTIONE_FRANCHIGIA, T769.FRANCHIGIA_ASSENZE, T769.T' +
        'IPO_ABBATTIMENTO,'
      
        '       T769.CONTA_FRUITO_ORE, T769.FORZA_ABB_GGINT, T769.PERC_AB' +
        'BATTIMENTO, T769.PERC_ABB_FRANCHIGIA, '
      
        '       T769.ASSENZE_AGGIUNTIVE, T769.PROPORZIONE_FRANCHIGIA, T76' +
        '9.CONTA_SOLO_GGINT'
      
        'from t040_giustificativi T040, T257_accorpcausali T257, T769_inc' +
        'entiviassenze T769, t766_incentivitipoabbat t766'
      'where PROGRESSIVO = :PROG'
      '  and T040.DATA BETWEEN :DADATA AND :ADATA'
      '  AND T040.CAUSALE = T257.COD_CAUSALE'
      '  AND T257.COD_TIPOACCORPCAUSALI = T769.COD_TIPOACCORPCAUSALI'
      
        '  AND T257.COD_CODICIACCORPCAUSALI = T769.COD_CODICIACCORPCAUSAL' +
        'I'
      
        '  AND DECODE(T769.DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),T769.DATO1) = NVL(:D' +
        'ATO1,'#39' '#39')'
      
        '  AND DECODE(T769.DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),T769.DATO2) = NVL(:D' +
        'ATO2,'#39' '#39')'
      
        '  AND DECODE(T769.DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),T769.DATO3) = NVL(:D' +
        'ATO3,'#39' '#39')'
      '  AND T040.DATA BETWEEN T769.DECORRENZA AND T769.DECORRENZA_FINE'
      '  and t769.tipo_abbattimento = t766.codice (+)'
      
        'order by NVL(t766.risparmio_bilancio,'#39'N'#39') DESC, DATA, T040.CAUSA' +
        'LE')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000C0000003A004400410054004F0031000500000000000000000000000C00
      00003A004400410054004F0032000500000000000000000000000C0000003A00
      4400410054004F0033000500000000000000000000000E0000003A0044004100
      44004100540041000C00000000000000000000000C0000003A00410044004100
      540041000C0000000000000000000000}
    Left = 428
    Top = 14
  end
  object selT040A: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT T040.CAUSALE, T040.DATANAS'
      'from t040_giustificativi T040, T257_accorpcausali T257'
      'where PROGRESSIVO = :PROG'
      '  and DATA BETWEEN :DADATA AND :ADATA'
      '  AND ('
      
        '     (T040.CAUSALE = T257.COD_CAUSALE AND T257.COD_TIPOACCORPCAU' +
        'SALI = :TIPOACCORP AND T257.COD_CODICIACCORPCAUSALI = :CODACCORP' +
        ') OR'
      '     (T040.CAUSALE IN (:ASSENZEAGG))'
      '      )')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A004400410044004100540041000C0000000000000000000000
      0C0000003A00410044004100540041000C000000000000000000000016000000
      3A005400490050004F004100430043004F005200500005000000000000000000
      0000140000003A0043004F0044004100430043004F0052005000050000000000
      000000000000160000003A0041005300530045004E005A004500410047004700
      010000000000000000000000}
    Left = 428
    Top = 64
  end
  object selT770: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from T770_QUOTE T770'
      ' where DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE '
      '                      WHERE DATO1 = T770.DATO1'
      '                        AND DATO2 = T770.DATO2'
      '                        AND DATO3 = T770.DATO3'
      '                        AND CODTIPOQUOTA = T770.CODTIPOQUOTA'
      '                        AND DECORRENZA <= :DATA)'
      '   and DECORRENZA_FINE >= :DATA'
      'order by CODTIPOQUOTA, DATO1||DATO2||DATO3 DESC')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A004400410054004F0031000500000000000000000000000C00
      00003A004400410054004F0032000500000000000000000000000C0000003A00
      4400410054004F003300050000000000000000000000}
    Left = 136
    Top = 16
  end
  object selT763: TOracleDataSet
    SQL.Strings = (
      'select t763.*,t763.rowid '
      'from t763_incentiviabbattimenti t763'
      'where anno = :ANNO'
      '  and progressivo = :PROG'
      'order by progressivo, mese')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A00500052004F004700030000000000000000000000}
    Left = 24
    Top = 64
  end
  object ControlloT257: TOracleDataSet
    SQL.Strings = (
      
        'select T769.DATO1,T769.DATO2,T769.DATO3,T769.DECORRENZA,T257.COD' +
        '_CAUSALE, COUNT(*) '
      'from t769_incentiviassenze t769, T257_ACCORPCAUSALI T257'
      'WHERE T769.COD_TIPOACCORPCAUSALI = T257.COD_TIPOACCORPCAUSALI'
      'AND T769.COD_CODICIACCORPCAUSALI = T257.COD_CODICIACCORPCAUSALI'
      
        'GROUP BY T769.DATO1,T769.DATO2,T769.DATO3,T769.DECORRENZA,T257.C' +
        'OD_CAUSALE'
      'HAVING COUNT(*) > 1')
    Optimize = False
    Left = 32
    Top = 224
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
    Left = 266
    Top = 224
  end
  object selP030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NUM_DEC_IMP_VOCE, 1 / TO_NUMBER(RPAD('#39'1'#39',NUM_DEC_IMP_VOCE' +
        '+1,'#39'0'#39')) DECIMALI, ABBREVIAZIONE FROM P030_VALUTE T1 WHERE'
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
    Left = 210
    Top = 224
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 418
    Top = 235
  end
  object selT766: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from T766_incentivitipoabbat'
      'ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F00540041000100000000001C0000004400
      4500530043005F005400490050004F00510055004F0054004100010000000000}
    Left = 499
    Top = 14
  end
  object TabellaStampaTotali: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 506
    Top = 235
  end
  object selT769: TOracleDataSet
    SQL.Strings = (
      
        'select T769.CAUSALE, T769.CONTA_FRUITO_ORE, T769.FORZA_ABB_GGINT' +
        ', T769.PERC_ABBATTIMENTO, T769.PERC_ABB_FRANCHIGIA, t769.CONTA_S' +
        'OLO_GGINT'
      'from T769_incentiviassenze T769'
      'where CAUSALE <> '#39' '#39
      
        '  AND DECODE(T769.DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),T769.DATO1) = NVL(:D' +
        'ATO1,'#39' '#39')'
      
        '  AND DECODE(T769.DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),T769.DATO2) = NVL(:D' +
        'ATO2,'#39' '#39')'
      
        '  AND DECODE(T769.DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),T769.DATO3) = NVL(:D' +
        'ATO3,'#39' '#39')'
      
        '  AND T769.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T769_INCENT' +
        'IVIASSENZE'
      '                          WHERE DATO1 = T769.DATO1'
      '                            AND DATO2 = T769.DATO2'
      '                            AND DATO3 = T769.DATO3'
      
        '                            AND COD_TIPOACCORPCAUSALI = T769.COD' +
        '_TIPOACCORPCAUSALI'
      
        '                            AND COD_CODICIACCORPCAUSALI = T769.C' +
        'OD_CODICIACCORPCAUSALI'
      '                            AND DECORRENZA <= :DATA)'
      '  AND T769.DECORRENZA_FINE >= :DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A004400410054004F0031000500000000000000
      000000000C0000003A004400410054004F003200050000000000000000000000
      0C0000003A004400410054004F0033000500000000000000000000000A000000
      3A0044004100540041000C0000000000000000000000}
    Left = 428
    Top = 112
  end
  object selT762Risp: TOracleDataSet
    SQL.Strings = (
      
        'select MESE, CODTIPOQUOTA, sum(giorni_ore) GIORNI_ORE, sum(impor' +
        'to) IMPORTO'
      '  from t762_incentivimaturati t762, t766_incentivitipoabbat t766'
      ' where t762.tipoimporto = t766.codice'
      '   and t766.risparmio_bilancio = '#39'S'#39
      '   and t762.progressivo = :PROG'
      '   and t762.anno = :ANNO'
      'group by mese, codtipoquota'
      'order by mese, codtipoquota')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F00030000000000000000000000}
    Left = 553
    Top = 15
  end
  object ControlloT770: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from T770_QUOTE T770'
      ' where DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and CODTIPOQUOTA = :CODQUOTA'
      '   and DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE '
      '                      WHERE DATO1 = T770.DATO1'
      '                        AND DATO2 = T770.DATO2'
      '                        AND DATO3 = T770.DATO3'
      '                        AND CODTIPOQUOTA = T770.CODTIPOQUOTA'
      '                        AND DECORRENZA <= :DATA)'
      '   and DECORRENZA_FINE >= :DATA')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A004400410054004F0031000500000000000000000000000C00
      00003A004400410054004F0032000500000000000000000000000C0000003A00
      4400410054004F003300050000000000000000000000120000003A0043004F00
      4400510055004F0054004100050000000000000000000000}
    Left = 296
    Top = 160
  end
  object selT762Imp: TOracleDataSet
    SQL.Strings = (
      'SELECT TIPOIMPORTO, SUM(GIORNI_ore) GIORNI_ORE,'
      '  SUM(T762.importo) IMPORTO100, '
      
        '  SUM((T762.IMPORTO * NVL(T775.PERCENTUALE,100) / 100 * :PESO_ST' +
        'RUTT / 100 * NVL(T775.PERC_STRUTTURALE,100) / 100) + '
      
        '      (T762.IMPORTO * NVL(T775.PERCENTUALE,100) / 100 * :PESO_IN' +
        'D / 100 * NVL(T775.PERC_INDIVIDUALE,100) / 100)) IMPORTO'
      'FROM T762_INCENTIVIMATURATI T762, T775_QUOTEINDIVIDUALI T775'
      'WHERE ANNO = :ANNO'
      '  and mese = :MESE'
      '  AND T762.CODTIPOQUOTA IN (:ACCONTI)'
      '  AND T762.PROGRESSIVO = :PROG'
      '  AND T762.PROGRESSIVO = T775.PROGRESSIVO (+)'
      
        '  AND LAST_DAY(TO_DATE('#39'01'#39'||LPAD(TO_CHAR(T762.MESE),2,'#39'0'#39')||TO_' +
        'CHAR(T762.ANNO),'#39'DDMMYYYY'#39')) BETWEEN T775.DECORRENZA (+) AND T77' +
        '5.SCADENZA (+)  '
      '  AND T775.CODTIPOQUOTA (+) = :COD'
      'GROUP BY TIPOIMPORTO'
      'ORDER BY TIPOIMPORTO'
      '')
    Optimize = False
    Variables.Data = {
      04000000070000000A0000003A00500052004F00470003000000040000000400
      0000000000000A0000003A0041004E004E004F000300000004000000D9070000
      00000000100000003A004100430043004F004E00540049000100000004000000
      27312700000000000A0000003A004D0045005300450003000000000000000000
      0000080000003A0043004F004400050000000000000000000000180000003A00
      5000450053004F005F0053005400520055005400540004000000000000000000
      0000120000003A005000450053004F005F0049004E0044000400000000000000
      00000000}
    Left = 721
    Top = 15
  end
  object selT762ImpTot: TOracleDataSet
    SQL.Strings = (
      
        'SELECT TIPOIMPORTO, T766.RISPARMIO_BILANCIO RISPARMIO, SUM(GIORN' +
        'I_ORE) GIORNI_ORE,'
      '  SUM(T762.IMPORTO) IMPORTO100, '
      
        '  SUM((T762.IMPORTO * NVL(T775.PERCENTUALE,100) / 100 * :PESO_ST' +
        'RUTT / 100 * NVL(T775.PERC_STRUTTURALE,100) / 100) + '
      
        '      (T762.IMPORTO * NVL(T775.PERCENTUALE,100) / 100 * :PESO_IN' +
        'D / 100 * NVL(T775.PERC_INDIVIDUALE,100) / 100)) IMPORTO'
      
        'FROM T762_INCENTIVIMATURATI T762,  t766_incentivitipoabbat T766,' +
        ' T430_STORICO T430, T775_QUOTEINDIVIDUALI T775'
      'WHERE T762.ANNO = :ANNO'
      '  and T762.mese = :MESE'
      '  AND T762.CODTIPOQUOTA IN (:ACCONTI)'
      '  AND T762.TIPOIMPORTO = T766.CODICE (+)'
      '  AND T762.PROGRESSIVO = T430.PROGRESSIVO'
      '  AND T762.PROGRESSIVO = T775.PROGRESSIVO (+)'
      
        '  AND LAST_DAY(TO_DATE('#39'01'#39'||LPAD(TO_CHAR(T762.MESE),2,'#39'0'#39')||TO_' +
        'CHAR(T762.ANNO),'#39'DDMMYYYY'#39')) BETWEEN T430.DATADECORRENZA AND T43' +
        '0.DATAFINE  '
      
        '  AND LAST_DAY(TO_DATE('#39'01'#39'||LPAD(TO_CHAR(T762.MESE),2,'#39'0'#39')||TO_' +
        'CHAR(T762.ANNO),'#39'DDMMYYYY'#39')) BETWEEN T775.DECORRENZA (+) AND T77' +
        '5.SCADENZA (+)'
      '  AND T775.CODTIPOQUOTA (+) = :COD'
      '  :FILTROPROG'
      'GROUP BY TIPOIMPORTO, T766.RISPARMIO_BILANCIO'
      'ORDER BY T766.RISPARMIO_BILANCIO DESC,TIPOIMPORTO')
    Optimize = False
    Variables.Data = {
      04000000070000000A0000003A0041004E004E004F0003000000000000000000
      0000100000003A004100430043004F004E005400490001000000000000000000
      0000160000003A00460049004C00540052004F00500052004F00470001000000
      020000002000000000000A0000003A004D004500530045000300000000000000
      00000000080000003A0043004F00440005000000000000000000000018000000
      3A005000450053004F005F005300540052005500540054000400000000000000
      00000000120000003A005000450053004F005F0049004E004400040000000000
      000000000000}
    Left = 721
    Top = 63
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select t070.*, t070.rowid '
      'from t070_schedariepil t070'
      'where progressivo = :PROG'
      '  and data = :DATA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 624
    Top = 16
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'select t071.*, t071.rowid '
      'from t071_schedafasce t071'
      'where progressivo = :PROG'
      '  and data = :DATA'
      '  and maggiorazione = '
      
        '      (select min(maggiorazione) from  t071_schedafasce where pr' +
        'ogressivo = :PROG and data = :DATA) '
      '  and rownum = 1')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 624
    Top = 64
  end
  object ControlloT070: TOracleDataSet
    SQL.Strings = (
      'select COUNT(*) CONTA'
      '  from T070_schedariepil'
      'where progressivo = :PROG'
      '  and data >= :data'
      '  and (causale1minass = :CAUSALE OR causale2minass = :CAUSALE)')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C000000000000000000000010000000
      3A00430041005500530041004C004500050000000000000000000000}
    Left = 624
    Top = 112
  end
  object selT040B: TOracleDataSet
    SQL.Strings = (
      
        'select DISTINCT T040.DATA, T770.IMPORTO, T770.PERCENTUALE, T770.' +
        'SOSPENDI_PT, t770.considera_saldo'
      '  from T040_GIUSTIFICATIVI T040, T770_QUOTE T770'
      ' where T040.PROGRESSIVO = :PROG'
      '   and T040.DATA BETWEEN :DADATA AND :ADATA'
      '   and T040.CAUSALE = T770.CAUSALE '
      '   and DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and T770.CODTIPOQUOTA = '#39' '#39
      
        '   and T040.DATA BETWEEN T770.DECORRENZA AND T770.DECORRENZA_FIN' +
        'E')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A004400410044004100540041000C0000000000000000000000
      0C0000003A00410044004100540041000C00000000000000000000000C000000
      3A004400410054004F0031000500000000000000000000000C0000003A004400
      410054004F0032000500000000000000000000000C0000003A00440041005400
      4F003300050000000000000000000000}
    Left = 424
    Top = 168
  end
  object TabellaAcconti: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 626
    Top = 235
  end
  object selT774: TOracleDataSet
    SQL.Strings = (
      'SELECT SUM(PESO_CALCOLATO) PESO'
      'FROM T774_PESATUREINDIVIDUALI'
      'WHERE ANNO = :ANNO'
      'AND PROGRESSIVO = :PROG'
      'AND CODTIPOQUOTA = :QUOTA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A00500052004F0047000300000000000000000000000C000000
      3A00510055004F0054004100050000000000000000000000}
    Left = 184
    Top = 62
  end
  object selT768: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T768_INCQUANTINDIVIDUALI'
      'WHERE PROGRESSIVO = :PROG'
      '  AND ANNO = :ANNO'
      '  AND CODTIPOQUOTA = :CODQUOTA'
      '  AND CONFERMATO = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F0003000000000000000000000012000000
      3A0043004F004400510055004F0054004100050000000000000000000000}
    Left = 232
    Top = 14
  end
  object selT767: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T767_INCQUANTGRUPPO'
      'WHERE ANNO = :ANNO'
      '  AND CODTIPOQUOTA = :CODQUOTA'
      '  AND CODGRUPPO = :CODGRUPPO')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000120000003A0043004F004400510055004F00540041000500000000000000
      00000000140000003A0043004F004400470052005500500050004F0005000000
      0000000000000000}
    Left = 232
    Top = 62
  end
  object selT768Flex: TOracleDataSet
    SQL.Strings = (
      'select FLESSIBILITA'
      '  from t768_incquantindividuali T768, T765_TIPOQUOTE T765'
      'where anno = :anno'
      '  and progressivo = :prog'
      '  and confermato = '#39'S'#39
      '  AND T768.CODTIPOQUOTA = T765.CODICE'
      
        '  AND T765.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQU' +
        'OTE'
      '                          WHERE CODICE = T765.CODICE)'
      '  AND INSTR('#39','#39'||T765.ACCONTI||'#39','#39','#39','#39'||:QUOTA||'#39','#39') > 0')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F000300000000000000000000000C000000
      3A00510055004F0054004100050000000000000000000000}
    Left = 232
    Top = 110
  end
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select perc'
      'from sg735_punteggifasce_incentivi'
      'where tipologia = :tipologia'
      '  and codquota = :quota'
      '  and flessibilita = :flex'
      '  and :datarif between decorrenza and decorrenza_fine'
      '  and :percrif between punteggio_da and punteggio_a'
      '')
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00510055004F00540041000500000000000000
      00000000100000003A0044004100540041005200490046000C00000000000000
      000000000A0000003A0046004C00450058000500000000000000000000001400
      00003A005400490050004F004C004F0047004900410005000000000000000000
      0000100000003A00500045005200430052004900460004000000000000000000
      0000}
    Left = 296
    Top = 108
  end
  object TabellaTipoD: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 722
    Top = 235
  end
  object selT430Lav: TOracleDataSet
    SQL.Strings = (
      'SELECT MIN(GREATEST(INIZIO,:DAL)) INI, '
      
        '       MAX(LEAST(NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:AL)) ' +
        'FIN'
      'FROM   T430_STORICO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    DATADECORRENZA <= :AL'
      'AND    DATAFINE >= :DAL'
      'GROUP BY INIZIO,'
      '         FINE'
      
        'HAVING GREATEST(INIZIO,:DAL) <= LEAST(NVL(FINE,TO_DATE('#39'31123999' +
        #39','#39'DDMMYYYY'#39')),:AL)'
      'ORDER BY 1,2')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F00030000000000000000000000}
    Left = 720
    Top = 288
  end
  object selT430Dati: TOracleDataSet
    SQL.Strings = (
      'SELECT GREATEST(DATADECORRENZA,:DAL) INI, '
      '       LEAST(DATAFINE,:AL) FIN,'
      '       :DATI_select'
      'FROM   T430_STORICO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    DATADECORRENZA <= :AL'
      'AND    DATAFINE >= :DAL'
      'ORDER BY 1,2'
      ''
      '/*'
      'SELECT MIN(GREATEST(DATADECORRENZA,INIZIO,:DAL)) INI, '
      
        '       MAX(LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39 +
        ')),:AL)) FIN,'
      '       :DATI_select'
      'FROM   T430_STORICO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      '--AND    NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <= :AL'
      '--AND    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= :DAL'
      'AND    DATADECORRENZA <= :AL'
      'AND    DATAFINE >= :DAL'
      'GROUP BY --GREATEST(DATADECORRENZA,INIZIO,:DAL),'
      
        '         --LEAST(DATAFINE,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39 +
        ')),:AL),'
      '         INIZIO,'
      '         FINE,'
      '         :DATI_group_by'
      
        '--HAVING GREATEST(DATADECORRENZA,INIZIO,:DAL) <= LEAST(DATAFINE,' +
        'NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:AL)'
      'ORDER BY 1,2'
      '*/')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F000300000000000000000000001800
      00003A0044004100540049005F00530045004C00450043005400010000000000
      000000000000}
    Left = 720
    Top = 336
  end
  object CreaTabellaTest: TOracleScript
    Left = 792
    Top = 288
  end
  object selTabellaTest: TOracleDataSet
    SQL.Strings = (
      'SELECT t.*, t.rowid'
      'FROM :TABELLA t')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410001000000
      0000000000000000}
    Left = 792
    Top = 336
  end
  object cdsT430Dati: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'INI'
        DataType = ftDateTime
      end
      item
        Name = 'FIN'
        DataType = ftDateTime
      end
      item
        Name = 'PARTTIME'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DATO1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DATO2'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DATO3'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 648
    Top = 336
  end
end
