object W010FRichiestaAssenzeDM: TW010FRichiestaAssenzeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 73
  Width = 156
  object selT050: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00460049004C00540052004F005F0041004E00
      41004700010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0051005600
      49005300540041004F005200410043004C004500010000000000000000000000
      1E0000003A00460049004C00540052004F005F0050004500520049004F004400
      4F000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      0100000000000000000000000A0000003A004900540045005200050000000000
      000000000000260000003A004C004900560045004C004C004F005F0049004E00
      5400450052004D004500440049004F0001000000000000000000000010000000
      3A0041005A00490045004E00440041000500000000000000000000002E000000
      3A004C004900560045004C004C004F005F004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    UpdatingTable = 'T050_RICHIESTEASSENZA'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selT050CalcFields
    OnFilterRecord = FiltroDizionario
    Left = 21
    Top = 16
    object selT050ID: TFloatField
      FieldName = 'ID'
    end
    object selT050ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT050ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT050PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT050NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT050MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT050SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT050COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT050TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT050AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT050REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT050DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selT050LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT050DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT050AUTORIZZAZIONE: TStringField
      DisplayLabel = ' '
      FieldName = 'AUTORIZZAZIONE'
      Visible = False
      Size = 1
    end
    object selT050NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object selT050AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT050AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT050RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT050AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT050AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT050D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT050D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT050D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT050ELABORATO: TStringField
      FieldName = 'ELABORATO'
      Size = 1
    end
    object selT050D_ELABORATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_ELABORATO'
      Size = 10
      Calculated = True
    end
    object selT050DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
    end
    object selT050AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
    end
    object selT050CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT050TIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object selT050NUMEROORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object selT050AORE: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object selT050CSI_TIPO_MG: TStringField
      DisplayLabel = 'Tipo mezza giornata'
      FieldName = 'CSI_TIPO_MG'
      Size = 1
    end
    object selT050DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
    end
    object selT050NUMEROORE_PREV: TStringField
      FieldName = 'NUMEROORE_PREV'
      Size = 5
    end
    object selT050AORE_PREV: TStringField
      FieldName = 'AORE_PREV'
      Size = 5
    end
    object selT050D_CAUSALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE'
      Size = 100
      Calculated = True
    end
    object selT050D_CAUSALE_2: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE_2'
      Size = 100
      Calculated = True
    end
    object selT050D_TIPOGIUST: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIUST'
      Calculated = True
    end
    object selT050D_DAORE_AORE: TStringField
      DisplayLabel = 'Ore'
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE'
      Size = 13
      Calculated = True
    end
    object selT050D_DAORE_AORE_PREV: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE_PREV'
      Size = 13
      Calculated = True
    end
    object selT050D_VISTI_PREC: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_VISTI_PREC'
      Size = 30
      Calculated = True
    end
    object selT050D_AVVERTIMENTI: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AVVERTIMENTI'
      Size = 1
      Calculated = True
    end
    object selT050D_CARTELLINO: TStringField
      Alignment = taCenter
      FieldKind = fkCalculated
      FieldName = 'D_CARTELLINO'
      Size = 1
      Calculated = True
    end
    object selT050D_CSI_TIPO_MG: TStringField
      DisplayLabel = 'Mezza gg.'
      FieldKind = fkCalculated
      FieldName = 'D_CSI_TIPO_MG'
      Size = 15
      Calculated = True
    end
  end
  object selCancInt: TOracleDataSet
    SQL.Strings = (
      'select v050.dal, v050.al'
      'from   vt050_richiesteassenza v050'
      'where  v050.progressivo = :PROGRESSIVO'
      'and    v050.tipo_richiesta = '#39'C'#39
      'and    least(:AL,v050.al) - greatest(:DAL,v050.dal) >= 0'
      'order by 1')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000060000003A0041004C000C0000000000
      000000000000080000003A00440041004C000C0000000000000000000000}
    Left = 96
    Top = 16
  end
end
