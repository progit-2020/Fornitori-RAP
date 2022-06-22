inherited A151FAssenteismoMW: TA151FAssenteismoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 309
  Width = 695
  object selSG101: TOracleDataSet
    SQL.Strings = (
      'select sg101.*, '
      '       t480.codcatastale || '#39'-'#39' || rtrim(t480.citta) comnasfam,'
      '       t480r.codcatastale || '#39'-'#39' || rtrim(t480r.citta) comresfam'
      
        'from sg101_familiari sg101, t480_comuni t480, t480_comuni t480r,' +
        ' t430_storico t430'
      'where sg101.progressivo = :PROG'
      
        '  and ((:ADOZ = '#39'S'#39' and dataadoz = :DATAADOZ) or (:ADOZ = '#39'N'#39' an' +
        'd datanas = :DATANAS))'
      '  and :DATARIF between decorrenza and decorrenza_fine'
      '  and sg101.comnas = t480.codice (+)'
      '  and sg101.comune = t480r.codice (+)'
      '  and sg101.progressivo = t430.progressivo'
      '  and :DATARIF between datadecorrenza and datafine')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00500052004F00470003000000000000000000
      0000100000003A0044004100540041005200490046000C000000000000000000
      0000100000003A0044004100540041004E00410053000C000000000000000000
      00000A0000003A00410044004F005A0005000000000000000000000012000000
      3A004400410054004100410044004F005A000C0000000000000000000000}
    Left = 120
    Top = 24
  end
  object selT910: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, TITOLO, '#39'T920'#39' || TABELLA_GENERATA TABELLA from t' +
        '910_riepilogo t'
      'where TABELLA_GENERATA is not null'
      '  and APPLICAZIONE = :APPLICAZIONE'
      'order by CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 207
    Top = 24
  end
  object selT255: TOracleDataSet
    SQL.Strings = (
      'select * from t255_tipoaccorpcausali'
      'order by cod_tipoaccorpcausali')
    Optimize = False
    Left = 288
    Top = 24
  end
  object selT256: TOracleDataSet
    SQL.Strings = (
      'select * from t256_codiciaccorpcausali'
      'where cod_tipoaccorpcausali = :TIPO'
      'order by cod_codiciaccorpcausali')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A005400490050004F0005000000000000000000
      0000}
    Left = 344
    Top = 24
  end
  object dsrT910: TDataSource
    DataSet = selT910
    Left = 208
    Top = 80
  end
  object dsrT255: TDataSource
    DataSet = selT255
    Left = 288
    Top = 80
  end
  object selRighe: TOracleDataSet
    SQL.Strings = (
      'select COLUMN_NAME DATOANAG '
      '  from cols '
      ' where table_name = :TABELLA'
      '   and ((substr(column_name,1,4) in ('#39'T430'#39','#39'P430'#39')'
      
        '   and column_name not in ('#39'T430PROGRESSIVO'#39','#39'T430DATADECORRENZA' +
        #39','#39'T430DATAFINE'#39','
      
        '                           '#39'P430PROGRESSIVO'#39','#39'P430DECORRENZA'#39','#39'P' +
        '430DECORRENZA_FINE'#39'))'
      '    or column_name IN('#39'SESSO'#39','#39'DATANAS'#39','#39'COMUNENAS'#39'))'
      'order by COLUMN_NAME')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410005000000
      0000000000000000}
    Left = 408
    Top = 24
  end
  object selT920Ass: TOracleDataSet
    SQL.Strings = (
      
        'select T920.DATACONTEGGIO, T257.cod_tipoaccorpcausali, T257.cod_' +
        'codiciaccorpcausali, '
      
        '       T920.assenzaorerese ASSRESE, T920.assenzagiornate ASSGIOR' +
        'N, T920.ASSENZAUMFRUIZIONE,'
      
        '       T920.DC_GGLAVORATIVO, T920.ASSENZADATAFAMILIARE, T920.ASS' +
        'ENZADATAFAMILIARE, T920.ASSENZACAUSALE'
      '  from :TABELLA T920, T257_ACCORPCAUSALI T257'
      ' where T920.progressivo = :PROGRESSIVO'
      '   and T920.dataconteggio between :DADATA and :ADATA'
      '   and T920.assenzacausale = T257.cod_causale'
      
        '   and T920.dataconteggio between T257.decorrenza and T257.decor' +
        'renza_fine'
      '   and T257.cod_tipoaccorpcausali = :TIPOACCORP'
      '   and T920.ASSENZAUMFRUIZIONE IN (:UM)'
      'order by T920.DATACONTEGGIO, T920.DC_GGLAVORATIVO DESC')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A0054004100420045004C004C00410001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000160000003A005400490050004F004100430043004F00
      52005000050000000000000000000000060000003A0055004D00010000000000
      000000000000}
    Left = 536
    Top = 24
  end
  object selDebitoGGQM: TOracleQuery
    SQL.Strings = (
      'select DEBITOGGQM from T470_QUALIFICAMINIST'
      'where CODICE = (select QUALIFICAMINIST from T430_STORICO'
      '                 where PROGRESSIVO = :PROGRESSIVO'
      
        '                   and :DATA between DATADECORRENZA and DATAFINE' +
        ')'
      '  and :DATA between DECORRENZA and DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 616
    Top = 24
  end
  object selT920AssGG: TOracleQuery
    SQL.Strings = (
      
        'select T920.DC_GGLAVORATIVO, NVL(OREMINUTI(T920.DEBITOSETTIMANAL' +
        'E),0) DEBSETT, NVL(T920.GIORNILAVORATIVI,0) GGLAV, NVL(T920.DC_O' +
        'REDEBITO,0) DEBITOGG'
      '  from :TABELLA T920'
      ' where T920.progressivo = :PROGRESSIVO'
      '   and T920.dataconteggio = :DATA'
      '   and gglavorativo is not null')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A0054004100420045004C004C0041000100
      00000C00000054393230415353505245530000000000}
    Left = 616
    Top = 80
  end
  object selT920: TOracleDataSet
    SQL.Strings = (
      'select :DATI'
      '  from :TABELLA T920'
      ' where T920.progressivo = :PROGRESSIVO'
      '   and T920.dataconteggio between :DADATA and :ADATA'
      '       :GGLAV')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A0054004100420045004C004C00410001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      000000000000000000000A0000003A0044004100540049000100000000000000
      000000000C0000003A00470047004C0041005600010000000000000000000000}
    Left = 536
    Top = 80
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'select distinct t040.data '
      '  from T040_GIUSTIFICATIVI T040, T257_ACCORPCAUSALI T257'
      ' where T040.progressivo = :PROGRESSIVO'
      '   and T040.data between :DADATA and :ADATA'
      '   and T040.causale = T257.cod_causale'
      
        '   and T040.data between T257.decorrenza and T257.decorrenza_fin' +
        'e'
      '   and T257.cod_tipoaccorpcausali = :TIPOACCORP'
      '   and T257.cod_codiciaccorpcausali = :CODACCORP'
      '   and T040.TIPOGIUST = '#39'I'#39
      ':ORDINAMENTO'
      '')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000160000003A005400490050004F004100430043004F00
      52005000050000000000000000000000140000003A0043004F00440041004300
      43004F0052005000050000000000000000000000180000003A004F0052004400
      49004E0041004D0045004E0054004F00010000000000000000000000}
    Left = 408
    Top = 80
  end
  object selT909: TOracleDataSet
    SQL.Strings = (
      'select T909.ESPRESSIONE'
      '  from T909_DATICALCOLATI T909'
      ' where T909.APPLICAZIONE = '#39'RILPRE'#39
      '   and T909.NOME = :NOME'
      ' order by T909.NOME')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 151
    Top = 81
  end
  object selT911: TOracleDataSet
    SQL.Strings = (
      'select T911.CODICE, T911.NOME, T911.CAPTION'
      '  from T911_DATIRIEPILOGO T911'
      ' where T911.CODICE = :COD_STAMPA'
      ' order by T911.NOME')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F0044005F005300540041004D005000
      4100050000000000000000000000}
    Left = 99
    Top = 81
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'SELECT T430PROGRESSIVO PROGRESSIVO, :Gruppo GRUPPO, '
      '       :Dettaglio,'
      
        '       GREATEST(GREATEST(T430DATADECORRENZA,T430INIZIO), :C700Da' +
        'taDal) DEC,'
      
        '       LEAST(LEAST(T430DATAFINE,NVL(T430FINE,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39'))), :DataLavoro) FINE,'
      
        '       LEAST(LEAST(T430DATAFINE,NVL(T430FINE,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39'))), :DataLavoro) - '
      
        '         GREATEST(GREATEST(T430DATADECORRENZA,T430INIZIO), :C700' +
        'DataDal) + 1 GG,'
      '       T460.PIANTA PT'
      
        '  FROM T460_PARTTIME T460, T030_ANAGRAFICO T030, V430_STORICO V4' +
        '30, T480_COMUNI T480'
      ' WHERE T030.PROGRESSIVO = V430.T430PROGRESSIVO'
      '   AND V430.T430DATADECORRENZA <= :DataLavoro'
      '   AND V430.T430DATAFINE >= :C700DataDal'
      '   AND V430.T430INIZIO <= :DataLavoro'
      
        '   AND NVL(V430.T430FINE,TO_DATE('#39'31/12/3999'#39','#39'DD/MM/YYYY'#39')) >= ' +
        ':C700DataDal'
      '   AND V430.T430PARTTIME = T460.CODICE (+)'
      '   AND T030.TIPO_PERSONALE = '#39'I'#39
      '      :FILTROC700'
      ' GROUP BY T430PROGRESSIVO, :Gruppo, '
      
        '          :Dettaglio2, T430DATADECORRENZA, T430INIZIO, T430DATAF' +
        'INE, T430FINE, T460.PIANTA'
      
        ' HAVING LEAST(LEAST(T430DATAFINE,NVL(T430FINE,TO_DATE('#39'31123999'#39 +
        ','#39'DDMMYYYY'#39'))), :DataLavoro) - '
      
        '        GREATEST(GREATEST(T430DATADECORRENZA,T430INIZIO), :C700D' +
        'ataDal) + 1  >= 0 '
      ' ORDER BY 1,2')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000006000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000160000003A00460049004C00540052004F00
      4300370030003000010000000000000000000000180000003A00430037003000
      30004400410054004100440041004C000C000000000000000000000014000000
      3A004400450054005400410047004C0049004F00010000000000000000000000
      160000003A004400450054005400410047004C0049004F003200010000000000
      0000000000000E0000003A00470052005500500050004F000100000000000000
      00000000}
    Left = 40
    Top = 81
  end
  object selSQL: TOracleDataSet
    ReadBuffer = 5000
    Optimize = False
    Left = 408
    Top = 136
  end
  object selI035: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT SUBSTR(RELAZIONE,INSTR(RELAZIONE,'#39'<#>'#39')+3, INSTR' +
        '(RELAZIONE,'#39'<#>'#39',10)-INSTR(RELAZIONE,'#39'<#>'#39')-3) CAMPO_RELAZIONATO'
      '  FROM I035_RELAZIONI_DETTAGLIO I035'
      ' WHERE I035.TABELLA = '#39'T430_STORICO'#39
      '   AND I035.COLONNA = :CAMPO'
      'ORDER BY CAMPO_RELAZIONATO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A00430041004D0050004F000500000000000000
      00000000}
    Left = 40
    Top = 251
  end
  object selI035Rel: TOracleDataSet
    SQL.Strings = (
      'SELECT RELAZIONE'
      '  FROM I035_RELAZIONI_DETTAGLIO I035'
      ' WHERE I035.TABELLA = '#39'T430_STORICO'#39
      '   AND I035.COLONNA = :CAMPO'
      
        '   AND SUBSTR(RELAZIONE,INSTR(RELAZIONE,'#39'<#>'#39')+3, INSTR(RELAZION' +
        'E,'#39'<#>'#39',10)-INSTR(RELAZIONE,'#39'<#>'#39')-3) = :CAMPO_RELAZIONATO')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A00430041004D0050004F000500000000000000
      00000000240000003A00430041004D0050004F005F00520045004C0041005A00
      49004F004E00410054004F00050000000000000000000000}
    Left = 112
    Top = 250
  end
  object dsrI010: TDataSource
    AutoEdit = False
    Left = 204
    Top = 249
  end
  object dsrI010B: TDataSource
    AutoEdit = False
    Left = 252
    Top = 250
  end
  object cdsTotale: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 206
    Top = 139
  end
  object cdsDettaglio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 278
    Top = 139
  end
  object XMLGenerato: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    ParseOptions = [poResolveExternals, poValidateOnParse]
    Left = 340
    Top = 248
    DOMVendorDesc = 'MSXML'
  end
  object cdsRisultato: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 38
    Top = 139
  end
  object dsrRisultato: TDataSource
    DataSet = cdsRisultato
    Left = 38
    Top = 195
  end
  object cdsRighe: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cdsRigheBeforeInsert
    BeforeDelete = cdsRigheBeforeDelete
    Left = 119
    Top = 139
  end
  object dsrRighe: TDataSource
    DataSet = cdsRighe
    Left = 119
    Top = 195
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select t480.codcatastale || '#39'-'#39' || rtrim(t480.citta) comresfam '
      ' from T030_ANAGRAFICO T030, T430_STORICO T430, T480_COMUNI T480'
      'where T030.PROGRESSIVO = T430.PROGRESSIVO'
      '  and T030.MATRICOLA = :MatrFam'
      '  and :DATARIF between DATADECORRENZA AND DATAFINE'
      '  and T430.COMUNE = T480.CODICE (+)')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041005200490046000C000000
      0000000000000000100000003A004D00410054005200460041004D0005000000
      0000000000000000}
    Left = 472
    Top = 136
  end
end
