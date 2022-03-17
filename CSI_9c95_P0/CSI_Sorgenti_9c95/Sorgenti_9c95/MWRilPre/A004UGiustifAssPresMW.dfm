inherited A004FGiustifAssPresMW: TA004FGiustifAssPresMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 211
  Width = 660
  object Q040: TOracleDataSet
    SQL.Strings = (
      'Select /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'T040.*,T040.ROWID '
      'from T040_GIUSTIFICATIVI T040 '
      'where PROGRESSIVO = :Progressivo')
    ReadBuffer = 2000
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OnPostError = Q040PostError
    Left = 16
    Top = 12
  end
  object Q040B: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '  * FROM T040_Giustificativi '
      '  WHERE Progressivo = :Progressivo AND'
      '  DATA BETWEEN :DATA1 AND :DATA2'
      ' :FILTROCAUSALE'
      '  ORDER BY Data,Causale')
    ReadBuffer = 2000
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      00000000000000001C0000003A00460049004C00540052004F00430041005500
      530041004C004500010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C00450001000000000018000000500052004F0047005200
      430041005500530041004C004500010000000000120000005400490050004F00
      470049005500530054000100000000000A000000440041004F00520045000100
      000000000800000041004F00520045000100000000000C000000530043004800
      4500440041000100000000000C0000005300540041004D005000410001000000
      00000E00000044004100540041004E0041005300010000000000}
    AfterOpen = Q040BAfterOpen
    OnCalcFields = Q040BCalcFields
    OnFilterRecord = Q040BFilterRecord
    Left = 54
    Top = 12
    object Q040BProgressivo: TFloatField
      FieldName = 'Progressivo'
      Visible = False
    end
    object Q040BData: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Data'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/9999;1;_'
    end
    object Q040BD_TipoCausale: TStringField
      DisplayLabel = 'P/A'
      DisplayWidth = 4
      FieldKind = fkCalculated
      FieldName = 'D_TipoCausale'
      Size = 4
      Calculated = True
    end
    object Q040BCausale: TStringField
      FieldName = 'Causale'
      Size = 5
    end
    object Q040BDATANAS: TDateTimeField
      DisplayLabel = 'Rif.'
      DisplayWidth = 10
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy HH.NN'
    end
    object Q040BProgrCausale: TFloatField
      FieldName = 'ProgrCausale'
      Visible = False
    end
    object Q040BTipoGiust: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TipoGiust'
      Size = 1
    end
    object Q040BCSI_TIPO_MG: TStringField
      DisplayLabel = 'Tipo mezza giornata'
      FieldName = 'CSI_TIPO_MG'
      Visible = False
      Size = 1
    end
    object Q040BD_CSI_TIPO_MG: TStringField
      DisplayLabel = 'Mezza gg.'
      FieldKind = fkCalculated
      FieldName = 'D_CSI_TIPO_MG'
      Size = 15
      Calculated = True
    end
    object Q040BDaOre: TDateTimeField
      DisplayLabel = 'Da ore/n.ore'
      DisplayWidth = 7
      FieldName = 'DaOre'
      OnSetText = T040DaOreSetText
      DisplayFormat = 'hh:mm'
      EditMask = '99:99;1;_'
    end
    object Q040BAOre: TDateTimeField
      DisplayLabel = 'A ore'
      DisplayWidth = 7
      FieldName = 'AOre'
      OnSetText = T040DaOreSetText
      DisplayFormat = 'hh:mm'
      EditMask = '99:99;1;_'
    end
    object Q040BD_Causale: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_Causale'
      LookupDataSet = Q265
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Causale'
      Size = 40
      Lookup = True
    end
    object Q040BNote: TStringField
      DisplayWidth = 12
      FieldName = 'Note'
      Size = 10
    end
  end
  object selT046: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM T046_GIUSTIFICATIVIFAMILIARI T'
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000700000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C0045000100000000000E00000044004100540041004E00
      41005300010000000000120000005400490050004F0047004900550053005400
      0100000000000A000000440041004F0052004500010000000000080000004100
      4F0052004500010000000000}
    ReadOnly = True
    Left = 98
    Top = 12
    object selT046PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT046DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
    object selT046CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selT046DATANAS: TDateTimeField
      DisplayLabel = 'Rif.'
      DisplayWidth = 10
      FieldName = 'DATANAS'
    end
    object selT046TIPOGIUST: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPOGIUST'
      Required = True
      Size = 1
    end
    object selT046DAORE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DAORE'
      Size = 5
    end
    object selT046AORE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'AORE'
      Size = 5
    end
  end
  object dsrVisualizza: TDataSource
    AutoEdit = False
    DataSet = Q040B
    Left = 53
    Top = 58
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'Select '
      '  Codice,Descrizione,Cumulo_Familiari,Fruizione_Familiari,'
      
        '  UM_Inserimento,UM_Inserimento_MG,UM_Inserimento_H,UM_Inserimen' +
        'to_D,TipoCumulo,'
      
        '  OreMinuti(Fruiz_Min) Fruiz_Min, OreMinuti(nvl(Fruiz_Max,'#39'24.00' +
        #39')) Fruiz_Max, OreMinuti(Fruiz_Arr) Fruiz_Arr,'
      
        '  Fruiz_Max_Debito,FruizCompetenze_Arr,Visita_Fiscale,CodCau1,Co' +
        'dCau2,CodCau3,Copri_GGNonLav,GSignific,Allarme_Fruizione_Continu' +
        'ativa,'
      
        '  OreMinuti(nvl(OreGG_Max_Inf6,'#39'24.00'#39')) OreGG_Max_Inf6, OreMinu' +
        'ti(nvl(OreGG_Max_Sup6,'#39'24.00'#39')) OreGG_Max_Sup6,'
      '  CSI_MAX_MGMAT, CSI_MAX_MGPOM'
      'from  T265_CauAssenze'
      'order by Codice')
    ReadBuffer = 200
    Optimize = False
    Filtered = True
    AfterOpen = Q275AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 144
    Top = 12
  end
  object D265: TDataSource
    AutoEdit = False
    DataSet = Q265
    Left = 144
    Top = 56
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      
        'Select Codice,Descrizione,UM_Inserimento_H,UM_Inserimento_D,CAUS' +
        'ALIZZA_TIMB_INTERSECANTI from T275_CauPresenze'
      'order by codice'
      '')
    ReadBuffer = 200
    Optimize = False
    Filtered = True
    AfterOpen = Q275AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 183
    Top = 12
  end
  object D275: TDataSource
    AutoEdit = False
    DataSet = Q275
    Left = 183
    Top = 56
  end
  object selConiuge: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM '
      'FROM SG101_FAMILIARI '
      
        'WHERE PROGRESSIVO = :PROGRESSIVO AND GRADOPAR IN ('#39'CG'#39','#39'AL'#39') AND' +
        ' MATRICOLA IS NULL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 236
    Top = 12
  end
  object dsrSG101: TDataSource
    Left = 236
    Top = 56
  end
  object selT050: TOracleDataSet
    SQL.Strings = (
      'select :HINTT030V430'
      '       distinct'
      '       t050.id,'
      '       t050.progressivo,'
      '       t050.elaborato,'
      '       t050.causale,'
      '       t050.tipogiust,'
      '       t050.csi_tipo_mg,'
      '       t050.dal,'
      '       t050.al,'
      '       t050.numeroore,'
      '       t050.aore,'
      '       t050.datanas,'
      '       t050.numeroore_prev,'
      '       t050.aore_prev,'
      '       t850.data,'
      '       t850.stato autorizzazione,'
      '       t850.tipo_richiesta,'
      '       t850.id_revoca,'
      '       t850.id_revocato, '
      '       t850.note note1, '
      '       t850.cod_iter, '
      '       t030.matricola,'
      '       t030.cognome || '#39' '#39' || t030.nome nominativo,'
      
        '       i060f_nominativo(:azienda,t851.responsabile) nominativo_r' +
        'esp,'
      '       nvl(t265.descrizione,t275.descrizione) descrizione,'
      '       decode(t265.codice,null,'#39'P'#39','#39'A'#39') tipocaus,'
      '       t850a.tipo_richiesta tipo_richiesta_orig,'
      '       t850r.stato stato_revoca,'
      
        '       decode(t853f_numallegati(T850.ID),0,'#39'N'#39','#39'S'#39') file_allegat' +
        'o'
      'from   t050_richiesteassenza t050, '
      '       t265_cauassenze t265, '
      '       t275_caupresenze t275, '
      '       t850_iter_richieste t850,'
      '       t851_iter_autorizzazioni t851,'
      '       t850_iter_richieste t850a,'
      '       t850_iter_richieste t850r,'
      '       :C700SelAnagrafe'
      '       and t050.progressivo = t030.progressivo'
      '       and t265.codice (+) = t050.causale'
      '       and t275.codice (+) = t050.causale'
      '       and t850.iter = '#39'T050'#39
      '       and t850.id = t050.id'
      '       and t850r.id_revocato (+) = t850.id'
      '       and t850r.iter (+) = '#39'T050'#39
      '       and t850a.id (+) = t850.id_revocato'
      '       and t850a.iter (+) = '#39'T050'#39
      
        '       and ( /* richiesta definitiva o revoca o cancellazione co' +
        'n autorizzazione impostata */'
      
        '             (t850.tipo_richiesta in ('#39'D'#39','#39'R'#39','#39'C'#39') and t850.stat' +
        'o in ('#39'S'#39','#39'N'#39')) or'
      
        '             /* qualsiasi richiesta con revoca / cancellazione a' +
        'utorizzata */'
      '             (t850r.stato = '#39'S'#39') or'
      '             /* richiesta preventiva negata */'
      '             (t850.tipo_richiesta = '#39'P'#39' and t850.stato = '#39'N'#39')'
      '           )'
      
        '       and t851.id(+) = t850.id and t851.livello(+) = abs(t851f_' +
        'maxliv_autorizzato(:azienda,'#39'T050'#39', t850.id))'
      '       /* END_REFRESH */'
      '       :FILTRO_MODALITA'
      '       :FILTRO_PERIODO'
      '       :FILTRO_RICHIESTE'
      '       :FILTRO_ALLEGATI'
      '       :FILTRO_CONDIZ_ALLEGATI'
      'order by nominativo, t030.matricola, t050.id')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000008000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000100000003A004100
      5A00490045004E00440041000500000000000000000000001A0000003A004800
      49004E0054005400300033003000560034003300300001000000000000000000
      0000200000003A00460049004C00540052004F005F004D004F00440041004C00
      4900540041000100000000000000000000001E0000003A00460049004C005400
      52004F005F0050004500520049004F0044004F00010000000000000000000000
      220000003A00460049004C00540052004F005F00520049004300480049004500
      530054004500010000000000000000000000200000003A00460049004C005400
      52004F005F0041004C004C004500470041005400490001000000000000000000
      00002E0000003A00460049004C00540052004F005F0043004F004E0044004900
      5A005F0041004C004C0045004700410054004900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      120000005400490050004F004700490055005300540001000000000006000000
      440041004C000100000000000400000041004C00010000000000120000004E00
      55004D00450052004F004F00520045000100000000000E000000440041005400
      41004E00410053000100000000001C0000004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000180000005200450053005000
      4F004E0053004100420049004C004500010000000000140000004E004F004D00
      49004E0041005400490056004F00010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000440045005300430052004900
      5A0049004F004E004500010000000000}
    UpdatingTable = 'T050_RICHIESTEASSENZA'
    Filtered = True
    OnCalcFields = selT050CalcFields
    OnFilterRecord = FiltroDizionario
    Left = 290
    Top = 12
    object selT050D_TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo richiesta'
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 14
      Calculated = True
    end
    object selT050AUTORIZZAZIONE: TStringField
      DisplayLabel = 'Aut.'
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT050MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT050NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT050D_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE'
      Size = 50
      Calculated = True
    end
    object selT050DAL: TDateTimeField
      DisplayLabel = 'Inizio'
      DisplayWidth = 10
      FieldName = 'DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT050AL: TDateTimeField
      DisplayLabel = 'Fine'
      DisplayWidth = 10
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT050TIPO: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldKind = fkCalculated
      FieldName = 'TIPO'
      Calculated = True
    end
    object selT050D_CSI_TIPO_MG: TStringField
      DisplayLabel = 'Mezza gg.'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_CSI_TIPO_MG'
      Calculated = True
    end
    object selT050NUMEROORE: TStringField
      DisplayLabel = 'Num.Ore/Da Ore'
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object selT050AORE: TStringField
      DisplayLabel = 'A Ore'
      FieldName = 'AORE'
      Size = 5
    end
    object selT050DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'DATANAS'
    end
    object selT050NOMINATIVO_RESP: TStringField
      DisplayLabel = 'Responsabile'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO_RESP'
      Size = 40
    end
    object selT050NOTE1: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE1'
      Size = 1000
    end
    object selT050ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT050PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT050ELABORATO: TStringField
      FieldName = 'ELABORATO'
      Visible = False
    end
    object selT050CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT050TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object selT050NUMEROORE_PREV: TStringField
      FieldName = 'NUMEROORE_PREV'
      Visible = False
      Size = 5
    end
    object selT050CSI_TIPO_MG: TStringField
      DisplayLabel = 'Mezza gg.'
      FieldName = 'CSI_TIPO_MG'
      Size = 1
    end
    object selT050AORE_PREV: TStringField
      FieldName = 'AORE_PREV'
      Visible = False
      Size = 5
    end
    object selT050DATA: TDateTimeField
      FieldName = 'DATA'
      Visible = False
    end
    object selT050TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selT050ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
      Visible = False
    end
    object selT050ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
      Visible = False
    end
    object selT050COD_ITER: TStringField
      DisplayLabel = 'Cod. struttura'
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selT050DESCRIZIONE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 40
    end
    object selT050TIPOCAUS: TStringField
      FieldName = 'TIPOCAUS'
      Visible = False
      Size = 1
    end
    object selT050TIPO_RICHIESTA_ORIG: TStringField
      FieldName = 'TIPO_RICHIESTA_ORIG'
      Visible = False
      Size = 1
    end
    object selT050STATO_REVOCA: TStringField
      FieldName = 'STATO_REVOCA'
      Size = 1
    end
    object selT050FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'FILE_ALLEGATO'
      Size = 1
    end
  end
  object selT050Upd: TOracleDataSet
    SQL.Strings = (
      'select elaborato, rowid'
      'from   t050_richiesteassenza'
      'where  id = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    LockingMode = lmLockImmediate
    CommitOnPost = False
    Left = 343
    Top = 12
  end
  object selT047: TOracleDataSet
    SQL.Strings = (
      'SELECT T047.*, T480.CITTA, T047.ROWID'
      '  FROM T047_VISITEFISCALI T047, T480_COMUNI T480'
      ' WHERE T047.TIPO_EVENTO = '#39'01'#39
      '   AND T047.COD_COMUNE = T480.CODICE(+)'
      '   AND T047.PROGRESSIVO = :PROGRESSIVO'
      '   AND T047.DATA_INIZIO_ASSENZA = /*:DATA_INIZIO*/'
      '                                  (SELECT MIN(INIZIO_MAL)'
      
        '                                     FROM (SELECT T1.DATA_INIZIO' +
        '_ASSENZA AS INIZIO_MAL'
      
        '                                             FROM T047_VISITEFIS' +
        'CALI T1'
      
        '                                            WHERE :DATA_INIZIO -' +
        ' 1 BETWEEN T1.DATA_INIZIO_ASSENZA AND T1.DATA_FINE_ASSENZA'
      
        '                                              AND T1.PROGRESSIVO' +
        ' = :PROGRESSIVO'
      
        '                                              AND T1.TIPO_EVENTO' +
        ' = '#39'01'#39
      
        '                                              AND T1.OPERAZIONE ' +
        '= '#39'I'#39
      '                                            UNION'
      
        '                                           SELECT :DATA_INIZIO A' +
        'S INIZIO_MAL'
      
        '                                             FROM DUAL))        ' +
        '                       '
      '   AND T047.OPERAZIONE = '#39'I'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      49004E0049005A0049004F000C0000000000000000000000}
    Left = 344
    Top = 60
  end
  object selElaborato: TOracleQuery
    SQL.Strings = (
      'select elaborato'
      'from   t050_richiesteassenza'
      'where  id = :id')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 408
    Top = 12
  end
  object selT485: TOracleDataSet
    SQL.Strings = (
      'select * from ('
      'select CODICE, DESCRIZIONE'
      'from   T485_MEDICINELEGALI T485'
      'union'
      'select null, null from DUAL)'
      'order by nvl(CODICE,'#39' '#39')')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    ReadOnly = True
    Left = 461
    Top = 12
  end
  object dscT485: TDataSource
    DataSet = selT485
    Left = 460
    Top = 56
  end
  object selT486: TOracleDataSet
    SQL.Strings = (
      'select T486.COD_COMUNE, T486.MED_LEGALE'
      'from   T486_COMUNI_MEDLEGALI T486'
      'where  T486.COD_COMUNE = :COD_COMUNE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F0044005F0043004F004D0055004E00
      4500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    ReadOnly = True
    Left = 517
    Top = 12
  end
  object insT280: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T280_MESSAGGIWEB'
      '  (progressivo, data, mittente, testo, log, flag, titolo)'
      'VALUES'
      
        '  (:PROGRESSIVO, :DATA, :MITTENTE, substr(:TESTO,1,4000), substr' +
        '(:LOG,1,4000), :FLAG, substr(:TITOLO,1,1000))'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A004D0049005400540045004E0054004500
      0500000000000000000000000C0000003A0054004500530054004F0005000000
      00000000000000000A0000003A0046004C004100470005000000000000000000
      00000E0000003A005400490054004F004C004F00050000000000000000000000
      080000003A004C004F004700050000000000000000000000}
    Left = 17
    Top = 109
  end
  object delT046: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T046_GIUSTIFICATIVIFAMILIARI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND '
      'CAUSALE = :CAUSALE AND'
      'DATA BETWEEN :DATA1 AND :DATA2')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 64
    Top = 108
  end
  object insT046: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T046_GIUSTIFICATIVIFAMILIARI '
      '  (PROGRESSIVO,DATA,CAUSALE,DATANAS,TIPOGIUST,DAORE,AORE)'
      'VALUES'
      '  (:PROGRESSIVO,:DATA,:CAUSALE,:DATANAS,:TIPOGIUST,:DAORE,:AORE)')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000140000003A005400490050004F004700490055005300
      54000500000000000000000000000C0000003A00440041004F00520045000500
      000000000000000000000A0000003A0041004F00520045000500000000000000
      00000000100000003A0044004100540041004E00410053000C00000000000000
      00000000}
    Left = 108
    Top = 108
  end
  object scrCopriGGNonLav: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  GETINIZIOASSENZA_GGNONLAV(:PROGRESSIVO, :DATA, :CAUSNEW, :CAUS' +
        'ALI);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000100000003A00430041005500530041004C0049000500
      00000000000000000000100000003A0043004100550053004E00450057000500
      00000000000000000000}
    Left = 184
    Top = 108
  end
  object scrT031: TOracleQuery
    SQL.Strings = (
      'declare '
      'begin'
      
        '  delete from T031_DATACARTELLINO where PROGRESSIVO =:PROGRESSIV' +
        'O and DATA between :DATA1 and :DATA2 and TIPO = '#39'1'#39';'
      '  if :INSERIMENTO = '#39'S'#39' then'
      
        '    insert into T031_DATACARTELLINO (PROGRESSIVO,DATA,TIPO) valu' +
        'es (:PROGRESSIVO,:DATA1,'#39'1'#39');'
      '  end if;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000180000003A0049004E0053004500520049004D0045004E00
      54004F00050000000000000000000000}
    Left = 264
    Top = 108
  end
  object selT040Revoche: TOracleDataSet
    SQL.Strings = (
      'select t040.*'
      'from   t040_giustificativi t040, t850_iter_richieste t850'
      
        'where  t850.id = :ID -- T850.ID_REVOCA = :ID (modifica per gesti' +
        're cancellazioni)'
      'and    t040.id_richiesta = t850.id'
      'and    t040.data between :DAL and :AL -- cancellazione periodo'
      
        'order by t040.data desc -- ordinamento per evitare riallineament' +
        'o causali concatenate sui giustificativi in fase di revoca')
    ReadBuffer = 60
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000000800
      00003A00440041004C000C0000000000000000000000060000003A0041004C00
      0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C00450001000000000018000000500052004F0047005200
      430041005500530041004C004500010000000000120000005400490050004F00
      470049005500530054000100000000000A000000440041004F00520045000100
      000000000800000041004F00520045000100000000000C000000530043004800
      4500440041000100000000000C0000005300540041004D005000410001000000
      00000E00000044004100540041004E0041005300010000000000}
    Left = 345
    Top = 109
  end
  object updT850: TOracleQuery
    SQL.Strings = (
      'update t850_iter_richieste'
      'set    stato = :stato'
      'where  id = :id')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000000C00
      00003A0053005400410054004F00050000000000000000000000}
    Left = 424
    Top = 108
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'Select * from T480_Comuni '
      ':ORDERBY ')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 568
    Top = 12
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 40
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrQ480: TDataSource
    DataSet = selT480
    Left = 568
    Top = 56
  end
  object selT047Esenzioni: TOracleDataSet
    SQL.Strings = (
      
        'select distinct TRIM(tipo_esenzione) tipo_esenzione from t047_vi' +
        'sitefiscali'
      'where tipo_esenzione is not null'
      'UNION'
      'select '#39'Generica'#39' tipo_esenzione from t047_visitefiscali'
      'UNION'
      
        'select '#39'Terapia salvavita'#39' tipo_esenzione from t047_visitefiscal' +
        'i'
      'order by tipo_esenzione')
    Optimize = False
    Left = 496
    Top = 107
  end
  object delT040IdRichiesta: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T040_GIUSTIFICATIVI '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND CAUSALE = :CAUSALE'
      'AND ID_RICHIESTA = :ID_RICHIESTA')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000001A0000003A00490044005F0052004900
      4300480049004500530054004100030000000000000000000000}
    Left = 40
    Top = 156
  end
  object seqT850Id: TOracleQuery
    SQL.Strings = (
      'select T850_ID.nextval from dual')
    ReadBuffer = 1
    Optimize = False
    Left = 128
    Top = 156
  end
  object insT040Extra: TOracleQuery
    SQL.Strings = (
      'insert into T040_GIUSTIFICATIVI '
      
        '  (PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,AORE,ID' +
        '_RICHIESTA)'
      'values '
      
        '  (:PROGRESSIVO,:DATA,:CAUSALE,T040F_NEWPROGRCAUSALE(:PROGRESSIV' +
        'O,:DATA,:CAUSALE),:TIPOGIUST,to_date('#39'30121899'#39'||(:DAORE*60),'#39'dd' +
        'mmyyyysssss'#39'),to_date('#39'30121899'#39'||(:AORE*60),'#39'ddmmyyyysssss'#39'),:I' +
        'D_RICHIESTA)')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000001A0000003A00490044005F0052004900
      43004800490045005300540041000300000000000000000000000A0000003A00
      44004100540041000C0000000000000000000000140000003A00540049005000
      4F00470049005500530054000500000000000000000000000C0000003A004400
      41004F00520045000300000000000000000000000A0000003A0041004F005200
      4500030000000000000000000000}
    Left = 208
    Top = 156
  end
  object T040p_allinea: TOracleQuery
    SQL.Strings = (
      'begin'
      
        ' T040P_ALLINEA_CONGPARENTALI(:PROGRESSIVO, :DATA, :CAUSALE, :OPE' +
        'RAZIONE);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000160000003A004F0050004500520041005A0049004F00
      4E004500050000000000000000000000100000003A0043004100550053004100
      4C004500050000000000000000000000}
    Left = 288
    Top = 156
  end
end
