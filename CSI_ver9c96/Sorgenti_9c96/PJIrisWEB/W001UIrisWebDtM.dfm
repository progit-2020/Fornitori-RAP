inherited W001FIrisWebDtM: TW001FIrisWebDtM
  OldCreateOrder = True
  Height = 1063
  Width = 875
  object seldistT003: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME '
      'FROM   T003_SELEZIONIANAGRAFE'
      'ORDER BY 1')
    ReadBuffer = 50
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 436
    Top = 8
  end
  object selT003: TOracleDataSet
    SQL.Strings = (
      
        'SELECT RIGA FROM T003_SELEZIONIANAGRAFE WHERE NOME = :NOME  ORDE' +
        'R BY POSIZIONE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 488
    Top = 8
  end
  object selDistAnagrafe: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT :CAMPO FROM '
      'T030_ANAGRAFICO T030, V430_STORICO V430, T480_COMUNI T480 WHERE'
      'T030.PROGRESSIVO = T430PROGRESSIVO AND'
      'T030.COMUNENAS = T480.CODICE(+) AND'
      ':DATALAVORO BETWEEN T430DATADECORRENZA AND T430DATAFINE'
      ':FILTRO'
      'ORDER BY 1'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00430041004D0050004F000100000000000000
      00000000160000003A0044004100540041004C00410056004F0052004F000C00
      000000000000000000000E0000003A00460049004C00540052004F0001000000
      0000000000000000}
    Left = 26
    Top = 151
  end
  object insT003: TOracleQuery
    SQL.Strings = (
      'begin'
      '  insert into t003_selezionianagrafe'
      '    (nome,posizione,riga)'
      '  values'
      '    (:nome,:posizione,:riga);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004E004F004D00450005000000000000000000
      0000140000003A0050004F00530049005A0049004F004E004500030000000000
      0000000000000A0000003A005200490047004100050000000000000000000000}
    Left = 140
    Top = 214
  end
  object selT350: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE, DESCRIZIONE, OREMINUTI(TO_CHAR(ORAINIZIO,'#39'HH24.MI' +
        #39')) INIZIO, OREMINUTI(TO_CHAR(ORAFINE,'#39'HH24.MI'#39')) FINE'
      'FROM   T350_REGREPERIB'
      'WHERE  TIPOLOGIA = :TIPOLOGIA'
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    OnFilterRecord = FiltroDizionario
    Left = 474
    Top = 64
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE, UM_INSERIMENTO_H, UM_INSERIMENTO_D, '
      
        '       TIPO_RICHIESTA_WEB, ARROT_RIEPGG, LINK_ASSENZA, ORENORMAL' +
        'I,'
      '       MINMINUTI, MAXMINUTI, CAUSALIZZA_TIMB_INTERSECANTI'
      'from   T275_CAUPRESENZE'
      'order by CODICE')
    ReadBuffer = 250
    Optimize = False
    OnFilterRecord = FiltroDizionario
    Left = 264
    Top = 64
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'select T265.CODICE, T265.DESCRIZIONE, T265.CUMULO_FAMILIARI, T26' +
        '5.FRUIZIONE_FAMILIARI,'
      
        '       T265.UM_INSERIMENTO, T265.UM_INSERIMENTO_MG, T265.UM_INSE' +
        'RIMENTO_H, T265.UM_INSERIMENTO_D, T265.TIPOCUMULO,'
      
        '       OreMinuti(T265.FRUIZ_MIN) FRUIZ_MIN, OreMinuti(nvl(T265.F' +
        'RUIZ_MAX,'#39'24.00'#39')) FRUIZ_MAX, OreMinuti(T265.FRUIZ_ARR) FRUIZ_AR' +
        'R,'
      
        '       T265.FRUIZ_MAX_DEBITO, T265.FRUIZCOMPETENZE_ARR, T265.VIS' +
        'ITA_FISCALE, T265.CODCAU1, T265.CODCAU2, T265.CODCAU3, '
      
        '       T265.COPRI_GGNONLAV, T265.GSIGNIFIC, T265.ALLARME_FRUIZIO' +
        'NE_CONTINUATIVA,'
      
        '       T265.NO_SUPERO_COMPETENZE, T265.NO_SUPERO_COMPETENZE_WEB,' +
        ' T265.VALIDAZIONE, T265.CSI_MAX_MGMAT, T265.CSI_MAX_MGPOM,'
      '       T260.CODINTERNO'
      'from   T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE T265.CODRAGGR = T260.CODICE'
      'order by T265.CODICE')
    ReadBuffer = 250
    Optimize = False
    OnFilterRecord = FiltroDizionario
    Left = 210
    Top = 64
  end
  object dsrT040: TDataSource
    DataSet = selT040
    Left = 584
    Top = 8
  end
  object selT280: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  T280.*,T280.ROWID, '#39' '#39' PULSANTE, T030.MATRICOLA, T030.COGNOME ' +
        '|| '#39' '#39' || T030.NOME NOMINATIVO '
      'FROM T030_ANAGRAFICO T030, T280_MESSAGGIWEB T280'
      'WHERE T030.PROGRESSIVO = :PROGRESSIVO'
      '  AND T280.PROGRESSIVO = T030.PROGRESSIVO'
      '  AND T280.FLAG IS NOT NULL'
      'ORDER BY DATA DESC, MITTENTE, FLAG')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    UpdatingTable = 'T280_MESSAGGIWEB'
    AfterOpen = selT280AfterOpen
    Left = 381
    Top = 9
  end
  object selSG110: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  SG110.*,SG110.ROWID RI,SG110.ROWID, '#39' '#39' PULSANTE, T030.MATRICO' +
        'LA, T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO '
      'FROM SG110_CURRICULUM SG110,'
      '     :QVISTAORACLE  '
      '  AND SG110.PROGRESSIVO = T030.PROGRESSIVO'
      '--  AND SG110.STATO <> '#39'C'#39
      '  :FILTRO'
      
        'ORDER BY INIZIO_ESPERIENZA, TIPOESPERIENZA, DETTAGLIOESPERIENZA,' +
        ' LUOGO_ESPERIENZA')
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A005100560049005300540041004F0052004100
      43004C0045000100000000000000000000000E0000003A00460049004C005400
      52004F00010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000002400000044004100540041005F0052004500470049005300
      5400520041005A0049004F004E0045000100000000001C000000540049005000
      4F0045005300500045005200490045004E005A00410001000000000026000000
      4400450054005400410047004C0049004F004500530050004500520049004500
      4E005A0041000100000000001C00000049004E0043004C005500440049005F00
      5300540041004D0050004100010000000000200000004C0055004F0047004F00
      5F0045005300500045005200490045004E005A00410001000000000022000000
      49004E0049005A0049004F005F0045005300500045005200490045004E005A00
      41000100000000001E000000460049004E0045005F0045005300500045005200
      490045004E005A00410001000000000016000000440045005300430052004900
      5A0049004F004E0045000100000000000E0000004F0052004900470049004E00
      45000100000000000A00000053005400410054004F0001000000000004000000
      52004900010000000000}
    OnCalcFields = selSG110CalcFields
    Left = 158
    Top = 348
    object selSG110PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selSG110DATA_REGISTRAZIONE: TDateTimeField
      FieldName = 'DATA_REGISTRAZIONE'
      Required = True
    end
    object selSG110TIPOESPERIENZA: TStringField
      FieldName = 'TIPOESPERIENZA'
      Required = True
    end
    object selSG110Desc_Tipo: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Tipo'
      Size = 100
      Calculated = True
    end
    object selSG110DETTAGLIOESPERIENZA: TStringField
      FieldName = 'DETTAGLIOESPERIENZA'
      Required = True
    end
    object selSG110Desc_Dettaglio: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Dettaglio'
      Size = 100
      Calculated = True
    end
    object selSG110INCLUDI_STAMPA: TStringField
      FieldName = 'INCLUDI_STAMPA'
      Required = True
      Size = 1
    end
    object selSG110LUOGO_ESPERIENZA: TStringField
      FieldName = 'LUOGO_ESPERIENZA'
      Required = True
      Size = 200
    end
    object selSG110INIZIO_ESPERIENZA: TDateTimeField
      FieldName = 'INIZIO_ESPERIENZA'
      Required = True
    end
    object selSG110FINE_ESPERIENZA: TDateTimeField
      FieldName = 'FINE_ESPERIENZA'
      Required = True
    end
    object selSG110DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 1000
    end
    object selSG110ORIGINE: TStringField
      FieldName = 'ORIGINE'
      Required = True
      Size = 1
    end
    object selSG110STATO: TStringField
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object selSG110RI: TStringField
      FieldName = 'RI'
      Size = 18
    end
    object selSG110Desc_Stato: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Stato'
      Calculated = True
    end
  end
  object selSG111: TOracleDataSet
    SQL.Strings = (
      'select * from sg111_tipoesperienze'
      'order by codice')
    ReadBuffer = 10
    Optimize = False
    Left = 294
    Top = 348
  end
  object selSG112: TOracleDataSet
    SQL.Strings = (
      'select * from sg112_dettaglioesperienze'
      '--where tipoesperienza = :TIPOESPERIENZA'
      'order by codice')
    ReadBuffer = 10
    Optimize = False
    Left = 346
    Top = 348
  end
  object selSG110_Luoghi: TOracleDataSet
    SQL.Strings = (
      'select distinct luogo_esperienza luogo'
      'from sg110_curriculum'
      '--where stato <> '#39'C'#39
      'order by luogo')
    ReadBuffer = 10
    Optimize = False
    Left = 226
    Top = 348
  end
  object selSG113: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  SG113.*,'
      '  --SG113.ROWID RI,'
      
        '  SG113.ROWID, '#39' '#39' PULSANTE, T030.MATRICOLA, T030.COGNOME || '#39' '#39 +
        ' || T030.NOME NOMINATIVO'
      '  :TABELLECAMPI'
      'FROM SG113_PREFERENZE SG113 :TABELLE, '
      '     :QVISTAORACLE  '
      '  AND SG113.PROGRESSIVO = T030.PROGRESSIVO'
      '  :TABELLEJOIN'
      '  :FILTRO'
      
        'ORDER BY DATA_REGISTRAZIONE, PREFERENZA_COMPETENZA, PREFERENZA_D' +
        'ESTINAZIONE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A005100560049005300540041004F0052004100
      43004C0045000100000000000000000000000E0000003A00460049004C005400
      52004F00010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0054004100
      420045004C004C004500430041004D0050004900010000000000000000000000
      100000003A0054004100420045004C004C004500010000000000000000000000
      180000003A0054004100420045004C004C0045004A004F0049004E0001000000
      0000000000000000}
    Left = 393
    Top = 348
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 593
    Top = 248
  end
  object selSG651: TOracleDataSet
    SQL.Strings = (
      
        'SELECT SG651.COD_CORSO, SG651.EDIZIONE, SG651.PROGRESSIVO, SG651' +
        '.NUMERO_GIORNO, '
      
        '       SG651.DATA_CORSO, SG651.ORA_INIZIO, SG651.ORA_FINE, SG651' +
        '.DURATA_CORSO, '
      
        '       SG651.NOTE, SG651.TIPO_RECORD, SG651.ORIGINE, SG651.STATO' +
        ', '
      
        '       SG651.DATA_ISCRIZIONE, SG651.OPERATORE_ISCRIZIONE, SG651.' +
        'DATA_AUTORIZZAZIONE, '
      
        '       SG651.OPERATORE_AUTORIZZAZIONE, SG651.DATA_VALIDAZIONE, S' +
        'G651.OPERATORE_VALIDAZIONE, '
      '       SG651.ROWID RI,'
      '       SG651.ROWID, '
      '       '#39' '#39' PULSANTE, '
      '       SG650.DECORRENZA, '
      '       SG650.PROFILO_CREDITI,'
      '       TO_NUMBER(SG650.MAX_ISCRITTI,'#39'9999'#39') MAX_ISCRITTI,'
      
        '       TO_NUMBER(SG650.MAX_PARTECIPANTI,'#39'9999'#39') MAX_PARTECIPANTI' +
        ','
      '       SG650.DATA_FINE,'
      '       T030.MATRICOLA, '
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '       sg659.descrizione as descgiorno,'
      '       '#39'PARTECIPANTE'#39' TIPO_PARTECIPAZIONE, '
      '       0 CREDITI'
      
        'FROM SG651_PIANIFICAZIONECORSI SG651, SG650_TESTATACORSI SG650, ' +
        'sg659_giornatecorsi sg659, :QVISTAORACLE '
      ' AND SG651.PROGRESSIVO = T030.PROGRESSIVO '
      ' AND SG651.COD_CORSO = SG650.CODICE '
      ' AND SG651.EDIZIONE = SG650.EDIZIONE '
      ' AND SG659.COD_CORSO=SG651.COD_CORSO '
      ' AND SG659.NUMERO_GIORNO=SG651.NUMERO_GIORNO '
      ' AND SG651.DATA_CORSO BETWEEN :DATAINIZIO AND :DATAFINE '
      '     :FILTRO '
      '/* END_REFRESH */'
      'UNION '
      
        'SELECT SG664.COD_CORSO, SG664.EDIZIONE, SG664.PROGRESSIVO, 0 NUM' +
        'ERO_GIORNO, '
      '       SG664.DECORRENZA, '#39'00.00'#39', '#39'00.00'#39', SG664.ORE_DOCENZA, '
      '       SG664.NOTE, '#39'M'#39', '#39'O'#39', '#39'I'#39', '
      '       SG650.DECORRENZA, '#39' '#39', SG650.DECORRENZA, '
      '       '#39' '#39', SG650.DECORRENZA, '#39' '#39', '
      '       SG664.ROWID RI, '
      '       SG664.ROWID, '
      '       '#39' '#39' PULSANTE, '
      '       SG650.DECORRENZA, '
      '       SG650.PROFILO_CREDITI, '
      '       TO_NUMBER(SG650.MAX_ISCRITTI,'#39'9999'#39') MAX_ISCRITTI,'
      
        '       TO_NUMBER(SG650.MAX_PARTECIPANTI,'#39'9999'#39') MAX_PARTECIPANTI' +
        ','
      '       SG650.DATA_FINE, '
      '       T030.MATRICOLA, '
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, '
      '       '#39' '#39' descgiorno,  '
      
        '       DECODE(SG664.TIPO,'#39'D'#39','#39'DOCENTE'#39','#39'R'#39','#39'RESPONSABILE SCIENTI' +
        'FICO'#39','#39'T'#39','#39'TUTOR'#39','#39'ALTRO'#39') TIPO_PARTECIPAZIONE, '
      '       SG664.NUMERO_CREDITI CREDITI '
      
        'FROM SG664_DOCENTI SG664, SG650_TESTATACORSI SG650, :QVISTAORACL' +
        'E '
      '  AND SG664.COD_CORSO = SG650.CODICE '
      '  AND SG664.EDIZIONE = SG650.EDIZIONE'
      '  AND SG664.PROGRESSIVO = T030.PROGRESSIVO '
      '  AND SG650.DECORRENZA BETWEEN :DATAINIZIO AND :DATAFINE '
      '  :FILTRODOCENTI'
      'ORDER BY 1,2,5,6')
    Optimize = False
    Variables.Data = {
      0400000006000000160000003A00440041005400410049004E0049005A004900
      4F000C00000000000000000000001A0000003A00510056004900530054004100
      4F005200410043004C004500010000000000000000000000160000003A004400
      4100540041004C00410056004F0052004F000C00000000000000000000001200
      00003A004400410054004100460049004E0045000C0000000000000000000000
      0E0000003A00460049004C00540052004F000100000000000000000000001C00
      00003A00460049004C00540052004F0044004F00430045004E00540049000100
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001B00000016000000500052004F004700520045005300530049005600
      4F000100000000001200000043004F0044005F0043004F00520053004F000100
      000000001400000044004100540041005F0043004F00520053004F0001000000
      0000140000004F00520041005F0049004E0049005A0049004F00010000000000
      100000004F00520041005F00460049004E004500010000000000180000004400
      550052004100540041005F0043004F00520053004F0001000000000008000000
      4E004F0054004500010000000000160000005400490050004F005F0052004500
      43004F00520044000100000000000E0000004F0052004900470049004E004500
      010000000000040000005200490001000000000010000000500055004C005300
      41004E0054004500010000000000140000004400450043004F00520052004500
      4E005A0041000100000000001A0000004E0055004D00450052004F005F004700
      49004F0052004E004F000100000000000A00000053005400410054004F000100
      000000001E00000044004100540041005F00490053004300520049005A004900
      4F004E004500010000000000280000004F00500045005200410054004F005200
      45005F00490053004300520049005A0049004F004E0045000100000000002600
      000044004100540041005F004100550054004F00520049005A005A0041005A00
      49004F004E004500010000000000300000004F00500045005200410054004F00
      520045005F004100550054004F00520049005A005A0041005A0049004F004E00
      45000100000000002000000044004100540041005F00560041004C0049004400
      41005A0049004F004E0045000100000000002A0000004F005000450052004100
      54004F00520045005F00560041004C004900440041005A0049004F004E004500
      010000000000100000004500440049005A0049004F004E004500010000000000
      1E000000500052004F00460049004C004F005F00430052004500440049005400
      4900010000000000180000004D00410058005F00490053004300520049005400
      54004900010000000000200000004D00410058005F0050004100520054004500
      43004900500041004E0054004900010000000000120000004D00410054005200
      490043004F004C004100010000000000140000004E004F004D0049004E004100
      5400490056004F00010000000000140000004400450053004300470049004F00
      52004E004F00010000000000}
    BeforePost = selSG651BeforePost
    OnCalcFields = selSG651CalcFields
    Left = 273
    Top = 405
    object selSG651PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selSG651COD_CORSO: TStringField
      FieldName = 'COD_CORSO'
      Required = True
      Size = 15
    end
    object selSG651DATA_CORSO: TDateTimeField
      FieldName = 'DATA_CORSO'
      Required = True
    end
    object selSG651ORA_INIZIO: TStringField
      FieldName = 'ORA_INIZIO'
      Size = 5
    end
    object selSG651ORA_FINE: TStringField
      FieldName = 'ORA_FINE'
      Size = 5
    end
    object selSG651DURATA_CORSO: TStringField
      FieldName = 'DURATA_CORSO'
      Size = 7
    end
    object selSG651NOTE: TStringField
      FieldName = 'NOTE'
      Size = 300
    end
    object selSG651TIPO_RECORD: TStringField
      FieldName = 'TIPO_RECORD'
      Required = True
      Size = 1
    end
    object selSG651ORIGINE: TStringField
      FieldName = 'ORIGINE'
      Required = True
      Size = 1
    end
    object selSG651RI: TStringField
      FieldName = 'RI'
      Size = 18
    end
    object selSG651PULSANTE: TStringField
      FieldName = 'PULSANTE'
      Size = 1
    end
    object selSG651Desc_Corso: TStringField
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'Desc_Corso'
      Size = 50
      Calculated = True
    end
    object selSG651Desc_TipoPart: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_TipoPart'
      Size = 50
      Calculated = True
    end
    object selSG651STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object selSG651Desc_Stato: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Stato'
      Calculated = True
    end
    object selSG651NUMERO_GIORNO: TFloatField
      FieldName = 'NUMERO_GIORNO'
    end
    object selSG651DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
    object selSG651EDIZIONE: TStringField
      FieldName = 'EDIZIONE'
      Size = 5
    end
    object selSG651PROFILO_CREDITI: TStringField
      FieldName = 'PROFILO_CREDITI'
      Size = 5
    end
    object selSG651DATA_ISCRIZIONE: TDateTimeField
      FieldName = 'DATA_ISCRIZIONE'
    end
    object selSG651MAX_ISCRITTI: TFloatField
      FieldName = 'MAX_ISCRITTI'
    end
    object selSG651MAX_PARTECIPANTI: TFloatField
      FieldName = 'MAX_PARTECIPANTI'
    end
    object selSG651OPERATORE_ISCRIZIONE: TStringField
      FieldName = 'OPERATORE_ISCRIZIONE'
      Size = 30
    end
    object selSG651OPERATORE_AUTORIZZAZIONE: TStringField
      FieldName = 'OPERATORE_AUTORIZZAZIONE'
      Size = 30
    end
    object selSG651DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selSG651DATA_FINE: TDateTimeField
      FieldName = 'DATA_FINE'
    end
    object selSG651MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selSG651NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selSG651DESCGIORNO: TStringField
      FieldName = 'DESCGIORNO'
      Size = 100
    end
    object selSG651TIPO_PARTECIPAZIONE: TStringField
      DisplayWidth = 25
      FieldName = 'TIPO_PARTECIPAZIONE'
      Size = 25
    end
    object selSG651CREDITI: TFloatField
      FieldName = 'CREDITI'
    end
  end
  object selSG650: TOracleDataSet
    SQL.Strings = (
      'select distinct s650.codice,'
      #9's650.titolo_corso,'
      #9'profilo_corso'
      'from   sg650_testatacorsi s650, sg660_calendariocorsi s660'
      'where  s650.codice = s660.cod_corso and'
      '       data_giorno between :DATAINIZIO and :DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A00440041005400410049004E0049005A004900
      4F000C0000000000000000000000120000003A00440041005400410046004900
      4E0045000C0000000000000000000000}
    Left = 22
    Top = 405
  end
  object selSG654: TOracleDataSet
    SQL.Strings = (
      'select * from sg654_tipopartecipazione'
      'order by codice')
    ReadBuffer = 5
    Optimize = False
    Left = 744
    Top = 405
  end
  object delT003: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete from t003_selezionianagrafe'
      '  where nome = :nome;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 192
    Top = 213
  end
  object Q950Lista: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T950_STAMPACARTELLINO '
      'ORDER BY CODICE')
    ReadBuffer = 20
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 722
    Top = 64
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      
        'select DISTINCT NVL(DATAADOZ,DATANAS) DATA, COGNOME || '#39' '#39' || NO' +
        'ME NOME, NUMORD, GRADOPAR'
      'from   SG101_FAMILIARI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      ':FILTRO '
      'order by 1, 2'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    Left = 24
    Top = 348
  end
  object selQSQL: TOracleQuery
    Optimize = False
    Left = 544
    Top = 248
  end
  object cdsT950Int: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 248
  end
  object selSG650Ediz: TOracleDataSet
    SQL.Strings = (
      'select distinct '
      '        s650.decorrenza,'
      #9's650.codice, '
      #9's650.edizione,'
      #9's650.titolo_corso, '
      #9's650.numero_crediti, '
      
        #9'decode(s650.flag_interno,'#39'I'#39','#39'Interno'#39','#39'E'#39','#39'Esterno'#39') flag_inte' +
        'rno,'
      #9's650.luogo_corso, '
      #9's650.metodo_corso, '
      
        #9'decode(s650.evento_progetto,'#39'E'#39','#39'Evento'#39','#39'P'#39','#39'Progetto'#39') evento' +
        '_progetto, '
      #9's650.max_partecipanti, '
      #9's650.max_iscritti, '
      #9's650.note, '
      #9's650.link_programma_corso'
      'from sg650_testatacorsi s650, sg660_calendariocorsi s660'
      'where s650.codice = s660.cod_corso and'
      '      s650.edizione = s660.edizione and'
      '      s660.cod_corso = :codicein and'
      '      s660.DATA_GIORNO between :DATAINIZIO and :DATAFINE'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A0043004F00440049004300450049004E000500
      00000000000000000000160000003A00440041005400410049004E0049005A00
      49004F000C0000000000000000000000120000003A0044004100540041004600
      49004E0045000C0000000000000000000000}
    Left = 140
    Top = 405
  end
  object selSG650Giorn: TOracleDataSet
    SQL.Strings = (
      'select s660.numero_giorno, s660.data_giorno, s659.descrizione'
      
        'from sg650_testatacorsi s650, sg660_calendariocorsi s660, sg659_' +
        'giornatecorsi s659'
      'where s650.codice = s660.cod_corso and'
      '      s650.edizione = s660.edizione and'
      '      s660.cod_corso = s659.cod_corso and'
      '      s660.numero_giorno = s659.numero_giorno and'
      '      s650.codice = :codicein and'
      '      s650.decorrenza = :decorrenza and'
      '      s650.edizione = :edizione and '
      '      s660.DATA_GIORNO between :DATAINIZIO and :DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000005000000120000003A0043004F00440049004300450049004E000500
      00000000000000000000160000003A004400450043004F005200520045004E00
      5A0041000C0000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000120000003A004500
      440049005A0049004F004E004500050000000000000000000000}
    Left = 212
    Top = 405
  end
  object selSG659: TOracleDataSet
    SQL.Strings = (
      'select ORE_GIORNO '
      'from sg659_giornatecorsi'
      'where cod_corso = :codicein and'
      '      numero_giorno = :NumGG')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F00440049004300450049004E000500
      000000000000000000000C0000003A004E0055004D0047004700030000000000
      000000000000}
    Left = 692
    Top = 404
  end
  object selSG651Iscritti: TOracleDataSet
    SQL.Strings = (
      'select count(distinct progressivo) iscritti'
      'from sg651_pianificazionecorsi sg651'
      'where sg651.cod_corso = :codicein and'
      '      sg651.edizione = :edizione'
      '      :giorno')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A0043004F00440049004300450049004E000500
      000000000000000000000E0000003A00470049004F0052004E004F0001000000
      0000000000000000120000003A004500440049005A0049004F004E0045000500
      00000000000000000000}
    Left = 336
    Top = 405
  end
  object selSG650c: TOracleDataSet
    SQL.Strings = (
      'select distinct s650.codice,'
      '       s650.titolo_corso'
      '  from sg650_testatacorsi s650,'
      '       sg660_calendariocorsi s660,'
      '       sg651_pianificazionecorsi s651'
      ' where s650.codice = s660.cod_corso and'
      '       s650.codice = s651.cod_corso and '
      '       ((s651.stato = '#39'R'#39') or (s651.stato = '#39'A'#39')) and'
      '       s660.data_giorno between :DATAINIZIO and :DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A00440041005400410049004E0049005A004900
      4F000C0000000000000000000000120000003A00440041005400410046004900
      4E0045000C0000000000000000000000}
    Left = 78
    Top = 405
  end
  object selT910: TOracleDataSet
    SQL.Strings = (
      'SELECT APPLICAZIONE,CODICE,TITOLO FROM T910_RIEPILOGO'
      
        'WHERE CODICE NOT IN (SELECT ID FROM I025_CESTINO WHERE TABELLA =' +
        ' '#39'T910_RIEPILOGO'#39')'
      'ORDER BY APPLICAZIONE,CODICE')
    ReadBuffer = 5
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 778
    Top = 64
  end
  object SelCurriculum: TOracleDataSet
    SQL.Strings = (
      'select SG110.PROGRESSIVO, '
      
        '       T030.MATRICOLA || '#39' - '#39' || T030.COGNOME || '#39' '#39' || T030.NO' +
        'ME AS NOMINATIVO,'
      '       TO_CHAR(SG110.INIZIO_ESPERIENZA,'#39'DD/MM/YYYY'#39') AS INIZIO,'
      '       TO_CHAR(SG110.FINE_ESPERIENZA,'#39'DD/MM/YYYY'#39') AS FINE, '
      '       SG112.DESCRIZIONE AS DETTAGLIO,'
      '       SG111.DESCRIZIONE AS TIPOESPERIENZA,'
      '       SG110.LUOGO_ESPERIENZA AS LUOGO,'
      '       SG110.DESCRIZIONE AS NOTE'
      
        '  from sg110_curriculum SG110, SG111_TIPOESPERIENZE SG111, SG112' +
        '_DETTAGLIOESPERIENZE SG112, T030_ANAGRAFICO T030'
      '  WHERE SG110.PROGRESSIVO=T030.PROGRESSIVO'
      '    AND T030.MATRICOLA = :MATRICOLA'
      '    AND SG111.CODICE = SG110.TIPOESPERIENZA '
      '    AND SG112.TIPOESPERIENZA = SG110.TIPOESPERIENZA '
      '    AND SG112.CODICE = SG110.DETTAGLIOESPERIENZA'
      '  ORDER BY SG110.INIZIO_ESPERIENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001C0000005400490050004F00450053005000450052004900
      45004E005A004100010000000000120000004400450054005400410047004C00
      49004F000100000000000A0000004C0055004F0047004F000100000000000800
      00004E004F00540045000100000000000C00000049004E0049005A0049004F00
      01000000000008000000460049004E004500010000000000140000004E004F00
      4D0049004E0041005400490056004F00010000000000}
    Left = 400
    Top = 248
    object SelCurriculumPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object SelCurriculumNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 72
    end
    object SelCurriculumINIZIO: TStringField
      FieldName = 'INIZIO'
      Size = 10
    end
    object SelCurriculumFINE: TStringField
      FieldName = 'FINE'
      Size = 10
    end
    object SelCurriculumDETTAGLIO: TStringField
      FieldName = 'DETTAGLIO'
      Size = 100
    end
    object SelCurriculumTIPOESPERIENZA: TStringField
      FieldName = 'TIPOESPERIENZA'
      Size = 100
    end
    object SelCurriculumLUOGO: TStringField
      FieldName = 'LUOGO'
      Required = True
      Size = 200
    end
    object SelCurriculumNOTE: TStringField
      FieldName = 'NOTE'
      Size = 1000
    end
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select t430.progressivo, :field campo'
      'from t430_storico t430, t030_anagrafico t030'
      'where t030.progressivo = :progressivo'
      '      and t030.progressivo = t430.progressivo '
      
        '      and :DATALAVORO between t430.datadecorrenza and t430.dataf' +
        'ine')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000000C0000003A0046004900
      45004C004400010000000000000000000000}
    Left = 136
    Top = 456
  end
  object selSG651ControlloIscritti: TOracleDataSet
    SQL.Strings = (
      'select progressivo'
      'from sg651_pianificazionecorsi'
      'where progressivo = :prog and'
      '      cod_corso = :codicein and'
      '      numero_giorno = :numero_giorno')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      0000120000003A0043004F00440049004300450049004E000500000000000000
      000000001C0000003A004E0055004D00450052004F005F00470049004F005200
      4E004F00030000000000000000000000}
    Left = 438
    Top = 404
  end
  object SelSG655: TOracleDataSet
    SQL.Strings = (
      'select distinct (profilo_crediti) profilo_crediti'
      'from sg655_profilicrediti'
      'where codice = :codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 640
    Top = 404
  end
  object selT375: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from T375_ACCESSIMENSA t'
      'where PROGRESSIVO = :progressivo'
      'and Data between :dal and :al'
      'order by Data')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 80
    Top = 456
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'select codice,descrizione from T305_CAUGIUSTIF'
      'order by codice')
    Optimize = False
    Left = 24
    Top = 456
  end
  object selP442Cumulo: TOracleDataSet
    SQL.Strings = (
      'SELECT'
      
        '      NUMREC, ORIGINE, VOCE, DESCRIZIONE, COD_VALUTA_INIZ, IMPOR' +
        'TO_VALUTA_INIZ, IMPORTO_COLONNA,'
      
        '      LTRIM(TO_CHAR(QUANTITA,'#39'9G999G999G990D'#39'||LPAD('#39'9'#39',NQ,'#39'9'#39'),' +
        #39'nls_numeric_characters='#39#39',.'#39#39#39')) AS QUANTITA,'
      
        '      LTRIM(TO_CHAR(DATOBASE,'#39'9G999G999G990D'#39'||LPAD('#39'9'#39',ND,'#39'9'#39'),' +
        #39'nls_numeric_characters='#39#39',.'#39#39#39')) AS DATOBASE,'
      '      IMPORTO, DATA_COMPETENZA_A, STAMPA_COMPETENZA,'
      
        '      STAMPA_CEDOLINO, COD_VOCE, COD_VOCE_SPECIALE, ID_CEDOLINO,' +
        ' COD_PAGAMENTO, NOTE, DESC_PAGAMENTO, CHIUSO, '
      '      COD_VALUTA_STAMPA, COD_VALUTA_BASE, DATA_CAMBIO_VALUTA'
      'FROM'
      '('
      '--Nessun cumulo e No Stampa'
      
        'SELECT 1 AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39') as AN' +
        'NO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS QUANTITA,'
      
        '       TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS DATOBASE,'
      '       LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39') AS ND,'
      '       LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39') NQ,'
      '       P442.IMPORTO, P442.DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE,'
      '       P130.DESCRIZIONE DESC_PAGAMENTO, P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      'PROGRESSIVO = :Progressivo AND'
      'DATA_CEDOLINO = :Data_Cedolino AND'
      'DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      'TIPO_CEDOLINO = :Tipo_Cedolino AND'
      'P441.ID_CEDOLINO = P442.ID_CEDOLINO AND'
      'P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND'
      'P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      
        'P442.DATA_COMPETENZA_A < :DATA_CUMULO_MAX AND P442.ORIGINE <> '#39'R' +
        #39' AND P200.CUMULO_ANNUALE_CEDOLONE IN ('#39'NC'#39','#39'NS'#39')'
      'UNION ALL'
      '--stesso DatoBase, cumula Importo e abblenca Quantita'
      
        'SELECT COUNT(*) AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39 +
        ') as ANNO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       MAX(TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_nu' +
        'meric_characters='#39#39',.'#39#39#39')) AS QUANTITA,'
      
        '       TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS DATOBASE,'
      '       MAX(LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39')) ND,'
      '       MAX(LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39')) NQ,'
      
        '       SUM(P442.IMPORTO) AS IMPORTO, MAX(P442.DATA_COMPETENZA_A)' +
        ' as DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE, P130.DE' +
        'SCRIZIONE DESC_PAGAMENTO, P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      
        'PROGRESSIVO = :Progressivo AND DATA_CEDOLINO = :Data_Cedolino AN' +
        'D DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      
        'TIPO_CEDOLINO = :Tipo_Cedolino AND P441.ID_CEDOLINO = P442.ID_CE' +
        'DOLINO AND P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      'P442.DATA_COMPETENZA_A < :DATA_CUMULO_MAX AND'
      'P442.ORIGINE <> '#39'R'#39' AND P200.CUMULO_ANNUALE_CEDOLONE = '#39'IM'#39
      'GROUP BY to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39'), P442.ORIGINE,'
      '       :CODICIDESCRIZIONIGRUPPO,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA, P442.DATOBASE,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, P130.DESCRIZIONE, P' +
        '441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      'UNION ALL'
      '--abblenca Quantita, cumula Importo e DatoBase'
      
        'SELECT COUNT(*) AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39 +
        ') as ANNO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       MAX(TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_nu' +
        'meric_characters='#39#39',.'#39#39#39')) AS QUANTITA,'
      
        '       SUM(TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_nu' +
        'meric_characters='#39#39',.'#39#39#39')) AS DATOBASE,'
      '       MAX(LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39')) ND,'
      '       MAX(LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39')) NQ,'
      
        '       SUM(P442.IMPORTO) AS IMPORTO, MAX(P442.DATA_COMPETENZA_A)' +
        ' as DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE, P130.DE' +
        'SCRIZIONE DESC_PAGAMENTO, P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      
        'PROGRESSIVO = :Progressivo AND DATA_CEDOLINO = :Data_Cedolino AN' +
        'D DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      
        'TIPO_CEDOLINO = :Tipo_Cedolino AND P441.ID_CEDOLINO = P442.ID_CE' +
        'DOLINO AND P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      'P442.DATA_COMPETENZA_A < :DATA_CUMULO_MAX AND'
      'P442.ORIGINE <> '#39'R'#39' AND P200.CUMULO_ANNUALE_CEDOLONE = '#39'IB'#39
      'GROUP BY to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39'), P442.ORIGINE,'
      '       :CODICIDESCRIZIONIGRUPPO,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, P130.DESCRIZIONE, P' +
        '441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      'UNION ALL'
      '--stesso DatoBase, cumula Importo e Quantita'
      
        'SELECT COUNT(*) AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39 +
        ') as ANNO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       SUM(TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_nu' +
        'meric_characters='#39#39',.'#39#39#39')) AS QUANTITA,'
      
        '       TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS DATOBASE,'
      '       MAX(LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39')) ND,'
      '       MAX(LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39')) NQ,'
      
        '       SUM(P442.IMPORTO) AS IMPORTO, MAX(P442.DATA_COMPETENZA_A)' +
        ' as DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE, P130.DE' +
        'SCRIZIONE DESC_PAGAMENTO, P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      
        'PROGRESSIVO = :Progressivo AND DATA_CEDOLINO = :Data_Cedolino AN' +
        'D DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      
        'TIPO_CEDOLINO = :Tipo_Cedolino AND P441.ID_CEDOLINO = P442.ID_CE' +
        'DOLINO AND P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      'P442.DATA_COMPETENZA_A < :DATA_CUMULO_MAX AND'
      'P442.ORIGINE <> '#39'R'#39' AND P200.CUMULO_ANNUALE_CEDOLONE = '#39'IQ'#39
      'GROUP BY to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39'), P442.ORIGINE,'
      '       :CODICIDESCRIZIONIGRUPPO,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA, P442.DATOBASE,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, P130.DESCRIZIONE, P' +
        '441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      'UNION ALL'
      '--stessa Quantita, cumula Importo e DatoBase'
      
        'SELECT COUNT(*) AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39 +
        ') as ANNO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS QUANTITA,'
      
        '       SUM(TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_nu' +
        'meric_characters='#39#39',.'#39#39#39')) AS DATOBASE,'
      '       MAX(LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39')) ND,'
      '       MAX(LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39')) NQ,'
      
        '       SUM(P442.IMPORTO) AS IMPORTO, MAX(P442.DATA_COMPETENZA_A)' +
        ' as DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE, P130.DE' +
        'SCRIZIONE DESC_PAGAMENTO, P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      
        'PROGRESSIVO = :Progressivo AND DATA_CEDOLINO = :Data_Cedolino AN' +
        'D DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      
        'TIPO_CEDOLINO = :Tipo_Cedolino AND P441.ID_CEDOLINO = P442.ID_CE' +
        'DOLINO AND P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      'P442.DATA_COMPETENZA_A < :DATA_CUMULO_MAX AND'
      'P442.ORIGINE <> '#39'R'#39' AND P200.CUMULO_ANNUALE_CEDOLONE = '#39'ID'#39
      'GROUP BY to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39'), P442.ORIGINE,'
      '       :CODICIDESCRIZIONIGRUPPO,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA, P442.QUANTITA,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO,P130.DESCRIZIONE,P44' +
        '1.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      'UNION ALL'
      '--Voci del mese corrente'
      
        'SELECT 1 AS NUMREC, to_char(P442.DATA_COMPETENZA_A,'#39'YYYY'#39') as AN' +
        'NO, P442.ORIGINE,'
      '       :CODICIDESCRIZIONI,'
      
        '       P442.COD_VALUTA_INIZ, P442.IMPORTO_VALUTA_INIZ, P200.IMPO' +
        'RTO_COLONNA,'
      
        '       TO_NUMBER(P442.QUANTITA,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS QUANTITA,'
      
        '       TO_NUMBER(P442.DATOBASE,'#39'9G999G999G999D99999'#39','#39'nls_numeri' +
        'c_characters='#39#39',.'#39#39#39') AS DATOBASE,'
      '       LENGTH(P442.DATOBASE) - INSTR(P442.DATOBASE,'#39','#39') AS ND,'
      '       LENGTH(P442.QUANTITA) - INSTR(P442.QUANTITA,'#39','#39') NQ,'
      '       P442.IMPORTO, P442.DATA_COMPETENZA_A,'
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, '#39#39' AS NOTE,'
      '       P130.DESCRIZIONE DESC_PAGAMENTO,P441.CHIUSO, '
      
        '       P441.COD_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_C' +
        'AMBIO_VALUTA'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE'
      'PROGRESSIVO = :Progressivo AND'
      'DATA_CEDOLINO = :Data_Cedolino AND'
      'DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      'TIPO_CEDOLINO = :Tipo_Cedolino AND'
      'P441.ID_CEDOLINO = P442.ID_CEDOLINO AND'
      'P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND'
      'P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39') AND'
      
        '((P442.DATA_COMPETENZA_A >= :DATA_CUMULO_MAX) OR (P442.ORIGINE =' +
        ' '#39'R'#39'))'
      ')'
      'ORDER BY COD_VOCE,COD_VOCE_SPECIALE,DATA_COMPETENZA_A')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000240000003A0044004100540041005F00
      52004500540052004900420055005A0049004F004E0045000C00000000000000
      000000001C0000003A005400490050004F005F004300450044004F004C004900
      4E004F000500000000000000000000001C0000003A0044004100540041005F00
      4300450044004F004C0049004E004F000C00000000000000000000001E000000
      3A0044004100540041005F0045004D0049005300530049004F004E0045000500
      000000000000000000001C0000003A0043004F004E00540052004F004C004C00
      41004400410054004100050000000000000000000000240000003A0043004F00
      44004900430049004400450053004300520049005A0049004F004E0049000100
      00000000000000000000300000003A0043004F00440049004300490044004500
      53004300520049005A0049004F004E004900470052005500500050004F000100
      00000000000000000000200000003A0044004100540041005F00430055004D00
      55004C004F005F004D00410058000C0000000000000000000000}
    Left = 256
    Top = 512
  end
  object selP442NonCumulo: TOracleDataSet
    SQL.Strings = (
      'SELECT :CODICIDESCRIZIONI,'
      
        '       P200.IMPORTO_COLONNA, P442.COD_VALUTA_INIZ, P442.IMPORTO_' +
        'VALUTA_INIZ, P442.QUANTITA, P442.DATOBASE, P442.IMPORTO,'
      '       P442.DATA_COMPETENZA_A, '
      
        '       P200.STAMPA_COMPETENZA, P200.STAMPA_CEDOLINO, P200.COD_VO' +
        'CE, P200.COD_VOCE_SPECIALE,'
      
        '       P441.ID_CEDOLINO, P441.COD_PAGAMENTO, P441.NOTE, P441.COD' +
        '_VALUTA_STAMPA, P441.COD_VALUTA_BASE, P441.DATA_CAMBIO_VALUTA,'
      '       P130.DESCRIZIONE DESC_PAGAMENTO, P441.CHIUSO'
      
        'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' +
        ' P130_PAGAMENTI P130'
      'WHERE '
      'PROGRESSIVO = :Progressivo AND '
      'DATA_CEDOLINO = :Data_Cedolino AND'
      'DATA_RETRIBUZIONE = :Data_Retribuzione AND'
      ':Data_Cumulo_Max = :Data_Cumulo_Max AND'
      'TIPO_CEDOLINO = :Tipo_Cedolino AND'
      'P441.ID_CEDOLINO = P442.ID_CEDOLINO AND'
      'P130.COD_PAGAMENTO(+) = P441.COD_PAGAMENTO AND'
      'P442.TIPO_RECORD = '#39'M'#39' AND'
      'P442.ID_VOCE = P200.ID_VOCE AND'
      
        '(NVL(DATA_EMISSIONE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(TO_DAT' +
        'E(:Data_Emissione,'#39'DD/MM/YYYY'#39'),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) ' +
        'OR :ControllaData = '#39'N'#39')'
      
        '-- ORDER BY P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P442.DATA_COMPE' +
        'TENZA_DA'
      'ORDER BY :CODICIDESCRIZIONIGRUPPO, P442.DATA_COMPETENZA_DA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000240000003A0044004100540041005F00
      52004500540052004900420055005A0049004F004E0045000C00000000000000
      000000001C0000003A005400490050004F005F004300450044004F004C004900
      4E004F000500000000000000000000001C0000003A0044004100540041005F00
      4300450044004F004C0049004E004F000C00000000000000000000001E000000
      3A0044004100540041005F0045004D0049005300530049004F004E0045000500
      000000000000000000001C0000003A0043004F004E00540052004F004C004C00
      41004400410054004100050000000000000000000000240000003A0043004F00
      44004900430049004400450053004300520049005A0049004F004E0049000100
      00000000000000000000300000003A0043004F00440049004300490044004500
      53004300520049005A0049004F004E004900470052005500500050004F000100
      00000000000000000000200000003A0044004100540041005F00430055004D00
      55004C004F005F004D00410058000C0000000000000000000000}
    Left = 344
    Top = 512
  end
  object selP442: TOracleDataSet
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000240000003A0044004100540041005F00
      52004500540052004900420055005A0049004F004E0045000C00000000000000
      000000001C0000003A005400490050004F005F004300450044004F004C004900
      4E004F000500000000000000000000001C0000003A0044004100540041005F00
      4300450044004F004C0049004E004F000C00000000000000000000001E000000
      3A0044004100540041005F0045004D0049005300530049004F004E0045000500
      000000000000000000001C0000003A0043004F004E00540052004F004C004C00
      41004400410054004100050000000000000000000000240000003A0043004F00
      44004900430049004400450053004300520049005A0049004F004E0049000100
      00000000000000000000300000003A0043004F00440049004300490044004500
      53004300520049005A0049004F004E004900470052005500500050004F000100
      00000000000000000000200000003A0044004100540041005F00430055004D00
      55004C004F005F004D00410058000C0000000000000000000000}
    Left = 192
    Top = 512
  end
  object selP500: TOracleDataSet
    SQL.Strings = (
      
        'select INDIRIZZO,CAP,COMUNE,COD_FISCALE,SEDE_SERVIZIO_CED,UNITA_' +
        'OP_CED,QUALIFICA_CED,DATA_INIZIO_CED,PIVA_CED,PATH_FILEPDF_CED,'
      
        '       WEB_PATH_ISTRUZIONI,FAM_DATA_DA,FAM_DATA_A,FAM_STATO_CIVI' +
        'LE,FAM_PATH_ISTRUZIONI,FAM_NOTE, WEB_DATA_STAMPA'
      'from p500_cudsetup t'
      'where anno=:anno')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 464
    Top = 512
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select t030.progressivo, t030.codfiscale, p092.posizione p092pos' +
        'izione_inail,'
      
        '       t430fine, t430indirizzo, t430cap, t430d_comune, t430d_pro' +
        'vincia,'
      '       p430cod_posizione_economica, p430perc_parttime'
      '      :dati_p500'
      'from  t030_anagrafico t030,'
      '      v430_storico v430,'
      '      p092_codiciinail p092'
      'where t030.progressivo = :Progressivo'
      'and   t030.progressivo = t430progressivo'
      'and   :DataRetrib between t430datadecorrenza and t430datafine'
      'and   p092.cod_codiceinail(+) = p430cod_codiceinail'
      
        'and   :DataCedolino between p092.decorrenza(+) and p092.decorren' +
        'za_fine(+)')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540049005F00
      50003500300030000100000000000000000000001A0000003A00440041005400
      41004300450044004F004C0049004E004F000C00000000000000000000001600
      00003A0044004100540041005200450054005200490042000C00000000000000
      00000000}
    Left = 16
    Top = 512
  end
  object selP441_Note: TOracleDataSet
    SQL.Strings = (
      'SELECT NOTE FROM P441_CEDOLINO'
      'WHERE ID_CEDOLINO=:ID_CEDOLINO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00490044005F004300450044004F004C004900
      4E004F00030000000000000000000000}
    Left = 128
    Top = 512
  end
  object selP442A: TOracleDataSet
    SQL.Strings = (
      'SELECT SUM(IMPORTO) IMPORTO'
      'FROM'
      '('
      'SELECT IMPORTO'
      'FROM P442_CEDOLINOVOCI P442, P441_CEDOLINO P441 WHERE '
      '  COD_VOCE = :Cod_Voce AND'
      
        '  TO_CHAR(DATA_COMPETENZA_A,'#39'YYYY'#39') = TO_CHAR(:DataCedolinoInSta' +
        'mpa,'#39'YYYY'#39') AND'
      '  TIPO_RECORD = '#39'M'#39' AND'
      '  CHIUSO = '#39'S'#39' AND'
      '  P441.ID_CEDOLINO<> :CedolinoInStampa AND'
      '  PROGRESSIVO = :Progressivo AND'
      '  P442.ID_CEDOLINO = P441.ID_CEDOLINO AND'
      '  P441.DATA_RETRIBUZIONE <= :DataRetribInStampa'
      'UNION ALL'
      'SELECT IMPORTO '
      'FROM P442_CEDOLINOVOCI WHERE'
      '  COD_VOCE = :Cod_Voce AND'
      
        '  TO_CHAR(DATA_COMPETENZA_A,'#39'YYYY'#39') = TO_CHAR(:DataCedolinoInSta' +
        'mpa,'#39'YYYY'#39') AND'
      '  TIPO_RECORD = '#39'M'#39' AND'
      '  ID_CEDOLINO= :CedolinoInStampa'
      ')')
    Optimize = False
    Variables.Data = {
      0400000005000000120000003A0043004F0044005F0056004F00430045000500
      00000000000000000000220000003A004300450044004F004C0049004E004F00
      49004E005300540041004D005000410003000000000000000000000018000000
      3A00500052004F0047005200450053005300490056004F000300000000000000
      000000002A0000003A0044004100540041004300450044004F004C0049004E00
      4F0049004E005300540041004D00500041000C00000000000000000000002600
      00003A00440041005400410052004500540052004900420049004E0053005400
      41004D00500041000C0000000000000000000000}
    Left = 416
    Top = 512
  end
  object selP441: TOracleDataSet
    SQL.Strings = (
      'select '
      '  Rowid,'
      '  to_char(DATA_CEDOLINO,'#39'MM/YYYY'#39') DATA_CEDOLINO,'
      '  to_char(DATA_RETRIBUZIONE,'#39'MM/YYYY'#39') DATA_RETRIBUZIONE, '
      
        '  decode(TIPO_CEDOLINO,'#39'NR'#39','#39'Normale'#39','#39'EX'#39','#39'Extra'#39','#39'TR'#39','#39'Tredice' +
        'sima'#39') TIPO_CEDOLINO, '
      '  DATA_EMISSIONE, '
      '  DATA_CONSEGNA,'
      '  ID_CEDOLINO'
      'from P441_CEDOLINO P441'
      'where '
      '  PROGRESSIVO = :PROGRESSIVO and '
      
        '  DATA_CEDOLINO  between :DATA_CEDOLINO1 and :DATA_CEDOLINO2 and' +
        ' '
      '  CHIUSO = '#39'S'#39' and'
      '  sysdate >= DATA_EMISSIONE + :WEB_CEDOLINI_GGEMISS and'
      '  DATA_CEDOLINO >= :WEB_CEDOLINI_DATAMIN and'
      '  (:WEB_CEDOLINI_MMPREC < 0 or '
      
        '   trunc(DATA_CEDOLINO,'#39'MM'#39') >= add_months(trunc(sysdate,'#39'MM'#39'),-' +
        ':WEB_CEDOLINI_MMPREC))'
      
        'order by P441.DATA_CEDOLINO desc, P441.DATA_RETRIBUZIONE, P441.D' +
        'ATA_EMISSIONE')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0044004100540041005F00
      4300450044004F004C0049004E004F0031000C00000000000000000000001E00
      00003A0044004100540041005F004300450044004F004C0049004E004F003200
      0C00000000000000000000002A0000003A005700450042005F00430045004400
      4F004C0049004E0049005F004700470045004D00490053005300030000000000
      0000000000002A0000003A005700450042005F004300450044004F004C004900
      4E0049005F0044004100540041004D0049004E000C0000000000000000000000
      280000003A005700450042005F004300450044004F004C0049004E0049005F00
      4D004D005000520045004300030000000000000000000000}
    OnFilterRecord = selP441FilterRecord
    Left = 504
    Top = 512
    object selP441DATA_CEDOLINO: TStringField
      FieldName = 'DATA_CEDOLINO'
      Size = 7
    end
    object selP441DATA_RETRIBUZIONE: TStringField
      FieldName = 'DATA_RETRIBUZIONE'
      Size = 7
    end
    object selP441TIPO_CEDOLINO: TStringField
      FieldName = 'TIPO_CEDOLINO'
      Size = 15
    end
    object selP441DATA_EMISSIONE: TDateTimeField
      FieldName = 'DATA_EMISSIONE'
    end
    object selP441DATA_CONSEGNA: TDateTimeField
      FieldName = 'DATA_CONSEGNA'
    end
    object selP441ID_CEDOLINO: TFloatField
      FieldName = 'ID_CEDOLINO'
    end
  end
  object dsrP441: TDataSource
    DataSet = selP441
    Left = 552
    Top = 512
  end
  object delSG651: TOracleQuery
    SQL.Strings = (
      'delete from SG651_PIANIFICAZIONECORSI '
      'where cod_corso = :COD_CORSO '
      'and edizione = :EDIZIONE '
      'and data_corso = :DATA '
      'and progressivo = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F0044005F0043004F00520053004F00
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000120000003A004500440049005A0049004F00
      4E004500050000000000000000000000}
    Left = 627
    Top = 456
  end
  object selSg651StatoGiornate: TOracleDataSet
    SQL.Strings = (
      'select distinct decode(stato,'#39'I'#39','#39'A'#39','#39'C'#39','#39'N'#39',stato)'
      'from SG651_PIANIFICAZIONECORSI SG651'
      'where SG651.cod_corso = :cod_corso '
      'and SG651.edizione = :edizione'
      'and SG651.progressivo = :progressivo'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F0044005F0043004F00520053004F00
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F00030000000000000000000000120000003A00450044004900
      5A0049004F004E004500050000000000000000000000}
    Left = 558
    Top = 404
  end
  object delSG651b: TOracleQuery
    SQL.Strings = (
      'delete from SG651_PIANIFICAZIONECORSI '
      'where cod_corso = :cod_corso '
      'and edizione = :edizione '
      'and progressivo = :progressivo')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F0044005F0043004F00520053004F00
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F00030000000000000000000000120000003A00450044004900
      5A0049004F004E004500050000000000000000000000}
    Left = 687
    Top = 456
  end
  object upSG651: TOracleQuery
    SQL.Strings = (
      'update SG651_PIANIFICAZIONECORSI set stato = :stato'
      'where cod_corso = :cod_corso '
      'and edizione = :edizione '
      'and progressivo = :progressivo '
      'and stato in ('#39'R'#39','#39'A'#39','#39'N'#39')')
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A0053005400410054004F000500000000000000
      00000000140000003A0043004F0044005F0043004F00520053004F0005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A004500440049005A004900
      4F004E004500050000000000000000000000}
    Left = 746
    Top = 456
  end
  object selI060Utenti: TOracleDataSet
    SQL.Strings = (
      'select I060.NOME_UTENTE, T030.COGNOME, T030.NOME, T030.MATRICOLA'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = :AZIENDA and'
      '       I060.NOME_UTENTE <> :UTENTE and'
      '       I060.MATRICOLA = T030.MATRICOLA (+)'
      '       :FILTRO'
      '       :FILTRO_ANAGRAFICHE'
      'order by I060.NOME_UTENTE')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      0000000000000E0000003A00460049004C00540052004F000100000000000000
      00000000260000003A00460049004C00540052004F005F0041004E0041004700
      5200410046004900430048004500010000000000000000000000}
    Left = 24
    Top = 576
  end
  object selI061NomiProfili: TOracleDataSet
    SQL.Strings = (
      'select distinct NOME_PROFILO'
      'from   MONDOEDP.I061_PROFILI_DIPENDENTE'
      'where  AZIENDA = :AZIENDA and'
      '       DELEGATO_DA IS NULL and'
      '       SYSDATE between INIZIO_VALIDITA and FINE_VALIDITA'
      'order by NOME_PROFILO')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 104
    Top = 576
  end
  object selI061PermessiUtente: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   MONDOEDP.I061_PROFILI_DIPENDENTE'
      'where  AZIENDA = :AZIENDA '
      'and    NOME_UTENTE = :UTENTE'
      'and    NOME_PROFILO = :PROFILO'
      'and    sysdate between INIZIO_VALIDITA and FINE_VALIDITA'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000100000003A00500052004F00460049004C004F00050000000000
      000000000000}
    Left = 210
    Top = 576
  end
  object selI061DelegheUtente: TOracleDataSet
    SQL.Strings = (
      
        'select I061.*, I061.ROWID, T030.COGNOME, T030.NOME, T030.COGNOME' +
        '||'#39' '#39'||T030.NOME NOMINATIVO'
      
        'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061, MONDOEDP.I060_LOGI' +
        'N_DIPENDENTE I060, T030_ANAGRAFICO T030'
      'where  I061.AZIENDA = :AZIENDA and'
      '       I061.DELEGATO_DA = :UTENTE and'
      '       I061.FINE_VALIDITA >= :DATA_LIMITE and'
      '       I061.AZIENDA = I060.AZIENDA and'
      '       I061.NOME_UTENTE = I060.NOME_UTENTE and'
      '       I060.MATRICOLA = T030.MATRICOLA (+)'
      'order by I061.NOME_UTENTE')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000180000003A0044004100540041005F004C0049004D0049005400
      45000C0000000000000000000000}
    Left = 323
    Top = 576
  end
  object selI061DelegheEsistenti: TOracleDataSet
    SQL.Strings = (
      'select I061.*, I061.ROWID'
      'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'where  I061.AZIENDA = :AZIENDA and'
      '       I061.NOME_UTENTE = :UTENTE and'
      '       I061.NOME_PROFILO = :PROFILO and'
      '       (((I061.INIZIO_VALIDITA >= :DATA_DAL and'
      '          I061.INIZIO_VALIDITA <= :DATA_AL) or'
      '         (I061.FINE_VALIDITA >= :DATA_DAL and'
      '          I061.FINE_VALIDITA <= :DATA_AL)) or'
      '        (I061.INIZIO_VALIDITA <= :DATA_DAL and'
      '         I061.FINE_VALIDITA >= :DATA_AL))')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000100000003A00500052004F00460049004C004F00050000000000
      000000000000120000003A0044004100540041005F00440041004C000C000000
      0000000000000000100000003A0044004100540041005F0041004C000C000000
      0000000000000000}
    Left = 437
    Top = 576
  end
  object selI060DatiUtente: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = :AZIENDA and'
      '       I060.NOME_UTENTE = :UTENTE and'
      '       I060.MATRICOLA = T030.MATRICOLA')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 32
    Top = 640
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'select I090.*'
      'from   MONDOEDP.I090_ENTI I090'
      'where  I090.AZIENDA = :AZIENDA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 112
    Top = 640
  end
  object selI061ProfiloAssegnato: TOracleDataSet
    SQL.Strings = (
      'select I061.*, I061.ROWID'
      'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'where  I061.AZIENDA = :AZIENDA and'
      '       I061.NOME_UTENTE = :UTENTE and'
      '       I061.NOME_PROFILO = :PROFILO and'
      '       I061.DELEGATO_DA IS NULL')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000100000003A00500052004F00460049004C004F00050000000000
      000000000000}
    Left = 557
    Top = 576
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'SELECT I061.*'
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE'
      '   AND TRUNC(SYSDATE) BETWEEN INIZIO_VALIDITA AND FINE_VALIDITA'
      ' ORDER BY I061.NOME_PROFILO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 181
    Top = 640
  end
  object selDatoLibero: TOracleDataSet
    ReadBuffer = 200
    Optimize = False
    Left = 655
    Top = 151
  end
  object selP504: TOracleDataSet
    SQL.Strings = (
      'select P504.PROGRESSIVO, P504.ANNO + 1 ANNO '
      'from P504_CUDTESTATE P504, P500_CUDSETUP P500'
      'where P504.PROGRESSIVO = :PROGRESSIVO'
      '  and P504.CHIUSO = '#39'S'#39' AND P504.TIPO_OPERAZIONE <> '#39'A'#39
      '  and P504.ANNO = P500.ANNO'
      '  and P500.WEB_STAMPA = '#39'S'#39
      'group by P504.PROGRESSIVO, P504.ANNO'
      'order by P504.ANNO desc')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 600
    Top = 512
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  NULL IMGSTAMPA,  '
      '  T040.*,'
      '  NVL(T265.DESCRIZIONE,T275.DESCRIZIONE) DESCRIZIONE,'
      '  T040.ROWID'
      'FROM '
      
        '  T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T275_CAUPRESEN' +
        'ZE T275'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DAL AND :AL AND'
      '  T040.CAUSALE = T265.CODICE(+) AND'
      '  T040.CAUSALE = T275.CODICE(+)'
      'ORDER BY T040.DATA, T040.CAUSALE')
    ReadBuffer = 40
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000B00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C00450001000000000018000000500052004F0047005200
      430041005500530041004C004500010000000000120000005400490050004F00
      470049005500530054000100000000000A000000440041004F00520045000100
      000000000800000041004F00520045000100000000000C000000530043004800
      4500440041000100000000000C0000005300540041004D005000410001000000
      00000E00000044004100540041004E0041005300010000000000160000004400
      450053004300520049005A0049004F004E004500010000000000}
    UpdatingTable = 'T040_GIUSTIFICATIVI'
    Left = 540
    Top = 8
    object selT040IMGSTAMPA: TStringField
      FieldName = 'IMGSTAMPA'
      Size = 1
    end
    object selT040PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT040DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
    end
    object selT040CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selT040DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT040DATANAS: TDateTimeField
      DisplayLabel = 'Riferimento'
      FieldName = 'DATANAS'
    end
    object selT040PROGRCAUSALE: TFloatField
      FieldName = 'PROGRCAUSALE'
      Required = True
      Visible = False
    end
    object selT040TIPOGIUST: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPOGIUST'
      Size = 1
    end
    object selT040DAORE: TDateTimeField
      DisplayLabel = 'Ore/Dalle'
      FieldName = 'DAORE'
      DisplayFormat = 'hh.nn'
    end
    object selT040AORE: TDateTimeField
      DisplayLabel = 'Alle'
      FieldName = 'AORE'
      DisplayFormat = 'hh.nn'
    end
    object selT040SCHEDA: TStringField
      FieldName = 'SCHEDA'
      Visible = False
      Size = 1
    end
    object selT040STAMPA: TStringField
      FieldName = 'STAMPA'
      Visible = False
      Size = 1
    end
    object selT040NOTE: TStringField
      FieldName = 'NOTE'
      Size = 10
    end
  end
  object sel2T100: TOracleQuery
    SQL.Strings = (
      
        '/*W018 CONTROLLO ESISTENZA TIMBRATURA LEGATA AD EVENTO BTNINSERI' +
        'SCI*/'
      'SELECT COUNT(*)'
      '  FROM T100_TIMBRATURE T100'
      ' WHERE T100.FLAG IN ('#39'I'#39','#39'O'#39')'
      '   AND'#9'T100.PROGRESSIVO = :PROGRESSIVO'
      '   AND T100.DATA = :DATA'
      '   AND TO_CHAR(T100.ORA,'#39'HH24.MI'#39') = :ORA'
      '   AND T100.VERSO = :VERSO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F00050000000000000000000000}
    Left = 264
    Top = 215
  end
  object selSG101Causali: TOracleDataSet
    SQL.Strings = (
      
        'select NUMORD, nvl(DATAADOZ,DATANAS) DATA, '#39'<'#39'||replace(CAUSALI_' +
        'ABILITATE,'#39','#39','#39'>,<'#39')||'#39'>'#39' CAUSALI_ABILITATE,'
      '       DECORRENZA, DECORRENZA_FINE'
      'from   SG101_FAMILIARI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      ':FILTRO'
      'order by NUMORD, DECORRENZA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    Filtered = True
    Left = 91
    Top = 348
  end
  object selT080: TOracleDataSet
    SQL.Strings = (
      'select T080.ROWID, T080.*'
      'from   T080_PIANIFORARI T080'
      'where  T080.PROGRESSIVO = :PROGRESSIVO'
      'and    T080.DATA BETWEEN :DATAINIZIO AND :DATAFINE'
      'order by DATA'
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A00440041005400410049004E0049005A004900
      4F000C0000000000000000000000120000003A00440041005400410046004900
      4E0045000C0000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F00030000000000000000000000}
    Left = 681
    Top = 12
  end
  object selT020: TOracleDataSet
    SQL.Strings = (
      
        'select T020.CODICE, T020.DESCRIZIONE, T020.TIPOORA, T020.PERLAV,' +
        ' count(T021.TIPO_FASCIA) TURNI'
      'from   T020_ORARI T020, T021_FASCEORARI T021'
      'where  T020.DECORRENZA = (select max(DECORRENZA) '
      '                          from   T020_ORARI '
      '                          where  CODICE = T020.CODICE)'
      'and    T020.CODICE = T021.CODICE(+) '
      'and    T020.DECORRENZA = T021.DECORRENZA(+) '
      'and    T021.TIPO_FASCIA(+) = '#39'PN'#39
      
        'group by T020.CODICE, T020.DESCRIZIONE, T020.TIPOORA, T020.PERLA' +
        'V'
      'order by T020.CODICE')
    ReadBuffer = 500
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000080000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      00005400490050004F004F00520041000100000000000C000000500045005200
      4C00410056000100000000001000000045004E00540052004100540041003100
      0100000000001000000045004E00540052004100540041003200010000000000
      1000000045004E00540052004100540041003300010000000000100000004500
      4E00540052004100540041003400010000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 730
    Top = 12
  end
  object selT163: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T163_CODICIINDENNITA'
      'order by CODICE'
      '')
    ReadBuffer = 31
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 777
    Top = 12
  end
  object selaP504: TOracleDataSet
    SQL.Strings = (
      'select p504.data_consegna, p504.rowid'
      'from p504_cudtestate p504'
      'where progressivo = :progressivo'
      'and anno = :anno'
      'and p504.chiuso='#39'S'#39' and p504.tipo_operazione <> '#39'A'#39
      
        'and data_chiusura = (select max(b.data_chiusura) from P504_CUDTE' +
        'STATE B where b.progressivo = p504.progressivo and b.anno = p504' +
        '.anno)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 648
    Top = 512
  end
  object selAnagrafePeriodica: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C00000000000000000000000E0000003A00460049004C00540052004F00
      010000000000000000000000}
    Left = 60
    Top = 296
  end
  object updP441: TOracleQuery
    SQL.Strings = (
      'update p441_cedolino'
      'set data_consegna = :data_consegna'
      'where id_cedolino = :id_cedolino')
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A0044004100540041005F0043004F004E005300
      450047004E0041000C0000000000000000000000180000003A00490044005F00
      4300450044004F004C0049004E004F00030000000000000000000000}
    Left = 811
    Top = 512
  end
  object insT280: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T280_MESSAGGIWEB'
      '  (progressivo, data, mittente, testo, log, flag, titolo)'
      'VALUES'
      '  (:PROGRESSIVO,:DATA,:MITTENTE,:TESTO, :LOG, :FLAG, :TITOLO)'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A004D0049005400540045004E0054004500
      0500000000000000000000000C0000003A0054004500530054004F0005000000
      00000000000000000A0000003A0046004C004100470005000000000000000000
      00000E0000003A005400490054004F004C004F00050000000000000000000000
      080000003A004C004F004700050000000000000000000000}
    Left = 362
    Top = 64
  end
  object selSG122: TOracleDataSet
    SQL.Strings = (
      'select  SG122.*, SG122.ROWID, TO_CHAR(DATANAS,'#39'HH24.MI'#39') ORANAS'
      'from    SG122_FAMILIARIDIPDET SG122'
      'where   SG122.PROGRESSIVO = :PROGRESSIVO'
      'and     SG122.DATA_AGG = :DATA_AGG'
      
        'ORDER BY DECODE(TIPO_FAM,'#39'CG'#39',1,'#39'FG1'#39',2,'#39'FG2'#39',3,'#39'FG3'#39',4,'#39'FG4'#39',5,' +
        #39'FG5'#39',6,'#39'FG6'#39',7,'#39'AL1'#39',8,'#39'AL2'#39',9,'#39'AL3'#39',10)')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    OnCalcFields = selSG122CalcFields
    Left = 94
    Top = 752
    object selSG122PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selSG122DATA_AGG: TDateTimeField
      FieldName = 'DATA_AGG'
    end
    object selSG122TIPO_FAM: TStringField
      FieldName = 'TIPO_FAM'
      Size = 3
    end
    object selSG122NUMORD: TFloatField
      FieldName = 'NUMORD'
    end
    object selSG122COGNOME: TStringField
      FieldName = 'COGNOME'
      Size = 30
    end
    object selSG122NOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
    object selSG122CARICO: TStringField
      FieldName = 'CARICO'
      Size = 1
    end
    object selSG122DATA_CARICO_DA: TDateTimeField
      FieldName = 'DATA_CARICO_DA'
    end
    object selSG122DATA_CARICO_A: TDateTimeField
      FieldName = 'DATA_CARICO_A'
    end
    object selSG122PERC_CARICO: TFloatField
      FieldName = 'PERC_CARICO'
    end
    object selSG122MANCA_CONIUGE: TStringField
      FieldName = 'MANCA_CONIUGE'
      Size = 1
    end
    object selSG122DETR_FIGLIO_HANDICAP: TStringField
      FieldName = 'DETR_FIGLIO_HANDICAP'
      Size = 1
    end
    object selSG122DATANAS: TDateTimeField
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
    end
    object selSG122CODFISCALE: TStringField
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object selSG122DESC_TIPO_FAM: TStringField
      FieldKind = fkCalculated
      FieldName = 'DESC_TIPO_FAM'
      Calculated = True
    end
    object selSG122ORANAS: TStringField
      FieldName = 'ORANAS'
      Size = 5
    end
  end
  object insSG122: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I integer;'
      '  NumFg integer;'
      '  NumAl integer;'
      ''
      '  CURSOR C1(Progress IN INTEGER, Decorr IN DATE) IS'
      '  SELECT SG101.GRADOPAR, SG101.NUMORD,'
      
        '         NVL(TRIM(SG101.COGNOME),'#39'XXX'#39') COGNOME, NVL(TRIM(SG101.' +
        'NOME),'#39'XXX'#39') NOME,'
      
        '         SG101.DATANAS, SG101.CODFISCALE, SG101.DETR_FIGLIO_HAND' +
        'ICAP'
      '  FROM SG101_FAMILIARI SG101'
      
        '  WHERE SG101.PROGRESSIVO=Progress AND Decorr BETWEEN SG101.DECO' +
        'RRENZA AND SG101.DECORRENZA_FINE'
      '  AND SG101.GRADOPAR IN('#39'CG'#39','#39'FG'#39','#39'GT'#39','#39'FR'#39','#39'NP'#39','#39'AL'#39') AND'
      '      ('
      '      SG101.TIPO_DETRAZIONE<>'#39'ND'#39' OR'
      
        '      (SG101.TIPO_DETRAZIONE='#39'ND'#39' AND NVL(TO_CHAR(SG101.DATASEP,' +
        #39'YYYY'#39'),'#39'3999'#39')>=TO_CHAR(Decorr,'#39'YYYY'#39'))'
      '      )'
      '  ORDER BY SG101.DATANAS;'
      ''
      
        '  CURSOR C2(Progress IN INTEGER, Anno IN VARCHAR2, NumOrdine IN ' +
        'INTEGER,'
      '            TipoDetr1 IN VARCHAR2, TipoDetr2 IN VARCHAR2) IS'
      
        '  SELECT GREATEST(MIN(SG101.DECORRENZA),TO_DATE('#39'0101'#39'||Anno,'#39'DD' +
        'MMYYYY'#39')) CARICO_DA,'
      
        '         LEAST(MAX(SG101.DECORRENZA_FINE),TO_DATE('#39'3112'#39'||Anno,'#39 +
        'DDMMYYYY'#39')) CARICO_A,'
      
        '         MIN(SG101.TIPO_DETRAZIONE) TIPO_DETRAZIONE, MAX(SG101.P' +
        'ERC_CARICO) PERC_CARICO'
      '  FROM SG101_FAMILIARI SG101'
      '  WHERE SG101.PROGRESSIVO=Progress AND SG101.NUMORD=NumOrdine'
      '    AND SG101.DECORRENZA<=TO_DATE('#39'3112'#39'||Anno,'#39'DDMMYYYY'#39')'
      '    AND SG101.DECORRENZA_FINE>=TO_DATE('#39'0101'#39'||Anno,'#39'DDMMYYYY'#39')'
      
        '    AND (SG101.TIPO_DETRAZIONE=TipoDetr1 OR SG101.TIPO_DETRAZION' +
        'E=TipoDetr2);'
      ''
      '  /*DA 21/02/2013'
      '  TROPPI_FIGLI EXCEPTION;'
      '  TROPPI_ALTRI EXCEPTION;'
      '  */'
      ''
      'BEGIN'
      ''
      '  --DA 21/02/2013'
      '  -- Cancello i record temporanei precedenti'
      '  DELETE SG120_FAMILIARIDIPGEN'
      '  WHERE PROGRESSIVO = :Progressivo'
      '  AND DATA_AGG >= :Data_Fissa;'
      ''
      '  -- Testata'
      '  INSERT INTO SG120_FAMILIARIDIPGEN'
      '    (PROGRESSIVO, DATA_AGG, CONFERMA)'
      '  VALUES'
      '    (:Progressivo, :Data_Agg, '#39'N'#39');'
      '  -- Detrazioni per redditi di lavoro dipendente e assimilati'
      '  UPDATE SG120_FAMILIARIDIPGEN SG120'
      '    SET SG120.DETRAZ_LAVDIP='
      
        '        (SELECT P430.DETRAZ_LAVDIP FROM P430_ANAGRAFICO P430 WHE' +
        'RE P430.PROGRESSIVO=:Progressivo'
      
        '         AND :Data_Agg BETWEEN P430.DECORRENZA AND P430.DECORREN' +
        'ZA_FINE'
      '         AND P430.DETRAZ_LAVDIP IN ('#39'S'#39','#39'N'#39'))'
      
        '  WHERE SG120.PROGRESSIVO=:Progressivo AND SG120.DATA_AGG=:Data_' +
        'Agg;'
      '  -- Stato civile se da richiedere'
      '  UPDATE SG120_FAMILIARIDIPGEN SG120'
      '    SET SG120.COD_STATOCIVILE='
      
        '        (SELECT P430.COD_STATOCIVILE FROM P430_ANAGRAFICO P430 W' +
        'HERE P430.PROGRESSIVO=:Progressivo'
      
        '         AND :Data_Agg BETWEEN P430.DECORRENZA AND P430.DECORREN' +
        'ZA_FINE)'
      
        '  WHERE SG120.PROGRESSIVO=:Progressivo AND SG120.DATA_AGG=:Data_' +
        'Agg'
      '    AND EXISTS'
      '    (SELECT '#39'X'#39' FROM P500_CUDSETUP P500'
      
        '     WHERE P500.ANNO=TO_CHAR(:Data_Agg,'#39'YYYY'#39') AND P500.FAM_STAT' +
        'O_CIVILE='#39'S'#39');'
      ''
      '  -- Dettagli'
      '  NumFg:=0;'
      '  NumAL:=0;'
      '  FOR T1 IN C1(:Progressivo, :Data_Agg) LOOP'
      ''
      '    IF T1.GRADOPAR = '#39'CG'#39' THEN'
      '      -- Coniuge'
      
        '      FOR T2 IN C2(:Progressivo, TO_CHAR(:Data_Agg,'#39'YYYY'#39'), T1.N' +
        'UMORD, '#39'DC'#39', '#39'DC'#39') LOOP'
      '        IF T2.CARICO_DA IS NOT NULL THEN'
      '          -- Coniuge inserito solo se a carico'
      '          INSERT INTO SG122_FAMILIARIDIPDET'
      
        '            (PROGRESSIVO, DATA_AGG, TIPO_FAM, NUMORD, COGNOME, N' +
        'OME, CARICO, DATA_CARICO_DA, DATA_CARICO_A,'
      '             DATANAS, CODFISCALE)'
      '          VALUES'
      
        '            (:Progressivo, :Data_Agg, '#39'CG'#39', T1.NUMORD, UPPER(T1.' +
        'COGNOME), UPPER(T1.NOME), '#39'S'#39', T2.CARICO_DA, T2.CARICO_A,'
      '             T1.DATANAS, T1.CODFISCALE);'
      '        END IF;'
      '      END LOOP;'
      '    ELSIF T1.GRADOPAR = '#39'FG'#39' THEN'
      '      -- Figlio'
      '      /*DA 21/02/2013'
      '      NumFg:=NumFg + 1;'
      '      IF NumFg > 6 THEN'
      '        RAISE TROPPI_FIGLI;'
      '      END IF;'
      '      INSERT INTO SG122_FAMILIARIDIPDET'
      
        '        (PROGRESSIVO, DATA_AGG, TIPO_FAM, NUMORD, COGNOME, NOME,' +
        ' CARICO, DETR_FIGLIO_HANDICAP, DATANAS, CODFISCALE)'
      '      VALUES'
      
        '        (:Progressivo, :Data_Agg, '#39'FG'#39'||TO_CHAR(NumFg), T1.NUMOR' +
        'D, UPPER(T1.COGNOME), UPPER(T1.NOME), '#39'N'#39', T1.DETR_FIGLIO_HANDIC' +
        'AP, T1.DATANAS, T1.CODFISCALE);'
      '      -- Periodo per figlio a carico'
      
        '      FOR T2 IN C2(:Progressivo, TO_CHAR(:Data_Agg,'#39'YYYY'#39'), T1.N' +
        'UMORD, '#39'DC'#39', '#39'DF'#39') LOOP'
      '        UPDATE SG122_FAMILIARIDIPDET SG122'
      
        '          SET SG122.CARICO='#39'S'#39', SG122.DATA_CARICO_DA=T2.CARICO_D' +
        'A, SG122.DATA_CARICO_A=T2.CARICO_A,'
      
        '              SG122.MANCA_CONIUGE=DECODE(T2.TIPO_DETRAZIONE,'#39'DC'#39 +
        ','#39'S'#39','#39'N'#39'),'
      '              SG122.PERC_CARICO=T2.PERC_CARICO'
      
        '        WHERE SG122.PROGRESSIVO=:Progressivo AND SG122.DATA_AGG=' +
        ':Data_Agg AND SG122.NUMORD=T1.NUMORD'
      '          AND T2.CARICO_DA IS NOT NULL;'
      '      END LOOP;'
      '      */'
      '      --DA 21/02/2013'
      
        '      FOR T2 IN C2(:Progressivo, TO_CHAR(:Data_Agg,'#39'YYYY'#39'), T1.N' +
        'UMORD, '#39'DC'#39', '#39'DF'#39') LOOP'
      '        IF T2.CARICO_DA IS NOT NULL THEN'
      '          -- Figlio inserito solo se a carico'
      '          NumFg:=NumFg + 1;'
      '          INSERT INTO SG122_FAMILIARIDIPDET'
      
        '            (PROGRESSIVO, DATA_AGG, TIPO_FAM, NUMORD, COGNOME, N' +
        'OME,'
      '             CARICO, DETR_FIGLIO_HANDICAP, DATANAS, CODFISCALE,'
      
        '             DATA_CARICO_DA, DATA_CARICO_A, MANCA_CONIUGE, PERC_' +
        'CARICO)'
      '          VALUES'
      
        '            (:Progressivo, :Data_Agg, '#39'FG'#39'||TO_CHAR(NumFg), T1.N' +
        'UMORD, UPPER(T1.COGNOME), UPPER(T1.NOME),'
      
        '             '#39'S'#39', T1.DETR_FIGLIO_HANDICAP, T1.DATANAS, T1.CODFIS' +
        'CALE,'
      
        '             T2.CARICO_DA, T2.CARICO_A, DECODE(T2.TIPO_DETRAZION' +
        'E,'#39'DC'#39','#39'S'#39','#39'N'#39'), T2.PERC_CARICO);'
      '        END IF;'
      '      END LOOP;'
      '    ELSE'
      '      -- Altro familiare'
      '      /*DA 21/02/2013'
      '      NumAl:=NumAl + 1;'
      '      IF NumAl > 3 THEN'
      '        RAISE TROPPI_ALTRI;'
      '      END IF;'
      '      INSERT INTO SG122_FAMILIARIDIPDET'
      
        '        (PROGRESSIVO, DATA_AGG, TIPO_FAM, NUMORD, COGNOME, NOME,' +
        ' CARICO, DATANAS, CODFISCALE)'
      '      VALUES'
      
        '        (:Progressivo, :Data_Agg, '#39'AL'#39'||TO_CHAR(NumAl), T1.NUMOR' +
        'D, UPPER(T1.COGNOME), UPPER(T1.NOME), '#39'N'#39', T1.DATANAS, T1.CODFIS' +
        'CALE);'
      '      -- Periodo per altro familiare a carico'
      
        '      FOR T2 IN C2(:Progressivo, TO_CHAR(:Data_Agg,'#39'YYYY'#39'), T1.N' +
        'UMORD, '#39'DA'#39', '#39'DA'#39') LOOP'
      '        UPDATE SG122_FAMILIARIDIPDET SG122'
      
        '          SET SG122.CARICO='#39'S'#39', SG122.DATA_CARICO_DA=T2.CARICO_D' +
        'A, SG122.DATA_CARICO_A=T2.CARICO_A,'
      '              SG122.PERC_CARICO=T2.PERC_CARICO'
      
        '        WHERE SG122.PROGRESSIVO=:Progressivo AND SG122.DATA_AGG=' +
        ':Data_Agg AND SG122.NUMORD=T1.NUMORD'
      '          AND T2.CARICO_DA IS NOT NULL;'
      '      END LOOP;'
      '      */'
      '      --DA 21/02/2013'
      
        '      FOR T2 IN C2(:Progressivo, TO_CHAR(:Data_Agg,'#39'YYYY'#39'), T1.N' +
        'UMORD, '#39'DA'#39', '#39'DA'#39') LOOP'
      '        IF T2.CARICO_DA IS NOT NULL THEN'
      '          -- Altro familiare inserito solo se a carico'
      '          NumAl:=NumAl + 1;'
      '          INSERT INTO SG122_FAMILIARIDIPDET'
      
        '            (PROGRESSIVO, DATA_AGG, TIPO_FAM, NUMORD, COGNOME, N' +
        'OME,'
      '             CARICO, DATANAS, CODFISCALE,'
      '             DATA_CARICO_DA, DATA_CARICO_A, PERC_CARICO)'
      '          VALUES'
      
        '            (:Progressivo, :Data_Agg, '#39'AL'#39'||TO_CHAR(NumAl), T1.N' +
        'UMORD, UPPER(T1.COGNOME), UPPER(T1.NOME),'
      '             '#39'S'#39', T1.DATANAS, T1.CODFISCALE,'
      '             T2.CARICO_DA, T2.CARICO_A, T2.PERC_CARICO);'
      '        END IF;'
      '      END LOOP;'
      '    END IF;'
      ''
      '  END LOOP;'
      ''
      '  /*DA 21/02/2013'
      
        '  -- Decorrenze per familiari non a carico; forzate a coincident' +
        'i con l'#39'intero Anno'
      '  UPDATE SG122_FAMILIARIDIPDET SG122 SET'
      
        '    SG122.DATA_CARICO_DA=TO_DATE('#39'0101'#39'||TO_CHAR(:Data_Agg,'#39'YYYY' +
        #39'),'#39'DDMMYYYY'#39'),'
      
        '    SG122.DATA_CARICO_A=TO_DATE('#39'3112'#39'||TO_CHAR(:Data_Agg,'#39'YYYY'#39 +
        '),'#39'DDMMYYYY'#39')'
      
        '  WHERE SG122.PROGRESSIVO=:Progressivo AND SG122.DATA_AGG=:Data_' +
        'Agg AND SG122.CARICO='#39'N'#39';'
      ''
      '  -- Caricamento record vuoti per familiari non presenti'
      
        '  INSERT INTO SG122_FAMILIARIDIPDET  (PROGRESSIVO, DATA_AGG, TIP' +
        'O_FAM)'
      
        '  SELECT :Progressivo, :Data_Agg, '#39'CG'#39' FROM DUAL WHERE NOT EXIST' +
        'S'
      
        '    (SELECT '#39'X'#39' FROM SG122_FAMILIARIDIPDET SG122 WHERE SG122.PRO' +
        'GRESSIVO=:Progressivo'
      '     AND SG122.DATA_AGG=:Data_Agg AND SG122.TIPO_FAM='#39'CG'#39');'
      '  FOR I IN 1..6 LOOP'
      
        '    INSERT INTO SG122_FAMILIARIDIPDET (PROGRESSIVO, DATA_AGG, TI' +
        'PO_FAM)'
      
        '    SELECT :Progressivo, :Data_Agg, '#39'FG'#39'||TO_CHAR(I) FROM DUAL W' +
        'HERE NOT EXISTS'
      
        '      (SELECT '#39'X'#39' FROM SG122_FAMILIARIDIPDET SG122 WHERE SG122.P' +
        'ROGRESSIVO=:Progressivo'
      
        '       AND SG122.DATA_AGG=:Data_Agg AND SG122.TIPO_FAM='#39'FG'#39'||TO_' +
        'CHAR(I));'
      '  END LOOP;'
      '  FOR I IN 1..3 LOOP'
      
        '    INSERT INTO SG122_FAMILIARIDIPDET (PROGRESSIVO, DATA_AGG, TI' +
        'PO_FAM)'
      
        '    SELECT :Progressivo, :Data_Agg, '#39'AL'#39'||TO_CHAR(I) FROM DUAL W' +
        'HERE NOT EXISTS'
      
        '      (SELECT '#39'X'#39' FROM SG122_FAMILIARIDIPDET SG122 WHERE SG122.P' +
        'ROGRESSIVO=:Progressivo'
      
        '       AND SG122.DATA_AGG=:Data_Agg AND SG122.TIPO_FAM='#39'AL'#39'||TO_' +
        'CHAR(I));'
      '  END LOOP;'
      '  */'
      ''
      '/*DA 21/02/2013'
      'EXCEPTION'
      '  WHEN TROPPI_FIGLI THEN'
      '    :MESSAGGIO:='#39'Nel nucleo familiare ci sono pi'#249' di 6 figli!'#39';'
      '  WHEN TROPPI_ALTRI THEN'
      
        '    :MESSAGGIO:='#39'Nel nucleo familiare ci sono pi'#249' di 3 persone o' +
        'ltre al coniuge e ai figli!'#39';'
      '  */'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000160000003A004400410054004100
      5F00460049005300530041000C0000000000000000000000}
    Left = 93
    Top = 800
  end
  object selSG120: TOracleDataSet
    SQL.Strings = (
      'select  SG120.*, SG120.ROWID'
      'from    SG120_FAMILIARIDIPGEN SG120'
      'where   SG120.PROGRESSIVO = :PROGRESSIVO'
      'and     SG120.DATA_AGG = :DATA_AGG')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 38
    Top = 752
  end
  object selaSG120: TOracleDataSet
    SQL.Strings = (
      'select  MAX(SG120.DATA_AGG) DATA_AGG'
      'from    SG120_FAMILIARIDIPGEN SG120'
      'where   SG120.PROGRESSIVO = :PROGRESSIVO'
      'and     SG120.CONFERMA = '#39'S'#39)
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 38
    Top = 800
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from t480_comuni'
      'where codcatastale = :CODCATASTALE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0043004F004400430041005400410053005400
      41004C004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 262
    Top = 752
  end
  object updSG122: TOracleQuery
    SQL.Strings = (
      'UPDATE SG122_FAMILIARIDIPDET SG122'
      '  SET SG122.NUMORD = NVL((SELECT SG101.NUMORD '
      '                            FROM SG101_FAMILIARI SG101 '
      
        '                           WHERE SG101.PROGRESSIVO = SG122.PROGR' +
        'ESSIVO'
      '                             AND SG101.GRADOPAR = '#39'CG'#39' '
      
        '                             AND SG101.CODFISCALE = SG122.CODFIS' +
        'CALE'
      
        '                             AND SG122.DATA_AGG BETWEEN SG101.DE' +
        'CORRENZA AND SG101.DECORRENZA_FINE)'
      '                         ,-1)'
      'WHERE SG122.PROGRESSIVO = :Progressivo '
      '  AND SG122.DATA_AGG = :Data_Agg '
      '  AND SG122.TIPO_FAM = '#39'CG'#39
      '  AND SG122.CODFISCALE IS NOT NULL '
      '  AND SG122.NUMORD = -1')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000}
    Left = 93
    Top = 848
  end
  object selCOLS: TOracleDataSet
    SQL.Strings = (
      'select column_name'
      'from cols'
      'where table_name = :tabella'
      'order by column_id')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 318
    Top = 752
  end
  object insStorico: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'BEGIN'
      '  insert into :Tabella'
      '  (:CampiIns)'
      '  select :CampiSel'
      '  from :Tabella'
      '  where :Decorrenza between decorrenza and decorrenza_fine'
      '  and :CondWhere;'
      '  update :Tabella'
      '  set decorrenza_fine = :Decorrenza - 1'
      '  where :Decorrenza - 1 between decorrenza and decorrenza_fine'
      '  and :CondWhere;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    NULL;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A0054004100420045004C004C00410001000000
      0000000000000000120000003A00430041004D005000490049004E0053000100
      00000000000000000000120000003A00430041004D0050004900530045004C00
      010000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000140000003A0043004F004E004400
      57004800450052004500010000000000000000000000}
    Left = 205
    Top = 752
  end
  object selaSG101: TOracleDataSet
    SQL.Strings = (
      'select distinct numord'
      'from SG101_FAMILIARI sg101'
      'where sg101.progressivo = :progressivo'
      'and not exists (select 1 '
      '                from SG122_FAMILIARIDIPDET sg122'
      '                where sg122.progressivo = :progressivo '
      '                and sg122.data_agg = :data_agg'
      '                and sg122.numord = sg101.numord)')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 150
    Top = 752
  end
  object updSG101: TOracleQuery
    SQL.Strings = (
      'update SG101_FAMILIARI'
      'set :CondSet'
      'where progressivo = :progressivo'
      'and numord = :numord'
      'and decorrenza >= :decorrenza')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000100000003A0043004F004E00440053004500
      5400010000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F000300000000000000000000000E0000003A004E005500
      4D004F0052004400010000000000000000000000}
    Left = 149
    Top = 896
  end
  object insSG101: TOracleQuery
    SQL.Strings = (
      'insert into SG101_FAMILIARI'
      
        '(PROGRESSIVO,NUMORD,DECORRENZA,DECORRENZA_FINE,COGNOME,NOME,GRAD' +
        'OPAR,DATANAS_PRESUNTA)'
      'values'
      
        '(:PROGRESSIVO,:NUMORD,:DECORRENZA,:DECORRENZA_FINE,:COGNOME,:NOM' +
        'E,:GRADOPAR,:DATANAS_PRESUNTA)')
    Optimize = False
    Variables.Data = {
      0400000008000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F000300000000000000000000000E0000003A004E005500
      4D004F0052004400030000000000000000000000100000003A0043004F004700
      4E004F004D0045000500000000000000000000000A0000003A004E004F004D00
      4500050000000000000000000000120000003A0047005200410044004F005000
      41005200050000000000000000000000200000003A004400450043004F005200
      520045004E005A0041005F00460049004E0045000C0000000000000000000000
      220000003A0044004100540041004E00410053005F0050005200450053005500
      4E00540041000C0000000000000000000000}
    Left = 149
    Top = 848
  end
  object selbSG101: TOracleDataSet
    SQL.Strings = (
      'select MAX(numord) NUMORD'
      'from SG101_FAMILIARI sg101'
      'where sg101.progressivo = :PROGRESSIVO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 150
    Top = 800
  end
  object updP430: TOracleQuery
    SQL.Strings = (
      'update P430_ANAGRAFICO'
      'set :CondSet'
      'where progressivo = :progressivo'
      'and decorrenza >= :decorrenza')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000100000003A0043004F00
      4E004400530045005400010000000000000000000000}
    Left = 373
    Top = 752
  end
  object selStorici: TOracleDataSet
    SQL.Strings = (
      'select rowid, decorrenza_fine, :CampiSel valoredati'
      'from :Tabella'
      'where :CondWhere'
      'order by :OrderBy')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000004000000120000003A00430041004D0050004900530045004C000100
      00000000000000000000100000003A0054004100420045004C004C0041000100
      00000000000000000000140000003A0043004F004E0044005700480045005200
      4500010000000000000000000000100000003A004F0052004400450052004200
      5900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 206
    Top = 800
  end
  object selP020: TOracleDataSet
    SQL.Strings = (
      'select cod_statocivile, descrizione '
      'from p020_statocivile'
      'order by cod_statocivile')
    ReadBuffer = 10
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 430
    Top = 752
  end
  object updI061UltimoAccesso: TOracleQuery
    SQL.Strings = (
      'update MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'set    ULTIMO_ACCESSO = sysdate'
      'where  I061.AZIENDA = :AZIENDA'
      'and    I061.NOME_UTENTE = :NOME_UTENTE'
      'and    I061.NOME_PROFILO = :NOME_PROFILO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      540045000500000000000000000000001A0000003A004E004F004D0045005F00
      500052004F00460049004C004F00050000000000000000000000}
    Left = 675
    Top = 576
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select T361.* '
      'from   T361_OROLOGI T361 '
      'order by CODICE')
    Optimize = False
    OnFilterRecord = FiltroDizionario
    Left = 336
    Top = 640
  end
  object selT257: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T257.COD_CODICIACCORPCAUSALI, T257.COD_CAUSALE, T256.DESC' +
        'RIZIONE'
      
        '  FROM T257_ACCORPCAUSALI T257, T256_CODICIACCORPCAUSALI T256, T' +
        '255_TIPOACCORPCAUSALI T255'
      ' WHERE T255.TIPO = '#39'WEB'#39
      '   AND :INDATA BETWEEN T257.DECORRENZA AND T257.DECORRENZA_FINE'
      '   AND T257.COD_TIPOACCORPCAUSALI = T256.COD_TIPOACCORPCAUSALI'
      
        '   AND T257.COD_CODICIACCORPCAUSALI = T256.COD_CODICIACCORPCAUSA' +
        'LI'
      '   AND T257.COD_TIPOACCORPCAUSALI = T255.COD_TIPOACCORPCAUSALI'
      ' ORDER BY T257.COD_CODICIACCORPCAUSALI, T257.COD_CAUSALE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0049004E0044004100540041000C0000000000
      000000000000}
    Left = 548
    Top = 63
  end
  object selAssPres: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'A'#39' TIPO, T265.CODICE, RPAD(T265.CODICE,5,'#39' '#39') || '#39' - '#39' |' +
        '| T265.DESCRIZIONE DESCRIZIONE'
      'from   T265_CAUASSENZE T265'
      'where  T265.UM_INSERIMENTO_H = '#39'S'#39
      'and    VISITA_FISCALE = '#39'N'#39
      'and    TIPOCUMULO not in ('#39'F'#39','#39'G'#39')'
      'and    FRUIZIONE = '#39'N'#39
      'and    CODCAU3 is null'
      'union all'
      
        'select '#39'P'#39' TIPO, T275.CODICE, RPAD(T275.CODICE,5,'#39' '#39') || '#39' - '#39' |' +
        '| T275.DESCRIZIONE DESCRIZIONE'
      'from   T275_CAUPRESENZE T275'
      'where  TIPOCONTEGGIO not in ('#39'A'#39','#39'E'#39')'
      ':ORDINAMENTO')
    ReadBuffer = 150
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004F005200440049004E0041004D0045004E00
      54004F00010000000000000000000000}
    Filtered = True
    OnFilterRecord = selAssPresFilterRecord
    Left = 181
    Top = 700
  end
  object selT280EMail: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  T280.*,T280.ROWID'
      'FROM T280_MESSAGGIWEB T280'
      'WHERE T280.FLAG = '#39'3'#39
      '  AND LOG IS NULL'
      'ORDER BY DATA ')
    ReadBuffer = 50
    Optimize = False
    Left = 421
    Top = 65
  end
  object selT282Count: TOracleQuery
    SQL.Strings = (
      
        'select nvl(sum(decode(T284.DATA_LETTURA,null,1,0)),0) NUM_MSG_TO' +
        'TALI,'
      
        '       nvl(sum(decode(T282.LETTURA_OBBLIGATORIA,'#39'S'#39',decode(T284.' +
        'DATA_RICEZIONE,null,1,0),0)),0) NUM_MSG_LETTURA_OBBLIGATORIA'
      'from   T282_MESSAGGI T282,'
      '       T284_DESTINATARI T284'
      'where  T282.STATO = '#39'I'#39
      'and    T284.ID = T282.ID'
      'and    T284.PROGRESSIVO = :PROGRESSIVO'
      'and    (T284.DATA_LETTURA is null or'
      '        T284.DATA_RICEZIONE is null)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 32
    Top = 944
  end
  object selT282CountOper: TOracleQuery
    SQL.Strings = (
      
        'select nvl(sum(decode(T285.DATA_LETTURA,null,1,0)),0) NUM_MSG_TO' +
        'TALI,'
      
        '       nvl(sum(decode(T282.LETTURA_OBBLIGATORIA,'#39'S'#39',decode(T285.' +
        'DATA_RICEZIONE,null,1,0),0)),0) NUM_MSG_LETTURA_OBBLIGATORIA'
      'from   T282_MESSAGGI T282,'
      '       T285_UTENTI_DEST T285'
      'where  T282.STATO = '#39'I'#39
      'and    T285.ID = T282.ID'
      'and    T285.UTENTE = :UTENTE'
      'and    (T285.DATA_LETTURA is null or'
      '        T285.DATA_RICEZIONE is null)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 128
    Top = 944
  end
  object selDatiPag: TOracleDataSet
    SQL.Strings = (
      
        'select p430conto_corrente, p430d_cod_banca, p430agenzia_banca, p' +
        '430iban'
      'from  v430_storico'
      'where t430progressivo = :Progressivo'
      'and   :Data_Cedolino between t430datadecorrenza and t430datafine')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001C0000003A0044004100540041005F00
      4300450044004F004C0049004E004F000C0000000000000000000000}
    Left = 64
    Top = 512
  end
  object selNotificaEventiSciopero: TOracleDataSet
    SQL.Strings = (
      'select T250.DATA, T250.SELEZIONE_ANAGRAFICA, T250.GG_NOTIFICA'
      'from   T250_SCIOPERI T250,'
      '       T251_SCIOPERI_STRUTTURA T251,'
      '       T850_ITER_RICHIESTE T850'
      'where  T250.ID = T251.ID_T250 (+)'
      'and    T251.PROGRESSIVO(+) = :PROGRESSIVO'
      'and    T251.ID = T850.ID (+)'
      'and    (T251.ID_T250 is null or nvl(T850.STATO,'#39'N'#39') <> '#39'S'#39')'
      
        'and    trunc(sysdate) between T250.DATA - T250.GG_NOTIFICA and T' +
        '250.DATA'
      'order by DATA desc')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 248
    Top = 944
  end
  object selAnagEventoSciopero: TOracleDataSet
    SQL.Strings = (
      '-- v. codice W001UIrisWebDtM')
    ReadBuffer = 500
    Optimize = False
    Left = 378
    Top = 944
  end
  object selT025: TOracleDataSet
    SQL.Strings = (
      'select T430.PROGRESSIVO, T025.PAR_CARTELLINO, T950.CODICE'
      'from   T025_CONTMENSILI T025, '
      '       T430_STORICO T430,'
      '       T950_STAMPACARTELLINO T950'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T025.CODICE = T430.PERSELASTICO'
      'and    T025.PAR_CARTELLINO is not null'
      'and    T950.CODICE = T025.PAR_CARTELLINO')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    ReadOnly = True
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 29
    Top = 997
  end
end
