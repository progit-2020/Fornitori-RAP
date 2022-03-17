inherited B021FGiustificativiDM: TB021FGiustificativiDM
  OldCreateOrder = True
  Height = 77
  Width = 174
  inherited selProg: TOracleQuery
    Left = 32
  end
  object selGiust: TOracleDataSet
    SQL.Strings = (
      'select '#39'T040'#39' tiporecord,'
      '       t040.progressivo, '
      '       t040.data, '
      '       t040.causale, '
      '       /*t040.progrcausale,*/ '
      '       t040.tipogiust, '
      '       t040.daore, '
      '       t040.aore, '
      '       t040.datanas, '
      '       t040.id_richiesta,'
      '       /*t040.note, '
      '       t040.id_certificato*/'
      
        '       decode(t040.tipogiust,'#39'I'#39','#39'A'#39','#39'M'#39','#39'B'#39','#39'D'#39','#39'C'#39','#39'N'#39','#39'D'#39') ti' +
        'pogiust_ord'
      'from   t040_giustificativi t040, '
      '       t265_cauassenze t265'
      'where  t040.progressivo = :PROGRESSIVO'
      'and    t040.data between :INIZIO AND :FINE'
      'and    t040.causale = t265.codice'
      'union all'
      
        'select /*SIHINT9 LEADING(T265) INDEX(T050_RICHIESTEASSENZA T050_' +
        'BMI_ELABORATO) */'
      '       '#39'T050'#39' tiporecord,'
      '       t050.progressivo,'
      '       v010.data,'
      '       nvl(t265.codice_richiesta,t050.causale) causale,'
      '       t050.tipogiust,'
      
        '       to_date(decode(numeroore,null,null,'#39'30121899'#39')||numeroore' +
        ','#39'DDMMYYYYHH24.MI'#39') daore,'
      
        '       to_date(decode(aore,null,null,'#39'30121899'#39')||aore,'#39'DDMMYYYY' +
        'HH24.MI'#39') aore,'
      '       t050.datanas,'
      '       t050.id,'
      
        '       decode(t050.tipogiust,'#39'I'#39','#39'A'#39','#39'M'#39','#39'B'#39','#39'D'#39','#39'C'#39','#39'N'#39','#39'D'#39') ti' +
        'pogiust_ord'
      'from   vt050_richieste_senzarevoca t050, '
      '       usr_t265_decod_richieste t265,'
      '       v010_calendari v010'
      'where  t050.elaborato = '#39'N'#39
      'and    t050.progressivo = :PROGRESSIVO'
      'and    t050.dal <= :FINE'
      'and    t050.al >= :INIZIO'
      'and    t050.causale = t265.codice(+)'
      'and    v010.progressivo = t050.progressivo'
      
        'and    v010.data between greatest(t050.dal,:INIZIO) and least(t0' +
        '50.al,:FINE)'
      
        'and    exists (select '#39'x'#39' from dual where nvl(t050f_autorizzata(' +
        't050.id),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'x'#39' from dual where t050f_cancellata(t050.' +
        'id,v010.data) = '#39'N'#39')'
      'order by data, tipogiust_ord, daore, causale')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0049004E0049005A0049004F000C0000000000
      0000000000000A0000003A00460049004E0045000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    Left = 104
    Top = 16
  end
end
