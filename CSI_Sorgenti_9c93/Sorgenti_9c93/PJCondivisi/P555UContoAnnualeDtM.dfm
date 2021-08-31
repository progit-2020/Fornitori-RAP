inherited P555FContoAnnualeDtM: TP555FContoAnnualeDtM
  OldCreateOrder = True
  Height = 244
  Width = 605
  object selP554: TOracleDataSet
    SQL.Strings = (
      'select p554.*, p554.rowid'
      'from  p554_contoanntestate p554'
      'order by anno, cod_tabella')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000430048004900550053004F000100000000001A00
      000044004100540041005F004300480049005500530055005200410001000000
      00000800000041004E004E004F000100000000001600000043004F0044005F00
      54004100420045004C004C00410001000000000016000000490044005F004300
      4F004E0054004F0041004E004E00010000000000}
    BeforeDelete = BeforeDelete
    AfterScroll = selP554AfterScroll
    Left = 9
    Top = 13
  end
  object selP555: TOracleDataSet
    SQL.Strings = (
      'select p555.*, p555.rowid'
      
        'from p555_contoanndatiindividuali p555, p554_contoanntestate p55' +
        '4, p552_contoannregole p552R, p552_contoannregole p552C'
      'where p555.id_contoann = :ID_CONTOANN'
      '  and p555.progressivo = :PROGRESSIVO'
      '  and p555.id_contoann = p554.id_contoann'
      '  and :ANNOREGOLE = p552R.anno '
      '  and p554.cod_tabella = p552R.cod_tabella'
      '  and p555.riga = p552R.riga'
      '  and p552R.colonna = 0'
      '  and :ANNOREGOLE = p552C.anno '
      '  and p554.cod_tabella = p552C.cod_tabella'
      '  and p555.colonna = p552C.colonna'
      '  and p552C.riga = 0'
      '  :FILTRO'
      'order by p555.riga, p555.colonna')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00490044005F0043004F004E0054004F004100
      4E004E00030000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F000300000000000000000000000E0000003A004600
      49004C00540052004F00010000000000000000000000160000003A0041004E00
      4E004F005200450047004F004C004500030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000560041004C004F00520045000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000001600
      0000490044005F0043004F004E0054004F0041004E004E000100000000000800
      000052004900470041000100000000000E00000043004F004C004F004E004E00
      4100010000000000}
    ReadOnly = True
    OnApplyRecord = selP555ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    OnCalcFields = selP555CalcFields
    OnNewRecord = selP555NewRecord
    Left = 56
    Top = 12
    object selP555ID_CONTOANN: TFloatField
      FieldName = 'ID_CONTOANN'
      Required = True
    end
    object selP555PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selP555RIGA: TIntegerField
      FieldName = 'RIGA'
      Required = True
    end
    object selP555COLONNA: TIntegerField
      FieldName = 'COLONNA'
      Required = True
    end
    object selP555VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object selP555Desc_Riga: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Riga'
      Size = 100
      Calculated = True
    end
    object selP555Desc_Colonna: TStringField
      FieldKind = fkCalculated
      FieldName = 'Desc_Colonna'
      Size = 100
      Calculated = True
    end
    object selP555Valore_Costante: TStringField
      FieldKind = fkCalculated
      FieldName = 'Valore_Costante'
      Size = 50
      Calculated = True
    end
  end
  object dsrP555: TDataSource
    AutoEdit = False
    DataSet = selP555
    Left = 60
    Top = 68
  end
  object selP552Riga: TOracleDataSet
    SQL.Strings = (
      
        'select anno,cod_tabella,riga,descrizione,valore_costante from p5' +
        '52_contoannregole '
      'where ANNO=:anno '
      'and COD_TABELLA=:cod_tabella'
      'and RIGA <> 0'
      'and COLONNA = 0'
      'order by anno,cod_tabella,riga')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A0043004F0044005F0054004100420045004C004C0041000500
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000005000000160000004400450053004300520049005A0049004F004E00
      45000100000000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000080000005200
      4900470041000100000000001E000000560041004C004F00520045005F004300
      4F005300540041004E0054004500010000000000}
    Left = 129
    Top = 15
    object selP552RigaANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selP552RigaCOD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selP552RigaRIGA: TIntegerField
      DisplayLabel = 'Riga'
      FieldName = 'RIGA'
      Required = True
    end
    object selP552RigaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP552RigaVALORE_COSTANTE: TStringField
      FieldName = 'VALORE_COSTANTE'
      Visible = False
      Size = 500
    end
  end
  object selP552Col: TOracleDataSet
    SQL.Strings = (
      
        'select anno,cod_tabella,colonna,descrizione from p552_contoannre' +
        'gole '
      'where ANNO=:anno'
      'and COD_TABELLA=:cod_tabella '
      'and COLONNA <> 0'
      'and RIGA = 0'
      'order by anno,cod_tabella,colonna')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A0043004F0044005F0054004100420045004C004C0041000500
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000004000000160000004400450053004300520049005A0049004F004E00
      45000100000000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C0041000100000000000E0000004300
      4F004C004F004E004E004100010000000000}
    Left = 191
    Top = 16
    object selP552ColANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selP552ColCOD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selP552ColCOLONNA: TIntegerField
      DisplayLabel = 'Colonna'
      FieldName = 'COLONNA'
      Required = True
    end
    object selP552ColDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
  end
  object selP552: TOracleDataSet
    SQL.Strings = (
      
        'select distinct P554.ANNO, P554.COD_TABELLA, P552.DESCRIZIONE, P' +
        '552.REGOLA_CALCOLO_MANUALE '
      'from p554_contoanntestate P554, P552_contoannregole P552'
      'where P554.COD_TABELLA = P552.COD_TABELLA'
      'AND P552.RIGA = 0 AND P552.COLONNA = 0'
      'AND P554.ANNO = :ANNO'
      
        'AND P552.ANNO=(SELECT MAX(P552A.ANNO) FROM P552_CONTOANNREGOLE P' +
        '552A WHERE'
      ' P552A.COD_TABELLA=P552.COD_TABELLA AND P552A.ANNO<=P554.ANNO)'
      'order by anno, cod_tabella'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0500000003000000160000004400450053004300520049005A0049004F004E00
      45000100000000000A000000500041005200540045000100000000000C000000
      4E0055004D00450052004F00010000000000}
    Left = 255
    Top = 16
  end
  object dsrP552: TDataSource
    DataSet = selP552
    Left = 256
    Top = 64
  end
  object dsrP552Riga: TDataSource
    DataSet = selP552Riga
    Left = 128
    Top = 64
  end
  object dsrP552Col: TDataSource
    DataSet = selP552Col
    Left = 192
    Top = 64
  end
  object selQuery: TOracleDataSet
    Optimize = False
    Left = 328
    Top = 16
  end
  object cdsValori: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 136
    object cdsValoriVARIABILE: TStringField
      FieldName = 'VARIABILE'
    end
    object cdsValoriVALORE: TStringField
      FieldName = 'VALORE'
      Size = 1000
    end
  end
  object dsrQuery: TDataSource
    DataSet = selQuery
    Left = 328
    Top = 65
  end
  object LungCampi: TOracleDataSet
    Optimize = False
    Left = 88
    Top = 120
  end
  object MaxAnno: TOracleDataSet
    SQL.Strings = (
      'select max(P554.ANNO) ANNO'
      
        'from P554_CONTOANNTESTATE P554,P555_CONTOANNDATIINDIVIDUALI P555' +
        ' '
      'where P554.ID_CONTOANN=P555.ID_CONTOANN'
      '  and P555.PROGRESSIVO=:progressivo ')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 16
    Top = 120
  end
  object selDip: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,P555.VALORE '
      
        'FROM P554_CONTOANNTESTATE P554, P555_CONTOANNDATIINDIVIDUALI P55' +
        '5, T030_ANAGRAFICO T030'
      
        'WHERE P554.ID_CONTOANN=P555.ID_CONTOANN AND P555.PROGRESSIVO=T03' +
        '0.PROGRESSIVO'
      'AND P554.ANNO=:Anno AND P554.COD_TABELLA=:CodTabella'
      'AND P555.RIGA=:Riga AND P555.COLONNA=:Colonna'
      'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      00000000000000000A0000003A00520049004700410003000000000000000000
      0000100000003A0043004F004C004F004E004E00410003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0500000004000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D0045000100000000000C000000560041004C004F00520045000100
      00000000}
    Left = 400
    Top = 16
    object selDipMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Required = True
      Size = 8
    end
    object selDipCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object selDipNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object selDipVALORE: TFloatField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
    end
  end
  object dsrDip: TDataSource
    DataSet = selDip
    Left = 400
    Top = 64
  end
  object selP555canc: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUMDIP FROM ('
      
        'SELECT DISTINCT PROGRESSIVO FROM P555_CONTOANNDATIINDIVIDUALI P5' +
        '55'
      '  WHERE P555.ID_CONTOANN = :IdContoAnn '
      '  GROUP BY PROGRESSIVO)')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004900440043004F004E0054004F0041004E00
      4E00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000160000005400490050004F005F005200450043004F005200
      44000100000000000C00000052004F0057004E0055004D000100000000000A00
      0000500041005200540045000100000000000C0000004E0055004D0045005200
      4F0001000000000024000000500052004F004700520045005300530049005600
      4F005F004E0055004D00450052004F000100000000000C000000560041004C00
      4F0052004500010000000000160000004400450053004300520049005A004900
      4F004E0045000100000000000C000000490044005F0037003700300001000000
      000016000000500052004F0047005200450053005300490056004F0001000000
      0000}
    Left = 464
    Top = 16
  end
end
