inherited A047FTimbMensaMW: TA047FTimbMensaMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 392
  object Q012: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from   T012_CalendIndivid '
      'where  Progressivo = :Progressivo '
      'and    Data BETWEEN :DataInizio AND :DataFine '
      'ORDER BY Data')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 40
    Top = 16
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       * '
      'from   T040_GIUSTIFICATIVI'
      'where  PROGRESSIVO = :Progressivo '
      'and    DATA between :DataInizio and :DataFine'
      'order by DATA, CAUSALE, PROGRCAUSALE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 88
    Top = 16
  end
  object Q370: TOracleDataSet
    SQL.Strings = (
      'select T370.*,T370.ROWID '
      'from   T370_TIMBMENSA T370'
      'where  PROGRESSIVO = :Progressivo '
      'and    DATA BETWEEN :DataInizio AND :DataFine'
      'and    (FLAG = '#39'O'#39' or FLAG = '#39'I'#39')'
      'order by DATA,ORA,VERSO,FLAG'
      '')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    BeforePost = Q370BeforePost
    AfterPost = Q370AfterPost
    BeforeDelete = Q370BeforeDelete
    OnNewRecord = Q370NewRecord
    Left = 136
    Top = 16
    object Q370PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T370_TIMBMENSA.PROGRESSIVO'
    end
    object Q370DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T370_TIMBMENSA.DATA'
      DisplayFormat = 'dd/mm/yy'
      EditMask = '!99/99/00;1;_'
    end
    object Q370ORA: TDateTimeField
      FieldName = 'ORA'
      Origin = 'T370_TIMBMENSA.ORA'
      OnGetText = Q370ORAGetText
      OnSetText = Q370ORASetText
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object Q370VERSO: TStringField
      FieldName = 'VERSO'
      Origin = 'T370_TIMBMENSA.VERSO'
      Size = 1
    end
    object Q370FLAG: TStringField
      FieldName = 'FLAG'
      Origin = 'T370_TIMBMENSA.FLAG'
      Size = 1
    end
    object Q370RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Origin = 'T370_TIMBMENSA.RILEVATORE'
      Size = 2
    end
    object Q370CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Origin = 'T370_TIMBMENSA.CAUSALE'
      Size = 5
    end
  end
  object D370: TDataSource
    AutoEdit = False
    DataSet = Q370
    Left = 164
    Top = 16
  end
  object selT375: TOracleDataSet
    SQL.Strings = (
      'SELECT T375.*,T375.ROWID FROM T375_ACCESSIMENSA T375'
      'WHERE PROGRESSIVO = :Progressivo and '
      '      DATA BETWEEN :DataInizio AND :DataFine'
      'ORDER BY DATA,DECODE(PRANZOCENA,'#39'P'#39',1,2), CAUSALE'
      '')
    ReadBuffer = 62
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 223
    Top = 16
  end
  object Q011: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from   T011_Calendari  '
      'where  Codice = :Codice '
      'and    DATA between :DataInizio and :DataFine'
      'order by DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A00440041005400410049004E0049005A0049004F00
      0C0000000000000000000000120000003A004400410054004100460049004E00
      45000C0000000000000000000000}
    Left = 12
    Top = 16
  end
  object D265: TDataSource
    DataSet = Q265
    Left = 40
    Top = 64
  end
  object D305: TDataSource
    DataSet = Q305
    Left = 116
    Top = 64
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      'FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 12
    Top = 64
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      'FROM T305_CAUGIUSTIF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 88
    Top = 64
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE, DESCRIZIONE, ARROT_RIEPGG, LINK_ASSENZA, UM_INSER' +
        'IMENTO_H, UM_INSERIMENTO_D'
      'FROM   T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 154
    Top = 64
  end
  object D275: TDataSource
    DataSet = Q275
    Left = 186
    Top = 63
  end
  object DOrologi: TDataSource
    DataSet = QOrologi
    Left = 270
    Top = 64
  end
  object QOrologi: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      'FROM   T361_OROLOGI T361 '
      'WHERE FUNZIONE IN ('#39'M'#39','#39'E'#39')'
      'ORDER BY CODICE'
      '')
    Optimize = False
    OnFilterRecord = QOrologiFilterRecord
    Left = 226
    Top = 64
  end
  object scrRipristinoOriginali: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  DELETE FROM T370_TIMBMENSA WHERE PROGRESSIVO = :PROGRESSIVO AN' +
        'D DATA BETWEEN :DAL AND :AL AND FLAG = '#39'I'#39';'
      
        '  UPDATE T370_TIMBMENSA SET FLAG = '#39'O'#39' WHERE PROGRESSIVO = :PROG' +
        'RESSIVO AND DATA BETWEEN :DAL AND :AL AND FLAG IN ('#39'M'#39','#39'C'#39');'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 84
    Top = 112
  end
end
