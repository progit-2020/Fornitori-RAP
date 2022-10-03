inherited A115FIterAutorizzativiDM: TA115FIterAutorizzativiDM
  OldCreateOrder = True
  Height = 555
  Width = 748
  object selI093: TOracleDataSet
    SQL.Strings = (
      'SELECT I093.*, '
      
        '  length(concatena_testo('#39'select '#39#39'X'#39#39' from mondoedp.i094_chkdat' +
        'i_iter_aut where azienda = '#39#39#39'||I093.AZIENDA||'#39#39#39' and ITER = '#39#39#39 +
        '||I093.ITER||'#39#39#39#39','#39#39')) CHKDATI_ITER_AUT,'
      '  I093.ROWID'
      '  FROM MONDOEDP.I093_BASE_ITER_AUT I093'
      ' WHERE I093.AZIENDA = :AZIENDA'
      ' ORDER BY I093.ITER')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    UpdatingTable = 'MONDOEDP.I093_BASE_ITER_AUT'
    CommitOnPost = False
    BeforeInsert = selI093BeforeInsert
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selI093AfterScroll
    OnCalcFields = selI093CalcFields
    Left = 24
    Top = 19
    object selI093AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI093D_iter: TStringField
      DisplayLabel = 'Iter'
      FieldKind = fkCalculated
      FieldName = 'D_iter'
      Size = 100
      Calculated = True
    end
    object selI093ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 30
    end
    object selI093REVOCABILE: TStringField
      DisplayLabel = 'Revocabile'
      FieldName = 'REVOCABILE'
      Size = 1
    end
    object selI093MAIL_OGGETTO_DIP: TStringField
      DisplayLabel = 'Mail oggetto richiedente'
      DisplayWidth = 30
      FieldName = 'MAIL_OGGETTO_DIP'
      Size = 2000
    end
    object selI093MAIL_CORPO_DIP: TStringField
      DisplayLabel = 'Mail corpo richiedente'
      DisplayWidth = 30
      FieldName = 'MAIL_CORPO_DIP'
      Size = 2000
    end
    object selI093MAIL_OGGETTO_RESP: TStringField
      DisplayLabel = 'Mail oggetto autorizzatore'
      DisplayWidth = 30
      FieldName = 'MAIL_OGGETTO_RESP'
      Size = 2000
    end
    object selI093MAIL_CORPO_RESP: TStringField
      DisplayLabel = 'Mail corpo autorizzatore'
      DisplayWidth = 30
      FieldName = 'MAIL_CORPO_RESP'
      Size = 2000
    end
    object selI093EXPR_PERIODO_VISUAL: TStringField
      DisplayLabel = 'Periodo visualizzazione'
      DisplayWidth = 30
      FieldName = 'EXPR_PERIODO_VISUAL'
      Size = 2000
    end
    object selI093CHKDATI_ITER_AUT: TFloatField
      DisplayLabel = 'Controllo riepiloghi'
      FieldName = 'CHKDATI_ITER_AUT'
      ReadOnly = True
      Visible = False
    end
    object selI093C_CHKDATI_ITER_AUT: TStringField
      DisplayLabel = 'Controllo riepiloghi'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_CHKDATI_ITER_AUT'
      Calculated = True
    end
  end
  object dsrI093: TDataSource
    DataSet = selI093
    Left = 23
    Top = 66
  end
  object selI095: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  I095.*, I095.ROWID,'
      
        '  length(concatena_testo('#39'select '#39#39'X'#39#39' from mondoedp.i097_validi' +
        'ta_iter_aut where azienda = '#39#39#39'||I095.AZIENDA||'#39#39#39' and ITER = '#39#39 +
        #39'||I095.ITER||'#39#39#39' and COD_ITER = '#39#39#39'||I095.COD_ITER||'#39#39#39#39','#39#39')) V' +
        'ALIDITA_ITER_AUT'
      '  FROM MONDOEDP.I095_ITER_AUT I095'
      ' WHERE I095.AZIENDA = :AZIENDA'
      '   AND I095.ITER = :ITER'
      ' ORDER BY I095.ITER, I095.COD_ITER')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    UpdatingTable = 'MONDOEDP.I095_ITER_AUT'
    CommitOnPost = False
    AfterOpen = selI095AfterOpen
    BeforeInsert = selI095BeforeInsert
    BeforePost = selI095BeforePost
    AfterPost = selI095AfterPost
    BeforeCancel = selI095BeforeCancel
    BeforeDelete = selI095BeforeDelete
    AfterScroll = selI095AfterScroll
    OnCalcFields = selI095CalcFields
    OnNewRecord = selI095NewRecord
    Left = 132
    Top = 20
    object selI095AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI095ITER: TStringField
      DisplayLabel = 'Iter'
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object selI095COD_ITER: TStringField
      DisplayLabel = 'Cod. struttura'
      DisplayWidth = 20
      FieldName = 'COD_ITER'
      Size = 30
    end
    object selI095DESCRIZIONE: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selI095FILTRO_RICHIESTA: TStringField
      DisplayLabel = 'Condiz. per riconoscimento Struttura'
      DisplayWidth = 30
      FieldName = 'FILTRO_RICHIESTA'
      Size = 2000
    end
    object selI095CONDIZ_AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Condiz. per autorizz. automatica'
      DisplayWidth = 30
      FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
      Size = 2000
    end
    object selI095MAX_LIV_AUTORIZZ_AUTOMATICA: TIntegerField
      DisplayLabel = 'Autorizz. automatica fino al livello'
      FieldName = 'MAX_LIV_AUTORIZZ_AUTOMATICA'
      MaxValue = 99
      MinValue = -1
    end
    object selI095FILTRO_INTERFACCIA: TStringField
      DisplayLabel = 'Filtrabile'
      FieldName = 'FILTRO_INTERFACCIA'
      Size = 1
    end
    object selI095VALIDITA_ITER_AUT2: TFloatField
      FieldName = 'VALIDITA_ITER_AUT'
      ReadOnly = True
      Visible = False
    end
    object selI095VALIDITA_ITER_AUT: TStringField
      DisplayLabel = 'Condiz. di validit'#224
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_VALIDITA_ITER_AUT'
      Calculated = True
    end
    object selI095MAX_LIV_NOTE_MODIFICABILI: TIntegerField
      DisplayLabel = 'Max liv. note modificabili'
      FieldName = 'MAX_LIV_NOTE_MODIFICABILI'
      MaxValue = 99
      MinValue = -1
    end
    object selI095CONDIZIONE_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      DisplayWidth = 20
      FieldName = 'CONDIZIONE_ALLEGATI'
      Size = 2000
    end
    object selI095ALLEGATI_MODIFICABILI: TStringField
      DisplayLabel = 'Allegati modif.'
      DisplayWidth = 20
      FieldName = 'ALLEGATI_MODIFICABILI'
      Size = 2000
    end
  end
  object dsrI095: TDataSource
    DataSet = selI095
    Left = 132
    Top = 69
  end
  object dsrI096: TDataSource
    DataSet = selI096
    Left = 188
    Top = 69
  end
  object selI096: TOracleDataSet
    SQL.Strings = (
      'SELECT I096.*, I096.ROWID'
      '  FROM MONDOEDP.I096_LIVELLI_ITER_AUT I096'
      ' WHERE I096.AZIENDA = :AZIENDA'
      '   AND I096.ITER = :ITER'
      '   AND I096.COD_ITER = :COD_ITER'
      ' ORDER BY I096.ITER, I096.LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    BeforeInsert = selI096BeforeInsert
    BeforePost = selI096BeforePost
    AfterPost = selI096AfterPost
    BeforeDelete = selI096BeforeDelete
    OnNewRecord = selI096NewRecord
    Left = 188
    Top = 20
    object selI096AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI096ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object selI096COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 10
      FieldName = 'COD_ITER'
      Visible = False
      Size = 30
    end
    object selI096LIVELLO: TIntegerField
      DisplayLabel = 'Livello'
      DisplayWidth = 1
      FieldName = 'LIVELLO'
      MaxValue = 9
      MinValue = 1
    end
    object selI096DESC_LIVELLO: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESC_LIVELLO'
      Size = 40
    end
    object selI096FASE: TIntegerField
      DisplayLabel = 'Fase'
      DisplayWidth = 10
      FieldName = 'FASE'
    end
    object selI096OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      DisplayWidth = 1
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selI096AVVISO: TStringField
      DisplayLabel = 'Avviso'
      DisplayWidth = 5
      FieldName = 'AVVISO'
      Visible = False
      Size = 1
    end
    object selI096VALORI_POSSIBILI: TStringField
      DisplayLabel = 'Valori possibili'
      DisplayWidth = 10
      FieldName = 'VALORI_POSSIBILI'
      Size = 100
    end
    object selI096AUTORIZZ_INTERMEDIA: TStringField
      DisplayLabel = 'Autorizz. intermedia'
      FieldName = 'AUTORIZZ_INTERMEDIA'
      Size = 1
    end
    object selI096DATI_MODIFICABILI: TStringField
      DisplayLabel = 'Dati modificabili'
      DisplayWidth = 5
      FieldName = 'DATI_MODIFICABILI'
      Size = 1
    end
    object selI096INVIO_EMAIL: TStringField
      DisplayLabel = 'Invio e-mail'
      FieldName = 'INVIO_EMAIL'
      Size = 1
    end
    object selI096CONDIZ_AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Condiz. per autorizz. automatica'
      DisplayWidth = 30
      FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
      Size = 2000
    end
    object selI096SCRIPT_AUTORIZZ: TStringField
      DisplayLabel = 'Script  di autorizzazione'
      DisplayWidth = 20
      FieldName = 'SCRIPT_AUTORIZZ'
      Size = 2000
    end
    object selI096ALLEGATI_OBBLIGATORI: TStringField
      DisplayLabel = 'Alleg. obblig.'
      FieldName = 'ALLEGATI_OBBLIGATORI'
      Size = 1
    end
    object selI096ALLEGATI_VISIBILI: TStringField
      DisplayLabel = 'Alleg. visibili'
      FieldName = 'ALLEGATI_VISIBILI'
      Size = 1
    end
  end
end
