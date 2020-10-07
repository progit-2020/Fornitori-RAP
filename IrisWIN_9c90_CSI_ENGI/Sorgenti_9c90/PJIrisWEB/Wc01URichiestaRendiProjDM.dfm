object Wc01FRichiestaRendiProjDM: TWc01FRichiestaRendiProjDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 183
  Width = 374
  object selT755: TOracleDataSet
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000080000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C0045000100000000000000000000000C0000003A0053005400410054004F00
      010000000000000000000000160000003A0044004100540041004C0041005600
      4F0052004F000C00000000000000000000001E0000003A00460049004C005400
      52004F005F0050004500520049004F0044004F00010000000000000000000000
      100000003A0041005A00490045004E0044004100050000000000000000000000
      180000003A00560041004C004900440041005A0049004F004E00450005000000
      0000000000000000240000003A00430041004D0050004F005F00560041004C00
      4900440041005A0049004F004E004500010000000000000000000000}
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
    OnCalcFields = selT755CalcFields
    Left = 24
    Top = 16
    object selT755ID: TFloatField
      FieldName = 'ID'
    end
    object selT755ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT755ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT755PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT755NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT755MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT755SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT755COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT755TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT755AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT755REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT755DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
    end
    object selT755LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT755DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT755AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT755NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT755AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT755AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT755RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT755AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT755AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT755D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT755D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT755D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT755DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT755ID_T752: TFloatField
      FieldName = 'ID_T752'
    end
    object selT755CF_C_PROGETTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_C_PROGETTO'
      Calculated = True
    end
    object selT755CF_D_PROGETTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_D_PROGETTO'
      Size = 100
      Calculated = True
    end
    object selT755CF_C_ATTIVITA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_C_ATTIVITA'
      Size = 10
      Calculated = True
    end
    object selT755CF_D_ATTIVITA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_D_ATTIVITA'
      Size = 100
      Calculated = True
    end
    object selT755CF_C_TASK: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_C_TASK'
      Size = 10
      Calculated = True
    end
    object selT755CF_D_TASK: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_D_TASK'
      Size = 100
      Calculated = True
    end
    object selT755ORE: TStringField
      FieldName = 'ORE'
      Size = 10
    end
    object selT755CF_ORE_AUTORIZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_ORE_AUTORIZ'
      Size = 6
      Calculated = True
    end
    object selT755CF_ORE_LIMITE_MESE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_ORE_LIMITE_MESE'
      Size = 10
      Calculated = True
    end
    object selT755CF_ORE_AUT_MESE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_ORE_AUT_MESE'
      Size = 10
      Calculated = True
    end
    object selT755CF_RES_ORE_MESE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_RES_ORE_MESE'
      Size = 10
      Calculated = True
    end
    object selT755CF_RIEP_ORE_MESE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_RIEP_ORE_MESE'
      Size = 32
      Calculated = True
    end
  end
  object selT753: TOracleDataSet
    SQL.Strings = (
      'select T750.CODICE C_PROGETTO, T750.DESCRIZIONE D_PROGETTO, '
      
        '       T750.DECORRENZA DEC_PROGETTO, T750.CHIUSURA_DAL, T750.CHI' +
        'USURA_AL,'
      '       T751.CODICE C_ATTIVITA, T751.DESCRIZIONE D_ATTIVITA,'
      '       T752.CODICE C_TASK, T752.DESCRIZIONE D_TASK,'
      
        '       T753.ID_T752, T753.PROGRESSIVO, greatest(T753.DECORRENZA,' +
        ':DAL) D_INI, least(T753.DECORRENZA_FINE,:AL) D_FIN'
      'from T753_LIMITI_IND_RENDICONTO T753,'
      '     T752_TASK_RENDICONTO T752,'
      '     T751_ATTIVITA_RENDICONTO T751,'
      '     T750_PROGETTI_RENDICONTO T750'
      'where T753.DECORRENZA <= :AL'
      'and T753.DECORRENZA_FINE >= :DAL'
      'and T752.ID = T753.ID_T752'
      'and T751.ID = T752.ID_T751'
      'and T750.ID = T751.ID_T750'
      'and T750.ID IN (:FILTRO_PROGETTO)'
      
        'order by T750.CODICE, T751.CODICE, T752.CODICE, T753.PROGRESSIVO' +
        ', D_INI')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A0041004C000C00000000000000000000000800
      00003A00440041004C000C0000000000000000000000200000003A0046004900
      4C00540052004F005F00500052004F0047004500540054004F00010000000000
      000000000000}
    Left = 80
    Top = 16
  end
  object cdsLista: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 192
    Top = 16
  end
  object cdsListaGG: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 304
    Top = 16
  end
  object cdsListaPag: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 16
  end
  object cdsT755Tab: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 216
    Top = 72
  end
  object dsrT755Tab: TDataSource
    DataSet = cdsT755Tab
    Left = 280
    Top = 72
  end
  object selaT755: TOracleDataSet
    SQL.Strings = (
      'select T755.DATA, '
      '       --sum(OREMINUTI(T755.ORE)) ORE_RICHIESTE_GG, '
      
        '       --sum(decode(T850.STATO,'#39'S'#39',OREMINUTI(T755.ORE),0)) ORE_A' +
        'UTORIZZATE,'
      
        '       sum(OREMINUTI(nvl(T852.VALORE,T755.ORE))) ORE_RICHIESTE_G' +
        'G, '
      
        '       sum(OREMINUTI(decode(T751.ID_T750,:ID_T750,nvl(T852.VALOR' +
        'E,T755.ORE),0))) ORE_RICHIESTE_PROJ, '
      
        '       sum(OREMINUTI(nvl(T852.VALORE,decode(T850.STATO,'#39'S'#39',T755.' +
        'ORE,0)))) ORE_AUTORIZZATE'
      'from T755_RICHIESTE_RENDICONTO T755,'
      '     T752_TASK_RENDICONTO T752,'
      '     T751_ATTIVITA_RENDICONTO T751,'
      '     T850_ITER_RICHIESTE T850,'
      '     T852_ITER_DATI_AUTORIZZATORI T852'
      'where T755.PROGRESSIVO = :PROGRESSIVO'
      'and T755.DATA between :DAL and :AL'
      'and T755.ID = T850.ID'
      'and nvl(T850.STATO,'#39'S'#39') = '#39'S'#39
      'and T852.ID (+) = T850.ID'
      'and T852.DATO (+) = '#39'ORE'#39
      'and T755.ID_T752 = T752.ID (+)'
      'and T752.ID_T751 = T751.ID (+)'
      'group by T755.DATA'
      'order by T755.DATA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C00000000000000000000001000
      00003A00490044005F005400370035003000030000000000000000000000}
    Left = 24
    Top = 72
  end
  object updT753: TOracleQuery
    SQL.Strings = (
      'update T753_LIMITI_IND_RENDICONTO'
      
        'set ORE_FRUITO = MINUTIORE(greatest(OREMINUTI(ORE_FRUITO) + :VAR' +
        'IAZIONE,0))'
      'where ID_T752 = :ID_T752'
      'and PROGRESSIVO = :PROGRESSIVO'
      'and :DATA between DECORRENZA and DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000160000003A00560041005200490041005A0049004F00
      4E004500030000000000000000000000100000003A00490044005F0054003700
      35003200030000000000000000000000}
    Left = 80
    Top = 72
  end
  object selT750: TOracleDataSet
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
    OnFilterRecord = selT750FilterRecord
    Left = 136
    Top = 16
  end
  object selbT755: TOracleDataSet
    SQL.Strings = (
      'select T755.ID_T752, '
      '       --sum(OREMINUTI(T755.ORE)) ORE_RICHIESTE_TASK, '
      
        '       sum(OREMINUTI(nvl(T852.VALORE,T755.ORE))) ORE_RICHIESTE_T' +
        'ASK'
      'from T755_RICHIESTE_RENDICONTO T755,'
      '     T850_ITER_RICHIESTE T850,'
      '     T852_ITER_DATI_AUTORIZZATORI T852'
      'where T755.PROGRESSIVO = :PROGRESSIVO'
      'and T755.DATA between :DAL and :AL'
      'and T755.ID = T850.ID'
      'and nvl(T850.STATO,'#39'S'#39') = '#39'S'#39
      'and T852.ID (+) = T850.ID'
      'and T852.DATO (+) = '#39'ORE'#39
      'group by T755.ID_T752'
      'order by T755.ID_T752')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 24
    Top = 128
  end
end
