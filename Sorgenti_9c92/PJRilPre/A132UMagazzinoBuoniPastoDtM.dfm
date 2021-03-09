inherited A132FMagazzinoBuoniPastoDtM: TA132FMagazzinoBuoniPastoDtM
  OldCreateOrder = True
  Height = 134
  Width = 268
  object selT691: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID from T691_MAGAZZINOBUONI T'
      ':where'
      'order by DATA_ACQUISTO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A00570048004500520045000100000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    BeforePost = selT691BeforePost
    Left = 16
    Top = 8
    object selT691DATA_ACQUISTO: TDateTimeField
      DisplayLabel = 'Data acquisto'
      FieldName = 'DATA_ACQUISTO'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selT691DATA_SCADENZA: TDateTimeField
      DisplayLabel = 'Data scadenza'
      FieldName = 'DATA_SCADENZA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selT691BUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      FieldName = 'BUONIPASTO'
    end
    object selT691TICKET: TIntegerField
      DisplayLabel = 'Ticket'
      FieldName = 'TICKET'
    end
    object selT691ID_DAL: TFloatField
      DisplayLabel = 'Dal blocchetto'
      FieldName = 'ID_DAL'
    end
    object selT691ID_AL: TFloatField
      DisplayLabel = 'Al blocchetto'
      FieldName = 'ID_AL'
    end
    object selT691DIM_BLOCCHETTO: TIntegerField
      DisplayLabel = 'Buoni per blocchetto'
      FieldName = 'DIM_BLOCCHETTO'
    end
  end
  object dsrT691: TDataSource
    AutoEdit = False
    DataSet = selT691
    Left = 16
    Top = 56
  end
end
