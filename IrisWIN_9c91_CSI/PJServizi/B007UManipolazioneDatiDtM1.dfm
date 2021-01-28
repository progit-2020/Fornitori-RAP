object B007FManipolazioneDatiDtM1: TB007FManipolazioneDatiDtM1
  OldCreateOrder = True
  OnCreate = B007FCancellaDtM1Create
  OnDestroy = B007FCancellaDtM1Destroy
  Height = 376
  Width = 754
  object updI070: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I070_OPERATORI '
      'SET OCCUPATO = '#39'N'#39' '
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 16
    Top = 186
  end
  object selI010_: TOracleDataSet
    SQL.Strings = (
      'SELECT REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') NOME_CAMPO, NOME_LOGICO '
      'FROM I010_CAMPIANAGRAFICI, COLS'
      'WHERE REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') = COLUMN_NAME '
      '  AND TABLE_NAME = '#39'T430_STORICO'#39
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'PROGRESSIVO'#39' '
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'DATADECORRENZA'#39' '
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'DATAFINE'#39
      'ORDER BY NOME_LOGICO '
      ''
      '/*'
      
        '  DECODE(SUBSTR(NOME_CAMPO,1,4),'#39'T430'#39','#39'T430_STORICO'#39','#39'P430'#39','#39'P4' +
        '30_ANAGRAFICO'#39','#39#39') '
      
        '  TABELLA, REPLACE(REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39'),'#39'P430'#39','#39#39') NOME' +
        '_CAMPO, '
      '  NOME_LOGICO'
      ''
      '  AND TABLE_NAME = '#39'V430_STORICO'#39
      '  AND SUBSTR(NOME_CAMPO,5,2) <> '#39'D_'#39
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'PROGRESSIVO'#39' '
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'DATADECORRENZA'#39' '
      '  AND REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') <> '#39'DATAFINE'#39
      '  AND REPLACE(NOME_CAMPO,'#39'P430'#39','#39#39') <> '#39'PROGRESSIVO'#39' '
      '  AND REPLACE(NOME_CAMPO,'#39'P430'#39','#39#39') <> '#39'DECORRENZA'#39
      '  AND REPLACE(NOME_CAMPO,'#39'P430'#39','#39#39') <> '#39'DECORRENZA_FINE'#39
      '*/')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000140000004E004F004D0045005F00430041004D0050004F00
      010000000000160000004E004F004D0045005F004C004F004700490043004F00
      010000000000}
    Left = 80
    Top = 10
    object selI010_NOME_CAMPO: TStringField
      FieldName = 'NOME_CAMPO'
      Required = True
      Size = 40
    end
    object selI010_NOME_LOGICO: TStringField
      FieldName = 'NOME_LOGICO'
      Size = 40
    end
  end
  object dsrI010: TDataSource
    Left = 119
    Top = 10
  end
  object dsrValori: TDataSource
    Left = 25
    Top = 14
  end
  object selI500: TOracleDataSet
    SQL.Strings = (
      'select * from I500_DATILIBERI'
      'order by NOMECAMPO')
    Optimize = False
    Left = 162
    Top = 10
  end
  object updT430Domicilio: TOracleQuery
    SQL.Strings = (
      'update T430_STORICO'
      'set    :SET_COMMAND'
      'where  PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A005300450054005F0043004F004D004D004100
      4E004400010000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F00030000000000000000000000}
    Left = 80
    Top = 288
  end
  object selT430COMUNE_DOM: TOracleDataSet
    SQL.Strings = (
      
        'select T030.COGNOME,T030.NOME,T030.MATRICOLA,T430.PROGRESSIVO,T4' +
        '30.DATADECORRENZA,T430.DATAFINE,T430.INIZIO,T430.FINE,T430.:COMU' +
        'NE_DOM '
      'from T430_STORICO T430, T030_ANAGRAFICO T030'
      'where T030.PROGRESSIVO = T430.PROGRESSIVO'
      
        'and T430.COMUNE_DOM_BASE is null and T430.:COMUNE_DOM is not nul' +
        'l'
      
        'order by T030.COGNOME,T030.NOME,T030.MATRICOLA,T430.DATADECORREN' +
        'ZA')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F004D0055004E0045005F0044004F00
      4D00010000000000000000000000}
    Filtered = True
    OnFilterRecord = selT430COMUNE_DOMFilterRecord
    Left = 184
    Top = 288
  end
end
