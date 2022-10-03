inherited A100FCheckRimborsiMW: TA100FCheckRimborsiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 130
  Width = 607
  object selM040CheckRimb: TOracleDataSet
    SQL.Strings = (
      'select T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, '
      '       T030.MATRICOLA,'
      '       M040.DATADA, '
      '       M040.ORADA, '
      '       M040.DATAA, '
      '       M040.ORAA,'
      '       M040.PARTENZA,'
      '       M040.DESTINAZIONE,'
      '       M041F_GETDESCLOCALITA(M040.PARTENZA) D_PARTENZA,'
      '       M041F_GETDESCLOCALITA(M040.DESTINAZIONE) D_DESTINAZIONE,'
      '       M040.TIPOREGISTRAZIONE,'
      '       M140.FLAG_DESTINAZIONE,'
      
        '       decode(M140.FLAG_DESTINAZIONE,'#39'R'#39','#39'Regione'#39','#39'I'#39','#39'Fuori re' +
        'gione'#39','#39'E'#39','#39'Estero'#39',M140.FLAG_DESTINAZIONE) D_FLAG_DESTINAZIONE,'
      '       M140.FLAG_ISPETTIVA,'
      
        '       decode(M140.FLAG_ISPETTIVA,'#39'S'#39','#39'S'#236#39','#39'N'#39','#39'No'#39') D_FLAG_ISPE' +
        'TTIVA,'
      '       M040.STATO,'
      
        '       decode(M040.STATO,'#39'D'#39','#39'Da liquidare'#39','#39'L'#39','#39'Liquidata'#39','#39'P'#39',' +
        #39'Parzialmente liquidata'#39','#39'S'#39','#39'Sospesa'#39',M040.STATO) D_STATO,'
      
        '       T480_RES.CITTA || '#39' ('#39' || T480_RES.PROVINCIA || '#39')'#39' D_RES' +
        'IDENZA,'
      '       M040.MESESCARICO, '
      '       M040.MESECOMPETENZA, '
      '       M040.TOTALEGG,'
      '       M040.DURATA,'
      '       M040.ID_MISSIONE,'
      '       M040.PROTOCOLLO,'
      '       M040.COMMESSA,'
      '       M040.PROGRESSIVO'
      'from   M040_MISSIONI M040,'
      '       M140_RICHIESTE_MISSIONI M140, '
      '       T480_COMUNI T480_RES,'
      '       T850_ITER_RICHIESTE T850,'
      ':C700SELANAGRAFE'
      'and    T030.PROGRESSIVO = M040.PROGRESSIVO'
      'and    M140.ID(+) = M040.ID_MISSIONE'
      'and    V430.T430COMUNE = T480_RES.CODICE(+)'
      'and    T850.ID = M140.ID'
      'and    T850.ITER = '#39'M140'#39
      'and    T850.TIPO_RICHIESTA <> '#39'A'#39
      ':FILTRO'
      'order by M040.PROGRESSIVO, M040.DATADA desc')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000000E0000003A004600
      49004C00540052004F00010000000000000000000000}
    ReadOnly = True
    AfterOpen = selM040CheckRimbAfterOpen
    AfterScroll = selM040CheckRimbAfterScroll
    AfterRefresh = selM040CheckRimbAfterRefresh
    Left = 48
    Top = 14
    object selM040CheckRimbNOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selM040CheckRimbMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selM040CheckRimbDATADA: TDateTimeField
      DisplayLabel = 'Data da'
      DisplayWidth = 10
      FieldName = 'DATADA'
    end
    object selM040CheckRimbORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      Size = 5
    end
    object selM040CheckRimbDATAA: TDateTimeField
      DisplayLabel = 'Data a'
      DisplayWidth = 10
      FieldName = 'DATAA'
    end
    object selM040CheckRimbORAA: TStringField
      DisplayLabel = 'Ora a'
      FieldName = 'ORAA'
      Size = 5
    end
    object selM040CheckRimbPARTENZA: TStringField
      DisplayLabel = 'Partenza'
      FieldName = 'PARTENZA'
      Visible = False
      Size = 8
    end
    object selM040CheckRimbD_PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 20
      FieldName = 'D_PARTENZA'
      Size = 40
    end
    object selM040CheckRimbDESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 20
      FieldName = 'DESTINAZIONE'
      Visible = False
      Size = 200
    end
    object selM040CheckRimbD_DESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 20
      FieldName = 'D_DESTINAZIONE'
      Size = 40
    end
    object selM040CheckRimbTIPOREGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo trasferta'
      FieldName = 'TIPOREGISTRAZIONE'
      Size = 5
    end
    object selM040CheckRimbFLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Flag destinazione'
      FieldName = 'FLAG_DESTINAZIONE'
      Visible = False
      Size = 1
    end
    object selM040CheckRimbD_FLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Flag destinazione'
      DisplayWidth = 10
      FieldName = 'D_FLAG_DESTINAZIONE'
    end
    object selM040CheckRimbFLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Flag ispettiva'
      FieldName = 'FLAG_ISPETTIVA'
      Visible = False
      Size = 1
    end
    object selM040CheckRimbD_FLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Ispettiva'
      FieldName = 'D_FLAG_ISPETTIVA'
      Size = 2
    end
    object selM040CheckRimbSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selM040CheckRimbD_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 10
      FieldName = 'D_STATO'
    end
    object selM040CheckRimbD_RESIDENZA: TStringField
      DisplayLabel = 'Residenza'
      DisplayWidth = 20
      FieldName = 'D_RESIDENZA'
      Size = 50
    end
    object selM040CheckRimbMESESCARICO: TDateTimeField
      DisplayLabel = 'Mese scarico'
      DisplayWidth = 10
      FieldName = 'MESESCARICO'
    end
    object selM040CheckRimbMESECOMPETENZA: TDateTimeField
      DisplayLabel = 'Mese competenza'
      DisplayWidth = 10
      FieldName = 'MESECOMPETENZA'
    end
    object selM040CheckRimbTOTALEGG: TFloatField
      DisplayLabel = 'Totale gg.'
      FieldName = 'TOTALEGG'
    end
    object selM040CheckRimbDURATA: TStringField
      DisplayLabel = 'Durata'
      FieldName = 'DURATA'
      Size = 7
    end
    object selM040CheckRimbID_MISSIONE: TIntegerField
      DisplayLabel = 'ID Missione'
      FieldName = 'ID_MISSIONE'
    end
    object selM040CheckRimbPROTOCOLLO: TStringField
      DisplayLabel = 'Protocollo'
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object selM040CheckRimbCOMMESSA: TStringField
      DisplayLabel = 'Commessa'
      DisplayWidth = 15
      FieldName = 'COMMESSA'
      Size = 80
    end
    object selM040CheckRimbPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object dsrM040CheckRimb: TDataSource
    DataSet = selM040CheckRimb
    Left = 50
    Top = 70
  end
  object selM170: TOracleDataSet
    SQL.Strings = (
      'select M020.CODICE, '
      '       M020.DESCRIZIONE, '
      '       M170.TARGA'
      'from   M170_RICHIESTE_MEZZI M170, '
      '       M020_TIPIRIMBORSI M020 '
      'where  M170.ID = :ID '
      'and    M170.CODICE = M020.CODICE'
      'order by 2')
    ReadBuffer = 15
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 357
    Top = 14
    object selM170CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 5
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selM170DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM170TARGA: TStringField
      DisplayLabel = 'Targa'
      FieldName = 'TARGA'
      Size = 15
    end
  end
  object dsrM170: TDataSource
    AutoEdit = False
    DataSet = selM170
    Left = 358
    Top = 70
  end
  object selM175: TOracleDataSet
    SQL.Strings = (
      'select M025.CODICE, '
      '       M025.DESCRIZIONE, '
      '       M175.VALORE '
      'from   M175_RICHIESTE_MOTIVAZIONI M175, '
      '       M025_MOTIVAZIONI M025 '
      'where  M175.ID = :ID '
      'and    M175.CODICE = M025.CODICE'
      'order by 2')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 285
    Top = 14
    object selM175CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 5
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selM175DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selM175VALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 25
      FieldName = 'VALORE'
      Size = 2000
    end
  end
  object dsrM175: TDataSource
    AutoEdit = False
    DataSet = selM175
    Left = 287
    Top = 70
  end
  object dsrM051: TDataSource
    DataSet = selM051
    Left = 135
    Top = 70
  end
  object selM051: TOracleDataSet
    SQL.Strings = (
      'select M051.ROWID, '
      '       M051.PROGRESSIVO, '
      '       M051.MESESCARICO,'
      '       M051.MESECOMPETENZA,'
      '       M051.DATADA,'
      '       M051.ORADA,'
      '       M051.CODICERIMBORSOSPESE,'
      '       M051.PROGRIMBORSO,'
      '       M051.DATARIMBORSO,'
      '       M051.IMPORTO,'
      '       M051.TIPORIMBORSO,'
      '       M051.IMPORTO_VALEST,'
      '       M051.STATO,'
      '       M051.NOTE,'
      '       M051.IMPORTO_ORIGINALE,'
      '       M020.DESCRIZIONE'
      'from   M050_RIMBORSI M050,'
      '       M051_DETTAGLIORIMBORSO M051,'
      '       M020_TIPIRIMBORSI M020'
      'where  M050.ID_MISSIONE = :ID'
      'and    M051.PROGRESSIVO = M050.PROGRESSIVO'
      'and    M051.MESESCARICO = M050.MESESCARICO '
      'and    M051.MESECOMPETENZA = M050.MESECOMPETENZA'
      'and    M051.DATADA = M050.DATADA'
      'and    M051.ORADA = M050.ORADA'
      'and    M051.CODICERIMBORSOSPESE = M050.CODICERIMBORSOSPESE'
      'and    M020.CODICE = M051.CODICERIMBORSOSPESE'
      'order by M051.CODICERIMBORSOSPESE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
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
    UpdatingTable = 'M051_DETTAGLIORIMBORSO'
    BeforeInsert = selM051BeforeInsert
    BeforePost = selM051BeforePost
    AfterPost = selM051AfterPost
    BeforeDelete = selM051BeforeDelete
    Left = 136
    Top = 14
    object selM051PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selM051MESESCARICO: TDateTimeField
      DisplayLabel = 'Mese scarico'
      DisplayWidth = 10
      FieldName = 'MESESCARICO'
      ReadOnly = True
      Visible = False
    end
    object selM051MESECOMPETENZA: TDateTimeField
      DisplayLabel = 'Mese competenza'
      DisplayWidth = 10
      FieldName = 'MESECOMPETENZA'
      ReadOnly = True
      Visible = False
    end
    object selM051DATADA: TDateTimeField
      DisplayLabel = 'Data da'
      DisplayWidth = 10
      FieldName = 'DATADA'
      ReadOnly = True
      Visible = False
    end
    object selM051ORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selM051CODICERIMBORSOSPESE: TStringField
      DisplayLabel = 'Codice rimb.'
      FieldName = 'CODICERIMBORSOSPESE'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selM051DESCRIZIONE: TStringField
      DisplayLabel = 'Voce rimborso'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 40
    end
    object selM051PROGRIMBORSO: TFloatField
      DisplayLabel = 'Prog. rimb.'
      FieldName = 'PROGRIMBORSO'
      ReadOnly = True
      Visible = False
    end
    object selM051DATARIMBORSO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data rimb.'
      DisplayWidth = 10
      FieldName = 'DATARIMBORSO'
      ReadOnly = True
    end
    object selM051IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selM051TIPORIMBORSO: TStringField
      DisplayLabel = 'Tipo rimb.'
      FieldName = 'TIPORIMBORSO'
      ReadOnly = True
      Size = 5
    end
    object selM051IMPORTO_VALEST2: TFloatField
      DisplayLabel = 'Importo val. estera'
      FieldName = 'IMPORTO_VALEST'
      ReadOnly = True
    end
    object selM051STATO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selM051D_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'D_STATO'
      LookupDataSet = cdsStato
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'STATO'
      Size = 50
      Lookup = True
    end
    object selM051NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM051IMPORTO_ORIGINALE: TFloatField
      DisplayLabel = 'Importo orig.'
      FieldName = 'IMPORTO_ORIGINALE'
      ReadOnly = True
    end
  end
  object selM052: TOracleDataSet
    SQL.Strings = (
      'select M052.ROWID,'
      '       M052.PROGRESSIVO,'
      '       M052.MESESCARICO,'
      '       M052.MESECOMPETENZA,'
      '       M052.DATADA,'
      '       M052.ORADA,'
      '       M052.CODICEINDENNITAKM,'
      '       M052.KMPERCORSI,'
      '       M052.IMPORTOINDENNITA,'
      '       M052.ID_MISSIONE,'
      '       M052.STATO,'
      '       M052.NOTE,'
      '       M052.KMPERCORSI_ORIGINALI,'
      '       M021.IMPORTO,'
      '       M021.ARROTONDAMENTO,'
      '       M021.DESCRIZIONE'
      'from   M052_INDENNITAKM M052,'
      '       M021_TIPIINDENNITAKM M021'
      'where  M052.ID_MISSIONE = :ID'
      'and    M021.CODICE = M052.CODICEINDENNITAKM'
      
        'and    :DATALAVORO between M021.DECORRENZA and M021.DECORRENZA_F' +
        'INE'
      'order by M052.CODICEINDENNITAKM')
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001600
      00003A0044004100540041004C00410056004F0052004F000C00000000000000
      00000000}
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
    BeforeInsert = selM052BeforeInsert
    BeforePost = selM052BeforePost
    AfterPost = selM052AfterPost
    BeforeDelete = selM052BeforeDelete
    Left = 208
    Top = 14
    object selM052PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selM052MESESCARICO: TDateTimeField
      DisplayLabel = 'Mese scarico'
      DisplayWidth = 10
      FieldName = 'MESESCARICO'
      ReadOnly = True
      Visible = False
    end
    object selM052MESECOMPETENZA: TDateTimeField
      DisplayLabel = 'Mese competenza'
      DisplayWidth = 10
      FieldName = 'MESECOMPETENZA'
      ReadOnly = True
      Visible = False
    end
    object selM052DATADA: TDateTimeField
      DisplayLabel = 'Data da'
      DisplayWidth = 10
      FieldName = 'DATADA'
      ReadOnly = True
      Visible = False
    end
    object selM052ORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selM052CODICEINDENNITAKM: TStringField
      DisplayLabel = 'Cod. ind. km'
      FieldName = 'CODICEINDENNITAKM'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selM052DESCRIZIONE: TStringField
      DisplayLabel = 'Indennit'#224' km'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM052KMPERCORSI: TFloatField
      DisplayLabel = 'Km percorsi'
      FieldName = 'KMPERCORSI'
    end
    object selM052IMPORTOINDENNITA: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTOINDENNITA'
      ReadOnly = True
    end
    object selM052ID_MISSIONE: TIntegerField
      DisplayLabel = 'ID missione'
      FieldName = 'ID_MISSIONE'
      ReadOnly = True
      Visible = False
    end
    object selM052STATO: TStringField
      DisplayLabel = 'Stato (N/V)'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selM052D_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'D_STATO'
      LookupDataSet = cdsStato
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'STATO'
      Size = 50
      Lookup = True
    end
    object selM052NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM052KMPERCORSI_ORIGINALI: TFloatField
      DisplayLabel = 'Km percorsi orig.'
      FieldName = 'KMPERCORSI_ORIGINALI'
      ReadOnly = True
    end
    object selM052IMPORTO: TFloatField
      DisplayLabel = 'Importo orig.'
      FieldName = 'IMPORTO'
      Visible = False
    end
    object selM052ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrot.'
      FieldName = 'ARROTONDAMENTO'
      Visible = False
      Size = 5
    end
  end
  object dsrM052: TDataSource
    DataSet = selM052
    Left = 208
    Top = 70
  end
  object updM050: TOracleQuery
    SQL.Strings = (
      'update M050_RIMBORSI '
      'set    (IMPORTORIMBORSOSPESE, IMPORTOCOSTORIMBORSO) ='
      '         (select sum(M051.IMPORTO),'
      '                 sum(M051.IMPORTO)'
      '          from   M050_RIMBORSI M050,'
      '                 M051_DETTAGLIORIMBORSO M051'
      '          where  M050.ID_MISSIONE = :ID'
      '          and    M050.CODICERIMBORSOSPESE = :CODICERIMBORSOSPESE'
      '          and    M051.PROGRESSIVO = M050.PROGRESSIVO'
      '          and    M051.MESESCARICO = M050.MESESCARICO '
      '          and    M051.MESECOMPETENZA = M050.MESECOMPETENZA'
      '          and    M051.DATADA = M050.DATADA'
      '          and    M051.ORADA = M050.ORADA'
      
        '          and    M051.CODICERIMBORSOSPESE = M050.CODICERIMBORSOS' +
        'PESE)'
      'where ID_MISSIONE = :ID'
      'and   CODICERIMBORSOSPESE = :CODICERIMBORSOSPESE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000002800
      00003A0043004F004400490043004500520049004D0042004F00520053004F00
      53005000450053004500050000000000000000000000}
    Left = 421
    Top = 14
  end
  object selP050: TOracleDataSet
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
    Left = 488
    Top = 16
    object selP050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object selP050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP050DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selP050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object selP050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object cdsStato: TClientDataSet
    PersistDataPacket.Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020001000B4445534352495A49
      4F4E4501004900000001000557494454480200020032000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 16
    object cdsStatoCODICE: TStringField
      FieldName = 'CODICE'
      Size = 1
    end
    object cdsStatoDESCRIZIONE: TStringField
      DisplayWidth = 14
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
end
