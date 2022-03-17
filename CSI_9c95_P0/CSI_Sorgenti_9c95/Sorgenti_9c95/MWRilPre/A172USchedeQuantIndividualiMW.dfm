inherited A172FSchedeQuantIndividualiMW: TA172FSchedeQuantIndividualiMW
  OldCreateOrder = True
  Height = 382
  Width = 655
  object cdsT768: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsT768BeforePost
    Left = 88
    Top = 24
  end
  object selT762: TOracleDataSet
    SQL.Strings = (
      'select progressivo, SUM(importo + variazioni) totale '
      'from t762_incentivimaturati t762'
      'where t762.anno = :anno'
      '  and t762.mese = :mese'
      '  and t762.codtipoquota IN (:acconti)'
      '  and t762.tipoimporto = '#39'2'#39
      'group by progressivo'
      'order by progressivo')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D0045005300450003000000000000000000000010000000
      3A004100430043004F004E0054004900010000000000000000000000}
    Left = 263
    Top = 86
  end
  object selT762Pag: TOracleDataSet
    SQL.Strings = (
      'select progressivo, SUM(GIORNI_ORE) totORE'
      'from t762_incentivimaturati t762'
      'where t762.anno = :anno'
      '  and t762.codtipoquota = :CODQUOTA'
      'group by progressivo'
      'order by progressivo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000120000003A0043004F004400510055004F00540041000500000000000000
      00000000}
    Left = 264
    Top = 136
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * from t765_tipoquote t765'
      'where tipoquota = '#39'Q'#39
      '  and decorrenza = (select max(decorrenza) from t765_tipoquote '
      '                     where codice = t765.codice'
      '                       and decorrenza <= :DEC)'
      'order by codice')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004400450043000C0000000000000000000000}
    Left = 144
    Top = 24
  end
  object selSG706: TOracleDataSet
    SQL.Strings = (
      
        'select sg706.*, SG706.ROWID, t030.cognome || '#39' '#39' || t030.nome ||' +
        ' '#39' ('#39' || t030.matricola || '#39')'#39' VALUTATORE'
      'from sg706_valutatori_dipendente SG706, t030_anagrafico t030'
      'where sg706.progressivo = t030.progressivo'
      
        '  and to_date('#39'31/12/'#39'||:anno,'#39'dd/mm/yyyy'#39') between sg706.decorr' +
        'enza and sg706.decorrenza_fine'
      'order by sg706.progressivo'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 408
    Top = 25
  end
  object selT768: TOracleDataSet
    SQL.Strings = (
      
        'select t768.*, t768.rowid, minutiore(oreminuti(numore_accettate)' +
        ' + oreminuti(nvl(numore_extra,'#39'00.00'#39'))) numore_totali,'
      '  t030.cognome, t030.nome, t030.matricola'
      'from t768_IncquantIndividuali t768, t030_anagrafico t030'
      'where anno = :ANNO'
      '  and codgruppo = :CODICE'
      '  and codtipoquota = :CODQUOTA'
      '  and t768.progressivo = t030.progressivo'
      
        'order by dato1, dato2, dato3, t030.cognome, t030.nome, t030.matr' +
        'icola')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000120000003A0043004F004400510055004F005400410005000000
      00000000000000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001A0000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      0100000000000E00000043004F0047004E004F004D0045000100000000000800
      00004E004F004D004500010000000000120000004D0041005400520049004300
      4F004C0041000100000000000800000041004E004E004F000100000000001800
      000046004C004500530053004900420049004C00490054004100010000000000
      200000004E0055004D004F00520045005F004100430043004500540054004100
      540045000100000000002000000054004F00540041004C0045005F0041004300
      4300450054005400410054004F000100000000001A0000004E0055004D004F00
      520045005F005000410047004100540045000100000000001C00000049004D00
      50004F00520054004F005F004F0052004100520049004F000100000000002000
      00004E0055004D004F00520045005F00410053005300450047004E0041005400
      45000100000000002000000054004F00540041004C0045005F00410053005300
      450047004E00410054004F000100000000001000000050004100520054005400
      49004D0045000100000000001400000043004F004E004600450052004D004100
      54004F00010000000000080000004E004F00540045000100000000000A000000
      4400410054004F0031000100000000000A0000004400410054004F0032000100
      000000000A0000004400410054004F0033000100000000001800000054004F00
      5400510055004F00540041005100550041004C000100000000001A0000004900
      4E0046005F004F00420049004500540054004900560049000100000000002400
      00004100430043004500540054005F00560041004C005500540041005A004900
      4F004E00450001000000000014000000560041004C0055005400410054004F00
      52004500010000000000180000004E0055004D004F00520045005F0045005800
      5400520041000100000000001A0000004E0055004D004F00520045005F005400
      4F00540041004C004900010000000000}
    Left = 36
    Top = 24
    object selT768ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
    end
    object selT768CODGRUPPO: TStringField
      FieldName = 'CODGRUPPO'
      Required = True
      Size = 10
    end
    object selT768CODTIPOQUOTA: TStringField
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selT768PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selT768MATRICOLA: TStringField
      DisplayLabel = 'Matr.'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT768COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object selT768NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object selT768PARTTIME: TFloatField
      DisplayLabel = '% PT'
      FieldName = 'PARTTIME'
    end
    object selT768FLESSIBILITA: TStringField
      DisplayLabel = 'Flessibilit'#224
      FieldName = 'FLESSIBILITA'
      Size = 100
    end
    object selT768IMPORTO_ORARIO: TFloatField
      DisplayLabel = 'Imp.orario'
      FieldName = 'IMPORTO_ORARIO'
      DisplayFormat = '###,###,###,##0.##'
    end
    object selT768NUMORE_ASSEGNATE: TStringField
      DisplayLabel = 'Ore assegn.'
      FieldName = 'NUMORE_ASSEGNATE'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT768TOTALE_ASSEGNATO: TFloatField
      DisplayLabel = 'Tot.assegn.'
      FieldName = 'TOTALE_ASSEGNATO'
      DisplayFormat = '###,###,###,##0.##'
    end
    object selT768NUMORE_ACCETTATE: TStringField
      DisplayLabel = 'Ore accett.'
      FieldName = 'NUMORE_ACCETTATE'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT768TOTALE_ACCETTATO: TFloatField
      DisplayLabel = 'Tot.accett.'
      FieldName = 'TOTALE_ACCETTATO'
      DisplayFormat = '###,###,###,##0.##'
    end
    object selT768CONFERMATO: TStringField
      DisplayLabel = 'Conf.'
      FieldName = 'CONFERMATO'
      Size = 1
    end
    object selT768NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 1000
    end
    object selT768DATO1: TStringField
      FieldName = 'DATO1'
    end
    object selT768DATO2: TStringField
      FieldName = 'DATO2'
    end
    object selT768DATO3: TStringField
      FieldName = 'DATO3'
    end
    object selT768INF_OBIETTIVI: TStringField
      FieldName = 'INF_OBIETTIVI'
      Size = 1
    end
    object selT768ACCETT_VALUTAZIONE: TStringField
      FieldName = 'ACCETT_VALUTAZIONE'
      Size = 1
    end
    object selT768NUMORE_EXTRA: TStringField
      DisplayLabel = 'Ore extra budget'
      FieldName = 'NUMORE_EXTRA'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT768NUMORE_TOTALI: TStringField
      DisplayLabel = 'Ore totali'
      DisplayWidth = 20
      FieldName = 'NUMORE_TOTALI'
      Size = 4000
    end
  end
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 500
    Top = 152
  end
  object selDato2: TOracleDataSet
    Optimize = False
    Left = 545
    Top = 152
  end
  object selDato3: TOracleDataSet
    Optimize = False
    Left = 593
    Top = 152
  end
  object dsrT768: TDataSource
    DataSet = selDato1
    Left = 88
    Top = 80
  end
  object selValutatori: TOracleDataSet
    SQL.Strings = (
      
        'select distinct t030.cognome || '#39' '#39' || t030.nome || '#39' ('#39' || t030' +
        '.matricola || '#39')'#39' VALUTATORE, t030.progressivo'
      'from t030_anagrafico t030,'
      '     mondoedp.i060_login_dipendente i060, '
      '     mondoedp.i061_profili_dipendente i061,'
      '     mondoedp.i071_permessi i071'
      'where t030.matricola = i060.matricola'
      'and i060.azienda = :AZIENDA '
      'and i061.azienda = i060.azienda'
      'and i061.nome_utente = i060.nome_utente'
      'and :DATA between i061.inizio_validita and i061.fine_validita'
      'and i071.azienda = i061.azienda'
      'and i071.profilo = i061.permessi'
      'and i071.s710_stati_abilitati is not null'
      'and i071.s710_supervisorevalut = '#39'N'#39
      'UNION'
      'select '#39' '#39' VALUTATORE, 0 progressivo'
      'from dual'
      'order by 1'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 204
    Top = 25
  end
  object dsrValutatori: TDataSource
    Left = 204
    Top = 84
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select t030.progressivo, t030.matricola, t030.cognome, t030.nome' +
        ', '
      '       NVL(T460.INCENTIVI,100) PARTTIME, :PROFILO'
      'from t030_anagrafico t030, v430_storico v430, t460_parttime t460'
      'where t030.progressivo = V430.t430progressivo'
      '  and V430.t430parttime = t460.codice (+)'
      
        '  and :DATARIF between v430.t430datadecorrenza and v430.t430data' +
        'fine '
      
        '  and :DATARIF between v430.t430inizio and nvl(v430.t430fine,to_' +
        'date('#39'31123999'#39','#39'ddmmyyyy'#39')) '
      '  and :filtro'
      'order by cognome, nome, matricola')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A00460049004C00540052004F00010000000000
      000000000000100000003A0044004100540041005200490046000C0000000000
      000000000000100000003A00500052004F00460049004C004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 312
    Top = 28
  end
  object selT770: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from T770_QUOTE T770'
      ' where DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and CODTIPOQUOTA = :QUOTA'
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
      4400410054004F0033000500000000000000000000000C0000003A0051005500
      4F0054004100050000000000000000000000}
    Left = 264
    Top = 24
  end
  object ControlloT768: TOracleDataSet
    SQL.Strings = (
      'select CODGRUPPO'
      '  from t768_incquantindividuali'
      'where anno = :anno'
      '  and codtipoquota = :quota'
      '  and codgruppo <> :gruppo'
      '  and progressivo = :prog')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0A0000003A00500052004F0047000300000000000000000000000C0000003A00
      510055004F0054004100050000000000000000000000}
    Left = 40
    Top = 144
  end
  object ControlloT040: TOracleDataSet
    SQL.Strings = (
      'select t040.causale'
      '  from t040_giustificativi t040, t265_cauassenze t265'
      'where t040.progressivo = :prog'
      '  and t040.data = :data'
      '  and t040.causale = t265.codice'
      '  and t265.periodo_lungo = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    Left = 112
    Top = 144
  end
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select perc'
      'from sg735_punteggifasce_incentivi'
      'where tipologia = '#39'I'#39
      '  and codquota = :quota'
      '  and flessibilita = '#39'*'#39
      '  and :datarif between decorrenza and decorrenza_fine'
      '  and :parttime between punteggio_da and punteggio_a'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00510055004F00540041000500000000000000
      00000000100000003A0044004100540041005200490046000C00000000000000
      00000000120000003A005000410052005400540049004D004500040000000000
      000000000000}
    Left = 476
    Top = 25
  end
  object updT767: TOracleQuery
    SQL.Strings = (
      'update t767_incquantgruppo'
      'set importo_totale = :IMP, numore_totale = :ORE'
      'where anno = :ANNO'
      '  and codgruppo = :GRUPPO'
      '  and codtipoquota = :QUOTA')
    Optimize = False
    Variables.Data = {
      0400000005000000080000003A0049004D005000040000000000000000000000
      080000003A004F00520045000500000000000000000000000A0000003A004100
      4E004E004F000300000000000000000000000E0000003A004700520055005000
      50004F000500000000000000000000000C0000003A00510055004F0054004100
      050000000000000000000000}
    Left = 40
    Top = 200
  end
  object delT768: TOracleQuery
    SQL.Strings = (
      'delete '
      '  from T768_INCQUANTINDIVIDUALI'
      ' where anno = :ANNO'
      '  and codgruppo = :CODICE'
      '  and codtipoquota = :CODQUOTA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A0043004F004400490043004500050000000000000000000000
      120000003A0043004F004400510055004F005400410005000000000000000000
      0000}
    Left = 37
    Top = 80
  end
  object CambioValutatore: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  w_decorrenza DATE;'
      '  w_decorrenza_fine DATE;'
      'BEGIN'
      '  BEGIN'
      '    SELECT DECORRENZA, DECORRENZA_FINE'
      '    INTO w_decorrenza, w_decorrenza_fine'
      '    FROM SG706_VALUTATORI_DIPENDENTE'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE;'
      '  EXCEPTION'
      '    WHEN NO_DATA_FOUND THEN'
      '      w_decorrenza:=null;'
      '      w_decorrenza_fine:=null;'
      '  END;'
      ''
      
        '  IF TO_CHAR(w_decorrenza,'#39'YYYY'#39') = TO_CHAR(w_decorrenza_fine,'#39'Y' +
        'YYY'#39') THEN'
      '    DELETE SG706_VALUTATORI_DIPENDENTE'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE;'
      
        '  ELSIF TO_CHAR(w_decorrenza,'#39'YYYY'#39') = TO_CHAR(:DATA,'#39'YYYY'#39') THE' +
        'N'
      '    UPDATE SG706_VALUTATORI_DIPENDENTE'
      '    SET DECORRENZA = :DATA + 1'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE;'
      
        '  ELSIF TO_CHAR(w_decorrenza_fine,'#39'YYYY'#39') = TO_CHAR(:DATA,'#39'YYYY'#39 +
        ') THEN'
      '    UPDATE SG706_VALUTATORI_DIPENDENTE'
      '    SET DECORRENZA_FINE = TRUNC(:DATA,'#39'YYYY'#39') - 1'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE;'
      '  ELSIF TO_CHAR(w_decorrenza,'#39'YYYY'#39') < TO_CHAR(:DATA,'#39'YYYY'#39')'
      
        '  AND TO_CHAR(w_decorrenza_fine,'#39'YYYY'#39') > TO_CHAR(:DATA,'#39'YYYY'#39') ' +
        'THEN'
      '    UPDATE SG706_VALUTATORI_DIPENDENTE'
      '    SET DECORRENZA_FINE = TRUNC(:DATA,'#39'YYYY'#39') - 1'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      '    AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE;'
      '    INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '    (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VALUT' +
        'ATO)'
      
        '    SELECT PROGRESSIVO, :DATA + 1, w_decorrenza_fine, PROGRESSIV' +
        'O_VALUTATO'
      '    FROM SG706_VALUTATORI_DIPENDENTE'
      '    WHERE PROGRESSIVO_VALUTATO = :PROGRESSIVO_VALUTATO'
      
        '    AND TRUNC(:DATA,'#39'YYYY'#39') - 1 BETWEEN DECORRENZA AND DECORRENZ' +
        'A_FINE;'
      '  END IF;'
      ''
      '  IF :PROGRESSIVO_VALUTATORE <> 0 THEN'
      '    INSERT INTO SG706_VALUTATORI_DIPENDENTE'
      
        '    (PROGRESSIVO, DECORRENZA, DECORRENZA_FINE, PROGRESSIVO_VALUT' +
        'ATO)'
      '    VALUES'
      
        '    (:PROGRESSIVO_VALUTATORE, TRUNC(:DATA,'#39'YYYY'#39'), :DATA, :PROGR' +
        'ESSIVO_VALUTATO);'
      '  END IF;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000030000002A0000003A00500052004F00470052004500530053004900
      56004F005F00560041004C0055005400410054004F0003000000000000000000
      00002E0000003A00500052004F0047005200450053005300490056004F005F00
      560041004C0055005400410054004F0052004500030000000000000000000000
      0A0000003A0044004100540041000C0000000000000000000000}
    Left = 113
    Top = 200
  end
  object selSG715: TOracleDataSet
    SQL.Strings = (
      'SELECT SG715.*, SG715.ROWID '
      'FROM SG715_VALUT_POSIZIONATI SG715'
      'WHERE ANNO = :ANNO'
      '  AND PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    BeforePost = selSG715BeforePost
    OnNewRecord = selSG715NewRecord
    Left = 544
    Top = 25
  end
end
