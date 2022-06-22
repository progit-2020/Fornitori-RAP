inherited A029FSchedaRiepilMW: TA029FSchedaRiepilMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 225
  Width = 786
  object selT071: TOracleDataSet
    SQL.Strings = (
      'SELECT T071.*,T071.ROWID FROM T071_SCHEDAFASCE T071 '
      'WHERE PROGRESSIVO = :Progressivo AND'
      '  DATA = :Data'
      '  ORDER BY MAGGIORAZIONE,CODFASCIA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    ReadOnly = True
    OnApplyRecord = selT071ApplyRecord
    BeforeInsert = selT071BeforeInsert
    BeforeDelete = selT071BeforeDelete
    OnCalcFields = selT071CalcFields
    Left = 11
    Top = 8
    object selT071D_Fascia: TStringField
      DisplayLabel = 'Fascia (%)'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'D_Fascia'
      Size = 12
      Calculated = True
    end
    object selT071ORELAVORATE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore lav.'
      FieldName = 'ORELAVORATE'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT071ORE1ASSEST: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore assestamento'
      DisplayWidth = 5
      FieldName = 'ORE1ASSEST'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!#000:00;1;_'
      Size = 7
    end
    object selT071ORE2ASSEST: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore assestamento'
      DisplayWidth = 5
      FieldName = 'ORE2ASSEST'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!#000:00;1;_'
      Size = 7
    end
    object selT071Totale: TStringField
      Alignment = taRightJustify
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'Totale'
      Size = 6
      Calculated = True
    end
    object selT071PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT071DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT071MAGGIORAZIONE: TFloatField
      DisplayLabel = '% Magg.'
      DisplayWidth = 2
      FieldName = 'MAGGIORAZIONE'
    end
    object selT071CODFASCIA: TStringField
      DisplayLabel = 'Fascia'
      FieldName = 'CODFASCIA'
      Size = 5
    end
    object selT071OREINDTURNO: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore'
      DisplayWidth = 6
      FieldName = 'OREINDTURNO'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT071OREECCEDGIORN: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ecc. giorn.'
      FieldName = 'OREECCEDGIORN'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT071StrMese: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Fatto nel mese'
      FieldKind = fkCalculated
      FieldName = 'StrMese'
      ReadOnly = True
      Size = 6
      Calculated = True
    end
    object selT071ORESTRAORDLIQ: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liq. del mese'
      FieldName = 'ORESTRAORDLIQ'
      ReadOnly = True
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT071LIQUIDNELMESE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liq. nel mese'
      FieldName = 'LIQUIDNELMESE'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT071StrAnnoAut: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Fatto inizio anno'
      FieldKind = fkCalculated
      FieldName = 'StrAnnoAut'
      ReadOnly = True
      Size = 6
      Calculated = True
    end
    object selT071StrAnnoLiq: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liq. inizio anno'
      FieldKind = fkCalculated
      FieldName = 'StrAnnoLiq'
      ReadOnly = True
      Size = 6
      Calculated = True
    end
    object selT071StrDaLiq: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Da liquidare'
      FieldKind = fkCalculated
      FieldName = 'StrDaLiq'
      ReadOnly = True
      Size = 6
      Calculated = True
    end
  end
  object dsrT071: TDataSource
    DataSet = selT071
    Left = 53
    Top = 8
  end
  object selT074: TOracleDataSet
    Optimize = False
    ReadOnly = True
    OnApplyRecord = selT074ApplyRecord
    AfterPost = selT074AfterPost
    BeforeDelete = selT074BeforeDelete
    AfterScroll = selT074AfterScroll
    OnCalcFields = selT074CalcFields
    Left = 314
    Top = 8
  end
  object dsrT074: TDataSource
    DataSet = selT074
    OnStateChange = dsrT074StateChange
    Left = 356
    Top = 8
  end
  object selT073Comp: TOracleDataSet
    SQL.Strings = (
      'SELECT CAUSALE,COMPENSABILE,GETTONE_RESIDUO,ROWID'
      'FROM T073_SCHEDACAUSPRES WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000030000000E000000430041005500530041004C004500010000000000
      1800000043004F004D00500045004E0053004100420049004C00450001000000
      00001E00000047004500540054004F004E0045005F0052004500530049004400
      55004F00010000000000}
    CachedUpdates = True
    AfterPost = selT073CompAfterPost
    Left = 76
    Top = 104
    object selT073CompCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selT073CompCOMPENSABILE: TStringField
      FieldName = 'COMPENSABILE'
      EditMask = '!900:00;1;_'
      Size = 7
    end
    object selT073CompGETTONE_RESIDUO: TStringField
      FieldName = 'GETTONE_RESIDUO'
      Size = 7
    end
  end
  object dsrT073Comp: TDataSource
    DataSet = selT073Comp
    Left = 76
    Top = 146
  end
  object selT074Liq: TOracleDataSet
    SQL.Strings = (
      'select CAUSALE,'
      '       CODFASCIA || '#39' ('#39' || MAGGIORAZIONE || '#39'%)'#39' FASCIA,'
      '       CODFASCIA,'
      '       MAGGIORAZIONE,'
      '       LIQUIDATO,'
      '       ROWID '
      'from   T074_CAUSPRESFASCE'
      'where  PROGRESSIVO = :PROGRESSIVO '
      'and    DATA = :DATA'
      'order by CAUSALE, MAGGIORAZIONE, CODFASCIA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforeInsert = selT074LiqBeforeInsert
    AfterPost = selT074LiqAfterPost
    BeforeDelete = selT074LiqBeforeInsert
    Left = 12
    Top = 104
    object selT074LiqCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT074LiqFASCIA: TStringField
      DisplayLabel = 'Fascia'
      DisplayWidth = 8
      FieldName = 'FASCIA'
      ReadOnly = True
      Size = 49
    end
    object selT074LiqCODFASCIA: TStringField
      FieldName = 'CODFASCIA'
      Required = True
      Visible = False
      Size = 5
    end
    object selT074LiqMAGGIORAZIONE: TFloatField
      FieldName = 'MAGGIORAZIONE'
      Required = True
      Visible = False
    end
    object selT074LiqLIQUIDATO: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liquidato'
      FieldName = 'LIQUIDATO'
      OnValidate = selT076OREValidate
      EditMask = '!900:00;1;_'
      Size = 7
    end
  end
  object dsrT074Liq: TDataSource
    DataSet = selT074Liq
    Left = 12
    Top = 146
  end
  object InsT074: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T074_CausPresFasce '
      
        '  (Progressivo, Data, Causale, Maggiorazione, CodFascia, OrePres' +
        'enza, Liquidato)'
      'VALUES '
      
        '  (:Progressivo, :Data, :Causale, :Maggiorazione, :CodFascia, :O' +
        'rePresenza, '#39'00.00'#39')')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000001C0000003A004D0041004700470049004F0052004100
      5A0049004F004E004500040000000000000000000000140000003A0043004F00
      4400460041005300430049004100050000000000000000000000180000003A00
      4F0052004500500052004500530045004E005A00410005000000000000000000
      0000}
    Left = 400
    Top = 8
  end
  object InsT073: TOracleQuery
    SQL.Strings = (
      'insert into T073_SCHEDACAUSPRES'
      '  (PROGRESSIVO,DATA,CAUSALE, COMPENSABILE)'
      'values'
      '  (:PROGRESSIVO, :DATA, :CAUSALE, '#39'00.00'#39')')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 182
    Top = 8
  end
  object UpdT073: TOracleQuery
    SQL.Strings = (
      'update T073_SCHEDACAUSPRES'
      'set'
      '  CAUSALE = :CAUSALE'
      'where'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  CAUSALE = :OLD_CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A00430041005500530041004C00450005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000180000003A004F004C0044005F004300410055005300
      41004C004500050000000000000000000000}
    Left = 227
    Top = 8
  end
  object updT074: TOracleQuery
    SQL.Strings = (
      'UPDATE T074_CausPresFasce '
      'SET '
      '  OrePresenza = :OrePresenza'
      'WHERE  '
      '  PROGRESSIVO = :Progressivo AND'
      '  DATA = :Data AND'
      '  CAUSALE = :Causale AND'
      '  MAGGIORAZIONE = :Maggiorazione AND'
      '  CODFASCIA = :CodFascia')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A004F0052004500500052004500530045004E00
      5A004100050000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F000300000000000000000000000A0000003A004400
      4100540041000C0000000000000000000000100000003A004300410055005300
      41004C0045000500000000000000000000001C0000003A004D00410047004700
      49004F00520041005A0049004F004E0045000400000000000000000000001400
      00003A0043004F00440046004100530043004900410005000000000000000000
      0000}
    Left = 444
    Top = 8
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 288
    Top = 56
  end
  object DelT073: TOracleQuery
    SQL.Strings = (
      'delete from T073_SCHEDACAUSPRES'
      'where'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  CAUSALE = :CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 271
    Top = 8
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT Codice,Descrizione,OreNormali,Abbatte_Budget,Periodicita_' +
        'Abbattimento'
      'FROM T275_CauPresenze'
      'ORDER BY Codice')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT275FilterRecord
    Left = 175
    Top = 56
  end
  object dsrT072: TDataSource
    DataSet = selT072
    Left = 137
    Top = 8
  end
  object selT072: TOracleDataSet
    SQL.Strings = (
      
        'SELECT Progressivo,Data,CodIndPres,IndPres,IndSupp_Resto,Tipo_Re' +
        'cord,RowID'
      'FROM T072_SchedaIndPres'
      'WHERE Progressivo = :Progressivo AND Data = :Data'
      'ORDER BY CodIndPres')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    OracleDictionary.DefaultValues = True
    ReadOnly = True
    BeforeEdit = selT072BeforeEdit
    BeforePost = selT072BeforePost
    BeforeDelete = selT072BeforeDelete
    OnNewRecord = selT072NewRecord
    Left = 95
    Top = 8
    object selT072PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT072DATA: TDateTimeField
      FieldName = 'DATA'
      Visible = False
    end
    object selT072CODINDPRES: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODINDPRES'
      Required = True
      OnValidate = selT072CODINDPRESValidate
      Size = 5
    end
    object selT072D_IndPres: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'D_IndPres'
      LookupDataSet = selT162
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODINDPRES'
      Size = 40
      Lookup = True
    end
    object selT072INDPRES: TStringField
      DisplayLabel = 'Num.'
      DisplayWidth = 5
      FieldName = 'INDPRES'
      OnValidate = selT072INDPRESValidate
      EditMask = '!#90,0;1;_'
      Size = 5
    end
    object selT072INDSUPP_RESTO: TStringField
      DisplayLabel = 'Resto Ind.Supp'
      FieldName = 'INDSUPP_RESTO'
      OnValidate = selT072INDPRESValidate
      EditMask = '!0,999;1;_'
      Size = 5
    end
    object selT072TIPO_RECORD: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECORD'
      ReadOnly = True
      Size = 1
    end
  end
  object selT162: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Descrizione,Tipo '
      'FROM T162_Indennita'
      'ORDER BY Codice')
    Optimize = False
    Left = 8
    Top = 56
  end
  object QLook75: TOracleDataSet
    Optimize = False
    Left = 573
    Top = 8
  end
  object dsrT075: TDataSource
    DataSet = selT075
    Left = 529
    Top = 8
  end
  object selT075: TOracleDataSet
    SQL.Strings = (
      'SELECT T075.*,T075.ROWID FROM T075_STRESTERNO T075'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA'
      'ORDER BY CENTROCOSTO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    CachedUpdates = True
    AfterPost = selT075AfterPost
    AfterCancel = selT075AfterCancel
    AfterDelete = selT075AfterPost
    OnNewRecord = selT075NewRecord
    Left = 488
    Top = 8
    object selT075PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T075_STRESTERNO.PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT075DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T075_STRESTERNO.DATA'
      Required = True
      Visible = False
    end
    object selT075CENTROCOSTO: TStringField
      DisplayWidth = 15
      FieldName = 'CENTROCOSTO'
      Origin = 'T075_STRESTERNO.CENTROCOSTO'
      Required = True
      Visible = False
      Size = 50
    end
    object selT075C_CentroCosto: TStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'C_CentroCosto'
      LookupDataSet = QLook75
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CENTROCOSTO'
      Lookup = True
    end
    object selT075D_CentroCosto: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 35
      FieldKind = fkLookup
      FieldName = 'D_CentroCosto'
      LookupDataSet = QLook75
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CENTROCOSTO'
      LookupCache = True
      Required = True
      Size = 40
      Lookup = True
    end
    object selT075ORESTRAORD: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Straordinario'
      DisplayWidth = 12
      FieldName = 'ORESTRAORD'
      Origin = 'T075_STRESTERNO.ORESTRAORD'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 7
    end
  end
  object selT276: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT CODICE,VOCEPAGHE '
      'FROM T276_VOCIPAGHEPRESENZA'
      'ORDER BY VOCEPAGHE')
    Optimize = False
    Left = 218
    Top = 56
  end
  object selT076: TOracleDataSet
    SQL.Strings = (
      'SELECT T076.*,T076.ROWID'
      'FROM T076_CAUSPRESPAGHE T076'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND DATA = :DATA'
      'ORDER BY T076.VOCEPAGHE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    ReadOnly = True
    OnNewRecord = selT076NewRecord
    Left = 616
    Top = 8
    object selT076PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT076DATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
      Visible = False
    end
    object selT076VOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Required = True
      Size = 6
    end
    object selT076Causale: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Causale'
      LookupDataSet = selT276
      LookupKeyFields = 'VOCEPAGHE'
      LookupResultField = 'CODICE'
      KeyFields = 'VOCEPAGHE'
      LookupCache = True
      ReadOnly = True
      Lookup = True
    end
    object selT076ORE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      Required = True
      OnValidate = selT076OREValidate
      EditMask = '!900:00;1;_'
      Size = 7
    end
  end
  object dsrT076: TDataSource
    DataSet = selT076
    Left = 658
    Top = 8
  end
  object selT077: TOracleDataSet
    SQL.Strings = (
      
        'select T077.*,T077.ROWID,nvl(I011.DESCRIZIONE,T077.DATO) DESCRIZ' +
        'IONE'
      
        'from T077_DATISCHEDA T077, MONDOEDP.I011_DIZIONARIO_DATISCHEDA I' +
        '011'
      'where T077.DATO = I011.DATO(+)'
      'and PROGRESSIVO = :PROGRESSIVO '
      'and DATA = :DATA'
      'order by nvl(I011.ORDINAMENTO,0),T077.DATO'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforeInsert = selT077BeforeInsert
    BeforeDelete = selT077BeforeDelete
    OnCalcFields = selT077CalcFields
    Left = 703
    Top = 8
    object selT077PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATA'
      Required = True
      Visible = False
    end
    object selT077DATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 20
      FieldName = 'DATO'
      ReadOnly = True
      Visible = False
      Size = 30
    end
    object selT077DESCRIZIONE: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 40
    end
    object selT077VALORE_AUT: TStringField
      DisplayLabel = 'Valore calcolato'
      DisplayWidth = 10
      FieldName = 'VALORE_AUT'
      ReadOnly = True
      Size = 50
    end
    object selT077VALORE_MAN: TStringField
      DisplayLabel = 'Valore manuale'
      DisplayWidth = 10
      FieldName = 'VALORE_MAN'
      Size = 50
    end
  end
  object dsrT077: TDataSource
    DataSet = selT077
    Left = 748
    Top = 8
  end
  object selT200: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Tipo,MaxStraord'
      'FROM T200_Contratti')
    Optimize = False
    Left = 50
    Top = 56
  end
  object dsrT200: TDataSource
    DataSet = selT200
    Left = 91
    Top = 56
  end
  object selT201: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T210.Codice,T210.Maggiorazione '
      'FROM T210_Maggiorazioni T210, T201_Maggiorazioni T201'
      
        'WHERE (T210.Codice = T201.Maggior1 OR T210.Codice = T201.Maggior' +
        '2 OR '
      
        '  T210.Codice = T201.Maggior3 OR T210.Codice = T201.Maggior4) AN' +
        'D'
      'T201.Codice = :Codice'
      'ORDER BY T210.Maggiorazione,T210.Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 132
    Top = 56
  end
  object selT065: TOracleDataSet
    SQL.Strings = (
      'select distinct PROGRESSIVO'
      'FROM T065_RICHIESTESTRAORDINARI'
      'WHERE PROGRESSIVO = :progressivo AND DATA = :data'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 506
    Top = 56
  end
  object dsrT305: TDataSource
    AutoEdit = False
    DataSet = selT305
    Left = 260
    Top = 148
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Descrizione,Limite_Liq'
      'FROM T305_CauGiustif'
      'ORDER BY Codice')
    Optimize = False
    Left = 219
    Top = 148
  end
  object selUsrT072: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from USR_T072_DETTGG_TIPOI '
      'where PROGRESSIVO = :PROGRESSIVO'
      'and trunc(DATA,'#39'MM'#39') = :DATA'
      'order by DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 320
    Top = 148
  end
  object Prova: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM V$PARAMETER WHERE UPPER(NAME) ='#39'NLS_DATE_FORMAT'#39)
    Optimize = False
    Left = 480
    Top = 144
  end
end
