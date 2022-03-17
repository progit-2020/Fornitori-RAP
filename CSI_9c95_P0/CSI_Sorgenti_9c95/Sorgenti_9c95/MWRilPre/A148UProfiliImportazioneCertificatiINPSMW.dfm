inherited A148FProfiliImportazioneCertificatiINPSMW: TA148FProfiliImportazioneCertificatiINPSMW
  OldCreateOrder = True
  object selFiltroNull: TOracleDataSet
    SQL.Strings = (
      'select T269.*'
      '  from T269_RELAZIONI_ATTESTATIINPS T269'
      ' where T269.FILTRO is null')
    Optimize = False
    Left = 32
    Top = 16
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'select T265.CODICE, T265.CODICE||'#39' - '#39'||T265.DESCRIZIONE as DESC' +
        'RIZIONE'
      '  from T265_CAUASSENZE T265 '
      ' where T265.VISITA_FISCALE = '#39'S'#39
      ' order by T265.CODICE')
    Optimize = False
    Left = 88
    Top = 16
    object selT265CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selT265_All: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.CODICE, T265.CODICE||'#39' - '#39'||T265.DESCRIZIONE as DESC' +
        'RIZIONE'
      '  FROM T265_CAUASSENZE T265'
      ' ORDER BY T265.CODICE, T265.DESCRIZIONE')
    Optimize = False
    Left = 140
    Top = 17
    object selT265_AllCODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object selT265_AllDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selI500: TOracleDataSet
    SQL.Strings = (
      'select I500.NOMECAMPO'
      '  from I500_DATILIBERI I500'
      ' where I500.TABELLA = '#39'S'#39
      '   and I500.STORICO = '#39'N'#39
      '   and I500.LUNGHEZZA = 1'
      ' order by I500.NOMECAMPO')
    Optimize = False
    Left = 32
    Top = 72
  end
end
