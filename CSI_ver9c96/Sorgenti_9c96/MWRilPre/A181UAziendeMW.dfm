inherited A181FAziendeMW: TA181FAziendeMW
  OldCreateOrder = True
  Height = 230
  Width = 472
  object Ins091: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I091_DATIENTE '
      '(AZIENDA, ORDINE, TIPO) '
      'VALUES '
      '(:AZIENDA, :ORDINE, :TIPO) '
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      00000E0000003A004F005200440049004E004500030000000000000000000000}
    Left = 224
    Top = 12
  end
  object scrdelI090: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete mondoedp.i091_datiente where azienda = :azienda;'
      '  delete mondoedp.i092_logtabelle where azienda = :azienda;'
      '  --delete mondoedp.i070_utenti where azienda = :azienda;'
      '  --delete mondoedp.i071_permessi where azienda = :azienda;'
      
        '  --delete mondoedp.i072_filtroanagrafe where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i073_filtrofunzioni where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i074_filtrodizionario where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i060_login_dipendente where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i061_profili_dipendente where azienda = :azi' +
        'enda;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 225
    Top = 76
  end
  object scrupdI090: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  update mondoedp.i091_datiente set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i092_logtabelle set azienda = :azienda_new whe' +
        're azienda = :azienda_old;'
      
        '  update mondoedp.i070_utenti set azienda = :azienda_new where a' +
        'zienda = :azienda_old;'
      
        '  update mondoedp.i071_permessi set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i072_filtroanagrafe set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i073_filtrofunzioni set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i074_filtrodizionario set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i060_login_dipendente set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i061_profili_dipendente set azienda = :azienda' +
        '_new where azienda = :azienda_old;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0041005A00490045004E00440041005F004E00
      45005700050000000000000000000000180000003A0041005A00490045004E00
      440041005F004F004C004400050000000000000000000000}
    Left = 281
    Top = 76
  end
  object DBMondoedp: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 24
    Top = 150
  end
  object scrI092: TOracleQuery
    ReadBuffer = 1
    Optimize = False
    Left = 285
    Top = 12
  end
end
