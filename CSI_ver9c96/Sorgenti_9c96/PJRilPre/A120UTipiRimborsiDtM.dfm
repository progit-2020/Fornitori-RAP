inherited A120FTIPIRIMBORSIDTM: TA120FTIPIRIMBORSIDTM
  OldCreateOrder = True
  Height = 87
  Width = 113
  object M020: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      '  from m020_tipirimborsi t'
      ' order by t.codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001E00
      000043004F00440049004300450056004F004300450050004100470048004500
      010000000000180000005300430041005200490043004F005000410047004800
      45000100000000002E0000004500530049005300540045004E005A0041004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      3A00000043004F00440049004300450056004F00430045005000410047004800
      450049004E00440045004E004E0049005400410053005500500050004C000100
      00000000340000005300430041005200490043004F0050004100470048004500
      49004E00440045004E004E0049005400410053005500500050004C0001000000
      000024000000500045005200430049004E00440045004E004E00490054004100
      53005500500050004C00010000000000260000004100520052004F0054004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      1A00000046004C00410047005F0041004E00540049004300490050004F000100
      00000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = M020AfterScroll
    OnCalcFields = M020CalcFields
    Left = 28
    Top = 24
    object M020CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object M020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object M020CODICEVOCEPAGHE: TStringField
      FieldName = 'CODICEVOCEPAGHE'
      Size = 6
    end
    object M020SCARICOPAGHE: TStringField
      FieldName = 'SCARICOPAGHE'
      Size = 1
    end
    object M020ESISTENZAINDENNITASUPPL: TStringField
      FieldName = 'ESISTENZAINDENNITASUPPL'
      Size = 1
    end
    object M020CODICEVOCEPAGHEINDENNITASUPPL: TStringField
      FieldName = 'CODICEVOCEPAGHEINDENNITASUPPL'
      Size = 6
    end
    object M020SCARICOPAGHEINDENNITASUPPL: TStringField
      FieldName = 'SCARICOPAGHEINDENNITASUPPL'
      Size = 1
    end
    object M020PERCINDENNITASUPPL: TFloatField
      FieldName = 'PERCINDENNITASUPPL'
      MaxValue = 100.000000000000000000
    end
    object M020ARROTINDENNITASUPPL: TStringField
      FieldName = 'ARROTINDENNITASUPPL'
      Size = 5
    end
    object M020FLAG_ANTICIPO: TStringField
      FieldName = 'FLAG_ANTICIPO'
      Required = True
      Size = 1
    end
    object M020CalcArrotIndennitaSuppl: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotIndennitaSuppl'
      Size = 40
      Calculated = True
    end
    object M020TIPO_QUANTITA: TStringField
      FieldName = 'TIPO_QUANTITA'
      Size = 1
    end
    object M020PERC_ANTICIPO: TFloatField
      FieldName = 'PERC_ANTICIPO'
      EditFormat = '###.##'
      MaxValue = 100.000000000000000000
    end
    object M020NOTE_FISSE: TStringField
      FieldName = 'NOTE_FISSE'
      Size = 500
    end
    object M020FLAG_MOTIVAZIONE: TStringField
      FieldName = 'FLAG_MOTIVAZIONE'
      Size = 1
    end
    object M020FLAG_TARGA: TStringField
      FieldName = 'FLAG_TARGA'
      Size = 1
    end
    object M020TIPO: TStringField
      FieldName = 'TIPO'
      Size = 5
    end
    object M020FLAG_MEZZO_PROPRIO: TStringField
      FieldName = 'FLAG_MEZZO_PROPRIO'
      Size = 1
    end
    object M020FLAG_NON_RIMBORSABILE: TStringField
      FieldName = 'FLAG_NON_RIMBORSABILE'
      Size = 1
    end
  end
end
