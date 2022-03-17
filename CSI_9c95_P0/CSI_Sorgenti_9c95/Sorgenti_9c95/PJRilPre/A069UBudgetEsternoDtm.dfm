inherited A069FBudgetEsternoDtm: TA069FBudgetEsternoDtm
  OldCreateOrder = True
  Height = 151
  Width = 326
  object selT710: TOracleDataSet
    SQL.Strings = (
      'select T710.*, T710.rowid'
      '  from T710_BUDGETESTERNO_ANNUO T710'
      ' where T710.ANNO = :ANNO'
      
        '   and (lpad(T710.CAPITOLO,10,'#39'0'#39'), lpad(T710.ARTICOLO,10,'#39'0'#39')) ' +
        'in '
      
        '       (select /* unnest */ lpad(T430:CAMPORAGRR1,10,'#39'0'#39'),lpad(T' +
        '430:CAMPORAGRR2,10,'#39'0'#39') from :C700SELANAGRAFE)'
      ' order by T710.CAPITOLO, T710.ARTICOLO, T710.COEL')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00430041004D0050004F005200410047005200520031000100
      00000000000000000000180000003A00430041004D0050004F00520041004700
      520052003200010000000000000000000000200000003A004300370030003000
      530045004C0041004E0041004700520041004600450001000000000000000000
      0000}
    CommitOnPost = False
    CachedUpdates = True
    BeforeInsert = selT710BeforeInsert
    AfterPost = AfterPost
    BeforeDelete = selT710BeforeDelete
    OnCalcFields = selT710CalcFields
    OnNewRecord = selT710NewRecord
    Left = 14
    Top = 8
    object selT710ANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Visible = False
    end
    object selT710CAPITOLO: TStringField
      DisplayLabel = 'Capitolo'
      FieldName = 'CAPITOLO'
      ReadOnly = True
      Size = 15
    end
    object selT710ARTICOLO: TStringField
      DisplayLabel = 'Articolo'
      FieldName = 'ARTICOLO'
      ReadOnly = True
      Size = 15
    end
    object selT710COEL: TStringField
      DisplayLabel = 'Coel'
      FieldName = 'COEL'
      ReadOnly = True
      Size = 15
    end
    object selT710STANZIAMENTO: TFloatField
      DisplayLabel = 'Stanziamento'
      FieldName = 'STANZIAMENTO'
      ReadOnly = True
    end
    object selT710DISPONIBILITA: TFloatField
      DisplayLabel = 'Impegnato'
      FieldName = 'DISPONIBILITA'
      ReadOnly = True
    end
    object selT710VARIAZIONE: TFloatField
      DisplayLabel = 'Variazione'
      FieldName = 'VARIAZIONE'
    end
    object selT710DECORRENZA_VARIAZIONE: TDateTimeField
      DisplayLabel = 'Decorrenza variazione'
      DisplayWidth = 15
      FieldName = 'DECORRENZA_VARIAZIONE'
      EditMask = '!99/99/0000;1;_'
    end
    object selT710SCADENZA_VARIAZIONE: TDateTimeField
      DisplayLabel = 'Scadenza variazione'
      DisplayWidth = 15
      FieldName = 'SCADENZA_VARIAZIONE'
      EditMask = '!99/99/0000;1;_'
    end
    object selT710UTILIZZO: TFloatField
      FieldName = 'UTILIZZO'
      Visible = False
    end
    object selT710C_UTILIZZO: TFloatField
      DisplayLabel = 'Utilizzo'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'C_UTILIZZO'
      Calculated = True
    end
  end
  object insT710: TOracleQuery
    SQL.Strings = (
      'begin '
      '  update T710_BUDGETESTERNO_ANNUO set'
      '    STANZIAMENTO = :STANZIAMENTO,'
      '    DISPONIBILITA = :DISPONIBILITA'
      '  where ANNO = :ANNO'
      '  and CAPITOLO = :CAPITOLO'
      '  and ARTICOLO = :ARTICOLO'
      '  and COEL = :COEL;'
      '  '
      '  if sql%rowcount = 0 then'
      '    insert into T710_BUDGETESTERNO_ANNUO '
      '      (ANNO,CAPITOLO,ARTICOLO,COEL,STANZIAMENTO,DISPONIBILITA)'
      '    values '
      
        '      (:ANNO,:CAPITOLO,:ARTICOLO,:COEL,:STANZIAMENTO,:DISPONIBIL' +
        'ITA);'
      '  end if;'
      '  commit;  '
      'end;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0041004E004E004F0003000000000000000000
      00001A0000003A005300540041004E005A00490041004D0045004E0054004F00
      0400000000000000000000001C0000003A0044004900530050004F004E004900
      420049004C00490054004100040000000000000000000000120000003A004300
      41005000490054004F004C004F00030000000000000000000000120000003A00
      410052005400490043004F004C004F000300000000000000000000000A000000
      3A0043004F0045004C00050000000000000000000000}
    Left = 70
    Top = 7
  end
  object selLiquidazioni: TOracleDataSet
    SQL.Strings = (
      'select :HINTT030V430'
      '       CAMPORAGRR1, '
      '       CAMPORAGRR2, '
      '       round(sum(MONETIZZAZIONE),2) MONETIZZAZIONE'
      'from ('
      'select :HINTT030V430'
      '       lpad(T430.:CAMPORAGRR1,10,'#39'0'#39') CAMPORAGRR1, '
      '       lpad(T430.:CAMPORAGRR2,10,'#39'0'#39') CAMPORAGRR2, '
      
        '       --oreminuti(decode(T275.ABBATTE_BUDGET,'#39'L'#39',T074.LIQUIDATO' +
        ','#39'M'#39',T074.OREPRESENZA))/60 * T430.:COSTO_ORARIO * (1 + T074.MAGG' +
        'IORAZIONE/100) MONETIZZAZIONE'
      
        '       oreminuti(T074.OREPRESENZA)/60 * T430.:COSTO_ORARIO * (1 ' +
        '+ T074.MAGGIORAZIONE/100) MONETIZZAZIONE'
      
        '  from T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275, T430_STOR' +
        'ICO T430'
      
        ' where (T430.:CAMPORAGRR1,T430.:CAMPORAGRR2) in (select /*+ unne' +
        'st*/ T430:CAMPORAGRR1,T430:CAMPORAGRR2 from :C700SELANAGRAFE)'
      '   and T074.PROGRESSIVO = T430.PROGRESSIVO'
      '   and T074.DATA between trunc(:DATACORR,'#39'yyyy'#39') and :DATACORR'
      
        '   and last_day(T074.DATA) between T430.DATADECORRENZA and T430.' +
        'DATAFINE'
      '   and T275.CODICE = T074.CAUSALE '
      '   and T275.ABBATTE_BUDGET in ('#39'L'#39','#39'M'#39')'
      'union all'
      'select :HINTT030V430'
      '       lpad(T430.:CAMPORAGRR1,10,'#39'0'#39') CAMPORAGRR1, '
      '       lpad(T430.:CAMPORAGRR2,10,'#39'0'#39') CAMPORAGRR2, '
      
        '       oreminuti(T071.LIQUIDNELMESE)/60 * T430.:COSTO_ORARIO * (' +
        '1 + T071.MAGGIORAZIONE/100) MONETIZZAZIONE'
      '  from T071_SCHEDAFASCE T071, T430_STORICO T430'
      
        ' where (T430.:CAMPORAGRR1,T430.:CAMPORAGRR2) in (select /*+ unne' +
        'st*/ T430:CAMPORAGRR1,T430:CAMPORAGRR2 from :C700SELANAGRAFE)'
      '   and T071.PROGRESSIVO = T430.PROGRESSIVO'
      '   and T071.DATA between trunc(:DATACORR,'#39'yyyy'#39') and :DATACORR'
      
        '   and last_day(T071.DATA) between T430.DATADECORRENZA and T430.' +
        'DATAFINE'
      ')'
      'group by CAMPORAGRR1, CAMPORAGRR2'
      'order by CAMPORAGRR1, CAMPORAGRR2')
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A00480049004E00540054003000330030005600
      3400330030000100000000000000000000001A0000003A0043004F0053005400
      4F005F004F0052004100520049004F0001000000000000000000000020000000
      3A004300370030003000530045004C0041004E00410047005200410046004500
      010000000000000000000000120000003A00440041005400410043004F005200
      52000C0000000000000000000000180000003A00430041004D0050004F005200
      41004700520052003100010000000000000000000000180000003A0043004100
      4D0050004F00520041004700520052003200010000000000000000000000}
    Left = 189
    Top = 7
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct :CAMPI_BUDGET'
      '  from T430_STORICO'
      'where to_date('#39'0101'#39'||:ANNO,'#39'ddmmyyyy'#39') <= DATAFINE'
      'and to_date('#39'3112'#39'||:ANNO,'#39'ddmmyyyy'#39') >= DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A00430041004D00500049005F00420055004400
      4700450054000100000000000000000000000A0000003A0041004E004E004F00
      050000000000000000000000}
    Left = 261
    Top = 7
  end
  object updT710: TOracleQuery
    SQL.Strings = (
      'update T710_BUDGETESTERNO_ANNUO set UTILIZZO = null')
    Optimize = False
    Left = 126
    Top = 7
  end
end
