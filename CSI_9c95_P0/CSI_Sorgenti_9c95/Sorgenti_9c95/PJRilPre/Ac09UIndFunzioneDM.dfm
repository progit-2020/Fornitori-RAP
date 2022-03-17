inherited Ac09FIndFunzioneDM: TAc09FIndFunzioneDM
  OldCreateOrder = True
  Height = 102
  Width = 240
  object selCSI006: TOracleDataSet
    SQL.Strings = (
      
        'select CSI006.ROWID, CSI006.ID, CSI006.PROGRESSIVO, T030.MATRICO' +
        'LA, T030.COGNOME, T030.NOME,'
      
        '       CSI006.DATA, T430.CONTRATTO, CSI006.TIMBRATURE, CSI006.GI' +
        'USTIFICATIVI, CSI006.ORARIO, CSI006.ORE_ASSENZA, CSI006.ORE_RESE' +
        ','
      '       CSI007.TIPO_RECORD, CSI007.FASCIA, '
      
        '       LPAD(minutiore(sum(oreminuti(CSI007.ORE))),5,'#39'0'#39') SUM_ORE' +
        ', '
      
        '       LPAD(minutiore(sum(oreminuti(CSI007.DISAGIO_SERALE))),5,'#39 +
        '0'#39') SUM_DISAGIO_SERALE,'
      '       :ListaIndFunzione as LISTA_INDFUNZIONE'
      '  from CSI006_CART_INDFUNZIONE CSI006,'
      '       CSI007_CART_INDFUNZIONE_DETT CSI007,'
      '       T030_ANAGRAFICO T030,'
      '       T430_STORICO T430'
      ' where CSI006.ID = CSI007.ID (+)'
      '   and CSI006.PROGRESSIVO = :PROGRESSIVO'
      '   and CSI006.DATA between :PeriodoDa and :PeriodoA'
      
        '   and (nvl(CSI007.TIPO_RECORD,:TipoRecord) = :TipoRecord or :Ti' +
        'poRecord = '#39'E'#39')'
      '   and T030.PROGRESSIVO = CSI006.PROGRESSIVO'
      '   and T430.PROGRESSIVO = CSI006.PROGRESSIVO'
      '   and CSI006.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        ' group by CSI006.ROWID, CSI006.ID, CSI006.PROGRESSIVO, T030.MATR' +
        'ICOLA, T030.COGNOME, T030.NOME,'
      
        '       CSI006.DATA, T430.CONTRATTO, CSI006.TIMBRATURE, CSI006.GI' +
        'USTIFICATIVI, CSI006.ORARIO, CSI006.ORE_ASSENZA, CSI006.ORE_RESE' +
        ','
      '       CSI007.TIPO_RECORD, CSI007.FASCIA'
      ' order by CSI006.DATA, CSI007.FASCIA, CSI007.TIPO_RECORD')
    ReadBuffer = 9000
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0050004500520049004F00
      44004F00440041000C0000000000000000000000120000003A00500045005200
      49004F0044004F0041000C0000000000000000000000160000003A0054004900
      50004F005200450043004F005200440005000000000000000000000022000000
      3A004C00490053005400410049004E004400460055004E005A0049004F004E00
      4500010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F000100000000000C00000052004F0057004E0055004D000100000000003C00
      000054004F005F00430048004100520028003900390039003900390039003900
      39002D0054004F005F004E0055004D00420045005200280054004F005F000100
      000000001A00000043004F0044005F0043004F004E0054005200410054005400
      4F000100000000001000000043004F0044005F0056004F004300450001000000
      00002200000043004F0044005F0056004F00430045005F005300500045004300
      490041004C0045000100000000001E0000004400450043004F00520052004500
      4E005A0041005F00460049004E0045000100000000000E00000049004D005000
      4F00520054004F000100000000001C00000049004D0050004F00520054004F00
      5F0049004E005400450052004F000100000000000E0000004F00520049004700
      49004E0045000100000000000A00000053005400410054004F00010000000000
      220000004400450043004F005200520045004E005A0041005F0049004E004900
      5A0049004F0001000000000026000000490044005F0056004F00430045005F00
      500052004F004700520041004D004D0041005400410001000000000012000000
      5400490050004F005F0056004F0043004500010000000000}
    ReadOnly = True
    BeforePost = BeforePostNoStorico
    AfterScroll = selCSI006AfterScroll
    OnCalcFields = selCSI006CalcFields
    Left = 25
    Top = 12
    object selCSI006ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selCSI006PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selCSI006MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selCSI006COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object selCSI006NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object selCSI006DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selCSI006CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      DisplayWidth = 7
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object selCSI006FASCIA: TStringField
      DisplayLabel = 'Fascia'
      DisplayWidth = 7
      FieldName = 'FASCIA'
      Size = 5
    end
    object selCSI006TIPO_RECORD: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECORD'
      Size = 1
    end
    object selCSI006LISTA_INDFUNZIONE: TStringField
      DisplayLabel = 'Indennit'#224' di funzione'
      DisplayWidth = 20
      FieldName = 'LISTA_INDFUNZIONE'
      Size = 100
    end
    object selCSI006SUM_ORE: TStringField
      DisplayLabel = 'HH ind.'
      FieldName = 'SUM_ORE'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selCSI006SUM_DISAGIO_SERALE: TStringField
      DisplayLabel = 'HH dis. serale'
      FieldName = 'SUM_DISAGIO_SERALE'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selCSI006TIMBRATURE: TStringField
      DisplayLabel = 'Timbrature'
      DisplayWidth = 25
      FieldName = 'TIMBRATURE'
      Size = 1000
    end
    object selCSI006GIUSTIFICATIVI: TStringField
      DisplayLabel = 'Giustificativi'
      DisplayWidth = 25
      FieldName = 'GIUSTIFICATIVI'
      Size = 1000
    end
    object selCSI006ORARIO: TStringField
      DisplayLabel = 'Orario'
      DisplayWidth = 7
      FieldName = 'ORARIO'
      Size = 5
    end
    object selCSI006ORE_ASSENZA: TStringField
      DisplayLabel = 'HH ass.'
      FieldName = 'ORE_ASSENZA'
      Size = 5
    end
    object selCSI006ORE_RESE: TStringField
      DisplayLabel = 'HH rese'
      FieldName = 'ORE_RESE'
      Size = 5
    end
    object selCSI006SUM_ORE_A: TStringField
      FieldKind = fkCalculated
      FieldName = 'SUM_ORE_A'
      Visible = False
      Size = 5
      Calculated = True
    end
    object selCSI006SUM_DISAGIO_SERALE_A: TStringField
      FieldKind = fkCalculated
      FieldName = 'SUM_DISAGIO_SERALE_A'
      Visible = False
      Size = 5
      Calculated = True
    end
  end
end
