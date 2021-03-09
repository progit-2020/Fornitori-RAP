inherited S706FValutatoriDipendenteDtM: TS706FValutatoriDipendenteDtM
  OldCreateOrder = True
  Height = 216
  Width = 346
  object selSG706: TOracleDataSet
    SQL.Strings = (
      'select sg706.*, sg706.rowid'
      'from SG706_VALUTATORI_DIPENDENTE sg706, T030_ANAGRAFICO T030'
      'where sg706.progressivo = :PROGRESSIVO'
      '  and t030.progressivo = sg706.progressivo_valutato'
      'order by sg706.decorrenza desc, t030.cognome, t030.nome')
    Optimize = False
    Variables.Data = {
      03000000010000000C0000003A50524F475245535349564F0300000000000000
      00000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A0000000B00000050524F475245535349564F0100000000000C0000
      005449504F5F5249534348494F0100000000000B000000444154415F494E495A
      494F0100000000000B000000444154415F5649534954410100000000000C0000
      00455349544F5F56495349544101000000000010000000444154415F50524F58
      5F564953495441010000000000040000004E4F5445010000000000070000004F
      47474554544F0100000000000C000000505245534352495A494F4E4501000000
      00000A000000444154415F455349544F010000000000}
    OnApplyRecord = selSG706ApplyRecord
    BeforeInsert = BeforeInsert
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = selSG706AfterScroll
    OnCalcFields = selSG706CalcFields
    Left = 24
    Top = 16
    object selSG706DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG706DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG706MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkCalculated
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
      Calculated = True
    end
    object selSG706NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      FieldKind = fkCalculated
      FieldName = 'NOMINATIVO'
      Size = 100
      Calculated = True
    end
    object selSG706PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progr. valutatore'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG706PROGRESSIVO_VALUTATO: TIntegerField
      DisplayLabel = 'Progr. valutato'
      FieldName = 'PROGRESSIVO_VALUTATO'
      ReadOnly = True
      Visible = False
    end
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      
        'select progressivo, matricola, cognome || '#39' '#39' || nome nominativo' +
        ', codfiscale'
      'from t030_anagrafico'
      'order by cognome,nome,matricola')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      04000000040000000B00000050524F475245535349564F010000000000090000
      004D41545249434F4C4101000000000007000000434F474E4F4D450100000000
      00040000004E4F4D45010000000000}
    Left = 168
    Top = 16
    object selT030PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT030MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT030NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 70
    end
    object selT030CODFISCALE: TStringField
      FieldName = 'CODFISCALE'
      Size = 16
    end
  end
  object insSG706: TOracleQuery
    SQL.Strings = (
      'insert into SG706_VALUTATORI_DIPENDENTE '
      '(progressivo,decorrenza,decorrenza_fine,progressivo_valutato)'
      'values'
      
        '(:PROGRESSIVO,:DECORRENZA,:DECORRENZA_FINE,:PROGRESSIVO_VALUTATO' +
        ')')
    Optimize = False
    Variables.Data = {
      03000000040000000C0000003A50524F475245535349564F0300000000000000
      000000000B0000003A4445434F5252454E5A410C000000000000000000000010
      0000003A4445434F5252454E5A415F46494E450C000000000000000000000015
      0000003A50524F475245535349564F5F56414C555441544F0300000000000000
      00000000}
    Left = 24
    Top = 80
  end
  object delSG706: TOracleQuery
    SQL.Strings = (
      'delete from SG706_VALUTATORI_DIPENDENTE '
      'where progressivo = :PROGRESSIVO'
      'and decorrenza = :DECORRENZA'
      'and decorrenza_fine = :DECORRENZA_FINE'
      'and progressivo_valutato = :PROGRESSIVO_VALUTATO')
    Optimize = False
    Variables.Data = {
      03000000040000000C0000003A50524F475245535349564F0300000000000000
      000000000B0000003A4445434F5252454E5A410C000000000000000000000015
      0000003A50524F475245535349564F5F56414C555441544F0300000000000000
      00000000100000003A4445434F5252454E5A415F46494E450C00000000000000
      00000000}
    Left = 24
    Top = 144
  end
  object selSG706a: TOracleDataSet
    SQL.Strings = (
      
        'select T030.matricola, T030.cognome || '#39' '#39' || T030.nome nominati' +
        'vo, SG706.decorrenza, SG706.decorrenza_fine'
      'from sg706_valutatori_dipendente SG706, t030_anagrafico T030'
      'where SG706.progressivo_valutato = :prog'
      
        'and (   (:dec_ini between SG706.decorrenza and SG706.decorrenza_' +
        'fine)'
      
        '     or (:dec_fin between SG706.decorrenza and SG706.decorrenza_' +
        'fine)'
      
        '     or (:dec_ini < SG706.decorrenza and :dec_fin > SG706.decorr' +
        'enza_fine))'
      'and SG706.progressivo = T030.progressivo'
      'order by SG706.decorrenza desc')
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A50524F47030000000000000000000000080000
      003A4445435F494E490C0000000000000000000000080000003A4445435F4649
      4E0C0000000000000000000000}
    Left = 96
    Top = 16
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct'
      '       t030.progressivo,'
      '       t030.matricola,'
      '       :campo CODICE,'
      '       :campo2 CODICE2,'
      '       t030.cognome||'#39' '#39'||t030.nome nominativo,'
      '       t030.codfiscale,'
      '       decode(:campo,:dato,'#39'A'#39','#39'B'#39'),'
      '       decode(:campo2,:dato2,'#39'A'#39','#39'B'#39')'
      'from  t030_anagrafico t030,'
      '      t430_storico    t430'
      'where t030.progressivo = t430.progressivo'
      'and   :DataFine between t430.datadecorrenza and t430.datafine'
      'order by decode(:campo,:dato,'#39'A'#39','#39'B'#39'),'
      '         :campo,'
      '         decode(:campo2,:dato2,'#39'A'#39','#39'B'#39'),'
      '         :campo2,'
      '         t030.cognome||'#39' '#39'||t030.nome ')
    Optimize = False
    Variables.Data = {
      0300000005000000060000003A43414D504F0100000000000000000000000500
      00003A4441544F050000000000000000000000070000003A43414D504F320100
      00000000000000000000060000003A4441544F32050000000000000000000000
      090000003A4441544146494E450C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000040000000B00000050524F475245535349564F010000000000090000
      004D41545249434F4C4101000000000007000000434F474E4F4D450100000000
      00040000004E4F4D45010000000000}
    Left = 232
    Top = 16
  end
  object selCOLS: TOracleDataSet
    SQL.Strings = (
      'select data_length'
      'from  COLS'
      'where table_name = '#39'I501'#39'||:CAMPO'
      'and   column_name = '#39'CODICE'#39)
    Optimize = False
    Variables.Data = {0300000001000000060000003A43414D504F010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000040000000B00000050524F475245535349564F010000000000090000
      004D41545249434F4C4101000000000007000000434F474E4F4D450100000000
      00040000004E4F4D45010000000000}
    Left = 288
    Top = 16
  end
end
