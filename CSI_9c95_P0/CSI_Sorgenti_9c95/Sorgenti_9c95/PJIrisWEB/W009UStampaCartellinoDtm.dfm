object W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 129
  Width = 203
  object selAnagrafeMatr: TOracleDataSet
    SQL.Strings = (
      
        'select T030.PROGRESSIVO,T030.MATRICOLA,T030.COGNOME,T030.NOME,T4' +
        '30BADGE, T430INIZIO, T430FINE'
      'from T030_ANAGRAFICO T030, V430_STORICO V430'
      'where T030.PROGRESSIVO = T430PROGRESSIVO'
      'and T030.MATRICOLA = :MATRICOLA'
      'and :DATALAVORO between T430DATADECORRENZA and T430DATAFINE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000140000003A004D0041005400520049004300
      4F004C004100050000000000000000000000}
    Left = 34
    Top = 13
  end
  object cdsRiep: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'X'
        DataType = ftInteger
      end
      item
        Name = 'Y'
        DataType = ftInteger
      end
      item
        Name = 'TAG'
        DataType = ftInteger
      end
      item
        Name = 'CAPTION'
        DataType = ftString
        Size = 2000
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 37
    Top = 69
  end
  object selAnagrafeProgr: TOracleDataSet
    SQL.Strings = (
      
        'select T030.PROGRESSIVO,T030.MATRICOLA,T030.COGNOME,T030.NOME,T4' +
        '30BADGE, T430INIZIO, T430FINE'
      'from T030_ANAGRAFICO T030, V430_STORICO V430'
      'where T030.PROGRESSIVO = T430PROGRESSIVO'
      'and T030.PROGRESSIVO = :PROGRESSIVO'
      'and :DATALAVORO between T430DATADECORRENZA and T430DATAFINE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000}
    Left = 122
    Top = 13
  end
end
