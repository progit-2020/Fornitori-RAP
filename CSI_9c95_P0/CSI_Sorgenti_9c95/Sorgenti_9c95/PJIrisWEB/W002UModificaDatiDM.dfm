object W002FModificaDatiDM: TW002FModificaDatiDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 77
  Width = 241
  object cdsDatiAnag: TClientDataSet
    PersistDataPacket.Data = {
      B90000009619E0BD010000001800000006000000000003000000B9000543414D
      504F010049000000010005574944544802000200640009444154415F54595045
      0100490000000100055749445448020002006A000B444154415F4C454E475448
      0400010000000000044441544F01004900020001000557494454480200020064
      000656414C4F5245010049000000010005574944544802000200C8000A56414C
      4F52455F4F4C44010049000000010005574944544802000200C8000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CAMPO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DATA_TYPE'
        DataType = ftString
        Size = 106
      end
      item
        Name = 'DATA_LENGTH'
        DataType = ftInteger
      end
      item
        Name = 'DATO'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'VALORE'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'VALORE_OLD'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 27
    Top = 17
    object cdsDatiAnagCAMPO: TStringField
      FieldName = 'CAMPO'
      Visible = False
      Size = 100
    end
    object cdsDatiAnagDATA_TYPE: TStringField
      FieldName = 'DATA_TYPE'
      Visible = False
      Size = 106
    end
    object cdsDatiAnagDATA_LENGTH: TIntegerField
      FieldName = 'DATA_LENGTH'
      Visible = False
    end
    object cdsDatiAnagDATO: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'DATO'
      ReadOnly = True
      Size = 100
    end
    object cdsDatiAnagVALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 50
      FieldName = 'VALORE'
      Size = 200
    end
    object cdsDatiAnagVALORE_OLD: TStringField
      FieldName = 'VALORE_OLD'
      Visible = False
      Size = 200
    end
  end
  object selDecorrenza: TOracleQuery
    SQL.Strings = (
      'select DATADECORRENZA'
      'from   T430_STORICO'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    trunc(sysdate) between DATADECORRENZA and DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00050000000000000000000000}
    Left = 102
    Top = 17
  end
  object updDatiAnag: TOracleQuery
    SQL.Strings = (
      'update T430_STORICO'
      'set    :SET_VALORI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATADECORRENZA >= :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A005300450054005F00560041004C004F005200
      4900010000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00050000000000000000000000160000003A0044004500
      43004F005200520045004E005A0041000C0000000000000000000000}
    Left = 180
    Top = 17
  end
end
