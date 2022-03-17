object B005FAggIrisDtM1: TB005FAggIrisDtM1
  OldCreateOrder = True
  OnCreate = DataModule2Create
  OnDestroy = DataModuleDestroy
  Height = 251
  Width = 451
  object D090: TDataSource
    AutoEdit = False
    DataSet = selI090
    Left = 151
    Top = 8
  end
  object DbAggIris: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 12
    Top = 8
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT AZIENDA,ALIAS,UTENTE,PAROLACHIAVE,TSLAVORO,TSIND' +
        'ICI,VERSIONEDB'
      'FROM MONDOEDP.I090_ENTI'
      ':FILTRO'
      'ORDER BY decode(AZIENDA,'#39'AZIN'#39',0,1),AZIENDA')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    Session = DbAggIris
    Left = 56
    Top = 8
    object selI090AZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 12
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object selI090VERSIONEDB: TStringField
      DisplayLabel = 'Versione'
      DisplayWidth = 8
      FieldName = 'VERSIONEDB'
      Size = 10
    end
    object selI090ALIAS: TStringField
      FieldName = 'ALIAS'
      Visible = False
      Size = 30
    end
    object selI090UTENTE: TStringField
      FieldName = 'UTENTE'
      Visible = False
    end
    object selI090PAROLACHIAVE: TStringField
      FieldName = 'PAROLACHIAVE'
      Visible = False
    end
    object selI090TSLAVORO: TStringField
      FieldName = 'TSLAVORO'
      Visible = False
    end
    object selI090TSINDICI: TStringField
      FieldName = 'TSINDICI'
      Visible = False
    end
  end
  object DbAzienda: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 12
    Top = 56
  end
  object SQLDml: TOracleQuery
    Session = DbAzienda
    Optimize = False
    Left = 60
    Top = 56
  end
  object Q050: TOracleDataSet
    SQL.Strings = (
      'SELECT NOME FROM I050_SCRIPTSQL')
    ReadBuffer = 200
    Optimize = False
    Session = DbAzienda
    Left = 104
    Top = 56
  end
  object InsI050: TOracleQuery
    SQL.Strings = (
      'INSERT INTO I050_SCRIPTSQL (NOME) VALUES (:NOME)')
    Session = DbAzienda
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 144
    Top = 56
  end
  object selTableSpace: TOracleDataSet
    SQL.Strings = (
      
        'SELECT TABLESPACE_NAME FROM TABS WHERE TABLE_NAME = '#39'T030_ANAGRA' +
        'FICO'#39)
    Optimize = False
    Session = DbAzienda
    Left = 272
    Top = 56
  end
  object ScriptSQL: TOracleScript
    Session = DbAzienda
    AutoCommit = True
    ColWidth = 165
    OutputOptions = [ooSQL, ooData, ooFeedback, ooError]
    Left = 204
    Top = 56
  end
  object selI090Old: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM MONDOEDP.I090_ENTI'
      'ORDER BY decode(AZIENDA,'#39'AZIN'#39',0,1),AZIENDA')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    Session = DbAggIris
    Left = 104
    Top = 8
  end
  object selI090Grant: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT AZIENDA,ALIAS,UTENTE,PAROLACHIAVE,TSLAVORO,TSIND' +
        'ICI,VERSIONEDB'
      'FROM MONDOEDP.I090_ENTI'
      'WHERE UTENTE <> '#39'MONDOEDP'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    Session = DbAggIris
    Left = 360
    Top = 160
    object StringField1: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 12
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object StringField2: TStringField
      DisplayLabel = 'Versione'
      DisplayWidth = 8
      FieldName = 'VERSIONEDB'
      Size = 10
    end
    object StringField3: TStringField
      FieldName = 'ALIAS'
      Visible = False
      Size = 30
    end
    object StringField4: TStringField
      FieldName = 'UTENTE'
      Visible = False
    end
    object StringField5: TStringField
      FieldName = 'PAROLACHIAVE'
      Visible = False
    end
    object StringField6: TStringField
      FieldName = 'TSLAVORO'
      Visible = False
    end
    object StringField7: TStringField
      FieldName = 'TSINDICI'
      Visible = False
    end
  end
  object selInvalidi: TOracleDataSet
    SQL.Strings = (
      
        'SELECT OBJECT_NAME, OBJECT_TYPE, DECODE(OBJECT_TYPE,'#39'FUNCTION'#39','#39 +
        'A'#39','#39'PROCEDURE'#39','#39'B'#39','#39'PACKAGE'#39','#39'C'#39','#39'PACKAGE BODY'#39','#39'D'#39','#39'TRIGGER'#39','#39'E' +
        #39') ORD'
      'FROM USER_OBJECTS '
      'WHERE STATUS = '#39'INVALID'#39
      'ORDER BY ORD, OBJECT_NAME')
    Optimize = False
    Session = DbAzienda
    Left = 56
    Top = 112
  end
  object selCountP042: TOracleQuery
    SQL.Strings = (
      'select count(*) from P042_ENTIIRPEF')
    Session = DbAzienda
    ReadBuffer = 1
    Optimize = False
    Left = 144
    Top = 112
  end
  object selI080: TOracleDataSet
    SQL.Strings = (
      'SELECT APPLICAZIONE,MODULO'
      'FROM MONDOEDP.I080_MODULI'
      'WHERE AZIENDA = :AZIENDA'
      'ORDER BY 1,2'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    Session = DbAggIris
    Left = 205
    Top = 8
  end
  object selI051: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID'
      'from I051_SQL_CUSTOM T'
      'where T.ATTIVO = '#39'S'#39
      'order by nvl(T.NUMORD,99999)')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000008000000080000004E004F004D004500010000000000160000004400
      450053004300520049005A0049004F004E004500010000000000120000005400
      49004D0045005300540041004D0050000100000000000C0000004E0055004D00
      4F00520044000100000000000C000000410054005400490056004F0001000000
      0000140000005300430052004900500054005F00530051004C00000000000000
      1E00000044004100540041005F00450053004500430055005A0049004F004E00
      45000100000000002000000045005300490054004F005F004500530045004300
      55005A0049004F004E004500010000000000}
    Session = DbAzienda
    Left = 56
    Top = 168
    object selI051NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object selI051DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 1000
    end
    object selI051TIMESTAMP: TDateTimeField
      FieldName = 'TIMESTAMP'
      Required = True
    end
    object selI051NUMORD: TIntegerField
      FieldName = 'NUMORD'
    end
    object selI051ATTIVO: TStringField
      FieldName = 'ATTIVO'
      Required = True
      Size = 1
    end
    object selI051SCRIPT_SQL: TMemoField
      FieldName = 'SCRIPT_SQL'
      Required = True
      BlobType = ftOraClob
    end
    object selI051DATA_ESECUZIONE: TDateTimeField
      FieldName = 'DATA_ESECUZIONE'
    end
    object selI051ESITO_ESECUZIONE: TStringField
      FieldName = 'ESITO_ESECUZIONE'
      Size = 4000
    end
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'select TIPO,DATO '
      'from MONDOEDP.I091_DATIENTE '
      'where 1=1--AZIENDA = '#39'AZIN'#39' '
      
        'and TIPO in ('#39'C90_EMAIL_SENDER_INDIRIZZO'#39','#39'C90_EMAIL_SMTPHOST'#39','#39 +
        'C90_EMAIL_USERNAME'#39','#39'C90_EMAIL_PASSWORD'#39')'
      'and DATO is not null')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    Session = DbAggIris
    Left = 261
    Top = 8
  end
end
