inherited R100FCreditiFormativiDtM: TR100FCreditiFormativiDtM
  OldCreateOrder = True
  Height = 196
  Width = 600
  object SelSG655: TOracleDataSet
    SQL.Strings = (
      
        'select codice, numero_crediti, assenze, presenze, minimo, massim' +
        'o'
      'from sg655_profilicrediti'
      'where anno = :nanno'
      '  and codice = :scodice'
      '  and profilo_crediti = :ProfiloCrediti')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A004E0041004E004E004F000300000000000000
      00000000100000003A00530043004F0044004900430045000500000000000000
      000000001E0000003A00500052004F00460049004C004F004300520045004400
      490054004900050000000000000000000000}
    Left = 24
    Top = 16
  end
  object SelT040: TOracleDataSet
    SQL.Strings = (
      'select * from t040_giustificativi'
      'where progressivo = :nprogressivo'
      '  and data between :ddatainizio and :ddatafine'
      '  and causale in (:scausale)')
    Optimize = False
    Variables.Data = {
      04000000040000001A0000003A004E00500052004F0047005200450053005300
      490056004F00030000000000000000000000180000003A004400440041005400
      410049004E0049005A0049004F000C0000000000000000000000140000003A00
      44004400410054004100460049004E0045000C00000000000000000000001200
      00003A005300430041005500530041004C004500050000000000000000000000}
    Left = 96
    Top = 16
  end
  object SelSG651: TOracleDataSet
    SQL.Strings = (
      'select distinct cod_corso'
      '  from sg651_pianificazionecorsi sg651, sg650_testatacorsi sg650'
      'where '
      '  sg651.progressivo = :prog and'
      '  sg651.cod_corso = sg650.codice and'
      '  sg651.edizione = sg650.edizione and'
      '  sg650.profilo_crediti = :profilo_crediti and'
      '  to_char(nvl(sg650.data_fine,sg650.data_inizio),'#39'yyyy'#39') = :anno'
      '--and data_corso between :datainizio and :datafine')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      0000200000003A00500052004F00460049004C004F005F004300520045004400
      4900540049000500000000000000000000000A0000003A0041004E004E004F00
      030000000000000000000000}
    Left = 168
    Top = 16
  end
  object SelPresenza: TOracleDataSet
    SQL.Strings = (
      'select count(*) from'
      '('
      'select distinct data'
      'from t040_giustificativi'
      'where causale = :scausale'
      '  and progressivo = :nprogressivo'
      '  and data between :dinizio and :dfine'
      'union'
      'select distinct data'
      'from t100_timbrature'
      'where causale = :scausale'
      '  and progressivo = :nprogressivo'
      '  and data between :dinizio and :dfine'
      ')')
    Optimize = False
    Variables.Data = {
      0400000004000000120000003A005300430041005500530041004C0045000500
      000000000000000000001A0000003A004E00500052004F004700520045005300
      5300490056004F00030000000000000000000000100000003A00440049004E00
      49005A0049004F000C00000000000000000000000C0000003A00440046004900
      4E0045000C0000000000000000000000}
    Left = 240
    Top = 16
  end
  object SelT030: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from t030_anagrafico '
      'where progressivo = :nprogressivo')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004E00500052004F0047005200450053005300
      490056004F00030000000000000000000000}
    Left = 24
    Top = 80
  end
  object SelT430: TOracleDataSet
    SQL.Strings = (
      'select :nomecampo as campo'
      'from t430_storico '
      'where datadecorrenza ='
      '(select max(datadecorrenza)'
      '   from t430_storico'
      
        '  where inizio <= to_date('#39'3112'#39' || to_char(:datain,'#39'yyyy'#39'),'#39'ddm' +
        'myyyy'#39')'
      
        '    and nvl(fine,:datain) >= to_date('#39'0101'#39' || to_char(:datain,'#39 +
        'yyyy'#39'),'#39'ddmmyyyy'#39')'
      '    and progressivo = :nprogressivo)'
      '  and progressivo = :nprogressivo')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004E004F004D004500430041004D0050004F00
      0100000010000000435245444954495F464F524D41544900000000000E000000
      3A00440041005400410049004E000C0000000700000078670101010101000000
      001A0000003A004E00500052004F0047005200450053005300490056004F0003
      000000040000002600000000000000}
    Left = 240
    Top = 80
  end
  object SelSG656: TOracleDataSet
    SQL.Strings = (
      'select CREDITI'
      'from sg656_residuocrediti'
      'where progressivo = :progressivo'
      '      and anno = :anno'
      '      ')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 96
    Top = 80
  end
  object selSG651ContCred: TOracleDataSet
    SQL.Strings = (
      
        'select numero_giorno, max(durata_corso) massima_durata, max(data' +
        '_corso) data_corso'
      'from sg651_pianificazionecorsi'
      'where cod_corso = :CodCorso and'
      '      progressivo = :Prog'#9
      'group by numero_giorno')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F00440043004F00520053004F000500
      0000080000004952495357454200000000000A0000003A00500052004F004700
      03000000040000001704000000000000}
    Left = 432
    Top = 16
  end
  object SelSG659: TOracleDataSet
    SQL.Strings = (
      'select t.*'
      'from sg659_giornatecorsi t'
      'where cod_corso=:cod_corso'
      'order by numero_giorno')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0043004F0044005F0043004F00520053004F00
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000005000000160000004400450053004300520049005A0049004F004E00
      45000100000000001200000043004F0044005F0043004F00520053004F000100
      000000001A0000004E0055004D00450052004F005F00470049004F0052004E00
      4F00010000000000140000004F00520045005F00470049004F0052004E004F00
      010000000000140000004F00520045005F004D0049004E0049004D0045000100
      00000000}
    Left = 508
    Top = 16
    object SelSG659COD_CORSO: TStringField
      FieldName = 'COD_CORSO'
      Required = True
      Size = 15
    end
    object SelSG659NUMERO_GIORNO: TIntegerField
      FieldName = 'NUMERO_GIORNO'
      Required = True
    end
    object SelSG659DESCRIZIONE: TStringField
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object SelSG659ORE_GIORNO: TStringField
      FieldName = 'ORE_GIORNO'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object SelSG659ORE_MINIME: TStringField
      FieldName = 'ORE_MINIME'
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
  object selSG650: TOracleDataSet
    SQL.Strings = (
      
        'select numero_crediti, gg_min, hh_min, durata_hh, profilo_credit' +
        'i'
      'from sg650_testatacorsi sg650'
      'where codice = :CODICEIN')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A0043004F00440049004300450049004E000500
      00000000000000000000}
    Left = 432
    Top = 72
  end
  object SelSG670: TOracleDataSet
    SQL.Strings = (
      'select CREDITI from sg670_creditiindividuali '
      
        'where progressivo = :progressivo and cod_corso = :cod_corso and ' +
        'crediti is not null'
      '      ')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0043004F0044005F004300
      4F00520053004F00050000000000000000000000}
    Left = 96
    Top = 136
  end
  object SelSG664: TOracleDataSet
    SQL.Strings = (
      'select sum(nvl(SG664.NUMERO_CREDITI,0)) NUMERO_CREDITI '
      '  from SG664_DOCENTI SG664, SG650_TESTATACORSI SG650'
      'where '
      '  SG664.PROGRESSIVO = :PROGRESSIVO and'
      '  SG664.COD_CORSO = SG650.CODICE AND'
      '  SG664.EDIZIONE = SG650.EDIZIONE and'
      '  SG650.PROFILO_CREDITI = :PROFILO_CREDITI and'
      '  to_char(nvl(SG650.DATA_FINE,SG650.DATA_INIZIO),'#39'yyyy'#39') = :ANNO')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000200000003A00500052004F0046004900
      4C004F005F004300520045004400490054004900050000000000000000000000
      0A0000003A0041004E004E004F00030000000000000000000000}
    Left = 432
    Top = 128
  end
end
