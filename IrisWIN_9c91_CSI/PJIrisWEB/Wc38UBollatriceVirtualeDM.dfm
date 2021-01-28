object Wc38FBollatriceVirtualeDM: TWc38FBollatriceVirtualeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 147
  Width = 244
  object selT100: TOracleDataSet
    SQL.Strings = (
      'select T100.DATA, TO_CHAR(T100.ORA,'#39'HH24.MI'#39') as ORA, '
      
        '       T100.CAUSALE, rpad(T100.CAUSALE,5,'#39' '#39') ||'#39' '#39'|| nvl(T275.D' +
        'ESCRIZIONE,T305.DESCRIZIONE) DESC_CAUSALE,'
      
        '       T100.VERSO, DECODE(T100.VERSO,'#39'E'#39','#39'Entrata'#39','#39'U'#39','#39'Uscita'#39')' +
        ' DESC_VERSO,'#13#10#10
      '       T100.PROGRESSIVO, T100.FLAG, '
      '       T100.RILEVATORE,'
      '       T100.RILEVATORE||'#39' '#39'||T361.DESCRIZIONE DESC_RILEVATORE,'
      '       T100.ROWID, '
      
        '       T030.MATRICOLA, T030.COGNOME || '#39' '#39' || T030.NOME as NOMIN' +
        'ATIVO'
      
        'from   T100_TIMBRATURE T100, T030_ANAGRAFICO T030, T275_CAUPRESE' +
        'NZE T275, T305_CAUGIUSTIF T305, T361_OROLOGI T361'
      'where  T100.PROGRESSIVO = :PROGRESSIVO'
      'and    T100.DATA = :DATA'
      'and    T100.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T100.FLAG IN ('#39'O'#39','#39'I'#39')'
      'and    T100.CAUSALE = T275.CODICE(+)'
      'and    T100.CAUSALE = T305.CODICE(+)'
      'and    T100.RILEVATORE = T361.CODICE(+)'
      'order by T100.ORA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 34
    Top = 14
    object selT100DATA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selT100ORA: TStringField
      DisplayLabel = 'Ora'
      FieldName = 'ORA'
      Size = 5
    end
    object selT100VERSO: TStringField
      FieldName = 'VERSO'
      Visible = False
      Size = 1
    end
    object selT100DESC_VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'DESC_VERSO'
      Size = 7
    end
    object selT100FLAG: TStringField
      FieldName = 'FLAG'
      Visible = False
      Size = 1
    end
    object selT100CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT100DESC_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'DESC_CAUSALE'
      Size = 40
    end
    object selT100RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Visible = False
      Size = 2
    end
    object selT100DESC_RILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'DESC_RILEVATORE'
      Size = 50
    end
    object selT100MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Visible = False
      Size = 8
    end
    object selT100NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Visible = False
      Size = 65
    end
    object selT100MOTIVAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'MOTIVAZIONE'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT100PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT100NOTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
      Calculated = True
    end
  end
  object insT100: TOracleQuery
    SQL.Strings = (
      
        'insert into T100_TIMBRATURE(PROGRESSIVO,DATA,ORA,VERSO,CAUSALE,F' +
        'LAG,RILEVATORE)'
      
        'values (:PROGRESSIVO, :DATA, TO_DATE('#39'01/01/1900 '#39' || :ORA,'#39'DD/M' +
        'M/YYYY HH24.MI.SS'#39'), :VERSO, :CAUSALE, :FLAG,:RILEVATORE) ')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000000A00
      00003A0046004C0041004700050000000000000000000000160000003A005200
      49004C0045005600410054004F00520045000500000000000000000000001000
      00003A00430041005500530041004C004500050000000000000000000000}
    Left = 104
    Top = 16
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select CODICE,INDIRIZZO_IP,INDIRIZZO '
      'from T361_OROLOGI '
      'where INDIRIZZO_IP is not null '
      'or INDIRIZZO is not null')
    Optimize = False
    Left = 32
    Top = 80
  end
  object selVT100TimbPrec: TOracleDataSet
    SQL.Strings = (
      'select VT100.*'
      'from   VT100_TIMB_DATAORA VT100'
      'where  VT100.PROGRESSIVO = :PROGRESSIVO'
      'and    VT100.DATAORA = (select max(DATAORA)'
      '                        from   VT100_TIMB_DATAORA'
      '                        where  PROGRESSIVO = VT100.PROGRESSIVO'
      '                        and    DATAORA < :DATA_TIMB)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      540049004D0042000C0000000000000000000000}
    Left = 104
    Top = 80
  end
  object selT275Abilitate: TOracleDataSet
    SQL.Strings = (
      'select '#39'T275'#39' TIPO, T275.CODICE, T275.DESCRIZIONE'
      'from   T275_CAUPRESENZE T275, T430_STORICO T430'
      'where  T430.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        'and    instr('#39','#39'||T430.ABPRESENZA1||'#39','#39','#39','#39'||T275.CODRAGGR||'#39','#39')' +
        ' > 0'
      'union '
      'select '#39'T305'#39' TIPO, T305.CODICE, T305.DESCRIZIONE'
      'from   T305_CAUGIUSTIF T305, T300_RAGGRGIUSTIF T300'
      'where  T305.CODRAGGR = T300.CODICE'
      'and    T300.CODINTERNO = '#39'B'#39
      'order by 2')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Filtered = True
    OnFilterRecord = selT275AbilitateFilterRecord
    Left = 173
    Top = 16
  end
end
