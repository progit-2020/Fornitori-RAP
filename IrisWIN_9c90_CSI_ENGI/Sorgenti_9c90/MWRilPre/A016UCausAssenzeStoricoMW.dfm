inherited A016FCausAssenzeStoricoMW: TA016FCausAssenzeStoricoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 268
  Width = 233
  object selT230: TOracleDataSet
    SQL.Strings = (
      'select T230.*, T230.ROWID'
      'from T230_CAUASSENZE_PARSTO T230'
      'where T230.id = :ID'
      'order by T230.ID, T230.DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 40
    Top = 80
    object selT230ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selT230DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selT230DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Fine decorrenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selT230CODICE: TStringField
      DisplayLabel = 'Causale'
      FieldKind = fkLookup
      FieldName = 'CODICE'
      LookupDataSet = selT265
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Size = 5
      Lookup = True
    end
    object selT230DESC_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupDataSet = selT265
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT230DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione periodo'
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT230VALORGIOR: TStringField
      FieldName = 'VALORGIOR'
      Visible = False
      Size = 1
    end
    object selT230VALORGIOR_ORE: TStringField
      FieldName = 'VALORGIOR_ORE'
      Visible = False
      OnValidate = ValidaCampoOrario
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT230VALORGIOR_COMP: TStringField
      FieldName = 'VALORGIOR_COMP'
      Visible = False
      Size = 1
    end
    object selT230VALORGIOR_ORECOMP: TStringField
      FieldName = 'VALORGIOR_ORECOMP'
      Visible = False
      OnValidate = ValidaCampoOrario
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT230VALORGIOR_ORE_PROPPT: TStringField
      FieldName = 'VALORGIOR_ORE_PROPPT'
      Visible = False
      Size = 1
    end
    object selT230HMASSENZA: TStringField
      FieldName = 'HMASSENZA'
      Visible = False
      OnValidate = ValidaCampoOrario
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT230HMASSENZA_PROPPT: TStringField
      FieldName = 'HMASSENZA_PROPPT'
      Visible = False
      Size = 1
    end
    object selT230CAUSALI_COMPATIBILI: TStringField
      FieldName = 'CAUSALI_COMPATIBILI'
      Visible = False
      OnGetText = selT230CAUSALI_COMPATIBILIGetText
      Size = 2000
    end
    object selT230STATO_COMPATIBILITA: TStringField
      FieldName = 'STATO_COMPATIBILITA'
      Visible = False
      Size = 1
    end
    object selT230CAUSALI_CHECKCOMPETENZE: TStringField
      FieldName = 'CAUSALI_CHECKCOMPETENZE'
      Visible = False
      Size = 100
    end
    object selT230CAUSALE_VISUALCOMPETENZE: TStringField
      FieldName = 'CAUSALE_VISUALCOMPETENZE'
      Size = 5
    end
    object selT230SCARICOPAGHE_FRUIZ_GG: TStringField
      FieldName = 'SCARICOPAGHE_FRUIZ_GG'
      Size = 1
    end
    object selT230SCARICOPAGHE_FRUIZ_ORE: TStringField
      FieldName = 'SCARICOPAGHE_FRUIZ_ORE'
      Size = 1
    end
    object selT230CAUSALE_FRUIZORE: TStringField
      FieldName = 'CAUSALE_FRUIZORE'
      Size = 5
    end
    object selT230CAUSALE_HMASSENZA: TStringField
      FieldName = 'CAUSALE_HMASSENZA'
      Size = 5
    end
    object selT230CHECK_SOLOCOMPETENZE: TStringField
      FieldName = 'CHECK_SOLOCOMPETENZE'
      Size = 1
    end
    object selT230ABBATTE_STRIND: TStringField
      FieldName = 'ABBATTE_STRIND'
      Size = 1
    end
    object selT230SCELTA_ORARIO: TStringField
      FieldName = 'SCELTA_ORARIO'
      Size = 1
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select ID,CODICE,DESCRIZIONE,TIPOCUMULO'
      'from T265_CAUASSENZE T'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 40
    Top = 16
  end
  object insT230Nuovo: TOracleQuery
    SQL.Strings = (
      
        'insert into t230_cauassenze_parsto(id,decorrenza,decorrenza_fine' +
        ',descrizione)'
      'values (:ID,:DECORRENZA,:DECORRENZA_FINE,:DESCRIZIONE)')
    Optimize = False
    Variables.Data = {
      0400000004000000060000003A00490044000300000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000200000003A004400450043004F005200520045004E005A0041005F00
      460049004E0045000C0000000000000000000000180000003A00440045005300
      4300520049005A0049004F004E004500050000000000000000000000}
    Left = 152
    Top = 80
  end
  object insT230NuovoCompleto: TOracleQuery
    SQL.Strings = (
      'insert into T230_CAUASSENZE_PARSTO ('
      '  ID,'
      '  :COLONNE'
      ')'
      'select '
      '  :ID,'
      '  :COLONNE'
      'from T230_CAUASSENZE_PARSTO where ID = :OLD_ID')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001000
      00003A0043004F004C004F004E004E0045000100000000000000000000000E00
      00003A004F004C0044005F0049004400030000000000000000000000}
    Left = 152
    Top = 136
  end
  object cdsStoriaParamStorizz: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 136
    object cdsStoriaParamStorizzDATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 250
      FieldName = 'DATO'
      Size = 250
    end
    object cdsStoriaParamStorizzDECORRENZA: TStringField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Size = 10
    end
    object cdsStoriaParamStorizzFINE_DECORRENZA: TStringField
      DisplayLabel = 'Termine'
      FieldName = 'FINE_DECORRENZA'
      Size = 10
    end
    object cdsStoriaParamStorizzVALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Size = 2000
    end
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 87
    Top = 15
  end
end
