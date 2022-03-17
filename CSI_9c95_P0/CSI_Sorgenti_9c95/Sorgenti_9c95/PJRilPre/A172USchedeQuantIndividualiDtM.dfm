inherited A172FSchedeQuantIndividualiDtM: TA172FSchedeQuantIndividualiDtM
  OldCreateOrder = True
  Width = 675
  object selT767: TOracleDataSet
    SQL.Strings = (
      'select t767.*, t767.rowid '
      'from t767_incquantgruppo t767'
      'order by anno, codgruppo, codtipoquota')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000240000001200000043004F004400470052005500500050004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001E000000460049004C00540052004F005F0041004E00410047005200
      4100460045000100000000001800000043004F0044005400490050004F005100
      55004F00540041000100000000000E0000004400410054004100520049004600
      0100000000000800000041004E004E004F000100000000001A0000004E005500
      4D004F00520045005F0054004F00540041004C0045000100000000001C000000
      49004D0050004F00520054004F005F0054004F00540041004C00450001000000
      00001200000050004100470031005F0050004500520043000100000000001000
      000050004100470031005F004D00410058000100000000001200000050004100
      470032005F005000450052004300010000000000100000005000410047003200
      5F004D00410058000100000000001200000050004100470033005F0050004500
      520043000100000000001000000050004100470033005F004D00410058000100
      000000001200000050004100470034005F005000450052004300010000000000
      1000000050004100470034005F004D0041005800010000000000120000005000
      4100470035005F00500045005200430001000000000010000000500041004700
      35005F004D00410058000100000000001200000050004100470036005F005000
      4500520043000100000000001000000050004100470036005F004D0041005800
      0100000000001200000050004100470037005F00500045005200430001000000
      00001000000050004100470037005F004D004100580001000000000012000000
      50004100470038005F0050004500520043000100000000001000000050004100
      470038005F004D00410058000100000000001200000050004100470039005F00
      50004500520043000100000000001000000050004100470039005F004D004100
      580001000000000014000000500041004700310030005F005000450052004300
      01000000000012000000500041004700310030005F004D004100580001000000
      000014000000500041004700310031005F005000450052004300010000000000
      12000000500041004700310031005F004D004100580001000000000014000000
      500041004700310032005F005000450052004300010000000000120000005000
      41004700310032005F004D00410058000100000000001400000054004F004C00
      4C004500520041004E005A0041000100000000000A0000005300540041005400
      4F00010000000000180000005300550050004500520056004900530049004F00
      4E00450001000000000020000000500052004F0047005F005300550050004500
      52005600490053004F0052004500010000000000}
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selT767AfterScroll
    OnFilterRecord = selT767FilterRecord
    OnNewRecord = selT767NewRecord
    Left = 32
    Top = 24
    object selT767ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
      OnValidate = selT767ANNOValidate
    end
    object selT767CODGRUPPO: TStringField
      FieldName = 'CODGRUPPO'
      Required = True
      Size = 10
    end
    object selT767DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT767FILTRO_ANAGRAFE: TStringField
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 4000
    end
    object selT767CODTIPOQUOTA: TStringField
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selT767NUMORE_TOTALE: TStringField
      FieldName = 'NUMORE_TOTALE'
      EditMask = '!990:00;1;_'
      Size = 9
    end
    object selT767IMPORTO_TOTALE: TFloatField
      FieldName = 'IMPORTO_TOTALE'
      DisplayFormat = '###,###,###,##0.00'
    end
    object selT767DATARIF: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATARIF'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT767PAG1_PERC: TFloatField
      DisplayLabel = 'Gen: % ore'
      FieldName = 'PAG1_PERC'
    end
    object selT767PAG1_MAX: TStringField
      DisplayLabel = 'Gen: max ore'
      FieldName = 'PAG1_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG2_PERC: TFloatField
      DisplayLabel = 'Feb: % ore'
      FieldName = 'PAG2_PERC'
    end
    object selT767PAG2_MAX: TStringField
      DisplayLabel = 'Feb: max ore'
      FieldName = 'PAG2_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG3_PERC: TFloatField
      DisplayLabel = 'Mar: % ore'
      FieldName = 'PAG3_PERC'
    end
    object selT767PAG3_MAX: TStringField
      DisplayLabel = 'Mar: max ore'
      FieldName = 'PAG3_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG4_PERC: TFloatField
      DisplayLabel = 'Apr: % ore'
      FieldName = 'PAG4_PERC'
    end
    object selT767PAG4_MAX: TStringField
      DisplayLabel = 'Apr: max ore'
      FieldName = 'PAG4_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG5_PERC: TFloatField
      DisplayLabel = 'Mag: % ore'
      FieldName = 'PAG5_PERC'
    end
    object selT767PAG5_MAX: TStringField
      DisplayLabel = 'Mag: max ore'
      FieldName = 'PAG5_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG6_PERC: TFloatField
      DisplayLabel = 'Giu: % ore'
      FieldName = 'PAG6_PERC'
    end
    object selT767PAG6_MAX: TStringField
      DisplayLabel = 'Giu: max ore'
      FieldName = 'PAG6_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG7_PERC: TFloatField
      DisplayLabel = 'Lug: % ore'
      FieldName = 'PAG7_PERC'
    end
    object selT767PAG7_MAX: TStringField
      DisplayLabel = 'Lug: max ore'
      FieldName = 'PAG7_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG8_PERC: TFloatField
      DisplayLabel = 'Ago: % ore'
      FieldName = 'PAG8_PERC'
    end
    object selT767PAG8_MAX: TStringField
      DisplayLabel = 'Ago: max ore'
      FieldName = 'PAG8_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG9_PERC: TFloatField
      DisplayLabel = 'Set: % ore'
      FieldName = 'PAG9_PERC'
    end
    object selT767PAG9_MAX: TStringField
      DisplayLabel = 'Set: max ore'
      FieldName = 'PAG9_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG10_PERC: TFloatField
      DisplayLabel = 'Ott: % ore'
      FieldName = 'PAG10_PERC'
    end
    object selT767PAG10_MAX: TStringField
      DisplayLabel = 'Ott: max ore'
      FieldName = 'PAG10_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG11_PERC: TFloatField
      DisplayLabel = 'Nov: % ore'
      FieldName = 'PAG11_PERC'
    end
    object selT767PAG11_MAX: TStringField
      DisplayLabel = 'Nov: max ore'
      FieldName = 'PAG11_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767PAG12_PERC: TFloatField
      DisplayLabel = 'Dic: % ore'
      FieldName = 'PAG12_PERC'
    end
    object selT767PAG12_MAX: TStringField
      DisplayLabel = 'Dic: max ore'
      FieldName = 'PAG12_MAX'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selT767TOLLERANZA: TFloatField
      FieldName = 'TOLLERANZA'
    end
    object selT767STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
    object selT767SUPERVISIONE: TStringField
      FieldName = 'SUPERVISIONE'
      Size = 1
    end
    object selT767PROG_SUPERVISORE: TFloatField
      FieldName = 'PROG_SUPERVISORE'
    end
  end
  object dsrT765: TDataSource
    Left = 176
    Top = 72
  end
end
