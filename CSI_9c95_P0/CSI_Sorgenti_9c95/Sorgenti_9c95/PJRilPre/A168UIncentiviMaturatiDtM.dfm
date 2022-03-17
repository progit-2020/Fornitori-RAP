inherited A168FIncentiviMaturatiDtM: TA168FIncentiviMaturatiDtM
  OldCreateOrder = True
  Width = 492
  object selT762: TOracleDataSet
    SQL.Strings = (
      'select t762.*,t762.rowid '
      'from t762_incentivimaturati t762'
      'where progressivo = :PROG'
      '      :FILTRO'
      'order by anno DESC, mese DESC, CODtipoquota, tipoimporto'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000900000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      45005300450001000000000014000000560041005200490041005A0049004F00
      4E004900010000000000160000005400490050004F0049004D0050004F005200
      54004F000100000000001800000043004F0044005400490050004F0051005500
      4F00540041000100000000000E00000049004D0050004F00520054004F000100
      0000000014000000470049004F0052004E0049005F004F005200450001000000
      0000160000005400490050004F00430041004C0043004F004C004F0001000000
      0000}
    BeforePost = BeforePostNoStorico
    BeforeDelete = BeforeDelete
    AfterScroll = selT762AfterScroll
    OnCalcFields = selT762CalcFields
    OnNewRecord = selT762NewRecord
    Left = 24
    Top = 16
    object selT762PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT762ANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
    end
    object selT762MESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      Required = True
    end
    object selT762Desc_Mese: TStringField
      DisplayLabel = ' '
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Desc_Mese'
      Calculated = True
    end
    object selT762CODTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selT762Desc_Quota: TStringField
      DisplayLabel = ' '
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'Desc_Quota'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selT762Tipologia_Quota: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'Tipologia_Quota'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'TIPOQUOTA'
      KeyFields = 'CODTIPOQUOTA'
      Size = 1
      Lookup = True
    end
    object selT762TIPOIMPORTO: TStringField
      DisplayLabel = 'Importo'
      FieldName = 'TIPOIMPORTO'
      Required = True
      Size = 5
    end
    object selT762Desc_Importo: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Desc_Importo'
      Size = 30
      Calculated = True
    end
    object selT762IMPORTO: TFloatField
      DisplayLabel = 'Quota'
      FieldName = 'IMPORTO'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0.#####'
    end
    object selT762VARIAZIONI: TFloatField
      DisplayLabel = 'Var.Quota'
      FieldName = 'VARIAZIONI'
      DisplayFormat = '###,###,###,##0.#####'
    end
    object selT762GIORNI_ORE: TFloatField
      DisplayLabel = 'Giorni/Ore'
      FieldName = 'GIORNI_ORE'
      ReadOnly = True
      Visible = False
    end
    object selT762DescGiorniOre: TStringField
      DisplayLabel = 'Giorni/Ore'
      FieldKind = fkCalculated
      FieldName = 'DescGiorniOre'
      Size = 7
      Calculated = True
    end
    object selT762Risparmio: TStringField
      FieldKind = fkLookup
      FieldName = 'Risparmio'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'RISPARMIO_BILANCIO'
      KeyFields = 'TIPOIMPORTO'
      Visible = False
      Size = 1
      Lookup = True
    end
    object selT762TIPOCALCOLO: TStringField
      FieldName = 'TIPOCALCOLO'
      Visible = False
      Size = 1
    end
  end
  object dsrT763: TDataSource
    Left = 88
    Top = 64
  end
  object selT763_old: TOracleDataSet
    SQL.Strings = (
      'select t763.*,t763.rowid '
      'from t763_incentiviabbattimenti t763'
      'where progressivo = :PROG'
      '  and anno = :ANNO'
      '  and mese = :MESE'
      '  AND TIPOQUOTA = :QUOTA'
      'order by tipoabbattimento'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F000300000000000000000000000A000000
      3A004D004500530045000300000000000000000000000C0000003A0051005500
      4F0054004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000700000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      450053004500010000000000120000005400490050004F00510055004F005400
      4100010000000000200000005400490050004F00410042004200410054005400
      49004D0045004E0054004F00010000000000380000004D004500530045004100
      500050004C004900430041005A0049004F004E00450041004200420041005400
      540049004D0045004E0054004F0001000000000022000000510055004F005400
      410041004200420041005400540049004D0045004E0054004F00010000000000}
    Left = 88
    Top = 16
    object selT763_oldPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT763_oldANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selT763_oldMESE: TFloatField
      FieldName = 'MESE'
      Required = True
      Visible = False
    end
    object selT763_oldTIPOQUOTA: TStringField
      FieldName = 'TIPOQUOTA'
      Required = True
      Visible = False
      Size = 5
    end
    object selT763_oldTIPOABBATTIMENTO: TStringField
      DisplayLabel = 'Abbattimento'
      DisplayWidth = 2
      FieldName = 'TIPOABBATTIMENTO'
      Required = True
      Size = 40
    end
    object selT763_oldDesc_Abbattimento: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'Desc_Abbattimento'
      Size = 50
      Calculated = True
    end
    object selT763_oldQUOTAABBATTIMENTO: TFloatField
      DisplayLabel = 'Quota Abb.'
      FieldName = 'QUOTAABBATTIMENTO'
    end
    object selT763_oldMESEAPPLICAZIONEABBATTIMENTO: TDateTimeField
      DisplayLabel = 'Mese applicaz. abb.'
      DisplayWidth = 10
      FieldName = 'MESEAPPLICAZIONEABBATTIMENTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
  end
end
