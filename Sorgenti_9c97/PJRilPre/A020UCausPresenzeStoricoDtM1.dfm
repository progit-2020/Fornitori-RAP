inherited A020FCausPresenzeStoricoDtM1: TA020FCausPresenzeStoricoDtM1
  OldCreateOrder = True
  Height = 73
  Width = 72
  object selT235: TOracleDataSet
    SQL.Strings = (
      'select T.ROWID, T.*'
      'from T235_CAUPRESENZE_PARSTO T'
      'where T.ID = :ID'
      'order by T.DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000040000004900440001000000000014000000440045004300
      4F005200520045004E005A0041000100000000001E0000004400450043004F00
      5200520045004E005A0041005F00460049004E00450001000000000016000000
      4400450053004300520049005A0049004F004E00450001000000000030000000
      4E004F004E004100420049004C00490054004100540041005F0045004C004900
      4D0049004E004100540049004D0042000100000000002E0000004E004F004E00
      4100430043004F005000500049004100540041005F0041004E004F004D004200
      4C004F0043004300010000000000}
    BeforePost = BeforePost
    Left = 16
    Top = 16
    object selT235ID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object selT235CODICE: TStringField
      FieldKind = fkLookup
      FieldName = 'CODICE'
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Lookup = True
    end
    object selT235DESC_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Size = 40
      Lookup = True
    end
    object selT235DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT235DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object selT235DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT235CAUSCOMP_DEBITOGG: TStringField
      FieldName = 'CAUSCOMP_DEBITOGG'
      Size = 5
    end
    object selT235RENDICONTA_PROGETTI: TStringField
      FieldName = 'RENDICONTA_PROGETTI'
      Size = 1
    end
    object selT235ARROT_RIEPGG: TStringField
      FieldName = 'ARROT_RIEPGG'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT235ARROT_RIEPGG_ORENORM: TStringField
      FieldName = 'ARROT_RIEPGG_ORENORM'
      Size = 1
    end
    object selT235ARROT_RIEPGG_FASCE: TStringField
      FieldName = 'ARROT_RIEPGG_FASCE'
      Size = 1
    end
    object selT235ARROT_RIEPGG_FINECONT: TStringField
      FieldName = 'ARROT_RIEPGG_FINECONT'
      Size = 1
    end
  end
end
