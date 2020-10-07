object R410FAutoGiustificazioneDtM: TR410FAutoGiustificazioneDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 357
  Width = 550
  object selT100T040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT 1 TIPO,DATA FROM T100_TIMBRATURE T100,T275_CAUPRESENZE T2' +
        '75 WHERE'
      '  T100.PROGRESSIVO = :PROGRESSIVO AND'
      '  T100.DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  T100.CAUSALE IS NOT NULL AND'
      '  T100.CAUSALE = T275.CODICE AND'
      '  T275.LINK_ASSENZA IS NOT NULL AND'
      '  T275.TIPOCONTEGGIO IN ('#39'A'#39','#39'E'#39')  '
      'UNION'
      'SELECT 1,DATA FROM T040_GIUSTIFICATIVI WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  STAMPA = '#39'A'#39
      ''
      'union'
      ''
      'select 2,T080.DATA '
      'from T080_PIANIFORARI T080, T020_ORARI T020 '
      'where T080.PROGRESSIVO = :progressivo '
      'and   T080.DATA between :data1 and :data2'
      'and   T080.ORARIO = T020.CODICE'
      
        'and   T020.DECORRENZA = (select max(DECORRENZA) from T020_ORARI ' +
        'where CODICE = T020.CODICE and DECORRENZA <= T080.DATA)'
      'and   T020.RICALCOLO_DEBITO_GG = '#39'S'#39
      
        'and   (T020.RICALCOLO_CAUS_NEG is not null or T020.RICALCOLO_CAU' +
        'S_POS is not null) '
      'union'
      'select 2,V010.DATA '
      
        'from V010_CALENDARI V010, T430_STORICO T430, T220_PROFILIORARI T' +
        '220, T221_PROFILISETTIMANA T221, T020_ORARI T020'
      'where V010.PROGRESSIVO = :PROGRESSIVO'
      'and   V010.DATA between :data1 and :data2'
      'and   T430.PROGRESSIVO = :PROGRESSIVO'
      'and   V010.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and   V010.DATA between T430.INIZIO and nvl(T430.FINE,V010.DATA)'
      'and   T220.CODICE = T430.PORARIO'
      'and   V010.DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and   T221.CODICE = T220.CODICE'
      'and   T221.DECORRENZA = T220.DECORRENZA'
      
        'and   T020.CODICE = decode(to_char(V010.DATA - 1,'#39'd'#39'),1,T221.LUN' +
        'EDI,2,T221.MARTEDI,3,T221.MERCOLEDI,4,T221.GIOVEDI,5,T221.VENERD' +
        'I,6,T221.SABATO)'
      
        'and   T020.DECORRENZA = (select max(DECORRENZA) from T020_ORARI ' +
        'where CODICE = T020.CODICE and DECORRENZA <= V010.DATA)'
      'and   T020.RICALCOLO_DEBITO_GG = '#39'S'#39
      
        'and   (T020.RICALCOLO_CAUS_NEG is not null or T020.RICALCOLO_CAU' +
        'S_POS is not null)'
      
        'and   not exists (select '#39'x'#39' from T080_PIANIFORARI where PROGRES' +
        'SIVO = V010.PROGRESSIVO and DATA = V010.DATA and ORARIO is not n' +
        'ull)'
      'order by 1,2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 49
    Top = 12
  end
  object delT040CausScorrimento: TOracleQuery
    SQL.Strings = (
      'delete from T040_GIUSTIFICATIVI T040'
      'where PROGRESSIVO = :PROGRESSIVO '
      'and DATA between :DATA1 and :DATA2 '
      
        'and to_char(DATA - 1,'#39'd'#39') = 7 -- i giustificativi interessati ri' +
        'cadono solo nelle domeniche'
      'and TIPOGIUST = '#39'N'#39
      'and CAUSALE in ('
      
        '  select RICALCOLO_CAUS_NEG from T020_ORARI where RICALCOLO_CAUS' +
        '_NEG is not null'
      '  union'
      
        '  select RICALCOLO_CAUS_POS from T020_ORARI where RICALCOLO_CAUS' +
        '_POS is not null)'
      
        'and T020F_USO_RICALCOLO_DEBITO(T040.PROGRESSIVO,T040.DATA - 6, T' +
        '040.DATA - 1) = '#39'N'#39)
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 50
    Top = 156
  end
  object insT040: TOracleQuery
    SQL.Strings = (
      'declare'
      '  numcaus integer;'
      '  dn date;'
      '  --:STAMPA: A=autogiustificativi, B=decurtazione banca ore'
      'begin'
      '  if :STAMPA <> '#39'B'#39' then'
      '    --Lettura eventuale familiare'
      '    begin'
      '      select max(DATANAS) into dn'
      '      from SG101_FAMILIARI '
      '      where PROGRESSIVO = :PROGRESSIVO'
      '      and :DATA between DECORRENZA and DECORRENZA_FINE'
      
        '      and :CAUSALE in (select CODICE from T265_CAUASSENZE where ' +
        'CUMULO_FAMILIARI = '#39'S'#39' or FRUIZIONE_FAMILIARI = '#39'S'#39')'
      
        '      and (instr('#39','#39'||CAUSALI_ABILITATE||'#39','#39','#39','#39'||:CAUSALE||'#39','#39')' +
        ' > 0 or CAUSALI_ABILITATE = '#39'*'#39');'
      '    exception'
      
        '      --va in errore su oracle 9.0.1 se la query non restituisce' +
        ' nessuna riga'
      '      when others then'
      '        dn:=null;'
      '    end;'
      '  end if;'
      
        '  --Verifica se l'#39'autogiustificativo va a intersecarsi con altro' +
        ' giustificativo inserito manualmente'
      '  if :TIPOGIUST = '#39'D'#39' then'
      '    select count(*) into numcaus from T040_GIUSTIFICATIVI '
      '    where PROGRESSIVO = :PROGRESSIVO'
      '    and DATA = :DATA'
      '    and CAUSALE = :CAUSALE'
      '    and TIPOGIUST = :TIPOGIUST'
      '    and :DAORE < AORE '
      '    and :AORE > DAORE'
      '    and nvl(STAMPA,'#39'*'#39') <> :STAMPA;'
      '    if numcaus > 0 then '
      '      return;'
      '    end if;'
      '  end if;'
      ''
      '  insert into T040_GIUSTIFICATIVI '
      
        '    (PROGRESSIVO,DATA,CAUSALE,TIPOGIUST,PROGRCAUSALE,DAORE,AORE,' +
        'SCHEDA,STAMPA,DATANAS)'
      '  values'
      
        '    (:PROGRESSIVO,:DATA,:CAUSALE,:TIPOGIUST,T040F_NEWPROGRCAUSAL' +
        'E(:PROGRESSIVO,:DATA,:CAUSALE),:DAORE,:AORE,:SCHEDA,:STAMPA,dn);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000000C0000003A00440041004F00520045000C0000000000
      000000000000140000003A005400490050004F00470049005500530054000500
      000000000000000000000A0000003A0041004F00520045000C00000000000000
      000000000E0000003A0053004300480045004400410005000000000000000000
      00000E0000003A005300540041004D0050004100050000000000000000000000}
    Left = 277
    Top = 12
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,ASSTOLL FROM T265_CAUASSENZE WHERE TIPOCUMULO = '#39'U' +
        #39)
    ReadBuffer = 5
    Optimize = False
    Left = 269
    Top = 108
  end
  object scrFestiviInfraSett: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is '
      '    select v010.progressivo,v010.data'
      '    from v010_calendari v010, t430_storico t430'
      '    where '
      
        '      v010.progressivo = :progressivo and v010.data between :dad' +
        'ata and :adata and'
      
        '      v010.festivo = '#39'S'#39' and v010.lavorativo = '#39'S'#39' and to_char(v' +
        '010.data,'#39'd'#39') <> '#39'1'#39' and'
      '      v010.progressivo = t430.progressivo and '
      
        '      v010.data between t430.datadecorrenza and t430.datafine an' +
        'd'
      '      t430.tgestione = '#39'0'#39' and '
      '      t430.hteoriche = '#39'4'#39' and'
      '      not exists'
      '        (select '#39'x'#39' from t040_giustificativi t040 where'
      '         progressivo = v010.progressivo and '
      
        '         data = v010.data and tipogiust = '#39'I'#39' /*and causale not ' +
        'in (:causali)*/) and'
      '      exists'
      '        (select '#39'x'#39' from t430_storico t430 where'
      '         progressivo = v010.progressivo and '
      
        '         v010.data between inizio and nvl(fine,to_date('#39'31123999' +
        #39','#39'ddmmyyyy'#39')));'
      '  causale varchar2(5);'
      'begin'
      '  for t1 in c1 loop'
      '    insert into t040_giustificativi'
      '      (progressivo,data,causale,tipogiust,progrcausale)  '
      '    values'
      '      (t1.progressivo,t1.data,:codcaus,'#39'I'#39',0);'
      '  end loop;'
      '  commit;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000100000003A0043004F00440043004100550053000500
      00000000000000000000}
    Left = 435
    Top = 108
  end
  object selT265FruizMin: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, oreminuti(FRUIZ_MIN) FRUIZ_MIN, oreminuti(FRUIZ_A' +
        'RR) FRUIZ_ARR, FRUIZCOMPETENZE_ARR '
      'from T265_CAUASSENZE'
      'where oreminuti(FRUIZ_MIN) <> 0 or oreminuti(FRUIZ_ARR) <> 0')
    Optimize = False
    Left = 347
    Top = 108
  end
  object selDatanas: TOracleQuery
    SQL.Strings = (
      'select max(DATANAS) '
      'from   SG101_FAMILIARI '
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between DECORRENZA and DECORRENZA_FINE'
      
        'and    (instr('#39','#39'||CAUSALI_ABILITATE||'#39','#39','#39','#39'||:CAUSALE||'#39','#39') > ' +
        '0 or CAUSALI_ABILITATE = '#39'*'#39')'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 338
    Top = 60
  end
  object selT265Familiari: TOracleDataSet
    SQL.Strings = (
      'select CODICE '
      'from   T265_CAUASSENZE '
      'where  (CUMULO_FAMILIARI = '#39'S'#39' or'
      '        FRUIZIONE_FAMILIARI = '#39'S'#39')'
      'order by 1')
    ReadBuffer = 30
    Optimize = False
    Left = 268
    Top = 60
  end
  object cdsT040StampaA: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TIPOGIUST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DAORE'
        DataType = ftDateTime
      end
      item
        Name = 'AORE'
        DataType = ftDateTime
      end
      item
        Name = 'SCHEDA'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 205
    Top = 12
  end
  object selT040StampaA: TOracleDataSet
    SQL.Strings = (
      'SELECT T040.*,ROWID '
      'FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND DATA = :DATA '
      'AND STAMPA = '#39'A'#39
      'ORDER BY DAORE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 121
    Top = 12
  end
  object selT020CausScorrimento: TOracleDataSet
    SQL.Strings = (
      
        'select RICALCOLO_CAUS_NEG from T020_ORARI where RICALCOLO_CAUS_N' +
        'EG is not null'
      'union'
      
        'select RICALCOLO_CAUS_POS from T020_ORARI where RICALCOLO_CAUS_P' +
        'OS is not null')
    ReadBuffer = 5
    Optimize = False
    Left = 49
    Top = 108
  end
  object delT040StampaB: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND DATA between :DATA1 and :DATA2'
      'AND STAMPA = '#39'B'#39)
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 341
    Top = 11
  end
  object selT040HMASSENZA: TOracleDataSet
    SQL.Strings = (
      'select T040.CAUSALE,count(*) NUMERO'
      'from T040_GIUSTIFICATIVI T040, VT230_CAUASSENZE_PARSTO T230'
      'where T040.CAUSALE = T230.CODICE'
      'and T040.DATA between T230.DECORRENZA and T230.DECORRENZA_FINE'
      'and T230.CAUSALE_HMASSENZA is not null'
      'and T040.TIPOGIUST in ('#39'D'#39','#39'N'#39')'
      'and T040.PROGRESSIVO = :PROGRESSIVO'
      'and T040.DATA between :DATA1 and :DATA2'
      'group by T040.CAUSALE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 48
    Top = 216
  end
end
