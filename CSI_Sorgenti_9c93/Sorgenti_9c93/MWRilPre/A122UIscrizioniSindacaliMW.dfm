inherited A122FIscrizioniSindacaliMW: TA122FIscrizioniSindacaliMW
  OldCreateOrder = True
  Width = 270
  object CalcolaData: TOracleQuery
    SQL.Strings = (
      'select last_day(:DATA) + 1'
      'from DUAL'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 24
    Top = 80
  end
  object ControlloIscrizioni: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from T246_ISCRIZIONISINDACATI'
      'where PROGRESSIVO = :PROGRESSIVO'
      '  and COD_SINDACATO = :COD_SINDACATO'
      '  :numriga'
      
        '  and :DECORRENZA <= NVL(DATA_DEC_CES,to_date('#39'31123999'#39','#39'ddmmyy' +
        'yy'#39'))'
      '  and :SCADENZA >= DATA_DEC_ISCR'
      '  ')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000120000003A0053004300
      4100440045004E005A0041000C00000000000000000000001C0000003A004300
      4F0044005F00530049004E00440041004300410054004F000500000000000000
      00000000100000003A004E0055004D0052004900470041000100000000000000
      00000000}
    Left = 183
    Top = 80
  end
  object ControlloFiltro: TOracleQuery
    SQL.Strings = (
      'select count(*) '
      'from T430_STORICO T430, T030_ANAGRAFICO T030'
      'where T430.PROGRESSIVO = T030.PROGRESSIVO '
      '  and T030.progressivo = :PROGRESSIVO'
      '      :FILTRO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    Left = 104
    Top = 80
  end
  object selT240: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione, filtro'
      '  from T240_ORGANIZZAZIONISINDACALI T240'
      ' where raggruppamento = '#39'N'#39' '
      '   and decorrenza = (select max(decorrenza) '
      '                       from T240_ORGANIZZAZIONISINDACALI '
      
        '                      where codice = t240.codice and decorrenza ' +
        '<= :decorrenza) '
      '   and codice not in (select distinct(codice) '
      
        '                        from (select t240A.codice,t240A.decorren' +
        'za inizio,decode(t240B.decorrenza - t240A.decorrenza,0,to_date('#39 +
        '31123999'#39','#39'ddmmyyyy'#39'),t240B.decorrenza - 1) fine'
      
        '                                from t240_organizzazionisindacal' +
        'i t240A, t240_organizzazionisindacali t240B'
      
        '                               where t240B.codice = t240A.codice' +
        ' '
      
        '                                 and (t240B.decorrenza = (select' +
        ' min(decorrenza) decorrenza'
      
        '                                                            from' +
        ' t240_organizzazionisindacali '
      
        '                                                           where' +
        ' codice = t240B.codice and decorrenza > t240A.decorrenza)'
      
        '                                 and t240A.decorrenza < (select ' +
        'max(decorrenza) '
      
        '                                                           from ' +
        't240_organizzazionisindacali '
      
        '                                                          where ' +
        'codice = t240B.codice)'
      
        '                                  or t240B.decorrenza = (select ' +
        'max(decorrenza) decorrenza'
      
        '                                                           from ' +
        't240_organizzazionisindacali '
      
        '                                                          where ' +
        'codice = t240B.codice)'
      
        '                                 and t240A.decorrenza = (select ' +
        'max(decorrenza) '
      
        '                                                           from ' +
        't240_organizzazionisindacali '
      
        '                                                          where ' +
        'codice = t240B.codice))'
      '                                 and t240A.raggruppamento = '#39'S'#39')'
      '                       where fine >= :decorrenza'
      
        '                         and (:flag_fine = '#39'S'#39' and inizio <= :fi' +
        'ne or :flag_fine = '#39'N'#39'))'
      'order by codice'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0046004C00410047005F004600
      49004E0045000500000000000000000000000A0000003A00460049004E004500
      0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000080000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      4400450053004300520049005A0049004F004E00450001000000000020000000
      43004F0044005F004D0049004E0049005300540045005200490041004C004500
      0100000000000C000000460049004C00540052004F000100000000001C000000
      5200410047004700520055005000500041004D0045004E0054004F0001000000
      00002A000000530049004E004400410043004100540049005F00520041004700
      4700520055005000500041005400490001000000000006000000520053005500
      010000000000}
    Left = 24
    Top = 16
  end
end
