object B019FGeneratoreStampeDtM: TB019FGeneratoreStampeDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 134
  Width = 568
  object selT925: TOracleDataSet
    SQL.Strings = (
      'select T925.*, T925.rowid from T925_SCHEDULAZIONI T925 '
      'order by DESCRIZIONE,DATAYY,DATAMM,DATADD,GIORNO,DATAHH')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C0000004400410054004100440044000100000000000C00
      000044004100540041004D004D000100000000000C0000004400410054004100
      590059000100000000000C000000440041005400410048004800010000000000
      2200000050004100520041004D0045005400520049005A005A0041005A004900
      4F004E0045000100000000000C000000470049004F0052004E004F0001000000
      0000}
    BeforePost = selT925BeforePost
    BeforeDelete = selT925BeforeDelete
    AfterScroll = selT925AfterScroll
    OnCalcFields = selT925CalcFields
    Left = 64
    Top = 12
    object selT925ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selT925DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT925DATAHH: TStringField
      FieldName = 'DATAHH'
      Required = True
      OnValidate = selT925DATAHHValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT925DATADD: TStringField
      FieldName = 'DATADD'
      OnValidate = selT925DATADDValidate
      Size = 2
    end
    object selT925DATAMM: TStringField
      FieldName = 'DATAMM'
      OnValidate = selT925DATAMMValidate
      Size = 2
    end
    object selT925DATAYY: TStringField
      FieldName = 'DATAYY'
      Size = 4
    end
    object selT925GIORNO: TStringField
      DisplayWidth = 1
      FieldName = 'GIORNO'
      OnValidate = selT925GIORNOValidate
      Size = 1
    end
    object selT925D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 10
      Calculated = True
    end
    object selT925FUNZIONE_GG: TStringField
      FieldName = 'FUNZIONE_GG'
      Size = 2000
    end
  end
  object selAnagrafe: TOracleDataSet
    Optimize = False
    Left = 212
    Top = 62
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 16
    Top = 64
  end
  object selT003: TOracleDataSet
    SQL.Strings = (
      'select * from T003_SELEZIONIANAGRAFE'
      'where NOME=:NOME '
      'order by POSIZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 148
    Top = 62
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA,UTENTE,PAROLACHIAVE,VERSIONEDB '
      'FROM MONDOEDP.I090_ENTI'
      'ORDER BY AZIENDA'
      '')
    Optimize = False
    Left = 16
    Top = 12
  end
  object selT926: TOracleDataSet
    SQL.Strings = (
      'select T926.*, T926.rowid from T926_STAMPESCHEDULATE T926'
      'where ID = :ID'
      'order by APPLICAZIONE,CODICE_STAMPA'
      '')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C0000004400410054004100440044000100000000000C00
      000044004100540041004D004D000100000000000C0000004400410054004100
      590059000100000000000C000000440041005400410048004800010000000000
      2200000050004100520041004D0045005400520049005A005A0041005A004900
      4F004E0045000100000000000C000000470049004F0052004E004F0001000000
      0000}
    BeforePost = selT926BeforePost
    OnNewRecord = selT926NewRecord
    Left = 112
    Top = 12
    object selT926ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selT926CODICE_STAMPA: TStringField
      DisplayLabel = 'Stampa'
      DisplayWidth = 15
      FieldName = 'CODICE_STAMPA'
    end
    object selT926SELEZIONE: TStringField
      DisplayLabel = 'Selez.anagrafica'
      DisplayWidth = 15
      FieldName = 'SELEZIONE'
    end
    object selT926DAL: TStringField
      DisplayLabel = 'Dal'
      DisplayWidth = 25
      FieldName = 'DAL'
      Size = 100
    end
    object selT926AL: TStringField
      DisplayLabel = 'Al'
      DisplayWidth = 25
      FieldName = 'AL'
      Size = 100
    end
    object selT926ROTTURA: TStringField
      DisplayLabel = 'Campo di raggruppamento'
      DisplayWidth = 15
      FieldName = 'ROTTURA'
      Size = 100
    end
    object selT926NOME_FILE: TStringField
      DisplayLabel = 'File pdf'
      DisplayWidth = 20
      FieldName = 'NOME_FILE'
      Size = 200
    end
    object selT926NOME_LOG: TStringField
      DisplayLabel = 'File di log'
      DisplayWidth = 20
      FieldName = 'NOME_LOG'
      Size = 200
    end
    object selT926SEMAFORO: TStringField
      DisplayLabel = 'File semaforo'
      DisplayWidth = 15
      FieldName = 'SEMAFORO'
      Size = 200
    end
    object selT926INTESTAZIONE_LOG: TStringField
      DisplayLabel = 'Intestazione log'
      DisplayWidth = 10
      FieldName = 'INTESTAZIONE_LOG'
      Size = 1000
    end
    object selT926DETTAGLIO_LOG: TStringField
      DisplayLabel = 'Dettaglio log'
      DisplayWidth = 10
      FieldName = 'DETTAGLIO_LOG'
      Size = 1000
    end
    object selT926CMD_AFTER: TStringField
      DisplayLabel = 'Comandi a fine elaborazione'
      DisplayWidth = 10
      FieldName = 'CMD_AFTER'
      Size = 1000
    end
  end
  object selT925MaxID: TOracleQuery
    SQL.Strings = (
      'select max(ID) from T925_SCHEDULAZIONI')
    ReadBuffer = 1
    Optimize = False
    Left = 168
    Top = 12
  end
  object selT910: TOracleDataSet
    SQL.Strings = (
      'select CODICE,APPLICAZIONE,TABELLA_GENERATA '
      'from T910_RIEPILOGO '
      
        'where CODICE not in (select ID from I025_CESTINO where TABELLA =' +
        ' '#39'T910_RIEPILOGO'#39')'
      'order by CODICE')
    Optimize = False
    Left = 240
    Top = 13
  end
  object selT003Nome: TOracleDataSet
    SQL.Strings = (
      'select distinct NOME from T003_SELEZIONIANAGRAFE order by NOME')
    Optimize = False
    Left = 360
    Top = 13
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'select COLUMN_NAME from COLS'
      'where TABLE_NAME in ('#39'T030_ANAGRAFICO'#39','#39'V430_STORICO'#39') '
      '  and substr(COLUMN_NAME,5,2) <> '#39'D_'#39
      'order by TABLE_NAME,COLUMN_NAME')
    Optimize = False
    Left = 424
    Top = 13
  end
  object selDalAlFile: TOracleDataSet
    SQL.Strings = (
      'select '
      '  :dal dal, '
      '  :al al, '
      '  :nome_file nome_file, '
      '  :nome_log nome_log, '
      '  :semaforo semaforo,'
      '  :intestazione_log intestazione_log'
      'from dual')
    Optimize = False
    Variables.Data = {
      0400000006000000080000003A00440041004C00010000000000000000000000
      060000003A0041004C00010000000000000000000000140000003A004E004F00
      4D0045005F00460049004C004500010000000000000000000000120000003A00
      4E004F004D0045005F004C004F00470001000000000000000000000012000000
      3A00530045004D00410046004F0052004F000100000000000000000000002200
      00003A0049004E00540045005300540041005A0049004F004E0045005F004C00
      4F004700010000000000000000000000}
    Left = 88
    Top = 62
  end
  object A077DCom: TDCOMConnection
    ServerGUID = '{D1FA98B6-6C13-4F6F-B862-E55B7A6FD1EA}'
    ServerName = 'A077PCOMServer.A077COMServer'
    ComputerName = 'localhost'
    Left = 296
    Top = 62
  end
  object P077DCom: TDCOMConnection
    ServerGUID = '{F257D48B-2FDF-40BF-A701-EC19EBC7DBBE}'
    ServerName = 'P077PCOMServer.P077ComServer'
    ComputerName = 'localhost'
    Left = 392
    Top = 62
  end
  object selT912: TOracleDataSet
    SQL.Strings = (
      'select NOME from T912_SORTRIEPILOGO '
      'where CODICE = :CODICE'
      '  and ROTTKEY = '#39'S'#39
      'order by POS')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 288
    Top = 13
  end
  object selT925FunzioneGG: TOracleDataSet
    SQL.Strings = (
      'select :FUNZIONE_GG from DUAL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00460055004E005A0049004F004E0045005F00
      47004700010000000000000000000000}
    Left = 496
    Top = 13
  end
end
