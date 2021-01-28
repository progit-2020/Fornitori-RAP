object A107FInsAssAutoRegoleDtM: TA107FInsAssAutoRegoleDtM
  OldCreateOrder = True
  OnCreate = A107FInsAssAutoRegoleDtMCreate
  OnDestroy = A107FInsAssAutoRegoleDtMDestroy
  Height = 72
  Width = 62
  object selT045: TOracleDataSet
    SQL.Strings = (
      'SELECT T045.*,T045.ROWID FROM T045_ASSENZEAUTOMATICHE T045')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000E000000430041005500530041004C004900010000000000
      0C000000440045004200490054004F0001000000000018000000470049004F00
      52004E0049005F00560055004F00540049000100000000000E0000004F005200
      45005F004D00410058000100000000002C00000045004C0049004D0049004E00
      41005F0047004900550053005400490046004900430041005400490056004900
      010000000000}
    BeforePost = selT045BeforePost
    AfterPost = selT045AfterPost
    AfterCancel = selT045AfterCancel
    Left = 12
    Top = 8
    object selT045CAUSALI: TStringField
      DisplayLabel = 'Causali'
      FieldName = 'CAUSALI'
      Size = 300
    end
    object selT045DEBITO: TStringField
      DisplayLabel = 'Debito da coprire'
      FieldName = 'DEBITO'
      Size = 1
    end
    object selT045GIORNI_VUOTI: TStringField
      DisplayLabel = 'Considera giorni vuoti'
      FieldName = 'GIORNI_VUOTI'
      Size = 1
    end
    object selT045ORE_MAX: TStringField
      DisplayLabel = 'Ore max giornaliere'
      FieldName = 'ORE_MAX'
      Required = True
      OnValidate = selT045ORE_MAXValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT045ELIMINA_GIUSTIFICATIVI: TStringField
      DisplayLabel = 'Elimina giustificativi preesistenti'
      FieldName = 'ELIMINA_GIUSTIFICATIVI'
      Size = 1
    end
  end
end
