inherited A163FTipoQuoteDtM: TA163FTipoQuoteDtM
  OldCreateOrder = True
  object selT765: TOracleDataSet
    SQL.Strings = (
      'SELECT T765.*,T765.ROWID FROM T765_TIPOQUOTE T765'
      'ORDER BY CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F0054004100010000000000140000004400
      450043004F005200520045004E005A0041000100000000002800000043004100
      5500530041004C0045005F0041005300530045005300540041004D0045004E00
      54004F0001000000000012000000560050005F0049004E005400450052004100
      01000000000020000000560050005F00500052004F0050004F0052005A004900
      4F004E0041005400410001000000000010000000560050005F004E0045005400
      5400410001000000000018000000560050005F004E0045005400540041005200
      49005300500001000000000018000000560050005F0052004900530050004100
      52004D0049004F000100000000001C000000560050005F004E004F0052004900
      53005000410052004D0049004F000100000000001E000000560050005F005100
      550041004E00540049005400410054004900560041000100000000000E000000
      4100430043004F004E0054004900010000000000}
    BeforePost = BeforePost
    BeforeDelete = BeforeDelete
    AfterScroll = selT765AfterScroll
    OnCalcFields = selT765CalcFields
    OnNewRecord = OnNewRecord
    Left = 48
    Top = 24
    object selT765DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT765CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT765DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT765TIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
    object selT765D_TIPOQUOTA: TStringField
      DisplayLabel = ' '
      DisplayWidth = 21
      FieldKind = fkCalculated
      FieldName = 'D_TIPOQUOTA'
      Size = 50
      Calculated = True
    end
    object selT765CAUSALE_ASSESTAMENTO: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE_ASSESTAMENTO'
      Size = 5
    end
    object selT765VP_INTERA: TStringField
      DisplayLabel = 'VP Intera'
      FieldName = 'VP_INTERA'
      Size = 6
    end
    object selT765VP_PROPORZIONATA: TStringField
      DisplayLabel = 'VP Proporzionata'
      FieldName = 'VP_PROPORZIONATA'
      Size = 6
    end
    object selT765VP_NETTA: TStringField
      DisplayLabel = 'VP Netta'
      FieldName = 'VP_NETTA'
      Size = 6
    end
    object selT765VP_NETTARISP: TStringField
      DisplayLabel = 'VP Netta+Risp'
      FieldName = 'VP_NETTARISP'
      Size = 6
    end
    object selT765VP_RISPARMIO: TStringField
      DisplayLabel = 'VP Risparmio'
      FieldName = 'VP_RISPARMIO'
      Size = 6
    end
    object selT765VP_NORISPARMIO: TStringField
      DisplayLabel = 'VP No Risparmio'
      FieldName = 'VP_NORISPARMIO'
      Size = 6
    end
    object selT765VP_QUANTITATIVA: TStringField
      DisplayLabel = 'VP Quantitativa'
      FieldName = 'VP_QUANTITATIVA'
      Size = 6
    end
    object selT765ACCONTI: TStringField
      DisplayLabel = 'Acconti'
      FieldName = 'ACCONTI'
    end
  end
end
