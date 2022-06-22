object Wc10FFesteParticolariDM: TWc10FFesteParticolariDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 127
  Width = 267
  object selC010: TOracleDataSet
    SQL.Strings = (
      'select C010.*, C010.ROWID,'
      
        '       decode(C010.FLAG_SCELTA,'#39'L'#39',T010F_GGLAVORATIVO(C010.PROGR' +
        'ESSIVO,C010.DATA_FESTIVITA),C010.FLAG_SCELTA) FLAG_SCELTA_RIP,'
      '       decode((select sum(1)'
      '               from   T040_GIUSTIFICATIVI T040'
      '               where  C010.PROGRESSIVO = T040.PROGRESSIVO'
      '               and    C010.DATA_FESTIVITA = T040.DATA'
      '               and    T040.TIPOGIUST = '#39'I'#39
      
        '               and    INSTR('#39','#39'||C010.CAUS_SOSTIT||'#39','#39','#39','#39'||T040' +
        '.CAUSALE||'#39','#39') > 0)'
      '              ,null,'#39'N'#39','#39'S'#39') ESISTE_CAUS_SOST'
      'from   CSI010_FESTIVITA_PARTICOLARI C010'
      'where  C010.DATA_FESTIVITA between :DAL and :AL'
      'and    C010.TIPO_RECORD = '#39'M'#39
      
        'and    C010.PROGRESSIVO in (select progressivo from (:SELANAGRAF' +
        'E_SQL))'
      
        'order by C010.PROGRESSIVO, C010.DATA_FESTIVITA, C010.TIPO_FESTIV' +
        'ITA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000200000003A0053004500
      4C0041004E004100470052004100460045005F00530051004C00010000000000
      000000000000}
    UpdatingTable = 'CSI010_FESTIVITA_PARTICOLARI '
    Left = 16
    Top = 8
  end
  object cdsLista: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 8
  end
  object cdsListaGG: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 8
  end
  object cdsListaPag: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 8
  end
  object updCSI010: TOracleQuery
    SQL.Strings = (
      'update CSI010_FESTIVITA_PARTICOLARI'
      'set SCELTA_EFFETTUATA = :SCELTA_EFFETTUATA,'
      '    DATA_SCELTA = :DATA_SCELTA'
      'where DATA_FESTIVITA = :DATA_FESTIVITA'
      'and TIPO_FESTIVITA = :TIPO_FESTIVITA'
      'and PROGRESSIVO = :PROGRESSIVO'
      'and TIPO_RECORD = '#39'A'#39)
    Optimize = False
    Variables.Data = {
      04000000050000001E0000003A005400490050004F005F004600450053005400
      490056004900540041000500000000000000000000001E0000003A0044004100
      540041005F004600450053005400490056004900540041000C00000000000000
      00000000240000003A005300430045004C00540041005F004500460046004500
      540054005500410054004100050000000000000000000000180000003A004400
      4100540041005F005300430045004C00540041000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    Left = 16
    Top = 63
  end
end
