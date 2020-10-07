inherited A112FInvioMessaggiMW: TA112FInvioMessaggiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 129
  Width = 425
  object selT295: TOracleDataSet
    SQL.Strings = (
      
        'select T295.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME || '#39' '#39' || ' +
        'T030.NOME NOMINATIVO, T295.DATA_MSG, '
      
        '       T295.ORA_MSG, T295.OPERATORE, T295.TESTO_MSG, T295.DATA_S' +
        'CAD_MSG, T295.ROWID'
      '  from T030_ANAGRAFICO T030,'
      '       T480_COMUNI T480,'
      '       V430_STORICO V430,'
      '       T295_MESSAGGIINVIATI T295'
      ' where T030.PROGRESSIVO = T295.PROGRESSIVO '
      '   and T295.DATA_SCAD_MSG >= :DATA'
      '       :FILTRO'
      'order by NOMINATIVO'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001000000044004100540041005F004D005300470001000000
      00001200000054004500530054004F005F004D00530047000100000000001200
      00004D00410054005200490043004F004C0041000100000000000E0000004F00
      520041005F004D0053004700010000000000120000004F005000450052004100
      54004F0052004500010000000000140000004E004F004D0049004E0041005400
      490056004F000100000000001A00000044004100540041005F00530043004100
      44005F004D0053004700010000000000}
    UpdatingTable = 'T295_MESSAGGIINVIATI'
    BeforeInsert = selT295BeforeInsert
    BeforeEdit = selT295BeforeEdit
    Left = 368
    Top = 24
    object selT295PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT295MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT295NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT295DATA_MSG: TDateTimeField
      DisplayLabel = 'Data messaggio'
      DisplayWidth = 10
      FieldName = 'DATA_MSG'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT295ORA_MSG: TDateTimeField
      DisplayLabel = 'Ora'
      DisplayWidth = 5
      FieldName = 'ORA_MSG'
      DisplayFormat = 'HH:MM'
      EditMask = '!90:00;1;_'
    end
    object selT295DATA_SCAD_MSG: TDateTimeField
      DisplayLabel = 'Scadenza msg.'
      DisplayWidth = 10
      FieldName = 'DATA_SCAD_MSG'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT295OPERATORE: TStringField
      DisplayLabel = 'Operatore'
      FieldName = 'OPERATORE'
      Size = 10
    end
    object selT295TESTO_MSG: TStringField
      DisplayLabel = 'Testo messaggio'
      FieldName = 'TESTO_MSG'
      Size = 1000
    end
  end
  object dsrT295: TDataSource
    DataSet = selT295
    Left = 369
    Top = 72
  end
  object selT265T275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT 0 TIPO,RPAD(CODICE,6,'#39' '#39')||DESCRIZIONE CAUSALE FROM T275_' +
        'CAUPRESENZE'
      'UNION'
      
        'SELECT 1,RPAD(CODICE,6,'#39' '#39')||DESCRIZIONE FROM T265_CAUASSENZE WH' +
        'ERE TIPOCUMULO <> '#39'H'#39' '
      'ORDER BY TIPO')
    ReadBuffer = 100
    Optimize = False
    Left = 308
    Top = 24
  end
  object selT291: TOracleDataSet
    SQL.Strings = (
      'select Q291.*, Q291.rowid from T291_PARMESSAGGI Q291'
      'order by Q291.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000C00000043004F0044004900430045000100000000001600
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
      520041005A0049004F004E004500010000000000}
    CachedUpdates = True
    Left = 20
    Top = 24
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
    object selT291REGISTRA_MSG: TStringField
      FieldName = 'REGISTRA_MSG'
      Size = 1
    end
    object selT291TIPO_REGISTRAZIONE: TStringField
      FieldName = 'TIPO_REGISTRAZIONE'
      Size = 1
    end
  end
  object dsrT291: TDataSource
    DataSet = selT291
    Left = 21
    Top = 68
  end
  object selT292: TOracleDataSet
    SQL.Strings = (
      'select Q292.*, Q292.rowid from T292_PARMESSAGGIDATI Q292'
      'where Q292.CODICE= :CODICE_PARM')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A0043004F0044004900430045005F0050004100
      52004D00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000001600
      00005400490050004F005F005200450043004F00520044000100000000001A00
      00004E0055004D00450052004F005F005200450043004F005200440001000000
      0000080000005400490050004F000100000000001200000050004F0053004900
      5A0049004F004E004500010000000000120000004C0055004E00470048004500
      5A005A004100010000000000180000004E004F004D0045005F0043004F004C00
      4F004E004E0041000100000000000E00000046004F0052004D00410054004F00
      0100000000001C000000560041004C004F00520045005F004400450046004100
      55004C005400010000000000}
    Left = 116
    Top = 24
  end
  object dsrT292: TDataSource
    DataSet = selT292
    Left = 117
    Top = 68
  end
  object selC292: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_RECORD'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NUMERO_RECORD'
        DataType = ftInteger
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POSIZIONE'
        DataType = ftInteger
      end
      item
        Name = 'LUNGHEZZA'
        DataType = ftInteger
      end
      item
        Name = 'NOME_COLONNA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FORMATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALORE_DEFAULT'
        DataType = ftString
        Size = 90
      end
      item
        Name = 'NOME_DATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODICE_DATO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CHIAVE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'T292INDICE'
        Fields = 'NUMERO_RECORD;POSIZIONE;NOME_COLONNA'
      end>
    IndexName = 'T292INDICE'
    Params = <>
    StoreDefs = True
    BeforeInsert = selC292BeforeDelete
    BeforeDelete = selC292BeforeDelete
    AfterScroll = selC292AfterScroll
    Left = 68
    Top = 23
    object selC292TIPO_RECORD: TStringField
      FieldName = 'TIPO_RECORD'
      Visible = False
      Size = 2
    end
    object selC292NUMERO_RECORD: TIntegerField
      FieldName = 'NUMERO_RECORD'
      Visible = False
    end
    object selC292NOME_DATO: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME_DATO'
    end
    object selC292TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object selC292POSIZIONE: TIntegerField
      FieldName = 'POSIZIONE'
      Visible = False
    end
    object selC292LUNGHEZZA: TIntegerField
      FieldName = 'LUNGHEZZA'
      Visible = False
    end
    object selC292NOME_COLONNA: TStringField
      FieldName = 'NOME_COLONNA'
      Visible = False
    end
    object selC292FORMATO: TStringField
      FieldName = 'FORMATO'
      Visible = False
    end
    object selC292VALORE_DEFAULT: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 40
      FieldName = 'VALORE_DEFAULT'
      OnValidate = selC292VALORE_DEFAULTValidate
      Size = 255
    end
    object selC292CODICE_DATO: TStringField
      DisplayLabel = 'Cod.dato'
      DisplayWidth = 5
      FieldName = 'CODICE_DATO'
      Size = 50
    end
    object selC292CHIAVE: TStringField
      FieldName = 'CHIAVE'
      Visible = False
      Size = 1
    end
  end
  object dsrC292: TDataSource
    DataSet = selC292
    Left = 68
    Top = 68
  end
  object QSelect: TOracleDataSet
    Optimize = False
    Left = 164
    Top = 24
  end
  object selODS: TOracleDataSet
    SQL.Strings = (
      'select badge t430badge from t430_storico'
      'minus'
      
        'select badge from t430_storico t430 where sysdate between datade' +
        'correnza and datafine'
      'and exists '
      '  (select '#39'x'#39' from t430_storico '
      
        '   where progressivo = t430.progressivo and sysdate between iniz' +
        'io and nvl(fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')))')
    ReadBuffer = 1000
    Optimize = False
    Left = 208
    Top = 24
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      
        'SELECT RIGA FROM T002_QUERYPERSONALIZZATE WHERE NOME = :NOME AND' +
        ' APPLICAZIONE = '#39'RILPRE'#39' ORDER BY POSIZ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 252
    Top = 24
  end
end
