object A169FCalcoloDtM: TA169FCalcoloDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 286
  Width = 522
  object selT770: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from T770_QUOTE T770'
      ' where DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and CODTIPOQUOTA = :CODQUOTA'
      '   and DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE '
      '                      WHERE DATO1 = T770.DATO1'
      '                        AND DATO2 = T770.DATO2'
      '                        AND DATO3 = T770.DATO3'
      '                        AND CODTIPOQUOTA = T770.CODTIPOQUOTA'
      '                        AND DECORRENZA <= :DATA)'
      'order by DATO1,DATO2,DATO3 DESC')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A004400410054004F0031000500000000000000000000000C00
      00003A004400410054004F0032000500000000000000000000000C0000003A00
      4400410054004F003300050000000000000000000000120000003A0043004F00
      4400510055004F0054004100050000000000000000000000}
    Left = 32
    Top = 24
  end
  object selT760: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T760_REGOLEINCENTIVI T760'
      
        'WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCEN' +
        'TIVI'
      '                     WHERE DECORRENZA <= :DECORRENZA'
      '                       AND LIVELLO = T760.LIVELLO)'
      'AND LIVELLO = :LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000100000003A004C004900560045004C004C00
      4F00050000000000000000000000}
    Left = 80
    Top = 22
  end
  object selT775: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, decorrenza, NVL(scadenza,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39')) SCADENZA, codtipoquota, importo, '
      
        '       penalizzazione, saltaprova, num_ore, perc_individuale, pe' +
        'rc_strutturale, considera_saldo, '
      '       percentuale, sospendi_pt, sospendi_quote, '
      
        '       LEAST(NVL(SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),:DATA)' +
        ' - GREATEST(DECORRENZA,TRUNC(:DATA,'#39'MM'#39')) + 1 GIORNI'
      '  from T775_QUOTEINDIVIDUALI T'
      ' where PROGRESSIVO = :PROGRESSIVO '
      '   and DECORRENZA <= :DATA'
      
        '   and NVL(SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= TRUNC(:DA' +
        'TA,'#39'MM'#39')'
      '   :CODQUOTA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A0043004F004400510055004F0054004100
      010000000000000000000000}
    Left = 148
    Top = 22
  end
  object selT040B: TOracleDataSet
    SQL.Strings = (
      
        'select DISTINCT T040.DATA, T770.IMPORTO, T770.PERCENTUALE, T770.' +
        'SOSPENDI_PT, t770.considera_saldo'
      '  from T040_GIUSTIFICATIVI T040, T770_QUOTE T770'
      ' where T040.PROGRESSIVO = :PROG'
      '   and T040.DATA BETWEEN :DADATA AND :ADATA'
      '   and T040.CAUSALE = T770.CAUSALE '
      '   and DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and T770.CODTIPOQUOTA = '#39' '#39
      '   and DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE '
      '                      WHERE DATO1 = T770.DATO1'
      '                        AND DATO2 = T770.DATO2'
      '                        AND DATO3 = T770.DATO3'
      '                        AND CODTIPOQUOTA = T770.CODTIPOQUOTA'
      '                        AND DECORRENZA <= :ADATA)')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A004400410044004100540041000C0000000000000000000000
      0C0000003A00410044004100540041000C00000000000000000000000C000000
      3A004400410054004F0031000500000000000000000000000C0000003A004400
      410054004F0032000500000000000000000000000C0000003A00440041005400
      4F003300050000000000000000000000}
    Left = 212
    Top = 24
  end
  object selT775Gen: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, decorrenza, NVL(scadenza,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39')) SCADENZA,  '
      '       saltaprova, sospendi_pt, sospendi_quote'
      '  from T775_QUOTEINDIVIDUALI T'
      ' where DECORRENZA <= to_date('#39'31/12/'#39' || :ANNO,'#39'DD/MM/YYYY'#39')'
      
        '   and NVL(SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= TO_DATE('#39 +
        '01/01/'#39'||:ANNO,'#39'DD/MM/YYYY'#39')'
      '   AND CODTIPOQUOTA = '#39' '#39
      'order by progressivo, decorrenza')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 148
    Top = 78
  end
  object ControlloT770: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from T770_QUOTE T770'
      ' where DECODE(DATO1,'#39' '#39',NVL(:DATO1,'#39' '#39'),DATO1) = NVL(:DATO1,'#39' '#39')'
      '   and DECODE(DATO2,'#39' '#39',NVL(:DATO2,'#39' '#39'),DATO2) = NVL(:DATO2,'#39' '#39')'
      '   and DECODE(DATO3,'#39' '#39',NVL(:DATO3,'#39' '#39'),DATO3) = NVL(:DATO3,'#39' '#39')'
      '   and CODTIPOQUOTA = :CODQUOTA'
      '   and DECORRENZA = (SELECT MAX(DECORRENZA) FROM T770_QUOTE '
      '                      WHERE DATO1 = T770.DATO1'
      '                        AND DATO2 = T770.DATO2'
      '                        AND DATO3 = T770.DATO3'
      '                        AND CODTIPOQUOTA = T770.CODTIPOQUOTA'
      '                        AND DECORRENZA <= :DATA)')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A004400410054004F0031000500000000000000000000000C00
      00003A004400410054004F0032000500000000000000000000000C0000003A00
      4400410054004F003300050000000000000000000000120000003A0043004F00
      4400510055004F0054004100050000000000000000000000}
    Left = 32
    Top = 80
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,INCENTIVI,PIANTA'
      'from t460_parttime'
      'order by CODICE')
    ReadBuffer = 500
    Optimize = False
    Left = 272
    Top = 22
  end
  object selT774: TOracleDataSet
    SQL.Strings = (
      
        'select t774.*, t774.rowid, t030.cognome, t030.nome, t030.matrico' +
        'la '
      'from t774_pesatureIndividuali t774, t030_anagrafico t030'
      'where anno = :ANNO'
      '  and codgruppo = :CODICE'
      '  and codtipoquota = :CODQUOTA'
      '  and t774.progressivo = t030.progressivo'
      'order by t030.cognome, t030.nome, t030.matricola')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000120000003A0043004F004400510055004F005400410005000000
      00000000000000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000200000005000450053004F005F0049004E004400490056004900
      4400550041004C0045000100000000001C0000005000450053004F005F004300
      41004C0043004F004C00410054004F0001000000000022000000510055004F00
      540041005F0049004E0044004900560049004400550041004C00450001000000
      00001E000000510055004F00540041005F00430041004C0043004F004C004100
      540041000100000000000E00000043004F0047004E004F004D00450001000000
      0000080000004E004F004D004500010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000470047005F00530045005200
      560049005A0049004F000100000000000800000041004E004E004F0001000000
      000014000000440041005400410049004E0049005A0049004F00010000000000
      100000004400410054004100460049004E0045000100000000001E0000005100
      55004F00540041005F00410053005300450047004E0041005400410001000000
      0000260000004F00420049004500540054004900560049005F00410053005300
      450047004E00410054004900010000000000}
    ReadOnly = True
    CachedUpdates = True
    Left = 424
    Top = 20
    object selT774ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selT774CODGRUPPO: TStringField
      FieldName = 'CODGRUPPO'
      Required = True
      Visible = False
      Size = 10
    end
    object selT774CODTIPOQUOTA: TStringField
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Visible = False
      Size = 5
    end
    object selT774PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT774MATRICOLA: TStringField
      DisplayLabel = 'Matr.'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT774COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object selT774NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object selT774DATAINIZIO: TDateTimeField
      FieldName = 'DATAINIZIO'
    end
    object selT774DATAFINE: TDateTimeField
      FieldName = 'DATAFINE'
    end
    object selT774GG_SERVIZIO: TFloatField
      DisplayLabel = 'GG Servizio'
      FieldName = 'GG_SERVIZIO'
    end
    object selT774OBIETTIVI_ASSEGNATI: TStringField
      DisplayLabel = 'O.A.'
      FieldName = 'OBIETTIVI_ASSEGNATI'
      Size = 1
    end
    object selT774PESO_INDIVIDUALE: TFloatField
      DisplayLabel = 'Peso base'
      FieldName = 'PESO_INDIVIDUALE'
    end
    object selT774QUOTA_INDIVIDUALE: TFloatField
      DisplayLabel = 'Quota base'
      FieldName = 'QUOTA_INDIVIDUALE'
    end
    object selT774QUOTA_ASSEGNATA: TFloatField
      DisplayLabel = 'Quota assegnata'
      FieldName = 'QUOTA_ASSEGNATA'
    end
    object selT774PESO_CALCOLATO: TFloatField
      DisplayLabel = 'Peso calc.'
      FieldName = 'PESO_CALCOLATO'
    end
    object selT774QUOTA_CALCOLATA: TFloatField
      DisplayLabel = 'Quota calcolata'
      FieldName = 'QUOTA_CALCOLATA'
    end
  end
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select perc'
      'from sg735_punteggifasce_incentivi'
      'where tipologia = '#39'I'#39
      '  and codquota = :quota'
      '  and flessibilita = :flex'
      '  and :datarif between decorrenza and decorrenza_fine'
      '  and :parttime between punteggio_da and punteggio_a'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A00510055004F00540041000500000000000000
      00000000100000003A0044004100540041005200490046000C00000000000000
      00000000120000003A005000410052005400540049004D004500040000000000
      0000000000000A0000003A0046004C0045005800050000000000000000000000}
    Left = 344
    Top = 20
  end
  object selT768: TOracleDataSet
    SQL.Strings = (
      'select FLESSIBILITA'
      '  from t768_incquantindividuali T768, T765_TIPOQUOTE T765'
      'where anno = :anno'
      '  and progressivo = :prog'
      '  and confermato = '#39'S'#39
      '  AND T768.CODTIPOQUOTA = T765.CODICE'
      
        '  AND T765.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQU' +
        'OTE'
      '                          WHERE CODICE = T765.CODICE)'
      '  AND INSTR('#39','#39'||T765.ACCONTI||'#39','#39','#39','#39'||:QUOTA||'#39','#39') > 0')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A00500052004F0047000300000000000000000000000C000000
      3A00510055004F0054004100050000000000000000000000}
    Left = 40
    Top = 144
  end
end
