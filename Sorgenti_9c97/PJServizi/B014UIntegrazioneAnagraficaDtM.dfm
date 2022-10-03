object B014FIntegrazioneAnagraficaDtM: TB014FIntegrazioneAnagraficaDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 386
  Width = 646
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 4
    Top = 4
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      
        'SELECT AZIENDA,UTENTE,PAROLACHIAVE,TSLAVORO,CODICE_INTEGRAZIONE,' +
        'VERSIONEDB FROM MONDOEDP.I090_ENTI '
      'WHERE CODICE_INTEGRAZIONE IS NOT NULL '
      'OR 1 = (SELECT COUNT(*) FROM I090_ENTI)'
      'ORDER BY AZIENDA')
    Optimize = False
    Left = 390
    Top = 48
  end
  object selIA110: TOracleDataSet
    SQL.Strings = (
      'SELECT IA110.*,C.DATA_LENGTH FROM '
      '  MONDOEDP.IA110_DETTAGLIODATI IA110, COLS C'
      'WHERE '
      '  NOME_STRUTTURA = :NOME_STRUTTURA AND '
      '  AZIENDA IN (:AZIENDA,'#39'*'#39') AND'
      '  TABELLA = C.TABLE_NAME(+) AND'
      '  CAMPO = C.COLUMN_NAME(+) AND'
      '  (INTESTAZIONE IS NOT NULL OR CAMPO IS NOT NULL)'
      
        'ORDER BY decode(STORICO,'#39'N'#39',0,1) + decode(VIRTUALE,'#39'N'#39',0,2),POS_' +
        'DATO,NOME_DATO')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000020000001E0000003A004E004F004D0045005F005300540052005500
      54005400550052004100050000000000000000000000100000003A0041005A00
      490045004E0044004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000F0000001C0000004E004F004D0045005F0053005400520055005400
      54005500520041000100000000000E00000041005A00490045004E0044004100
      0100000000001800000049004E00540045005300540041005A0049004F004E00
      45000100000000000E00000054004100420045004C004C004100010000000000
      0A000000430041004D0050004F000100000000001000000050004F0053005F00
      4400410054004F00010000000000120000004C0055004E0047005F0044004100
      54004F00010000000000120000004E004F004D0045005F004400410054004F00
      010000000000120000005400490050004F005F004400410054004F0001000000
      00001000000046004D0054005F0044004100540041000100000000000E000000
      530054004F005200490043004F00010000000000100000005600490052005400
      550041004C00450001000000000012000000500052004F005000520049004500
      540041000100000000001800000054004100420045004C004C0041005F004400
      4500530043000100000000001600000044004100540041005F004C0045004E00
      470054004800010000000000}
    Left = 390
    Top = 92
  end
  object selIA100: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM MONDOEDP.IA100_STRUTTUREDATI '
      'WHERE NOME_STRUTTURA IN (:STRUTTURE)'
      'ORDER BY NOME_STRUTTURA'
      'FOR UPDATE NOWAIT')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A00530054005200550054005400550052004500
      010000000000000000000000}
    Session = SessioneLock
    Left = 297
    Top = 48
  end
  object selDatiInput: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    QueryAllRecords = False
    CountAllRecords = True
    Left = 390
    Top = 180
  end
  object insT030: TOracleQuery
    SQL.Strings = (
      'declare'
      '  m varchar2(8);'
      '  dISTANTE date;'
      'begin'
      '  :stato:='#39'M'#39';'
      
        '  select progressivo into :progressivo from t030_anagrafico wher' +
        'e matricola = :matricola;'
      'exception'
      '  when no_data_found then'
      '    :stato:='#39'I'#39';'
      '    select progressivo into :progressivo from t035_progressivo;'
      '    :progressivo:=:progressivo + 1;'
      ''
      '    begin'
      '      select min(SYSDATE) into dISTANTE from DUAL;'
      
        '      insert into T030_NOTRIGGER (PROGRESSIVO,ISTANTE) values (:' +
        'PROGRESSIVO,dISTANTE);'
      '    exception'
      '      when others then null;'
      '    end;'
      ''
      '    begin'
      
        '      insert into t030_anagrafico (progressivo,matricola) values' +
        ' (:progressivo,:matricola);'
      
        '      insert into t430_storico (progressivo,datadecorrenza,dataf' +
        'ine) values (:progressivo,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'),to_date' +
        '('#39'31123999'#39','#39'ddmmyyyy'#39'));'
      '    exception'
      '      when others then null;'
      '    end;'
      '    '
      '    begin'
      
        '      delete from T030_NOTRIGGER where PROGRESSIVO = :PROGRESSIV' +
        'O and ISTANTE = dISTANTE;'
      '    exception'
      '      when others then null;'
      '    end;'
      ''
      '    update t035_progressivo set progressivo = :progressivo;'
      '    commit;'
      'end;')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000C0000003A00530054004100
      54004F00050000000000000000000000}
    Left = 112
    Top = 48
  end
  object SessioneAzienda: TOracleSession
    Preferences.UseOCI7 = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 112
    Top = 4
  end
  object scrCreazioneStorico: TOracleQuery
    SQL.Strings = (
      'begin'
      '  creazione_storico(:progressivo,:dal,:al);'
      '  commit;'
      'end;')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F00030000000000000000000000}
    Left = 112
    Top = 92
  end
  object scrAllineaPeriodiStorici: TOracleQuery
    SQL.Strings = (
      'begin'
      '  allinea_periodi_storici(:progressivo,1,:Errore,'#39#39');'
      '  commit;'
      'end;')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000}
    Left = 112
    Top = 136
  end
  object scrAggiornamento: TOracleQuery
    Session = SessioneAzienda
    Optimize = False
    Left = 112
    Top = 180
  end
  object insIA000: TOracleQuery
    SQL.Strings = (
      'INSERT /*+ APPEND */ INTO IA000_LOGINTEGRAZIONE'
      
        '  (data_elaborazione, struttura, azienda, ente, data_registrazio' +
        'ne, '
      
        '   id, utente, chiave, decorrenza, scadenza, stato, dato, valore' +
        ', messaggio, testo_sql)'
      'VALUES'
      
        '  (:data_elaborazione, :struttura, :azienda, :ente, :data_regist' +
        'razione, '
      
        '   :id, substr(:utente,1,50), :chiave, :decorrenza, :scadenza, :' +
        'stato, :dato, :valore, :messaggio, :testo_sql)'
      '')
    Optimize = False
    Variables.Data = {
      040000000F0000000C0000003A0053005400410054004F000500000000000000
      000000000A0000003A004400410054004F000500000000000000000000000E00
      00003A00560041004C004F005200450005000000000000000000000014000000
      3A004D0045005300530041004700470049004F00050000000000000000000000
      140000003A0054004500530054004F005F00530051004C000500000000000000
      00000000140000003A0053005400520055005400540055005200410005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A0045004E005400450005000000000000000000
      0000060000003A00490044000300000000000000000000000E0000003A005500
      540045004E00540045000500000000000000000000000E0000003A0043004800
      4900410056004500050000000000000000000000160000003A00440045004300
      4F005200520045004E005A0041000C0000000000000000000000120000003A00
      530043004100440045004E005A0041000C000000000000000000000024000000
      3A0044004100540041005F0045004C00410042004F00520041005A0049004F00
      4E0045000C0000000000000000000000260000003A0044004100540041005F00
      520045004700490053005400520041005A0049004F004E0045000C0000000000
      000000000000}
    Left = 390
    Top = 268
  end
  object delDatiInput: TOracleQuery
    SQL.Strings = (
      'DELETE FROM :TABELLA WHERE ROWID = :MYROWID'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410001000000
      0000000000000000100000003A004D00590052004F0057004900440005000000
      0000000000000000}
    Left = 390
    Top = 224
  end
  object selIA190: TOracleDataSet
    SQL.Strings = (
      
        'SELECT * FROM IA190_SCHEDULAZIONE WHERE OREMINUTI(ORA) = :ORA AN' +
        'D ORA IS NOT NULL')
    ReadBuffer = 300
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004F0052004100030000000000000000000000}
    Left = 390
    Top = 136
  end
  object scrB014Personalizzata: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  Select_Aperte.B014Personalizzata(:p,:dal,:dato,:valore,:strutt' +
        'ura,:sequenza,:rowid_riga);'
      'end;')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000007000000080000003A00440041004C000C0000000000000000000000
      140000003A005300540052005500540054005500520041000500000000000000
      00000000160000003A0052004F005700490044005F0052004900470041000500
      00000000000000000000040000003A0050000300000000000000000000000A00
      00003A004400410054004F00050000000000000000000000120000003A005300
      45005100550045004E005A0041000500000000000000000000000E0000003A00
      560041004C004F0052004500050000000000000000000000}
    Left = 112
    Top = 224
  end
  object insDatiInput: TOracleQuery
    Optimize = False
    Left = 470
    Top = 92
  end
  object crtDatiInput: TOracleQuery
    Optimize = False
    Left = 470
    Top = 48
  end
  object selIA110NomeDato: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT INTESTAZIONE,NOME_DATO,POS_DATO,LUNG_DATO FROM '
      '  MONDOEDP.IA110_DETTAGLIODATI'
      'WHERE '
      '  NOME_STRUTTURA = :NOME_STRUTTURA AND'
      '  ((NVL(POS_DATO,0) > 0 AND NVL(LUNG_DATO,0) > 0) OR'
      '    INTESTAZIONE = '#39'SEQUENZA'#39')')
    ReadBuffer = 30
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A004E004F004D0045005F005300540052005500
      54005400550052004100050000000000000000000000}
    Left = 470
    Top = 136
  end
  object SessioneLock: TOracleSession
    Preferences.UseOCI7 = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 297
    Top = 4
  end
  object IdFTP: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 48
    Top = 4
  end
  object selIA120: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM IA120_DATIOUTPUT T'
      'WHERE '
      '  AZIENDA = :AZIENDA AND '
      
        '  TABELLA IN (SELECT DISTINCT TABELLA FROM IA110_DETTAGLIODATI W' +
        'HERE NOME_STRUTTURA = :NOME_STRUTTURA)'
      'ORDER BY ID,DATA_REGISTRAZIONE')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000001E0000003A004E004F004D0045005F005300540052005500
      54005400550052004100050000000000000000000000}
    Left = 558
    Top = 48
  end
  object selDatiOutput: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM :TABELLA WHERE :JOIN :CAMPO = :VALORE')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0054004100420045004C004C00410001000000
      00000000000000000C0000003A00430041004D0050004F000100000000000000
      000000000E0000003A00560041004C004F005200450005000000000000000000
      00000A0000003A004A004F0049004E00010000000000000000000000}
    Left = 558
    Top = 96
  end
  object insDatiOutput: TOracleQuery
    Optimize = False
    Left = 558
    Top = 144
  end
  object ScriptBeforeAfter: TOracleScript
    Session = SessioneAzienda
    OutputOptions = []
    Left = 111
    Top = 272
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA_LENGTH FROM COLS'
      'WHERE TABLE_NAME = :TABELLA AND COLUMN_NAME = :COLONNA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410005000000
      0000000000000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000}
    Session = SessioneAzienda
    Left = 110
    Top = 316
  end
  object delI030: TOracleQuery
    SQL.Strings = (
      'DELETE I030_RELAZIONI_ANAGRAFE'
      'WHERE  TABELLA = '#39'T430_STORICO'#39
      'AND    TAB_ORIGINE = '#39'T430_STORICO'#39
      'AND    COLONNA = :COLONNA')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000}
    Left = 213
    Top = 48
  end
  object selIA140: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   :TABELLA'
      'order by ORDINE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410001000000
      0000000000000000}
    Left = 390
    Top = 320
  end
  object selStruttura: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM   :STRUTTURA'
      'WHERE  :DECORRENZA BETWEEN DECORRENZA AND SCADENZA'
      'ORDER BY PILOTA')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A00530054005200550054005400550052004100
      010000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000}
    Session = SessioneAzienda
    Left = 213
    Top = 180
  end
  object selDecStruttura: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DECORRENZA'
      'FROM   :STRUTTURA'
      'ORDER BY DECORRENZA'
      ''
      '/* PROVA 11072008'
      'SELECT A.PILOTA, A.PILOTATO, MIN(A.DECORRENZA) DECORRENZA'
      'FROM (SELECT DISTINCT C.PILOTA, C.PILOTATO'
      '      FROM  :STRUTTURA C,'
      '           (SELECT E.PILOTA, COUNT(DISTINCT(E.DECORRENZA))'
      '            FROM :STRUTTURA E'
      '            GROUP BY E.PILOTA'
      '            HAVING COUNT(DISTINCT(E.DECORRENZA)) > 1) D '
      '      WHERE D.PILOTA = C.PILOTA) B,'
      '      :STRUTTURA A'
      'WHERE B.PILOTA = A.PILOTA'
      'AND B.PILOTATO = A.PILOTATO'
      'GROUP BY A.PILOTA, A.PILOTATO'
      'ORDER BY MIN(A.DECORRENZA)*/')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A00530054005200550054005400550052004100
      010000000000000000000000}
    Session = SessioneAzienda
    Left = 213
    Top = 136
  end
  object selCntDec: TOracleDataSet
    SQL.Strings = (
      'SELECT PILOTA, COUNT(DISTINCT(DECORRENZA))'
      'FROM  :STRUTTURA'
      'GROUP BY PILOTA'
      'HAVING COUNT(DISTINCT(DECORRENZA)) > 1')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A00530054005200550054005400550052004100
      010000000000000000000000}
    Session = SessioneAzienda
    Left = 213
    Top = 92
  end
  object insT030NoTrigger: TOracleQuery
    SQL.Strings = (
      
        'insert /*+ append */ into T030_NOTRIGGER (PROGRESSIVO,ISTANTE) v' +
        'alues (:PROGRESSIVO,:dISTANTE)'
      '')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004900530054004100
      4E00540045000C0000000000000000000000}
    Left = 216
    Top = 228
  end
  object delT030NoTrigger: TOracleQuery
    SQL.Strings = (
      
        'delete from T030_NOTRIGGER where PROGRESSIVO = :PROGRESSIVO and ' +
        'ISTANTE = :dISTANTE'
      '')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004900530054004100
      4E00540045000C0000000000000000000000}
    Left = 216
    Top = 276
  end
  object selTabStorica: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,rowid'
      'FROM   :TABELLA T'
      'WHERE  :CHIAVE'
      'ORDER BY :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      4100010000000000000000000000100000003A0054004100420045004C004C00
      41000100000000000000000000000E0000003A00430048004900410056004500
      010000000000000000000000}
    Session = SessioneAzienda
    Left = 215
    Top = 324
  end
end
