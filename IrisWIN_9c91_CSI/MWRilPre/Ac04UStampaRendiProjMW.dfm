inherited Ac04FStampaRendiProjMW: TAc04FStampaRendiProjMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 380
  object cdsStampaAnagrafico: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'COGNOME_DIP'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'NOME_DIP'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MATRICOLA_DIP'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'PERIODO_STAMPA'
        DataType = ftDateTime
      end
      item
        Name = 'PERIODO_STAMPA_DESC'
        DataType = ftString
        Size = 21
      end
      item
        Name = 'ID_T750'
        DataType = ftInteger
      end
      item
        Name = 'REPORTING_PERIOD'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'COD_PROGETTO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESC_PROGETTO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PARTNER_NAME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PARTNER_NUMBER'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'NOMINATIVO_DIP'
        DataType = ftString
        Size = 61
      end
      item
        Name = 'TIPO_TEMPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVIZIO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FUNZIONE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NOMINATIVO_RESP'
        DataType = ftString
        Size = 61
      end
      item
        Name = 'TOT_ATT_MM'
        DataType = ftInteger
      end
      item
        Name = 'NON_REND_COD'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TOT_NON_REND'
        DataType = ftInteger
      end
      item
        Name = 'TOT_PRO_MM'
        DataType = ftInteger
      end
      item
        Name = 'TOT_MM'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'Primario'
        Expression = 'COGNOME_DIP;NOME_DIP;MATRICOLA_DIP;COD_PROGETTO;PERIODO_STAMPA'
        Options = [ixExpression]
      end>
    IndexName = 'Primario'
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 16
  end
  object cdsStampaDettaglio: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'ID_T750'
        DataType = ftInteger
      end
      item
        Name = 'PERIODO_STAMPA'
        DataType = ftDateTime
      end
      item
        Name = 'GIORNO'
        DataType = ftDateTime
      end
      item
        Name = 'DESC_GIORNO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'TOT_ATT_GG'
        DataType = ftInteger
      end
      item
        Name = 'NON_REND_HH'
        DataType = ftInteger
      end
      item
        Name = 'TOT_PRO_GG'
        DataType = ftInteger
      end
      item
        Name = 'ASS_FESTIVITA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ASS_ALTRE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TOT_GG'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'Primario'
        Expression = 'PROGRESSIVO;ID_T750;PERIODO_STAMPA;GIORNO'
        Options = [ixExpression]
      end>
    IndexName = 'Primario'
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 72
  end
  object selT750Lista: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T750.ID ID_T750, T750.CODICE C_PROGETTO, T750.DE' +
        'SCRIZIONE D_PROGETTO, '
      
        '       T750.DECORRENZA DEC_PROGETTO, T750.DECORRENZA_FINE SCA_PR' +
        'OGETTO'
      'from T753_LIMITI_IND_RENDICONTO T753,'
      '     T752_TASK_RENDICONTO T752,'
      '     T751_ATTIVITA_RENDICONTO T751,'
      '     T750_PROGETTI_RENDICONTO T750'
      'where T752.ID = T753.ID_T752'
      'and T751.ID = T752.ID_T751'
      'and T750.ID = T751.ID_T750'
      'and T753.PROGRESSIVO = :PROGRESSIVO'
      'and T753.DECORRENZA <= :AL'
      'and T753.DECORRENZA_FINE >= :DAL'
      'order by T750.CODICE, T750.DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000060000003A0041004C000C0000000000
      000000000000080000003A00440041004C000C0000000000000000000000}
    OnFilterRecord = selT750ListaFilterRecord
    Left = 40
    Top = 128
  end
  object selT750: TOracleDataSet
    SQL.Strings = (
      'select T750.*'
      'from T750_PROGETTI_RENDICONTO T750'
      'order by T750.ID')
    Optimize = False
    OnFilterRecord = selT750ListaFilterRecord
    Left = 128
    Top = 72
  end
  object selT751: TOracleDataSet
    SQL.Strings = (
      'select T751.*'
      'from T751_ATTIVITA_RENDICONTO T751'
      'order by T751.ID_T750, T751.CODICE')
    Optimize = False
    OnFilterRecord = selT750ListaFilterRecord
    Left = 128
    Top = 128
  end
  object selT755: TOracleDataSet
    SQL.Strings = (
      'select T750.CODICE COD_PRO,'
      '       T751.ID_T750,'
      '       T751.CODICE COD_ATT,'
      '       T752.ID_T751,'
      '       T755.DATA,'
      
        '       sum(OREMINUTI(nvl(T852.VALORE,T755.ORE))) ORE_RENDICONTAT' +
        'E'
      'from T755_RICHIESTE_RENDICONTO T755,'
      '     T752_TASK_RENDICONTO T752,'
      '     T751_ATTIVITA_RENDICONTO T751,'
      '     T750_PROGETTI_RENDICONTO T750,'
      '     T850_ITER_RICHIESTE T850,'
      '     T852_ITER_DATI_AUTORIZZATORI T852'
      'where T755.PROGRESSIVO = :PROGRESSIVO'
      'and T755.DATA between :DAL and :AL'
      'and T752.ID = T755.ID_T752'
      'and T751.ID = T752.ID_T751'
      'and T750.ID = T751.ID_T750'
      'and T850.ITER = '#39'T755'#39
      'and T850.ID = T755.ID'
      'and nvl(T850.STATO,'#39'S'#39') = '#39'S'#39
      'and T852.ID (+) = T850.ID'
      'and T852.DATO (+) = '#39'ORE'#39
      
        'group by T750.CODICE, T751.ID_T750, T751.CODICE, T752.ID_T751, T' +
        '755.DATA'
      
        'order by T750.CODICE, T751.ID_T750, T751.CODICE, T752.ID_T751, T' +
        '755.DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 192
    Top = 128
  end
  object selT754: TOracleDataSet
    SQL.Strings = (
      'select T754.*'
      'from T754_PROPRIETA_IND_RENDICONTO T754'
      'order by T754.ID_T750, T754.PROGRESSIVO')
    Optimize = False
    OnFilterRecord = selT750ListaFilterRecord
    Left = 192
    Top = 72
  end
  object selT257: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from T257_ACCORPCAUSALI '
      'where COD_TIPOACCORPCAUSALI = '#39'Ac01'#39' '
      'and COD_CODICIACCORPCAUSALI IN ('#39'SL'#39','#39'AH'#39')'
      
        'order by COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI, COD_CAU' +
        'SALE, DECORRENZA, DECORRENZA_FINE')
    Optimize = False
    Left = 192
    Top = 16
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'select T040.DATA, T040.CAUSALE, T040.TIPOGIUST,'
      '       nvl((select RENDICONTA_PROGETTI'
      
        '            from T265_CAUASSENZE T265, T230_CAUASSENZE_PARSTO T2' +
        '30 '
      '            where T265.CODICE = T040.CAUSALE'
      '            and T230.ID = T265.ID '
      
        '            and T040.DATA between T230.DECORRENZA and T230.DECOR' +
        'RENZA_FINE'
      '            union'
      '            select RENDICONTA_PROGETTI'
      
        '            from T275_CAUPRESENZE T275, T235_CAUPRESENZE_PARSTO ' +
        'T235 '
      '            where T275.CODICE = T040.CAUSALE'
      '            and T235.ID = T275.ID '
      
        '            and T040.DATA between T235.DECORRENZA and T235.DECOR' +
        'RENZA_FINE'
      '            ),'#39'N'#39') RENDICONTA_PROGETTI'
      'from T040_GIUSTIFICATIVI T040'
      'where T040.PROGRESSIVO = :PROGRESSIVO'
      'and T040.DATA between :DAL and :AL'
      
        'and T040.CAUSALE not in (select RICALCOLO_CAUS_NEG from T020_ORA' +
        'RI where RICALCOLO_CAUS_NEG is not null'
      '                         union'
      
        '                         select RICALCOLO_CAUS_POS from T020_ORA' +
        'RI where RICALCOLO_CAUS_POS is not null)'
      'order by T040.DATA, T040.CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 128
    Top = 16
  end
  object selFestivita: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  GETCALENDARIO(:Progressivo,:Data,:Festivo,:Lavorativo,:NumGior' +
        'ni,:MonteOre);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A004600450053005400490056004F000500
      00000000000000000000160000003A004C00410056004F005200410054004900
      56004F00050000000000000000000000140000003A004E0055004D0047004900
      4F0052004E004900030000000000000000000000120000003A004D004F004E00
      540045004F0052004500050000000000000000000000}
    Left = 256
    Top = 16
  end
  object selT756: TOracleDataSet
    SQL.Strings = (
      'select T756.*'
      'from T756_REPORTING_RENDICONTO T756'
      'order by T756.ID_T750, T756.DECORRENZA')
    Optimize = False
    OnFilterRecord = selT750ListaFilterRecord
    Left = 256
    Top = 72
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      'select T460.ASSENZEHH TIPO_TEMPO'
      'from T430_STORICO T430,'
      '     T460_PARTTIME T460'
      'where T430.PROGRESSIVO = :PROGRESSIVO'
      'and :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and T460.CODICE (+) = T430.PARTTIME')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 256
    Top = 128
  end
end
