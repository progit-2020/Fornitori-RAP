inherited A027FCarMenDtM: TA027FCarMenDtM
  OldCreateOrder = True
  Height = 359
  Width = 607
  object selT065: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '  T065_ID.ORE_DESTINATE,T030.PROGRESSIVO,T030.MATRICOLA,T030.COG' +
        'NOME||'#39' '#39'||T030.NOME NOME,T065.DATA,T065.ID,T065.STATO,T065.TIPO' +
        '_RICHIESTA,T065.COD_ITER,T430.CONTRATTO, '
      
        '  lpad(minutiore(USR_T050F_ORERICHIESTE_MESE(T065.PROGRESSIVO,US' +
        'R_CONST.cAUTST,T065.DATA,'#39'A'#39')),5,'#39'0'#39') ORE_AUTORIZZATE,'
      
        '  T065.ORE_ECCEDENTI,T065.ORE_DALIQUIDARE,T065.ORE_DACOMPENSARE,' +
        'decode(T180F_STATORIEPILOGO('#39'T195'#39',T030.PROGRESSIVO,add_months(t' +
        'runc(sysdate,'#39'mm'#39'),-1)),'#39'C'#39','#39'Si'#39',null) ANOMALIA'
      'from ('
      '  -- da destinare'
      '  select '#39'N'#39' ORE_DESTINATE,T065.ID'
      
        '    from T065_RICHIESTESTRAORDINARI T065, T850_ITER_RICHIESTE T8' +
        '50 '
      '    where T065.DATA <= :DATA'
      '    and T065.ID = T850.ID'
      '    and T850.STATO is null'
      '    and T850.ID >= 0'
      '  union'
      '  --destinate'
      '  select '#39'S'#39' ORE_DESTINATE,T065.ID'
      
        '    from T065_RICHIESTESTRAORDINARI T065, T850_ITER_RICHIESTE T8' +
        '50'
      '    where T065.DATA <= :DATA'
      '    and T065.ID = T850.ID'
      '    and T850.STATO = '#39'S'#39
      '    and COD_ITER = '#39'DEFAULT'#39
      '    and T850.TIPO_RICHIESTA = '#39'S'#39
      '    and T850.ID >= 0'
      '  union'
      '  --gi'#224' liquidate'
      '  select '#39'L'#39' ORE_DESTINATE,T065.ID'
      
        '    from T065_RICHIESTESTRAORDINARI T065, T850_ITER_RICHIESTE T8' +
        '50'
      '    where T065.DATA = :DATA'
      '    and T065.ID = T850.ID'
      '    and T850.STATO = '#39'S'#39
      '    and T850.TIPO_RICHIESTA = '#39'L'#39
      '    and T850.ID >= 0'
      '  union'
      '  --destinazione successiva'
      '  select '#39'D'#39' ORE_DESTINATE,T065.ID'
      
        '    from T065_RICHIESTESTRAORDINARI T065, T850_ITER_RICHIESTE T8' +
        '50'
      
        '    where (T065.MESE_RIFERIMENTO = :DATA or (T850.TIPO_RICHIESTA' +
        ' = '#39'R'#39' and T065.DATA <= :DATA))'
      '    and T065.ID = T850.ID'
      '    --and T850.STATO = '#39'S'#39
      '    --and T850.TIPO_RICHIESTA = '#39'L'#39
      '    and T850.ID < 0'
      
        ') T065_ID, VT065_RICHIESTESTRAORDINARI T065, T030_ANAGRAFICO T03' +
        '0, T430_STORICO T430'
      'where T065_ID.ID = T065.ID'
      'and   T065.PROGRESSIVO = T030.PROGRESSIVO'
      'and   T065.PROGRESSIVO = T430.PROGRESSIVO'
      
        'and   last_day(T065.DATA) between T430.DATADECORRENZA and T430.D' +
        'ATAFINE'
      'order by T030.COGNOME,T030.NOME,T030.MATRICOLA,T065.DATA')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Filtered = True
    OnCalcFields = selT065CalcFields
    OnFilterRecord = selT065FilterRecord
    Left = 32
    Top = 16
    object selT065DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selT065ORE_DESTINATE: TStringField
      DisplayLabel = 'Ore destinate'
      FieldName = 'ORE_DESTINATE'
      Size = 1
    end
    object selT065PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT065MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT065NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 40
      FieldName = 'NOME'
      Size = 80
    end
    object selT065CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      FieldName = 'CONTRATTO'
      Size = 40
    end
    object selT065ID: TFloatField
      DisplayWidth = 8
      FieldName = 'ID'
    end
    object selT065ORE_AUTORIZZATE: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'ORE_AUTORIZZATE'
      Size = 6
    end
    object selT065ORE_ECCEDENTI: TStringField
      DisplayLabel = 'Destinabile'
      FieldName = 'ORE_ECCEDENTI'
      Size = 6
    end
    object selT065ORE_DALIQUIDARE: TStringField
      DisplayLabel = 'In pagamento'
      FieldName = 'ORE_DALIQUIDARE'
      Size = 6
    end
    object selT065ORE_DACOMPENSARE: TStringField
      DisplayLabel = 'In banca ore'
      FieldName = 'ORE_DACOMPENSARE'
      Size = 6
    end
    object selT065STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selT065TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo richiesta'
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selT065COD_ITER: TStringField
      DisplayLabel = 'Struttura iter'
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selT065ANOMALIA: TStringField
      DisplayLabel = 'Anomalia'
      FieldName = 'ANOMALIA'
      Visible = False
      Size = 2
    end
    object selT065C_ANOMALIA: TStringField
      DisplayLabel = 'Anomalia'
      FieldKind = fkCalculated
      FieldName = 'C_ANOMALIA'
      Visible = False
      Size = 2
      Calculated = True
    end
  end
  object dsrT065: TDataSource
    DataSet = selT065
    Left = 32
    Top = 64
  end
  object USR_T065PCK_GESTSTRAORD_ESEGUILIQUIDAZIONE: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.ESEGUILIQUIDAZIONE(:ID);'
      'end;')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 350
    Top = 16
  end
  object USR_T065PCK_GESTSTRAORD_ANNULLALIQUIDAZIONE: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.ANNULLALIQUIDAZIONE(:ID);'
      'end;')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 350
    Top = 64
  end
  object USR_T065PCK_GESTSTRAORD_ANNULLADESTINAZIONE: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.ANNULLADESTINAZIONE(:ID);'
      'end;')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 350
    Top = 112
  end
  object USR_T065PCK_GESTSTRAORD_ANNULLATAGLIOBAO: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.ANNULLATAGLIOBAO(:ID);'
      'end;')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 350
    Top = 160
  end
  object selT102OreNotturne: TOracleDataSet
    SQL.Strings = (
      '--ore notturne gi'#224' liquidate'
      
        'select T030.MATRICOLA,T030.COGNOME||'#39' '#39'||T030.NOME NOME,T102.PRO' +
        'GRESSIVO,minutiore(sum(T102.ALLE-T102.DALLE)) ORE_NOTTURNE,'#39'S'#39' L' +
        'IQUIDATO '
      'from T102_DATIGG T102, T030_ANAGRAFICO T030, T430_STORICO T430'
      'where T102.MESE_RIEPILOGO = :MESE_RIEPILOGO'
      'and T102.PROGRESSIVO = T030.PROGRESSIVO'
      'and T102.DATO = USR_CONST.cRIEPPRESEU'
      'and T102.CAUSALE = USR_CONST.cMGGNT'
      'and T102.PROGRESSIVO = T430.PROGRESSIVO'
      'and T102.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and  nvl(T430.FLAG_TIMBRA,'#39'nullo'#39') <> '#39'0'#39
      
        'and not exists (select '#39'x'#39' from T065_RICHIESTESTRAORDINARI where' +
        ' PROGRESSIVO = T030.PROGRESSIVO and DATA = :MESE_RIEPILOGO)'
      'group by T030.MATRICOLA,T030.COGNOME,T030.NOME,T102.PROGRESSIVO'
      ''
      'union'
      ''
      '--ore notturne ancora da liquidare'
      
        'select MATRICOLA,COGNOME||'#39' '#39'||NOME NOME,PROGRESSIVO,minutiore(s' +
        'um(ORE_NOTTURNE)) ORE_NOTTURNE,'#39'N'#39' LIQUIDATO from'
      '('
      
        '  select T030.MATRICOLA,T030.COGNOME,T030.NOME,T102.PROGRESSIVO,' +
        'T102.DATA,sum(T102.ALLE-T102.DALLE) ORE_NOTTURNE from'
      '  ('
      '    select '
      '      PROGRESSIVO,DATA,'
      
        '      greatest(to_number(DALLE),1320) DALLE, to_number(ALLE) ALL' +
        'E'
      '    from T102_DATIGG T102'
      '    where T102.MESE_RIEPILOGO = :MESE_RIEPILOGO'
      '    and T102.DATO = USR_CONST.cRIEPPRESEU'
      
        '    and nvl(T102.CAUSALE,USR_CONST.cSTAUT) not in (USR_CONST.cST' +
        'PAG,USR_CONST.cSTBAO,USR_CONST.cSTMAG,USR_CONST.cHSPAG,USR_CONST' +
        '.cHSBAO,USR_CONST.cHSMAG,USR_CONST.cMGGNT,USR_CONST.cSTNNB)'
      '    and ALLE > 1320'
      '    and DALLE <= 1440'
      ''
      '    union all'
      ''
      '    select '
      '      PROGRESSIVO,DATA+1,'
      
        '      greatest(to_number(DALLE)-1440,1320) DALLE, to_number(ALLE' +
        ')-1440 ALLE'
      '    from T102_DATIGG T102'
      '    where T102.MESE_RIEPILOGO = :MESE_RIEPILOGO'
      '    and T102.DATO = USR_CONST.cRIEPPRESEU'
      
        '    and nvl(T102.CAUSALE,USR_CONST.cSTAUT) not in (USR_CONST.cST' +
        'PAG,USR_CONST.cSTBAO,USR_CONST.cSTMAG,USR_CONST.cHSPAG,USR_CONST' +
        '.cHSBAO,USR_CONST.cHSMAG,USR_CONST.cMGGNT,USR_CONST.cSTNNB)'
      '    and ALLE-1440 > 1320'
      '    and DALLE > 1440'
      ''
      '    union all'
      ''
      '    select '
      '      PROGRESSIVO,DATA,'
      '      to_number(DALLE) DALLE,least(to_number(ALLE),360) ALLE'
      '    from T102_DATIGG T102'
      '    where T102.MESE_RIEPILOGO = :MESE_RIEPILOGO'
      '    and T102.DATO = USR_CONST.cRIEPPRESEU'
      
        '    and nvl(T102.CAUSALE,USR_CONST.cSTAUT) not in (USR_CONST.cST' +
        'PAG,USR_CONST.cSTBAO,USR_CONST.cSTMAG,USR_CONST.cHSPAG,USR_CONST' +
        '.cHSBAO,USR_CONST.cHSMAG,USR_CONST.cMGGNT,USR_CONST.cSTNNB)'
      '    and DALLE < 360'
      ''
      '    union all'
      ''
      '    select '
      '      PROGRESSIVO,DATA+1,'
      
        '      to_number(DALLE)-1440 DALLE,least(to_number(ALLE)-1440,360' +
        ') ALLE'
      '    from T102_DATIGG T102'
      '    where T102.MESE_RIEPILOGO = :MESE_RIEPILOGO'
      '    and T102.DATO = USR_CONST.cRIEPPRESEU'
      
        '    and nvl(T102.CAUSALE,USR_CONST.cSTAUT) not in (USR_CONST.cST' +
        'PAG,USR_CONST.cSTBAO,USR_CONST.cSTMAG,USR_CONST.cHSPAG,USR_CONST' +
        '.cHSBAO,USR_CONST.cHSMAG,USR_CONST.cMGGNT,USR_CONST.cSTNNB)'
      '    and DALLE-1440 < 360'
      '    and DALLE > 1440'
      ''
      '  ) T102, T030_ANAGRAFICO T030, T430_STORICO T430'
      '  where T102.PROGRESSIVO = T030.PROGRESSIVO'
      '  and   T102.PROGRESSIVO = T430.PROGRESSIVO'
      '  and   T102.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      '  and   T430.TGESTIONE = '#39'0'#39
      '  and   nvl(T430.FLAG_TIMBRA,'#39'nullo'#39') <> '#39'0'#39
      
        '  --and not exists (select '#39'x'#39' from T065_RICHIESTESTRAORDINARI w' +
        'here PROGRESSIVO = T030.PROGRESSIVO and DATA = :MESE_RIEPILOGO)'
      
        '  and not exists (select '#39'x'#39' from VT050_RICHIESTE_SENZAREVOCA wh' +
        'ere PROGRESSIVO = T030.PROGRESSIVO and CAUSALE = USR_CONST.cAUTS' +
        'T and last_day(:MESE_RIEPILOGO) between DAL and AL)'
      
        '  and not exists (select '#39'x'#39' from T102_DATIGG where PROGRESSIVO ' +
        '= T030.PROGRESSIVO and MESE_RIEPILOGO = :MESE_RIEPILOGO and CAUS' +
        'ALE = USR_CONST.cMGGNT)'
      
        '  group by T030.MATRICOLA,T030.COGNOME,T030.NOME,T102.PROGRESSIV' +
        'O,T102.DATA'
      '  having sum(T102.ALLE-T102.DALLE) >= 30'
      ')'
      'group by MATRICOLA,COGNOME,NOME,PROGRESSIVO'
      'order by NOME,MATRICOLA')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A004D004500530045005F005200490045005000
      49004C004F0047004F000C0000000000000000000000}
    OnFilterRecord = selT102OreNotturneFilterRecord
    Left = 112
    Top = 16
    object selT102OreNotturneMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT102OreNotturneNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 80
    end
    object selT102OreNotturneORE_NOTTURNE: TStringField
      DisplayLabel = 'Ore notturne'
      FieldName = 'ORE_NOTTURNE'
      Size = 6
    end
    object selT102OreNotturneLIQUIDATO: TStringField
      DisplayLabel = 'Gi'#224' liquidate'
      FieldName = 'LIQUIDATO'
      Size = 1
    end
    object selT102OreNotturnePROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object dsrT102: TDataSource
    DataSet = selT102OreNotturne
    Left = 112
    Top = 64
  end
  object USR_T065PCK_GESTSTRAORD_GESTIONEMAGGNOTT: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.GESTIONEMAGGNOTT(:PROGRESSIVO,:DATA);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 350
    Top = 216
  end
  object USR_T065PCK_GESTSTRAORD_ANNULLAMAGGNOTT: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_T065PCK_GESTSTRAORD.ANNULLAMAGGNOTT(:PROGRESSIVO,:DATA);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 350
    Top = 264
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select POSIZ,RIGA from T002_QUERYPERSONALIZZATE t'
      'where NOME = :NOME'
      'and POSIZ >= 0'
      'order by POSIZ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    OnFilterRecord = selT102OreNotturneFilterRecord
    Left = 32
    Top = 128
  end
  object dsrQryT002: TDataSource
    DataSet = selQryT002
    Left = 112
    Top = 176
  end
  object selQryT002: TOracleDataSet
    Optimize = False
    OnFilterRecord = selT102OreNotturneFilterRecord
    Left = 112
    Top = 128
  end
end
