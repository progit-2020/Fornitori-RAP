inherited P554FElaborazioneContoAnnualeDtM: TP554FElaborazioneContoAnnualeDtM
  OldCreateOrder = True
  Height = 425
  Width = 667
  object selP555_ID: TOracleDataSet
    SQL.Strings = (
      'SELECT P555_ID_CONTOANN.NEXTVAL FROM DUAL'
      '  ')
    Optimize = False
    CommitOnPost = False
    Left = 154
    Top = 71
  end
  object selP554: TOracleDataSet
    SQL.Strings = (
      'SELECT ID_CONTOANN,CHIUSO FROM P554_CONTOANNTESTATE '
      '  WHERE ANNO = :Anno '
      '  AND COD_TABELLA = :CodTabella')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0005000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 26
    Top = 71
  end
  object insP554: TOracleQuery
    SQL.Strings = (
      'INSERT INTO P554_CONTOANNTESTATE'
      '  (ANNO, COD_TABELLA, ID_CONTOANN, CHIUSO)'
      'VALUES'
      '  (:Anno, :CodTabella, :IdCONTANN, '#39'N'#39')'
      '  ')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0005000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      0000000000000000140000003A004900440043004F004E00540041004E004E00
      030000000000000000000000}
    Left = 29
    Top = 129
  end
  object delP555: TOracleQuery
    SQL.Strings = (
      
        'DELETE P555_CONTOANNDATIINDIVIDUALI WHERE ID_CONTOANN IN (:IdFlu' +
        'ssi)'
      '  AND (PROGRESSIVO = :Progressivo OR PROGRESSIVO = -1)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A004900440046004C005500
      530053004900010000000000000000000000}
    Left = 80
    Top = 185
  end
  object updP554: TOracleQuery
    SQL.Strings = (
      'UPDATE P554_CONTOANNTESTATE '
      '  SET DATA_CHIUSURA = :DataChiusura, CHIUSO = '#39'S'#39
      '  WHERE ID_CONTOANN IN (:IdFlussi)')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A00440041005400410043004800490055005300
      5500520041000C0000000000000000000000120000003A004900440046004C00
      5500530053004900010000000000000000000000}
    Left = 98
    Top = 129
  end
  object delP554: TOracleQuery
    SQL.Strings = (
      'DELETE P554_CONTOANNTESTATE'
      ' WHERE ID_CONTOANN IN (:IdFlussi)'
      '   AND ID_CONTOANN NOT IN '
      ' '#9'(SELECT DISTINCT ID_CONTOANN '
      '          FROM P555_CONTOANNDATIINDIVIDUALI '
      '         WHERE ID_CONTOANN IN (:IdFlussi))')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A004900440046004C0055005300530049000100
      00000000000000000000}
    Left = 27
    Top = 185
  end
  object seleP554: TOracleDataSet
    SQL.Strings = (
      'SELECT ID_CONTOANN,COD_TABELLA FROM P554_CONTOANNTESTATE '
      '  WHERE ANNO = :Anno '
      '    AND CHIUSO IN (:Stato)'
      'ORDER BY COD_TABELLA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0005000000000000000000
      00000C0000003A0053005400410054004F00010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 90
    Top = 71
  end
  object selP552: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COD_TABELLA, DESCRIZIONE, DECODE(TIPO_TABELLA_RIGHE,'#39'3'#39','#39 +
        '1'#39',TIPO_TABELLA_RIGHE) TIPO_TABELLA_RIGHE, VALORE_COSTANTE'
      
        '  FROM P552_CONTOANNREGOLE WHERE RIGA = 0 AND COLONNA = 0 AND AN' +
        'NO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE ANNO <= :A' +
        'nnoElaborazione)'
      '  ORDER BY COD_TABELLA')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A0041004E004E004F0045004C00410042004F00
      520041005A0049004F004E004500050000000000000000000000}
    CommitOnPost = False
    Left = 154
    Top = 7
  end
  object selP552a: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT COD_TABELLA,SUBSTR(P552.NUMERO_TREDCORR,1,INSTR(' +
        'P552.NUMERO_TREDCORR,'#39'.'#39') -1) COD_TABELLA_CORRELATA FROM P552_CO' +
        'NTOANNREGOLE P552 '
      
        'WHERE ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE AN' +
        'NO <= :AnnoElaborazione)'
      
        ' AND INSTR(P552.NUMERO_TREDCORR,'#39'.'#39') > 0 AND SUBSTR(P552.NUMERO_' +
        'TREDCORR,1,INSTR(P552.NUMERO_TREDCORR,'#39'.'#39') -1) <> COD_TABELLA'
      'UNION'
      
        'SELECT DISTINCT COD_TABELLA,SUBSTR(P552.NUMERO_TREDPREC,1,INSTR(' +
        'P552.NUMERO_TREDPREC,'#39'.'#39') -1) COD_TABELLA_CORRELATA FROM P552_CO' +
        'NTOANNREGOLE P552 '
      
        'WHERE ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE AN' +
        'NO <= :AnnoElaborazione) '
      
        ' AND INSTR(P552.NUMERO_TREDPREC,'#39'.'#39') > 0 AND SUBSTR(P552.NUMERO_' +
        'TREDPREC,1,INSTR(P552.NUMERO_TREDPREC,'#39'.'#39') -1) <> COD_TABELLA'
      'UNION'
      
        'SELECT DISTINCT COD_TABELLA,SUBSTR(P552.NUMERO_ARRCORR,1,INSTR(P' +
        '552.NUMERO_ARRCORR,'#39'.'#39') -1) COD_TABELLA_CORRELATA FROM P552_CONT' +
        'OANNREGOLE P552 '
      
        'WHERE ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE AN' +
        'NO <= :AnnoElaborazione) '
      
        ' AND INSTR(P552.NUMERO_ARRCORR,'#39'.'#39') > 0 AND SUBSTR(P552.NUMERO_A' +
        'RRCORR,1,INSTR(P552.NUMERO_ARRCORR,'#39'.'#39') -1) <> COD_TABELLA'
      'UNION'
      
        'SELECT DISTINCT COD_TABELLA,SUBSTR(P552.NUMERO_ARRPREC,1,INSTR(P' +
        '552.NUMERO_ARRPREC,'#39'.'#39') -1) COD_TABELLA_CORRELATA FROM P552_CONT' +
        'OANNREGOLE P552 '
      
        'WHERE ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE AN' +
        'NO <= :AnnoElaborazione) '
      
        ' AND INSTR(P552.NUMERO_ARRPREC,'#39'.'#39') > 0 AND SUBSTR(P552.NUMERO_A' +
        'RRPREC,1,INSTR(P552.NUMERO_ARRPREC,'#39'.'#39') -1) <> COD_TABELLA')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A0041004E004E004F0045004C00410042004F00
      520041005A0049004F004E004500050000000000000000000000}
    CommitOnPost = False
    Left = 218
    Top = 7
  end
  object delP555a: TOracleQuery
    SQL.Strings = (
      
        'DELETE P555_CONTOANNDATIINDIVIDUALI WHERE ID_CONTOANN IN (:IdFlu' +
        'ssi)'
      '  AND PROGRESSIVO = :Progressivo')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A004900440046004C005500
      530053004900010000000000000000000000}
    Left = 152
    Top = 185
  end
  object delP555b: TOracleQuery
    SQL.Strings = (
      
        'DELETE P555_CONTOANNDATIINDIVIDUALI WHERE ID_CONTOANN = :IdCONTA' +
        'NN AND PROGRESSIVO = -1')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004900440043004F004E00540041004E004E00
      030000000000000000000000}
    Left = 230
    Top = 187
  end
  object insP555: TOracleQuery
    SQL.Strings = (
      'INSERT INTO P555_CONTOANNDATIINDIVIDUALI'
      '  (ID_CONTOANN, PROGRESSIVO, RIGA, COLONNA, VALORE)'
      'VALUES'
      '  (:IdCONTANN, -1, :Riga, :Colonna, :Valore)')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A004900440043004F004E00540041004E004E00
      0300000000000000000000000A0000003A005200490047004100030000000000
      000000000000100000003A0043004F004C004F004E004E004100030000000000
      0000000000000E0000003A00560041004C004F00520045000400000000000000
      00000000}
    Left = 165
    Top = 130
  end
  object selP050: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.VALORE,P050.TIPO'
      'FROM P050_ARROTONDAMENTI P050 WHERE'
      'P050.COD_ARROTONDAMENTO = :CodArrotondamento AND '
      'P050.COD_VALUTA = :CodValuta AND'
      
        'P050.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P050_ARROTONDAMEN' +
        'TI'
      
        '   WHERE DECORRENZA <= :Decorrenza AND COD_ARROTONDAMENTO = :Cod' +
        'Arrotondamento AND '
      '   COD_VALUTA = :CodValuta)')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000240000003A0043004F004400410052005200
      4F0054004F004E00440041004D0045004E0054004F0005000000000000000000
      0000140000003A0043004F004400560041004C00550054004100050000000000
      000000000000}
    CommitOnPost = False
    Left = 26
    Top = 7
  end
  object selP500: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM P500_CUDSETUP'
      
        '  WHERE ANNO = (SELECT MAX(ANNO) FROM P500_CUDSETUP WHERE ANNO <' +
        '= :Anno)')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 90
    Top = 7
  end
  object selP555: TOracleDataSet
    SQL.Strings = (
      
        'SELECT :IdCONTANN, -1, RIGA,COLONNA,SUM(VALORE) DATO FROM P555_C' +
        'ONTOANNDATIINDIVIDUALI'
      '  WHERE ID_CONTOANN = :IdCONTANN'
      '  GROUP BY RIGA,COLONNA'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004900440043004F004E00540041004E004E00
      030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 218
    Top = 71
  end
  object selP552b: TOracleDataSet
    SQL.Strings = (
      '-- Estraggo codice arrotondamento'
      'SELECT COD_TABELLA, RIGA, COLONNA, COD_ARROTONDAMENTO'
      '  FROM P552_CONTOANNREGOLE P552'
      
        '  WHERE ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHERE ' +
        'ANNO <= :AnnoElaborazione) '
      
        '  AND ((EXISTS (SELECT '#39'*'#39' FROM P552_CONTOANNREGOLE P552A WHERE ' +
        'P552A.ANNO = P552.ANNO'
      
        '  AND P552A.COD_TABELLA = P552.COD_TABELLA AND RIGA = 0 AND COLO' +
        'NNA = 0 AND TIPO_TABELLA_RIGHE IN('#39'0'#39','#39'1'#39','#39'3'#39'))'
      '  AND RIGA = 0 AND COLONNA > 0)'
      '    OR '
      
        '  (EXISTS (SELECT '#39'*'#39' FROM P552_CONTOANNREGOLE P552A WHERE P552A' +
        '.ANNO = P552.ANNO'
      
        '  AND P552A.COD_TABELLA = P552.COD_TABELLA AND RIGA = 0 AND COLO' +
        'NNA = 0 AND TIPO_TABELLA_RIGHE = '#39'2'#39')'
      '  AND RIGA > 0 AND COLONNA = 0))'
      '  AND COD_ARROTONDAMENTO IS NOT NULL'
      '  ORDER BY COD_TABELLA,RIGA,COLONNA')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A0041004E004E004F0045004C00410042004F00
      520041005A0049004F004E004500050000000000000000000000}
    CommitOnPost = False
    Left = 282
    Top = 7
  end
  object selP555a: TOracleDataSet
    SQL.Strings = (
      
        'SELECT P555.RIGA,P552.VALORE_COSTANTE,VALORE DATO FROM P555_CONT' +
        'OANNDATIINDIVIDUALI P555,'
      
        '  P554_CONTOANNTESTATE P554, P552_CONTOANNREGOLE P552, T470_QUAL' +
        'IFICAMINIST T470'
      '  WHERE P555.ID_CONTOANN = :IdCONTANN '
      '  AND P555.ID_CONTOANN = P554.ID_CONTOANN'
      '  AND P554.COD_TABELLA = :CodTabella '
      '  AND P554.ANNO = :AnnoElaborazione'
      '  AND P555.COLONNA = :Colonna'
      '  AND P554.COD_TABELLA = P552.COD_TABELLA '
      
        '  AND P552.ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WHE' +
        'RE ANNO <= :AnnoElaborazione)'
      '  AND P552.COLONNA = 0'
      '  AND PROGRESSIVO = -1'
      '  AND P552.RIGA = P555.RIGA'
      '  AND T470.CODICE = P552.VALORE_COSTANTE'
      '  AND T470.MACRO_CATEG_QM = :MacroCateg'
      
        '  AND TO_DATE('#39'3112'#39'||:AnnoElaborazione,'#39'DDMMYYYY'#39') BETWEEN T470' +
        '.DECORRENZA AND T470.DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000005000000140000003A004900440043004F004E00540041004E004E00
      030000000000000000000000160000003A0043004F0044005400410042004500
      4C004C004100050000000000000000000000220000003A0041004E004E004F00
      45004C00410042004F00520041005A0049004F004E0045000500000000000000
      00000000100000003A0043004F004C004F004E004E0041000300000000000000
      00000000160000003A004D004100430052004F00430041005400450047000500
      00000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 346
    Top = 71
  end
  object selP555b: TOracleDataSet
    SQL.Strings = (
      
        'SELECT :MacroCateg, :ImportoResiduo,SUM(DATO),DECODE(SUM(DATO),0' +
        ',0,:ImportoResiduo/SUM(DATO)) PERC_RIDISTR'
      '  FROM T470_QUALIFICAMINIST T470,'
      
        '  (SELECT P552.VALORE_COSTANTE,SUM(VALORE) DATO FROM P555_CONTOA' +
        'NNDATIINDIVIDUALI P555,'
      '   P554_CONTOANNTESTATE P554, P552_CONTOANNREGOLE P552'
      '   WHERE P555.ID_CONTOANN = :IdCONTANN '
      '   AND P555.ID_CONTOANN = P554.ID_CONTOANN'
      '   AND P554.COD_TABELLA = :CodTabella '
      '   AND P554.ANNO = :AnnoElaborazione'
      '   AND P555.COLONNA = :Colonna'
      '   AND P554.COD_TABELLA = P552.COD_TABELLA '
      
        '   AND P552.ANNO = (SELECT MAX(ANNO) FROM P552_CONTOANNREGOLE WH' +
        'ERE ANNO <= :AnnoElaborazione)'
      '   AND P552.COLONNA = 0'
      '   AND PROGRESSIVO = -1'
      '   AND P552.RIGA = P555.RIGA'
      '   GROUP BY P552.VALORE_COSTANTE'
      '   ) TAB1'
      '  WHERE T470.CODICE = TAB1.VALORE_COSTANTE'
      '  AND T470.MACRO_CATEG_QM = :MacroCateg'
      
        '  AND TO_DATE('#39'3112'#39'||:AnnoElaborazione,'#39'DDMMYYYY'#39') BETWEEN T470' +
        '.DECORRENZA AND T470.DECORRENZA_FINE'
      '  GROUP BY :MacroCateg, :ImportoResiduo'
      '')
    Optimize = False
    Variables.Data = {
      0400000006000000140000003A004900440043004F004E00540041004E004E00
      030000000000000000000000160000003A0043004F0044005400410042004500
      4C004C004100050000000000000000000000160000003A004D00410043005200
      4F00430041005400450047000500000000000000000000001E0000003A004900
      4D0050004F00520054004F005200450053004900440055004F00040000000000
      000000000000220000003A0041004E004E004F0045004C00410042004F005200
      41005A0049004F004E004500050000000000000000000000100000003A004300
      4F004C004F004E004E004100030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 410
    Top = 71
  end
  object selP553: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COLONNA_RIGA, MACRO_CATEG, IMPORTO_RESIDUO, COD_TABELLA_Q' +
        'UOTE, COLONNA_QUOTE'
      
        '  FROM P553_CONTOANNRISORRES WHERE ANNO = :AnnoElaborazione AND ' +
        'COD_TABELLA = :CodTabella')
    Optimize = False
    Variables.Data = {
      0400000002000000220000003A0041004E004E004F0045004C00410042004F00
      520041005A0049004F004E004500050000000000000000000000160000003A00
      43004F00440054004100420045004C004C004100050000000000000000000000}
    CommitOnPost = False
    Left = 346
    Top = 7
  end
  object updP555: TOracleQuery
    SQL.Strings = (
      'UPDATE P555_CONTOANNDATIINDIVIDUALI '
      '  SET VALORE = VALORE + :ImportoResiduo'
      
        '  WHERE ID_CONTOANN = :IdCONTANN AND PROGRESSIVO = -1 AND RIGA =' +
        ' :Riga AND COLONNA = :Colonna')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A004900440043004F004E00540041004E004E00
      0300000000000000000000000A0000003A005200490047004100030000000000
      0000000000001E0000003A0049004D0050004F00520054004F00520045005300
      4900440055004F00040000000000000000000000100000003A0043004F004C00
      4F004E004E004100030000000000000000000000}
    Left = 229
    Top = 130
  end
  object selP555Esporta: TOracleDataSet
    SQL.Strings = (
      
        'select p554.anno, p554.cod_tabella, p555.riga, p552R.Valore_Cost' +
        'ante,p555.colonna, p552C.Descrizione, p555.valore, p552C.Cod_Arr' +
        'otondamento'
      
        'from p555_contoanndatiindividuali p555, p554_contoanntestate p55' +
        '4, p552_contoannregole p552R, p552_contoannregole p552C'
      'where p555.id_contoann = :ID_CONTOANN'
      '  and p555.progressivo = -1'
      '  and p555.id_contoann = p554.id_contoann'
      '  and :ANNOREGOLE = p552R.anno '
      '  and p554.cod_tabella = p552R.cod_tabella'
      '  and p555.riga = p552R.riga'
      '  and p552R.colonna = 0'
      '  and :ANNOREGOLE = p552C.anno '
      '  and p554.cod_tabella = p552C.cod_tabella'
      '  and p555.colonna = p552C.colonna'
      '  and p552C.riga = 0'
      'order by p555.riga, p555.colonna')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00490044005F0043004F004E0054004F004100
      4E004E00030000000000000000000000160000003A0041004E004E004F005200
      450047004F004C004500030000000000000000000000}
    Left = 520
    Top = 8
  end
  object selP551: TOracleDataSet
    SQL.Strings = (
      'select * from p551_contoannfile p551'
      'where anno = :ANNO'
      '  and cod_tabella = :TABELLA'
      'order by num_campo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000100000003A0054004100420045004C004C00410005000000000000000000
      0000}
    Left = 520
    Top = 104
  end
  object selP555Righe: TOracleDataSet
    SQL.Strings = (
      'select distinct p555.riga, p552R.Valore_Costante'
      
        'from p555_contoanndatiindividuali p555, p554_contoanntestate p55' +
        '4, p552_contoannregole p552R'
      'where p555.id_contoann = :ID_CONTOANN'
      '  and p555.progressivo = -1'
      '  and p555.id_contoann = p554.id_contoann'
      '--  and p554.anno = p552R.anno '
      '  and :ANNOREGOLE = p552R.anno '
      '  and p554.cod_tabella = p552R.cod_tabella'
      '  and p555.riga = p552R.riga'
      '  and p552R.colonna = 0'
      'order by p555.riga'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00490044005F0043004F004E0054004F004100
      4E004E00030000000000000000000000160000003A0041004E004E004F005200
      450047004F004C004500030000000000000000000000}
    Left = 520
    Top = 56
  end
  object selQuery: TOracleDataSet
    Optimize = False
    Left = 536
    Top = 168
  end
  object selP551Formato: TOracleDataSet
    SQL.Strings = (
      'select FORMATO from p551_contoannfile p551'
      'where anno = :ANNO'
      '  and cod_tabella = :TABELLA'
      '  and tipo_campo = :TIPOCAMPO'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000100000003A0054004100420045004C004C00410005000000000000000000
      0000140000003A005400490050004F00430041004D0050004F00050000000000
      000000000000}
    Left = 448
    Top = 168
  end
end
