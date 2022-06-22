inherited A121FRecapitiSindacatiDtM: TA121FRecapitiSindacatiDtM
  OldCreateOrder = True
  Height = 67
  Width = 74
  object selT241: TOracleDataSet
    SQL.Strings = (
      'SELECT T241.*,T241.ROWID '
      'FROM T241_RECAPITISINDACATI T241'
      'WHERE CODICE = :CODICE'
      'ORDER BY CODICE, TIPO_RECAPITO, PROG_RECAPITO, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000001A000000
      5400490050004F005F0052004500430041005000490054004F00010000000000
      1200000049004E0044004900520049005A005A004F0001000000000006000000
      4300410050000100000000000C00000043004F004D0055004E00450001000000
      000010000000540045004C00450046004F004E004F0001000000000006000000
      4600410058000100000000000E00000043004F0047004E004F004D0045000100
      00000000080000004E004F004D0045000100000000001A000000540045004C00
      450046004F004E004F005F004300410053004100010000000000200000005400
      45004C00450046004F004E004F005F005500460046004900430049004F000100
      0000000012000000430045004C004C0055004C00410052004500010000000000
      0A00000045004D00410049004C000100000000001A000000500052004F004700
      5F0052004500430041005000490054004F000100000000001600000044004500
      53004300520049005A0049004F004E004500010000000000}
    RefreshOptions = [roAfterInsert, roAfterUpdate, roAllFields]
    BeforePost = BeforePost
    AfterScroll = selT241AfterScroll
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 8
    object selT241CODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 10
    end
    object selT241DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT241TIPO_RECAPITO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECAPITO'
      Required = True
      Size = 2
    end
    object selT241PROG_RECAPITO: TIntegerField
      DisplayLabel = 'Prog.'
      DisplayWidth = 2
      FieldName = 'PROG_RECAPITO'
      Required = True
    end
    object selT241DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT241INDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      DisplayWidth = 20
      FieldName = 'INDIRIZZO'
      Size = 50
    end
    object selT241Citta: TStringField
      DisplayLabel = 'Citt'#224
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Citta'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      Size = 50
      Lookup = True
    end
    object selT241Provincia: TStringField
      DisplayLabel = 'Prov'
      FieldKind = fkLookup
      FieldName = 'Provincia'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      Size = 2
      Lookup = True
    end
    object selT241COMUNE: TStringField
      FieldName = 'COMUNE'
      Visible = False
      OnChange = selT241COMUNEChange
      Size = 6
    end
    object selT241CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT241TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selT241FAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 15
    end
    object selT241COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
    end
    object selT241NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
    end
    object selT241TELEFONO_CASA: TStringField
      DisplayLabel = 'Tel.Casa'
      FieldName = 'TELEFONO_CASA'
      Size = 15
    end
    object selT241TELEFONO_UFFICIO: TStringField
      DisplayLabel = 'Tel.Ufficio'
      FieldName = 'TELEFONO_UFFICIO'
      Size = 15
    end
    object selT241CELLULARE: TStringField
      DisplayLabel = 'Cellulare'
      FieldName = 'CELLULARE'
      Size = 15
    end
    object selT241EMAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'EMAIL'
      Size = 40
    end
  end
end
