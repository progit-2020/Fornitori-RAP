inherited P690FStampaFondiDtM: TP690FStampaFondiDtM
  OldCreateOrder = True
  Width = 670
  object selP684: TOracleDataSet
    SQL.Strings = (
      'SELECT distinct cod_fondo,descrizione FROM P684_FONDI'
      'WHERE DECORRENZA_DA <= :FINE'
      'AND DECORRENZA_A >= :INIZIO'
      'order by cod_fondo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00460049004E0045000C000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000}
    Left = 24
    Top = 24
  end
  object selP688: TOracleDataSet
    SQL.Strings = (
      'select :DATI,'
      '       decorrenza_da,decorrenza_a,'
      
        '       MAX(NVL(data_ultimo_monit,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'))' +
        ') data_ultimo_monit,'
      
        '       MAX(NVL(data_costituz,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'))) da' +
        'ta_costituz,'
      
        '       round(sum(tot_risorse)) tot_risorse, round(sum(tot_speso)' +
        ') tot_speso, round(sum(tot_risorse)) - round(sum(tot_speso)) tot' +
        '_residuo'
      'from'
      '('
      'select p680.cod_macrocateg, p680.descrizione desc_macrocateg, '
      '       p682.cod_raggr, p682.descrizione desc_raggr,'
      '       nvl(p682.cod_raggr,p684.cod_fondo) cod_fondo_raggr,'
      '       nvl(p682.descrizione,p684.descrizione) desc_fondo_raggr,'
      '       p684.cod_fondo,p684.descrizione desc_fondo,'
      
        '       p684.decorrenza_da,p684.decorrenza_a,p684.data_costituz, ' +
        'p684.data_ultimo_monit,'
      
        '       sum(decode(p688.class_voce,'#39'R'#39',p688.importo,0)) tot_risor' +
        'se,'
      
        '       sum(decode(p688.class_voce,'#39'D'#39',p688.importo,0)) tot_speso' +
        ','
      
        '       sum(decode(p688.class_voce,'#39'R'#39',p688.importo,-p688.importo' +
        ')) tot_residuo'
      
        'from p680_fondimacrocateg p680, p682_fondiraggr p682, p684_fondi' +
        ' p684, p688_risdestdet p688'
      
        'where p680.cod_macrocateg(+)=p684.cod_macrocateg and p682.cod_ra' +
        'ggr(+)=p684.cod_raggr and '
      
        '      p684.cod_fondo=p688.cod_fondo and p684.decorrenza_da=p688.' +
        'decorrenza_da and'
      '      p684.decorrenza_da <= :FINE and'
      '      p684.decorrenza_a >= :INIZIO and '
      '      :COD'
      'group by p680.cod_macrocateg, p680.descrizione, '
      '         p682.cod_raggr, p682.descrizione,'
      '         nvl(p682.cod_raggr,p684.cod_fondo),'
      '         nvl(p682.descrizione,p684.descrizione),'
      '         p684.cod_fondo,p684.descrizione,'
      
        '         p684.decorrenza_da,p684.decorrenza_a,p684.data_costituz' +
        ',p684.data_ultimo_monit'
      ')'
      'group by :DATI ,decorrenza_da,decorrenza_a'
      'order by :DATI ,decorrenza_da')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00440041005400490001000000000000000000
      00000A0000003A00460049004E0045000C00000000000000000000000E000000
      3A0049004E0049005A0049004F000C0000000000000000000000080000003A00
      43004F004400010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C0000001C00000043004F0044005F004D004100430052004F004300
      41005400450047000100000000001E00000044004500530043005F004D004100
      430052004F00430041005400450047000100000000001E00000043004F004400
      5F0046004F004E0044004F005F00520041004700470052000100000000001400
      000044004500530043005F005200410047004700520001000000000012000000
      43004F0044005F0046004F004E0044004F000100000000001400000044004500
      530043005F0046004F004E0044004F000100000000001A000000440045004300
      4F005200520045004E005A0041005F0044004100010000000000180000004400
      450043004F005200520045004E005A0041005F00410001000000000022000000
      44004100540041005F0055004C00540049004D004F005F004D004F004E004900
      54000100000000001600000054004F0054005F005200490053004F0052005300
      45000100000000001200000054004F0054005F0053005000450053004F000100
      000000001600000054004F0054005F005200450053004900440055004F000100
      00000000}
    AfterScroll = selP688AfterScroll
    Left = 104
    Top = 24
  end
  object TabStampaRis: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 96
  end
  object selP688Dett: TOracleDataSet
    SQL.Strings = (
      
        'select p688.cod_voce_det, p688.descrizione, p688.quantita, p688.' +
        'datobase, p688.moltiplicatore, sum(p688.importo) importo'
      'from p684_fondi p684, p688_risdestdet p688'
      'where :COD'
      '  and p684.decorrenza_da = :DEC'
      '  and p684.cod_fondo = p688.cod_fondo'
      '  and p684.decorrenza_da = p688.decorrenza_da'
      '  and p688.class_voce = :CLASS'
      '  and p688.cod_voce_gen = :CODGEN'
      '  and p688.descrizione is not null'
      
        'group by p688.cod_voce_det, p688.descrizione, p688.quantita, p68' +
        '8.datobase, p688.moltiplicatore'
      'order by P688.COD_VOCE_DET')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A0043004F004400010000000000000000000000
      080000003A004400450043000C00000000000000000000000C0000003A004300
      4C004100530053000500000000000000000000000E0000003A0043004F004400
      470045004E00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004400450053004300520049005A0049004F004E00
      45000100000000001800000043004F0044005F0056004F00430045005F004400
      45005400010000000000100000005100550041004E0054004900540041000100
      00000000100000004400410054004F0042004100530045000100000000001C00
      00004D004F004C005400490050004C0049004300410054004F00520045000100
      000000000E00000049004D0050004F00520054004F0001000000000018000000
      43004F0044005F0056004F00430045005F00470045004E000100000000001000
      000044004500530043005F00470045004E000100000000001200000054004900
      50004F005F0056004F00430045000100000000000E00000054004F0054005F00
      49004D005000010000000000}
    Left = 272
    Top = 24
  end
  object selP686: TOracleDataSet
    SQL.Strings = (
      
        'select distinct NVL(P686.ORDINE_STAMPA,9999) ORDIN, p686.cod_voc' +
        'e_GEN, P686.descrizione DESC_GEN, P686.tipo_voce,'
      '  (select ROUND(sum(p688.importo)) TOT_IMP'
      '     from p684_fondi p684, p688_risdestdet P688'
      '    where :COD'
      '      and p684.decorrenza_da = :DEC'
      '      and p684.cod_fondo = p688.cod_fondo'
      '      and p684.decorrenza_da = p688.decorrenza_da'
      '      and p688.class_voce = P686.CLASS_VOCE'
      '      and p688.cod_voce_gen = p686.cod_voce_gen) TOT_IMP'
      'from p684_fondi p684, P686_RISDESTGEN P686'
      'where :COD'
      '  and p684.decorrenza_da = :DEC'
      '  and p684.cod_fondo = p686.cod_fondo'
      '  and p684.decorrenza_da = p686.decorrenza_da'
      '  and p686.class_voce = :CLASS'
      'ORDER BY NVL(P686.ORDINE_STAMPA,9999), P686.COD_VOCE_GEN')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A0043004F004400010000000000000000000000
      080000003A004400450043000C00000000000000000000000C0000003A004300
      4C00410053005300050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004400450053004300520049005A0049004F004E00
      45000100000000001800000043004F0044005F0056004F00430045005F004400
      45005400010000000000100000005100550041004E0054004900540041000100
      00000000100000004400410054004F0042004100530045000100000000001C00
      00004D004F004C005400490050004C0049004300410054004F00520045000100
      000000000E00000049004D0050004F00520054004F0001000000000018000000
      43004F0044005F0056004F00430045005F00470045004E000100000000001000
      000044004500530043005F00470045004E000100000000001200000054004900
      50004F005F0056004F00430045000100000000000E00000054004F0054005F00
      49004D005000010000000000}
    Left = 192
    Top = 24
  end
  object TabStampaDest: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 96
  end
end
