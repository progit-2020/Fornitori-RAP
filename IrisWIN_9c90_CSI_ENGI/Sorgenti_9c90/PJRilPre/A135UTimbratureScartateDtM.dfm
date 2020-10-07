inherited A135FTimbratureScartateDtM: TA135FTimbratureScartateDtM
  OldCreateOrder = True
  object selT103: TOracleDataSet
    SQL.Strings = (
      'select t103.*, rowid'
      'from   t103_timbrature_scartate t103'
      'where'#9't103.progressivo = :progressivo'
      'and'#9't103.data between :datainizio and :datafine'
      'order by t103.data, t103.ora')
    Variables.Data = {
      03000000030000000C0000003A50524F475245535349564F0300000000000000
      000000000B0000003A44415441494E495A494F0C000000000000000000000009
      0000003A4441544146494E450C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000070000000B00000050524F475245535349564F010000000000040000
      0044415441010000000000030000004F52410100000000000500000056455253
      4F01000000000004000000464C41470100000000000A00000052494C45564154
      4F52450100000000000700000043415553414C45010000000000}
    BeforeInsert = selT103BeforeInsert
    AfterScroll = selT103AfterScroll
    Left = 24
    Top = 16
    object selT103PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT103DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
    object selT103ORA: TDateTimeField
      DisplayLabel = 'Ora'
      DisplayWidth = 8
      FieldName = 'ORA'
      ReadOnly = True
      Required = True
      OnGetText = selT103ORAGetText
      DisplayFormat = 'hh.mm'
    end
    object selT103VERSO: TStringField
      DisplayLabel = 'Verso'
      DisplayWidth = 3
      FieldName = 'VERSO'
      Required = True
      Size = 1
    end
    object selT103FLAG: TStringField
      DisplayWidth = 1
      FieldName = 'FLAG'
      Required = True
      Visible = False
      Size = 1
    end
    object selT103RILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      DisplayWidth = 10
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selT103CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 8
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      'select t100.*, rowid'
      'from   t100_timbrature t100'
      'where'#9't100.progressivo = :progressivo'
      'and'#9't100.data = :datagiorno'
      'and'#9'flag in ('#39'O'#39','#39'I'#39')'
      'order by t100.data, t100.ora')
    Variables.Data = {
      03000000020000000C0000003A50524F475245535349564F0300000000000000
      000000000B0000003A4441544147494F524E4F0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000070000000B00000050524F475245535349564F010000000000040000
      0044415441010000000000030000004F52410100000000000500000056455253
      4F01000000000004000000464C41470100000000000A00000052494C45564154
      4F52450100000000000700000043415553414C45010000000000}
    ReadOnly = True
    Left = 24
    Top = 72
    object FloatField1: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'Ora'
      DisplayWidth = 8
      FieldName = 'ORA'
      Required = True
      OnGetText = DateTimeField2GetText
      DisplayFormat = 'hh.mm'
    end
    object StringField1: TStringField
      DisplayLabel = 'Verso'
      DisplayWidth = 3
      FieldName = 'VERSO'
      Required = True
      Size = 1
    end
    object StringField2: TStringField
      FieldName = 'FLAG'
      Required = True
      Visible = False
      Size = 1
    end
    object StringField3: TStringField
      DisplayLabel = 'Rilevatore'
      DisplayWidth = 10
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object StringField4: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 8
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object D100: TDataSource
    DataSet = selT100
    Left = 64
    Top = 72
  end
end
