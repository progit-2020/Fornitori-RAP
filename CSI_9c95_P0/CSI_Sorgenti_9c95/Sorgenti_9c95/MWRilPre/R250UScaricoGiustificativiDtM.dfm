inherited R250FScaricoGiustificativiDtM: TR250FScaricoGiustificativiDtM
  OldCreateOrder = True
  Height = 170
  Width = 369
  object selI150: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM MONDOEDP.I150_PARSCARICOGIUST'
      ' ORDER BY CODICE')
    Optimize = False
    Left = 20
    Top = 8
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA,ALIAS,UTENTE,PAROLACHIAVE,VERSIONEDB '
      '  FROM MONDOEDP.I090_ENTI '
      ' WHERE AZIENDA = :AZIENDA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 64
    Top = 8
  end
  object DbScarico: TOracleSession
    Preferences.UseOCI7 = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 88
    Top = 107
  end
  object FormattaData: TOracleQuery
    SQL.Strings = (
      'select to_date(:DATA,:FORMATO) from dual')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00440041005400410005000000000000000000
      0000100000003A0046004F0052004D00410054004F0005000000000000000000
      0000}
    Left = 25
    Top = 107
  end
  object SelT030: TOracleDataSet
    Optimize = False
    Left = 109
    Top = 9
  end
  object SelT040: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM'
      'T040_GIUSTIFICATIVI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000010000001000000043004F0055004E00540028002A00290001000000
      0000}
    Left = 150
    Top = 8
  end
  object SelT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE,CAUSALE_SUCCESSIVA FROM T265_CAUASSENZ' +
        'E')
    ReadBuffer = 100
    Optimize = False
    Left = 197
    Top = 8
  end
  object selI102: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWID, ORA, MODULO'
      'FROM MONDOEDP.I102_SCARICOPIANIFICATO'
      'WHERE MODULO = '#39'B015'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000060000004F00520041000100000000000C0000004D004F00
      440055004C004F00010000000000}
    OnNewRecord = selI102NewRecord
    Left = 296
    Top = 8
    object selI102ORA: TStringField
      FieldName = 'ORA'
      OnValidate = selI102ORAValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selI102MODULO: TStringField
      FieldName = 'MODULO'
      Visible = False
      Size = 4
    end
  end
  object dsrI102: TDataSource
    DataSet = selI102
    Left = 296
    Top = 56
  end
  object selGiustif: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from :tabella t'
      ':condizione')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410001000000
      0000000000000000160000003A0043004F004E00440049005A0049004F004E00
      4500010000000000000000000000}
    Left = 151
    Top = 109
  end
  object _selSG101: TOracleDataSet
    SQL.Strings = (
      'select * from SG101_FAMILIARI'
      'where PROGRESSIVO=:progressivo and NUMORD=:numord')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004E0055004D004F005200
      4400030000000000000000000000}
    Left = 24
    Top = 56
  end
  object delT040: TOracleQuery
    SQL.Strings = (
      'delete T040_GIUSTIFICATIVI'
      'where PROGRESSIVO=:progressivo '
      'and DATA between :datada and :dataa'
      'and CAUSALE in (:causale)'
      'and TIPOGIUST=:tipogiust '
      'and (DAORE=:daore or (DAORE is null and :daore is null)) '
      'and (AORE=:aore or (AORE is null and :aore is null)) ')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      00000000000000000000100000003A00430041005500530041004C0045000100
      00000000000000000000140000003A005400490050004F004700490055005300
      54000500000000000000000000000C0000003A00440041004F00520045000C00
      000000000000000000000A0000003A0041004F00520045000C00000000000000
      00000000}
    Left = 176
    Top = 56
  end
  object insT040: TOracleQuery
    SQL.Strings = (
      '/*'
      'INSERT INTO T040_GIUSTIFICATIVI '
      
        '(PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,AORE,DATA' +
        'NAS)'
      'VALUES'
      
        '(:PROGRESSIVO,:DATA,:CAUSALE,:PROGRCAUSALE,:TIPOGIUST,:DAORE,:AO' +
        'RE,:DATANAS)'
      '*/'
      
        '-- Nuova gestione: permette di inserire pi'#249' giustificativi in un' +
        'a stessa data'
      'declare'
      '  PROGC INTEGER;'
      'begin'
      '  PROGC:=:PROGRCAUSALE;'
      '  begin'
      '    INSERT INTO T040_GIUSTIFICATIVI '
      
        '      (PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,AOR' +
        'E,DATANAS)'
      '    VALUES'
      
        '      (:PROGRESSIVO,:DATA,:CAUSALE,PROGC,:TIPOGIUST,:DAORE,:AORE' +
        ',:DATANAS);'
      '  exception    '
      '    when DUP_VAL_ON_INDEX then'
      '      PROGC:=PROGC + 1;'
      '      INSERT INTO T040_GIUSTIFICATIVI '
      
        '        (PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,A' +
        'ORE,DATANAS)'
      '      VALUES'
      
        '        (:PROGRESSIVO,:DATA,:CAUSALE,PROGC,:TIPOGIUST,:DAORE,:AO' +
        'RE,:DATANAS);'
      '    when others then '
      '      raise;    '
      '  end;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000001A0000003A00500052004F0047005200430041005500
      530041004C004500030000000000000000000000140000003A00540049005000
      4F00470049005500530054000500000000000000000000000C0000003A004400
      41004F00520045000C00000000000000000000000A0000003A0041004F005200
      45000C0000000000000000000000100000003A0044004100540041004E004100
      53000C0000000000000000000000}
    Left = 96
    Top = 56
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE')
    ReadBuffer = 100
    Optimize = False
    Left = 245
    Top = 8
  end
end
