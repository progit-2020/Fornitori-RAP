inherited A043FStampaRepMW: TA043FStampaRepMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 208
  Width = 428
  object QContratti: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,REPERIBILITA '
      'FROM T200_CONTRATTI T200')
    Optimize = False
    Left = 20
    Top = 8
    object QContrattiCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T200_CONTRATTI.CODICE'
      Size = 5
    end
    object QContrattiDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T200_CONTRATTI.DESCRIZIONE'
      Size = 40
    end
    object QContrattiREPERIBILITA: TStringField
      FieldName = 'REPERIBILITA'
      Origin = 'T200_CONTRATTI.REPERIBILITA'
      Size = 6
    end
  end
  object QCausaliPResenza: TOracleDataSet
    SQL.Strings = (
      'SELECT  T275.CODICE,T275.DETREPERIB'
      'FROM T275_CAUPRESENZE T275')
    Optimize = False
    Left = 112
    Top = 8
    object QCausaliPResenzaCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T275_CAUPRESENZE.CODICE'
      Size = 5
    end
    object QCausaliPResenzaDETREPERIB: TStringField
      FieldName = 'DETREPERIB'
      Origin = 'T275_CAUPRESENZE.DETREPERIB'
      Size = 1
    end
  end
  object QSostitutivo: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Left = 212
    Top = 8
  end
  object Q380Sost: TOracleDataSet
    SQL.Strings = (
      'SELECT PROGRESSIVO,TURNO1,TURNO2,TURNO3 FROM'
      'T380_PIANIFREPERIB'
      'WHERE (DATA =:DATA) AND'
      '      (PROGRESSIVO =:PROGRESSIVO) AND'
      '      (TIPOLOGIA = '#39'R'#39')')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 212
    Top = 152
  end
  object Q350RegReperib: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T350_REGREPERIB'
      'WHERE TIPOLOGIA = '#39'R'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00004F005200410049004E0049005A0049004F000100000000000E0000004F00
      52004100460049004E0045000100000000000E0000005400490050004F004F00
      52004500010000000000140000004F00520045004E004F0052004D0041004C00
      49000100000000001C0000004F005200450043004F004D005000520045005300
      45004E005A004100010000000000120000005400490050004F00540055005200
      4E004F000100000000001C000000520041004700470052005500500050004100
      4D0045004E0054004F00010000000000140000004F00520045004E004F004E00
      43004100550053000100000000001400000054004F004C004C00450052004100
      4E005A00410001000000000010000000560050005F005400550052004E004F00
      0100000000000C000000560050005F004F00520045000100000000001A000000
      560050005F004D0041004700470049004F005200410054004500010000000000
      20000000560050005F004E004F004E004D0041004700470049004F0052004100
      54004500010000000000180000005400550052004E004F005F0049004E005400
      450052004F0001000000000018000000440045005400520041005A005F004D00
      45004E0053004100010000000000}
    Left = 112
    Top = 108
    object Q350RegReperibCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object Q350RegReperibDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object Q350RegReperibTIPOORE: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object Q350RegReperibORENORMALI: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
    end
    object Q350RegReperibORAINIZIO: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object Q350RegReperibORAFINE: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object Q350RegReperibORENONCAUS: TStringField
      FieldName = 'ORENONCAUS'
      Origin = 'T350_REGREPERIB.ORENONCAUS'
      Size = 1
    end
    object Q350RegReperibTOLLERANZA: TFloatField
      FieldName = 'TOLLERANZA'
      Origin = 'T350_REGREPERIB.TOLLERANZA'
    end
    object Q350RegReperibTIPOTURNO: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 1
    end
    object Q350RegReperibRAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.CODICE'
    end
    object Q350RegReperibORECOMPRESENZA: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
    end
    object Q350RegReperibVP_TURNO: TStringField
      FieldName = 'VP_TURNO'
      Required = True
      Size = 6
    end
    object Q350RegReperibVP_ORE: TStringField
      FieldName = 'VP_ORE'
      Required = True
      Size = 6
    end
    object Q350RegReperibVP_MAGGIORATE: TStringField
      FieldName = 'VP_MAGGIORATE'
      Required = True
      Size = 6
    end
    object Q350RegReperibVP_NONMAGGIORATE: TStringField
      FieldName = 'VP_NONMAGGIORATE'
      Required = True
      Size = 6
    end
    object Q350RegReperibVP_GETTONE_CHIAMATA: TStringField
      FieldName = 'VP_GETTONE_CHIAMATA'
      Size = 6
    end
    object Q350RegReperibVP_TURNI_OLTREMAX: TStringField
      FieldName = 'VP_TURNI_OLTREMAX'
      Size = 6
    end
    object Q350RegReperibTURNO_INTERO: TStringField
      FieldName = 'TURNO_INTERO'
      Size = 5
    end
    object Q350RegReperibDETRAZ_MENSA: TStringField
      FieldName = 'DETRAZ_MENSA'
      Size = 1
    end
    object Q350RegReperibORE_MIN_INDENNITA: TStringField
      FieldName = 'ORE_MIN_INDENNITA'
      Size = 5
    end
    object Q350RegReperibPIANIF_MAX_MESE: TIntegerField
      FieldName = 'PIANIF_MAX_MESE'
    end
    object Q350RegReperibPIANIF_MAX_MESE_TURNI_INTERI: TStringField
      FieldName = 'PIANIF_MAX_MESE_TURNI_INTERI'
      Size = 1
    end
  end
  object Q380Pianif: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,TURNO1,TURNO2,TURNO3 FROM'
      'T380_PIANIFREPERIB T380'
      'WHERE DATA BETWEEN :DATA1 AND :DATA2 AND'
      '      PROGRESSIVO =:PROGRESSIVO AND'
      '      TIPOLOGIA = '#39'R'#39
      'ORDER BY DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    Filtered = True
    OnFilterRecord = Q380PianifFilterRecord
    Left = 112
    Top = 152
  end
  object D010: TDataSource
    Left = 48
    Top = 56
  end
  object QCausaliAssenza: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,INFLUCONT,DETREPERIB,DETREPERIB_TOTALE'
      'FROM T265_CAUASSENZE')
    ReadBuffer = 100
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001400
      0000440045005400520045005000450052004900420001000000000022000000
      44004500540052004500500045005200490042005F0054004F00540041004C00
      4500010000000000}
    Left = 112
    Top = 56
    object QCausaliAssenzaCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T265_CAUASSENZE.CODICE'
      Size = 5
    end
    object QCausaliAssenzaDETREPERIB: TStringField
      FieldName = 'DETREPERIB'
      Origin = 'T265_CAUASSENZE.DETREPERIB'
      Size = 1
    end
    object QCausaliAssenzaDETREPERIB_TOTALE: TStringField
      FieldName = 'DETREPERIB_TOTALE'
      Size = 1
    end
    object QCausaliAssenzaINFLUCONT: TStringField
      FieldName = 'INFLUCONT'
      Size = 1
    end
  end
  object QMesePrecedente: TOracleDataSet
    SQL.Strings = (
      
        'SELECT VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGIORATE,VP_GETTONE' +
        '_CHIAMATA,VP_TURNI_OLTREMAX,TURNIORE '
      'FROM T340_TURNIREPERIB WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||LPAD(ANNO,4,'#39'0'#39'),'#39'DDMMYYYY'#39') = '
      
        '  (SELECT MAX(TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39')||LPAD(ANNO,4,'#39'0'#39'),'#39 +
        'DDMMYYYY'#39')) FROM T340_TURNIREPERIB WHERE '
      
        '    PROGRESSIVO = :PROGRESSIVO AND TO_DATE('#39'01'#39'||LPAD(MESE,2,'#39'0'#39 +
        ')||LPAD(ANNO,4,'#39'0'#39'),'#39'DDMMYYYY'#39') <= :DATA)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 212
    Top = 56
  end
  object QDelete: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T340_TURNIREPERIB '
      'WHERE PROGRESSIVO =:PROGRESSIVO AND'
      '               ANNO =:ANNO AND'
      '               MESE =:MESE AND'
      '               FLAGPAGHE <> '#39'2'#39)
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      000000000000000000000A0000003A004D004500530045000300000000000000
      00000000}
    Left = 284
    Top = 8
  end
  object QInsert: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T340_TURNIREPERIB '
      
        '(PROGRESSIVO,ANNO,MESE,VP_TURNO,VP_ORE,VP_MAGGIORATE,VP_NONMAGGI' +
        'ORATE,TURNIINTERI,TURNIORE,OREMAGG,ORENONMAGG,FLAGPAGHE,GETTONE_' +
        'CHIAMATA,VP_GETTONE_CHIAMATA,TURNI_OLTREMAX,VP_TURNI_OLTREMAX)'
      'VALUES'
      
        '(:PROGRESSIVO,:ANNO,:MESE,:VP_TURNO,:VP_ORE,:VP_MAGGIORATE,:VP_N' +
        'ONMAGGIORATE,:TURNIINTERI,:TURNIORE,:OREMAGG,:ORENONMAGG,:FLAGPA' +
        'GHE,:GETTONE_CHIAMATA,:VP_GETTONE_CHIAMATA,:TURNI_OLTREMAX,:VP_T' +
        'URNI_OLTREMAX)')
    Optimize = False
    Variables.Data = {
      0400000010000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      000000000000000000000A0000003A004D004500530045000300000000000000
      00000000180000003A005400550052004E00490049004E005400450052004900
      050000000000000000000000120000003A005400550052004E0049004F005200
      4500050000000000000000000000100000003A004F00520045004D0041004700
      4700050000000000000000000000160000003A004F00520045004E004F004E00
      4D00410047004700050000000000000000000000140000003A0046004C004100
      470050004100470048004500050000000000000000000000120000003A005600
      50005F005400550052004E004F000500000000000000000000000E0000003A00
      560050005F004F00520045000500000000000000000000001C0000003A005600
      50005F004D0041004700470049004F0052004100540045000500000000000000
      00000000220000003A00560050005F004E004F004E004D004100470047004900
      4F005200410054004500050000000000000000000000220000003A0047004500
      540054004F004E0045005F0043004800490041004D0041005400410003000000
      0000000000000000280000003A00560050005F0047004500540054004F004E00
      45005F0043004800490041004D00410054004100050000000000000000000000
      1E0000003A005400550052004E0049005F004F004C005400520045004D004100
      5800030000000000000000000000240000003A00560050005F00540055005200
      4E0049005F004F004C005400520045004D004100580005000000000000000000
      0000}
    Left = 284
    Top = 56
  end
  object Q110: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T110_ORALEGALESOLARE')
    Optimize = False
    Left = 20
    Top = 104
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 8
  end
end
