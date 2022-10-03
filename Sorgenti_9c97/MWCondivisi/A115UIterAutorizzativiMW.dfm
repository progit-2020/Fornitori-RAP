inherited A115FIterAutorizzativiMW: TA115FIterAutorizzativiMW
  OldCreateOrder = True
  Height = 352
  Width = 622
  object selI097: TOracleDataSet
    SQL.Strings = (
      'SELECT I097.*, I097.ROWID'
      '  FROM MONDOEDP.I097_VALIDITA_ITER_AUT I097'
      ' WHERE I097.AZIENDA = :AZIENDA'
      '   AND I097.ITER = :ITER'
      '   AND I097.COD_ITER = :COD_ITER'
      ' ORDER BY I097.ITER, I097.COD_ITER, I097.NUM_CONDIZ')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selI097BeforePost
    OnNewRecord = selI097NewRecord
    Left = 75
    Top = 20
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
      DisplayWidth = 20
      FieldName = 'COD_ITER'
      Visible = False
      Size = 30
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
      '   AND I094.ITER = :ITER'
      ' ORDER BY I094.ITER')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selI094BeforePost
    OnNewRecord = selI094NewRecord
    Left = 19
    Top = 21
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
    Left = 141
    Top = 20
  end
  object scrI093P_AGGIORNA_ITER: TOracleQuery
    SQL.Strings = (
      'begin'
      '  I093P_AGGIORNA_ITER(:AZIENDA, :ITER);'
      'end;'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 64
    Top = 104
  end
end
