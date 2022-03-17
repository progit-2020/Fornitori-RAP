inherited A169FPesatureIndividualiMW: TA169FPesatureIndividualiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 460
  Width = 695
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * from t765_tipoquote t765'
      'where tipoquota = '#39'I'#39
      '  and decorrenza = (select max(decorrenza) from t765_tipoquote '
      '                     where codice = t765.codice'
      '                       and decorrenza <= :DEC)'
      'order by codice')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004400450043000C0000000000000000000000}
    Left = 96
    Top = 24
  end
  object dsrT765: TDataSource
    DataSet = selT765
    Left = 96
    Top = 80
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, matricola, cognome, nome, MIN(DATAINIZIO) DA' +
        'TAINIZIO, MAX(DATAFINE) DATAFINE, sum(ggservizio) ggservizio'
      'from ('
      
        'select DISTINCT t030.progressivo, t030.matricola, t030.cognome, ' +
        't030.nome, '
      '       T430INIZIO,T430FINE,'
      
        '      greatest(greatest(t430inizio,t430datadecorrenza),:datainiz' +
        'io) DATAINIZIO,'
      
        '      least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),t' +
        '430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'DD' +
        '/MM/YYYY'#39')) DATAFINE,'
      
        '       least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),' +
        't430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'D' +
        'D/MM/YYYY'#39')) - '
      
        '         greatest(greatest(t430inizio,t430datadecorrenza),:datai' +
        'nizio) + 1 ggservizio'
      'from t030_anagrafico t030, v430_storico v430'
      'where t030.progressivo = V430.t430progressivo'
      
        '  and v430.t430datadecorrenza <= TO_DATE('#39'31/12/'#39' || TO_CHAR(:DA' +
        'TAINIZIO,'#39'YYYY'#39'),'#39'DD/MM/YYYY'#39')'
      '  and v430.t430datafine >= :DATAINIZIO'
      '  and v430.t430inizio <= :DATAFINE'
      
        '  and nvl(v430.t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) >= :DATA' +
        'INIZIO'
      '  and :filtro'
      
        '  AND least(least(nvl(t430fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')),t' +
        '430datafine),TO_DATE('#39'31/12/'#39' || TO_CHAR(:DATAINIZIO,'#39'YYYY'#39'),'#39'DD' +
        '/MM/YYYY'#39')) - '
      
        '      greatest(greatest(t430inizio,t430datadecorrenza),:datainiz' +
        'io) + 1 > 0'
      ')'
      'group by progressivo, matricola, cognome, nome'
      'order by cognome, nome, matricola')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004400410054004100460049004E0045000C00
      00000000000000000000160000003A00440041005400410049004E0049005A00
      49004F000C00000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 168
    Top = 24
  end
  object selT773b: TOracleDataSet
    SQL.Strings = (
      'select distinct codgruppo, descrizione from t773_pesaturegruppo'
      'where anno = :anno'
      'order by codgruppo')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 92
    Top = 144
  end
  object ControlloT774: TOracleDataSet
    SQL.Strings = (
      'select CODGRUPPO'
      '  from t774_pesatureindividuali'
      'where anno = :anno'
      '  and codtipoquota = :quota'
      '  and codgruppo <> :gruppo'
      '  and progressivo = :prog'
      '  and datainizio <= :fine'
      '  and datafine >= :inizio')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00470052005500500050004F00050000000000000000000000
      0A0000003A00500052004F0047000300000000000000000000000A0000003A00
      460049004E0045000C00000000000000000000000E0000003A0049004E004900
      5A0049004F000C00000000000000000000000C0000003A00510055004F005400
      4100050000000000000000000000}
    Left = 168
    Top = 80
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
    AutoCalcFields = False
    CachedUpdates = True
    BeforeInsert = selT774BeforeInsert
    BeforeDelete = selT774BeforeDelete
    Left = 32
    Top = 24
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
      ReadOnly = True
      Size = 8
    end
    object selT774COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 30
    end
    object selT774NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ReadOnly = True
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
      ReadOnly = True
    end
    object selT774OBIETTIVI_ASSEGNATI: TStringField
      DisplayLabel = 'O.A.'
      FieldName = 'OBIETTIVI_ASSEGNATI'
      Size = 1
    end
    object selT774PESO_INDIVIDUALE: TFloatField
      DisplayLabel = 'Peso base'
      FieldName = 'PESO_INDIVIDUALE'
      OnValidate = selT774PESO_INDIVIDUALEValidate
    end
    object selT774QUOTA_INDIVIDUALE: TFloatField
      DisplayLabel = 'Quota base'
      FieldName = 'QUOTA_INDIVIDUALE'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0.00'
    end
    object selT774QUOTA_ASSEGNATA: TFloatField
      DisplayLabel = 'Quota assegnata'
      FieldName = 'QUOTA_ASSEGNATA'
      DisplayFormat = '###,###,###,##0.00'
    end
    object selT774PESO_CALCOLATO: TFloatField
      DisplayLabel = 'Peso calc.'
      FieldName = 'PESO_CALCOLATO'
      ReadOnly = True
    end
    object selT774QUOTA_CALCOLATA: TFloatField
      DisplayLabel = 'Quota calcolata'
      FieldName = 'QUOTA_CALCOLATA'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0.00'
    end
  end
  object dsrT774: TDataSource
    DataSet = selT774
    Left = 32
    Top = 80
  end
end
