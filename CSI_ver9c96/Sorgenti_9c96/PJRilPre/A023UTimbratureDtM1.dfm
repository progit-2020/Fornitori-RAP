object A023FTimbratureDtM1: TA023FTimbratureDtM1
  OldCreateOrder = True
  OnCreate = A023FTimbratureDtM1Create
  OnDestroy = A023FTimbratureDtM1Destroy
  Height = 200
  Width = 568
  object dsrSG101: TDataSource
    Left = 116
    Top = 19
  end
  object cdsGestMese: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FLAG_RIGA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FLAG_RIGA_SUBCOD'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'DATA_CONTEGGI'
        DataType = ftDateTime
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'DALLE_H'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ALLE_H'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'C_AUTORIZZATO'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'DESC_CAUSALE'
        DataType = ftString
        Size = 47
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TOTLAV'
        DataType = ftInteger
      end
      item
        Name = 'DEBITOGG'
        DataType = ftInteger
      end
      item
        Name = 'SCOST'
        DataType = ftInteger
      end
      item
        Name = 'C_TOTLAV_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'C_DEBITOGG_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'C_SCOST_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CAVALLO_MEZZANOTTE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATA_ORIG'
        DataType = ftDateTime
      end
      item
        Name = 'DALLE_ORIG'
        DataType = ftInteger
      end
      item
        Name = 'ALLE_ORIG'
        DataType = ftInteger
      end
      item
        Name = 'CAUSALE_ORIG'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'C_ARROT_RIEPGG'
        DataType = ftInteger
      end
      item
        Name = 'C_MODIFICATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID_EVENTO_STR'
        DataType = ftInteger
      end
      item
        Name = 'SERVIZIO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVIZIO_ORIG'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'cdsGestMeseIdx1'
        Fields = 'DATA;DALLE_H;ALLE_H;TIPO;FLAG_RIGA'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'cdsGestMeseIdx1'
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsGestMeseBeforeInsert
    BeforeEdit = cdsGestMeseBeforeEdit
    BeforePost = cdsGestMeseBeforePost
    AfterPost = cdsGestMeseAfterPost
    BeforeDelete = cdsGestMeseBeforeDelete
    AfterScroll = cdsGestMeseAfterScroll
    OnCalcFields = cdsGestMeseCalcFields
    OnFilterRecord = cdsGestMeseFilterRecord
    OnPostError = cdsGestMesePostError
    Left = 16
    Top = 74
    object cdsGestMeseFLAG_RIGA: TStringField
      Alignment = taCenter
      FieldName = 'FLAG_RIGA'
      Size = 1
    end
    object cdsGestMeseFLAG_RIGA_SUBCOD: TIntegerField
      DisplayLabel = 'T1'
      FieldName = 'FLAG_RIGA_SUBCOD'
    end
    object cdsGestMeseDATA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      OnValidate = cdsGestMeseDATAValidate
      EditMask = '!99/99/9999;1;_'
    end
    object cdsGestMeseDATA_CONTEGGI: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATA_CONTEGGI'
      Visible = False
    end
    object cdsGestMeseTIPO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 2
    end
    object cdsGestMeseDALLE_H: TStringField
      Alignment = taCenter
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE_H'
      OnValidate = cdsGestMeseDALLE_HValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsGestMeseALLE_H: TStringField
      Alignment = taCenter
      DisplayLabel = 'Alle'
      FieldName = 'ALLE_H'
      OnValidate = cdsGestMeseDALLE_HValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsGestMeseC_AUTORIZZATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_AUTORIZZATO'
      Size = 13
      Calculated = True
    end
    object cdsGestMeseDESC_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 47
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupDataSet = selAssPres
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      OnValidate = cdsGestMeseCAUSALEValidate
      Size = 47
      Lookup = True
    end
    object cdsGestMeseCAUSALE: TStringField
      DisplayLabel = 'Cod. caus.'
      FieldName = 'CAUSALE'
      OnValidate = cdsGestMeseCAUSALEValidate
      Size = 5
    end
    object cdsGestMeseTOTLAV: TIntegerField
      DisplayLabel = 'Tot. lavorato'
      FieldName = 'TOTLAV'
      Visible = False
    end
    object cdsGestMeseDEBITOGG: TIntegerField
      DisplayLabel = 'Debito gg.'
      FieldName = 'DEBITOGG'
      Visible = False
    end
    object cdsGestMeseSCOST: TIntegerField
      DisplayLabel = 'Scost.'
      FieldName = 'SCOST'
      Visible = False
    end
    object cdsGestMeseC_TOTLAV_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Tot. lavorato'
      FieldKind = fkCalculated
      FieldName = 'C_TOTLAV_H'
      Visible = False
      Size = 6
      Calculated = True
    end
    object cdsGestMeseC_DEBITOGG_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Debito gg.'
      FieldKind = fkCalculated
      FieldName = 'C_DEBITOGG_H'
      Visible = False
      Size = 6
      Calculated = True
    end
    object cdsGestMeseC_SCOST_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Scost.'
      FieldKind = fkCalculated
      FieldName = 'C_SCOST_H'
      Size = 6
      Calculated = True
    end
    object cdsGestMeseCAVALLO_MEZZANOTTE: TStringField
      FieldName = 'CAVALLO_MEZZANOTTE'
      Size = 1
    end
    object cdsGestMeseDATA_ORIG: TDateTimeField
      DisplayLabel = 'Data orig'
      FieldName = 'DATA_ORIG'
    end
    object cdsGestMeseDALLE_ORIG: TIntegerField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE_ORIG'
      Visible = False
    end
    object cdsGestMeseALLE_ORIG: TIntegerField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE_ORIG'
      Visible = False
    end
    object cdsGestMeseCAUSALE_ORIG: TStringField
      FieldName = 'CAUSALE_ORIG'
      Size = 5
    end
    object cdsGestMeseC_ARROT_RIEPGG: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'C_ARROT_RIEPGG'
      Calculated = True
    end
    object cdsGestMeseC_MODIFICATO: TStringField
      DisplayLabel = 'Modificato'
      FieldKind = fkCalculated
      FieldName = 'C_MODIFICATO'
      Size = 1
      Calculated = True
    end
    object cdsGestMeseID_EVENTO_STR: TIntegerField
      FieldName = 'ID_EVENTO_STR'
      Visible = False
    end
    object cdsGestMeseSERVIZIO: TStringField
      FieldName = 'SERVIZIO'
    end
    object cdsGestMeseSERVIZIO_ORIG: TStringField
      FieldName = 'SERVIZIO_ORIG'
    end
  end
  object dscGestMese: TDataSource
    DataSet = cdsGestMese
    Left = 16
    Top = 127
  end
  object selAssPres: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'A'#39' TIPO, T265.CODICE, RPAD(T265.CODICE,5,'#39' '#39') || '#39' - '#39' |' +
        '| T265.DESCRIZIONE DESCRIZIONE'
      'from   T265_CAUASSENZE T265'
      'where  T265.UM_INSERIMENTO_H = '#39'S'#39
      'and    VISITA_FISCALE = '#39'N'#39
      'and    TIPOCUMULO not in ('#39'F'#39','#39'G'#39')'
      'and    FRUIZIONE = '#39'N'#39
      'and    CODCAU3 is null'
      'union all'
      
        'select '#39'P'#39' TIPO, T275.CODICE, RPAD(T275.CODICE,5,'#39' '#39') || '#39' - '#39' |' +
        '| T275.DESCRIZIONE DESCRIZIONE'
      'from   T275_CAUPRESENZE T275'
      'where  TIPOCONTEGGIO not in ('#39'A'#39','#39'E'#39')'
      ':ORDINAMENTO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004F005200440049004E0041004D0045004E00
      54004F00010000000000000000000000}
    Filtered = True
    OnFilterRecord = selAssPresFilterRecord
    Left = 206
    Top = 70
  end
  object insT320: TOracleQuery
    SQL.Strings = (
      'insert into t320_pianlibprofessione'
      
        '   (progressivo, data, dalle, alle, causale, id_evento_str, serv' +
        'izio)'
      ' values'
      
        '   (:PROGRESSIVO, :DATA, :DALLE, :ALLE, :CAUSALE, :ID_EVENTO_STR' +
        ', :SERVIZIO)')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000
      1C0000003A00490044005F004500560045004E0054004F005F00530054005200
      030000000000000000000000120000003A00530045005200560049005A004900
      4F00050000000000000000000000}
    BeforeQuery = insT320BeforeQuery
    AfterQuery = insT320AfterQuery
    Left = 259
    Top = 70
  end
  object delT320: TOracleQuery
    SQL.Strings = (
      'delete from t320_pianlibprofessione'
      'where  progressivo = :PROGRESSIVO '
      'and    data between :DATA_INIZIO and :DATA_FINE'
      'and    nvl(ID_EVENTO_STR,-1) = nvl(:ID_EVENTO_STR,-1)')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      49004E0049005A0049004F000C0000000000000000000000140000003A004400
      4100540041005F00460049004E0045000C00000000000000000000001C000000
      3A00490044005F004500560045004E0054004F005F0053005400520003000000
      0000000000000000}
    BeforeQuery = delT320BeforeQuery
    AfterQuery = delT320AfterQuery
    Left = 305
    Top = 70
  end
  object selI060DatiUtente: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = :AZIENDA'
      'and    I060.NOME_UTENTE = :UTENTE'
      'and    I060.MATRICOLA = T030.MATRICOLA')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 31
    Top = 20
  end
  object selT370: TOracleDataSet
    SQL.Strings = (
      'SELECT T370.*'
      '  FROM T370_TIMBMENSA T370'
      ' WHERE TO_NUMBER(TO_CHAR(T370.DATA,'#39'YYYY'#39')) = :ANNO'
      '   AND TO_NUMBER(TO_CHAR(T370.DATA,'#39'MM'#39')) = :MESE'
      '   AND T370.PROGRESSIVO = :PROGR'
      ' ORDER BY T370.DATA, T370.ORA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A004D004500530045000300000000000000000000000C000000
      3A00500052004F0047005200030000000000000000000000}
    Left = 208
    Top = 16
  end
  object scrBloccaRiepT325: TOracleQuery
    SQL.Strings = (
      'insert into t180_datibloccati '
      '  (progressivo,dal,al,riepilogo,stato)'
      'values '
      '  (:progressivo,:dal,:al,:riepilogo,'#39'C'#39')')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      0000}
    Left = 378
    Top = 69
  end
  object scrSbloccaRiepT325: TOracleQuery
    SQL.Strings = (
      '  delete from t180_datibloccati '
      '   where progressivo = :progressivo'
      '     and riepilogo = :riepilogo'
      '     and dal >= :dal and al <= :al')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      0000}
    Left = 476
    Top = 69
  end
  object dsrT722: TDataSource
    DataSet = selT722
    Left = 88
    Top = 126
  end
  object selT722: TOracleDataSet
    SQL.Strings = (
      
        'select T722.ID,T722.CODICE,T722.DESCRIZIONE,greatest(T722.DECORR' +
        'ENZA,T724.DAL) DAL,least(T722.DECORRENZA_FINE,T724.AL) AL,'
      
        '       T722.ORE_TOTALI,nvl(T724.ORE_INDIV,T722.ORE_INDIV) ORE_IN' +
        'DIV,T722.CAUSALE_STR,T722.CAUSALE_STR_DOM,'
      '       T724.SERVIZI,T724.DELEGATO,T724.TIPO_LAVORO'
      
        'from T724_EVENTI_STR_INDIVIDUALI T724, T722_PERIODI_EVENTI_STR T' +
        '722'
      'where T724.PROGRESSIVO = :PROGRESSIVO'
      'and T724.ID = T722.ID'
      'and T724.DAL <= T722.DECORRENZA_FINE'
      'and T724.AL >= T722.DECORRENZA'
      'and T722.STATO = '#39'A'#39
      'order by T722.CODICE,DAL desc')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 88
    Top = 71
    object selT722ID: TIntegerField
      DisplayWidth = 8
      FieldName = 'ID'
    end
    object selT722CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT722DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT722DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
    end
    object selT722AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
    end
    object selT722ORE_INDIV: TStringField
      DisplayLabel = 'Ore indiv.'
      FieldName = 'ORE_INDIV'
      Size = 7
    end
    object selT722CAUSALE_STR: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE_STR'
      Size = 5
    end
    object selT722CAUSALE_STR_DOM: TStringField
      DisplayLabel = 'Caus. Domenica'
      FieldName = 'CAUSALE_STR_DOM'
      Size = 5
    end
    object selT722SERVIZI: TStringField
      DisplayLabel = 'Servizi'
      DisplayWidth = 20
      FieldName = 'SERVIZI'
      Size = 200
    end
    object selT722DELEGATO: TStringField
      DisplayLabel = 'Delegato'
      FieldName = 'DELEGATO'
      Size = 1
    end
    object selT722TIPO_LAVORO: TStringField
      DisplayLabel = 'Tipo lavoro'
      FieldName = 'TIPO_LAVORO'
      Size = 5
    end
  end
  object selT723: TOracleDataSet
    SQL.Strings = (
      'select '
      '  FILTRO_ANAGRAFE,'
      '  ORE,'
      '  minutiore(sum(ORE_CAUS)) ORE_CAUS'
      'from ('
      'select '
      '  T723.FILTRO_ANAGRAFE,'
      '  T723.ORE,'
      '  T320.PROGRESSIVO,'
      '  T320.DATA,'
      '  T320.CAUSALE,'
      '  arrotonda('
      
        '    sum(decode(sign(oreminuti(T320.ALLE) - oreminuti(T320.DALLE)' +
        '),'
      
        '                                        -1,oreminuti(T320.ALLE) ' +
        '+ 1440 - oreminuti(T320.DALLE),'
      
        '                                           oreminuti(T320.ALLE) ' +
        '- oreminuti(T320.DALLE))),oreminuti(T275.ARROT_RIEPGG),'#39'D'#39') ORE_' +
        'CAUS'
      'from'
      '  T320_PIANLIBPROFESSIONE T320,'
      '  T275_CAUPRESENZE T275,'
      '  T030_ANAGRAFICO T030,'
      '  T722_PERIODI_EVENTI_STR T722, '
      '  T723_BUDGET_EVENTI_STR T723'
      'where T722.ID = :ID'
      'and T320.PROGRESSIVO = T030.PROGRESSIVO'
      'and T320.ID_EVENTO_STR = T722.ID'
      'and T320.CAUSALE = T275.CODICE'
      'and T320.DATA between T722.DECORRENZA and T722.DECORRENZA_FINE'
      'and T722.ID = T723.ID       '
      
        'and instr('#39','#39'||T723.FILTRO_ANAGRAFE||'#39','#39','#39','#39'||T320.SERVIZIO||'#39','#39 +
        ') > 0'
      'and exists ('
      '      select '#39'x'#39' '
      '      from T724_EVENTI_STR_INDIVIDUALI T724b'
      '      where T724b.PROGRESSIVO = :PROGRESSIVO'
      '      and T724b.ID = :ID'
      
        '      and INTERSEZ_LISTE(T724b.SERVIZI,T723.FILTRO_ANAGRAFE) is ' +
        'not null'
      ')'
      'group by '
      
        '  T723.FILTRO_ANAGRAFE,T723.ORE,T320.PROGRESSIVO,T320.DATA,T320.' +
        'CAUSALE,T275.ARROT_RIEPGG'
      ') '
      'group by '
      '  FILTRO_ANAGRAFE,ORE'
      'order by '
      '  FILTRO_ANAGRAFE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001800
      00003A00500052004F0047005200450053005300490056004F00030000000000
      000000000000}
    Left = 144
    Top = 71
    object selT723FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Servizio'
      DisplayWidth = 20
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 2000
    end
    object selT723ORE: TStringField
      DisplayLabel = 'Disponibilit'#224
      FieldName = 'ORE'
      Size = 10
    end
    object selT723ORE_CAUS: TStringField
      DisplayLabel = 'Utilizzato'
      FieldName = 'ORE_CAUS'
      Size = 10
    end
  end
  object dsrT723: TDataSource
    DataSet = selT723
    Left = 144
    Top = 126
  end
  object selDistT722: TOracleDataSet
    SQL.Strings = (
      'select CAUSALE_STR CODICE from T722_PERIODI_EVENTI_STR'
      'union '
      'select CAUSALE_STR_DOM CODICE from T722_PERIODI_EVENTI_STR')
    Optimize = False
    Left = 264
    Top = 120
  end
end
