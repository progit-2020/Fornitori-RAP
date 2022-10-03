object W025FCambioOrarioDM: TW025FCambioOrarioDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 89
  Width = 493
  object selT085: TOracleDataSet
    SQL.Strings = (
      
        'select  T085.*, T085.ROWID, T030.MATRICOLA, T030.COGNOME || '#39' '#39' ' +
        '|| T030.NOME NOMINATIVO,'
      '        T030R.COGNOME || '#39' '#39' || T030R.NOME NOMINATIVO_RESP'
      'from    T085_RICHIESTECAMBIORARI T085,'
      '        MONDOEDP.I060_LOGIN_DIPENDENTE I060, '
      '        T030_ANAGRAFICO T030R,'
      '        :QVISTAORACLE  '
      'and     T085.PROGRESSIVO = T030.PROGRESSIVO'
      'and     I060.AZIENDA (+)= :AZIENDA '
      'and     I060.NOME_UTENTE (+) = T085.RESPONSABILE '
      'and     I060.MATRICOLA = T030R.MATRICOLA (+)'
      'and     NVL(T085.AUTORIZZAZIONE,'#39'#NULL#'#39') :AUTORIZZAZIONE'
      '        :FILTRO'
      '        :FILTRO_PERIODO'
      
        'order by T030.COGNOME, T030.NOME, T085.PROGRESSIVO, T085.DATA DE' +
        'SC, T085.DATA_RICHIESTA DESC')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C0045000100000000000000000000001E0000003A004100550054004F005200
      49005A005A0041005A0049004F004E0045000100000000000000000000001600
      00003A0044004100540041004C00410056004F0052004F000C00000000000000
      000000001E0000003A00460049004C00540052004F005F005000450052004900
      4F0044004F00010000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000}
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
    OnCalcFields = selT085CalcFields
    Left = 14
    Top = 16
    object selT085ID: TFloatField
      FieldName = 'ID'
    end
    object selT085ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT085ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT085PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT085NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT085MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT085SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT085COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT085TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT085AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT085REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT085DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
    end
    object selT085LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT085DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT085AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT085NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT085AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT085AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT085RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT085AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT085AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT085D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT085D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT085D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT085DATA: TDateTimeField
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT085TIPOGIORNO: TStringField
      FieldName = 'TIPOGIORNO'
      Size = 1
    end
    object selT085ORARIO: TStringField
      FieldName = 'ORARIO'
      Size = 5
    end
    object selT085DATA_INVER: TDateTimeField
      FieldName = 'DATA_INVER'
    end
    object selT085TIPOGIORNO_INVER: TStringField
      FieldName = 'TIPOGIORNO_INVER'
      Size = 1
    end
    object selT085ORARIO_INVER: TStringField
      FieldName = 'ORARIO_INVER'
      Size = 5
    end
    object selT085SOLO_NOTE: TStringField
      FieldName = 'SOLO_NOTE'
      Size = 1
    end
    object selT085MESSAGGI: TStringField
      FieldKind = fkCalculated
      FieldName = 'MESSAGGI'
      Size = 200
      Calculated = True
    end
    object selT085CF_Data: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_Data'
      Size = 14
      Calculated = True
    end
    object selT085CF_Orario: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_Orario'
      Size = 110
      Calculated = True
    end
    object selT085CF_Data_Inver: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_Data_Inver'
      Size = 14
      Calculated = True
    end
    object selT085CF_Orario_Inver: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_Orario_Inver'
      Size = 110
      Calculated = True
    end
    object selT085Desc_Solo_Note: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Solo_Note'
      Size = 2
      Calculated = True
    end
    object selT085Desc_Orario_Inver: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Orario_Inver'
      Size = 100
      Calculated = True
    end
    object selT085Desc_Orario: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Orario'
      Size = 100
      Calculated = True
    end
  end
  object selOrario: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  w_n_timbrature NUMBER := 0;'
      '  w_n_settimane  NUMBER := 0;'
      ''
      '  ORARIO_TROVATO EXCEPTION;'
      'BEGIN'
      '  --Prelevo l'#39'orario dalla pianificazione'
      '  BEGIN'
      '    select ORARIO'
      '    into   :ORARIO'
      '    from   T080_PIANIFORARI'
      '    where  PROGRESSIVO = :PROGRESSIVO'
      '    and    DATA = :DATA'
      '    order by DATA;'
      '  EXCEPTION'
      '    WHEN NO_DATA_FOUND THEN'
      '      :ORARIO:='#39#39';'
      '  END;'
      '  IF :ORARIO IS NOT NULL THEN'
      '    RAISE ORARIO_TROVATO;'
      '  END IF;'
      
        '  --Prelevo l'#39'orario del profilo (se trovo '#39':GGST'#39' allora devo c' +
        'ercare il giorno della settimana effettivo)'
      '  BEGIN'
      '    select DECODE(DECODE(:TIPOGIORNO,'
      '                         '#39'N'#39',T221.NONLAV,'
      '                         '#39'F'#39',T221.FESTIVO,'
      '                         '#39'T'#39',T221.FESTIVO),'
      '                  '#39':GGST'#39',DECODE(:NUMGIORNO,'
      '                                 '#39'1'#39',T221.LUNEDI,'
      '                                 '#39'2'#39',T221.MARTEDI,'
      '                                 '#39'3'#39',T221.MERCOLEDI,'
      '                                 '#39'4'#39',T221.GIOVEDI,'
      '                                 '#39'5'#39',T221.VENERDI,'
      '                                 '#39'6'#39',T221.SABATO,'
      '                                 '#39'7'#39',T221.DOMENICA),'
      '                          DECODE(:TIPOGIORNO,'
      '                                 '#39'1'#39',T221.LUNEDI,'
      '                                 '#39'2'#39',T221.MARTEDI,'
      '                                 '#39'3'#39',T221.MERCOLEDI,'
      '                                 '#39'4'#39',T221.GIOVEDI,'
      '                                 '#39'5'#39',T221.VENERDI,'
      '                                 '#39'6'#39',T221.SABATO,'
      '                                 '#39'7'#39',T221.DOMENICA,'
      '                                 '#39'N'#39',T221.NONLAV,'
      '                                 '#39'F'#39',T221.FESTIVO,'
      '                                 '#39'T'#39',T221.FESTIVO))'
      '    into   :ORARIO_PROFILO'
      
        '    from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFI' +
        'LISETTIMANA T221'
      '    where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      '    and    T430.PROGRESSIVO = :PROGRESSIVO'
      '    and    T430.PORARIO = T220.CODICE'
      
        '    and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FIN' +
        'E'
      '    and    T220.CODICE = T221.CODICE'
      '    and    T220.DECORRENZA = T221.DECORRENZA'
      '    and    T221.PROGRESSIVO = 1;'
      '  EXCEPTION'
      '    WHEN NO_DATA_FOUND THEN'
      '      :ORARIO_PROFILO:='#39#39';'
      '  END;'
      '  --Controllo se ci sono delle timbrature'
      '  select COUNT(*)'
      '  into   w_n_timbrature'
      '  from   T100_TIMBRATURE'
      '  where  PROGRESSIVO = :PROGRESSIVO'
      '  and    DATA = :DATA;'
      
        '  --Se ci sono delle timbrature verifico se c'#39#232' una sola settima' +
        'na impostata per il profilo orario'
      '  IF w_n_timbrature > 0 THEN'
      '    select COUNT(*)'
      '    into   w_n_settimane'
      
        '    from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFI' +
        'LISETTIMANA T221'
      '    where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      '    and    T430.PROGRESSIVO = :PROGRESSIVO'
      '    and    T430.PORARIO = T220.CODICE'
      
        '    and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FIN' +
        'E'
      '    and    T220.CODICE = T221.CODICE'
      '    and    T220.DECORRENZA = T221.DECORRENZA;'
      '  END IF;'
      
        '  --Se non ci sono timbrature o c'#39#232' una sola settimana impostata' +
        ' per il profilo orario ricavo l'#39'orario'
      '  IF w_n_timbrature = 0 OR w_n_settimane = 1 THEN'
      '    :ORARIO:=:ORARIO_PROFILO;'
      '  END IF;'
      'EXCEPTION'
      '  WHEN ORARIO_TROVATO THEN'
      '    NULL;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000160000003A005400490050004F00470049004F005200
      4E004F000500000000000000000000000E0000003A004F005200410052004900
      4F000500000000000000000000001E0000003A004F0052004100520049004F00
      5F00500052004F00460049004C004F0005000000000000000000000014000000
      3A004E0055004D00470049004F0052004E004F00050000000000000000000000}
    Left = 131
    Top = 16
  end
  object selOrario2: TOracleDataSet
    SQL.Strings = (
      'select codice from ('
      'select lunedi codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select martedi codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select mercoledi codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select giovedi codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select venerdi codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select sabato codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select domenica codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select nonlav codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA'
      'union'
      'select festivo codice'
      
        'from   T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISE' +
        'TTIMANA T221'
      'where  :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PORARIO = T220.CODICE'
      'and    :DATA between T220.DECORRENZA and T220.DECORRENZA_FINE'
      'and    T220.CODICE = T221.CODICE'
      'and    T220.DECORRENZA = T221.DECORRENZA)'
      'where codice is not null '
      'and codice <> '#39':GGST'#39
      'order by codice')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
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
    Left = 182
    Top = 16
  end
  object selaT085: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM T850_ITER_RICHIESTE T850, T085_RICHIESTECAMBIORARI T085'
      'WHERE T085.PROGRESSIVO = :PROGRESSIVO'
      'AND (T085.DATA = :DATA OR T085.DATA_INVER = :DATA)'
      'AND T850.ID = T085.ID'
      'AND T850.STATO IS NULL')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 71
    Top = 16
  end
  object selaT020: TOracleDataSet
    SQL.Strings = (
      'SELECT DESCRIZIONE'
      'FROM   T020_ORARI T020A'
      'WHERE  CODICE = :ORARIO'
      'AND    DECORRENZA = (SELECT MAX(T020B.DECORRENZA)'
      '                     FROM   T020_ORARI T020B'
      '                     WHERE  T020B.CODICE = T020A.CODICE'
      '                     AND    T020B.DECORRENZA <= :DATA)')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004F0052004100520049004F00050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 296
    Top = 16
  end
  object selT012: TOracleDataSet
    SQL.Strings = (
      'SELECT t.*, t.rowid'
      'from   t012_calendindivid t'
      'where  data = :DATA'
      'and    progressivo = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 240
    Top = 16
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,LAVORATIVO,FESTIVO,NUMGIORNI FROM  V010_CALENDARI'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DAL AND :AL'
      'ORDER BY DATA')
    ReadBuffer = 33
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 354
    Top = 16
  end
  object selT080: TOracleDataSet
    SQL.Strings = (
      'select T080.ROWID, T080.*'
      'from   T080_PIANIFORARI T080'
      'where  T080.PROGRESSIVO = :PROGRESSIVO'
      'and    T080.DATA = :DATA')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 411
    Top = 16
  end
end
