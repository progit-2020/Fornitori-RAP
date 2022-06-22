inherited A044FAllineaStoriciMW: TA044FAllineaStoriciMW
  OldCreateOrder = True
  Height = 238
  Width = 382
  object selT430: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T430_STORICO '
      'WHERE PROGRESSIVO =:PROGRESSIVO'
      'ORDER BY DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 20
    Top = 12
  end
  object updT430: TOracleQuery
    SQL.Strings = (
      'UPDATE T430_STORICO '
      'SET DATAFINE = :DATAFINE'
      'WHERE PROGRESSIVO =:PROGRESSIVO '
      '  AND DATADECORRENZA = :DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004400410054004100460049004E0045000C00
      00000000000000000000180000003A00500052004F0047005200450053005300
      490056004F000300000000000000000000001E0000003A004400410054004100
      4400450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 20
    Top = 60
  end
  object updT430B: TOracleQuery
    SQL.Strings = (
      'UPDATE T430_STORICO '
      'SET DATADECORRENZA = :DATA'
      'WHERE '
      'PROGRESSIVO =:PROGRESSIVO AND'
      'DATADECORRENZA = :DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000001E0000003A0044004100540041004400450043004F00
      5200520045004E005A0041000C0000000000000000000000}
    Left = 71
    Top = 60
  end
  object scrT430: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  Allinea_Periodi_Storici(:Progressivo,1,:Errore,:AssLibera,'#39'S'#39')' +
        ';'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000140000003A004100530053004C0049004200
      450052004100050000000000000000000000}
    Left = 20
    Top = 117
  end
  object scrP430: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  Allinea_Periodi_Stipendi(:Progressivo,:Errore,:AssLibera,'#39'S'#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000140000003A004100530053004C0049004200
      450052004100050000000000000000000000}
    Left = 71
    Top = 117
  end
  object updJob: TOracleQuery
    SQL.Strings = (
      'declare'
      '  id_job  number;'
      'BEGIN'
      '  begin'
      '    select valore'
      '    into   id_job'
      '    from   t001_parametrifunzioni'
      '    where  progoperatore = -1'
      '    and    prog = '#39'A044'#39
      '    and    nome = '#39'ID_JOB'#39';'
      '  exception'
      '    when no_data_found then'
      '      id_job:=-1;'
      '  end;'
      '  if id_job <> -1 then'
      
        '    if to_date('#39'01-01-1900 '#39'||to_char(sysdate,'#39'hh24.mi'#39')||'#39'.00'#39',' +
        #39'dd-mm-yyyy hh24.mi.ss'#39') <= to_date('#39'01-01-1900 '#39'||:Next_date||'#39 +
        '.00'#39','#39'dd-mm-yyyy hh24.mi.ss'#39') then'
      
        '      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate,'#39'dd-' +
        'mm-yyyy'#39')||'#39' '#39'||:Next_date||'#39'.00'#39', '#39'dd-mm-yyyy hh24.mi.ss'#39'));'
      '    else'
      
        '      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate+1,'#39'd' +
        'd-mm-yyyy'#39')||'#39' '#39'||:Next_date||'#39'.00'#39', '#39'dd-mm-yyyy hh24.mi.ss'#39'));'
      '    end if;'
      '  end if;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E004500580054005F004400410054004500
      050000000000000000000000}
    Left = 119
    Top = 117
  end
  object scrJob: TOracleQuery
    SQL.Strings = (
      
        '-- Script per la creazione del job di allineamento dei dati anag' +
        'rafici'
      'declare'
      '  n_p430 number    :=0;'
      '  id_job number       ;'
      'begin'
      '  begin'
      '    select valore'
      '    into   id_job'
      '    from   t001_parametrifunzioni'
      '    where  progoperatore = -1'
      '    and    prog = '#39'A044'#39
      '    and    nome = '#39'ID_JOB'#39';'
      '  exception'
      '    when no_data_found then'
      '      id_job:=-1;'
      '  end;'
      '  if id_job <> -1 then'
      '    begin'
      '      sys.dbms_job.remove(id_job);'
      '    exception'
      '      when others then null;'
      '    end;'
      '    delete t001_parametrifunzioni'
      '    where prog = '#39'A044'#39
      '    and   nome = '#39'ID_JOB'#39
      '    and   progoperatore = -1;'
      '    id_job:=-1;'
      '  end if;'
      '  if id_job = -1 then'
      '    sys.dbms_job.submit(job => id_job,'
      '                        what => '#39'declare'
      'begin'
      '  allinea_per_job;'
      'exception'
      '  when others then'
      '    null;'
      'end;'#39','
      
        '                        next_date => to_date(to_char(sysdate+1,'#39 +
        'dd-mm-yyyy'#39')||'#39' 00.00.00'#39', '#39'dd-mm-yyyy hh24.mi.ss'#39'),'
      '                        interval => '#39'sysdate + 1'#39');'
      '    insert into t001_parametrifunzioni'
      '      (prog,'
      '       nome,'
      '       valore,'
      '       progoperatore,'
      '       utente)'
      '    values'
      '      ('#39'A044'#39','
      '       '#39'ID_JOB'#39','
      '       id_job,'
      '       -1,'
      '       '#39'JOB'#39');'
      '  end if;'
      '  commit;'
      'exception'
      '  when others then'
      '    rollback;'
      'end;')
    Optimize = False
    Left = 168
    Top = 117
  end
  object selUser_Job: TOracleDataSet
    SQL.Strings = (
      'select next_date, next_sec'
      'from user_jobs'
      'where job = :id_job')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00490044005F004A004F004200030000000000
      000000000000}
    Left = 116
    Top = 12
  end
  object selT001: TOracleDataSet
    SQL.Strings = (
      'select VALORE'
      'from   t001_parametrifunzioni'
      'where  progoperatore = -1'
      'and    prog = '#39'A044'#39
      'and    nome = '#39'ID_JOB'#39)
    Optimize = False
    Left = 68
    Top = 12
  end
  object updOra: TOracleQuery
    SQL.Strings = (
      'declare'
      '  ora_job varchar2(5);'
      'BEGIN'
      '  begin'
      '    select valore'
      '    into   ora_job'
      '    from   t001_parametrifunzioni'
      '    where  progoperatore = -1'
      '    and    prog = '#39'A044'#39
      '    and    nome = '#39'ORA_JOB'#39';'
      '    --'
      '    update t001_parametrifunzioni'
      '    set    valore = :Next_date'
      '    where  progoperatore = -1'
      '    and    prog = '#39'A044'#39
      '    and    nome = '#39'ORA_JOB'#39';'
      '  exception'
      '    when no_data_found then'
      '      insert into t001_parametrifunzioni'
      '        (prog,'
      '         nome,'
      '         valore,'
      '         progoperatore,'
      '         utente)'
      '      values'
      '        ('#39'A044'#39','
      '         '#39'ORA_JOB'#39','
      '         :Next_date,'
      '         -1,'
      '         '#39'JOB'#39');'
      '  end;'
      'END;'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E004500580054005F004400410054004500
      050000000000000000000000}
    Left = 216
    Top = 117
  end
  object scrJobCtrl: TOracleQuery
    SQL.Strings = (
      
        '-- Script per la creazione del job che ogni giorno imposta la da' +
        'ta di esecuzione del job di allineamento dei dati anagrafici'
      'declare'
      '  id_job number       ;'
      'begin'
      '  begin'
      '    select valore'
      '    into   id_job'
      '    from   t001_parametrifunzioni'
      '    where  progoperatore = -1'
      '    and    prog = '#39'A044'#39
      '    and    nome = '#39'ID_JOB_CTRL'#39';'
      '  exception'
      '    when no_data_found then'
      '      id_job:=-1;'
      '  end;'
      '  if id_job <> -1 then'
      '    begin'
      '      sys.dbms_job.remove(id_job);'
      '    exception'
      '      when others then null;'
      '    end;'
      '    delete t001_parametrifunzioni'
      '    where prog = '#39'A044'#39
      '    and   nome = '#39'ID_JOB_CTRL'#39
      '    and   progoperatore = -1;'
      '    id_job:=-1;'
      '  end if;'
      '  if id_job = -1 then'
      '      sys.dbms_job.submit(job => id_job,'
      '                          what => '#39'declare'
      'errore  varchar2(100);'
      'ora_job varchar2(5);'
      'id_job  number;'
      'begin'
      '  begin'
      '    select valore'
      '    into   id_job'
      '    from   t001_parametrifunzioni'
      '    where  progoperatore = -1'
      '    and    prog = '#39#39'A044'#39#39
      '    and    nome = '#39#39'ID_JOB'#39#39';'
      '  exception'
      '    when others then'
      '      id_job:=0;'
      '  end;'
      '  if id_job > 0 then'
      '    begin'
      '      select valore'
      '      into   ora_job'
      '      from   t001_parametrifunzioni'
      '      where  progoperatore = -1'
      '      and    prog = '#39#39'A044'#39#39
      '      and    nome = '#39#39'ORA_JOB'#39#39';'
      '    exception'
      '      when others then'
      '        ora_job:='#39#39'00.00'#39#39';'
      '    end;'
      
        '    if to_date('#39#39'01-01-1900 '#39#39'||to_char(sysdate,'#39#39'hh24.mi'#39#39')||'#39#39 +
        '.00'#39#39','#39#39'dd-mm-yyyy hh24.mi.ss'#39#39') <= to_date('#39#39'01-01-1900 '#39#39'||ora' +
        '_job||'#39#39'.00'#39#39','#39#39'dd-mm-yyyy hh24.mi.ss'#39#39') then'
      
        '      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate,'#39#39'dd' +
        '-mm-yyyy'#39#39')||'#39#39' '#39#39'||ora_job||'#39#39'.00'#39#39', '#39#39'dd-mm-yyyy hh24.mi.ss'#39#39')' +
        ');'
      '    else'
      
        '      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate+1,'#39#39 +
        'dd-mm-yyyy'#39#39')||'#39#39' '#39#39'||ora_job||'#39#39'.00'#39#39', '#39#39'dd-mm-yyyy hh24.mi.ss'#39 +
        #39'));'
      '    end if;'
      '  end if;'
      'end;'#39','
      
        '                          next_date => to_date(to_char(sysdate+1' +
        ','#39'dd-mm-yyyy'#39')||'#39' 00.00.00'#39', '#39'dd-mm-yyyy hh24.mi.ss'#39'),'
      '                          interval => '#39'TRUNC(sysdate) + 1'#39');'
      '    insert into t001_parametrifunzioni'
      '      (prog,'
      '       nome,'
      '       valore,'
      '       progoperatore,'
      '       utente)'
      '    values'
      '      ('#39'A044'#39','
      '       '#39'ID_JOB_CTRL'#39','
      '       id_job,'
      '       -1,'
      '       '#39'JOB'#39');'
      '  end if;'
      'exception'
      '  when others then'
      '    rollback;'
      'end;')
    Optimize = False
    Left = 264
    Top = 117
  end
  object scrT430_P430: TOracleQuery
    SQL.Strings = (
      'declare '
      '  cursor c1 is '
      
        '    select PROGRESSIVO, decode(P430DECORRENZA,null,INIZIO,trunc(' +
        'INIZIO,'#39'mm'#39')) PRIMA_DECORRENZA from '
      
        '      (select T430.PROGRESSIVO,min(T430.INIZIO) INIZIO,(select m' +
        'in(P430.DECORRENZA) from P430_ANAGRAFICO P430 where P430.PROGRES' +
        'SIVO = T430.PROGRESSIVO) P430DECORRENZA'
      
        '        from T430_STORICO T430 where T430.PROGRESSIVO = :Progres' +
        'sivo and T430.INIZIO is not null'
      '        group by PROGRESSIVO'
      '      )'
      
        '    where decode(P430DECORRENZA,null,INIZIO,trunc(INIZIO,'#39'mm'#39')) ' +
        'is not null'
      '    order by PROGRESSIVO;'
      'begin'
      '  for t1 in c1 loop'
      
        '    delete T430_STORICO where PROGRESSIVO = t1.progressivo and D' +
        'ATAFINE < t1.prima_decorrenza;'
      
        '    update T430_STORICO T430A set DATADECORRENZA = t1.prima_deco' +
        'rrenza where PROGRESSIVO = t1.progressivo '
      
        '      and DATADECORRENZA = (select min(DATADECORRENZA) from T430' +
        '_STORICO T430B where T430B.PROGRESSIVO = T430A.PROGRESSIVO)'
      '      and DATADECORRENZA < t1.prima_decorrenza;'
      
        '    delete P430_ANAGRAFICO where PROGRESSIVO = t1.progressivo an' +
        'd DECORRENZA_FINE < t1.prima_decorrenza;'
      
        '    update P430_ANAGRAFICO P430A set DECORRENZA = t1.prima_decor' +
        'renza where PROGRESSIVO = t1.progressivo '
      
        '      and DECORRENZA = (select min(DECORRENZA) from P430_ANAGRAF' +
        'ICO P430B where P430B.PROGRESSIVO = P430A.PROGRESSIVO)'
      '      and DECORRENZA < t1.prima_decorrenza;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 132
    Top = 60
  end
end
