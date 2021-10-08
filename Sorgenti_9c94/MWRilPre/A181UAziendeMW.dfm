inherited A181FAziendeMW: TA181FAziendeMW
  OldCreateOrder = True
  Height = 230
  Width = 472
  object selI097: TOracleDataSet
    SQL.Strings = (
      'SELECT I097.*, I097.ROWID'
      '  FROM MONDOEDP.I097_VALIDITA_ITER_AUT I097'
      ' WHERE I097.AZIENDA = :AZIENDA'
      ' ORDER BY I097.ITER, I097.COD_ITER, I097.NUM_CONDIZ')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    OnApplyRecord = selI097ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selI097BeforePost
    OnNewRecord = selI097NewRecord
    Left = 86
    Top = 12
    object selI097AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI097ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 10
    end
    object selI097COD_ITER: TStringField
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selI097NUM_CONDIZ: TIntegerField
      FieldName = 'NUM_CONDIZ'
      Visible = False
    end
    object selI097CONDIZ_VALIDITA: TStringField
      DisplayLabel = 'Condizione validit'#224
      DisplayWidth = 30
      FieldName = 'CONDIZ_VALIDITA'
      Size = 2000
    end
    object selI097MESSAGGIO: TStringField
      DisplayLabel = 'Messaggio'
      DisplayWidth = 30
      FieldName = 'MESSAGGIO'
      Size = 2000
    end
    object selI097BLOCCANTE: TStringField
      DisplayLabel = 'Bloccante'
      FieldName = 'BLOCCANTE'
      Size = 1
    end
  end
  object selI094: TOracleDataSet
    SQL.Strings = (
      'SELECT I094.*, I094.ROWID'
      '  FROM MONDOEDP.I094_CHKDATI_ITER_AUT I094'
      ' WHERE I094.AZIENDA = :AZIENDA'
      ' ORDER BY I094.ITER')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    OnApplyRecord = selI094ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selI094BeforePost
    OnNewRecord = selI094NewRecord
    Left = 22
    Top = 13
    object selI094AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI094ITER: TStringField
      FieldName = 'ITER'
      Visible = False
      Size = 30
    end
    object selI094d_riepilogo: TStringField
      DisplayLabel = 'Riepilogo'
      FieldKind = fkLookup
      FieldName = 'd_riepilogo'
      LookupDataSet = cdsBloccoRiep
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'RIEPILOGO'
      Size = 50
      Lookup = True
    end
    object selI094RIEPILOGO: TStringField
      DisplayLabel = 'Riepilogo'
      DisplayWidth = 30
      FieldName = 'RIEPILOGO'
      Visible = False
      Size = 5
    end
    object selI094STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Size = 1
    end
    object selI094EXPR_DATA: TStringField
      DisplayLabel = 'Data di controllo'
      DisplayWidth = 30
      FieldName = 'EXPR_DATA'
      Size = 2000
    end
  end
  object cdsBloccoRiep: TClientDataSet
    PersistDataPacket.Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020005000B4445534352495A49
      4F4E4501004900000001000557494454480200020032000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 25
    Top = 87
  end
  object Ins091: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I091_DATIENTE '
      '(AZIENDA, ORDINE, TIPO) '
      'VALUES '
      '(:AZIENDA, :ORDINE, :TIPO) '
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      00000E0000003A004F005200440049004E004500030000000000000000000000}
    Left = 224
    Top = 12
  end
  object scrdelI090: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete mondoedp.i091_datiente where azienda = :azienda;'
      '  delete mondoedp.i092_logtabelle where azienda = :azienda;'
      '  --delete mondoedp.i070_utenti where azienda = :azienda;'
      '  --delete mondoedp.i071_permessi where azienda = :azienda;'
      
        '  --delete mondoedp.i072_filtroanagrafe where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i073_filtrofunzioni where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i074_filtrodizionario where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i060_login_dipendente where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i061_profili_dipendente where azienda = :azi' +
        'enda;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 225
    Top = 76
  end
  object scrupdI090: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  update mondoedp.i091_datiente set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i092_logtabelle set azienda = :azienda_new whe' +
        're azienda = :azienda_old;'
      
        '  update mondoedp.i070_utenti set azienda = :azienda_new where a' +
        'zienda = :azienda_old;'
      
        '  update mondoedp.i071_permessi set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i072_filtroanagrafe set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i073_filtrofunzioni set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i074_filtrodizionario set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i060_login_dipendente set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i061_profili_dipendente set azienda = :azienda' +
        '_new where azienda = :azienda_old;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0041005A00490045004E00440041005F004E00
      45005700050000000000000000000000180000003A0041005A00490045004E00
      440041005F004F004C004400050000000000000000000000}
    Left = 281
    Top = 76
  end
  object DBMondoedp: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 24
    Top = 150
  end
  object scrI092: TOracleQuery
    ReadBuffer = 1
    Optimize = False
    Left = 285
    Top = 12
  end
end
