inherited S700FAreeValutazioniDtM: TS700FAreeValutazioniDtM
  OldCreateOrder = True
  OnDestroy = nil
  Height = 196
  Width = 333
  object selSG701: TOracleDataSet
    SQL.Strings = (
      'select SG701.*, SG701.rowid '
      'from SG701_AREE_VALUTAZIONI SG701'
      'order by cod_area, decorrenza, descrizione')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000001000000043004F0044005F00410052004500410001000000
      0000140000004400450043004F005200520045004E005A004100010000000000
      1E0000004400450043004F005200520045004E005A0041005F00460049004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000200000005000450053004F005F0050004500520043004500
      4E005400550041004C004500010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selSG701AfterScroll
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 16
    object selSG701COD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      FieldName = 'COD_AREA'
      Required = True
      Size = 5
    end
    object selSG701DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG701DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selSG701DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 100
    end
    object selSG701PESO_PERCENTUALE: TFloatField
      DisplayLabel = 'Peso %'
      FieldName = 'PESO_PERCENTUALE'
      OnValidate = selSG701PESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_PERC_MIN: TFloatField
      DisplayLabel = 'Peso % min'
      FieldName = 'PESO_PERC_MIN'
      OnValidate = selSG701PESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_PERC_MAX: TFloatField
      DisplayLabel = 'Peso % max'
      FieldName = 'PESO_PERC_MAX'
      OnValidate = selSG701PESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_VARIABILE_ITEMS: TStringField
      DisplayLabel = 'Elementi con peso variabile'
      FieldName = 'PESO_VARIABILE_ITEMS'
      Size = 1
    end
    object selSG701TIPO_PUNTEGGIO_ITEMS: TStringField
      DisplayLabel = 'Assegn. punteggio'
      FieldName = 'TIPO_PUNTEGGIO_ITEMS'
      Size = 1
    end
    object selSG701ITEM_TUTTI_VALUTABILI: TStringField
      DisplayLabel = 'Item tutti valutabili'
      FieldName = 'ITEM_TUTTI_VALUTABILI'
      Size = 1
    end
    object selSG701ITEM_PERSONALIZZATI_MIN: TIntegerField
      DisplayLabel = 'Minimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MIN'
      DisplayFormat = '0'
    end
    object selSG701ITEM_PERSONALIZZATI_MAX: TIntegerField
      DisplayLabel = 'Massimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MAX'
      DisplayFormat = '0'
    end
    object selSG701TIPO_PESO_PERCENTUALE: TStringField
      DisplayLabel = 'Peso % degli elementi'
      FieldName = 'TIPO_PESO_PERCENTUALE'
      Size = 1
    end
    object selSG701TIPO_LINK_ITEM: TStringField
      DisplayLabel = 'Tipo collegamento elementi'
      FieldName = 'TIPO_LINK_ITEM'
      Size = 1
    end
    object selSG701STATI_ABILITATI_PUNTEGGI: TStringField
      DisplayLabel = 'Stati abilitati punteggi'
      FieldName = 'STATI_ABILITATI_PUNTEGGI'
      Size = 200
    end
    object selSG701STATI_ABILITATI_ELEMENTI: TStringField
      DisplayLabel = 'Stati abilitati elementi'
      FieldName = 'STATI_ABILITATI_ELEMENTI'
      Size = 200
    end
    object selSG701TESTO_ITEM_PERSONALIZZATI: TStringField
      DisplayLabel = 'Testo iniziale item personalizzati'
      FieldName = 'TESTO_ITEM_PERSONALIZZATI'
      Size = 500
    end
    object selSG701PESO_EQUO_ITEMS: TStringField
      DisplayLabel = 'Peso elementi uniforme'
      FieldName = 'PESO_EQUO_ITEMS'
      Size = 1
    end
    object selSG701PUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField
      DisplayLabel = 'Punteggi solo elementi valutabili'
      FieldName = 'PUNTEGGI_SOLO_ITEM_VALUTABILI'
      Size = 1
    end
  end
  object selSG700: TOracleDataSet
    SQL.Strings = (
      'select SG700.*, SG700.rowid from SG700_VALUTAZIONI SG700'
      'where cod_area = :COD_AREA and decorrenza = :DECORRENZA'
      'order by cod_valutazione')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      00000000000000000000160000003A004400450043004F005200520045004E00
      5A0041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    ReadOnly = True
    OnApplyRecord = selSG700ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selSG700BeforePost
    AfterPost = selSG700AfterPost
    BeforeDelete = selSG700BeforeDelete
    OnCalcFields = selSG700CalcFields
    OnNewRecord = selSG700NewRecord
    Left = 96
    Top = 15
    object selSG700COD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      DisplayWidth = 5
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selSG700DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selSG700COD_VALUTAZIONE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_VALUTAZIONE'
      OnValidate = selSG700COD_VALUTAZIONEValidate
      Size = 5
    end
    object selSG700DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione elemento'
      DisplayWidth = 110
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
    object selSG700PESO_PERCENTUALE: TFloatField
      DisplayLabel = 'Peso %'
      FieldName = 'PESO_PERCENTUALE'
      OnValidate = selSG700PESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG700COD_AREA_LINK: TStringField
      DisplayLabel = 'Cod. area'
      FieldName = 'COD_AREA_LINK'
      Size = 5
    end
    object selSG700COD_VALUTAZIONE_LINK: TStringField
      DisplayLabel = 'Cod. el.'
      FieldName = 'COD_VALUTAZIONE_LINK'
      Size = 5
    end
    object selSG700DESCRIZIONE_LINK: TStringField
      DisplayLabel = 'Descrizione elemento collegato'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE_LINK'
      Size = 200
      Calculated = True
    end
  end
  object dsrSG700: TDataSource
    DataSet = selSG700
    Left = 96
    Top = 80
  end
  object selSG710: TOracleDataSet
    SQL.Strings = (
      'select count(*) n_rec_schede'
      'from   sg710_testata_valutazioni sg710,'
      '       sg711_valutazioni_dipendente sg711'
      'where  sg710.data >= :dec_ini'
      'and    sg710.data = sg711.data'
      'and    sg710.progressivo = sg711.progressivo'
      'and    sg711.cod_area = :cod_area'
      'group by sg710.data, sg710.progressivo, sg711.cod_area')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      00000000000000000000100000003A004400450043005F0049004E0049000C00
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 160
    Top = 15
  end
  object selSG711: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from sg711_valutazioni_dipendente'
      'where cod_area = :COD_AREA'
      'and cod_valutazione = :COD_VALUTAZIONE'
      'and desc_valutazione_agg is not null'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      00000000000000000000200000003A0043004F0044005F00560041004C005500
      540041005A0049004F004E004500050000000000000000000000}
    Left = 216
    Top = 15
  end
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT CODREGOLA, CODICE, DESCRIZIONE'
      'FROM SG746_STATI_AVANZAMENTO'
      'ORDER BY CODREGOLA, CODICE, DESCRIZIONE')
    Optimize = False
    Left = 270
    Top = 15
  end
  object updSG701: TOracleQuery
    SQL.Strings = (
      'update sg701_aree_valutazioni'
      'set peso_percentuale = :peso_percentuale'
      'where cod_area = :cod_area'
      'and decorrenza = :decorrenza')
    Optimize = False
    Variables.Data = {
      0400000003000000220000003A005000450053004F005F005000450052004300
      45004E005400550041004C004500040000000000000000000000120000003A00
      43004F0044005F00410052004500410005000000000000000000000016000000
      3A004400450043004F005200520045004E005A0041000C000000000000000000
      0000}
    Left = 32
    Top = 136
  end
  object selLinkItem: TOracleDataSet
    SQL.Strings = (
      
        'SELECT SG700.COD_AREA, SG700.COD_VALUTAZIONE, SG701.DESCRIZIONE ' +
        '|| '#39' - '#39' || SG700.DESCRIZIONE DESCRIZIONE'
      'FROM SG701_AREE_VALUTAZIONI SG701, SG700_VALUTAZIONI SG700'
      'WHERE SG700.COD_AREA = SG701.COD_AREA'
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG701.TIPO_LINK_ITEM = '#39'0'#39
      'AND :DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FINE'
      'ORDER BY COD_AREA, COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 96
    Top = 135
    object selLinkItemCOD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      DisplayWidth = 5
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selLinkItemCOD_VALUTAZIONE: TStringField
      DisplayLabel = 'Cod. elem.'
      DisplayWidth = 5
      FieldName = 'COD_VALUTAZIONE'
      Size = 5
    end
    object selLinkItemDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 90
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
  end
end
