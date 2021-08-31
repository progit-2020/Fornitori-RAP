inherited A054FCicliTurniMW: TA054FCicliTurniMW
  OldCreateOrder = True
  Height = 135
  Width = 311
  object Q611CancellaCiclo: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T611_CICLIGIORNALIERI '
      'WHERE CICLO = :CICLO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A004300490043004C004F000500000000000000
      00000000}
    Left = 223
    Top = 64
  end
  object Q611AggiornaCiclo: TOracleQuery
    SQL.Strings = (
      'UPDATE T611_CICLIGIORNALIERI SET CICLO= :CICLO'
      'WHERE CICLO = :CICLO_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A004300490043004C004F000500000000000000
      00000000140000003A004300490043004C004F005F004F004C00440005000000
      0000000000000000}
    Left = 223
    Top = 8
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 156
    Top = 8
  end
  object Q021: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T021.CODICE, T021.ENTRATA, T021.USCITA, T021.SIGLATURNI, ' +
        'T021.NUMTURNO'
      '  FROM T021_FASCEORARI T021'
      ' WHERE T021.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                            FROM T021_FASCEORARI '
      '                           WHERE CODICE = T021.CODICE)'
      '   AND TIPO_FASCIA = '#39'PN'#39
      ' ORDER BY T021.CODICE, T021.ENTRATA, T021.USCITA')
    Optimize = False
    Left = 120
    Top = 64
  end
  object Q020: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,MAX(DESCRIZIONE) DESCRIZIONE FROM T020_ORARI GROUP' +
        ' BY CODICE')
    Optimize = False
    Left = 120
    Top = 8
  end
  object Q611: TOracleDataSet
    SQL.Strings = (
      'SELECT T611.*,T611.ROWID '
      '  FROM T611_CICLIGIORNALIERI T611'
      ' WHERE CICLO = :CICLO'
      ' :ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A004300490043004C004F000500000000000000
      00000000100000003A004F005200440045005200420059000100000000000000
      00000000}
    ReadOnly = True
    CachedUpdates = True
    BeforeEdit = Q611BeforeEdit
    BeforePost = Q611BeforePost
    OnCalcFields = Q611CalcFields
    OnNewRecord = Q611NewRecord
    Left = 20
    Top = 8
    object Q611CICLO: TStringField
      DisplayLabel = 'Ciclo'
      FieldName = 'CICLO'
      Origin = 'T611_CICLIGIORNALIERI.CICLO'
      Required = True
      Visible = False
      Size = 5
    end
    object Q611GIORNO: TFloatField
      DisplayLabel = 'Giorno'
      DisplayWidth = 6
      FieldName = 'GIORNO'
      Origin = 'T611_CICLIGIORNALIERI.GIORNO'
      ReadOnly = True
    end
    object Q611ORARIO: TStringField
      DisplayLabel = 'Orario'
      DisplayWidth = 10
      FieldName = 'ORARIO'
      Origin = 'T611_CICLIGIORNALIERI.ORARIO'
      OnValidate = Q611ORARIOValidate
      Size = 5
    end
    object Q611CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 10
      FieldName = 'CAUSALE'
      Origin = 'T611_CICLIGIORNALIERI.CAUSALE'
      OnValidate = Q611CAUSALEValidate
      Size = 5
    end
    object Q611TURNO1: TStringField
      DisplayLabel = 'Fascia T1'
      DisplayWidth = 2
      FieldName = 'TURNO1'
      Origin = 'T611_CICLIGIORNALIERI.TURNO1'
      OnSetText = Q611TURNO1SetText
      OnValidate = Q611TURNO1Validate
      Size = 2
    end
    object Q611TURNO1EU: TStringField
      DisplayLabel = 'Turno 1 EU'
      FieldName = 'TURNO1EU'
      Origin = 'T611_CICLIGIORNALIERI.TURNO1EU'
      Size = 1
    end
    object Q611numturno1: TStringField
      DisplayLabel = 'Num. T1'
      FieldKind = fkCalculated
      FieldName = 'numturno1'
      Size = 1
      Calculated = True
    end
    object Q611siglaturno1: TStringField
      DisplayLabel = 'Sigla T1'
      FieldKind = fkCalculated
      FieldName = 'siglaturno1'
      Size = 2
      Calculated = True
    end
    object Q611entrata1: TStringField
      DisplayLabel = 'Entrata T1'
      FieldKind = fkCalculated
      FieldName = 'entrata1'
      Size = 5
      Calculated = True
    end
    object Q611uscita1: TStringField
      DisplayLabel = 'Uscita T1'
      FieldKind = fkCalculated
      FieldName = 'uscita1'
      Size = 5
      Calculated = True
    end
    object Q611TURNO2: TStringField
      DisplayLabel = 'Fascia T2'
      DisplayWidth = 2
      FieldName = 'TURNO2'
      Origin = 'T611_CICLIGIORNALIERI.TURNO2'
      OnSetText = Q611TURNO1SetText
      OnValidate = Q611TURNO2Validate
      Size = 2
    end
    object Q611TURNO2EU: TStringField
      DisplayLabel = 'Turno 2 EU'
      FieldName = 'TURNO2EU'
      Origin = 'T611_CICLIGIORNALIERI.TURNO2EU'
      Size = 1
    end
    object Q611numturno2: TStringField
      DisplayLabel = 'Num. T2'
      FieldKind = fkCalculated
      FieldName = 'numturno2'
      Size = 1
      Calculated = True
    end
    object Q611siglaturno2: TStringField
      DisplayLabel = 'Sigla T2'
      FieldKind = fkCalculated
      FieldName = 'siglaturno2'
      Size = 2
      Calculated = True
    end
    object Q611entrata2: TStringField
      DisplayLabel = 'Entrata T2'
      FieldKind = fkCalculated
      FieldName = 'entrata2'
      Size = 5
      Calculated = True
    end
    object Q611uscita2: TStringField
      DisplayLabel = 'Uscita T2'
      FieldKind = fkCalculated
      FieldName = 'uscita2'
      Size = 5
      Calculated = True
    end
  end
  object D611: TDataSource
    DataSet = Q611
    OnDataChange = D611DataChange
    Left = 64
    Top = 8
  end
end
