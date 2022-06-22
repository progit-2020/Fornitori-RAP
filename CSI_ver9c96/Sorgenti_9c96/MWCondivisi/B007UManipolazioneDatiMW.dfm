inherited B007FManipolazioneDatiMW: TB007FManipolazioneDatiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 456
  Width = 699
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 151
    Top = 10
  end
  object cdsValori: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VALOREOLD'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'VALORENEW'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <
      item
        Name = 'selValoriInd'
        Fields = 'VALOREOLD'
        Options = [ixPrimary, ixUnique, ixDescending]
      end>
    IndexName = 'selValoriInd'
    Params = <>
    StoreDefs = True
    BeforePost = cdsValoriBeforePost
    Left = 19
    Top = 14
    object cdsValoriVALOREOLD: TStringField
      DisplayLabel = 'Valore esistente'
      FieldName = 'VALOREOLD'
      Size = 500
    end
    object cdsValoriVALORENEW: TStringField
      DisplayLabel = 'Nuovo valore'
      FieldName = 'VALORENEW'
      Size = 500
    end
  end
  object CreazioneStorico: TOracleQuery
    SQL.Strings = (
      'begin'
      '  CREAZIONE_STORICO(:PROGRESSIVO,:DADATA,:ADATA);  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 39
    Top = 206
  end
  object CreazioneStoricoStipendi: TOracleQuery
    SQL.Strings = (
      'begin'
      '  CREAZIONE_STORICO_STIPENDI(:PROGRESSIVO,:DADATA,:ADATA);  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 149
    Top = 206
  end
  object updT430: TOracleQuery
    SQL.Strings = (
      'UPDATE T430_STORICO T430'
      'SET :SET'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  DATADECORRENZA >= :DATADECORRENZA AND '
      '  DATAFINE <= :DATAFINE '
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A00530045005400010000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      00000000000000001E0000003A0044004100540041004400450043004F005200
      520045004E005A0041000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 28
    Top = 256
  end
  object updP430: TOracleQuery
    SQL.Strings = (
      'UPDATE P430_ANAGRAFICO P430'
      'SET :SET'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  DECORRENZA >= :DATADECORRENZA AND '
      '  DECORRENZA_FINE <= :DATAFINE '
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A00530045005400010000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      00000000000000001E0000003A0044004100540041004400450043004F005200
      520045004E005A0041000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 86
    Top = 256
  end
  object AllineaPeriodiStorici: TOracleQuery
    SQL.Strings = (
      'begin'
      '  ALLINEA_PERIODI_STORICI(:PROGRESSIVO,1,:Errore,:AGGLIBERA);  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000140000003A004100470047004C0049004200
      450052004100050000000000000000000000}
    Left = 156
    Top = 256
  end
  object AllineaPeriodiStipendi: TOracleQuery
    SQL.Strings = (
      'begin'
      '  ALLINEA_PERIODI_STIPENDI(:PROGRESSIVO,:Errore,'#39#39');  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000}
    Left = 260
    Top = 258
  end
  object insI020: TOracleQuery
    SQL.Strings = (
      'declare'
      '  CURSOR CI035 IS'
      '    select i030.tabella, i030.colonna, count(*)'
      '    from   i035_relazioni_dettaglio i035,'
      '           i030_relazioni_anagrafe i030'
      '    where  i035.relazione like '#39'%<#>'#39'||:COLONNA||'#39'<#>%'#39
      '    and    i030.tab_origine = :TABELLA'
      '    and    i030.tabella = i035.tabella'
      '    and    i030.colonna = i035.colonna'
      '    and    i030.decorrenza = i035.decorrenza'
      '    and    i030.tipo in ('#39'L'#39','#39'S'#39')'
      '    group by i030.tabella, i030.colonna'
      '    having count(*) > 0;'
      '  n_trov number := 0;'
      'begin'
      '  for RI035 in CI035 loop'
      '  begin'
      '    select count(*)'
      '    into  n_trov'
      '    from  i020_dati_allineamento'
      '    where tipo = '#39'R'#39
      '    and   tabella = RI035.TABELLA'
      '    and   colonna = RI035.COLONNA;'
      '    if n_trov = 0 then'
      '      insert into i020_dati_allineamento'
      '      (tipo,'
      '       tabella,'
      '       colonna,'
      '       valore)'
      '      values'
      '      ('#39'R'#39','
      '       RI035.TABELLA,'
      '       RI035.COLONNA,'
      '       null);'
      '    end if;'
      '  exception'
      '    when others then'
      '      null;'
      '  end;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410005000000
      0000000000000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000}
    Left = 28
    Top = 311
  end
  object QDProg: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T030_ANAGRAFICO'
      'WHERE PROGRESSIVO=:PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 248
    Top = 206
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'select distinct table_name TABELLA '
      '  from cols'
      ' where column_name = '#39'PROGRESSIVO'#39
      '   and substr(table_name,1,1) in ('#39'I'#39','#39'M'#39','#39'P'#39','#39'S'#39','#39'T'#39')'
      
        '   and table_name not in ('#39'T035_PROGRESSIVO'#39','#39'I070_UTENTI'#39','#39'I072' +
        '_FILTROANAGRAFE'#39','#39'I500_DATILIBERI'#39','#39'I006_MSGDATI'#39','
      
        '                          '#39'T221_PROFILISETTIMANA'#39','#39'T030_ANAGRAFI' +
        'CO'#39','#39'T031_DATACARTELLINO'#39','#39'T430_STORICO'#39', '#39'P430_ANAGRAFICO'#39')'
      '   and table_name not like ('#39'T920%'#39')')
    Optimize = False
    Left = 385
    Top = 8
  end
  object cdsDipendenti: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 64
  end
  object dsrDipendenti: TDataSource
    DataSet = cdsDipendenti
    Left = 190
    Top = 64
  end
  object selContaTabelle: TOracleQuery
    SQL.Strings = (
      'SELECT count(*) CONTA'
      '  FROM :TABELLA T'
      ' WHERE PROGRESSIVO = :PROG')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410001000000
      00000000000000000A0000003A00500052004F00470003000000000000000000
      0000}
    Left = 415
    Top = 256
  end
  object QBadget: TOracleDataSet
    SQL.Strings = (
      'select table_name'
      'from tabs'
      'where SUBSTR(TABLE_NAME,1,11)='#39'T712_BUDGET'#39)
    Optimize = False
    Left = 196
    Top = 10
  end
  object QDAnno: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T340_TURNIREPERIB'
      'WHERE ANNO  BETWEEN :DAANNO AND :AANNO')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410041004E004E004F00030000000000
      0000000000000C0000003A00410041004E004E004F0003000000000000000000
      0000}
    Left = 304
    Top = 206
  end
  object QDMeseAnno: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T340_TURNIREPERIB'
      'WHERE ANNO BETWEEN :DAANNO AND :AANNO AND'
      'MESE BETWEEN :DAMESE AND :AMESE')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A004400410041004E004E004F00030000000000
      0000000000000C0000003A00410041004E004E004F0003000000000000000000
      00000E0000003A00440041004D00450053004500030000000000000000000000
      0C0000003A0041004D00450053004500030000000000000000000000}
    Left = 412
    Top = 206
  end
  object QDData: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T012_CALENDINDIVID'
      'WHERE '
      'DATA>=:DADATA AND'
      'DATA < :ADATA + 1'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410044004100540041000C0000000000
      0000000000000C0000003A00410044004100540041000C000000000000000000
      0000}
    Left = 356
    Top = 206
  end
  object QDProgData: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T012_CALENDINDIVID'
      'WHERE '
      'DATA >= :DADATA AND'
      'DATA <= :ADATA + 1'
      'AND PROGRESSIVO=:PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410044004100540041000C0000000000
      0000000000000C0000003A00410044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 480
    Top = 206
  end
  object CancAssenze: TOracleQuery
    SQL.Strings = (
      'begin'
      '  cancassenze(:P, :D1, :D2, :C);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000040000003A00500003000000000000000000000006000000
      3A00440031000C0000000000000000000000060000003A00440032000C000000
      0000000000000000040000003A004300050000000000000000000000}
    Left = 488
    Top = 254
  end
  object QDProgMeseAnno: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T340_TURNIREPERIB'
      'WHERE PROGRESSIVO=:PROGRESSIVO and'
      'ANNO>=:DAANNO AND'
      'ANNO<=:AANNO AND'
      'MESE>=:DAMESE AND'
      'MESE<=:AMESE')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004400410041004E004E00
      4F000300000000000000000000000C0000003A00410041004E004E004F000300
      000000000000000000000E0000003A00440041004D0045005300450003000000
      00000000000000000C0000003A0041004D004500530045000300000000000000
      00000000}
    Left = 388
    Top = 94
  end
  object QDProgAnno: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T340_TURNIREPERIB'
      'WHERE PROGRESSIVO=:PROGRESSIVO AND '
      'ANNO>=:DAANNO AND'
      'ANNO<=:AANNO')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004400410041004E004E00
      4F000300000000000000000000000C0000003A00410041004E004E004F000300
      00000000000000000000}
    Left = 476
    Top = 94
  end
  object QDDaA: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T012_CALENDINDIVID'
      'WHERE DAL>=:DADATA AND'
      'AL < :ADATA + 1')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410044004100540041000C0000000000
      0000000000000C0000003A00410044004100540041000C000000000000000000
      0000}
    Left = 544
    Top = 206
  end
  object QDProgDaA: TOracleQuery
    SQL.Strings = (
      'DELETE'
      'FROM T012_CALENDINDIVID'
      'WHERE PROGRESSIVO=:PROGRESSIVO and'
      'DAL>=:DADATA AND'
      
        'AL<=TO_DATE(TO_CHAR(:ADATA,'#39'DD/MM/YYYY'#39')||'#39'2359'#39','#39'DD/MM/YYYYHH24' +
        'MI'#39')'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 548
    Top = 94
  end
  object selQ265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T265_CAUASSENZE'
      'order by codice'
      '')
    Optimize = False
    Left = 276
    Top = 10
  end
  object dsrQ265: TDataSource
    DataSet = selQ265
    Left = 320
    Top = 10
  end
  object selQ275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T275_CAUPRESENZE'
      'order by codice'
      '')
    Optimize = False
    Left = 276
    Top = 58
  end
  object dsrQ275: TDataSource
    DataSet = selQ275
    Left = 320
    Top = 58
  end
  object QRenCaus: TOracleQuery
    SQL.Strings = (
      'update /*+ FULL(T040_GIUSTIFICATIVI)*/'
      'T040_GIUSTIFICATIVI'
      'set causale = :newcausale'
      'WHERE '
      
        'DATA BETWEEN :DADATA AND TO_DATE(TO_CHAR(:ADATA,'#39'DD/MM/YYYY'#39')||'#39 +
        '2359'#39','#39'DD/MM/YYYYHH24MI'#39') '
      'and causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004E0045005700430041005500530041004C00
      45000500000000000000000000000E0000003A00440041004400410054004100
      0C00000000000000000000000C0000003A00410044004100540041000C000000
      0000000000000000160000003A004F004C004400430041005500530041004C00
      4500050000000000000000000000}
    Left = 156
    Top = 310
  end
  object QRenTimb: TOracleQuery
    SQL.Strings = (
      'update :tabella'
      'set causale = :newcausale'
      'WHERE '
      
        'DATA BETWEEN :DADATA AND TO_DATE(TO_CHAR(:ADATA,'#39'DD/MM/YYYY'#39')||'#39 +
        '2359'#39','#39'DD/MM/YYYYHH24MI'#39') '
      'and causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A004E0045005700430041005500530041004C00
      45000500000000000000000000000E0000003A00440041004400410054004100
      0C00000000000000000000000C0000003A00410044004100540041000C000000
      0000000000000000160000003A004F004C004400430041005500530041004C00
      4500050000000000000000000000100000003A0054004100420045004C004C00
      4100010000000000000000000000}
    Left = 220
    Top = 310
  end
  object QRenRes: TOracleQuery
    SQL.Strings = (
      'update T131_RESIDPRESENZE'
      'set causale = :newcausale'
      'WHERE '
      '(ANNO - 1) BETWEEN :DAANNO AND :AANNO'
      'and causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004E0045005700430041005500530041004C00
      4500050000000000000000000000160000003A004F004C004400430041005500
      530041004C0045000500000000000000000000000E0000003A00440041004100
      4E004E004F000300000000000000000000000C0000003A00410041004E004E00
      4F00030000000000000000000000}
    Left = 276
    Top = 310
  end
  object QRenProgCaus: TOracleQuery
    SQL.Strings = (
      'update /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'T040_giustificativi'
      'set causale = :newcausale'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      
        'DATA BETWEEN :DADATA AND TO_DATE(TO_CHAR(:ADATA,'#39'DD/MM/YYYY'#39')||'#39 +
        '2359'#39','#39'DD/MM/YYYYHH24MI'#39') AND'
      'causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A004E0045005700430041005500530041004C00
      45000500000000000000000000000E0000003A00440041004400410054004100
      0C00000000000000000000000C0000003A00410044004100540041000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004F004C00440043004100
      5500530041004C004500050000000000000000000000}
    Left = 344
    Top = 310
  end
  object QRenProgRes: TOracleQuery
    SQL.Strings = (
      'update T131_RESIDPRESENZE'
      'set causale = :newcausale'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      '(ANNO - 1) BETWEEN :DAANNO AND :AANNO AND'
      'causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A004E0045005700430041005500530041004C00
      4500050000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000160000003A004F004C00
      4400430041005500530041004C0045000500000000000000000000000E000000
      3A004400410041004E004E004F000300000000000000000000000C0000003A00
      410041004E004E004F00040000000000000000000000}
    Left = 424
    Top = 310
  end
  object QRenProgTimb: TOracleQuery
    SQL.Strings = (
      'update '
      ':tabella'
      'set causale = :newcausale'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      
        'DATA BETWEEN :DADATA AND TO_DATE(TO_CHAR(:ADATA,'#39'DD/MM/YYYY'#39')||'#39 +
        '2359'#39','#39'DD/MM/YYYYHH24MI'#39') AND'
      'causale = :oldcausale')
    Optimize = False
    Variables.Data = {
      0400000006000000160000003A004E0045005700430041005500530041004C00
      45000500000000000000000000000E0000003A00440041004400410054004100
      0C00000000000000000000000C0000003A00410044004100540041000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004F004C00440043004100
      5500530041004C004500050000000000000000000000100000003A0054004100
      420045004C004C004100010000000000000000000000}
    Left = 504
    Top = 310
  end
  object selT265TesteCatena: TOracleDataSet
    SQL.Strings = (
      
        '-- estrae le sole causali di assenza che sono "testa della caten' +
        'a"'
      
        '-- (hanno una causale successiva ma non rientrano tra le causali' +
        ' successive di altre causali)'
      'select CODICE, DESCRIZIONE from T265_CAUASSENZE A'
      'where  CAUSALE_SUCCESSIVA is not null '
      'and    not exists (select '#39'X'#39' '
      '                   from   T265_CAUASSENZE B'
      '                   where  B.CAUSALE_SUCCESSIVA = A.CODICE)'
      'order by CODICE')
    Optimize = False
    Left = 477
    Top = 10
  end
  object dsrDipendentiUnificazione: TDataSource
    DataSet = cdsDipendentiUnificazione
    Left = 190
    Top = 120
  end
  object cdsDipendentiUnificazione: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 120
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select :CAMPI '
      'from T030_ANAGRAFICO T030, V430_STORICO V430'
      'where T030.PROGRESSIVO = V430.T430PROGRESSIVO'
      '  :FILTRO'
      'order by T030.PROGRESSIVO, T430DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      0000000000000C0000003A00430041004D005000490001000000000000000000
      0000}
    Left = 556
    Top = 8
  end
  object QSQL: TOracleQuery
    Optimize = False
    Left = 560
    Top = 256
  end
  object selP441: TOracleDataSet
    SQL.Strings = (
      'SELECT P441.*,P441.ROWID FROM P441_CEDOLINO P441 '
      'WHERE PROGRESSIVO = :OLD'
      'ORDER BY DATA_CEDOLINO DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004F004C004400030000000000000000000000}
    CommitOnPost = False
    Left = 621
    Top = 8
  end
  object selP442: TOracleDataSet
    SQL.Strings = (
      'SELECT P442.*,P442.ROWID FROM P442_CEDOLINOVOCI P442'
      'WHERE ID_CEDOLINO = :ID'
      '')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    Left = 624
    Top = 64
  end
  object updTabelle: TOracleQuery
    SQL.Strings = (
      'UPDATE :TABELLA '
      'SET PROGRESSIVO = :PROGNEW'
      'WHERE PROGRESSIVO = :PROGOLD')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0054004100420045004C004C00410001000000
      0000000000000000100000003A00500052004F0047004E004500570003000000
      0000000000000000100000003A00500052004F0047004F004C00440003000000
      0000000000000000}
    Left = 624
    Top = 216
  end
  object selPeriodi: TOracleDataSet
    SQL.Strings = (
      'select inizio,fine from ('
      
        'select distinct inizio,fine from t430_storico where progressivo ' +
        '= :PROG and inizio is not null'
      'minus'
      
        'select distinct inizio,fine from t430_storico where progressivo ' +
        '= :PROGPARTENZA and inizio is not null'
      ') order by inizio, fine')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A00500052004F00470050004100520054004500
      4E005A0041000300000000000000000000000A0000003A00500052004F004700
      030000000000000000000000}
    Left = 620
    Top = 120
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select * from T430_STORICO '
      'where PROGRESSIVO = :Progressivo '
      'and inizio = :INIZIO'
      'and nvl(fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) >= datadecorrenza'
      'and inizio <= datafine'
      'order by datadecorrenza')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0049004E0049005A004900
      4F000C0000000000000000000000}
    Left = 276
    Top = 120
  end
  object selT430Dec: TOracleDataSet
    SQL.Strings = (
      
        'select min(DATADECORRENZA) as DATADECORRENZA from T430_STORICO w' +
        'here PROGRESSIVO = :Progressivo and DATADECORRENZA > :DataFine')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041004600
      49004E0045000C0000000000000000000000}
    Left = 324
    Top = 136
  end
  object selPeriodiStipendi: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from p430_anagrafico '
      'where progressivo = :PROG'
      '  :FILTRO'
      'order by DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000}
    Left = 624
    Top = 168
  end
  object selP430Dec: TOracleDataSet
    SQL.Strings = (
      
        'select min(DECORRENZA) as DECORRENZA from P430_ANAGRAFICO where ' +
        'PROGRESSIVO = :Progressivo ')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 625
    Top = 272
  end
  object ScrExeScript: TOracleScript
    AutoCommit = True
    OutputOptions = [ooSQL, ooNonSQL, ooFeedback, ooError]
    Left = 616
    Top = 336
  end
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T030.MATRICOLA,'
      '  T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '  T960.NOME_FILE ||'
      '  DECODE(T960.EXT_FILE, '#39#39', '#39#39', '#39'.'#39' || T960.EXT_FILE) INFO_FILE,'
      '  T960.PATH_STORAGE,'
      '  T960.DIMENSIONE,'
      '  T960.DATA_CREAZIONE,'
      '  T960.PROGRESSIVO,'
      '  T960.ID,'
      '  T960.ROWID,'
      '  T960.PROVENIENZA,'
      '  T850.ITER,'
      
        '  decode(T850.ITER,'#39'T050'#39',T050.CAUSALE,'#39'M140'#39',M140.PROTOCOLLO) I' +
        'NFO_RICHIESTA, '
      '  T850.STATO'
      'from'
      '  T960_DOCUMENTI_INFO T960,'
      '  T853_DOC_ALLEGATI T853,'
      '  T850_ITER_RICHIESTE T850, '
      '  M140_RICHIESTE_MISSIONI M140, '
      '  T050_RICHIESTEASSENZA T050,'
      '--where 1 = 1'
      '  :C700SelAnagrafe'
      '  and T030.PROGRESSIVO = T960.PROGRESSIVO '
      '  and T960.DATA_CREAZIONE between :DAL and :AL + 1 '
      '  and T960.PATH_STORAGE = '#39'DB'#39
      '  and T960.TIPOLOGIA = '#39'ITER'#39
      '  and T960.ID = T853.ID_T960 '
      '  and T853.ID = T850.ID'
      '  :STATO --and T850.STATO = S/N   '
      '  :ITER --and T850.ITER = T050 / M140'
      '  and T850.ID = M140.ID(+)'
      '  and T850.ID = T050.ID(+)'
      
        '  :INFO_RICHIESTA --and decode(T850.ITER,'#39'T050'#39',T050.CAUSALE,'#39'M1' +
        '40'#39',M140.PROTOCOLLO) = VALORE'
      '  '
      'order by'
      '  T960.DATA_CREAZIONE')
    Optimize = False
    Variables.Data = {
      0400000006000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000080000003A004400
      41004C000C0000000000000000000000060000003A0041004C000C0000000000
      0000000000000C0000003A0053005400410054004F0001000000000000000000
      00000A0000003A0049005400450052000100000000000000000000001E000000
      3A0049004E0046004F005F005200490043004800490045005300540041000100
      00000000000000000000}
    Left = 29
    Top = 394
  end
  object selCausali: TOracleDataSet
    SQL.Strings = (
      'select'
      '  DISTINCT (T.:CAUSALE) CAUSALE  '
      'from'
      '  :TABELLA_ITER T'
      'where'
      '  T.ID in  (select'
      '                T853.ID'
      '              from'
      '                T960_DOCUMENTI_INFO T960,'
      '                T853_DOC_ALLEGATI T853,'
      '                T850_ITER_RICHIESTE T850,'
      '                :C700SelAnagrafe               '
      '                :STATO'
      
        '                and T030.PROGRESSIVO :OUT_JOIN = T960.PROGRESSIV' +
        'O :PATH_STORAGE '
      
        '                and T960.DATA_CREAZIONE between :DAL and :AL + 1' +
        ' '
      '                and T960.ID = T853.ID_T960 '
      '                and T853.ID = T850.ID)')
    Optimize = False
    Variables.Data = {
      0400000009000000100000003A00430041005500530041004C00450001000000
      00000000000000001A0000003A0054004100420045004C004C0041005F004900
      540045005200010000000000000000000000200000003A004300370030003000
      530045004C0041004E0041004700520041004600450001000000000000000000
      00000C0000003A0053005400410054004F000100000000000000000000001200
      00003A004F00550054005F004A004F0049004E00010000000000000000000000
      1A0000003A0050004100540048005F00530054004F0052004100470045000100
      00000000000000000000080000003A00440041004C000C000000000000000000
      0000060000003A0041004C000C0000000000000000000000160000003A004400
      4100540041004C00410056004F0052004F000C0000000000000000000000}
    Left = 82
    Top = 396
  end
  object dsrT960: TDataSource
    DataSet = selT960
    Left = 168
    Top = 392
  end
end
