inherited A100FMissioniMW: TA100FMissioniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 422
  Width = 677
  object QM011: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M011.CODICE, M011.DESCRIZIONE, M011.SELEZIONATO, M010.DEC' +
        'ORRENZA, 1 AS ORDMIS'
      'FROM M010_PARAMETRICONTEGGIO M010, M011_TIPOMISSIONE M011'
      'WHERE M010.CODICE = (SELECT T430.:C8_MISSIONI'
      '                     FROM T430_STORICO T430'
      '                     WHERE T430.PROGRESSIVO = :PROGRESSIVO'
      
        '                           AND :data BETWEEN T430.DATADECORRENZA' +
        ' AND DATAFINE)'
      '      AND M011.CODICE = M010.TIPO_MISSIONE'
      '      AND M011.SELEZIONATO = '#39'S'#39
      '      AND M010.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                             FROM M010_PARAMETRICONTEGGIO'
      '                             WHERE DECORRENZA <= :DATA'
      
        '                                   AND TIPO_MISSIONE = M010.TIPO' +
        '_MISSIONE'
      
        '                                   AND CODICE = (SELECT T430.:C8' +
        '_MISSIONI'
      
        '                                                 FROM T430_STORI' +
        'CO T430'
      
        '                                                 WHERE T430.PROG' +
        'RESSIVO = :PROGRESSIVO'
      
        '                                                      AND :data ' +
        'BETWEEN T430.DATADECORRENZA AND DATAFINE))'
      'UNION'
      
        'SELECT M011.CODICE, M011.DESCRIZIONE, M011.SELEZIONATO, M010.DEC' +
        'ORRENZA, 2 AS ORDMIS'
      'FROM M010_PARAMETRICONTEGGIO M010, M011_TIPOMISSIONE M011'
      'WHERE M010.CODICE = (SELECT T430.:C8_MISSIONI'
      '                     FROM T430_STORICO T430'
      '                     WHERE T430.PROGRESSIVO = :PROGRESSIVO'
      
        '                           AND :data BETWEEN T430.DATADECORRENZA' +
        ' AND DATAFINE)'
      '      AND M011.CODICE = M010.TIPO_MISSIONE'
      '      AND M011.SELEZIONATO <> '#39'S'#39
      '      AND M010.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                             FROM M010_PARAMETRICONTEGGIO'
      '                             WHERE DECORRENZA <= :DATA'
      
        '                                   AND TIPO_MISSIONE = M010.TIPO' +
        '_MISSIONE'
      
        '                                   AND CODICE = (SELECT T430.:C8' +
        '_MISSIONI'
      
        '                                                 FROM T430_STORI' +
        'CO T430'
      
        '                                                 WHERE T430.PROG' +
        'RESSIVO = :PROGRESSIVO'
      
        '                                                      AND :data ' +
        'BETWEEN T430.DATADECORRENZA AND DATAFINE))'
      'ORDER BY ORDMIS')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00430038005F004D0049005300530049004F00
      4E004900010000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F000300000000000000000000000A0000003A004400
      4100540041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001600
      0000530045004C0045005A0049004F004E00410054004F000100000000000200
      00003100010000000000}
    Filtered = True
    OnFilterRecord = QM011FilterRecord
    Left = 122
    Top = 5
    object QM011CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object QM011DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object QM011SELEZIONATO: TStringField
      FieldName = 'SELEZIONATO'
      Size = 1
    end
  end
  object dsrM011: TDataSource
    DataSet = QM011
    Left = 83
    Top = 5
  end
  object M013F_CALC_RIMB_PASTO: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :RESULT:=M013F_CALC_RIMB_PASTO('#39'I'#39', :CODICE, :TIPOREGISTRAZION' +
        'E, :DATADA, :DATAA, :ORADA, :ORAA);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A0052004500530055004C005400040000000000
      0000000000000E0000003A0043004F0044004900430045000500000000000000
      00000000240000003A005400490050004F005200450047004900530054005200
      41005A0049004F004E0045000500000000000000000000000E0000003A004400
      410054004100440041000C00000000000000000000000C0000003A0044004100
      5400410041000C00000000000000000000000C0000003A004F00520041004400
      41000500000000000000000000000A0000003A004F0052004100410005000000
      0000000000000000}
    Left = 482
    Top = 257
  end
  object QSource: TOracleDataSet
    Optimize = False
    Left = 360
    Top = 256
  end
  object M049: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from m049_tipopagamento t')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000A00
      000053004F004D004D004100010000000000}
    BeforePost = M049BeforePost
    Left = 144
    Top = 64
    object M049CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object M049DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object M049SOMMA: TStringField
      DisplayLabel = 'Rimborsa'
      FieldName = 'SOMMA'
      Size = 1
    end
  end
  object DM049: TDataSource
    AutoEdit = False
    DataSet = M049
    Left = 96
    Top = 64
  end
  object M051: TOracleDataSet
    SQL.Strings = (
      'SELECT M051.*, M051.ROWID '
      '  FROM M051_DETTAGLIORIMBORSO M051'
      ' WHERE M051.PROGRESSIVO=:PROGRESSIVO'
      '   AND M051.MESESCARICO=:MESESCARICO'
      '   AND M051.MESECOMPETENZA=:MESECOMPETENZA'
      '   AND M051.DATADA=:DATADA'
      '   AND M051.ORADA=:ORADA'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000
      100000003A004F00520044004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000002600000043004F00
      4400490043004500520049004D0042004F00520053004F005300500045005300
      450001000000000018000000500052004F004700520049004D0042004F005200
      53004F00010000000000180000004400410054004100520049004D0042004F00
      520053004F000100000000000E00000049004D0050004F00520054004F000100
      00000000180000005400490050004F00520049004D0042004F00520053004F00
      010000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = M051BeforePost
    BeforeDelete = M051BeforeDelete
    AfterDelete = M051AfterDelete
    Left = 56
    Top = 128
    object M051DATARIMBORSO: TDateTimeField
      DisplayLabel = 'Data rimborso'
      DisplayWidth = 18
      FieldName = 'DATARIMBORSO'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object M051TIPORIMBORSO: TStringField
      DisplayLabel = 'Modalit'#224' di pagamento'
      FieldName = 'TIPORIMBORSO'
      Size = 5
    end
    object M051desctiporimborso: TStringField
      DisplayLabel = 'Descrizione modalit'#224' di pagamento'
      FieldKind = fkLookup
      FieldName = 'desctiporimborso'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPORIMBORSO'
      Size = 40
      Lookup = True
    end
    object M051somma: TStringField
      DisplayLabel = 'Rimborsare'
      DisplayWidth = 2
      FieldKind = fkLookup
      FieldName = 'somma'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'SOMMA'
      KeyFields = 'TIPORIMBORSO'
      OnGetText = M051sommaGetText
      Size = 2
      Lookup = True
    end
    object M051IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object M051IMPORTO_VALEST: TFloatField
      DisplayLabel = 'Imp. val. est'
      FieldName = 'IMPORTO_VALEST'
      OnChange = M051IMPORTO_VALESTChange
    end
    object M051PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object M051MESESCARICO: TDateTimeField
      FieldName = 'MESESCARICO'
      Required = True
      Visible = False
    end
    object M051MESECOMPETENZA: TDateTimeField
      FieldName = 'MESECOMPETENZA'
      Required = True
      Visible = False
    end
    object M051DATADA: TDateTimeField
      FieldName = 'DATADA'
      Required = True
      Visible = False
    end
    object M051ORADA: TStringField
      FieldName = 'ORADA'
      Required = True
      Visible = False
      Size = 5
    end
    object M051PROGRIMBORSO: TFloatField
      FieldName = 'PROGRIMBORSO'
      Required = True
      Visible = False
    end
    object M051CODICERIMBORSOSPESE: TStringField
      FieldName = 'CODICERIMBORSOSPESE'
      Required = True
      Visible = False
      Size = 5
    end
  end
  object M051A: TOracleDataSet
    SQL.Strings = (
      'select max(progrimborso) as progrimborso'
      '  from m051_dettagliorimborso'
      ' where progressivo=:progressivo'
      '   and mesescarico=:mesescarico'
      '   and mesecompetenza=:mesecompetenza'
      '   and datada=:datada'
      '   and orada=:orada '
      '   and codicerimborsospese=:codicerimborsospese'
      '   and datarimborso=:datarimborso')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000
      280000003A0043004F004400490043004500520049004D0042004F0052005300
      4F00530050004500530045000500000000000000000000001A0000003A004400
      410054004100520049004D0042004F00520053004F000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000002600000043004F00
      4400490043004500520049004D0042004F00520053004F005300500045005300
      450001000000000018000000500052004F004700520049004D0042004F005200
      53004F00010000000000180000004400410054004100520049004D0042004F00
      520053004F000100000000000E00000049004D0050004F00520054004F000100
      00000000180000005400490050004F00520049004D0042004F00520053004F00
      010000000000}
    Left = 112
    Top = 128
  end
  object D051: TDataSource
    DataSet = M051
    OnDataChange = D051DataChange
    Left = 16
    Top = 128
  end
  object Q050: TOracleDataSet
    SQL.Strings = (
      'SELECT M050.ROWID, M050.*,'
      
        '       M051F_GETMINVALORE(M050.PROGRESSIVO, M050.CODICERIMBORSOS' +
        'PESE, M050.MESESCARICO, M050.MESECOMPETENZA, M050.DATADA, M050.O' +
        'RADA,'#39'NOTE'#39') NOTE,'
      
        '       M051F_GETMINVALORE(M050.PROGRESSIVO, M050.CODICERIMBORSOS' +
        'PESE, M050.MESESCARICO, M050.MESECOMPETENZA, M050.DATADA, M050.O' +
        'RADA,'#39'STATO'#39') STATO'
      '  FROM M050_RIMBORSI M050'
      ' WHERE M050.PROGRESSIVO = :PROG'
      '   AND M050.MESESCARICO = :MSCARICO'
      '   AND M050.MESECOMPETENZA= :MCOMPETENZA'
      '   AND M050.DATADA = :DDA'
      '   AND M050.ORADA = :ODA'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470008000000000000000000
      0000120000003A004D005300430041005200490043004F000C00000000000000
      00000000180000003A004D0043004F004D0050004500540045004E005A004100
      0C0000000000000000000000080000003A004400440041000C00000000000000
      00000000080000003A004F004400410005000000000000000000000010000000
      3A004F00520044004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000900000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000A0000004F00520041004400410001000000
      00002600000043004F004400490043004500520049004D0042004F0052005300
      4F00530050004500530045000100000000002800000049004D0050004F005200
      54004F00520049004D0042004F00520053004F00530050004500530045000100
      000000003A00000049004D0050004F00520054004F0049004E00440045004E00
      4E0049005400410053005500500050004C0045004D0045004E00540041005200
      45000100000000000C0000004400410054004100440041000100000000002800
      000049004D0050004F00520054004F0043004F00530054004F00520049004D00
      42004F00520053004F00010000000000}
    ReadOnly = True
    OnApplyRecord = Q050ApplyRecord
    CachedUpdates = True
    BeforeInsert = Q050BeforeInsert
    BeforePost = Q050BeforePost
    AfterPost = Q050AfterPost
    BeforeDelete = Q050BeforeDelete
    AfterDelete = Q050AfterDelete
    AfterScroll = Q050AfterScroll
    OnNewRecord = Q050NewRecord
    Left = 376
    Top = 64
    object Q050CODICERIMBORSOSPESE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICERIMBORSOSPESE'
      Required = True
      OnValidate = Q050CODICERIMBORSOSPESEValidate
      Size = 5
    end
    object Q050descrimborso: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'descrimborso'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICERIMBORSOSPESE'
      Size = 40
      Lookup = True
    end
    object Q050CODICEVOCEPAGHE: TStringField
      DisplayLabel = 'C.Pag.'
      FieldKind = fkLookup
      FieldName = 'CODICEVOCEPAGHE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICEVOCEPAGHE'
      KeyFields = 'CODICERIMBORSOSPESE'
      ReadOnly = True
      Size = 6
      Lookup = True
    end
    object Q050IMPORTORIMBORSOSPESE: TFloatField
      DisplayLabel = 'Imp. Rimb. (C)'
      FieldName = 'IMPORTORIMBORSOSPESE'
      OnChange = Q050IMPORTORIMBORSOSPESEChange
      OnValidate = Q050IMPORTORIMBORSOSPESEValidate
    end
    object Q050IMPORTOCOSTORIMBORSO: TFloatField
      DisplayLabel = 'Costo Rimb. (D)'
      FieldName = 'IMPORTOCOSTORIMBORSO'
    end
    object Q050COD_VALUTA_EST: TStringField
      DisplayLabel = 'Cod. Valuta'
      FieldName = 'COD_VALUTA_EST'
      OnChange = Q050COD_VALUTA_ESTChange
      OnValidate = Q050COD_VALUTA_ESTValidate
      Size = 10
    end
    object Q050IMPRIMB_VALEST: TFloatField
      DisplayLabel = 'Rimb. val. est.'
      FieldName = 'IMPRIMB_VALEST'
      OnChange = Q050IMPRIMB_VALESTChange
    end
    object Q050COSTORIMB_VALEST: TFloatField
      DisplayLabel = 'Costo val. est.'
      FieldName = 'COSTORIMB_VALEST'
      ReadOnly = True
    end
    object Q050CODICEVOCEPAGHEINDENNITASUPPL: TStringField
      DisplayLabel = 'C. Pag. I.S.'
      FieldKind = fkLookup
      FieldName = 'CODICEVOCEPAGHEINDENNITASUPPL'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICEVOCEPAGHEINDENNITASUPPL'
      KeyFields = 'CODICERIMBORSOSPESE'
      ReadOnly = True
      Size = 6
      Lookup = True
    end
    object Q050IMPORTOINDENNITASUPPLEMENTARE: TFloatField
      DisplayLabel = 'Imp. I.S: (E)'
      FieldName = 'IMPORTOINDENNITASUPPLEMENTARE'
    end
    object Q050PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q050MESESCARICO: TDateTimeField
      FieldName = 'MESESCARICO'
      Required = True
      Visible = False
    end
    object Q050MESECOMPETENZA: TDateTimeField
      FieldName = 'MESECOMPETENZA'
      Required = True
      Visible = False
    end
    object Q050DATADA: TDateTimeField
      FieldName = 'DATADA'
      Required = True
      Visible = False
    end
    object Q050ORADA: TStringField
      FieldName = 'ORADA'
      Required = True
      Visible = False
      Size = 5
    end
    object Q050DESCRIZIONE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICERIMBORSOSPESE'
      ReadOnly = True
      Visible = False
      Size = 40
      Lookup = True
    end
    object Q050ESISTENZAINDENNITASUPPL: TStringField
      FieldKind = fkLookup
      FieldName = 'ESISTENZAINDENNITASUPPL'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'ESISTENZAINDENNITASUPPL'
      KeyFields = 'CODICERIMBORSOSPESE'
      ReadOnly = True
      Visible = False
      Size = 1
      Lookup = True
    end
    object Q050TIPO: TStringField
      FieldKind = fkLookup
      FieldName = 'TIPO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'TIPO'
      KeyFields = 'CODICERIMBORSOSPESE'
      Visible = False
      Size = 5
      Lookup = True
    end
    object Q050TIPO_QUANTITA: TStringField
      FieldKind = fkLookup
      FieldName = 'TIPO_QUANTITA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'TIPO_QUANTITA'
      KeyFields = 'CODICERIMBORSOSPESE'
      Visible = False
      Size = 1
      Lookup = True
    end
    object Q050flag_anticipo: TStringField
      FieldKind = fkLookup
      FieldName = 'flag_anticipo'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'FLAG_ANTICIPO'
      KeyFields = 'CODICERIMBORSOSPESE'
      Visible = False
      Size = 1
      Lookup = True
    end
    object Q050codrimborso: TStringField
      FieldKind = fkLookup
      FieldName = 'codrimborso'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CODICERIMBORSOSPESE'
      Visible = False
      Size = 5
      Lookup = True
    end
    object Q050NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      ReadOnly = True
      Size = 2000
    end
    object Q050STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 10
      FieldName = 'STATO'
      ReadOnly = True
      Size = 40
    end
    object Q050ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
      Visible = False
    end
    object Q050FLAG_NON_RIMBORSABILE: TStringField
      FieldKind = fkLookup
      FieldName = 'flag_non_rimborsabile'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'FLAG_NON_RIMBORSABILE'
      KeyFields = 'CODICERIMBORSOSPESE'
      Visible = False
      Size = 1
      Lookup = True
    end
  end
  object Q020: TOracleDataSet
    SQL.Strings = (
      'select * from m020_tipirimborsi'
      ':FILTRO'
      ' order by codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001E00
      000043004F00440049004300450056004F004300450050004100470048004500
      010000000000180000005300430041005200490043004F005000410047004800
      45000100000000002E0000004500530049005300540045004E005A0041004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      3A00000043004F00440049004300450056004F00430045005000410047004800
      450049004E00440045004E004E0049005400410053005500500050004C000100
      00000000340000005300430041005200490043004F0050004100470048004500
      49004E00440045004E004E0049005400410053005500500050004C0001000000
      000024000000500045005200430049004E00440045004E004E00490054004100
      53005500500050004C00010000000000260000004100520052004F0054004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      1A00000046004C00410047005F0041004E00540049004300490050004F000100
      00000000}
    Left = 198
    Top = 7
    object Q020CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object Q020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q020CODICEVOCEPAGHE: TStringField
      FieldName = 'CODICEVOCEPAGHE'
      Size = 6
    end
    object Q020SCARICOPAGHE: TStringField
      FieldName = 'SCARICOPAGHE'
      Size = 1
    end
    object Q020ESISTENZAINDENNITASUPPL: TStringField
      FieldName = 'ESISTENZAINDENNITASUPPL'
      Size = 1
    end
    object Q020CODICEVOCEPAGHEINDENNITASUPPL: TStringField
      FieldName = 'CODICEVOCEPAGHEINDENNITASUPPL'
      Size = 6
    end
    object Q020SCARICOPAGHEINDENNITASUPPL: TStringField
      FieldName = 'SCARICOPAGHEINDENNITASUPPL'
      Size = 1
    end
    object Q020PERCINDENNITASUPPL: TFloatField
      FieldName = 'PERCINDENNITASUPPL'
    end
    object Q020ARROTINDENNITASUPPL: TStringField
      FieldName = 'ARROTINDENNITASUPPL'
      Size = 5
    end
    object Q020FLAG_ANTICIPO: TStringField
      FieldName = 'FLAG_ANTICIPO'
      Required = True
      Size = 1
    end
    object Q020TIPO: TStringField
      FieldName = 'TIPO'
      Size = 5
    end
    object Q020TIPO_QUANTITA: TStringField
      FieldName = 'TIPO_QUANTITA'
      Size = 1
    end
    object Q020FLAG_NON_RIMBORSABILE: TStringField
      FieldName = 'FLAG_NON_RIMBORSABILE'
    end
  end
  object D020: TDataSource
    DataSet = Q020
    Left = 166
    Top = 7
  end
  object D010: TDataSource
    DataSet = Q010
    Left = 4
    Top = 6
  end
  object Q010: TOracleDataSet
    SQL.Strings = (
      'select '
      
        'decorrenza, codice, tipo_missione, descrizione, oreminimeperinde' +
        'nnita, limiteoreretribuiteintere, arrotondamentoore, percretribs' +
        'uperoore,'
      
        'maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione' +
        ', arrottotimportidatipaghe, tipo, riduzione_pasto, percretribpas' +
        'to, '
      
        'tariffaindennita, tipo_tariffa, codvocepagheintera, codvocepaghe' +
        'suphh, codvocepaghesupgg, codvocepaghesuphhgg, '
      
        'orerimborsopasto, tariffarimborsopasto, orerimborsopasto2, tarif' +
        'farimborsopasto2, codici_indennitakm, codici_rimborsi, ind_da_ta' +
        'b_tariffe,'
      
        'causale_missione, giustif_hhmax, giustif_copre_debitogg, tipo_ri' +
        'mborsopasto'
      'from m010_parametriconteggio'
      'where decorrenza = (select max(decorrenza) '
      '                      from m010_parametriconteggio '
      '                     where decorrenza <= :DECORRENZA '
      '                       AND tipo_missione=:tiporegistrazione'
      '                       and codice=:codice)'
      '  and tipo_missione=:tiporegistrazione'
      '  and codice=:codice')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000240000003A005400490050004F0052004500
      4700490053005400520041005A0049004F004E00450005000000000000000000
      00000E0000003A0043004F004400490043004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001C000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002A0000004F00520045004D0049004E0049004D00450050004500
      520049004E00440045004E004E00490054004100010000000000320000004C00
      49004D004900540045004F005200450052004500540052004900420055004900
      5400450049004E00540045005200450001000000000022000000410052005200
      4F0054004F004E00440041004D0045004E0054004F004F005200450001000000
      0000260000005000450052004300520045005400520049004200530055005000
      450052004F004F0052004500010000000000220000004D004100580047004900
      4F0052004E00490052004500540052004D004500530045000100000000002400
      0000500045005200430052004500540052004900420053005500500045005200
      4F0047004700010000000000320000004100520052004F005400540041005200
      490046004600410044004F0050004F0052004900440055005A0049004F004E00
      4500010000000000300000004100520052004F00540054004F00540049004D00
      50004F0052005400490044004100540049005000410047004800450001000000
      0000080000005400490050004F000100000000001E0000005200490044005500
      5A0049004F004E0045005F0050004100530054004F000100000000001E000000
      500045005200430052004500540052004900420050004100530054004F000100
      000000000C00000043004F0044004900430045000100000000001A0000005400
      490050004F005F004D0049005300530049004F004E0045000100000000002000
      0000540041005200490046004600410049004E00440045004E004E0049005400
      4100010000000000180000005400490050004F005F0054004100520049004600
      460041000100000000002200000043004F00440056004F004300450050004100
      470048004500530055005000480048000100000000002200000043004F004400
      56004F0043004500500041004700480045005300550050004700470001000000
      00002000000043004F004400520049004D0042004F00520053004F0050004100
      530054004F00010000000000200000004F0052004500520049004D0042004F00
      520053004F0050004100530054004F0001000000000028000000540041005200
      4900460046004100520049004D0042004F00520053004F005000410053005400
      4F00010000000000220000004F0052004500520049004D0042004F0052005300
      4F0050004100530054004F0032000100000000002A0000005400410052004900
      460046004100520049004D0042004F00520053004F0050004100530054004F00
      32000100000000002400000043004F00440056004F0043004500500041004700
      4800450049004E0054004500520041000100000000002600000043004F004400
      56004F0043004500500041004700480045005300550050004800480047004700
      0100000000002400000043004F0044004900430049005F0049004E0044004500
      4E004E004900540041004B004D000100000000001E00000043004F0044004900
      430049005F00520049004D0042004F00520053004900010000000000}
    AfterScroll = Q010AfterScroll
    Left = 36
    Top = 6
    object Q010DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object Q010CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 80
    end
    object Q010TIPO_MISSIONE: TStringField
      FieldName = 'TIPO_MISSIONE'
      Required = True
      Size = 5
    end
    object Q010DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q010OREMINIMEPERINDENNITA: TStringField
      FieldName = 'OREMINIMEPERINDENNITA'
      Size = 5
    end
    object Q010LIMITEORERETRIBUITEINTERE: TStringField
      FieldName = 'LIMITEORERETRIBUITEINTERE'
      Size = 5
    end
    object Q010ARROTONDAMENTOORE: TFloatField
      FieldName = 'ARROTONDAMENTOORE'
    end
    object Q010TIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object Q010PERCRETRIBSUPEROORE: TFloatField
      FieldName = 'PERCRETRIBSUPEROORE'
    end
    object Q010MAXGIORNIRETRMESE: TFloatField
      FieldName = 'MAXGIORNIRETRMESE'
    end
    object Q010PERCRETRIBSUPEROGG: TFloatField
      FieldName = 'PERCRETRIBSUPEROGG'
    end
    object Q010ARROTTARIFFADOPORIDUZIONE: TStringField
      FieldName = 'ARROTTARIFFADOPORIDUZIONE'
      Size = 5
    end
    object Q010ARROTTOTIMPORTIDATIPAGHE: TStringField
      FieldName = 'ARROTTOTIMPORTIDATIPAGHE'
      Size = 5
    end
    object Q010RIDUZIONE_PASTO: TStringField
      FieldName = 'RIDUZIONE_PASTO'
      Required = True
      Size = 1
    end
    object Q010PERCRETRIBPASTO: TFloatField
      FieldName = 'PERCRETRIBPASTO'
    end
    object Q010TARIFFAINDENNITA: TFloatField
      FieldName = 'TARIFFAINDENNITA'
    end
    object Q010TIPO_TARIFFA: TStringField
      FieldName = 'TIPO_TARIFFA'
      Size = 1
    end
    object Q010CODVOCEPAGHEINTERA: TStringField
      FieldName = 'CODVOCEPAGHEINTERA'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPHH: TStringField
      FieldName = 'CODVOCEPAGHESUPHH'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPGG: TStringField
      FieldName = 'CODVOCEPAGHESUPGG'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPHHGG: TStringField
      FieldName = 'CODVOCEPAGHESUPHHGG'
      Size = 6
    end
    object Q010ORERIMBORSOPASTO: TStringField
      FieldName = 'ORERIMBORSOPASTO'
      Size = 5
    end
    object Q010TARIFFARIMBORSOPASTO: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO'
    end
    object Q010ORERIMBORSOPASTO2: TStringField
      FieldName = 'ORERIMBORSOPASTO2'
      Size = 5
    end
    object Q010TARIFFARIMBORSOPASTO2: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO2'
    end
    object Q010CODICI_INDENNITAKM: TStringField
      FieldName = 'CODICI_INDENNITAKM'
      Size = 500
    end
    object Q010CODICI_RIMBORSI: TStringField
      FieldName = 'CODICI_RIMBORSI'
      Size = 500
    end
    object Q010IND_DA_TAB_TARIFFE: TStringField
      FieldName = 'IND_DA_TAB_TARIFFE'
      Size = 1
    end
    object Q010CAUSALE_MISSIONE: TStringField
      FieldName = 'CAUSALE_MISSIONE'
      Size = 5
    end
    object Q010GIUSTIF_HHMAX: TStringField
      FieldName = 'GIUSTIF_HHMAX'
      Size = 5
    end
    object Q010GIUSTIF_COPRE_DEBITOGG: TStringField
      FieldName = 'GIUSTIF_COPRE_DEBITOGG'
      Size = 1
    end
    object Q010TIPO_RIMBORSOPASTO: TStringField
      FieldName = 'TIPO_RIMBORSOPASTO'
      Size = 1
    end
  end
  object countM050: TOracleQuery
    SQL.Strings = (
      
        'SELECT T.PROGRESSIVO, T.MESESCARICO, T.MESECOMPETENZA, T.DATADA,' +
        ' T.ORADA, T.CODICERIMBORSOSPESE,'
      
        '       T.IMPORTORIMBORSOSPESE, T.IMPORTOCOSTORIMBORSO, T.IMPORTO' +
        'INDENNITASUPPLEMENTARE, T.COD_VALUTA_EST,'
      #9'T.IMPRIMB_VALEST, T.COSTORIMB_VALEST, T.ROWID '
      '  FROM M050_RIMBORSI T'
      ' WHERE T.PROGRESSIVO = :PROG'
      '   AND T.MESESCARICO = :MSCARICO'
      '   AND T.MESECOMPETENZA = :MCOMPETENZA'
      '   AND T.DATADA = :DDA'
      '   AND T.ORADA = :ODA'
      '   AND T.CODICERIMBORSOSPESE = :CODICE'
      ' ORDER BY CODICERIMBORSOSPESE')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470008000000000000000000
      0000120000003A004D005300430041005200490043004F000C00000000000000
      00000000180000003A004D0043004F004D0050004500540045004E005A004100
      0C0000000000000000000000080000003A004400440041000C00000000000000
      00000000080000003A004F00440041000500000000000000000000000E000000
      3A0043004F004400490043004500050000000000000000000000}
    Left = 320
    Top = 64
  end
  object selCountM050: TOracleQuery
    SQL.Strings = (
      'SELECT count(*)'
      '  FROM M050_RIMBORSI M050'
      ' WHERE M050.PROGRESSIVO = :PROG'
      '   AND M050.MESESCARICO = :MSCARICO'
      '   AND M050.MESECOMPETENZA = :MCOMPETENZA'
      '   AND M050.DATADA = :DDA'
      '   AND M050.ORADA = :ODA'
      '   AND M050.COD_VALUTA_EST IS NOT NULL')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00500052004F00470003000000000000000000
      0000120000003A004D005300430041005200490043004F000C00000000000000
      00000000180000003A004D0043004F004D0050004500540045004E005A004100
      0C0000000000000000000000080000003A004400440041000C00000000000000
      00000000080000003A004F0044004100050000000000000000000000}
    Left = 432
    Top = 64
  end
  object SelP030: TOracleDataSet
    SQL.Strings = (
      'SELECT P030.COD_VALUTA, P030.DESCRIZIONE,P030.ABBREVIAZIONE'
      '  FROM P030_VALUTE P030'
      ' WHERE P030.DECORRENZA=(SELECT MAX(DECORRENZA)'
      '                          FROM P030_VALUTE'
      '                         WHERE COD_VALUTA=P030.COD_VALUTA'
      '                           AND DECORRENZA <= :DATADA)')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A004400410054004100440041000C0000000700
      00008BC70C1F01010100000000}
    Left = 434
    Top = 5
  end
  object DSelP030: TDataSource
    DataSet = SelP030
    Left = 386
    Top = 5
  end
  object DP050: TDataSource
    DataSet = P050
    Left = 192
    Top = 64
  end
  object P050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.COD_ARROTONDAMENTO, T.COD_VALUTA, T.DECORRENZA, T.DESCR' +
        'IZIONE, T.VALORE, T.TIPO'
      'FROM P050_ARROTONDAMENTI T'
      'WHERE COD_ARROTONDAMENTO = :CODICE '
      '  AND T.DECORRENZA = (SELECT MAX(A.DECORRENZA) '
      '                        FROM P050_ARROTONDAMENTI A '
      '                       WHERE A.DECORRENZA <= :DECORRENZA '
      
        '                         AND A.COD_ARROTONDAMENTO = T.COD_ARROTO' +
        'NDAMENTO)')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C00000000000000000000000E0000003A0043004F004400490043004500
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000}
    Left = 224
    Top = 64
    object P050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object P050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object P050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object P050DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object P050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object P050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object selP032: TOracleDataSet
    SQL.Strings = (
      'SELECT P032.*'
      '  FROM P032_CAMBI P032'
      ' WHERE P032.COD_VALUTA1=:VALEST'
      '   AND P032.COD_VALUTA2=(SELECT COD_VALUTA_BASE'
      '                           FROM P150_SETUP'
      
        '                          WHERE DECORRENZA=(SELECT MAX(DECORRENZ' +
        'A)'
      '                                              FROM P150_SETUP'
      
        '                                             WHERE DECORRENZA <=' +
        ' :DATAMISS))'
      '   AND P032.DECORRENZA=(SELECT MAX(DECORRENZA)'
      '                          FROM P032_CAMBI'
      '                         WHERE DECORRENZA <= :DATAMISS'
      '                           AND COD_VALUTA1=P032.COD_VALUTA1'
      '                           AND COD_VALUTA2=P032.COD_VALUTA2)')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00560041004C00450053005400050000000000
      000000000000120000003A0044004100540041004D004900530053000C000000
      0000000000000000}
    Left = 492
    Top = 4
  end
  object DSuperoGiorni: TDataSource
    DataSet = QSuperoGiorni
    Left = 192
    Top = 256
  end
  object QSuperoGiorni: TOracleDataSet
    SQL.Strings = (
      'select sum(t.totalegg) as GIORNI'
      'from m040_missioni t'
      'where t.progressivo = :PROGRESSIVO'
      
        'and to_date('#39'01'#39'||TO_CHAR(t.datada,'#39'MMYYYY'#39'),'#39'DDMMYYYY'#39') = :DATA' +
        'DA'
      'and '
      '((:STATO = '#39'I'#39') OR '
      ' (:STATO = '#39'U'#39' and t.rowid <> :IDRIGA))')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0049004400520049004700
      41000500000000000000000000000C0000003A0053005400410054004F000500
      000000000000000000000E0000003A004400410054004100440041000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {05000000010000000C000000470049004F0052004E004900010000000000}
    Left = 280
    Top = 256
    object QSuperoGiorniGIORNI: TFloatField
      FieldName = 'GIORNI'
    end
  end
  object DM065: TDataSource
    DataSet = selM065
    Left = 514
    Top = 127
  end
  object selM065: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      '  FROM M065_TARIFFE_INDENNITA M065'
      ' WHERE M065.CODICE = (SELECT T430.:DATOLIB'
      '                        FROM T430_STORICO T430'
      '                       WHERE T430.PROGRESSIVO = :PROGRESSIVO'
      
        '                         AND :DATA BETWEEN T430.DATADECORRENZA A' +
        'ND T430.DATAFINE)'
      '   AND :DATA BETWEEN M065.DECORRENZA AND M065.DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A004400410054004F004C004900420001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 562
    Top = 127
  end
  object DM066: TDataSource
    DataSet = selM066
    Left = 16
    Top = 184
  end
  object selM066: TOracleDataSet
    SQL.Strings = (
      'SELECT M066.*'
      '  FROM M066_RIDUZIONI M066'
      ' WHERE M066.CODICE = (SELECT T430.:DATOLIB'
      '                        FROM T430_STORICO T430'
      '                       WHERE T430.DATADECORRENZA ='
      '                             (SELECT MAX(DATADECORRENZA)'
      '                                FROM T430_STORICO'
      
        '                               WHERE PROGRESSIVO = T430.PROGRESS' +
        'IVO'
      '                                 AND DATADECORRENZA <= :DATA)'
      '                         AND T430.PROGRESSIVO = :PROGRESSIVO)'
      '   AND M066.COD_TARIFFA = :COD_TARIFF'
      '   AND M066.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                            FROM M066_RIDUZIONI'
      '                           WHERE DECORRENZA <= :DATA'
      '                             AND COD_TARIFFA=M066.COD_TARIFFA'
      '                             AND CODICE = M066.CODICE)')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A004400410054004F004C004900420001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0043004F0044005F005400
      410052004900460046000500000000000000000000000A0000003A0044004100
      540041000C0000000000000000000000}
    Left = 64
    Top = 184
  end
  object P050Est: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.COD_ARROTONDAMENTO, T.COD_VALUTA, T.DECORRENZA, T.DESCR' +
        'IZIONE, T.VALORE, T.TIPO'
      '  FROM P050_ARROTONDAMENTI T'
      ' WHERE T.COD_VALUTA = :CODICE '
      '   AND T.COD_ARROTONDAMENTO = :CODARR'
      '   AND T.DECORRENZA = (SELECT MAX(A.DECORRENZA) '
      '                         FROM P050_ARROTONDAMENTI A '
      '                        WHERE A.DECORRENZA <= :DECORRENZA'
      
        '                          AND A.COD_ARROTONDAMENTO = T.COD_ARROT' +
        'ONDAMENTO)')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000000E0000003A0043004F0044004100520052000500
      00000000000000000000}
    Left = 272
    Top = 64
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 24
    Top = 256
  end
  object QM021: TOracleDataSet
    SQL.Strings = (
      
        'select m021.codice, m021.descrizione, m021.decorrenza, m021.impo' +
        'rto, m021.codvocepaghe, m021.arrotondamento'
      'from m021_tipiindennitakm m021'
      
        'where m021.decorrenza=(select max(decorrenza) from m021_tipiinde' +
        'nnitakm where decorrenza <= :decorrenza and codice = m021.codice' +
        ')'
      ':FILTRO'
      ' order by m021.codice')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C00000000000000000000000E0000003A00460049004C00540052004F00
      010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000000E000000
      49004D0050004F00520054004F000100000000001C0000004100520052004F00
      54004F004E00440041004D0045004E0054004F00010000000000180000004300
      4F00440056004F004300450050004100470048004500010000000000}
    Left = 290
    Top = 5
    object QM021CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object QM021DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object QM021DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object QM021IMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object QM021CODVOCEPAGHE: TStringField
      FieldName = 'CODVOCEPAGHE'
      Size = 6
    end
    object QM021ARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Size = 5
    end
  end
  object QM052: TOracleDataSet
    SQL.Strings = (
      'select m052.*, '
      
        '       decode(m052.stato,'#39'N'#39','#39'Da verificare'#39','#39'Verificato'#39') D_STA' +
        'TO,'
      '       m052.rowid'
      'from   m052_indennitakm m052'
      'where  m052.progressivo = :PROG'
      'and    m052.MESESCARICO = :MSCARICO'
      'and    m052.MESECOMPETENZA = :MCOMPETENZA'
      'and    m052.DATADA = :DDA'
      'and    m052.ORADA= :ODA'
      'order by m052.CODICEINDENNITAKM')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00500052004F00470003000000000000000000
      0000120000003A004D005300430041005200490043004F000C00000000000000
      00000000180000003A004D0043004F004D0050004500540045004E005A004100
      0C0000000000000000000000080000003A004400440041000C00000000000000
      00000000080000003A004F0044004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000002200000043004F00
      440049004300450049004E00440045004E004E004900540041004B004D000100
      00000000140000004B004D0050004500520043004F0052005300490001000000
      00002000000049004D0050004F00520054004F0049004E00440045004E004E00
      490054004100010000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = QM052BeforePost
    AfterPost = QM052AfterPost
    BeforeDelete = QM052BeforeDelete
    AfterDelete = QM052AfterDelete
    OnNewRecord = QM052NewRecord
    Left = 208
    Top = 128
    object QM052CODICEINDENNITAKM: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICEINDENNITAKM'
      Required = True
      Size = 5
    end
    object QM052descrizione: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICEINDENNITAKM'
      Size = 40
      Lookup = True
    end
    object QM052importounitario: TFloatField
      DisplayLabel = 'Importo Km'
      FieldKind = fkLookup
      FieldName = 'importounitario'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'IMPORTO'
      KeyFields = 'CODICEINDENNITAKM'
      Lookup = True
    end
    object QM052KMPERCORSI: TFloatField
      DisplayLabel = 'Km percorsi'
      FieldName = 'KMPERCORSI'
    end
    object QM052IMPORTOINDENNITA: TFloatField
      DisplayLabel = 'Tot. indennit'#224
      FieldName = 'IMPORTOINDENNITA'
      ReadOnly = True
    end
    object QM052PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object QM052MESESCARICO: TDateTimeField
      FieldName = 'MESESCARICO'
      Required = True
      Visible = False
    end
    object QM052MESECOMPETENZA: TDateTimeField
      FieldName = 'MESECOMPETENZA'
      Required = True
      Visible = False
    end
    object QM052DATADA: TDateTimeField
      FieldName = 'DATADA'
      Required = True
      Visible = False
    end
    object QM052ORADA: TStringField
      FieldName = 'ORADA'
      Required = True
      Visible = False
      Size = 5
    end
    object QM052codice: TStringField
      FieldKind = fkLookup
      FieldName = 'codice'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CODICEINDENNITAKM'
      Visible = False
      Size = 5
      Lookup = True
    end
    object QM052decorrenza: TDateField
      FieldKind = fkLookup
      FieldName = 'decorrenza'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DECORRENZA'
      KeyFields = 'CODICEINDENNITAKM'
      Visible = False
      Lookup = True
    end
    object QM052STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object QM052D_STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'D_STATO'
      ReadOnly = True
    end
    object QM052NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 50
      FieldName = 'NOTE'
      ReadOnly = True
      Size = 2000
    end
    object QM052KMPERCORSI_ORIGINALI: TFloatField
      DisplayLabel = 'Km percorsi orig.'
      FieldName = 'KMPERCORSI_ORIGINALI'
      ReadOnly = True
    end
    object QM052ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
      Visible = False
    end
  end
  object D052: TDataSource
    DataSet = QM052
    Left = 168
    Top = 128
  end
  object selM043: TOracleDataSet
    SQL.Strings = (
      'SELECT M043.*, M043.ROWID '
      'FROM   M043_DETTAGLIOGG M043'
      'WHERE  M043.ID = :ID'
      ':ORDERBY')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000400000000000000000000001000
      00003A004F00520044004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000900000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000A0000004F00520041004400410001000000
      00002600000043004F004400490043004500520049004D0042004F0052005300
      4F00530050004500530045000100000000002800000049004D0050004F005200
      54004F00520049004D0042004F00520053004F00530050004500530045000100
      000000003A00000049004D0050004F00520054004F0049004E00440045004E00
      4E0049005400410053005500500050004C0045004D0045004E00540041005200
      45000100000000000C0000004400410054004100440041000100000000002800
      000049004D0050004F00520054004F0043004F00530054004F00520049004D00
      42004F00520053004F00010000000000}
    BeforePost = selM043BeforePost
    OnNewRecord = selM043NewRecord
    Left = 54
    Top = 64
    object selM043ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selM043TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 1
      FieldName = 'TIPO'
      Size = 1
    end
    object selM043DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      OnValidate = selM043DATAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object selM043DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      OnValidate = selM043DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selM043ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      OnValidate = selM043DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selM043NOTE: TStringField
      DisplayLabel = 'Note Attivit'#224
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  object dsrM043: TDataSource
    DataSet = selM043
    Left = 8
    Top = 63
  end
  object QCommessa: TOracleDataSet
    Optimize = False
    Left = 80
    Top = 256
  end
  object QSede: TOracleDataSet
    Optimize = False
    Left = 136
    Top = 256
  end
  object SelM041: TOracleDataSet
    SQL.Strings = (
      'select * from'
      
        '(select tipo1, localita1, t480A.citta as partenza, tipo2, locali' +
        'ta2, t480B.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480A, t480_comuni t480B'
      
        'where tipo1='#39'C'#39' and tipo2='#39'C'#39' and localita1=t480A.codice and loc' +
        'alita2=t480B.codice'
      'union all'
      
        'select tipo1, localita1, m042A.descrizione as partenza, tipo2, l' +
        'ocalita2, m042B.descrizione as destinazione, chilometri '
      
        ' from m041_distanze m041, m042_localita m042A, m042_localita m04' +
        '2B'
      
        'where tipo1='#39'P'#39' and tipo2='#39'P'#39' and localita1=m042A.codice and loc' +
        'alita2=m042B.codice'
      'union all'
      
        'select tipo1, localita1, t480.citta as partenza, tipo2, localita' +
        '2, m042.descrizione as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo1='#39'C'#39' and tipo2='#39'P'#39' and localita1=t480.codice and loca' +
        'lita2=m042.codice'
      'union all'
      
        'select tipo1, localita1, m042.descrizione as partenza, tipo2, lo' +
        'calita2, t480.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo1='#39'P'#39' and tipo2='#39'C'#39' and localita1=m042.codice and loca' +
        'lita2=t480.codice'
      'union all'
      
        'select tipo2, localita2, t480A.citta as partenza, tipo1, localit' +
        'a1, t480B.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480A, t480_comuni t480B'
      
        'where tipo2='#39'C'#39' and tipo1='#39'C'#39' and localita2=t480A.codice and loc' +
        'alita1=t480B.codice'
      'union all'
      
        'select tipo2, localita2, m042A.descrizione as partenza, tipo1, l' +
        'ocalita1, m042B.descrizione as destinazione, chilometri '
      
        ' from m041_distanze m041, m042_localita m042A, m042_localita m04' +
        '2B'
      
        'where tipo2='#39'P'#39' and tipo1='#39'P'#39' and localita2=m042A.codice and loc' +
        'alita1=m042B.codice'
      'union all'
      
        'select tipo2, localita2, t480.citta as partenza, tipo1, localita' +
        '1, m042.descrizione as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo2='#39'C'#39' and tipo1='#39'P'#39' and localita2=t480.codice and loca' +
        'lita1=m042.codice'
      'union all'
      
        'select tipo2, localita2, m042.descrizione as partenza, tipo1, lo' +
        'calita1, t480.citta as destinazione, chilometri '
      ' from m041_distanze m041, t480_comuni t480, m042_localita m042'
      
        'where tipo2='#39'P'#39' and tipo1='#39'C'#39' and localita2=m042.codice and loca' +
        'lita1=t480.codice'
      ')'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000A0000005400490050004F00310001000000000012000000
      4C004F00430041004C0049005400410031000100000000001000000050004100
      5200540045004E005A0041000100000000000A0000005400490050004F003200
      010000000000120000004C004F00430041004C00490054004100320001000000
      000018000000440045005300540049004E0041005A0049004F004E0045000100
      00000000140000004300480049004C004F004D00450054005200490001000000
      0000}
    Left = 588
    Top = 4
    object SelM041PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 25
      FieldName = 'PARTENZA'
      Size = 40
    end
    object SelM041DESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 25
      FieldName = 'DESTINAZIONE'
      Size = 40
    end
    object SelM041CHILOMETRI: TFloatField
      DisplayLabel = 'Km'
      DisplayWidth = 5
      FieldName = 'CHILOMETRI'
    end
    object SelM041TIPO1: TStringField
      DisplayLabel = 'Tipo Part.'
      FieldName = 'TIPO1'
      Size = 1
    end
    object SelM041LOCALITA1: TStringField
      DisplayLabel = 'Cod. Partenza'
      FieldName = 'LOCALITA1'
      Size = 6
    end
    object SelM041TIPO2: TStringField
      DisplayLabel = 'Tipo Dest.'
      FieldName = 'TIPO2'
      Size = 1
    end
    object SelM041LOCALITA2: TStringField
      DisplayLabel = 'Cod. Destinazione'
      FieldName = 'LOCALITA2'
      Size = 6
    end
  end
  object DSelM041: TDataSource
    DataSet = SelM041
    Left = 540
    Top = 4
  end
  object SelM060: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.*, M060.ROWID'
      '  FROM M060_ANTICIPI M060'
      ' WHERE M060.STATO='#39'S'#39
      '   AND M060.PROGRESSIVO=:PROGRESSIVO'
      '   :FILTRO'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    Left = 359
    Top = 126
  end
  object InsM050: TOracleQuery
    Optimize = False
    Left = 496
    Top = 64
  end
  object SelM020: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE'
      'FROM M020_TIPIRIMBORSI M020'
      'WHERE M020.CODICE = :COD_RIMB')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A0043004F0044005F00520049004D0042000500
      00000000000000000000}
    Left = 243
    Top = 7
  end
  object GrpM060: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M060.NROSOSP,M060.DATA_MISSIONE,SUM(M060.IMPORTO) AS IMPO' +
        'RTO'
      '  FROM M060_ANTICIPI M060'
      ' WHERE M060.STATO = '#39'S'#39
      '   AND M060.PROGRESSIVO = :PROGRESSIVO'
      ' GROUP BY M060.NROSOSP,M060.DATA_MISSIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 462
    Top = 125
  end
  object selM021A: TOracleDataSet
    SQL.Strings = (
      
        'select m021.codice, m021.descrizione, m021.decorrenza, m021.impo' +
        'rto, m021.codvocepaghe, m021.arrotondamento'
      'from m021_tipiindennitakm m021'
      'where m021.codice=:codice'
      
        '  and m021.decorrenza = (select max(decorrenza) from m021_tipiin' +
        'dennitakm where codice=m021.codice and decorrenza <= :decorrenza' +
        ')')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002800000049004E00440045004E004E004900540041004B004D00
      4E0045004C0043004F004D0055004E0045000100000000002C00000049004E00
      440045004E004E004900540041004B004D00460055004F005200490043004F00
      4D0055004E0045000100000000002E0000004100520052004F00540049004D00
      50004F005200540049004B004D004E0045004C0043004F004D0055004E004500
      010000000000320000004100520052004F00540049004D0050004F0052005400
      49004B004D00460055004F005200490043004F004D0055004E00450001000000
      0000}
    Left = 330
    Top = 5
  end
  object UpdM060: TOracleQuery
    SQL.Strings = (
      'UPDATE M060_ANTICIPI M060 '
      '   SET STATO='#39'S'#39
      ' WHERE M060.ID_MISSIONE = :ID_MISSIONE'
      '   AND M060.STATO<>'#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00490044005F004D0049005300530049004F00
      4E004500030000000000000000000000}
    Left = 407
    Top = 126
  end
  object SelT195: TOracleDataSet
    SQL.Strings = (
      'SELECT ADD_MONTHS(MAX(DATARIF),1) AS DATARIF'
      'FROM T195_VOCIVARIABILI'
      
        'WHERE COD_INTERNO IN ('#39'400'#39','#39'402'#39','#39'404'#39','#39'406'#39','#39'408'#39','#39'424'#39','#39'426'#39',' +
        #39'428'#39')'
      '')
    Optimize = False
    Left = 119
    Top = 184
  end
  object SelM052: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M052.PROGRESSIVO, M052.MESESCARICO, M052.MESECOMPETENZA, ' +
        'M052.DATADA, M052.ORADA,'
      
        '       M052.CODICEINDENNITAKM, M052.KMPERCORSI, M052.IMPORTOINDE' +
        'NNITA,'
      '       M040.DATAA'
      'FROM M052_INDENNITAKM M052, M040_MISSIONI M040'
      'WHERE M052.PROGRESSIVO=M040.PROGRESSIVO'
      '  AND M052.MESESCARICO=M040.MESESCARICO'
      '  AND M052.MESECOMPETENZA=M040.MESECOMPETENZA'
      '  AND M052.DATADA=M040.DATADA'
      '  AND M052.ORADA=M040.ORADA'
      '  AND M040.MESESCARICO BETWEEN :DATADA AND :DATAA '
      
        '  AND M052.PROGRESSIVO IN (SELECT T030.PROGRESSIVO FROM :C700SEL' +
        'ANAGRAFE)'
      'ORDER BY M052.CODICEINDENNITAKM, M052.DATADA')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000200000003A004300370030003000530045004C0041004E00410047005200
      410046004500010000000000000000000000}
    Filtered = True
    Left = 258
    Top = 127
  end
  object UM052: TOracleQuery
    SQL.Strings = (
      'update m052_indennitakm'
      'set IMPORTOINDENNITA = :IMPORTOINDENNITA'
      'where progressivo=:progressivo '
      '  and mesescarico=:mesescarico'
      '  and mesecompetenza=:mesecompetenza'
      '  and datada=:datada'
      '  and orada=:orada '
      '  and codiceindennitakm=:codiceindennitakm')
    Optimize = False
    Variables.Data = {
      0400000007000000220000003A0049004D0050004F00520054004F0049004E00
      440045004E004E00490054004100040000000000000000000000180000003A00
      500052004F0047005200450053005300490056004F0003000000000000000000
      0000180000003A004D004500530045005300430041005200490043004F000C00
      000000000000000000001E0000003A004D0045005300450043004F004D005000
      4500540045004E005A0041000C00000000000000000000000E0000003A004400
      410054004100440041000C00000000000000000000000C0000003A004F005200
      410044004100050000000000000000000000240000003A0043004F0044004900
      4300450049004E00440045004E004E004900540041004B004D00050000000000
      000000000000}
    Left = 310
    Top = 127
  end
  object USR_M050P_CARICA_GIUST_DAITER: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'wCODE varchar2(500);'
      'wProgGiustBloc integer;'
      'begin'
      
        '  -- verifica l'#39'esistenza della procedure personalizzata per il ' +
        'caricamento dei giustificativi'
      '  select count(*)'
      '  into   :CONTA_PROC'
      '  from   user_procedures'
      '  where  upper(object_name) = '#39'USR_M050P_CARICA_GIUST_DAITER'#39';'
      
        '  -- se la procedure esiste, la esegue ignorando eventuali eccez' +
        'ioni sollevate'
      '  if :CONTA_PROC > 0 and :AGGIORNA = '#39'S'#39' then'
      '    begin'
      '      wCODE:='#39'BEGIN USR_M050P_CARICA_GIUST_DAITER(:ID); END;'#39';'
      '      execute immediate wCODE using in out :ID;'
      '    exception'
      '      when others then'
      '        :AGGIORNA:='#39'E'#39';'
      '    end;'
      '    select max(m140.progressivo) into wProgGiustBloc'
      
        '      from t180_datibloccati t180, m140_richieste_missioni m140 ' +
        'where t180.riepilogo = '#39'T040'#39' and m140.datada between t180.dal a' +
        'nd last_day(t180.al)'
      '      and m140.id = :ID and m140.progressivo = t180.progressivo;'
      '    if wProgGiustBloc > 0 then'
      '      :AGGIORNA:='#39'E'#39';'
      '    end if;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001200
      00003A0041004700470049004F0052004E004100050000000000000000000000
      160000003A0043004F004E00540041005F00500052004F004300030000000400
      00000100000000000000}
    Left = 485
    Top = 302
  end
  object updM140Riapri: TOracleQuery
    SQL.Strings = (
      'update m140_richieste_missioni'
      'set    missione_riaperta = :MISSIONE_RIAPERTA'
      'where  id = :ID')
    Optimize = False
    Variables.Data = {
      0400000002000000240000003A004D0049005300530049004F004E0045005F00
      5200490041005000450052005400410005000000000000000000000006000000
      3A0049004400030000000000000000000000}
    Left = 24
    Top = 320
  end
  object selM141: TOracleDataSet
    SQL.Strings = (
      'select m141.id,'
      '       m141.ord,'
      '       m141.localita,'
      '       m141.ind_km,'
      '       decode(t480.codice,'
      '              null,decode(m042.codice,'
      '                          null,null,'
      '                          '#39'P'#39'),'
      '              '#39'C'#39') tipo_localita,'
      
        '       nvl(t480.citta,nvl(m042.descrizione,m141.localita)) d_loc' +
        'alita,'
      '       t480.codice c_cod_comune,'
      '       rownum numero_riga'
      'from   m141_percorso_missione m141,'
      '       m042_localita m042,'
      '       t480_comuni t480'
      'where  m141.id = :ID'
      'and    m042.codice(+) = m141.localita'
      'and    t480.codice(+) = m141.localita'
      'order by m141.ord'
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    Left = 391
    Top = 360
    object selM141ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selM141ORD: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORD'
      Visible = False
    end
    object selM141D_TAPPA: TStringField
      DisplayLabel = 'Tappa'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'D_TAPPA'
      Size = 15
      Calculated = True
    end
    object selM141D_LOCALITA: TStringField
      DisplayLabel = 'Localit'#224
      DisplayWidth = 40
      FieldName = 'D_LOCALITA'
      Size = 60
    end
    object selM141IND_KM: TStringField
      DisplayLabel = 'Ind. km'
      FieldName = 'IND_KM'
      Visible = False
      Size = 1
    end
    object selM141TIPO_LOCALITA: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_LOCALITA'
      Visible = False
      Size = 1
    end
    object selM141LOCALITA: TStringField
      DisplayLabel = 'Localit'#224
      FieldName = 'LOCALITA'
      Visible = False
      Size = 200
    end
    object selM141C_COD_COMUNE: TStringField
      FieldName = 'C_COD_COMUNE'
      Visible = False
      Size = 6
    end
    object selM141NUMERO_RIGA2: TFloatField
      FieldName = 'NUMERO_RIGA'
      Visible = False
    end
  end
  object dsrM141: TDataSource
    DataSet = selM141
    Left = 440
    Top = 360
  end
  object cdsM141: TClientDataSet
    PersistDataPacket.Data = {
      860000009619E0BD010000001800000005000000000003000000860005544150
      50410100490000000100055749445448020002000F00084C4F43414C49544101
      0049000000010005574944544802000200C80006494E445F4B4D010049000000
      0100055749445448020002000100024B4D0400010000000000064B4D5F494E44
      04000100000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TAPPA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LOCALITA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'IND_KM'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'KM'
        DataType = ftInteger
      end
      item
        Name = 'KM_IND'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsM141CalcFields
    Left = 496
    Top = 360
    object cdsM141TAPPA: TStringField
      DisplayLabel = 'Tappa'
      DisplayWidth = 12
      FieldName = 'TAPPA'
      Size = 15
    end
    object cdsM141LOCALITA: TStringField
      DisplayLabel = 'Localit'#224
      DisplayWidth = 40
      FieldName = 'LOCALITA'
      Size = 200
    end
    object cdsM141IND_KM: TStringField
      FieldName = 'IND_KM'
      Visible = False
      Size = 1
    end
    object cdsM141KM: TIntegerField
      FieldName = 'KM'
      Visible = False
    end
    object cdsM141KM_IND: TIntegerField
      FieldName = 'KM_IND'
      Visible = False
    end
    object cdsM141D_KM: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'KM'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'D_KM'
      Size = 15
      Calculated = True
    end
    object cdsM141D_KM_IND: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'KM ind.'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'D_KM_IND'
      Size = 15
      Calculated = True
    end
  end
  object selLogRiaperture: TOracleDataSet
    SQL.Strings = (
      'select I000a.ID ID_LOG,'
      '       I000a.VALORE_NEW ID_MISSIONE,'
      '       I000b.DATA'
      'from VI000_I001_LOG I000a, VI000_I001_LOG I000b'
      'where '
      
        '  I000a.MASCHERA = '#39'A100'#39' and I000a.OPERAZIONE = '#39'M'#39' and I000a.T' +
        'ABELLA = '#39'M140_RICHIESTE_MISSIONI'#39' and'
      
        '  I000a.COLONNA = '#39'ID'#39' and I000a.VALORE_OLD is NULL and I000a.VA' +
        'LORE_NEW = :ID_MISSIONE and'
      '  I000a.ID = I000b.ID and'
      '  I000b.COLONNA = '#39'MISSIONE_RIAPERTA'#39' and'
      '  I000b.VALORE_OLD = '#39'N'#39' and'
      '  I000b.VALORE_NEW = '#39'S'#39
      'order by I000b.DATA desc')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00490044005F004D0049005300530049004F00
      4E004500050000000000000000000000}
    Left = 144
    Top = 320
    object selLogRiapertureID_LOG: TFloatField
      FieldName = 'ID_LOG'
      Visible = False
    end
    object selLogRiapertureID_MISSIONE: TStringField
      FieldName = 'ID_MISSIONE'
      Visible = False
      Size = 0
    end
    object selLogRiapertureDATA: TDateTimeField
      DisplayLabel = 'Date di riapertura'
      FieldName = 'DATA'
    end
  end
  object dsrLogRiaperture: TDataSource
    DataSet = selLogRiaperture
    Left = 240
    Top = 320
  end
  object selProtocolloUnique: TOracleQuery
    SQL.Strings = (
      'select '#39'M040'#39' TABELLA '
      'from   M040_MISSIONI '
      'where  ID_MISSIONE <> nvl(:ID,0)'
      'and    PROTOCOLLO = :PROTOCOLLO'
      'union all'
      'select '#39'M140'#39
      'from   M140_RICHIESTE_MISSIONI'
      'where  ID <> nvl(:ID,0)'
      'and    PROTOCOLLO = :PROTOCOLLO')
    ReadBuffer = 3
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001600
      00003A00500052004F0054004F0043004F004C004C004F000500000000000000
      00000000}
    Left = 40
    Top = 372
  end
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select T960.ID,'
      '       T960.NOME_FILE, '
      '       T960.EXT_FILE, '
      '       T960.DIMENSIONE, '
      '       T960.NOTE, '
      '       T960.NOME_UTENTE, '
      '       T960.UTENTE,'
      
        '       I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) WEB_NOMINATIV' +
        'O'
      'from   T960_DOCUMENTI_INFO T960,'
      '       T853_DOC_ALLEGATI T853,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      'where  T960.ID = T853.ID_T960'
      'and    T853.ID = :ID_MISSIONE'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'order by T960.NOME_FILE, T960.EXT_FILE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00490044005F004D0049005300530049004F00
      4E004500030000000000000000000000100000003A0041005A00490045004E00
      44004100050000000000000000000000}
    ReadOnly = True
    OnCalcFields = selT960CalcFields
    Left = 231
    Top = 376
    object selT960ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT960D_NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_NOME_FILE'
      Size = 250
      Calculated = True
    end
    object selT960D_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Calculated = True
    end
    object selT960D_PROPRIETARIO: TStringField
      DisplayLabel = 'Proprietario'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_PROPRIETARIO'
      Size = 150
      Calculated = True
    end
    object selT960NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT960NOME_FILE: TStringField
      FieldName = 'NOME_FILE'
      Visible = False
      Size = 200
    end
    object selT960EXT_FILE: TStringField
      FieldName = 'EXT_FILE'
      Visible = False
    end
    object selT960DIMENSIONE: TFloatField
      FieldName = 'DIMENSIONE'
      Visible = False
    end
    object selT960UTENTE: TStringField
      FieldName = 'UTENTE'
      Visible = False
      Size = 30
    end
    object selT960NOME_UTENTE: TStringField
      FieldName = 'NOME_UTENTE'
      Visible = False
      Size = 30
    end
    object selT960WEB_NOMINATIVO: TStringField
      FieldName = 'WEB_NOMINATIVO'
      Visible = False
      Size = 100
    end
  end
  object dsrT960: TDataSource
    DataSet = selT960
    Left = 280
    Top = 376
  end
  object selCountI095Allegati: TOracleQuery
    SQL.Strings = (
      'select count(*) '
      'from   mondoedp.i095_iter_aut '
      'where  iter = '#39'M140'#39' '
      'and    nvl(condizione_allegati,'#39'N'#39') <> '#39'N'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 168
    Top = 376
  end
end
