inherited A087FImpAttestatiMalMW: TA087FImpAttestatiMalMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 398
  Width = 520
  object selEsenzioni: TOracleQuery
    Optimize = False
    Left = 301
    Top = 175
  end
  object selT040_del: TOracleDataSet
    SQL.Strings = (
      'SELECT T040.PROGRESSIVO, T040.DATA, T040.CAUSALE'
      '  FROM T040_GIUSTIFICATIVI T040'
      ' WHERE T040.PROGRESSIVO = :INPROG'
      '   AND T040.DATA BETWEEN :INDATADA AND :INDATAA'
      '   AND T040.CAUSALE = :INCAUSALE'
      ' ORDER BY T040.DATA DESC')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0049004E00500052004F004700030000000000
      000000000000120000003A0049004E004400410054004100440041000C000000
      0000000000000000100000003A0049004E00440041005400410041000C000000
      0000000000000000140000003A0049004E00430041005500530041004C004500
      050000000000000000000000}
    Left = 238
    Top = 175
  end
  object selT048: TOracleDataSet
    SQL.Strings = (
      'SELECT T048.*, T030.COGNOME, T030.NOME, T030.CODFISCALE'
      '  FROM T048_ATTESTATIINPS T048, T030_ANAGRAFICO T030'
      ' WHERE T030.PROGRESSIVO = T048.PROGRESSIVO'
      '   AND T048.TIPO_ELEMENTO = :TELEMENTO'
      '   AND T048.ID_CERTIFICATO = :ID_CERTIFICATO')
    Optimize = False
    Variables.Data = {
      04000000020000001E0000003A00490044005F00430045005200540049004600
      49004300410054004F00050000000000000000000000140000003A0054004500
      4C0045004D0045004E0054004F00050000000000000000000000}
    CommitOnPost = False
    Left = 294
    Top = 14
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT T030.*, decode(INIZIO,null,'#39'N'#39','#39'S'#39') IN_SERVIZIO'
      '  from T030_ANAGRAFICO T030, T430_STORICO T430'
      ' where T030.CODFISCALE IS NOT NULL'
      '   and T030.PROGRESSIVO = T430.PROGRESSIVO(+)'
      
        '   and :DATAIN BETWEEN T430.INIZIO(+) AND NVL(T430.FINE(+),TO_DA' +
        'TE('#39'31/12/3999'#39','#39'DD/MM/YYYY'#39'))'
      '   and UPPER(TRIM(T030.CODFISCALE)) = UPPER(TRIM(:CODFISC))')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00440041005400410049004E000C0000000000
      000000000000100000003A0043004F0044004600490053004300050000000000
      000000000000}
    CommitOnPost = False
    Left = 252
    Top = 14
  end
  object InsT048: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO T048_ATTESTATIINPS (PROGRESSIVO, DATA_REGISTRAZIONE,' +
        ' OPERATORE, CAUSALE_MAL, TIPO_ELEMENTO, '
      
        '                                ID_CERTIFICATO, COD_FISCALE_AZIE' +
        'NDA, MATRICOLA_INPS, COD_SEDE_INPDAP, '
      
        '                                COD_FISCALE_MED, COGNOME_MED, NO' +
        'ME_MED, COD_REGIONE, COD_ASL, COD_FISCALE, '
      
        '                                COGNOME, NOME, SESSO, DATA_NAS, ' +
        'CODCATASTALE_NAS, PROV_NAS, VIA_DOM, '
      
        '                                CAP_DOM, CODCATASTALE_DOM, PROV_' +
        'DOM, COGNOME_REP, VIA_REP, CAP_REP, '
      
        '                                CODCATASTALE_REP, PROV_REP, DATA' +
        '_RILASCIO, DATA_INIZIO_MAL, DATA_FINE_MAL, '
      
        '                                COD_DIAGNOSI, TESTO_DIAGNOSI, TI' +
        'PO_CERTIFICATO, ID_CERTIFICATO_RETT,'
      
        '                                CIVICO_REP, CIVICO_DOM, RUOLOMED' +
        'ICO, CODSTRUTTURA_MED, GIORNATALAVORATA,'
      
        '                                TRAUMA, AGEVOLAZIONI, DATA_FINEP' +
        'OSTRIC, TIPO_RICOVERO, CAUSALE_POSTRIC,'
      
        '                                TIPO_GESTIONE, DATA_CONSEGNA, CA' +
        'USA_MALATTIA, TIPO_REGISTRAZIONE, '
      
        '                                ID_FILETXT, NUM_PROTOCOLLO, NOTE' +
        ')'
      
        '     VALUES (:PROGRESSIVO, :DATA_REGISTRAZIONE, :OPERATORE, :CAU' +
        'SALE_MAL, :TIPO_ELEMENTO, '
      
        '             :ID_CERTIFICATO, :COD_FISCALE_AZIENDA, :MATRICOLA_I' +
        'NPS, :COD_SEDE_INPDAP, '
      
        '             :COD_FISCALE_MED, :COGNOME_MED, :NOME_MED, :COD_REG' +
        'IONE, :COD_ASL, :COD_FISCALE, '
      
        '             :COGNOME, :NOME, :SESSO, :DATA_NAS, :CODCATASTALE_N' +
        'AS, :PROV_NAS, :VIA_DOM, '
      
        '             :CAP_DOM, :CODCATASTALE_DOM, :PROV_DOM, :COGNOME_RE' +
        'P, :VIA_REP, :CAP_REP, '
      
        '             :CODCATASTALE_REP, :PROV_REP, :DATA_RILASCIO, :DATA' +
        '_INIZIO_MAL, :DATA_FINE_MAL, '
      
        '             :COD_DIAGNOSI, :TESTO_DIAGNOSI, :TIPO_CERTIFICATO, ' +
        ':ID_CERTIFICATO_RETT,'
      
        '             :CIVICO_REP, :CIVICO_DOM, :RUOLOMEDICO, :CODSTRUTTU' +
        'RA_MED, :GIORNATALAVORATA,'
      
        '             :TRAUMA, :AGEVOLAZIONI, :DATA_FINEPOSTRIC, :TIPO_RI' +
        'COVERO, :CAUSALE_POSTRIC,'
      
        '             :TIPO_GESTIONE, :DATA_CONSEGNA, :CAUSA_MALATTIA, :T' +
        'IPO_REGISTRAZIONE, '
      '             :ID_FILETXT, :NUM_PROTOCOLLO, :NOTE) ')
    Optimize = False
    Variables.Data = {
      0400000036000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000260000003A0044004100540041005F00
      520045004700490053005400520041005A0049004F004E0045000C0000000000
      000000000000140000003A004F00500045005200410054004F00520045000500
      00000000000000000000180000003A00430041005500530041004C0045005F00
      4D0041004C000500000000000000000000001C0000003A005400490050004F00
      5F0045004C0045004D0045004E0054004F000500000000000000000000001E00
      00003A00490044005F0043004500520054004900460049004300410054004F00
      050000000000000000000000280000003A0043004F0044005F00460049005300
      430041004C0045005F0041005A00490045004E00440041000500000000000000
      000000001E0000003A004D00410054005200490043004F004C0041005F004900
      4E0050005300050000000000000000000000200000003A0043004F0044005F00
      53004500440045005F0049004E00500044004100500005000000000000000000
      0000200000003A0043004F0044005F00460049005300430041004C0045005F00
      4D0045004400050000000000000000000000180000003A0043004F0047004E00
      4F004D0045005F004D0045004400050000000000000000000000120000003A00
      4E004F004D0045005F004D004500440005000000000000000000000018000000
      3A0043004F0044005F0052004500470049004F004E0045000500000000000000
      00000000100000003A0043004F0044005F00410053004C000500000000000000
      00000000180000003A0043004F0044005F00460049005300430041004C004500
      050000000000000000000000100000003A0043004F0047004E004F004D004500
      0500000000000000000000000A0000003A004E004F004D004500050000000000
      0000000000000C0000003A0053004500530053004F0005000000000000000000
      0000120000003A0044004100540041005F004E00410053000C00000000000000
      00000000220000003A0043004F00440043004100540041005300540041004C00
      45005F004E0041005300050000000000000000000000120000003A0050005200
      4F0056005F004E0041005300050000000000000000000000100000003A005600
      490041005F0044004F004D00050000000000000000000000100000003A004300
      410050005F0044004F004D00050000000000000000000000220000003A004300
      4F00440043004100540041005300540041004C0045005F0044004F004D000500
      00000000000000000000120000003A00500052004F0056005F0044004F004D00
      050000000000000000000000180000003A0043004F0047004E004F004D004500
      5F00520045005000050000000000000000000000100000003A00560049004100
      5F00520045005000050000000000000000000000100000003A00430041005000
      5F00520045005000050000000000000000000000220000003A0043004F004400
      43004100540041005300540041004C0045005F00520045005000050000000000
      000000000000120000003A00500052004F0056005F0052004500500005000000
      00000000000000001C0000003A0044004100540041005F00520049004C004100
      5300430049004F000C0000000000000000000000200000003A00440041005400
      41005F0049004E0049005A0049004F005F004D0041004C000C00000000000000
      000000001C0000003A0044004100540041005F00460049004E0045005F004D00
      41004C000C00000000000000000000001A0000003A0043004F0044005F004400
      4900410047004E004F00530049000500000000000000000000001E0000003A00
      54004500530054004F005F0044004900410047004E004F005300490005000000
      0000000000000000220000003A005400490050004F005F004300450052005400
      4900460049004300410054004F00050000000000000000000000280000003A00
      490044005F0043004500520054004900460049004300410054004F005F005200
      450054005400050000000000000000000000160000003A004300490056004900
      43004F005F00520045005000050000000000000000000000160000003A004300
      49005600490043004F005F0044004F004D000500000000000000000000001800
      00003A00520055004F004C004F004D0045004400490043004F00050000000000
      000000000000220000003A0043004F0044005300540052005500540054005500
      520041005F004D0045004400050000000000000000000000220000003A004700
      49004F0052004E004100540041004C00410056004F0052004100540041000500
      000000000000000000000E0000003A0054005200410055004D00410005000000
      00000000000000001A0000003A0041004700450056004F004C0041005A004900
      4F004E004900050000000000000000000000220000003A004400410054004100
      5F00460049004E00450050004F00530054005200490043000C00000000000000
      000000001C0000003A005400490050004F005F005200490043004F0056004500
      52004F00050000000000000000000000200000003A0043004100550053004100
      4C0045005F0050004F0053005400520049004300050000000000000000000000
      1C0000003A005400490050004F005F00470045005300540049004F004E004500
      0500000000000000000000001C0000003A0044004100540041005F0043004F00
      4E005300450047004E0041000C00000000000000000000001E0000003A004300
      41005500530041005F004D0041004C0041005400540049004100050000000000
      0000000000000A0000003A004E004F0054004500050000000000000000000000
      260000003A005400490050004F005F0052004500470049005300540052004100
      5A0049004F004E004500050000000000000000000000160000003A0049004400
      5F00460049004C0045005400580054000500000000000000000000001E000000
      3A004E0055004D005F00500052004F0054004F0043004F004C004C004F000500
      00000000000000000000}
    Left = 203
    Top = 14
  end
  object delT048: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM T048_ATTESTATIINPS T048'
      ' WHERE T048.ID_CERTIFICATO = :ID'
      '   AND T048.TIPO_ELEMENTO = :TIPO')
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000500000000000000000000000A00
      00003A005400490050004F00050000000000000000000000}
    Left = 147
    Top = 70
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, T048.DATA_INIZ' +
        'IO_MAL, T048.DATA_FINE_MAL, T048.CAUSALE_MAL'
      '  FROM T040_GIUSTIFICATIVI T040, T048_ATTESTATIINPS T048'
      ' WHERE 1 = 1'
      '   AND T040.ID_CERTIFICATO = T048.ID_CERTIFICATO'
      '   AND T048.ID_CERTIFICATO = :ID'
      '   AND T048.TIPO_ELEMENTO in ('#39'I'#39','#39'D'#39','#39'R'#39')'
      ' ORDER BY T040.DATA DESC')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400050000000000000000000000}
    CommitOnPost = False
    Left = 91
    Top = 70
  end
  object delT040: TOracleQuery
    SQL.Strings = (
      'DELETE'
      '  FROM T040_GIUSTIFICATIVI T040'
      ' WHERE T040.ID_CERTIFICATO = :ID_CERTIFICATO')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A00490044005F00430045005200540049004600
      49004300410054004F00050000000000000000000000}
    Left = 91
    Top = 127
  end
  object updT048: TOracleQuery
    SQL.Strings = (
      'UPDATE T048_ATTESTATIINPS T048'
      '   SET T048.ELABORATO = '#39'S'#39
      ' WHERE T048.ID_CERTIFICATO = :IDCERTIFICATO'
      '   AND T048.TIPO_ELEMENTO = :TELEMENTO')
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A00490044004300450052005400490046004900
      4300410054004F00050000000000000000000000140000003A00540045004C00
      45004D0045004E0054004F00050000000000000000000000}
    Left = 147
    Top = 127
  end
  object selT048ContinuaMal: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  BEGIN '
      '    --LETTURA CERTIFICATI PREESISTENTI'
      
        '    SELECT MAX(T048_PREC.DATA_FINE_MAL) INTO :NUOVA_DATA_INIZIO_' +
        'MAL'
      
        '      FROM T048_ATTESTATIINPS T048_C, T048_ATTESTATIINPS T048_PR' +
        'EC'
      '     WHERE T048_C.TIPO_CERTIFICATO = '#39'C'#39
      '       AND T048_C.ID_CERTIFICATO = :ID_CERTIFICATO'
      '       AND T048_C.ID_CERTIFICATO_RETT IS NULL'
      '       AND T048_PREC.ID_CERTIFICATO <> T048_C.ID_CERTIFICATO'
      '       AND T048_C.PROGRESSIVO = T048_PREC.PROGRESSIVO'
      
        '       AND T048_PREC.DATA_FINE_MAL BETWEEN T048_C.DATA_INIZIO_MA' +
        'L AND T048_C.DATA_FINE_MAL'
      '       AND T048_PREC.ELABORATO = '#39'S'#39'   '
      '       AND NOT EXISTS (SELECT '#39'X'#39' '
      '                         FROM T048_ATTESTATIINPS '
      '                        WHERE TIPO_ELEMENTO = '#39'C'#39' '
      
        '                          AND ID_CERTIFICATO = T048_PREC.ID_CERT' +
        'IFICATO'
      '                          AND ELABORATO = '#39'S'#39')'
      '       AND NOT EXISTS (SELECT '#39'X'#39' '
      '                         FROM T048_ATTESTATIINPS '
      
        '                        WHERE ID_CERTIFICATO_RETT = T048_PREC.ID' +
        '_CERTIFICATO'
      '                          AND ELABORATO = '#39'S'#39')'
      '     GROUP BY T048_C.ID_CERTIFICATO;'
      '   EXCEPTION'
      '     WHEN NO_DATA_FOUND THEN'
      '       :NUOVA_DATA_INIZIO_MAL:=NULL;'
      '   END;    '
      '   '
      '  IF :NUOVA_DATA_INIZIO_MAL IS NULL THEN'
      '    BEGIN    '
      
        '      --SE NON ESISTONO CERTIFICATI PREESISTENTI SI LEGGONO COMU' +
        'NQUE LE CAUSALI INSERITE SULLA T040'
      '      SELECT MAX(T040.DATA) INTO :NUOVA_DATA_INIZIO_MAL'
      '        FROM T040_GIUSTIFICATIVI T040'
      '       WHERE T040.PROGRESSIVO = :PROGRESSIVO'
      
        '         AND T040.DATA BETWEEN :DATA_INIZIO_MAL AND :DATA_FINE_M' +
        'AL'
      '         AND T040.CAUSALE IN (:CHAIN_CAUSALI)'
      '         AND T040.DATA IS NOT NULL;'
      '     EXCEPTION '
      '       WHEN NO_DATA_FOUND THEN'
      '         :NUOVA_DATA_INIZIO_MAL:=NULL;'
      '     END;    '
      '  END IF;'
      '  IF :NUOVA_DATA_INIZIO_MAL IS NOT NULL THEN'
      '    :NUOVA_DATA_INIZIO_MAL:=:NUOVA_DATA_INIZIO_MAL + 1;'
      '  END IF;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000060000002C0000003A004E0055004F00560041005F00440041005400
      41005F0049004E0049005A0049004F005F004D0041004C000C00000000000000
      000000001E0000003A00490044005F0043004500520054004900460049004300
      410054004F00050000000000000000000000180000003A00500052004F004700
      5200450053005300490056004F00030000000000000000000000200000003A00
      44004100540041005F0049004E0049005A0049004F005F004D0041004C000C00
      000000000000000000001C0000003A0044004100540041005F00460049004E00
      45005F004D0041004C000C00000000000000000000001C0000003A0043004800
      410049004E005F00430041005500530041004C00490001000000000000000000
      0000}
    Left = 224
    Top = 127
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'SELECT T480.*'
      '  FROM T480_COMUNI T480')
    ReadBuffer = 1000
    Optimize = False
    CommitOnPost = False
    Left = 224
    Top = 70
  end
  object XMLDoc: TXMLDocument
    FileName = 'Z:\Normativa\Rilevazione presenze\Inps\attestati_07102010.xml'
    ParseOptions = [poResolveExternals, poValidateOnParse]
    Left = 91
    Top = 14
    DOMVendorDesc = 'MSXML'
  end
  object dscLookT265: TDataSource
    DataSet = cdsLookT265
    Left = 397
    Top = 127
  end
  object dscT265_All: TDataSource
    DataSet = selT265_All
    Left = 175
    Top = 175
  end
  object selT265_All: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE, T265.DESCRIZIONE'
      '  FROM T265_CAUASSENZE T265'
      ' ORDER BY T265.CODICE, T265.DESCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Left = 112
    Top = 175
  end
  object dscT265: TDataSource
    DataSet = selT265
    Left = 294
    Top = 127
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE, T265.DESCRIZIONE, T265.TIPOCUMULO'
      '  FROM T265_CAUASSENZE T265 '
      ' WHERE T265.VISITA_FISCALE = '#39'S'#39
      'ORDER BY T265.CODICE ')
    Optimize = False
    Left = 294
    Top = 70
    object selT265CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT265TIPOCUMULO: TStringField
      FieldName = 'TIPOCUMULO'
    end
  end
  object cdsLookT265: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODICE_ALL'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODICE_RICOVERO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODICE_POSTRIC'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODICE_TSALVAVITA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODICE_SERVIZIO'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 397
    Top = 70
    object cdsLookT265CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object cdsLookT265D_CODICE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODICE'
      LookupDataSet = selT265
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object cdsLookT265CODICE_ALL: TStringField
      FieldName = 'CODICE_ALL'
      Size = 5
    end
    object cdsLookT265D_CODICE_ALL: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODICE_ALL'
      LookupDataSet = selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE_ALL'
      OnValidate = cdsLookT265D_CODICE_ALLValidate
      Size = 40
      Lookup = True
    end
    object cdsLookT265CODICE_RICOVERO: TStringField
      FieldName = 'CODICE_RICOVERO'
      Size = 5
    end
    object cdsLookT265DESC_RICOVERO: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_RICOVERO'
      LookupDataSet = selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE_RICOVERO'
      Lookup = True
    end
    object cdsLookT265CODICE_POSTRIC: TStringField
      FieldName = 'CODICE_POSTRIC'
      Size = 5
    end
    object cdsLookT265DESC_POSTRIC: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_POSTRIC'
      LookupDataSet = selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE_POSTRIC'
      Size = 50
      Lookup = True
    end
    object cdsLookT265CODICE_TSALVAVITA: TStringField
      FieldName = 'CODICE_TSALVAVITA'
      Size = 5
    end
    object cdsLookT265DESC_TSALVAVITA: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_TSALVAVITA'
      LookupDataSet = selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE_TSALVAVITA'
      Size = 50
      Lookup = True
    end
    object cdsLookT265CODICE_SERVIZIO: TStringField
      FieldName = 'CODICE_SERVIZIO'
      Size = 5
    end
    object cdsLookT265DESC_SERVIZIO: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_SERVIZIO'
      LookupDataSet = selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE_SERVIZIO'
      Size = 50
      Lookup = True
    end
  end
  object CDtsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = CDtsTempFilterRecord
    Left = 147
    Top = 14
  end
  object selT269: TOracleDataSet
    SQL.Strings = (
      'select T269.*'
      '  from T269_RELAZIONI_ATTESTATIINPS T269'
      ' order by decode(T269.FILTRO,null,1,0), T269.CODICE')
    Optimize = False
    Left = 40
    Top = 16
    object selT269CODICE: TStringField
      DisplayLabel = 'Profilo'
      DisplayWidth = 10
      FieldName = 'CODICE'
    end
    object selT269FILTRO: TStringField
      DisplayLabel = 'Selezione'
      DisplayWidth = 25
      FieldName = 'FILTRO'
      Size = 2000
    end
    object selT269CAUS_PROVVISORIA: TStringField
      DisplayLabel = 'Causale provvisoria'
      FieldName = 'CAUS_PROVVISORIA'
      Size = 5
    end
    object selT269CAUS_INSERIMENTO: TStringField
      DisplayLabel = 'Causale di inserimento'
      FieldName = 'CAUS_INSERIMENTO'
      Size = 5
    end
    object selT269CAUS_RICOVERO: TStringField
      DisplayLabel = 'Causale di ricovero'
      FieldName = 'CAUS_RICOVERO'
      Size = 5
    end
    object selT269CAUS_POSTRICOVERO: TStringField
      DisplayLabel = 'Causale post-ricovero'
      FieldName = 'CAUS_POSTRICOVERO'
    end
    object selT269CAUS_SALVAVITA: TStringField
      DisplayLabel = 'Causale salva-vita'
      FieldName = 'CAUS_SALVAVITA'
      Size = 5
    end
    object selT269CAUS_SERVIZIO: TStringField
      DisplayLabel = 'Causale di servizio'
      FieldName = 'CAUS_SERVIZIO'
      Size = 5
    end
    object selT269CAUS_GRAVIDANZA: TStringField
      DisplayLabel = 'Causale di gravidanza'
      FieldName = 'CAUS_GRAVIDANZA'
      Size = 5
    end
    object selT269CAUS_PATGRAVI: TStringField
      DisplayLabel = 'Causale patologie gravi'
      FieldName = 'CAUS_PATGRAVI'
      Size = 5
    end
    object selT269POSTRICOVERO_AUTO: TStringField
      DisplayLabel = 'Post-ricovero automatico'
      FieldName = 'POSTRICOVERO_AUTO'
      Size = 1
    end
    object selT269STATO_CAUSA_MALATTIA: TStringField
      DisplayLabel = 'Stato causa malattia'
      FieldName = 'STATO_CAUSA_MALATTIA'
      Size = 15
    end
  end
  object dtsT269: TDataSource
    DataSet = selT269
    Left = 40
    Top = 72
  end
  object GetPostRicovero: TOracleQuery
    SQL.Strings = (
      'begin'
      ''
      '  :OUTCAUSALE:=null;'
      '  /*ricerca causale su T040(causali)*/'
      
        '  --Ricerca se data di ricovero '#232' inclusa all'#39'interno del period' +
        'o post-ricovero'
      '  begin'
      '    select T040.CAUSALE into :OUTCAUSALE'
      
        '      from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_' +
        'RAGGRASSENZE T260'
      '     where T040.PROGRESSIVO = :INPROGR'
      '       and T040.DATA = :INDATA'
      '       and T040.TIPOGIUST = '#39'I'#39
      '       and T040.CAUSALE = T265.CODICE'
      '       and T265.CODRAGGR = T260.CODICE'
      '       and T260.CODINTERNO <> '#39'H'#39';'
      '  exception'
      '    when others then '
      '      null;'
      '  end;'
      '  '
      
        '  --se la causale non '#232' stata trovata cerco comunque sui giustif' +
        'icativi gi'#224' inseriti'
      
        '  --Ricerca se data di ricovero '#232' antecedente(1 gg) del periodo ' +
        'post-ricovero  '
      '  if :OUTCAUSALE is null then'
      '    begin'
      '      select T040.CAUSALE into :OUTCAUSALE'
      
        '        from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T26' +
        '0_RAGGRASSENZE T260'
      '       where T040.PROGRESSIVO = :INPROGR'
      '         and T040.DATA = :INDATA - 1'
      '         and T040.TIPOGIUST = '#39'I'#39
      '         and T040.CAUSALE = T265.CODICE'
      '         and T265.CODRAGGR = T260.CODICE'
      '         and T260.CODINTERNO <> '#39'H'#39';'
      '    exception'
      '      when others then '
      '        null;'
      '    end;'
      '  end if;'
      ' '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0049004E00500052004F004700520003000000
      00000000000000000E0000003A0049004E0044004100540041000C0000000000
      000000000000160000003A004F0055005400430041005500530041004C004500
      050000000000000000000000}
    Left = 40
    Top = 176
  end
  object selT048CancMan: TOracleDataSet
    SQL.Strings = (
      
        'select T030.COGNOME, T030.NOME, T048.DATA_INIZIO_MAL, T048.DATA_' +
        'FINE_MAL, T048.NUM_PROTOCOLLO,'
      
        '       T048.PROGRESSIVO, T048.TIPO_ELEMENTO, T048.TIPO_CERTIFICA' +
        'TO, T048.TIPO_RICOVERO, T048.AGEVOLAZIONI,'
      
        '       T048.CAUSALE_MAL, T048.TIPO_GESTIONE, T048.DATA_CONSEGNA,' +
        ' T048.DATA_RILASCIO, T048.CAUSA_MALATTIA, '
      
        '       T265.DESCRIZIONE, T048.ID_CERTIFICATO, T048.COGNOME_REP, ' +
        'T048.VIA_REP, T048.CODCATASTALE_REP,'
      
        '       T048.CIVICO_REP, T048.CAP_REP, T048.PROV_REP, T048.NOTE, ' +
        'T048.ID_CERTIFICATO_RETT'
      
        '  from T048_ATTESTATIINPS T048, T265_CAUASSENZE T265, :C700SelAn' +
        'agrafe'
      '   and T048.TIPO_GESTIONE in ('#39'M'#39','#39'E'#39','#39'T'#39','#39'W'#39')'
      '   and T048.PROGRESSIVO = T030.PROGRESSIVO'
      '   and T048.CAUSALE_MAL = T265.CODICE'
      
        ' order by T048.DATA_INIZIO_MAL desc, T048.DATA_FINE_MAL desc, T0' +
        '48.NUM_PROTOCOLLO')
    Optimize = False
    Variables.Data = {
      0400000001000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000}
    QueryAllRecords = False
    OnCalcFields = selT048CancManCalcFields
    Left = 395
    Top = 175
    object selT048CancManCOGNOME: TStringField
      DisplayWidth = 20
      FieldName = 'COGNOME'
      Size = 30
    end
    object selT048CancManNOME: TStringField
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 30
    end
    object selT048CancManDATA_INIZIO_MAL: TDateTimeField
      DisplayLabel = 'Inizio malattia'
      DisplayWidth = 15
      FieldName = 'DATA_INIZIO_MAL'
    end
    object selT048CancManDATA_FINE_MAL: TDateTimeField
      DisplayLabel = 'Fine malattia'
      DisplayWidth = 15
      FieldName = 'DATA_FINE_MAL'
    end
    object selT048CancManDescTGestione: TStringField
      DisplayLabel = 'Tipo gestione'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescTGestione'
      Size = 50
      Calculated = True
    end
    object selT048CancManID_CERTIFICATO: TStringField
      DisplayLabel = 'Numero protocollo'
      FieldName = 'NUM_PROTOCOLLO'
      Size = 10
    end
    object selT048CancManDATA_RILASCIO: TDateTimeField
      DisplayWidth = 15
      FieldName = 'DATA_RILASCIO'
    end
    object selT048CancManDATA_CONSEGNA: TDateTimeField
      DisplayWidth = 15
      FieldName = 'DATA_CONSEGNA'
    end
    object selT048CancManTIPO_CERTIFICATO: TStringField
      FieldName = 'TIPO_CERTIFICATO'
      Visible = False
      Size = 1
    end
    object selT048CancManDescTCertificato: TStringField
      DisplayLabel = 'Tipo certificato'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescTCertificato'
      Size = 30
      Calculated = True
    end
    object selT048CancManTIPO_RICOVERO: TStringField
      FieldName = 'TIPO_RICOVERO'
      Visible = False
      Size = 1
    end
    object selT048CancManDescTRicovero: TStringField
      DisplayLabel = 'Tipo ricovero'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescTRicovero'
      Size = 30
      Calculated = True
    end
    object selT048CancManAGEVOLAZIONI: TStringField
      FieldName = 'AGEVOLAZIONI'
      Visible = False
      Size = 1
    end
    object selT048CancManDescAgevolazioni: TStringField
      DisplayLabel = 'Agevolazioni'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescAgevolazioni'
      Size = 30
      Calculated = True
    end
    object selT048CancManCAUSA_MALATTIA: TStringField
      FieldName = 'CAUSA_MALATTIA'
      Visible = False
      Size = 1
    end
    object selT048CancManDescCausaMal: TStringField
      DisplayLabel = 'Particolari cause malattia'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescCausaMal'
      Size = 30
      Calculated = True
    end
    object selT048CancManTIPO_ELEMENTO: TStringField
      FieldName = 'TIPO_ELEMENTO'
      Visible = False
      Size = 1
    end
    object selT048CancManCAUSALE_MALATTIA: TStringField
      FieldName = 'CAUSALE_MAL'
      Visible = False
      Size = 5
    end
    object selT048CancManDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 40
    end
    object selT048CancManTIPO_GESTIONE: TStringField
      FieldName = 'TIPO_GESTIONE'
      Visible = False
      Size = 1
    end
    object selT048CancManPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT048CancManID_CERTIFICATO2: TStringField
      FieldName = 'ID_CERTIFICATO'
      Visible = False
      Size = 10
    end
    object selT048CancManCOGNOME_REP: TStringField
      FieldName = 'COGNOME_REP'
      Visible = False
      Size = 24
    end
    object selT048CancManVIA_REP: TStringField
      FieldName = 'VIA_REP'
      Visible = False
      Size = 80
    end
    object selT048CancManCAP_REP: TStringField
      FieldName = 'CAP_REP'
      Visible = False
      Size = 5
    end
    object selT048CancManCODCATASTALE_REP: TStringField
      FieldName = 'CODCATASTALE_REP'
      Visible = False
      Size = 4
    end
    object selT048CancManPROV_REP: TStringField
      FieldName = 'PROV_REP'
      Visible = False
      Size = 2
    end
    object selT048CancManCIVICO_REP: TStringField
      FieldName = 'CIVICO_REP'
      Visible = False
      Size = 15
    end
    object selT048CancManNOTE: TStringField
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
    end
    object selT048CancManID_CERTFICATO_RETT: TStringField
      FieldName = 'ID_CERTIFICATO_RETT'
      Visible = False
      Size = 10
    end
    object selT048CancManDescIdCertificatoRett: TStringField
      DisplayLabel = 'Numero protocollo da rettificare'
      FieldKind = fkCalculated
      FieldName = 'DescIdCertificatoRett'
      Size = 10
      Calculated = True
    end
  end
  object ScriptIDPrecedente: TOracleQuery
    SQL.Strings = (
      'declare'
      '  FESTIVO varchar2(1);'
      '  FERIALE varchar2(1);'
      '  MONTEORE varchar2(5);'
      '  '
      '  T048PROGRESSIVO integer;  '
      '  T048TIPO_CERTIFICATO varchar2(1);'
      '  T048CAUSALE_MAL varchar2(5);'
      '  T048DATA_INIZIO_MAL date;'
      '  T048TIPO_GESTIONE varchar2(1);'
      '  '
      '  CHAIN varchar2(2000);'
      '  CHAIN_L133 varchar2(2000);'
      '  C_CONSIDERATE varchar2(2000);'
      '  NGG integer;'
      '  AUS_DATA date;'
      'begin'
      '  FESTIVO:='#39#39';'
      '  FERIALE:='#39#39';'
      '  NGG:=0;'
      '  MONTEORE:='#39#39';'
      '  '
      '  T048PROGRESSIVO:=0;'
      '  T048CAUSALE_MAL:='#39#39';'
      '  T048DATA_INIZIO_MAL:=null;'
      '  T048TIPO_CERTIFICATO:='#39#39';'
      '  '
      '  begin'
      
        '    select T048.PROGRESSIVO, T048.DATA_INIZIO_MAL, T048.CAUSALE_' +
        'MAL, T048.TIPO_CERTIFICATO into '
      
        '           T048PROGRESSIVO, T048DATA_INIZIO_MAL, T048CAUSALE_MAL' +
        ', T048TIPO_CERTIFICATO'
      '      from T048_ATTESTATIINPS T048'
      '     where T048.ID_CERTIFICATO = :ID_CERTIFICATOIN;'
      '  exception'
      '    when NO_DATA_FOUND then'
      '      T048PROGRESSIVO:=0;'
      '      T048CAUSALE_MAL:='#39#39';'
      '      T048DATA_INIZIO_MAL:=null;'
      '  end;'
      '  '
      '  AUS_DATA:=T048DATA_INIZIO_MAL - 1;'
      
        '  getcalendario(T048PROGRESSIVO,AUS_DATA,FESTIVO,FERIALE,NGG,MON' +
        'TEORE);    '
      
        '  /*Se trovo causali dello stesso tipo sul giorno allora annullo' +
        ' inserimento*/'
      '  select decode(count(*),0,FERIALE,'#39'S'#39') into FERIALE'
      '    from T040_GIUSTIFICATIVI T040'
      '   where T040.PROGRESSIVO = T048PROGRESSIVO'
      '     and T040.DATA = AUS_DATA'
      '     and T040.CAUSALE = T048CAUSALE_MAL;      '
      '  if FERIALE = '#39'N'#39' then'
      '    loop'
      '        AUS_DATA:=AUS_DATA - 1;      '
      
        '        getcalendario(T048PROGRESSIVO,AUS_DATA,FESTIVO,FERIALE,N' +
        'GG,MONTEORE);  '
      '        select decode(count(*),0,FERIALE,'#39'S'#39') into FERIALE'
      '          from T040_GIUSTIFICATIVI T040'
      '         where T040.PROGRESSIVO = T048PROGRESSIVO'
      '           and T040.DATA = AUS_DATA'
      '           and T040.CAUSALE = T048CAUSALE_MAL;        '
      '        exit when FERIALE = '#39'S'#39';'
      '    end loop;'
      
        '    T265F_GETCATENA(T048CAUSALE_MAL, CHAIN, CHAIN_L133, C_CONSID' +
        'ERATE);'
      '    begin'
      
        '      select T040.ID_CERTIFICATO, T040.DATA + 1 into :ID_CERTIFI' +
        'CATOOUT, :DATAOUT'
      '        from T040_GIUSTIFICATIVI T040, T048_ATTESTATIINPS T048'
      '       where T040.ID_CERTIFICATO = T048.ID_CERTIFICATO'
      '         and T048.TIPO_GESTIONE in ('#39'M'#39','#39'T'#39','#39'W'#39','#39'E'#39','#39'A'#39')'
      '         and T040.PROGRESSIVO = T048PROGRESSIVO'
      '         and T040.DATA = AUS_DATA'
      '         and T040.TIPOGIUST = '#39'I'#39' '
      
        '         and instr('#39','#39'||CHAIN||'#39','#39'||CHAIN_L133||'#39','#39','#39','#39'||T040.CA' +
        'USALE||'#39','#39') > 0;'
      '    exception'
      '      when NO_DATA_FOUND then'
      '        :ID_CERTIFICATOOUT:='#39#39';'
      '        :DATAOUT:=null;'
      '    end;    '
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0044004100540041004F00550054000C000000
      0000000000000000220000003A00490044005F00430045005200540049004600
      49004300410054004F0049004E00050000000000000000000000240000003A00
      490044005F0043004500520054004900460049004300410054004F004F005500
      5400050000000000000000000000}
    Left = 40
    Top = 232
  end
  object updT040: TOracleQuery
    SQL.Strings = (
      'update T040_GIUSTIFICATIVI T040'
      '   set T040.ID_CERTIFICATO = :NEWID'
      ' where T040.PROGRESSIVO = :PROGRESSIVO'
      '   and T040.DATA between :DATA_INIZIO and :DATA_FINE'
      '   and T040.ID_CERTIFICATO = :OLDID')
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A004E0045005700490044000500000000000000
      00000000180000003A0044004100540041005F0049004E0049005A0049004F00
      0C0000000000000000000000140000003A0044004100540041005F0046004900
      4E0045000C0000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F000300000000000000000000000C0000003A004F00
      4C00440049004400050000000000000000000000}
    Left = 112
    Top = 232
  end
  object CDtsTXTFile: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 232
    object CDtsTXTFileMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 10
    end
    object CDtsTXTFileGIORNO_INIZIO: TStringField
      DisplayLabel = 'Giorno inizio'
      FieldName = 'GIORNO_INIZIO'
      Size = 2
    end
    object CDtsTXTFileMESE_INIZIO: TStringField
      DisplayLabel = 'Mese inizio'
      FieldName = 'MESE_INIZIO'
      Size = 2
    end
    object CDtsTXTFileANNO_INIZIO: TStringField
      DisplayLabel = 'Anno inizio'
      FieldName = 'ANNO_INIZIO'
      Size = 4
    end
    object CDtsTXTFileGIORNO_FINE: TStringField
      DisplayLabel = 'Giorno fine'
      FieldName = 'GIORNO_FINE'
      Size = 2
    end
    object CDtsTXTFileMESE_FINE: TStringField
      DisplayLabel = 'Mese fine'
      FieldName = 'MESE_FINE'
      Size = 2
    end
    object CDtsTXTFileANNO_FINE: TStringField
      DisplayLabel = 'Anno fine'
      FieldName = 'ANNO_FINE'
      Size = 4
    end
    object CDtsTXTFileCAUSALE_MAL: TStringField
      DisplayLabel = 'Causale di malattia'
      FieldName = 'CAUSALE_MAL'
      Size = 4
    end
    object CDtsTXTFileNPROTOCOLLO: TStringField
      DisplayLabel = 'Num. protocollo'
      DisplayWidth = 40
      FieldName = 'NPROTOCOLLO'
      Size = 100
    end
    object CDtsTXTFileTIPO_FRUIZIONE: TStringField
      DisplayLabel = 'Tipo fruizione'
      FieldName = 'TIPO_FRUIZIONE'
      Size = 1
    end
    object CDtsTXTFileTIPO_REGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo registrazione'
      FieldName = 'TIPO_REGISTRAZIONE'
      Size = 1
    end
    object CDtsTXTFileID_FILETXT: TStringField
      DisplayLabel = 'Time stamp'
      FieldName = 'ID_FILETXT'
      Size = 14
    end
    object CDtsTXTFileNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 512
    end
  end
  object updT048NoteNProt: TOracleQuery
    SQL.Strings = (
      'declare'
      '  vPROGRESSIVO integer;'
      '  vID_FILETXT varchar2(14);'
      '  vNOTE varchar2(2000);'
      '  vNUM_PROTOCOLLO varchar2(10);'
      '  vCAUSALE_MAL varchar2(5);'
      '  vDATA_FINE_MAL date;'
      '  vDATA_FINE_OLD date;'
      '  vDATA_RILASCIO date;'
      '  vDATA_CONSEGNA date;   '
      '  vTIPO_CERTIFICATO varchar2(1);'
      '  vCAUSA_MALATTIA varchar2(1);'
      '  vAGEVOLAZIONI varchar2(1);'
      '  vCOGNOME_REP varchar2(24); '
      '  vVIA_REP varchar2(80);'
      '  vCODCATASTALE_REP varchar2(4);'
      '  vPROV_REP varchar2(2);'
      '  vCAP_REP varchar2(5);'
      'begin'
      '  :RESULT:='#39#39';'
      '  /*Estraggo dati del nuovo record da applicare sull'#39'esistente*/'
      '  begin'
      
        '    select T048.ID_FILETXT, T048.PROGRESSIVO, T048.DATA_FINE_MAL' +
        ', T048.TIPO_CERTIFICATO,'
      
        '           T048.CAUSALE_MAL, T048.CAUSA_MALATTIA, T048.AGEVOLAZI' +
        'ONI, '
      
        '           T048.NUM_PROTOCOLLO, T048.NOTE, T048.DATA_RILASCIO, T' +
        '048.DATA_CONSEGNA, '
      
        '           T048.COGNOME_REP, T048.VIA_REP, T048.CODCATASTALE_REP' +
        ', T048.PROV_REP, T048.CAP_REP'
      
        '      into vID_FILETXT, vPROGRESSIVO, vDATA_FINE_MAL, vTIPO_CERT' +
        'IFICATO,'
      '           vCAUSALE_MAL, vCAUSA_MALATTIA, vAGEVOLAZIONI, '
      
        '           vNUM_PROTOCOLLO, vNOTE, vDATA_RILASCIO, vDATA_CONSEGN' +
        'A, '
      
        '           vCOGNOME_REP, vVIA_REP, vCODCATASTALE_REP, vPROV_REP,' +
        ' vCAP_REP'
      '      from T048_ATTESTATIINPS T048'
      '     where T048.ID_CERTIFICATO = :ID_CERTIFICATO;'
      '  exception'
      '    when NO_DATA_FOUND then'
      '    begin'
      
        '      :RESULT:='#39'ID certificato "'#39'||:ID_CERTIFICATO||'#39'" non trova' +
        'to.'#39';'
      '      return;'
      '    end;'
      '  end;'
      '  '
      '  begin'
      '    --modifica record gi'#224' esistente'
      '    if :ID_CERTIFICATO_OLD is null then'
      '      --modifica proveniente da file'
      '      update T048_ATTESTATIINPS T048'
      
        '         set T048.NUM_PROTOCOLLO = nvl(vNUM_PROTOCOLLO,T048.NUM_' +
        'PROTOCOLLO),'
      '             T048.NOTE = nvl(vNOTE,T048.NOTE),'
      
        '             T048.DATA_RILASCIO = nvl(vDATA_RILASCIO,T048.DATA_R' +
        'ILASCIO),'
      
        '             T048.DATA_CONSEGNA = nvl(vDATA_CONSEGNA,T048.DATA_C' +
        'ONSEGNA), '
      
        '             T048.DATA_FINE_MAL = nvl(vDATA_FINE_MAL,T048.DATA_F' +
        'INE_MAL),'
      
        '             T048.TIPO_CERTIFICATO = nvl(vTIPO_CERTIFICATO,T048.' +
        'TIPO_CERTIFICATO), '
      
        '             T048.CAUSALE_MAL = nvl(vCAUSALE_MAL,T048.CAUSALE_MA' +
        'L),'
      
        '             T048.CAUSA_MALATTIA = nvl(vCAUSA_MALATTIA,T048.CAUS' +
        'A_MALATTIA),'
      
        '             T048.AGEVOLAZIONI = nvl(vAGEVOLAZIONI,T048.AGEVOLAZ' +
        'IONI),'
      
        '             T048.COGNOME_REP = nvl(vCOGNOME_REP,T048.COGNOME_RE' +
        'P),'
      '             T048.VIA_REP = nvl(vVIA_REP,T048.VIA_REP),'
      
        '             T048.CODCATASTALE_REP = nvl(vCODCATASTALE_REP,T048.' +
        'CODCATASTALE_REP), '
      '             T048.PROV_REP = nvl(vPROV_REP,T048.PROV_REP), '
      '             T048.CAP_REP = nvl(vCAP_REP,T048.CAP_REP)'
      '       where T048.PROGRESSIVO = vPROGRESSIVO'
      '         and T048.ID_FILETXT = vID_FILETXT '
      '         and T048.TIPO_REGISTRAZIONE in ('#39'N'#39','#39'M'#39')'
      
        '         and (   nvl(T048.NUM_PROTOCOLLO,'#39'NULL'#39') <> nvl(vNUM_PRO' +
        'TOCOLLO,'#39'NULL'#39')'
      '              or nvl(T048.NOTE,'#39'NULL'#39') <> nvl(vNOTE,'#39'NULL'#39')'
      
        '              or nvl(T048.DATA_RILASCIO,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_RILASCIO,to_date('#39'31121900'#39','#39'ddmmyyyy'#39'))'
      
        '              or nvl(T048.DATA_CONSEGNA,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_CONSEGNA,to_date('#39'31121900'#39','#39'ddmmyyyy'#39')) '
      
        '              or nvl(T048.DATA_FINE_MAL,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_FINE_MAL,to_date('#39'31121900'#39','#39'ddmmyyyy'#39'))   ' +
        '          '
      
        '              or nvl(T048.TIPO_CERTIFICATO,'#39'NULL'#39') <> nvl(vTIPO_' +
        'CERTIFICATO,'#39'NULL'#39')'
      
        '              or nvl(T048.CAUSALE_MAL,'#39'NULL'#39') <> nvl(vCAUSALE_MA' +
        'L,'#39'NULL'#39')'
      
        '              or nvl(T048.CAUSA_MALATTIA,'#39'NULL'#39') <> nvl(vCAUSA_M' +
        'ALATTIA,'#39'NULL'#39') '
      
        '              or nvl(T048.AGEVOLAZIONI,'#39'NULL'#39') <>nvl(vAGEVOLAZIO' +
        'NI,'#39'NULL'#39')'
      
        '              or nvl(T048.COGNOME_REP,'#39'NULL'#39') <> nvl(vCOGNOME_RE' +
        'P,'#39'NULL'#39')'
      
        '              or nvl(T048.VIA_REP,'#39'NULL'#39') <> nvl(vVIA_REP,'#39'NULL'#39 +
        ')'
      
        '              or nvl(T048.CODCATASTALE_REP,'#39'NULL'#39') <> nvl(vCODCA' +
        'TASTALE_REP,'#39'NULL'#39')'
      
        '              or nvl(T048.PROV_REP,'#39'NULL'#39') <> nvl(vPROV_REP,'#39'NUL' +
        'L'#39')'
      
        '              or nvl(T048.CAP_REP,'#39'NULL'#39') <> nvl(vCAP_REP,'#39'NULL'#39 +
        '));              '
      '      if sql%rowcount > 0 then        '
      
        '        --modifico TIPO_REGISTRAZIONE = '#39'M'#39' solo se il record pr' +
        'ima aveva TIPO_REGISTRAZIONE = '#39'N'#39' (proveniente da file) '
      '        update T048_ATTESTATIINPS T048'
      '           set T048.TIPO_REGISTRAZIONE = '#39'M'#39
      '         where T048.PROGRESSIVO = vPROGRESSIVO'
      '           and T048.ID_FILETXT = vID_FILETXT'
      '           and T048.TIPO_REGISTRAZIONE = '#39'N'#39'; '
      '      end if;'
      '    else'
      '      --modifica manuale '
      '      update T048_ATTESTATIINPS T048'
      '         set T048.NUM_PROTOCOLLO = vNUM_PROTOCOLLO,'
      '             T048.NOTE = vNOTE,'
      '             T048.DATA_RILASCIO = vDATA_RILASCIO, '
      '             T048.DATA_CONSEGNA = vDATA_CONSEGNA, '
      '             T048.DATA_FINE_MAL = vDATA_FINE_MAL,'
      '             T048.TIPO_CERTIFICATO = vTIPO_CERTIFICATO, '
      '             T048.CAUSALE_MAL = T048.CAUSALE_MAL,'
      '             T048.CAUSA_MALATTIA = vCAUSA_MALATTIA,'
      '             T048.AGEVOLAZIONI = vAGEVOLAZIONI,'
      '             T048.COGNOME_REP = vCOGNOME_REP, '
      '             T048.VIA_REP = vVIA_REP, '
      '             T048.CODCATASTALE_REP = vCODCATASTALE_REP, '
      '             T048.PROV_REP = vPROV_REP, '
      '             T048.CAP_REP = vCAP_REP'
      '       where T048.PROGRESSIVO = vPROGRESSIVO'
      '         and :ID_CERTIFICATO_OLD = T048.ID_CERTIFICATO'
      
        '         and (   nvl(T048.NUM_PROTOCOLLO,'#39'NULL'#39') <> nvl(vNUM_PRO' +
        'TOCOLLO,'#39'NULL'#39')'
      '              or nvl(T048.NOTE,'#39'NULL'#39') <> nvl(vNOTE,'#39'NULL'#39')'
      
        '              or nvl(T048.DATA_RILASCIO,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_RILASCIO,to_date('#39'31121900'#39','#39'ddmmyyyy'#39'))'
      
        '              or nvl(T048.DATA_CONSEGNA,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_CONSEGNA,to_date('#39'31121900'#39','#39'ddmmyyyy'#39'))'
      
        '              or nvl(T048.DATA_FINE_MAL,to_date('#39'31121900'#39','#39'ddmm' +
        'yyyy'#39')) <> nvl(vDATA_FINE_MAL,to_date('#39'31121900'#39','#39'ddmmyyyy'#39'))'
      
        '              or nvl(T048.TIPO_CERTIFICATO,'#39'NULL'#39') <> nvl(vTIPO_' +
        'CERTIFICATO,'#39'NULL'#39')'
      
        '              or nvl(T048.CAUSALE_MAL,'#39'NULL'#39') <> nvl(vCAUSALE_MA' +
        'L,'#39'NULL'#39')'
      
        '              or nvl(T048.CAUSA_MALATTIA,'#39'NULL'#39') <> nvl(vCAUSA_M' +
        'ALATTIA,'#39'NULL'#39') '
      
        '              or nvl(T048.AGEVOLAZIONI,'#39'NULL'#39') <> nvl(vAGEVOLAZI' +
        'ONI,'#39'NULL'#39')'
      
        '              or nvl(T048.COGNOME_REP,'#39'NULL'#39') <> nvl(vCOGNOME_RE' +
        'P,'#39'NULL'#39')'
      
        '              or nvl(T048.VIA_REP,'#39'NULL'#39') <> nvl(vVIA_REP,'#39'NULL'#39 +
        ')'
      
        '              or nvl(T048.CODCATASTALE_REP,'#39'NULL'#39') <> nvl(vCODCA' +
        'TASTALE_REP,'#39'NULL'#39')'
      
        '              or nvl(T048.PROV_REP,'#39'NULL'#39') <> nvl(vPROV_REP,'#39'NUL' +
        'L'#39')'
      
        '              or nvl(T048.CAP_REP,'#39'NULL'#39') <> nvl(vCAP_REP,'#39'NULL'#39 +
        '));'
      '      if sql%rowcount > 0 then        '
      
        '        --modifico TIPO_REGISTRAZIONE = '#39'M'#39' solo se il record pr' +
        'ima aveva TIPO_REGISTRAZIONE = '#39'N'#39' (proveniente da file) '
      '        update T048_ATTESTATIINPS T048'
      '           set T048.TIPO_REGISTRAZIONE = '#39'M'#39
      '         where T048.PROGRESSIVO = vPROGRESSIVO'
      '           and :ID_CERTIFICATO_OLD = T048.ID_CERTIFICATO'
      '           and T048.TIPO_REGISTRAZIONE = '#39'N'#39'; '
      '      end if;            '
      '    end if;'
      '  exception'
      '    when OTHERS then'
      
        '      :RESULT:='#39'Errore aggiornamento dati certificato "'#39'||:ID_CE' +
        'RTIFICATO_OLD||'#39'" su tabella T048.'#39';'
      '  end;'
      '     '
      
        '  --cancellazione del record temporaneo con TIPO_REGISTRAZIONE =' +
        ' '#39'T'#39
      '  delete'
      '    from T048_ATTESTATIINPS T048'
      '   where T048.ID_CERTIFICATO = :ID_CERTIFICATO;      '
      'end;')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0052004500530055004C005400050000001F00
      0000494420636572746966696361746F202222206E6F6E2074726F7661746F2E
      00000000001E0000003A00490044005F00430045005200540049004600490043
      00410054004F00050000000000000000000000260000003A00490044005F0043
      004500520054004900460049004300410054004F005F004F004C004400050000
      000000000000000000}
    Left = 288
    Top = 240
  end
  object ScriptContaGGPrecedenti: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor C1(Causale in string) is'
      '    select T040.DATA'
      '      from T040_GIUSTIFICATIVI T040, T048_ATTESTATIINPS T048'
      '     where T040.PROGRESSIVO = :PROGRESSIVO'
      '       and T040.ID_CERTIFICATO = T048.ID_CERTIFICATO'
      '       and T040.ID_CERTIFICATO is not null'
      '       and T040.DATA < :DATA'
      '       and instr('#39','#39'||Causale||'#39','#39','#39','#39'||T040.CAUSALE||'#39','#39') > 0'
      '       and T048.NUM_PROTOCOLLO is null'
      '       and T048.TIPO_GESTIONE in ('#39'T'#39','#39'E'#39')'
      '     order by T040.DATA desc;'
      '  PrevData date;'
      '  Chain varchar2(2000);'
      '  ChainL133 varchar2(2000);'
      '  CConsiderazione varchar2(2000);'
      'begin'
      '  PrevData:=:DATA;'
      '  :NGGCONSEC:=1;'
      
        '  T265F_GETCATENA(:CAUSALE_MAL, Chain, ChainL133, CConsiderazion' +
        'e);'
      '  for T1 in C1(Chain) loop'
      '    if PrevData - T1.DATA > 1 then      '
      '       exit;'
      '    end if;'
      '    PrevData:=T1.DATA;'
      '    :NGGCONSEC:=:NGGCONSEC + 1;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000140000003A004E004700470043004F004E0053004500
      430003000000040000000100000000000000180000003A004300410055005300
      41004C0045005F004D0041004C00050000000000000000000000}
    Left = 40
    Top = 280
  end
  object selCertificatiRett: TOracleDataSet
    SQL.Strings = (
      'select T048_1.ID_CERTIFICATO'
      '  from T048_ATTESTATIINPS T048_1, T048_ATTESTATIINPS T048_2'
      ' where T048_1.ID_CERTIFICATO = T048_2.ID_CERTIFICATO_RETT')
    Optimize = False
    Left = 288
    Top = 288
  end
  object selDatoAnagrafico: TOracleDataSet
    SQL.Strings = (
      'select COLUMN_NAME'
      '  from USER_TAB_COLUMNS'
      ' where TABLE_NAME = '#39'V430_STORICO'#39
      '   and COLUMN_NAME = :T269DATO_LIBERO')
    Optimize = False
    Variables.Data = {
      0400000001000000200000003A0054003200360039004400410054004F005F00
      4C0049004200450052004F00050000000000000000000000}
    Left = 184
    Top = 232
  end
  object selT265DettCAssenza: TOracleDataSet
    SQL.Strings = (
      '/*Eventuali dati generici su causale*/'
      'select T265.TIPOCUMULO, T265.COPRI_GGNONLAV'
      '  from T265_CAUASSENZE T265'
      ' where T265.CODICE = :CODICE'
      ' order by T265.CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 392
    Top = 288
  end
  object selT048Info: TOracleDataSet
    SQL.Strings = (
      'select t048.*'
      'from   t048_attestatiinps t048'
      'where  t048.id_certificato = :ID_CERTIFICATO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A00490044005F00430045005200540049004600
      49004300410054004F00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000003800000016000000500052004F004700520045005300530049005600
      4F000100000000002400000044004100540041005F0052004500470049005300
      5400520041005A0049004F004E004500010000000000120000004F0050004500
      5200410054004F00520045000100000000001600000043004100550053004100
      4C0045005F004D0041004C000100000000001A0000005400490050004F005F00
      45004C0045004D0045004E0054004F000100000000001C000000490044005F00
      43004500520054004900460049004300410054004F0001000000000026000000
      43004F0044005F00460049005300430041004C0045005F0041005A0049004500
      4E00440041000100000000001C0000004D00410054005200490043004F004C00
      41005F0049004E00500053000100000000001E00000043004F0044005F005300
      4500440045005F0049004E0050004400410050000100000000001E0000004300
      4F0044005F00460049005300430041004C0045005F004D004500440001000000
      00001600000043004F0047004E004F004D0045005F004D004500440001000000
      0000100000004E004F004D0045005F004D004500440001000000000016000000
      43004F0044005F0052004500470049004F004E0045000100000000000E000000
      43004F0044005F00410053004C000100000000001600000043004F0044005F00
      460049005300430041004C0045000100000000000E00000043004F0047004E00
      4F004D004500010000000000080000004E004F004D0045000100000000000A00
      000053004500530053004F000100000000001000000044004100540041005F00
      4E00410053000100000000002000000043004F00440043004100540041005300
      540041004C0045005F004E004100530001000000000010000000500052004F00
      56005F004E00410053000100000000000E0000005600490041005F0044004F00
      4D000100000000000E0000004300410050005F0044004F004D00010000000000
      2000000043004F00440043004100540041005300540041004C0045005F004400
      4F004D0001000000000010000000500052004F0056005F0044004F004D000100
      000000001600000043004F0047004E004F004D0045005F005200450050000100
      000000000E0000005600490041005F005200450050000100000000000E000000
      4300410050005F005200450050000100000000002000000043004F0044004300
      4100540041005300540041004C0045005F005200450050000100000000001000
      0000500052004F0056005F005200450050000100000000001A00000044004100
      540041005F00520049004C0041005300430049004F000100000000001E000000
      44004100540041005F0049004E0049005A0049004F005F004D0041004C000100
      000000001A00000044004100540041005F00460049004E0045005F004D004100
      4C000100000000001800000043004F0044005F0044004900410047004E004F00
      530049000100000000001C00000054004500530054004F005F00440049004100
      47004E004F0053004900010000000000200000005400490050004F005F004300
      4500520054004900460049004300410054004F00010000000000260000004900
      44005F0043004500520054004900460049004300410054004F005F0052004500
      540054000100000000001200000045004C00410042004F005200410054004F00
      01000000000014000000430049005600490043004F005F005200450050000100
      0000000014000000430049005600490043004F005F0044004F004D0001000000
      000016000000520055004F004C004F004D0045004400490043004F0001000000
      00002000000043004F0044005300540052005500540054005500520041005F00
      4D004500440001000000000020000000470049004F0052004E00410054004100
      4C00410056004F0052004100540041000100000000000C000000540052004100
      55004D0041000100000000001800000041004700450056004F004C0041005A00
      49004F004E0049000100000000002000000044004100540041005F0046004900
      4E00450050004F00530054005200490043000100000000001A00000054004900
      50004F005F005200490043004F005600450052004F000100000000001E000000
      430041005500530041004C0045005F0050004F00530054005200490043000100
      000000001A00000044004100540041005F0043004F004E005300450047004E00
      41000100000000001C000000430041005500530041005F004D0041004C004100
      54005400490041000100000000001A0000005400490050004F005F0047004500
      5300540049004F004E0045000100000000001C0000004E0055004D005F005000
      52004F0054004F0043004F004C004C004F00010000000000080000004E004F00
      54004500010000000000240000005400490050004F005F005200450047004900
      53005400520041005A0049004F004E0045000100000000001400000049004400
      5F00460049004C00450054005800540001000000000014000000490044005F00
      460049004C00450058004D004C00010000000000}
    ReadOnly = True
    Left = 352
    Top = 14
    object selT048InfoDATA_INIZIO_MAL: TDateTimeField
      DisplayLabel = 'Data inizio malattia'
      FieldName = 'DATA_INIZIO_MAL'
    end
    object selT048InfoDATA_FINE_MAL: TDateTimeField
      DisplayLabel = 'Data fine malattia'
      FieldName = 'DATA_FINE_MAL'
    end
    object selT048InfoTIPO_CERTIFICATO: TStringField
      DisplayLabel = 'Tipo certificato'
      FieldName = 'TIPO_CERTIFICATO'
      Visible = False
      Size = 1
    end
    object selT048InfoD_TIPO_CERTIFICATO: TStringField
      DisplayLabel = 'Tipo certificato'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_CERTIFICATO'
      Size = 30
      Calculated = True
    end
    object selT048InfoDATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      DisplayWidth = 10
      FieldName = 'DATA_RILASCIO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT048InfoID_CERTIFICATO: TStringField
      DisplayLabel = 'Id certificato'
      FieldName = 'ID_CERTIFICATO'
      Required = True
      Size = 10
    end
    object selT048InfoCOGNOME_REP: TStringField
      DisplayLabel = 'Cognome rep.'
      DisplayWidth = 15
      FieldName = 'COGNOME_REP'
      Size = 24
    end
    object selT048InfoVIA_REP: TStringField
      DisplayLabel = 'Via rep.'
      DisplayWidth = 30
      FieldName = 'VIA_REP'
      Size = 80
    end
    object selT048InfoCIVICO_REP: TStringField
      DisplayLabel = 'Civico rep.'
      DisplayWidth = 4
      FieldName = 'CIVICO_REP'
      Size = 15
    end
    object selT048InfoCAP_REP: TStringField
      DisplayLabel = 'CAP rep.'
      FieldName = 'CAP_REP'
      Size = 5
    end
    object selT048InfoCODCATASTALE_REP: TStringField
      DisplayLabel = 'Comune rep.'
      FieldName = 'CODCATASTALE_REP'
      Size = 4
    end
    object selT048InfoPROV_REP: TStringField
      DisplayLabel = 'Provincia rep.'
      FieldName = 'PROV_REP'
      Size = 2
    end
    object selT048InfoMATRICOLA_INPS: TStringField
      DisplayLabel = 'Matricola INPS'
      FieldName = 'MATRICOLA_INPS'
      Size = 10
    end
    object selT048InfoCOD_SEDE_INPDAP: TStringField
      DisplayLabel = 'Codice sede'
      FieldName = 'COD_SEDE_INPDAP'
      Visible = False
      Size = 10
    end
    object selT048InfoGIORNATALAVORATA: TStringField
      DisplayLabel = 'Giornata lavorata'
      FieldName = 'GIORNATALAVORATA'
      Size = 1
    end
    object selT048InfoTRAUMA: TStringField
      DisplayLabel = 'Trauma'
      FieldName = 'TRAUMA'
      Size = 1
    end
    object selT048InfoTIPO_RICOVERO: TStringField
      DisplayLabel = 'Tipo ricovero'
      FieldName = 'TIPO_RICOVERO'
      Visible = False
      Size = 1
    end
    object selT048InfoD_TIPO_RICOVERO: TStringField
      DisplayLabel = 'Tipo ricovero'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICOVERO'
      Size = 30
      Calculated = True
    end
    object selT048InfoAGEVOLAZIONI: TStringField
      DisplayLabel = 'Agevolazioni'
      FieldName = 'AGEVOLAZIONI'
      Visible = False
      Size = 1
    end
    object selT048InfoD_AGEVOLAZIONI: TStringField
      DisplayLabel = 'Agevolazioni'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_AGEVOLAZIONI'
      Size = 30
      Calculated = True
    end
    object selT048InfoPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT048InfoTIPO_ELEMENTO: TStringField
      DisplayLabel = 'Tipo elemento'
      FieldName = 'TIPO_ELEMENTO'
      Required = True
      Visible = False
      Size = 1
    end
    object selT048InfoCOGNOME: TStringField
      FieldName = 'COGNOME'
      Visible = False
      Size = 24
    end
    object selT048InfoDATA_REGISTRAZIONE: TDateTimeField
      DisplayLabel = 'Data registrazione'
      FieldName = 'DATA_REGISTRAZIONE'
      Required = True
      Visible = False
    end
    object selT048InfoOPERATORE: TStringField
      DisplayLabel = 'Operatore'
      FieldName = 'OPERATORE'
      Required = True
      Visible = False
    end
    object selT048InfoCAUSALE_MAL: TStringField
      DisplayLabel = 'Causale malattia'
      FieldName = 'CAUSALE_MAL'
      Required = True
      Visible = False
      Size = 5
    end
    object selT048InfoCOD_FISCALE_AZIENDA: TStringField
      DisplayLabel = 'Cod. fiscale azienda'
      FieldName = 'COD_FISCALE_AZIENDA'
      Visible = False
      Size = 16
    end
    object selT048InfoCOD_FISCALE_MED: TStringField
      FieldName = 'COD_FISCALE_MED'
      Visible = False
      Size = 16
    end
    object selT048InfoCOGNOME_MED: TStringField
      FieldName = 'COGNOME_MED'
      Visible = False
      Size = 24
    end
    object selT048InfoNOME_MED: TStringField
      FieldName = 'NOME_MED'
      Visible = False
    end
    object selT048InfoCOD_REGIONE: TStringField
      FieldName = 'COD_REGIONE'
      Visible = False
      Size = 3
    end
    object selT048InfoCOD_ASL: TStringField
      FieldName = 'COD_ASL'
      Visible = False
      Size = 3
    end
    object selT048InfoCOD_FISCALE: TStringField
      FieldName = 'COD_FISCALE'
      Visible = False
      Size = 16
    end
    object selT048InfoNOME: TStringField
      FieldName = 'NOME'
      Visible = False
    end
    object selT048InfoSESSO: TStringField
      FieldName = 'SESSO'
      Visible = False
      Size = 1
    end
    object selT048InfoDATA_NAS: TDateTimeField
      FieldName = 'DATA_NAS'
      Visible = False
    end
    object selT048InfoCODCATASTALE_NAS: TStringField
      FieldName = 'CODCATASTALE_NAS'
      Visible = False
      Size = 4
    end
    object selT048InfoPROV_NAS: TStringField
      FieldName = 'PROV_NAS'
      Visible = False
      Size = 2
    end
    object selT048InfoVIA_DOM: TStringField
      FieldName = 'VIA_DOM'
      Visible = False
      Size = 80
    end
    object selT048InfoCAP_DOM: TStringField
      FieldName = 'CAP_DOM'
      Visible = False
      Size = 5
    end
    object selT048InfoCODCATASTALE_DOM: TStringField
      FieldName = 'CODCATASTALE_DOM'
      Visible = False
      Size = 4
    end
    object selT048InfoPROV_DOM: TStringField
      FieldName = 'PROV_DOM'
      Visible = False
      Size = 2
    end
    object selT048InfoCOD_DIAGNOSI: TStringField
      FieldName = 'COD_DIAGNOSI'
      Visible = False
      Size = 10
    end
    object selT048InfoTESTO_DIAGNOSI: TStringField
      FieldName = 'TESTO_DIAGNOSI'
      Visible = False
      Size = 200
    end
    object selT048InfoID_CERTIFICATO_RETT: TStringField
      FieldName = 'ID_CERTIFICATO_RETT'
      Visible = False
      Size = 10
    end
    object selT048InfoELABORATO: TStringField
      FieldName = 'ELABORATO'
      Visible = False
      Size = 1
    end
    object selT048InfoCIVICO_DOM: TStringField
      FieldName = 'CIVICO_DOM'
      Visible = False
      Size = 15
    end
    object selT048InfoRUOLOMEDICO: TStringField
      FieldName = 'RUOLOMEDICO'
      Visible = False
      Size = 1
    end
    object selT048InfoCODSTRUTTURA_MED: TStringField
      FieldName = 'CODSTRUTTURA_MED'
      Visible = False
      Size = 9
    end
    object selT048InfoDATA_FINEPOSTRIC: TDateTimeField
      FieldName = 'DATA_FINEPOSTRIC'
      Visible = False
    end
    object selT048InfoCAUSALE_POSTRIC: TStringField
      FieldName = 'CAUSALE_POSTRIC'
      Visible = False
      Size = 5
    end
    object selT048InfoDATA_CONSEGNA: TDateTimeField
      FieldName = 'DATA_CONSEGNA'
      Visible = False
    end
    object selT048InfoCAUSA_MALATTIA: TStringField
      FieldName = 'CAUSA_MALATTIA'
      Visible = False
      Size = 1
    end
    object selT048InfoTIPO_GESTIONE: TStringField
      FieldName = 'TIPO_GESTIONE'
      Visible = False
      Size = 1
    end
    object selT048InfoNUM_PROTOCOLLO: TStringField
      FieldName = 'NUM_PROTOCOLLO'
      Visible = False
      Size = 10
    end
    object selT048InfoNOTE: TStringField
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
    end
    object selT048InfoTIPO_REGISTRAZIONE: TStringField
      FieldName = 'TIPO_REGISTRAZIONE'
      Visible = False
      Size = 1
    end
    object selT048InfoID_FILETXT: TStringField
      FieldName = 'ID_FILETXT'
      Visible = False
      Size = 14
    end
    object selT048InfoID_FILEXML: TFloatField
      FieldName = 'ID_FILEXML'
      Visible = False
    end
  end
end
