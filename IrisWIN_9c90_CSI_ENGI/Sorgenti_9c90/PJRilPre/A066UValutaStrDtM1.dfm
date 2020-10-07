inherited A066FValutaStrDtM1: TA066FValutaStrDtM1
  OldCreateOrder = True
  Height = 184
  Width = 361
  object selT730: TOracleDataSet
    SQL.Strings = (
      'select T730.*,T730.ROWID '
      'from   T730_VALUTAORE T730 '
      'order by LIVELLO, CAUSALE, DECORRENZA, MAGGIORAZIONE')
    ReadBuffer = 500
    Optimize = False
    AfterOpen = selT730AfterOpen
    BeforeInsert = BeforeInsert
    BeforePost = BeforePost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    Left = 15
    Top = 12
    object selT730LIVELLO: TStringField
      FieldName = 'LIVELLO'
      KeyFields = 'LIVELLO'
    end
    object selT730CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT730DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
    object selT730DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object selT730MAGGIORAZIONE: TFloatField
      FieldName = 'MAGGIORAZIONE'
      OnValidate = selT730MAGGIORAZIONEValidate
    end
    object selT730TARIFFA_LIQ: TFloatField
      FieldName = 'TARIFFA_LIQ'
    end
    object selT730TARIFFA_MAT: TFloatField
      FieldName = 'TARIFFA_MAT'
    end
  end
  object QStampa: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   T730_VALUTAORE '
      'where  LIVELLO between :LIVELLO1 and :LIVELLO2'
      'and    nvl(DECORRENZA_FINE,:DATA1) >= :DATA1 '
      'and    DECORRENZA <=:DATA2'
      'order by LIVELLO, DECORRENZA, MAGGIORAZIONE')
    Optimize = False
    Variables.Data = {
      0400000004000000120000003A004C004900560045004C004C004F0031000500
      00000000000000000000120000003A004C004900560045004C004C004F003200
      0500000000000000000000000C0000003A00440041005400410031000C000000
      00000000000000000C0000003A00440041005400410032000C00000000000000
      00000000}
    Left = 12
    Top = 76
  end
end
