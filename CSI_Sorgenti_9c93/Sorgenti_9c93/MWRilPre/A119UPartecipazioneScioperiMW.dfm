inherited A119FPartecipazioneScioperiMW: TA119FPartecipazioneScioperiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 234
  Width = 512
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, UM_INSERIMENTO, UM_INSERIMENTO_MG, U' +
        'M_INSERIMENTO_H, UM_INSERIMENTO_D'
      'from   T265_CAUASSENZE'
      'order by 1')
    ReadBuffer = 200
    Optimize = False
    Filtered = True
    Left = 32
    Top = 12
  end
  object dsrT265: TDataSource
    AutoEdit = False
    DataSet = selT265
    Left = 32
    Top = 64
  end
  object selFiltroAnagrafe: TOracleDataSet
    ReadBuffer = 2
    Optimize = False
    Left = 122
    Top = 12
  end
  object selT251Count: TOracleQuery
    SQL.Strings = (
      'select count(T250.ID)'
      'from   T250_SCIOPERI T250,'
      '       T251_SCIOPERI_STRUTTURA T251'
      'where  T250.ID = :ID'
      'and    T250.ID = T251.ID_T250')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 208
    Top = 12
  end
  object selT250Data: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from   T250_SCIOPERI'
      'where  DATA = :DATA_EVENTO'
      ':CONTROLLO_EDIT')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0044004100540041005F004500560045004E00
      54004F000C00000000000000000000001E0000003A0043004F004E0054005200
      4F004C004C004F005F004500440049005400010000000000000000000000}
    Left = 291
    Top = 12
  end
  object selT251: TOracleDataSet
    SQL.Strings = (
      'select T251.ROWID,'
      '       T251.ID,'
      '       T251.PROGRESSIVO,'
      '       T251.DATA,'
      '       T030.MATRICOLA, '
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '       nvl(T850.STATO,'#39'N'#39') AUTORIZZATO,'
      '       decode(nvl(T850.STATO,'#39'N'#39'),'
      '              '#39'S'#39','#39'S'#236#39','
      '              '#39'N'#39','#39'No'#39','
      '              '#39#39') D_AUTORIZZATO,'
      '       T850.TIPO_RICHIESTA,'
      '       decode(T850.TIPO_RICHIESTA,'
      '              '#39'P'#39','#39'Notifica provvisoria'#39','
      '              '#39'D'#39','#39'Notifica definitiva'#39','
      '              '#39'E'#39','#39'Elaborata'#39','
      '              '#39'A'#39','#39'Annullata'#39') D_TIPO_RICHIESTA,'
      '       decode(T180.STATO,'
      '              '#39'C'#39','#39'S'#39','
      '              '#39'N'#39') BLOCCATO,'
      '       decode(T180.STATO,'
      '              '#39'C'#39','#39'S'#236#39','
      '              '#39'No'#39') D_BLOCCATO,'
      '       null D_ESITO_IMPORTAZIONE'
      'from   VT251_RICHIESTESCIOPERI T251, '
      '       T030_ANAGRAFICO T030, '
      '       T180_DATIBLOCCATI T180,'
      '       T850_ITER_RICHIESTE T850'
      'where  T251.ID_T250 = :ID_T250'
      'and    T251.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T251.ID = T850.ID'
      'and    trunc(T251.DATA,'#39'mm'#39') between T180.DAL(+) and T180.AL(+)'
      'and    T180.PROGRESSIVO(+) = T251.PROGRESSIVO'
      'and    T180.RIEPILOGO(+) = '#39'T250'#39
      'order by NOMINATIVO, MATRICOLA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00490044005F00540032003500300003000000
      0000000000000000}
    OnCalcFields = selT251CalcFields
    Left = 32
    Top = 124
    object selT251ID: TFloatField
      DisplayLabel = '(**) ID'
      DisplayWidth = 6
      FieldName = 'ID'
      Visible = False
    end
    object selT251PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT251DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Visible = False
    end
    object selT251MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT251NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 35
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT251AUTORIZZATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'AUTORIZZATO'
      Visible = False
      Size = 1
    end
    object selT251D_AUTORIZZATO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Autorizzato'
      FieldKind = fkInternalCalc
      FieldName = 'D_AUTORIZZATO'
      Size = 2
    end
    object selT251TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selT251BLOCCATO: TStringField
      DisplayLabel = 'Bloccato'
      FieldName = 'BLOCCATO'
      Visible = False
      Size = 1
    end
    object selT251D_BLOCCATO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Bloccato'
      FieldKind = fkInternalCalc
      FieldName = 'D_BLOCCATO'
      Size = 2
    end
    object selT251D_TIPO_RICHIESTA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo richiesta'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO_RICHIESTA'
    end
    object selT251D_ESITO_IMPORTAZIONE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Esito importazione'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_ESITO_IMPORTAZIONE'
      Calculated = True
    end
  end
  object dsrT251: TDataSource
    DataSet = selT251
    Left = 31
    Top = 176
  end
  object selT252: TOracleDataSet
    SQL.Strings = (
      'select T252.PROGRESSIVO,'
      '       T030.MATRICOLA, '
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '       T252.SCIOPERA,'
      '       decode(nvl(T252.SCIOPERA,'#39'N'#39'),'
      '              '#39'S'#39','#39'S'#236#39','
      '              '#39'N'#39','#39'No'#39','
      '              '#39#39') D_SCIOPERA'
      'from   T252_SCIOPERI_INDIVIDUALI T252,'
      '       T030_ANAGRAFICO T030'
      'where  T252.ID = :ID'
      ':FILTRO_SCIOPERA'
      'and    T252.PROGRESSIVO = T030.PROGRESSIVO'
      'order by NOMINATIVO, MATRICOLA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000002000
      00003A00460049004C00540052004F005F005300430049004F00500045005200
      4100010000000000000000000000}
    ReadOnly = True
    OnCalcFields = selT252CalcFields
    Left = 92
    Top = 123
    object selT252PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT252MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT252NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 35
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT252SCIOPERA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Sciopera'
      FieldName = 'SCIOPERA'
      Visible = False
      Size = 1
    end
    object selT252D_SCIOPERA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Sciopera'
      FieldKind = fkInternalCalc
      FieldName = 'D_SCIOPERA'
      Size = 2
    end
    object selT252D_ANOMALIE: TStringField
      DisplayLabel = 'Anomalie importazione'
      DisplayWidth = 140
      FieldKind = fkCalculated
      FieldName = 'D_ANOMALIE'
      Size = 500
      Calculated = True
    end
  end
  object dsrT252: TDataSource
    DataSet = selT252
    Left = 94
    Top = 176
  end
  object T250P_ANNULLA_RICHIESTA: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  T250P_ANNULLA_RICHIESTA(:ID, :LIVELLO, :STATO, :RESPONSABILE, ' +
        ':AUTORIZZ_AUTOMATICA);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000005000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F000300000000000000000000000C00
      00003A0053005400410054004F000500000000000000000000001A0000003A00
      52004500530050004F004E0053004100420049004C0045000500000000000000
      00000000280000003A004100550054004F00520049005A005A005F0041005500
      54004F004D0041005400490043004100050000000000000000000000}
    Left = 196
    Top = 123
  end
  object selDatiGiust: TOracleDataSet
    SQL.Strings = (
      'select DATA, CAUSALE, TIPOGIUST, DAORE, AORE'
      'from   VT251_RICHIESTESCIOPERI'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 305
    Top = 122
  end
  object updT850: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set    TIPO_RICHIESTA = :TIPO_RICHIESTA'
      'where  ID = :ID'
      'and    ITER = '#39'T251'#39)
    Optimize = False
    Variables.Data = {
      04000000020000001E0000003A005400490050004F005F005200490043004800
      49004500530054004100050000000000000000000000060000003A0049004400
      030000000000000000000000}
    Left = 376
    Top = 122
  end
  object selT040Canc: TOracleDataSet
    SQL.Strings = (
      'select t040.*'
      'from   t040_giustificativi t040, '
      '       t850_iter_richieste t850'
      'where  t850.id = :ID'
      'and    t040.id_richiesta = t850.id'
      
        'order by t040.data desc -- ordinamento per evitare riallineament' +
        'o causali concatenate sui giustificativi in fase di revoca')
    ReadBuffer = 60
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C00450001000000000018000000500052004F0047005200
      430041005500530041004C004500010000000000120000005400490050004F00
      470049005500530054000100000000000A000000440041004F00520045000100
      000000000800000041004F00520045000100000000000C000000530043004800
      4500440041000100000000000C0000005300540041004D005000410001000000
      00000E00000044004100540041004E0041005300010000000000}
    Left = 441
    Top = 122
  end
end
