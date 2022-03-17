object C001FFiltroTabelleDTM: TC001FFiltroTabelleDTM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 279
  Width = 184
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 20
    Top = 56
  end
  object DataSource2: TDataSource
    DataSet = Query2
    Left = 20
    Top = 8
  end
  object DSDistinct: TDataSource
    DataSet = QDistinct
    Left = 20
    Top = 108
  end
  object D900: TDataSource
    DataSet = Q900
    OnDataChange = D900DataChange
    Left = 20
    Top = 156
  end
  object Query2: TOracleDataSet
    ReadBuffer = 500
    Optimize = False
    Left = 80
    Top = 8
  end
  object Query1: TOracleDataSet
    ReadBuffer = 500
    Optimize = False
    Filtered = True
    BeforeOpen = Query1BeforeOpen
    AfterOpen = Query1AfterOpen
    OnFilterRecord = FilterCestino
    Left = 80
    Top = 56
  end
  object QDistinct: TOracleDataSet
    ReadBuffer = 500
    Optimize = False
    Filtered = True
    OnFilterRecord = FilterCestino
    Left = 80
    Top = 108
  end
  object Q900: TOracleDataSet
    SQL.Strings = (
      'select T900.*,T900.ROWID from T900_STAMPABASE T900'
      'where CODICEINTERNO =:CODICEINTERNO'
      'order by NOMESTAMPA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000001C0000003A0043004F00440049004300450049004E005400
      450052004E004F00050000000000000000000000}
    Left = 80
    Top = 156
  end
  object cdsLookup: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'LookupDa'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'LookupA'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'LookupNumDa'
        DataType = ftFloat
      end
      item
        Name = 'LookupNumA'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 80
    Top = 202
    Data = {
      7A0000009619E0BD0100000018000000040000000000030000007A00084C6F6F
      6B757044610100490000000100055749445448020002005000074C6F6F6B7570
      4101004900000001000557494454480200020050000B4C6F6F6B75704E756D44
      6108000400000000000A4C6F6F6B75704E756D4108000400000000000000}
    object cdsLookupLookupDa: TStringField
      FieldName = 'LookupDa'
      Size = 80
    end
    object cdsLookupLookupA: TStringField
      FieldName = 'LookupA'
      Size = 80
    end
    object cdsLookupLookupNumDa: TFloatField
      FieldName = 'LookupNumDa'
    end
    object cdsLookupLookupNumA: TFloatField
      FieldName = 'LookupNumA'
    end
  end
  object dsrLookup: TDataSource
    DataSet = cdsLookup
    Left = 20
    Top = 202
  end
  object selT901: TOracleDataSet
    SQL.Strings = (
      'select T901.*,T901.ROWID from T901_STAMPABASE_DATI T901'
      'where CODICEINTERNO =:CODICEINTERNO and NOMESTAMPA = :NOMESTAMPA'
      'order by NUMRIGA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A0043004F00440049004300450049004E005400
      450052004E004F00050000000000000000000000160000003A004E004F004D00
      45005300540041004D0050004100050000000000000000000000}
    Left = 128
    Top = 156
  end
end
