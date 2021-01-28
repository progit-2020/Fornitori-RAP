inherited A131FGestioneAnticipiMW: TA131FGestioneAnticipiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 252
  Width = 262
  object selTAnticipi: TOracleDataSet
    SQL.Strings = (
      'SELECT M020.CODICE, M020.DESCRIZIONE'
      'FROM M020_TIPIRIMBORSI M020'
      'WHERE M020.FLAG_ANTICIPO='#39'S'#39)
    Optimize = False
    Left = 199
    Top = 9
    object selTAnticipiCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
    end
    object selTAnticipiDESCRIZIONE: TStringField
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
  end
  object dscTAnticipi: TDataSource
    DataSet = selTAnticipi
    Left = 198
    Top = 64
  end
  object selM040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M040.*, (M040.PROGRESSIVO || M040.MESESCARICO || M040.MES' +
        'ECOMPETENZA || M040.DATADA || M040.ORADA) AS IDMISSIONI'
      'FROM M040_MISSIONI M040'
      'WHERE M040.PROGRESSIVO=:PROGRESSIVO'
      #9'AND M040.STATO='#39'D'#39
      'ORDER BY M040.DATADA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F0003000000040000002701000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001F00000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000001400000050005200
      4F0054004F0043004F004C004C004F0001000000000022000000540049005000
      4F00520045004700490053005400520041005A0049004F004E00450001000000
      00000A00000044004100540041004100010000000000080000004F0052004100
      41000100000000001000000054004F00540041004C0045004700470001000000
      00000C0000004400550052004100540041000100000000002000000054004100
      5200490046004600410049004E00440049004E00540045005200410001000000
      0000180000004F005200450049004E00440049004E0054004500520041000100
      000000002000000049004D0050004F00520054004F0049004E00440049004E00
      5400450052004100010000000000240000005400410052004900460046004100
      49004E0044005200490044004F0054005400410048000100000000001C000000
      4F005200450049004E0044005200490044004F00540054004100480001000000
      00002400000049004D0050004F00520054004F0049004E004400520049004400
      4F00540054004100480001000000000024000000540041005200490046004600
      410049004E0044005200490044004F0054005400410047000100000000001C00
      00004F005200450049004E0044005200490044004F0054005400410047000100
      000000002400000049004D0050004F00520054004F0049004E00440052004900
      44004F0054005400410047000100000000002600000054004100520049004600
      4600410049004E0044005200490044004F005400540041004800470001000000
      00001E0000004F005200450049004E0044005200490044004F00540054004100
      480047000100000000002600000049004D0050004F00520054004F0049004E00
      44005200490044004F00540054004100480047000100000000001E0000004600
      4C00410047005F004D004F0044004900460049004300410054004F0001000000
      000010000000500041005200540045004E005A00410001000000000018000000
      440045005300540049004E0041005A0049004F004E0045000100000000001A00
      00004E004F00540045005F00520049004D0042004F0052005300490001000000
      00001000000043004F004D004D0045005300530041000100000000000A000000
      53005400410054004F00010000000000160000004D00410058004D0045005300
      4900520049004D00420001000000000014000000490044004D00490053005300
      49004F004E004900010000000000}
    Left = 79
    Top = 64
    object selM040IDMISSIONI: TStringField
      FieldName = 'IDMISSIONI'
      Size = 50
    end
    object selM040PROTOCOLLO: TStringField
      FieldName = 'PROTOCOLLO'
    end
    object selM040DATADA: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATADA'
    end
    object selM040MESESCARICO: TDateTimeField
      DisplayWidth = 10
      FieldName = 'MESESCARICO'
    end
    object selM040MESECOMPETENZA: TDateTimeField
      DisplayWidth = 10
      FieldName = 'MESECOMPETENZA'
    end
    object selM040ORADA: TStringField
      FieldName = 'ORADA'
    end
    object selM040PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selM040TIPOREGISTRAZIONE: TStringField
      FieldName = 'TIPOREGISTRAZIONE'
      Required = True
      Size = 5
    end
    object selM040DATAA: TDateTimeField
      FieldName = 'DATAA'
    end
    object selM040ORAA: TStringField
      FieldName = 'ORAA'
      Size = 5
    end
    object selM040TOTALEGG: TFloatField
      FieldName = 'TOTALEGG'
    end
    object selM040DURATA: TStringField
      FieldName = 'DURATA'
      Size = 7
    end
    object selM040TARIFFAINDINTERA: TFloatField
      FieldName = 'TARIFFAINDINTERA'
    end
    object selM040OREINDINTERA: TFloatField
      FieldName = 'OREINDINTERA'
    end
    object selM040IMPORTOINDINTERA: TFloatField
      FieldName = 'IMPORTOINDINTERA'
    end
    object selM040TARIFFAINDRIDOTTAH: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAH'
    end
    object selM040OREINDRIDOTTAH: TFloatField
      FieldName = 'OREINDRIDOTTAH'
    end
    object selM040IMPORTOINDRIDOTTAH: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAH'
    end
    object selM040TARIFFAINDRIDOTTAG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAG'
    end
    object selM040OREINDRIDOTTAG: TFloatField
      FieldName = 'OREINDRIDOTTAG'
    end
    object selM040IMPORTOINDRIDOTTAG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAG'
    end
    object selM040TARIFFAINDRIDOTTAHG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAHG'
    end
    object selM040OREINDRIDOTTAHG: TFloatField
      FieldName = 'OREINDRIDOTTAHG'
    end
    object selM040IMPORTOINDRIDOTTAHG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAHG'
    end
    object selM040FLAG_MODIFICATO: TStringField
      FieldName = 'FLAG_MODIFICATO'
      Size = 1
    end
    object selM040PARTENZA: TStringField
      FieldName = 'PARTENZA'
      Size = 80
    end
    object selM040DESTINAZIONE: TStringField
      FieldName = 'DESTINAZIONE'
      Size = 80
    end
    object selM040NOTE_RIMBORSI: TStringField
      FieldName = 'NOTE_RIMBORSI'
      Size = 240
    end
    object selM040COMMESSA: TStringField
      FieldName = 'COMMESSA'
      Size = 80
    end
    object selM040STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object selM040ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
    end
  end
  object SelM050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M040.DATADA, M040.PROTOCOLLO, M050.CODICERIMBORSOSPESE, M' +
        '020.DESCRIZIONE, M050.IMPORTORIMBORSOSPESE'
      
        'FROM M040_MISSIONI M040, M050_RIMBORSI M050, M020_TIPIRIMBORSI M' +
        '020'
      'WHERE M020.FLAG_ANTICIPO='#39'S'#39
      '      AND M050.PROGRESSIVO=M040.PROGRESSIVO'
      '      AND M050.MESESCARICO=M040.MESESCARICO'
      '      AND M050.MESECOMPETENZA=M040.MESECOMPETENZA'
      '      AND M050.DATADA=M040.DATADA'
      '      AND M050.ORADA=M040.ORADA'
      '      AND M020.CODICE=M050.CODICERIMBORSOSPESE'
      '      AND M050.PROGRESSIVO=:PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Left = 143
    Top = 8
    object SelM050DATADA: TDateTimeField
      DisplayLabel = 'DATA MISSIONE'
      DisplayWidth = 15
      FieldName = 'DATADA'
    end
    object SelM050CODICERIMBORSOSPESE: TStringField
      DisplayLabel = 'CODICE'
      DisplayWidth = 10
      FieldName = 'CODICERIMBORSOSPESE'
    end
    object SelM050DESCRIZIONE: TStringField
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SelM050PROTOCOLLO: TStringField
      DisplayWidth = 15
      FieldName = 'PROTOCOLLO'
    end
    object SelM050IMPORTORIMBORSOSPESE: TFloatField
      DisplayLabel = 'IMPORTO'
      FieldName = 'IMPORTORIMBORSOSPESE'
    end
  end
  object dscM050: TDataSource
    DataSet = SelM050
    Left = 142
    Top = 64
  end
  object groupM060: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M060.CASSA AS CASSA, M060.ANNO_MOVIMENTO AS ANNO_MOVIMENT' +
        'O, M060.NROSOSP AS NUMERO_SOSPESO, M060.NUM_MOVIMENTO AS NUMERO_' +
        'MOVIMENTO, M060.STATO AS STATO, SUM(M060.IMPORTO) AS TOTALE_IMPO' +
        'RTO'
      '  FROM M060_ANTICIPI M060 '
      ' WHERE M060.PROGRESSIVO = :PROGRESSIVO'
      '   AND M060.FLAG_TOTALIZZATORE = '#39'S'#39
      
        ' GROUP BY M060.CASSA, M060.ANNO_MOVIMENTO, M060.NROSOSP, M060.NU' +
        'M_MOVIMENTO, M060.STATO'
      ' ORDER BY M060.ANNO_MOVIMENTO DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F0003000000040000008307000000000000}
    ReadOnly = True
    OnCalcFields = groupM060CalcFields
    Left = 80
    Top = 10
    object groupM060CASSA: TStringField
      DisplayWidth = 10
      FieldName = 'CASSA'
    end
    object groupM060ANNO_MOVIMENTO: TStringField
      DisplayWidth = 5
      FieldName = 'ANNO_MOVIMENTO'
    end
    object groupM060NUMERO_SPESO: TFloatField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'NUMERO_SOSPESO'
    end
    object groupM060NUMERO_MOVIMENTO: TFloatField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'NUMERO_MOVIMENTO'
    end
    object groupM060D_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object groupM060IMPORTO: TFloatField
      FieldName = 'TOTALE_IMPORTO'
    end
    object groupM060STATO: TStringField
      DisplayWidth = 20
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
  end
  object sel2M060: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.*'
      '  FROM M060_ANTICIPI M060'
      ' WHERE M060.PROGRESSIVO=:PROGRESSIVO'
      '   AND M060.FLAG_TOTALIZZATORE='#39'S'#39
      '   AND M060.STATO='#39'S'#39
      ' ORDER BY DATA_MISSIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F000100000000000A000000430041005300530041000100000000001C000000
      41004E004E004F005F004D004F00560049004D0045004E0054004F0001000000
      00001A0000004E0055004D005F004D004F00560049004D0045004E0054004F00
      0100000000001000000043004F0044005F0056004F0043004500010000000000
      1A00000044004100540041005F004D0049005300530049004F004E0045000100
      000000001C00000044004100540041005F004D004F00560049004D0045004E00
      54004F00010000000000100000005100550041004E0054004900540041000100
      000000000E00000049004D0050004F00520054004F0001000000000024000000
      46004C00410047005F0054004F00540041004C0049005A005A00410054004F00
      520045000100000000000A00000053005400410054004F000100000000002E00
      000044004100540041005F0049004D0050004F005300540041005A0049004F00
      4E0045005F0053005400410054004F00010000000000080000004E004F005400
      4500010000000000140000004900440041004E00540049004300490050004900
      010000000000}
    Left = 16
    Top = 64
    object sel2M060DATAMISSIONE: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATA_MISSIONE'
    end
    object sel2M060CASSA: TStringField
      DisplayWidth = 6
      FieldName = 'CASSA'
    end
    object sel2M060ANNOMOVIMENTO: TStringField
      DisplayWidth = 5
      FieldName = 'ANNO_MOVIMENTO'
    end
    object sel2M060COD_VOCE: TStringField
      DisplayWidth = 6
      FieldName = 'COD_VOCE'
    end
    object sel2M060NUM_MOVIMENTO: TFloatField
      DisplayWidth = 6
      FieldName = 'NUM_MOVIMENTO'
    end
    object sel2M060PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object sel2M060IMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object sel2M060DATA_MOVIMENTO: TDateTimeField
      FieldName = 'DATA_MOVIMENTO'
    end
    object sel2M060QUANTITA: TFloatField
      FieldName = 'QUANTITA'
    end
    object sel2M060FLAG_TOTALIZZATORE: TStringField
      FieldName = 'FLAG_TOTALIZZATORE'
      Size = 1
    end
    object sel2M060STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object sel2M060DATA_IMPOSTAZIONE_STATO: TDateTimeField
      FieldName = 'DATA_IMPOSTAZIONE_STATO'
    end
    object sel2M060NOTE: TStringField
      FieldName = 'NOTE'
      Size = 500
    end
    object sel2M060ITA_EST: TStringField
      FieldName = 'ITA_EST'
      Size = 1
    end
    object sel2M060NROSOSP: TFloatField
      FieldName = 'NROSOSP'
    end
  end
  object SerchM050: TOracleDataSet
    Optimize = False
    Left = 143
    Top = 111
  end
  object InsM050: TOracleQuery
    Optimize = False
    Left = 16
    Top = 111
  end
  object selMaxM060: TOracleQuery
    SQL.Strings = (
      'SELECT MAX(M060.NUM_MOVIMENTO) + 1 AS NUM_MOVIMENTO'
      'FROM M060_ANTICIPI M060'
      'WHERE M060.PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 79
    Top = 110
  end
  object selM010: TOracleDataSet
    SQL.Strings = (
      'SELECT M010.CODICI_RIMBORSI '
      '  FROM M010_PARAMETRICONTEGGIO M010'
      ' WHERE M010.CODICE=(SELECT T430.:C8_MISSIONI'
      '                      FROM T430_STORICO T430'
      '                     WHERE T430.PROGRESSIVO = :PROGRESSIVO'
      
        '                       AND :DATA BETWEEN T430.DATADECORRENZA AND' +
        ' T430.DATAFINE)'
      '   AND M010.TIPO_MISSIONE=:TIPOMISS'
      '   AND M010.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                            FROM M010_PARAMETRICONTEGGIO'
      '                           WHERE DECORRENZA <= :DATA'
      '                             AND CODICE = (SELECT :C8_MISSIONI'
      '                                             FROM T430_STORICO'
      
        '                                            WHERE PROGRESSIVO = ' +
        ':PROGRESSIVO'
      
        '                                              AND :DATA BETWEEN ' +
        'DATADECORRENZA AND DATAFINE)'
      #9'                     AND TIPO_MISSIONE = M010.TIPO_MISSIONE)')
    Optimize = False
    Variables.Data = {
      0400000004000000120000003A005400490050004F004D004900530053000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000180000003A00430038005F004D0049005300530049004F004E004900
      010000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F00030000000000000000000000}
    Left = 74
    Top = 176
  end
  object SelM020: TOracleDataSet
    SQL.Strings = (
      'SELECT M020.FLAG_ANTICIPO'
      'FROM M020_TIPIRIMBORSI M020'
      'WHERE M020.CODICE=:COD_VOCE')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A0043004F0044005F0056004F00430045000500
      00000000000000000000}
    Left = 12
    Top = 170
  end
end
