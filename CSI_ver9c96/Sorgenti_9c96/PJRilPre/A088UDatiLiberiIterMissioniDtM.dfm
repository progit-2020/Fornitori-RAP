inherited A088FDatiLiberiIterMissioniDtM: TA088FDatiLiberiIterMissioniDtM
  OldCreateOrder = True
  Height = 131
  Width = 195
  object selM025: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATO' +
        'RIO, RIGHE, FORMATO, LUNG_MAX, DATO_ANAGRAFICO, QUERY_VALORE, EL' +
        'ENCO_FISSO, VALORE_DEFAULT , ROWID'
      'from   M025_MOTIVAZIONI M025'
      'where  CATEGORIA = :CODICE'
      'order by ORDINE, CODICE, DESCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = selM025BeforePost
    BeforeDelete = selM025BeforeDelete
    OnNewRecord = selM025NewRecord
    Left = 104
    Top = 16
    object selM025CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selM025DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 35
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selM025CATEGORIA: TStringField
      DisplayLabel = 'Categoria'
      FieldName = 'CATEGORIA'
      Size = 5
    end
    object selM025ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
      MaxValue = 9999
    end
    object selM025OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selM025RIGHE: TIntegerField
      DisplayLabel = 'Righe'
      DisplayWidth = 2
      FieldName = 'RIGHE'
      MaxValue = 9
      MinValue = 1
    end
    object selM025FORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Size = 1
    end
    object selM025LUNG_MAX: TIntegerField
      DisplayLabel = 'Lung. max'
      DisplayWidth = 4
      FieldName = 'LUNG_MAX'
      MaxValue = 9999
    end
    object selM025ELENCO_FISSO: TStringField
      DisplayLabel = 'Elenco fisso'
      FieldName = 'ELENCO_FISSO'
      Size = 1
    end
    object selM025VALORI: TStringField
      DisplayLabel = 'Valori'
      DisplayWidth = 15
      FieldName = 'VALORI'
      Size = 2000
    end
    object selM025DATO_ANAGRAFICO: TStringField
      DisplayLabel = 'Dato anagrafico'
      DisplayWidth = 15
      FieldName = 'DATO_ANAGRAFICO'
      Size = 30
    end
    object selM025QUERY_VALORE: TStringField
      DisplayLabel = 'Interrog. servizio'
      DisplayWidth = 15
      FieldName = 'QUERY_VALORE'
      Size = 30
    end
    object selM025VALORE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 10
      FieldName = 'VALORE_DEFAULT'
      Size = 2000
    end
  end
  object selM024: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, ORDINE, MIN_FASE_VISIBILE, MAX_FASE_' +
        'VISIBILE, MIN_FASE_MODIFICA, MAX_FASE_MODIFICA, ROWID'
      'from   M024_CATEG_DATI_LIBERI M024'
      'order by ORDINE, CODICE')
    ReadBuffer = 10
    Optimize = False
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    BeforeDelete = BeforeDelete
    AfterScroll = selM024AfterScroll
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 16
    object selM024CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 6
      FieldName = 'CODICE'
      Size = 5
    end
    object selM024DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selM024ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
      MaxValue = 9999
      MinValue = 1
    end
    object selM024MIN_FASE_VISIBILE: TIntegerField
      DisplayLabel = 'Visibilit'#224' fase min'
      FieldName = 'MIN_FASE_VISIBILE'
      MaxValue = 99
      MinValue = -1
    end
    object selM024MAX_FASE_VISIBILE: TIntegerField
      DisplayLabel = 'Visibilit'#224' fase max'
      FieldName = 'MAX_FASE_VISIBILE'
      MaxValue = 99
      MinValue = -1
    end
    object selM024MIN_FASE_MODIFICA: TIntegerField
      DisplayLabel = 'Modifica fase min'
      FieldName = 'MIN_FASE_MODIFICA'
    end
    object selM024MAX_FASE_MODIFICA: TIntegerField
      DisplayLabel = 'Modifica fase max'
      FieldName = 'MAX_FASE_MODIFICA'
    end
  end
  object dsrM025: TDataSource
    DataSet = selM025
    Left = 104
    Top = 72
  end
end
