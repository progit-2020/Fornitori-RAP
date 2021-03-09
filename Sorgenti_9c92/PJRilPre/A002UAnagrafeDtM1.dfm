object A002FAnagrafeDtM1: TA002FAnagrafeDtM1
  OldCreateOrder = True
  OnCreate = A002FAnagrafeDtM1Create
  OnDestroy = A002FAnagrafeDtM1Destroy
  Height = 413
  Width = 521
  object D030: TDataSource
    AutoEdit = False
    DataSet = Q030
    OnStateChange = D030StateChange
    Left = 19
    Top = 222
  end
  object D430: TDataSource
    AutoEdit = False
    DataSet = Q430
    OnDataChange = D430DataChange
    Left = 81
    Top = 222
  end
  object D480: TDataSource
    AutoEdit = False
    DataSet = T480
    Left = 200
    Top = 223
  end
  object DQVista: TDataSource
    AutoEdit = False
    DataSet = QVista
    Left = 21
    Top = 56
  end
  object T480: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Citta,Cap,Provincia,CodCatastale from T480_Comuni '
      'ORDER BY CITTA')
    ReadBuffer = 10000
    Optimize = False
    Left = 196
    Top = 175
    object T480CODICE: TStringField
      FieldName = 'CODICE'
      Size = 6
    end
    object T480CITTA: TStringField
      DisplayWidth = 35
      FieldName = 'CITTA'
      Size = 40
    end
    object T480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object T480PROVINCIA: TStringField
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object T480CODCATASTALE: TStringField
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 172
    Top = 287
  end
  object Q030Count: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*) FROM T030_ANAGRAFICO')
    ReadBuffer = 1
    Optimize = False
    Left = 322
    Top = 7
  end
  object Q034: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T034_LayoutGriglia '
      '  WHERE Operatore = :Operatore'
      'ORDER BY NomeCampo')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004F00500045005200410054004F0052004500
      030000000000000000000000}
    Left = 208
    Top = 7
  end
  object InsQ034: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T034_LayoutGriglia '
      '  (Operatore, NomeCampo, Posizione, Visible, Lunghezza, Label)'
      'VALUES '
      
        '  (:Operatore, :NomeCampo, :Posizione, :Visible, :Lunghezza, :La' +
        'bel)')
    Optimize = False
    Variables.Data = {
      0400000006000000140000003A004F00500045005200410054004F0052004500
      030000000000000000000000140000003A004E004F004D004500430041004D00
      50004F00050000000000000000000000140000003A0050004F00530049005A00
      49004F004E004500030000000000000000000000100000003A00560049005300
      490042004C004500050000000000000000000000140000003A004C0055004E00
      4700480045005A005A0041000300000000000000000000000C0000003A004C00
      4100420045004C00050000000000000000000000}
    Left = 264
    Top = 8
  end
  object QVista: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.* FROM'
      ':C700SelAnagrafe'
      ':FiltroCessati'
      ':OrderBy')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000030000001C0000003A00460049004C00540052004F00430045005300
      5300410054004900010000000000000000000000200000003A00430037003000
      3000530045004C0041004E004100470052004100460045000100000000000000
      00000000100000003A004F005200440045005200420059000100000000000000
      00000000}
    AfterScroll = QVistaAfterScroll
    Left = 22
    Top = 8
  end
  object Q030: TOracleDataSet
    SQL.Strings = (
      
        'Select T030.*,T030.ROWID from T030_ANAGRAFICO T030 where PROGRES' +
        'SIVO = :Progressivo')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C000000120000004D00410054005200490043004F004C0041000100
      0000000016000000500052004F0047005200450053005300490056004F000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D0045000100000000000A00000053004500530053004F0001000000
      00000E00000044004100540041004E0041005300010000000000120000004300
      4F004D0055004E0045004E00410053000100000000000C000000430041005000
      4E00410053000100000000001400000043004F00440046004900530043004100
      4C0045000100000000001C00000049004E0049005A0049004F00530045005200
      560049005A0049004F000100000000001C00000052004100500050004F005200
      540049005F0055004E004900540049000100000000001C000000540049005000
      4F005F0050004500520053004F004E0041004C004500010000000000}
    CachedUpdates = True
    BeforeInsert = Q030BeforeInsert
    AfterInsert = Q030AfterInsert
    BeforeEdit = Q030BeforeEdit
    AfterEdit = Q030AfterInsert
    BeforePost = Q030BeforePost
    AfterPost = Q030AfterPost
    AfterCancel = Q030AfterCancel
    AfterDelete = Q030AfterDelete
    OnCalcFields = Q030CalcFields
    OnNewRecord = Q030NewRecord
    Left = 20
    Top = 174
    object Q030MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object Q030PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q030COGNOME: TStringField
      FieldName = 'COGNOME'
      Size = 30
    end
    object Q030NOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
    object Q030SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object Q030DATANAS: TDateTimeField
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q030COMUNENAS: TStringField
      FieldName = 'COMUNENAS'
      Size = 6
    end
    object Q030CAPNAS: TStringField
      FieldName = 'CAPNAS'
      EditMask = '00000;1;_'
      Size = 5
    end
    object Q030CODFISCALE: TStringField
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object Q030INIZIOSERVIZIO: TDateTimeField
      FieldName = 'INIZIOSERVIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q030RAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object Q030TIPO_PERSONALE: TStringField
      FieldName = 'TIPO_PERSONALE'
      Required = True
      Size = 1
    end
    object Q030DescComune: TStringField
      FieldKind = fkLookup
      FieldName = 'DescComune'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNENAS'
      LookupCache = True
      Size = 40
      Lookup = True
    end
    object Q030D_Cap: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Cap'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMUNENAS'
      LookupCache = True
      Size = 5
      Lookup = True
    end
    object Q030NomeCognome: TStringField
      FieldKind = fkCalculated
      FieldName = 'NomeCognome'
      Size = 60
      Calculated = True
    end
    object Q030D_CodCatastale: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodCatastale'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODCATASTALE'
      KeyFields = 'COMUNENAS'
      LookupCache = True
      Size = 4
      Lookup = True
    end
    object Q030D_ProvinciaNas: TStringField
      FieldKind = fkLookup
      FieldName = 'D_ProvinciaNas'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNENAS'
      LookupCache = True
      Size = 2
      Lookup = True
    end
    object Q030I060EMAIL: TStringField
      FieldKind = fkCalculated
      FieldName = 'I060EMAIL'
      Size = 200
      Calculated = True
    end
  end
  object Q430: TOracleDataSet
    SQL.Strings = (
      'select T430.*,T430.ROWID from T430_STORICO T430'
      ' where :DataLav between DATADECORRENZA and DATAFINE'
      '   and  PROGRESSIVO = :Progressivo'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041004C00410056000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000003C00000016000000500052004F004700520045005300530049005600
      4F000100000000001C00000044004100540041004400450043004F0052005200
      45004E005A004100010000000000100000004400410054004100460049004E00
      45000100000000000A000000420041004400470045000100000000000E000000
      45004400420041004400470045000100000000001200000049004E0044004900
      520049005A005A004F000100000000000C00000043004F004D0055004E004500
      0100000000000600000043004100500001000000000010000000540045004C00
      450046004F004E004F000100000000000C00000049004E0049005A0049004F00
      01000000000008000000460049004E0045000100000000000E00000054004900
      50004F004F0050004500010000000000120000005400450052004D0049004E00
      41004C0049000100000000001600000043004100550053005300540052004100
      4F00520044000100000000001000000053005400520041004F00520044004500
      0100000000001000000053005400520041004F00520044005500010000000000
      1200000053005400520041004F00520044004500550001000000000012000000
      43004F004E00540052004100540054004F000100000000000C0000004F005200
      4100520049004F00010000000000120000004800540045004F00520049004300
      4800450001000000000018000000500045005200530045004C00410053005400
      490043004F00010000000000120000005400470045005300540049004F004E00
      45000100000000000E00000050004C00550053004F0052004100010000000000
      14000000430041004C0045004E0044004100520049004F000100000000001200
      00004900500052004500530045004E005A0041000100000000000E0000005000
      4F0052004100520049004F000100000000001000000050004100530053004500
      4E005A0045000100000000001400000041004200430041005500530041004C00
      450031000100000000001600000041004200500052004500530045004E005A00
      410031000100000000000E000000530051005500410044005200410001000000
      0000180000005400490050004F0052004100500050004F00520054004F000100
      00000000100000005000410052005400540049004D0045000100000000001400
      000053005400520041004F005200440045005500320001000000000012000000
      50004500520053004F004E0041004C0045000100000000001200000053005400
      52005500540054005500520041000100000000000E00000041005A0049004500
      4E004400410001000000000010000000530045005200560049005A0049004F00
      0100000000001E00000053004F00540054004F005F0050004500520053004F00
      4E0041004C0045000100000000000E00000053004500540054004F0052004500
      0100000000000E0000005200450050004100520054004F000100000000001200
      00005100550041004C0049004600490043004100010000000000180000004300
      45004E00540052004F005F0043004F00530054004F000100000000001A000000
      5400490054004F004C004F005F00530054005500440049004F00010000000000
      1C0000005400490050004F005F004F00500045005200410054004F0052004500
      010000000000080000004E004F00540045000100000000001200000054004500
      4C00450046004F004E004F0032000100000000000C00000049004E0044004400
      4F004D000100000000000C00000043004100500044004F004D00010000000000
      0C00000043004F004D0044004F004D000100000000000E000000500052004F00
      560044004F004D00010000000000180000005200450050004500520049004200
      49004C004900540041000100000000001A00000053005400520041004F005200
      440049004E004100520049004F000100000000001200000049004E0043004500
      4E0054004900560049000100000000000E0000004C004900560045004C004C00
      4F000100000000001000000043004F004D004D00450053005300410001000000
      00001200000044004900520045005A0049004F004E0045000100000000000600
      000055004F0043000100000000000600000055004F0053000100000000001400
      000055004E004900540041005F00500052004F0044000100000000000E000000
      44004F00430045004E0054004500010000000000}
    LockingMode = lmLockImmediate
    AfterFetchRecord = Q430AfterFetchRecord
    CachedUpdates = True
    AfterOpen = Q430AfterOpen
    BeforeInsert = Q430BeforeInsert
    AfterInsert = Q430AfterInsert
    BeforeEdit = Q430BeforeEdit
    AfterScroll = Q430AfterScroll
    Left = 82
    Top = 174
    object Q430PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q430DATADECORRENZA: TDateTimeField
      FieldName = 'DATADECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430DATAFINE: TDateTimeField
      FieldName = 'DATAFINE'
      OnGetText = T430DataFineGetText
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430BADGE: TFloatField
      FieldName = 'BADGE'
    end
    object Q430EDBADGE: TStringField
      FieldName = 'EDBADGE'
      Origin = 'aaa'
      Size = 15
    end
    object Q430INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 80
    end
    object Q430COMUNE: TStringField
      DisplayWidth = 6
      FieldName = 'COMUNE'
      Size = 6
    end
    object Q430CAP: TStringField
      FieldName = 'CAP'
      EditMask = '00000;1;_'
      Size = 5
    end
    object Q430INIZIO: TDateTimeField
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430TELEFONO: TStringField
      FieldName = 'TELEFONO'
      Size = 15
    end
    object Q430FINE: TDateTimeField
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430SQUADRA: TStringField
      DisplayWidth = 6
      FieldName = 'SQUADRA'
      Size = 5
    end
    object Q430TIPOOPE: TStringField
      FieldName = 'TIPOOPE'
      Size = 5
    end
    object Q430TERMINALI: TStringField
      DisplayWidth = 10
      FieldName = 'TERMINALI'
      Size = 300
    end
    object Q430CAUSSTRAORD: TStringField
      FieldName = 'CAUSSTRAORD'
      Size = 1
    end
    object Q430STRAORDE: TStringField
      FieldName = 'STRAORDE'
      Size = 1
    end
    object Q430STRAORDU: TStringField
      FieldName = 'STRAORDU'
      Size = 1
    end
    object Q430STRAORDEU: TStringField
      FieldName = 'STRAORDEU'
      Size = 1
    end
    object Q430CONTRATTO: TStringField
      DisplayWidth = 6
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object Q430ORARIO: TStringField
      DisplayWidth = 6
      FieldName = 'ORARIO'
      OnValidate = Q430StringField27Validate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object Q430HTEORICHE: TStringField
      FieldName = 'HTEORICHE'
      Size = 1
    end
    object Q430PERSELASTICO: TStringField
      FieldName = 'PERSELASTICO'
      Size = 5
    end
    object Q430TGESTIONE: TStringField
      FieldName = 'TGESTIONE'
      Size = 1
    end
    object Q430PLUSORA: TStringField
      DisplayWidth = 6
      FieldName = 'PLUSORA'
      Size = 5
    end
    object Q430CALENDARIO: TStringField
      DisplayWidth = 6
      FieldName = 'CALENDARIO'
      Size = 5
    end
    object Q430IPRESENZA: TStringField
      DisplayWidth = 6
      FieldName = 'IPRESENZA'
      Size = 5
    end
    object Q430PORARIO: TStringField
      DisplayWidth = 8
      FieldName = 'PORARIO'
      Size = 5
    end
    object Q430PASSENZE: TStringField
      DisplayWidth = 6
      FieldName = 'PASSENZE'
      Size = 5
    end
    object Q430ABCAUSALE1: TStringField
      DisplayWidth = 20
      FieldName = 'ABCAUSALE1'
      Size = 4000
    end
    object Q430ABPRESENZA1: TStringField
      DisplayWidth = 20
      FieldName = 'ABPRESENZA1'
      Size = 4000
    end
    object Q430TIPORAPPORTO: TStringField
      FieldName = 'TIPORAPPORTO'
      Origin = 'T430_STORICO.TIPORAPPORTO'
      Size = 5
    end
    object Q430PARTTIME: TStringField
      FieldName = 'PARTTIME'
      Origin = 'T430_STORICO.PARTTIME'
      Size = 5
    end
    object Q430STRAORDEU2: TStringField
      FieldName = 'STRAORDEU2'
      Origin = 'T430_STORICO.STRAORDEU2'
      Size = 1
    end
    object Q430DOCENTE: TStringField
      FieldName = 'DOCENTE'
      Required = True
      Size = 1
    end
    object Q430QUALIFICAMINIST: TStringField
      DisplayWidth = 10
      FieldName = 'QUALIFICAMINIST'
    end
    object Q430TIPO_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'TIPO_LOCALITA_DIST_LAVORO'
      Size = 1
    end
    object Q430COD_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'COD_LOCALITA_DIST_LAVORO'
      Size = 6
    end
    object Q430INIZIO_IND_MAT: TDateTimeField
      FieldName = 'INIZIO_IND_MAT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430FINE_IND_MAT: TDateTimeField
      FieldName = 'FINE_IND_MAT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q430MEDICINA_LEGALE: TStringField
      FieldName = 'MEDICINA_LEGALE'
      Size = 10
    end
    object Q430INDIRIZZO_DOM_BASE: TStringField
      FieldName = 'INDIRIZZO_DOM_BASE'
      Size = 80
    end
    object Q430COMUNE_DOM_BASE: TStringField
      FieldName = 'COMUNE_DOM_BASE'
      Size = 6
    end
    object Q430CAP_DOM_BASE: TStringField
      FieldName = 'CAP_DOM_BASE'
      EditMask = '00000;1;_'
      Size = 5
    end
    object Q430D_Comune: TStringField
      Tag = 1
      FieldKind = fkLookup
      FieldName = 'D_Comune'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      LookupCache = True
      Size = 40
      Lookup = True
    end
    object Q430D_Cap: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Cap'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMUNE'
      LookupCache = True
      Size = 5
      Lookup = True
    end
    object Q430D_Provincia: TStringField
      Tag = 1
      FieldKind = fkLookup
      FieldName = 'D_Provincia'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      LookupCache = True
      Size = 2
      Lookup = True
    end
    object Q430D_Squadra: TStringField
      Tag = 2
      FieldKind = fkLookup
      FieldName = 'D_Squadra'
      LookupDataSet = A002FAnagrafeMW.selT600
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'SQUADRA'
      Size = 40
      Lookup = True
    end
    object Q430D_Contratto: TStringField
      Tag = 3
      FieldKind = fkLookup
      FieldName = 'D_Contratto'
      LookupDataSet = A002FAnagrafeMW.selT200
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CONTRATTO'
      Size = 40
      Lookup = True
    end
    object Q430D_TIPOCART: TStringField
      Tag = 11
      FieldKind = fkLookup
      FieldName = 'D_TIPOCART'
      LookupDataSet = A002FAnagrafeMW.selT025
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PERSELASTICO'
      Size = 40
      Lookup = True
    end
    object Q430D_PlusOra: TStringField
      Tag = 4
      FieldKind = fkLookup
      FieldName = 'D_PlusOra'
      LookupDataSet = A002FAnagrafeMW.selT060
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PLUSORA'
      Size = 40
      Lookup = True
    end
    object Q430D_Calendario: TStringField
      Tag = 5
      FieldKind = fkLookup
      FieldName = 'D_Calendario'
      LookupDataSet = A002FAnagrafeMW.selT010
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CALENDARIO'
      Size = 40
      Lookup = True
    end
    object Q430D_IPresenza: TStringField
      Tag = 6
      FieldKind = fkLookup
      FieldName = 'D_IPresenza'
      LookupDataSet = A002FAnagrafeMW.selT163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'IPRESENZA'
      Size = 40
      Lookup = True
    end
    object Q430D_POrario: TStringField
      Tag = 7
      FieldKind = fkLookup
      FieldName = 'D_POrario'
      LookupDataSet = A002FAnagrafeMW.selT220
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PORARIO'
      Size = 40
      Lookup = True
    end
    object Q430D_PAssenze: TStringField
      Tag = 8
      FieldKind = fkLookup
      FieldName = 'D_PAssenze'
      LookupDataSet = A002FAnagrafeMW.selT261
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PASSENZE'
      Size = 40
      Lookup = True
    end
    object Q430D_TipoRapporto: TStringField
      Tag = 12
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_TipoRapporto'
      LookupDataSet = A002FAnagrafeMW.selT450
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPORAPPORTO'
      Size = 60
      Lookup = True
    end
    object Q430D_PartTime: TStringField
      Tag = 13
      FieldKind = fkLookup
      FieldName = 'D_PartTime'
      LookupDataSet = A002FAnagrafeMW.selT460
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTTIME'
      Size = 40
      Lookup = True
    end
    object Q430D_QUALIFICAMINIST: TStringField
      Tag = 14
      FieldKind = fkLookup
      FieldName = 'D_QUALIFICAMINIST'
      LookupDataSet = A002FAnagrafeMW.selT470
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'QUALIFICAMINIST'
      Size = 100
      Lookup = True
    end
    object Q430D_COD_LOCALITA_DIST_LAVORO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_COD_LOCALITA_DIST_LAVORO'
      LookupDataSet = selLocalita
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_LOCALITA_DIST_LAVORO'
      LookupCache = True
      Size = 40
      Lookup = True
    end
    object Q430D_MEDICINA_LEGALE: TStringField
      Tag = 15
      FieldKind = fkLookup
      FieldName = 'D_MEDICINA_LEGALE'
      LookupDataSet = A002FAnagrafeMW.selT485
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MEDICINA_LEGALE'
      Size = 60
      Lookup = True
    end
    object Q430D_COMUNE_DOM_BASE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_COMUNE_DOM_BASE'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE_DOM_BASE'
      Size = 40
      Lookup = True
    end
    object Q430D_CAP_DOM_BASE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAP_DOM_BASE'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMUNE_DOM_BASE'
      Size = 5
      Lookup = True
    end
    object Q430D_PROVINCIA_DOM_BASE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_PROVINCIA_DOM_BASE'
      LookupDataSet = T480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE_DOM_BASE'
      Size = 2
      Lookup = True
    end
  end
  object Q430B: TOracleDataSet
    SQL.Strings = (
      'SELECT T430.*,T430.ROWID FROM T430_STORICO T430'
      '  WHERE PROGRESSIVO = :Prog'
      '  ORDER BY DATADECORRENZA   ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00470003000000000000000000
      0000}
    RefreshOptions = [roAfterUpdate]
    CachedUpdates = True
    OnFilterRecord = Q430BFilterRecord
    Left = 140
    Top = 174
    object Q430BPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object Q430BDATADECORRENZA2: TDateTimeField
      FieldName = 'DATADECORRENZA'
    end
    object Q430BDATAFINE2: TDateTimeField
      FieldName = 'DATAFINE'
    end
    object Q430BBADGE: TFloatField
      FieldName = 'BADGE'
    end
    object Q430BEDBADGE2: TStringField
      FieldName = 'EDBADGE'
      Size = 15
    end
    object Q430BINDIRIZZO2: TStringField
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object Q430BCOMUNE2: TStringField
      FieldName = 'COMUNE'
      Size = 6
    end
    object Q430BCAP2: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object Q430BTELEFONO2: TStringField
      FieldName = 'TELEFONO'
      Size = 15
    end
    object Q430BINIZIO2: TDateTimeField
      FieldName = 'INIZIO'
    end
    object Q430BFINE2: TDateTimeField
      FieldName = 'FINE'
    end
    object Q430BSQUADRA2: TStringField
      FieldName = 'SQUADRA'
      Size = 5
    end
    object Q430BTIPOOPE2: TStringField
      FieldName = 'TIPOOPE'
      Size = 5
    end
    object Q430BTERMINALI2: TStringField
      DisplayWidth = 10
      FieldName = 'TERMINALI'
      Size = 300
    end
    object Q430BCAUSSTRAORD2: TStringField
      FieldName = 'CAUSSTRAORD'
      Size = 1
    end
    object Q430BSTRAORDE2: TStringField
      FieldName = 'STRAORDE'
      Size = 1
    end
    object Q430BSTRAORDU2: TStringField
      FieldName = 'STRAORDU'
      Size = 1
    end
    object Q430BSTRAORDEU3: TStringField
      FieldName = 'STRAORDEU'
      Size = 1
    end
    object Q430BCONTRATTO2: TStringField
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object Q430BORARIO2: TStringField
      FieldName = 'ORARIO'
      Size = 5
    end
    object Q430BHTEORICHE2: TStringField
      FieldName = 'HTEORICHE'
      Size = 1
    end
    object Q430BPERSELASTICO2: TStringField
      FieldName = 'PERSELASTICO'
      Size = 5
    end
    object Q430BTGESTIONE2: TStringField
      FieldName = 'TGESTIONE'
      Size = 1
    end
    object Q430BPLUSORA2: TStringField
      FieldName = 'PLUSORA'
      Size = 5
    end
    object Q430BCALENDARIO2: TStringField
      FieldName = 'CALENDARIO'
      Size = 5
    end
    object Q430BIPRESENZA2: TStringField
      FieldName = 'IPRESENZA'
      Size = 5
    end
    object Q430BPORARIO2: TStringField
      FieldName = 'PORARIO'
      Size = 5
    end
    object Q430BPASSENZE2: TStringField
      FieldName = 'PASSENZE'
      Size = 5
    end
    object Q430BABCAUSALE12: TStringField
      DisplayWidth = 20
      FieldName = 'ABCAUSALE1'
      Size = 200
    end
    object Q430BABPRESENZA12: TStringField
      DisplayWidth = 20
      FieldName = 'ABPRESENZA1'
      Size = 200
    end
    object Q430BTIPORAPPORTO2: TStringField
      FieldName = 'TIPORAPPORTO'
      Origin = 'T430_STORICO.TIPORAPPORTO'
      Size = 5
    end
    object Q430BPARTTIME2: TStringField
      FieldName = 'PARTTIME'
      Origin = 'T430_STORICO.PARTTIME'
      Size = 5
    end
    object Q430BSTRAORDEU22: TStringField
      FieldName = 'STRAORDEU2'
      Origin = 'T430_STORICO.STRAORDEU2'
      Size = 1
    end
    object Q430BDOCENTE: TStringField
      FieldName = 'DOCENTE'
      Size = 1
    end
    object Q430BQUALIFICAMINIST: TStringField
      FieldName = 'QUALIFICAMINIST'
    end
    object Q430BTIPO_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'TIPO_LOCALITA_DIST_LAVORO'
      Size = 1
    end
    object Q430BCOD_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'COD_LOCALITA_DIST_LAVORO'
      Size = 6
    end
    object Q430BINIZIO_IND_MAT: TDateTimeField
      FieldName = 'INIZIO_IND_MAT'
    end
    object Q430BFINE_IND_MAT: TDateTimeField
      FieldName = 'FINE_IND_MAT'
    end
    object Q430BMEDICINA_LEGALE: TStringField
      FieldName = 'MEDICINA_LEGALE'
      Size = 10
    end
    object Q430BINDIRIZZO_DOM_BASE: TStringField
      FieldName = 'INDIRIZZO_DOM_BASE'
      Size = 80
    end
    object Q430BCOMUNE_DOM_BASE: TStringField
      FieldName = 'COMUNE_DOM_BASE'
      Size = 6
    end
    object Q430BCAP_DOM_BASE: TStringField
      FieldName = 'CAP_DOM_BASE'
      Size = 5
    end
  end
  object InsQ033: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T033_LAYOUT'
      '  (Nome,Top,Lft,Caption,Accesso,NomePagina,CampoDB)'
      'VALUES'
      '  (:Nome,:Top,:Lft,:Caption,:Accesso,:NomePagina,:CampoDB)')
    Optimize = False
    Variables.Data = {
      04000000070000000A0000003A004E004F004D00450005000000000000000000
      0000080000003A0054004F005000030000000000000000000000080000003A00
      4C0046005400030000000000000000000000100000003A004300410050005400
      49004F004E00050000000000000000000000100000003A004100430043004500
      530053004F00050000000000000000000000160000003A004E004F004D004500
      50004100470049004E004100050000000000000000000000100000003A004300
      41004D0050004F0044004200050000000000000000000000}
    Left = 254
    Top = 108
  end
  object Q033B: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWNUM,NOMEPAGINA,CAMPODB,TOP,LFT,CAPTION,ACCESSO '
      
        '  FROM (SELECT NOMEPAGINA,TRUNC(TOP/20), LFT,CAMPODB,TOP,CAPTION' +
        ',ACCESSO '
      '          FROM T033_LAYOUT'
      '         WHERE NOME = :Nome '
      '        :ORDERBY'
      
        '        NOMEPAGINA,TRUNC(TOP/20), LFT,CAMPODB,TOP,CAPTION,ACCESS' +
        'O)'
      '')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F004D00450005000000000000000000
      0000100000003A004F0052004400450052004200590001000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000052004F0057004E0055004D000100000000001400
      00004E004F004D00450050004100470049004E0041000100000000000E000000
      430041004D0050004F00440042000100000000000600000054004F0050000100
      00000000060000004C00460054000100000000000E0000004300410050005400
      49004F004E000100000000000E0000004100430043004500530053004F000100
      00000000}
    Left = 172
    Top = 107
    object Q033BTOP: TFloatField
      FieldName = 'TOP'
    end
    object Q033BLFT: TFloatField
      FieldName = 'LFT'
    end
    object Q033BCAPTION: TStringField
      FieldName = 'CAPTION'
      Size = 50
    end
    object Q033BACCESSO: TStringField
      FieldName = 'ACCESSO'
      Size = 1
    end
    object Q033BNOMEPAGINA: TStringField
      FieldName = 'NOMEPAGINA'
    end
    object Q033BCAMPODB: TStringField
      FieldName = 'CAMPODB'
      Size = 40
    end
    object Q033BROWNUM: TFloatField
      FieldName = 'ROWNUM'
    end
  end
  object Q033: TOracleDataSet
    SQL.Strings = (
      'Select distinct Nome from T033_Layout')
    Optimize = False
    Left = 203
    Top = 107
  end
  object sel070: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from (select I070.UTENTE'
      '          from MONDOEDP.I070_UTENTI I070'
      '         where I070.AZIENDA = :AZIELAV'
      '           and I070.UTENTE <> '#39'MONDOEDP'#39
      '         union'
      '        select T033.NOME'
      '          from T033_LAYOUT T033'
      '         where T033.NOME <> '#39'DEFAULT'#39')'
      ' order by 1')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004C004100560005000000
      0000000000000000}
    Left = 19
    Top = 107
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOMEPAGINA FROM T033_LAYOUT WHERE '
      'NOMEPAGINA <> '#39'Dati Anagrafici'#39' AND'
      'NOMEPAGINA <> '#39'Parametri orario'#39' AND'
      'NOMEPAGINA <> '#39'Presenze/Assenze'#39
      'ORDER BY NOMEPAGINA')
    ReadBuffer = 10
    Optimize = False
    Left = 74
    Top = 107
  end
  object selaT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT')
    Optimize = False
    Left = 118
    Top = 107
  end
  object selT432: TOracleDataSet
    SQL.Strings = (
      'select T.*,ROWID '
      'from   T432_DATALAVORO T '
      'where  UTENTE = :UTENTE'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 148
    Top = 7
  end
  object updDec: TOracleQuery
    SQL.Strings = (
      'select count(*) from t430_storico'
      ' where progressivo = :PROG'
      
        '   and datadecorrenza = (SELECT MIN(DATADECORRENZA) FROM T430_ST' +
        'ORICO WHERE PROGRESSIVO = :PROG)'
      
        '   and :DATA <= (SELECT MIN(INIZIO) FROM T430_STORICO WHERE PROG' +
        'RESSIVO = :PROG)'
      
        '   and :DATA <= (SELECT MIN(DATAFINE) FROM T430_STORICO WHERE PR' +
        'OGRESSIVO = :PROG)'
      ''
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      00000A0000003A00500052004F004700030000000000000000000000}
    Left = 216
    Top = 287
  end
  object selLocalita: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, CITTA DESCRIZIONE FROM T480_COMUNI ORDER BY CITTA')
    ReadBuffer = 10000
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 264
    Top = 176
  end
  object DselLocalita: TDataSource
    DataSet = selLocalita
    Left = 264
    Top = 224
  end
  object selP430: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) ANAGRAFICHE_STIPENDIALI FROM P430_ANAGRAFICO')
    Optimize = False
    Left = 24
    Top = 337
  end
  object selI050: TOracleDataSet
    SQL.Strings = (
      'select NOME from I050_SCRIPTSQL where upper(NOME) = upper(:NOME)')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 88
    Top = 8
  end
end
