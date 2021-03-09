object W036FTraspDirigenzaDM: TW036FTraspDirigenzaDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 275
  Width = 512
  object selSG210a: TOracleDataSet
    SQL.Strings = (
      'select  SG210.*, SG210.ROWID'
      'from    SG210_TRASP_ESPERIENZE SG210'
      'where   SG210.PROGRESSIVO = :PROGRESSIVO'
      'and     SG210.INCARICO_ATTUALE = '#39'S'#39)
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnCalcFields = EsperienzeCalcFields
    OnNewRecord = DataSetNewRecord
    Left = 14
    Top = 16
    object selSG210aPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG210aDECORRENZA: TDateTimeField
      DisplayLabel = 'Dal (*)'
      FieldName = 'DECORRENZA'
    end
    object selSG210aDECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      ReadOnly = True
      Visible = False
    end
    object selSG210aORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
    object selSG210aINCARICO_ATTUALE: TStringField
      FieldName = 'INCARICO_ATTUALE'
      Visible = False
      Size = 1
    end
    object selSG210aTIPO_AMMINISTRAZIONE: TStringField
      DisplayLabel = 'Tipologia di amministrazione (*)'
      DisplayWidth = 20
      FieldName = 'TIPO_AMMINISTRAZIONE'
      Visible = False
      Size = 200
    end
    object selSG210aAMMINISTRAZIONE: TStringField
      DisplayLabel = 'Amministrazione (*)'
      DisplayWidth = 15
      FieldName = 'AMMINISTRAZIONE'
      Size = 500
    end
    object selSG210aCOMUNE: TStringField
      FieldName = 'COMUNE'
      Visible = False
      Size = 6
    end
    object selSG210aD_COMUNE: TStringField
      DisplayLabel = 'Comune (*)'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_COMUNE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selSG210aD_PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      FieldKind = fkCalculated
      FieldName = 'D_PROVINCIA'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selSG210aSITO_WEB: TStringField
      DisplayLabel = 'Sito Web (*)'
      DisplayWidth = 15
      FieldName = 'SITO_WEB'
      Visible = False
      Size = 100
    end
    object selSG210aTEL_UFFICIO: TStringField
      DisplayLabel = 'Tel. ufficio (*)'
      DisplayWidth = 10
      FieldName = 'TEL_UFFICIO'
      Visible = False
      Size = 40
    end
    object selSG210aFAX_UFFICIO: TStringField
      DisplayLabel = 'Fax ufficio (*)'
      DisplayWidth = 10
      FieldName = 'FAX_UFFICIO'
      Visible = False
      Size = 40
    end
    object selSG210aEMAIL_UFFICIO: TStringField
      DisplayLabel = 'E-mail istituzionale (*)'
      DisplayWidth = 15
      FieldName = 'EMAIL_UFFICIO'
      Visible = False
      Size = 100
    end
    object selSG210aQUALIFICA: TStringField
      DisplayLabel = 'Qualifica (*)'
      DisplayWidth = 15
      FieldName = 'QUALIFICA'
      Size = 200
    end
    object selSG210aRUOLO: TStringField
      DisplayLabel = 'Ruolo (*)'
      DisplayWidth = 15
      FieldName = 'RUOLO'
      Size = 200
    end
    object selSG210aUNITA_ORGANIZZATIVA: TStringField
      DisplayLabel = 'Unit'#224' organizzativa (*)'
      DisplayWidth = 15
      FieldName = 'UNITA_ORGANIZZATIVA'
      Visible = False
      Size = 200
    end
    object selSG210aTESTO: TStringField
      DisplayLabel = 'Esperienza'
      DisplayWidth = 15
      FieldName = 'TESTO'
      Visible = False
      Size = 1000
    end
  end
  object selSG210b: TOracleDataSet
    SQL.Strings = (
      'select  SG210.*, SG210.ROWID'
      'from    SG210_TRASP_ESPERIENZE SG210'
      'where   SG210.PROGRESSIVO = :PROGRESSIVO'
      'and     SG210.INCARICO_ATTUALE = '#39'N'#39
      
        'order by SG210.DECORRENZA DESC, SG210.DECORRENZA_FINE DESC, SG21' +
        '0.ORDINE DESC')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnCalcFields = EsperienzeCalcFields
    OnNewRecord = DataSetNewRecord
    Left = 78
    Top = 16
    object selSG210bPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG210bDECORRENZA: TDateTimeField
      DisplayLabel = 'Dal (*)'
      FieldName = 'DECORRENZA'
    end
    object selSG210bDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al (*)'
      FieldName = 'DECORRENZA_FINE'
    end
    object selSG210bORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
    object selSG210bINCARICO_ATTUALE: TStringField
      FieldName = 'INCARICO_ATTUALE'
      Visible = False
      Size = 1
    end
    object selSG210bTIPO_AMMINISTRAZIONE: TStringField
      DisplayLabel = 'Tipologia di amministrazione (*)'
      DisplayWidth = 20
      FieldName = 'TIPO_AMMINISTRAZIONE'
      Visible = False
      Size = 200
    end
    object selSG210bAMMINISTRAZIONE: TStringField
      DisplayLabel = 'Amministrazione (*)'
      DisplayWidth = 15
      FieldName = 'AMMINISTRAZIONE'
      Size = 500
    end
    object selSG210bCOMUNE: TStringField
      FieldName = 'COMUNE'
      Visible = False
      Size = 6
    end
    object selSG210bD_COMUNE: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_COMUNE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selSG210bD_PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      FieldKind = fkCalculated
      FieldName = 'D_PROVINCIA'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selSG210bSITO_WEB: TStringField
      DisplayLabel = 'Sito Web'
      DisplayWidth = 15
      FieldName = 'SITO_WEB'
      Visible = False
      Size = 100
    end
    object selSG210bTEL_UFFICIO: TStringField
      DisplayLabel = 'Tel. ufficio'
      DisplayWidth = 10
      FieldName = 'TEL_UFFICIO'
      Visible = False
      Size = 40
    end
    object selSG210bFAX_UFFICIO: TStringField
      DisplayLabel = 'Fax ufficio'
      DisplayWidth = 10
      FieldName = 'FAX_UFFICIO'
      Visible = False
      Size = 40
    end
    object selSG210bEMAIL_UFFICIO: TStringField
      DisplayLabel = 'E-mail istituzionale'
      DisplayWidth = 15
      FieldName = 'EMAIL_UFFICIO'
      Visible = False
      Size = 100
    end
    object selSG210bQUALIFICA: TStringField
      DisplayLabel = 'Qualifica'
      DisplayWidth = 15
      FieldName = 'QUALIFICA'
      Size = 200
    end
    object selSG210bRUOLO: TStringField
      DisplayLabel = 'Ruolo'
      DisplayWidth = 15
      FieldName = 'RUOLO'
      Size = 200
    end
    object selSG210bUNITA_ORGANIZZATIVA: TStringField
      DisplayLabel = 'Unit'#224' organizzativa'
      DisplayWidth = 15
      FieldName = 'UNITA_ORGANIZZATIVA'
      Visible = False
      Size = 200
    end
    object selSG210bTESTO: TStringField
      DisplayLabel = 'Esperienza (*)'
      DisplayWidth = 15
      FieldName = 'TESTO'
      Visible = False
      Size = 1000
    end
  end
  object selSG211a: TOracleDataSet
    SQL.Strings = (
      'select  SG211.*, SG211.ROWID'
      'from    SG211_TRASP_ISTRUZIONE SG211'
      'where   SG211.TIPO = '#39'A'#39
      'and     SG211.PROGRESSIVO = :PROGRESSIVO'
      'order by SG211.ORDINE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    CommitOnPost = False
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnNewRecord = DataSetNewRecord
    Left = 142
    Top = 16
    object selSG211aTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selSG211aPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG211aORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
    object selSG211aDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selSG211aTITOLO_STUDIO: TStringField
      DisplayLabel = 'Titolo di studio (*)'
      DisplayWidth = 15
      FieldName = 'TITOLO_STUDIO'
      Size = 200
    end
    object selSG211aTESTO: TStringField
      DisplayLabel = 'Testo (*)'
      DisplayWidth = 20
      FieldName = 'TESTO'
      Size = 1000
    end
  end
  object selSG212: TOracleDataSet
    SQL.Strings = (
      'select  SG212.*, SG212.ROWID'
      'from    SG212_TRASP_LINGUE SG212'
      'where   SG212.PROGRESSIVO = :PROGRESSIVO'
      'order by SG212.LINGUA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    CommitOnPost = False
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnNewRecord = DataSetNewRecord
    OnPostError = selSG212PostError
    Left = 206
    Top = 16
    object selSG212PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG212LINGUA: TStringField
      DisplayLabel = 'Lingua (*)'
      DisplayWidth = 15
      FieldName = 'LINGUA'
      Size = 100
    end
    object selSG212LIVELLO_PARLATO: TStringField
      DisplayLabel = 'Livello parlato (*)'
      DisplayWidth = 15
      FieldName = 'LIVELLO_PARLATO'
      Size = 100
    end
    object selSG212LIVELLO_SCRITTO: TStringField
      DisplayLabel = 'Livello scritto (*)'
      DisplayWidth = 15
      FieldName = 'LIVELLO_SCRITTO'
      Size = 100
    end
  end
  object selSG211b: TOracleDataSet
    SQL.Strings = (
      'select  SG211.*, SG211.ROWID'
      'from    SG211_TRASP_ISTRUZIONE SG211'
      'where   SG211.TIPO = '#39'B'#39
      'and     SG211.PROGRESSIVO = :PROGRESSIVO'
      'order by SG211.ORDINE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    CommitOnPost = False
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnNewRecord = DataSetNewRecord
    Left = 270
    Top = 16
    object selSG211bTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selSG211bPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG211bORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
    object selSG211bDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selSG211bTITOLO_STUDIO: TStringField
      FieldName = 'TITOLO_STUDIO'
      Visible = False
      Size = 200
    end
    object selSG211bTESTO: TStringField
      DisplayLabel = 'Testo (*)'
      DisplayWidth = 20
      FieldName = 'TESTO'
      Size = 1000
    end
  end
  object selSG211z: TOracleDataSet
    SQL.Strings = (
      'select  SG211.*, SG211.ROWID'
      'from    SG211_TRASP_ISTRUZIONE SG211'
      'where   SG211.TIPO = '#39'Z'#39
      'and     SG211.PROGRESSIVO = :PROGRESSIVO'
      'order by SG211.ORDINE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    CommitOnPost = False
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    AfterDelete = DataSetControlloSezioniObbligatorie
    OnNewRecord = DataSetNewRecord
    Left = 334
    Top = 16
    object selSG211zTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selSG211zPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG211zORDINE: TIntegerField
      FieldName = 'ORDINE'
      Visible = False
    end
    object selSG211zDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selSG211zTITOLO_STUDIO: TStringField
      FieldName = 'TITOLO_STUDIO'
      Visible = False
      Size = 200
    end
    object selSG211zTESTO: TStringField
      DisplayLabel = 'Testo (*)'
      DisplayWidth = 20
      FieldName = 'TESTO'
      Size = 1000
    end
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'Select * from T480_Comuni '
      ':ORDERBY')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 144
    Top = 160
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrQ480: TDataSource
    DataSet = selT480
    Left = 144
    Top = 208
  end
  object updSG210a: TOracleQuery
    SQL.Strings = (
      'UPDATE SG210_TRASP_ESPERIENZE T'
      'SET INCARICO_ATTUALE = '#39'N'#39','
      
        '    DECORRENZA_FINE = DECODE(:DECORRENZA_FINE,DECORRENZA - 1,DEC' +
        'ORRENZA,:DECORRENZA_FINE)'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND INCARICO_ATTUALE = '#39'S'#39
      'AND ROWID <> :IDRIGA ')
    Optimize = False
    Variables.Data = {
      0400000003000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000180000003A005000
      52004F0047005200450053005300490056004F00030000000000000000000000
      0E0000003A00490044005200490047004100050000000000000000000000}
    Left = 16
    Top = 72
  end
  object selSG215: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from SG215_TRASP_ABBINA_CAMPI')
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
    CommitOnPost = False
    Left = 462
    Top = 16
    object selSG215NOME_LOGICO: TStringField
      FieldName = 'NOME_LOGICO'
      Size = 40
    end
    object selSG215NOME_CAMPO: TStringField
      FieldName = 'NOME_CAMPO'
      Size = 40
    end
    object selSG215VAL_DEFAULT: TStringField
      FieldName = 'VAL_DEFAULT'
      Size = 1000
    end
    object selSG215CTRL_VALORE_DA_ELENCO: TStringField
      FieldName = 'CTRL_VALORE_DA_ELENCO'
      Size = 1
    end
  end
  object selListaValori: TOracleDataSet
    Optimize = False
    Left = 208
    Top = 160
  end
  object selSG210OrdSucc: TOracleQuery
    SQL.Strings = (
      'SELECT NVL(MAX(ORDINE),0)'
      'FROM SG210_TRASP_ESPERIENZE'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000}
    Left = 144
    Top = 72
  end
  object selSG211OrdSucc: TOracleQuery
    SQL.Strings = (
      'SELECT NVL(MAX(ORDINE),0)'
      'FROM SG211_TRASP_ISTRUZIONE'
      'WHERE TIPO = :TIPO'
      'AND PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      00000000000000000000}
    Left = 232
    Top = 72
  end
  object selV430a: TOracleDataSet
    SQL.Strings = (
      'SELECT :CAMPI'
      'FROM V430_STORICO '
      'WHERE T430PROGRESSIVO = :PROGRESSIVO'
      'AND SYSDATE BETWEEN T430DATADECORRENZA AND T430DATAFINE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A00430041004D0050004900
      010000000000000000000000}
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
    CommitOnPost = False
    Left = 14
    Top = 160
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select email'
      'from mondoedp.i060_login_dipendente'
      'where azienda = :azienda'
      'and matricola = :matricola'
      'order by nome_utente')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    Left = 80
    Top = 160
  end
  object selV430b: TOracleQuery
    SQL.Strings = (
      'SELECT MIN(T1.T430datadecorrenza)'
      'FROM V430_STORICO t1'
      'WHERE T1.T430PROGRESSIVO = :PROGRESSIVO'
      'AND nvl(T1.:nomecampo,'#39'#null#'#39') = nvl(:val_attuale,'#39'#null#'#39')'
      
        'AND T1.T430datadecorrenza > (SELECT nvl(MAX(T2.T430datadecorrenz' +
        'a),T1.T430datadecorrenza - 1)'
      '                             FROM V430_STORICO t2'
      
        '                             WHERE T2.T430PROGRESSIVO = :PROGRES' +
        'SIVO'
      
        '                             AND T2.T430datadecorrenza < :dec_at' +
        'tuale'
      
        '                             AND nvl(T2.:nomecampo,'#39'#null#'#39') <> ' +
        'nvl(:val_attuale,'#39'#null#'#39'))')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A004E004F004D0045004300
      41004D0050004F00010000000000000000000000180000003A00560041004C00
      5F00410054005400550041004C00450005000000000000000000000018000000
      3A004400450043005F00410054005400550041004C0045000C00000000000000
      00000000}
    Left = 16
    Top = 216
  end
  object selSG213: TOracleDataSet
    SQL.Strings = (
      'select  SG213.*, SG213.ROWID'
      'from    SG213_TRASP_DICHIARAZIONI SG213'
      'where   SG213.PROGRESSIVO = :PROGRESSIVO'
      'and     SG213.DATA_VALIDITA = (SELECT MAX(SG213A.DATA_VALIDITA) '
      
        '                               FROM SG213_TRASP_DICHIARAZIONI SG' +
        '213A '
      
        '                               WHERE SG213A.PROGRESSIVO = SG213.' +
        'PROGRESSIVO'
      
        '                               AND SG213A.DATA_VALIDITA >= :DATA' +
        '_VALIDITA)')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001C0000003A0044004100540041005F00
      560041004C00490044004900540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
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
    BeforePost = DataSetBeforePost
    AfterPost = DataSetControlloSezioniObbligatorie
    AfterCancel = DataSetControlloSezioniObbligatorie
    OnNewRecord = DataSetNewRecord
    Left = 398
    Top = 16
    object selSG213PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG213DATA_VALIDITA: TDateTimeField
      FieldName = 'DATA_VALIDITA'
      Visible = False
    end
    object selSG213DATA_COMPILAZIONE: TDateTimeField
      FieldName = 'DATA_COMPILAZIONE'
      Visible = False
    end
    object selSG213SENTENZA_CONDANNA: TStringField
      DisplayLabel = 'Sentenza condanna (*)'
      FieldName = 'SENTENZA_CONDANNA'
      Size = 1
    end
    object selSG213INCOMPATIBILITA: TStringField
      DisplayLabel = 'Incompatibilit'#224' (*)'
      FieldName = 'INCOMPATIBILITA'
      Size = 1
    end
    object selSG213INCONFERIBILITA: TStringField
      DisplayLabel = 'Inconferibilit'#224' (*)'
      FieldName = 'INCONFERIBILITA'
      OnChange = selSG213INCONFERIBILITAChange
      Size = 1
    end
    object selSG213INCONF_RUOLO: TStringField
      DisplayLabel = 'incarico/carica'
      FieldName = 'INCONF_RUOLO'
      Size = 200
    end
    object selSG213INCONF_AMMINISTRAZIONE: TStringField
      DisplayLabel = 'presso'
      FieldName = 'INCONF_AMMINISTRAZIONE'
      Size = 500
    end
  end
  object dsrSG213: TDataSource
    DataSet = selSG213
    Left = 400
    Top = 72
  end
end
