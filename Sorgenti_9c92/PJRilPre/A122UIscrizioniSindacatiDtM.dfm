inherited A122FIscrizioniSindacatiDtM: TA122FIscrizioniSindacatiDtM
  OldCreateOrder = True
  Height = 81
  Width = 79
  object selT246: TOracleDataSet
    SQL.Strings = (
      'select T246.*, T246.ROWID'
      'from T246_ISCRIZIONISINDACATI T246'
      'where progressivo = :PROGRESSIVO'
      'order by cod_sindacato, data_iscr')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001200000044004100540041005F0049005300430052000100
      000000001A0000004E0055004D005F00500052004F0054005F00490053004300
      52000100000000001A00000044004100540041005F004400450043005F004900
      5300430052000100000000001200000044004100540041005F00430045005300
      53000100000000001A0000004E0055004D005F00500052004F0054005F004300
      4500530053000100000000001800000044004100540041005F00440045004300
      5F004300450053000100000000001A00000043004F0044005F00530049004E00
      440041004300410054004F00010000000000}
    BeforeInsert = selT246BeforeInsert
    BeforePost = BeforePostNoStorico
    OnCalcFields = selT246CalcFields
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 16
    object selT246PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT246NUM_PROT_ISCR: TFloatField
      DisplayLabel = 'Pr.Iscriz.'
      DisplayWidth = 6
      FieldName = 'NUM_PROT_ISCR'
      Required = True
    end
    object selT246DATA_ISCR: TDateTimeField
      DisplayLabel = 'Comunic.Iscriz.'
      DisplayWidth = 10
      FieldName = 'DATA_ISCR'
      Required = True
      OnValidate = selT246DATA_ISCRValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT246DATA_DEC_ISCR: TDateTimeField
      DisplayLabel = 'Decorr.Iscriz'
      DisplayWidth = 10
      FieldName = 'DATA_DEC_ISCR'
      Required = True
      OnValidate = selT246DATA_DEC_ISCRValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT246NUM_PROT_CESS: TFloatField
      DisplayLabel = 'Pr.Cessaz.'
      DisplayWidth = 6
      FieldName = 'NUM_PROT_CESS'
    end
    object selT246DATA_CESS: TDateTimeField
      DisplayLabel = 'Comunic.Cessaz.'
      DisplayWidth = 10
      FieldName = 'DATA_CESS'
      OnValidate = selT246DATA_CESSValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT246DATA_DEC_CES: TDateTimeField
      DisplayLabel = 'Decorr.Cessaz.'
      DisplayWidth = 10
      FieldName = 'DATA_DEC_CES'
      OnValidate = selT246DATA_DEC_CESValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT246COD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 6
      FieldName = 'COD_SINDACATO'
      Required = True
      Visible = False
      OnChange = selT246COD_SINDACATOChange
      Size = 10
    end
    object selT246DESC_SINDACATO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'DESC_SINDACATO'
      Size = 50
      Calculated = True
    end
  end
end
