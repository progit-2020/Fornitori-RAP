inherited A075FFineAnnoMW: TA075FFineAnnoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 297
  Width = 721
  object Q010: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE FROM T010_CALENDIMPOSTAZ')
    Optimize = False
    Left = 12
    Top = 12
  end
  object GeneraCal: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GENERACALENDARIO.GENERACAL(:COD, :DAL, :AL, '#39'N'#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A0043004F004400050000000000000000000000
      080000003A00440041004C000C0000000000000000000000060000003A004100
      4C000C0000000000000000000000}
    Left = 56
    Top = 12
  end
  object GeneraProf: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GENERAPROFILI(:YEAR,:DUPLICATI);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00590045004100520003000000000000000000
      0000140000003A004400550050004C0049004300410054004900050000000000
      000000000000}
    Left = 112
    Top = 12
  end
  object scrGeneraDebiti: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor T061 is'
      '    select * from t061_plusoraannuo where anno = :NuovoAnno - 1;'
      'begin'
      '    for t1 in T061 loop'
      '    begin'
      
        '    insert into t061_plusoraannuo(anno,codice,tipopo,tipodebito,' +
        'ore1,ore2,ore3,ore4,ore5,ore6,ore7,ore8,ore9,ore10,ore11,ore12,t' +
        'ipogest1,tipogest2, '
      
        #9#9#9#9#9'tipogest3,tipogest4,tipogest5,tipogest6,tipogest7,tipogest8' +
        ',tipogest9,tipogest10,tipogest11,tipogest12)'
      
        '      values(:NuovoAnno,t1.codice,t1.tipopo,t1.tipodebito,t1.ore' +
        '1,t1.ore2,t1.ore3,t1.ore4,t1.ore5,t1.ore6,t1.ore7,t1.ore8,t1.ore' +
        '9,t1.ore10,t1.ore11,'
      
        '             t1.ore12,t1.tipogest1,t1.tipogest2,t1.tipogest3,t1.' +
        'tipogest4,t1.tipogest5,t1.tipogest6,t1.tipogest7,t1.tipogest8,t1' +
        '.tipogest9,'
      '             t1.tipogest10,t1.tipogest11,t1.tipogest12);'
      '    exception'
      '      when others then'
      '        null;  '
      '    end;  '
      '    end loop;'
      '    commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E0055004F0056004F0041004E004E004F00
      030000000000000000000000}
    Left = 472
    Top = 64
  end
  object delLimitiMens: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I INTEGER;'
      'BEGIN'
      '  FOR I IN 1..12 LOOP'
      '      DELETE FROM T810_LIQUIDABILE '
      '       WHERE anno = :anno and mese = I;'
      '      DELETE FROM T811_RESIDUABILE '
      '       WHERE anno = :anno and mese = I;'
      '      COMMIT;'
      '  END LOOP;'
      'END;'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 24
    Top = 176
  end
  object LimitiMensili: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I INTEGER;'
      'BEGIN'
      '  FOR I IN 1..12 LOOP'
      
        '      INSERT INTO T810_LIQUIDABILE (campo1, campo2, anno, mese, ' +
        'valore)'
      
        '      SELECT campo1, campo2, :anno, I, valore FROM T810_LIQUIDAB' +
        'ILE '
      '       WHERE anno = :anno - 1 and mese = decode(:MESE,0,I,12);'
      
        '      INSERT INTO T811_RESIDUABILE (campo1, campo2, anno, mese, ' +
        'valore)'
      
        '      SELECT campo1, campo2, :anno, I, valore FROM T811_RESIDUAB' +
        'ILE '
      '       WHERE anno = :anno - 1 and mese = decode(:MESE,0,I,12);'
      '      COMMIT;'
      '  END LOOP;'
      'END;'
      ''
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D00450053004500030000000000000000000000}
    Left = 24
    Top = 120
  end
  object scrGeneraProfiliInd: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR C1 IS'
      '    SELECT T263.*'
      '      FROM T263_PROFASSIND T263, T260_RAGGRASSENZE T260'
      '     WHERE T263.CODRAGGR = T260.CODICE'
      '       AND (T260.CONTASOLARE = '#39'S'#39
      '            OR EXISTS (SELECT '#39'X'#39
      '                       FROM T265_CAUASSENZE T265'
      '                      WHERE T265.CODRAGGR = T260.CODICE'
      
        '                        AND T265.TIPOCUMULO IN ('#39'A'#39','#39'M'#39','#39'N'#39','#39'P'#39',' +
        #39'Q'#39','#39'R'#39','#39'S'#39','#39'U'#39')))'
      '       AND T263.DAL = TO_DATE('#39'0101'#39'||:ANNO,'#39'DDMMYYYY'#39')  '
      '       AND T263.AL = TO_DATE('#39'3112'#39'||:ANNO,'#39'DDMMYYYY'#39')  '
      '       AND T263.PROGRESSIVO = :PROGRESSIVO;'
      '  P NUMBER;'
      'BEGIN'
      '  FOR T1 IN C1 LOOP'
      '    BEGIN'
      '      IF T1.DATARES IS NOT NULL THEN'
      '        T1.DATARES:=ADD_MONTHS(T1.DATARES,12);'
      '      END IF;'
      '      INSERT INTO T263_PROFASSIND'
      '        (PROGRESSIVO, DAL, AL, CODRAGGR, UMISURA, '
      
        '         COMPETENZA1, RETRIBUZIONE1, COMPETENZA2, RETRIBUZIONE2,' +
        ' COMPETENZA3, RETRIBUZIONE3, '
      
        '         COMPETENZA4, RETRIBUZIONE4, COMPETENZA5, RETRIBUZIONE5,' +
        ' COMPETENZA6, RETRIBUZIONE6, '
      '         DATARES)'
      '      VALUES'
      
        '        (T1.PROGRESSIVO, ADD_MONTHS(T1.DAL,12), ADD_MONTHS(T1.AL' +
        ',12), T1.CODRAGGR, T1.UMISURA, '
      
        '         T1.COMPETENZA1, T1.RETRIBUZIONE1, T1.COMPETENZA2, T1.RE' +
        'TRIBUZIONE2, T1.COMPETENZA3, T1.RETRIBUZIONE3, '
      
        '         T1.COMPETENZA4, T1.RETRIBUZIONE4, T1.COMPETENZA5, T1.RE' +
        'TRIBUZIONE5, T1.COMPETENZA6, T1.RETRIBUZIONE6, '
      '         T1.DATARES);'
      '    EXCEPTION '
      '      WHEN OTHERS THEN'
      '        P:=NULL;'
      '    END;'
      '  END LOOP; '
      '  COMMIT;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 112
    Top = 60
  end
  object scrGeneraDebitiIndiv: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor T090 is'
      
        '    select * from t090_plusoraindiv where progressivo = :prog an' +
        'd anno = :NuovoAnno - 1;'
      'begin'
      '    for t1 in T090 loop'
      '    begin'
      
        '    insert into t090_plusoraindiv(progressivo,anno,descrizione,t' +
        'ipopo,tipodebito,ore1,ore2,ore3,ore4,ore5,ore6,ore7,ore8,ore9,or' +
        'e10,ore11,ore12,tipogest1,tipogest2, '
      
        #9#9#9#9#9'tipogest3,tipogest4,tipogest5,tipogest6,tipogest7,tipogest8' +
        ',tipogest9,tipogest10,tipogest11,tipogest12)'
      
        '      values(t1.progressivo,:NuovoAnno,t1.descrizione,t1.tipopo,' +
        't1.tipodebito,t1.ore1,t1.ore2,t1.ore3,t1.ore4,t1.ore5,t1.ore6,t1' +
        '.ore7,t1.ore8,t1.ore9,t1.ore10,t1.ore11,'
      
        '             t1.ore12,t1.tipogest1,t1.tipogest2,t1.tipogest3,t1.' +
        'tipogest4,t1.tipogest5,t1.tipogest6,t1.tipogest7,t1.tipogest8,t1' +
        '.tipogest9,'
      '             t1.tipogest10,t1.tipogest11,t1.tipogest12);'
      '    exception'
      '      when others then'
      '        null;  '
      '    end;  '
      '    end loop;'
      '    commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      0000140000003A004E0055004F0056004F0041004E004E004F00030000000000
      000000000000}
    Left = 576
    Top = 64
  end
  object scrT263: TOracleQuery
    SQL.Strings = (
      'declare'
      '  i integer;'
      'begin'
      '  select count(*) into i '
      '  from T260_RAGGRASSENZE T260'
      '  where T260.CODICE = :CODRAGGR'
      '  and T260.CONTASOLARE = '#39'S'#39';'
      '  if i > 0 then   '
      '    if oreminuti(:COMPETENZA) = 0 then'
      '      delete from T263_PROFASSIND '
      '      where PROGRESSIVO = :PROGRESSIVO'
      '      and CODRAGGR = :CODRAGGR'
      '      and DAL = :DAL;'
      '    else'
      '      update T263_PROFASSIND '
      '      set COMPETENZA1 = :COMPETENZA'
      '      where PROGRESSIVO = :PROGRESSIVO'
      '      and CODRAGGR = :CODRAGGR'
      '      and DAL = :DAL;'
      '  '
      '      if sql%rowcount = 0 then'
      
        '        insert into T263_PROFASSIND (PROGRESSIVO,DAL,AL,CODRAGGR' +
        ',UMISURA,COMPETENZA1)'
      
        '        values (:PROGRESSIVO,:DAL,add_months(:DAL,12) - 1,:CODRA' +
        'GGR,'#39'O'#39',:COMPETENZA);'
      '      end if;'
      '    end if;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0043004F00440052004100
      470047005200050000000000000000000000080000003A00440041004C000C00
      00000000000000000000160000003A0043004F004D0050004500540045004E00
      5A004100050000000000000000000000}
    Left = 247
    Top = 13
  end
  object Del130: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T130_RESIDANNOPREC'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND ANNO = :ANNO'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 164
    Top = 12
  end
  object Ins130: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  INSERT INTO T130_RESIDANNOPREC'
      
        '    (PROGRESSIVO,ANNO,SALDOORELAV,ORECOMPENSABILI,RIPOSICOMP,BAN' +
        'CA_ORE)'
      '  VALUES'
      
        '    (:PROGRESSIVO,:ANNO,:SALDOORELAV,:ORECOMPENSABILI,:RIPOSICOM' +
        'P,:BANCA_ORE);'
      'EXCEPTION'
      '  WHEN DUP_VAL_ON_INDEX THEN'
      '    :ERR_DUP_VAL:='#39'S'#39';'
      'END;'
      '')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000180000003A00530041004C0044004F004F0052004500
      4C0041005600050000000000000000000000200000003A004F00520045004300
      4F004D00500045004E0053004100420049004C00490005000000000000000000
      0000160000003A005200490050004F005300490043004F004D00500005000000
      0000000000000000140000003A00420041004E00430041005F004F0052004500
      050000000000000000000000180000003A004500520052005F00440055005000
      5F00560041004C00050000000000000000000000}
    Left = 204
    Top = 12
  end
  object delT131: TOracleQuery
    SQL.Strings = (
      
        'DELETE FROM T131_RESIDPRESENZE WHERE PROGRESSIVO = :PROGRESSIVO ' +
        'AND ANNO = :ANNO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 192
    Top = 60
  end
  object insT131: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  INSERT INTO T131_RESIDPRESENZE '
      
        '    (PROGRESSIVO,ANNO,CAUSALE,ORE_FASCIA1,ORE_FASCIA2,ORE_FASCIA' +
        '3,ORE_FASCIA4,ORE_FASCIA5,ORE_FASCIA6)'
      '  VALUES'
      
        '    (:PROGRESSIVO,:ANNO,:CAUSALE,:ORE_FASCIA1,:ORE_FASCIA2,:ORE_' +
        'FASCIA3,:ORE_FASCIA4,:ORE_FASCIA5,:ORE_FASCIA6);'
      'EXCEPTION'
      '  WHEN DUP_VAL_ON_INDEX THEN'
      '    NULL;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000180000003A004F00520045005F004600410053004300
      490041003100050000000000000000000000180000003A004F00520045005F00
      4600410053004300490041003200050000000000000000000000180000003A00
      4F00520045005F00460041005300430049004100330005000000000000000000
      0000180000003A004F00520045005F0046004100530043004900410034000500
      00000000000000000000180000003A004F00520045005F004600410053004300
      490041003500050000000000000000000000180000003A004F00520045005F00
      4600410053004300490041003600050000000000000000000000}
    Left = 236
    Top = 60
  end
  object delT264: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T264_RESIDASSANN'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND ANNO = :ANNO'
      'AND CODRAGGR = :CODRAGGR'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000120000003A0043004F00440052004100470047005200
      050000000000000000000000}
    Left = 324
    Top = 14
  end
  object selT264: TOracleDataSet
    SQL.Strings = (
      'select RESIDUO1,RESIDUO2,RESIDUO3,RESIDUO4,RESIDUO5,RESIDUO6'
      'from T264_RESIDASSANN'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and ANNO = :ANNO'
      'and CODRAGGR = :CODRAGGR')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000120000003A0043004F00440052004100470047005200
      050000000000000000000000}
    Left = 464
    Top = 14
  end
  object updT264: TOracleQuery
    SQL.Strings = (
      'UPDATE T264_RESIDASSANN SET '
      '  RESIDUO1 = :RESIDUO1,'
      '  RESIDUO2 = :RESIDUO2,'
      '  RESIDUO3 = :RESIDUO3,'
      '  RESIDUO4 = :RESIDUO4,'
      '  RESIDUO5 = :RESIDUO5,'
      '  RESIDUO6 = :RESIDUO6'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND ANNO = :ANNO'
      'AND CODRAGGR = :CODRAGGR')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000120000003A0043004F00440052004100470047005200
      050000000000000000000000120000003A005200450053004900440055004F00
      3100050000000000000000000000120000003A00520045005300490044005500
      4F003200050000000000000000000000120000003A0052004500530049004400
      55004F003300050000000000000000000000120000003A005200450053004900
      440055004F003400050000000000000000000000120000003A00520045005300
      4900440055004F003500050000000000000000000000120000003A0052004500
      53004900440055004F003600050000000000000000000000}
    Left = 416
    Top = 14
  end
  object scrT692: TOracleQuery
    SQL.Strings = (
      'declare'
      '  b number;'
      '  t number;'
      '  res_b number;'
      '  res_t number;'
      '  acq_b number;'
      '  acq_t number;'
      '  ini date;'
      '  fin date;'
      'begin'
      
        '  select last_day(add_months(inizio,-1)) + 1, fine into ini,fin ' +
        'from '
      
        '  (SELECT MIN(INIZIO) INIZIO,MAX(NVL(FINE,TO_DATE(31123999,'#39'DDMM' +
        'YYYY'#39'))) FINE FROM '
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
      
        '  TO_DATE('#39'3112'#39'||LPAD(:ANNO,4,'#39'0'#39'),'#39'DDMMYYYY'#39') BETWEEN INIZIO A' +
        'ND NVL(FINE,TO_DATE(31123999,'#39'DDMMYYYY'#39')) '
      '  )'
      '  where inizio is not null;'
      ''
      '  --lettura maturato nell'#39'anno corrente'
      '  begin'
      
        '    select nvl(sum(nvl(buonipasto,0) + nvl(varbuonipasto,0)),0),' +
        ' nvl(sum(nvl(ticket,0) + nvl(varticket,0)),0)'
      '      into b,t'
      '      from t680_buonimensili'
      '     where progressivo = :progressivo and anno = :anno and'
      
        '           to_date('#39'01'#39'||lpad(mese,2,'#39'0'#39')||lpad(anno,4,'#39'0'#39'),'#39'ddm' +
        'myyyy'#39') between ini and fin;'
      '  exception'
      '    when no_data_found then'
      '      b:=0;'
      '      t:=0;'
      '  end;'
      '  --lettura acquisti nell'#39'anno corrente'
      '  begin'
      
        '    select nvl(sum(nvl(buonipasto,0) + nvl(buoni_auto,0)),0),nvl' +
        '(sum(nvl(ticket,0) + nvl(ticket_auto,0)),0) '
      '      into acq_b,acq_t '
      '      from t690_acquistobuoni'
      '     where progressivo = :progressivo and '
      
        '           data between to_date('#39'0101'#39'||:anno,'#39'ddmmyyyy'#39') and to' +
        '_date('#39'3112'#39'||:anno,'#39'ddmmyyyy'#39') and'
      '           data between ini and fin;'
      '  exception'
      '    when no_data_found then'
      '      acq_b:=0;'
      '      acq_t:=0;   '
      '  end;'
      '  --lettura residuo dall'#39'anno precedente'
      '  begin'
      '    select nvl(buonipasto,0),nvl(ticket,0) '
      '      into res_b,res_t '
      '      from t692_residuobuoni'
      '     where progressivo = :progressivo and anno = :anno and'
      '           anno > to_char(ini,'#39'yyyy'#39');'
      '  exception'
      '    when no_data_found then'
      '      res_b:=0;'
      '      res_t:=0;   '
      '  end;'
      '  b:=acq_b + res_b - b;'
      '  t:=acq_t + res_t - t;'
      '  '
      '  --aggiornamento residui correnti'
      '  if :sovrascrivi = '#39'S'#39' then'
      '    update t692_residuobuoni '
      '    set    buonipasto = b,'
      '           ticket = t'
      '    where  progressivo = :progressivo '
      '    and    anno = :anno + 1;'
      '  end if;'
      ''
      '  if ((:sovrascrivi = '#39'N'#39') or (sql%rowcount = 0)) and '
      '     (b <> 0 or t <> 0) then'
      '    begin'
      
        '      insert into t692_residuobuoni (progressivo,anno,buonipasto' +
        ',ticket)'
      '      values (:progressivo,:anno + 1,b,t);'
      '    exception'
      '      when dup_val_on_index then'
      '        :ERR_DUP_VAL:='#39'S'#39';        '
      '    end;'
      '  end if;'
      'exception'
      '  when no_data_found then'
      '    b:=0;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000180000003A0053004F00560052004100530043005200
      490056004900050000000000000000000000180000003A004500520052005F00
      4400550050005F00560041004C00050000000000000000000000}
    Left = 12
    Top = 60
  end
  object delT820: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I INTEGER;'
      'BEGIN'
      '  FOR I IN 1..12 LOOP'
      '      DELETE FROM T820_LIMITIIND '
      
        '       WHERE progressivo = :progressivo AND anno = :anno and mes' +
        'e = I;'
      '      COMMIT;'
      '  END LOOP;'
      'END;'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 104
    Top = 176
  end
  object insT820: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I INTEGER;'
      'BEGIN'
      '  FOR I IN 1..12 LOOP'
      '    BEGIN'
      
        '      INSERT INTO T820_LIMITIIND (progressivo, anno, mese, dal, ' +
        'al, causale, liquidabile, ore_teoriche, ore)'
      
        '        SELECT progressivo, :anno, I, dal, al, causale, liquidab' +
        'ile, ore_teoriche, ore from T820_LIMITIIND '
      
        '        WHERE progressivo = :progressivo AND anno = :anno - 1 an' +
        'd mese = decode(:MESE,0,I,12);'
      '      COMMIT;'
      '    EXCEPTION'
      '      WHEN DUP_VAL_ON_INDEX THEN'
      '        :ERR_DUP_VAL:='#39'S'#39';'
      '    END;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000A0000003A004D004500530045000300000000000000
      00000000180000003A004500520052005F004400550050005F00560041004C00
      050000000000000000000000}
    Left = 104
    Top = 120
  end
  object SelSG655: TOracleDataSet
    SQL.Strings = (
      'select distinct PROFILO_CREDITI'
      'from sg655_profilicrediti'
      'where anno = :nanno'
      '  and codice = :scodice')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A004E0041004E004E004F000300000000000000
      00000000100000003A00530043004F0044004900430045000500000000000000
      00000000}
    Left = 668
    Top = 15
  end
  object scrSG256: TOracleQuery
    SQL.Strings = (
      'declare'
      'begin'
      '  --aggiornamento residui correnti'
      '  update SG656_RESIDUOCREDITI'
      '     set CREDITI = :crediti'
      
        '   where progressivo = :progressivo and anno = :anno and profilo' +
        '_crediti = :profilo;'
      '   if sql%rowcount = 0 then'
      
        '     insert into SG656_RESIDUOCREDITI (progressivo,anno,profilo_' +
        'crediti,crediti)'
      '     values (:progressivo,:anno,:profilo,:crediti);'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000400000004000000000000000A0000003A0041004E004E00
      4F000300000004000000D107000000000000100000003A004300520045004400
      490054004900040000000000000000000000100000003A00500052004F004600
      49004C004F00050000000000000000000000}
    Left = 316
    Top = 60
  end
  object Q262: TOracleDataSet
    SQL.Strings = (
      'select '
      '  min(CODICE) CODICE, min(TIPOCUMULO) TIPOCUMULO,'
      
        '  CODRAGGR,MAXRESIDUO,MAXRESIDUO_CORR,MAXRESIDUO_PREC,RAGGRUPPAM' +
        'ENTO_RESIDUO,RAGGR_RESIDUO_PREC,DATARES,CUMULA_RAGGR_BASE'
      'from ('
      '--Profili assenze'
      
        'select T265.CODICE,T265.CODRAGGR,T265.FRUIBILE,T260.MAXRESIDUO,T' +
        '260.MAXRESIDUO_CORR,T260.MAXRESIDUO_PREC,T260.RAGGRUPPAMENTO_RES' +
        'IDUO,T260.RAGGR_RESIDUO_PREC,T262.DATARES,T265.TIPOCUMULO,T265.D' +
        'URATACUMULO,'
      
        '       decode(T260.RAGGRUPPAMENTO_RESIDUO,null,decode(T260.CUMUL' +
        'A_RAGGR_BASE,'#39'S'#39','#39'0'#39','#39'1'#39'),'#39'1'#39') CUMULA_RAGGR_BASE'
      'from T265_CAUASSENZE T265,'
      '     T260_RAGGRASSENZE T260,'
      '     T262_PROFASSANN T262'
      'where '
      '      T260.RESIDUABILE = '#39'S'#39' and      '
      '      T260.CONTASOLARE = '#39'S'#39' and'
      '      T265.CODRAGGR = T260.CODICE and'
      '      T262.CODPROFILO = '
      '        (select PASSENZE '
      '         from T430_STORICO '
      
        '         where PROGRESSIVO = :PROGRESSIVO and :DATA between DATA' +
        'DECORRENZA and DATAFINE) and'
      '      T262.CODRAGGR = T265.CODRAGGR and'
      '      T262.ANNO = :ANNO and'
      '      T265.TIPOCUMULO = '#39'A'#39' and '
      
        '      T265.CODRAGGR not in (select CODRAGGR from T263_PROFASSIND' +
        ' where ANNO = :ANNO and PROGRESSIVO = :PROGRESSIVO)'
      'union'
      '--Profili assenze individuali'
      
        'select T265.CODICE,T265.CODRAGGR,T265.FRUIBILE,T260.MAXRESIDUO,T' +
        '260.MAXRESIDUO_CORR,T260.MAXRESIDUO_PREC,T260.RAGGRUPPAMENTO_RES' +
        'IDUO,T260.RAGGR_RESIDUO_PREC,T263.DATARES,T265.TIPOCUMULO,T265.D' +
        'URATACUMULO,'
      
        '       decode(T260.RAGGRUPPAMENTO_RESIDUO,null,decode(T260.CUMUL' +
        'A_RAGGR_BASE,'#39'S'#39','#39'0'#39','#39'1'#39'),'#39'1'#39') CUMULA_RAGGR_BASE'
      'from T265_CAUASSENZE T265,'
      '     T260_RAGGRASSENZE T260,'
      '     T263_PROFASSIND T263'
      'where '
      '      T263.PROGRESSIVO =:PROGRESSIVO and'
      '      :DATA between T263.DAL and T263.AL and '
      '      T263.CODRAGGR = T265.CODRAGGR and'
      '      T265.CODRAGGR = T260.CODICE and'
      '      T265.TIPOCUMULO = '#39'A'#39' and '
      '      T260.RESIDUABILE = '#39'S'#39' and '
      '      T260.CONTASOLARE = '#39'S'#39
      'union'
      '--Raggruppamenti residuabili'
      
        'select T265.CODICE,T265.CODRAGGR,T265.FRUIBILE,T260.MAXRESIDUO,T' +
        '260.MAXRESIDUO_CORR,T260.MAXRESIDUO_PREC,T260.RAGGRUPPAMENTO_RES' +
        'IDUO,T260.RAGGR_RESIDUO_PREC,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'),T265' +
        '.TIPOCUMULO,T265.DURATACUMULO,'
      
        '       decode(T260.RAGGRUPPAMENTO_RESIDUO,null,decode(T260.CUMUL' +
        'A_RAGGR_BASE,'#39'S'#39','#39'0'#39','#39'1'#39'),'#39'1'#39') CUMULA_RAGGR_BASE'
      'from T265_CAUASSENZE T265,'
      '     T260_RAGGRASSENZE T260'
      'where '
      '      T260.RESIDUABILE = '#39'S'#39' and'
      '      T260.CONTASOLARE = '#39'N'#39' and'
      '      T265.CODRAGGR = T260.CODICE and'
      '      T265.TIPOCUMULO <> '#39'H'#39
      ')'
      'where 1=1'
      '--Abilitazione in anagrafica'
      'and ('
      '     FRUIBILE = '#39'S'#39' or'
      '     exists ('
      '       select '#39'X'#39' from T430_STORICO where'
      '       PROGRESSIVO = :PROGRESSIVO and '
      '       :DATA between DATADECORRENZA and DATAFINE and'
      '       instr('#39','#39'||ABCAUSALE1||'#39','#39','#39','#39'||CODICE||'#39','#39') > 0'
      '       )'
      '     )'
      
        '--Esclusione dei raggruppamenti che residuano su raggruppamenti ' +
        'diversi'
      'and CODRAGGR not in'
      '  (select T1.RAGGRUPPAMENTO_RESIDUO '
      '   from T260_RAGGRASSENZE T1, T260_RAGGRASSENZE T2'
      '   where T1.CODICE <> T1.RAGGRUPPAMENTO_RESIDUO '
      '   and T1.RAGGRUPPAMENTO_RESIDUO is not null'
      '   and T1.RAGGRUPPAMENTO_RESIDUO = T2.CODICE '
      '   and nvl(T2.RAGGRUPPAMENTO_RESIDUO,T2.CODICE) = T2.CODICE'
      '   and T2.CUMULA_RAGGR_BASE = '#39'N'#39
      '   --and T1.CODICE <> '#39'FSV2'#39
      
        '   --Si considerano solo i raggruppamenti abilitati, o da profil' +
        'o o sull'#39'anagrafica'
      '   and (T1.CONTASOLARE = '#39'N'#39' '
      
        '        or exists (select '#39'X'#39' from T262_PROFASSANN T262, T430_ST' +
        'ORICO T430 where T430.PROGRESSIVO = :PROGRESSIVO and :DATA betwe' +
        'en T430.datadecorrenza and T430.datafine'
      
        '                   and T430.PASSENZE = T262.CODPROFILO and T262.' +
        'ANNO = :ANNO and T262.CODRAGGR = T1.CODICE'
      '                   union '
      
        '                   select '#39'X'#39' from T263_PROFASSIND T263 where PR' +
        'OGRESSIVO = :PROGRESSIVO and T263.ANNO = :ANNO and T263.CODRAGGR' +
        ' = T1.CODICE))'
      '   and exists (select '#39'x'#39' from T265_CAUASSENZE '
      '               where CODRAGGR = T1.CODICE'
      '               and (FRUIBILE = '#39'S'#39' '
      '                    or exists (select '#39'X'#39' from T430_STORICO '
      '                               where PROGRESSIVO = :PROGRESSIVO '
      
        '                               and :DATA between DATADECORRENZA ' +
        'and DATAFINE '
      
        '                               and instr('#39','#39'||ABCAUSALE1||'#39','#39','#39',' +
        #39'||CODICE||'#39','#39') > 0)))'
      '  )'
      'and CODRAGGR not in'
      '  (select T1.RAGGR_RESIDUO_PREC'
      '   from T260_RAGGRASSENZE T1, T260_RAGGRASSENZE T2'
      '   where T1.CODICE <> T1.RAGGR_RESIDUO_PREC '
      '   and T1.RAGGR_RESIDUO_PREC is not null'
      '   and T1.RAGGR_RESIDUO_PREC = T2.CODICE '
      '   and nvl(T2.RAGGR_RESIDUO_PREC,T2.CODICE) = T2.CODICE'
      '   and T2.CUMULA_RAGGR_BASE = '#39'N'#39
      
        '   --Si considerano solo i raggruppamenti abilitati, o da profil' +
        'o o sull'#39'anagrafica'
      '   and (T1.CONTASOLARE = '#39'N'#39' '
      
        '        or exists (select '#39'X'#39' from T262_PROFASSANN T262, T430_ST' +
        'ORICO T430 where T430.PROGRESSIVO = :PROGRESSIVO and :DATA betwe' +
        'en T430.datadecorrenza and T430.datafine'
      
        '                   and T430.PASSENZE = T262.CODPROFILO and T262.' +
        'ANNO = :ANNO and T262.CODRAGGR = T1.CODICE'
      '                   union '
      
        '                   select '#39'X'#39' from T263_PROFASSIND T263 where PR' +
        'OGRESSIVO = :PROGRESSIVO and T263.ANNO = :ANNO and T263.CODRAGGR' +
        ' = T1.CODICE))'
      '   and exists (select '#39'x'#39' from T265_CAUASSENZE '
      '               where CODRAGGR = T1.CODICE'
      '               and (FRUIBILE = '#39'S'#39' '
      '                    or exists (select '#39'X'#39' from T430_STORICO '
      '                               where PROGRESSIVO = :PROGRESSIVO '
      
        '                               and :DATA between DATADECORRENZA ' +
        'and DATAFINE '
      
        '                               and instr('#39','#39'||ABCAUSALE1||'#39','#39','#39',' +
        #39'||CODICE||'#39','#39') > 0)))'
      '  )'
      
        'group by CODRAGGR,MAXRESIDUO,MAXRESIDUO_CORR,MAXRESIDUO_PREC,RAG' +
        'GRUPPAMENTO_RESIDUO,RAGGR_RESIDUO_PREC,DATARES,CUMULA_RAGGR_BASE'
      'order by CUMULA_RAGGR_BASE,CODRAGGR')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 288
    Top = 14
  end
  object SelT430: TOracleDataSet
    SQL.Strings = (
      'select :nomecampo as campo'
      'from t430_storico '
      'where datadecorrenza ='
      '(select max(datadecorrenza)'
      '   from t430_storico'
      
        '  where inizio <= to_date('#39'3112'#39' || to_char(:datain,'#39'yyyy'#39'),'#39'ddm' +
        'myyyy'#39')'
      
        '    and nvl(fine,:datain) >= to_date('#39'0101'#39' || to_char(:datain,'#39 +
        'yyyy'#39'),'#39'ddmmyyyy'#39')'
      '    and progressivo = :nprogressivo)'
      '  and progressivo = :nprogressivo')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004E004F004D004500430041004D0050004F00
      0100000010000000435245444954495F464F524D41544900000000000E000000
      3A00440041005400410049004E000C0000000700000078670101010101000000
      001A0000003A004E00500052004F0047005200450053005300490056004F0003
      000000040000002600000000000000}
    Left = 604
    Top = 15
  end
  object insT825: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'BEGIN'
      
        '  INSERT INTO T825_LIQUIDINDANNUO (progressivo, anno, liquidabil' +
        'e, residuabile)'
      
        '    SELECT progressivo, :anno, liquidabile, residuabile FROM T82' +
        '5_LIQUIDINDANNUO'
      '    WHERE progressivo = :progressivo AND anno = :anno - 1;'
      '  COMMIT;'
      'EXCEPTION'
      '  WHEN DUP_VAL_ON_INDEX THEN'
      '    :ERR_DUP_VAL:='#39'S'#39';'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000180000003A004500520052005F004400550050005F00
      560041004C00050000000000000000000000}
    Left = 176
    Top = 120
  end
  object delT825: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'BEGIN'
      '  DELETE FROM T825_LIQUIDINDANNUO '
      '   WHERE progressivo = :progressivo AND anno = :anno;'
      '  COMMIT;'
      'END;'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 176
    Top = 176
  end
  object scrTriggerBefore: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  wParCount   integer;'
      '  wSqlStm     varchar2(2000);'
      'BEGIN'
      
        '  -- la stored procedure pu'#242' contenere o meno il terzo argomento' +
        ' P_ELENCO_RESIDUI'
      '  select count(ARGUMENT_NAME)'
      '  into   wParCount'
      '  from   USER_ARGUMENTS'
      '  where  OBJECT_NAME = '#39'RESIDUI_TRIGGER_BEFORE'#39';'
      ''
      '  if wParCount = 2 then'
      
        '    wSqlStm:='#39'BEGIN RESIDUI_TRIGGER_BEFORE(:PROGRESSIVO, :ANNO);' +
        ' END;'#39';'
      '    execute immediate wSqlStm using :PROGRESSIVO, :ANNO;'
      '  elsif wParCount = 3 then'
      
        '    wSqlStm:='#39'BEGIN RESIDUI_TRIGGER_BEFORE(:PROGRESSIVO, :ANNO, ' +
        ':ELENCO_RESIDUI); END;'#39';'
      
        '    execute immediate wSqlStm using :PROGRESSIVO, :ANNO, :ELENCO' +
        '_RESIDUI;'
      '  end if;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      000000000000000000001E0000003A0045004C0045004E0043004F005F005200
      450053004900440055004900050000000000000000000000}
    Left = 256
    Top = 176
  end
  object scrTriggerAfter: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  wParCount   integer;'
      '  wSqlStm     varchar2(2000);'
      'BEGIN'
      '  -- la stored procedure pu'#242' contenere parametri opzionali'
      '  select count(ARGUMENT_NAME)'
      '  into   wParCount'
      '  from   USER_ARGUMENTS'
      '  where  OBJECT_NAME = '#39'RESIDUI_TRIGGER_AFTER'#39';'
      ''
      '  if wParCount = 2 then'
      
        '    wSqlStm:='#39'BEGIN RESIDUI_TRIGGER_AFTER(:PROGRESSIVO, :ANNO); ' +
        'END;'#39';'
      '    execute immediate wSqlStm using :PROGRESSIVO, :ANNO;'
      '  elsif wParCount = 3 then'
      
        '    wSqlStm:='#39'BEGIN RESIDUI_TRIGGER_AFTER(:PROGRESSIVO, :ANNO, :' +
        'ELENCO_RESIDUI); END;'#39';'
      
        '    execute immediate wSqlStm using :PROGRESSIVO, :ANNO, :ELENCO' +
        '_RESIDUI;'
      '  elsif wParCount = 4 then'
      
        '    wSqlStm:='#39'BEGIN RESIDUI_TRIGGER_AFTER(:PROGRESSIVO, :ANNO, :' +
        'ELENCO_RESIDUI, :ELENCO_RESIDUI_PRESENTI); END;'#39';'
      
        '    execute immediate wSqlStm using :PROGRESSIVO, :ANNO, :ELENCO' +
        '_RESIDUI, :ELENCO_RESIDUI_PRESENTI;'
      '  end if;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      000000000000000000001E0000003A0045004C0045004E0043004F005F005200
      450053004900440055004900050000000000000000000000300000003A004500
      4C0045004E0043004F005F0052004500530049004400550049005F0050005200
      4500530045004E0054004900050000000000000000000000}
    Left = 344
    Top = 176
  end
  object selProcResidui: TOracleDataSet
    SQL.Strings = (
      'select OBJECT_NAME'
      'from   USER_PROCEDURES'
      
        'where  OBJECT_NAME in ('#39'RESIDUI_TRIGGER_BEFORE'#39', '#39'RESIDUI_TRIGGE' +
        'R_AFTER'#39')')
    ReadBuffer = 2
    Optimize = False
    ReadOnly = True
    Left = 424
    Top = 176
  end
  object insT264: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T264_RESIDASSANN'
      
        '(PROGRESSIVO,ANNO,CODRAGGR,FRUIZCOMPPREC_CUMULO_T,RESIDUO1,RESID' +
        'UO2,RESIDUO3,RESIDUO4,RESIDUO5,RESIDUO6)'
      'VALUES'
      
        '(:PROGRESSIVO,:ANNO,:CODRAGGR,:FRUIZCOMPPREC_CUMULO_T,:RESIDUO1,' +
        ':RESIDUO2,:RESIDUO3,:RESIDUO4,:RESIDUO5,:RESIDUO6)')
    Optimize = False
    Variables.Data = {
      040000000A000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000120000003A0043004F00440052004100470047005200
      050000000000000000000000120000003A005200450053004900440055004F00
      3100050000000000000000000000120000003A00520045005300490044005500
      4F003200050000000000000000000000120000003A0052004500530049004400
      55004F003300050000000000000000000000120000003A005200450053004900
      440055004F003400050000000000000000000000120000003A00520045005300
      4900440055004F003500050000000000000000000000120000003A0052004500
      53004900440055004F0036000500000000000000000000002E0000003A004600
      5200550049005A0043004F004D00500050005200450043005F00430055004D00
      55004C004F005F005400050000000000000000000000}
    Left = 368
    Top = 14
  end
  object selT264RaggrAnno: TOracleDataSet
    SQL.Strings = (
      'select CODRAGGR '
      'from   T264_RESIDASSANN'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    ANNO = :ANNO'
      'order by CODRAGGR')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000500000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 535
    Top = 14
  end
  object selCountT692: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   T692_RESIDUOBUONI'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    ANNO = :ANNO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 224
    Top = 240
  end
  object selCountT820: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   T820_LIMITIIND'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    ANNO = :ANNO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 304
    Top = 240
  end
  object selCountT825: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   T825_LIQUIDINDANNUO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    ANNO = :ANNO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 376
    Top = 240
  end
  object selCountT130_T131: TOracleQuery
    SQL.Strings = (
      'SELECT '
      '  (SELECT COUNT(*)'
      '   FROM   T130_RESIDANNOPREC'
      '   WHERE  PROGRESSIVO = :PROGRESSIVO'
      '   AND    ANNO = :ANNO) AS COUNT_T130,'
      '  (SELECT COUNT(*)'
      '   FROM   T130_RESIDANNOPREC'
      '   WHERE  PROGRESSIVO = :PROGRESSIVO'
      '   AND    ANNO = :ANNO) AS COUNT_T131'
      'FROM    DUAL')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 40
    Top = 240
  end
  object selCountT264: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   T264_RESIDASSANN'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    ANNO = :ANNO'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 144
    Top = 240
  end
end
