inherited A100FImpRimborsiIterMW: TA100FImpRimborsiIterMW
  OldCreateOrder = True
  Height = 218
  Width = 352
  object SelM041: TOracleDataSet
    SQL.Strings = (
      'select * from'
      
        '(select tipo1, localita1, t480A.citta as partenza, tipo2, locali' +
        'ta2, t480B.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480A, t480_comuni t480B'
      
        'where tipo1='#39'C'#39' and tipo2='#39'C'#39' and localita1=t480A.codice and loc' +
        'alita2=t480B.codice'
      'union all'
      
        'select tipo1, localita1, m042A.descrizione as partenza, tipo2, l' +
        'ocalita2, m042B.descrizione as destinazione, chilometri '
      
        ' from m041_distanze m041, m042_localita m042A, m042_localita m04' +
        '2B'
      
        'where tipo1='#39'P'#39' and tipo2='#39'P'#39' and localita1=m042A.codice and loc' +
        'alita2=m042B.codice'
      'union all'
      
        'select tipo1, localita1, t480.citta as partenza, tipo2, localita' +
        '2, m042.descrizione as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo1='#39'C'#39' and tipo2='#39'P'#39' and localita1=t480.codice and loca' +
        'lita2=m042.codice'
      'union all'
      
        'select tipo1, localita1, m042.descrizione as partenza, tipo2, lo' +
        'calita2, t480.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo1='#39'P'#39' and tipo2='#39'C'#39' and localita1=m042.codice and loca' +
        'lita2=t480.codice'
      'union all'
      
        'select tipo2, localita2, t480A.citta as partenza, tipo1, localit' +
        'a1, t480B.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480A, t480_comuni t480B'
      
        'where tipo2='#39'C'#39' and tipo1='#39'C'#39' and localita2=t480A.codice and loc' +
        'alita1=t480B.codice'
      'union all'
      
        'select tipo2, localita2, m042A.descrizione as partenza, tipo1, l' +
        'ocalita1, m042B.descrizione as destinazione, chilometri '
      
        ' from m041_distanze m041, m042_localita m042A, m042_localita m04' +
        '2B'
      
        'where tipo2='#39'P'#39' and tipo1='#39'P'#39' and localita2=m042A.codice and loc' +
        'alita1=m042B.codice'
      'union all'
      
        'select tipo2, localita2, t480.citta as partenza, tipo1, localita' +
        '1, m042.descrizione as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo2='#39'C'#39' and tipo1='#39'P'#39' and localita2=t480.codice and loca' +
        'lita1=m042.codice'
      'union all'
      
        'select tipo2, localita2, m042.descrizione as partenza, tipo1, lo' +
        'calita1, t480.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo2='#39'P'#39' and tipo1='#39'C'#39' and localita2=m042.codice and loca' +
        'lita1=t480.codice'
      ')')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000A0000005400490050004F00310001000000000012000000
      4C004F00430041004C0049005400410031000100000000001000000050004100
      5200540045004E005A0041000100000000000A0000005400490050004F003200
      010000000000120000004C004F00430041004C00490054004100320001000000
      000018000000440045005300540049004E0041005A0049004F004E0045000100
      00000000140000004300480049004C004F004D00450054005200490001000000
      0000}
    Left = 79
    Top = 8
    object SelM041PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 25
      FieldName = 'PARTENZA'
      Size = 40
    end
    object SelM041DESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 25
      FieldName = 'DESTINAZIONE'
      Size = 40
    end
    object SelM041CHILOMETRI: TFloatField
      DisplayLabel = 'Km'
      DisplayWidth = 5
      FieldName = 'CHILOMETRI'
    end
    object SelM041TIPO1: TStringField
      DisplayLabel = 'Tipo Part.'
      FieldName = 'TIPO1'
      Size = 1
    end
    object SelM041LOCALITA1: TStringField
      DisplayLabel = 'Cod. Partenza'
      FieldName = 'LOCALITA1'
      Size = 6
    end
    object SelM041TIPO2: TStringField
      DisplayLabel = 'Tipo Dest.'
      FieldName = 'TIPO2'
      Size = 1
    end
    object SelM041LOCALITA2: TStringField
      DisplayLabel = 'Cod. Destinazione'
      FieldName = 'LOCALITA2'
      Size = 6
    end
  end
  object selM021A: TOracleDataSet
    SQL.Strings = (
      
        'select m021.codice, m021.descrizione, m021.decorrenza, m021.impo' +
        'rto, m021.codvocepaghe, m021.arrotondamento'
      'from m021_tipiindennitakm m021'
      'where m021.codice=:codice'
      
        '  and m021.decorrenza = (select max(decorrenza) from m021_tipiin' +
        'dennitakm where codice=m021.codice and decorrenza <= :decorrenza' +
        ')')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002800000049004E00440045004E004E004900540041004B004D00
      4E0045004C0043004F004D0055004E0045000100000000002C00000049004E00
      440045004E004E004900540041004B004D00460055004F005200490043004F00
      4D0055004E0045000100000000002E0000004100520052004F00540049004D00
      50004F005200540049004B004D004E0045004C0043004F004D0055004E004500
      010000000000320000004100520052004F00540049004D0050004F0052005400
      49004B004D00460055004F005200490043004F004D0055004E00450001000000
      0000}
    Left = 20
    Top = 8
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
    Left = 134
    Top = 8
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
  object updM150: TOracleQuery
    SQL.Strings = (
      'begin'
      '  update M150_RICHIESTE_RIMBORSI set '
      '    STATO = :STATO,'
      '    RIMBORSO_VARIATO = :RIMBORSO_VARIATO,'
      '    KMPERCORSI_VARIATO = :KMPERCORSI_VARIATO'
      '  where ROWID = :RIGAID;'
      '  if :STATO = '#39'S'#39' then'
      '    M050P_CARICA_RIMBORSI_DAITER(:ID);'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000060000003A00490044000300000000000000000000000E00
      00003A005200490047004100490044000500000000000000000000000C000000
      3A0053005400410054004F00050000000000000000000000220000003A005200
      49004D0042004F00520053004F005F005600410052004900410054004F000400
      00000000000000000000260000003A004B004D0050004500520043004F005200
      530049005F005600410052004900410054004F00040000000000000000000000}
    Left = 21
    Top = 62
  end
  object selP150: TOracleQuery
    SQL.Strings = (
      
        'select T480.CODICE, T480.CITTA, T481.COD_PROVINCIA, T482.COD_REG' +
        'IONE'
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
    Left = 21
    Top = 111
  end
  object selDatoSede: TOracleQuery
    SQL.Strings = (
      
        'select T480.CODICE, T480.CAP, T480.CITTA, T481.COD_PROVINCIA, T4' +
        '82.COD_REGIONE'
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
    Left = 80
    Top = 111
  end
  object selM175: TOracleDataSet
    SQL.Strings = (
      'select M025.CODICE, M025.DESCRIZIONE, M175.VALORE '
      'from   M175_RICHIESTE_MOTIVAZIONI M175, '
      '       M025_MOTIVAZIONI M025 '
      'where  M175.ID = :ID '
      'and    M175.CODICE = M025.CODICE'
      'order by 2')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 21
    Top = 158
    object selM175CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selM175DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selM175VALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 30
      FieldName = 'VALORE'
      Size = 2000
    end
  end
  object dsrM175: TDataSource
    AutoEdit = False
    DataSet = selM175
    Left = 63
    Top = 158
  end
  object selM170: TOracleDataSet
    SQL.Strings = (
      'select M020.CODICE, M020.DESCRIZIONE, M170.TARGA'
      'from   M170_RICHIESTE_MEZZI M170, '
      '       M020_TIPIRIMBORSI M020 '
      'where  M170.ID = :ID '
      'and    M170.CODICE = M020.CODICE'
      'order by 2')
    ReadBuffer = 15
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 136
    Top = 158
    object selM170CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selM170DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM170TARGA: TStringField
      DisplayLabel = 'Targa'
      FieldName = 'TARGA'
      Size = 15
    end
  end
  object dsrM170: TDataSource
    AutoEdit = False
    DataSet = selM170
    Left = 178
    Top = 158
  end
  object selM143: TOracleDataSet
    SQL.Strings = (
      
        'select m143.data, m143.dalle, m143.alle, m143.note, m143.tipo, d' +
        'ecode(m143.tipo,'#39'S'#39','#39'Servizio attivo'#39','#39'V'#39','#39'Ore viaggio'#39',m143.tip' +
        'o) d_tipo'
      'from   m143_dettagliogg m143'
      'where  m143.id = :ID '
      'order by m143.data, m143.dalle')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 245
    Top = 158
    object selM143DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selM143D_TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 12
      FieldName = 'D_TIPO'
    end
    object selM143DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Size = 5
    end
    object selM143ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Size = 5
    end
    object selM143NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM143TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
  end
  object dsrM143: TDataSource
    AutoEdit = False
    DataSet = selM143
    Left = 290
    Top = 158
  end
end
