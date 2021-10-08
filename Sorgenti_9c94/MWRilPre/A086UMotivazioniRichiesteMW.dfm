inherited A086FMotivazioniRichiesteMW: TA086FMotivazioniRichiesteMW
  OldCreateOrder = True
  Height = 110
  Width = 129
  object cdsTipologie: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 30
    Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020005000B4445534352495A49
      4F4E4501004900000001000557494454480200020032000000}
    object cdsTipologieCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object cdsTipologieDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
end
