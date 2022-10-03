object W032FRichiestaMissioniDM: TW032FRichiestaMissioniDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 620
  Width = 749
  object selM020Mezzi: TOracleDataSet
    SQL.Strings = (
      'select M020.*'
      'from   M020_TIPIRIMBORSI M020'
      'where  M020.TIPO = '#39'MEZZO'#39
      'order by M020.CODICE')
    ReadBuffer = 50
    Optimize = False
    ReadOnly = True
    Left = 177
    Top = 72
  end
  object selM140: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A0041005A00490045004E004400410005000000
      00000000000000001A0000003A005100560049005300540041004F0052004100
      43004C004500010000000000000000000000160000003A004400410054004100
      4C00410056004F0052004F000C0000000000000000000000180000003A004600
      49004C00540052004F005F0041004E0041004700010000000000000000000000
      2E0000003A00460049004C00540052004F005F00560049005300550041004C00
      49005A005A0041005A0049004F004E0045000100000000000000000000001E00
      00003A00460049004C00540052004F005F0050004500520049004F0044004F00
      010000000000000000000000}
    SequenceField.Field = 'PROTOCOLLO'
    SequenceField.Sequence = 'M140_PROTOCOLLO'
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    AfterOpen = selM140AfterOpen
    BeforePost = selM140BeforePost
    AfterPost = selM140AfterPost
    OnCalcFields = selM140CalcFields
    OnFilterRecord = selM140FilterRecord
    Left = 32
    Top = 16
    object selM140ID: TFloatField
      FieldName = 'ID'
    end
    object selM140ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selM140ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selM140PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selM140NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selM140MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selM140SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selM140COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selM140TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selM140AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selM140REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selM140DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
    end
    object selM140LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selM140FASE_CORRENTE: TFloatField
      FieldName = 'FASE_CORRENTE'
    end
    object selM140AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selM140NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object selM140AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selM140AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selM140RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selM140AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selM140AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selM140D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selM140D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selM140D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selM140PROTOCOLLO: TStringField
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object selM140TIPOREGISTRAZIONE: TStringField
      FieldName = 'TIPOREGISTRAZIONE'
      Size = 5
    end
    object selM140FLAG_DESTINAZIONE: TStringField
      FieldName = 'FLAG_DESTINAZIONE'
      Size = 1
    end
    object selM140FLAG_ISPETTIVA: TStringField
      FieldName = 'FLAG_ISPETTIVA'
      Size = 1
    end
    object selM140DATADA: TDateTimeField
      FieldName = 'DATADA'
    end
    object selM140DATAA: TDateTimeField
      FieldName = 'DATAA'
    end
    object selM140ORADA: TStringField
      FieldName = 'ORADA'
      Size = 5
    end
    object selM140ORAA: TStringField
      FieldName = 'ORAA'
      Size = 5
    end
    object selM140FLAG_TIPOACCREDITO: TStringField
      FieldName = 'FLAG_TIPOACCREDITO'
      Size = 1
    end
    object selM140DELEGATO: TStringField
      FieldName = 'DELEGATO'
      Size = 100
    end
    object selM140ANNULLAMENTO: TStringField
      FieldName = 'ANNULLAMENTO'
      Size = 40
    end
    object selM140PARTENZA: TStringField
      FieldName = 'PARTENZA'
      Size = 200
    end
    object selM140ELENCO_DESTINAZIONI: TStringField
      DisplayLabel = 'Elenco destinazioni'
      DisplayWidth = 20
      FieldName = 'ELENCO_DESTINAZIONI'
      Size = 2000
    end
    object selM140RIENTRO: TStringField
      FieldName = 'RIENTRO'
      Size = 200
    end
    object selM140FLAG_PERCORSO: TStringField
      DisplayLabel = 'Flag percorso'
      FieldName = 'FLAG_PERCORSO'
      Size = 10
    end
    object selM140F1_RESP: TStringField
      FieldKind = fkCalculated
      FieldName = 'F1_RESP'
      Size = 40
      Calculated = True
    end
    object selM140F1_STATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'F1_STATO'
      Size = 1
      Calculated = True
    end
    object selM140F4_RESP: TStringField
      FieldKind = fkCalculated
      FieldName = 'F4_RESP'
      Size = 40
      Calculated = True
    end
    object selM140F4_STATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'F4_STATO'
      Size = 1
      Calculated = True
    end
    object selM140C_DESTINAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_DESTINAZIONE'
      Calculated = True
    end
    object selM140C_ISPETTIVA: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_ISPETTIVA'
      Size = 2
      Calculated = True
    end
    object selM140C_RIMBORSI: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_RIMBORSI'
      Size = 1
      Calculated = True
    end
    object selM140C_TIPOREGISTRAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TIPOREGISTRAZIONE'
      Size = 40
      Calculated = True
    end
    object selM140C_PERCORSO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_PERCORSO'
      Size = 500
      Calculated = True
    end
    object selM140MISSIONE_RIAPERTA: TStringField
      FieldName = 'MISSIONE_RIAPERTA'
      Size = 1
    end
    object selM140PROTOCOLLO_MANUALE: TStringField
      DisplayLabel = 'Autorizzazione cartacea'
      FieldName = 'PROTOCOLLO_MANUALE'
      Size = 1
    end
    object selM140C_PROTOCOLLO_MANUALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_PROTOCOLLO_MANUALE'
      Size = 2
      Calculated = True
    end
  end
  object selM020Anticipi: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   M020_TIPIRIMBORSI'
      'where  FLAG_ANTICIPO = '#39'S'#39
      ':FILTRO_CODICI'
      ':FILTRO'
      'order by DESCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      0000000000001C0000003A00460049004C00540052004F005F0043004F004400
      490043004900010000000000000000000000}
    ReadOnly = True
    OnFilterRecord = selM020AnticipiFilterRecord
    Left = 105
    Top = 192
  end
  object selM025: TOracleDataSet
    SQL.Strings = (
      'select m024.ordine ordine_cat,'
      '       m024.descrizione descrizione_cat,'
      '       m024.min_fase_visibile min_fase_visibile_cat,'
      '       m024.max_fase_visibile max_fase_visibile_cat,'
      '       m024.min_fase_modifica min_fase_modifica_cat,'
      '       m024.max_fase_modifica max_fase_modifica_cat,'
      '       m025.ordine, '
      '       m025.categoria,'
      '       m025.codice, '
      '       m025.descrizione, '
      '       m025.valori, '
      '       m025.obbligatorio, '
      '       m025.righe,'
      '       m025.formato,'
      '       m025.lung_max,'
      '       m025.dato_anagrafico,'
      '       m025.query_valore,'
      '       m025.elenco_fisso,'
      '       m025.valore_default'
      'from   m025_motivazioni m025,'
      '       m024_categ_dati_liberi m024'
      'where  m024.codice = m025.categoria'
      'order by m024.ordine, m025.categoria, m025.ordine')
    Optimize = False
    ReadOnly = True
    Left = 177
    Top = 128
  end
  object selM175: TOracleDataSet
    SQL.Strings = (
      'select M175.*, M175.ROWID'
      'from   M175_RICHIESTE_MOTIVAZIONI M175'
      'where  M175.ID = :ID'
      'order by M175.CODICE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OnApplyRecord = selM175ApplyRecord
    Left = 32
    Top = 128
  end
  object selM160: TOracleDataSet
    SQL.Strings = (
      'select M160.*, M160.ROWID'
      'from   M160_RICHIESTE_ANTICIPI M160'
      'where  M160.ID = :ID'
      'order by M160.CODICE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    RefreshOptions = [roBeforeEdit, roAllFields]
    OnApplyRecord = selM160ApplyRecord
    CachedUpdates = True
    OnCalcFields = selM160CalcFields
    Left = 31
    Top = 192
    object selM160ID: TFloatField
      FieldName = 'ID'
    end
    object selM160CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object selM160QUANTITA: TFloatField
      FieldName = 'QUANTITA'
    end
    object selM160NOTE: TStringField
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM160C_DESCRIZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_DESCRIZIONE'
      Size = 40
      Calculated = True
    end
    object selM160C_TIPO_QUANTITA: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TIPO_QUANTITA'
      Size = 1
      Calculated = True
    end
    object selM160C_PERC_ANTICIPO: TFloatField
      FieldKind = fkCalculated
      FieldName = 'C_PERC_ANTICIPO'
      Calculated = True
    end
    object selM160C_NOTE_FISSE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_NOTE_FISSE'
      Size = 500
      Calculated = True
    end
  end
  object selM170: TOracleDataSet
    SQL.Strings = (
      'select M170.*, M170.ROWID'
      'from   M170_RICHIESTE_MEZZI M170'
      'where  M170.ID = :ID'
      'order by M170.CODICE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OnApplyRecord = selM170ApplyRecord
    Left = 32
    Top = 72
  end
  object selM150: TOracleDataSet
    SQL.Strings = (
      'select M150.*, M150.ROWID'
      'from   M150_RICHIESTE_RIMBORSI M150'
      'where  M150.ID = :ID'
      'order by M150.INDENNITA_KM, M150.DATA_RIMBORSO, M150.CODICE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OnApplyRecord = selM150ApplyRecord
    CachedUpdates = True
    OnCalcFields = selM150CalcFields
    Left = 31
    Top = 312
    object selM150ID: TFloatField
      FieldName = 'ID'
    end
    object selM150INDENNITA_KM: TStringField
      FieldName = 'INDENNITA_KM'
      Size = 1
    end
    object selM150ID_RIMBORSO: TIntegerField
      FieldName = 'ID_RIMBORSO'
    end
    object selM150DATA_RIMBORSO: TDateTimeField
      FieldName = 'DATA_RIMBORSO'
    end
    object selM150CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object selM150KMPERCORSI: TFloatField
      FieldName = 'KMPERCORSI'
    end
    object selM150KMPERCORSI_VARIATO: TFloatField
      FieldName = 'KMPERCORSI_VARIATO'
    end
    object selM150COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Size = 10
    end
    object selM150RIMBORSO: TFloatField
      FieldName = 'RIMBORSO'
    end
    object selM150RIMBORSO_VARIATO: TFloatField
      FieldName = 'RIMBORSO_VARIATO'
    end
    object selM150NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM150FILE_ALLEGATO: TStringField
      FieldName = 'FILE_ALLEGATO'
      Size = 200
    end
    object selM150STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object selM150C_DESCRIZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_DESCRIZIONE'
      Size = 40
      Calculated = True
    end
    object selM150AUTOMATICO: TStringField
      FieldName = 'AUTOMATICO'
      Size = 1
    end
    object selM150C_TIPO_QUANTITA: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TIPO_QUANTITA'
      Size = 1
      Calculated = True
    end
  end
  object selM020Rimborsi: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   M020_TIPIRIMBORSI'
      'where  FLAG_ANTICIPO = '#39'N'#39
      ':FILTRO_CODICI'
      ':FILTRO'
      'order by DESCRIZIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      0000000000001C0000003A00460049004C00540052004F005F0043004F004400
      490043004900010000000000000000000000}
    ReadOnly = True
    OnFilterRecord = selM020RimborsiFilterRecord
    Left = 105
    Top = 312
  end
  object selM021: TOracleDataSet
    SQL.Strings = (
      'select M021.*'
      'from   M021_TIPIINDENNITAKM M021'
      'where  trunc(:DATA) between DECORRENZA and DECORRENZA_FINE'
      ':FILTRO_CODICI'
      ':FILTRO'
      'order by M021.DESCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000
      1C0000003A00460049004C00540052004F005F0043004F004400490043004900
      010000000000000000000000}
    ReadOnly = True
    Left = 241
    Top = 72
  end
  object selP030: TOracleDataSet
    SQL.Strings = (
      'select P030.*'
      'from   P030_VALUTE P030'
      'where  :DATA between DECORRENZA and DECORRENZA_FINE'
      'order by P030.COD_VALUTA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    ReadOnly = True
    OnFilterRecord = selM020AnticipiFilterRecord
    Left = 601
    Top = 72
  end
  object selM010: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   M010_PARAMETRICONTEGGIO'
      'where  DECORRENZA = (select max(decorrenza) '
      '                     from   M010_PARAMETRICONTEGGIO'
      '                     where  DECORRENZA <= :DECORRENZA '
      '                     and    TIPO_MISSIONE = :TIPOREGISTRAZIONE'
      '                     and    CODICE = :CODICE)'
      'and    TIPO_MISSIONE = :TIPOREGISTRAZIONE'
      'and    CODICE = :CODICE')
    ReadBuffer = 40
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000240000003A005400490050004F0052004500
      4700490053005400520041005A0049004F004E00450005000000000000000000
      00000E0000003A0043004F004400490043004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001C000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002A0000004F00520045004D0049004E0049004D00450050004500
      520049004E00440045004E004E00490054004100010000000000320000004C00
      49004D004900540045004F005200450052004500540052004900420055004900
      5400450049004E00540045005200450001000000000022000000410052005200
      4F0054004F004E00440041004D0045004E0054004F004F005200450001000000
      0000260000005000450052004300520045005400520049004200530055005000
      450052004F004F0052004500010000000000220000004D004100580047004900
      4F0052004E00490052004500540052004D004500530045000100000000002400
      0000500045005200430052004500540052004900420053005500500045005200
      4F0047004700010000000000320000004100520052004F005400540041005200
      490046004600410044004F0050004F0052004900440055005A0049004F004E00
      4500010000000000300000004100520052004F00540054004F00540049004D00
      50004F0052005400490044004100540049005000410047004800450001000000
      0000080000005400490050004F000100000000001E0000005200490044005500
      5A0049004F004E0045005F0050004100530054004F000100000000001E000000
      500045005200430052004500540052004900420050004100530054004F000100
      000000000C00000043004F0044004900430045000100000000001A0000005400
      490050004F005F004D0049005300530049004F004E0045000100000000002000
      0000540041005200490046004600410049004E00440045004E004E0049005400
      4100010000000000180000005400490050004F005F0054004100520049004600
      460041000100000000002200000043004F00440056004F004300450050004100
      470048004500530055005000480048000100000000002200000043004F004400
      56004F0043004500500041004700480045005300550050004700470001000000
      00002000000043004F004400520049004D0042004F00520053004F0050004100
      530054004F00010000000000200000004F0052004500520049004D0042004F00
      520053004F0050004100530054004F0001000000000028000000540041005200
      4900460046004100520049004D0042004F00520053004F005000410053005400
      4F00010000000000220000004F0052004500520049004D0042004F0052005300
      4F0050004100530054004F0032000100000000002A0000005400410052004900
      460046004100520049004D0042004F00520053004F0050004100530054004F00
      32000100000000002400000043004F00440056004F0043004500500041004700
      4800450049004E0054004500520041000100000000002600000043004F004400
      56004F0043004500500041004700480045005300550050004800480047004700
      0100000000002400000043004F0044004900430049005F0049004E0044004500
      4E004E004900540041004B004D000100000000001E00000043004F0044004900
      430049005F00520049004D0042004F00520053004900010000000000}
    ReadOnly = True
    Left = 598
    Top = 16
  end
  object selNomeDelegato: TOracleDataSet
    SQL.Strings = (
      'select T030.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, T030.NOME'
      'from   T030_ANAGRAFICO T030'
      'where  (:MATRICOLA = '#39'S'#39' and '
      '        T030.MATRICOLA = :VALORE) or'
      '       (:MATRICOLA = '#39'N'#39' and'
      '        ((T030.MATRICOLA like '#39'%'#39' || :VALORE || '#39'%'#39' or'
      '        upper(T030.COGNOME) like '#39'%'#39' || upper(:VALORE) || '#39'%'#39')))'
      
        'and exists (select '#39'x'#39' from T430_STORICO where PROGRESSIVO = T03' +
        '0.PROGRESSIVO and trunc(sysdate) between INIZIO and nvl(FINE,sys' +
        'date))'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00560041004C004F0052004500050000000000
      000000000000140000003A004D00410054005200490043004F004C0041000500
      00000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    Left = 681
    Top = 72
  end
  object M040P_CARICA_MISSIONE_DAITER: TOracleQuery
    SQL.Strings = (
      'begin'
      '   M040P_CARICA_MISSIONE_DAITER(:ID);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 149
    Top = 16
  end
  object M060P_CARICA_ANTICIPI_DAITER: TOracleQuery
    SQL.Strings = (
      'begin'
      '  M060P_CARICA_ANTICIPI_DAITER(:ID);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 105
    Top = 248
  end
  object M050P_CARICA_RIMBORSI_DAITER: TOracleQuery
    SQL.Strings = (
      'begin'
      '  M050P_CARICA_RIMBORSI_DAITER(:ID );'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 106
    Top = 376
  end
  object delM040: TOracleQuery
    SQL.Strings = (
      'begin'
      '  if :ANNULLAMENTO = '#39'S'#39' then'
      '    delete from M040_MISSIONI '
      '    where ID_MISSIONE = :ID'
      
        '    and not exists (select '#39'x'#39' from M060_ANTICIPI where ID_MISSI' +
        'ONE = :ID);'
      '  else'
      '    delete from M040_MISSIONI where ID_MISSIONE = :ID;'
      '  end if;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001A00
      00003A0041004E004E0055004C004C0041004D0045004E0054004F0005000000
      0000000000000000}
    BeforeQuery = delM040BeforeQuery
    AfterQuery = delM040AfterQuery
    Left = 261
    Top = 16
  end
  object delM060: TOracleQuery
    SQL.Strings = (
      'delete from M060_ANTICIPI where ID_MISSIONE = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 220
    Top = 248
  end
  object delRimborsi: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete from M050_RIMBORSI where ID_MISSIONE = :ID;'
      '  delete from M052_INDENNITAKM where ID_MISSIONE = :ID;'
      '  delete from M043_DETTAGLIOGG where ID = :ID;'
      '  delete from T040_GIUSTIFICATIVI where ID_RICHIESTA = :ID;'
      '  update M040_MISSIONI set STATO = '#39'S'#39' where ID_MISSIONE = :ID; '
      'exception'
      '  when others then'
      '    raise;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 231
    Top = 376
  end
  object P050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.COD_ARROTONDAMENTO, T.COD_VALUTA, T.DECORRENZA, T.DESCR' +
        'IZIONE, T.VALORE, T.TIPO'
      'FROM P050_ARROTONDAMENTI T'
      'WHERE COD_ARROTONDAMENTO = :CODICE '
      '  AND T.DECORRENZA = (SELECT MAX(A.DECORRENZA) '
      '                        FROM P050_ARROTONDAMENTI A '
      '                       WHERE A.DECORRENZA <= :DECORRENZA '
      
        '                         AND A.COD_ARROTONDAMENTO = T.COD_ARROTO' +
        'NDAMENTO)')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C00000000000000000000000E0000003A0043004F004400490043004500
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000}
    ReadOnly = True
    Left = 177
    Top = 312
    object P050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object P050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object P050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object P050DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object P050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object P050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object M013F_CALC_RIMB_PASTO: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :RESULT:=m013f_calc_rimb_pasto(:TIPORISULTATO,:CODICE,:TIPOREG' +
        'ISTRAZIONE,:DATADA,:DATAA,:ORADA,:ORAA);'
      'exception'
      '  when others then'
      '    :RESULT:=-1;'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000080000000E0000003A0043004F004400490043004500050000000000
      000000000000240000003A005400490050004F00520045004700490053005400
      520041005A0049004F004E0045000500000000000000000000000E0000003A00
      4400410054004100440041000C00000000000000000000000C0000003A004400
      41005400410041000C00000000000000000000000C0000003A004F0052004100
      440041000500000000000000000000000A0000003A004F005200410041000500
      000000000000000000000E0000003A0052004500530055004C00540004000000
      00000000000000001C0000003A005400490050004F0052004900530055004C00
      5400410054004F00050000000000000000000000}
    Left = 512
    Top = 312
  end
  object selCountM143M150: TOracleQuery
    SQL.Strings = (
      'select count(*) from ('
      '  select '#39'x'#39' from M143_DETTAGLIOGG'
      '  where  ID = :ID'
      '  union all'
      '  select '#39'x'#39' from M150_RICHIESTE_RIMBORSI'
      '  where  ID = :ID'
      '  and    AUTOMATICO <> '#39'S'#39
      ')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000002600
      00003A00460049004C00540052004F005F0049004E0044005F004B004D005F00
      4100550054004F00010000000000000000000000}
    Left = 111
    Top = 440
  end
  object updM150: TOracleQuery
    SQL.Strings = (
      'update M150_RICHIESTE_RIMBORSI'
      'set    :SETVALORI'
      'where  ID = :ID'
      'and    nvl(STATO,'#39'A'#39') <> '#39'I'#39' -- verificare')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001400
      00003A00530045005400560041004C004F005200490001000000000000000000
      0000}
    Left = 288
    Top = 376
  end
  object selM040: TOracleQuery
    SQL.Strings = (
      'select STATO '
      'from   M040_MISSIONI'
      'where  ID_MISSIONE = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 421
    Top = 16
  end
  object selT106: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   T106_MOTIVAZIONIRICHIESTE'
      'where  TIPO = '#39'M140'#39
      'order by DESCRIZIONE')
    Optimize = False
    ReadOnly = True
    OnFilterRecord = selM020AnticipiFilterRecord
    Left = 601
    Top = 128
  end
  object M150F_FILTRORIMBORSI: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :RESULT:=M150F_FILTRORIMBORSI(:ID);'
      '  if :RESULT = '#39'L'#39' then'
      
        '    select max(MESESCARICO) into :MESESCARICO from M040_MISSIONI' +
        ' where ID_MISSIONE = :ID;'
      '  end if;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000000E00
      00003A0052004500530055004C00540005000000020000004E00000000001800
      00003A004D004500530045005300430041005200490043004F000C0000000000
      000000000000}
    Left = 512
    Top = 376
  end
  object selM011: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   M011_TIPOMISSIONE'
      'where  M011F_FILTROITER(CODICE, :REGOLA, :ID) = '#39'S'#39' '
      'order by CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A005200450047004F004C004100050000000000
      000000000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Filtered = True
    OnFilterRecord = selM011FilterRecord
    Left = 601
    Top = 192
  end
  object selM143: TOracleDataSet
    SQL.Strings = (
      'select M143.*, M143.ROWID'
      'from   M143_DETTAGLIOGG M143'
      'where  M143.ID = :ID'
      'order by M143.DATA, M143.DALLE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OnApplyRecord = selM143ApplyRecord
    CachedUpdates = True
    OnCalcFields = selM150CalcFields
    Left = 31
    Top = 440
    object selM143ID: TFloatField
      FieldName = 'ID'
    end
    object selM143TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object selM143DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selM143DALLE: TStringField
      FieldName = 'DALLE'
      Size = 5
    end
    object selM143ALLE: TStringField
      FieldName = 'ALLE'
      Size = 5
    end
    object selM143NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  object selFiltroM020: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   USER_PROCEDURES'
      'WHERE  UPPER(OBJECT_NAME) = '#39'USR_M020M021F_FILTROITER'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 541
    Top = 16
  end
  object selQueryValore: TOracleQuery
    SQL.Strings = (
      
        'select concatena_testo('#39'select riga from t002_querypersonalizzat' +
        'e where nome = '#39#39#39' || :nome || '#39#39#39' and applicazione = '#39#39'RILPRE'#39#39 +
        ' and posiz >= 0 order by posiz'#39','#39' '#39') '
      'from   dual')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 31
    Top = 568
  end
  object USR_M140F_MSG_PERIODO_INVALIDO: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :result:=USR_M140F_MSG_PERIODO_INVALIDO(:PROGRESSIVO,:DATADA,:' +
        'ORADA,:DATAA,:ORAA);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A0052004500530055004C005400050000000000
      000000000000180000003A00500052004F004700520045005300530049005600
      4F000300000000000000000000000E0000003A00440041005400410044004100
      0C00000000000000000000000C0000003A004F00520041004400410005000000
      00000000000000000C0000003A00440041005400410041000C00000000000000
      000000000A0000003A004F00520041004100050000000000000000000000}
    Left = 368
    Top = 72
  end
  object selCountAnticipi: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   M020_TIPIRIMBORSI'
      'WHERE  FLAG_ANTICIPO = '#39'S'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 442
    Top = 128
  end
  object selM041Localita: TOracleDataSet
    SQL.Strings = (
      
        'select M041.TIPO1 TIPO, M041.LOCALITA1 CODICE, T480.CITTA DESCRI' +
        'ZIONE'
      'from   M041_DISTANZE M041,'
      '       T480_COMUNI T480'
      'where  M041.TIPO1 = '#39'C'#39
      'and    T480.CODICE = M041.LOCALITA1'
      'union'
      'select M041.TIPO1, M041.LOCALITA1, M042.DESCRIZIONE'
      'from   M041_DISTANZE M041,'
      '       M042_LOCALITA M042'
      'where  M041.TIPO1 = '#39'P'#39
      'and    M041.LOCALITA1 = M042.CODICE'
      'union'
      
        'select M041.TIPO2 TIPO, M041.LOCALITA2 CODICE, T480.CITTA DESCRI' +
        'ZIONE'
      'from   M041_DISTANZE M041,'
      '       T480_COMUNI T480'
      'where  M041.TIPO2 = '#39'C'#39
      'and    T480.CODICE = M041.LOCALITA2'
      'union'
      'select M041.TIPO2, M041.LOCALITA2, M042.DESCRIZIONE'
      'from   M041_DISTANZE M041,'
      '       M042_LOCALITA M042'
      'where  M041.TIPO2 = '#39'P'#39
      'and    M041.LOCALITA2 = M042.CODICE'
      'order by 3')
    ReadBuffer = 500
    Optimize = False
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    Left = 31
    Top = 504
  end
  object selM041: TOracleDataSet
    SQL.Strings = (
      'select M041.*, M041.ROWID'
      'from   M041_DISTANZE M041'
      '')
    ReadBuffer = 100
    Optimize = False
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    Left = 215
    Top = 504
  end
  object M150P_INDKM_AUTO: TOracleQuery
    SQL.Strings = (
      'begin'
      '  M150P_INDKM_AUTO(:ID,:INDKM, :CODREGOLA);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000000C00
      00003A0049004E0044004B004D00050000000000000000000000140000003A00
      43004F0044005200450047004F004C004100050000000000000000000000}
    Left = 317
    Top = 504
  end
  object selP150: TOracleQuery
    SQL.Strings = (
      
        'select T480.CODICE, T481.COD_PROVINCIA, T482.COD_REGIONE, T480.C' +
        'ITTA'
      'from   P150_SETUP P150,'
      '       T480_COMUNI T480,'
      '       T481_PROVINCE T481,'
      '       T482_REGIONI T482'
      
        'where  trunc(sysdate) BETWEEN P150.DECORRENZA AND P150.DECORRENZ' +
        'A_FINE'
      'and    P150.COD_COMUNE_INAIL = T480.CODCATASTALE'
      'and    T480.PROVINCIA = T481.COD_PROVINCIA'
      'and    T481.COD_REGIONE = T482.COD_REGIONE')
    ReadBuffer = 2
    Optimize = False
    Left = 415
    Top = 504
  end
  object selT480ComuneDest: TOracleQuery
    SQL.Strings = (
      'select T480.CODICE, T481.COD_PROVINCIA, T482.COD_REGIONE'
      'from   T480_COMUNI T480,'
      '       T481_PROVINCE T481,'
      '       T482_REGIONI T482'
      'where  T480.CODICE = :CODICE'
      'and    T480.PROVINCIA = T481.COD_PROVINCIA'
      'and    T481.COD_REGIONE = T482.COD_REGIONE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 494
    Top = 504
  end
  object selCountDatiPers: TOracleQuery
    SQL.Strings = (
      'select count(m025.codice)'
      'from   m025_motivazioni m025,'
      '       m024_categ_dati_liberi m024'
      'where  m025.categoria = m024.codice'
      'and    m024.ordine > 0')
    ReadBuffer = 2
    Optimize = False
    Left = 530
    Top = 128
  end
  object selDatoSede: TOracleQuery
    SQL.Strings = (
      
        'select T480.CODICE, T481.COD_PROVINCIA, T482.COD_REGIONE, T480.C' +
        'ITTA'
      'from   T430_STORICO T430,'
      '       T480_COMUNI T480,'
      '       T481_PROVINCE T481,'
      '       T482_REGIONI T482'
      'where  T430.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATARIF between T430.DATADECORRENZA and T430.DATAFINE'
      'and    T430.:DATOSEDE = T480.CODICE'
      'and    T480.PROVINCIA = T481.COD_PROVINCIA'
      'and    T481.COD_REGIONE = T482.COD_REGIONE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C0000000000000000000000120000003A004400410054004F005300
      450044004500010000000000000000000000}
    Left = 666
    Top = 192
  end
  object selM011Lookup: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   M011_TIPOMISSIONE'
      '')
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = selM011FilterRecord
    Left = 601
    Top = 248
  end
  object selM170Targa: TOracleDataSet
    SQL.Strings = (
      'select M170.TARGA '
      'from   M170_RICHIESTE_MEZZI M170,'
      '       M140_RICHIESTE_MISSIONI M140,'
      '       M020_TIPIRIMBORSI M020'
      'where  M140.PROGRESSIVO = :PROGRESSIVO'
      'and    M170.ID = M140.ID        '
      'and    M170.TARGA is not null '
      'and    M170.CODICE = M020.CODICE'
      'and    M020.TIPO = :FLAG_TIPO'
      'and    M020.FLAG_TARGA = '#39'S'#39'    '
      'and    M020.FLAG_MEZZO_PROPRIO = :FLAG_MEZZO_PROPRIO'
      'order by M140.DATAA DESC')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000260000003A0046004C00410047005F00
      4D0045005A005A004F005F00500052004F005000520049004F00050000000000
      000000000000140000003A0046004C00410047005F005400490050004F000500
      00000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    Left = 103
    Top = 72
  end
  object M140F_CHECKRICHIESTA: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :RESULT:=M140F_CHECKRICHIESTA(:ID,:LIVELLO,:FASE,:CHIUSURA);'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A0052004500530055004C005400050000000000
      000000000000060000003A004900440003000000000000000000000010000000
      3A004C004900560045004C004C004F000300000000000000000000000A000000
      3A004600410053004500030000000000000000000000120000003A0043004800
      490055005300550052004100050000000000000000000000}
    Left = 512
    Top = 440
  end
  object selM141: TOracleDataSet
    SQL.Strings = (
      'select m141.id,'
      '       m141.ord,'
      '       m141.localita,'
      '       m141.ind_km,'
      '       m141.rowid,'
      '       decode(t480.codice,'
      '              null,decode(m042.codice,'
      '                          null,null,'
      '                          '#39'P'#39'),'
      '              '#39'C'#39') tipo_localita,'
      
        '       nvl(t480.citta,nvl(m042.descrizione,m141.localita)) d_loc' +
        'alita,'
      '       to_number(null) c_distanza'
      'from   m141_percorso_missione m141,'
      '       m042_localita m042,'
      '       t480_comuni t480'
      'where  m141.id = :ID'
      'and    m042.codice(+) = m141.localita'
      'and    t480.codice(+) = m141.localita'
      'order by m141.ord'
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OnApplyRecord = selM141ApplyRecord
    UpdatingTable = 'm141_percorso_missione'
    CachedUpdates = True
    OnCalcFields = selM141CalcFields
    Left = 591
    Top = 504
    object selM141ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selM141D_ORD: TStringField
      DisplayLabel = 'Tappa'
      FieldKind = fkCalculated
      FieldName = 'D_ORD'
      Size = 10
      Calculated = True
    end
    object selM141D_LOCALITA: TStringField
      DisplayLabel = 'Localit'#224
      FieldName = 'D_LOCALITA'
      Size = 40
    end
    object selM141IND_KM: TStringField
      DisplayLabel = 'Ind. km'
      FieldName = 'IND_KM'
      Size = 1
    end
    object selM141ORD: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORD'
      Visible = False
    end
    object selM141TIPO_LOCALITA: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_LOCALITA'
      Size = 1
    end
    object selM141LOCALITA: TStringField
      DisplayLabel = 'Localit'#224
      FieldName = 'LOCALITA'
      Size = 200
    end
    object selM141C_DISTANZA: TFloatField
      FieldName = 'C_DISTANZA'
    end
  end
  object selM040PK: TOracleQuery
    SQL.Strings = (
      'select sum(conto) from ('
      'select count(*) conto'
      'from   M040_MISSIONI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATADA = :DATADA '
      'and    ORADA = :ORADA '
      'and    ID_MISSIONE <> :ID'
      'union all'
      'select count(*) conto'
      'from   M140_RICHIESTE_MISSIONI M140, T850_ITER_RICHIESTE T850'
      'where  M140.PROGRESSIVO = :PROGRESSIVO'
      'and    M140.DATADA = :DATADA '
      'and    M140.ORADA = :ORADA '
      'and    m140f_getpartenza(M140.ID) = :PARTENZA'
      'and    m140f_getdestinazioni(M140.ID) = :ELENCO_DEST'
      'and    m140f_getrientro(M140.ID) = :RIENTRO'
      'and    M140.ID <> :ID'
      'and    T850.ID = M140.ID'
      'and    nvl(T850.TIPO_RICHIESTA,'#39'null'#39') <> '#39'A'#39
      'and    T850.ID_REVOCA is null'
      ')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000007000000060000003A00490044000300000000000000000000000E00
      00003A004400410054004100440041000C00000000000000000000000C000000
      3A004F005200410044004100050000000000000000000000180000003A005000
      52004F0047005200450053005300490056004F00030000000000000000000000
      120000003A00500041005200540045004E005A00410005000000000000000000
      0000180000003A0045004C0045004E0043004F005F0044004500530054000500
      00000000000000000000100000003A005200490045004E00540052004F000500
      00000000000000000000}
    Left = 477
    Top = 16
  end
  object selM025DatiAnagPers: TOracleDataSet
    SQL.Strings = (
      '/* '
      ' * NOTA'
      ' * l'#39'ordinamento non '#232' rilevante in quanto questi dati'
      ' * vengono aggiunti ad una selezione sql'
      ' */'
      'select distinct dato_anagrafico'
      'from   m025_motivazioni'
      'where  dato_anagrafico is not null')
    ReadBuffer = 5
    Optimize = False
    ReadOnly = True
    Left = 255
    Top = 128
  end
  object selValiditaPeriodo: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM   USER_PROCEDURES'
      'WHERE  UPPER(OBJECT_NAME) = '#39'USR_M140F_PERIODO_VALIDO'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 672
    Top = 16
  end
  object updM040Stato: TOracleQuery
    SQL.Strings = (
      
        '/* TORINO_REGIONE - commessa 2014/243 SVILUPPO#1 - riesame del 2' +
        '8/10/2014 */'
      'update M040_MISSIONI '
      'set    STATO = '#39'S'#39' '
      'where  ID_MISSIONE = :ID '
      'and    STATO = '#39'D'#39)
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 327
    Top = 16
  end
  object selCountM143: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from   M143_DETTAGLIOGG'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 207
    Top = 440
  end
  object updM140Riapri: TOracleQuery
    SQL.Strings = (
      'update m140_richieste_missioni'
      'set    missione_riaperta = :MISSIONE_RIAPERTA'
      'where  id = :ID')
    Optimize = False
    Variables.Data = {
      0400000002000000240000003A004D0049005300530049004F004E0045005F00
      5200490041005000450052005400410005000000000000000000000006000000
      3A0049004400030000000000000000000000}
    Left = 288
    Top = 440
  end
  object selProtocolloUnique: TOracleQuery
    SQL.Strings = (
      'select '#39'M040'#39' TABELLA '
      'from   M040_MISSIONI '
      'where  ID_MISSIONE <> nvl(:ID,0)'
      'and    PROTOCOLLO = :PROTOCOLLO'
      'union all'
      'select '#39'M140'#39
      'from   M140_RICHIESTE_MISSIONI'
      'where  ID <> nvl(:ID,0)'
      'and    PROTOCOLLO = :PROTOCOLLO')
    ReadBuffer = 3
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001600
      00003A00500052004F0054004F0043004F004C004C004F000500000000000000
      00000000}
    Left = 130
    Top = 569
  end
end
