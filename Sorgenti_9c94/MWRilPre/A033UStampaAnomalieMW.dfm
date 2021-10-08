inherited A033FStampaAnomalieMW: TA033FStampaAnomalieMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object dsrI010: TDataSource
    AutoEdit = False
    Left = 16
    Top = 68
  end
  object QDelete: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T101_ANOMALIE WHERE OPERATORE = :OPERATORE')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004F00500045005200410054004F0052004500
      030000000000000000000000}
    Left = 112
    Top = 12
  end
  object Q100: TOracleDataSet
    SQL.Strings = (
      'SELECT ORA,VERSO,CAUSALE,RILEVATORE FROM T100_TIMBRATURE'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      'DATA = :DATA  AND FLAG IN ('#39'O'#39','#39'I'#39')'
      'ORDER BY DATA,ORA,VERSO,FLAG')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 12
    Top = 12
  end
  object QInsert: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T101_ANOMALIE'
      
        '(PROGRESSIVO,DATA,LIVELLO,ANOMALIA,OPERATORE,UTENTE, NUM_ANOMALI' +
        'A)'
      'VALUES'
      
        '(:PROGRESSIVO,:DATA,:LIVELLO,:ANOMALIA,:OPERATORE, :UTENTE, :NUM' +
        '_ANOMALIA)')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A004C004900560045004C004C004F000300
      00000000000000000000120000003A0041004E004F004D0041004C0049004100
      050000000000000000000000140000003A004F00500045005200410054004F00
      520045000300000000000000000000000E0000003A005500540045004E005400
      45000500000000000000000000001A0000003A004E0055004D005F0041004E00
      4F004D0041004C0049004100030000000000000000000000}
    Left = 60
    Top = 12
  end
  object TStampa: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Raggruppamento'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Matricola'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Nome'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Data'
        DataType = ftDate
      end
      item
        Name = 'Anomalia'
        DataType = ftMemo
      end
      item
        Name = 'Progressivo'
        DataType = ftInteger
      end
      item
        Name = 'Badge'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'Indice'
        Fields = 'Raggruppamento;Nome;Matricola;Data'
      end>
    IndexName = 'Indice'
    Params = <>
    StoreDefs = True
    Left = 112
    Top = 70
  end
end
