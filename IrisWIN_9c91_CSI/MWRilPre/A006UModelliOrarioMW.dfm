inherited A006FModelliOrarioMW: TA006FModelliOrarioMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 110
  Width = 700
  object selT021Copia: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T021_FASCEORARI t where CODICE = :CODICE o' +
        'rder by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 472
    Top = 8
  end
  object selT020CopiaW: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T020_ORARI t where CODICE = :CODICE order ' +
        'by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 400
    Top = 8
  end
  object selT020CopiaR: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T020_ORARI t where CODICE = :CODICE order ' +
        'by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 320
    Top = 8
  end
  object selT021Control: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) TOTALE FROM T021_FASCEORARI T '
      
        'WHERE CODICE = :CODICE AND DECORRENZA = :DECORRENZA AND TIPO_FAS' +
        'CIA ='#39'STR'#39)
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    Left = 224
    Top = 8
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE from T265_CAUASSENZE order by CODICE')
    ReadBuffer = 50
    Optimize = False
    Left = 651
    Top = 8
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 652
    Top = 56
  end
  object selT276: TOracleDataSet
    SQL.Strings = (
      'select distinct T275.CODICE, T275.DESCRIZIONE '
      'from T276_VOCIPAGHEPRESENZA T276, T275_CAUPRESENZE T275'
      'where T276.CODICE = T275.CODICE'
      'order by T275.CODICE')
    ReadBuffer = 5
    Optimize = False
    Left = 595
    Top = 8
  end
  object dstT276: TDataSource
    DataSet = selT276
    Left = 595
    Top = 56
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'select T275.CODICE, T275.DESCRIZIONE '
      'from T275_CAUPRESENZE T275'
      'order by T275.CODICE')
    Optimize = False
    AfterOpen = selT275AfterOpen
    Left = 538
    Top = 8
  end
  object dsrT275: TDataSource
    DataSet = selT275
    Left = 539
    Top = 56
  end
  object selT021STR: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,OREMINIME,RO' +
        'WID '
      'FROM   T021_FASCEORARI T '
      'WHERE  CODICE = :CODICE '
      'AND    DECORRENZA = :DECORRENZA '
      'AND    TIPO_FASCIA IN ('#39'STR'#39','#39'FO'#39','#39'MGM'#39','#39'MGP'#39')'
      'ORDER BY TIPO_FASCIA,ENTRATA,USCITA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000180000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      5400490050004F005F004600410053004300490041000100000000000E000000
      45004E00540052004100540041000100000000000C0000005500530043004900
      54004100010000000000140000004D004D0041004E0054004900430049005000
      4F00010000000000160000004D004D0041004E00540049004300490050004F00
      55000100000000001400000054004F004C004C004500520041004E005A004100
      0100000000001600000054004F004C004C004500520041004E005A0041005500
      0100000000001600000041005200520046004C00450053004600410053004300
      0100000000001800000041005200520046004C00450053004600410053004300
      5500010000000000120000004D004D005200490054004100520044004F000100
      00000000140000004D004D005200490054004100520044004F00550001000000
      0000140000004D004D004100520052004F0054004F004E004400010000000000
      160000004D004D004100520052004F0054004F004E0044005500010000000000
      140000004100520052005200490054004100520044004F000100000000001200
      000041005200520055005300430041004E0054000100000000002C0000005300
      43004F00530054005F00500055004E00540049005F004E004F004D0049004E00
      41004C0049005F0045000100000000002C000000530043004F00530054005F00
      500055004E00540049005F004E004F004D0049004E0041004C0049005F005500
      0100000000000C0000004D004D0046004C004500580001000000000012000000
      4F0052004500540045004F005400550052000100000000001400000053004900
      47004C0041005400550052004E004900010000000000100000004E0055004D00
      5400550052004E004F00010000000000120000004F00520045004D0049004E00
      49004D004500010000000000}
    ReadOnly = True
    OnApplyRecord = selT021ApplyRecord
    CachedUpdates = True
    AfterOpen = selT021AfterOpen
    BeforePost = selT021BeforePost
    AfterPost = selT021STRAfterPost
    OnNewRecord = selT021NewRecord
    Left = 148
    Top = 8
    object StringField23: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
      Visible = False
    end
    object selT021STRTipo_Fascia: TStringField
      DisplayLabel = 'Tipo fascia'
      FieldName = 'TIPO_FASCIA'
      Required = True
      OnValidate = TIPO_FASCIAValidate
      Size = 3
    end
    object StringField25: TStringField
      DisplayLabel = 'Entrata'
      FieldName = 'ENTRATA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object StringField26: TStringField
      DisplayLabel = 'Uscita'
      FieldName = 'USCITA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021STROREMINIME: TStringField
      DisplayLabel = 'Durata'
      FieldName = 'OREMINIME'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
  object dsrT021STR: TDataSource
    DataSet = selT021STR
    Left = 148
    Top = 52
  end
  object dsrT021PM: TDataSource
    DataSet = selT021PM
    Left = 84
    Top = 52
  end
  object selT021PM: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DECORRENZA,TIPO_FASCIA,ENTRATA,USCITA,MMANTICIPOU,' +
        'MMRITARDO,MMARROTOND,MMARROTONDU,OREMINIME,MMFLEX,ROWID '
      
        'FROM T021_FASCEORARI T WHERE CODICE = :CODICE AND DECORRENZA = :' +
        'DECORRENZA AND TIPO_FASCIA IN ('#39'PMA'#39','#39'PMT'#39')'
      'ORDER BY TIPO_FASCIA,ENTRATA,USCITA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000B0000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      5400490050004F005F004600410053004300490041000100000000000E000000
      45004E00540052004100540041000100000000000C0000005500530043004900
      54004100010000000000160000004D004D0041004E0054004900430049005000
      4F005500010000000000120000004D004D005200490054004100520044004F00
      010000000000140000004D004D004100520052004F0054004F004E0044000100
      00000000160000004D004D004100520052004F0054004F004E00440055000100
      00000000120000004F00520045004D0049004E0049004D004500010000000000
      0C0000004D004D0046004C0045005800010000000000}
    ReadOnly = True
    OnApplyRecord = selT021ApplyRecord
    CachedUpdates = True
    AfterOpen = selT021AfterOpen
    BeforeInsert = selT021BeforeInsert
    BeforePost = selT021BeforePost
    AfterScroll = selT021PMAfterScroll
    OnNewRecord = selT021NewRecord
    Left = 84
    Top = 8
    object StringField1: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
      Visible = False
    end
    object selT021PMTipo_Fascia: TStringField
      DisplayLabel = 'Tipo fascia'
      FieldName = 'TIPO_FASCIA'
      Required = True
      OnChange = selT021PMTipo_FasciaChange
      OnValidate = TIPO_FASCIAValidate
      Size = 3
    end
    object StringField3: TStringField
      DisplayLabel = 'Inizio'
      FieldName = 'ENTRATA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object StringField15: TStringField
      DisplayLabel = 'Inizio max'
      FieldName = 'MMRITARDO'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object StringField17: TStringField
      DisplayLabel = 'Arrot.Inizio'
      FieldName = 'MMARROTOND'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object StringField10: TStringField
      DisplayLabel = 'Rientro min'
      FieldName = 'MMANTICIPOU'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object StringField4: TStringField
      DisplayLabel = 'Rientro'
      FieldName = 'USCITA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object StringField18: TStringField
      DisplayLabel = 'Arrot.Rientro'
      FieldName = 'MMARROTONDU'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object StringField8: TStringField
      DisplayLabel = 'Ore minime'
      FieldName = 'OREMINIME'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PMMMFLEX: TStringField
      DisplayLabel = 'Flex.Max.'
      FieldName = 'MMFLEX'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
  object selT021PN: TOracleDataSet
    SQL.Strings = (
      'select ROWNUM, T.*'
      
        '  from /*T021_FASCEORARI <--Serve alla funzione R180GetTabella p' +
        'er reperire la tabella*/'
      '       (select T021.*, T021.ROWID '
      '          from T021_FASCEORARI T021'
      '         where T021.CODICE = :CODICE '
      '           and T021.DECORRENZA = :DECORRENZA '
      '           and T021.TIPO_FASCIA in ('#39'PN'#39')'
      '         order by T021.TIPO_FASCIA, T021.ENTRATA, T021.USCITA) T')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001B0000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      5400490050004F005F004600410053004300490041000100000000000E000000
      45004E00540052004100540041000100000000000C0000005500530043004900
      54004100010000000000140000004D004D0041004E0054004900430049005000
      4F00010000000000160000004D004D0041004E00540049004300490050004F00
      55000100000000001400000054004F004C004C004500520041004E005A004100
      0100000000001600000054004F004C004C004500520041004E005A0041005500
      0100000000001600000041005200520046004C00450053004600410053004300
      0100000000001800000041005200520046004C00450053004600410053004300
      5500010000000000120000004D004D005200490054004100520044004F000100
      00000000140000004D004D005200490054004100520044004F00550001000000
      0000140000004D004D004100520052004F0054004F004E004400010000000000
      160000004D004D004100520052004F0054004F004E0044005500010000000000
      140000004100520052005200490054004100520044004F000100000000001200
      000041005200520055005300430041004E0054000100000000002C0000005300
      43004F00530054005F00500055004E00540049005F004E004F004D0049004E00
      41004C0049005F0045000100000000002C000000530043004F00530054005F00
      500055004E00540049005F004E004F004D0049004E0041004C0049005F005500
      0100000000000C0000004D004D0046004C004500580001000000000012000000
      4F0052004500540045004F005400550052000100000000001400000053004900
      47004C0041005400550052004E004900010000000000100000004E0055004D00
      5400550052004E004F00010000000000120000004F00520045004D0049004E00
      49004D0045000100000000001600000045004E00540052004100540041005F00
      4F0042004200010000000000140000005500530043004900540041005F004F00
      42004200010000000000140000004F0052004500540045004F00540055005200
      3200010000000000}
    ReadOnly = True
    OnApplyRecord = selT021ApplyRecord
    CachedUpdates = True
    AfterOpen = selT021AfterOpen
    BeforeInsert = selT021BeforeInsert
    BeforePost = selT021BeforePost
    OnNewRecord = selT021NewRecord
    Left = 16
    Top = 8
    object selT021PNROWNUM: TFloatField
      DisplayLabel = 'Num. riga'
      DisplayWidth = 7
      FieldName = 'ROWNUM'
      ReadOnly = True
    end
    object selT021PNCODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT021PNDECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
      Visible = False
    end
    object selT021PNTIPO_FASCIA: TStringField
      DisplayLabel = 'Tipo fascia'
      FieldName = 'TIPO_FASCIA'
      ReadOnly = True
      Required = True
      OnValidate = TIPO_FASCIAValidate
      Size = 3
    end
    object selT021PNENTRATA: TStringField
      DisplayLabel = 'Entrata'
      FieldName = 'ENTRATA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNUSCITA: TStringField
      DisplayLabel = 'Uscita'
      FieldName = 'USCITA'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNENTRATA_OBB: TStringField
      DisplayLabel = 'Ent.obbl.'
      FieldName = 'ENTRATA_OBB'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNUSCITA_OBB: TStringField
      DisplayLabel = 'Usc.obbl.'
      FieldName = 'USCITA_OBB'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNSIGLATURNI: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLATURNI'
      Size = 2
    end
    object selT021PNNUMTURNO: TIntegerField
      DisplayLabel = 'Num.turno'
      DisplayWidth = 7
      FieldName = 'NUMTURNO'
      OnValidate = selT021PNNUMTURNOValidate
      MaxValue = 4
    end
    object selT021PNMMFLEX: TStringField
      DisplayLabel = 'Flessibilit'#224
      FieldName = 'MMFLEX'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNORETEOTUR: TStringField
      DisplayLabel = 'Ore teoriche'
      FieldName = 'ORETEOTUR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNORETEOTUR2: TStringField
      DisplayLabel = 'Ore teoriche in Usc.'
      FieldName = 'ORETEOTUR2'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNOREMINIME: TStringField
      DisplayLabel = 'Ore minime'
      FieldName = 'OREMINIME'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNMMANTICIPO: TStringField
      DisplayLabel = 'Anticipo E'
      FieldName = 'MMANTICIPO'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNMMANTICIPOU: TStringField
      DisplayLabel = 'Anticipo U'
      FieldName = 'MMANTICIPOU'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNTOLLERANZA: TStringField
      DisplayLabel = 'Tolleranza E'
      FieldName = 'TOLLERANZA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNTOLLERANZAU: TStringField
      DisplayLabel = 'Tolleranza U'
      FieldName = 'TOLLERANZAU'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNARRFLESFASC: TStringField
      DisplayLabel = 'Arr.fless.E'
      FieldName = 'ARRFLESFASC'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNARRFLESFASCU: TStringField
      DisplayLabel = 'Arr.fless.U'
      FieldName = 'ARRFLESFASCU'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNMMRITARDO: TStringField
      DisplayLabel = 'Ritardo E'
      FieldName = 'MMRITARDO'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNMMRITARDOU: TStringField
      DisplayLabel = 'Ritardo U'
      FieldName = 'MMRITARDOU'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNMMARROTOND: TStringField
      DisplayLabel = 'Arrotond.E'
      FieldName = 'MMARROTOND'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNMMARROTONDU: TStringField
      DisplayLabel = 'Arrotond.U'
      FieldName = 'MMARROTONDU'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNARRRITARDO: TStringField
      DisplayLabel = 'Arr.ritardo'
      FieldName = 'ARRRITARDO'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNARRUSCANT: TStringField
      DisplayLabel = 'Arr.anticipo'
      FieldName = 'ARRUSCANT'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT021PNSCOST_PUNTI_NOMINALI_E: TStringField
      DisplayLabel = 'Scostam.E'
      FieldName = 'SCOST_PUNTI_NOMINALI_E'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNSCOST_PUNTI_NOMINALI_U: TStringField
      DisplayLabel = 'Scostam.U'
      FieldName = 'SCOST_PUNTI_NOMINALI_U'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT021PNDISAGIO_SERALE: TStringField
      DisplayLabel = 'Disagio serale'
      DisplayWidth = 5
      FieldName = 'DISAGIO_SERALE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
  object dsrT021PN: TDataSource
    DataSet = selT021PN
    Left = 16
    Top = 52
  end
end
