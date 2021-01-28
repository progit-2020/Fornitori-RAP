object R110FCreazioneFileMessaggi: TR110FCreazioneFileMessaggi
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 171
  Width = 270
  object QSQL: TOracleQuery
    Optimize = False
    Left = 24
    Top = 81
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select * from T361_OROLOGI'
      'order by POSTAZIONE, INDIRIZZO_TERMINALE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      0000460055004E005A0049004F004E0045000100000000001200000043004100
      550053004D0045004E00530041000100000000000A0000005600450052005300
      4F000100000000001400000050004F005300540041005A0049004F004E004500
      0100000000002600000049004E0044004900520049005A005A004F005F005400
      450052004D0049004E0041004C0045000100000000001800000049004E004400
      4900520049005A005A004F005F00490050000100000000002000000052004900
      430045005A0049004F004E0045005F004D004500530053004100470001000000
      0000}
    Filter = 
      '(RICEZIONE_MESSAG='#39'S'#39') AND (POSTAZIONE<>'#39#39') AND (INDIRIZZO_TERMI' +
      'NALE<>'#39#39')'
    Filtered = True
    Left = 24
    Top = 24
    object selT361CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 2
    end
    object selT361DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT361FUNZIONE: TStringField
      FieldName = 'FUNZIONE'
      Size = 1
    end
    object selT361CAUSMENSA: TStringField
      FieldName = 'CAUSMENSA'
      Size = 5
    end
    object selT361VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object selT361POSTAZIONE: TStringField
      FieldName = 'POSTAZIONE'
      Size = 5
    end
    object selT361INDIRIZZO_TERMINALE: TStringField
      FieldName = 'INDIRIZZO_TERMINALE'
      Size = 5
    end
    object selT361INDIRIZZO_IP: TStringField
      FieldName = 'INDIRIZZO_IP'
      Size = 15
    end
    object selT361RICEZIONE_MESSAG: TStringField
      FieldName = 'RICEZIONE_MESSAG'
      Required = True
      Size = 1
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE,'#39'I'#39' TABELLA FROM '
      'T265_CAUASSENZE T265,T260_RAGGRASSENZE T260,T263_PROFASSIND T263'
      'WHERE'
      '  T265.CODRAGGR = T260.CODICE AND'
      '  T260.CODINTERNO = '#39'A'#39' AND'
      '  T260.CODICE = T263.CODRAGGR AND'
      '  T263.ANNO = :ANNO AND'
      '  T263.PROGRESSIVO = :PROGRESSIVO AND'
      '  ROWNUM = 1'
      'UNION'
      'SELECT T265.CODICE,'#39'A'#39' FROM '
      'T265_CAUASSENZE T265,T260_RAGGRASSENZE T260,T262_PROFASSANN T262'
      'WHERE'
      '  T265.CODRAGGR = T260.CODICE AND'
      '  T260.CODINTERNO = '#39'A'#39' AND'
      '  T260.CODICE = T262.CODRAGGR AND'
      '  T262.ANNO = :ANNO AND'
      '  T262.CODPROFILO = :CODPROFILO AND'
      '  ROWNUM = 1')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000160000003A0043004F004400500052004F0046004900
      4C004F00050000000000000000000000}
    Left = 72
    Top = 24
  end
  object insT295: TOracleQuery
    SQL.Strings = (
      'declare'
      'begin'
      '  UPDATE T295_MESSAGGIINVIATI '
      
        '     SET PROGRESSIVO=:PROGRESSIVO, DATA_MSG=:DATA_MSG, ORA_MSG=:' +
        'ORA_MSG,'
      
        '         OPERATORE=:OPERATORE, TESTO_MSG=:TESTO_MSG, DATA_SCAD_M' +
        'SG=:DATA_SCAD_MSG '
      '   WHERE PROGRESSIVO=:PROGRESSIVO; '
      '  if SQL%ROWCOUNT = 0 THEN'
      '    INSERT INTO T295_MESSAGGIINVIATI '
      
        '    (PROGRESSIVO,DATA_MSG,ORA_MSG,OPERATORE,TESTO_MSG,DATA_SCAD_' +
        'MSG)'
      '    VALUES'
      
        '    (:PROGRESSIVO,:DATA_MSG,:ORA_MSG,:OPERATORE,:TESTO_MSG,:DATA' +
        '_SCAD_MSG);'
      '  end if;'
      'end;'
      ''
      '')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4D00530047000C0000000000000000000000140000003A005400450053005400
      4F005F004D0053004700050000000000000000000000100000003A004F005200
      41005F004D00530047000C0000000000000000000000140000003A004F005000
      45005200410054004F00520045000500000000000000000000001C0000003A00
      44004100540041005F0053004300410044005F004D00530047000C0000000000
      000000000000}
    Left = 71
    Top = 82
  end
  object delT295: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T295_MESSAGGIINVIATI WHERE PROGRESSIVO=:PROGRESSIVO'
      ''
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 127
    Top = 82
  end
  object selT295Prog: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROGRESSIVO FROM T295_MESSAGGIINVIATI'
      'WHERE DATA_SCAD_MSG >= :DATA')
    ReadBuffer = 3000
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 128
    Top = 24
  end
end
