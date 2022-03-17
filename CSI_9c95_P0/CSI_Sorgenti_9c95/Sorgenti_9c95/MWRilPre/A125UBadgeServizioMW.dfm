inherited A125FBadgeServizioMW: TA125FBadgeServizioMW
  OldCreateOrder = True
  Height = 66
  Width = 185
  object selT435: TOracleDataSet
    SQL.Strings = (
      'SELECT distinct '
      
        '  decode(tipo,'#39'O'#39','#39'Badge  ordinario: '#39','#39'Badge di servizio: '#39') TI' +
        'POBADGE,'
      '  T030.NOME, T030.COGNOME, T030.MATRICOLA,'
      
        '  TO_CHAR(badge_altri.inizio,decode(tipo,'#39'O'#39','#39'dd/mm/yyyy'#39','#39'dd/mm' +
        '/yyyy hh24.mi'#39')) DATADECORRENZA,'
      
        '  TO_CHAR(NVL(badge_altri.fine,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')),d' +
        'ecode(tipo,'#39'O'#39','#39'dd/mm/yyyy'#39','#39'dd/mm/yyyy hh24.mi'#39')) DATAFINE from'
      '('
      
        'select distinct progressivo,greatest(:decorrenza,t430.inizio) in' +
        'izio, least(:scadenza,nvl(t430.fine,:scadenza)) fine '
      'from t430_storico t430'
      'where progressivo = :progressivo'
      'and :decorrenza <= nvl(t430.fine,:scadenza)'
      'and :scadenza >= t430.inizio'
      ') badge_mio,'
      '('
      
        'select distinct '#39'O'#39' tipo,progressivo,greatest(datadecorrenza,ini' +
        'zio) inizio, least(datafine,nvl(fine,to_date('#39'31123999'#39','#39'DDMMYYY' +
        'Y'#39'))) fine'
      'from :utente.t430_storico '
      'where progressivo <> :progressivo_ext'
      'and badge = :badge'
      'union'
      
        'select distinct '#39'S'#39' tipo,t435.progressivo,greatest(t435.decorren' +
        'za,t430.inizio), least(nvl(t435.scadenza,to_date('#39'31123999'#39','#39'DDM' +
        'MYYYY'#39')),nvl(t430.fine,to_date('#39'31123999'#39','#39'DDMMYYYY'#39')))'
      'from :utente.t435_badgeservizio t435, '
      
        '    (select distinct progressivo,inizio,nvl(fine,to_date('#39'311239' +
        '99'#39','#39'DDMMYYYY'#39')) fine from :utente.t430_storico where progressiv' +
        'o <> :progressivo_ext) t430'
      'where t435.progressivo <> :progressivo_ext'
      'and t435.badgeserv = :badge'
      'and t435.progressivo = t430.progressivo'
      'and t435.decorrenza <= t430.fine'
      
        'and nvl(t435.scadenza,to_date('#39'31123999'#39','#39'DDMMYYYY'#39')) >= t430.in' +
        'izio'
      ') badge_altri, :utente.t030_anagrafico t030'
      'where badge_mio.inizio <= badge_altri.fine '
      'and badge_mio.fine >= badge_altri.inizio'
      'and t030.progressivo = badge_altri.progressivo'
      'order by T030.COGNOME, T030.NOME')
    Optimize = False
    Variables.Data = {
      0400000006000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000120000003A00530043004100440045004E00
      5A0041000C0000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F000300000000000000000000000E0000003A005500
      540045004E0054004500010000000000000000000000200000003A0050005200
      4F0047005200450053005300490056004F005F00450058005400030000000000
      0000000000000C0000003A004200410044004700450003000000000000000000
      0000}
    Left = 24
    Top = 8
  end
  object selI090_GruppoBadge: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'1'#39' ORD, :AZIENDA AZIENDA, :UTENTE UTENTE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'2'#39' ORD, AZIENDA, UTENTE'
      'FROM MONDOEDP.I090_ENTI'
      'WHERE GRUPPO_BADGE = :GRUPPO'
      'AND AZIENDA <> :AZIENDA'
      'AND UTENTE <> :UTENTE'
      'ORDER BY ORD, UTENTE')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      0000000000000E0000003A00470052005500500050004F000500000000000000
      00000000}
    Left = 104
    Top = 9
  end
end
