object B014FMonitorIntegrazioneDtM: TB014FMonitorIntegrazioneDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 282
  Width = 552
  object selIA000: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM IA000_LOGINTEGRAZIONE T'
      ':FILTRO')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000F0000002200000044004100540041005F0045004C00410042004F00
      520041005A0049004F004E004500010000000000120000005300540052005500
      540054005500520041000100000000000E00000041005A00490045004E004400
      41000100000000000800000045004E0054004500010000000000240000004400
      4100540041005F00520045004700490053005400520041005A0049004F004E00
      450001000000000004000000490044000100000000000C000000550054004500
      4E00540045000100000000000C00000043004800490041005600450001000000
      0000140000004400450043004F005200520045004E005A004100010000000000
      10000000530043004100440045004E005A0041000100000000000A0000005300
      5400410054004F00010000000000080000004400410054004F00010000000000
      0C000000560041004C004F0052004500010000000000120000004D0045005300
      530041004700470049004F000100000000001200000054004500530054004F00
      5F00530051004C00010000000000}
    QueryAllRecords = False
    CountAllRecords = True
    AfterOpen = selIA000AfterOpen
    BeforeInsert = selIA000BeforeInsert
    BeforePost = selIA000BeforePost
    BeforeDelete = selIA000BeforeDelete
    AfterScroll = selIA000AfterScroll
    Left = 32
    Top = 12
  end
  object dsrIA000: TDataSource
    AutoEdit = False
    DataSet = selIA000
    Left = 32
    Top = 56
  end
  object selIA190: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM IA190_SCHEDULAZIONE T ORDER BY ORA')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000060000004F00520041000100000000001200000053005400
      5200550054005400550052004500010000000000}
    Left = 88
    Top = 12
    object selIA190ORA: TStringField
      DisplayWidth = 7
      FieldName = 'ORA'
      OnValidate = selIA190ORAValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selIA190STRUTTURE: TStringField
      DisplayWidth = 80
      FieldName = 'STRUTTURE'
      Size = 2000
    end
  end
  object dsrIA190: TDataSource
    DataSet = selIA190
    Left = 88
    Top = 56
  end
  object selIA100Nome: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NOME_STRUTTURA FROM IA100_STRUTTUREDATI ORDER BY NOME_STR' +
        'UTTURA')
    Optimize = False
    Left = 148
    Top = 12
  end
  object selIA100: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM IA100_STRUTTUREDATI T'
      'ORDER BY NOME_STRUTTURA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001C0000004E004F004D0045005F0053005400520055005400
      54005500520041000100000000001C0000005400490050004F005F0053005400
      5200550054005400550052004100010000000000120000004E004F004D004500
      5F00460049004C004500010000000000100000004600540050005F0048004F00
      53005400010000000000100000004600540050005F0055005300450052000100
      00000000180000004600540050005F00500041005300530057004F0052004400
      010000000000100000004600540050005F0050004F0052005400010000000000
      140000004C004F0047005F004500520052004F00520045000100000000001800
      00004C004F0047005F0045005300450047005500490054004F00010000000000
      14000000520045005300450054005F0044004100540049000100000000001A00
      0000430041004E00430045004C004C0041005A0049004F004E00450001000000
      000024000000420030003100340050004500520053004F004E0041004C004900
      5A005A004100540041000100000000001C00000044004900520045005A004900
      4F004E0045005F0044004100540049000100000000001A000000530043005200
      4900500054005F004200450046004F0052004500010000000000180000005300
      430052004900500054005F004100460054004500520001000000000018000000
      4C004F0047005F004D004F00440049004600490043004100010000000000}
    AfterOpen = selIA100AfterOpen
    AfterPost = selIA100AfterPost
    BeforeDelete = selIA100BeforeDelete
    AfterScroll = selIA100AfterScroll
    Left = 212
    Top = 12
    object selIA100NOME_STRUTTURA: TStringField
      DisplayLabel = 'Nome struttura'
      DisplayWidth = 20
      FieldName = 'NOME_STRUTTURA'
      Required = True
      Size = 200
    end
    object selIA100TIPO_STRUTTURA: TStringField
      DisplayLabel = 'Tipo struttura'
      FieldName = 'TIPO_STRUTTURA'
      Size = 1
    end
    object selIA100NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 20
      FieldName = 'NOME_FILE'
      Size = 200
    end
    object selIA100FTP_HOST: TStringField
      DisplayLabel = 'FTP Host'
      DisplayWidth = 15
      FieldName = 'FTP_HOST'
    end
    object selIA100FTP_USER: TStringField
      DisplayLabel = 'FTP User'
      DisplayWidth = 15
      FieldName = 'FTP_USER'
    end
    object selIA100FTP_PASSWORD: TStringField
      DisplayLabel = 'FTP Password'
      DisplayWidth = 15
      FieldName = 'FTP_PASSWORD'
    end
    object selIA100FTP_PORT: TIntegerField
      DisplayLabel = 'FTP Port'
      FieldName = 'FTP_PORT'
    end
    object selIA100LOG_ERRORE: TStringField
      DisplayLabel = 'LOG Errore'
      FieldName = 'LOG_ERRORE'
      Size = 1
    end
    object selIA100LOG_ESEGUITO: TStringField
      DisplayLabel = 'LOG Eseguito'
      FieldName = 'LOG_ESEGUITO'
      Size = 1
    end
    object selIA100RESET_DATI: TStringField
      DisplayLabel = 'Reset Dati'
      FieldName = 'RESET_DATI'
      Visible = False
      Size = 1
    end
    object selIA100CANCELLAZIONE: TStringField
      DisplayLabel = 'Cancellazione'
      FieldName = 'CANCELLAZIONE'
      Size = 1
    end
    object selIA100B014PERSONALIZZATA: TStringField
      DisplayLabel = 'B014Personalizzata'
      FieldName = 'B014PERSONALIZZATA'
      Size = 1
    end
    object selIA100DIREZIONE_DATI: TStringField
      DisplayLabel = 'Direzione dati'
      FieldName = 'DIREZIONE_DATI'
      Size = 1
    end
    object selIA100SCRIPT_BEFORE: TStringField
      DisplayLabel = 'Script Before'
      DisplayWidth = 20
      FieldName = 'SCRIPT_BEFORE'
      Size = 500
    end
    object selIA100SCRIPT_AFTER: TStringField
      DisplayLabel = 'Script After'
      DisplayWidth = 20
      FieldName = 'SCRIPT_AFTER'
      Size = 500
    end
    object selIA100LOG_MODIFICA: TStringField
      FieldName = 'LOG_MODIFICA'
      Size = 1
    end
  end
  object selIA110: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*, ROWID FROM IA110_DETTAGLIODATI T'
      'WHERE NOME_STRUTTURA = :NOME_STRUTTURA'
      'ORDER BY INTESTAZIONE,POS_DATO,TABELLA,CAMPO')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A004E004F004D0045005F005300540052005500
      54005400550052004100050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E0000001C0000004E004F004D0045005F0053005400520055005400
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
      450053004300010000000000}
    AfterOpen = selIA100AfterOpen
    BeforeInsert = selIA110BeforeInsert
    OnNewRecord = selIA110NewRecord
    Left = 264
    Top = 12
    object selIA110NOME_STRUTTURA: TStringField
      FieldName = 'NOME_STRUTTURA'
      Size = 200
    end
    object selIA110AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selIA110INTESTAZIONE: TStringField
      FieldName = 'INTESTAZIONE'
      Size = 40
    end
    object selIA110TABELLA: TStringField
      FieldName = 'TABELLA'
      Size = 80
    end
    object selIA110CAMPO: TStringField
      FieldName = 'CAMPO'
      Size = 80
    end
    object selIA110POS_DATO: TIntegerField
      FieldName = 'POS_DATO'
    end
    object selIA110LUNG_DATO: TIntegerField
      FieldName = 'LUNG_DATO'
    end
    object selIA110NOME_DATO: TStringField
      FieldName = 'NOME_DATO'
      Required = True
      Size = 40
    end
    object selIA110VIRTUALE: TStringField
      FieldName = 'VIRTUALE'
      Size = 1
    end
    object selIA110TIPO_DATO: TStringField
      FieldName = 'TIPO_DATO'
      Size = 1
    end
    object selIA110FMT_DATA: TStringField
      FieldName = 'FMT_DATA'
    end
    object selIA110STORICO: TStringField
      FieldName = 'STORICO'
      Size = 1
    end
    object selIA110PROPRIETA: TStringField
      FieldName = 'PROPRIETA'
      Size = 500
    end
    object selIA110TABELLA_DESC: TStringField
      FieldName = 'TABELLA_DESC'
      Size = 80
    end
  end
  object dsrIA100: TDataSource
    DataSet = selIA100
    Left = 212
    Top = 56
  end
  object dsrIA110: TDataSource
    DataSet = selIA110
    Left = 264
    Top = 56
  end
  object selIADati: TOracleDataSet
    ReadBuffer = 500
    Optimize = False
    QueryAllRecords = False
    CountAllRecords = True
    Left = 320
    Top = 12
  end
  object dsrIADati: TDataSource
    AutoEdit = False
    DataSet = selIADati
    Left = 320
    Top = 56
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      
        'SELECT AZIENDA,UTENTE,PAROLACHIAVE FROM I090_ENTI ORDER BY AZIEN' +
        'DA')
    Optimize = False
    Left = 380
    Top = 12
  end
  object delIA000: TOracleQuery
    SQL.Strings = (
      'DELETE FROM IA000_LOGINTEGRAZIONE'
      ':FILTRO')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 32
    Top = 104
  end
  object SessioneAzienda: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 32
    Top = 160
  end
  object dsrIA130: TDataSource
    AutoEdit = False
    DataSet = selIA130
    OnStateChange = dsrIA130StateChange
    Left = 436
    Top = 56
  end
  object selIA130: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM IA130_TRIGGEROUTPUT T')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000E00000041005A00490045004E0044004100010000000000
      0E00000054004100420045004C004C0041000100000000001800000054005200
      490047004700450052005F005400450058005400010000000000}
    BeforeDelete = selIA130BeforeDelete
    Left = 436
    Top = 12
    object selIA130AZIENDA: TStringField
      DisplayWidth = 20
      FieldName = 'AZIENDA'
      Required = True
      Size = 40
    end
    object selIA130TABELLA: TStringField
      DisplayWidth = 30
      FieldName = 'TABELLA'
      Required = True
      Size = 80
    end
    object selIA130TRIGGER_TEXT: TStringField
      FieldName = 'TRIGGER_TEXT'
      Size = 4000
    end
  end
  object scrTrigger: TOracleScript
    Session = SessioneAzienda
    OutputOptions = [ooNonSQL, ooFeedback, ooError]
    OnError = scrTriggerError
    Left = 104
    Top = 160
  end
  object selUserErrors: TOracleDataSet
    SQL.Strings = (
      'SELECT LINE,POSITION,TEXT FROM USER_ERRORS WHERE NAME = :NAME')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E0041004D00450005000000000000000000
      0000}
    Session = SessioneAzienda
    Left = 168
    Top = 160
  end
  object dsrI090: TDataSource
    DataSet = selI090
    Left = 380
    Top = 56
  end
  object insIA120: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.IA120_DATIOUTPUT'
      
        '  (AZIENDA,TABELLA,ID_DATO,DATA_REGISTRAZIONE,ID,OS_USER,MACHINE' +
        '_USER,USERNAME)'
      '  SELECT '
      
        '    NVL(I090.CODICE_INTEGRAZIONE,'#39'*'#39'),'#39'T430_STORICO'#39',:PROGRESSIV' +
        'O,SYSDATE,'
      '    MONDOEDP.IA120_ID.NEXTVAL,V.OSUSER,V.MACHINE,V.USERNAME'
      '  FROM V$SESSION V, MONDOEDP.I090_ENTI I090 WHERE'
      
        '    V.SID = (SELECT MAX(SID) FROM V$MYSTAT) AND V.USERNAME = I09' +
        '0.UTENTE(+) AND ROWNUM = 1 AND'
      
        '    NOT EXISTS(SELECT '#39'X'#39' FROM MONDOEDP.IA120_DATIOUTPUT WHERE T' +
        'ABELLA = '#39'T430_STORICO'#39
      
        '               AND ID_DATO = :PROGRESSIVO AND AZIENDA = I090.COD' +
        'ICE_INTEGRAZIONE)')
    Session = SessioneAzienda
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 232
    Top = 160
  end
  object selSourceB014Personalizzata: TOracleDataSet
    SQL.Strings = (
      
        'SELECT TEXT FROM USER_SOURCE WHERE TYPE = '#39'PACKAGE BODY'#39' AND NAM' +
        'E = '#39'SELECT_APERTE'#39' ORDER BY LINE')
    Optimize = False
    Session = SessioneAzienda
    Left = 328
    Top = 160
  end
  object scrGenerico: TOracleQuery
    Optimize = False
    Left = 493
    Top = 12
  end
end
