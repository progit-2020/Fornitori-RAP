inherited P553FRisorseResidueContoAnnualeDtM: TP553FRisorseResidueContoAnnualeDtM
  OldCreateOrder = True
  Height = 288
  Width = 365
  object selP553: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from P553_CONTOANNRISORRES t'
      'order by anno,cod_tabella')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000800000004000000414E4E4F0100000000000B000000434F445F5441
      42454C4C410100000000000C000000434F4C4F4E4E415F524947410100000000
      000B0000004D4143524F5F43415445470100000000000B000000444553435249
      5A494F4E450100000000000F000000494D504F52544F5F5245534944554F0100
      0000000011000000434F445F544142454C4C415F51554F54450100000000000D
      000000434F4C4F4E4E415F51554F5445010000000000}
    BeforePost = BeforePostNoStorico
    AfterScroll = selP553AfterScroll
    Left = 24
    Top = 16
    object selP553ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
    end
    object selP553COD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Size = 10
    end
    object selP553COLONNA_RIGA: TIntegerField
      FieldName = 'COLONNA_RIGA'
      Required = True
    end
    object selP553MACRO_CATEG: TStringField
      FieldName = 'MACRO_CATEG'
      Required = True
      Size = 10
    end
    object selP553DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selP553IMPORTO_RESIDUO: TFloatField
      FieldName = 'IMPORTO_RESIDUO'
    end
    object selP553COD_TABELLA_QUOTE: TStringField
      FieldName = 'COD_TABELLA_QUOTE'
      Size = 10
    end
    object selP553COLONNA_QUOTE: TIntegerField
      FieldName = 'COLONNA_QUOTE'
    end
  end
  object selP552: TOracleDataSet
    SQL.Strings = (
      'select ANNO,COD_TABELLA,DESCRIZIONE,TIPO_TABELLA_RIGHE '
      '  from p552_contoannregole'
      ' where RIGA=0 and COLONNA=0 and TIPO_TABELLA_RIGHE in (0,2)'
      '   and ANNO = :ANNO'
      'order by anno')
    Optimize = False
    Variables.Data = {0300000001000000050000003A414E4E4F030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000400000004000000414E4E4F0100000000000B000000434F445F5441
      42454C4C410100000000000B0000004445534352495A494F4E45010000000000
      120000005449504F5F544142454C4C415F5249474845010000000000}
    Left = 88
    Top = 16
  end
  object selT470: TOracleDataSet
    SQL.Strings = (
      'select distinct MACRO_CATEG_QM from T470_QUALIFICAMINIST'
      'order by MACRO_CATEG_QM ')
    Optimize = False
    Variables.Data = {
      0300000001000000080000003A544142454C4C41010000000000000000000000}
    Left = 136
    Top = 16
  end
  object dsrT470: TDataSource
    DataSet = selT470
    Left = 136
    Top = 64
  end
  object QSQL: TOracleDataSet
    Optimize = False
    Left = 256
    Top = 16
  end
end
