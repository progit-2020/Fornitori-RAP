object A021FCausGiustifDtM1: TA021FCausGiustifDtM1
  OldCreateOrder = True
  OnCreate = A021FCausGiustifDtM1Create
  OnDestroy = A021FCausGiustifDtM1Destroy
  Height = 96
  Width = 233
  object D300: TDataSource
    DataSet = Q300
    Left = 92
    Top = 16
  end
  object T305: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T305.*,T305.ROWID FROM T305_CAUGIUSTIF T305 ORDER BY CODI' +
        'CE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000B0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      000043004F004400520041004700470052000100000000001400000056004F00
      430045005000410047004800450031000100000000001400000056004F004300
      45005000410047004800450032000100000000001400000056004F0043004500
      5000410047004800450033000100000000001400000056004F00430045005000
      410047004800450034000100000000000A0000005300490047004C0041000100
      00000000180000004100530053004500530054005F0041004E004E0055004F00
      0100000000002200000041004200420041005400540045005F00450043004300
      5F00470049004F0052004E00010000000000140000004C0049004D0049005400
      45005F004C0049005100010000000000}
    BeforePost = T305BeforePost
    AfterPost = T305AfterPost
    BeforeDelete = T305BeforeDelete
    AfterDelete = T305AfterDelete
    Left = 28
    Top = 16
    object T305Codice: TStringField
      FieldName = 'Codice'
      Required = True
      OnValidate = BDET305CodiceValidate
      Size = 5
    end
    object T305Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object T305CodRaggr: TStringField
      FieldName = 'CodRaggr'
      Required = True
      Size = 5
    end
    object T305VocePaghe1: TStringField
      FieldName = 'VocePaghe1'
      Size = 6
    end
    object T305VocePaghe2: TStringField
      FieldName = 'VocePaghe2'
      Size = 6
    end
    object T305VocePaghe3: TStringField
      FieldName = 'VocePaghe3'
      Size = 6
    end
    object T305VocePaghe4: TStringField
      FieldName = 'VocePaghe4'
      Size = 6
    end
    object T305D_CodRaggr: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodRaggr'
      LookupDataSet = Q300
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object T305SIGLA: TStringField
      FieldName = 'SIGLA'
      Size = 1
    end
    object T305ASSEST_ANNUO: TStringField
      FieldName = 'ASSEST_ANNUO'
      Size = 11
    end
    object T305ABBATTE_ECC_GIORN: TStringField
      FieldName = 'ABBATTE_ECC_GIORN'
      Size = 1
    end
    object T305LIMITE_LIQ: TStringField
      FieldName = 'LIMITE_LIQ'
      Size = 1
    end
    object T305BANCAORE_NEGATIVA: TStringField
      FieldName = 'BANCAORE_NEGATIVA'
      Size = 1
    end
    object T305DATA_MIN_ASSEST: TDateTimeField
      FieldName = 'DATA_MIN_ASSEST'
      OnGetText = T305DATA_MIN_ASSESTGetText
      OnSetText = T305DATA_MIN_ASSESTSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
  end
  object Q300: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T300_RaggrGiustif ORDER BY Codice')
    Optimize = False
    Left = 64
    Top = 16
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T265_CauAssenze '
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 132
    Top = 16
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T275_CauPresenze  '
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 168
    Top = 16
  end
end
