object W018FRichiestaTimbratureDM: TW018FRichiestaTimbratureDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 152
  Width = 418
  object selT105: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A005100560049005300540041004F0052004100
      43004C004500010000000000000000000000160000003A004400410054004100
      4C00410056004F0052004F000C00000000000000000000001E0000003A004600
      49004C00540052004F005F0050004500520049004F0044004F00010000000000
      000000000000100000003A0041005A00490045004E0044004100050000000000
      000000000000180000003A00460049004C00540052004F005F0041004E004100
      47000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      010000000000000000000000}
    UpdatingTable = 'T105_RICHIESTETIMBRATURE'
    CommitOnPost = False
    OnCalcFields = selT105CalcFields
    Left = 44
    Top = 22
    object selT105ID: TFloatField
      FieldName = 'ID'
    end
    object selT105ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT105ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT105PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT105NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT105MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT105SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT105COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT105TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT105AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT105REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT105DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selT105LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT105DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT105AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT105NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT105AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT105AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT105RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT105AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT105AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT105D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT105D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT105D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT105ELABORATO: TStringField
      FieldName = 'ELABORATO'
      Size = 1
    end
    object selT105D_ELABORATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_ELABORATO'
      Size = 5
      Calculated = True
    end
    object selT105OPERAZIONE: TStringField
      FieldName = 'OPERAZIONE'
      Size = 1
    end
    object selT105DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT105ORA: TStringField
      FieldName = 'ORA'
      Size = 5
    end
    object selT105VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object selT105CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT105CAUSALE_ORIG: TStringField
      FieldName = 'CAUSALE_ORIG'
      Size = 5
    end
    object selT105VERSO_ORIG: TStringField
      FieldName = 'VERSO_ORIG'
      Size = 1
    end
    object selT105RILEVATORE_ORIG: TStringField
      FieldName = 'RILEVATORE_ORIG'
      Size = 2
    end
    object selT105MOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Size = 5
    end
    object selT105RILEVATORE_RICH: TStringField
      FieldName = 'RILEVATORE_RICH'
      Size = 5
    end
    object selT105DESC_OPERAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'DESC_OPERAZIONE'
      Size = 3
      Calculated = True
    end
    object selT105CAUSALE_UTILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CAUSALE_UTILE'
      Size = 5
      Calculated = True
    end
    object selT105CAUSALE_UTILE_LIV: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'CAUSALE_UTILE_LIV'
      Calculated = True
    end
    object selT105DETTAGLIO_GG: TStringField
      FieldKind = fkCalculated
      FieldName = 'DETTAGLIO_GG'
      Size = 1
      Calculated = True
    end
    object selT105D_MOTIVAZIONE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_MOTIVAZIONE'
      LookupDataSet = selT106Lookup
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MOTIVAZIONE'
      Size = 40
      Lookup = True
    end
  end
  object selT100ModifTimb: TOracleDataSet
    SQL.Strings = (
      'select T100.DATA, TO_CHAR(T100.ORA,'#39'HH24.MI'#39') as ORA, '
      
        '       T100.CAUSALE, rpad(T100.CAUSALE,5,'#39' '#39') ||'#39' '#39'|| nvl(T275.D' +
        'ESCRIZIONE,T305.DESCRIZIONE) DESC_CAUSALE,'
      
        '       T100.VERSO, DECODE(T100.VERSO,'#39'E'#39','#39'Entrata'#39','#39'U'#39','#39'Uscita'#39')' +
        ' DESC_VERSO,'#13#10#10
      
        '       T100.PROGRESSIVO, T100.FLAG, T100.RILEVATORE, T100.ROWID,' +
        ' '
      
        '       T030.MATRICOLA, T030.COGNOME || '#39' '#39' || T030.NOME as NOMIN' +
        'ATIVO'
      
        'from   T100_TIMBRATURE T100, T030_ANAGRAFICO T030, T275_CAUPRESE' +
        'NZE T275, T305_CAUGIUSTIF T305'
      'where  T100.PROGRESSIVO = :PROGRESSIVO'
      'and    T100.DATA = :DATA'
      'and    T100.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T100.FLAG IN ('#39'O'#39','#39'I'#39')'
      'and    T100.CAUSALE = T275.CODICE(+)'
      'and    T100.CAUSALE = T305.CODICE(+)'
      'and    not exists (select '#39'X'#39' '
      '                   from   T105_RICHIESTETIMBRATURE T105 '
      '                   where  T100.PROGRESSIVO = T105.PROGRESSIVO '
      '                   and    T100.DATA = T105.DATA '
      
        '                   and    OREMINUTI(to_char(T100.ORA,'#39'HH24.MI'#39'))' +
        ' = OREMINUTI(T105.ORA)'
      '                   and    ((T105.OPERAZIONE <> '#39'M'#39' and '
      '                            T100.VERSO = T105.VERSO) or'
      '                           (T105.OPERAZIONE = '#39'M'#39' and '
      '                            T100.VERSO = T105.VERSO_ORIG))'
      '                   and    nvl(T105.ELABORATO,'#39'N'#39') = '#39'N'#39')'
      'order by T100.ORA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 114
    Top = 22
    object selT100ModifTimbDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT100ModifTimbORA: TStringField
      FieldName = 'ORA'
      Size = 5
    end
    object selT100ModifTimbVERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object selT100ModifTimbFLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object selT100ModifTimbCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT100ModifTimbRILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selT100ModifTimbMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT100ModifTimbNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT100ModifTimbDESC_VERSO: TStringField
      FieldName = 'DESC_VERSO'
      Size = 7
    end
    object selT100ModifTimbDESC_CAUSALE: TStringField
      FieldName = 'DESC_CAUSALE'
      Size = 40
    end
    object selT100ModifTimbMOTIVAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'MOTIVAZIONE'
      Size = 1
      Calculated = True
    end
    object selT100ModifTimbPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT100ModifTimbNOTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'NOTE'
      Size = 2000
      Calculated = True
    end
  end
  object dsrRiepOre: TDataSource
    AutoEdit = False
    DataSet = cdsRiepOre
    Left = 112
    Top = 80
  end
  object selT105RiepOre: TOracleDataSet
    SQL.Strings = (
      'select T105.*'
      'from   T105_RICHIESTETIMBRATURE T105'
      'where  T105.PROGRESSIVO = :PROGRESSIVO'
      'and    T105.DATA = :DATA'
      'and    T105.CAUSALE in (select CODICE '
      '                        from   T275_CAUPRESENZE '
      '                        where  TIPO_RICHIESTA_WEB in ('#39'R'#39','#39'P'#39'))'
      'order by T105.ORA')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 185
    Top = 80
  end
  object cdsRiepOre: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 80
    object cdsRiepOreDATA_CONTEGGI: TStringField
      FieldName = 'DATA_CONTEGGI'
      Size = 30
    end
    object cdsRiepOreORE: TStringField
      FieldName = 'ORE'
      Size = 8
    end
    object cdsRiepOreORE_CAUS: TStringField
      FieldName = 'ORE_CAUS'
      Size = 8
    end
    object cdsRiepOreORE_RICH_REC: TStringField
      FieldName = 'ORE_RICH_REC'
      Size = 8
    end
    object cdsRiepOreORE_RICH_PAG: TStringField
      FieldName = 'ORE_RICH_PAG'
      Size = 8
    end
    object cdsRiepOreAUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 15
    end
    object cdsRiepOreSALDO_ORE: TStringField
      FieldName = 'SALDO_ORE'
      Size = 8
    end
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
    Left = 185
    Top = 22
  end
  object selT275Abilitate: TOracleDataSet
    SQL.Strings = (
      'select '#39'T275'#39' TIPO, T275.CODICE, T275.DESCRIZIONE'
      'from   T275_CAUPRESENZE T275, T430_STORICO T430'
      'where  T430.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        'and    instr('#39','#39'||T430.ABPRESENZA1||'#39','#39','#39','#39'||T275.CODRAGGR||'#39','#39')' +
        ' > 0'
      'union --richiesto dal CSI e CISAP'
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
    Left = 253
    Top = 22
  end
  object selT106Lookup: TOracleDataSet
    SQL.Strings = (
      'select T106.*'
      'from   T106_MOTIVAZIONIRICHIESTE T106'
      'where  T106.TIPO = '#39'T'#39
      'order by T106.CODICE')
    ReadBuffer = 100
    Optimize = False
    UpdatingTable = 'T105_RICHIESTETIMBRATURE'
    Left = 338
    Top = 22
  end
end
