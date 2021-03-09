inherited A123FPartecipazioniSindacatiDtM: TA123FPartecipazioniSindacatiDtM
  OldCreateOrder = True
  Height = 75
  Width = 87
  object selT247: TOracleDataSet
    SQL.Strings = (
      'select T247.*, T247.ROWID'
      'from T247_PARTECIPAZIONISINDACATI T247'
      'where progressivo = :PROGRESSIVO'
      'order by DADATA, COD_SINDACATO, COD_ORGANISMO ')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F000100000000001A00000043004F0044005F00530049004E00440041004300
      410054004F000100000000000C00000044004100440041005400410001000000
      00000A000000410044004100540041000100000000001A00000043004F004400
      5F004F005200470041004E00490053004D004F00010000000000}
    BeforeInsert = selT247BeforeInsert
    BeforePost = BeforePostNoStorico
    OnCalcFields = selT247CalcFields
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 16
    object selT247PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT247DADATA: TDateTimeField
      DisplayLabel = 'Da data'
      DisplayWidth = 10
      FieldName = 'DADATA'
      Required = True
      OnValidate = selT247DADATAValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT247ADATA: TDateTimeField
      DisplayLabel = 'A data'
      DisplayWidth = 10
      FieldName = 'ADATA'
      OnValidate = selT247ADATAValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT247COD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      FieldName = 'COD_SINDACATO'
      Required = True
      OnChange = selT247COD_SINDACATOChange
      Size = 10
    end
    object selT247DESC_SINDACATO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'DESC_SINDACATO'
      Size = 50
      Calculated = True
    end
    object selT247COD_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      FieldName = 'COD_ORGANISMO'
      Required = True
      OnChange = selT247COD_ORGANISMOChange
      Size = 5
    end
    object selT247DESC_ORGANISMO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DESC_ORGANISMO'
      Size = 50
      Calculated = True
    end
  end
end
