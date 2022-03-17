inherited A121FRecapitiSindacaliMW: TA121FRecapitiSindacaliMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 598
  object selRaggruppatoIn: TOracleDataSet
    SQL.Strings = (
      'select distinct codice'
      '  from T240_ORGANIZZAZIONISINDACALI t240'
      ' where codice <> :CODICE'
      '   and sindacati_raggruppati like '#39'%'#39' || :codice || '#39'%'#39
      '   and decorrenza = (select max(decorrenza) '
      '                  from T240_ORGANIZZAZIONISINDACALI '
      
        '                 where codice = t240.codice and decorrenza <= :d' +
        'ecorrenza)'
      'order by codice')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    Left = 416
    Top = 56
  end
  object selRaggruppamenti: TOracleDataSet
    SQL.Strings = (
      'select codice, sindacati_raggruppati from '
      '('
      
        'select t240A.codice,t240A.decorrenza inizio,decode(t240B.decorre' +
        'nza - t240A.decorrenza,0,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'),t240B.de' +
        'correnza - 1) fine, t240A.sindacati_raggruppati'
      'from '
      
        '  t240_organizzazionisindacali t240A, t240_organizzazionisindaca' +
        'li t240B'
      'where '
      '  t240B.codice = t240A.codice and'
      '  ('
      '  t240B.decorrenza = (select min(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      
        '                      where codice = t240B.codice and decorrenza' +
        ' > t240A.decorrenza)'
      
        '  and t240A.decorrenza < (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  or'
      '  t240B.decorrenza = (select max(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      '                      where codice = t240B.codice)'
      
        '  and t240A.decorrenza = (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  )'
      '  and (t240A.raggruppamento = '#39'S'#39' '
      '   or t240A.rsu = '#39'S'#39')'
      '  and t240A.codice <> :codice'
      ')'
      'where '
      '  (:INIZIO = '#39'S'#39' and fine >= :decorrenza or '
      
        '   :INIZIO = '#39'N'#39' and fine >= (select least(min(decorrenza),:deco' +
        'rrenza) from t240_organizzazionisindacali where codice = :codice' +
        ')) and '
      '   '
      
        '  (:FINE = '#39'S'#39' and inizio <= (select nvl(min(decorrenza)-1,to_da' +
        'te('#39'31123999'#39','#39'ddmmyyyy'#39')) decorrenza_fine'
      
        '               from t240_organizzazionisindacali where codice = ' +
        ':codice and decorrenza > :decorrenza)'
      '   or'
      '   :FINE = '#39'N'#39
      '  )'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      0000000000000E0000003A0049004E0049005A0049004F000500000000000000
      00000000160000003A004400450043004F005200520045004E005A0041000C00
      000000000000000000000A0000003A00460049004E0045000500000000000000
      00000000}
    Left = 415
    Top = 8
  end
  object delCollegateOrg: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete from T247_PARTECIPAZIONISINDACATI'
      '   where COD_ORGANISMO = :CODICE;'
      '  delete from T248_PERMESSISINDACALI'
      '   where COD_ORGANISMO = :CODICE;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 440
    Top = 120
  end
  object delCollegate: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete from T241_RECAPITISINDACATI'
      '   where CODICE = :CODICE;'
      '  delete from T242_COMPETENZESINDACATI'
      '   where CODICE = :CODICE;'
      '  delete from T246_ISCRIZIONISINDACATI'
      '   where COD_SINDACATO = :CODICE;'
      '  delete from T247_PARTECIPAZIONISINDACATI'
      '   where COD_SINDACATO = :CODICE;'
      '  delete from T248_PERMESSISINDACALI'
      '   where COD_SINDACATO = :CODICE;'
      'end;'
      ''
      ''
      ''
      ''
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 368
    Top = 120
  end
  object ControlloRaggruppamento: TOracleQuery
    SQL.Strings = (
      'select count(*) from '
      '('
      
        'select t240A.codice,t240A.decorrenza inizio,decode(t240B.decorre' +
        'nza - t240A.decorrenza,0,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'),t240B.de' +
        'correnza - 1) fine, t240A.sindacati_raggruppati'
      'from '
      
        '  t240_organizzazionisindacali t240A, t240_organizzazionisindaca' +
        'li t240B'
      'where '
      '  t240B.codice = t240A.codice and'
      '  ('
      '  t240B.decorrenza = (select min(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      
        '                      where codice = t240B.codice and decorrenza' +
        ' > t240A.decorrenza)'
      
        '  and t240A.decorrenza < (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  or'
      '  t240B.decorrenza = (select max(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      '                      where codice = t240B.codice)'
      
        '  and t240A.decorrenza = (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  )'
      '  and t240A.raggruppamento = '#39'S'#39' '
      '  and t240A.codice <> :codice'
      ')'
      'where '
      '  (:INIZIO = '#39'S'#39' and fine >= :decorrenza or '
      
        '   :INIZIO = '#39'N'#39' and fine >= (select least(min(decorrenza),:deco' +
        'rrenza) from t240_organizzazionisindacali where codice = :codice' +
        ')) and '
      '   '
      
        '  (:FINE = '#39'S'#39' and inizio <= (select nvl(min(decorrenza)-1,to_da' +
        'te('#39'31123999'#39','#39'ddmmyyyy'#39')) decorrenza_fine'
      
        '               from t240_organizzazionisindacali where codice = ' +
        ':codice and decorrenza > :decorrenza)'
      '   or'
      '   :FINE = '#39'N'#39
      '  )'
      
        '  and '#39','#39' || sindacati_raggruppati || '#39','#39' like '#39'%,'#39' || :codice |' +
        '| '#39',%'#39)
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      0000000000000E0000003A0049004E0049005A0049004F000500000000000000
      00000000160000003A004400450043004F005200520045004E005A0041000C00
      000000000000000000000A0000003A00460049004E0045000500000000000000
      00000000}
    Left = 235
    Top = 123
  end
  object ControlloCompetenze: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from t242_competenzesindacati t242A'
      'where codice = :codice'
      '  and area_sindacale = :area '
      '  and tipo = :tipo'
      
        '  and :decorrenza <= nvl(scadenza,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')' +
        ')'
      '  and :scadenza >= decorrenza'
      '  :numriga'
      '')
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000120000003A00530043004100440045004E005A00
      41000C0000000000000000000000100000003A004E0055004D00520049004700
      41000100000000000000000000000A0000003A00410052004500410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000}
    Left = 114
    Top = 123
  end
  object ControlloRSU: TOracleQuery
    SQL.Strings = (
      'select count(*) from '
      '('
      
        'select t240A.codice,t240A.decorrenza inizio,decode(t240B.decorre' +
        'nza - t240A.decorrenza,0,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'),t240B.de' +
        'correnza - 1) fine'
      'from '
      
        '  t240_organizzazionisindacali t240A, t240_organizzazionisindaca' +
        'li t240B'
      'where '
      '  t240B.codice = t240A.codice and'
      '  ('
      '  t240B.decorrenza = (select min(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      
        '                      where codice = t240B.codice and decorrenza' +
        ' > t240A.decorrenza)'
      
        '  and t240A.decorrenza < (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  or'
      '  t240B.decorrenza = (select max(decorrenza) decorrenza'
      '                      from t240_organizzazionisindacali '
      '                      where codice = t240B.codice)'
      
        '  and t240A.decorrenza = (select max(decorrenza) from t240_organ' +
        'izzazionisindacali where codice = t240B.codice)'
      '  )'
      '  and t240A.RSU = '#39'S'#39
      '  and t240A.codice <> :codice'
      ')'
      'where '
      '  (:INIZIO = '#39'S'#39' and fine >= :decorrenza or '
      
        '   :INIZIO = '#39'N'#39' and fine >= (select least(min(decorrenza),:deco' +
        'rrenza) from t240_organizzazionisindacali where codice = :codice' +
        ')) and '
      '   '
      
        '  (:FINE = '#39'S'#39' and inizio <= (select nvl(min(decorrenza)-1,to_da' +
        'te('#39'31123999'#39','#39'ddmmyyyy'#39')) decorrenza_fine'
      
        '               from t240_organizzazionisindacali where codice = ' +
        ':codice and decorrenza > :decorrenza)'
      '   or'
      '   :FINE = '#39'N'#39
      '  )')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004400450043004F005200520045004E005A00
      41000C00000000000000000000000E0000003A0043004F004400490043004500
      0500000000000000000000000E0000003A0049004E0049005A0049004F000500
      000000000000000000000A0000003A00460049004E0045000500000000000000
      00000000}
    Left = 24
    Top = 123
  end
  object selT200: TOracleDataSet
    SQL.Strings = (
      'select codice,descrizione,tipo '
      'from T200_contratti'
      'order by codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000800
      00005400490050004F00010000000000}
    Left = 243
    Top = 8
    object selT200CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT200DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT200TIPO: TStringField
      FieldName = 'TIPO'
      Size = 3
    end
  end
  object dsrT480: TDataSource
    DataSet = selT480
    Left = 195
    Top = 55
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from t480_comuni'
      ':orderby')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 195
    Top = 8
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object selT240A: TOracleDataSet
    SQL.Strings = (
      'select codice,descrizione'
      'from T240_ORGANIZZAZIONISINDACALI t240'
      'where '
      '--raggruppamento = '#39'N'#39' '
      '--  and RSU ='#39'N'#39
      '--  and '
      '  :CODICE AND'
      '  decorrenza = (select max(decorrenza) '
      '                  from T240_ORGANIZZAZIONISINDACALI '
      
        '                 where codice = t240.codice and decorrenza <= :d' +
        'ecorrenza) '
      'order by codice')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500010000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    Left = 151
    Top = 8
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 332
    Top = 55
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE'
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 332
    Top = 8
  end
  object selT245: TOracleDataSet
    SQL.Strings = (
      'select t245.*, t245.rowid'
      'from t245_organismisindacali t245'
      'order by codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 288
    Top = 8
    object selT245CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT245DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
  end
  object dsrT245: TDataSource
    DataSet = selT245
    Left = 288
    Top = 56
  end
  object selT241: TOracleDataSet
    SQL.Strings = (
      'SELECT T241.*'
      'FROM T241_RECAPITISINDACATI T241'
      'WHERE CODICE = :CODICE'
      'ORDER BY CODICE, TIPO_RECAPITO, PROG_RECAPITO, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000001A000000
      5400490050004F005F0052004500430041005000490054004F00010000000000
      1200000049004E0044004900520049005A005A004F0001000000000006000000
      4300410050000100000000000C00000043004F004D0055004E00450001000000
      000010000000540045004C00450046004F004E004F0001000000000006000000
      4600410058000100000000000E00000043004F0047004E004F004D0045000100
      00000000080000004E004F004D0045000100000000001A000000540045004C00
      450046004F004E004F005F004300410053004100010000000000200000005400
      45004C00450046004F004E004F005F005500460046004900430049004F000100
      0000000012000000430045004C004C0055004C00410052004500010000000000
      0A00000045004D00410049004C000100000000001A000000500052004F004700
      5F0052004500430041005000490054004F000100000000001600000044004500
      53004300520049005A0049004F004E004500010000000000}
    RefreshOptions = [roAfterInsert, roAfterUpdate, roAllFields]
    Left = 104
    Top = 8
    object selT241CODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 10
    end
    object selT241DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT241TIPO_RECAPITO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECAPITO'
      Required = True
      Size = 2
    end
    object selT241PROG_RECAPITO: TIntegerField
      DisplayLabel = 'Prog.'
      DisplayWidth = 2
      FieldName = 'PROG_RECAPITO'
      Required = True
    end
    object selT241DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT241INDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      DisplayWidth = 20
      FieldName = 'INDIRIZZO'
      Size = 50
    end
    object selT241Citta: TStringField
      DisplayLabel = 'Citt'#224
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Citta'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      Size = 50
      Lookup = True
    end
    object selT241Provincia: TStringField
      DisplayLabel = 'Prov'
      FieldKind = fkLookup
      FieldName = 'Provincia'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      Size = 2
      Lookup = True
    end
    object selT241COMUNE: TStringField
      FieldName = 'COMUNE'
      Visible = False
      Size = 6
    end
    object selT241CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT241TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selT241FAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 15
    end
    object selT241COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
    end
    object selT241NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
    end
    object selT241TELEFONO_CASA: TStringField
      DisplayLabel = 'Tel.Casa'
      FieldName = 'TELEFONO_CASA'
      Size = 15
    end
    object selT241TELEFONO_UFFICIO: TStringField
      DisplayLabel = 'Tel.Ufficio'
      FieldName = 'TELEFONO_UFFICIO'
      Size = 15
    end
    object selT241CELLULARE: TStringField
      DisplayLabel = 'Cellulare'
      FieldName = 'CELLULARE'
      Size = 15
    end
    object selT241EMAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'EMAIL'
      Size = 40
    end
  end
  object dsrT241: TDataSource
    AutoEdit = False
    DataSet = selT241
    Left = 104
    Top = 55
  end
  object selT242: TOracleDataSet
    SQL.Strings = (
      
        'select t242.codice, t242.area_sindacale, t242.competenza, t242.d' +
        'ecorrenza, t242.scadenza,'
      
        '  NVL(TO_CHAR(T242.SCADENZA,'#39'YYYY'#39'),'#39'3999'#39') ANNO, T242.TIPO, T24' +
        '2.ROWID,'
      '--  minutiore(sum(oreminuti(t248.ore))) fruito,'
      
        '  decode(tipo,'#39'I'#39',null,minutiore(sum(oreminuti(t248.ore)))) frui' +
        'to, '
      
        '--  minutiore(oreminuti(t242.competenza) - sum(oreminuti(t248.or' +
        'e))) residuo,'
      
        '  decode(tipo,'#39'I'#39',null,minutiore(oreminuti(t242.competenza) - su' +
        'm(oreminuti(t248.ore)))) residuo'
      'from t242_competenzesindacati t242, '
      
        '(  select t430.contratto,t430.datadecorrenza, t430.datafine, t24' +
        '8.cod_sindacato, T248.data, minutiore(sum(oreminuti(t248.ore))) ' +
        'ore'
      '     from t248_permessisindacali T248, t430_storico t430'
      '    where t248.progressivo = t430.progressivo'
      
        '      and t248.data between t430.datadecorrenza and t430.datafin' +
        'e'
      '      and T248.abbatte_competenze = '#39'S'#39
      '      and T248.stato IN ('#39'O'#39','#39'M'#39')'
      
        '     group by t430.contratto, t430.datadecorrenza, t430.datafine' +
        ', t248.cod_sindacato, t248.data) t248'
      'where t242.codice = :CODICE'
      '  and T248.cod_sindacato (+)= T242.CODICE '
      '  and t248.contratto (+)=t242.area_sindacale'
      
        '  and T248.data (+) between T242.DECORRENZA and nvl(t242.scadenz' +
        'a,to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      
        'group by t242.codice, t242.area_sindacale, t242.competenza, t242' +
        '.decorrenza, t242.scadenza, T242.TIPO, T242.ROWID'
      'ORDER BY T242.AREA_SINDACALE, T242.TIPO, T242.DECORRENZA DESC'
      '')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000010000000
      530043004100440045004E005A0041000100000000001400000043004F004D00
      50004500540045004E005A0041000100000000001C0000004100520045004100
      5F00530049004E0044004100430041004C0045000100000000000C0000004600
      52005500490054004F000100000000000E000000520045005300490044005500
      4F00010000000000080000005400490050004F00010000000000080000004100
      4E004E004F00010000000000}
    ReadOnly = True
    OnApplyRecord = selT242ApplyRecord
    CachedUpdates = True
    BeforePost = selT242BeforePost
    OnCalcFields = selT242CalcFields
    OnNewRecord = selT242NewRecord
    Left = 61
    Top = 8
    object selT242CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 10
    end
    object selT242AREA_SINDACALE: TStringField
      DisplayLabel = 'Contratto'
      FieldName = 'AREA_SINDACALE'
      Required = True
    end
    object selT242CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'CONTRATTO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'AREA_SINDACALE'
      Visible = False
      Size = 50
      Lookup = True
    end
    object selT242DESC_CONTRATTO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DESC_CONTRATTO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'AREA_SINDACALE'
      Size = 50
      Lookup = True
    end
    object selT242TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selT242DESC_TIPO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'DESC_TIPO'
      Calculated = True
    end
    object selT242DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT242SCADENZA: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      OnValidate = selT242SCADENZAValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT242COMPETENZA: TStringField
      DisplayLabel = 'Competenza'
      FieldName = 'COMPETENZA'
      OnValidate = selT242COMPETENZAValidate
      EditMask = '!9000:00;1;_'
      Size = 7
    end
    object selT242FRUITO: TStringField
      DisplayLabel = 'Fruito'
      DisplayWidth = 7
      FieldName = 'FRUITO'
      ReadOnly = True
      EditMask = '!9000:00;1;_'
      Size = 4000
    end
    object selT242RESIDUO: TStringField
      DisplayLabel = 'Residuo'
      DisplayWidth = 7
      FieldName = 'RESIDUO'
      ReadOnly = True
      EditMask = '!9000:00;1;_'
      Size = 4000
    end
    object selT242ANNO: TStringField
      FieldName = 'ANNO'
      Visible = False
      Size = 4
    end
  end
  object dsrT242: TDataSource
    DataSet = selT242
    Left = 60
    Top = 55
  end
  object selT241MaxProg: TOracleQuery
    SQL.Strings = (
      'select max(prog_recapito) '
      'from t241_recapitisindacati'
      ' where codice = :codice'
      '   and tipo_recapito = :tipo ')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A005400490050004F00050000000000000000000000}
    Left = 533
    Top = 119
  end
end
