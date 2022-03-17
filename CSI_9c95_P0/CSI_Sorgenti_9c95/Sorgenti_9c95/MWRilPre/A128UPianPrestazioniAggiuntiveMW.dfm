inherited A128FPianPrestazioniAggiuntiveMW: TA128FPianPrestazioniAggiuntiveMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 132
  Width = 310
  object selT030: TOracleDataSet
    SQL.Strings = (
      'SELECT MATRICOLA,PROGRESSIVO FROM T030_ANAGRAFICO')
    ReadBuffer = 10000
    Optimize = False
    Filtered = True
    Left = 16
    Top = 16
  end
  object Q330: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T330_REG_ATT_AGGIUNTIVE ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00004F005200410049004E0049005A0049004F000100000000000E0000004F00
      52004100460049004E0045000100000000001800000043004F004E0054005200
      4F004C004C004F005F0050005400010000000000}
    Filtered = True
    Left = 64
    Top = 16
    object Q330CODICE: TStringField
      DisplayWidth = 10
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object Q330DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object Q330ORAINIZIO: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object Q330ORAFINE: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object Q330CONTROLLO_PT: TStringField
      FieldName = 'CONTROLLO_PT'
      Size = 1
    end
  end
  object D330: TDataSource
    DataSet = Q330
    Left = 96
    Top = 16
  end
  object selaT332: TOracleDataSet
    SQL.Strings = (
      'SELECT TURNO1,TURNO2 FROM T332_PIAN_ATT_AGGIUNTIVE'
      '  WHERE DATA = :DATA AND PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 144
    Top = 16
  end
  object Q430Contratto: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T430.CONTRATTO,T200.DESCRIZIONE,ABPRESENZA1,DECODE(T430.P' +
        'ARTTIME,'#39#39',100,NVL(T460.PIANTA,100)) PERCPT'
      
        '  FROM T430_STORICO T430, T200_CONTRATTI T200, T460_PARTTIME T46' +
        '0'
      
        '  WHERE T430.PROGRESSIVO = :PROGRESSIVO AND :DATA BETWEEN T430.D' +
        'ATADECORRENZA AND T430.DATAFINE'
      
        '    AND T430.CONTRATTO = T200.CODICE AND T430.PARTTIME = T460.CO' +
        'DICE(+)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 224
    Top = 16
  end
  object insT332: TOracleQuery
    SQL.Strings = (
      'insert into T332_PIAN_ATT_AGGIUNTIVE'
      '  (DATA, PROGRESSIVO, TURNO1, TURNO2)'
      'values'
      '  (:DATA, :PROGRESSIVO, :TURNO1, :TURNO2)')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000E0000003A005400550052004E004F00310005000000
      00000000000000000E0000003A005400550052004E004F003200050000000000
      000000000000}
    Left = 16
    Top = 72
  end
  object updT332: TOracleQuery
    SQL.Strings = (
      
        'UPDATE T332_PIAN_ATT_AGGIUNTIVE SET TURNO2 = :TURNO2 WHERE PROGR' +
        'ESSIVO = :PROGRESSIVO AND DATA = :DATA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000E0000003A005400550052004E004F00320005000000
      0000000000000000}
    Left = 64
    Top = 72
  end
  object delT332: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T332_PIAN_ATT_AGGIUNTIVE '
      'WHERE PROGRESSIVO = :PROGRESSIVO AND '
      '      DATA = :DATA'
      '      :WHERE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A0057004800450052004500010000000000
      000000000000}
    Left = 112
    Top = 72
  end
  object cdsParametri: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Turno1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Turno2'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 72
    object cdsParametriTurno1: TStringField
      FieldName = 'Turno1'
    end
    object cdsParametriTurno2: TStringField
      FieldName = 'Turno2'
    end
  end
  object dsrParametri: TDataSource
    DataSet = cdsParametri
    Left = 248
    Top = 72
  end
end
