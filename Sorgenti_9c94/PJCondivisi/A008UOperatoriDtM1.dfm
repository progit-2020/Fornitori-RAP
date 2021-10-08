object A008FOperatoriDtM1: TA008FOperatoriDtM1
  OldCreateOrder = True
  OnCreate = A008FOperatoriDtM1Create
  OnDestroy = A008FOperatoriDtM1Destroy
  Height = 497
  Width = 884
  object D090: TDataSource
    AutoEdit = False
    DataSet = QI090
    Left = 48
    Top = 12
  end
  object D091: TDataSource
    DataSet = QI091
    Left = 124
    Top = 12
  end
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.*,I090.ROWID '
      '  FROM MONDOEDP.I090_ENTI I090'
      ' ORDER BY AZIENDA')
    ReadBuffer = 5
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000170000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C00490041005300010000000000160000004400450053004300
      520049005A0049004F004E0045000100000000001200000049004E0044004900
      520049005A005A004F000100000000001A0000005400490050004F0043004F00
      4E00540045004700470049004F0001000000000020000000530054004F005200
      4900410049004E00540045005200560045004E0054004F000100000000002000
      000041005A005A004500520041004D0045004E0054004F00530041004C004400
      4F00010000000000160000004500430043004600410053004300450053005400
      52000100000000000C0000005500540045004E00540045000100000000001800
      00005000410052004F004C004100430048004900410056004500010000000000
      10000000540053004C00410056004F0052004F00010000000000100000005400
      530049004E0044004900430049000100000000001A0000004600520041005A00
      49004F004E0041004E004F005400540045000100000000001C00000054004900
      4D0042004F005200490047005F0056004500520053004F000100000000002000
      0000540049004D0042004F005200490047005F00430041005500530041004C00
      45000100000000001E00000052004100470049004F004E0045005F0053004F00
      4300490041004C00450001000000000014000000560045005200530049004F00
      4E004500440042000100000000002600000043004F0044004900430045005F00
      49004E00540045004700520041005A0049004F004E0045000100000000001A00
      00004C0055004E0047005F00500041005300530057004F005200440001000000
      00001C000000560041004C00490044005F00500041005300530057004F005200
      440001000000000018000000560041004C00490044005F005500540045004E00
      540045000100000000000E000000500041005400430048004400420001000000
      0000180000005400530041005500530049004C0049004100520049004F000100
      00000000}
    CachedUpdates = True
    AfterEdit = QI090AfterEdit
    BeforePost = QI090BeforePost
    AfterPost = QI090AfterPost
    AfterCancel = QI070AfterCancel
    BeforeDelete = QI090BeforeDelete
    AfterDelete = QI090AfterDelete
    AfterScroll = QI090AfterScroll
    OnNewRecord = QI090NewRecord
    Left = 20
    Top = 12
    object QI090AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object QI090DESCRIZIONE: TStringField
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 150
    end
    object QI090INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object QI090STORIAINTERVENTO: TStringField
      FieldName = 'STORIAINTERVENTO'
      Size = 1
    end
    object QI090UTENTE: TStringField
      FieldName = 'UTENTE'
    end
    object QI090PAROLACHIAVE: TStringField
      FieldName = 'PAROLACHIAVE'
      OnGetText = BDEQI090PAROLACHIAVEGetText
      OnSetText = BDEQI090PAROLACHIAVESetText
    end
    object QI090TSLAVORO: TStringField
      FieldName = 'TSLAVORO'
      Origin = 'I090_ENTI.TSLAVORO'
    end
    object QI090TSINDICI: TStringField
      FieldName = 'TSINDICI'
      Origin = 'I090_ENTI.TSINDICI'
    end
    object QI090TSAUSILIARIO: TStringField
      FieldName = 'TSAUSILIARIO'
    end
    object QI090TIMBORIG_VERSO: TStringField
      FieldName = 'TIMBORIG_VERSO'
      Visible = False
      Size = 1
    end
    object QI090TIMBORIG_CAUSALE: TStringField
      FieldName = 'TIMBORIG_CAUSALE'
      Visible = False
      Size = 1
    end
    object QI090CODICE_INTEGRAZIONE: TStringField
      FieldName = 'CODICE_INTEGRAZIONE'
      Size = 30
    end
    object QI090LUNG_PASSWORD: TIntegerField
      FieldName = 'LUNG_PASSWORD'
      MaxValue = 99
    end
    object QI090VALID_PASSWORD: TIntegerField
      FieldName = 'VALID_PASSWORD'
      MaxValue = 999
    end
    object QI090VALID_UTENTE: TIntegerField
      FieldName = 'VALID_UTENTE'
      MaxValue = 999
    end
    object QI090PATHALLCLIENT: TStringField
      FieldName = 'PATHALLCLIENT'
      Size = 200
    end
    object QI090DOMINIO_USR: TStringField
      FieldName = 'DOMINIO_USR'
      Size = 80
    end
    object QI090DOMINIO_DIP: TStringField
      FieldName = 'DOMINIO_DIP'
      Size = 80
    end
    object QI090DOMINIO_DIP_TIPO: TStringField
      FieldName = 'DOMINIO_DIP_TIPO'
      OnChange = QI090DOMINIO_DIP_TIPOChange
      Size = 5
    end
    object QI090DOMINIO_USR_TIPO: TStringField
      FieldName = 'DOMINIO_USR_TIPO'
      OnChange = QI090DOMINIO_DIP_TIPOChange
      Size = 5
    end
    object QI090PASSWORD_CIFRE: TIntegerField
      FieldName = 'PASSWORD_CIFRE'
    end
    object QI090PASSWORD_MAIUSCOLE: TIntegerField
      FieldName = 'PASSWORD_MAIUSCOLE'
    end
    object QI090PASSWORD_CARSPECIALI: TIntegerField
      FieldName = 'PASSWORD_CARSPECIALI'
    end
    object QI090AGGIORNAMENTO_ABILITATO: TStringField
      FieldName = 'AGGIORNAMENTO_ABILITATO'
      Size = 1
    end
    object QI090GRUPPO_BADGE: TStringField
      FieldName = 'GRUPPO_BADGE'
      Size = 1
    end
    object QI090LOGIN_USR_ABILITATO: TStringField
      FieldName = 'LOGIN_USR_ABILITATO'
      Size = 1
    end
    object QI090LOGIN_DIP_ABILITATO: TStringField
      FieldName = 'LOGIN_DIP_ABILITATO'
      Size = 1
    end
  end
  object QI091: TOracleDataSet
    SQL.Strings = (
      'select I091.*, I091.ROWID '
      '  from MONDOEDP.I091_DATIENTE I091 '
      ' where I091.AZIENDA = :AZIENDA'
      ' order by instr(I091.TIPO,'#39'_'#39'), ORDINE, TIPO')
    ReadBuffer = 250
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeInsert = QI091BeforeDelete
    BeforePost = QI091BeforePost
    AfterPost = QI091AfterPost
    BeforeDelete = QI091BeforeDelete
    AfterDelete = QI091AfterDelete
    AfterScroll = QI091AfterScroll
    OnCalcFields = QI091CalcFields
    OnFilterRecord = QI091FilterRecord
    Left = 88
    Top = 12
    object QI091AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Origin = 'I091_DATIENTE.AZIENDA'
      Visible = False
      Size = 30
    end
    object QI091TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'I091_DATIENTE.TIPO'
      ReadOnly = True
      Size = 40
    end
    object QI091DATO: TStringField
      DisplayLabel = 'VALORE'
      FieldName = 'DATO'
      Origin = 'I091_DATIENTE.DATO'
      OnGetText = QI091DATOGetText
      Size = 200
    end
    object QI091D_Tipo: TStringField
      DisplayLabel = 'TIPO DATO'
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'D_Tipo'
      Size = 50
      Calculated = True
    end
    object QI091Gruppo: TStringField
      FieldKind = fkCalculated
      FieldName = 'Gruppo'
      Calculated = True
    end
  end
  object _Ins091: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I091_DATIENTE '
      '(AZIENDA, TIPO) '
      'VALUES '
      '(:AZIENDA, :TIPO) '
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000}
    Left = 168
    Top = 12
  end
  object QI092: TOracleDataSet
    SQL.Strings = (
      'SELECT SCHEDA FROM MONDOEDP.I092_LOGTABELLE '
      'WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    BeforeOpen = BeforeOpen_ReadBuffer
    Left = 224
    Top = 12
  end
  object _Del092: TOracleQuery
    SQL.Strings = (
      'DELETE MONDOEDP.I092_LOGTABELLE '
      'WHERE AZIENDA = :AZIENDA AND SCHEDA = :SCHEDA')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A00530043004800450044004100050000000000
      000000000000}
    Left = 268
    Top = 12
  end
  object _Ins092: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I092_LOGTABELLE (AZIENDA,SCHEDA)'
      'VALUES (:AZIENDA,:SCHEDA)')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A00530043004800450044004100050000000000
      000000000000}
    Left = 308
    Top = 12
  end
  object QI070: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.*,I070.ROWID '
      '  FROM MONDOEDP.I070_UTENTI I070 '
      ' ORDER BY AZIENDA,UTENTE')
    ReadBuffer = 50
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000F0000000E00000041005A00490045004E0044004100010000000000
      0C0000005500540045004E005400450001000000000016000000500052004F00
      47005200450053005300490056004F000100000000000C000000500041005300
      530057004400010000000000100000004F004300430055005000410054004F00
      0100000000002800000049004E00540045004700520041005A0049004F004E00
      450041004E004100470052004100460045000100000000000E00000053004200
      4C004F00430043004F00010000000000100000005000450052004D0045005300
      530049000100000000001E000000460049004C00540052004F005F0041004E00
      4100470052004100460045000100000000001E000000460049004C0054005200
      4F005F00460055004E005A0049004F004E004900010000000000220000004600
      49004C00540052004F005F00440049005A0049004F004E004100520049004F00
      0100000000000E00000044004100540041005F00500057000100000000001C00
      00004E0055004F00560041005F00500041005300530057004F00520044000100
      000000001800000044004100540041005F004100430043004500530053004F00
      0100000000001C0000004100430043004500530053004F005F004E0045004700
      410054004F00010000000000}
    AfterQuery = QI070AfterQuery
    CachedUpdates = True
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeInsert = QI070BeforeInsert
    BeforeEdit = QI070BeforeEdit
    BeforePost = QI070BeforePost
    AfterPost = QI070AfterPost
    AfterCancel = QI070AfterCancel
    BeforeDelete = QI070BeforeDelete
    AfterDelete = QI070AfterDelete
    BeforeScroll = QI070BeforeScroll
    AfterScroll = QI070AfterScroll
    OnCalcFields = QI070CalcFields
    OnFilterRecord = QI070FilterRecord
    OnPostError = QI070PostError
    Left = 20
    Top = 60
    object QI070AZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA'
      Required = True
      OnValidate = QI070AZIENDAValidate
      Size = 30
    end
    object QI070UTENTE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'UTENTE'
      Required = True
      Size = 30
    end
    object QI070PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo operatore'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object QI070OCCUPATO: TStringField
      DisplayLabel = 'Occupato'
      FieldName = 'OCCUPATO'
      Visible = False
      Size = 1
    end
    object QI070PASSWD: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PASSWD'
      Visible = False
      OnGetText = I070PASSWDGetText
      OnSetText = I070PASSWDSetText
      Size = 40
    end
    object QI070INTEGRAZIONEANAGRAFE: TStringField
      DisplayLabel = 'Integrazione anagrafe'
      FieldName = 'INTEGRAZIONEANAGRAFE'
      Origin = 'I070_OPERATORI.INTEGRAZIONEANAGRAFE'
      Visible = False
      Size = 1
    end
    object QI070SBLOCCO: TStringField
      DisplayLabel = 'Sblocco'
      FieldName = 'SBLOCCO'
      Visible = False
      Size = 1
    end
    object QI070PERMESSI: TStringField
      DisplayLabel = 'Permessi'
      FieldName = 'PERMESSI'
      Visible = False
    end
    object QI070FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Visible = False
    end
    object QI070FILTRO_FUNZIONI: TStringField
      DisplayLabel = 'Filtro funzioni'
      FieldName = 'FILTRO_FUNZIONI'
      Visible = False
    end
    object QI070FILTRO_DIZIONARIO: TStringField
      DisplayLabel = 'Filtro dizionario'
      FieldName = 'FILTRO_DIZIONARIO'
      Visible = False
    end
    object QI070DATA_PW: TDateTimeField
      DisplayLabel = 'Data password'
      FieldName = 'DATA_PW'
      Visible = False
    end
    object QI070ScadenzaPasswd: TDateField
      DisplayLabel = 'Scadenza password'
      FieldKind = fkCalculated
      FieldName = 'ScadenzaPasswd'
      Visible = False
      Calculated = True
    end
    object QI070D_Azienda: TStringField
      DisplayLabel = 'Azienda'
      FieldKind = fkLookup
      FieldName = 'D_Azienda'
      LookupDataSet = QI090
      LookupKeyFields = 'AZIENDA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'AZIENDA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object QI070NUOVA_PASSWORD: TStringField
      DisplayLabel = 'Nuova password'
      FieldName = 'NUOVA_PASSWORD'
      Visible = False
      Size = 1
    end
    object QI070DATA_ACCESSO: TDateTimeField
      DisplayLabel = 'Data accesso'
      FieldName = 'DATA_ACCESSO'
      Visible = False
    end
    object QI070ScadenzaUtente: TDateField
      DisplayLabel = 'Scadenza utente'
      FieldKind = fkCalculated
      FieldName = 'ScadenzaUtente'
      Visible = False
      Calculated = True
    end
    object QI070ACCESSO_NEGATO: TStringField
      DisplayLabel = 'Accesso negato'
      FieldName = 'ACCESSO_NEGATO'
      Required = True
      Visible = False
      Size = 1
    end
    object QI070VALIDITA_CESSATI: TIntegerField
      DisplayLabel = 'Validita cessati'
      FieldName = 'VALIDITA_CESSATI'
      Visible = False
      MaxValue = 999
    end
    object QI070T030_PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo anag. riferimento'
      FieldName = 'T030_PROGRESSIVO'
      Visible = False
    end
  end
  object T035: TOracleDataSet
    SQL.Strings = (
      'SELECT T035.*,T035.ROWID FROM MONDOEDP.T035_PROGRESSIVO T035')
    ReadBuffer = 1
    Optimize = False
    Left = 137
    Top = 60
  end
  object OperSQL: TOracleQuery
    ReadBuffer = 1
    Optimize = False
    Left = 385
    Top = 60
  end
  object DbIris008B: TOracleSession
    AfterLogOn = DbIris008BAfterLogOn
    Preferences.UseOCI7 = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Preferences.TrimStringFields = False
    Preferences.ZeroDateIsNull = False
    NullValue = nvNull
    Left = 22
    Top = 394
  end
  object QCOLS: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    Optimize = False
    Session = DbIris008B
    Left = 74
    Top = 394
  end
  object selI071: TOracleDataSet
    SQL.Strings = (
      'SELECT I071.*,ROWID '
      '  FROM MONDOEDP.I071_PERMESSI I071'
      'ORDER BY AZIENDA,PROFILO')
    ReadBuffer = 50
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    AfterOpen = selI071AfterOpen
    BeforePost = selI071BeforePost
    BeforeScroll = BeforeScroll
    OnFilterRecord = selI071FilterRecord
    Left = 245
    Top = 108
  end
  object selI072: TOracleDataSet
    SQL.Strings = (
      'SELECT I072.*,ROWID '
      '  FROM MONDOEDP.I072_FILTROANAGRAFE I072'
      ' ORDER BY PROFILO,PROGRESSIVO')
    ReadBuffer = 100
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000060000000E000000500052004F00460049004C004F00010000000000
      16000000500052004F0047005200450053005300490056004F00010000000000
      0A000000430041004D0050004F00010000000000120000004F00500045005200
      410054004F00520045000100000000000C000000560041004C004F0052004500
      010000000000100000004F0050004C004F004700490043004F00010000000000}
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    OnFilterRecord = selI072FilterRecord
    Left = 289
    Top = 108
  end
  object selI073: TOracleDataSet
    SQL.Strings = (
      'SELECT I073.*,ROWID '
      '  FROM MONDOEDP.I073_FILTROFUNZIONI I073'
      ' WHERE APPLICAZIONE IN (:APPLICAZIONE,'#39'FUNWEB'#39')'
      ' ORDER BY PROFILO,GRUPPO,DESCRIZIONE')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E000000500052004F00460049004C004F00010000000000
      180000004100500050004C004900430041005A0049004F004E00450001000000
      00000600000054004100470001000000000010000000460055004E005A004900
      4F004E0045000100000000000C000000470052005500500050004F0001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      00001400000049004E004900420049005A0049004F004E004500010000000000}
    ReadOnly = True
    CommitOnPost = False
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeInsert = selI073BeforeDeleteInsert
    BeforePost = selI073BeforePost
    BeforeDelete = selI073BeforeDeleteInsert
    OnFilterRecord = selI073FilterRecord
    OnNewRecord = selI073NewRecord
    Left = 333
    Top = 108
    object selI073PROFILO: TStringField
      FieldName = 'PROFILO'
      Required = True
    end
    object selI073APPLICAZIONE: TStringField
      FieldName = 'APPLICAZIONE'
      Required = True
      Size = 6
    end
    object selI073TAG: TIntegerField
      FieldName = 'TAG'
      Required = True
    end
    object selI073FUNZIONE: TStringField
      FieldName = 'FUNZIONE'
      Size = 50
    end
    object selI073GRUPPO: TStringField
      FieldName = 'GRUPPO'
      Size = 50
    end
    object selI073DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
    object selI073INIBIZIONE: TStringField
      FieldName = 'INIBIZIONE'
      OnValidate = selI073INIBIZIONEValidate
      Size = 1
    end
    object selI073AZIENDA: TStringField
      FieldName = 'AZIENDA'
    end
    object selI073ACCESSO_BROWSE: TStringField
      DisplayLabel = 'Accesso Browse'
      FieldName = 'ACCESSO_BROWSE'
      Size = 1
    end
    object selI073RIGHE_PAGINA: TIntegerField
      DisplayLabel = 'Righe pagina'
      FieldName = 'RIGHE_PAGINA'
      MaxValue = 9999
      MinValue = -1
    end
  end
  object selI074: TOracleDataSet
    SQL.Strings = (
      'SELECT I074.*,ROWID '
      '  FROM MONDOEDP.I074_FILTRODIZIONARIO I074'
      ' ORDER BY PROFILO,TABELLA,CODICE')
    ReadBuffer = 500
    Optimize = False
    BeforeOpen = BeforeOpen_ReadBuffer
    OnFilterRecord = selI074FilterRecord
    Left = 377
    Top = 108
  end
  object selI072Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I072_FILTROANAGRAFE'
      'ORDER BY AZIENDA,PROFILO'
      '')
    Optimize = False
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeScroll = BeforeScroll
    AfterScroll = selI072DistAfterScroll
    OnFilterRecord = selI071FilterRecord
    Left = 24
    Top = 108
  end
  object selI073Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I073_FILTROFUNZIONI '
      ' --WHERE APPLICAZIONE = :APPLICAZIONE'
      'ORDER BY AZIENDA,PROFILO')
    Optimize = False
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeScroll = BeforeScroll
    AfterScroll = selI073DistAfterScroll
    OnFilterRecord = selI071FilterRecord
    Left = 84
    Top = 108
  end
  object selI074Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA'
      '  FROM MONDOEDP.I074_FILTRODIZIONARIO'
      'ORDER BY AZIENDA,PROFILO')
    Optimize = False
    Filtered = True
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeScroll = BeforeScroll
    AfterScroll = selI074DistAfterScroll
    OnFilterRecord = selI071FilterRecord
    Left = 144
    Top = 108
  end
  object dsrI072Dist: TDataSource
    DataSet = selI072Dist
    Left = 24
    Top = 152
  end
  object dsrI073Dist: TDataSource
    DataSet = selI073Dist
    Left = 84
    Top = 152
  end
  object dsrI074Dist: TDataSource
    DataSet = selI074Dist
    Left = 144
    Top = 152
  end
  object dsrI071: TDataSource
    AutoEdit = False
    DataSet = selI071
    Left = 245
    Top = 152
  end
  object dsrI072: TDataSource
    DataSet = selI072
    Left = 289
    Top = 152
  end
  object dsrI073: TDataSource
    DataSet = selI073
    Left = 333
    Top = 152
  end
  object dsrI074: TDataSource
    DataSet = selI074
    Left = 377
    Top = 152
  end
  object insI071: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I071_PERMESSI (PROFILO)'
      'SELECT '
      '  :NEW_PROFILO'
      'FROM I071 WHERE PROFILO = :OLD_PROFILO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 148
    Top = 196
  end
  object selValues: TOracleDataSet
    Optimize = False
    Session = DbIris008B
    Left = 118
    Top = 394
  end
  object insI072: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO)'
      'SELECT '
      '  :NEW_PROFILO'
      'FROM I072 WHERE PROFILO = :OLD_PROFILO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 192
    Top = 196
  end
  object insI073: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO,AZIENDA)'
      'SELECT '
      '  :NEW_PROFILO,:AZIENDA'
      'FROM I072 WHERE PROFILO = :OLD_PROFILO and AZIENDA = :AZIENDA')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 236
    Top = 196
  end
  object insI074: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO)'
      'SELECT '
      '  :NEW_PROFILO'
      'FROM I072 WHERE PROFILO = :OLD_PROFILO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 328
    Top = 196
  end
  object selDizionario: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    Session = DbIris008B
    Left = 178
    Top = 394
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT ORDER BY NOME')
    Optimize = False
    Session = DbIris008B
    Left = 234
    Top = 394
  end
  object dsrT033: TDataSource
    AutoEdit = False
    DataSet = selT033
    Left = 234
    Top = 443
  end
  object QI060: TOracleDataSet
    SQL.Strings = (
      
        'SELECT I060.AZIENDA, I060.MATRICOLA, I060.NOME_UTENTE, I060.PASS' +
        'WORD, I060.DATA_PW, I060.EMAIL, I061F_ELENCO_PROFILI(I060.AZIEND' +
        'A,I060.NOME_UTENTE) NOMI_PROFILI,'
      '       T030.COGNOME||'#39' '#39'||T030.NOME NOMINATIVO_QRY, I060.ROWID '
      
        'FROM   MONDOEDP.I060_LOGIN_DIPENDENTE I060, T030_ANAGRAFICO T030' +
        ' '
      
        'WHERE  I060.MATRICOLA = T030.MATRICOLA(+) AND I060.AZIENDA = :Az' +
        'ienda'
      ':FILTRO_I061'
      'order by :COLONNA_ORD :TIPO_ORD')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A00460049004C00540052004F005F0049003000
      36003100010000000000000000000000180000003A0043004F004C004F004E00
      4E0041005F004F0052004400010000000000000000000000120000003A005400
      490050004F005F004F0052004400010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000E00000041005A00490045004E0044004100010000000000
      1E000000460049004C00540052004F005F00460055004E005A0049004F004E00
      4900010000000000120000004D00410054005200490043004F004C0041000100
      00000000160000004E004F004D0045005F005500540045004E00540045000100
      0000000010000000500041005300530057004F00520044000100000000000C00
      000052004F0057004E0055004D000100000000001E000000460049004C005400
      52004F005F0041004E004100470052004100460045000100000000000E000000
      44004100540041005F0050005700010000000000100000005000450052004D00
      450053005300490001000000000022000000460049004C00540052004F005F00
      440049005A0049004F004E004100520049004F00010000000000}
    RefreshOptions = [roBeforeEdit, roAfterInsert, roAfterUpdate]
    Filtered = True
    AfterOpen = QI060AfterOpen
    BeforePost = QI060BeforePost
    AfterPost = QI060AfterDelete
    BeforeDelete = QI060BeforeDelete
    AfterDelete = QI060AfterDelete
    AfterScroll = QI060AfterScroll
    OnCalcFields = QI060CalcFields
    OnFilterRecord = QI060FilterRecord
    OnNewRecord = QI060NewRecord
    OnPostError = QI060PostError
    Left = 21
    Top = 245
    object QI060AZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Required = True
      Visible = False
      Size = 30
    end
    object QI060MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object QI060NOME_UTENTE: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'NOME_UTENTE'
      Size = 30
    end
    object QI060PASSWORD: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PASSWORD'
      Visible = False
    end
    object QI060D_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'D_NOMINATIVO'
      LookupDataSet = selaT030
      LookupKeyFields = 'MATRICOLA'
      LookupResultField = 'NOMINATIVO'
      KeyFields = 'MATRICOLA'
      ReadOnly = True
      Size = 50
      Lookup = True
    end
    object QI060D_PASSWORD: TStringField
      DisplayLabel = 'Password'
      FieldKind = fkCalculated
      FieldName = 'D_PASSWORD'
      Calculated = True
    end
    object QI060DATA_PW: TDateTimeField
      DisplayLabel = 'Data immissione password'
      FieldName = 'DATA_PW'
    end
    object QI060EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object QI060NOMI_PROFILI: TStringField
      DisplayLabel = 'Profili disponibili'
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'NOMI_PROFILI'
      ReadOnly = True
      Size = 500
    end
    object QI060C_PWD_DECRIPTATA: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_PWD_DECRIPTATA'
      Calculated = True
    end
    object QI060NOMINATIVO_QRY: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'NOMINATIVO_QRY'
      Visible = False
      Size = 60
    end
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.*,I090.ROWID '
      '  FROM MONDOEDP.I090_ENTI I090'
      ' ORDER BY AZIENDA')
    ReadBuffer = 5
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000150000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C00490041005300010000000000160000004400450053004300
      520049005A0049004F004E0045000100000000001200000049004E0044004900
      520049005A005A004F000100000000001A0000005400490050004F0043004F00
      4E00540045004700470049004F0001000000000020000000530054004F005200
      4900410049004E00540045005200560045004E0054004F000100000000002000
      000041005A005A004500520041004D0045004E0054004F00530041004C004400
      4F00010000000000160000004500430043004600410053004300450053005400
      52000100000000000C0000005500540045004E00540045000100000000001800
      00005000410052004F004C004100430048004900410056004500010000000000
      10000000540053004C00410056004F0052004F00010000000000100000005400
      530049004E0044004900430049000100000000001A0000004600520041005A00
      49004F004E0041004E004F005400540045000100000000001C00000054004900
      4D0042004F005200490047005F0056004500520053004F000100000000002000
      0000540049004D0042004F005200490047005F00430041005500530041004C00
      45000100000000001E00000052004100470049004F004E0045005F0053004F00
      4300490041004C00450001000000000014000000560045005200530049004F00
      4E004500440042000100000000002600000043004F0044004900430045005F00
      49004E00540045004700520041005A0049004F004E0045000100000000001A00
      00004C0055004E0047005F00500041005300530057004F005200440001000000
      00001C000000560041004C00490044005F00500041005300530057004F005200
      440001000000000018000000560041004C00490044005F005500540045004E00
      54004500010000000000}
    CachedUpdates = True
    AfterScroll = selI090AfterScroll
    Left = 356
    Top = 12
    object selI090AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object selI090ALIAS: TStringField
      FieldName = 'ALIAS'
      Size = 30
    end
    object selI090DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 150
    end
    object selI090INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object selI090TIPOCONTEGGIO: TStringField
      FieldName = 'TIPOCONTEGGIO'
      Size = 1
    end
    object selI090STORIAINTERVENTO: TStringField
      FieldName = 'STORIAINTERVENTO'
      Size = 1
    end
    object selI090AZZERAMENTOSALDO: TStringField
      FieldName = 'AZZERAMENTOSALDO'
      Size = 1
    end
    object selI090ECCFASCESTR: TStringField
      FieldName = 'ECCFASCESTR'
      Size = 1
    end
    object selI090UTENTE: TStringField
      FieldName = 'UTENTE'
    end
    object selI090PAROLACHIAVE: TStringField
      FieldName = 'PAROLACHIAVE'
    end
    object selI090TSLAVORO: TStringField
      FieldName = 'TSLAVORO'
    end
    object selI090TSINDICI: TStringField
      FieldName = 'TSINDICI'
    end
    object selI090FRAZIONANOTTE: TStringField
      FieldName = 'FRAZIONANOTTE'
      Size = 1
    end
    object selI090TSAUSILIARIO: TStringField
      FieldName = 'TSAUSILIARIO'
    end
    object selI090TIMBORIG_VERSO: TStringField
      FieldName = 'TIMBORIG_VERSO'
      Size = 1
    end
    object selI090TIMBORIG_CAUSALE: TStringField
      FieldName = 'TIMBORIG_CAUSALE'
      Size = 1
    end
    object selI090RAGIONE_SOCIALE: TStringField
      FieldName = 'RAGIONE_SOCIALE'
      Size = 200
    end
    object selI090VERSIONEDB: TStringField
      FieldName = 'VERSIONEDB'
      Size = 10
    end
    object selI090CODICE_INTEGRAZIONE: TStringField
      FieldName = 'CODICE_INTEGRAZIONE'
      Size = 30
    end
    object selI090VALID_UTENTE: TIntegerField
      FieldName = 'VALID_UTENTE'
    end
  end
  object dselI090: TDataSource
    AutoEdit = False
    DataSet = selI090
    Left = 396
    Top = 12
  end
  object dselI060: TDataSource
    AutoEdit = False
    DataSet = QI060
    Left = 21
    Top = 289
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select I060.NOME_UTENTE, '
      '       T030.COGNOME,'
      '       T030.NOME,'
      '       T030.MATRICOLA'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, '
      '       T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = :AZIENDA '
      'and    I060.NOME_UTENTE <> :NOME_UTENTE'
      'and    I060.MATRICOLA = T030.MATRICOLA (+)'
      'order by I060.NOME_UTENTE')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000001000000120000004D00410054005200490043004F004C0041000100
      00000000}
    Left = 67
    Top = 245
  end
  object insI060: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I060_LOGIN_DIPENDENTE '
      
        '(AZIENDA,MATRICOLA,NOME_UTENTE,PASSWORD,FILTRO_FUNZIONI,FILTRO_A' +
        'NAGRAFE,DATA_PW,PERMESSI,FILTRO_DIZIONARIO)'
      'VALUES '
      
        '(:Azienda,:Matricola,:NomeUtente,:Password,:FiltroFunzioni,:Filt' +
        'roAnagrafe,:DataPw,:Permessi,:FiltroDizionario)'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000009000000100000003A0041005A00490045004E004400410005000000
      0000000000000000120000003A00500041005300530057004F00520044000500
      000000000000000000001E0000003A00460049004C00540052004F0046005500
      4E005A0049004F004E004900050000000000000000000000140000003A004D00
      410054005200490043004F004C00410005000000000000000000000016000000
      3A004E004F004D0045005500540045004E005400450005000000000000000000
      00001E0000003A00460049004C00540052004F0041004E004100470052004100
      46004500050000000000000000000000120000003A005000450052004D004500
      530053004900050000000000000000000000220000003A00460049004C005400
      52004F00440049005A0049004F004E004100520049004F000500000000000000
      000000000E0000003A004400410054004100500057000C000000000000000000
      0000}
    Left = 107
    Top = 245
  end
  object selaT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MATRICOLA,COGNOME||'#39' '#39'||NOME NOMINATIVO FROM T030_ANAGRAF' +
        'ICO WHERE TIPO_PERSONALE = '#39'I'#39)
    ReadBuffer = 1000
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000120000004D00410054005200490043004F004C0041000100
      00000000140000004E004F004D0049004E0041005400490056004F0001000000
      0000}
    Session = DbIris008B
    Left = 290
    Top = 394
    object selaT030MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selaT030NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 30
    end
  end
  object delI060: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :PROFILI_CANC:=0;'
      '  :LOGIN_CANC:=0;'
      ''
      '  DELETE'
      '    FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '   WHERE I061.AZIENDA = :AZIENDA'
      '     AND I061.NOME_UTENTE = :NOME_UTENTE;'
      '  :PROFILI_CANC:=SQL%ROWCOUNT;'
      ''
      '  DELETE MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      '   WHERE I060.AZIENDA = :AZIENDA'
      '     AND I060.NOME_UTENTE = :NOME_UTENTE;'
      '  IF SQL%ROWCOUNT > 0 THEN'
      '    :LOGIN_CANC:=SQL%ROWCOUNT;'
      '    :PROFILI_CANC:=0;    '
      '  END IF;'
      ''
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      540045000500000000000000000000001A0000003A00500052004F0046004900
      4C0049005F00430041004E004300030000000000000000000000160000003A00
      4C004F00470049004E005F00430041004E004300030000000000000000000000}
    Left = 155
    Top = 245
  end
  object selUser_Triggers: TOracleDataSet
    SQL.Strings = (
      
        'SELECT STATUS FROM USER_TRIGGERS WHERE TRIGGER_NAME = '#39'T030_AFTE' +
        'RINS_I060'#39)
    Optimize = False
    Session = DbIris008B
    BeforeInsert = selUser_TriggersBeforeInsert
    BeforeDelete = selUser_TriggersBeforeDelete
    Left = 366
    Top = 395
  end
  object selI070Accessi: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.*, I070.ROWID'
      'FROM MONDOEDP.I070_UTENTI I070'
      'WHERE UTENTE NOT IN ('#39'SYSMAN'#39','#39'MONDOEDP'#39')'
      'ORDER BY AZIENDA,UTENTE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000F0000000E00000041005A00490045004E0044004100010000000000
      0C0000005500540045004E005400450001000000000016000000500052004F00
      47005200450053005300490056004F000100000000000C000000500041005300
      530057004400010000000000100000004F004300430055005000410054004F00
      0100000000000E000000530042004C004F00430043004F000100000000002800
      000049004E00540045004700520041005A0049004F004E00450041004E004100
      47005200410046004500010000000000100000005000450052004D0045005300
      530049000100000000001E000000460049004C00540052004F005F0041004E00
      4100470052004100460045000100000000001E000000460049004C0054005200
      4F005F00460055004E005A0049004F004E004900010000000000220000004600
      49004C00540052004F005F00440049005A0049004F004E004100520049004F00
      0100000000000E00000044004100540041005F00500057000100000000001C00
      00004E0055004F00560041005F00500041005300530057004F00520044000100
      000000001800000044004100540041005F004100430043004500530053004F00
      0100000000001C0000004100430043004500530053004F005F004E0045004700
      410054004F00010000000000}
    Filtered = True
    BeforeInsert = selI070AccessiBeforeInsert
    BeforePost = selI070AccessiBeforePost
    BeforeDelete = selI070AccessiBeforeDelete
    Left = 80
    Top = 60
    object selI070AccessiAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selI070AccessiUTENTE: TStringField
      DisplayLabel = 'Utente'
      DisplayWidth = 20
      FieldName = 'UTENTE'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selI070AccessiACCESSO_NEGATO: TStringField
      DisplayLabel = 'Accesso negato'
      FieldName = 'ACCESSO_NEGATO'
      Size = 1
    end
    object selI070AccessiPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object selVSESSION: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SID,SERIAL#,STATUS,USERNAME,OSUSER,MACHINE,TERMINAL,PROGRAM'
      'from'
      '  gv$session'
      'where'
      '  (instr(upper(program),'#39'A002PANAGRAFE.EXE'#39')          > 0 or'
      '  instr(upper(program),'#39'M000PMISSIONI.EXE'#39')           > 0 or'
      '  instr(upper(program),'#39'P000PSTIPENDI.EXE'#39')           > 0 or'
      '  instr(upper(program),'#39'S000PSTATOGIURIDICO.EXE'#39')     > 0 or'
      '  instr(upper(program),'#39'B006PSCARICO'#39')                > 0 or'
      '  instr(upper(program),'#39'B010PMESSAGGIOROLOGI'#39')        > 0 or'
      '  instr(upper(program),'#39'B014PINTEGRAZIONEANAGRAFICA'#39') > 0 or'
      '  instr(upper(program),'#39'B015PSCARICOGIUSTIFICATIVI'#39') > 0 or'
      '  instr(upper(program),'#39'B019PGENERATORESTAMPE'#39') > 0 or'
      '  instr(upper(program),'#39'W3WP'#39') > 0 or'
      '  instr(upper(program),'#39'W000PIRISWEB'#39') > 0'
      '  ) and'
      '  UPPER(osuser||terminal||program) <> '
      
        '  (SELECT UPPER(osuser||terminal||program) FROM GV$SESSION V WHE' +
        'RE V.SID = (SELECT MAX(SID) FROM GV$MYSTAT))'
      'order by OSUSER,MACHINE,TERMINAL,PROGRAM')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000008000000060000005300490044000100000000000E00000053004500
      5200490041004C0023000100000000000C000000530054004100540055005300
      0100000000001000000055005300450052004E0041004D004500010000000000
      0C0000004F00530055005300450052000100000000000E0000004D0041004300
      480049004E004500010000000000100000005400450052004D0049004E004100
      4C000100000000000E000000500052004F004700520041004D00010000000000}
    Left = 558
    Top = 109
    object selVSESSIONSID: TFloatField
      DisplayLabel = 'Sid'
      DisplayWidth = 5
      FieldName = 'SID'
    end
    object selVSESSIONSERIAL: TFloatField
      DisplayLabel = 'Serial#'
      DisplayWidth = 5
      FieldName = 'SERIAL#'
    end
    object selVSESSIONSTATUS: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATUS'
      Size = 8
    end
    object selVSESSIONUSERNAME: TStringField
      DisplayLabel = 'User name'
      DisplayWidth = 10
      FieldName = 'USERNAME'
      Size = 30
    end
    object selVSESSIONOSUSER: TStringField
      DisplayLabel = 'Os user'
      DisplayWidth = 25
      FieldName = 'OSUSER'
      Size = 30
    end
    object selVSESSIONMACHINE: TStringField
      DisplayLabel = 'Macchina'
      DisplayWidth = 25
      FieldName = 'MACHINE'
      Size = 64
    end
    object selVSESSIONTERMINAL: TStringField
      DisplayLabel = 'Terminale'
      DisplayWidth = 15
      FieldName = 'TERMINAL'
      Size = 16
    end
    object selVSESSIONPROGRAM: TStringField
      DisplayLabel = 'Programma utilizzato'
      DisplayWidth = 20
      FieldName = 'PROGRAM'
      Size = 64
    end
  end
  object dsrVSESSION: TDataSource
    DataSet = selVSESSION
    Left = 558
    Top = 153
  end
  object delI060Filtri: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR C1 IS'
      
        '    SELECT I060.AZIENDA, I060.NOME_UTENTE, I061.NOME_PROFILO, I0' +
        '61.FILTRO_FUNZIONI'
      
        '      FROM MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I061_PR' +
        'OFILI_DIPENDENTE I061'
      '     WHERE I060.AZIENDA = :AZIENDA '
      '       AND I060.NOME_UTENTE = :NOME_UTENTE'
      '       AND I060.AZIENDA = I061.AZIENDA '
      '       AND I060.NOME_UTENTE = I061.NOME_UTENTE '
      '       AND (NVL(I061.NOME_PROFILO,'#39' '#39') = NVL(:NOMEPROFILO,'#39' '#39')) '
      
        '       AND (NVL(I061.FILTRO_FUNZIONI,'#39' '#39') = NVL(:FILTROFUNZIONI,' +
        'NVL(I061.FILTRO_FUNZIONI,'#39' '#39'))) '
      
        '       AND (NVL(I061.FILTRO_ANAGRAFE,'#39' '#39') = NVL(:FILTROANAGRAFE,' +
        'NVL(I061.FILTRO_ANAGRAFE,'#39' '#39'))) '
      
        '       AND (NVL(I061.ITER_AUTORIZZATIVI,'#39' '#39') = NVL(:ITER_AUTORIZ' +
        'ZATIVI,NVL(I061.ITER_AUTORIZZATIVI,'#39' '#39'))) '
      
        '       AND (NVL(I061.PERMESSI,'#39' '#39') = NVL(:PERMESSI,NVL(I061.PERM' +
        'ESSI,'#39' '#39'))) '
      
        '       AND (NVL(I061.FILTRO_DIZIONARIO,'#39' '#39') = NVL(:FILTRODIZIONA' +
        'RIO,NVL(I061.FILTRO_DIZIONARIO,'#39' '#39')));'
      'BEGIN'
      '  :PROFILI_CANC:=0;'
      '  :LOGIN_CANC:=0;'
      ''
      '  FOR T1 IN C1 LOOP'
      '    DELETE '
      '      FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '     WHERE I061.AZIENDA = T1.AZIENDA '
      '       AND I061.NOME_UTENTE = T1.NOME_UTENTE'
      '       AND I061.NOME_PROFILO = T1.NOME_PROFILO;'
      '    :LOGIN_CANC:=:LOGIN_CANC + SQL%ROWCOUNT;'
      '  END LOOP;'
      ''
      '  DELETE '
      '    FROM MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      '   WHERE I060.AZIENDA = :AZIENDA '
      '     AND I060.NOME_UTENTE = :NOME_UTENTE'
      '     AND NOT EXISTS(SELECT '#39'X'#39' '
      '                      FROM MONDOEDP.I061_PROFILI_DIPENDENTE '
      '                     WHERE AZIENDA = I060.AZIENDA '
      '                       AND NOME_UTENTE = I060.NOME_UTENTE);'
      ''
      '  IF SQL%ROWCOUNT > 0 THEN'
      '    :LOGIN_CANC:=SQL%ROWCOUNT;'
      '    :PROFILI_CANC:=0;    '
      '  END IF;'
      ''
      '  COMMIT;'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      040000000A000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E00000000001E0000003A00460049004C00540052004F0046
      0055004E005A0049004F004E0049000500000008000000414C424552544F0000
      0000001E0000003A00460049004C00540052004F0041004E0041004700520041
      0046004500050000000000000000000000120000003A005000450052004D0045
      00530053004900050000000A000000414C424552544F31310000000000220000
      003A00460049004C00540052004F00440049005A0049004F004E004100520049
      004F00050000000000000000000000180000003A004E004F004D004500500052
      004F00460049004C004F00050000000000000000000000260000003A00490054
      00450052005F004100550054004F00520049005A005A00410054004900560049
      00050000000000000000000000180000003A004E004F004D0045005F00550054
      0045004E00540045000500000000000000000000001A0000003A00500052004F
      00460049004C0049005F00430041004E00430003000000000000000000000016
      0000003A004C004F00470049004E005F00430041004E00430003000000000000
      0000000000}
    Left = 211
    Top = 245
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'select I061.*, I061.ROWID'
      '  from MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' where I061.AZIENDA = :AZIENDA'
      '   and I061.NOME_UTENTE = :NOME_UTENTE'
      '  order by I061.FINE_VALIDITA desc'
      '  ')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    ReadOnly = True
    OnApplyRecord = selI061ApplyRecord
    CachedUpdates = True
    BeforeInsert = selI061BeforeInsert
    BeforeEdit = selI061BeforeEdit
    BeforePost = selI061BeforePost
    OnFilterRecord = selI061FilterRecord
    OnNewRecord = selI061NewRecord
    Left = 478
    Top = 244
    object selI061AZIENDA: TStringField
      DisplayLabel = 'Azieda'
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selI061NOME_UTENTE: TStringField
      FieldName = 'NOME_UTENTE'
      Size = 30
    end
    object selI061NOME_PROFILO: TStringField
      DisplayLabel = 'Nome profilo'
      DisplayWidth = 20
      FieldName = 'NOME_PROFILO'
      Size = 30
    end
    object selI061PERMESSI: TStringField
      DisplayLabel = 'Permessi'
      DisplayWidth = 18
      FieldName = 'PERMESSI'
    end
    object selI061FILTRO_FUNZIONI: TStringField
      DisplayLabel = 'Filtro funzioni'
      DisplayWidth = 18
      FieldName = 'FILTRO_FUNZIONI'
    end
    object selI061FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      DisplayWidth = 18
      FieldName = 'FILTRO_ANAGRAFE'
    end
    object selI061ITER_AUTORIZZATIVI: TStringField
      DisplayWidth = 18
      FieldName = 'ITER_AUTORIZZATIVI'
    end
    object selI061FILTRO_DIZIONARIO: TStringField
      DisplayLabel = 'Filtro dizionario'
      DisplayWidth = 18
      FieldName = 'FILTRO_DIZIONARIO'
    end
    object selI061INIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio Validit'#224
      DisplayWidth = 10
      FieldName = 'INIZIO_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI061FINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine Validit'#224
      DisplayWidth = 10
      FieldName = 'FINE_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI061RICEZIONE_MAIL: TStringField
      DisplayLabel = 'Ricezione E-Mail'
      FieldName = 'RICEZIONE_MAIL'
      Size = 1
    end
    object selI061DELEGATO_DA: TStringField
      DisplayLabel = 'Delegato da'
      DisplayWidth = 20
      FieldName = 'DELEGATO_DA'
      Size = 30
    end
    object selI061FINE_VALIDITA2: TDateTimeField
      DisplayLabel = 'Ultimo accesso'
      DisplayWidth = 10
      FieldName = 'ULTIMO_ACCESSO'
      ReadOnly = True
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
  object dsrI061: TDataSource
    DataSet = selI061
    Left = 478
    Top = 295
  end
  object delI061: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 319
    Top = 245
  end
  object UpdI061: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '   SET I061.NOME_UTENTE = :NOME_UTENTENEW'
      ' WHERE I061.NOME_UTENTE = :NOME_UTENTEOLD'
      '   AND I061.AZIENDA = :AZIENDA')
    Optimize = False
    Variables.Data = {
      04000000030000001E0000003A004E004F004D0045005F005500540045004E00
      540045004E00450057000500000000000000000000001E0000003A004E004F00
      4D0045005F005500540045004E00540045004F004C0044000500000000000000
      00000000100000003A0041005A00490045004E00440041000500000000000000
      00000000}
    Left = 367
    Top = 244
  end
  object InsI061: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO MONDOEDP.I061_PROFILI_DIPENDENTE(AZIENDA, NOME_UTENT' +
        'E, NOME_PROFILO, PERMESSI, FILTRO_FUNZIONI, FILTRO_ANAGRAFE, ITE' +
        'R_AUTORIZZATIVI, '
      
        '                                             FILTRO_DIZIONARIO, ' +
        'INIZIO_VALIDITA, FINE_VALIDITA)'
      
        'VALUES(:AZIENDA, :NOME_UTENTE, :NOME_PROFILO, :PERMESSI, :FILTRO' +
        '_FUNZIONI, :FILTRO_ANAGRAFE, :ITER_AUTORIZZATIVI, :FILTRO_DIZION' +
        'ARIO, '
      '       :INIZIO_VALIDITA, :FINE_VALIDITA)')
    Optimize = False
    Variables.Data = {
      040000000A000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      540045000500000000000000000000001A0000003A004E004F004D0045005F00
      500052004F00460049004C004F00050000000000000000000000120000003A00
      5000450052004D00450053005300490005000000000000000000000020000000
      3A00460049004C00540052004F005F00460055004E005A0049004F004E004900
      050000000000000000000000200000003A00460049004C00540052004F005F00
      41004E0041004700520041004600450005000000000000000000000024000000
      3A00460049004C00540052004F005F00440049005A0049004F004E0041005200
      49004F00050000000000000000000000200000003A0049004E0049005A004900
      4F005F00560041004C00490044004900540041000C0000000000000000000000
      1C0000003A00460049004E0045005F00560041004C0049004400490054004100
      0C0000000000000000000000260000003A0049005400450052005F0041005500
      54004F00520049005A005A004100540049005600490005000000000000000000
      0000}
    Left = 271
    Top = 245
  end
  object selI061Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT I061.NOME_PROFILO '
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061 '
      ' WHERE I061.AZIENDA = :AZIENDA'
      ' ORDER BY I061.NOME_PROFILO')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 422
    Top = 244
  end
  object selPermessi: TOracleQuery
    SQL.Strings = (
      
        'select permessi from mondoedp.i070_utenti where azienda = :azien' +
        'da and permessi = :profilo '
      'union'
      
        'select permessi from mondoedp.i061_profili_dipendente where azie' +
        'nda = :azienda and permessi = :profilo')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 21
    Top = 338
  end
  object selFiltroAnagrafe: TOracleQuery
    SQL.Strings = (
      
        'select filtro_anagrafe from mondoedp.i070_utenti where azienda =' +
        ' :azienda and filtro_anagrafe = :profilo'
      'union'
      
        'select filtro_anagrafe from mondoedp.i061_profili_dipendente whe' +
        're azienda = :azienda and filtro_anagrafe = :profilo')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 101
    Top = 338
  end
  object selFiltroFunzioni: TOracleQuery
    SQL.Strings = (
      
        'select filtro_funzioni from mondoedp.i070_utenti where azienda =' +
        ' :azienda and filtro_funzioni = :profilo'
      'union'
      
        'select filtro_funzioni from mondoedp.i061_profili_dipendente whe' +
        're azienda = :azienda and filtro_funzioni = :profilo')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 189
    Top = 338
  end
  object selFiltroDizionario: TOracleQuery
    SQL.Strings = (
      
        'select filtro_dizionario from mondoedp.i070_utenti where azienda' +
        ' = :azienda and filtro_dizionario = :profilo'
      'union'
      
        'select filtro_dizionario from mondoedp.i061_profili_dipendente w' +
        'here azienda = :azienda and filtro_dizionario = :profilo')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 277
    Top = 338
  end
  object delI073: TOracleQuery
    SQL.Strings = (
      
        'delete from mondoedp.i073_filtrofunzioni where profilo = :profil' +
        'o and azienda = :azienda')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 284
    Top = 196
  end
  object updI073: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I073_FILTROFUNZIONI'
      'SET INIBIZIONE = :INIBIZIONE'
      'WHERE AZIENDA = :AZIENDA'
      'AND PROFILO = :PROFILO'
      'AND GRUPPO = :GRUPPO'
      'AND FUNZIONE = :FUNZIONE'
      'AND APPLICAZIONE <> :APPLICAZIONE')
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000160000003A0049004E004900420049005A0049004F004E00
      45000500000000000000000000000E0000003A00470052005500500050004F00
      050000000000000000000000120000003A00460055004E005A0049004F004E00
      45000500000000000000000000001A0000003A004100500050004C0049004300
      41005A0049004F004E004500050000000000000000000000}
    Left = 284
    Top = 60
  end
  object _scrupdI090: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  update i091_datiente set azienda = :azienda_new where azienda ' +
        '= :azienda_old;'
      
        '  update i092_logtabelle set azienda = :azienda_new where aziend' +
        'a = :azienda_old;'
      
        '  update i070_utenti set azienda = :azienda_new where azienda = ' +
        ':azienda_old;'
      
        '  update i071_permessi set azienda = :azienda_new where azienda ' +
        '= :azienda_old;'
      
        '  update i072_filtroanagrafe set azienda = :azienda_new where az' +
        'ienda = :azienda_old;'
      
        '  update i073_filtrofunzioni set azienda = :azienda_new where az' +
        'ienda = :azienda_old;'
      
        '  update i074_filtrodizionario set azienda = :azienda_new where ' +
        'azienda = :azienda_old;'
      
        '  update i060_login_dipendente set azienda = :azienda_new where ' +
        'azienda = :azienda_old;'
      
        '  update i061_profili_dipendente set azienda = :azienda_new wher' +
        'e azienda = :azienda_old;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0041005A00490045004E00440041005F004E00
      45005700050000000000000000000000180000003A0041005A00490045004E00
      440041005F004F004C004400050000000000000000000000}
    Left = 457
    Top = 12
  end
  object _scrdelI090: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete i091_datiente where azienda = :azienda;'
      '  delete i092_logtabelle where azienda = :azienda;'
      '  --delete i093_livelli_iter_aut where azienda = :azienda;'
      '  --delete i070_utenti where azienda = :azienda;'
      '  --delete i071_permessi where azienda = :azienda;'
      '  --delete i072_filtroanagrafe where azienda = :azienda;'
      '  --delete i073_filtrofunzioni where azienda = :azienda;'
      '  --delete i074_filtrodizionario where azienda = :azienda;'
      '  --delete i075_iter_autorizzativi where azienda = :azienda;'
      '  --delete i060_login_dipendente where azienda = :azienda;'
      '  --delete i061_profili_dipendente where azienda = :azienda;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 521
    Top = 12
  end
  object selI075Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT I075.AZIENDA, I075.PROFILO'
      '  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075'
      ' ORDER BY I075.AZIENDA, I075.PROFILO')
    Optimize = False
    BeforeOpen = BeforeOpen_ReadBuffer
    BeforeScroll = BeforeScroll
    AfterScroll = selI075DistAfterScroll
    OnFilterRecord = selI071FilterRecord
    Left = 196
    Top = 109
  end
  object dsrI075: TDataSource
    DataSet = selI075
    Left = 424
    Top = 154
  end
  object dsrI075Dist: TDataSource
    DataSet = selI075Dist
    Left = 196
    Top = 152
  end
  object insI075: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO MONDOEDP.I075_ITER_AUTORIZZATIVI(AZIENDA, PROFILO, I' +
        'TER, COD_ITER, LIVELLO, ACCESSO)'
      
        'SELECT I096.AZIENDA, :PROFILO, I096.ITER, I096.COD_ITER, I096.LI' +
        'VELLO, NVL(:ACCESSO,'#39'N'#39')'
      '  FROM MONDOEDP.I096_LIVELLI_ITER_AUT I096'
      ' WHERE I096.AZIENDA = :AZIENDA'
      '   AND I096.ITER LIKE NVL(:ITER,'#39'%'#39')'
      '   AND I096.COD_ITER LIKE NVL(:COD_ITER,'#39'%'#39')'
      '   AND TO_CHAR(I096.LIVELLO) LIKE (NVL(:LIVELLO,'#39'%'#39'))')
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000100000003A004C004900560045004C004C004F000500000000000000
      00000000100000003A004100430043004500530053004F000500000000000000
      00000000}
    Left = 376
    Top = 196
  end
  object selI075: TOracleDataSet
    SQL.Strings = (
      
        'SELECT :AZIENDA AS AZIENDA, :PROFILO AS PROFILO, I096.ITER, I096' +
        '.COD_ITER, I096.LIVELLO, '
      '       NVL(I075.ACCESSO,'#39'N'#39') AS ACCESSO, I075.ROWID'
      
        '  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075, MONDOEDP.I096_LIVE' +
        'LLI_ITER_AUT I096'
      ' WHERE I096.AZIENDA = :AZIENDA'
      '   AND I075.PROFILO(+) LIKE NVL(:PROFILO,'#39'%'#39')'
      '   AND I096.AZIENDA = I075.AZIENDA(+)'
      '   AND I096.ITER = I075.ITER(+)'
      '   AND I096.COD_ITER = I075.COD_ITER(+)'
      '   AND I096.LIVELLO = I075.LIVELLO(+)'
      '   AND I096.ITER LIKE (NVL(:ITER,'#39'%'#39'))'
      ' ORDER BY I096.ITER, I096.COD_ITER, I096.LIVELLO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    ReadOnly = True
    OnApplyRecord = selI075ApplyRecord
    UpdatingTable = 'MONDOEDP.I075_ITER_AUTORIZZATIVI'
    CommitOnPost = False
    CachedUpdates = True
    OnCalcFields = selI075CalcFields
    OnNewRecord = selI075NewRecord
    Left = 425
    Top = 109
    object selI075ITER: TStringField
      FieldName = 'ITER'
      Size = 10
    end
    object selI075D_ITER: TStringField
      DisplayLabel = 'Iter'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_ITER'
      ReadOnly = True
      Size = 30
      Calculated = True
    end
    object selI075COD_ITER: TStringField
      DisplayLabel = 'Codice iter'
      DisplayWidth = 10
      FieldName = 'COD_ITER'
      ReadOnly = True
    end
    object selI075LIVELLO: TIntegerField
      DisplayLabel = 'Livello'
      DisplayWidth = 5
      FieldName = 'LIVELLO'
      ReadOnly = True
    end
    object selI075ACCESSO: TStringField
      FieldName = 'ACCESSO'
      Size = 1
    end
    object selI075D_ACCESSO: TStringField
      DisplayLabel = 'Tipo accesso'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_ACCESSO'
      LookupDataSet = cdsI075LookUp
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ACCESSO'
      Size = 30
      Lookup = True
    end
    object selI075AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selI075PROFILO: TStringField
      FieldName = 'PROFILO'
    end
  end
  object delI075: TOracleQuery
    SQL.Strings = (
      'DELETE'
      '  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075'
      ' WHERE I075.AZIENDA = :AZIENDA'
      '   AND I075.PROFILO = :PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 423
    Top = 197
  end
  object cdsI075LookUp: TClientDataSet
    PersistDataPacket.Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020001000B4445534352495A49
      4F4E4501004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'Codice'
      end>
    Params = <>
    StoreDefs = True
    Left = 482
    Top = 109
    object cdsI075LookUpCODICE: TStringField
      FieldName = 'CODICE'
      Size = 1
    end
    object cdsI075LookUpDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
  end
  object selIterAutorizzativi: TOracleQuery
    SQL.Strings = (
      'SELECT I061.ITER_AUTORIZZATIVI'
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.ITER_AUTORIZZATIVI = :PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 371
    Top = 338
  end
  object insI075_2: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO MONDOEDP.I075_ITER_AUTORIZZATIVI(AZIENDA, PROFILO, I' +
        'TER, COD_ITER, LIVELLO, ACCESSO)'
      
        'SELECT I075.AZIENDA, :NEW_PROFILO, I075.ITER, I075.COD_ITER, I07' +
        '5.LIVELLO, I075.ACCESSO'
      '  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075'
      ' WHERE I075.AZIENDA = :AZIENDA'
      '   AND I075.PROFILO = :OLD_PROFILO')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000}
    Left = 476
    Top = 196
  end
  object dsrI096: TDataSource
    DataSet = selI096
    Left = 797
    Top = 61
  end
  object cdsI096LookUp: TClientDataSet
    PersistDataPacket.Data = {
      530000009619E0BD010000001800000002000000000003000000530004495445
      520100490000000100055749445448020002000A000B4445534352495A494F4E
      4501004900000001000557494454480200020032000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ITER'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 483
    Top = 154
    object cdsI096LookUpITER: TStringField
      FieldName = 'ITER'
      Size = 10
    end
    object cdsI096LookUpDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
  object selI095: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  I095.*, I095.ROWID,'
      
        '  length(concatena_testo('#39'select '#39#39'X'#39#39' from mondoedp.i097_validi' +
        'ta_iter_aut where azienda = '#39#39#39'||I095.AZIENDA||'#39#39#39' and ITER = '#39#39 +
        #39'||I095.ITER||'#39#39#39' and COD_ITER = '#39#39#39'||I095.COD_ITER||'#39#39#39#39','#39#39')) V' +
        'ALIDITA_ITER_AUT'
      '  FROM MONDOEDP.I095_ITER_AUT I095'
      ' WHERE I095.AZIENDA = :AZIENDA'
      ' ORDER BY I095.ITER, I095.COD_ITER')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    OnApplyRecord = selI095ApplyRecord
    UpdatingTable = 'MONDOEDP.I095_ITER_AUT'
    CommitOnPost = False
    CachedUpdates = True
    AfterOpen = selI095AfterOpen
    BeforeInsert = selI095BeforeInsert
    BeforePost = selI095BeforePost
    BeforeDelete = selI095BeforeDelete
    AfterScroll = selI095AfterScroll
    OnCalcFields = selI095CalcFields
    OnNewRecord = selI095NewRecord
    Left = 752
    Top = 12
    object selI095AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI095ITER: TStringField
      DisplayLabel = 'Iter'
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object selI095COD_ITER: TStringField
      DisplayLabel = 'Cod. struttura'
      FieldName = 'COD_ITER'
    end
    object selI095DESCRIZIONE: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selI095FILTRO_RICHIESTA: TStringField
      DisplayLabel = 'Condiz. per riconoscimento Struttura'
      DisplayWidth = 30
      FieldName = 'FILTRO_RICHIESTA'
      Size = 2000
    end
    object selI095CONDIZ_AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Condiz. per autorizz. automatica'
      DisplayWidth = 30
      FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
      Size = 2000
    end
    object selI095MAX_LIV_AUTORIZZ_AUTOMATICA: TIntegerField
      DisplayLabel = 'Autorizz. automatica fino al livello'
      FieldName = 'MAX_LIV_AUTORIZZ_AUTOMATICA'
      MaxValue = 99
      MinValue = -1
    end
    object selI095FILTRO_INTERFACCIA: TStringField
      DisplayLabel = 'Filtrabile'
      FieldName = 'FILTRO_INTERFACCIA'
      Size = 1
    end
    object selI095VALIDITA_ITER_AUT2: TFloatField
      FieldName = 'VALIDITA_ITER_AUT'
      ReadOnly = True
      Visible = False
    end
    object selI095VALIDITA_ITER_AUT: TStringField
      DisplayLabel = 'Condiz. di validit'#224
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_VALIDITA_ITER_AUT'
      Calculated = True
    end
    object selI095MAX_LIV_NOTE_MODIFICABILI: TIntegerField
      DisplayLabel = 'Max liv. note modificabili'
      FieldName = 'MAX_LIV_NOTE_MODIFICABILI'
      MaxValue = 99
      MinValue = -1
    end
    object selI095CONDIZIONE_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      DisplayWidth = 20
      FieldName = 'CONDIZIONE_ALLEGATI'
      Size = 2000
    end
    object selI095ALLEGATI_MODIFICABILI: TStringField
      DisplayLabel = 'Allegati modif.'
      FieldName = 'ALLEGATI_MODIFICABILI'
      Size = 1
    end
  end
  object selI096: TOracleDataSet
    SQL.Strings = (
      'SELECT I096.*, I096.ROWID'
      '  FROM MONDOEDP.I096_LIVELLI_ITER_AUT I096'
      ' WHERE I096.AZIENDA = :AZIENDA'
      ' ORDER BY I096.ITER, I096.LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    ReadOnly = True
    OnApplyRecord = selI096ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforeInsert = selI096BeforeInsert
    BeforePost = selI096BeforePost
    BeforeDelete = selI096BeforeDelete
    OnNewRecord = selI096NewRecord
    Left = 796
    Top = 12
    object selI096AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI096ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object selI096COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 10
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selI096LIVELLO: TIntegerField
      DisplayLabel = 'Livello'
      DisplayWidth = 1
      FieldName = 'LIVELLO'
      MaxValue = 9
      MinValue = 1
    end
    object selI096DESC_LIVELLO: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESC_LIVELLO'
      Size = 40
    end
    object selI096FASE: TIntegerField
      DisplayLabel = 'Fase'
      DisplayWidth = 10
      FieldName = 'FASE'
    end
    object selI096OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      DisplayWidth = 1
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selI096AVVISO: TStringField
      DisplayLabel = 'Avviso'
      DisplayWidth = 5
      FieldName = 'AVVISO'
      Visible = False
      Size = 1
    end
    object selI096VALORI_POSSIBILI: TStringField
      DisplayLabel = 'Valori possibili'
      DisplayWidth = 10
      FieldName = 'VALORI_POSSIBILI'
      Size = 100
    end
    object selI096AUTORIZZ_INTERMEDIA: TStringField
      DisplayLabel = 'Autorizz. intermedia'
      FieldName = 'AUTORIZZ_INTERMEDIA'
      Size = 1
    end
    object selI096DATI_MODIFICABILI: TStringField
      DisplayLabel = 'Dati modificabili'
      DisplayWidth = 5
      FieldName = 'DATI_MODIFICABILI'
      Size = 1
    end
    object selI096INVIO_EMAIL: TStringField
      DisplayLabel = 'Invio e-mail'
      FieldName = 'INVIO_EMAIL'
      Size = 1
    end
    object selI096CONDIZ_AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Condiz. per autorizz. automatica'
      DisplayWidth = 30
      FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
      Size = 2000
    end
    object selI096SCRIPT_AUTORIZZ: TStringField
      DisplayLabel = 'Script  di autorizzazione'
      DisplayWidth = 20
      FieldName = 'SCRIPT_AUTORIZZ'
      Size = 2000
    end
    object selI096ALLEGATI_OBBLIGATORI: TStringField
      DisplayLabel = 'Alleg. obblig.'
      FieldName = 'ALLEGATI_OBBLIGATORI'
      Size = 1
    end
    object selI096ALLEGATI_VISIBILI: TStringField
      DisplayLabel = 'Alleg. visibili'
      FieldName = 'ALLEGATI_VISIBILI'
      Size = 1
    end
  end
  object dsrI095: TDataSource
    DataSet = selI095
    Left = 752
    Top = 61
  end
  object selI095Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT I095.COD_ITER'
      '  FROM MONDOEDP.I095_ITER_AUT I095'
      ' WHERE I095.AZIENDA = :AZIENDA'
      ' ORDER BY I095.COD_ITER')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 702
    Top = 12
    object selI095DistCOD_ITER: TStringField
      FieldName = 'COD_ITER'
      Size = 50
    end
  end
  object selI093: TOracleDataSet
    SQL.Strings = (
      'SELECT I093.*, '
      
        '  length(concatena_testo('#39'select '#39#39'X'#39#39' from mondoedp.i094_chkdat' +
        'i_iter_aut where azienda = '#39#39#39'||I093.AZIENDA||'#39#39#39' and ITER = '#39#39#39 +
        '||I093.ITER||'#39#39#39#39','#39#39')) CHKDATI_ITER_AUT,'
      '  I093.ROWID'
      '  FROM MONDOEDP.I093_BASE_ITER_AUT I093'
      ' WHERE I093.AZIENDA LIKE :AZIENDA'
      ' ORDER BY I093.ITER')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    ReadOnly = True
    OnApplyRecord = selI093ApplyRecord
    UpdatingTable = 'MONDOEDP.I093_BASE_ITER_AUT'
    CommitOnPost = False
    CachedUpdates = True
    AfterOpen = selI093AfterOpen
    BeforeInsert = selI093BeforeInsert
    BeforePost = selI093BeforePost
    BeforeDelete = selI093BeforeDelete
    AfterScroll = selI093AfterScroll
    OnCalcFields = selI093CalcFields
    Left = 614
    Top = 13
    object selI093AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI093D_iter: TStringField
      DisplayLabel = 'Iter'
      FieldKind = fkCalculated
      FieldName = 'D_iter'
      Size = 100
      Calculated = True
    end
    object selI093ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 30
    end
    object selI093REVOCABILE: TStringField
      DisplayLabel = 'Revocabile'
      FieldName = 'REVOCABILE'
      Size = 1
    end
    object selI093MAIL_OGGETTO_DIP: TStringField
      DisplayLabel = 'Mail oggetto richiedente'
      DisplayWidth = 30
      FieldName = 'MAIL_OGGETTO_DIP'
      Size = 2000
    end
    object selI093MAIL_CORPO_DIP: TStringField
      DisplayLabel = 'Mail corpo richiedente'
      DisplayWidth = 30
      FieldName = 'MAIL_CORPO_DIP'
      Size = 2000
    end
    object selI093MAIL_OGGETTO_RESP: TStringField
      DisplayLabel = 'Mail oggetto autorizzatore'
      DisplayWidth = 30
      FieldName = 'MAIL_OGGETTO_RESP'
      Size = 2000
    end
    object selI093MAIL_CORPO_RESP: TStringField
      DisplayLabel = 'Mail corpo autorizzatore'
      DisplayWidth = 30
      FieldName = 'MAIL_CORPO_RESP'
      Size = 2000
    end
    object selI093EXPR_PERIODO_VISUAL: TStringField
      DisplayLabel = 'Periodo visualizzazione'
      DisplayWidth = 30
      FieldName = 'EXPR_PERIODO_VISUAL'
      Size = 2000
    end
    object selI093CHKDATI_ITER_AUT: TFloatField
      DisplayLabel = 'Controllo riepiloghi'
      FieldName = 'CHKDATI_ITER_AUT'
      ReadOnly = True
      Visible = False
    end
    object selI093C_CHKDATI_ITER_AUT: TStringField
      DisplayLabel = 'Controllo riepiloghi'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_CHKDATI_ITER_AUT'
      Calculated = True
    end
  end
  object dsrI093: TDataSource
    DataSet = selI093
    Left = 615
    Top = 66
  end
  object _selI097: TOracleDataSet
    SQL.Strings = (
      'SELECT I097.*, I097.ROWID'
      '  FROM MONDOEDP.I097_VALIDITA_ITER_AUT I097'
      ' WHERE I097.AZIENDA = :AZIENDA'
      ' ORDER BY I097.ITER, I097.COD_ITER, I097.NUM_CONDIZ')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    ReadOnly = True
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = _selI097BeforePost
    OnNewRecord = _selI097NewRecord
    Left = 838
    Top = 12
    object _selI097AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object _selI097ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object _selI097COD_ITER: TStringField
      FieldName = 'COD_ITER'
      Visible = False
    end
    object _selI097NUM_CONDIZ: TIntegerField
      FieldName = 'NUM_CONDIZ'
      Visible = False
    end
    object _selI097CONDIZ_VALIDITA: TStringField
      DisplayLabel = 'Condizione validit'#224
      DisplayWidth = 30
      FieldName = 'CONDIZ_VALIDITA'
      Size = 2000
    end
    object _selI097MESSAGGIO: TStringField
      DisplayLabel = 'Messaggio'
      DisplayWidth = 30
      FieldName = 'MESSAGGIO'
      Size = 2000
    end
    object _selI097BLOCCANTE: TStringField
      DisplayLabel = 'Bloccante'
      FieldName = 'BLOCCANTE'
      Size = 1
    end
  end
  object _selI094: TOracleDataSet
    SQL.Strings = (
      'SELECT I094.*, I094.ROWID'
      '  FROM MONDOEDP.I094_CHKDATI_ITER_AUT I094'
      ' WHERE I094.AZIENDA = :AZIENDA'
      ' ORDER BY I094.ITER')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    ReadOnly = True
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = _selI094BeforePost
    OnNewRecord = _selI094NewRecord
    Left = 654
    Top = 13
    object _selI094AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object _selI094ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 30
    end
    object _selI094d_riepilogo: TStringField
      DisplayLabel = 'Riepilogo'
      FieldKind = fkLookup
      FieldName = 'd_riepilogo'
      LookupDataSet = _cdsBloccoRiep
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'RIEPILOGO'
      Size = 50
      Lookup = True
    end
    object _selI094RIEPILOGO: TStringField
      DisplayLabel = 'Riepilogo'
      DisplayWidth = 30
      FieldName = 'RIEPILOGO'
      Visible = False
      Size = 5
    end
    object _selI094STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Size = 1
    end
    object _selI094EXPR_DATA: TStringField
      DisplayLabel = 'Data di controllo'
      DisplayWidth = 30
      FieldName = 'EXPR_DATA'
      Size = 2000
    end
  end
  object _cdsBloccoRiep: TClientDataSet
    PersistDataPacket.Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020005000B4445534352495A49
      4F4E4501004900000001000557494454480200020032000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 483
    Top = 63
  end
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT CODREGOLA, CODICE, DESCRIZIONE'
      'FROM SG746_STATI_AVANZAMENTO'
      'ORDER BY CODREGOLA, CODICE, DESCRIZIONE')
    Optimize = False
    Session = DbIris008B
    Left = 438
    Top = 394
  end
  object UpdI060: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      ' SET I060.PASSWORD = :PASSWORD_NEW, '
      '     I060.DATA_PW = :DATAPW'
      ' WHERE I060.AZIENDA = :AZIENDA'
      ' AND I060.NOME_UTENTE = :NOME_UTENTE'
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      00000000000000001A0000003A00500041005300530057004F00520044005F00
      4E00450057000500000000000000000000000E0000003A004400410054004100
      500057000C0000000000000000000000180000003A004E004F004D0045005F00
      5500540045004E0054004500050000000000000000000000}
    AfterQuery = UpdI060AfterQuery
    Left = 151
    Top = 292
  end
  object selI065P: TOracleDataSet
    SQL.Strings = (
      'select T.* from MONDOEDP.I065_EXPR_ACCOUNT T'
      'where T.TIPO = '#39'P'#39
      'order by CODICE')
    Optimize = False
    CommitOnPost = False
    Left = 534
    Top = 245
  end
  object dsrI065P: TDataSource
    DataSet = selI065P
    Left = 534
    Top = 297
  end
  object selI065U: TOracleDataSet
    SQL.Strings = (
      'select T.* from MONDOEDP.I065_EXPR_ACCOUNT T'
      'where T.TIPO = '#39'U'#39
      'order by CODICE')
    Optimize = False
    CommitOnPost = False
    Left = 590
    Top = 245
  end
  object dsrI065U: TDataSource
    DataSet = selI065U
    Left = 593
    Top = 296
  end
  object selI065: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID from MONDOEDP.I065_EXPR_ACCOUNT T'
      'order by T.TIPO,T.CODICE')
    Optimize = False
    BeforePost = selI065BeforePost
    AfterPost = selI065AfterPost
    OnCalcFields = selI065CalcFields
    Left = 646
    Top = 245
    object selI065C_TIPO: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'C_TIPO'
      Size = 10
      Calculated = True
    end
    object selI065TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selI065CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 25
      FieldName = 'CODICE'
    end
    object selI065ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      DisplayWidth = 85
      FieldName = 'ESPRESSIONE'
      Size = 2000
    end
  end
  object dsrI065: TDataSource
    DataSet = selI065
    Left = 649
    Top = 296
  end
  object testFiltroAnagrafe: TOracleDataSet
    Optimize = False
    Left = 511
    Top = 395
    object testFiltroAnagrafeMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object testFiltroAnagrafeCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 20
      FieldName = 'COGNOME'
      Size = 30
    end
    object testFiltroAnagrafeNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 30
    end
    object testFiltroAnagrafeT430INIZIO: TDateTimeField
      DisplayLabel = 'Inizio'
      FieldName = 'T430INIZIO'
    end
    object testFiltroAnagrafeT430FINE: TDateTimeField
      DisplayLabel = 'Fine'
      FieldName = 'T430FINE'
    end
  end
  object dsrTestFiltroAnagrafe: TDataSource
    DataSet = testFiltroAnagrafe
    Left = 511
    Top = 343
  end
  object selI074Before: TOracleDataSet
    Optimize = False
    Left = 664
    Top = 112
  end
  object selI074After: TOracleDataSet
    Optimize = False
    Left = 664
    Top = 160
  end
  object selI076: TOracleDataSet
    SQL.Strings = (
      'select I076.*, I076.ROWID '
      'from   MONDOEDP.I076_REGOLE_ACCESSO I076'
      'where  AZIENDA = :AZIENDA'
      'and    PROFILO = :PROFILO'
      'and    APPLICAZIONE = :APPLICAZIONE'
      'and    TAG = :TAG'
      'order by I076.IP')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000080000003A005400410047000300
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0E000000500052004F00460049004C004F000100000000001800000041005000
      50004C004900430041005A0049004F004E004500010000000000060000005400
      4100470001000000000004000000490050000100000000001400000043004F00
      4E00530045004E005400490054004F0001000000000014000000490050005F00
      450053005400450052004E004F00010000000000}
    BeforePost = selI076BeforePost
    OnNewRecord = selI076NewRecord
    Left = 760
    Top = 112
    object selI076AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Required = True
      Visible = False
      Size = 30
    end
    object selI076PROFILO: TStringField
      FieldName = 'PROFILO'
      Required = True
      Visible = False
    end
    object selI076APPLICAZIONE: TStringField
      FieldName = 'APPLICAZIONE'
      Required = True
      Visible = False
      Size = 6
    end
    object selI076TAG: TIntegerField
      FieldName = 'TAG'
      Required = True
      Visible = False
    end
    object selI076IP: TStringField
      DisplayLabel = 'Indirizzo IP'
      FieldName = 'IP'
      Required = True
      Size = 15
    end
    object selI076CONSENTITO: TStringField
      DisplayLabel = 'Consentito'
      FieldName = 'CONSENTITO'
      Required = True
      Size = 1
    end
    object selI076IP_ESTERNO: TStringField
      DisplayLabel = 'IP esterno'
      FieldName = 'IP_ESTERNO'
      Size = 1
    end
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME, T030.CODFISCALE'
      'from   T030_ANAGRAFICO T030'
      'where  T030.PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Session = DbIris008B
    Left = 24
    Top = 448
  end
  object selI073Agg: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT APPLICAZIONE,TAG,FUNZIONE,GRUPPO,DESCRIZIONE'
      'FROM MONDOEDP.I073_FILTROFUNZIONI '
      'WHERE APPLICAZIONE IN (:APPLICAZIONE,'#39'FUNWEB'#39')'
      'ORDER BY TAG,APPLICAZIONE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Left = 764
    Top = 172
  end
  object insI073Agg: TOracleQuery
    SQL.Strings = (
      
        'insert into MONDOEDP.I073_FILTROFUNZIONI (AZIENDA,PROFILO,APPLIC' +
        'AZIONE,TAG,FUNZIONE,GRUPPO,DESCRIZIONE,INIBIZIONE)'
      
        'select distinct AZIENDA,PROFILO,:APPLICAZIONE,:TAG,:FUNZIONE,:GR' +
        'UPPO,:DESCRIZIONE,'#39'N'#39' '
      'from MONDOEDP.I073_FILTROFUNZIONI I073'
      'where not exists '
      '  (select '#39'x'#39' from MONDOEDP.I073_FILTROFUNZIONI '
      
        '   where AZIENDA = I073.AZIENDA and PROFILO = I073.PROFILO and T' +
        'AG = :TAG and APPLICAZIONE = :APPLICAZIONE)')
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00470052005500500050004F00050000000000
      000000000000120000003A00460055004E005A0049004F004E00450005000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000080000003A005400410047000300
      00000000000000000000180000003A004400450053004300520049005A004900
      4F004E004500050000000000000000000000}
    Left = 828
    Top = 220
  end
  object updI073Agg: TOracleQuery
    SQL.Strings = (
      'update MONDOEDP.I073_FILTROFUNZIONI '
      
        'set FUNZIONE = :FUNZIONE,GRUPPO = :GRUPPO,DESCRIZIONE = :DESCRIZ' +
        'IONE '
      'where TAG = :TAG and APPLICAZIONE = :APPLICAZIONE'
      
        'and   (FUNZIONE <> :FUNZIONE or GRUPPO <> :GRUPPO or DESCRIZIONE' +
        ' <> :DESCRIZIONE)')
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00470052005500500050004F00050000000000
      000000000000120000003A00460055004E005A0049004F004E00450005000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000080000003A005400410047000300
      00000000000000000000180000003A004400450053004300520049005A004900
      4F004E004500050000000000000000000000}
    Left = 764
    Top = 220
  end
  object delI073Agg: TOracleQuery
    SQL.Strings = (
      
        'delete from MONDOEDP.I073_FILTROFUNZIONI where TAG = :TAG and AP' +
        'PLICAZIONE = :APPLICAZIONE')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000080000003A005400410047000300
      00000000000000000000}
    Left = 828
    Top = 172
  end
end
