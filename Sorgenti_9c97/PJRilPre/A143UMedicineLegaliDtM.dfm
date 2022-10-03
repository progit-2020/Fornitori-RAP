inherited A143FMedicineLegaliDtm: TA143FMedicineLegaliDtm
  OldCreateOrder = True
  Height = 185
  Width = 292
  object selT485: TOracleDataSet
    SQL.Strings = (
      'select T485.*, T485.ROWID'
      'from   T485_MEDICINELEGALI T485'
      'order by T485.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001400
      000043004F0044005F0043004F004D0055004E00450001000000000012000000
      49004E0044004900520049005A005A004F000100000000000600000043004100
      500001000000000010000000540045004C00450046004F004E004F0001000000
      00000A00000045004D00410049004C00010000000000}
    BeforePost = BeforePostNoStorico
    Left = 40
    Top = 24
    object selT485CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selT485DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 60
    end
    object selT485COD_COMUNE: TStringField
      FieldName = 'COD_COMUNE'
      OnValidate = selT485COD_COMUNEValidate
      Size = 6
    end
    object selT485INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object selT485CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT485TELEFONO: TStringField
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selT485EMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 40
    end
    object selT485D_COMUNE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_COMUNE'
      LookupDataSet = selT480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE'
      Lookup = True
    end
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'select * from T480_COMUNI'
      'order by citta')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 128
    Top = 24
  end
  object dscT480: TDataSource
    DataSet = selT480
    Left = 128
    Top = 80
  end
end
