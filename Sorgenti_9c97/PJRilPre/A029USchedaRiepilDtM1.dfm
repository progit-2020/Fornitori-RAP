object A029FSchedaRiepilDtM1: TA029FSchedaRiepilDtM1
  OldCreateOrder = True
  OnCreate = A029FSchedaRiepilDtM1Create
  OnDestroy = A029FSchedaRiepilDtM1Destroy
  Height = 239
  Width = 705
  object Q070: TOracleDataSet
    SQL.Strings = (
      'SELECT T070.*,T070.ROWID FROM T070_SchedaRiepil T070'
      'WHERE Progressivo = :Progressivo'
      'ORDER BY Data')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000002600000016000000500052004F004700520045005300530049005600
      4F00010000000000080000004400410054004100010000000000180000004400
      45004200490054004F004F0052004100520049004F0001000000000010000000
      440045004200490054004F0050004F000100000000000C000000540049005000
      4F0050004F000100000000001800000046004500530054004900560049004E00
      54004500520041000100000000001A0000004600450053005400490056005200
      490044004F005400540041000100000000001600000049004E00440054005500
      52004E004F004E0055004D000100000000001600000049004E00440054005500
      52004E004F004F00520045000100000000001C00000043004100550053004100
      4C00450031004D0049004E004100530053000100000000001C00000043004100
      5500530041004C00450032004D0049004E004100530053000100000000001800
      00004F00520045004500430043004500440043004F004D005000010000000000
      0C0000005400550052004E00490031000100000000000C000000540055005200
      4E00490032000100000000000C0000005400550052004E004900330001000000
      00000C0000005400550052004E00490034000100000000001400000047004700
      500052004500530045004E005A0041000100000000000E000000470047005600
      55004F0054004900010000000000180000004F00520045005600410052004900
      41005A00450043004300010000000000140000004F0052004500410053005300
      45004E005A0045000100000000001600000052004500430041004E004E004F00
      43004F00520052000100000000001600000052004500430041004E004E004F00
      500052004500430001000000000010000000530043004F00530054004E004500
      47000100000000000C00000052004900500043004F004D000100000000001200
      000041004200420052004900500043004F004D000100000000001A0000004100
      4400440045004200490054004F00500041004700480045000100000000001400
      00005200450043004C004900510043004F005200520001000000000014000000
      5200450043004C00490051005000520045004300010000000000200000004C00
      490051005F00460055004F00520049005F004200550044004700450054000100
      00000000220000004F005200450043004F004D0050005F004C00490051005500
      49004400410054004500010000000000240000004F005200450043004F004D00
      50005F0052004500430055005000450052004100540045000100000000002800
      000043004100520045004E005A0041005F004F00420042004C00490047004100
      54004F005200490041000100000000002E0000004F0052004500450043004300
      4500440043004F004D0050004F004C0054005200450053004F0047004C004900
      4100010000000000120000004F00520045005F0049004E00410049004C000100
      000000002000000046004500530054004900560049004E005400450052004100
      5F00560041005200010000000000220000004600450053005400490056005200
      490044004F005400540041005F005600410052000100000000001E0000004900
      4E0044005400550052004E004F004E0055004D005F0056004100520001000000
      00001E00000049004E0044005400550052004E004F004F00520045005F005600
      41005200010000000000}
    CachedUpdates = True
    BeforeInsert = Q070BeforeInsert
    AfterInsert = Q070AfterInsert
    AfterEdit = Q070AfterEdit
    BeforePost = Q070BeforePost
    AfterPost = Q070AfterPost
    AfterCancel = Q070AfterCancel
    BeforeDelete = Q070BeforeDelete
    AfterDelete = Q070AfterDelete
    BeforeScroll = Q070BeforeScroll
    AfterScroll = Q070AfterScroll
    OnNewRecord = Q070NewRecord
    Left = 8
    Top = 8
    object Q070PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q070DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q070DEBITOORARIO: TStringField
      FieldName = 'DEBITOORARIO'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object Q070DEBITOPO: TStringField
      FieldName = 'DEBITOPO'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object Q070TIPOPO: TStringField
      FieldName = 'TIPOPO'
      Size = 1
    end
    object Q070FESTIVINTERA: TFloatField
      FieldName = 'FESTIVINTERA'
    end
    object Q070FESTIVINTERA_VAR: TFloatField
      FieldName = 'FESTIVINTERA_VAR'
    end
    object Q070FESTIVRIDOTTA: TFloatField
      FieldName = 'FESTIVRIDOTTA'
    end
    object Q070FESTIVRIDOTTA_VAR: TFloatField
      FieldName = 'FESTIVRIDOTTA_VAR'
    end
    object Q070INDTURNONUM: TFloatField
      FieldName = 'INDTURNONUM'
    end
    object Q070INDTURNONUM_VAR: TIntegerField
      FieldName = 'INDTURNONUM_VAR'
    end
    object Q070INDTURNOORE: TStringField
      FieldName = 'INDTURNOORE'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object Q070INDTURNOORE_VAR: TStringField
      FieldName = 'INDTURNOORE_VAR'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!#00:00;1;_'
      Size = 6
    end
    object Q070CAUSALE1MINASS: TStringField
      FieldName = 'CAUSALE1MINASS'
      OnValidate = BDEQ070CAUSALE1MINASSValidate
      EditMask = '!900:00;1;_'
      Size = 5
    end
    object Q070CAUSALE2MINASS: TStringField
      DisplayLabel = 'CAUSALE1MINASS'
      FieldName = 'CAUSALE2MINASS'
      OnValidate = BDEQ070CAUSALE1MINASSValidate
      EditMask = '!900:00;1;_'
      Size = 5
    end
    object Q070OREECCEDCOMP: TStringField
      FieldName = 'OREECCEDCOMP'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object Q070TURNI1: TFloatField
      FieldName = 'TURNI1'
    end
    object Q070TURNI2: TFloatField
      FieldName = 'TURNI2'
    end
    object Q070TURNI3: TFloatField
      FieldName = 'TURNI3'
    end
    object Q070TURNI4: TFloatField
      FieldName = 'TURNI4'
    end
    object Q070GGPRESENZA: TFloatField
      FieldName = 'GGPRESENZA'
    end
    object Q070GGVUOTI: TFloatField
      FieldName = 'GGVUOTI'
    end
    object Q070OREVARIAZECC: TStringField
      FieldName = 'OREVARIAZECC'
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!##00:00;1;_'
      Size = 7
    end
    object Q070OREASSENZE: TStringField
      FieldName = 'OREASSENZE'
      ReadOnly = True
      OnValidate = BDEQ070DEBITOORARIOValidate
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object Q070D_Causale1: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Causale1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE1MINASS'
      Size = 40
      Lookup = True
    end
    object Q070D_Causale2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Causale2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE2MINASS'
      Size = 40
      Lookup = True
    end
    object Q070RECANNOCORR: TStringField
      FieldName = 'RECANNOCORR'
      Origin = 'T070_SCHEDARIEPIL.RECANNOCORR'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070RECANNOPREC: TStringField
      FieldName = 'RECANNOPREC'
      Origin = 'T070_SCHEDARIEPIL.RECANNOPREC'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070SCOSTNEG: TStringField
      FieldName = 'SCOSTNEG'
      Origin = 'T070_SCHEDARIEPIL.SCOSTNEG'
      EditMask = '!-000:00;1;_'
      Size = 7
    end
    object Q070RIPCOM: TStringField
      FieldName = 'RIPCOM'
      Origin = 'T070_SCHEDARIEPIL.RIPCOM'
      ReadOnly = True
      EditMask = '!###0:00;1;_'
      Size = 7
    end
    object Q070ABBRIPCOM: TStringField
      FieldName = 'ABBRIPCOM'
      Origin = 'T070_SCHEDARIEPIL.ABBRIPCOM'
      ReadOnly = True
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070ADDEBITOPAGHE: TStringField
      FieldName = 'ADDEBITOPAGHE'
      Origin = 'T070_SCHEDARIEPIL.ADDEBITOPAGHE'
      Size = 7
    end
    object Q070RECLIQCORR: TStringField
      FieldName = 'RECLIQCORR'
      Size = 6
    end
    object Q070RECLIQPREC: TStringField
      FieldName = 'RECLIQPREC'
      Size = 6
    end
    object Q070ORECOMP_LIQUIDATE: TStringField
      FieldName = 'ORECOMP_LIQUIDATE'
      OnValidate = Q070ORECOMP_LIQUIDATEValidate
      EditMask = '!9990:00;1;_'
      Size = 7
    end
    object Q070LIQ_FUORI_BUDGET: TFloatField
      FieldName = 'LIQ_FUORI_BUDGET'
      ReadOnly = True
    end
    object Q070ORECOMP_RECUPERATE: TStringField
      FieldName = 'ORECOMP_RECUPERATE'
      OnValidate = Q070ORECOMP_RECUPERATEValidate
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070OREECCEDCOMPOLTRESOGLIA: TStringField
      FieldName = 'OREECCEDCOMPOLTRESOGLIA'
      OnValidate = Q070ORECOMP_RECUPERATEValidate
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070ORE_INAIL: TStringField
      FieldName = 'ORE_INAIL'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object Q070RIPOSI_NONFRUITI: TIntegerField
      FieldName = 'RIPOSI_NONFRUITI'
    end
    object Q070RIPOSINONFRUITIORE: TStringField
      FieldName = 'RIPOSINONFRUITIORE'
      Size = 7
    end
    object Q070BANCAORE_LIQ_VAR: TStringField
      FieldName = 'BANCAORE_LIQ_VAR'
      OnValidate = Q070ORECOMP_LIQUIDATEValidate
      EditMask = '!#990:00;1;_'
      Size = 7
    end
  end
  object SumReperibilita: TOracleDataSet
    SQL.Strings = (
      'select sum(oreminuti(orepresenza)) RepLiq'
      'from t074_causpresfasce t074,'
      't275_caupresenze t275,'
      't270_raggrpresenze t270'
      
        'where progressivo = :PROGRESSIVO and data between :DADATA and :A' +
        'DATA and'
      'causale = t275.codice and '
      'codraggr = t270.codice and'
      'codinterno = '#39'C'#39' and'
      'orenormali = '#39'A'#39)
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 76
    Top = 8
  end
end
