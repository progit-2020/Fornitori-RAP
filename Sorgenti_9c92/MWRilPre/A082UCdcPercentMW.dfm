inherited A082FCdcPercentMW: TA082FCdcPercentMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 138
  Width = 317
  object selCdcPercent: TOracleDataSet
    Optimize = False
    Left = 28
    Top = 10
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'SELECT :CAMPO '
      'FROM T430_STORICO'
      'WHERE PROGRESSIVO = :Progressivo AND'
      '      :DATALAVORO BETWEEN DATADECORRENZA AND DATAFINE')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000000C0000003A0043004100
      4D0050004F00010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000020000001A00000043004F0044005F0043004F004E00540052004100
      540054004F00010000000000160000004400450053004300520049005A004900
      4F004E004500010000000000}
    Left = 107
    Top = 10
  end
  object scrT433Decorrenza_Fine: TOracleQuery
    SQL.Strings = (
      'begin'
      '  UPDATE T433_CDC_PERCENT T433 SET '
      '  DECORRENZA_FINE = '
      '    (SELECT MIN(DECORRENZA) - 1'
      '    FROM T433_CDC_PERCENT'
      '    WHERE PROGRESSIVO = T433.PROGRESSIVO AND'
      '    DECORRENZA > T433.DECORRENZA AND'
      '    CODICE = T433.CODICE)'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    DECORRENZA < (SELECT MAX(DECORRENZA)'
      '                  FROM T433_CDC_PERCENT'
      '                  WHERE PROGRESSIVO = T433.PROGRESSIVO AND'
      '                  CODICE = T433.CODICE) AND'
      '    DECORRENZA_FINE >= '
      '                  (SELECT MIN(DECORRENZA)'
      '                   FROM T433_CDC_PERCENT'
      '                   WHERE PROGRESSIVO = T433.PROGRESSIVO AND'
      '                   CODICE = T433.CODICE AND'
      '                   DECORRENZA > T433.DECORRENZA) AND'
      '    CODICE = :CODICE;'
      '  --Aggiorna l'#39'ultimo periodo storico'
      '  UPDATE T433_CDC_PERCENT T433 SET '
      '    DECORRENZA_FINE = TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      
        '    DECORRENZA = (SELECT MAX(DECORRENZA) FROM T433_CDC_PERCENT W' +
        'HERE PROGRESSIVO = T433.PROGRESSIVO AND CODICE = T433.CODICE) AN' +
        'D'
      '    CODICE = T433.CODICE AND'
      
        '    (DECORRENZA_FINE IS NULL OR DECORRENZA_FINE > TO_DATE('#39'31123' +
        '999'#39','#39'DDMMYYYY'#39'));'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0043004F00440049004300
      4500050000000000000000000000}
    Left = 52
    Top = 81
  end
  object srcCalcolaPerc: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is '
      '    select *'
      '    from t433_cdc_percent'
      '    where progressivo = :progressivo;'
      '  cursor c2 is'
      '    select distinct decorrenza'
      '    from t433_cdc_percent t'
      '    where progressivo = :progressivo'
      '    union'
      '    select distinct decorrenza-1'
      '    from t433_cdc_percent t'
      '    where progressivo = :progressivo'
      '    union'
      '    select distinct decorrenza_fine'
      '    from t433_cdc_percent t'
      '    where progressivo = :progressivo'
      '    union'
      '    select distinct decorrenza_fine+1'
      '    from t433_cdc_percent t'
      '    where progressivo = :progressivo; '
      '  somma number;'
      '  anomalie long:='#39#39';'
      'begin'
      '  for t2 in c2 loop'
      '    somma:=0;'
      '    for t1 in c1 loop'
      
        '      if t2.decorrenza between t1.decorrenza and t1.decorrenza_f' +
        'ine then'
      '        somma:=somma + t1.percentuale;'
      '      end if;'
      '    end loop;'
      '    if (somma != 100) and (somma != 0) then'
      
        '      anomalie:= anomalie || '#39'Il giorno '#39' || t2.decorrenza || '#39' ' +
        #232' coperto per il '#39' || somma || '#39'%'#39' || chr(10);'
      '    end if;'
      '  end loop;'
      '  :anomalie:=anomalie;  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0041004E004F004D004100
      4C00490045000A0000000000000000000000}
    Left = 168
    Top = 80
  end
  object cdsT433: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 170
    Top = 11
  end
  object delT433: TOracleQuery
    SQL.Strings = (
      'delete from T433_CDC_PERCENT where progressivo = :progressivo')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 249
    Top = 24
  end
  object CopyT433: TOracleQuery
    SQL.Strings = (
      'declare '
      '  cursor C1 is'
      '    select (T433.DECORRENZA_FINE - T433.DECORRENZA), T433.*'
      '      from T433_CDC_PERCENT T433'
      '     where T433.PROGRESSIVO = :PROGRESSIVO_ORIG'
      
        '       and :DATALAVORO between T433.DECORRENZA and T433.DECORREN' +
        'ZA_FINE'
      '     order by 1 desc;'
      '  DATA_FINE DATE;'
      'begin'
      '  if :PROGRESSIVO_ORIG = :PROGRESSIVO_DEST then'
      '    return;'
      '  end if; '
      
        '  /*PROGRESSIVO_ORIG progressivo modello da copiare su gli altri' +
        ' progressivi'
      
        '  PROGRESSIVO_DEST progressivo su cui effettuare la copia e unif' +
        'ormare'
      '  DATALAVORO data di riferimento*/  '
      '  for T1 in C1 loop              '
      
        '      /*cancello i periodi di destinazione completamente compres' +
        'i all'#39'interno del periodo di origine      '
      
        '          |--------------------------------------------|    -->P' +
        'eriodo di oriogine'
      '               A                  B             C     D'
      
        '        |---------------|-------------------|------|-----|  -->P' +
        'eriodi cancellati perch'#232' in terni(B/C)*/'
      '      delete'
      '        from T433_CDC_PERCENT T433'
      '       where T433.PROGRESSIVO = :PROGRESSIVO_DEST'
      '         and T433.DECORRENZA >= T1.DECORRENZA'
      
        '         and T433.DECORRENZA_FINE <= T1.DECORRENZA_FINE;        ' +
        '   '
      ''
      
        '      /*se il periodo di origine e contenuto in un periodo di de' +
        'stinazione spezzo il periodo di destinazione'
      
        '           |--------------------------------------------|     --' +
        '>Periodo di oriogine            '
      
        '        |--------------------------------------------------|  --' +
        '>Periodo di destinazione'
      
        '        |--|                                            |--|  --' +
        '>Periodo di destinazione spezzato*/     '
      
        '      insert into T433_CDC_PERCENT(PROGRESSIVO,DECORRENZA,DECORR' +
        'ENZA_FINE,CODICE,PERCENTUALE)'
      
        '      select T433.PROGRESSIVO, T1.DECORRENZA_FINE + 1,T433.DECOR' +
        'RENZA_FINE,T433.CODICE,T433.PERCENTUALE'
      '        from T433_CDC_PERCENT T433'
      '       where T433.PROGRESSIVO = :PROGRESSIVO_DEST'
      '         and T433.DECORRENZA <= T1.DECORRENZA'
      '         and T433.DECORRENZA_FINE >= T1.DECORRENZA_FINE'
      '         and (T433.DECORRENZA <> T1.DECORRENZA'
      '          or T433.DECORRENZA_FINE <> T1.DECORRENZA_FINE);'
      '                '
      '        '
      
        '      /*uniformo i periodi di destinazione intersecanti al perio' +
        'do di origine            '
      
        '          |--------------------------------------------|    -->P' +
        'eriodo di oriogine'
      '               A                  B             C     D'
      
        '        |---------------|-------------------|------|-----|  -->P' +
        'eriodi intersecanti (A/D)'
      '         A                  B                     C     D'
      
        '        |-|     Periodi precedentemente cancellati     |-|*/    ' +
        '     '
      '      update T433_CDC_PERCENT T433'
      '         set T433.DECORRENZA_FINE = T1.DECORRENZA - 1'
      '       where T433.PROGRESSIVO = :PROGRESSIVO_DEST'
      
        '         and T1.DECORRENZA between T433.DECORRENZA and T433.DECO' +
        'RRENZA_FINE;         '
      '      commit;   '
      '            '
      '      update T433_CDC_PERCENT T433'
      '         set T433.DECORRENZA = T1.DECORRENZA_FINE + 1'
      '       where T433.PROGRESSIVO = :PROGRESSIVO_DEST'
      
        '         and T1.DECORRENZA_FINE between T433.DECORRENZA and T433' +
        '.DECORRENZA_FINE;                     '
      '  end loop;  '
      '  for T1 in C1 loop               '
      
        '      insert into T433_CDC_PERCENT(PROGRESSIVO,DECORRENZA,DECORR' +
        'ENZA_FINE,CODICE,PERCENTUALE)'
      
        '      values(:PROGRESSIVO_DEST,T1.DECORRENZA,T1.DECORRENZA_FINE,' +
        'T1.CODICE,T1.PERCENTUALE);'
      '  end loop;    '
      '  commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000220000003A00500052004F00470052004500530053004900
      56004F005F004F00520049004700030000000000000000000000160000003A00
      44004100540041004C00410056004F0052004F000C0000000000000000000000
      220000003A00500052004F0047005200450053005300490056004F005F004400
      450053005400030000000000000000000000}
    Left = 245
    Top = 77
  end
end
