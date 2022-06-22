inherited A100FMISSIONIDTM: TA100FMISSIONIDTM
  OldCreateOrder = True
  Height = 203
  Width = 376
  object M040: TOracleDataSet
    SQL.Strings = (
      'SELECT M040.*, M040.ROWID, '
      '       T850.TIPO_RICHIESTA, '
      
        '       DECODE(T850.TIPO_RICHIESTA,'#39'A'#39','#39'RICHIESTA ANNULLATA DAL D' +
        'IPENDENTE'#39','#39#39') D_ANNULLATA,'
      '       M140.ID,'
      '       M140.FLAG_DESTINAZIONE, '
      '       M140.FLAG_ISPETTIVA,'
      '       M140.MISSIONE_RIAPERTA,'
      '       M140.PROTOCOLLO_MANUALE,'
      
        '       DECODE(M140.PROTOCOLLO_MANUALE,'#39'S'#39','#39'Autorizzazione cartac' +
        'ea'#39','#39#39') D_PROTOCOLLO_MANUALE'
      'FROM   M040_MISSIONI M040, '
      '       T850_ITER_RICHIESTE T850, '
      '       M140_RICHIESTE_MISSIONI M140'
      'WHERE  M040.PROGRESSIVO = :PROGRESSIVO'
      'AND    T850.ID (+) = M040.ID_MISSIONE'
      'AND    T850.ITER (+) = '#39'M140'#39
      'AND    M140.ID (+) = M040.ID_MISSIONE'
      'ORDER BY M040.DATADA')
    ReadBuffer = 250
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    SequenceField.Field = 'ID_MISSIONE'
    SequenceField.Sequence = 'T850_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001C00000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000001400000050005200
      4F0054004F0043004F004C004C004F0001000000000022000000540049005000
      4F00520045004700490053005400520041005A0049004F004E00450001000000
      00000A00000044004100540041004100010000000000080000004F0052004100
      41000100000000001000000054004F00540041004C0045004700470001000000
      00000C0000004400550052004100540041000100000000002000000054004100
      5200490046004600410049004E00440049004E00540045005200410001000000
      0000180000004F005200450049004E00440049004E0054004500520041000100
      000000002000000049004D0050004F00520054004F0049004E00440049004E00
      5400450052004100010000000000240000005400410052004900460046004100
      49004E0044005200490044004F0054005400410048000100000000001C000000
      4F005200450049004E0044005200490044004F00540054004100480001000000
      00002400000049004D0050004F00520054004F0049004E004400520049004400
      4F00540054004100480001000000000024000000540041005200490046004600
      410049004E0044005200490044004F0054005400410047000100000000001C00
      00004F005200450049004E0044005200490044004F0054005400410047000100
      000000002400000049004D0050004F00520054004F0049004E00440052004900
      44004F0054005400410047000100000000002600000054004100520049004600
      4600410049004E0044005200490044004F005400540041004800470001000000
      00001E0000004F005200450049004E0044005200490044004F00540054004100
      480047000100000000002600000049004D0050004F00520054004F0049004E00
      44005200490044004F00540054004100480047000100000000001E0000004600
      4C00410047005F004D004F0044004900460049004300410054004F0001000000
      000010000000500041005200540045004E005A00410001000000000018000000
      440045005300540049004E0041005A0049004F004E0045000100000000001A00
      00004E004F00540045005F00520049004D0042004F0052005300490001000000
      00001000000043004F004D004D004500530053004100010000000000}
    OnApplyRecord = M040ApplyRecord
    Filtered = True
    AfterOpen = M040AfterOpen
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = M040AfterScroll
    OnCalcFields = M040CalcFields
    OnFilterRecord = FiltroDizionario
    OnNewRecord = M040NewRecord
    OnPostError = M040PostError
    Left = 16
    Top = 16
    object M040PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object M040MESESCARICO: TDateTimeField
      FieldName = 'MESESCARICO'
      OnGetText = M040MESESCARICOGetText
      OnSetText = M040MESESCARICOSetText
      OnValidate = M040MESESCARICOValidate
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object M040MESECOMPETENZA: TDateTimeField
      FieldName = 'MESECOMPETENZA'
      OnGetText = M040MESESCARICOGetText
      OnSetText = M040MESESCARICOSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object M040DATADA: TDateTimeField
      FieldName = 'DATADA'
      OnChange = M040DATADAChange
      OnValidate = M040DATADAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object M040ORADA: TStringField
      FieldName = 'ORADA'
      OnValidate = M040ORADAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M040TIPOREGISTRAZIONE: TStringField
      FieldName = 'TIPOREGISTRAZIONE'
      Required = True
      OnValidate = M040DATADAValidate
      Size = 5
    end
    object M040PROTOCOLLO: TStringField
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object M040DATAA: TDateTimeField
      FieldName = 'DATAA'
      OnValidate = M040DATAAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object M040ORAA: TStringField
      FieldName = 'ORAA'
      OnValidate = M040ORADAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M040TOTALEGG: TFloatField
      FieldName = 'TOTALEGG'
    end
    object M040DURATA: TStringField
      FieldName = 'DURATA'
      EditMask = '!9990:00;1;_'
      Size = 7
    end
    object M040TARIFFAINDINTERA: TFloatField
      FieldName = 'TARIFFAINDINTERA'
      OnValidate = M040TARIFFAINDINTERAValidate
    end
    object M040OREINDINTERA: TFloatField
      FieldName = 'OREINDINTERA'
      OnValidate = M040TARIFFAINDINTERAValidate
    end
    object M040IMPORTOINDINTERA: TFloatField
      FieldName = 'IMPORTOINDINTERA'
    end
    object M040TARIFFAINDRIDOTTAH: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAH'
      OnValidate = M040TARIFFAINDRIDOTTAHValidate
    end
    object M040OREINDRIDOTTAH: TFloatField
      FieldName = 'OREINDRIDOTTAH'
      OnValidate = M040TARIFFAINDRIDOTTAHValidate
    end
    object M040IMPORTOINDRIDOTTAH: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAH'
    end
    object M040TARIFFAINDRIDOTTAG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAG'
      OnValidate = M040TARIFFAINDRIDOTTAGValidate
    end
    object M040OREINDRIDOTTAG: TFloatField
      FieldName = 'OREINDRIDOTTAG'
      OnValidate = M040TARIFFAINDRIDOTTAGValidate
    end
    object M040IMPORTOINDRIDOTTAG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAG'
    end
    object M040TARIFFAINDRIDOTTAHG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAHG'
      OnValidate = M040TARIFFAINDRIDOTTAHGValidate
    end
    object M040OREINDRIDOTTAHG: TFloatField
      FieldName = 'OREINDRIDOTTAHG'
      OnValidate = M040TARIFFAINDRIDOTTAHGValidate
    end
    object M040IMPORTOINDRIDOTTAHG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAHG'
    end
    object M040FLAG_MODIFICATO: TStringField
      FieldName = 'FLAG_MODIFICATO'
      Size = 1
    end
    object M040TotaleOreIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleOreIndennita'
      Calculated = True
    end
    object M040TotaleImportiIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleImportiIndennita'
      Calculated = True
    end
    object M040TotaleKmIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleKmIndennita'
      Calculated = True
    end
    object M040TotaleImportiKmIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleImportiKmIndennita'
      Calculated = True
    end
    object M040TotaleMissione: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleMissione'
      Calculated = True
    end
    object M040CostoMissione: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CostoMissione'
      Calculated = True
    end
    object M040PARTENZA: TStringField
      FieldName = 'PARTENZA'
      Size = 100
    end
    object M040descpartenza: TStringField
      FieldKind = fkLookup
      FieldName = 'descpartenza'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTENZA'
      Size = 80
      Lookup = True
    end
    object M040DESTINAZIONE: TStringField
      FieldName = 'DESTINAZIONE'
      Size = 100
    end
    object M040NOTE_RIMBORSI: TStringField
      FieldName = 'NOTE_RIMBORSI'
      Size = 240
    end
    object M040desctipomissione: TStringField
      FieldKind = fkLookup
      FieldName = 'desctipomissione'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPOREGISTRAZIONE'
      Size = 40
      Lookup = True
    end
    object M040COMMESSA: TStringField
      FieldName = 'COMMESSA'
      Size = 80
    end
    object M040desccommessa: TStringField
      FieldKind = fkLookup
      FieldName = 'desccommessa'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COMMESSA'
      Size = 80
      Lookup = True
    end
    object M040STATO: TStringField
      FieldName = 'STATO'
    end
    object M040COD_TARIFFA: TStringField
      FieldName = 'COD_TARIFFA'
    end
    object M040COD_RIDUZIONE: TStringField
      FieldName = 'COD_RIDUZIONE'
    end
    object M040desctariffa: TStringField
      FieldKind = fkCalculated
      FieldName = 'desctariffa'
      Size = 80
      Calculated = True
    end
    object M040ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
    end
    object M040TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object M040D_ANNULLATA: TStringField
      FieldName = 'D_ANNULLATA'
      Size = 40
    end
    object M040ID: TFloatField
      FieldName = 'ID'
    end
    object M040FLAG_DESTINAZIONE: TStringField
      FieldName = 'FLAG_DESTINAZIONE'
      ReadOnly = True
      Size = 1
    end
    object M040FLAG_ISPETTIVA: TStringField
      FieldName = 'FLAG_ISPETTIVA'
      ReadOnly = True
      Size = 1
    end
    object M040MISSIONE_RIAPERTA: TStringField
      FieldName = 'MISSIONE_RIAPERTA'
      Size = 1
    end
    object M040PROTOCOLLO_MANUALE: TStringField
      FieldName = 'PROTOCOLLO_MANUALE'
      Size = 1
    end
    object M040D_PROTOCOLLO_MANUALE: TStringField
      FieldName = 'D_PROTOCOLLO_MANUALE'
      Size = 30
    end
  end
  object D050: TDataSource
    OnStateChange = D050StateChange
    OnDataChange = D050DataChange
    Left = 176
    Top = 16
  end
  object Q030A: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from p030_valute t'
      'WHERE T.cod_valuta = '
      
        '       (select cod_valuta_base from p150_setup where decorrenza ' +
        '= '
      
        '               (select max(decorrenza) from p150_setup where dec' +
        'orrenza <= :DECORRENZA))'
      
        'and T.DECORRENZA = (select max(A.decorrenza) from p030_valute A ' +
        'where A.decorrenza <= :DECORRENZA AND A.COD_VALUTA = T.COD_VALUT' +
        'A)'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000001400000043004F0044005F00560041004C00550054004100
      010000000000140000004400450043004F005200520045004E005A0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001A000000410042004200520045005600490041005A0049004F004E00
      4500010000000000200000004E0055004D005F004400450043005F0049004D00
      50005F0056004F0043004500010000000000200000004E0055004D005F004400
      450043005F0049004D0050005F0055004E0049005400010000000000}
    Left = 272
    Top = 72
    object Q030ACOD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object Q030ADECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object Q030ADESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
    object Q030AABBREVIAZIONE: TStringField
      FieldName = 'ABBREVIAZIONE'
      Size = 3
    end
    object Q030ANUM_DEC_IMP_VOCE: TIntegerField
      FieldName = 'NUM_DEC_IMP_VOCE'
    end
    object Q030ANUM_DEC_IMP_UNIT: TIntegerField
      FieldName = 'NUM_DEC_IMP_UNIT'
    end
  end
  object D030A: TDataSource
    DataSet = Q030A
    Left = 232
    Top = 72
  end
  object D021A: TDataSource
    DataSet = Q021A
    Left = 232
    Top = 16
  end
  object Q021A: TOracleDataSet
    SQL.Strings = (
      'select '
      'codice, '
      'descrizione, '
      'decorrenza, '
      'importo, '
      'CODVOCEPAGHE, '
      'arrotondamento '
      ' from m021_tipiindennitakm t'
      'where codice = :codice'
      'ORDER BY decorrenza DESC')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000000C00000043004F0044004900430045000100000000000E000000
      49004D0050004F00520054004F000100000000001800000043004F0044005600
      4F0043004500500041004700480045000100000000001C000000410052005200
      4F0054004F004E00440041004D0045004E0054004F00010000000000}
    Left = 272
    Top = 16
    object Q021ACODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object Q021ADESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q021ADECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object Q021AIMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object Q021ACODVOCEPAGHE: TStringField
      FieldName = 'CODVOCEPAGHE'
      Size = 6
    end
    object Q021AARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Size = 5
    end
  end
  object SelM011: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid'
      'from m011_tipomissione t')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001600
      0000530045004C0045005A0049004F004E00410054004F000100000000000200
      00003100010000000000}
    Left = 88
    Top = 88
    object StringField1: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object StringField3: TStringField
      FieldName = 'SELEZIONATO'
      Size = 1
    end
  end
  object Sel010TipoTariffa: TOracleDataSet
    SQL.Strings = (
      'select '
      'tipo_tariffa'
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
    Left = 88
    Top = 16
  end
  object selM150: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T850.TIPO_RICHIESTA,'
      '  T030.COGNOME||'#39' '#39'||T030.NOME NOMINATIVO,'
      '  T030.MATRICOLA,'
      '  M140.PROGRESSIVO,'
      '  M140.ID,'
      '  M140.PROTOCOLLO,'
      
        '  decode(M140.FLAG_DESTINAZIONE,'#39'R'#39','#39'Italia'#39','#39'I'#39','#39'Italia'#39','#39'Ester' +
        'o'#39') D_DESTINAZIONE,'
      '  M140.FLAG_ISPETTIVA,'
      '  M140F_GETPARTENZA(M140.ID) PARTENZA,'
      '  M140F_GETDESTINAZIONI(M140.ID) ELENCO_DESTINAZIONI,'
      '  M140F_GETRIENTRO(M140.ID) RIENTRO,'
      '  M140.DATADA,'
      '  M140.DATAA,'
      '  M140.ORADA,'
      '  M140.ORAA,'
      '  M150.CODICE,'
      '  M150.INDENNITA_KM,'
      
        '  decode(M150.INDENNITA_KM,'#39'S'#39',M021.DESCRIZIONE,M020.DESCRIZIONE' +
        ') DESCRIZIONE,'
      '  M150.KMPERCORSI,'
      '  M150.KMPERCORSI_VARIATO,'
      '  M150.RIMBORSO,'
      '  M150.COD_VALUTA,'
      '  M150.RIMBORSO_VARIATO,'
      '  M150.STATO,'
      '  M150.NOTE,'
      '  M150.ROWID,'
      '  T480_RES.CITTA COMUNE_RESIDENZA,'
      '  T480_RES.CAP CAP_RESIDENZA,'
      '  T480_DOM.CITTA COMUNE_DOMICILIO,'
      '  T480_DOM.CAP CAP_DOMICILIO'
      'from '
      
        '  M140_RICHIESTE_MISSIONI M140, M150_RICHIESTE_RIMBORSI M150, T8' +
        '50_ITER_RICHIESTE T850, '
      
        '  M020_TIPIRIMBORSI M020, M021_TIPIINDENNITAKM M021, T480_COMUNI' +
        ' T480_RES, T480_COMUNI T480_DOM,'
      '  :C700SELANAGRAFE'
      'and T030.PROGRESSIVO = M140.PROGRESSIVO'
      'and T850.ITER = '#39'M140'#39
      'and T850.ID = M140.ID'
      'and T850.TIPO_RICHIESTA = '#39'5'#39
      'and M150.ID = M140.ID'
      'and M150.STATO = '#39'A'#39
      'and M020.CODICE(+) = M150.CODICE'
      'and M021.CODICE(+) = M150.CODICE'
      'and V430.T430COMUNE = T480_RES.CODICE(+)'
      'and V430.T430COMUNE_DOM_BASE = T480_DOM.CODICE(+)'
      
        'and trunc(sysdate) between M021.DECORRENZA(+) and M021.DECORRENZ' +
        'A_FINE(+)'
      'order by M140.DATADA,M140.ORADA,M140.PROTOCOLLO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000120000001C0000005400490050004F005F0052004900430048004900
      4500530054004100010000000000140000004E004F004D0049004E0041005400
      490056004F00010000000000120000004D00410054005200490043004F004C00
      410001000000000014000000500052004F0054004F0043004F004C004C004F00
      0100000000002200000046004C00410047005F00440045005300540049004E00
      41005A0049004F004E0045000100000000001C00000046004C00410047005F00
      490053005000450054005400490056004100010000000000100000004C004F00
      430041004C004900540041000100000000000C00000044004100540041004400
      41000100000000000A000000440041005400410041000100000000000A000000
      4F005200410044004100010000000000080000004F0052004100410001000000
      00000C00000043004F0044004900430045000100000000001600000044004500
      53004300520049005A0049004F004E004500010000000000140000004B004D00
      50004500520043004F0052005300490001000000000010000000520049004D00
      42004F00520053004F000100000000001400000043004F0044005F0056004100
      4C0055005400410001000000000020000000520049004D0042004F0052005300
      4F005F005600410052004900410054004F00010000000000080000004E004F00
      54004500010000000000}
    OnApplyRecord = selM150ApplyRecord
    UpdatingTable = 'M150_RICHIESTE_RIMBORSI'
    CachedUpdates = True
    BeforeInsert = selM150BeforeInsert
    BeforeEdit = selM150BeforeEdit
    BeforePost = selM150BeforePost
    AfterPost = selM150AfterPost
    BeforeDelete = selM150BeforeDelete
    AfterScroll = selM150AfterScroll
    OnCalcFields = selM150CalcFields
    Left = 16
    Top = 88
    object selM150TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selM150NOMINATIVO: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      ReadOnly = True
      Size = 61
    end
    object selM150MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selM150D_DESTINAZIONE: TStringField
      DisplayLabel = 'Destin.'
      DisplayWidth = 6
      FieldName = 'D_DESTINAZIONE'
      ReadOnly = True
      Size = 10
    end
    object selM150FLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Isp.'
      FieldName = 'FLAG_ISPETTIVA'
      ReadOnly = True
      Required = True
      Size = 1
    end
    object selM150PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 20
      FieldName = 'PARTENZA'
      Visible = False
      Size = 200
    end
    object selM150ELENCO_DESTINAZIONI: TStringField
      DisplayLabel = 'Destinazioni'
      DisplayWidth = 30
      FieldName = 'ELENCO_DESTINAZIONI'
      Size = 2000
    end
    object selM150RIENTRO: TStringField
      DisplayLabel = 'Rientro'
      DisplayWidth = 20
      FieldName = 'RIENTRO'
      Visible = False
      Size = 200
    end
    object selM150C_PERCORSO: TStringField
      DisplayLabel = 'Percorso'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'C_PERCORSO'
      Size = 500
      Calculated = True
    end
    object selM150DATADA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DATADA'
      ReadOnly = True
    end
    object selM150DATAA: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'DATAA'
      ReadOnly = True
    end
    object selM150ORADA: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'ORADA'
      ReadOnly = True
      Size = 5
    end
    object selM150ORAA: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ORAA'
      ReadOnly = True
      Size = 5
    end
    object selM150INDENNITA_KM: TStringField
      FieldName = 'INDENNITA_KM'
      Visible = False
      Size = 1
    end
    object selM150DESCRIZIONE: TStringField
      DisplayLabel = 'Voce'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 40
    end
    object selM150KMPERCORSI: TFloatField
      DisplayLabel = 'KM'
      DisplayWidth = 4
      FieldName = 'KMPERCORSI'
      ReadOnly = True
    end
    object selM150KMPERCORSI_VARIATO: TFloatField
      DisplayLabel = 'KM rimb.'
      DisplayWidth = 8
      FieldName = 'KMPERCORSI_VARIATO'
      OnValidate = selM150KMPERCORSI_VARIATOValidate
    end
    object selM150COD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      DisplayWidth = 6
      FieldName = 'COD_VALUTA'
      ReadOnly = True
      Size = 10
    end
    object selM150RIMBORSO: TFloatField
      DisplayLabel = 'Richiesta'
      DisplayWidth = 8
      FieldName = 'RIMBORSO'
      ReadOnly = True
    end
    object selM150RIMBORSO_VARIATO: TFloatField
      DisplayLabel = 'A rimborso'
      DisplayWidth = 8
      FieldName = 'RIMBORSO_VARIATO'
    end
    object selM150STATO: TStringField
      DisplayLabel = 'Conf.'
      FieldName = 'STATO'
      Size = 1
    end
    object selM150CODICE: TStringField
      DisplayLabel = 'Cod.rimb.'
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object selM150PROTOCOLLO: TStringField
      DisplayLabel = 'Prot.'
      DisplayWidth = 6
      FieldName = 'PROTOCOLLO'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selM150NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
    object selM150ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selM150COMUNE_RESIDENZA: TStringField
      FieldName = 'COMUNE_RESIDENZA'
      Visible = False
      Size = 40
    end
    object selM150CAP_RESIDENZA: TStringField
      FieldName = 'CAP_RESIDENZA'
      Visible = False
      Size = 5
    end
    object selM150COMUNE_DOMICILIO: TStringField
      FieldName = 'COMUNE_DOMICILIO'
      Size = 40
    end
    object selM150CAP_DOMICILIO: TStringField
      FieldName = 'CAP_DOMICILIO'
      Size = 5
    end
    object selM150PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selM150C_SEDE_LAVORO: TStringField
      DisplayLabel = 'Sede lavoro'
      FieldKind = fkCalculated
      FieldName = 'C_SEDE_LAVORO'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selM150C_COMUNE_RES: TStringField
      DisplayLabel = 'Comune di residenza'
      FieldKind = fkCalculated
      FieldName = 'C_COMUNE_RES'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selM150C_COMUNE_DOM: TStringField
      DisplayLabel = 'Comune di domicilio'
      FieldKind = fkCalculated
      FieldName = 'C_COMUNE_DOM'
      Size = 100
      Calculated = True
    end
  end
end
