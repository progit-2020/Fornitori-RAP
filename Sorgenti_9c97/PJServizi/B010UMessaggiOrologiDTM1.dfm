object B010FMessaggiOrologiDTM1: TB010FMessaggiOrologiDTM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 144
  Width = 507
  object selT290: TOracleDataSet
    SQL.Strings = (
      'select T290.*, T290.rowid from T290_MESSAGGIOROLOGI T290')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C0000004400410054004100440044000100000000000C00
      000044004100540041004D004D000100000000000C0000004400410054004100
      590059000100000000000C000000440041005400410048004800010000000000
      2200000050004100520041004D0045005400520049005A005A0041005A004900
      4F004E0045000100000000000C000000470049004F0052004E004F0001000000
      0000}
    BeforePost = selT290BeforePost
    OnCalcFields = selT290CalcFields
    Left = 16
    Top = 12
    object selT290DATADD: TStringField
      FieldName = 'DATADD'
      OnValidate = selT290DATADDValidate
      Size = 2
    end
    object selT290DATAMM: TStringField
      FieldName = 'DATAMM'
      OnValidate = selT290DATAMMValidate
      Size = 2
    end
    object selT290DATAYY: TStringField
      FieldName = 'DATAYY'
      Size = 4
    end
    object selT290DATAHH: TStringField
      FieldName = 'DATAHH'
      Required = True
      OnValidate = selT290DATAHHValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT290PARAMETRIZZAZIONE: TStringField
      DisplayWidth = 35
      FieldName = 'PARAMETRIZZAZIONE'
      Size = 200
    end
    object selT290GIORNO: TStringField
      DisplayWidth = 1
      FieldName = 'GIORNO'
      OnValidate = selT290GIORNOValidate
      Size = 1
    end
    object selT290D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 10
      Calculated = True
    end
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select PROGRESSIVO, T430BADGE, T430TERMINALI, T430PASSENZE'
      'from T030_ANAGRAFICO T030, V430_STORICO V430,T480_COMUNI T480'
      'where '
      '  T030.PROGRESSIVO = T430PROGRESSIVO AND'
      '  T030.COMUNENAS = T480.CODICE(+) AND'
      '  :DATASITU BETWEEN T430DATADECORRENZA and T430DATAFINE and '
      '      EXISTS'
      '      (select '#39'x'#39' from T430_STORICO where '
      '         PROGRESSIVO = T430PROGRESSIVO AND'
      
        '         :DATASITU BETWEEN INIZIO AND NVL(FINE,TO_DATE('#39'31123999' +
        #39','#39'DDMMYYYY'#39')))')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A00440041005400410053004900540055000C00
      00000000000000000000}
    Session = SessioneOracleB010
    Left = 364
    Top = 12
  end
  object selT291: TOracleDataSet
    SQL.Strings = (
      'select * from T291_PARMESSAGGI '
      'where DEFAULT_FILE = '#39'S'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F005F00460049004C004500010000000000120000004E00
      4F004D0045005F00460049004C00450001000000000012000000440041005400
      41005F00460049004C0045000100000000001800000044004500460041005500
      4C0054005F00460049004C0045000100000000001A0000004E0055004D005F00
      520049005000450054005F004D00530047000100000000001A0000004E005500
      4D005F0047004700560041004C005F004D00530047000100000000001C000000
      4E0055004D005F004D004D0049004E0044005F0043004F004E00530001000000
      000018000000460049004C00540052004F005F0041004E004100470052000100
      00000000160000005400490050004F005F00460049004C00540052004F000100
      0000000018000000520045004700490053005400520041005F004D0053004700
      010000000000240000005400490050004F005F00520045004700490053005400
      520041005A0049004F004E0045000100000000001E0000004E0055004D005F00
      4D004D0049004E0044005F00560041004C0049004400010000000000}
    Session = SessioneOracleB010
    Left = 264
    Top = 12
    object selT291CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT291DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT291TIPO_FILE: TStringField
      FieldName = 'TIPO_FILE'
      Size = 1
    end
    object selT291NOME_FILE: TStringField
      FieldName = 'NOME_FILE'
      Size = 80
    end
    object selT291DATA_FILE: TStringField
      FieldName = 'DATA_FILE'
      Size = 10
    end
    object selT291DEFAULT_FILE: TStringField
      FieldName = 'DEFAULT_FILE'
      Size = 1
    end
    object selT291NUM_RIPET_MSG: TFloatField
      FieldName = 'NUM_RIPET_MSG'
    end
    object selT291NUM_GGVAL_MSG: TFloatField
      FieldName = 'NUM_GGVAL_MSG'
    end
    object selT291NUM_MMIND_CONS: TFloatField
      FieldName = 'NUM_MMIND_CONS'
    end
    object selT291FILTRO_ANAGR: TStringField
      FieldName = 'FILTRO_ANAGR'
    end
    object selT291TIPO_FILTRO: TStringField
      FieldName = 'TIPO_FILTRO'
      Size = 1
    end
    object selT291TIPO_REGISTRAZIONE: TStringField
      FieldName = 'TIPO_REGISTRAZIONE'
      Size = 1
    end
    object selT291REGISTRA_MSG: TStringField
      FieldName = 'REGISTRA_MSG'
      Size = 1
    end
    object selT291NUM_MMIND_VALID: TIntegerField
      FieldName = 'NUM_MMIND_VALID'
    end
  end
  object selT292: TOracleDataSet
    SQL.Strings = (
      'select * from T292_PARMESSAGGIDATI'
      'where CODICE=:CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Session = SessioneOracleB010
    Left = 316
    Top = 12
  end
  object QSQL: TOracleQuery
    Session = SessioneOracleB010
    Optimize = False
    Left = 264
    Top = 58
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
      'where NOME=:NOME ORDER BY POSIZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Session = SessioneOracleB010
    Left = 460
    Top = 12
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select RIGA from T002_QUERYPERSONALIZZATE'
      'where NOME=:NOME and APPLICAZIONE = '#39'RILPRE'#39' ORDER BY POSIZ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Session = SessioneOracleB010
    Left = 412
    Top = 12
  end
  object selT299: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.*,ROWID FROM T299_MESSAGGIRICHIESTI T WHERE ROWNUM <= 2' +
        '000')
    ReadBuffer = 500
    Optimize = False
    Left = 104
    Top = 12
  end
  object delStruttura: TOracleQuery
    SQL.Strings = (
      'DELETE FROM :STRUTTURA '
      'WHERE TO_DATE(:CAMPO,:FORMATO) < ADD_MONTHS(SYSDATE,:SCADENZA)')
    Session = SessioneOracleB010
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A00530054005200550054005400550052004100
      0100000000000000000000000C0000003A00430041004D0050004F0001000000
      0000000000000000100000003A0046004F0052004D00410054004F0005000000
      0000000000000000120000003A00530043004100440045004E005A0041000300
      00000000000000000000}
    Left = 316
    Top = 60
  end
  object SessioneOracleB010: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 188
    Top = 12
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA,UTENTE,PAROLACHIAVE,VERSIONEDB FROM I090_ENTI')
    Optimize = False
    Left = 60
    Top = 12
  end
end
