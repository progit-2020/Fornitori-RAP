inherited A040FPianifRepDtM2: TA040FPianifRepDtM2
  OldCreateOrder = True
  Height = 214
  Width = 314
  object cdsPianif: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 192
    Top = 24
  end
  object selT380: TOracleDataSet
    SQL.Strings = (
      
        'select T030.PROGRESSIVO, T380.DATA, T380.TURNO1,T380.PRIORITA1,T' +
        '380.TURNO2,T380.PRIORITA2,T380.TURNO3,T380.PRIORITA3,'
      '       T380.DATOLIBERO, T380.TIPOLOGIA,'
      '       T030.MATRICOLA, T030.COGNOME, T030.NOME'
      'from   T380_PIANIFREPERIB T380, '
      '       :C700SelAnagrafe '
      'and    T380.TIPOLOGIA :OUTER_JOIN = :TIPOLOGIA'
      'and    T380.DATA :OUTER_JOIN between :DATADA and :DATAA'
      'and    T380.PROGRESSIVO :OUTER_JOIN = T030.PROGRESSIVO'
      ':FILTRO_TURNI'
      ':ORDINAMENTO')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000007000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000200000003A004300370030003000530045004C00
      41004E0041004700520041004600450001000000000000000000000018000000
      3A004F005200440049004E0041004D0045004E0054004F000100000000000000
      000000000E0000003A004400410054004100440041000C000000000000000000
      00000C0000003A00440041005400410041000C00000000000000000000001A00
      00003A00460049004C00540052004F005F005400550052004E00490001000000
      0000000000000000160000003A004F0055005400450052005F004A004F004900
      4E00010000000000000000000000}
    UpdatingTable = 'T380_PIANIFREPERIB'
    CommitOnPost = False
    Filtered = True
    OnFilterRecord = selT380FilterRecord
    Left = 22
    Top = 24
  end
  object selT350: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   T350_REGREPERIB'
      'where  TIPOLOGIA = :TIPOLOGIA'
      ':FILTRO'
      'order by CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A005400490050004F004C004F00470049004100
      0500000000000000000000000E0000003A00460049004C00540052004F000100
      00000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 92
    Top = 24
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'select T040.DATA, T040.CAUSALE'
      
        'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGG' +
        'RASSENZE T260'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.DATA between :DATADA and :DATAA'
      'and    T040.TIPOGIUST = '#39'I'#39
      'and    T040.CAUSALE = T265.CODICE'
      'and    T265.CODRAGGR = T260.CODICE'
      'and    T260.CODINTERNO not in ('#39'E'#39','#39'H'#39')'
      'order by 1')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      00000000000000000000}
    Left = 92
    Top = 88
  end
  object selT267: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from   T267_regoleriposi'
      'where  CODICE = :CODICE'
      'and    TIPO_CAUSALE = :TIPO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A005400490050004F00050000000000000000000000}
    Left = 22
    Top = 88
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T265_CAUASSENZE'
      'order by CODICE')
    ReadBuffer = 1
    Optimize = False
    Left = 22
    Top = 152
  end
  object cdsLegenda: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODTURNO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESCTURNO'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'CODCAUS'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESCCAUS'
        DataType = ftString
        Size = 40
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 192
    Top = 88
    Data = {
      8E0000009619E0BD0100000018000000040000000000030000008E0008434F44
      5455524E4F010049000000010005574944544802000200050009444553435455
      524E4F010049000000010005574944544802000200280007434F444341555301
      0049000000010005574944544802000200050008444553434341555301004900
      000001000557494454480200020028000000}
    object cdsLegendaCODTURNO: TStringField
      FieldName = 'CODTURNO'
      Size = 5
    end
    object cdsLegendaDESCTURNO: TStringField
      FieldName = 'DESCTURNO'
      Size = 40
    end
    object cdsLegendaCODCAUS: TStringField
      FieldName = 'CODCAUS'
      Size = 5
    end
    object cdsLegendaDESCCAUS: TStringField
      FieldName = 'DESCCAUS'
      Size = 40
    end
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,LAVORATIVO,FESTIVO'
      'FROM  V010_CALENDARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND   DATA BETWEEN :DAL AND :AL'
      'ORDER BY DATA')
    ReadBuffer = 33
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 92
    Top = 152
  end
  object cdsTotPianif: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 248
    Top = 24
  end
end
