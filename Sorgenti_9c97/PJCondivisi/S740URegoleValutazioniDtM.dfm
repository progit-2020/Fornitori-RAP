inherited S740FRegoleValutazioniDtM: TS740FRegoleValutazioniDtM
  OldCreateOrder = True
  Height = 266
  Width = 422
  object SG741: TOracleDataSet
    SQL.Strings = (
      'SELECT SG741.*, SG741.ROWID'
      'FROM SG741_REGOLE_VALUTAZIONI SG741'
      'ORDER BY CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = SG741AfterScroll
    OnCalcFields = SG741CalcFields
    Left = 16
    Top = 16
    object SG741DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object SG741DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza fine'
      FieldName = 'DECORRENZA_FINE'
    end
    object SG741CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object SG741DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object SG741FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 4000
    end
    object SG741PATH_ISTRUZIONI: TStringField
      DisplayLabel = 'Path file istruzioni'
      FieldName = 'PATH_ISTRUZIONI'
      Size = 1000
    end
    object SG741PATH_INFORMAZIONI: TStringField
      DisplayLabel = 'Path file informazioni'
      FieldName = 'PATH_INFORMAZIONI'
      Size = 1000
    end
    object SG741COD_TIPI_RAPPORTO: TStringField
      DisplayLabel = 'Tipi rapporto valutabili'
      FieldName = 'COD_TIPI_RAPPORTO'
      Size = 400
    end
    object SG741GIORNI_MINIMI: TIntegerField
      DisplayLabel = 'Giorni minimi'
      FieldName = 'GIORNI_MINIMI'
    end
    object SG741VALUTA_CESSATI_RUOLO: TStringField
      DisplayLabel = 'Ignora gg min cessati ruolo'
      FieldName = 'VALUTA_CESSATI_RUOLO'
      Size = 1
    end
    object SG741PAGINE_ABILITATE: TStringField
      DisplayLabel = 'Pagine abilitate'
      FieldName = 'PAGINE_ABILITATE'
      Size = 50
    end
    object SG741AGGIORNA_DATA_COMPILAZIONE: TStringField
      DisplayLabel = 'Agg. data compil.'
      FieldName = 'AGGIORNA_DATA_COMPILAZIONE'
      Size = 1
    end
    object SG741LOGO_LARGHEZZA: TIntegerField
      DisplayLabel = 'Larghezza logo'
      FieldName = 'LOGO_LARGHEZZA'
    end
    object SG741LOGO_ALTEZZA: TIntegerField
      DisplayLabel = 'Altezza logo'
      FieldName = 'LOGO_ALTEZZA'
    end
    object SG741DATO_STAMPA_1: TStringField
      DisplayLabel = 'Dato stampa 1'
      FieldName = 'DATO_STAMPA_1'
      Size = 30
    end
    object SG741DESC_LUNGA_1: TStringField
      DisplayLabel = 'Descr. lunga 1'
      FieldName = 'DESC_LUNGA_1'
      Size = 1
    end
    object SG741DATO_STAMPA_2: TStringField
      DisplayLabel = 'Dato stampa 2'
      FieldName = 'DATO_STAMPA_2'
      Size = 30
    end
    object SG741DATO_STAMPA_3: TStringField
      DisplayLabel = 'Dato stampa 3'
      FieldName = 'DATO_STAMPA_3'
      Size = 30
    end
    object SG741DESC_LUNGA_3: TStringField
      DisplayLabel = 'Descr. lunga 3'
      FieldName = 'DESC_LUNGA_3'
      Size = 1
    end
    object SG741DATO_STAMPA_4: TStringField
      DisplayLabel = 'Dato stampa 4'
      FieldName = 'DATO_STAMPA_4'
      Size = 30
    end
    object SG741DATO_STAMPA_5: TStringField
      DisplayLabel = 'Dato stampa 5'
      FieldName = 'DATO_STAMPA_5'
      Size = 30
    end
    object SG741DESC_LUNGA_5: TStringField
      DisplayLabel = 'Descr. lunga 5'
      FieldName = 'DESC_LUNGA_5'
      Size = 1
    end
    object SG741STAMPA_VARIAZIONI_5: TStringField
      DisplayLabel = 'Stampa variaz. 5'
      FieldName = 'STAMPA_VARIAZIONI_5'
      Size = 1
    end
    object SG741DATO_STAMPA_6: TStringField
      DisplayLabel = 'Dato stampa 6'
      FieldName = 'DATO_STAMPA_6'
      Size = 30
    end
    object SG741DATO_VARIAZIONE_VALUTATORE: TStringField
      DisplayLabel = 'Campo firma 2'#176' valut.'
      FieldName = 'DATO_VARIAZIONE_VALUTATORE'
      Size = 30
    end
    object SG741TESTO_VALUTAZIONI_COMPLESSIVE: TStringField
      DisplayLabel = 'Testo val. compl.'
      FieldName = 'TESTO_VALUTAZIONI_COMPLESSIVE'
      Size = 500
    end
    object SG741ASSEGN_PREVENTIVA_OBIETTIVI: TStringField
      DisplayLabel = 'Assegn. preventiva obiettivi'
      FieldName = 'ASSEGN_PREVENTIVA_OBIETTIVI'
      Size = 1
    end
    object SG741DATA_DA_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Inizio periodo assegn. ob.'
      FieldName = 'DATA_DA_OBIETTIVI'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG741DATA_A_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Fine periodo assegn. ob.'
      FieldName = 'DATA_A_OBIETTIVI'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG741ABILITA_AREE_FORMATIVE: TStringField
      DisplayLabel = 'Abilita aree form.'
      FieldName = 'ABILITA_AREE_FORMATIVE'
      Size = 1
    end
    object SG741AREA_FORMATIVA_OBBLIGATORIA: TStringField
      DisplayLabel = 'Area form. obblig.'
      FieldName = 'AREA_FORMATIVA_OBBLIGATORIA'
      Size = 1
    end
    object SG741ABILITA_ACCETTAZIONE_VALUTATO: TStringField
      DisplayLabel = 'Abilita accett. valutato'
      FieldName = 'ABILITA_ACCETTAZIONE_VALUTATO'
      Size = 1
    end
    object SG741ABILITA_COMMENTI_VALUTATO: TStringField
      DisplayLabel = 'Abilita comm. valutato'
      FieldName = 'ABILITA_COMMENTI_VALUTATO'
      Size = 1
    end
    object SG741CAMPI_OPZIONALI_STAMPA: TStringField
      DisplayLabel = 'Col. opzionali stampa'
      FieldName = 'CAMPI_OPZIONALI_STAMPA'
      Size = 10
    end
    object SG741CAMPI_OPZIONALI_COMPILAZIONE: TStringField
      DisplayLabel = 'Col. opzionali compilazione'
      FieldName = 'CAMPI_OPZIONALI_COMPILAZIONE'
      Size = 10
    end
    object SG741STAMPA_PERIODO_VALUTAZIONE: TStringField
      DisplayLabel = 'Stampa periodo valutazione'
      FieldName = 'STAMPA_PERIODO_VALUTAZIONE'
      Size = 1
    end
    object SG741MODIFICA_NOTE_SUPERVISOREVALUT: TStringField
      DisplayLabel = 'Modifica note Supervisore'
      FieldName = 'MODIFICA_NOTE_SUPERVISOREVALUT'
      Size = 1
    end
    object SG741PATH_FILEPDF: TStringField
      DisplayLabel = 'Path file PDF'
      FieldName = 'PATH_FILEPDF'
      Size = 1000
    end
    object SG741COD_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Param. protocollazione'
      FieldName = 'COD_PARPROTOCOLLO'
      Size = 5
    end
    object SG741D_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Desc. param. protocollazione'
      FieldKind = fkCalculated
      FieldName = 'D_PARPROTOCOLLO'
      Size = 40
      Calculated = True
    end
    object SG741INVIO_EMAIL: TStringField
      DisplayLabel = 'Invio email valutato'
      FieldName = 'INVIO_EMAIL'
      Size = 1
    end
  end
  object D010: TDataSource
    Left = 368
    Top = 16
  end
  object selT450: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from t450_tiporapporto'
      'order by codice')
    Optimize = False
    Left = 248
    Top = 16
  end
  object selColOpzionali: TOracleDataSet
    SQL.Strings = (
      'select 1 ordine, '#39'Peso % area'#39' descrizione from dual'
      'union'
      'select 2 ordine, '#39'Punteggio area'#39' descrizione from dual'
      'union'
      'select 3 ordine, '#39'Peso % elemento'#39' descrizione from dual'
      'union'
      
        'select 4 ordine, '#39'Punteggio pesato elemento'#39' descrizione from du' +
        'al'
      'union'
      'select 5 ordine, '#39'Giudicabile'#39' descrizione from dual'
      'order by ordine')
    Optimize = False
    Left = 304
    Top = 16
  end
  object SG742: TOracleDataSet
    SQL.Strings = (
      'SELECT SG742.*, SG742.ROWID'
      'FROM SG742_ETICHETTE_VALUTAZIONI SG742'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C004100050000000000000000000000}
    OracleDictionary.DefaultValues = True
    CountAllRecords = True
    CommitOnPost = False
    CachedUpdates = True
    CompressBLOBs = True
    BeforeInsert = SG742BeforeInsert
    BeforeEdit = SG742BeforeEdit
    BeforeDelete = SG742BeforeDelete
    OnCalcFields = SG742CalcFields
    Left = 72
    Top = 16
    object SG742DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Visible = False
    end
    object SG742CODREGOLA: TStringField
      DisplayLabel = 'Cod. regola'
      FieldName = 'CODREGOLA'
      Visible = False
      Size = 5
    end
    object SG742NOME_CAMPO: TStringField
      DisplayLabel = 'Cod. nome campo'
      FieldName = 'NOME_CAMPO'
      Visible = False
      Size = 40
    end
    object SG742DESCRIZIONE: TStringField
      DisplayLabel = 'Campo'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE'
      Size = 100
      Calculated = True
    end
    object SG742ETICHETTA: TStringField
      DisplayLabel = 'Etichetta'
      FieldName = 'ETICHETTA'
      Size = 40
    end
    object SG742ORDINE: TFloatField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
      ReadOnly = True
    end
  end
  object D742: TDataSource
    DataSet = SG742
    Left = 72
    Top = 64
  end
  object delSG742: TOracleQuery
    SQL.Strings = (
      'DELETE SG742_ETICHETTE_VALUTAZIONI'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'AND NOME_CAMPO = NVL(:NOME_CAMPO,NOME_CAMPO)')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C004100050000000000000000000000160000003A004E004F004D004500
      5F00430041004D0050004F00050000000000000000000000}
    Left = 72
    Top = 160
  end
  object insaSG742: TOracleQuery
    SQL.Strings = (
      'insert into SG742_ETICHETTE_VALUTAZIONI'
      'select :DECORRENZA_NEW, CODREGOLA, NOME_CAMPO, ETICHETTA, ORDINE'
      'from SG742_ETICHETTE_VALUTAZIONI'
      'where DECORRENZA = :DECORRENZA_OLD'
      'and CODREGOLA = :CODREGOLA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F0044005200450047004F004C004100
      0500000000000000000000001E0000003A004400450043004F00520052004500
      4E005A0041005F004E00450057000C00000000000000000000001E0000003A00
      4400450043004F005200520045004E005A0041005F004F004C0044000C000000
      0000000000000000}
    Left = 128
    Top = 112
  end
  object insSG742: TOracleQuery
    SQL.Strings = (
      'insert into SG742_ETICHETTE_VALUTAZIONI'
      '( DECORRENZA, CODREGOLA, NOME_CAMPO, ETICHETTA, ORDINE)'
      'values'
      '(:DECORRENZA,:CODREGOLA,:NOME_CAMPO,:ETICHETTA,:ORDINE)')
    Optimize = False
    Variables.Data = {
      0400000005000000140000003A0043004F0044005200450047004F004C004100
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000160000003A004E004F004D004500
      5F00430041004D0050004F00050000000000000000000000140000003A004500
      540049004300480045005400540041000500000000000000000000000E000000
      3A004F005200440049004E004500040000000000000000000000}
    Left = 72
    Top = 112
  end
  object updSG742: TOracleQuery
    SQL.Strings = (
      'update SG742_ETICHETTE_VALUTAZIONI'
      'set ORDINE = :ORDINE'
      'where DECORRENZA = :DECORRENZA'
      'and CODREGOLA = :CODREGOLA'
      'and NOME_CAMPO = :NOME_CAMPO')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C0041000500000000000000000000000E0000003A004F00520044004900
      4E004500030000000000000000000000160000003A004E004F004D0045005F00
      430041004D0050004F00050000000000000000000000}
    Left = 128
    Top = 160
  end
  object selSG750: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg750_parprotocollo'
      'order by codice')
    Optimize = False
    Left = 184
    Top = 16
  end
  object D750: TDataSource
    DataSet = selSG750
    Left = 184
    Top = 64
  end
end
