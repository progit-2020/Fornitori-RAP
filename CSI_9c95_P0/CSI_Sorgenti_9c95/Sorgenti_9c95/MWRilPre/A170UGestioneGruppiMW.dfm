inherited A170FGestioneGruppiMW: TA170FGestioneGruppiMW
  OldCreateOrder = True
  Height = 271
  Width = 510
  object selT773: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from T773_pesaturegruppo T773'
      'where T773.anno = :ANNO'
      '  and T773.codtipoquota = :CODQUOTA'
      '  :FILTRO'
      'order by codgruppo')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000
      120000003A0043004F004400510055004F005400410005000000000000000000
      0000}
    Left = 120
    Top = 24
  end
  object selT773Quote: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT CODTIPOQUOTA, T765.DESCRIZIONE'
      'from T773_pesaturegruppo T773, T765_tipoquote T765'
      'where t773.codtipoquota = T765.codice'
      
        '  and T765.decorrenza = (select max(decorrenza) from t765_tipoqu' +
        'ote'
      '                          where codice = T765.codice'
      '                            and decorrenza <= T773.datarif)'
      '  and T773.anno = :ANNO'
      'order by CODTIPOQUOTA, T765.DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000001800000043004F0044005400490050004F00510055004F00
      54004100010000000000160000004400450053004300520049005A0049004F00
      4E004500010000000000}
    Left = 32
    Top = 24
  end
  object selT767Quote: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT CODTIPOQUOTA, T765.DESCRIZIONE'
      'from T767_incquantgruppo T767, T765_tipoquote T765'
      'where t767.codtipoquota = T765.codice'
      
        '  and T765.decorrenza = (select max(decorrenza) from t765_tipoqu' +
        'ote'
      '                          where codice = T765.codice'
      '                            and decorrenza <= T767.datarif)'
      'order by CODTIPOQUOTA, T765.DESCRIZIONE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001800000043004F0044005400490050004F00510055004F00
      54004100010000000000160000004400450053004300520049005A0049004F00
      4E004500010000000000}
    Left = 32
    Top = 86
  end
  object selT767: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from T767_incquantgruppo T767'
      'where T767.anno = :ANNO'
      '  and T767.codtipoquota = :CODQUOTA'
      '  :FILTRO'
      'order by codgruppo')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000
      120000003A0043004F004400510055004F005400410005000000000000000000
      0000}
    Left = 116
    Top = 86
  end
  object updT773: TOracleQuery
    SQL.Strings = (
      'update T773_PESATUREGRUPPO '
      'set chiuso = :STATO'
      'where anno = :ANNO'
      'and codtipoquota = :CODQUOTA'
      'and codgruppo in (:GRUPPI)')
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A0053005400410054004F000500000000000000
      000000000A0000003A0041004E004E004F000300000000000000000000000E00
      00003A0047005200550050005000490001000000000000000000000012000000
      3A0043004F004400510055004F0054004100050000000000000000000000}
    Left = 248
    Top = 92
  end
  object selT774: TOracleDataSet
    SQL.Strings = (
      'select t774.*, t774.rowid'
      'from t774_pesatureIndividuali t774'
      'where anno = :ANNO'
      '  and codgruppo = :CODICE'
      '  and codtipoquota = :CODQUOTA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000120000003A0043004F004400510055004F005400410005000000
      00000000000000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000200000005000450053004F005F0049004E004400490056004900
      4400550041004C0045000100000000001C0000005000450053004F005F004300
      41004C0043004F004C00410054004F0001000000000022000000510055004F00
      540041005F0049004E0044004900560049004400550041004C00450001000000
      00001E000000510055004F00540041005F00430041004C0043004F004C004100
      540041000100000000000E00000043004F0047004E004F004D00450001000000
      0000080000004E004F004D004500010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000470047005F00530045005200
      560049005A0049004F000100000000000800000041004E004E004F0001000000
      000014000000440041005400410049004E0049005A0049004F00010000000000
      100000004400410054004100460049004E0045000100000000001E0000005100
      55004F00540041005F00410053005300450047004E0041005400410001000000
      0000060000004F004E004100010000000000}
    Left = 180
    Top = 24
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, matricola, cognome, nome, MIN(DATAINIZIO) DA' +
        'TAINIZIO, MAX(DATAFINE) DATAFINE, sum(ggservizio) ggservizio'
      'from ('
      
        'select DISTINCT t030.progressivo, t030.matricola, t030.cognome, ' +
        't030.nome, '
      '       T430INIZIO,T430FINE,'
      
        '      greatest(greatest(t430inizio,t430datadecorrenza),:datainiz' +
        'io) DATAINIZIO,'
      
        '      least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),t' +
        '430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'DD' +
        '/MM/YYYY'#39')) DATAFINE,'
      
        '       least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),' +
        't430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'D' +
        'D/MM/YYYY'#39')) - '
      
        '         greatest(greatest(t430inizio,t430datadecorrenza),:datai' +
        'nizio) + 1 ggservizio'
      'from t030_anagrafico t030, v430_storico v430'
      'where t030.progressivo = V430.t430progressivo'
      
        '  and v430.t430datadecorrenza <= TO_DATE('#39'31/12/'#39' || TO_CHAR(:DA' +
        'TAINIZIO,'#39'YYYY'#39'),'#39'DD/MM/YYYY'#39')'
      '  and v430.t430datafine >= :DATAINIZIO'
      '  and v430.t430inizio <= :DATAFINE'
      
        '  and nvl(v430.t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) >= :DATA' +
        'INIZIO'
      '  and :filtro'
      
        '  AND least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),t' +
        '430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'DD' +
        '/MM/YYYY'#39')) - '
      
        '      greatest(greatest(t430inizio,t430datadecorrenza),:datainiz' +
        'io) + 1 > 0'
      ')'
      'group by progressivo, matricola, cognome, nome'
      'order by cognome, nome, matricola')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004400410054004100460049004E0045000C00
      00000000000000000000160000003A00440041005400410049004E0049005A00
      49004F000C00000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 248
    Top = 24
  end
  object ControlloT774: TOracleDataSet
    SQL.Strings = (
      'select CODGRUPPO'
      '  from t774_pesatureindividuali'
      'where anno = :anno'
      '  and codgruppo <> :gruppo'
      '  and progressivo = :prog'
      '  and datainizio <= :fine'
      '  and datafine >= :inizio')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0A0000003A00500052004F0047000300000000000000000000000A0000003A00
      460049004E0045000C00000000000000000000000E0000003A0049004E004900
      5A0049004F000C0000000000000000000000}
    Left = 181
    Top = 76
  end
  object updT767: TOracleQuery
    SQL.Strings = (
      'update T767_INCQUANTGRUPPO '
      'set STATO = :STATO'
      'where anno = :ANNO'
      'and codtipoquota = :CODQUOTA'
      'and codgruppo in (:GRUPPI)')
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A0053005400410054004F000500000000000000
      000000000A0000003A0041004E004E004F000300000000000000000000000E00
      00003A0047005200550050005000490001000000000000000000000012000000
      3A0043004F004400510055004F0054004100050000000000000000000000}
    Left = 112
    Top = 142
  end
  object selT768: TOracleDataSet
    SQL.Strings = (
      'select t768.*, t768.rowid'
      'from t768_incquantindividuali t768'
      'where anno = :ANNO'
      '  and codgruppo = :CODICE'
      '  and codtipoquota = :CODQUOTA'
      '  and confermato = '#39'N'#39)
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000120000003A0043004F004400510055004F005400410005000000
      00000000000000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000200000005000450053004F005F0049004E004400490056004900
      4400550041004C0045000100000000001C0000005000450053004F005F004300
      41004C0043004F004C00410054004F0001000000000022000000510055004F00
      540041005F0049004E0044004900560049004400550041004C00450001000000
      00001E000000510055004F00540041005F00430041004C0043004F004C004100
      540041000100000000000E00000043004F0047004E004F004D00450001000000
      0000080000004E004F004D004500010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000470047005F00530045005200
      560049005A0049004F000100000000000800000041004E004E004F0001000000
      000014000000440041005400410049004E0049005A0049004F00010000000000
      100000004400410054004100460049004E0045000100000000001E0000005100
      55004F00540041005F00410053005300450047004E0041005400410001000000
      0000060000004F004E004100010000000000}
    Left = 178
    Top = 131
  end
  object selV430ScInd: TOracleDataSet
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
      000000000000100000003A00500052004F00460049004C004F00010000000000
      000000000000100000003A0044004100540041005200490046000C0000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 248
    Top = 150
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
    Left = 324
    Top = 30
  end
  object ControlloT768: TOracleDataSet
    SQL.Strings = (
      'select CODGRUPPO'
      '  from t768_incquantindividuali'
      'where anno = :anno'
      '  and codtipoquota = :quota'
      '  and ((codgruppo <> :gruppo and progressivo = :prog)'
      
        '   or (codgruppo = :gruppo and progressivo = :prog and confermat' +
        'o = '#39'S'#39'))'
      ''
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0A0000003A00500052004F0047000300000000000000000000000C0000003A00
      510055004F0054004100050000000000000000000000}
    Left = 177
    Top = 187
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
    Left = 248
    Top = 211
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
    Left = 324
    Top = 92
  end
  object updT767Tot: TOracleQuery
    SQL.Strings = (
      'update t767_incquantgruppo'
      'set importo_totale = :IMP, numore_totale = :ORE'
      'where anno = :ANNO'
      '  and codgruppo = :GRUPPO'
      '  and codtipoquota = :QUOTA')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0041004E004E004F0003000000000000000000
      0000080000003A0049004D005000040000000000000000000000080000003A00
      4F00520045000500000000000000000000000E0000003A004700520055005000
      50004F000500000000000000000000000C0000003A00510055004F0054004100
      050000000000000000000000}
    Left = 104
    Top = 199
  end
  object selT767New: TOracleDataSet
    SQL.Strings = (
      'select T767.*,T767.ROWID'
      'from T767_incquantgruppo T767'
      'where T767.anno = :ANNO'
      '  and T767.codtipoquota = :CODQUOTA'
      'order by codgruppo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000120000003A0043004F004400510055004F00540041000500000000000000
      00000000}
    Left = 324
    Top = 207
  end
  object delT767: TOracleQuery
    SQL.Strings = (
      'delete from t767_incquantgruppo t'
      'WHERE ANNO = :ANNO and codtipoquota = :CODQUOTA and STATO <> '#39'C'#39
      
        'and codgruppo not in (select codgruppo from t768_incquantindivid' +
        'uali where anno = :ANNO AND codtipoquota = :CODQUOTA)')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000120000003A0043004F004400510055004F00540041000500000000000000
      00000000}
    Left = 328
    Top = 160
  end
end
