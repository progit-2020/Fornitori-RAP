inherited A137FCalcoloSpeseAccessoMW: TA137FCalcoloSpeseAccessoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 207
  Width = 425
  object dsrM010: TDataSource
    DataSet = selM010
    Left = 70
    Top = 14
  end
  object selM010: TOracleDataSet
    SQL.Strings = (
      'select distinct tipo_missione, descrizione'
      'from   m010_parametriconteggio')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F00540041000100000000001C0000004400
      4500530043005F005400490050004F00510055004F0054004100010000000000}
    Left = 19
    Top = 14
    object selM010TIPO_MISSIONE: TStringField
      FieldName = 'TIPO_MISSIONE'
      Size = 5
    end
    object selM010DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione'
      'from T275_CAUPRESENZE'
      'order by CODICE')
    ReadBuffer = 50
    Optimize = False
    Left = 183
    Top = 80
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select tipo_localita_dist_lavoro, cod_localita_dist_lavoro'
      'from   t430_storico'
      'where  progressivo = :progressivo'
      'and    :datagg between datadecorrenza and datafine')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004700
      47000C0000000000000000000000}
    Left = 327
    Top = 80
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      'select verso, rilevatore'
      'from   t100_timbrature'
      'where  progressivo = :PROGRESSIVO'
      'and    data = :DATAGG'
      'and    flag in ('#39'I'#39','#39'O'#39')'
      ':PRESENZE_ESCLUSE'
      'order by ora')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004700
      47000C0000000000000000000000220000003A00500052004500530045004E00
      5A0045005F004500530043004C00550053004500010000000000000000000000}
    Left = 240
    Top = 80
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select CODICE, TIPO_LOCALITA, COD_LOCALITA'
      'from   t361_orologi'
      '')
    Optimize = False
    Left = 369
    Top = 80
  end
  object selM041: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   m041_distanze t')
    Optimize = False
    Left = 72
    Top = 80
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'select codice, citta'
      'from   t480_comuni'
      'order by codice')
    Optimize = False
    Left = 283
    Top = 80
  end
  object selM042: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   m042_localita'
      'order by codice')
    Optimize = False
    Left = 128
    Top = 80
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 130
    Top = 14
  end
  object selM040: TOracleDataSet
    SQL.Strings = (
      'select id_missione'
      'from   m040_missioni'
      'where progressivo = :progressivo'
      'and   mesescarico = :mesescarico'
      'and   mesecompetenza = :mesecompetenza'
      'and   datada      = :datada'
      'and   orada       = :orada'
      'and   tiporegistrazione = :tiporegistrazione'
      'and   dataa       = :dataa'
      'and   oraa        = :oraa')
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000
      240000003A005400490050004F00520045004700490053005400520041005A00
      49004F004E0045000500000000000000000000000C0000003A00440041005400
      410041000C00000000000000000000000A0000003A004F005200410041000500
      00000000000000000000}
    Left = 16
    Top = 80
  end
  object insM040: TOracleQuery
    SQL.Strings = (
      'INSERT INTO M040_MISSIONI'
      '  (PROGRESSIVO'
      '  ,MESESCARICO'
      '  ,MESECOMPETENZA'
      '  ,DATADA'
      '  ,ORADA'
      '  ,TIPOREGISTRAZIONE'
      '  ,DATAA'
      '  ,ORAA'
      '  ,TOTALEGG'
      '  ,DURATA'
      '  ,TARIFFAINDINTERA'
      '  ,OREINDINTERA'
      '  ,IMPORTOINDINTERA'
      '  ,TARIFFAINDRIDOTTAH'
      '  ,OREINDRIDOTTAH'
      '  ,IMPORTOINDRIDOTTAH'
      '  ,TARIFFAINDRIDOTTAG'
      '  ,OREINDRIDOTTAG'
      '  ,IMPORTOINDRIDOTTAG'
      '  ,TARIFFAINDRIDOTTAHG'
      '  ,OREINDRIDOTTAHG'
      '  ,IMPORTOINDRIDOTTAHG'
      '  ,FLAG_MODIFICATO'
      '  ,STATO'
      '  ,ID_MISSIONE)'
      'VALUES'
      '  (:PROGRESSIVO'
      '  ,:MESESCARICO'
      '  ,:MESECOMPETENZA'
      '  ,:DATADA'
      '  ,'#39'00.00'#39
      '  ,:TIPOREGISTRAZIONE'
      '  ,:DATAA'
      '  ,'#39'00.00'#39
      '  ,:TOTALEGG'
      '  ,:DURATA'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,0'
      '  ,:OREINDRIDOTTAHG'
      '  ,0'
      '  ,'#39'N'#39
      '  ,'#39'D'#39
      '  ,T850_ID.NEXTVAL)')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      00000000240000003A005400490050004F005200450047004900530054005200
      41005A0049004F004E0045000500000000000000000000000C0000003A004400
      41005400410041000C0000000000000000000000120000003A0054004F005400
      41004C004500470047000400000000000000000000000E0000003A0044005500
      5200410054004100050000000000000000000000200000003A004F0052004500
      49004E0044005200490044004F00540054004100480047000400000000000000
      00000000}
    Left = 16
    Top = 144
  end
  object selM052: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   m052_indennitakm'
      'where progressivo = :progressivo'
      'and   mesescarico = :mesescarico'
      'and   mesecompetenza = :mesecompetenza'
      'and   datada      = :datada'
      'and   orada       = :orada'
      'and   codiceindennitakm = :codiceindennitakm')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      00000000240000003A0043004F00440049004300450049004E00440045004E00
      4E004900540041004B004D000500000000000000000000000C0000003A004F00
      5200410044004100050000000000000000000000}
    Left = 184
    Top = 144
  end
  object insM052: TOracleQuery
    SQL.Strings = (
      'INSERT INTO M052_INDENNITAKM'
      '  (PROGRESSIVO'
      '  ,MESESCARICO'
      '  ,MESECOMPETENZA'
      '  ,DATADA'
      '  ,ORADA'
      '  ,CODICEINDENNITAKM'
      '  ,KMPERCORSI'
      '  ,IMPORTOINDENNITA)'
      'VALUES'
      '  (:PROGRESSIVO'
      '  ,:MESESCARICO'
      '  ,:MESECOMPETENZA'
      '  ,:DATADA'
      '  ,'#39'00.00'#39
      '  ,:CODICEINDENNITAKM'
      '  ,:KMPERCORSI'
      '  ,0)')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      00000000240000003A0043004F00440049004300450049004E00440045004E00
      4E004900540041004B004D00050000000000000000000000160000003A004B00
      4D0050004500520043004F00520053004900040000000000000000000000}
    Left = 240
    Top = 144
  end
  object updM052: TOracleQuery
    SQL.Strings = (
      'update m052_indennitakm'
      'set  kmpercorsi = :kmpercorsi'
      'where progressivo = :progressivo'
      'and   mesescarico = :mesescarico'
      'and   mesecompetenza = :mesecompetenza'
      'and   datada      = :datada'
      'and   orada       = '#39'00.00'#39
      'and   codiceindennitakm = :codiceindennitakm')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      00000000240000003A0043004F00440049004300450049004E00440045004E00
      4E004900540041004B004D00050000000000000000000000160000003A004B00
      4D0050004500520043004F00520053004900040000000000000000000000}
    Left = 288
    Top = 143
  end
end
