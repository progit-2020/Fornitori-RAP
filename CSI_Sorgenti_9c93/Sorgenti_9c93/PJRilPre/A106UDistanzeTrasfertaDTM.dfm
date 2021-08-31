inherited A106FDistanzeTrasfertaDTM: TA106FDistanzeTrasfertaDTM
  OldCreateOrder = True
  Height = 75
  Width = 235
  object SelM041: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from m041_distanze t')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000A0000005400490050004F00310001000000000012000000
      4C004F00430041004C0049005400410031000100000000000A00000054004900
      50004F003200010000000000120000004C004F00430041004C00490054004100
      3200010000000000140000004300480049004C004F004D004500540052004900
      010000000000160000004400450053004300520049005A0049004F004E004500
      010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = SelM041CalcFields
    Left = 16
    Top = 16
    object SelM041TIPO1: TStringField
      DisplayLabel = 'TIPO LOC.PART.'
      FieldName = 'TIPO1'
      Required = True
      Size = 1
    end
    object SelM041LOCALITA1: TStringField
      DisplayLabel = 'CODICE PART.'
      FieldName = 'LOCALITA1'
      Required = True
      Size = 6
    end
    object SelM041desc_comune1: TStringField
      DisplayLabel = 'COMUNE DI PARTENZA'
      FieldKind = fkLookup
      FieldName = 'desc_comune1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'LOCALITA1'
      Size = 40
      Lookup = True
    end
    object SelM041desc_capcom1: TStringField
      DisplayLabel = 'CAP PART.'
      FieldKind = fkCalculated
      FieldName = 'desc_capcom1'
      Size = 5
      Calculated = True
    end
    object SelM041desc_prov1: TStringField
      DisplayLabel = 'PROV.PART.'
      FieldKind = fkCalculated
      FieldName = 'desc_prov1'
      Size = 2
      Calculated = True
    end
    object SelM041desc_localita1: TStringField
      DisplayLabel = 'LOCALITA'#39' DI PARTENZA PERS.'
      FieldKind = fkLookup
      FieldName = 'desc_localita1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'LOCALITA1'
      Size = 40
      Lookup = True
    end
    object SelM041TIPO2: TStringField
      DisplayLabel = 'TIPO LOC.DEST.'
      FieldName = 'TIPO2'
      Required = True
      Size = 1
    end
    object SelM041LOCALITA2: TStringField
      DisplayLabel = 'CODICE DEST.'
      FieldName = 'LOCALITA2'
      Required = True
      Size = 6
    end
    object SelM041desc_comune2: TStringField
      DisplayLabel = 'COMUNE DI DESTINAZIONE'
      FieldKind = fkLookup
      FieldName = 'desc_comune2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'LOCALITA2'
      Size = 40
      Lookup = True
    end
    object SelM041desc_capcom2: TStringField
      DisplayLabel = 'CAP DEST.'
      FieldKind = fkCalculated
      FieldName = 'desc_capcom2'
      Size = 5
      Calculated = True
    end
    object SelM041desc_prov2: TStringField
      DisplayLabel = 'PROV.DEST.'
      FieldKind = fkCalculated
      FieldName = 'desc_prov2'
      Size = 2
      Calculated = True
    end
    object SelM041desc_localita2: TStringField
      DisplayLabel = 'LOCALITA'#39' DI DESTINAZIONE PERS.'
      FieldKind = fkLookup
      FieldName = 'desc_localita2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'LOCALITA2'
      Size = 40
      Lookup = True
    end
    object SelM041CHILOMETRI: TFloatField
      FieldName = 'CHILOMETRI'
    end
    object SelM041C_CHILOMETRI: TFloatField
      FieldKind = fkCalculated
      FieldName = 'C_CHILOMETRI'
      Calculated = True
    end
  end
  object SelM041B: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid,'
      '       c1.desc_partenza,'
      '       c1.cap1,'
      '       c1.prov1,'
      '       c2.desc_destinazione,'
      '       c2.cap2,'
      '       c2.prov2, '
      '       to_number(null) km_proposti'
      'from   m041_distanze t,'
      
        '       (select ('#39'C'#39' || codice) as codice, citta as desc_partenza' +
        ', cap as cap1 ,provincia as prov1'
      '        from t480_comuni'
      '        union all'
      
        '        select ('#39'P'#39' || codice) as codice, descrizione as desc_pa' +
        'rtenza, '#39#39' as cap1 ,'#39#39' as prov1'
      '        from m042_localita      '
      '        ) c1,'
      
        '       (select ('#39'C'#39' || codice) as codice, citta as desc_destinaz' +
        'ione, cap as cap2 ,provincia as prov2'
      '        from t480_comuni'
      '        union all'
      
        '        select ('#39'P'#39' || codice) as codice, descrizione as desc_de' +
        'stinazione, '#39#39' as cap2 ,'#39#39' as prov2'
      '        from m042_localita      '
      '       ) c2    '
      'where  t.tipo1 || t.localita1 = c1.codice'
      'and    t.tipo2 || t.localita2 = c2.codice'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000008000000140000004300480049004C004F004D004500540052004900
      0100000000000A0000005400490050004F003100010000000000120000004C00
      4F00430041004C00490054004100310001000000000010000000500041005200
      540045004E005A0041000100000000000A0000005400490050004F0032000100
      00000000120000004C004F00430041004C004900540041003200010000000000
      18000000440045005300540049004E0041005A0049004F004E00450001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      0000}
    OnApplyRecord = SelM041BApplyRecord
    CachedUpdates = True
    AfterScroll = SelM041BAfterScroll
    OnCalcFields = SelM041CalcFields
    Left = 64
    Top = 16
    object SelM041BTIPO1: TStringField
      FieldName = 'TIPO1'
      Size = 1
    end
    object SelM041BLOCALITA1: TStringField
      FieldName = 'LOCALITA1'
      Size = 6
    end
    object SelM041BDESC_PARTENZA: TStringField
      FieldName = 'DESC_PARTENZA'
      Size = 40
    end
    object SelM041BTIPO2: TStringField
      FieldName = 'TIPO2'
      Size = 1
    end
    object SelM041BLOCALITA2: TStringField
      FieldName = 'LOCALITA2'
      Size = 6
    end
    object SelM041BDESC_DESTINAZIONE: TStringField
      FieldName = 'DESC_DESTINAZIONE'
      Size = 40
    end
    object SelM041BCHILOMETRI: TFloatField
      FieldName = 'CHILOMETRI'
    end
    object SelM041BKM_PROPOSTI: TFloatField
      FieldName = 'KM_PROPOSTI'
    end
    object SelM041BCAP1: TStringField
      FieldName = 'CAP1'
      Size = 5
    end
    object SelM041BCAP2: TStringField
      FieldName = 'CAP2'
      Size = 5
    end
    object SelM041BPROV1: TStringField
      FieldName = 'PROV1'
      Size = 2
    end
    object SelM041BPROV2: TStringField
      FieldName = 'PROV2'
      Size = 2
    end
  end
  object DSelM041B: TDataSource
    DataSet = SelM041B
    Left = 120
    Top = 16
  end
  object updM041: TOracleQuery
    SQL.Strings = (
      'UPDATE M041_DISTANZE'
      'SET    CHILOMETRI = :KM'
      'WHERE  ROWID = :M041ROWID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A004B004D000400000000000000000000001400
      00003A004D0030003400310052004F0057004900440005000000000000000000
      0000}
    Left = 180
    Top = 16
  end
end
