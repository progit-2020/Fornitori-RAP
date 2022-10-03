object A053FSquadreDtM1: TA053FSquadreDtM1
  OldCreateOrder = True
  OnCreate = A053FSquadreDtM1Create
  OnDestroy = A053FSquadreDtM1Destroy
  Height = 130
  Width = 409
  object D601: TDataSource
    DataSet = Q601
    Left = 96
    Top = 8
  end
  object Q600: TOracleDataSet
    SQL.Strings = (
      'SELECT T600.*,T600.ROWID FROM T600_SQUADRE T600 ORDER BY CODICE')
    Optimize = False
    CachedUpdates = True
    BeforeInsert = Q600BeforeInsert
    BeforePost = Q600BeforePost
    AfterPost = Q600AfterPost
    AfterCancel = Q600AfterCancel
    BeforeDelete = Q600BeforeDelete
    AfterDelete = Q600AfterDelete
    Left = 16
    Top = 8
    object Q600CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T600_SQUADRE.CODICE'
      Required = True
      Size = 5
    end
    object Q600TOTMIN1: TIntegerField
      FieldName = 'TOTMIN1'
    end
    object Q600TOTMAX1: TIntegerField
      FieldName = 'TOTMAX1'
    end
    object Q600FESMIN1: TIntegerField
      FieldName = 'FESMIN1'
    end
    object Q600FESMAX1: TIntegerField
      FieldName = 'FESMAX1'
    end
    object Q600TOTMIN2: TIntegerField
      FieldName = 'TOTMIN2'
    end
    object Q600TOTMAX2: TIntegerField
      FieldName = 'TOTMAX2'
    end
    object Q600FESMIN2: TIntegerField
      FieldName = 'FESMIN2'
    end
    object Q600FESMAX2: TIntegerField
      FieldName = 'FESMAX2'
    end
    object Q600TOTMAX3: TIntegerField
      FieldName = 'TOTMAX3'
    end
    object Q600TOTMIN3: TIntegerField
      FieldName = 'TOTMIN3'
    end
    object Q600FESMIN3: TIntegerField
      FieldName = 'FESMIN3'
    end
    object Q600FESMAX3: TIntegerField
      FieldName = 'FESMAX3'
    end
    object Q600TOTMIN4: TIntegerField
      FieldName = 'TOTMIN4'
    end
    object Q600TOTMAX4: TIntegerField
      FieldName = 'TOTMAX4'
    end
    object Q600FESMIN4: TIntegerField
      FieldName = 'FESMIN4'
    end
    object Q600FESMAX4: TIntegerField
      FieldName = 'FESMAX4'
    end
    object Q600DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T600_SQUADRE.DESCRIZIONE'
      Size = 40
    end
    object Q600DESCRIZIONELUNGA: TStringField
      FieldName = 'DESCRIZIONELUNGA'
      Origin = 'T600_SQUADRE.DESCRIZIONELUNGA'
      Size = 80
    end
    object Q600CAUS_RIPOSO: TStringField
      FieldName = 'CAUS_RIPOSO'
      Size = 5
    end
    object Q600MIN_IND1: TIntegerField
      FieldName = 'MIN_IND1'
    end
    object Q600MIN_IND2: TIntegerField
      FieldName = 'MIN_IND2'
    end
    object Q600MIN_IND3: TIntegerField
      FieldName = 'MIN_IND3'
    end
    object Q600MIN_IND4: TIntegerField
      FieldName = 'MIN_IND4'
    end
    object Q600MIN_FESTIVITA_MESE: TIntegerField
      FieldName = 'MIN_FESTIVITA_MESE'
    end
    object Q600PERIODO_MATUR_IND: TIntegerField
      FieldName = 'PERIODO_MATUR_IND'
    end
    object Q600PRIORITA_MINMAX: TStringField
      FieldName = 'PRIORITA_MINMAX'
      Size = 4
    end
  end
  object Q601: TOracleDataSet
    SQL.Strings = (
      'SELECT T601.*,T601.ROWID FROM T601_TIPIOPERATORE T601'
      'WHERE SQUADRA = :SQUADRA'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    ReadOnly = True
    CachedUpdates = True
    OnNewRecord = Q601NewRecord
    Left = 56
    Top = 8
    object Q601CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object Q601MIN1: TIntegerField
      DisplayWidth = 5
      FieldName = 'Min1'
    end
    object Q601MAX1: TIntegerField
      DisplayWidth = 5
      FieldName = 'Max1'
    end
    object Q601FESMIN1: TIntegerField
      DisplayLabel = 'Min Fest. 1'
      FieldName = 'FESMIN1'
    end
    object Q601FESMAX1: TIntegerField
      DisplayLabel = 'Max Fest. 1'
      FieldName = 'FESMAX1'
    end
    object Q601OTTIMALE1FR: TIntegerField
      DisplayLabel = 'Ott. 1 Fer.'
      FieldName = 'OTTIMALE1FR'
    end
    object Q601OTTIMALE1FS: TIntegerField
      DisplayLabel = 'Ott. 1 Fer.'
      FieldName = 'OTTIMALE1FS'
    end
    object Q601MIN2: TIntegerField
      DisplayLabel = 'Min2'
      DisplayWidth = 5
      FieldName = 'MIN2'
    end
    object Q601MAX2: TIntegerField
      DisplayLabel = 'Max2'
      DisplayWidth = 5
      FieldName = 'MAX2'
    end
    object Q601FESMIN2: TIntegerField
      DisplayLabel = 'Min Fest. 2'
      FieldName = 'FESMIN2'
    end
    object Q601FESMAX2: TIntegerField
      DisplayLabel = 'Max Fest. 2'
      FieldName = 'FESMAX2'
    end
    object Q601OTTIMALE2FR: TIntegerField
      DisplayLabel = 'Ott. 2 Fer.'
      FieldName = 'OTTIMALE2FR'
    end
    object Q601OTTIMALE2FS: TIntegerField
      DisplayLabel = 'Ott. 2 Fest.'
      FieldName = 'OTTIMALE2FS'
    end
    object Q601MIN3: TIntegerField
      DisplayLabel = 'Min3'
      DisplayWidth = 5
      FieldName = 'MIN3'
    end
    object Q601MAX3: TIntegerField
      DisplayLabel = 'Max3'
      DisplayWidth = 5
      FieldName = 'MAX3'
    end
    object Q601FESMIN3: TIntegerField
      DisplayLabel = 'Min Fest. 3'
      FieldName = 'FESMIN3'
    end
    object Q601FESMAX3: TIntegerField
      DisplayLabel = 'Max Fest. 3'
      FieldName = 'FESMAX3'
    end
    object Q601OTTIMALE3FR: TIntegerField
      DisplayLabel = 'Ott. 3 Fer.'
      FieldName = 'OTTIMALE3FR'
    end
    object Q601OTTIMALE3FS: TIntegerField
      DisplayLabel = 'Ott. 3 Fest.'
      FieldName = 'OTTIMALE3FS'
    end
    object Q601MIN4: TIntegerField
      DisplayLabel = 'Min4'
      DisplayWidth = 5
      FieldName = 'MIN4'
    end
    object Q601MAX4: TIntegerField
      DisplayLabel = 'Max4'
      DisplayWidth = 5
      FieldName = 'MAX4'
    end
    object Q601FESMIN4: TIntegerField
      DisplayLabel = 'Min Fest. 4'
      FieldName = 'FESMIN4'
    end
    object Q601FESMAX4: TIntegerField
      DisplayLabel = 'Max Fest. 4'
      FieldName = 'FESMAX4'
    end
    object Q601SQUADRA: TStringField
      FieldName = 'SQUADRA'
      Required = True
      Visible = False
      Size = 5
    end
    object Q601ORARIO: TStringField
      FieldName = 'ORARIO'
      Visible = False
      Size = 5
    end
    object Q601PROFILO: TStringField
      DisplayLabel = 'Prof. Turni'
      FieldName = 'PROFILO'
      Size = 5
    end
    object Q601TURNAZ: TStringField
      DisplayLabel = 'Turnazione'
      FieldName = 'TURNAZ'
      Size = 5
    end
  end
  object Q640: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T640_TURNAZIONI '
      'ORDER BY CODICE')
    Optimize = False
    Left = 208
    Top = 8
  end
  object Q601AggiornaSquadra: TOracleQuery
    SQL.Strings = (
      'UPDATE T601_TIPIOPERATORE SET SQUADRA = :SQUADRA '
      'WHERE SQUADRA = :SQUADRA_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00530051005500410044005200410005000000
      0000000000000000180000003A0053005100550041004400520041005F004F00
      4C004400050000000000000000000000}
    Left = 320
    Top = 56
  end
  object Q601CancellaSquadra: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T601_TIPIOPERATORE '
      'WHERE SQUADRA = :SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    Left = 320
    Top = 8
  end
  object Q602: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE from t602_profiliturni order by codic' +
        'e')
    Optimize = False
    Left = 16
    Top = 72
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE, T265.DESCRIZIONE'
      '  FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      ' WHERE T265.CODRAGGR = T260.CODICE'
      '   AND T260.CODINTERNO = '#39'H'#39
      ' ORDER BY CODICE')
    Optimize = False
    Left = 56
    Top = 72
  end
  object DT265: TDataSource
    DataSet = selT265
    Left = 96
    Top = 72
  end
end
