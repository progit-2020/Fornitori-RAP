object W003FAnomalieDM: TW003FAnomalieDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object selT101: TOracleDataSet
    SQL.Strings = (
      
        'select T101.PROGRESSIVO, T101.DATA, T101.LIVELLO, T101.ANOMALIA,' +
        ' T101.NUM_ANOMALIA, T030.MATRICOLA, T030.COGNOME, T030.NOME'
      '  from T101_ANOMALIE T101, T030_ANAGRAFICO T030'
      ' where T101.UTENTE = '#39'W003'#39
      '   and T030.PROGRESSIVO = T101.PROGRESSIVO'
      ' order by T030.COGNOME,T030.NOME,T030.MATRICOLA,T101.DATA')
    ReadBuffer = 200
    Optimize = False
    OnFilterRecord = selT101FilterRecord
    Left = 32
    Top = 9
  end
end
