inherited A028FScMW: TA028FScMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 149
  Width = 264
  object dsrConteggi: TDataSource
    DataSet = cdsConteggi
    Left = 22
    Top = 16
  end
  object cdsConteggi: TClientDataSet
    PersistDataPacket.Data = {
      4E0000009619E0BD0100000018000000020000000000030000004E0004446174
      6F010049000000010005574944544802000200C8000656616C6F726501004900
      0000010005574944544802000200C8000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Dato'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Valore'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 86
    Top = 16
    object cdsConteggiDato: TStringField
      DisplayWidth = 40
      FieldName = 'Dato'
      Size = 200
    end
    object cdsConteggiValore: TStringField
      DisplayWidth = 55
      FieldName = 'Valore'
      Size = 200
    end
  end
end
