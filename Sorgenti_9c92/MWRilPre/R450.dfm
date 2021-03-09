object R450DtM1: TR450DtM1
  OldCreateOrder = True
  OnCreate = R450DtM1Create
  OnDestroy = R450DtM1Destroy
  Height = 356
  Width = 464
  object selT070: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T070_SCHEDARIEPIL'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2'
      'ORDER BY DATA')
    ReadBuffer = 60
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 30
    Top = 4
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T071_SCHEDAFASCE'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND '
      'DATA BETWEEN :DATA1 AND :DATA2'
      'ORDER BY DATA,MAGGIORAZIONE,CODFASCIA')
    ReadBuffer = 240
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 74
    Top = 4
  end
  object selT130: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T130_RESIDANNOPREC WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  ANNO  BETWEEN :ANNO1 AND :ANNO2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0041004E004E004F003100
      0300000000000000000000000C0000003A0041004E004E004F00320003000000
      0000000000000000}
    Left = 214
    Top = 4
  end
  object FasceCount: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T210.Codice,T210.Maggiorazione'
      'FROM T210_Maggiorazioni T210, T201_Maggiorazioni T201'
      'WHERE '
      
        'T210.Codice IN (T201.Maggior1,T201.Maggior2,T201.Maggior3,T201.M' +
        'aggior4) AND'
      'T201.Codice = '
      '  (SELECT CONTRATTO FROM T430_STORICO WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    :DATA BETWEEN DATADECORRENZA AND DATAFINE)'
      'ORDER BY T210.Codice,T210.Maggiorazione')
    ReadBuffer = 6
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 314
    Top = 4
  end
  object selT075: TOracleDataSet
    SQL.Strings = (
      'select data,sum(oreminuti(orestraord)) mm'
      'from t075_stresterno'
      'where '
      '  progressivo=:progressivo and'
      '  data between :data1 and :data2'
      'group by data')
    ReadBuffer = 180
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 118
    Top = 4
  end
  object QIndPresTot: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,SUM(TO_NUMBER(INDPRES)) IND FROM T072_SCHEDAINDPRES'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND '
      'DATA BETWEEN :DATA1 AND :DATA2'
      'GROUP BY DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 386
    Top = 240
  end
  object QTurniReperib: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  ANNO,MESE,'
      '  VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGIORATE,'
      '  TURNIINTERI TURNI,'
      '  TURNIORE SPEZZONI,'
      '  OREMAGG MAGGIORATE,'
      '  ORENONMAGG NONMAGGIORATE'
      'FROM T340_TURNIREPERIB'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      'TO_DATE(ANNO || '#39'/'#39' || MESE,'#39'yyyy/mm'#39') BETWEEN :DATA1 AND :DATA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 386
    Top = 8
  end
  object QMaturazioneMensa: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  ANNO,MESE,'
      '  BUONIPASTO BUONIMATURATI,'
      '  VARBUONIPASTO BUONIVARIATI,'
      '  TICKET TICKETMATURATI,'
      '  VARTICKET TICKETVARIATI,'
      '  NOTE'
      'FROM T680_BUONIMENSILI'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      'TO_DATE(ANNO || '#39'/'#39' || MESE,'#39'yyyy/mm'#39') BETWEEN :DATA1 AND :DATA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Cursor = crSQLWait
    Left = 386
    Top = 56
  end
  object QAcquistoMensa: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  LAST_DAY(DATA) DATA, MAX(DATA_MAGAZZINO) DATA_MAGAZZINO, T690F' +
        '_ID_BLOCCHETTI(last_day(DATA),max(PROGRESSIVO)) ID_BLOCCHETTI,'
      '  SUM(NVL(BUONIPASTO,0) + NVL(BUONI_AUTO,0)) BUONI,'
      '  SUM(NVL(TICKET,0) + NVL(TICKET_AUTO,0)) TICKET,'
      '  SUM(NVL(BUONI_RECUPERATI,0)) BUONI_RECUPERATI,'
      '  SUM(NVL(TICKET_RECUPERATI,0)) TICKET_RECUPERATI'
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
    Left = 386
    Top = 100
  end
  object QNumPasti: TOracleDataSet
    SQL.Strings = (
      'SELECT'
      '  ANNO,MESE, '
      '  SUM(NVL(PASTI,0)) NUMPASTI,SUM(NVL(PASTI2,0)) NUMPASTI2'
      'FROM T410_PASTI'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      'TO_DATE(ANNO || '#39'/'#39' || MESE,'#39'yyyy/mm'#39') BETWEEN :DATA1 AND :DATA2'
      'GROUP BY ANNO,MESE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 386
    Top = 192
  end
  object selT025: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T025_CONTMENSILI ORDER BY CODICE'
      '')
    ReadBuffer = 12
    Optimize = False
    Left = 34
    Top = 152
  end
  object selT800: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DATADECORR,TIPOLIMITE,NOMECAMPO1,NOMECAMPO2,TRONCA_ECCEDE' +
        'NZE FROM T800_CAMPILIMITI'
      'ORDER BY DATADECORR DESC')
    ReadBuffer = 10
    Optimize = False
    Left = 128
    Top = 152
  end
  object selT810: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T810_LIQUIDABILE ORDER BY CAMPO1,CAMPO2,ANNO,MESE')
    ReadBuffer = 120
    Optimize = False
    Left = 176
    Top = 152
  end
  object selT811: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T811_RESIDUABILE ORDER BY CAMPO1,CAMPO2,ANNO,MESE')
    ReadBuffer = 120
    Optimize = False
    Left = 224
    Top = 152
  end
  object selT074: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,CAUSALE,MAGGIORAZIONE,CODFASCIA,'
      
        '       OREMINUTI(OREPRESENZA) OREPRESENZA,OREMINUTI(LIQUIDATO) L' +
        'IQUIDATO'
      'FROM T074_CAUSPRESFASCE'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2'
      'ORDER BY CAUSALE,DATA,MAGGIORAZIONE,CODFASCIA')
    ReadBuffer = 960
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 76
    Top = 52
  end
  object selT073: TOracleDataSet
    SQL.Strings = (
      'SELECT CAUSALE,DATA,OREMINUTI(COMPENSABILE) COMPENSABILE '
      'FROM T073_SCHEDACAUSPRES T073'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND '
      'DATA BETWEEN :DATA1 AND :DATA2'
      'ORDER BY CAUSALE,DATA')
    ReadBuffer = 240
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 32
    Top = 52
  end
  object selT074liq: TOracleDataSet
    SQL.Strings = (
      'SELECT CAUSALE,SUM(OREMINUTI(LIQUIDATO)) LIQUIDATO'
      'FROM T074_CAUSPRESFASCE '
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  OREMINUTI(LIQUIDATO) > 0'
      'GROUP BY CAUSALE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Filtered = True
    Left = 124
    Top = 52
  end
  object sum071: TOracleQuery
    SQL.Strings = (
      'SELECT SUM(OREMINUTI(LIQUIDNELMESE)) LIQUIDNELMESE'
      'FROM T071_SCHEDAFASCE '
      
        'WHERE PROGRESSIVO = :PROGRESSIVO AND DATA BETWEEN :DATA1 AND :DA' +
        'TA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 280
    Top = 100
  end
  object selT026: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T026_SALDIABBATTUTI '
      'ORDER BY CODICE,ANNO_RIF,MESE_RIF'
      '')
    Optimize = False
    Left = 76
    Top = 152
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT (ADD_MONTHS(LAST_DAY(INIZIO),-1) + 1) INIZIO,NVL' +
        '(LAST_DAY(FINE),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) FINE'
      'FROM T430_STORICO T430, T030_ANAGRAFICO T030'
      'WHERE '
      'T030.PROGRESSIVO = :PROGRESSIVO AND'
      'T030.PROGRESSIVO = T430.PROGRESSIVO AND'
      'T030.RAPPORTI_UNITI = '#39'N'#39' AND'
      
        ':DATA BETWEEN ADD_MONTHS(LAST_DAY(INIZIO),-1) + 1 AND NVL(LAST_D' +
        'AY(FINE),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      'UNION'
      
        'SELECT TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYY' +
        'YY'#39')'
      'FROM T030_ANAGRAFICO'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      '(RAPPORTI_UNITI = '#39'S'#39' OR RAPPORTI_UNITI IS NULL)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 32
    Top = 100
  end
  object sum070: TOracleQuery
    SQL.Strings = (
      
        'SELECT SUM(OREMINUTI(ORECOMP_LIQUIDATE) + OREMINUTI(BANCAORE_LIQ' +
        '_VAR)) COMPLIQUIDATO'
      'FROM T070_SCHEDARIEPIL'
      
        'WHERE PROGRESSIVO = :PROGRESSIVO AND DATA BETWEEN :DATA1 AND :DA' +
        'TA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 236
    Top = 100
  end
  object QResiduiMensa: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  ANNO,'
      '  BUONIPASTO,'
      '  TICKET'
      'FROM T692_RESIDUOBUONI'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND '
      'ANNO BETWEEN :ANNO1 AND :ANNO2')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0041004E004E004F003100
      0300000000000000000000000C0000003A0041004E004E004F00320003000000
      0000000000000000}
    Left = 386
    Top = 144
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,ORENORMALI,RESIDUABILE,RESIDUO_LIQUIDABILE,NO_LIMI' +
        'TE_MENSILE_LIQ,ABBATTE_BUDGET,INCLUSIONE_SALDI_CAUSALI,PERIODICI' +
        'TA_ABBATTIMENTO'
      'FROM T275_CAUPRESENZE'
      ''
      '')
    Optimize = False
    Left = 36
    Top = 200
  end
  object selT131: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T131_RESIDPRESENZE WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  ANNO BETWEEN :ANNO1 AND :ANNO2'
      'ORDER BY ANNO,CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0041004E004E004F003100
      0300000000000000000000000C0000003A0041004E004E004F00320003000000
      0000000000000000}
    Left = 262
    Top = 4
  end
  object selT134: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  OREMINUTI(ORE_LIQUIDATE) LIQORE_ANNIPREC, OREMINUTI(VARIAZIONE' +
        '_ORE) VARIAZIONE_SALDO, DATA, NOTE'
      
        '  /*SUM(OREMINUTI(ORE_LIQUIDATE)) LIQORE_ANNIPREC, SUM(OREMINUTI' +
        '(VARIAZIONE_ORE)) VARIAZIONE_SALDO, MAX(DATA) DATA, MAX(NOTE) NO' +
        'TE*/'
      '  FROM T134_ORELIQUIDATEANNIPREC '
      '  WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA >= :DATA'
      '  AND OREPERSE = '#39'N'#39
      'ORDER BY DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Filtered = True
    Left = 80
    Top = 200
  end
  object selT430InizioFine: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) INIZI' +
        'O,NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) FINE FROM T430_STORIC' +
        'O WHERE'
      'PROGRESSIVO = :Progressivo'
      'ORDER BY INIZIO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 96
    Top = 100
  end
  object scrStrAnnuo: TOracleQuery
    SQL.Strings = (
      'declare'
      '  liq varchar2(7);'
      '  res varchar2(7);'
      '  liq_teorico varchar2(7);'
      '  res_teorico varchar2(7);'
      'begin'
      '  begin'
      '    liq:=null;'
      '    res:=null; '
      '    liq_teorico:=null;'
      '    res_teorico:=null; '
      '    :maxresanno_teorico:=0;'
      '    :maxstranno_teorico:=0;'
      
        '    select liquidabile, residuabile, liquidabile_teorico, residu' +
        'abile_teorico'
      
        '    into liq, res, liq_teorico, res_teorico from t825_liquidinda' +
        'nnuo where'
      '    progressivo = :progressivo and anno = to_char(:data,'#39'yyyy'#39');'
      '    :maxresanno_teorico:=oreminuti(res_teorico);'
      '    :maxstranno_teorico:=oreminuti(liq_teorico);'
      '    if res is null or liq is null then'
      '      raise no_data_found;'
      '    end if;'
      '    :maxresanno:=oreminuti(res);'
      '    :maxstranno:=oreminuti(liq);'
      '  exception'
      '    when no_data_found then'
      '      begin'
      
        '        select oreminuti(maxstraord),oreminuti(maxresiduabile) i' +
        'nto :maxstranno,:maxresanno from t200_contratti where codice = '
      '        (select contratto from t430_storico where '
      '           progressivo = :progressivo and '
      '           last_day(:data) between datadecorrenza and datafine);'
      '        if liq is not null then'
      '          :maxstranno:=oreminuti(liq);'
      '        end if;'
      '        if res is not null then'
      '          :maxresanno:=oreminuti(res);'
      '        end if;'
      '      exception'
      '        when no_data_found then'
      '          if liq is null then '
      '            :maxstranno:=0; '
      '          end if;'
      '          if res is null then'
      '            :maxresanno:=0;'
      '          end if;'
      '      end;'
      '  end;'
      
        '  --Aggiunti i limiti mensili causalizzati, che non devono rient' +
        'rare nei limiti annuali'
      
        '  select nvl(sum(oreminuti(nvl(ore,'#39'0'#39'))),0) into :maxstrannocau' +
        's'
      '  from '
      '    t820_limitiind t820, t275_caupresenze t275'
      '  where '
      '    progressivo = :progressivo and'
      '    anno = to_char(:data,'#39'yyyy'#39') and'
      '    mese between 1 and to_char(:data,'#39'mm'#39') and'
      '    t820.causale = t275.codice and'
      '    t275.orenormali in ('#39'B'#39','#39'D'#39') and'
      '    t275.no_limite_mensile_liq = '#39'S'#39' and'
      '    t820.liquidabile = '#39'S'#39';'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F00030000000400000004000000000000000A0000003A00440041005400
      41000C0000000700000077B9011F01010100000000160000003A004D00410058
      0053005400520041004E004E004F000300000004000000000000000000000016
      0000003A004D004100580052004500530041004E004E004F0003000000040000
      0000000000000000001E0000003A004D004100580053005400520041004E004E
      004F00430041005500530003000000040000000000000000000000260000003A
      004D004100580052004500530041004E004E004F005F00540045004F00520049
      0043004F00030000000000000000000000260000003A004D0041005800530054
      00520041004E004E004F005F00540045004F005200490043004F000300000000
      00000000000000}
    Left = 163
    Top = 257
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT TO_DATE('#39'01'#39'||TO_CHAR(DATA,'#39'MMYYYY'#39'),'#39'DDMMYYYY'#39')' +
        ' DATA,CAUSALE'
      'FROM T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DAL AND :AL AND'
      'T040.CAUSALE = T265.CODICE AND'
      'T265.TIPOCUMULO = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 104
    Top = 256
  end
  object selT265_CumuloS: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is '
      '    select codice,asstoll||'#39','#39' asstoll, tiporecupero, influcont '
      '    from t265_cauassenze '
      
        '    where /*influcont in ('#39'A'#39','#39'C'#39','#39'G'#39','#39'H'#39','#39'I'#39') and*/ tipocumulo ' +
        '= '#39'S'#39' order by codice;'
      '  i integer;'
      '  n integer;'
      '  cau_pres varchar2(10);'
      'begin'
      '  :lista_ass:='#39#39';'
      '  :lista_pres:='#39#39';'
      '  for t1 in c1 loop'
      '    cau_pres:='#39#39';'
      '    for i in 1..length(t1.asstoll) loop'
      '      if substr(t1.asstoll,i,1) = '#39','#39' then'
      '        n:=0;'
      
        '        select count(*) into n from t275_caupresenze where codic' +
        'e = cau_pres and (orenormali = '#39'A'#39' or t1.tiporecupero <> '#39'0'#39' or ' +
        't1.influcont in ('#39'B'#39','#39'D'#39'));'
      '        if n > 0 then'
      '          :lista_ass:=:lista_ass||'#39','#39'||t1.codice;'
      '          :lista_pres:=:lista_pres||'#39','#39'||cau_pres;  '
      '        end if;'
      '        cau_pres:='#39#39';'
      '      else'
      '        cau_pres:=cau_pres||substr(t1.asstoll,i,1);'
      '      end if;'
      '    end loop;'
      '  end loop;'
      'end;'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004C0049005300540041005F00410053005300
      050000000D0000002C31352C31352C31352C35350000000000160000003A004C
      0049005300540041005F00500052004500530005000000170000002C54435354
      462C544353544E2C54435354522C3031320000000000}
    Left = 36
    Top = 256
  end
  object selT074lb: TOracleDataSet
    SQL.Strings = (
      'SELECT NVL(SUM(OREMINUTI(LIQUIDATO)),0) LIQUIDATO'
      '  FROM T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  WHERE '
      '  T074.CAUSALE = T275.CODICE AND'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      
        '  (ORENORMALI IN ('#39'B'#39','#39'D'#39') OR ORENORMALI = '#39'A'#39' AND ABBATTE_BUDGE' +
        'T = '#39'L'#39')')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Filtered = True
    Left = 180
    Top = 52
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      
        'select codice,assest_annuo,abbatte_ecc_giorn,bancaore_negativa,d' +
        'ata_min_assest from t305_caugiustif')
    ReadBuffer = 10
    Optimize = False
    Left = 136
    Top = 200
  end
  object selBuoniPastoTotali: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  wINIZIO DATE;'
      '  wFINE DATE;'
      '  BUONI_RES NUMBER(8);'
      '  TICKET_RES NUMBER(8);'
      'BEGIN'
      '  :BUONI_MAT:=0;'
      '  :TICKET_MAT:=0;'
      '  :BUONI_ACQ:=0;'
      '  :TICKET_ACQ:=0;'
      '  BUONI_RES:=0;'
      '  TICKET_RES:=0;'
      '  SELECT INIZIO,FINE INTO wINIZIO,wFINE FROM'
      '  ('
      
        '  SELECT MIN(INIZIO) INIZIO,MAX(NVL(FINE,TO_DATE(31123999,'#39'DDMMY' +
        'YYY'#39'))) FINE FROM '
      '  T030_ANAGRAFICO T030,T430_STORICO T430 WHERE'
      '  T030.PROGRESSIVO = :PROGRESSIVO AND '
      '  T030.RAPPORTI_UNITI = '#39'S'#39' AND'
      '  T430.PROGRESSIVO = T030.PROGRESSIVO'
      '  UNION'
      
        '  SELECT INIZIO,NVL(FINE,TO_DATE(31123999,'#39'DDMMYYYY'#39')) FINE FROM' +
        ' '
      '  T030_ANAGRAFICO T030,T430_STORICO T430 WHERE'
      '  T030.PROGRESSIVO = :PROGRESSIVO AND '
      '  T030.RAPPORTI_UNITI = '#39'N'#39' AND'
      '  T430.PROGRESSIVO = T030.PROGRESSIVO AND'
      
        '  :DATA2 BETWEEN INIZIO AND NVL(FINE,TO_DATE(31123999,'#39'DDMMYYYY'#39 +
        ')) '
      '  )'
      '  WHERE INIZIO IS NOT NULL;'
      ''
      '  SELECT NVL(SUM(NVL(TICKET,0) + NVL(TICKET_AUTO,0)),0),'
      '         NVL(SUM(NVL(BUONIPASTO,0) + NVL(BUONI_AUTO,0)),0)'
      '  INTO :TICKET_ACQ,:BUONI_ACQ'
      '  FROM T690_ACQUISTOBUONI T690'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  DATA BETWEEN TRUNC(wINIZIO,'#39'MM'#39') AND wFINE;'
      ''
      '  SELECT NVL(SUM(NVL(TICKET,0) + NVL(VARTICKET,0)),0),'
      '         NVL(SUM(NVL(BUONIPASTO,0) + NVL(VARBUONIPASTO,0)),0)'
      '  INTO :TICKET_MAT,:BUONI_MAT'
      '  FROM T680_BUONIMENSILI T680'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      
        '  TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||ANNO,'#39'DDMMYYYY'#39') BETWEEN :DATA' +
        '1 AND :DATA2 AND'
      
        '  TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||ANNO,'#39'DDMMYYYY'#39') BETWEEN TRUNC' +
        '(wINIZIO,'#39'MM'#39') AND wFINE;'
      '  BEGIN'
      
        '    SELECT NVL(BUONIPASTO,0),NVL(TICKET,0) INTO BUONI_RES, TICKE' +
        'T_RES FROM T692_RESIDUOBUONI'
      '    WHERE '
      
        '    PROGRESSIVO = :PROGRESSIVO AND ANNO = TO_CHAR(:DATA1,'#39'YYYY'#39')' +
        ' AND'
      '    ANNO > '
      '    (SELECT TO_CHAR(INIZIO,'#39'YYYY'#39') FROM'
      '     ('
      '      SELECT MIN(INIZIO) INIZIO FROM '
      '      T030_ANAGRAFICO T030,T430_STORICO T430 WHERE'
      '      T030.PROGRESSIVO = :PROGRESSIVO AND '
      '      T030.RAPPORTI_UNITI = '#39'S'#39' AND'
      '      T430.PROGRESSIVO = T030.PROGRESSIVO'
      '      UNION'
      '      SELECT INIZIO FROM '
      '      T030_ANAGRAFICO T030,T430_STORICO T430 WHERE'
      '      T030.PROGRESSIVO = :PROGRESSIVO AND '
      '      T030.RAPPORTI_UNITI = '#39'N'#39' AND'
      '      T430.PROGRESSIVO = T030.PROGRESSIVO AND'
      
        '      wINIZIO BETWEEN INIZIO AND NVL(FINE,TO_DATE(31123999,'#39'DDMM' +
        'YYYY'#39')) '
      '      )'
      '    WHERE INIZIO IS NOT NULL);'
      '  EXCEPTION'
      '    WHEN NO_DATA_FOUND THEN'
      '      NULL;'
      '  END;'
      '  :TICKET_ACQ:=:TICKET_ACQ + TICKET_RES;'
      '  :BUONI_ACQ:=:BUONI_ACQ + BUONI_RES;'
      'EXCEPTION'
      '  WHEN NO_DATA_FOUND THEN'
      '    :BUONI_ACQ:=0;'
      '    :TICKET_ACQ:=0;'
      '    :BUONI_MAT:=0;'
      '    :TICKET_MAT:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003200
      0C00000000000000000000000C0000003A00440041005400410031000C000000
      0000000000000000140000003A00420055004F004E0049005F004D0041005400
      03000000040000000000000000000000160000003A005400490043004B004500
      54005F004D004100540003000000040000000000000000000000140000003A00
      420055004F004E0049005F004100430051000300000004000000000000000000
      0000160000003A005400490043004B00450054005F0041004300510003000000
      040000000000000000000000}
    Left = 386
    Top = 284
  end
  object selT820: TOracleDataSet
    SQL.Strings = (
      'SELECT T820.* FROM T820_LIMITIIND T820'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      
        '  TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||LPAD(ANNO,4,'#39'0'#39'),'#39'DDMMYYYY'#39') B' +
        'ETWEEN :DATA1 AND:DATA2'
      'ORDER BY ANNO,MESE,DAL,AL,CAUSALE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 272
    Top = 152
  end
  object cdsStrAnnuo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 227
    Top = 257
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select t265.codice,t265.codraggr,t260.codinterno '
      'from t265_cauassenze t265,t260_raggrassenze t260'
      'where '
      '  t265.codraggr = t260.codice and'
      '  t265.codice = :codice')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 224
    Top = 200
  end
  object selT011: TOracleDataSet
    SQL.Strings = (
      'select '
      '  trunc(T011.DATA,'#39'mm'#39') DATA,'
      
        '  decode(T011.NUMGIORNI,0,0,trunc(oreminuti(T430.ORARIO)/T011.NU' +
        'MGIORNI)) VALENZA_GIORNALIERA'
      'from T430_STORICO T430, T011_CALENDARI T011'
      'where T430.PROGRESSIVO = :PROGRESSIVO'
      'and T011.CODICE = T430.CALENDARIO'
      'and T011.DATA = last_day(T011.DATA)'
      'and T011.DATA between last_day(:DATA1) and last_day(:DATA2)'
      'and T011.DATA between T430.DATADECORRENZA and T430.DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 40
    Top = 304
  end
  object selT077: TOracleDataSet
    SQL.Strings = (
      'select DATA,DATO,nvl(VALORE_MAN,VALORE_AUT) VALORE'
      'from T077_DATISCHEDA'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and DATA between :DATA1 and :DATA2'
      'order by DATA,DATO')
    ReadBuffer = 180
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 166
    Top = 4
  end
end
