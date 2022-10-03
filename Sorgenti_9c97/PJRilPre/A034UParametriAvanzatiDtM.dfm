inherited A034FParametriAvanzatiDtM: TA034FParametriAvanzatiDtM
  OldCreateOrder = True
  Height = 205
  Width = 403
  object selT193: TOracleDataSet
    SQL.Strings = (
      'SELECT T193.*,ROWID '
      'FROM T193_VOCIPAGHE_PARAMETRI T193 '
      'ORDER BY COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA')
    ReadBuffer = 100
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E0000001400000056004F00430045005F0050004100470048004500
      0100000000002600000056004F00430045005F00500041004700480045005F00
      4E00450047004100540049005600410001000000000016000000440045005300
      4300520049005A0049004F004E00450001000000000006000000440041004C00
      0100000000000400000041004C00010000000000160000004100550054004F00
      49004E0043005F00440041004C00010000000000140000004100550054004F00
      49004E0043005F0041004C000100000000001E00000043004F0044005F004900
      4E00540045005200460041004300430049004100010000000000140000004400
      450043004F005200520045004E005A0041000100000000002600000056004F00
      430045005F00500041004700480045005F004300450044004F004C0049004E00
      4F000100000000001C0000004100520052004F0054004F004E00440041004D00
      45004E0054004F000100000000000E00000046004F0052004D0055004C004100
      0100000000001A000000530050004F005300540041005F00560041004C004900
      4D0050000100000000001A000000530050004F005300540041005F0056004100
      4C00510054004100010000000000}
    BeforePost = BeforePost
    Left = 48
    Top = 32
    object selT193COD_INTERFACCIA: TStringField
      DisplayLabel = 'Interfaccia'
      FieldName = 'COD_INTERFACCIA'
      Required = True
    end
    object selT193VOCE_PAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCE_PAGHE'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selT193DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT193DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT193VOCE_PAGHE_CEDOLINO: TStringField
      DisplayLabel = 'Voce paghe cedolino'
      FieldName = 'VOCE_PAGHE_CEDOLINO'
      Size = 10
    end
    object selT193VOCE_PAGHE_NEGATIVA: TStringField
      DisplayLabel = 'Valore negativo'
      FieldName = 'VOCE_PAGHE_NEGATIVA'
      Size = 10
    end
    object selT193DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 7
      FieldName = 'DAL'
      OnGetText = selT193DALGetText
      OnSetText = selT193DALSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selT193AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 7
      FieldName = 'AL'
      OnGetText = selT193DALGetText
      OnSetText = selT193DALSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selT193AUTOINC_DAL: TStringField
      DisplayLabel = 'Inc.aut.Dal'
      FieldName = 'AUTOINC_DAL'
      Size = 1
    end
    object selT193AUTOINC_AL: TStringField
      DisplayLabel = 'Inc.aut.Al'
      FieldName = 'AUTOINC_AL'
      Size = 1
    end
    object selT193DESC_VPAGHE_NEGATIVA: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_VPAGHE_NEGATIVA'
      LookupDataSet = A034FParametriAvanzatiMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VOCE_PAGHE_NEGATIVA'
      Size = 50
      Lookup = True
    end
    object selT193DESC_VPAGHE_CEDOLINO: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_VPAGHE_CEDOLINO'
      LookupDataSet = A034FParametriAvanzatiMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VOCE_PAGHE_CEDOLINO'
      Size = 50
      Lookup = True
    end
    object selT193ARROTONDAMENTO: TFloatField
      DisplayLabel = 'Arrotondamento'
      FieldName = 'ARROTONDAMENTO'
    end
    object selT193FORMULA: TStringField
      FieldName = 'FORMULA'
      Size = 200
    end
    object selT193SPOSTA_VALIMP: TStringField
      FieldName = 'SPOSTA_VALIMP'
      Size = 1
    end
  end
  object selT195: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from t195_vocivariabili'
      'where vocepaghe = :VOCEPAGHE'
      '  and progressivo in (select progressivo from t430_storico t'
      
        '                       where datadecorrenza = (select max(datade' +
        'correnza) from t430_storico'
      
        '                                                where progressiv' +
        'o = t.progressivo'
      
        '                                                  and datafine >' +
        '= :DECORRENZA)'
      '                         and :INTERFACCIA)'
      '  and data_cassa >= :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0056004F004300450050004100470048004500
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000180000003A0049004E0054004500
      5200460041004300430049004100010000000000000000000000}
    Left = 112
    Top = 136
  end
end
