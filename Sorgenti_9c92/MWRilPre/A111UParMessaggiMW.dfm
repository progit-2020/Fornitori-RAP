inherited A111FParMessaggiMW: TA111FParMessaggiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 217
  Width = 267
  object delT292: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T292_PARMESSAGGIDATI WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 16
    Top = 160
  end
  object updT292: TOracleQuery
    SQL.Strings = (
      'UPDATE T292_PARMESSAGGIDATI SET CODICE = :CODICE_NEW'
      'WHERE CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0043004F0044004900430045005F004E004500
      5700050000000000000000000000160000003A0043004F004400490043004500
      5F004F004C004400050000000000000000000000}
    Left = 16
    Top = 108
  end
  object SelDual: TOracleDataSet
    SQL.Strings = (
      'SELECT TO_CHAR(SYSDATE,:FormatoData) FROM DUAL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A0046004F0052004D00410054004F0044004100
      54004100050000000000000000000000}
    Left = 66
    Top = 108
  end
  object selT265T275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT 0 TIPO,RPAD(CODICE,6,'#39' '#39')||DESCRIZIONE CAUSALE FROM T275_' +
        'CAUPRESENZE'
      'UNION'
      
        'SELECT 1,RPAD(CODICE,6,'#39' '#39')||DESCRIZIONE FROM T265_CAUASSENZE WH' +
        'ERE TIPOCUMULO <> '#39'H'#39' '
      'ORDER BY TIPO')
    ReadBuffer = 100
    Optimize = False
    Left = 168
    Top = 108
  end
  object selC292: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_RECORD'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NUMERO_RECORD'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TIPO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POSIZIONE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'LUNGHEZZA'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME_COLONNA'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FORMATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALORE_DEFAULT'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'T292INDICE'
        Fields = 'NUMERO_RECORD;POSIZIONE;NOME_COLONNA'
      end>
    IndexName = 'T292INDICE'
    Params = <>
    StoreDefs = True
    Left = 211
    Top = 18
  end
  object dsrC292: TDataSource
    DataSet = selC292
    Left = 211
    Top = 62
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT NOME FROM T002_QUERYPERSONALIZZATE WHERE APPLICA' +
        'ZIONE = '#39'RILPRE'#39' ORDER BY NOME'
      '')
    Optimize = False
    Left = 166
    Top = 17
  end
  object dsrT002: TDataSource
    DataSet = selT002
    Left = 164
    Top = 61
  end
  object selT003: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT NOME from T003_SELEZIONIANAGRAFE'
      '')
    Optimize = False
    Left = 118
    Top = 16
  end
  object dsrT003: TDataSource
    DataSet = selT003
    Left = 118
    Top = 59
  end
  object selT292: TOracleDataSet
    SQL.Strings = (
      'select T292.*, T292.rowid from T292_PARMESSAGGIDATI T292'
      'where CODICE = :CODICE_PARM '
      'order by NUMERO_RECORD, POSIZIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A0043004F0044004900430045005F0050004100
      52004D00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000C00000043004F0044004900430045000100000000001600
      00005400490050004F005F005200450043004F00520044000100000000001A00
      00004E0055004D00450052004F005F005200450043004F005200440001000000
      0000080000005400490050004F000100000000001200000050004F0053004900
      5A0049004F004E004500010000000000120000004C0055004E00470048004500
      5A005A004100010000000000180000004E004F004D0045005F0043004F004C00
      4F004E004E0041000100000000000E00000046004F0052004D00410054004F00
      0100000000001C000000560041004C004F00520045005F004400450046004100
      55004C0054000100000000001600000043004F0044004900430045005F004400
      410054004F00010000000000}
    AutoCalcFields = False
    ReadOnly = True
    CachedUpdates = True
    BeforePost = selT292BeforePost
    AfterScroll = selT292AfterScroll
    OnNewRecord = selT292NewRecord
    Left = 72
    Top = 16
    object selT292CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT292TIPO_RECORD: TStringField
      DisplayLabel = 'Tipo R.'
      FieldName = 'TIPO_RECORD'
      Required = True
      OnValidate = selT292TIPO_RECORDValidate
      Size = 2
    end
    object selT292NUMERO_RECORD: TFloatField
      DisplayLabel = 'Num.R.'
      FieldName = 'NUMERO_RECORD'
      Required = True
    end
    object selT292TIPO: TStringField
      DisplayLabel = 'Tipo C.'
      FieldName = 'TIPO'
      Required = True
      OnValidate = selT292TIPOValidate
      Size = 2
    end
    object selT292NOME_COLONNA: TStringField
      DisplayLabel = 'Nome Colonna'
      FieldName = 'NOME_COLONNA'
      Required = True
      OnValidate = selT292NOME_COLONNAValidate
    end
    object selT292POSIZIONE: TFloatField
      DisplayLabel = 'Pos.'
      FieldName = 'POSIZIONE'
      Required = True
      OnValidate = selT292POSIZIONEValidate
    end
    object selT292LUNGHEZZA: TFloatField
      DisplayLabel = 'Lung.'
      FieldName = 'LUNGHEZZA'
      Required = True
      OnValidate = selT292LUNGHEZZAValidate
    end
    object selT292VALORE_DEFAULT: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'VALORE_DEFAULT'
      OnValidate = selT292VALORE_DEFAULTValidate
      Size = 80
    end
    object selT292FORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      OnValidate = selT292FORMATOValidate
    end
    object selT292CODICE_DATO: TStringField
      DisplayLabel = 'Cod.dato'
      DisplayWidth = 8
      FieldName = 'CODICE_DATO'
      Size = 50
    end
    object selT292CHIAVE: TStringField
      DisplayLabel = 'Chiave'
      FieldName = 'CHIAVE'
      Size = 1
    end
  end
  object dsrT292: TDataSource
    DataSet = selT292
    Left = 72
    Top = 60
  end
end
