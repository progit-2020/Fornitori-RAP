inherited Ac02FLimitiRendiProjDtM: TAc02FLimitiRendiProjDtM
  OldCreateOrder = True
  Height = 92
  Width = 85
  object selT753: TOracleDataSet
    SQL.Strings = (
      'select T753.*, T753.ROWID, '
      '       T750.CODICE C_PROG, T750.DESCRIZIONE D_PROG,'
      '       T751.CODICE C_ATT, T751.DESCRIZIONE D_ATT, T751.ID_T750,'
      '       T752.CODICE C_TASK, T752.DESCRIZIONE D_TASK, T752.ID_T751'
      'from   T753_LIMITI_IND_RENDICONTO T753,'
      '       T752_TASK_RENDICONTO T752,'
      '       T751_ATTIVITA_RENDICONTO T751,'
      '       T750_PROGETTI_RENDICONTO T750'
      'where  T753.PROGRESSIVO = :PROGRESSIVO'
      'and    T753.ID_T752 = T752.ID'
      'and    T752.ID_T751 = T751.ID'
      'and    T751.ID_T750 = T750.ID'
      'order by :ORDINAMENTO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004F005200440049004E00
      41004D0045004E0054004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001E00000044004100540041005F0043004F004D0050004500
      540045004E005A0041000100000000002400000043004F0044005F004D004900
      53005500520041005100550041004E0054004900540041000100000000000E00
      00004F0052004900470049004E00450001000000000016000000540049005000
      4F005F005200450043004F005200440001000000000010000000510055004100
      4E0054004900540041000100000000000800000046004C004100470001000000
      00001A00000044004100540041005F004300450044004F004C0049004E004F00
      010000000000}
    BeforePost = BeforePostNoStorico
    BeforeDelete = BeforeDelete
    OnFilterRecord = selT753FilterRecord
    Left = 24
    Top = 16
    object selT753ID_T750: TFloatField
      DisplayLabel = 'ID Progetto'
      FieldName = 'ID_T750'
      ReadOnly = True
    end
    object selT753C_PROG: TStringField
      DisplayLabel = 'Progetto'
      FieldName = 'C_PROG'
      ReadOnly = True
    end
    object selT753D_PROG: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'D_PROG'
      ReadOnly = True
      Size = 100
    end
    object selT753ID_T751: TFloatField
      DisplayLabel = 'ID Attivit'#224
      FieldName = 'ID_T751'
      ReadOnly = True
    end
    object selT753C_ATT: TStringField
      DisplayLabel = 'Attivit'#224
      FieldName = 'C_ATT'
      ReadOnly = True
      Size = 10
    end
    object selT753D_ATT: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'D_ATT'
      ReadOnly = True
      Size = 100
    end
    object selT753ID_T752: TFloatField
      DisplayLabel = 'ID Task'
      FieldName = 'ID_T752'
      ReadOnly = True
    end
    object selT753C_TASK: TStringField
      DisplayLabel = 'Task'
      FieldName = 'C_TASK'
      ReadOnly = True
      Size = 10
    end
    object selT753D_TASK: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'D_TASK'
      ReadOnly = True
      Size = 100
    end
    object selT753PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
    end
    object selT753DECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'DECORRENZA'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT753DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'DECORRENZA_FINE'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT753ORE_MAX: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE_MAX'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT753ORE_FRUITO: TStringField
      DisplayLabel = 'Fruito'
      FieldName = 'ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
  end
end
