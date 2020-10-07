inherited A148FProfiliImportazioneCertificatiINPSDtm: TA148FProfiliImportazioneCertificatiINPSDtm
  OldCreateOrder = True
  Height = 103
  Width = 139
  object selT269: TOracleDataSet
    SQL.Strings = (
      'select T269.*, T269.ROWID'
      '  from T269_RELAZIONI_ATTESTATIINPS T269'
      ' order by decode(T269.FILTRO,null,1,0), T269.CODICE')
    Optimize = False
    CompressBLOBs = True
    BeforePost = selT269BeforePost
    Left = 24
    Top = 8
    object selT269CODICE: TStringField
      DisplayLabel = 'Profilo'
      DisplayWidth = 15
      FieldName = 'CODICE'
    end
    object selT269FILTRO: TStringField
      DisplayLabel = 'Selezione'
      DisplayWidth = 40
      FieldName = 'FILTRO'
      Size = 2000
    end
    object selT269dCProvvisoria: TStringField
      DisplayLabel = 'Causale provvisoria'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCProvvisoria'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_PROVVISORIA'
      Size = 40
      Lookup = True
    end
    object selT269dCInserimento: TStringField
      DisplayLabel = 'Causale di inserimento'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCInserimento'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_INSERIMENTO'
      Size = 40
      Lookup = True
    end
    object selT269dCRicovero: TStringField
      DisplayLabel = 'Causale di ricovero'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCRicovero'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_RICOVERO'
      Size = 40
      Lookup = True
    end
    object selT269dCPostRicovero: TStringField
      DisplayLabel = 'Causale post-ricovero'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCPostRicovero'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_POSTRICOVERO'
      Size = 40
      Lookup = True
    end
    object selT269dCSalvaVita: TStringField
      DisplayLabel = 'Causale salva-vita'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCSalvaVita'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_SALVAVITA'
      Size = 40
      Lookup = True
    end
    object selT269dCGravidanza: TStringField
      DisplayLabel = 'Causale di gravidanza'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCGravidanza'
      Size = 40
      Lookup = True
    end
    object selT269dCPatGravi: TStringField
      DisplayLabel = 'Causale patologie gravi'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCPatGravi'
      Size = 40
      Lookup = True
    end
    object selT269dCServizio: TStringField
      DisplayLabel = 'Causale di servizio'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCServizio'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_SERVIZIO'
      Size = 40
      Lookup = True
    end
    object selT269CAUS_PROVVISORIA: TStringField
      DisplayLabel = 'Causale provvisoria'
      FieldName = 'CAUS_PROVVISORIA'
      Visible = False
      Size = 5
    end
    object selT269STATO_CAUSA_MALATTIA: TStringField
      FieldName = 'STATO_CAUSA_MALATTIA'
      Visible = False
      Size = 15
    end
    object selT269CAUS_INSERIMENTO: TStringField
      DisplayLabel = 'Causale di inserimento'
      FieldName = 'CAUS_INSERIMENTO'
      Visible = False
      Size = 5
    end
    object selT269CAUS_RICOVERO: TStringField
      DisplayLabel = 'Causale di ricovero'
      FieldName = 'CAUS_RICOVERO'
      Visible = False
      Size = 5
    end
    object selT269CAUS_POSTRICOVERO: TStringField
      DisplayLabel = 'Causale di post-ricovero'
      FieldName = 'CAUS_POSTRICOVERO'
      Visible = False
      Size = 5
    end
    object selT269CAUS_SALVAVITA: TStringField
      DisplayLabel = 'Causale salva-vita'
      FieldName = 'CAUS_SALVAVITA'
      Visible = False
      Size = 5
    end
    object selT269CAUS_SERVIZIO: TStringField
      DisplayLabel = 'Causale di servizio'
      FieldName = 'CAUS_SERVIZIO'
      Visible = False
      Size = 5
    end
    object selT269CAUS_GRAVIDANZA: TStringField
      FieldName = 'CAUS_GRAVIDANZA'
      Visible = False
      Size = 5
    end
    object selT269CAUS_PATGRAVI: TStringField
      FieldName = 'CAUS_PATGRAVI'
      Visible = False
      Size = 5
    end
    object selT269POSTRICOVERO_AUTO: TStringField
      DisplayLabel = 'Post-ricovero automatico'
      FieldName = 'POSTRICOVERO_AUTO'
      Size = 1
    end
    object selT269SCausaMalattia: TStringField
      DisplayLabel = 'Stato causa malattia'
      FieldKind = fkLookup
      FieldName = 'SCausaMalattia'
      LookupDataSet = A148FProfiliImportazioneCertificatiINPSMW.selI500
      LookupKeyFields = 'NOMECAMPO'
      LookupResultField = 'NOMECAMPO'
      KeyFields = 'STATO_CAUSA_MALATTIA'
      Size = 15
      Lookup = True
    end
  end
end
