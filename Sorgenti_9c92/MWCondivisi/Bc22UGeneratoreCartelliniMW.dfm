object Bc22FGeneratoreCartelliniMW: TBc22FGeneratoreCartelliniMW
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 131
  Width = 170
  object selVT860: TOracleDataSet
    SQL.Strings = (
      
        'select AZIENDA, COD_AZIENDA, DESC_AZIENDA, ENTE, PROGRESSIVO, MA' +
        'TRICOLA, COGNOME, NOME, CODFISCALE, DATANAS, EMAIL, MESE_CARTELL' +
        'INO, PARAM_CARTELLINO'
      'from   VT860_CARTELLINI_PDF'
      'order by AZIENDA, MESE_CARTELLINO')
    ReadBuffer = 500
    Optimize = False
    ReadOnly = True
    Left = 16
    Top = 8
    object selVT860AZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selVT860COD_AZIENDA: TStringField
      DisplayLabel = 'Cod. azienda'
      FieldName = 'COD_AZIENDA'
      Size = 2
    end
    object selVT860DESC_AZIENDA: TStringField
      DisplayLabel = 'Descr. azienda'
      FieldName = 'DESC_AZIENDA'
      Size = 80
    end
    object selVT860ENTE: TStringField
      DisplayLabel = 'Ente'
      DisplayWidth = 5
      FieldName = 'ENTE'
      Size = 10
    end
    object selVT860PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
    end
    object selVT860MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selVT860COGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 15
      FieldName = 'COGNOME'
      Size = 30
    end
    object selVT860NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'NOME'
      Size = 30
    end
    object selVT860CODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object selVT860DATANAS: TDateTimeField
      DisplayLabel = 'Data nascita'
      DisplayWidth = 10
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT860EMAIL: TStringField
      DisplayLabel = 'Email'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 2000
    end
    object selVT860MESE_CARTELLINO: TDateTimeField
      DisplayLabel = 'Mese'
      DisplayWidth = 12
      FieldName = 'MESE_CARTELLINO'
      DisplayFormat = 'mmmm yyyy'
    end
    object selVT860PARAM_CARTELLINO: TStringField
      DisplayLabel = 'Param. cartellino'
      FieldName = 'PARAM_CARTELLINO'
      Size = 5
    end
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'select TIPO, DATO'
      'from   MONDOEDP.I091_DATIENTE I091'
      'where  AZIENDA = :AZIENDA'
      'and    TIPO like '#39'C90_W009%'#39)
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    ReadOnly = True
    Left = 16
    Top = 64
  end
  object updT860: TOracleQuery
    SQL.Strings = (
      'update T860_ITER_STAMPACARTELLINI'
      'set    ESISTE_PDF = :ESISTE_PDF'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    MESE_CARTELLINO = :MESE_CARTELLINO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004500530049005300540045005F0050004400
      4600050000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000200000003A004D004500
      530045005F00430041005200540045004C004C0049004E004F000C0000000000
      000000000000}
    Left = 80
    Top = 64
  end
end
