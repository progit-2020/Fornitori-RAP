inherited S031FFamiliariDtM: TS031FFamiliariDtM
  OldCreateOrder = True
  Height = 182
  Width = 233
  object QSG101: TOracleDataSet
    SQL.Strings = (
      'SELECT SG101.*,SG101.ROWID '
      '  FROM SG101_FAMILIARI SG101'
      ' WHERE SG101.PROGRESSIVO = :PROGRESSIVO'
      ' ORDER BY SG101.NUMORD, SG101.DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000003300000016000000500052004F004700520045005300530049005600
      4F000100000000000C0000004E0055004D004F00520044000100000000001400
      00004400450043004F005200520045004E005A0041000100000000000E000000
      43004F0047004E004F004D004500010000000000080000004E004F004D004500
      0100000000000C00000043004F004D004E00410053000100000000000E000000
      44004100540041004E0041005300010000000000100000004700520041004400
      4F005000410052000100000000001E0000005400490050004F005F0044004500
      5400520041005A0049004F004E00450001000000000016000000500045005200
      43005F00430041005200490043004F000100000000000E000000440041005400
      41004D00410054000100000000000E0000004400410054004100530045005000
      0100000000002800000044004500540052005F004600490047004C0049004F00
      5F00480041004E0044004900430041005000010000000000120000004D004100
      54005200490043004F004C004100010000000000100000004400410054004100
      410044004F005A000100000000000A00000053004500530053004F0001000000
      00001400000043004F004400460049005300430041004C004500010000000000
      1C00000043004F004D0050004F004E0045004E00540045005F0041004E004600
      010000000000160000005200450044004400490054004F005F0041004E004600
      010000000000220000005200450044004400490054004F005F0041004C005400
      52004F005F0041004E0046000100000000001800000053005000450043004900
      41004C0045005F0041004E0046000100000000001600000049004E0041004200
      49004C0045005F0041004E0046000100000000001E0000004400450043004F00
      5200520045004E005A0041005F00460049004E00450001000000000020000000
      44004100540041004E00410053005F00500052004500530055004E0054004100
      01000000000022000000430041005500530041004C0049005F00410042004900
      4C00490054004100540045000100000000000E0000004E004F004D0045005F00
      500041000100000000001200000049004E0044004900520049005A005A004F00
      0100000000000C00000043004F004D0055004E00450001000000000006000000
      43004100500001000000000010000000540045004C00450046004F004E004F00
      0100000000000C0000004300410050004E004100530001000000000020000000
      44004100540041005F0055004C0054005F00460041004D005F00430041005200
      010000000000100000004E0055004D0047005200410044004F00010000000000
      0E0000005400490050004F005000410052000100000000002A00000044004500
      540052005F004600490047004C0049004F005F003100300030005F0041004600
      460049004400010000000000080000004E004F00540045000100000000001200
      00004400550052004100540041005F0050004100010000000000100000004100
      4E004E004F005F004100560056000100000000001800000041004E004E004F00
      5F004100560056005F00460041004D000100000000001E000000540049005000
      4F005F004400490053004100420049004C004900540041000100000000001C00
      000041004E004E004F005F005200450056004900530049004F004E0045000100
      000000001C0000004D004F005400490056004F005F0047005200410044004F00
      5F0033000100000000001600000041004C005400450052004E00410054004900
      56004100010000000000160000004E004F004D0045005F00500041005F004100
      4C005400010000000000240000004D004F005400490056004F005F0047005200
      410044004F005F0033005F0041004C0054000100000000001E00000054004900
      50004F005F00410044004F005A005F0041004600460049004400010000000000
      2000000047005200410056005F0049004E0049005A0049004F005F0054004500
      4F0052000100000000002400000047005200410056005F0049004E0049005A00
      49004F005F005300430045004C00540041000100000000001E00000047005200
      410056005F0049004E0049005A0049004F005F00450046004600010000000000
      1200000047005200410056005F00460049004E00450001000000000018000000
      44004100540041005F00500052004500410044004F005A00010000000000}
    AfterOpen = QSG101AfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = QSG101AfterScroll
    OnCalcFields = QSG101CalcFields
    OnNewRecord = OnNewRecord
    Left = 20
    Top = 8
    object QSG101PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object QSG101DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object QSG101DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object QSG101NUMORD: TFloatField
      DisplayLabel = 'N.ordine'
      FieldName = 'NUMORD'
      Required = True
      MaxValue = 99.000000000000000000
    end
    object QSG101GRADOPAR: TStringField
      DisplayLabel = 'Cod.parentela'
      FieldName = 'GRADOPAR'
      Size = 2
    end
    object QSG101Desc_Grado: TStringField
      DisplayLabel = 'Parentela'
      FieldKind = fkCalculated
      FieldName = 'Desc_Grado'
      Size = 30
      Calculated = True
    end
    object QSG101TIPOPAR: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPOPAR'
      Size = 1
    end
    object QSG101Desc_TipoPar: TStringField
      DisplayLabel = 'Descrizione tipo'
      FieldKind = fkCalculated
      FieldName = 'Desc_TipoPar'
      Visible = False
      Size = 50
      Calculated = True
    end
    object QSG101NUMGRADO: TStringField
      DisplayLabel = 'Grado'
      FieldName = 'NUMGRADO'
      Size = 2
    end
    object QSG101MOTIVO_GRADO_3: TStringField
      DisplayLabel = 'Motivo 3'#176' grado'
      FieldName = 'MOTIVO_GRADO_3'
      Size = 1
    end
    object QSG101MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      OnValidate = QSG101MATRICOLAValidate
      Size = 8
    end
    object QSG101COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object QSG101NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object QSG101SESSO: TStringField
      DisplayLabel = 'Sesso'
      FieldName = 'SESSO'
      Size = 1
    end
    object QSG101DATANAS_PRESUNTA: TDateTimeField
      DisplayLabel = 'Data presunta'
      FieldName = 'DATANAS_PRESUNTA'
      OnChange = QSG101DATANAS_PRESUNTAChange
      OnGetText = QSG101DATANASGetText
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object QSG101DATANAS: TDateTimeField
      DisplayLabel = 'Data nascita'
      DisplayWidth = 18
      FieldName = 'DATANAS'
      OnChange = QSG101DATANASChange
      OnGetText = QSG101DATANASGetText
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object QSG101COMNAS: TStringField
      DisplayLabel = 'Comune nascita'
      FieldName = 'COMNAS'
      Size = 6
    end
    object QSG101D_DESCOMNAS: TStringField
      DisplayLabel = 'Descrizione comune nascita'
      FieldKind = fkLookup
      FieldName = 'D_DESCOMNAS'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMNAS'
      Size = 40
      Lookup = True
    end
    object QSG101D_PROVINCIA: TStringField
      DisplayLabel = 'Provincia nascita'
      FieldKind = fkLookup
      FieldName = 'D_PROVINCIA'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMNAS'
      Lookup = True
    end
    object QSG101CAPNAS: TStringField
      DisplayLabel = 'CAP nascita'
      FieldName = 'CAPNAS'
      Size = 5
    end
    object QSG101CODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object QSG101DATA_PREADOZ: TDateTimeField
      DisplayLabel = 'Data pre-adozione'
      DisplayWidth = 10
      FieldName = 'DATA_PREADOZ'
      OnChange = QSG101DATAADOZChange
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101DATAADOZ: TDateTimeField
      DisplayLabel = 'Data adozione'
      FieldName = 'DATAADOZ'
      OnChange = QSG101DATAADOZChange
      OnGetText = QSG101DATANASGetText
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object QSG101TIPO_ADOZ_AFFID: TStringField
      DisplayLabel = 'Tipo adozione/affidamento'
      FieldName = 'TIPO_ADOZ_AFFID'
      Size = 1
    end
    object QSG101DATASEP: TDateTimeField
      DisplayLabel = 'Data esclusione'
      DisplayWidth = 10
      FieldName = 'DATASEP'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101DATAMAT: TDateTimeField
      DisplayLabel = 'Data matrimonio'
      DisplayWidth = 10
      FieldName = 'DATAMAT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101GRAV_INIZIO_TEOR: TDateTimeField
      DisplayLabel = 'Inizio teorico gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_TEOR'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101GRAV_INIZIO_SCELTA: TDateTimeField
      DisplayLabel = 'Inizio scelto dal dip. gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_SCELTA'
      OnChange = QSG101GRAV_INIZIO_SCELTAChange
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101GRAV_INIZIO_EFF: TDateTimeField
      DisplayLabel = 'Inizio effettivo gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_EFF'
      OnChange = QSG101GRAV_INIZIO_EFFChange
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101GRAV_FINE: TDateTimeField
      DisplayLabel = 'Fine effettiva gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_FINE'
      OnChange = QSG101GRAV_FINEChange
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101CAUSALI_ABILITATE: TStringField
      DisplayLabel = 'Causali fruibili'
      FieldName = 'CAUSALI_ABILITATE'
      Size = 2000
    end
    object QSG101TIPO_DISABILITA: TStringField
      DisplayLabel = 'Tipo disabilit'#224
      FieldName = 'TIPO_DISABILITA'
      Size = 1
    end
    object QSG101Desc_TipoDisab: TStringField
      DisplayLabel = 'Descrizione tipo disabilit'#224
      FieldKind = fkCalculated
      FieldName = 'Desc_TipoDisab'
      Size = 50
      Calculated = True
    end
    object QSG101ANNO_REVISIONE: TDateTimeField
      DisplayLabel = 'Data revisione'
      DisplayWidth = 10
      FieldName = 'ANNO_REVISIONE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101ANNO_AVV: TFloatField
      DisplayLabel = 'Anno avvicinamento proprio dom.'
      FieldName = 'ANNO_AVV'
    end
    object QSG101ANNO_AVV_FAM: TFloatField
      DisplayLabel = 'Anno avvicinamento dom.fam.'
      FieldName = 'ANNO_AVV_FAM'
    end
    object QSG101INDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object QSG101COMUNE: TStringField
      DisplayLabel = 'Comune'
      FieldName = 'COMUNE'
      Size = 6
    end
    object QSG101Desc_Comune: TStringField
      DisplayLabel = 'Descrizione comune'
      FieldKind = fkLookup
      FieldName = 'Desc_Comune'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      Size = 100
      Lookup = True
    end
    object QSG101Prov_Comune: TStringField
      DisplayLabel = 'Provincia comune'
      FieldKind = fkLookup
      FieldName = 'Prov_Comune'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      Size = 5
      Lookup = True
    end
    object QSG101CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object QSG101TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 15
    end
    object QSG101NOME_PA: TStringField
      DisplayLabel = 'Denominazione P.A.'
      FieldName = 'NOME_PA'
      Size = 100
    end
    object QSG101DURATA_PA: TStringField
      DisplayLabel = 'Durata contratto'
      FieldName = 'DURATA_PA'
      Size = 1
    end
    object QSG101ALTERNATIVA: TStringField
      DisplayLabel = 'Tipo soggetto alternativa'
      FieldName = 'ALTERNATIVA'
      Size = 1
    end
    object QSG101MOTIVO_GRADO_3_ALT: TStringField
      DisplayLabel = 'Motivo 3'#176' grado alternativa'
      FieldName = 'MOTIVO_GRADO_3_ALT'
      Size = 1
    end
    object QSG101NOME_PA_ALT: TStringField
      DisplayLabel = 'Denominazione P.A. alternativa'
      FieldName = 'NOME_PA_ALT'
      Size = 100
    end
    object QSG101DATA_ULT_FAM_CAR: TDateTimeField
      DisplayLabel = 'Data ultima dichiarazione'
      DisplayWidth = 10
      FieldName = 'DATA_ULT_FAM_CAR'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object QSG101TIPO_DETRAZIONE: TStringField
      DisplayLabel = 'Tipo detrazione'
      FieldName = 'TIPO_DETRAZIONE'
      Size = 2
    end
    object QSG101Desc_Detrazione: TStringField
      DisplayLabel = 'Descrizione tipo detrazione'
      FieldKind = fkCalculated
      FieldName = 'Desc_Detrazione'
      Calculated = True
    end
    object QSG101PERC_CARICO: TFloatField
      DisplayLabel = 'Percentuale a carico'
      FieldName = 'PERC_CARICO'
      DisplayFormat = '000.00'
      MaxValue = 100.000000000000000000
      Precision = 4
    end
    object QSG101DETR_FIGLIO_HANDICAP: TStringField
      DisplayLabel = 'Figlio portatore di handicap'
      FieldName = 'DETR_FIGLIO_HANDICAP'
      Size = 1
    end
    object QSG101DETR_FIGLIO_100_AFFID: TStringField
      DisplayLabel = 'Detrazione 100% affidamento figli'
      FieldName = 'DETR_FIGLIO_100_AFFID'
      Size = 1
    end
    object QSG101COMPONENTE_ANF: TStringField
      DisplayLabel = 'Componente nucleo'
      FieldName = 'COMPONENTE_ANF'
      Size = 1
    end
    object QSG101Desc_ANF: TStringField
      DisplayLabel = 'Componente nucleo'
      FieldKind = fkCalculated
      FieldName = 'Desc_ANF'
      Size = 2
      Calculated = True
    end
    object QSG101SPECIALE_ANF: TStringField
      DisplayLabel = 'Studente/Apprendista'
      FieldName = 'SPECIALE_ANF'
      Size = 1
    end
    object QSG101INABILE_ANF: TStringField
      DisplayLabel = 'Inabile'
      FieldName = 'INABILE_ANF'
      Size = 1
    end
    object QSG101Desc_Inabile: TStringField
      DisplayLabel = 'Inabile'
      FieldKind = fkCalculated
      FieldName = 'Desc_Inabile'
      Size = 2
      Calculated = True
    end
    object QSG101REDDITO_ANF: TFloatField
      DisplayLabel = 'Reddito lav.dip.'
      FieldName = 'REDDITO_ANF'
    end
    object QSG101REDDITO_ALTRO_ANF: TFloatField
      DisplayLabel = 'Altri redditi'
      FieldName = 'REDDITO_ALTRO_ANF'
    end
    object QSG101NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object QSG101D_CODCATASTALE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODCATASTALE'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODCATASTALE'
      KeyFields = 'COMNAS'
      Visible = False
      Size = 10
      Lookup = True
    end
    object QSG101D_CAPNAS: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAPNAS'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMNAS'
      Visible = False
      Size = 5
      Lookup = True
    end
    object QSG101D_CAP: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAP'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMUNE'
      Visible = False
      Size = 5
      Lookup = True
    end
    object QSG101REG_DATANAS: TStringField
      DisplayLabel = 'Registrazione evento data nascita'
      FieldName = 'REG_DATANAS'
      Size = 1
    end
    object QSG101NOTE_INDIVIDUALI: TStringField
      DisplayLabel = 'Note individuali'
      FieldName = 'NOTE_INDIVIDUALI'
      Size = 300
    end
    object QSG101PART_FRUIZ_MATERNITA: TStringField
      FieldName = 'PART_FRUIZ_MATERNITA'
      Size = 1
    end
  end
  object dsrT030: TDataSource
    AutoEdit = False
    DataSet = S031FFamiliariMW.selT030
    Left = 77
    Top = 8
  end
end
