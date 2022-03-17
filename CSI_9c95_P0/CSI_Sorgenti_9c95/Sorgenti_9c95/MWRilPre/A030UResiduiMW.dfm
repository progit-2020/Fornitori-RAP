inherited A030FResiduiMW: TA030FResiduiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 221
  Width = 309
  object Q130: TOracleDataSet
    SQL.Strings = (
      'SELECT T130.*,T130.ROWID FROM T130_RESIDANNOPREC T130'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000160000005300
      41004C0044004F004F00520045004C0041005600010000000000140000005300
      41004C0044004F004F005200450050004F000100000000001E0000004F005200
      450043004F004D00500045004E0053004100420049004C004900010000000000
      1E000000430041005500530041005300530045004E005A00410043004F004D00
      5000010000000000140000005200490050004F005300490043004F004D005000
      01000000000012000000420041004E00430041005F004F005200450001000000
      0000}
    BeforeInsert = Q130BeforeInsert
    BeforePost = Q130BeforePost
    AfterPost = Q130AfterPost
    AfterCancel = Q130AfterCancel
    BeforeDelete = Q130BeforeDelete
    AfterDelete = Q130AfterDelete
    OnCalcFields = Q130CalcFields
    OnNewRecord = Q130NewRecord
    Left = 20
    Top = 8
    object Q130PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object Q130ANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      Required = True
      MaxValue = 9999.000000000000000000
    end
    object Q130D_Anno: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_Anno'
      Size = 17
      Calculated = True
    end
    object Q130SALDOORELAV: TStringField
      DisplayLabel = 'Saldo ore'
      FieldName = 'SALDOORELAV'
      OnValidate = bdeQ130SALDOORELAVValidate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object Q130SALDOOREPO: TStringField
      DisplayLabel = 'Saldo PO'
      FieldName = 'SALDOOREPO'
      OnValidate = bdeQ130SALDOORELAVValidate
      EditMask = '!-##00:00;1;_'
      Size = 8
    end
    object Q130ORECOMPENSABILI: TStringField
      DisplayLabel = 'Ore compensabili'
      FieldName = 'ORECOMPENSABILI'
      OnValidate = bdeQ130SALDOORELAVValidate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object Q130BANCA_ORE: TStringField
      DisplayLabel = 'Banca ore'
      FieldName = 'BANCA_ORE'
      OnValidate = bdeQ130SALDOORELAVValidate
      EditMask = '!99900:00;1;_'
      Size = 8
    end
    object Q130RIPOSICOMP: TStringField
      DisplayLabel = 'Riposi compensativi'
      FieldName = 'RIPOSICOMP'
      OnValidate = Q130RIPOSICOMPValidate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 60
    Top = 56
  end
  object selT131: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM T131_RESIDPRESENZE T'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000900000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F000100000000000E0000004300
      41005500530041004C004500010000000000160000004F00520045005F004600
      410053004300490041003100010000000000160000004F00520045005F004600
      410053004300490041003200010000000000160000004F00520045005F004600
      410053004300490041003300010000000000160000004F00520045005F004600
      410053004300490041003400010000000000160000004F00520045005F004600
      410053004300490041003500010000000000160000004F00520045005F004600
      410053004300490041003600010000000000}
    BeforePost = selT131BeforePost
    AfterPost = selT131AfterPost
    BeforeDelete = selT131BeforeDelete
    AfterDelete = selT131AfterPost
    OnNewRecord = selT131NewRecord
    Left = 20
    Top = 56
    object selT131PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT131ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      Required = True
    end
    object selT131CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 7
      FieldName = 'CAUSALE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT131C_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldKind = fkLookup
      FieldName = 'C_CAUSALE'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CAUSALE'
      Size = 5
      Lookup = True
    end
    object selT131D_CAUSALE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
    object selT131ORE_FASCIA1: TStringField
      DisplayLabel = 'Fascia 1'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA1'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object selT131ORE_FASCIA2: TStringField
      DisplayLabel = 'Fascia 2'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA2'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object selT131ORE_FASCIA3: TStringField
      DisplayLabel = 'Fascia 3'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA3'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object selT131ORE_FASCIA4: TStringField
      DisplayLabel = 'Fascia 4'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA4'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object selT131ORE_FASCIA5: TStringField
      DisplayLabel = 'Fascia 5'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA5'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
    object selT131ORE_FASCIA6: TStringField
      DisplayLabel = 'Fascia 6'
      DisplayWidth = 7
      FieldName = 'ORE_FASCIA6'
      OnValidate = selT131ORE_FASCIA1Validate
      EditMask = '!###00:00;1;_'
      Size = 8
    end
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      
        'SELECT t260.codice,t260.descrizione,max(t265.umisura) umisura FR' +
        'OM '
      'T260_RaggrAssenze t260, t265_cauassenze t265'
      'WHERE '
      '  t260.residuabile = '#39'S'#39' and'
      '  t260.codice = t265.codraggr'
      'GROUP BY t260.codice,t260.descrizione '
      'ORDER BY t260.codice')
    Optimize = False
    Filtered = True
    AfterOpen = Q260AfterOpen
    OnFilterRecord = Q260FilterRecord
    Left = 140
    Top = 100
  end
  object T264: TOracleDataSet
    SQL.Strings = (
      'SELECT T264.*,T264.ROWID FROM T264_RESIDASSANN T264'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    AfterEdit = T264AfterEdit
    BeforePost = T264BeforePost
    AfterPost = T264AfterPost
    BeforeDelete = T264BeforeDelete
    AfterDelete = T264AfterPost
    AfterScroll = T264AfterScroll
    OnNewRecord = T264NewRecord
    Left = 20
    Top = 100
    object T264Progressivo: TFloatField
      FieldName = 'Progressivo'
      Visible = False
    end
    object T264Anno: TFloatField
      DisplayWidth = 6
      FieldName = 'Anno'
      Required = True
      OnChange = T264AnnoChange
    end
    object T264CodRaggr: TStringField
      DisplayLabel = 'Assenza'
      FieldName = 'CodRaggr'
      Required = True
      OnChange = T264AnnoChange
      Size = 5
    end
    object T264D_Raggruppamento: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object T264Residuo1: TStringField
      DisplayLabel = 'Fascia 1'
      FieldName = 'Residuo1'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T264Residuo2: TStringField
      DisplayLabel = 'Fascia 2'
      FieldName = 'Residuo2'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T264Residuo3: TStringField
      DisplayLabel = 'Fascia 3'
      FieldName = 'Residuo3'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T264Residuo4: TStringField
      DisplayLabel = 'Fascia 4'
      FieldName = 'Residuo4'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T264Residuo5: TStringField
      DisplayLabel = 'Fascia 5'
      FieldName = 'Residuo5'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T264Residuo6: TStringField
      DisplayLabel = 'Fascia 6'
      FieldName = 'Residuo6'
      EditMask = '!#90.9;1;_'
      Size = 7
    end
  end
  object selT692: TOracleDataSet
    SQL.Strings = (
      'SELECT T692.*,ROWID FROM T692_RESIDUOBUONI T692'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000400000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F000100000000000C0000005400
      490043004B004500540001000000000014000000420055004F004E0049005000
      4100530054004F00010000000000}
    BeforePost = selT692BeforePost
    AfterPost = selT692AfterPost
    BeforeDelete = selT692BeforeDelete
    AfterDelete = selT692AfterPost
    OnNewRecord = selT692NewRecord
    Left = 20
    Top = 148
    object selT692PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT692ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 1
      FieldName = 'ANNO'
      Required = True
    end
    object selT692BUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      FieldName = 'BUONIPASTO'
    end
    object selT692TICKET: TIntegerField
      DisplayLabel = 'Ticket'
      FieldName = 'TICKET'
    end
  end
  object selSG657: TOracleDataSet
    SQL.Strings = (
      'select CODICE'
      'from sg657_codprofilicrediti')
    Optimize = False
    Left = 147
    Top = 148
  end
  object SelSG656: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from sg656_residuocrediti t'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000400000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F000100000000000E0000004300
      5200450044004900540049000100000000001E000000500052004F0046004900
      4C004F005F004300520045004400490054004900010000000000}
    BeforePost = SelSG656BeforePost
    AfterPost = SelSG656AfterPost
    BeforeDelete = SelSG656BeforeDelete
    AfterDelete = SelSG656AfterPost
    OnNewRecord = SelSG656NewRecord
    Left = 76
    Top = 148
    object SelSG656PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object SelSG656ANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
    end
    object SelSG656PROFILO_CREDITI: TStringField
      DisplayLabel = 'Profilo crediti'
      FieldName = 'PROFILO_CREDITI'
      Required = True
      Visible = False
      Size = 5
    end
    object SelSG656C_PROFILO_CREDITI: TStringField
      DisplayLabel = 'Profilo crediti'
      FieldKind = fkLookup
      FieldName = 'C_PROFILO_CREDITI'
      LookupDataSet = selSG657
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'PROFILO_CREDITI'
      Size = 5
      Lookup = True
    end
    object SelSG656CREDITI: TFloatField
      DisplayLabel = 'Crediti'
      FieldName = 'CREDITI'
    end
  end
  object Q263: TOracleDataSet
    SQL.Strings = (
      'SELECT Anno,CodRaggr,UMisura FROM T263_ProfAssInd'
      '  WHERE Progressivo = :Prog')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00470003000000000000000000
      0000}
    Left = 60
    Top = 100
  end
  object Q262: TOracleDataSet
    SQL.Strings = (
      'SELECT Anno,CodProfilo,CodRaggr,UMisura FROM T262_ProfAssAnn'
      '  WHERE Anno = :Anno AND'
      '                CodProfilo = :CodProfilo AND'
      '                CodRaggr = :CodRaggr')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F004400500052004F00460049004C004F0005000000
      0000000000000000120000003A0043004F004400520041004700470052000500
      00000000000000000000}
    Left = 108
    Top = 100
  end
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 176
    Top = 100
  end
end
