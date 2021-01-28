object A022FContrattiDtM1: TA022FContrattiDtM1
  OldCreateOrder = True
  OnCreate = A022FContrattiDtM1Create
  OnDestroy = A022FContrattiDtM1Destroy
  Height = 109
  Width = 372
  object D201: TDataSource
    DataSet = T201
    Left = 104
    Top = 8
  end
  object D210: TDataSource
    DataSet = T210
    Left = 168
    Top = 8
  end
  object T200: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T200.*,T200.ROWID FROM T200_CONTRATTI T200 ORDER BY CODIC' +
        'E')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000800
      00005400490050004F000100000000001000000049004E004400540055005200
      4E004F0001000000000018000000520045005000450052004900420049004C00
      490054004100010000000000160000004C00410056004F0052004F0053005500
      500050004C000100000000001800000048004C00410056004F0052004F005300
      5500500050004C00010000000000140000004D00410058005300540052004100
      4F00520044000100000000001400000049004E0044004E004F00540054004500
      440041000100000000001200000049004E0044004E004F005400540045004100
      0100000000001600000049004E0044004E004F00540054004500530054005200
      0100000000001400000049004E00440046004500530054005300540052000100
      000000001200000054004F004C0049004E0044004E004F005400010000000000
      1200000041005200520049004E0044004E004F0054000100000000001C000000
      44004100540041004400450043004F005200520045004E005A00410001000000
      00001C0000004D00410058005200450053004900440055004100420049004C00
      4500010000000000200000004100520052005F0049004E004400540055005200
      4E004F005F00500041004C00010000000000}
    AfterEdit = T200AfterEdit
    BeforePost = T200BeforePost
    AfterPost = T200AfterPost
    BeforeDelete = T200BeforeDelete
    AfterDelete = T200AfterDelete
    AfterScroll = T200AfterScroll
    OnNewRecord = T200NewRecord
    Left = 12
    Top = 8
    object T200Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T200Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object T200Tipo: TStringField
      FieldName = 'Tipo'
      Size = 3
    end
    object T200IndTurno: TStringField
      FieldName = 'IndTurno'
      Size = 1
    end
    object T200Reperibilita: TStringField
      FieldName = 'Reperibilita'
      OnValidate = BDET200ReperibilitaValidate
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object T200MaxStraord: TStringField
      FieldName = 'MaxStraord'
      OnValidate = BDET200ReperibilitaValidate
      EditMask = '!9990:00;1;_'
      Size = 7
    end
    object T200IndNotteDa: TDateTimeField
      FieldName = 'IndNotteDa'
      OnGetText = T200IndNotteDaGetText
      OnSetText = BDET200IndNotteDaSetText
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T200IndNotteA: TDateTimeField
      FieldName = 'IndNotteA'
      OnGetText = T200IndNotteDaGetText
      OnSetText = BDET200IndNotteDaSetText
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T200TOLINDNOT: TFloatField
      FieldName = 'TOLINDNOT'
      MaxValue = 99.000000000000000000
      Precision = 2
    end
    object T200ARRINDNOT: TFloatField
      FieldName = 'ARRINDNOT'
      MaxValue = 1440.000000000000000000
      Precision = 4
    end
    object T200DATADECORRENZA: TDateTimeField
      FieldName = 'DATADECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object T200MAXRESIDUABILE: TStringField
      FieldName = 'MAXRESIDUABILE'
      OnValidate = BDET200ReperibilitaValidate
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object T200ARR_INDTURNO_PAL: TStringField
      FieldName = 'ARR_INDTURNO_PAL'
      OnValidate = T200ARR_INDTURNO_PALValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T200ORE_LAVFASCE_CONASS: TStringField
      FieldName = 'ORE_LAVFASCE_CONASS'
      Size = 1
    end
  end
  object T201: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T201.*,T201.ROWID FROM T201_MAGGIORAZIONI T201 WHERE CODI' +
        'CE = :CODICE'
      'ORDER BY GIORNO')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    BeforeInsert = T201BeforeInsert
    BeforePost = T201BeforePost
    AfterPost = T201AfterPost
    BeforeDelete = T201BeforeDelete
    OnCalcFields = T201CalcFields
    Left = 76
    Top = 8
    object T201Codice: TStringField
      FieldName = 'Codice'
      Visible = False
      Size = 5
    end
    object T201Giorno: TStringField
      FieldName = 'Giorno'
      Visible = False
      Size = 1
    end
    object T201D_Giorno: TStringField
      DisplayLabel = 'Giorno'
      FieldKind = fkCalculated
      FieldName = 'D_Giorno'
      Size = 9
      Calculated = True
    end
    object T201FasciaDa1: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa1'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaDa1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA1: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA1'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaA1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior1: TStringField
      DisplayLabel = 'Fascia 1'
      FieldName = 'Maggior1'
      OnValidate = T201FasciaValidate
      Size = 5
    end
    object T201FasciaDa2: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa2'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaDa1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA2: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA2'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaA1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior2: TStringField
      DisplayLabel = 'Fascia 2'
      FieldName = 'Maggior2'
      OnValidate = T201FasciaValidate
      Size = 5
    end
    object T201FasciaDa3: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa3'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaDa1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA3: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA3'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaA1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior3: TStringField
      DisplayLabel = 'Fascia 3'
      FieldName = 'Maggior3'
      OnValidate = T201FasciaValidate
      Size = 5
    end
    object T201FasciaDa4: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa4'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaDa1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA4: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA4'
      OnGetText = T201FasciaDa1GetText
      OnSetText = BDET200IndNotteDaSetText
      OnValidate = BDET201FasciaA1Validate
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior4: TStringField
      DisplayLabel = 'Fascia 4'
      FieldName = 'Maggior4'
      OnValidate = T201FasciaValidate
      Size = 5
    end
  end
  object T210: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T210.*, T210.ROWID FROM T210_MAGGIORAZIONI T210 ORDER BY ' +
        'CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001A00
      00004D0041004700470049004F00520041005A0049004F004E00450001000000
      00001000000050004F00520045005F004C00410056000100000000001A000000
      50005300540052005F004E0045004C005F004D00450053004500010000000000
      10000000500049004E0044005F00540055005200010000000000120000005000
      4F00520045005F0043004F004D005000010000000000}
    BeforePost = T210BeforePost
    AfterPost = T210AfterDelete
    BeforeDelete = T210BeforeDelete
    AfterDelete = T210AfterDelete
    Left = 140
    Top = 8
    object T210Codice: TStringField
      FieldName = 'Codice'
      Size = 5
    end
    object T210Descrizione: TStringField
      DisplayWidth = 30
      FieldName = 'Descrizione'
      Size = 40
    end
    object T210Maggiorazione: TFloatField
      DisplayLabel = 'Magg.(%)'
      DisplayWidth = 6
      FieldName = 'Maggiorazione'
      EditFormat = '###'
      MaxValue = 100.000000000000000000
    end
    object T210PORE_LAV: TStringField
      DisplayLabel = 'Ore lavorate'
      FieldName = 'PORE_LAV'
      Size = 6
    end
    object T210PSTR_NEL_MESE: TStringField
      DisplayLabel = 'Ore liquidate'
      FieldName = 'PSTR_NEL_MESE'
      Size = 6
    end
    object T210PIND_TUR: TStringField
      DisplayLabel = 'Ore ind.turno'
      FieldName = 'PIND_TUR'
      Size = 6
    end
    object T210PORE_COMP: TStringField
      DisplayLabel = 'Banca ore'
      FieldName = 'PORE_COMP'
      Size = 6
    end
  end
  object Q201ModificaContr: TOracleQuery
    SQL.Strings = (
      'UPDATE T201_MAGGIORAZIONI SET CODICE = :CODICE'
      'WHERE CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000}
    Left = 232
    Top = 8
  end
end
