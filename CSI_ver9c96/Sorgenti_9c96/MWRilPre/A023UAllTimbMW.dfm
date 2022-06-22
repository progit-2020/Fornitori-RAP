inherited A023FAllTimbMW: TA023FAllTimbMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 134
  Width = 136
  object Q100: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,ORA,VERSO,FLAG,CAUSALE,ROWID'
      'FROM T100_TIMBRATURE'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      '      DATA BETWEEN :DATA1 AND :DATA2 AND'
      '      (FLAG = '#39'O'#39' OR FLAG = '#39'I'#39')'
      'ORDER BY DATA,ORA,VERSO')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    OnFilterRecord = Q100FilterRecord
    Left = 16
    Top = 16
  end
  object Q100Upd: TOracleQuery
    SQL.Strings = (
      'UPDATE T100_TIMBRATURE SET ORA = :ORANEW'
      'WHERE'
      'ROWID = :ROW_ID')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004F00520041004E00450057000C0000000000
      0000000000000E0000003A0052004F0057005F00490044000500000000000000
      00000000}
    Left = 80
    Top = 16
  end
  object dsrT100: TDataSource
    DataSet = cdsT100
    Left = 77
    Top = 79
  end
  object cdsT100: TClientDataSet
    PersistDataPacket.Data = {
      A10100009619E0BD010000001800000010000000000003000000A1010A415554
      4F4D415449434F01004900000001000557494454480200020001000B50524F47
      5245535349564F040001000000000007434F474E4F4D45010049000000010005
      5749445448020002001E00044E4F4D4501004900000001000557494454480200
      02001E00094D41545249434F4C41010049000000010005574944544802000200
      080004444154410800080000000000044F524131080008000000000006564552
      534F31010049000000010005574944544802000200010005464C414731010049
      00000001000557494454480200020001000843415553414C4531010049000000
      010005574944544802000200050006524F574944310100490000000100055749
      445448020002001400044F524132080008000000000006564552534F32010049
      000000010005574944544802000200010005464C414732010049000000010005
      57494454480200020001000843415553414C4532010049000000010005574944
      544802000200050006524F574944320100490000000100055749445448020002
      0014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'AUTOMATICO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'COGNOME'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MATRICOLA'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'ORA1'
        DataType = ftDateTime
      end
      item
        Name = 'VERSO1'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FLAG1'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CAUSALE1'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ROWID1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ORA2'
        DataType = ftDateTime
      end
      item
        Name = 'VERSO2'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FLAG2'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CAUSALE2'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ROWID2'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsT100CalcFields
    Left = 16
    Top = 80
    object cdsT100AUTOMATICO: TStringField
      DisplayLabel = 'Automatico'
      FieldName = 'AUTOMATICO'
      Visible = False
      Size = 1
    end
    object cdsT100PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object cdsT100D_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 35
      FieldKind = fkCalculated
      FieldName = 'D_NOMINATIVO'
      Size = 63
      Calculated = True
    end
    object cdsT100COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Visible = False
      Size = 30
    end
    object cdsT100NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Visible = False
      Size = 30
    end
    object cdsT100MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsT100DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsT100ORA1: TDateTimeField
      DisplayWidth = 8
      FieldName = 'ORA1'
      Visible = False
      DisplayFormat = 'hhhh.mm.ss'
    end
    object cdsT100VERSO1: TStringField
      FieldName = 'VERSO1'
      Visible = False
      Size = 1
    end
    object cdsT100FLAG1: TStringField
      FieldName = 'FLAG1'
      Visible = False
      Size = 1
    end
    object cdsT100CAUSALE1: TStringField
      FieldName = 'CAUSALE1'
      Visible = False
      Size = 5
    end
    object cdsT100ROWID1: TStringField
      FieldName = 'ROWID1'
      Visible = False
    end
    object cdsT100ORA2: TDateTimeField
      FieldName = 'ORA2'
      Visible = False
      DisplayFormat = 'hhhh.mm.ss'
    end
    object cdsT100VERSO2: TStringField
      FieldName = 'VERSO2'
      Visible = False
      Size = 1
    end
    object cdsT100FLAG2: TStringField
      FieldName = 'FLAG2'
      Visible = False
      Size = 1
    end
    object cdsT100CAUSALE2: TStringField
      FieldName = 'CAUSALE2'
      Visible = False
      Size = 5
    end
    object cdsT100ROWID2: TStringField
      FieldName = 'ROWID2'
      Visible = False
    end
    object cdsT100D_ORA1: TStringField
      DisplayLabel = 'Timbratura 1'
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'D_ORA1'
      Calculated = True
    end
    object cdsT100D_ORA2: TStringField
      DisplayLabel = 'Timbratura 2'
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'D_ORA2'
      Calculated = True
    end
  end
end
