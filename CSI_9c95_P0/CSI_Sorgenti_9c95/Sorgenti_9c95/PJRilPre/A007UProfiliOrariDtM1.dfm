inherited A007FProfiliOrariDtM1: TA007FProfiliOrariDtM1
  OldCreateOrder = True
  Height = 111
  Width = 584
  object D020: TDataSource
    AutoEdit = False
    DataSet = Q020
    Left = 158
    Top = 4
  end
  object D221: TDataSource
    DataSet = Q221
    OnStateChange = D221StateChange
    Left = 86
    Top = 4
  end
  object Q220: TOracleDataSet
    SQL.Strings = (
      'SELECT T220.*,T220.ROWID FROM T220_PROFILIORARI T220'
      '  ORDER BY CODICE,DECORRENZA')
    ReadBuffer = 500
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000080000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001C00
      000041004E00540049004300490050004F005500530043004900540041000100
      0000000010000000500052004900540049004D00530043000100000000001800
      0000530043004F005300540045004E0054005200410054004100010000000000
      22000000540049004D0042004E004F004E004100500050004F00470047004900
      4100540045000100000000001E0000005200490054004100520044004F005F00
      45004E0054005200410054004100010000000000140000004400450043004F00
      5200520045004E005A004100010000000000}
    Filtered = True
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = Q220AfterScroll
    OnFilterRecord = FiltroDizionario
    Left = 16
    Top = 4
    object Q220CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object Q220DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object Q220DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object Q220DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object Q220ANTICIPOUSCITA: TDateTimeField
      FieldName = 'ANTICIPOUSCITA'
      OnGetText = Q220ANTICIPOUSCITAGetText
      OnSetText = T220AnticipoUscitaSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q220PRITIMSC: TStringField
      FieldName = 'PRITIMSC'
      Size = 1
    end
    object Q220SCOSTENTRATA: TStringField
      FieldName = 'SCOSTENTRATA'
      Origin = 'T220_PROFILIORARI.SCOSTENTRATA'
      Size = 1
    end
    object Q220TIMBNONAPPOGGIATE: TStringField
      FieldName = 'TIMBNONAPPOGGIATE'
      Size = 1
    end
    object Q220RITARDO_ENTRATA: TIntegerField
      FieldName = 'RITARDO_ENTRATA'
      MaxValue = 999
      MinValue = -1
    end
    object Q220IGNORA_TIMBNONINSEQ: TStringField
      FieldName = 'IGNORA_TIMBNONINSEQ'
      Size = 1
    end
    object Q220PRIORITA_DOM_FEST: TStringField
      FieldName = 'PRIORITA_DOM_FEST'
      Size = 1
    end
    object Q220PRIORITA_DOM_NONLAV: TStringField
      FieldName = 'PRIORITA_DOM_NONLAV'
      Size = 1
    end
  end
  object Q221: TOracleDataSet
    SQL.Strings = (
      'SELECT T221.*,T221.ROWID FROM T221_PROFILISETTIMANA T221'
      'WHERE CODICE = :Codice AND DECORRENZA = :Decorrenza  '
      'ORDER BY CODICE,PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000C00000043004F0044004900430045000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000000C00
      00004C0055004E004500440049000100000000000E0000004D00410052005400
      450044004900010000000000120000004D004500520043004F004C0045004400
      49000100000000000E000000470049004F005600450044004900010000000000
      0E000000560045004E0045005200440049000100000000000C00000053004100
      4200410054004F000100000000001000000044004F004D0045004E0049004300
      41000100000000000C0000004E004F004E004C00410056000100000000000E00
      00004600450053005400490056004F0001000000000014000000440045004300
      4F005200520045004E005A004100010000000000}
    ReadOnly = True
    CachedUpdates = True
    AfterOpen = Q221AfterOpen
    AfterPost = Q221AfterPost
    AfterCancel = Q221AfterCancel
    AfterDelete = Q221AfterDelete
    OnNewRecord = Q221NewRecord
    Left = 56
    Top = 4
    object Q221Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Visible = False
      Size = 5
    end
    object Q221D_Codice: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = Q220
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'Codice'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221Progressivo: TFloatField
      DisplayLabel = 'Num.'
      DisplayWidth = 5
      FieldName = 'Progressivo'
      Required = True
    end
    object Q221Lunedi: TStringField
      DisplayLabel = 'Luned'#236
      DisplayWidth = 8
      FieldName = 'Lunedi'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Martedi: TStringField
      DisplayLabel = 'Marted'#236
      DisplayWidth = 8
      FieldName = 'Martedi'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Mercoledi: TStringField
      DisplayLabel = 'Mercoled'#236
      DisplayWidth = 8
      FieldName = 'Mercoledi'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Giovedi: TStringField
      DisplayLabel = 'Gioved'#236
      DisplayWidth = 8
      FieldName = 'Giovedi'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Venerdi: TStringField
      DisplayLabel = 'Venerd'#236
      DisplayWidth = 8
      FieldName = 'Venerdi'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Sabato: TStringField
      DisplayWidth = 8
      FieldName = 'Sabato'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221Domenica: TStringField
      DisplayWidth = 8
      FieldName = 'Domenica'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221NonLav: TStringField
      DisplayLabel = 'Non lavorativo'
      DisplayWidth = 8
      FieldName = 'NonLav'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221FESTIVO: TStringField
      DisplayLabel = 'Festivo'
      DisplayWidth = 8
      FieldName = 'FESTIVO'
      OnValidate = OrarioValidate
      Size = 5
    end
    object Q221DLunedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DLunedi'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Lunedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DMartedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DMartedi'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Martedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DMercoledi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DMercoledi'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Mercoledi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DGiovedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DGiovedi'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Giovedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DVenerdi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DVenerdi'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Venerdi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DSabato: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DSabato'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Sabato'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DDomenica: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DDomenica'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Domenica'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DNonLav: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DNonLav'
      LookupDataSet = Q020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'NonLav'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DFestivo: TStringField
      FieldKind = fkLookup
      FieldName = 'DFestivo'
      LookupDataSet = Q020
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FESTIVO'
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q221DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
  end
  object Q020: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T020.CODICE, T020.DESCRIZIONE, T020.DECORRENZA'
      '  FROM T020_ORARI T020'
      ' WHERE T020.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                            FROM T020_ORARI'
      '                           WHERE CODICE=T020.CODICE)'
      ' ORDER BY T020.CODICE')
    ReadBuffer = 500
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 128
    Top = 4
    object Q020CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Origin = 'T020_ORARI.CODICE'
      Size = 5
    end
    object Q020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T020_ORARI.DESCRIZIONE'
      Size = 40
    end
  end
  object Q221ModificaProfilo: TOracleQuery
    SQL.Strings = (
      
        'UPDATE T221_PROFILISETTIMANA SET CODICE = :CODICE, DECORRENZA = ' +
        ':DECORRENZA'
      'WHERE CODICE = :CODICE_OLD AND'
      '      DECORRENZA = :DEC_OLD')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000100000003A004400450043005F00
      4F004C0044000C0000000000000000000000}
    Left = 228
    Top = 4
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 312
    Top = 4
  end
  object insT221: TOracleQuery
    SQL.Strings = (
      
        'insert into t221_profilisettimana(CODICE,DECORRENZA,PROGRESSIVO,' +
        'LUNEDI,MARTEDI,MERCOLEDI,GIOVEDI,VENERDI,SABATO,DOMENICA,NONLAV,' +
        'FESTIVO)'
      
        'values(:CODICE,:DECORRENZA,:PROGRESSIVO,:LUNEDI,:MARTEDI,:MERCOL' +
        'EDI,:GIOVEDI,:VENERDI,:SABATO,:DOMENICA,:NONLAV,:FESTIVO)')
    Optimize = False
    Variables.Data = {
      040000000C0000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000E0000003A004C0055004E00
      450044004900050000000000000000000000100000003A004D00410052005400
      450044004900050000000000000000000000140000003A004D00450052004300
      4F004C00450044004900050000000000000000000000100000003A0047004900
      4F005600450044004900050000000000000000000000100000003A0056004500
      4E0045005200440049000500000000000000000000000E0000003A0053004100
      4200410054004F00050000000000000000000000120000003A0044004F004D00
      45004E004900430041000500000000000000000000000E0000003A004E004F00
      4E004C0041005600050000000000000000000000100000003A00460045005300
      5400490056004F00050000000000000000000000}
    Left = 312
    Top = 56
  end
  object selT220CopiaR: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T220_PROFILIORARI t where CODICE = :CODICE' +
        ' order by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 376
    Top = 4
  end
  object selT220CopiaW: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T220_PROFILIORARI t where CODICE = :CODICE' +
        ' order by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 456
    Top = 4
  end
  object selT221Copia: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T221_PROFILISETTIMANA t where CODICE = :CO' +
        'DICE order by codice,decorrenza')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 528
    Top = 4
  end
end
