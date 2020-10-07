inherited A123FPartecipazioniSindacatiMW: TA123FPartecipazioniSindacatiMW
  OldCreateOrder = True
  Height = 156
  Width = 381
  object ControlloIscrizioni: TOracleQuery
    SQL.Strings = (
      'select COUNT(*)'
      'from T247_PARTECIPAZIONISINDACATI'
      'where PROGRESSIVO = :PROGRESSIVO'
      '  and :DADATA <= NVL(ADATA,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      '  and :ADATA  >= DADATA'
      '  :numriga'
      
        '  and ((COD_SINDACATO = :COD_SINDACATO and COD_ORGANISMO = :COD_' +
        'ORGANISMO)'
      '   or (COD_SINDACATO <> :COD_SINDACATO and '
      '       COD_SINDACATO NOT IN (select CODICE'
      
        '                               from (select t240A.codice,t240A.d' +
        'ecorrenza inizio,decode(t240B.decorrenza - t240A.decorrenza,0,to' +
        '_date('#39'31123999'#39','#39'ddmmyyyy'#39'),t240B.decorrenza - 1) fine'
      
        '                                       from t240_organizzazionis' +
        'indacali t240A, t240_organizzazionisindacali t240B'
      
        '                                      where t240B.codice = t240A' +
        '.codice '
      
        '                                        and (t240B.decorrenza = ' +
        '(select min(decorrenza) decorrenza'
      
        '                                                                ' +
        '   from t240_organizzazionisindacali '
      
        '                                                                ' +
        '  where codice = t240B.codice and decorrenza > t240A.decorrenza)'
      
        '                                        and t240A.decorrenza < (' +
        'select max(decorrenza) '
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice)'
      
        '                                         or t240B.decorrenza = (' +
        'select max(decorrenza) decorrenza'
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice)'
      
        '                                        and t240A.decorrenza = (' +
        'select max(decorrenza) '
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice))'
      '                                        and t240A.RSU = '#39'S'#39')'
      '                              where inizio <= :DADATA'
      '                                and fine >= :ADATA) and '
      '       :COD_SINDACATO NOT IN (select CODICE'
      
        '                               from (select t240A.codice,t240A.d' +
        'ecorrenza inizio,decode(t240B.decorrenza - t240A.decorrenza,0,to' +
        '_date('#39'31123999'#39','#39'ddmmyyyy'#39'),t240B.decorrenza - 1) fine'
      
        '                                       from t240_organizzazionis' +
        'indacali t240A, t240_organizzazionisindacali t240B'
      
        '                                      where t240B.codice = t240A' +
        '.codice '
      
        '                                        and (t240B.decorrenza = ' +
        '(select min(decorrenza) decorrenza'
      
        '                                                                ' +
        '   from t240_organizzazionisindacali '
      
        '                                                                ' +
        '  where codice = t240B.codice and decorrenza > t240A.decorrenza)'
      
        '                                        and t240A.decorrenza < (' +
        'select max(decorrenza) '
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice)'
      
        '                                         or t240B.decorrenza = (' +
        'select max(decorrenza) decorrenza'
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice)'
      
        '                                        and t240A.decorrenza = (' +
        'select max(decorrenza) '
      
        '                                                                ' +
        '  from t240_organizzazionisindacali '
      
        '                                                                ' +
        ' where codice = t240B.codice))'
      '                                        and t240A.RSU = '#39'S'#39')'
      '                              where inizio <= :DADATA'
      '                                and fine >= :ADATA)))')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000100000003A004E0055004D0052004900470041000100
      000000000000000000001C0000003A0043004F0044005F00530049004E004400
      41004300410054004F000500000000000000000000001C0000003A0043004F00
      44005F004F005200470041004E00490053004D004F0005000000000000000000
      0000}
    Left = 40
    Top = 94
  end
  object selT245: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from t245_organismisindacali'
      'order by codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 144
    Top = 16
  end
  object selT240: TOracleDataSet
    SQL.Strings = (
      'select * from t240_organizzazionisindacali T240'
      'where ((codice in (select cod_sindacato'
      '                   from t246_iscrizionisindacati'
      '                  where progressivo = :PROGRESSIVO'
      '                    and data_dec_iscr <= :DADATA'
      
        '                    and nvl(data_dec_ces,to_date('#39'31123999'#39','#39'ddm' +
        'myyyy'#39')) >= :ADATA)'
      '          and rsu = '#39'N'#39') '
      '   or rsu = '#39'S'#39')'
      '  and decorrenza = (select max(decorrenza) '
      '                      from T240_ORGANIZZAZIONISINDACALI '
      
        '                     where codice = t240.codice and decorrenza <' +
        '= :DADATA) '
      '   ')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0041004400410054004100
      0C00000000000000000000000E0000003A004400410044004100540041000C00
      00000000000000000000}
    Left = 88
    Top = 16
  end
  object selT240A: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from t240_organizzazionisindacali T240'
      'where codice in (select distinct(cod_sindacato)'
      '                   from t247_partecipazionisindacati'
      
        '                  where :DATA between dadata and nvl(adata,to_da' +
        'te('#39'31123999'#39','#39'ddmmyyyy'#39')))'
      '   and decorrenza = (select max(decorrenza) '
      '                       from T240_ORGANIZZAZIONISINDACALI '
      
        '                      where codice = t240.codice and decorrenza ' +
        '<= :DATA) ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 192
    Top = 16
  end
  object selT245A: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from t245_organismisindacali T245'
      'where codice in (select distinct(cod_organismo)'
      '                   from t247_partecipazionisindacati'
      
        '                  where :DATA between dadata and nvl(adata,to_da' +
        'te('#39'31123999'#39','#39'ddmmyyyy'#39')))')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 256
    Top = 16
  end
  object selT247A: TOracleDataSet
    SQL.Strings = (
      
        'select T030.matricola, T030.cognome || '#39' '#39' || T030.nome nominati' +
        'vo, T247.dadata, T247.adata, T247.cod_sindacato, T247.cod_organi' +
        'smo'
      'from T247_partecipazionisindacati T247, T030_anagrafico T030'
      'where T247.progressivo = T030.progressivo'
      
        '  and :DATA between dadata and nvl(adata,to_date('#39'31123999'#39','#39'ddm' +
        'myyyy'#39'))'
      '  :FILTROSINDACATO'
      '  :FILTROORGANISMO'
      'order by :ORDINAMENTO nominativo, T030.matricola '
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000200000003A00460049004C00540052004F00530049004E00440041004300
      410054004F00010000000000000000000000200000003A00460049004C005400
      52004F004F005200470041004E00490053004D004F0001000000000000000000
      0000180000003A004F005200440049004E0041004D0045004E0054004F000100
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000120000004D00410054005200490043004F004C0041000100
      000000000C0000004400410044004100540041000100000000000A0000004100
      44004100540041000100000000001A00000043004F0044005F00530049004E00
      440041004300410054004F000100000000001A00000043004F0044005F004F00
      5200470041004E00490053004D004F00010000000000140000004E004F004D00
      49004E0041005400490056004F00010000000000}
    Left = 319
    Top = 16
    object selT247ACOD_ORGANISMO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 3
      FieldName = 'COD_ORGANISMO'
      Required = True
      Size = 5
    end
    object selT247ADESC_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'DESC_ORGANISMO'
      LookupDataSet = selT245A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_ORGANISMO'
      Size = 50
      Lookup = True
    end
    object selT247ACOD_SINDACATO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 3
      FieldName = 'COD_SINDACATO'
      Required = True
      Size = 10
    end
    object selT247ADESC_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DESC_SINDACATO'
      LookupDataSet = selT240A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_SINDACATO'
      Size = 50
      Lookup = True
    end
    object selT247ADADATA: TDateTimeField
      DisplayLabel = 'Da data'
      DisplayWidth = 10
      FieldName = 'DADATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT247AADATA: TDateTimeField
      DisplayLabel = 'A data'
      DisplayWidth = 10
      FieldName = 'ADATA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT247AMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 5
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT247ANOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 60
    end
  end
  object dsrT247A: TDataSource
    AutoEdit = False
    DataSet = selT247A
    Left = 319
    Top = 72
  end
  object dsrT240A: TDataSource
    AutoEdit = False
    DataSet = selT240A
    Left = 192
    Top = 72
  end
  object dsrT245A: TDataSource
    AutoEdit = False
    DataSet = selT245A
    Left = 256
    Top = 72
  end
end
