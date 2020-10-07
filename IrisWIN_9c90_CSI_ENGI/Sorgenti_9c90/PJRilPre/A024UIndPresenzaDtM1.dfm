object A024FIndPresenzaDtM1: TA024FIndPresenzaDtM1
  OldCreateOrder = True
  OnCreate = A024FIndPresenzaDtM1Create
  OnDestroy = A024FIndPresenzaDtM1Destroy
  Height = 175
  Width = 631
  object D160: TDataSource
    DataSet = Q160
    Left = 88
    Top = 8
  end
  object D171: TDataSource
    DataSet = Q171
    Left = 40
    Top = 58
  end
  object D162: TDataSource
    DataSet = Look162
    Left = 284
    Top = 52
  end
  object Q163: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,ROWID FROM T163_CODICIINDENNITA'
      'ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    OnApplyRecord = Q163ApplyRecord
    CachedUpdates = True
    BeforeInsert = Q163BeforeEdit
    BeforeEdit = Q163BeforeEdit
    BeforePost = Q163BeforePost
    AfterPost = Q163AfterPost
    AfterCancel = Q163AfterCancel
    BeforeDelete = Q163BeforeDelete
    AfterDelete = Q163AfterDelete
    AfterScroll = Q163AfterScroll
    Left = 12
    Top = 8
    object Q163CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object Q163DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object Q160: TOracleDataSet
    SQL.Strings = (
      'SELECT T160.*,T160.ROWID FROM T160_PROFILIINDENNITA T160'
      'WHERE CODICE = :CODICE ORDER BY INDENNITA'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OnApplyRecord = Q160ApplyRecord
    Left = 60
    Top = 8
    object Q160CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T160_PROFILIINDENNITA.CODICE'
      Visible = False
      Size = 5
    end
    object Q160DESCRIZIONE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupDataSet = Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Visible = False
      Size = 50
      Lookup = True
    end
    object Q160INDENNITA: TStringField
      DisplayLabel = 'Indennit'#224
      FieldName = 'INDENNITA'
      Origin = 'T160_PROFILIINDENNITA.INDENNITA'
      Required = True
      Size = 5
    end
    object Q160D_INDENNITA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupDataSet = Q162
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDENNITA'
      Size = 50
      Lookup = True
    end
  end
  object Ins160: TOracleQuery
    SQL.Strings = (
      'insert into T160_PROFILIINDENNITA'
      '  (CODICE, INDENNITA)'
      'values'
      '  (:CODICE, :INDENNITA)')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000140000003A0049004E00440045004E004E004900540041000500
      00000000000000000000}
    Left = 128
    Top = 8
  end
  object Update160: TOracleQuery
    SQL.Strings = (
      'update T160_PROFILIINDENNITA'
      'set'
      '  INDENNITA = :INDENNITA'
      'where'
      '  CODICE = :OLD_CODICE AND'
      '  INDENNITA = :OLD_INDENNITA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0049004E00440045004E004E00490054004100
      050000000000000000000000160000003A004F004C0044005F0043004F004400
      4900430045000500000000000000000000001C0000003A004F004C0044005F00
      49004E00440045004E004E00490054004100050000000000000000000000}
    Left = 176
    Top = 8
  end
  object Delete160: TOracleQuery
    SQL.Strings = (
      'delete from T160_PROFILIINDENNITA'
      'where'
      '  CODICE = :OLD_CODICE AND'
      '  INDENNITA = :OLD_INDENNITA')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004F004C0044005F0043004F00440049004300
      45000500000000000000000000001C0000003A004F004C0044005F0049004E00
      440045004E004E00490054004100050000000000000000000000}
    Left = 232
    Top = 8
  end
  object Upd160: TOracleQuery
    SQL.Strings = (
      'UPDATE T160_PROFILIINDENNITA SET CODICE = :NEW_CODICE'
      'WHERE CODICE = :OLD_CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004E00450057005F0043004F00440049004300
      4500050000000000000000000000160000003A004F004C0044005F0043004F00
      4400490043004500050000000000000000000000}
    Left = 284
    Top = 8
  end
  object Del160: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T160_PROFILIINDENNITA WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 324
    Top = 8
  end
  object Q162: TOracleDataSet
    SQL.Strings = (
      'SELECT T162.*, T162.ROWID '
      '  FROM T162_INDENNITA T162'
      ' ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000150000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      000049004D0050004F00520054004F000100000000001200000056004F004300
      450050004100470048004500010000000000080000005400490050004F000100
      00000000100000004E0055004D005400550052004E0049000100000000000A00
      00005400550052004E0049000100000000000E00000041005300530045004E00
      5A0045000100000000000E00000043004F004400490043004500320001000000
      00000C0000005400550052004E004F0031000100000000000C00000054005500
      52004E004F0032000100000000000C0000005400550052004E004F0033000100
      000000000C0000005400550052004E004F003400010000000000100000005000
      520049004F0052004900540041000100000000002E00000049004E0044004500
      4E004E004900540041005F0049004E0043004F004D0050004100540049004200
      49004C0049000100000000001800000043004F00450046004600490043004900
      45004E00540045000100000000001C0000004100520052004F0054004F004E00
      440041004D0045004E0054004F00010000000000220000004100530053004500
      4E005A0045005F004100420049004C0049005400410054004500010000000000
      1800000053005500500050004C005F003500470047004C004100560001000000
      00001E00000043004100550050005200450053005F0052004900450050004F00
      520045000100000000001E0000004E004D004500530049005F00450051005500
      49005400550052004E004900010000000000}
    AfterEdit = Q162AfterEdit
    BeforePost = Q162BeforePost
    AfterPost = Q162AfterPost
    AfterCancel = Q162AfterCancel
    BeforeDelete = Q162BeforeDelete
    AfterDelete = Q162AfterDelete
    AfterScroll = Q162AfterScroll
    OnNewRecord = Q162NewRecord
    Left = 368
    Top = 8
    object Q162CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T162_INDENNITA.CODICE'
      OnValidate = BDEQ162CODICEValidate
      Size = 5
    end
    object Q162DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T162_INDENNITA.DESCRIZIONE'
      Size = 40
    end
    object Q162IMPORTO: TFloatField
      FieldName = 'IMPORTO'
      Origin = 'T162_INDENNITA.IMPORTO'
      currency = True
    end
    object Q162VOCEPAGHE: TStringField
      FieldName = 'VOCEPAGHE'
      Origin = 'T162_INDENNITA.VOCEPAGHE'
      Size = 6
    end
    object Q162TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'T162_INDENNITA.TIPO'
      OnValidate = BDEQ162TIPOValidate
      Size = 1
    end
    object Q162NUMTURNI: TFloatField
      FieldName = 'NUMTURNI'
      Origin = 'T162_INDENNITA.NUMTURNI'
    end
    object Q162TURNI: TStringField
      FieldName = 'TURNI'
      Origin = 'T162_INDENNITA.TURNI'
      Size = 4
    end
    object Q162ASSENZE: TStringField
      FieldName = 'ASSENZE'
      Origin = 'T162_INDENNITA.ASSENZE'
      Size = 1000
    end
    object Q162CODICE2: TStringField
      FieldName = 'CODICE2'
      Origin = 'T162_INDENNITA.CODICE2'
      Size = 5
    end
    object Q162TURNO1: TFloatField
      FieldName = 'TURNO1'
    end
    object Q162TURNO2: TFloatField
      FieldName = 'TURNO2'
    end
    object Q162TURNO3: TFloatField
      FieldName = 'TURNO3'
    end
    object Q162TURNO4: TFloatField
      FieldName = 'TURNO4'
    end
    object Q162PRIORITA: TIntegerField
      FieldName = 'PRIORITA'
    end
    object Q162INDENNITA_INCOMPATIBILI: TStringField
      FieldName = 'INDENNITA_INCOMPATIBILI'
      Size = 200
    end
    object Q162COEFFICIENTE: TFloatField
      FieldName = 'COEFFICIENTE'
    end
    object Q162ARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Size = 1
    end
    object Q162ASSENZE_ABILITATE: TStringField
      FieldName = 'ASSENZE_ABILITATE'
      Size = 1000
    end
    object Q162SUPPL_5GGLAV: TStringField
      FieldName = 'SUPPL_5GGLAV'
      Size = 1
    end
    object Q162CAUPRES_RIEPORE: TStringField
      FieldName = 'CAUPRES_RIEPORE'
      Size = 5
    end
    object Q162D_CAUPRES_RIEPORE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUPRES_RIEPORE'
      LookupDataSet = selT275Escluse
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUPRES_RIEPORE'
      Size = 40
      Lookup = True
    end
    object Q162NMESI_EQUITURNI: TFloatField
      FieldName = 'NMESI_EQUITURNI'
    end
    object Q162OFFSET_METADEBITO: TIntegerField
      FieldName = 'OFFSET_METADEBITO'
    end
    object Q162MATURA_SABATO: TStringField
      FieldName = 'MATURA_SABATO'
      Size = 1
    end
    object Q162PIANIF_NOOP: TStringField
      FieldName = 'PIANIF_NOOP'
      Size = 1
    end
    object Q162MIN_TURNI_PRIORITARI: TStringField
      FieldName = 'MIN_TURNI_PRIORITARI'
      Size = 2000
    end
    object Q162MIN_TURNI_SECONDARI: TStringField
      FieldName = 'MIN_TURNI_SECONDARI'
      Size = 2000
    end
    object Q162OFFSET_GGPREC: TStringField
      FieldName = 'OFFSET_GGPREC'
      Size = 5
    end
    object Q162ESCLUDI_FESTIVI: TStringField
      FieldName = 'ESCLUDI_FESTIVI'
      Size = 1
    end
    object Q162MATURAZ_PROP_DEBITOGG: TStringField
      FieldName = 'MATURAZ_PROP_DEBITOGG'
      Size = 1
    end
  end
  object Q171: TOracleDataSet
    SQL.Strings = (
      'SELECT T171.*,T171.ROWID FROM T171_LIMITI T171'
      'WHERE CODICE = :CODICE'
      'ORDER BY CODICE,GIORNI')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OnNewRecord = Q171NewRecord
    Left = 12
    Top = 58
    object Q171CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T171_LIMITI.CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object Q171GIORNI: TFloatField
      DisplayLabel = 'Giorni'
      FieldName = 'GIORNI'
      Origin = 'T171_LIMITI.GIORNI'
      Required = True
    end
    object Q171ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      FieldName = 'ESPRESSIONE'
      Origin = 'T171_LIMITI.ESPRESSIONE'
      Required = True
      Size = 40
    end
  end
  object Del171: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T171_LIMITI WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 12
    Top = 104
  end
  object Upd171: TOracleQuery
    SQL.Strings = (
      'UPDATE T171_LIMITI SET CODICE = :CODICENEW'
      'WHERE CODICE = :CODICEOLD')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044004900430045004E0045005700
      050000000000000000000000140000003A0043004F0044004900430045004F00
      4C004400050000000000000000000000}
    Left = 52
    Top = 104
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 200
    Top = 52
  end
  object Look162: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA WHERE CODICE <> :C' +
        'ODICE'
      'AND TIPO IN ('#39'A'#39','#39'B'#39','#39'C'#39','#39'D'#39','#39'E'#39','#39'I'#39','#39'P'#39')'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 248
    Top = 52
    object Look162CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object Look162DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selT164: TOracleDataSet
    SQL.Strings = (
      'select T164.*, T164.ROWID'
      '  from T164_ASSOCIAZIONIINDENNITA T164'
      ' where T164.CODICE = :CODICE'
      ' order by DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      450053005000520045005300530049004F004E00450001000000000010000000
      530043004100440045004E005A004100010000000000}
    OnNewRecord = selT164NewRecord
    Left = 102
    Top = 57
    object selT164CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT164DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT164ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      FieldName = 'ESPRESSIONE'
      Required = True
      Size = 2000
    end
    object selT164SCADENZA: TDateTimeField
      FieldName = 'SCADENZA'
      OnValidate = selT164SCADENZAValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT164TIPO_ASSOCIAZIONE: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO_ASSOCIAZIONE'
      Size = 1
    end
  end
  object dsrT164: TDataSource
    DataSet = selT164
    Left = 143
    Top = 57
  end
  object delT164: TOracleQuery
    SQL.Strings = (
      'delete '
      'from T164_ASSOCIAZIONIINDENNITA'
      'where CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 100
    Top = 104
  end
  object updT164: TOracleQuery
    SQL.Strings = (
      'update T164_ASSOCIAZIONIINDENNITA '
      'set CODICE = :CODICENEW'
      'where CODICE = :CODICEOLD')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044004900430045004E0045005700
      050000000000000000000000140000003A0043004F0044004900430045004F00
      4C004400050000000000000000000000}
    Left = 144
    Top = 104
  end
  object selI010: TOracleDataSet
    SQL.Strings = (
      
        'SELECT REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') NOME_CAMPO, NOME_LOGICO, TA' +
        'BLE_NAME'
      'FROM I010_CAMPIANAGRAFICI, COLS'
      'WHERE '
      '  REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') = COLUMN_NAME AND '
      '  TABLE_NAME IN ('#39'T430_STORICO'#39','#39'T030_ANAGRAFICO'#39') AND '
      '  COLUMN_NAME NOT IN ('#39'PROGRESSIVO'#39','#39'DATADECORRENZA'#39','#39'DATAFINE'#39')'
      'ORDER BY TABLE_NAME, NOME_LOGICO ')
    Optimize = False
    Left = 204
    Top = 108
  end
  object dsrI010: TDataSource
    DataSet = selI010
    Left = 252
    Top = 108
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 300
    Top = 112
  end
  object testSQL: TOracleQuery
    Optimize = False
    Left = 344
    Top = 112
  end
  object selT162Incomp: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA WHERE CODICE <> :C' +
        'ODICE'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 344
    Top = 52
    object StringField1: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 416
    Top = 8
  end
  object SelQ162: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,CODICE2 FROM T162_INDENNITA T162'
      'WHERE CODICE=:CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      000049004D0050004F00520054004F000100000000001200000056004F004300
      450050004100470048004500010000000000080000005400490050004F000100
      00000000100000004E0055004D005400550052004E0049000100000000000A00
      00005400550052004E0049000100000000000E00000041005300530045004E00
      5A0045000100000000000E00000043004F004400490043004500320001000000
      00000C0000005400550052004E004F0031000100000000000C00000054005500
      52004E004F0032000100000000000C0000005400550052004E004F0033000100
      000000000C0000005400550052004E004F003400010000000000100000005000
      520049004F0052004900540041000100000000002E00000049004E0044004500
      4E004E004900540041005F0049004E0043004F004D0050004100540049004200
      49004C0049000100000000001800000043004F00450046004600490043004900
      45004E00540045000100000000001C0000004100520052004F0054004F004E00
      440041004D0045004E0054004F00010000000000}
    Left = 416
    Top = 56
  end
  object selT275Escluse: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'WHERE ORENORMALI = '#39'A'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 480
    Top = 8
    object selT275EscluseCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT275EscluseDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT275Escluse: TDataSource
    DataSet = selT275Escluse
    Left = 556
    Top = 8
  end
end
