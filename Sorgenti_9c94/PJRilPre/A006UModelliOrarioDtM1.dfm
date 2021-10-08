inherited A006FModelliOrarioDtM1: TA006FModelliOrarioDtM1
  OldCreateOrder = True
  Height = 68
  Width = 62
  object selT020: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T020.*,ROWID FROM T020_ORARI T020 ORDER BY CODICE,DECORRE' +
        'NZA')
    ReadBuffer = 200
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000004D0000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      4400450053004300520049005A0049004F004E0045000100000000000E000000
      5400490050004F004F00520041000100000000000C0000005000450052004C00
      410056000100000000000E0000005400490050004F0046004C00450001000000
      00000E0000004F00420042004C004600410043000100000000000E0000004F00
      52004500540045004F0052000100000000000C0000004F00520045004D004900
      4E000100000000000C0000004F00520045004D00410058000100000000001000
      000043004F004D00500044004500540052000100000000001200000041005200
      5200460055004F0045004E005400010000000000120000004100520052004600
      55004F005500530043000100000000000C00000041005200520050004F005300
      0100000000000C0000004100520052004E004500470001000000000010000000
      54004F004C004C005000520045005300010000000000120000004D004D004900
      4E00440050005200450053000100000000001000000046004C00410047005000
      5200450053000100000000000E00000043004F004D0050004E004F0054000100
      00000000140000004D004D0049004E0044004D00500052004500530001000000
      00001200000046004C00410047004D0050005200450053000100000000000E00
      00004600520041005A00440045004200010000000000180000004E004F005400
      5400450045004E0054005200410054004100010000000000200000004D004900
      4E005F005500530043004900540041005F004E004F0054005400450001000000
      00001400000049004E0044004600450053005400490056004100010000000000
      140000004F005200450049004E00440046004500530054000100000000001000
      000049004E0044005400550052004E004F000100000000001A0000004D004100
      54005500520041005F0052004900500043004F004D0001000000000012000000
      5400490050004F004D0045004E00530041000100000000001000000043004100
      55004F004200460041004300010000000000100000004D004D004D0049004E00
      49004D004900010000000000140000004D0049004E0050004500520043004F00
      520052000100000000001E000000540049004D00420052004100540055005200
      41004D0045004E00530041000100000000002200000049004E00540045005200
      530045005A0049004F004E0045004D0045004E00530041000100000000002A00
      0000500041005500530041004D0045004E00530041005F004100550054004F00
      4D00410054004900430041000100000000001800000050004D005F0041005500
      54004F005F005500520049005400010000000000160000004400450054005200
      41005500540043004F004E0054000100000000001C0000005200490045004E00
      540052004F005F004D0049004E0049004D004F00010000000000140000004300
      4F004D0050004600410053004300490041000100000000001200000054005500
      540054004F0043004F004D005000010000000000120000004D0049004E005300
      43004F00530054005200010000000000260000004F00520041004D0041005800
      5F0043004F004D00500045004E0053004100420049004C004500010000000000
      12000000410052005200530043004F005300540052000100000000001C000000
      410052005200530043004F005300540052005F0043004F004D00500001000000
      00000E00000043004F004D0050004C0049005100010000000000120000004D00
      49004E0049004D00490053005400520001000000000012000000410052005200
      49005600520041004E004700010000000000120000004D0049004E0047004900
      4F00530054005200010000000000120000004100520052004F00540047004900
      4F005200010000000000120000004D0041005800470049004F00530054005200
      0100000000001000000049004E00540045005200550053004300010000000000
      1C0000005300540052005F0044004F0050004F005F00480048004D0041005800
      0100000000001400000049004E00440050005200450053005300540052000100
      000000001400000049004E004400460045005300540053005400520001000000
      00001200000049004E0044004E004F0054005300540052000100000000002400
      000043004100520045004E005A0041005F004F00420042005F004E004F005F00
      4C00490051000100000000002600000052004900430041004C0043004F004C00
      4F005F00440045004200490054004F005F00470047000100000000001A000000
      52004900430041004C0043004F004C004F005F004D0049004E00010000000000
      1A00000052004900430041004C0043004F004C004F005F004D00410058000100
      000000001A0000004100520052005F00450043004300450044005F004C004900
      5100010000000000160000004100520052005F0049004E0044005F004E004F00
      540001000000000024000000500041005500530041004D0045004E0053004100
      5F00450053005400450052004E0041000100000000001C000000520045004700
      4F004C0045005F00500052004F00460049004C004F000100000000002A000000
      4500430043005F0043004F004D0050005F00430041005500530041004C004900
      5A005A0041005400410001000000000016000000530054005200520049005000
      460041005300430045000100000000002200000043004F005000450052005400
      5500520041005F0043004100520045004E005A0041000100000000001E000000
      4100520052005F00450043004300450044005F00460041005300430045000100
      00000000140000004100520052004F0054005F0043004F004D00500001000000
      0000200000004100520052005F00540049004D0042005F0049004E0054004500
      52004E004500010000000000240000004100520052005F004500430043005F00
      460041005300430045005F0043004F004D0050000100000000001E0000005000
      4D005F00520045004300550050005F0055005300430049005400410001000000
      00002E000000540049004D0042005200410054005500520041004D0045004E00
      530041005F0049004E005400450052004E004100010000000000280000005000
      4D0054005F00540049004D0042005F004100550054004F00520049005A005A00
      4100540045000100000000003200000050004D0041005F005000520045005300
      45005200560041005F00540049004D00420049004E0046004100530043004900
      410001000000000024000000530043004F0053005400470047005F004D004900
      4E005F0053004F0047004C00490041000100000000001C00000050004D005400
      5F0054004F004C004C004500520041004E005A0041000100000000001A000000
      440045004200490054004F005F0052004900500043004F004D00010000000000}
    Filtered = True
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = selT020AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT020AfterScroll
    OnFilterRecord = selT020FilterRecord
    OnNewRecord = OnNewRecord
    Left = 16
    Top = 8
    object selT020CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT020DECORRENZA: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT020TIPOORA: TStringField
      FieldName = 'TIPOORA'
      Required = True
      Size = 1
    end
    object selT020PERLAV: TStringField
      FieldName = 'PERLAV'
      Required = True
      Size = 2
    end
    object selT020TIPOFLE: TStringField
      FieldName = 'TIPOFLE'
      Size = 1
    end
    object selT020OBBLFAC: TStringField
      FieldName = 'OBBLFAC'
      Size = 1
    end
    object selT020ORETEOR: TStringField
      FieldName = 'ORETEOR'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020OREMIN: TStringField
      FieldName = 'OREMIN'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020OREMAX: TStringField
      FieldName = 'OREMAX'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020COMPDETR: TStringField
      FieldName = 'COMPDETR'
      Size = 1
    end
    object selT020ARRFUOENT: TStringField
      FieldName = 'ARRFUOENT'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020ARRFUOUSC: TStringField
      FieldName = 'ARRFUOUSC'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020ARRPOS: TStringField
      FieldName = 'ARRPOS'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020ARRNEG: TStringField
      FieldName = 'ARRNEG'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020TOLLPRES: TStringField
      FieldName = 'TOLLPRES'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020MMINDPRES: TStringField
      FieldName = 'MMINDPRES'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020FLAGPRES: TStringField
      FieldName = 'FLAGPRES'
      Size = 1
    end
    object selT020COMPNOT: TStringField
      FieldName = 'COMPNOT'
      Size = 1
    end
    object selT020MMINDMPRES: TStringField
      FieldName = 'MMINDMPRES'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020FLAGMPRES: TStringField
      FieldName = 'FLAGMPRES'
      Size = 1
    end
    object selT020FRAZDEB: TStringField
      FieldName = 'FRAZDEB'
      Size = 1
    end
    object selT020NOTTEENTRATA: TStringField
      FieldName = 'NOTTEENTRATA'
      Size = 1
    end
    object selT020MIN_USCITA_NOTTE: TStringField
      FieldName = 'MIN_USCITA_NOTTE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020INDFESTIVA: TStringField
      FieldName = 'INDFESTIVA'
      Size = 1
    end
    object selT020OREINDFEST: TStringField
      FieldName = 'OREINDFEST'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020INDTURNO: TStringField
      FieldName = 'INDTURNO'
      Size = 1
    end
    object selT020MATURA_RIPCOM: TStringField
      FieldName = 'MATURA_RIPCOM'
      Size = 1
    end
    object selT020TIPOMENSA: TStringField
      FieldName = 'TIPOMENSA'
      Size = 1
    end
    object selT020CAUOBFAC: TStringField
      FieldName = 'CAUOBFAC'
      Size = 1
    end
    object selT020MMMINIMI: TStringField
      FieldName = 'MMMINIMI'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020MINPERCORR: TStringField
      FieldName = 'MINPERCORR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020TIMBRATURAMENSA: TStringField
      FieldName = 'TIMBRATURAMENSA'
      Size = 1
    end
    object selT020INTERSEZIONEMENSA: TStringField
      FieldName = 'INTERSEZIONEMENSA'
      Size = 1
    end
    object selT020PAUSAMENSA_AUTOMATICA: TStringField
      FieldName = 'PAUSAMENSA_AUTOMATICA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020PM_AUTO_URIT: TStringField
      FieldName = 'PM_AUTO_URIT'
      Size = 1
    end
    object selT020DETRAUTCONT: TStringField
      FieldName = 'DETRAUTCONT'
      Size = 1
    end
    object selT020RIENTRO_MINIMO: TStringField
      FieldName = 'RIENTRO_MINIMO'
      Size = 5
    end
    object selT020COMPFASCIA: TStringField
      FieldName = 'COMPFASCIA'
      Size = 1
    end
    object selT020TUTTOCOMP: TStringField
      FieldName = 'TUTTOCOMP'
      Size = 1
    end
    object selT020MINSCOSTR: TStringField
      FieldName = 'MINSCOSTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ORAMAX_COMPENSABILE: TStringField
      FieldName = 'ORAMAX_COMPENSABILE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ARRSCOSTR: TStringField
      FieldName = 'ARRSCOSTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020ARRSCOSTR_COMP: TStringField
      FieldName = 'ARRSCOSTR_COMP'
      Size = 1
    end
    object selT020COMPLIQ: TStringField
      FieldName = 'COMPLIQ'
      Size = 1
    end
    object selT020MINIMISTR: TStringField
      FieldName = 'MINIMISTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ARRIVRANG: TStringField
      FieldName = 'ARRIVRANG'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020MINGIOSTR: TStringField
      FieldName = 'MINGIOSTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ARROTGIOR: TStringField
      FieldName = 'ARROTGIOR'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020MAXGIOSTR: TStringField
      FieldName = 'MAXGIOSTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020INTERUSC: TStringField
      FieldName = 'INTERUSC'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020STR_DOPO_HHMAX: TStringField
      FieldName = 'STR_DOPO_HHMAX'
      Size = 1
    end
    object selT020INDPRESSTR: TStringField
      FieldName = 'INDPRESSTR'
      Size = 1
    end
    object selT020INDFESTSTR: TStringField
      FieldName = 'INDFESTSTR'
      Size = 1
    end
    object selT020INDNOTSTR: TStringField
      FieldName = 'INDNOTSTR'
      Size = 1
    end
    object selT020CARENZA_OBB_NO_LIQ: TStringField
      FieldName = 'CARENZA_OBB_NO_LIQ'
      Size = 1
    end
    object selT020RICALCOLO_DEBITO_GG: TStringField
      FieldName = 'RICALCOLO_DEBITO_GG'
      Size = 1
    end
    object selT020RICALCOLO_MIN: TStringField
      FieldName = 'RICALCOLO_MIN'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020RICALCOLO_MAX: TStringField
      FieldName = 'RICALCOLO_MAX'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ARR_ECCED_LIQ: TStringField
      FieldName = 'ARR_ECCED_LIQ'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020PAUSAMENSA_ESTERNA: TStringField
      FieldName = 'PAUSAMENSA_ESTERNA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020REGOLE_PROFILO: TStringField
      FieldName = 'REGOLE_PROFILO'
      Size = 1
    end
    object selT020ECC_COMP_CAUSALIZZATA: TStringField
      FieldName = 'ECC_COMP_CAUSALIZZATA'
      Size = 1
    end
    object selT020STRRIPFASCE: TStringField
      FieldName = 'STRRIPFASCE'
      Required = True
      Size = 1
    end
    object selT020COPERTURA_CARENZA: TStringField
      FieldName = 'COPERTURA_CARENZA'
      Size = 1
    end
    object selT020ARR_ECCED_FASCE: TStringField
      FieldName = 'ARR_ECCED_FASCE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020ARROT_COMP: TStringField
      FieldName = 'ARROT_COMP'
      Size = 1
    end
    object selT020ARR_TIMB_INTERNE: TStringField
      FieldName = 'ARR_TIMB_INTERNE'
      Size = 1
    end
    object selT020ARR_ECC_FASCE_COMP: TStringField
      FieldName = 'ARR_ECC_FASCE_COMP'
      Size = 1
    end
    object selT020PM_RECUP_USCITA: TStringField
      FieldName = 'PM_RECUP_USCITA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020TIMBRATURAMENSA_INTERNA: TStringField
      FieldName = 'TIMBRATURAMENSA_INTERNA'
      Size = 1
    end
    object selT020PMT_TIMB_AUTORIZZATE: TStringField
      FieldName = 'PMT_TIMB_AUTORIZZATE'
      Size = 1
    end
    object selT020PMA_PRESERVA_TIMBINFASCIA: TStringField
      FieldName = 'PMA_PRESERVA_TIMBINFASCIA'
      Size = 1
    end
    object selT020SCOSTGG_MIN_SOGLIA: TStringField
      FieldName = 'SCOSTGG_MIN_SOGLIA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020PMT_TOLLERANZA: TStringField
      FieldName = 'PMT_TOLLERANZA'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020DEBITO_RIPCOM: TStringField
      FieldName = 'DEBITO_RIPCOM'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020TIMBRATURAMENSA_DETRAZIONE: TStringField
      FieldName = 'TIMBRATURAMENSA_DETRAZIONE'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020PMT_TIMB_MATURAMENSA: TStringField
      FieldName = 'PMT_TIMB_MATURAMENSA'
      Size = 1
    end
    object selT020PMT_SOLO_TIMBMENSA: TStringField
      FieldName = 'PMT_SOLO_TIMBMENSA'
      Size = 1
    end
    object selT020TIMBRATURAMENSA_DETRTOT: TStringField
      FieldName = 'TIMBRATURAMENSA_DETRTOT'
      Size = 1
    end
    object selT020PM_OREMINIME_INF: TStringField
      FieldName = 'PM_OREMINIME_INF'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020PM_STACCO_INF: TStringField
      FieldName = 'PM_STACCO_INF'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020MINIMISTR_COMP: TStringField
      FieldName = 'MINIMISTR_COMP'
      Size = 1
    end
    object selT020CAUSALE_FASCE: TStringField
      FieldName = 'CAUSALE_FASCE'
      Size = 5
    end
    object selT020RICALCOLO_SPOSTA_PN: TStringField
      FieldName = 'RICALCOLO_SPOSTA_PN'
      Size = 1
    end
    object selT020RICALCOLO_OFF_NOTIMB: TStringField
      FieldName = 'RICALCOLO_OFF_NOTIMB'
      Size = 1
    end
    object selT020RICALCOLO_DEB_MIN: TStringField
      FieldName = 'RICALCOLO_DEB_MIN'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020RICALCOLO_DEB_MAX: TStringField
      FieldName = 'RICALCOLO_DEB_MAX'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT020RICALCOLO_CAUS_NEG: TStringField
      FieldName = 'RICALCOLO_CAUS_NEG'
      Size = 5
    end
    object selT020RICALCOLO_CAUS_POS: TStringField
      FieldName = 'RICALCOLO_CAUS_POS'
      Size = 5
    end
    object selT020PMT_LIMITE_FLEX: TStringField
      FieldName = 'PMT_LIMITE_FLEX'
      Size = 1
    end
    object selT020TIMBRATURAMENSA_FLEX: TStringField
      FieldName = 'TIMBRATURAMENSA_FLEX'
      Size = 1
    end
    object selT020XPARAM: TStringField
      FieldName = 'XPARAM'
      Size = 1000
    end
    object selT020SPEZZNONCAUS_SCARTOECC: TStringField
      FieldName = 'SPEZZNONCAUS_SCARTOECC'
      Size = 1
    end
    object selT020FLEXDOPOMEZZANOTTE: TStringField
      FieldName = 'FLEXDOPOMEZZANOTTE'
      Size = 1
    end
    object selT020INTERSEZ_AUTOGIUST: TStringField
      FieldName = 'INTERSEZ_AUTOGIUST'
      Size = 1
    end
    object selT020RIPCOM_GGNONLAV: TStringField
      FieldName = 'RIPCOM_GGNONLAV'
      Size = 1
    end
    object selT020PMT_NOTIMBCONSECUTIVE: TStringField
      FieldName = 'PMT_NOTIMBCONSECUTIVE'
      Size = 1
    end
    object selT020PMT_USCITARIT: TStringField
      FieldName = 'PMT_USCITARIT'
      Size = 1
    end
    object selT020CAUSALI_ECCEDENZA: TStringField
      FieldName = 'CAUSALI_ECCEDENZA'
    end
    object selT020ARRSCOSTR_SOTTOSOGLIA: TStringField
      FieldName = 'ARRSCOSTR_SOTTOSOGLIA'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020RIENTRO_POMERIDIANO: TStringField
      FieldName = 'RIENTRO_POMERIDIANO'
      Size = 1
    end
    object selT020FESTLAV_LIQ: TStringField
      FieldName = 'FESTLAV_LIQ'
      Size = 5
    end
    object selT020FESTLAV_CMP_LIQ: TStringField
      FieldName = 'FESTLAV_CMP_LIQ'
      Size = 5
    end
    object selT020FESTLAV_CMP_LIQ_TURN: TStringField
      FieldName = 'FESTLAV_CMP_LIQ_TURN'
      Size = 5
    end
    object selT020CAUSALE_DISABIL_BLOCCANTE: TStringField
      FieldName = 'CAUSALE_DISABIL_BLOCCANTE'
      Size = 1
    end
    object selT020FASCIA_NOTTFEST_COMPLETA: TStringField
      FieldName = 'FASCIA_NOTTFEST_COMPLETA'
      Size = 1
    end
    object selT020INDFESTIVA_USA_NOTTE_COMPLETA: TStringField
      FieldName = 'INDFESTIVA_USA_NOTTE_COMPLETA'
      Size = 1
    end
    object selT020MAXSCOSTR: TStringField
      FieldName = 'MAXSCOSTR'
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selT020POSTICIPA_CAUS_TIMB_INTERSEC: TStringField
      FieldName = 'POSTICIPA_CAUS_TIMB_INTERSEC'
      Size = 1
    end
    object selT020ANOM_BLOCC_23LIV: TStringField
      FieldName = 'ANOM_BLOCC_23LIV'
      Size = 1000
    end
    object selT020CAUSALI_ECCCOMP: TStringField
      FieldName = 'CAUSALI_ECCCOMP'
    end
  end
end
