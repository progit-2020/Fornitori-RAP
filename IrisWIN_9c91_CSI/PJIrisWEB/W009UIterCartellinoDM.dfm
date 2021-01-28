object W009FIterCartellinoDM: TW009FIterCartellinoDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 138
  Width = 279
  object selT860: TOracleDataSet
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
    AfterOpen = selT860AfterOpen
    OnCalcFields = selT860CalcFields
    Left = 30
    Top = 20
    object selT860ID: TFloatField
      FieldName = 'ID'
    end
    object selT860ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT860ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT860PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT860NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT860MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT860COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT860TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT860AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT860REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT860DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selT860LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT860FASE_CORRENTE: TFloatField
      FieldName = 'FASE_CORRENTE'
    end
    object selT860DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT860AUTORIZZAZIONE: TStringField
      DisplayLabel = ' '
      FieldName = 'AUTORIZZAZIONE'
      Visible = False
      Size = 1
    end
    object selT860NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object selT860NOMINATIVO_RESP2: TStringField
      FieldName = 'NOMINATIVO_RESP2'
      Size = 61
    end
    object selT860AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT860AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT860D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT860D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT860MESE_CARTELLINO: TDateTimeField
      FieldName = 'MESE_CARTELLINO'
    end
    object selT860ESISTE_PDF: TStringField
      DisplayLabel = 'Esiste PDF'
      FieldName = 'ESISTE_PDF'
      Size = 1
    end
    object selT860D_AUTORIZZAZIONE_FINALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE_FINALE'
      Size = 2
      Calculated = True
    end
    object selT860CF_RIEPILOGHI: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_RIEPILOGHI'
      Size = 4000
      Calculated = True
    end
  end
  object selRichiestePendenti: TOracleDataSet
    SQL.Strings = (
      'select '#39'M140'#39' ITER, count(T850.ID) NUM_RICHIESTE'
      'from   M140_RICHIESTE_MISSIONI M140, '
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'M140'#39
      'and    T850.ID = M140.ID'
      'and    M140.PROGRESSIVO = :PROGRESSIVO'
      'and    M140.DATADA <= :DATA2 '
      'and    M140.DATAA >= :DATA1 '
      'and    T850.STATO is null'
      'union all'
      'select '#39'T050'#39', count(T850.ID)'
      'from   T050_RICHIESTEASSENZA T050, '
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'T050'#39
      'and    T850.ID = T050.ID'
      'and    T050.PROGRESSIVO = :PROGRESSIVO'
      'and    T050.DAL <= :DATA2 '
      'and    T050.AL >= :DATA1 '
      'and    (T850.STATO is null or T050.ELABORATO = '#39'N'#39')'
      'union all'
      'select '#39'T065'#39', count(T850.ID)'
      'from   T065_RICHIESTESTRAORDINARI T065,'
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'T065'#39
      'and    T850.ID = T065.ID'
      'and    T065.PROGRESSIVO = :PROGRESSIVO'
      'and    T065.DATA between :DATA1 and :DATA2 '
      'and    T850.STATO is null'
      
        'and    T180F_STATORIEPILOGO('#39'T820'#39',T065.PROGRESSIVO,T065.DATA) =' +
        ' '#39'A'#39
      
        'and    T065.DATA >= add_months(trunc(sysdate,'#39'mm'#39'),nvl(I091F_GET' +
        'DATO('#39'C90_W024MMINDIETRO'#39'),1)*-1)'
      'union all'
      'select '#39'T085'#39', count(T850.ID)'
      'from   T085_RICHIESTECAMBIORARI T085,'
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'T085'#39
      'and    T850.ID = T085.ID'
      'and    T085.PROGRESSIVO = :PROGRESSIVO'
      'and    T085.DATA between :DATA1 and :DATA2 '
      'and    T850.STATO is null'
      'union all'
      'select '#39'T105'#39', count(T850.ID)'
      'from   T105_RICHIESTETIMBRATURE T105,'
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'T105'#39
      'and    T850.ID = T105.ID'
      'and    T105.PROGRESSIVO = :PROGRESSIVO'
      'and    T105.DATA between :DATA1 and :DATA2 '
      'and    (T850.STATO is null or T105.ELABORATO = '#39'N'#39')'
      'union all'
      'select '#39'T325'#39', count(T850.ID)'
      'from   :VISTAT325 T325,'
      '       T850_ITER_RICHIESTE T850'
      'where  T850.ITER = '#39'T325'#39
      'and    T850.ID = T325.ID'
      'and    T325.PROGRESSIVO = :PROGRESSIVO'
      'and    T325.DATA between :DATA1 and :DATA2 '
      'and    T850.STATO is null'
      'and    T850.TIPO_RICHIESTA = '#39'R'#39
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003200
      0C00000000000000000000000C0000003A00440041005400410031000C000000
      0000000000000000140000003A00560049005300540041005400330032003500
      010000000000000000000000}
    Left = 193
    Top = 20
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      
        'select T070.DATA,T180F_STATORIEPILOGO('#39'T860'#39',T070.PROGRESSIVO,T0' +
        '70.DATA) RIEPILOGO_T860'
      'from   T070_SCHEDARIEPIL T070,'
      '       T860_ITER_STAMPACARTELLINI T860'
      'where  T070.PROGRESSIVO = :PROGRESSIVO'
      'and    T070.DATA between :DATA1 and :DATA2'
      'and    T860.PROGRESSIVO (+) = T070.PROGRESSIVO '
      'and    T860.MESE_CARTELLINO (+) = T070.DATA'
      'and    T860.PROGRESSIVO is null'
      'and    T860.MESE_CARTELLINO is null'
      'order by T070.DATA')
    ReadBuffer = 13
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 103
    Top = 20
  end
  object scrBloccaRiep: TOracleQuery
    SQL.Strings = (
      'begin'
      '  T180P_BLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al);'
      '  -- commit non eseguita qui'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      0000}
    Left = 32
    Top = 80
  end
  object scrSbloccaRiep: TOracleQuery
    SQL.Strings = (
      'begin'
      '  T180P_SBLOCCARIEPILOGHI(:progressivo,:riepilogo,:dal,:al);'
      '  -- commit non eseguita qui'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0052004900450050004900
      4C004F0047004F00050000000000000000000000080000003A00440041004C00
      0C0000000000000000000000060000003A0041004C000C000000000000000000
      0000}
    Left = 112
    Top = 80
  end
end
