inherited Ac03FValidazioneCartellinoDtM: TAc03FValidazioneCartellinoDtM
  OldCreateOrder = True
  Height = 130
  Width = 320
  object selT860: TOracleDataSet
    SQL.Strings = (
      'select T030.PROGRESSIVO,'
      '       T030.MATRICOLA, '
      '       T030.COGNOME, '
      '       T030.NOME, '
      '       T430D_SEDE SEDE, '
      '       T070.DATA MESE_SCHEDA,'
      
        '       T180F_STATORIEPILOGO('#39'T860A'#39',T070.PROGRESSIVO,T070.DATA) ' +
        'STATO_T180A,'
      
        '       T180F_STATORIEPILOGO('#39'T860'#39',T070.PROGRESSIVO,T070.DATA) S' +
        'TATO, '
      '       T850.ID,'
      '       T850.COD_ITER,'
      '       T850.TIPO_RICHIESTA,'
      
        '       T851F_MAXLIV_AUTORIZZATO(T000F_GETAZIENDACORRENTE,T850.IT' +
        'ER,T850.ID) MAX_LIV_AUT,'
      '       T851F_STATO_LIVELLO(T850.ID, 1) AUT_LIV_1,'
      '       T850.STATO AUT_FINALE,'
      '       T860.MESE_CARTELLINO, '
      '       nvl(T860.ESISTE_PDF,'#39'N'#39') ESISTE_PDF, '
      '       T860.DATA_PDF,'
      
        '       I060F_EMAIL(T000F_GETAZIENDACORRENTE,T030.PROGRESSIVO) EM' +
        'AIL'
      'from   T070_SCHEDARIEPIL T070,'
      '       T860_ITER_STAMPACARTELLINI T860,'
      '       T850_ITER_RICHIESTE T850,'
      ':C700SELANAGRAFE'
      'and    T070.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T070.DATA = trunc(:DATALAVORO,'#39'mm'#39')'
      'and    T860.PROGRESSIVO(+) = T070.PROGRESSIVO'
      'and    T860.MESE_CARTELLINO(+) = T070.DATA'
      'and    T850.ID(+) = T860.ID'
      ':FILTRO'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000003000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000160000003A004400
      4100540041004C00410056004F0052004F000C00000000000000000000000E00
      00003A00460049004C00540052004F00010000000000000000000000}
    OnCalcFields = selT860CalcFields
    Left = 24
    Top = 9
    object selT860PROGRESSIVO2: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT860MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT860COGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 15
      FieldName = 'COGNOME'
      Size = 30
    end
    object selT860NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'NOME'
      Size = 30
    end
    object selT860SEDE: TStringField
      DisplayLabel = 'Sede'
      DisplayWidth = 20
      FieldName = 'SEDE'
      Size = 60
    end
    object selT860EMAIL: TStringField
      DisplayLabel = 'Email'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selT860MESE_SCHEDA: TDateTimeField
      DisplayLabel = 'Mese scheda'
      DisplayWidth = 10
      FieldName = 'MESE_SCHEDA'
      Visible = False
      DisplayFormat = 'mmmm yyyy'
    end
    object selT860STATO_T180A: TStringField
      FieldName = 'STATO_T180A'
      Visible = False
      Size = 1
    end
    object selT860STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selT860C_ITER_DISPONIBILE: TStringField
      DisplayLabel = 'Iter disponibile'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'C_ITER_DISPONIBILE'
      Size = 40
      Calculated = True
    end
    object selT860C_STATO_VALIDAZIONE: TStringField
      DisplayLabel = 'Stato validazione'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'C_STATO_VALIDAZIONE'
      Size = 40
      Calculated = True
    end
    object selT860ID2: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT860COD_ITER2: TStringField
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selT860TIPO_RICHIESTA2: TStringField
      DisplayLabel = 'Tipo richiesta'
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selT860MAX_LIV_AUT: TFloatField
      DisplayLabel = 'Max. liv. aut.'
      DisplayWidth = 2
      FieldName = 'MAX_LIV_AUT'
      Visible = False
    end
    object selT860AUT_LIV_1: TStringField
      DisplayLabel = 'Aut. liv. 1'
      FieldName = 'AUT_LIV_1'
      Visible = False
      Size = 1
    end
    object selT860AUT_FINALE: TStringField
      DisplayLabel = 'Aut. finale'
      FieldName = 'AUT_FINALE'
      Visible = False
      Size = 1
    end
    object selT860MESE_CARTELLINO: TDateTimeField
      DisplayLabel = 'Mese cartellino'
      DisplayWidth = 10
      FieldName = 'MESE_CARTELLINO'
      Visible = False
      DisplayFormat = 'mmm yyyy'
    end
    object selT860ESISTE_PDF: TStringField
      DisplayLabel = 'PDF'
      FieldName = 'ESISTE_PDF'
      Size = 1
    end
    object selT860DATA_PDF: TDateTimeField
      DisplayLabel = 'Data PDF'
      DisplayWidth = 10
      FieldName = 'DATA_PDF'
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select I060.EMAIL'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = T000F_GETAZIENDACORRENTE'
      'and    I060.MATRICOLA = T030.MATRICOLA'
      'and    T030.PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Left = 168
    Top = 9
  end
  object selT860Iter: TOracleDataSet
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
    OnCalcFields = selT860CalcFields
    Left = 97
    Top = 9
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
    object StringField1: TStringField
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
    object DateTimeField1: TDateTimeField
      FieldName = 'MESE_CARTELLINO'
    end
    object StringField2: TStringField
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
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select T070.DATA'
      'from   T070_SCHEDARIEPIL T070'
      'where  T070.PROGRESSIVO = :PROGRESSIVO'
      'and    T070.DATA = :MESERIF'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004D004500530045005200
      490046000C0000000000000000000000}
    Left = 23
    Top = 70
  end
  object updT860: TOracleQuery
    SQL.Strings = (
      'update T860_ITER_STAMPACARTELLINI'
      'set    ESISTE_PDF = '#39'N'#39','
      '       DATA_PDF = null'
      'where  ID = :ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 96
    Top = 70
  end
  object selI075Profilo: TOracleDataSet
    SQL.Strings = (
      'select PROFILO, COD_ITER'
      'from   MONDOEDP.I075_ITER_AUTORIZZATIVI'
      'where  AZIENDA = :AZIENDA'
      'and    ITER = '#39'T860'#39' '
      'and    ACCESSO = '#39'F'#39
      'and    LIVELLO = 1'
      'intersect '
      'select PROFILO, COD_ITER'
      'from   MONDOEDP.I075_ITER_AUTORIZZATIVI'
      'where  AZIENDA = :AZIENDA'
      'and    ITER = '#39'T860'#39' '
      'and    ACCESSO = '#39'F'#39
      'and    LIVELLO = i096f_ultimoliv_obb(ITER, COD_ITER)'
      'order by 1,2')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 232
    Top = 8
  end
  object selI070: TOracleDataSet
    SQL.Strings = (
      'select PASSWD '
      'from   MONDOEDP.I070_UTENTI'
      'where  UTENTE = '#39'SYSMAN'#39
      'and    AZIENDA = :AZIENDA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    ReadOnly = True
    Left = 168
    Top = 70
  end
end
