object A085FPartTimeDtM1: TA085FPartTimeDtM1
  OldCreateOrder = True
  OnCreate = A076FIndGruppoDtM1Create
  OnDestroy = A085FPartTimeDtM1Destroy
  Height = 264
  Width = 400
  object Q460: TOracleDataSet
    SQL.Strings = (
      'SELECT T460.*,T460.ROWID FROM T460_PARTTIME T460'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000800
      00005400490050004F000100000000000C0000005000490041004E0054004100
      0100000000000E00000049004E00440050005200450053000100000000001200
      000049004E00430045004E005400490056004900010000000000120000004100
      5300530045004E005A0045004700470001000000000012000000410053005300
      45004E005A004500480048000100000000000E00000049004E00440046004500
      53005400010000000000240000004400450053004300520049005A0049004F00
      4E0045005F00450053005400450053004100010000000000}
    CachedUpdates = True
    BeforePost = Q460BeforePost
    AfterPost = Q460AfterPost
    AfterCancel = Q460AfterCancel
    BeforeDelete = Q460BeforeDelete
    AfterDelete = Q460AfterDelete
    OnNewRecord = Q460NewRecord
    Left = 20
    Top = 8
    object Q460CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T460_PARTTIME.CODICE'
      Size = 5
    end
    object Q460DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T460_PARTTIME.DESCRIZIONE'
      Size = 40
    end
    object Q460DESCRIZIONE_ESTESA: TStringField
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE_ESTESA'
      Size = 200
    end
    object Q460PIANTA: TFloatField
      FieldName = 'PIANTA'
      Origin = 'T460_PARTTIME.PIANTA'
      Required = True
      OnValidate = Q460PIANTAValidate
      MaxValue = 100.000000000000000000
    end
    object Q460TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'T460_PARTTIME.TIPO'
      Size = 1
    end
    object Q460INDPRES: TFloatField
      FieldName = 'INDPRES'
      Origin = 'T460_PARTTIME.INDPRES'
      Required = True
      MaxValue = 100.000000000000000000
    end
    object Q460INDFEST: TFloatField
      FieldName = 'INDFEST'
      Required = True
    end
    object Q460INCENTIVI: TFloatField
      FieldName = 'INCENTIVI'
      Origin = 'T460_PARTTIME.INCENTIVI'
      Required = True
      MaxValue = 100.000000000000000000
    end
    object Q460ASSENZEGG: TFloatField
      FieldName = 'ASSENZEGG'
      Required = True
      MaxValue = 100.000000000000000000
    end
    object Q460ASSENZEHH: TFloatField
      FieldName = 'ASSENZEHH'
      Required = True
      MaxValue = 100.000000000000000000
    end
    object Q460DEBITO_AGG: TFloatField
      FieldName = 'DEBITO_AGG'
      Required = True
      MaxValue = 100.000000000000000000
    end
    object Q460HHGIORNALIERE: TFloatField
      FieldName = 'HHGIORNALIERE'
      Required = True
      MaxValue = 100.000000000000000000
    end
  end
end
