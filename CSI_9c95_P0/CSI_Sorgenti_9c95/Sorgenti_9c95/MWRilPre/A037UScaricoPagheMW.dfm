inherited A037FScaricoPagheMW: TA037FScaricoPagheMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 441
  Width = 802
  object selT191: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T191_PARPAGHE'
      'WHERE TIPO_PARAMETRIZZAZIONE = '#39'PAGHE'#39
      'ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000F0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      00005400490050004F00460049004C0045000100000000001600000044004500
      4600410055004C00540045004E00540045000100000000001600000054004100
      420045004C004C00410045004E00540045000100000000001200000043004100
      4D0050004F0045004E0054004500010000000000100000004E004F004D004500
      460049004C004500010000000000100000004400410054004100460049004C00
      4500010000000000100000004D0045005300450041004E004E004F0001000000
      00001400000046004F0052004D00410054004F004F0052004500010000000000
      1400000050005200450043004900530049004F004E0045000100000000001200
      00005500530045005200500041004700480045000100000000002C0000005300
      41004C0056004100540041004700470049004F005F004100550054004F004D00
      41005400490043004F0001000000000024000000530045005000410052004100
      54004F005200450044004500430049004D0041004C0049000100000000001A00
      00005400490050004F0044004100540041005F00460049004C00450001000000
      0000}
    Left = 53
    Top = 64
    object selT191CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'CODICE'
      Origin = 'T191_PARPAGHE.CODICE'
      Size = 5
    end
    object selT191DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T191_PARPAGHE.DESCRIZIONE'
      Size = 40
    end
    object selT191DEFAULTENTE: TStringField
      FieldName = 'DEFAULTENTE'
      Origin = 'T191_PARPAGHE.DEFAULTENTE'
    end
    object selT191TABELLAENTE: TStringField
      FieldName = 'TABELLAENTE'
      Origin = 'T191_PARPAGHE.TABELLAENTE'
      Size = 50
    end
    object selT191CAMPOENTE: TStringField
      FieldName = 'CAMPOENTE'
      Origin = 'T191_PARPAGHE.CAMPOENTE'
      Size = 30
    end
    object selT191NOMEFILE: TStringField
      FieldName = 'NOMEFILE'
      Origin = 'T191_PARPAGHE.NOMEFILE'
      Size = 80
    end
    object selT191DATAFILE: TStringField
      FieldName = 'DATAFILE'
      Origin = 'T191_PARPAGHE.DATAFILE'
      Size = 10
    end
    object selT191TIPOFILE: TStringField
      FieldName = 'TIPOFILE'
      Origin = 'T191_PARPAGHE.TIPOFILE'
      Size = 1
    end
    object selT191FORMATOORE: TStringField
      FieldName = 'FORMATOORE'
      Origin = 'T191_PARPAGHE.FORMATOORE'
      Size = 1
    end
    object selT191PRECISIONE: TStringField
      FieldName = 'PRECISIONE'
      Origin = 'T191_PARPAGHE.PRECISIONE'
      Size = 1
    end
    object selT191USERPAGHE: TStringField
      FieldName = 'USERPAGHE'
      Origin = 'T191_PARPAGHE.USERPAGHE'
    end
    object selT191SALVATAGGIO_AUTOMATICO: TStringField
      FieldName = 'SALVATAGGIO_AUTOMATICO'
      Size = 1
    end
    object selT191SEPARATOREDECIMALI: TStringField
      FieldName = 'SEPARATOREDECIMALI'
      Size = 1
    end
    object selT191MESEANNO: TStringField
      FieldName = 'MESEANNO'
      Size = 10
    end
    object selT191TIPODATA_FILE: TStringField
      FieldName = 'TIPODATA_FILE'
      Size = 1
    end
    object selT191RICREAZIONE_AUTOMATICA: TStringField
      DisplayWidth = 1
      FieldName = 'RICREAZIONE_AUTOMATICA'
      Size = 1
    end
  end
  object dsrT191: TDataSource
    DataSet = selT191
    Left = 97
    Top = 64
  end
  object selCodiciScaricoT196: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T196.CODICE'
      'FROM T196_FILTROSCARICOPAGHE T196'
      'ORDER BY T196.CODICE'
      '')
    ReadBuffer = 100
    Optimize = False
    Left = 96
    Top = 129
  end
  object selT196: TOracleDataSet
    SQL.Strings = (
      'SELECT T196.*, T196.ROWID'
      'FROM T196_FILTROSCARICOPAGHE T196'
      'WHERE UPPER(T196.CODICE) = UPPER(:CODICE)'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 16
    Top = 129
  end
  object selCountCodiciT196: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) AS NUMREC'
      'FROM T196_FILTROSCARICOPAGHE T196'
      'WHERE T196.CODICE =:CODICE'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 200
    Top = 129
  end
  object selT193Filtro: TOracleDataSet
    SQL.Strings = (
      
        'select t1.voce_paghe_cedolino cod_voce, '#39'Voce con pi'#249' descrizion' +
        'i'#39' descrizione'
      'from t193_vocipaghe_parametri t1,'
      '    (select voce_paghe_cedolino, count(distinct(descrizione)) '
      '     from t193_vocipaghe_parametri t'
      '     where t.decorrenza = (select max(t3.decorrenza)'
      '                           from t193_vocipaghe_parametri t3'
      
        '                           where t.cod_interfaccia = t3.cod_inte' +
        'rfaccia'
      
        '                           and t.voce_paghe_cedolino = t3.voce_p' +
        'aghe_cedolino)'
      '     group by voce_paghe_cedolino'
      '     having count(distinct(descrizione)) > 1) t2'
      'where t1.voce_paghe_cedolino = t2.voce_paghe_cedolino'
      'union '
      'select distinct t1.voce_paghe_cedolino cod_voce, t4.descrizione'
      'from t193_vocipaghe_parametri t1,'
      '    (select voce_paghe_cedolino, count(distinct(descrizione)) '
      '     from t193_vocipaghe_parametri t'
      '     where t.decorrenza = (select max(t3.decorrenza)'
      '                           from t193_vocipaghe_parametri t3'
      
        '                           where t.cod_interfaccia = t3.cod_inte' +
        'rfaccia'
      
        '                           and t.voce_paghe_cedolino = t3.voce_p' +
        'aghe_cedolino)'
      '     group by voce_paghe_cedolino'
      '     having count(distinct(descrizione)) <= 1) t2,'
      '    (select voce_paghe_cedolino, descrizione'
      '     from t193_vocipaghe_parametri t'
      '     where t.decorrenza = (select max(t3.decorrenza)'
      '                           from t193_vocipaghe_parametri t3'
      
        '                           where t.cod_interfaccia = t3.cod_inte' +
        'rfaccia'
      
        '                           and t.voce_paghe_cedolino = t3.voce_p' +
        'aghe_cedolino)'
      '     and descrizione is not null) t4'
      'where t1.voce_paghe_cedolino = t2.voce_paghe_cedolino'
      'and t1.voce_paghe_cedolino = t4.voce_paghe_cedolino (+)'
      'order by cod_voce')
    Optimize = False
    Left = 199
    Top = 64
  end
  object selT199: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T199_DATACASSA')
    ReadBuffer = 1
    Optimize = False
    Left = 332
    Top = 128
  end
  object selMaxDataCassa: TOracleDataSet
    SQL.Strings = (
      'SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI')
    Optimize = False
    Left = 559
    Top = 64
  end
  object selT710: TOracleDataSet
    SQL.Strings = (
      'select * from ('
      
        '  select T710.ANNO,T710.CAPITOLO,T710.ARTICOLO,T710.COEL,T710.ST' +
        'ANZIAMENTO,T710.DISPONIBILITA + nvl(T710B.VARIAZIONE,0) DISPONIB' +
        'ILITA, T710.UTILIZZO '
      
        '  from T710_BUDGETESTERNO_ANNUO T710, T710_BUDGETESTERNO_ANNUO T' +
        '710B'
      '  where T710.UTILIZZO is not null'
      '  and T710.ANNO = T710B.ANNO(+)'
      '  and T710.CAPITOLO = T710B.CAPITOLO(+)'
      '  and T710.ARTICOLO = T710B.ARTICOLO(+)'
      '  and T710.COEL = T710B.COEL(+)'
      
        '  and to_date('#39'0101'#39'||T710.ANNO,'#39'ddmmyyyy'#39') <= nvl(T710B.SCADENZ' +
        'A_VARIAZIONE(+),to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      
        '  and to_date('#39'3112'#39'||T710.ANNO,'#39'ddmmyyyy'#39') >= T710B.DECORRENZA_' +
        'VARIAZIONE(+)'
      ')'
      'where DISPONIBILITA < UTILIZZO'
      'order by ANNO,CAPITOLO,ARTICOLO')
    Optimize = False
    Left = 16
    Top = 240
  end
  object selT192: TOracleDataSet
    SQL.Strings = (
      'SELECT POS,LUNG,DEF,TIPO,NOME FROM T192_PARPAGHEDATI '
      'WHERE CODICE = :CODICE '
      'ORDER BY POS')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 145
    Top = 64
  end
  object QDrop: TOracleQuery
    Optimize = False
    Left = 81
    Top = 240
  end
  object QIns: TOracleQuery
    Optimize = False
    Left = 133
    Top = 240
  end
  object QDel: TOracleQuery
    Optimize = False
    Left = 177
    Top = 240
  end
  object selT190: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T190_INTERFACCIAPAGHE ORDER BY CODICE,ORDINE')
    Optimize = False
    Left = 9
    Top = 64
  end
  object selT042: TOracleDataSet
    SQL.Strings = (
      'SELECT T1.DAL,T1.AL,T1.DAORE,T1.AORE,T2.VOCEPAGHE,T1.OPERAZIONE'
      'FROM T042_PERIODIASSENZA T1, T265_CAUASSENZE T2 WHERE'
      'T1.CAUSALE = T2.CODICE AND'
      'T2.VOCEPAGHE IS NOT NULL AND'
      'T2.TIPOCUMULO <> '#39'T'#39' AND'
      'T1.PROGRESSIVO = :PROGRESSIVO AND'
      'T1.DATA_AGG >= :DATA1'
      'ORDER BY DATA_AGG')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C0000000000000000000000}
    Left = 145
    Top = 12
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  DATA,'
      
        '  OREMINUTI(INDTURNOORE) + OREMINUTI(INDTURNOORE_VAR) INDTURNOOR' +
        'E, '
      '  NVL(INDTURNONUM,0) + NVL(INDTURNONUM_VAR,0) INDTURNONUM, '
      '  NVL(FESTIVINTERA,0) + NVL(FESTIVINTERA_VAR,0) FESTIVINTERA, '
      
        '  NVL(FESTIVRIDOTTA,0) + NVL(FESTIVRIDOTTA_VAR,0) FESTIVRIDOTTA,' +
        ' '
      
        '  OREASSENZE, DEBITOORARIO, ADDEBITOPAGHE, TURNI1, TURNI2, TURNI' +
        '3, TURNI4, '
      
        '  OREMINUTI(ORECOMP_LIQUIDATE) + OREMINUTI(BANCAORE_LIQ_VAR) ORE' +
        'COMP_LIQUIDATE, '
      '  ORE_INAIL, RIPOSI_NONFRUITI'
      'FROM T070_SCHEDARIEPIL'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000080000004400410054004100010000000000160000004900
      4E0044005400550052004E004F004F0052004500010000000000160000004900
      4E0044005400550052004E004F004E0055004D00010000000000180000004600
      4500530054004900560049004E0054004500520041000100000000001A000000
      4600450053005400490056005200490044004F00540054004100010000000000
      140000004F005200450041005300530045004E005A0045000100000000001800
      0000440045004200490054004F004F0052004100520049004F00010000000000
      1A00000041004400440045004200490054004F00500041004700480045000100
      000000000C0000005400550052004E00490031000100000000000C0000005400
      550052004E00490032000100000000000C0000005400550052004E0049003300
      0100000000000C0000005400550052004E004900340001000000000022000000
      4F005200450043004F004D0050005F004C004900510055004900440041005400
      4500010000000000120000004F00520045005F0049004E00410049004C000100
      00000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 201
    Top = 12
    object selT070INDTURNONUM: TFloatField
      FieldName = 'INDTURNONUM'
      Origin = 'T070_SCHEDARIEPIL.INDTURNONUM'
    end
    object selT070INDTURNOORE: TFloatField
      FieldName = 'INDTURNOORE'
    end
    object selT070FESTIVINTERA: TFloatField
      FieldName = 'FESTIVINTERA'
      Origin = 'T070_SCHEDARIEPIL.FESTIVINTERA'
    end
    object selT070FESTIVRIDOTTA: TFloatField
      FieldName = 'FESTIVRIDOTTA'
      Origin = 'T070_SCHEDARIEPIL.FESTIVRIDOTTA'
    end
    object selT070OREASSENZE: TStringField
      FieldName = 'OREASSENZE'
      Origin = 'T070_SCHEDARIEPIL.OREASSENZE'
      Size = 6
    end
    object selT070DEBITOORARIO: TStringField
      FieldName = 'DEBITOORARIO'
      Origin = 'T070_SCHEDARIEPIL.DEBITOORARIO'
      Size = 6
    end
    object selT070DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T070_SCHEDARIEPIL.DATA'
    end
    object selT070ADDEBITOPAGHE: TStringField
      FieldName = 'ADDEBITOPAGHE'
      Origin = 'T070_SCHEDARIEPIL.ADDEBITOPAGHE'
      Size = 7
    end
    object selT070TURNI1: TFloatField
      FieldName = 'TURNI1'
    end
    object selT070TURNI2: TFloatField
      FieldName = 'TURNI2'
    end
    object selT070TURNI3: TFloatField
      FieldName = 'TURNI3'
    end
    object selT070TURNI4: TFloatField
      FieldName = 'TURNI4'
    end
    object selT070ORE_INAIL: TStringField
      FieldName = 'ORE_INAIL'
      Size = 6
    end
    object selT070RIPOSI_NONFRUITI: TIntegerField
      FieldName = 'RIPOSI_NONFRUITI'
    end
    object selT070ORECOMP_LIQUIDATE: TFloatField
      FieldName = 'ORECOMP_LIQUIDATE'
    end
  end
  object QOreLavFasce: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  T071.DATA, T071.MAGGIORAZIONE,'
      '  T071.ORELAVORATE, T071.LIQUIDNELMESE,'
      '  T071.ORE1ASSEST,T071.ORE2ASSEST,'
      '  T071.OREINDTURNO,'
      '  T210.PORE_LAV,T210.PSTR_NEL_MESE,T210.PIND_TUR FROM '
      'T071_SCHEDAFASCE T071,'
      'T210_MAGGIORAZIONI T210 WHERE'
      'T071.PROGRESSIVO = :PROGRESSIVO AND'
      'T071.DATA  BETWEEN :DATA1 AND :DATA2 AND'
      'T210.CODICE = T071.CODFASCIA'
      'ORDER BY '
      'T071.DATA,T071.MAGGIORAZIONE,T071.CODFASCIA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000800000044004100540041000100000000001A0000004D00
      41004700470049004F00520041005A0049004F004E0045000100000000001600
      00004F00520045004C00410056004F0052004100540045000100000000001A00
      00004C00490051005500490044004E0045004C004D0045005300450001000000
      0000140000004F00520045003100410053005300450053005400010000000000
      140000004F005200450032004100530053004500530054000100000000001600
      00004F005200450049004E0044005400550052004E004F000100000000001000
      000050004F00520045005F004C00410056000100000000001A00000050005300
      540052005F004E0045004C005F004D0045005300450001000000000010000000
      500049004E0044005F00540055005200010000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 241
    Top = 244
    object QOreLavFasceORELAVORATE: TStringField
      FieldName = 'ORELAVORATE'
      Origin = 'T071_SCHEDAFASCE.ORELAVORATE'
      Size = 6
    end
    object QOreLavFascePORE_LAV: TStringField
      FieldName = 'PORE_LAV'
      Origin = 'T210_MAGGIORAZIONI.PORE_LAV'
      Size = 6
    end
    object QOreLavFasceORE1ASSEST: TStringField
      FieldName = 'ORE1ASSEST'
      Origin = 'T071_SCHEDAFASCE.ORE1ASSEST'
      Size = 7
    end
    object QOreLavFasceORE2ASSEST: TStringField
      FieldName = 'ORE2ASSEST'
      Origin = 'T071_SCHEDAFASCE.ORE2ASSEST'
      Size = 7
    end
    object QOreLavFasceDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T071_SCHEDAFASCE.DATA'
    end
    object QOreLavFasceMAGGIORAZIONE: TFloatField
      FieldName = 'MAGGIORAZIONE'
      Origin = 'T071_SCHEDAFASCE.MAGGIORAZIONE'
    end
    object QOreLavFasceLIQUIDNELMESE: TStringField
      FieldName = 'LIQUIDNELMESE'
      Origin = 'T071_SCHEDAFASCE.LIQUIDNELMESE'
      Size = 6
    end
    object QOreLavFascePSTR_NEL_MESE: TStringField
      FieldName = 'PSTR_NEL_MESE'
      Origin = 'T210_MAGGIORAZIONI.PSTR_NEL_MESE'
      Size = 6
    end
    object QOreLavFasceOREINDTURNO: TStringField
      FieldName = 'OREINDTURNO'
      Size = 6
    end
    object QOreLavFascePIND_TUR: TStringField
      FieldName = 'PIND_TUR'
      Size = 6
    end
  end
  object QAssestCausali1: TOracleDataSet
    SQL.Strings = (
      'SELECT T070.DATA,T070.CAUSALE1MINASS,'
      'T305.VOCEPAGHE1, T305.VOCEPAGHE2,'
      'T305.VOCEPAGHE3, T305.VOCEPAGHE4'
      'FROM '
      'T070_SCHEDARIEPIL T070,'
      'T305_CAUGIUSTIF T305'
      'WHERE'
      'T070.PROGRESSIVO = :PROGRESSIVO AND'
      'T070.DATA BETWEEN :DATA1 AND :DATA2 AND'
      'T305.CODICE = T070.CAUSALE1MINASS')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 329
    Top = 244
    object QAssestCausali1CAUSALE1MINASS: TStringField
      FieldName = 'CAUSALE1MINASS'
      Origin = 'T070_SCHEDARIEPIL.CAUSALE1MINASS'
      Size = 5
    end
    object QAssestCausali1VOCEPAGHE1: TStringField
      FieldName = 'VOCEPAGHE1'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE1'
      Size = 6
    end
    object QAssestCausali1VOCEPAGHE2: TStringField
      FieldName = 'VOCEPAGHE2'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE2'
      Size = 6
    end
    object QAssestCausali1VOCEPAGHE3: TStringField
      FieldName = 'VOCEPAGHE3'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE3'
      Size = 6
    end
    object QAssestCausali1VOCEPAGHE4: TStringField
      FieldName = 'VOCEPAGHE4'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE4'
      Size = 6
    end
    object QAssestCausali1DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T070_SCHEDARIEPIL.DATA'
    end
  end
  object QAssestCausali2: TOracleDataSet
    SQL.Strings = (
      'SELECT T070.DATA,T070.CAUSALE2MINASS,'
      'T305.VOCEPAGHE1, T305.VOCEPAGHE2,'
      'T305.VOCEPAGHE3, T305.VOCEPAGHE4'
      'FROM '
      'T070_SCHEDARIEPIL T070,'
      'T305_CAUGIUSTIF T305'
      'WHERE'
      'T070.PROGRESSIVO = :PROGRESSIVO AND'
      'T070.DATA BETWEEN :DATA1 AND :DATA2 AND'
      'T305.CODICE = T070.CAUSALE2MINASS')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 417
    Top = 244
    object QAssestCausali2CAUSALE2MINASS: TStringField
      FieldName = 'CAUSALE2MINASS'
      Origin = 'T070_SCHEDARIEPIL.CAUSALE2MINASS'
      Size = 5
    end
    object QAssestCausali2VOCEPAGHE1: TStringField
      FieldName = 'VOCEPAGHE1'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE1'
      Size = 6
    end
    object QAssestCausali2VOCEPAGHE2: TStringField
      FieldName = 'VOCEPAGHE2'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE2'
      Size = 6
    end
    object QAssestCausali2VOCEPAGHE3: TStringField
      FieldName = 'VOCEPAGHE3'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE3'
      Size = 6
    end
    object QAssestCausali2VOCEPAGHE4: TStringField
      FieldName = 'VOCEPAGHE4'
      Origin = 'T305_CAUGIUSTIF.VOCEPAGHE4'
      Size = 6
    end
    object QAssestCausali2DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T070_SCHEDARIEPIL.DATA'
    end
  end
  object selT134: TOracleDataSet
    SQL.Strings = (
      
        'SELECT ANNO, DATA, OREMINUTI(ORE_LIQUIDATE) LIQORE_ANNIPREC FROM' +
        ' T134_ORELIQUIDATEANNIPREC '
      '  WHERE PROGRESSIVO = :Progressivo '
      '  AND DATA BETWEEN :Data1 AND :Data2'
      '  AND OREPERSE = '#39'N'#39
      '  ')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    Left = 297
    Top = 12
  end
  object selT074: TOracleDataSet
    SQL.Strings = (
      'SELECT T074.DATA,T074.CAUSALE, '
      
        '       OREMINUTI(T074.OREPRESENZA) OREPRESENZA,OREMINUTI(T074.LI' +
        'QUIDATO) LIQUIDATO,'
      '       VOCEPAGHE1, VOCEPAGHE2, VOCEPAGHE3, VOCEPAGHE4,'
      
        '       VOCEPAGHELIQ1, VOCEPAGHELIQ2, VOCEPAGHELIQ3, VOCEPAGHELIQ' +
        '4,ABBATTE_BUDGET'
      'FROM '
      'T074_CAUSPRESFASCE T074,'
      'T275_CAUPRESENZE T275'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2 AND'
      'T275.CODICE = T074.CAUSALE'
      'ORDER BY '
      'CAUSALE,MAGGIORAZIONE,CODFASCIA'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 509
    Top = 244
    object selT074CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Origin = 'T074_CAUSPRESFASCE.CAUSALE'
      Size = 5
    end
    object selT074OREPRESENZA: TFloatField
      FieldName = 'OREPRESENZA'
    end
    object selT074LIQUIDATO: TFloatField
      FieldName = 'LIQUIDATO'
    end
    object selT074VOCEPAGHE1: TStringField
      FieldName = 'VOCEPAGHE1'
      Origin = 'T275_CAUPRESENZE.VOCEPAGHE1'
      Size = 6
    end
    object selT074VOCEPAGHE2: TStringField
      FieldName = 'VOCEPAGHE2'
      Origin = 'T275_CAUPRESENZE.VOCEPAGHE2'
      Size = 6
    end
    object selT074VOCEPAGHE3: TStringField
      FieldName = 'VOCEPAGHE3'
      Origin = 'T275_CAUPRESENZE.VOCEPAGHE3'
      Size = 6
    end
    object selT074VOCEPAGHE4: TStringField
      FieldName = 'VOCEPAGHE4'
      Origin = 'T275_CAUPRESENZE.VOCEPAGHE4'
      Size = 6
    end
    object selT074VOCEPAGHELIQ1: TStringField
      FieldName = 'VOCEPAGHELIQ1'
      Size = 6
    end
    object selT074VOCEPAGHELIQ2: TStringField
      FieldName = 'VOCEPAGHELIQ2'
      Size = 6
    end
    object selT074VOCEPAGHELIQ3: TStringField
      FieldName = 'VOCEPAGHELIQ3'
      Size = 6
    end
    object selT074VOCEPAGHELIQ4: TStringField
      FieldName = 'VOCEPAGHELIQ4'
      Size = 6
    end
    object selT074DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT074ABBATTE_BUDGET: TStringField
      FieldName = 'ABBATTE_BUDGET'
      Size = 1
    end
  end
  object QIndPresenza: TOracleDataSet
    SQL.Strings = (
      'SELECT T162.VOCEPAGHE,T072.DATA, T072.INDPRES'
      'FROM '
      'T072_SCHEDAINDPRES T072, T162_INDENNITA T162 '
      'WHERE'
      'T072.PROGRESSIVO = :PROGRESSIVO AND'
      'T072.DATA BETWEEN :DATA1 AND :DATA2 AND'
      'T162.CODICE = T072.CODINDPRES AND'
      'T162.VOCEPAGHE IS NOT NULL AND'
      'T072.INDPRES IS NOT NULL')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 21
    Top = 300
    object QIndPresenzaINDPRES: TStringField
      FieldName = 'INDPRES'
      Origin = 'T072_SCHEDAINDPRES.INDPRES'
      Size = 4
    end
    object QIndPresenzaDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T072_SCHEDAINDPRES.DATA'
    end
    object QIndPresenzaVOCEPAGHE: TStringField
      FieldName = 'VOCEPAGHE'
      Origin = 'T162_INDENNITA.VOCEPAGHE'
      Size = 6
    end
  end
  object QNumPasti: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  TO_DATE(LPAD(T410.ANNO,4,'#39'0'#39') || LPAD(T410.MESE,2,'#39'0'#39'),'#39'YYYYMM' +
        #39') DATA,'
      '  T410.PASTI, T410.PASTI2, T410.CAUSALE,'
      '  T305.VOCEPAGHE1, T305.VOCEPAGHE2,'
      
        '  T360.VOCEPAGHE1 VOCEPAGHE_NOCAUS1, T360.VOCEPAGHE2 VOCEPAGHE_N' +
        'OCAUS2, '
      '  T360.CAUSALE CAUSALE_ANOM'
      
        'FROM T410_PASTI T410,T305_CAUGIUSTIF T305, T430_STORICO T430, T3' +
        '60_TERMENSA T360 WHERE'
      'T410.PROGRESSIVO = :PROGRESSIVO AND'
      'T410.PASTI IS NOT NULL AND'
      
        'TO_DATE(LPAD(T410.ANNO,4,'#39'0'#39') || LPAD(T410.MESE,2,'#39'0'#39'),'#39'YYYYMM'#39')' +
        ' BETWEEN :DATA1 AND :DATA2 AND'
      'T410.CAUSALE = T305.CODICE(+) AND'
      'T410.PROGRESSIVO = T430.PROGRESSIVO AND'
      
        'LAST_DAY(TO_DATE(LPAD(T410.ANNO,4,'#39'0'#39') || LPAD(T410.MESE,2,'#39'0'#39'),' +
        #39'YYYYMM'#39')) BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND'
      ':C18_ACCESSIMENSA = T360.CODICE(+)'
      'ORDER BY DATA DESC,CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000220000003A004300310038005F0041004300430045005300
      530049004D0045004E0053004100010000000000000000000000}
    Left = 89
    Top = 300
  end
  object QBuoniMensa: TOracleDataSet
    SQL.Strings = (
      
        'SELECT TO_DATE(LPAD(ANNO,4,'#39'0'#39') || LPAD(MESE,2,'#39'0'#39'),'#39'YYYYMM'#39') DA' +
        'TA,'
      
        '       NVL(BUONIPASTO,0) + NVL(VARBUONIPASTO,0) BP,NVL(TICKET,0)' +
        ' + NVL(VARTICKET,0) TK'
      'FROM T680_BUONIMENSILI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      
        'TO_DATE(LPAD(ANNO,4,'#39'0'#39') || LPAD(MESE,2,'#39'0'#39'),'#39'YYYYMM'#39') BETWEEN :' +
        'DATA1 AND :DATA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 153
    Top = 300
  end
  object selT690: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  LAST_DAY(DATA) DATA, '
      '  SUM(NVL(BUONIPASTO,0) + NVL(BUONI_AUTO,0)) BUONIPASTO,'
      '  SUM(NVL(TICKET,0) + NVL(TICKET_AUTO,0)) TICKET'
      'FROM T690_ACQUISTOBUONI'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      'DATA BETWEEN :DATA1 AND :DATA2'
      'GROUP BY LAST_DAY(DATA)')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 594
    Top = 124
  end
  object selT762: TOracleDataSet
    SQL.Strings = (
      
        'select to_date(lpad(anno,4,'#39'0'#39') || lpad(mese,2,'#39'0'#39'),'#39'yyyymm'#39') da' +
        'ta,'
      '       t762.codtipoquota,'
      
        '       decode(t766.risparmio_bilancio,'#39'S'#39','#39'99'#39','#39'N'#39','#39'100'#39',tipoimp' +
        'orto) tipoimporto,'
      '       (nvl(importo,0) + nvl(variazioni,0)) importo,'
      '       giorni_ore'
      ' from t762_incentivimaturati t762, t766_incentivitipoabbat t766'
      'where progressivo = :progressivo '
      
        '  and to_date(lpad(anno,4,'#39'0'#39') || lpad(mese,2,'#39'0'#39'),'#39'yyyymm'#39') bet' +
        'ween :data1 and :data2 '
      
        '  and decode(t766.risparmio_bilancio,'#39'S'#39','#39'99'#39','#39'N'#39','#39'100'#39',tipoimpo' +
        'rto) in (:tipoimporto)'
      '  and t762.tipoimporto = t766.codice (+)'
      'order by 1,2'
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000180000003A005400490050004F0049004D0050004F005200
      54004F00010000000000000000000000}
    Left = 646
    Top = 124
  end
  object selT076: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,VOCEPAGHE,ORE'
      'FROM T076_CAUSPRESPAGHE'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2'
      'AND VOCEPAGHE IS NOT NULL AND '
      'OREMINUTI(ORE) > 0'
      'ORDER BY DATA'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 249
    Top = 12
  end
  object QDatiReper: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  TO_DATE(LPAD(ANNO,4,'#39'0'#39') || LPAD(MESE,2,'#39'0'#39'),'#39'YYYYMM'#39') DATA,'
      
        '  VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGIORATE,VP_GETTONE_CHIA' +
        'MATA,VP_TURNI_OLTREMAX,'
      
        '  TURNIINTERI,TURNIORE,OREMAGG,ORENONMAGG,GETTONE_CHIAMATA,TURNI' +
        '_OLTREMAX'
      'FROM T340_TURNIREPERIB'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      
        'TO_DATE(LPAD(ANNO,4,'#39'0'#39') || LPAD(MESE,2,'#39'0'#39'),'#39'YYYYMM'#39') BETWEEN :' +
        'DATA1 AND :DATA2'
      'ORDER BY ANNO,MESE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000080000004400410054004100010000000000100000005600
      50005F005400550052004E004F000100000000000C000000560050005F004F00
      520045000100000000001A000000560050005F004D0041004700470049004F00
      520041005400450001000000000020000000560050005F004E004F004E004D00
      41004700470049004F0052004100540045000100000000001600000054005500
      52004E00490049004E0054004500520049000100000000001000000054005500
      52004E0049004F00520045000100000000000E0000004F00520045004D004100
      47004700010000000000140000004F00520045004E004F004E004D0041004700
      4700010000000000}
    Left = 241
    Top = 300
    object QDatiReperTURNIINTERI: TFloatField
      FieldName = 'TURNIINTERI'
      Origin = 'T340_TURNIREPERIB.TURNIINTERI'
    end
    object QDatiReperTURNIORE: TStringField
      FieldName = 'TURNIORE'
      Origin = 'T340_TURNIREPERIB.TURNIORE'
      Size = 7
    end
    object QDatiReperOREMAGG: TStringField
      FieldName = 'OREMAGG'
      Origin = 'T340_TURNIREPERIB.OREMAGG'
      Size = 7
    end
    object QDatiReperORENONMAGG: TStringField
      FieldName = 'ORENONMAGG'
      Origin = 'T340_TURNIREPERIB.ORENONMAGG'
      Size = 7
    end
    object QDatiReperDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object QDatiReperGETTONE_CHIAMATA: TIntegerField
      FieldName = 'GETTONE_CHIAMATA'
    end
    object QDatiReperTUNRNI_OLTREMAX: TIntegerField
      FieldName = 'TURNI_OLTREMAX'
    end
    object QDatiReperVP_TURNO: TStringField
      FieldName = 'VP_TURNO'
      Required = True
      Size = 6
    end
    object QDatiReperVP_ORE: TStringField
      FieldName = 'VP_ORE'
      Required = True
      Size = 6
    end
    object QDatiReperVP_MAGGIORATE: TStringField
      FieldName = 'VP_MAGGIORATE'
      Required = True
      Size = 6
    end
    object QDatiReperVP_NONMAGGIORATE: TStringField
      FieldName = 'VP_NONMAGGIORATE'
      Required = True
      Size = 6
    end
    object QDatiReperVP_GETTONE_CHIAMATA: TStringField
      FieldName = 'VP_GETTONE_CHIAMATA'
      Size = 6
    end
    object QDatiReperVP_TURNI_OLTREMAX: TStringField
      FieldName = 'VP_TURNI_OLTREMAX'
      Size = 6
    end
  end
  object selM040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M040.MESESCARICO DATA,M040.MESECOMPETENZA,M040.DATADA,M04' +
        '0.ORADA,M040.IMPORTOINDINTERA,'
      
        '       M040.IMPORTOINDRIDOTTAH,M040.IMPORTOINDRIDOTTAG,M040.IMPO' +
        'RTOINDRIDOTTAHG,'
      '       M010.CODVOCEPAGHEINTERA,'
      '       M010.CODVOCEPAGHESUPHH,'
      
        '       M010.CODVOCEPAGHESUPGG,M010.CODVOCEPAGHESUPHHGG,M010.DATA' +
        'RIF_VOCEPAGHE,M040.COD_TARIFFA,'
      '       M010.IND_DA_TAB_TARIFFE'
      'FROM M040_MISSIONI M040,M010_PARAMETRICONTEGGIO M010'
      'WHERE M040.PROGRESSIVO = :PROGRESSIVO AND '
      '      M040.MESESCARICO BETWEEN :DATA1 AND :DATA2 AND'
      '      M010.TIPO_MISSIONE = M040.TIPOREGISTRAZIONE AND '
      '      M010.CODICE = (SELECT :C8_MISSIONE '
      '                     FROM T430_STORICO '
      '                     WHERE PROGRESSIVO = M040.PROGRESSIVO AND '
      
        '                           M040.DATAA BETWEEN DATADECORRENZA AND' +
        ' DATAFINE) AND'
      '      M010.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                         FROM M010_PARAMETRICONTEGGIO '
      
        '                         WHERE TIPO_MISSIONE = M010.TIPO_MISSION' +
        'E AND '
      
        '                               CODICE = M010.CODICE AND DECORREN' +
        'ZA <= M040.DATAA) AND '
      '      M040.STATO <> '#39'S'#39' AND'
      '      M010.IND_DA_TAB_TARIFFE = '#39'N'#39
      'UNION ALL'
      
        'SELECT M040.MESESCARICO DATA,M040.MESECOMPETENZA,M040.DATADA,M04' +
        '0.ORADA,M040.IMPORTOINDINTERA,'
      
        '       M040.IMPORTOINDRIDOTTAH,M040.IMPORTOINDRIDOTTAG,M040.IMPO' +
        'RTOINDRIDOTTAHG,'
      
        '       DECODE(M010.IND_DA_TAB_TARIFFE,'#39'S'#39',M065.VOCEPAGHE_ESENTE,' +
        'M010.CODVOCEPAGHEINTERA) CODVOCEPAGHEINTERA,'
      
        '       DECODE(M010.IND_DA_TAB_TARIFFE,'#39'S'#39',M065.VOCEPAGHE_ASSOG,M' +
        '010.CODVOCEPAGHESUPHH) CODVOCEPAGHESUPHH,'
      
        '       M010.CODVOCEPAGHESUPGG,M010.CODVOCEPAGHESUPHHGG,M010.DATA' +
        'RIF_VOCEPAGHE,M040.COD_TARIFFA,'
      '       M010.IND_DA_TAB_TARIFFE'
      
        'FROM M040_MISSIONI M040,M010_PARAMETRICONTEGGIO M010, M065_TARIF' +
        'FE_INDENNITA M065'
      'WHERE M040.PROGRESSIVO = :PROGRESSIVO AND '
      '      M040.MESESCARICO BETWEEN :DATA1 AND :DATA2 AND'
      '      M010.TIPO_MISSIONE = M040.TIPOREGISTRAZIONE AND '
      '      M010.CODICE = (SELECT :C8_MISSIONE '
      '                     FROM T430_STORICO '
      '                     WHERE PROGRESSIVO = M040.PROGRESSIVO AND '
      
        '                           M040.DATAA BETWEEN DATADECORRENZA AND' +
        ' DATAFINE) AND'
      '      M010.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                         FROM M010_PARAMETRICONTEGGIO '
      
        '                         WHERE TIPO_MISSIONE = M010.TIPO_MISSION' +
        'E AND '
      
        '                               CODICE = M010.CODICE AND DECORREN' +
        'ZA <= M040.DATAA) AND '
      '      M040.STATO <> '#39'S'#39' AND'
      '      M010.CODICE = M065.CODICE AND '
      '      M040.COD_TARIFFA = M065.COD_TARIFFA AND'
      
        '      M040.DATAA BETWEEN M065.DECORRENZA AND M065.DECORRENZA_FIN' +
        'E AND'
      '      M010.IND_DA_TAB_TARIFFE = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000180000003A00430038005F004D0049005300530049004F00
      4E004500010000000A0000005155414C49464943410000000000}
    Left = 465
    Top = 10
  end
  object selM050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M050.MESESCARICO DATA,M050.IMPORTORIMBORSOSPESE,M050.IMPO' +
        'RTOINDENNITASUPPLEMENTARE,'
      
        '       M020.CODICEVOCEPAGHE,M020.SCARICOPAGHE,M020.CODICEVOCEPAG' +
        'HEINDENNITASUPPL,M020.SCARICOPAGHEINDENNITASUPPL,'
      
        '       M040.MESESCARICO,M040.MESECOMPETENZA,M040.DATADA,M040.ORA' +
        'DA,M010.DATARIF_VOCEPAGHE'
      
        'FROM M050_RIMBORSI M050, M020_TIPIRIMBORSI M020, M040_MISSIONI M' +
        '040, M010_PARAMETRICONTEGGIO M010'
      'WHERE M050.CODICERIMBORSOSPESE = M020.CODICE'
      '      AND M010.TIPO_MISSIONE = M040.TIPOREGISTRAZIONE'
      '      AND M010.CODICE = (SELECT :C8_MISSIONE '
      '                         FROM T430_STORICO '
      '                         WHERE PROGRESSIVO = M040.PROGRESSIVO '
      
        '                               AND M040.DATAA BETWEEN DATADECORR' +
        'ENZA AND DATAFINE)'
      '      AND M010.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                             FROM M010_PARAMETRICONTEGGIO '
      
        '                             WHERE TIPO_MISSIONE = M010.TIPO_MIS' +
        'SIONE '
      
        '                                   AND CODICE = M010.CODICE AND ' +
        'DECORRENZA <= M040.DATAA)'
      '      AND M050.PROGRESSIVO = :PROGRESSIVO'
      '      AND M050.MESESCARICO BETWEEN :DATA1 AND :DATA2'
      '      AND M050.PROGRESSIVO=M040.PROGRESSIVO'
      '      AND M050.MESESCARICO=M040.MESESCARICO'
      '      AND M050.MESECOMPETENZA=M040.MESECOMPETENZA'
      '      AND M050.DATADA=M040.DATADA'
      '      AND M050.ORADA=M040.ORADA'
      '      AND M040.STATO<>'#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000180000003A00430038005F004D0049005300530049004F00
      4E004500010000000000000000000000}
    Left = 517
    Top = 10
  end
  object selM052: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M052.MESESCARICO DATA,M052.IMPORTOINDENNITA,M052.KMPERCOR' +
        'SI,M021.CODVOCEPAGHE,'
      
        '       M040.MESESCARICO,M040.MESECOMPETENZA,M040.DATADA,M040.ORA' +
        'DA,M010.DATARIF_VOCEPAGHE'
      
        'FROM M052_INDENNITAKM M052, M021_TIPIINDENNITAKM M021, M040_MISS' +
        'IONI M040, M010_PARAMETRICONTEGGIO M010 '
      'WHERE M052.PROGRESSIVO = M040.PROGRESSIVO '
      '      AND M010.TIPO_MISSIONE = M040.TIPOREGISTRAZIONE'
      '      AND M010.CODICE = (SELECT :C8_MISSIONE '
      '                         FROM T430_STORICO '
      '                         WHERE PROGRESSIVO = M040.PROGRESSIVO '
      
        '                               AND M040.DATAA BETWEEN DATADECORR' +
        'ENZA AND DATAFINE)      '
      '      AND M010.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                             FROM M010_PARAMETRICONTEGGIO '
      
        '                             WHERE TIPO_MISSIONE = M010.TIPO_MIS' +
        'SIONE '
      
        '                                   AND CODICE = M010.CODICE AND ' +
        'DECORRENZA <= M040.DATAA)      '
      '      AND M052.MESESCARICO = M040.MESESCARICO'
      '      AND M052.MESECOMPETENZA = M040.MESECOMPETENZA'
      '      AND M052.DATADA = M040.DATADA'
      '      AND M052.ORADA = M040.ORADA'
      '      AND M052.CODICEINDENNITAKM = M021.CODICE'
      '      AND (M052.IMPORTOINDENNITA > 0 OR M052.KMPERCORSI <> 0)'
      '      AND M021.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                        FROM M021_TIPIINDENNITAKM '
      '                        WHERE CODICE = M021.CODICE '
      '                              AND DECORRENZA <= M040.DATAA) '
      '      AND M052.PROGRESSIVO = :PROGRESSIVO '
      '      AND M052.MESESCARICO BETWEEN :DATA1 AND :DATA2 '
      '      AND M021.CODVOCEPAGHE IS NOT NULL'
      '      AND M040.STATO<>'#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000180000003A00430038005F004D0049005300530049004F00
      4E004500010000000000000000000000}
    Left = 568
    Top = 10
  end
  object selT040CumuloT: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT '
      '  T265.CODICE, VOCEPAGHE'
      'FROM '
      '  T040_GIUSTIFICATIVI T040,'
      '  T265_CAUASSENZE T265'
      'WHERE '
      '  T265.TIPOCUMULO = '#39'T'#39' AND '
      '  T265.DURATACUMULO >= 1 AND'
      '  T265.VOCEPAGHE IS NOT NULL AND '
      '  T040.PROGRESSIVO = :PROGRESSIVO AND'
      
        '  T040.DATA BETWEEN ADD_MONTHS(:DATA1,-DURATACUMULO + 1) AND :DA' +
        'TA2 AND'
      '  instr('#39','#39'||T265.ASSTOLL||'#39','#39','#39','#39'||T040.CAUSALE||'#39','#39') > 0')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000400000004000000000000000C0000003A00440041005400
      410031000C0000000700000078670801010101000000000C0000003A00440041
      005400410032000C000000070000007867081F01010100000000}
    Left = 32
    Top = 12
  end
  object selM060: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T430.CONTRATTO,M060.DATA_MISSIONE,M060.IMPORTO, M060.DATA' +
        '_IMPOSTAZIONE_STATO, M060.STATO,'
      
        #9'TO_NUMBER(TO_CHAR(ADD_MONTHS(M060.DATA_MISSIONE, M010.MAXMESIRI' +
        'MB), '#39'YYYY'#39')) AS ANNO_SCADENZA,'
      
        #9'TO_NUMBER(TO_CHAR(ADD_MONTHS(M060.DATA_MISSIONE, M010.MAXMESIRI' +
        'MB), '#39'MM'#39')) AS MESE_SCADENZA,'
      '        M010.DATARIF_VOCEPAGHE,'#9'M060.ROWID'
      
        'FROM M060_ANTICIPI M060, T430_STORICO T430, M010_PARAMETRICONTEG' +
        'GIO M010'
      'WHERE M060.PROGRESSIVO = :PROGRESSIVO '
      '  AND M060.PROGRESSIVO = T430.PROGRESSIVO '
      '  AND M010.MAXMESIRIMB >= 0 '
      
        '  AND M060.DATA_MISSIONE BETWEEN T430.DATADECORRENZA AND T430.DA' +
        'TAFINE '
      '  AND M060.STATO IN ('#39'S'#39','#39'R'#39') '
      '  AND M010.TIPO_MISSIONE = (SELECT MAX(TIPO_MISSIONE) '
      
        '                              FROM M010_PARAMETRICONTEGGIO M010A' +
        ' '
      '                             WHERE M010A.CODICE = M010.CODICE'
      '      '#9#9#9'       AND M010A.DECORRENZA = M010.DECORRENZA)'
      '  AND M010.CODICE = T430.:C8_MISSIONE '
      '  AND M010.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                           FROM M010_PARAMETRICONTEGGIO '
      
        '                          WHERE CODICE = M010.CODICE AND DECORRE' +
        'NZA <= M060.DATA_MISSIONE)'
      
        '  AND ADD_MONTHS(M060.DATA_MISSIONE, M010.MAXMESIRIMB) BETWEEN :' +
        'DATADA AND :DATAA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      00000000000000000000180000003A00430038005F004D004900530053004900
      4F004E004500010000000000000000000000}
    Left = 620
    Top = 9
  end
  object selT193: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  VOCE_PAGHE,'
      '  VOCE_PAGHE_CEDOLINO,'
      
        '  NVL(VOCE_PAGHE_NEGATIVA,VOCE_PAGHE_CEDOLINO) VOCE_PAGHE_NEGATI' +
        'VA, '
      '  NVL(DAL,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39')) DAL, '
      '  NVL(AL,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) AL,'
      '  FORMULA,'
      '  ARROTONDAMENTO,'
      '  SPOSTA_VALIMP'
      'FROM T193_VOCIPAGHE_PARAMETRI T193'
      'WHERE '
      'COD_INTERFACCIA = :COD_INTERFACCIA AND '
      
        'DECORRENZA = (SELECT MAX(DECORRENZA) FROM T193_VOCIPAGHE_PARAMET' +
        'RI WHERE COD_INTERFACCIA = T193.COD_INTERFACCIA AND VOCE_PAGHE =' +
        ' T193.VOCE_PAGHE AND DECORRENZA <= :DECORRENZA)')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A0043004F0044005F0049004E00540045005200
      46004100430043004900410005000000020000002A0000000000160000003A00
      4400450043004F005200520045004E005A0041000C0000000700000078690C1F
      01010100000000}
    Left = 269
    Top = 64
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * '
      '  from t765_tipoquote T765'
      ' where decorrenza = (select max(decorrenza) from t765_tipoquote'
      '                      where codice = t765.codice'
      '                        and decorrenza <= :DATA2)'
      
        '   and codice in (select distinct codtipoquota from t762_incenti' +
        'vimaturati'
      '                   where progressivo = :PROGRESSIVO'
      
        '                     and to_date(lpad(anno,4,'#39'0'#39') || lpad(mese,2' +
        ','#39'0'#39'),'#39'yyyymm'#39') between :data1 and :data2 )')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 696
    Top = 124
  end
  object Del195PA: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T195_VOCIVARIABILI'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATARIF = :DATARIF AND'
      'VOCEPAGHE = :VOCEPAGHE AND'
      'DAL = :DAL AND'
      'OPERAZIONE = :OPERAZIONE'
      '')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C0000000000000000000000140000003A0056004F00430045005000
      4100470048004500050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000160000003A004F0050004500520041005A004900
      4F004E004500050000000000000000000000}
    Left = 627
    Top = 64
  end
  object Ins195: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T195_VOCIVARIABILI'
      
        '  (PROGRESSIVO,DATARIF,VOCEPAGHE,VALORE,IMPORTO,UM,DAL,AL,OPERAZ' +
        'IONE,COD_INTERNO,DATA_CASSA)'
      'VALUES'
      
        '  (:PROGRESSIVO,:DATARIF,:VOCEPAGHE,:VALORE,:IMPORTO,:UM,:DAL,:A' +
        'L,:OPERAZIONE,:COD_INTERNO,:DATA_CASSA)')
    Optimize = False
    Variables.Data = {
      040000000B000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C0000000000000000000000140000003A0056004F00430045005000
      41004700480045000500000000000000000000000E0000003A00560041004C00
      4F0052004500040000000000000000000000060000003A0055004D0005000000
      0000000000000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000160000003A004F005000
      4500520041005A0049004F004E00450005000000000000000000000018000000
      3A0043004F0044005F0049004E005400450052004E004F000500000000000000
      00000000160000003A0044004100540041005F00430041005300530041000C00
      00000000000000000000100000003A0049004D0050004F00520054004F000400
      00000000000000000000}
    Left = 759
    Top = 64
  end
  object selT195: TOracleDataSet
    SQL.Strings = (
      'SELECT DATARIF,DAL,VOCEPAGHE,VALORE,IMPORTO,UM,COD_INTERNO'
      'FROM T195_VOCIVARIABILI T195'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      'DATARIF BETWEEN :DATA1 AND :DATA2 AND'
      'DATA_CASSA < :DATA_CASSA'
      
        'AND (NOT EXISTS (SELECT '#39'X'#39' FROM T265_CAUASSENZE WHERE VOCEPAGHE' +
        ' = T195.VOCEPAGHE) OR'
      
        '     NOT EXISTS (SELECT '#39'X'#39' FROM T190_INTERFACCIAPAGHE WHERE COD' +
        'ICE IN (:INTERFACCE) AND CODINTERNO = '#39'180'#39' AND FLAG = '#39'S'#39'))'
      '')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000160000003A0044004100540041005F004300410053005300
      41000C0000000000000000000000160000003A0049004E005400450052004600
      4100430043004500010000000000000000000000}
    Left = 395
    Top = 64
  end
  object selValore: TOracleQuery
    SQL.Strings = (
      '-- select <FORMULA> from dual'
      
        '-- in cui <FORMULA> contiene una funzione della variabile :VALOR' +
        'E'
      '')
    ReadBuffer = 1
    Optimize = False
    Left = 17
    Top = 368
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,VOCEPAGHE,SCARICOPAGHE_UM_PROP,UMISURA,FRUIZ_ARR,F' +
        'RUIZ_MIN,FRUIZCOMPETENZE_ARR,NVL(RETRIBUZIONE1,100) RETRIBUZIONE' +
        '1,'
      
        #9'UM_SCARICOPAGHE,VOCEPAGHE2,VOCEPAGHE3,VOCEPAGHE4,VOCEPAGHE5,VOC' +
        'EPAGHE6'
      '  FROM T265_CAUASSENZE '
      ' WHERE VOCEPAGHE IS NOT NULL '
      '   AND TIPOCUMULO <> '#39'T'#39)
    Optimize = False
    Left = 469
    Top = 125
  end
  object selT200: TOracleDataSet
    SQL.Strings = (
      '--SELECT DESCRIZIONE FROM T200_CONTRATTI WHERE CODICE = :CODICE'
      'select ore_lavfasce_conass'
      'from   t200_contratti t200,'
      '       t430_storico   t430'
      'where  t430.progressivo = :progressivo'
      'and    :datarif between t430.datadecorrenza and t430.datafine'
      'and    t200.codice = t430.contratto')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C0000000000000000000000}
    Left = 377
    Top = 127
  end
  object selT210: TOracleDataSet
    SQL.Strings = (
      
        'select codice,pore_lav,pstr_nel_mese,pind_tur,pore_comp from t21' +
        '0_maggiorazioni')
    Optimize = False
    Left = 425
    Top = 127
  end
  object UpdM040: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      'UPDATE M040_MISSIONI M040'
      'SET M040.STATO='#39'L'#39
      'WHERE M040.PROGRESSIVO=:PROGRESSIVO'
      '      AND M040.MESESCARICO=:MESESCARICO'
      '      AND M040.MESECOMPETENZA=:MESECOMPETENZA'
      '      AND M040.DATADA=:DATADA'
      '      AND M040.ORADA=:ORADA;'
      ''
      'UPDATE M060_ANTICIPI M060'
      '   SET M060.STATO='#39'L'#39
      ' WHERE M060.ID_MISSIONE=(SELECT M040.ID_MISSIONE'
      '                           FROM M040_MISSIONI M040'
      '                          WHERE M040.PROGRESSIVO=:PROGRESSIVO'
      
        '                            AND M040.MESECOMPETENZA=:MESECOMPETE' +
        'NZA'
      '                            AND M040.DATADA=:DATADA'
      '                            AND M040.ORADA=:ORADA)'
      '   AND M060.STATO='#39'P'#39';'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000}
    Left = 90
    Top = 368
  end
  object selT195DataCassa: TOracleDataSet
    SQL.Strings = (
      'SELECT DATARIF,VOCEPAGHE,ROWID FROM T195_VOCIVARIABILI'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATARIF BETWEEN :DATARIF1 AND :DATARIF2 AND'
      'DATA_CASSA = :DATA_CASSA AND'
      'COD_INTERNO IN (:COD_INTERNO)'
      '')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005200
      4900460031000C0000000000000000000000120000003A004400410054004100
      52004900460032000C0000000000000000000000160000003A00440041005400
      41005F00430041005300530041000C0000000000000000000000180000003A00
      43004F0044005F0049004E005400450052004E004F0001000000000000000000
      0000}
    Left = 467
    Top = 64
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select DATADECORRENZA, '
      '       DATAFINE, '
      '       NVL(INIZIO,to_date('#39'31/12/3999'#39','#39'dd/mm/yyyy'#39')) INIZIO, '
      
        '--       LEAST(NVL(FINE,to_date('#39'31/12/3999'#39','#39'dd/mm/yyyy'#39')),LAST' +
        '_DAY(:data)) FINE'
      '       NVL(FINE,to_date('#39'31/12/3999'#39','#39'dd/mm/yyyy'#39')) FINE'
      'from t430_storico'
      'where progressivo = :progressivo'
      'and :data between datadecorrenza and datafine'
      'order by datadecorrenza')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 536
    Top = 125
  end
  object OperSQL: TOracleDataSet
    Optimize = False
    Left = 157
    Top = 368
  end
  object delT195Cassa: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T195_VOCIVARIABILI'
      'WHERE '
      'DATA_CASSA = (SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI)')
    Optimize = False
    Left = 695
    Top = 64
  end
  object delT196: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM T196_FILTROSCARICOPAGHE T196'
      ' WHERE UPPER(T196.CODICE) = UPPER(:CODICE)'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 280
    Top = 128
  end
  object RipristinoVociPaghe: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  RIPRISTINOVOCIPAGHE;'
      'END;')
    Optimize = False
    Left = 241
    Top = 368
  end
  object QSelect: TOracleDataSet
    Optimize = False
    Left = 329
    Top = 368
  end
  object selUSR_GetRidEveMal: TOracleDataSet
    SQL.Strings = (
      
        'select COUNT(*) ESISTEPROC FROM user_procedures WHERE object_nam' +
        'e='#39'USR_GETRIDEVEMAL'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 48
    Top = 180
  end
  object selUSR_GetRidEveMal1: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '  VOCEPAGHE,VOCEPAGHE2,VOCEPAGHE3,VOCEPAGHE4,VOCEPAGHE5,VOCEPAGH' +
        'E6,'
      '  least(substr(usr_getridevemal(PROGRESSIVO,DATA,'#39'GIORNALIERO'#39'),'
      
        '       instr(usr_getridevemal(PROGRESSIVO,DATA,'#39'GIORNALIERO'#39'),'#39'N' +
        'UMEVRID='#39')+length('#39'NUMEVRID='#39'),'
      
        '       (instr(usr_getridevemal(PROGRESSIVO,DATA,'#39'GIORNALIERO'#39'),'#39 +
        ';'#39',instr(usr_getridevemal(PROGRESSIVO,DATA,'#39'GIORNALIERO'#39'),'#39'NUMEV' +
        'RID='#39')+length('#39'NUMEVRID='#39'))) -'
      
        '       (instr(usr_getridevemal(PROGRESSIVO,DATA,'#39'GIORNALIERO'#39'),'#39 +
        'NUMEVRID='#39')+length('#39'NUMEVRID='#39'))),5) NUMEVENTO_RID'
      'from ('
      
        '  select T040.PROGRESSIVO,T040.DATA,T265.VOCEPAGHE,T265.VOCEPAGH' +
        'E2,T265.VOCEPAGHE3,T265.VOCEPAGHE4,T265.VOCEPAGHE5,T265.VOCEPAGH' +
        'E6'
      '  from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      '  where T040.PROGRESSIVO = :PROGRESSIVO'
      '  and T040.DATA = :DATA '
      '  and T040.CAUSALE = T265.CODICE'
      '  and T265.VOCEPAGHE2 is not null'
      ')  ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 168
    Top = 179
  end
  object T193F_VOCE_SCARICABILE: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :result:=T193F_VOCE_SCARICABILE(:p_progressivo, :p_data_comp, ' +
        ':p_data_cassa, :p_interfaccia, :p_voce, :p_voce_cedolino);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A0052004500530055004C005400050000000000
      0000000000001C0000003A0050005F00500052004F0047005200450053005300
      490056004F00030000000000000000000000180000003A0050005F0044004100
      540041005F0043004F004D0050000C00000000000000000000001A0000003A00
      50005F0044004100540041005F00430041005300530041000C00000000000000
      000000001C0000003A0050005F0049004E005400450052004600410043004300
      490041000500000000000000000000000E0000003A0050005F0056004F004300
      4500050000000000000000000000200000003A0050005F0056004F0043004500
      5F004300450044004F004C0049004E004F00050000000000000000000000}
    Left = 296
    Top = 179
  end
  object T195F_VOCE_GETVALORE: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :result:=T195F_VOCE_GETVALORE(:p_progressivo, :p_data_comp, :p' +
        '_interfaccia, :p_voce_orig, :p_voce, :p_valore);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A0052004500530055004C005400040000000000
      0000000000001C0000003A0050005F00500052004F0047005200450053005300
      490056004F00030000000000000000000000180000003A0050005F0044004100
      540041005F0043004F004D0050000C00000000000000000000001C0000003A00
      50005F0049004E00540045005200460041004300430049004100050000000000
      0000000000000E0000003A0050005F0056004F00430045000500000000000000
      00000000120000003A0050005F00560041004C004F0052004500040000000000
      000000000000180000003A0050005F0056004F00430045005F004F0052004900
      4700050000000000000000000000}
    Left = 439
    Top = 179
  end
  object selT193Extra: TOracleDataSet
    SQL.Strings = (
      'select * from USR_VT193_VOCIEXTRA T193'
      'where COD_INTERFACCIA = :COD_INTERFACCIA '
      'and :DECORRENZA between DECORRENZA and DECORRENZA_FINE'
      'order by VOCE_PAGHE')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A0043004F0044005F0049004E00540045005200
      46004100430043004900410005000000020000002A0000000000160000003A00
      4400450043004F005200520045004E005A0041000C0000000700000078690C1F
      01010100000000}
    Left = 333
    Top = 63
  end
  object QIndFunzione: TOracleDataSet
    SQL.Strings = (
      'select TRUNC(DATA,'#39'MM'#39') DATA, SUM(IMP_TOT_GG) INDFUNZ'
      'from ('
      '  select CSI006.DATA, '
      
        '         CSI007.ORE, OREMINUTI(CSI007.ORE)/60 NUM_ORE, NVL(CSI00' +
        '5.IMPORTO,0) IMPORTO, ROUND(OREMINUTI(CSI007.ORE)/60 * NVL(CSI00' +
        '5.IMPORTO,0),2) IMP_ORE,'
      
        '         CSI007.DISAGIO_SERALE, OREMINUTI(CSI007.DISAGIO_SERALE)' +
        '/60 NUM_SER, NVL(CSI005.MAGG_DISAGIO_SERALE,0) MAG_SER, ROUND(OR' +
        'EMINUTI(CSI007.DISAGIO_SERALE)/60 * NVL(CSI005.MAGG_DISAGIO_SERA' +
        'LE,0),2) IMP_SER,'
      
        '         ROUND(OREMINUTI(CSI007.ORE)/60 * NVL(CSI005.IMPORTO,0),' +
        '2) + ROUND(OREMINUTI(CSI007.DISAGIO_SERALE)/60 * NVL(CSI005.MAGG' +
        '_DISAGIO_SERALE,0),2) IMP_TOT_GG'
      
        '    from CSI006_CART_INDFUNZIONE CSI006, CSI007_CART_INDFUNZIONE' +
        '_DETT CSI007,'
      
        '         CSI004_INDFUNZIONE CSI004, CSI005_INDFUNZIONE_FASCE CSI' +
        '005,'
      '         T430_STORICO T430'
      '   where CSI006.ID = CSI007.ID'
      '     and CSI006.PROGRESSIVO = :PROGRESSIVO '
      '     and CSI006.DATA BETWEEN :DATA1 AND :DATA2 '
      '     and CSI007.TIPO_RECORD = '#39'M'#39
      '     and T430.PROGRESSIVO = CSI006.PROGRESSIVO'
      
        '     and CSI006.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFI' +
        'NE'
      '     and CSI004.ID = CSI005.ID'
      
        '     and CSI006.DATA BETWEEN CSI004.DECORRENZA AND CSI004.DECORR' +
        'ENZA_FINE'
      '     and CSI004.CODICE = CSI007.INDFUNZIONE'
      '     and CSI004.CONTRATTO = T430.CONTRATTO'
      '     and CSI005.FASCIA = CSI007.FASCIA'
      ')'
      ' group by TRUNC(DATA,'#39'MM'#39')'
      ' order by 1')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = selT070FilterRecord
    Left = 328
    Top = 304
  end
end
