inherited S720FProfiliAreeDtM: TS720FProfiliAreeDtM
  OldCreateOrder = True
  Height = 300
  Width = 487
  object selSG720: TOracleDataSet
    SQL.Strings = (
      'select SG720.*, SG720.ROWID'
      'from   SG720_PROFILI_AREE SG720'
      'order by DATO1, DATO2, DATO3, DATO4, COD_AREA, DECORRENZA')
    Optimize = False
    BeforePost = BeforePost
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 24
    object selSG720DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG720DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG720DATO1: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO1'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO1'
      LookupDataSet = selDato1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 100
      Lookup = True
    end
    object selSG720DATO2: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO2'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO2'
      LookupDataSet = selDato2
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 100
      Lookup = True
    end
    object selSG720DATO3: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO3'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO3: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO3'
      LookupDataSet = selDato3
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 100
      Lookup = True
    end
    object selSG720DATO4: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO4'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO4: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO4'
      LookupDataSet = selDato4
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO4'
      Size = 100
      Lookup = True
    end
    object selSG720COD_AREA: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selSG720DESCRIZIONE: TStringField
      DisplayLabel = 'Area'
      DisplayWidth = 35
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupDataSet = selArea
      LookupKeyFields = 'COD_AREA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_AREA'
      Size = 100
      Lookup = True
    end
  end
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 112
    Top = 24
  end
  object dsrDato1: TDataSource
    DataSet = selDato1
    Left = 112
    Top = 80
  end
  object selDato2: TOracleDataSet
    Optimize = False
    Left = 176
    Top = 24
  end
  object selDato3: TOracleDataSet
    Optimize = False
    Left = 240
    Top = 24
  end
  object dsrDato2: TDataSource
    DataSet = selDato2
    Left = 176
    Top = 80
  end
  object dsrDato3: TDataSource
    DataSet = selDato3
    Left = 240
    Top = 80
  end
  object selArea: TOracleDataSet
    SQL.Strings = (
      'select cod_area, descrizione '
      'from SG701_AREE_VALUTAZIONI'
      'where sysdate between decorrenza and decorrenza_fine'
      'order by cod_area')
    Optimize = False
    Left = 392
    Top = 24
  end
  object dsrArea: TDataSource
    DataSet = selArea
    Left = 392
    Top = 80
  end
  object selSG720a: TOracleQuery
    SQL.Strings = (
      'select count(*) n_dec_intersecanti'
      'from   sg720_profili_aree'
      'where  dato1 = :dato1'
      'and    dato2 = :dato2'
      'and    dato3 = :dato3'
      'and    dato4 = :dato4'
      'and    cod_area = :cod_area'
      ':cond_rowid'
      'and    (   :decorrenza between decorrenza and decorrenza_fine'
      '        or :scadenza   between decorrenza and decorrenza_fine'
      
        '        or (:decorrenza < decorrenza and :scadenza > decorrenza_' +
        'fine))')
    Optimize = False
    Variables.Data = {
      04000000080000000C0000003A004400410054004F0031000500000000000000
      000000000C0000003A004400410054004F003200050000000000000000000000
      0C0000003A004400410054004F00330005000000000000000000000012000000
      3A0043004F0044005F0041005200450041000500000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000120000003A00530043004100440045004E005A0041000C0000000000
      000000000000160000003A0043004F004E0044005F0052004F00570049004400
      0100000000000000000000000C0000003A004400410054004F00340005000000
      0000000000000000}
    Left = 24
    Top = 136
  end
  object selDato4: TOracleDataSet
    Optimize = False
    Left = 304
    Top = 24
  end
  object dsrDato4: TDataSource
    DataSet = selDato4
    Left = 304
    Top = 80
  end
end
