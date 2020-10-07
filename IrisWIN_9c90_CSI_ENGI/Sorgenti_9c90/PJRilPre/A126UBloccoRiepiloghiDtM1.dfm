object A126FBloccoRiepiloghiDtM1: TA126FBloccoRiepiloghiDtM1
  OldCreateOrder = True
  OnCreate = A126FBloccoRiepiloghiDtM1Create
  OnDestroy = A126FBloccoRiepiloghiDtM1Destroy
  Height = 138
  Width = 252
  object selT180: TOracleDataSet
    SQL.Strings = (
      
        'select matricola, cognome || '#39' '#39' || nome nome, t180.progressivo,' +
        ' t180.riepilogo, '
      
        '  to_char(t180.dal,'#39'mm/yyyy'#39') dadata, to_char(t180.al,'#39'mm/yyyy'#39')' +
        ' adata, t180.rowid'
      'from t180_datibloccati t180, t030_anagrafico t030'
      'where '
      '  t180.progressivo = t030.progressivo and '
      '  t180.dal <= :data2 and '
      '  t180.al >= :data1 and'
      '  riepilogo in (:riepilogo) and'
      '  t180.stato = '#39'C'#39
      'order by :orderby')
    ReadBuffer = 2000
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A00520049004500500049004C004F0047004F00
      0100000004000000272A270000000000100000003A004F005200440045005200
      42005900010000000A0000004D41545249434F4C4100000000000C0000003A00
      440041005400410031000C00000000000000000000000C0000003A0044004100
      5400410032000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000120000004D00410054005200490043004F004C0041000100
      00000000080000004E004F004D00450001000000000012000000520049004500
      500049004C004F0047004F0001000000000016000000500052004F0047005200
      450053005300490056004F000100000000000C00000044004100440041005400
      41000100000000000A00000041004400410054004100010000000000}
    BeforeInsert = selT180BeforeInsert
    BeforeEdit = selT180BeforeInsert
    BeforeDelete = selT180BeforeDelete
    OnCalcFields = selT180CalcFields
    OnFilterRecord = selT180FilterRecord
    Left = 16
    Top = 7
    object selT180MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT180NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 61
    end
    object selT180RIEPILOGO: TStringField
      DisplayLabel = 'Riepilogo'
      FieldName = 'RIEPILOGO'
      Required = True
      Size = 6
    end
    object selT180D_Riepilogo: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_Riepilogo'
      Size = 30
      Calculated = True
    end
    object selT180DADATA: TStringField
      DisplayLabel = 'Dal'
      FieldName = 'DADATA'
      Size = 7
    end
    object selT180ADATA: TStringField
      DisplayLabel = 'Al'
      FieldName = 'ADATA'
      Size = 7
    end
    object selT180PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
  end
  object dsrT180: TDataSource
    DataSet = selT180
    Left = 16
    Top = 55
  end
end
