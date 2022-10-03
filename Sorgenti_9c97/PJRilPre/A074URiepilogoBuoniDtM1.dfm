object A074FRiepilogoBuoniDtM1: TA074FRiepilogoBuoniDtM1
  OldCreateOrder = True
  OnCreate = A049FStampaPastiDtM1Create
  OnDestroy = A049FStampaPastiDtM1Destroy
  Height = 117
  Width = 225
  object cdsT191: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codice'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsT191CalcFields
    Left = 56
    Top = 14
    Data = {
      350000009619E0BD010000001800000001000000000003000000350006636F64
      69636501004900000001000557494454480200020005000000}
    object cdsT191codice: TStringField
      DisplayWidth = 7
      FieldName = 'codice'
      Size = 5
    end
    object cdsT191d_codice: TStringField
      FieldKind = fkCalculated
      FieldName = 'd_codice'
      Size = 40
      Calculated = True
    end
    object cdsT191d_nomefile: TStringField
      FieldKind = fkCalculated
      FieldName = 'd_nomefile'
      Size = 40
      Calculated = True
    end
  end
  object dcdsT191: TDataSource
    DataSet = cdsT191
    Left = 56
    Top = 59
  end
end
