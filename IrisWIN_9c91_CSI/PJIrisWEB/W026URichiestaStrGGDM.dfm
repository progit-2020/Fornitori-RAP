object W026FRichiestaStrGGDM: TW026FRichiestaStrGGDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 252
  Width = 657
  object delT325: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete from T326_RICHIESTESTR_SPEZ T326'
      '  where exists (select '#39'X'#39' '
      '                from   T325_RICHIESTESTR_GG T325'
      '                where  T325.PROGRESSIVO = :PROGRESSIVO'
      '                and    T325.DATA between :DATA1 and :DATA2'
      '                and    T325.STATO = '#39'I'#39
      '                and    T326.ID = T325.ID);'
      ''
      '  delete from T325_RICHIESTESTR_GG'
      '  where  PROGRESSIVO = :PROGRESSIVO'
      '  and    DATA between :DATA1 and :DATA2'
      '  and    STATO = '#39'I'#39';'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 455
    Top = 12
  end
  object selT100B: TOracleDataSet
    SQL.Strings = (
      'select T100.CAUSALE, T100.FLAG, T100.ID_RICHIESTA'
      'from   T100_TIMBRATURE T100 '
      'where  T100.PROGRESSIVO = :PROGRESSIVO'
      'and    T100.DATA = :DATA'
      'and    oreminuti(to_char(T100.ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      'and    T100.VERSO = :VERSO'
      'and    T100.FLAG IN ('#39'I'#39','#39'O'#39')')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F00050000000000000000000000}
    Left = 455
    Top = 76
  end
  object updT100: TOracleQuery
    SQL.Strings = (
      'update T100_TIMBRATURE T100 '
      'set    T100.CAUSALE = :CAUSALE'
      'where  T100.PROGRESSIVO = :PROGRESSIVO'
      'and    T100.DATA = :DATA'
      'and    oreminuti(to_char(T100.ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      'and    T100.VERSO = :VERSO')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      0000100000003A00430041005500530041004C00450005000000000000000000
      00000C0000003A0056004500520053004F00050000000000000000000000}
    Left = 519
    Top = 76
  end
  object insUpdT100: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  COD_RIL  varchar2(2);'
      'BEGIN'
      '  BEGIN'
      '    select T100.RILEVATORE'
      '    into   COD_RIL'
      '    from   T100_TIMBRATURE T100     '
      '    where  T100.PROGRESSIVO = :PROGRESSIVO'
      '    and    T100.DATA = :DATA'
      
        '    and    oreminuti(to_char(T100.ORA,'#39'HH24.MI'#39')) = oreminuti(:O' +
        'RA)'
      '    and    T100.VERSO = :VERSO_ORIG'
      '    and    FLAG = '#39'O'#39';'
      '  EXCEPTION'
      '    when NO_DATA_FOUND then'
      '  '#9'raise NO_DATA_FOUND;'
      '  END;'
      ''
      '  BEGIN'
      '    update T100_TIMBRATURE T100 '
      '    set    T100.FLAG = '#39'M'#39
      '    where  T100.PROGRESSIVO = :PROGRESSIVO'
      '    and    T100.DATA = :DATA'
      
        '    and    oreminuti(to_char(T100.ORA,'#39'HH24.MI'#39')) = oreminuti(:O' +
        'RA)'
      '    and    T100.VERSO = :VERSO_ORIG'
      '    and    FLAG = '#39'O'#39';'
      '  EXCEPTION'
      '    when OTHERS then'
      '      raise DUP_VAL_ON_INDEX;'
      '  END;'
      ''
      '  insert into T100_TIMBRATURE'
      '    (PROGRESSIVO,DATA,ORA,FLAG,VERSO,CAUSALE,RILEVATORE)'
      '  values'
      
        '    (:PROGRESSIVO,:DATA,TO_DATE('#39'01/01/1900 '#39' || :ORA, '#39'DD/MM/YY' +
        'YY HH24.MI'#39'),'#39'I'#39',:VERSO,:CAUSALE,COD_RIL);  '
      'END;')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000001600
      00003A0056004500520053004F005F004F005200490047000500000000000000
      00000000100000003A00430041005500530041004C0045000500000000000000
      00000000}
    Left = 592
    Top = 76
  end
  object insT320: TOracleQuery
    SQL.Strings = (
      'insert into t320_pianlibprofessione'
      '  (progressivo, data, dalle, alle, causale)'
      'values'
      '  (:PROGRESSIVO, :DATA, :DALLE, :ALLE, :CAUSALE)'
      '')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000}
    Left = 455
    Top = 140
  end
  object delT320: TOracleQuery
    SQL.Strings = (
      'delete from T320_PIANLIBPROFESSIONE'
      'where  PROGRESSIVO = :PROGRESSIVO '
      'and    DATA = :DATA'
      'and    DALLE = :DALLE'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      000000000000}
    Left = 519
    Top = 140
  end
  object selT325Vis: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00460049004C00540052004F005F0041004E00
      41004700010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0051005600
      49005300540041004F005200410043004C004500010000000000000000000000
      1E0000003A00460049004C00540052004F005F0050004500520049004F004400
      4F00010000000000000000000000100000003A0041005A00490045004E004400
      41000500000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      010000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    CommitOnPost = False
    AfterOpen = selT325VisAfterOpen
    OnCalcFields = selT325VisCalcFields
    Left = 22
    Top = 12
  end
  object cdsT325Vis: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxNomeDataSpez'
        Fields = 'NOMINATIVO;DATA;SPEZ'
      end>
    IndexName = 'idxNomeDataSpez'
    Params = <>
    StoreDefs = True
    AfterScroll = cdsT325VisAfterScroll
    OnCalcFields = cdsT325VisCalcFields
    Left = 22
    Top = 72
    object cdsT325VisID: TFloatField
      FieldName = 'ID'
    end
    object cdsT325VisID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object cdsT325VisID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object cdsT325VisPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object cdsT325VisNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object cdsT325VisMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsT325VisSESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object cdsT325VisCOD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object cdsT325VisTIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object cdsT325VisAUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object cdsT325VisREVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object cdsT325VisDATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object cdsT325VisLIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object cdsT325VisDATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object cdsT325VisAUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object cdsT325VisRESPONSABILE: TStringField
      FieldName = 'RESPONSABILE'
      Size = 61
    end
    object cdsT325VisNOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object cdsT325VisAUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object cdsT325VisAUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object cdsT325VisRESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object cdsT325VisAUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object cdsT325VisAUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object cdsT325VisD_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object cdsT325VisD_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object cdsT325VisD_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object cdsT325VisID_T325: TFloatField
      FieldName = 'ID_T325'
    end
    object cdsT325VisDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsT325VisTIMBRATURE: TStringField
      FieldName = 'TIMBRATURE'
      Size = 1000
    end
    object cdsT325VisORE_LORDE: TStringField
      FieldName = 'ORE_LORDE'
      Size = 6
    end
    object cdsT325VisORE_CONTEGGIATE: TStringField
      FieldName = 'ORE_CONTEGGIATE'
      Size = 6
    end
    object cdsT325VisDEBITO: TStringField
      FieldName = 'DEBITO'
      Size = 5
    end
    object cdsT325VisDETR_MENSA: TStringField
      FieldName = 'DETR_MENSA'
      Size = 5
    end
    object cdsT325VisRITARDO: TStringField
      FieldName = 'RITARDO'
      Size = 5
    end
    object cdsT325VisTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsT325VisDATA_SPEZ: TDateField
      FieldName = 'DATA_SPEZ'
    end
    object cdsT325VisECCEDENZA: TStringField
      FieldName = 'ECCEDENZA'
      Size = 5
    end
    object cdsT325VisSPEZ: TStringField
      FieldName = 'SPEZ'
      Size = 11
    end
    object cdsT325VisCAUS_ORIG: TStringField
      FieldName = 'CAUS_ORIG'
      Size = 5
    end
    object cdsT325VisSPEZ_DALLE1: TStringField
      FieldName = 'SPEZ_DALLE1'
      Size = 5
    end
    object cdsT325VisSPEZ_ALLE1: TStringField
      FieldName = 'SPEZ_ALLE1'
      Size = 5
    end
    object cdsT325VisCAUS1: TStringField
      FieldName = 'CAUS1'
      Size = 5
    end
    object cdsT325VisSPEZ_DALLE2: TStringField
      FieldName = 'SPEZ_DALLE2'
      Size = 5
    end
    object cdsT325VisSPEZ_ALLE2: TStringField
      FieldName = 'SPEZ_ALLE2'
      Size = 5
    end
    object cdsT325VisCAUS2: TStringField
      FieldName = 'CAUS2'
      Size = 5
    end
    object cdsT325VisSPEZ_DALLE3: TStringField
      FieldName = 'SPEZ_DALLE3'
      Size = 5
    end
    object cdsT325VisSPEZ_ALLE3: TStringField
      FieldName = 'SPEZ_ALLE3'
      Size = 5
    end
    object cdsT325VisCAUS3: TStringField
      FieldName = 'CAUS3'
      Size = 5
    end
    object cdsT325VisC_SPEZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_SPEZ'
      Calculated = True
    end
    object cdsT325VisC_SPEZ_MIN: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_SPEZ_MIN'
      Calculated = True
    end
    object cdsT325VisC_SPEZ_REC: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_SPEZ_REC'
      Calculated = True
    end
    object cdsT325VisC_SPEZ_PAG: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_SPEZ_PAG'
      Calculated = True
    end
    object cdsT325VisTIPO_RIGA: TStringField
      FieldName = 'TIPO_RIGA'
      Size = 1
    end
    object cdsT325VisMOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Size = 5
    end
  end
  object cdsT325VisEU: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxNomeDataSpez'
        Fields = 'NOMINATIVO;DATA;SPEZ_E;SPEZ_U'
      end>
    IndexName = 'idxNomeDataSpez'
    Params = <>
    StoreDefs = True
    AfterScroll = cdsT325VisAfterScroll
    OnCalcFields = cdsT325VisCalcFields
    Left = 87
    Top = 72
    object cdsT325VisEUID: TFloatField
      FieldName = 'ID'
    end
    object cdsT325VisEUID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object cdsT325VisEUID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object cdsT325VisEUPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object cdsT325VisEUNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object cdsT325VisEUMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsT325VisEUSESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object cdsT325VisEUCOD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object cdsT325VisEUTIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object cdsT325VisEUAUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object cdsT325VisEUREVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object cdsT325VisEUDATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object cdsT325VisEULIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object cdsT325VisEUDATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object cdsT325VisEUAUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object cdsT325VisEURESPONSABILE: TStringField
      FieldName = 'RESPONSABILE'
      Size = 61
    end
    object cdsT325VisEUNOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object cdsT325VisEUAUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object cdsT325VisEUAUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object cdsT325VisEURESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object cdsT325VisEUAUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object cdsT325VisEUAUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object cdsT325VisEUD_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object cdsT325VisEUD_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object cdsT325VisEUD_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object cdsT325VisEUID_T325: TFloatField
      FieldName = 'ID_T325'
    end
    object cdsT325VisEUDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsT325VisEUTIMBRATURE: TStringField
      FieldName = 'TIMBRATURE'
      Size = 1000
    end
    object cdsT325VisEUORE_LORDE: TStringField
      FieldName = 'ORE_LORDE'
      Size = 6
    end
    object cdsT325VisEUORE_CONTEGGIATE: TStringField
      FieldName = 'ORE_CONTEGGIATE'
      Size = 6
    end
    object cdsT325VisEUDEBITO: TStringField
      FieldName = 'DEBITO'
      Size = 5
    end
    object cdsT325VisEUDETR_MENSA: TStringField
      FieldName = 'DETR_MENSA'
      Size = 5
    end
    object cdsT325VisEURITARDO: TStringField
      FieldName = 'RITARDO'
      Size = 5
    end
    object cdsT325VisEUTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsT325VisEUCAUS_ORIG: TStringField
      FieldName = 'CAUS_ORIG'
      Size = 5
    end
    object cdsT325VisEUSPEZ_E: TStringField
      FieldName = 'SPEZ_E'
      Size = 11
    end
    object cdsT325VisEUECCEDENZA_E: TStringField
      FieldName = 'ECCEDENZA_E'
      Size = 5
    end
    object cdsT325VisEUSPEZ_DALLE1_E: TStringField
      FieldName = 'SPEZ_DALLE1_E'
      Size = 5
    end
    object cdsT325VisEUSPEZ_ALLE1_E: TStringField
      FieldName = 'SPEZ_ALLE1_E'
      Size = 5
    end
    object cdsT325VisEUCAUS1_E: TStringField
      FieldName = 'CAUS1_E'
      Size = 5
    end
    object cdsT325VisEUAUTORIZZAZIONE_E: TStringField
      FieldName = 'AUTORIZZAZIONE_E'
      Size = 1
    end
    object cdsT325VisEUDATA_SPEZ_E: TDateField
      FieldName = 'DATA_SPEZ_E'
    end
    object cdsT325VisEUSPEZ_U: TStringField
      FieldName = 'SPEZ_U'
      Size = 11
    end
    object cdsT325VisEUSPEZ_DALLE1_U: TStringField
      FieldName = 'SPEZ_DALLE1_U'
      Size = 5
    end
    object cdsT325VisEUSPEZ_ALLE1_U: TStringField
      FieldName = 'SPEZ_ALLE1_U'
      Size = 5
    end
    object cdsT325VisEUECCEDENZA_U: TStringField
      FieldName = 'ECCEDENZA_U'
      Size = 5
    end
    object cdsT325VisEUCAUS1_U: TStringField
      FieldName = 'CAUS1_U'
      Size = 5
    end
    object cdsT325VisEUAUTORIZZAZIONE_U: TStringField
      FieldName = 'AUTORIZZAZIONE_U'
      Size = 1
    end
    object cdsT325VisEUMOTIVAZIONE_E: TStringField
      FieldName = 'MOTIVAZIONE_E'
      Size = 5
    end
    object cdsT325VisEUDATA_SPEZ_U: TDateField
      FieldName = 'DATA_SPEZ_U'
    end
    object cdsT325VisEUD_AUTORIZZAZIONE_E: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE_E'
      Size = 2
      Calculated = True
    end
    object cdsT325VisEUD_AUTORIZZAZIONE_U: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE_U'
      Size = 2
      Calculated = True
    end
    object cdsT325VisEUMOTIVAZIONE_U: TStringField
      FieldName = 'MOTIVAZIONE_U'
      Size = 5
    end
    object cdsT325VisEUMOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Size = 5
    end
    object cdsT325VisEUTIPO_RIGA: TStringField
      FieldName = 'TIPO_RIGA'
      Size = 1
    end
  end
  object selT325Search: TOracleDataSet
    SQL.Strings = (
      'select  T325.DATA, T850.TIPO_RICHIESTA, T850.ID'
      
        'from    T326_RICHIESTESTR_SPEZ T326, T325_RICHIESTESTR_GG T325, ' +
        'T850_ITER_RICHIESTE T850'
      'where   T325.DATA between :DATA1 and :DATA2'
      'and     T325.PROGRESSIVO = :PROGRESSIVO'
      'and     T325.ID = T326.ID'
      'and     T850.ID = T326.ID_T850'
      'and     T850.ITER = '#39'T325'#39)
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 204
    Top = 12
  end
  object updT325Orig: TOracleQuery
    SQL.Strings = (
      'update T325_RICHIESTESTR_GG T325'
      'set    T325.STATO = :STATO,'
      '       T325.ID_RETTIFICA = null'
      'where  T325.ID = :ID_ORIG')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A0053005400410054004F000500000000000000
      00000000100000003A00490044005F004F005200490047000300000000000000
      00000000}
    Left = 592
    Top = 12
  end
  object selT325IdOrig: TOracleQuery
    SQL.Strings = (
      'begin'
      '  select ID'
      '  into   :ID_ORIG'
      '  from   T325_RICHIESTESTR_GG'
      '  where  ID_RETTIFICA = :ID;'
      'exception'
      '  when NO_DATA_FOUND then'
      '    :ID_ORIG:=0;  '
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00490044005F004F0052004900470003000000
      0000000000000000060000003A0049004400030000000000000000000000}
    Left = 519
    Top = 12
  end
  object selT020Scorr: TOracleDataSet
    SQL.Strings = (
      'select count(*)'
      'from   T020_ORARI'
      'where  RICALCOLO_DEBITO_GG = '#39'S'#39' '
      'and    RICALCOLO_SPOSTA_PN = '#39'S'#39)
    ReadBuffer = 2
    Optimize = False
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    ReadOnly = True
    Left = 27
    Top = 132
  end
  object selT221: TOracleDataSet
    SQL.Strings = (
      'select count(*) '
      'from   T020_ORARI T020'
      'where  T020.RICALCOLO_DEBITO_GG = '#39'S'#39' '
      'and    T020.RICALCOLO_SPOSTA_PN = '#39'S'#39
      'and    T020.DECORRENZA = (select max(DECORRENZA)   '
      '                          from T020_ORARI '
      '                          where CODICE = T020.CODICE '
      '                          and DECORRENZA <= :DATARIF)'
      'and    T020.CODICE in ('
      '         select T221.LUNEDI'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1 '
      '         and    T430.PROGRESSIVO = :PROGRESSIVO '
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.LUNEDI is not null'
      '         union'
      '         select T221.MARTEDI'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1 '
      '         and    T430.PROGRESSIVO = :PROGRESSIVO '
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.MARTEDI is not null'
      '         union'
      '         select T221.MERCOLEDI'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1 '
      '         and    T430.PROGRESSIVO = :PROGRESSIVO'
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.MERCOLEDI is not null'
      '         union'
      '         select T221.GIOVEDI'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1 '
      '         and    T430.PROGRESSIVO = :PROGRESSIVO'
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.GIOVEDI is not null'
      '         union'
      '         select T221.VENERDI'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1'
      '         and    T430.PROGRESSIVO = :PROGRESSIVO '
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.VENERDI is not null'
      '         union'
      '         select T221.SABATO'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1'
      '         and    T430.PROGRESSIVO = :PROGRESSIVO'
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.SABATO is not null'
      '         union'
      '         select T221.DOMENICA'
      
        '         from   T220_PROFILIORARI T220, T221_PROFILISETTIMANA T2' +
        '21, T430_STORICO T430'
      '         where  1 = 1 '
      '         and    T430.PROGRESSIVO = :PROGRESSIVO'
      
        '         and    :DATARIF between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '         and    T220.CODICE = T430.PORARIO'
      
        '         and    :DATARIF between T220.DECORRENZA and T220.DECORR' +
        'ENZA_FINE'
      '         and    T220.CODICE = T221.CODICE'
      '         and    T220.DECORRENZA = T221.DECORRENZA'
      '         and    T221.DOMENICA is not null'
      '       )')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041005200490046000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    ReadOnly = True
    Left = 94
    Top = 132
  end
  object selT325: TOracleDataSet
    SQL.Strings = (
      'select  T325.*, T325.ROWID'
      'from    T325_RICHIESTESTR_GG T325'
      'where   T325.DATA between :DATA1 and :DATA2'
      'and     T325.PROGRESSIVO = :PROGRESSIVO'
      'order by T325.DATA'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T325_ID'
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    CommitOnPost = False
    BeforePost = selT325BeforePost
    AfterPost = selT325AfterPost
    Left = 87
    Top = 12
    object FloatField1: TFloatField
      FieldName = 'ID'
    end
    object IntegerField1: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATA'
    end
    object StringField1: TStringField
      FieldName = 'TIMBRATURE'
      Size = 1000
    end
    object StringField2: TStringField
      FieldName = 'ORE_LORDE'
      Size = 6
    end
    object StringField3: TStringField
      FieldName = 'ORE_CONTEGGIATE'
      Size = 6
    end
    object StringField4: TStringField
      FieldName = 'DEBITO'
      Size = 5
    end
    object StringField5: TStringField
      FieldName = 'DETR_MENSA'
      Size = 5
    end
    object StringField6: TStringField
      FieldName = 'RITARDO'
      Size = 5
    end
  end
  object selT326: TOracleDataSet
    SQL.Strings = (
      'select  T326.*, T326.ROWID'
      'from    T326_RICHIESTESTR_SPEZ T326, T325_RICHIESTESTR_GG T325'
      'where   T325.DATA between :DATA1 and :DATA2'
      'and     T325.PROGRESSIVO = :PROGRESSIVO'
      'and     T325.ID = T326.ID'
      'order by T326.ID, T326.TIPO')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    SequenceField.Field = 'ID_T850'
    SequenceField.Sequence = 'T850_ID'
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    CommitOnPost = False
    BeforePost = selT326BeforePost
    AfterPost = selT326AfterPost
    Left = 140
    Top = 12
    object FloatField2: TFloatField
      FieldName = 'ID'
    end
    object StringField7: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object StringField8: TStringField
      FieldName = 'ECCEDENZA'
      Size = 5
    end
    object StringField9: TStringField
      FieldName = 'SPEZ'
      Size = 11
    end
    object StringField10: TStringField
      FieldName = 'CAUS_ORIG'
      Size = 11
    end
    object StringField11: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object StringField12: TStringField
      FieldName = 'SPEZ_DALLE1'
      Size = 5
    end
    object StringField13: TStringField
      FieldName = 'SPEZ_ALLE1'
      Size = 5
    end
    object StringField14: TStringField
      FieldName = 'CAUS1'
      Size = 5
    end
    object StringField15: TStringField
      FieldName = 'SPEZ_DALLE2'
      Size = 5
    end
    object StringField16: TStringField
      FieldName = 'SPEZ_ALLE2'
      Size = 5
    end
    object StringField17: TStringField
      FieldName = 'CAUS2'
      Size = 5
    end
    object StringField18: TStringField
      FieldName = 'SPEZ_DALLE3'
      Size = 5
    end
    object StringField19: TStringField
      FieldName = 'SPEZ_ALLE3'
      Size = 5
    end
    object StringField20: TStringField
      FieldName = 'CAUS3'
      Size = 5
    end
    object FloatField3: TFloatField
      FieldName = 'ID_T850'
    end
    object selT326DATA_SPEZ: TDateTimeField
      FieldName = 'DATA_SPEZ'
    end
    object selT326MOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Size = 5
    end
  end
  object selRichiesteGiorno: TOracleQuery
    SQL.Strings = (
      
        'select count(distinct T325.ID) NUM_RICH, decode(nvl(min(T850.TIP' +
        'O_RICHIESTA),'#39'X'#39'),nvl(max(T850.TIPO_RICHIESTA),'#39'X'#39'),'#39'S'#39','#39'N'#39') STA' +
        'TO_UGUALE'
      
        'from   T325_RICHIESTESTR_GG T325, T326_RICHIESTESTR_SPEZ T326,  ' +
        'T850_ITER_RICHIESTE T850'
      'where  T325.PROGRESSIVO = :PROGRESSIVO'
      'and    T325.DATA = :DATARIF'
      'and    T850.TIPO_RICHIESTA <> '#39'A'#39
      'and    T325.ID = T326.ID'
      'and    T850.ID = T326.ID_T850'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C0000000000000000000000}
    Left = 290
    Top = 12
  end
  object insT850Man: TOracleQuery
    SQL.Strings = (
      'begin'
      '  select T850_ID.nextval into :ID from dual;'
      ''
      '  insert into T850_ITER_RICHIESTE'
      
        '    (ITER,COD_ITER,ID,DATA,NOTE,STATO,TIPO_RICHIESTA,AUTORIZZ_AU' +
        'TOMATICA,ID_REVOCA,ID_REVOCATO)'
      '  values '
      
        '    (:ITER,null,:ID,:DATA,:NOTE,null,:TIPO_RICHIESTA,null,null,n' +
        'ull);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000000A0000003A004E00
      4F00540045000500000000000000000000001E0000003A005400490050004F00
      5F00520049004300480049004500530054004100050000000000000000000000
      0A0000003A0044004100540041000C0000000000000000000000}
    Left = 376
    Top = 12
  end
  object selTotAnno: TOracleQuery
    SQL.Strings = (
      
        'SELECT minutiore(sum(decode(SPEZ_DALLE1,NULL,0,oreminuti(SPEZ_AL' +
        'LE1) + decode(sign(oreminuti(SPEZ_ALLE1) - oreminuti(SPEZ_DALLE1' +
        ')),1,0,1440) - oreminuti(SPEZ_DALLE1)))) TOTCAUSREC,'
      
        '       minutiore(sum(decode(SPEZ_DALLE2,NULL,0,oreminuti(SPEZ_AL' +
        'LE2) + decode(sign(oreminuti(SPEZ_ALLE2) - oreminuti(SPEZ_DALLE2' +
        ')),1,0,1440) - oreminuti(SPEZ_DALLE2)))) TOTCAUSPAG'
      'FROM   T325_RICHIESTESTR_GG T325,'
      '       T326_RICHIESTESTR_SPEZ T326,'
      '       T850_ITER_RICHIESTE T850,'
      '      :QVISTAORACLE'
      'AND    T325.ID = T326.ID'
      'AND    T325.DATA BETWEEN :INIZIO and :FINE'
      'AND    T326.ID_T850 = T850.ID'
      'AND    NVL(T850.STATO,'#39'S'#39') <> '#39'N'#39
      'AND    T325.PROGRESSIVO = T030.PROGRESSIVO'
      ':FILTRO_ANAG')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000050000001A0000003A005100560049005300540041004F0052004100
      43004C0045000100000000000000000000000E0000003A0049004E0049005A00
      49004F000C00000000000000000000000A0000003A00460049004E0045000C00
      00000000000000000000180000003A00460049004C00540052004F005F004100
      4E0041004700010000000000000000000000160000003A004400410054004100
      4C00410056004F0052004F000C0000000000000000000000}
    Left = 455
    Top = 195
  end
  object selTotMese: TOracleQuery
    SQL.Strings = (
      
        'select sum(decode(SPEZ_DALLE1,NULL,0,oreminuti(SPEZ_ALLE1) + dec' +
        'ode(sign(oreminuti(SPEZ_ALLE1) - oreminuti(SPEZ_DALLE1)),1,0,144' +
        '0) - oreminuti(SPEZ_DALLE1))) TOTCAUSREC,'
      
        '       sum(decode(SPEZ_DALLE2,NULL,0,oreminuti(SPEZ_ALLE2) + dec' +
        'ode(sign(oreminuti(SPEZ_ALLE2) - oreminuti(SPEZ_DALLE2)),1,0,144' +
        '0) - oreminuti(SPEZ_DALLE2))) TOTCAUSPAG'
      'from   T325_RICHIESTESTR_GG T325,'
      '       T326_RICHIESTESTR_SPEZ T326,'
      '       T850_ITER_RICHIESTE T850'
      'where  T325.ID = T326.ID'
      'and    T850.ID <> :ID'
      'and    T325.DATA between :INIZIO and :FINE'
      'and    T326.ID_T850 = T850.ID'
      'and    nvl(T850.STATO,'#39'S'#39') <> '#39'N'#39
      'and    T325.PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0049004E0049005A0049004F000C0000000000
      0000000000000A0000003A00460049004E0045000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000060000003A0049004400030000000000000000000000}
    Left = 519
    Top = 195
  end
  object selT106: TOracleDataSet
    SQL.Strings = (
      'select T106.*'
      'from   T106_MOTIVAZIONIRICHIESTE T106'
      'where  T106.TIPO = :TIPO'
      'order by T106.CODICE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A005400490050004F0005000000000000000000
      0000}
    UpdatingTable = 'T105_RICHIESTETIMBRATURE'
    Left = 25
    Top = 190
  end
end
