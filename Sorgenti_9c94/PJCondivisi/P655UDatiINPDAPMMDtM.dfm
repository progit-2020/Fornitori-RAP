inherited P655FDatiINPDAPMMDtM: TP655FDatiINPDAPMMDtM
  OldCreateOrder = True
  Height = 211
  Width = 397
  object P662: TOracleDataSet
    SQL.Strings = (
      'SELECT P662.*,P662.ROWID '
      '  FROM P662_FLUSSITESTATE P662'
      ' WHERE NOME_FLUSSO=:NOMEFLUSSO'
      ' ORDER BY DATA_FINE_PERIODO,DATA_CHIUSURA')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004E004F004D00450046004C00550053005300
      4F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000430048004900550053004F000100000000001A00
      000044004100540041005F004300480049005500530055005200410001000000
      00002200000044004100540041005F00460049004E0045005F00500045005200
      49004F0044004F00010000000000160000004E004F004D0045005F0046004C00
      5500530053004F0001000000000012000000490044005F0046004C0055005300
      53004F00010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = P662AfterScroll
    OnNewRecord = P662NewRecord
    Left = 9
    Top = 13
    object P662DATA_FINE_PERIODO: TDateTimeField
      FieldName = 'DATA_FINE_PERIODO'
      Required = True
    end
    object P662CHIUSO: TStringField
      FieldName = 'CHIUSO'
      Size = 1
    end
    object P662DATA_CHIUSURA: TDateTimeField
      FieldName = 'DATA_CHIUSURA'
    end
    object P662NOME_FLUSSO: TStringField
      FieldName = 'NOME_FLUSSO'
      Size = 10
    end
    object P662ID_FLUSSO: TFloatField
      FieldName = 'ID_FLUSSO'
      Required = True
    end
  end
  object selP663_ID: TOracleDataSet
    SQL.Strings = (
      'SELECT P663_ID_FLUSSO.NEXTVAL FROM DUAL'
      '  ')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000000E0000004E00450058005400560041004C00010000000000}
    CommitOnPost = False
    Left = 13
    Top = 120
  end
  object DselP660: TDataSource
    Left = 55
    Top = 64
  end
end
