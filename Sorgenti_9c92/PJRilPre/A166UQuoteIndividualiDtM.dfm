inherited A166FQuoteIndividualiDtM: TA166FQuoteIndividualiDtM
  OldCreateOrder = True
  Height = 243
  Width = 393
  object selT775: TOracleDataSet
    SQL.Strings = (
      'select T775.*,T775.rowid '
      'from T775_QUOTEINDIVIDUALI T775'
      'where PROGRESSIVO =:PROGRESSIVO'
      'order by DECORRENZA,CODTIPOQUOTA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004400450043004F005200520045004E005A004100
      01000000000010000000530043004100440045004E005A004100010000000000
      1800000043004F0044005400490050004F00510055004F005400410001000000
      00001C000000500045004E0041004C0049005A005A0041005A0049004F004E00
      450001000000000014000000530041004C0054004100500052004F0056004100
      0100000000000E00000049004D0050004F00520054004F000100000000000E00
      00004E0055004D005F004F005200450001000000000020000000500045005200
      43005F0049004E0044004900560049004400550041004C004500010000000000
      2000000050004500520043005F00530054005200550054005400550052004100
      4C0045000100000000001E00000043004F004E00530049004400450052004100
      5F00530041004C0044004F000100000000001600000050004500520043004500
      4E005400550041004C0045000100000000001600000053004F00530050004500
      4E00440049005F00500054000100000000001C00000053004F00530050004500
      4E00440049005F00510055004F0054004500010000000000}
    BeforePost = selT775BeforePost
    AfterPost = selT775AfterPost
    AfterScroll = selT775AfterScroll
    OnNewRecord = selT775NewRecord
    Left = 16
    Top = 16
    object selT775PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      DisplayWidth = 5
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT775DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      OnValidate = selT775DECORRENZAValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT775SCADENZA: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      OnValidate = selT775DECORRENZAValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT775CODTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      OnValidate = selT775DECORRENZAValidate
      Size = 5
    end
    object selT775D_TIPOQUOTA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selT775PENALIZZAZIONE: TFloatField
      DisplayLabel = 'Penalizzazione'
      DisplayWidth = 20
      FieldName = 'PENALIZZAZIONE'
      MaxValue = 100.000000000000000000
    end
    object selT775SALTAPROVA: TStringField
      FieldName = 'SALTAPROVA'
      Size = 1
    end
    object selT775IMPORTO: TFloatField
      FieldName = 'IMPORTO'
      DisplayFormat = '###,###,###,##0.#####'
    end
    object selT775NUM_ORE: TStringField
      FieldName = 'NUM_ORE'
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT775PERC_INDIVIDUALE: TFloatField
      FieldName = 'PERC_INDIVIDUALE'
    end
    object selT775PERC_STRUTTURALE: TFloatField
      FieldName = 'PERC_STRUTTURALE'
    end
    object selT775CONSIDERA_SALDO: TStringField
      FieldName = 'CONSIDERA_SALDO'
      Size = 1
    end
    object selT775PERCENTUALE: TFloatField
      FieldName = 'PERCENTUALE'
      OnValidate = selT775PERCENTUALEValidate
    end
    object selT775SOSPENDI_PT: TStringField
      FieldName = 'SOSPENDI_PT'
      Size = 1
    end
    object selT775SOSPENDI_QUOTE: TStringField
      FieldName = 'SOSPENDI_QUOTE'
      Size = 1
    end
  end
  object dsrT765: TDataSource
    Left = 64
    Top = 64
  end
  object selT430: TOracleQuery
    SQL.Strings = (
      'select count(distinct inizio) '
      ' from t430_storico'
      'where progressivo = :PROG'
      '  and datadecorrenza <= :FINE'
      '  and datafine >= :INIZIO'
      '  and inizio <= :FINE'
      '  and nvl(fine,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) >= :INIZIO'
      '  ')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00460049004E0045000C000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000
      0A0000003A00500052004F004700030000000000000000000000}
    Left = 184
    Top = 112
  end
end
