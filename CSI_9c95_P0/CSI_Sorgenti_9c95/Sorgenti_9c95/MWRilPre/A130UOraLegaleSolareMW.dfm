inherited A130FOraLegaleSolareMW: TA130FOraLegaleSolareMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 216
  Width = 338
  object selT100: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  T030.MATRICOLA,T030.COGNOME|| '#39' '#39' ||T030.NOME NOMINATIVO,T100.' +
        'DATA,'
      
        '  TO_CHAR(T100.ORA,'#39'HH24.MI'#39') ORA,TO_CHAR((T100.ORA + DECODE(:MI' +
        'NUTI,23,-1,25,1,0)/24),'#39'HH24.MI'#39') NEWORA,'
      
        '  T100.VERSO,T100.RILEVATORE,T100.CAUSALE,T100.FLAG,T100.PROGRES' +
        'SIVO, T100.ROWID'
      'FROM T100_TIMBRATURE T100,T030_ANAGRAFICO T030'
      'WHERE '
      
        'T030.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe) A' +
        'ND'
      'T100.PROGRESSIVO=T030.PROGRESSIVO AND'
      'T100.FLAG IN ('#39'O'#39','#39'I'#39') AND'
      'T100.DATA BETWEEN :DATADA AND :DATAA AND'
      
        'T100.Ora BETWEEN TO_DATE('#39'01/01/1900 '#39' || decode(T100.DATA,:DATA' +
        'DA,:ORADA,'#39'00.00'#39'),'#39'DD/MM/YYYY HH24.MI'#39') AND'
      
        '                 TO_DATE('#39'01/01/1900 '#39' || decode(T100.DATA,:DATA' +
        'A,:ORAA,'#39'23.59'#39'),'#39'DD/MM/YYYY HH24.MI'#39')'
      ':OROLOGI'
      'ORDER BY T100.DATA,T100.ORA')
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A004400410054004100440041000C0000000700
      000078650101010101000000000C0000003A004F005200410044004100050000
      000600000030332E303000000000000C0000003A00440041005400410041000C
      000000070000007865011F010101000000000A0000003A004F00520041004100
      050000000600000030352E30300000000000100000003A004F0052004F004C00
      4F00470049000100000000000000000000000E0000003A004D0049004E005500
      5400490003000000040000003C00000000000000200000003A00430037003000
      3000530045004C0041004E004100470052004100460045000100000000000000
      00000000}
    Left = 24
    Top = 32
    object selT100MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 12
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT100NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 40
    end
    object selT100DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selT100ORA: TStringField
      DisplayLabel = 'Ora originale'
      FieldName = 'ORA'
      Size = 5
    end
    object selT100ORANEW: TStringField
      DisplayLabel = 'Ora modificata'
      FieldName = 'NEWORA'
      Size = 5
    end
    object selT100VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object selT100RILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selT100CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT100FLAG: TStringField
      FieldName = 'FLAG'
      Visible = False
      Size = 1
    end
    object selT100PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'SELECT T361.* '
      '  FROM T361_OROLOGI T361'
      ' WHERE T361.FUNZIONE IN ('#39'E'#39',:TOROLOGIO)')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0054004F0052004F004C004F00470049004F00
      050000000000000000000000}
    Left = 80
    Top = 32
  end
  object selT370: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.MATRICOLA,T030.COGNOME|| '#39' '#39' ||T030.NOME NOMINATIVO,' +
        'T370.DATA,'
      
        '       TO_CHAR(T370.ORA,'#39'HH24.MI'#39') ORA,TO_CHAR((T370.ORA + DECOD' +
        'E(:MINUTI,23,-1,25,1,0)/24),'#39'HH24.MI'#39') NEWORA,'
      
        '       T370.VERSO,T370.RILEVATORE,T370.CAUSALE,T370.FLAG,T370.PR' +
        'OGRESSIVO, T370.ROWID'
      '  FROM T370_TIMBMENSA T370,T030_ANAGRAFICO T030'
      
        ' WHERE T030.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnag' +
        'rafe) '
      '   AND T370.PROGRESSIVO=T030.PROGRESSIVO '
      '   AND T370.FLAG IN ('#39'O'#39','#39'I'#39') '
      '   AND T370.DATA BETWEEN :DATADA AND :DATAA '
      
        '   AND T370.ORA BETWEEN TO_DATE('#39'01/01/1900 '#39' || DECODE(T370.DAT' +
        'A,:DATADA,:ORADA,'#39'00.00'#39'),'#39'DD/MM/YYYY HH24.MI'#39') '
      
        '   AND TO_DATE('#39'01/01/1900 '#39' || DECODE(T370.DATA,:DATAA,:ORAA,'#39'2' +
        '3.59'#39'),'#39'DD/MM/YYYY HH24.MI'#39')'
      '   :OROLOGI'
      ' ORDER BY T370.DATA,T370.ORA')
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A004D0049004E00550054004900030000000000
      000000000000200000003A004300370030003000530045004C0041004E004100
      470052004100460045000100000000000000000000000E0000003A0044004100
      54004100440041000C00000000000000000000000C0000003A00440041005400
      410041000C00000000000000000000000C0000003A004F005200410044004100
      0500000000000000000000000A0000003A004F00520041004100050000000000
      000000000000100000003A004F0052004F004C004F0047004900010000000000
      000000000000}
    Left = 24
    Top = 80
    object selT370MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 12
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT370NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 40
    end
    object selT370DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selT370ORA: TStringField
      DisplayLabel = 'Ora originale'
      FieldName = 'ORA'
      Size = 5
    end
    object selT370NEWORA: TStringField
      DisplayLabel = 'Ora modificata'
      FieldName = 'NEWORA'
      Size = 5
    end
    object selT370VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object selT370RILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selT370CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT370FLAG: TStringField
      FieldName = 'FLAG'
      Visible = False
      Size = 1
    end
    object selT370PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object Update: TOracleQuery
    SQL.Strings = (
      'UPDATE :TABELLA T'
      '   SET T.DATA = :DATA,'
      '       T.ORA = TO_DATE(:ORA,'#39'DD/MM/YYYY HH24.MI'#39')'
      ' WHERE T.ROWID = :RI')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0054004100420045004C004C00410001000000
      00000000000000000A0000003A0044004100540041000C000000000000000000
      0000080000003A004F0052004100050000000000000000000000060000003A00
      52004900050000000000000000000000}
    Left = 136
    Top = 32
  end
  object selTSalva: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,T.ROWID '
      '  FROM :TABELLA T')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410001000000
      0000000000000000}
    Left = 200
    Top = 32
  end
  object dscSelT100: TDataSource
    Left = 80
    Top = 88
  end
end
