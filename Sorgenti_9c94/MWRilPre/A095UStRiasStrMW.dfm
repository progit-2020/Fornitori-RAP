inherited A095FStRiasStrMW: TA095FStRiasStrMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 385
  object selT810: TOracleDataSet
    SQL.Strings = (
      'select valore'
      'from T810_Liquidabile'
      'where anno=:anno and'
      '           mese=:mese and'
      '           campo1=:campo1 and'
      '           campo2=:campo2'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D004500530045000300000000000000000000000E000000
      3A00430041004D0050004F0031000500000000000000000000000E0000003A00
      430041004D0050004F003200050000000000000000000000}
    Left = 162
    Top = 72
    object selT810VALORE: TStringField
      FieldName = 'VALORE'
      Origin = 'T810_LIQUIDABILE.VALORE'
      Size = 7
    end
  end
  object selT800_data: TOracleDataSet
    SQL.Strings = (
      'select NomeCampo1,Nomecampo2'
      'from T800_campilimiti'
      'where datadecorr=(Select Max(DataDecorr) '
      '                               from T800_campilimiti '
      '                              where datadecorr <= :data'
      '                              and TipoLimite=:Tipo)'
      ' and Tipolimite=:Tipo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      00000A0000003A005400490050004F00050000000000000000000000}
    Left = 106
    Top = 72
    object selT800_dataNOMECAMPO1: TStringField
      FieldName = 'NOMECAMPO1'
    end
    object selT800_dataNOMECAMPO2: TStringField
      FieldName = 'NOMECAMPO2'
    end
  end
  object selT811: TOracleDataSet
    SQL.Strings = (
      'select valore'
      'from T811_Residuabile'
      'where anno=:anno and'
      '           mese=:mese and'
      '           campo1=:campo1 and'
      '           campo2=:campo2'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D004500530045000300000000000000000000000E000000
      3A00430041004D0050004F0031000500000000000000000000000E0000003A00
      430041004D0050004F003200050000000000000000000000}
    Left = 205
    Top = 72
    object selT811VALORE: TStringField
      FieldName = 'VALORE'
      Origin = 'T811_RESIDUABILE.VALORE'
      Size = 7
    end
  end
  object selT075: TOracleDataSet
    SQL.Strings = (
      'select sum(oreminuti(orestraord)) mm'
      'from t075_stresterno'
      'where progressivo=:progr and'
      '           data=:data')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A00500052004F00470052000300000000000000
      000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 249
    Top = 72
  end
  object selT820: TOracleDataSet
    SQL.Strings = (
      'select liquidabile, residuabile'
      'from T820_LimitiInd'
      'where anno=:anno and'
      '           mese=:mese and'
      '           progressivo=:progr')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D004500530045000300000000000000000000000C000000
      3A00500052004F0047005200030000000000000000000000}
    Left = 294
    Top = 72
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'SELECT PROGRESSIVO, SUM(OREMINUTI(LIQUIDNELMESE)) LIQUID'
      '  FROM T071_SCHEDAFASCE '
      ' WHERE DATA = :DATA'
      ':FILTRO'
      'GROUP BY PROGRESSIVO'
      'HAVING SUM(OREMINUTI(LIQUIDNELMESE)) > 0')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000
      160000003A0044004100540041004C00410056004F0052004F000C0000000000
      000000000000}
    Left = 338
    Top = 72
  end
  object selT071_Data: TOracleQuery
    SQL.Strings = (
      'SELECT MAX(DATA) FROM T071_SCHEDAFASCE WHERE'
      'DATA BETWEEN '
      '  TO_DATE('#39'0101'#39'||TO_CHAR(:DATALAVORO,'#39'YYYY'#39'),'#39'DDMMYYYY'#39') AND  '
      '  TO_DATE('#39'3112'#39'||TO_CHAR(:DATALAVORO,'#39'YYYY'#39'),'#39'DDMMYYYY'#39') AND'
      '  OREMINUTI(LIQUIDNELMESE) > 0'
      ':FILTRO')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      000000000000160000003A0044004100540041004C00410056004F0052004F00
      0C0000000000000000000000}
    Left = 200
    Top = 12
  end
  object updT071: TOracleQuery
    SQL.Strings = (
      'UPDATE T071_SCHEDAFASCE '
      
        'SET LIQUIDNELMESE = MINUTIORE(OREMINUTI(LIQUIDNELMESE) + :LIQUID' +
        'NELMESE)'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA AND'
      'CODFASCIA = :CODFASCIA')
    Optimize = False
    Variables.Data = {
      04000000040000001C0000003A004C00490051005500490044004E0045004C00
      4D00450053004500030000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F000300000000000000000000000A000000
      3A0044004100540041000C0000000000000000000000140000003A0043004F00
      4400460041005300430049004100050000000000000000000000}
    Left = 108
    Top = 12
  end
  object QCols: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME,DATA_LENGTH FROM COLS'
      'WHERE TABLE_NAME IN ('#39'T030_ANAGRAFICO'#39','#39'V430_STORICO'#39')')
    ReadBuffer = 100
    Optimize = False
    Left = 20
    Top = 12
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 28
    Top = 72
  end
end
