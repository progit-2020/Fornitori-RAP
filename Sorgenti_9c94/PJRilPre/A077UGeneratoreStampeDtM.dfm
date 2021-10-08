inherited A077FGeneratoreStampeDtM: TA077FGeneratoreStampeDtM
  Height = 397
  Width = 889
  inherited cds920: TClientDataSet
    Left = 284
  end
  inherited updT920DataDecorrenza: TOracleQuery
    Variables.Data = {
      04000000040000000C0000003A00430041004D0050004900010000000C000000
      54343330504F524152494F0000000000100000003A0054004100420045004C00
      4C004100010000000C000000543932305F5359534D414E000000000016000000
      3A0054004100420045004C004C00410053005400520005000000000000000000
      00001E0000003A0043004400430050004500520043005F0043004F0044004900
      43004500010000000000000000000000}
  end
  inherited selDropUserTabs: TOracleDataSet
    SQL.Strings = (
      'SELECT TABELLA_GENERATA'
      '  FROM T910_RIEPILOGO T910'
      'WHERE NVL(T910.DATA_ACCESSO,SYSDATE) < ADD_MONTHS(SYSDATE,-12)'
      'AND TABELLA_GENERATA IS NOT NULL'
      'MINUS'
      'SELECT TABELLA_GENERATA'
      '  FROM T910_RIEPILOGO T910'
      'WHERE NVL(T910.DATA_ACCESSO,SYSDATE) >= ADD_MONTHS(SYSDATE,-12)'
      'AND TABELLA_GENERATA IS NOT NULL'
      '')
  end
  inherited selT002Riga: TOracleDataSet
    Left = 824
    Top = 120
  end
  object selT072: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 12
    Top = 193
  end
  object selM050: TOracleDataSet
    SQL.Strings = (
      '-- rimborsi'
      'SELECT '#39'N'#39' MR_RICHIESTA,'
      '       '#39'N'#39' MR_INDENNITAKM,'
      '       '#39'S'#39' MR_STATOAUTORIZZAZIONE,'
      '       M040.ID_MISSIONE MR_IDMISSIONE,'
      '       M050.PROGRESSIVO PROGRESSIVO7, '
      '       M050.MESESCARICO MR_MESESCARICO, '
      '       M050.MESECOMPETENZA MR_MESECOMPETENZA, '
      '       M050.DATADA MR_DADATA, '
      '       M050.ORADA MR_DAORA,'
      '       M050.CODICERIMBORSOSPESE MR_CODICERIMBORSO,'
      '       M020.DESCRIZIONE MR_DESCRIZIONERIMBORSO, '
      '       M020.FLAG_ANTICIPO MR_ANTICIPO, '
      '       0 MR_RIMBORSORICHIESTO,'
      '       M050.IMPORTORIMBORSOSPESE MR_RIMBORSORICONOSCIUTO,'
      '       M050.IMPORTOINDENNITASUPPLEMENTARE MR_INDENNITASUPPL,'
      
        '       DECODE(M020.FLAG_ANTICIPO,'#39'S'#39',0,M050.IMPORTOCOSTORIMBORSO' +
        ') MR_COSTO,'
      '       0 MR_KMRICHIESTI,'
      '       0 MR_KMRICONOSCIUTI,'
      '       M020.CODICEVOCEPAGHE MR_VOCEPAGHE,'
      '       M020.TIPO_QUANTITA,'
      '       M040.TIPOREGISTRAZIONE MR_TIPOMISSIONE, '
      '       M040.PROTOCOLLO MR_PROTOCOLLO, '
      '       M040.COMMESSA MR_COMMESSA,'
      '       TO_CHAR(NULL) MR_NOTE'
      
        'FROM   M050_RIMBORSI M050, M040_MISSIONI M040, M020_TIPIRIMBORSI' +
        ' M020'
      'WHERE  M050.PROGRESSIVO = :PROGRESSIVO '
      'AND    M050.:DATO_DALAL BETWEEN :DATA1 AND :DATA2'
      'AND    M050.CODICERIMBORSOSPESE = M020.CODICE '
      'AND    M050.PROGRESSIVO = M040.PROGRESSIVO'
      'AND    M050.MESECOMPETENZA = M040.MESECOMPETENZA'
      'AND    M050.MESESCARICO = M040.MESESCARICO'
      'AND    M050.DATADA = M040.DATADA'
      'AND    M050.ORADA = M040.ORADA'
      'UNION ALL'
      '-- indennit'#224' km'
      'SELECT '#39'N'#39' /* MR_RICHIESTA */,'
      '       '#39'S'#39' /* MR_INDENNITA_KM */,'
      '       '#39'S'#39' /* MR_STATO_AUTORIZZAZIONE */,'
      '       M040.ID_MISSIONE,'
      '       M052.PROGRESSIVO, '
      '       M052.MESESCARICO, '
      '       M052.MESECOMPETENZA, '
      '       M052.DATADA, '
      '       M052.ORADA,'
      '       M052.CODICEINDENNITAKM,'
      '       M021.DESCRIZIONE, '
      '       NULL /* MR_ANTICIPO */, '
      '       0 /* MR_RIMBORSORICHIESTO */,'
      '       M052.IMPORTOINDENNITA /* MR_RIMBORSORICONOSCIUTO'#39'*/,'
      '       0 /* MR_INDENNITASUPPL */,'
      '       0 /* MR_COSTO */,'
      '       0 KMRICHIESTI,'
      '       KMPERCORSI,'
      '       M021.CODVOCEPAGHE,'
      '       '#39'I'#39','
      '       M040.TIPOREGISTRAZIONE /* MR_TIPOMISSIONE */, '
      '       M040.PROTOCOLLO, '
      '       M040.COMMESSA,'
      '       TO_CHAR(NULL) /* MR_NOTE */'
      
        'FROM   M052_INDENNITAKM M052, M040_MISSIONI M040, M021_TIPIINDEN' +
        'NITAKM M021 '
      'WHERE  M052.PROGRESSIVO = :PROGRESSIVO '
      'AND    M052.:DATO_DALAL BETWEEN :DATA1 AND :DATA2'
      'AND    M052.PROGRESSIVO = M040.PROGRESSIVO'
      'AND    M052.MESECOMPETENZA = M040.MESECOMPETENZA'
      'AND    M052.MESESCARICO = M040.MESESCARICO'
      'AND    M052.DATADA = M040.DATADA'
      'AND    M052.ORADA = M040.ORADA'
      'AND    M052.CODICEINDENNITAKM = M021.CODICE'
      'AND    :DATA2 BETWEEN M021.DECORRENZA AND M021.DECORRENZA_FINE'
      'UNION ALL'
      '-- richieste di rimborsi e indennit'#224' km'
      'SELECT '#39'S'#39' /* MR_RICHIESTA */,'
      '       M150.INDENNITA_KM,'
      '       T850.STATO,'
      '       M140.ID,'
      '       M140.PROGRESSIVO, '
      '       trunc(M140.DATAA,'#39'MM'#39') /* MR_MESESCARICO */, '
      '       trunc(M140.DATAA,'#39'MM'#39') /* MR_MESECOMPETENZA */, '
      '       M140.DATADA, '
      '       M140.ORADA,'
      '       M150.CODICE, '
      
        '       decode(M150.INDENNITA_KM,'#39'S'#39',M021.DESCRIZIONE,M020.DESCRI' +
        'ZIONE), '
      '       decode(M150.INDENNITA_KM,'#39'S'#39','#39'N'#39',M020.FLAG_ANTICIPO), '
      '       M150.RIMBORSO,'
      '       nvl(M150.RIMBORSO_VARIATO,M150.RIMBORSO), '
      '       NULL,'
      '       nvl(M150.RIMBORSO_VARIATO,M150.RIMBORSO),'
      '       M150.KMPERCORSI,'
      '       nvl(M150.KMPERCORSI_VARIATO,M150.KMPERCORSI),'
      
        '       decode(M150.INDENNITA_KM,'#39'S'#39',M021.CODVOCEPAGHE,M020.CODIC' +
        'EVOCEPAGHE),'
      '       M020.TIPO_QUANTITA,'
      '       M140.TIPOREGISTRAZIONE, '
      '       M140.PROTOCOLLO,'
      '       NULL, /* MR_COMMESSA */'
      '       M150.NOTE'
      'FROM   M150_RICHIESTE_RIMBORSI M150, '
      '       M140_RICHIESTE_MISSIONI M140, '
      '       M020_TIPIRIMBORSI M020, '
      '       M021_TIPIINDENNITAKM M021,'
      '       T850_ITER_RICHIESTE T850'
      'WHERE  M140.PROGRESSIVO = :PROGRESSIVO'
      'AND    M140.DATADA BETWEEN :DATA1 AND :DATA2'
      'AND    M150.ID = M140.ID'
      'AND    M020.CODICE (+) = M150.CODICE'
      'AND    M021.CODICE (+) = M150.CODICE'
      
        'AND    trunc(sysdate) BETWEEN M021.DECORRENZA(+) AND M021.DECORR' +
        'ENZA_FINE(+)'
      'AND    T850.ITER = '#39'M140'#39
      'AND    T850.ID = M140.ID')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000160000003A004400410054004F005F00440041004C004100
      4C00010000000000000000000000}
    Left = 116
    Top = 193
  end
  object selM040: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  M040.*,'
      '  M010.CODVOCEPAGHEINTERA,'
      '  M010.CODVOCEPAGHESUPHH,'
      '  M010.CODVOCEPAGHESUPGG,'
      '  M010.CODVOCEPAGHESUPHHGG'
      
        'FROM M040_MISSIONI M040, T430_STORICO T430,M010_PARAMETRICONTEGG' +
        'IO M010'
      'WHERE '
      'M040.PROGRESSIVO = :PROGRESSIVO AND '
      'M040.PROGRESSIVO = T430.PROGRESSIVO AND '
      'M040.DATAA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND'
      '--M040.MESESCARICO BETWEEN :DATA1 AND :DATA2 AND'
      'M040.:DATO_DALAL BETWEEN :DATA1 AND :DATA2 AND'
      'M010.TIPO_MISSIONE = M040.TIPOREGISTRAZIONE AND'
      'M010.CODICE = :DATO_STORICO AND '
      
        'M010.DECORRENZA = (SELECT MAX(DECORRENZA) FROM M010_PARAMETRICON' +
        'TEGGIO WHERE CODICE = M010.CODICE AND TIPO_MISSIONE = M010.TIPO_' +
        'MISSIONE AND DECORRENZA <= (ADD_MONTHS(M040.MESECOMPETENZA,1) - ' +
        '1))'
      'ORDER BY MESESCARICO')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001A0000003A004400410054004F005F00530054004F005200
      490043004F00010000000000000000000000160000003A004400410054004F00
      5F00440041004C0041004C00010000000000000000000000}
    Left = 64
    Top = 193
  end
  object selT195: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DATARIF,VOCEPAGHE,VALORE,IMPORTO,UM,COD_INTERNO,DATA_CASS' +
        'A'
      'FROM T195_VOCIVARIABILI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATARIF BETWEEN :DATA1 AND :DATA2'
      ':VOCI')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000000A0000003A0056004F004300490001000000000000000000
      0000}
    Left = 276
    Top = 193
  end
  object selT340: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM T340_TURNIREPERIB WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      
        'TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||LPAD(ANNO,4,'#39'0'#39'),'#39'DDMMYYYY'#39') BET' +
        'WEEN :DATA1 AND :DATA2')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 336
    Top = 193
  end
  object selVSG651: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM VSG651_PIANIFICAZIONECORSI WHERE'
      'PROGRESSIVO10 = :PROGRESSIVO AND'
      '(CF_DATA_PARTECIPAZIONE BETWEEN :DATA1 AND :DATA2 '
      ' OR'
      
        ' CF_TIPO_PARTECIPAZIONE = '#39'D'#39' AND :DATA1 <= NVL(CF_FINE,CF_INIZI' +
        'O) AND :DATA2 >= CF_INIZIO)'
      ':CORSI'
      'ORDER BY CF_COD_CORSO,CF_INIZIO,CF_DATA_PARTECIPAZIONE ')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000000C0000003A0043004F005200530049000100000000000000
      00000000}
    Left = 332
    Top = 291
  end
  object selVT246: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM VT246_ISCRIZIONISINDACATI WHERE'
      'PROGRESSIVO11 = :PROGRESSIVO AND'
      
        'IS_DATA_ISCRIZIONE <= :DATA2 AND NVL(IS_DATA_CESSAZIONE,:DATA1) ' +
        '>= :DATA1'
      'AND IS_TIPO_RECAPITO = :TIPO_RECAPITO'
      ':COD_SINDACATI'
      'ORDER BY IS_DATA_ISCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A005400490050004F005F005200450043004100
      5000490054004F000500000000000000000000001C0000003A0043004F004400
      5F00530049004E00440041004300410054004900010000000000000000000000}
    Left = 456
    Top = 193
  end
  object selVT247: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM VT247_PARTECIPAZIONISINDACALI WHERE'
      'PROGRESSIVO12 = :PROGRESSIVO AND'
      'OS_DATA_INIZIO <= :DATA2 AND NVL(OS_DATA_FINE,:DATA1) >= :DATA1'
      'AND OS_TIPO_RECAPITO = :TIPO_RECAPITO'
      ':COD_SINDACATI'
      'ORDER BY OS_DATA_INIZIO')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A005400490050004F005F005200450043004100
      5000490054004F000500000000000000000000001C0000003A0043004F004400
      5F00530049004E00440041004300410054004900010000000000000000000000}
    Left = 512
    Top = 193
  end
  object selVT248: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM VT248_PERMESSISINDACALI WHERE'
      'PROGRESSIVO13 = :PROGRESSIVO AND'
      'PS_DATA BETWEEN :DATA1 AND :DATA2'
      'AND PS_TIPO_RECAPITO = :TIPO_RECAPITO'
      ':COD_SINDACATI'
      'ORDER BY PS_DATA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A005400490050004F005F005200450043004100
      5000490054004F000500000000000000000000001C0000003A0043004F004400
      5F00530049004E00440041004300410054004900010000000000000000000000}
    Left = 572
    Top = 193
  end
  object selM052: TOracleDataSet
    SQL.Strings = (
      'SELECT M052.*, M021.DESCRIZIONE, M021.CODVOCEPAGHE,'
      
        '       M040.TIPOREGISTRAZIONE TIPOMISSIONE, M040.PROTOCOLLO, M04' +
        '0.COMMESSA'
      
        'FROM   M052_INDENNITAKM M052, M040_MISSIONI M040, M021_TIPIINDEN' +
        'NITAKM M021 '
      'WHERE  M052.PROGRESSIVO = :PROGRESSIVO '
      'AND    M052.:DATO_DALAL BETWEEN :DATA1 AND :DATA2 -- MESESCARICO'
      'AND    M052.PROGRESSIVO = M040.PROGRESSIVO'
      'AND    M052.MESECOMPETENZA = M040.MESECOMPETENZA'
      'AND    M052.MESESCARICO = M040.MESESCARICO'
      'AND    M052.DATADA = M040.DATADA'
      'AND    M052.ORADA = M040.ORADA'
      'AND    M052.CODICEINDENNITAKM = M021.CODICE'
      'AND    M021.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                          FROM   M021_TIPIINDENNITAKM '
      '                          WHERE  CODICE = M021.CODICE '
      '                          AND    DECORRENZA <= :DATA2)')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000160000003A004400410054004F005F00440041004C004100
      4C00010000000000000000000000}
    Left = 168
    Top = 193
  end
  object selT762: TOracleDataSet
    SQL.Strings = (
      
        'select t762.progressivo,to_date(lpad(t762.anno,4,'#39'0'#39') || lpad(t7' +
        '62.mese,2,'#39'0'#39'),'#39'yyyymm'#39') qi_data,'
      '       t762.codtipoquota qi_cod_tipo_quota, '
      '       t765.descrizione qi_desc_tipo_quota,'
      '       t765.tipoquota qi_tipo_quota,'
      
        '       nvl(importo,0) qi_incentivi,nvl(variazioni,0) qi_varincen' +
        'tivi,'
      '       t762.tipoimporto qi_cod_tipo_importo,'
      
        '       decode(t762.tipoimporto,'#39'1'#39','#39'Quota intera'#39','#39'2'#39','#39'Quota pro' +
        'porzionata'#39','#39'3'#39','#39'Quota netta'#39','#39'4'#39','#39'Quota netta + Risparmio'#39','#39'5'#39',' +
        #39'Quota quantitativa'#39',t766.descrizione) qi_desc_tipo_importo,'
      '       t766.risparmio_bilancio qi_risparmio,'
      '       nvl(t762.giorni_ore,0) qi_giorni'
      'from   t762_incentivimaturati t762, '
      '       t765_tipoquote t765, '
      '       t766_incentivitipoabbat t766'
      'where  t762.progressivo = :progressivo and '
      
        '       to_date(lpad(t762.anno,4,'#39'0'#39') || lpad(t762.mese,2,'#39'0'#39'),'#39'y' +
        'yyymm'#39') between :data1 and :data2 and'
      '       t765.codice = t762.codtipoquota and'
      '       t765.decorrenza = ('
      '         select max(decorrenza) '
      '         from   t765_tipoquote '
      '         where  codice = t765.codice and '
      
        '                decorrenza <= LAST_DAY(to_date(lpad(t762.anno,4,' +
        #39'0'#39') || lpad(t762.mese,2,'#39'0'#39'),'#39'yyyymm'#39'))'
      '         ) and   '
      '       t762.tipoimporto = t766.codice (+)'
      'order by qi_data,t762.codtipoquota')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 624
    Top = 193
  end
  object selT763: TOracleDataSet
    SQL.Strings = (
      'select nvl(t763.quotaabbattimento,0) qi_abbattimento,'
      '       t763.tipoabbattimento qi_tipoabbattimento'
      'from t763_incentiviabbattimenti t763'
      'where '
      '  :progressivo = t763.progressivo and'
      '  :anno = t763.anno and'
      '  :mese = t763.mese and'
      '  :tipoquota = t763.tipoquota'
      'order by tipoabbattimento')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      000000000000000000000A0000003A004D004500530045000300000000000000
      00000000140000003A005400490050004F00510055004F005400410005000000
      0000000000000000}
    Left = 672
    Top = 193
  end
  object selM060: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.* FROM '
      'M060_ANTICIPI M060 WHERE'
      'M060.PROGRESSIVO = :PROGRESSIVO AND '
      'M060.DATA_MISSIONE BETWEEN :DATA1 AND :DATA2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 224
    Top = 193
  end
  object selVSG402: TOracleDataSet
    SQL.Strings = (
      'select VSG402.*'
      'from VSG402_RISCHIPRESCRIZIONI VSG402'
      'where '
      '  VSG402.PROGRESSIVO17 = :progressivo and'
      '  RP_DATA_INIZIO <= :data2 and '
      '  NVL(RP_DATA_FINE,:data1) >= :data1'
      
        'order by VSG402.RP_DATA_INIZIO, VSG402.RP_DATA_VISITA,VSG402.RP_' +
        'TIPO_RISCHIO')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 12
    Top = 289
  end
  object selVSG303: TOracleDataSet
    SQL.Strings = (
      'select VSG303.*'
      'from VSG303_INCARICHI VSG303'
      'where '
      '  VSG303.PROGRESSIVO18 = :progressivo and'
      
        '((:data2 >= IN_DATA_AFFIDAMENTO and :data1 <= nvl(IN_DATA_SCADEN' +
        'ZA,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))) OR'
      ' (IN_DATA_VERIFICA between :data1 and :data2))'
      
        'order by VSG303.IN_DATA_AFFIDAMENTO, IN_COD_UNITAORG, IN_TIPOINC' +
        ', IN_TITOLO_POSIZIONE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 68
    Top = 289
  end
  object selVT280: TOracleDataSet
    SQL.Strings = (
      'select VT280.*'
      'from VT280_MESSAGGIWEB VT280'
      'where '
      '  VT280.PROGRESSIVO19 = :progressivo and'
      '  VT280.MW_DATA between :data1 and :data2'
      'order by VT280.MW_DATA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 12
    Top = 337
  end
  object selVT050T105: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from VT050_T105_RICHIESTEWEB'
      'where '
      '  PROGRESSIVO20 = :progressivo and'
      '  RW_DATA1 <= :data2 and '
      '  RW_DATA2 >= :data1'
      'order by RW_DATA1')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 76
    Top = 337
  end
  object selVT500: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from VT500_CARTASERVIZI'
      'where '
      '  PROGRESSIVO21 = :progressivo and'
      '  CS_DATA between :data1 and :data2'
      'order by CS_DATA,CS_DALLE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 260
    Top = 289
  end
  object selC20Incarichi: TOracleDataSet
    Optimize = False
    Left = 416
    Top = 289
  end
  object selSG710: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT --La distinct serve ad appiattire i record SG700' +
        ' quando SG701.tipo_link_item = '#39'1'#39
      '  SG710.progressivo PROGRESSIVO22,'
      '  SG710.data VA_DATA_VALUTAZIONE,'
      '  to_char(SG710.data,'#39'yyyy'#39') VA_ANNO,'
      '  SG710.dal VA_DAL_VALUTAZIONE,'
      '  SG710.al VA_AL_VALUTAZIONE,'
      '  SG710.tipo_valutazione VA_COD_TIPO_VALUTAZIONE,'
      
        '  DECODE(SG710.tipo_valutazione,'#39'A'#39','#39'Autovalutazione'#39','#39'V'#39','#39'Valut' +
        'azione'#39') VA_DESC_TIPO_VALUTAZIONE,'
      '  SG710.codregola VA_COD_REGOLA,'
      '  SG741.descrizione VA_DESC_REGOLA,'
      '  SG710.stato_avanzamento VA_STATO_AVANZAMENTO,'
      '  SG710.valutabile VA_DIPENDENTE_VALUTABILE,'
      '  SG710.chiuso VA_CHIUSO,'
      '  SG710.data_chiusura VA_DATA_CHIUSURA,'
      '  DECODE(SG710.valutabile,'#39'N'#39','#39'Non valutabile'#39','
      
        '                          DECODE(SG710.chiuso,'#39'S'#39','#39'Scheda defini' +
        'tiva'#39','
      
        '                                              '#39'B'#39','#39'Scheda blocca' +
        'ta'#39','
      
        '                                              DECODE(SG710.tipo_' +
        'valutazione,'#39'V'#39',SG746.descrizione,'
      
        '                                                                ' +
        '            DECODE(CREA_AUTOVAL.codregola,NULL,SG746.descrizione' +
        ','
      
        '                                                                ' +
        '                                          '#39'Scheda provvisoria'#39'))' +
        ')) VA_DESC_STATO_SCHEDA,'
      '  SG710.data_compilazione VA_DATA_COMPILAZIONE,'
      
        '  DECODE(SG710.tipo_valutazione,'#39'A'#39',NULL,SG710.progressivi_valut' +
        'atori) VA_PROGRESSIVI_VALUTATORI,'
      
        '  DECODE(SG710.tipo_valutazione,'#39'A'#39',NULL,SG710F_DESC_VALUTATORI(' +
        'SG710.progressivi_valutatori)) VA_DESC_VALUTATORI,'
      '  SG710.punteggio_finale_pesato VA_PUNTEGGIO_FINALE_PESATO,'
      '  SG710.esito_valutazione_intermedia VA_ESITO_VAL_INTERMEDIA,'
      
        '  DECODE(SG710.esito_valutazione_intermedia,'#39'N'#39','#39'Negativa'#39','#39'P'#39','#39 +
        'Positiva'#39','#39#39') VA_DESC_ESITO_VAL_INTERMEDIA,'
      
        '  REPLACE(REPLACE(TRIM(SG710.valutazione_intermedia),chr(13)||ch' +
        'r(10),'#39' '#39'),chr(10),'#39' '#39') VA_VALUTAZIONE_INTERMEDIA,'
      
        '  REPLACE(REPLACE(SG710F_STORIA_VAL_INTERM(SG710.data,SG710.prog' +
        'ressivo,SG710.tipo_valutazione,SG710.stato_avanzamento + 1),chr(' +
        '13)||chr(10),'#39' '#39'),chr(10),'#39' '#39') VA_STORIA_VAL_INTERMEDIA,'
      
        '  REPLACE(REPLACE(TRIM(SG710.valutazione_complessive),chr(13)||c' +
        'hr(10),'#39' '#39'),chr(10),'#39' '#39') VA_VALUTAZIONI_COMPLESSIVE,'
      
        '  REPLACE(REPLACE(TRIM(SG710.obiettivi_azioni),chr(13)||chr(10),' +
        #39' '#39'),chr(10),'#39' '#39') VA_OBIETTIVI_AZIONI,'
      '  SG710.proposte_formative_1 VA_PROPOSTE_FORMATIVE_1,'
      '  SG710.proposte_formative_2 VA_PROPOSTE_FORMATIVE_2,'
      '  SG710.proposte_formative_3 VA_PROPOSTE_FORMATIVE_3,'
      
        '  REPLACE(REPLACE(TRIM(SG710.proposte_formative),chr(13)||chr(10' +
        '),'#39' '#39'),chr(10),'#39' '#39') VA_PROPOSTE_FORMATIVE,'
      '  SG710.accettazione_valutato VA_ACCETTAZIONE_VALUTATO,'
      
        '  DECODE(SG710.accettazione_valutato,'#39'S'#39','#39'Accettata'#39','#39'Non accett' +
        'ata'#39') VA_DESC_ACCETTAZIONE_VALUTATO,'
      
        '  REPLACE(REPLACE(TRIM(SG710.commenti_valutato),chr(13)||chr(10)' +
        ','#39' '#39'),chr(10),'#39' '#39') VA_COMMENTI_VALUTATO,'
      
        '  REPLACE(REPLACE(TRIM(SG710.note),chr(13)||chr(10),'#39' '#39'),chr(10)' +
        ','#39' '#39') VA_NOTE,'
      '  SG710.numero_protocollo VA_NUMERO_PROTOCOLLO,'
      '  SG710.anno_protocollo VA_ANNO_PROTOCOLLO,'
      '  SG710.data_protocollo VA_DATA_PROTOCOLLO,'
      '  SG710.tipo_protocollo VA_COD_TIPO_PROTOCOLLO,'
      
        '  DECODE(SG710.tipo_protocollo,'#39'A'#39','#39'Automatico'#39','#39'M'#39','#39'Manuale'#39') V' +
        'A_DESC_TIPO_PROTOCOLLO,'
      '  SG745.esito VA_PRESA_VISIONE_DIP,'
      '  SG745.data_consegna VA_DATA_PRESA_VISIONE_DIP,'
      '  SG711.cod_area VA_COD_AREA,'
      '  SG701.descrizione VA_DESC_AREA,'
      
        '  TRIM(TO_CHAR(NVL(AREE_SENZA_PESO.peso_area,SG701.peso_percentu' +
        'ale),'#39'990D00'#39')) VA_PESO_AREA,'
      '  SG711.cod_valutazione VA_COD_ELEMENTO,'
      '  DECODE(SG701.tipo_link_item,'
      
        '        '#39'1'#39',CONCATENA_TESTO('#39'SELECT DESCRIZIONE FROM SG700_VALUT' +
        'AZIONI WHERE COD_AREA = '#39#39#39'||SG701.cod_area ||'#39#39#39' AND DECORRENZA' +
        ' = TO_DATE('#39#39#39'||TO_CHAR(SG701.decorrenza,'#39'DDMMYYYY'#39')||'#39#39#39','#39#39'DDMM' +
        'YYYY'#39#39') ORDER BY COD_VALUTAZIONE'#39','#39' / '#39'),'
      
        '            NVL(SG711.desc_valutazione_agg,SG700.descrizione)) V' +
        'A_DESC_ELEMENTO,'
      '  SG711.perc_valutazione VA_PESO_ELEMENTO,'
      '  SG711.valutabile VA_ELEMENTO_VALUTABILE,'
      '  SG711.punteggio VA_PUNTEGGIO,'
      
        '  DECODE(SG701.tipo_punteggio_items,'#39'1'#39',TO_CHAR(SG711.punteggio)' +
        ',SG711.cod_punteggio) VA_COD_PUNTEGGIO,'
      '  SG711.punteggio_pesato VA_PUNTEGGIO_PESATO,'
      '  SG711.note_punteggio VA_NOTE_PUNTEGGIO'
      'FROM SG710_TESTATA_VALUTAZIONI SG710,'
      '     SG711_VALUTAZIONI_DIPENDENTE SG711,'
      '     SG701_AREE_VALUTAZIONI SG701,'
      '     SG700_VALUTAZIONI SG700,'
      '     SG741_REGOLE_VALUTAZIONI SG741,'
      '     SG746_STATI_AVANZAMENTO SG746,'
      '     (SELECT CODREGOLA, DECORRENZA, DECORRENZA_FINE'
      '      FROM SG746_STATI_AVANZAMENTO'
      '      WHERE CREA_AUTOVALUTAZIONE = '#39'S'#39') CREA_AUTOVAL,'
      '     SG745_CONSEGNA_VALUTAZIONI SG745,'
      
        '     (SELECT SG711.DATA, SG711.PROGRESSIVO, SG711.TIPO_VALUTAZIO' +
        'NE, SG711.STATO_AVANZAMENTO, SG711.COD_AREA, SUM(PERC_VALUTAZION' +
        'E) PESO_AREA'
      '      FROM SG711_VALUTAZIONI_DIPENDENTE SG711,'
      '           SG701_AREE_VALUTAZIONI SG701'
      '      WHERE SG711.COD_AREA = SG701.COD_AREA'
      
        '      AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORREN' +
        'ZA_FINE'
      '      AND SG701.TIPO_PESO_PERCENTUALE = '#39'0'#39
      '      AND SG701.PESO_PERCENTUALE = 0'
      
        '      GROUP BY SG711.DATA, SG711.PROGRESSIVO, SG711.TIPO_VALUTAZ' +
        'IONE, SG711.STATO_AVANZAMENTO, SG711.COD_AREA) AREE_SENZA_PESO'
      'WHERE SG710.progressivo = :progressivo'
      'AND SG710.data BETWEEN :data1 AND :data2'
      'AND SG711.data (+) = SG710.data'
      'AND SG711.progressivo (+) = SG710.progressivo'
      'AND SG711.tipo_valutazione (+) = SG710.tipo_valutazione'
      'AND SG711.stato_avanzamento (+) = SG710.stato_avanzamento'
      'AND SG701.cod_area (+) = SG711.cod_area'
      
        'AND SG711.data BETWEEN SG701.decorrenza (+) AND SG701.decorrenza' +
        '_fine (+)'
      'AND SG700.cod_area (+) = SG701.cod_area'
      'AND SG700.decorrenza (+) = SG701.decorrenza'
      'AND (   (SG701.tipo_link_item = '#39'1'#39')'
      
        '     OR (SG701.tipo_link_item <> '#39'1'#39' AND NVL(SG700.cod_valutazio' +
        'ne,'#39'#NULL#'#39') = DECODE(SG711.desc_valutazione_agg,NULL,SG711.cod_' +
        'valutazione,NVL(SG700.cod_valutazione,'#39'#NULL#'#39'))))'
      'AND SG741.codice (+) = SG710.codregola'
      
        'AND SG710.data between SG741.decorrenza (+) AND SG741.decorrenza' +
        '_fine (+)'
      'AND SG746.codregola (+) = SG710.codregola'
      'AND SG746.codice (+) = SG710.stato_avanzamento'
      
        'AND SG710.data between SG746.decorrenza (+) AND SG746.decorrenza' +
        '_fine (+)'
      'AND CREA_AUTOVAL.codregola (+) = SG710.codregola'
      
        'AND SG710.data between CREA_AUTOVAL.decorrenza (+) AND CREA_AUTO' +
        'VAL.decorrenza_fine (+)'
      'AND SG745.data (+) = SG710.data'
      'AND SG745.progressivo (+) = SG710.progressivo'
      'AND SG745.tipo_valutazione (+) = SG710.tipo_valutazione'
      'AND SG745.stato_avanzamento (+) = SG710.stato_avanzamento'
      'AND SG745.prog_utente (+) = SG710.progressivo'
      'AND SG745.tipo_consegna (+) = '#39'PV'#39
      'AND AREE_SENZA_PESO.data (+) = SG711.data'
      'AND AREE_SENZA_PESO.progressivo (+) = SG711.progressivo'
      
        'AND AREE_SENZA_PESO.tipo_valutazione (+) = SG711.tipo_valutazion' +
        'e'
      
        'AND AREE_SENZA_PESO.stato_avanzamento (+) = SG711.stato_avanzame' +
        'nto'
      'AND AREE_SENZA_PESO.cod_area (+) = SG711.cod_area'
      'AND (:STATO_ATTUALE = '#39'N'#39' OR '
      
        '     SG710.STATO_AVANZAMENTO = (SELECT MAX(SG710A.STATO_AVANZAME' +
        'NTO) '
      
        '                                FROM SG710_TESTATA_VALUTAZIONI S' +
        'G710A'
      
        '                                WHERE SG710A.PROGRESSIVO = SG710' +
        '.PROGRESSIVO'
      '                                AND SG710A.DATA = SG710.DATA'
      
        '                                AND SG710A.TIPO_VALUTAZIONE = SG' +
        '710.TIPO_VALUTAZIONE))'
      
        'ORDER BY SG710.progressivo, SG710.data, SG710.tipo_valutazione, ' +
        'SG710.stato_avanzamento, SG711.cod_area, SG711.cod_valutazione')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A0053005400410054004F005F00410054005400
      550041004C004500050000000000000000000000}
    Left = 572
    Top = 289
  end
  object selVSG308: TOracleDataSet
    SQL.Strings = (
      'select VSG308.*'
      'from VSG308_INCVERIFICHE VSG308'
      'where '
      '  VSG308.PROGRESSIVO23 = :progressivo and'
      '((VSG308.IV_DATA_VERIFICA between :data1 and :data2) or'
      
        ' (nvl(VSG308.IV_DECORRENZA_IND,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39')) <' +
        '= :data2 and '
      
        '  nvl(VSG308.IV_SCADENZA_IND,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= ' +
        ':data1))'
      
        'order by VSG308.IV_DATA_VERIFICA, IV_DECORRENZA_IND, IV_COD_TIPO' +
        '_VERIFICA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 688
    Top = 288
  end
  object selVT134: TOracleDataSet
    SQL.Strings = (
      'select VT134.*'
      'from VT134_ORELIQUIDATEANNIPREC VT134'
      'where '
      '  VT134.PROGRESSIVO24 = :progressivo and'
      '  VT134.VAP_DATA_VARIAZIONE between :data1 and :data2'
      'order by VT134.VAP_ANNO_COMPETENZA,VT134.VAP_DATA_VARIAZIONE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 739
    Top = 193
  end
  object selVT850_T851: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '  --non estrarre tutte le colonne, ma solo quelle utili in stamp' +
        'a non presenti sugli altri dataset selT050, selT065, ecc... '
      '  PROGRESSIVO25,'
      '  IA_DAL,'
      '  IA_AL,'
      '  IA_ID, '
      '  IA_ITER, '
      '  IA_STRUTTURA_ITER, '
      '  IA_DATA_RICHIESTA, '
      '  IA_NOTE_RICHIESTA, '
      '  IA_STATO_RICHIESTA, '
      '  IA_TIPO_RICHIESTA, '
      '  IA_RICHIESTA_AUTOMATICA, '
      '  IA_REVOCA, '
      '  IA_REVOCATO, '
      '  IA_LIVELLO_AUTORIZZAZIONE, '
      '  IA_DATA_AUTORIZZAZIONE, '
      '  IA_AUTORIZZATORE, '
      '  IA_NOTE_AUTORIZZAZIONE, '
      '  IA_AUTORIZZAZIONE, '
      '  IA_AUTORIZZ_AUTOMATICA'
      'from VT850_T851_UL_A077'
      'where '
      '  PROGRESSIVO25 = :progressivo and'
      '  IA_DAL <= :data2 and '
      '  IA_AL >= :data1'
      'order by IA_DAL')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 156
    Top = 336
  end
  object selT050: TOracleDataSet
    SQL.Strings = (
      'select'
      'T050.CAUSALE IA_T050_CAUSALE,'
      'NVL(T265.DESCRIZIONE,T275.DESCRIZIONE) IA_T050_D_CAUSALE,'
      'T050.TIPOGIUST IA_T050_TIPO,'
      'T050.NUMEROORE IA_T050_DAORE,'
      'T050.AORE IA_T050_AORE,'
      'T050.DATANAS IA_T050_DATANASCITA,'
      'T050.ELABORATO IA_T050_ELABORATO,'
      'T050.TIPO_RICHIESTA IA_T050_TIPO_RICHIESTA'
      
        'from T050_RICHIESTEASSENZA T050, T265_CAUASSENZE T265, T275_CAUP' +
        'RESENZE T275'
      'where T050.CAUSALE = T265.CODICE(+)'
      'and T050.CAUSALE = T275.CODICE(+)'
      'and T050.ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 220
    Top = 336
  end
  object selT065: TOracleDataSet
    SQL.Strings = (
      'select '
      'DATA, '
      'TIPO             IA_T065_TIPO, '
      'ID_CONGUAGLIO    IA_T065_IDCONGUAGLIO,'
      'oreminuti(ORE_ECCED_CALC)   IA_T065_ECCED_CALC, '
      'oreminuti(ORE_ECCEDENTI)    IA_T065_ECCED_RICH, '
      'oreminuti(ORE_DACOMPENSARE) IA_T065_COMP_RICH,'
      'oreminuti(ORE_DALIQUIDARE)  IA_T065_LIQ_RICH,'
      
        'oreminuti(nvl(T852F_GETVALORE(T065.ID,-1,'#39'ORE_ECCEDENTI'#39'),ORE_EC' +
        'CEDENTI)) IA_T065_ECCED_AUT,'
      
        'oreminuti(nvl(T852F_GETVALORE(T065.ID,-1,'#39'ORE_DACOMPENSARE'#39'),ORE' +
        '_DACOMPENSARE)) IA_T065_COMP_AUT,'
      
        'oreminuti(nvl(T852F_GETVALORE(T065.ID,-1,'#39'ORE_DALIQUIDARE'#39'),ORE_' +
        'DALIQUIDARE)) IA_T065_LIQ_AUT'
      'from T065_RICHIESTESTRAORDINARI T065 '
      'where T065.ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 268
    Top = 336
  end
  object selT085: TOracleDataSet
    SQL.Strings = (
      'select'
      'DATA             IA_T085_GIORNO_ORIG,'
      'TIPOGIORNO       IA_T085_TIPOGIORNO_ORIG, '
      'ORARIO           IA_T085_ORARIO_ORIG, '
      'DATA_INVER       IA_T085_GIORNO_RICH,'
      'TIPOGIORNO_INVER IA_T085_TIPOGIORNO_RICH, '
      'ORARIO_INVER     IA_T085_ORARIO_RICH'
      'from T085_RICHIESTECAMBIORARI T085'
      'where T085.ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 316
    Top = 336
  end
  object selT105: TOracleDataSet
    SQL.Strings = (
      'select'
      'T105.OPERAZIONE IA_T105_OPERAZIONE,'
      'T105.CAUSALE_ORIG IA_T105_CAUS_ORIG,'
      'T105.CAUSALE IA_T105_CAUSALE,'
      'T105.VERSO_ORIG IA_T105_VERSO_ORIG,'
      'T105.VERSO IA_T105_VERSO,'
      'T105.ORA IA_T105_ORA,'
      'T105.ELABORATO IA_T105_ELABORATO'
      'from T105_RICHIESTETIMBRATURE T105'
      'where T105.ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 364
    Top = 336
  end
  object selT755: TOracleDataSet
    SQL.Strings = (
      'select '
      'T755.DATA, '
      'T750.CODICE      IA_T755_PROGETTO,'
      'T750.DESCRIZIONE IA_T755_D_PROGETTO,'
      'T750.ID          IA_T755_ID_PROGETTO,'
      'T751.CODICE      IA_T755_ATTIVITA,'
      'T751.DESCRIZIONE IA_T755_D_ATTIVITA,'
      'T751.ID          IA_T755_ID_ATTIVITA,'
      'T752.CODICE      IA_T755_TASK,'
      'T752.DESCRIZIONE IA_T755_D_TASK,'
      'T752.ID          IA_T755_ID_TASK,'
      '--oreminuti(T755.ORE)   IA_T755_ORE_RIC, '
      '--oreminuti(T852F_GETVALORE(T755.ID,-1,'#39'ORE'#39')) IA_T755_ORE_MOD, '
      
        '--oreminuti(decode(T850.STATO,'#39'S'#39',nvl(T852F_GETVALORE(T755.ID,-1' +
        ','#39'ORE'#39'),T755.ORE),'#39'0'#39')) IA_T755_ORE_AUT,'
      
        'oreminuti(nvl(T852F_GETVALORE(T755.ID,-1,'#39'ORE'#39'),T755.ORE)) IA_T7' +
        '55_ORE_RENDICONTATE'
      'from T755_RICHIESTE_RENDICONTO T755,'
      '     T850_ITER_RICHIESTE T850,'
      '     T752_TASK_RENDICONTO T752,'
      '     T751_ATTIVITA_RENDICONTO T751,'
      '     T750_PROGETTI_RENDICONTO T750'
      'where T755.ID = :ID'
      'and T755.ID = T850.ID'
      'and T755.ID_T752 = T752.ID'
      'and T752.ID_T751 = T751.ID'
      'and T751.ID_T750 = T750.ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 412
    Top = 336
  end
  object selCSI006: TOracleDataSet
    SQL.Strings = (
      'select A.*, IF_IMPORTO_ORE + IF_IMPORTO_MAG IF_IMPORTO_TOT'
      '  from ('
      '    select PROGRESSIVO26,'
      '           IF_DATA,'
      '           IF_CONTRATTO,'
      '           IF_FASCIA,'
      '           IF_INDFUNZIONE,'
      '           IF_TIMBRATURE,'
      '           IF_GIUSTIFICATIVI,'
      '           IF_ORARIO,'
      '           IF_ORE_ASSENZA,'
      '           IF_ORE_RESE,'
      '           IF_ORE_IND,'
      '           IF_IMPORTO,'
      
        '           NVL(ROUND(IF_ORE_IND/60 * IF_IMPORTO,2),0) IF_IMPORTO' +
        '_ORE,'
      '           IF_DISAGIO_SERALE,'
      '           IF_MAG_SER,'
      
        '           NVL(ROUND(IF_DISAGIO_SERALE/60 * IF_MAG_SER,2),0) IF_' +
        'IMPORTO_MAG'
      '      from ('
      '        select CSI006.PROGRESSIVO PROGRESSIVO26,'
      '               CSI006.DATA IF_DATA,'
      '               CSI006.TIMBRATURE IF_TIMBRATURE,'
      '               CSI006.GIUSTIFICATIVI IF_GIUSTIFICATIVI,'
      '               CSI006.ORARIO IF_ORARIO,'
      '               CSI006.ORE_ASSENZA IF_ORE_ASSENZA,'
      '               CSI006.ORE_RESE IF_ORE_RESE,'
      '               T430.CONTRATTO IF_CONTRATTO,'
      '               CSI007.FASCIA IF_FASCIA,'
      '               CSI007.INDFUNZIONE IF_INDFUNZIONE,'
      '               OREMINUTI(CSI007.ORE) IF_ORE_IND,'
      
        '               OREMINUTI(CSI007.DISAGIO_SERALE) IF_DISAGIO_SERAL' +
        'E'
      '          from CSI006_CART_INDFUNZIONE CSI006,'
      '               CSI007_CART_INDFUNZIONE_DETT CSI007,'
      '               T430_STORICO T430'
      '         where CSI006.ID = CSI007.ID'
      '           and CSI006.PROGRESSIVO = :PROGRESSIVO'
      '           and CSI006.DATA BETWEEN :DATA1 AND :DATA2'
      '           and CSI007.TIPO_RECORD = '#39'M'#39
      '           and T430.PROGRESSIVO = CSI006.PROGRESSIVO'
      
        '           and CSI006.DATA BETWEEN T430.DATADECORRENZA AND T430.' +
        'DATAFINE'
      '            ) INDFUNZ,'
      '           ('
      '        select CSI004.CODICE,'
      '               CSI004.CONTRATTO,'
      '               CSI004.DECORRENZA,'
      '               CSI004.DECORRENZA_FINE,'
      '               CSI005.FASCIA,'
      '               NVL(CSI005.IMPORTO,0) IF_IMPORTO,'
      '               NVL(CSI005.MAGG_DISAGIO_SERALE,0) IF_MAG_SER'
      '          from CSI004_INDFUNZIONE CSI004,'
      '               CSI005_INDFUNZIONE_FASCE CSI005'
      '         where :DATA1 <= CSI004.DECORRENZA_FINE'
      '           and :DATA2 >= CSI004.DECORRENZA'
      '           and CSI004.ID = CSI005.ID'
      '            ) REGOLE'
      
        '     where INDFUNZ.IF_DATA BETWEEN REGOLE.DECORRENZA (+) AND REG' +
        'OLE.DECORRENZA_FINE (+)'
      '       and REGOLE.CODICE (+) = INDFUNZ.IF_INDFUNZIONE'
      '       and REGOLE.CONTRATTO (+) = INDFUNZ.IF_CONTRATTO'
      '       and REGOLE.FASCIA (+) = INDFUNZ.IF_FASCIA'
      '        ) A'
      
        ' order by A.PROGRESSIVO26, A.IF_DATA, A.IF_FASCIA, A.IF_INDFUNZI' +
        'ONE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 628
    Top = 289
  end
end
