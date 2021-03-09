inherited S031FFamiliariMW: TS031FFamiliariMW
  OldCreateOrder = True
  Height = 234
  Width = 500
  object Q480: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Citta,Cap,Provincia,CodCatastale from T480_Comuni '
      ':ORDERBY')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 25
    Top = 7
    object Q480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object Q480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object Q480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object Q480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object Q480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MATRICOLA, COGNOME || '#39' '#39' || NOME NOMINATIVO, COGNOME, NO' +
        'ME, DATANAS, COMUNENAS, SESSO, CODFISCALE, CAPNAS'
      'FROM T030_ANAGRAFICO '
      'ORDER BY NOMINATIVO')
    ReadBuffer = 2000
    Optimize = False
    Left = 85
    Top = 8
  end
  object dsrQ480: TDataSource
    DataSet = Q480
    Left = 27
    Top = 56
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,TIPOCUMULO,FRUIBILE'
      'from T265_CAUASSENZE '
      'where nvl(CUMULO_FAMILIARI,'#39'N'#39') <> '#39'N'#39
      'or nvl(FRUIZIONE_FAMILIARI,'#39'N'#39') <> '#39'N'#39
      'order by CODICE')
    Optimize = False
    Left = 143
    Top = 8
  end
  object updSG101: TOracleQuery
    SQL.Strings = (
      'UPDATE SG101_FAMILIARI'
      
        'SET DATA_ULT_FAM_CAR = DECODE(:DATA_ULT_FAM_CAR,TO_DATE('#39'3012189' +
        '9'#39','#39'DDMMYYYY'#39'),NULL,:DATA_ULT_FAM_CAR)'
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000220000003A0044004100540041005F00
      55004C0054005F00460041004D005F004300410052000C000000000000000000
      0000}
    Left = 24
    Top = 117
  end
  object selT040Count: TOracleQuery
    SQL.Strings = (
      'declare'
      '  i integer;'
      'begin'
      '  :COUNT:=0;'
      '  select count(*) into i from SG101_FAMILIARI '
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   (DATANAS = :DATANAS or DATAADOZ = :DATANAS);'
      '  '
      '  if i = 1 then'
      '    select count(*),min(DATA),max(DATA) '
      '    into   :COUNT,:MINDATA,:MAXDATA '
      '    from   T040_GIUSTIFICATIVI'
      '    where  PROGRESSIVO = :PROGRESSIVO'
      '    and    DATANAS = :DATANAS;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C00000000000000000000000C0000003A0043004F0055004E005400
      03000000040000000000000000000000100000003A004D0049004E0044004100
      540041000C0000000000000000000000100000003A004D004100580044004100
      540041000C0000000000000000000000}
    Left = 362
    Top = 116
  end
  object selNumOrd: TOracleQuery
    SQL.Strings = (
      'SELECT NVL(MAX(NUMORD),0), MAX(DATA_ULT_FAM_CAR)'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 95
    Top = 116
  end
  object selGradoPar: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*) CONTA'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND GRADOPAR = '#39'NS'#39
      'and numord <> :NUM')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A004E0055004D0003000000
      0000000000000000}
    Left = 286
    Top = 116
  end
  object selCodFiscDuplicato: TOracleQuery
    SQL.Strings = (
      'select nvl(max(numord),0)'
      'from sg101_familiari'
      'where progressivo = :PROGRESSIVO'
      'and codfiscale = :CODICE_FISCALE'
      'and numord <> :NUMERO_ORDINE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0043004F00440049004300
      45005F00460049005300430041004C0045000500000000000000000000001C00
      00003A004E0055004D00450052004F005F004F005200440049004E0045000300
      00000000000000000000}
    Left = 190
    Top = 116
  end
  object selNomePA: TOracleDataSet
    SQL.Strings = (
      'select distinct :DATO'
      'from SG101_FAMILIARI'
      'where :DATO is not null'
      'order by :DATO')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004400410054004F0001000000000000000000
      0000}
    Left = 211
    Top = 8
  end
end
