object W035FMessaggisticaDM: TW035FMessaggisticaDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 331
  Width = 406
  object selT282Inviati: TOracleDataSet
    SQL.Strings = (
      'select T282.ROWID,'
      '       T282.ID,'
      '       T282.STATO,'
      '       T282.DATA_INVIO,'
      '       T282.MITTENTE,'
      '       T282.RICEVENTE, '
      '       T282.ID_ORIGINALE,'
      '       T282.OGGETTO, '
      '       T282.TESTO,'
      '       T282.LETTURA_OBBLIGATORIA,'
      '       T282.SELEZIONE_ANAGRAFICA, '
      
        '       i060f_nominativo(t000f_getaziendacorrente(),T282.MITTENTE' +
        ') D_MITTENTE,'
      '       nvl(T282R.D_RISPOSTE_TOT,0) D_RISPOSTE_TOT,'
      '       concatena_testo('#39'select nominativo from ('
      
        '                          select t030.nome || '#39#39' '#39#39' || t030.cogn' +
        'ome nominativo, 0 ordinamento'
      '                          from   t284_destinatari t284,'
      '                                 t030_anagrafico t030'
      
        '                          where  t284.progressivo = t030.progres' +
        'sivo'
      '                          and    t284.id = '#39' || t282.id || '#39
      '                          union all'
      '                          select t285.utente, 1'
      '                          from   t285_utenti_dest t285'
      '                          where  t285.id = '#39' || t282.id || '#39
      '                        ) '
      '                        where    rownum <= '#39' || :LIMITE_DEST,'
      '                        '#39', '#39') D_DESTINATARI,'
      
        '       nvl(T284.D_DEST_LETTI,0) + nvl(T285.D_DEST_OPER_LETTI,0) ' +
        'D_DEST_LETTI,'
      
        '       nvl(T284.D_DEST_RICEVUTI,0) + nvl(T285.D_DEST_OPER_RICEVU' +
        'TI,0) D_DEST_RICEVUTI,'
      
        '       nvl(T284.D_DEST_TOT,0) + nvl(T285.D_DEST_OPER_TOT,0) D_DE' +
        'ST_TOT, '
      '       decode(T282.STATO,'
      '              '#39'S'#39',0, '
      '              decode(nvl(T284.D_DEST_TOT,0),'
      '                     0,0,'
      '                     nvl(T284.D_DEST_LETTI,0) / T284.D_DEST_TOT'
      '                    )'
      '             ) D_PERC_LETTURA,'
      '       decode(T282.STATO,'
      '              '#39'S'#39',0, '
      '              decode(nvl(T284.D_DEST_TOT,0),'
      '                     0,0,'
      
        '                     nvl(T284.D_DEST_RICEVUTI,0) / T284.D_DEST_T' +
        'OT'
      '                    )'
      '             ) D_PERC_RICEZIONE,             '
      '       nvl(T283.D_ALLEGATI,0) D_ALLEGATI'
      'from   T282_MESSAGGI T282,'
      '       (select ID_ORIGINALE, count(*) D_RISPOSTE_TOT'
      '        from   T282_MESSAGGI'
      '        group by ID_ORIGINALE) T282R,'
      
        '       (select ID, count(DATA_LETTURA) D_DEST_LETTI, count(DATA_' +
        'RICEZIONE) D_DEST_RICEVUTI, count(PROGRESSIVO) D_DEST_TOT'
      '        from   T284_DESTINATARI '
      '        group by ID) T284,'
      
        '       (select ID, count(DATA_LETTURA) D_DEST_OPER_LETTI, count(' +
        'DATA_RICEZIONE) D_DEST_OPER_RICEVUTI, count(UTENTE) D_DEST_OPER_' +
        'TOT'
      '        from   T285_UTENTI_DEST'
      '        group by ID) T285,'
      '       (select ID, count(*) D_ALLEGATI'
      '        from   T283_ALLEGATI'
      '        group by ID ) T283'
      'where  T282.MITTENTE = :MITTENTE'
      ':FILTRO_VIS'
      'and    T282R.ID_ORIGINALE (+) = T282.ID'
      'and    T284.ID(+) = T282.ID'
      'and    T285.ID(+) = T282.ID'
      'and    T283.ID(+) = T282.ID'
      'order by T282.ID desc')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004D0049005400540045004E00540045000500
      00000000000000000000160000003A00460049004C00540052004F005F005600
      49005300010000000000000000000000180000003A004C0049004D0049005400
      45005F004400450053005400030000000000000000000000}
    UpdatingTable = 'T282_MESSAGGI'
    CommitOnPost = False
    AfterOpen = selT282InviatiAfterOpen
    AfterScroll = selT282InviatiAfterScroll
    OnCalcFields = selT282InviatiCalcFields
    OnNewRecord = selT282InviatiNewRecord
    Left = 32
    Top = 16
    object selT282InviatiD_MITTENTE: TStringField
      DisplayLabel = 'Mittente'
      FieldName = 'D_MITTENTE'
      ReadOnly = True
      Size = 61
    end
    object selT282InviatiD_STATO: TStringField
      DisplayLabel = 'Stato'
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      ReadOnly = True
      Calculated = True
    end
    object selT282InviatiLETTURA_OBBLIGATORIA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Lettura obbligatoria'
      FieldName = 'LETTURA_OBBLIGATORIA'
      ReadOnly = True
      Size = 1
    end
    object selT282InviatiRICEVENTE: TStringField
      DisplayLabel = 'Ricevente'
      FieldName = 'RICEVENTE'
      ReadOnly = True
      Size = 30
    end
    object selT282InviatiDATA_INVIO: TDateTimeField
      DisplayLabel = 'Data invio'
      FieldName = 'DATA_INVIO'
      ReadOnly = True
    end
    object selT282InviatiOGGETTO: TStringField
      DisplayLabel = 'Oggetto'
      FieldName = 'OGGETTO'
      ReadOnly = True
      Size = 200
    end
    object selT282InviatiTESTO: TStringField
      DisplayLabel = 'Testo'
      FieldName = 'TESTO'
      ReadOnly = True
      Size = 4000
    end
    object selT282InviatiD_PERC_LETTURA: TFloatField
      FieldName = 'D_PERC_LETTURA'
      ReadOnly = True
      Visible = False
    end
    object selT282InviatiD_PERC_RICEZIONE: TFloatField
      FieldName = 'D_PERC_RICEZIONE'
      ReadOnly = True
      Visible = False
    end
    object selT282InviatiD_ALLEGATI: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Allegati'
      FieldName = 'D_ALLEGATI'
      ReadOnly = True
    end
    object selT282InviatiSELEZIONE_ANAGRAFICA: TStringField
      DisplayLabel = 'Selezione'
      FieldName = 'SELEZIONE_ANAGRAFICA'
      ReadOnly = True
    end
    object selT282InviatiD_DESTINATARI: TStringField
      DisplayLabel = 'Destinatari'
      DisplayWidth = 30
      FieldName = 'D_DESTINATARI'
      ReadOnly = True
      Size = 2000
    end
    object selT282InviatiD_STATO_LETTURA: TStringField
      DisplayLabel = 'Stato lettura'
      FieldKind = fkCalculated
      FieldName = 'D_STATO_LETTURA'
      ReadOnly = True
      Visible = False
      Size = 30
      Calculated = True
    end
    object selT282InviatiD_STATO_RICEZIONE: TStringField
      DisplayLabel = 'Stato ricezione'
      FieldKind = fkCalculated
      FieldName = 'D_STATO_RICEZIONE'
      ReadOnly = True
      Size = 30
      Calculated = True
    end
    object selT282InviatiD_DEST_LETTI: TFloatField
      FieldName = 'D_DEST_LETTI'
      ReadOnly = True
      Visible = False
    end
    object selT282InviatiD_DEST_RICEVUTI: TFloatField
      FieldName = 'D_DEST_RICEVUTI'
      ReadOnly = True
      Visible = False
    end
    object selT282InviatiD_DEST_TOT: TFloatField
      FieldName = 'D_DEST_TOT'
      ReadOnly = True
      Visible = False
    end
    object selT282InviatiID2: TFloatField
      FieldName = 'ID'
      ReadOnly = True
    end
    object selT282InviatiSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      ReadOnly = True
      Size = 1
    end
    object selT282InviatiMITTENTE: TStringField
      FieldName = 'MITTENTE'
      ReadOnly = True
      Size = 30
    end
    object selT282InviatiID_ORIGINALE: TFloatField
      DisplayLabel = 'ID orig.'
      FieldName = 'ID_ORIGINALE'
      ReadOnly = True
    end
    object selT282InviatiD_RISPOSTE_TOT: TFloatField
      FieldName = 'D_RISPOSTE_TOT'
      Visible = False
    end
  end
  object selT284: TOracleDataSet
    SQL.Strings = (
      
        'select T284.*, T284.ROWID, T030.MATRICOLA, T030.COGNOME, T030.NO' +
        'ME'
      'from   T284_DESTINATARI T284,'
      '       T030_ANAGRAFICO T030'
      'where  T284.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T284.ID = :ID'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    AfterOpen = selT284AfterOpen
    Left = 32
    Top = 208
  end
  object delT284: TOracleQuery
    SQL.Strings = (
      'delete from T284_DESTINATARI'
      'where  ID = :ID'
      'and    DATA_RICEZIONE is null')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 101
    Top = 208
  end
  object selT283: TOracleDataSet
    SQL.Strings = (
      'select T283.ID, T283.NOME, T283.DIMENSIONE, T283.ROWID'
      'from   T283_ALLEGATI T283'
      'where  T283.ID = :ID'
      'order by T283.NOME'
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    Left = 32
    Top = 144
  end
  object selT282ID: TOracleQuery
    SQL.Strings = (
      'select T282_ID.nextval'
      'from   dual')
    Optimize = False
    Left = 34
    Top = 80
  end
  object insT283: TOracleQuery
    SQL.Strings = (
      'insert into T283_ALLEGATI (ID, NOME, ALLEGATO, DIMENSIONE)'
      'values (:ID, :NOME, :ALLEGATO, :DIMENSIONE)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000060000003A00490044000300000000000000000000000A00
      00003A004E004F004D004500050000000000000000000000120000003A004100
      4C004C0045004700410054004F00710000000000000000000000160000003A00
      440049004D0045004E00530049004F004E004500030000000000000000000000}
    Left = 101
    Top = 144
  end
  object selT283Allegato: TOracleQuery
    SQL.Strings = (
      'select ALLEGATO'
      'from   T283_ALLEGATI'
      'where  ID = :ID'
      'and    NOME = :NOME')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000000A00
      00003A004E004F004D004500050000000000000000000000}
    Left = 273
    Top = 144
  end
  object delT283: TOracleQuery
    SQL.Strings = (
      'delete from T283_ALLEGATI'
      'where  ID = :ID'
      'and    NOME = :NOME'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000000A00
      00003A004E004F004D004500050000000000000000000000}
    Left = 176
    Top = 144
  end
  object insT283Dup: TOracleQuery
    SQL.Strings = (
      'insert into T283_ALLEGATI (ID, NOME, ALLEGATO, DIMENSIONE)'
      '  select :ID_NEW, NOME, ALLEGATO, DIMENSIONE'
      '  from   T283_ALLEGATI'
      '  where  ID = :ID_OLD'
      '  and    NOME = :NOME')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A00490044005F004E0045005700030000000000
      0000000000000E0000003A00490044005F004F004C0044000300000000000000
      000000000A0000003A004E004F004D004500050000000000000000000000}
    Left = 352
    Top = 144
  end
  object selT282Ricevuti: TOracleDataSet
    SQL.Strings = (
      'SELECT T282.ROWID,'
      '       T282.ID,'
      '       T282.STATO,'
      '       T282.DATA_INVIO,'
      '       T282.MITTENTE,'
      '       T282.RICEVENTE,'
      '       T282.ID_ORIGINALE, '
      '       T282.OGGETTO, '
      '       T282.TESTO,'
      '       T282.LETTURA_OBBLIGATORIA,'
      '       T282.SELEZIONE_ANAGRAFICA, '
      
        '       i060f_nominativo(t000f_getaziendacorrente(),T282.MITTENTE' +
        ') D_MITTENTE,'
      '       nvl(T282R.D_RISPOSTE_TOT,0) D_RISPOSTE_TOT,'
      '       T_DEST.PROGRESSIVO,'
      '       T_DEST.DATA_RICEZIONE,'
      '       T_DEST.DATA_LETTURA,'
      '       nvl(T283.D_ALLEGATI,0) D_ALLEGATI'
      'from   T282_MESSAGGI T282,'
      '       (select ID_ORIGINALE, count(*) D_RISPOSTE_TOT'
      '        from   T282_MESSAGGI'
      '        group by ID_ORIGINALE) T282R,'
      '       T284_DESTINATARI T_DEST,'
      '       (select ID, count(*) D_ALLEGATI'
      '        from   T283_ALLEGATI'
      '        group by ID ) T283'
      'where  T_DEST.ID = T282.ID'
      'and    T_DEST.PROGRESSIVO = :PROGRESSIVO '
      'and    T282R.ID_ORIGINALE (+) = T282.ID'
      'and    T283.ID (+) = T282.ID'
      ':FILTRO_VIS'
      '--order by T_DEST.DATA_LETTURA nulls first, T282.ID desc'
      
        'order by decode(T_DEST.DATA_LETTURA,null,to_number(null),T282.ID' +
        ') desc nulls first, T282.ID desc')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A00460049004C0054005200
      4F005F00560049005300010000000000000000000000}
    CommitOnPost = False
    AfterOpen = selT282RicevutiAfterOpen
    AfterScroll = selT282RicevutiAfterScroll
    OnCalcFields = selT282InviatiCalcFields
    Left = 125
    Top = 16
    object selT282RicevutiDATA_LETTURA: TDateTimeField
      DisplayLabel = 'Letto'
      FieldName = 'DATA_LETTURA'
    end
    object selT282RicevutiLETTURA_OBBLIGATORIA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Lettura obbligatoria'
      FieldName = 'LETTURA_OBBLIGATORIA'
      Size = 1
    end
    object selT282RicevutiD_MITTENTE: TStringField
      DisplayLabel = 'Mittente'
      FieldName = 'D_MITTENTE'
      Size = 61
    end
    object selT282RicevutiD_STATO: TStringField
      DisplayLabel = 'Stato'
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object selT282RicevutiRICEVENTE: TStringField
      DisplayLabel = 'Ricevente'
      FieldName = 'RICEVENTE'
      Size = 30
    end
    object selT282RicevutiDATA_INVIO: TDateTimeField
      DisplayLabel = 'Data invio'
      FieldName = 'DATA_INVIO'
    end
    object selT282RicevutiOGGETTO: TStringField
      DisplayLabel = 'Oggetto'
      FieldName = 'OGGETTO'
      Size = 200
    end
    object selT282RicevutiTESTO: TStringField
      DisplayLabel = 'Testo'
      FieldName = 'TESTO'
      Size = 4000
    end
    object selT282RicevutiPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT282RicevutiD_ALLEGATI: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Allegati'
      FieldName = 'D_ALLEGATI'
    end
    object selT282RicevutiSELEZIONE_ANAGRAFICA: TStringField
      FieldName = 'SELEZIONE_ANAGRAFICA'
    end
    object selT282RicevutiID: TFloatField
      FieldName = 'ID'
    end
    object selT282RicevutiSTATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object selT282RicevutiMITTENTE: TStringField
      FieldName = 'MITTENTE'
      Size = 30
    end
    object selT282RicevutiDATA_RICEZIONE: TDateTimeField
      DisplayLabel = 'Data ricezione'
      FieldName = 'DATA_RICEZIONE'
    end
    object selT282RicevutiID_ORIGINALE: TFloatField
      DisplayLabel = 'ID orig.'
      FieldName = 'ID_ORIGINALE'
      ReadOnly = True
    end
    object selT282RicevutiD_RISPOSTE_TOT: TFloatField
      FieldName = 'D_RISPOSTE_TOT'
      Visible = False
    end
  end
  object updT284Lettura: TOracleQuery
    SQL.Strings = (
      'update T284_DESTINATARI'
      'set    DATA_LETTURA = :DATA_LETTURA'
      'where  ID = :ID'
      'and    PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001A00
      00003A0044004100540041005F004C004500540054005500520041000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 176
    Top = 208
  end
  object updT284Ricezione: TOracleQuery
    SQL.Strings = (
      'update T284_DESTINATARI'
      'set    DATA_RICEZIONE = :DATA_RICEZIONE'
      'where  ID = :ID'
      'and    PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001800
      00003A00500052004F0047005200450053005300490056004F00030000000000
      0000000000001E0000003A0044004100540041005F0052004900430045005A00
      49004F004E0045000C0000000000000000000000}
    Left = 273
    Top = 208
  end
  object selT285: TOracleDataSet
    SQL.Strings = (
      'select T285.*, T285.ROWID'
      'from   T285_UTENTI_DEST T285'
      'where  T285.ID = :ID'
      'order by T285.UTENTE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    AfterOpen = selT285AfterOpen
    Left = 32
    Top = 272
  end
  object selOperatori: TOracleDataSet
    SQL.Strings = (
      'select distinct UTENTE'
      'from   MONDOEDP.I070_UTENTI I070,'
      '       MONDOEDP.I073_FILTROFUNZIONI I073'
      'where  I070.AZIENDA = t000f_getaziendacorrente()'
      'and    I073.AZIENDA = I070.AZIENDA'
      'and    I073.PROFILO = I070.FILTRO_FUNZIONI'
      'and    I073.TAG = :TAG'
      'and    I073.INIBIZIONE in ('#39'S'#39','#39'R'#39')'
      'minus'
      'select NOME_UTENTE '
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE'
      'where  AZIENDA = t000f_getaziendacorrente()'
      'order by UTENTE')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A00540041004700030000000000000000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 101
    Top = 80
  end
  object selT282RicevutiOper: TOracleDataSet
    SQL.Strings = (
      'SELECT T282.ROWID,'
      '       T282.ID,'
      '       T282.STATO,'
      '       T282.DATA_INVIO,'
      '       T282.MITTENTE, '
      '       T282.RICEVENTE,'
      '       T282.ID_ORIGINALE,'
      '       T282.OGGETTO, '
      '       T282.TESTO,'
      '       T282.LETTURA_OBBLIGATORIA,'
      '       T282.SELEZIONE_ANAGRAFICA, '
      
        '       i060f_nominativo(t000f_getaziendacorrente(),T282.MITTENTE' +
        ') D_MITTENTE,'
      '       nvl(T282R.D_RISPOSTE_TOT,0) D_RISPOSTE_TOT,'
      '       T_DEST.UTENTE,'
      '       T_DEST.DATA_RICEZIONE,'
      '       T_DEST.DATA_LETTURA,'
      '       nvl(T283.D_ALLEGATI,0) D_ALLEGATI'
      'from   T282_MESSAGGI T282,'
      '       (select ID_ORIGINALE, count(*) D_RISPOSTE_TOT'
      '        from   T282_MESSAGGI'
      '        group by ID_ORIGINALE) T282R,       '
      '       T285_UTENTI_DEST T_DEST,'
      '       (select ID, count(*) D_ALLEGATI'
      '        from   T283_ALLEGATI'
      '        group by ID ) T283'
      'where  T_DEST.ID = T282.ID'
      'and    T_DEST.UTENTE = :UTENTE'
      'and    T282R.ID_ORIGINALE (+) = T282.ID'
      'and    T283.ID(+) = T282.ID'
      ':FILTRO_VIS'
      '--order by T_DEST.DATA_LETTURA nulls first, T282.ID desc'
      
        'order by decode(T_DEST.DATA_LETTURA,null,to_number(null),T282.ID' +
        ') desc nulls first, T282.ID desc')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A00460049004C00540052004F005F0056004900
      53000100000000000000000000000E0000003A005500540045004E0054004500
      050000000000000000000000}
    CommitOnPost = False
    AfterOpen = selT282RicevutiAfterOpen
    AfterScroll = selT282RicevutiAfterScroll
    OnCalcFields = selT282InviatiCalcFields
    Left = 237
    Top = 16
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Letto'
      FieldName = 'DATA_LETTURA'
    end
    object selT282RicevutiOperLETTURA_OBBLIGATORIA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Lettura obbligatoria'
      FieldName = 'LETTURA_OBBLIGATORIA'
      Size = 1
    end
    object StringField1: TStringField
      DisplayLabel = 'Mittente'
      FieldName = 'D_MITTENTE'
      Size = 61
    end
    object StringField2: TStringField
      DisplayLabel = 'Stato'
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object selT282RicevutiOperRICEVENTE: TStringField
      DisplayLabel = 'Ricevente'
      FieldName = 'RICEVENTE'
      Size = 30
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'Data invio'
      FieldName = 'DATA_INVIO'
    end
    object StringField3: TStringField
      DisplayLabel = 'Oggetto'
      FieldName = 'OGGETTO'
      Size = 200
    end
    object StringField4: TStringField
      DisplayLabel = 'Testo'
      FieldName = 'TESTO'
      Size = 4000
    end
    object selT282RicevutiOperUTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Size = 30
    end
    object FloatField1: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Allegati'
      FieldName = 'D_ALLEGATI'
    end
    object StringField5: TStringField
      FieldName = 'SELEZIONE_ANAGRAFICA'
    end
    object FloatField2: TFloatField
      FieldName = 'ID'
    end
    object StringField6: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object StringField7: TStringField
      FieldName = 'MITTENTE'
      Size = 30
    end
    object DateTimeField3: TDateTimeField
      DisplayLabel = 'Data ricezione'
      FieldName = 'DATA_RICEZIONE'
    end
    object selT282RicevutiOperID_ORIGINALE: TFloatField
      DisplayLabel = 'ID orig.'
      FieldName = 'ID_ORIGINALE'
      ReadOnly = True
    end
    object selT282RicevutiOperD_RISPOSTE_TOT: TFloatField
      FieldName = 'D_RISPOSTE_TOT'
      Visible = False
    end
  end
  object updT285Lettura: TOracleQuery
    SQL.Strings = (
      'update T285_UTENTI_DEST'
      'set    DATA_LETTURA = :DATA_LETTURA'
      'where  ID = :ID'
      'and    UTENTE = :UTENTE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001A00
      00003A0044004100540041005F004C004500540054005500520041000C000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 176
    Top = 272
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      
        'select I060.NOME_UTENTE, T030.COGNOME, T030.NOME, T030.MATRICOLA' +
        ', T030.PROGRESSIVO'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = t000f_getaziendacorrente()'
      'and    I060.NOME_UTENTE = :UTENTE'
      'and    I060.MATRICOLA = T030.MATRICOLA (+)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    ReadOnly = True
    CommitOnPost = False
    AfterOpen = selT284AfterOpen
    Left = 176
    Top = 80
  end
  object updT285Ricezione: TOracleQuery
    SQL.Strings = (
      'update T285_UTENTI_DEST'
      'set    DATA_RICEZIONE = :DATA_RICEZIONE'
      'where  ID = :ID'
      'and    UTENTE = :UTENTE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001E00
      00003A0044004100540041005F0052004900430045005A0049004F004E004500
      0C00000000000000000000000E0000003A005500540045004E00540045000500
      00000000000000000000}
    Left = 273
    Top = 272
  end
  object selElencoMsg: TOracleDataSet
    SQL.Strings = (
      'select LEVEL, '
      '       T282.*,'
      
        '       i060f_nominativo(t000f_getaziendacorrente(),MITTENTE) D_M' +
        'ITTENTE,'
      '       decode(T282.RICEVENTE,null,null,'#39'('#39'||T282.RICEVENTE||'#39')'#39')'
      '       ||'
      
        '       concatena_testo('#39' select T030.COGNOME || '#39#39' '#39#39' || T030.NO' +
        'ME '#39' ||'
      
        '                       '#39' from   T284_DESTINATARI T284, T030_ANAG' +
        'RAFICO T030 '#39' ||'
      '                       '#39' where  T284.ID = '#39' || T282.ID || '
      
        '                       '#39' and    T284.PROGRESSIVO = T030.PROGRESS' +
        'IVO'#39' ||'
      '                       '#39' union all'#39' ||'
      '                       '#39' select T285.UTENTE '#39' ||'
      '                       '#39' from   T285_UTENTI_DEST T285 '#39' ||'
      '                       '#39' where T285.ID = '#39' || T282.ID,'#39','#39') '
      '       D_DESTINATARI'
      'from   T282_MESSAGGI T282'
      'where  STATO = '#39'I'#39
      'connect by prior T282.ID = T282.ID_ORIGINALE'
      'start with T282.ID = (select ID'
      '                      from   T282_MESSAGGI T282B'
      '                      where  T282B.ID_ORIGINALE is null'
      
        '                      connect by prior T282B.ID_ORIGINALE = T282' +
        'B.ID'
      '                      start with T282B.ID = :ID)')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 273
    Top = 80
    object selElencoMsgLEVEL: TFloatField
      FieldName = 'LEVEL'
      Visible = False
    end
    object selElencoMsgID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selElencoMsgID_ORIGINALE: TFloatField
      FieldName = 'ID_ORIGINALE'
      Visible = False
    end
    object selElencoMsgOGGETTO: TStringField
      DisplayLabel = 'Oggetto'
      FieldName = 'OGGETTO'
      Size = 200
    end
    object selElencoMsgDATA_INVIO: TDateTimeField
      DisplayLabel = 'Inviato'
      FieldName = 'DATA_INVIO'
      DisplayFormat = 'dd/mm/yyyy hhhh.mm'
    end
    object selElencoMsgSTATO: TStringField
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selElencoMsgMITTENTE: TStringField
      DisplayLabel = 'Mittente'
      FieldName = 'MITTENTE'
      Visible = False
      Size = 30
    end
    object selElencoMsgD_MITTENTE: TStringField
      DisplayLabel = 'Mittente'
      FieldName = 'D_MITTENTE'
      Size = 61
    end
    object selElencoMsgD_DESTINATARI: TStringField
      DisplayLabel = 'Destinatari'
      FieldName = 'D_DESTINATARI'
      Size = 50
    end
    object selElencoMsgTESTO: TStringField
      DisplayLabel = 'Testo'
      FieldName = 'TESTO'
      Visible = False
      Size = 4000
    end
  end
  object delT285: TOracleQuery
    SQL.Strings = (
      'delete from T285_UTENTI_DEST '
      'where  ID = :ID'
      'and    DATA_RICEZIONE is null')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 101
    Top = 272
  end
end
